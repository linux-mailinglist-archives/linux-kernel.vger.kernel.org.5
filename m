Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F1677F5C4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 13:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350547AbjHQLyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 07:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350543AbjHQLyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 07:54:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45958115;
        Thu, 17 Aug 2023 04:54:01 -0700 (PDT)
Received: from [192.168.100.7] (unknown [39.34.187.233])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D72826607239;
        Thu, 17 Aug 2023 12:53:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692273239;
        bh=NDwrIqrsI159rrunO3TO5SvnU+qPpQTlO8QHzuyVFhY=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=JGwnb0vC6MYRkmQy8bOfBocl8XasicyQwB4Q7Hgf0zZd4+JYgvZZ6LqsPfERlOuDw
         FMT8/s0Zt3Td0fK+4BKMWGZrA5AuRe/fHZ17QWDNbAii3b6en044ADF6WZWCx1lYEL
         zVdZGToEDbDtlBDn78j4AzziqXzJ4JEg+1NrEh0w4mnVpcBmrifjJlDKWqUgU8A0p4
         LP2sSha0Wos5Q5buveL6AiP9Ae8KB0jbRmw1Jw79SDsoTeIWGFgl1RosQrzTHlZxGu
         4RkaigIJXyBqGVFtVT1tSLGj5E0/tC8w78L0Ic0QkkM1p4dj7lX5BeT5mbq3AchkIS
         rKFKiDKjcQaZQ==
Message-ID: <994cf010-88bb-8585-cbc6-df6a016012c4@collabora.com>
Date:   Thu, 17 Aug 2023 16:53:51 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        linux-bluetooth@vger.kernel.org,
        syzbot <syzbot+2446dd3cb07277388db6@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, coreteam@netfilter.org,
        davem@davemloft.net, devel@driverdev.osuosl.org,
        forest@alittletooquiet.net, johan.hedberg@gmail.com,
        kaber@trash.net, kadlec@blackhole.kfki.hu, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        rvarsha016@gmail.com
Subject: Re: [PATCH v4] Bluetooth: Fix for ACL disconnect when pairing fails
Content-Language: en-US
To:     Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
        Marcel Holtmann <marcel@holtmann.org>
References: <1403003060-14663-1-git-send-email-lukasz.rymanowski@tieto.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <1403003060-14663-1-git-send-email-lukasz.rymanowski@tieto.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/14 4:04 PM, Lukasz Rymanowski wrote:
> When pairing fails hci_conn refcnt drops below zero. This cause that
> ACL link is not disconnected when disconnect timeout fires.
> 
> Probably this is because l2cap_conn_del calls l2cap_chan_del for each
> channel, and inside l2cap_chan_del conn is dropped. After that loop
> hci_chan_del is called which also drops conn.
> 
> Anyway, as it is desrcibed in hci_core.h, it is known that refcnt
> drops below 0 sometimes and it should be fine. If so, let disconnect
> link when hci_conn_timeout fires and refcnt is 0 or below. This patch
> does it.
> 
> This affects PTS test SM_TC_JW_BV_05_C
> 
> Logs from scenario:
> 
> [69713.706227] [6515] pair_device:
> [69713.706230] [6515] hci_conn_add: hci0 dst 00:1b:dc:06:06:22
> [69713.706233] [6515] hci_dev_hold: hci0 orig refcnt 8
> [69713.706235] [6515] hci_conn_init_sysfs: conn ffff88021f65a000
> [69713.706239] [6515] hci_req_add_ev: hci0 opcode 0x200d plen 25
> [69713.706242] [6515] hci_prepare_cmd: skb len 28
> [69713.706243] [6515] hci_req_run: length 1
> [69713.706248] [6515] hci_conn_hold: hcon ffff88021f65a000 orig refcnt 0
> [69713.706251] [6515] hci_dev_put: hci0 orig refcnt 9
> [69713.706281] [8909] hci_cmd_work: hci0 cmd_cnt 1 cmd queued 1
> [69713.706288] [8909] hci_send_frame: hci0 type 1 len 28
> [69713.706290] [8909] hci_send_to_monitor: hdev ffff88021f0c7000 len 28
> [69713.706316] [5949] hci_sock_recvmsg: sock ffff8800941a9680, sk ffff88012bf4d000
> [69713.706382] [5949] hci_sock_recvmsg: sock ffff8800941a9680, sk ffff88012bf4d000
> [69713.711664] [8909] hci_rx_work: hci0
> [69713.711668] [8909] hci_send_to_monitor: hdev ffff88021f0c7000 len 6
> [69713.711680] [8909] hci_rx_work: hci0 Event packet
> [69713.711683] [8909] hci_cs_le_create_conn: hci0 status 0x00
> [69713.711685] [8909] hci_sent_cmd_data: hci0 opcode 0x200d
> [69713.711688] [8909] hci_req_cmd_complete: opcode 0x200d status 0x00
> [69713.711690] [8909] hci_sent_cmd_data: hci0 opcode 0x200d
> [69713.711695] [5949] hci_sock_recvmsg: sock ffff8800941a9680, sk ffff88012bf4d000
> [69713.711744] [5949] hci_sock_recvmsg: sock ffff8800941a9680, sk ffff88012bf4d000
> [69713.818875] [8909] hci_rx_work: hci0
> [69713.818889] [8909] hci_send_to_monitor: hdev ffff88021f0c7000 len 21
> [69713.818913] [8909] hci_rx_work: hci0 Event packet
> [69713.818917] [8909] hci_le_conn_complete_evt: hci0 status 0x00
> [69713.818922] [8909] hci_send_to_control: len 19
> [69713.818927] [5949] hci_sock_recvmsg: sock ffff8800941a9680, sk ffff88012bf4d000
> [69713.818938] [8909] hci_conn_add_sysfs: conn ffff88021f65a000
> [69713.818975] [6450] bt_sock_poll: sock ffff88005e758500, sk ffff88010323b800
> [69713.818981] [6515] hci_sock_recvmsg: sock ffff88005e75a080, sk ffff88010323ac00
> ...
> [69713.819021] [8909] hci_dev_hold: hci0 orig refcnt 10
> [69713.819025] [8909] l2cap_connect_cfm: hcon ffff88021f65a000 bdaddr 00:1b:dc:06:06:22 status 0
> [69713.819028] [8909] hci_chan_create: hci0 hcon ffff88021f65a000
> [69713.819031] [8909] l2cap_conn_add: hcon ffff88021f65a000 conn ffff880221005c00 hchan ffff88020d60b1c0
> [69713.819034] [8909] l2cap_conn_ready: conn ffff880221005c00
> [69713.819036] [5949] hci_sock_recvmsg: sock ffff8800941a9680, sk ffff88012bf4d000
> [69713.819037] [8909] smp_conn_security: conn ffff880221005c00 hcon ffff88021f65a000 level 0x02
> [69713.819039] [8909] smp_chan_create:
> [69713.819041] [8909] hci_conn_hold: hcon ffff88021f65a000 orig refcnt 1
> [69713.819043] [8909] smp_send_cmd: code 0x01
> [69713.819045] [8909] hci_send_acl: hci0 chan ffff88020d60b1c0 flags 0x0000
> [69713.819046] [5949] hci_sock_recvmsg: sock ffff8800941a9900, sk ffff88012bf4e800
> [69713.819049] [8909] hci_queue_acl: hci0 nonfrag skb ffff88005157c100 len 15
> [69713.819055] [5949] hci_sock_recvmsg: sock ffff8800941a9900, sk ffff88012bf4e800
> [69713.819057] [8909] l2cap_le_conn_ready:
> [69713.819064] [8909] l2cap_chan_create: chan ffff88005ede2c00
> [69713.819066] [8909] l2cap_chan_hold: chan ffff88005ede2c00 orig refcnt 1
> [69713.819069] [8909] l2cap_sock_init: sk ffff88005ede5800
> [69713.819072] [8909] bt_accept_enqueue: parent ffff880160356000, sk ffff88005ede5800
> [69713.819074] [8909] __l2cap_chan_add: conn ffff880221005c00, psm 0x00, dcid 0x0004
> [69713.819076] [8909] l2cap_chan_hold: chan ffff88005ede2c00 orig refcnt 2
> [69713.819078] [8909] hci_conn_hold: hcon ffff88021f65a000 orig refcnt 2
> [69713.819080] [8909] smp_conn_security: conn ffff880221005c00 hcon ffff88021f65a000 level 0x01
> [69713.819082] [8909] l2cap_sock_ready_cb: sk ffff88005ede5800, parent ffff880160356000
> [69713.819086] [8909] le_pairing_complete_cb: status 0
> [69713.819091] [8909] hci_tx_work: hci0 acl 10 sco 8 le 0
> [69713.819093] [8909] hci_sched_acl: hci0
> [69713.819094] [8909] hci_sched_sco: hci0
> [69713.819096] [8909] hci_sched_esco: hci0
> [69713.819098] [8909] hci_sched_le: hci0
> [69713.819099] [8909] hci_chan_sent: hci0
> [69713.819101] [8909] hci_chan_sent: chan ffff88020d60b1c0 quote 10
> [69713.819104] [8909] hci_sched_le: chan ffff88020d60b1c0 skb ffff88005157c100 len 15 priority 7
> [69713.819106] [8909] hci_send_frame: hci0 type 2 len 15
> [69713.819108] [8909] hci_send_to_monitor: hdev ffff88021f0c7000 len 15
> [69713.819119] [8909] hci_chan_sent: hci0
> [69713.819121] [8909] hci_prio_recalculate: hci0
> [69713.819123] [8909] process_pending_rx:
> [69713.819226] [6450] hci_sock_recvmsg: sock ffff88005e758780, sk ffff88010323d400
> ...
> [69713.822022] [6450] l2cap_sock_accept: sk ffff880160356000 timeo 0
> [69713.822024] [6450] bt_accept_dequeue: parent ffff880160356000
> [69713.822026] [6450] bt_accept_unlink: sk ffff88005ede5800 state 1
> [69713.822028] [6450] l2cap_sock_accept: new socket ffff88005ede5800
> [69713.822368] [6450] l2cap_sock_getname: sock ffff8800941ab700, sk ffff88005ede5800
> [69713.822375] [6450] l2cap_sock_getsockopt: sk ffff88005ede5800
> [69713.822383] [6450] l2cap_sock_getname: sock ffff8800941ab700, sk ffff88005ede5800
> [69713.822414] [6450] bt_sock_poll: sock ffff8800941ab700, sk ffff88005ede5800
> ...
> [69713.823255] [6450] l2cap_sock_getname: sock ffff8800941ab700, sk ffff88005ede5800
> [69713.823259] [6450] l2cap_sock_getsockopt: sk ffff88005ede5800
> [69713.824322] [6450] l2cap_sock_getname: sock ffff8800941ab700, sk ffff88005ede5800
> [69713.824330] [6450] l2cap_sock_getsockopt: sk ffff88005ede5800
> [69713.825029] [6450] bt_sock_poll: sock ffff88005e758500, sk ffff88010323b800
> ...
> [69713.825187] [6450] l2cap_sock_sendmsg: sock ffff8800941ab700, sk ffff88005ede5800
> [69713.825189] [6450] bt_sock_wait_ready: sk ffff88005ede5800
> [69713.825192] [6450] l2cap_create_basic_pdu: chan ffff88005ede2c00 len 3
> [69713.825196] [6450] l2cap_do_send: chan ffff88005ede2c00, skb ffff880160b0b500 len 7 priority 0
> [69713.825199] [6450] hci_send_acl: hci0 chan ffff88020d60b1c0 flags 0x0000
> [69713.825201] [6450] hci_queue_acl: hci0 nonfrag skb ffff880160b0b500 len 11
> [69713.825210] [8909] hci_tx_work: hci0 acl 9 sco 8 le 0
> [69713.825213] [8909] hci_sched_acl: hci0
> [69713.825214] [8909] hci_sched_sco: hci0
> [69713.825216] [8909] hci_sched_esco: hci0
> [69713.825217] [8909] hci_sched_le: hci0
> [69713.825219] [8909] hci_chan_sent: hci0
> [69713.825221] [8909] hci_chan_sent: chan ffff88020d60b1c0 quote 9
> [69713.825223] [8909] hci_sched_le: chan ffff88020d60b1c0 skb ffff880160b0b500 len 11 priority 0
> [69713.825225] [8909] hci_send_frame: hci0 type 2 len 11
> [69713.825227] [8909] hci_send_to_monitor: hdev ffff88021f0c7000 len 11
> [69713.825242] [8909] hci_chan_sent: hci0
> [69713.825253] [5949] hci_sock_recvmsg: sock ffff8800941a9680, sk ffff88012bf4d000
> [69713.825253] [8909] hci_prio_recalculate: hci0
> [69713.825292] [5949] hci_sock_recvmsg: sock ffff8800941a9680, sk ffff88012bf4d000
> [69713.825768] [6450] bt_sock_poll: sock ffff88005e758500, sk ffff88010323b800
> ...
> [69713.866902] [8909] hci_rx_work: hci0
> [69713.866921] [8909] hci_send_to_monitor: hdev ffff88021f0c7000 len 7
> [69713.866928] [8909] hci_rx_work: hci0 Event packet
> [69713.866931] [8909] hci_num_comp_pkts_evt: hci0 num_hndl 1
> [69713.866937] [8909] hci_tx_work: hci0 acl 9 sco 8 le 0
> [69713.866939] [5949] hci_sock_recvmsg: sock ffff8800941a9680, sk ffff88012bf4d000
> [69713.866940] [8909] hci_sched_acl: hci0
> ...
> [69713.866944] [8909] hci_sched_le: hci0
> [69713.866953] [8909] hci_chan_sent: hci0
> [69713.866997] [5949] hci_sock_recvmsg: sock ffff8800941a9680, sk ffff88012bf4d000
> [69713.867840] [28074] hci_rx_work: hci0
> [69713.867844] [28074] hci_send_to_monitor: hdev ffff88021f0c7000 len 7
> [69713.867850] [28074] hci_rx_work: hci0 Event packet
> [69713.867853] [28074] hci_num_comp_pkts_evt: hci0 num_hndl 1
> [69713.867857] [5949] hci_sock_recvmsg: sock ffff8800941a9680, sk ffff88012bf4d000
> [69713.867858] [28074] hci_tx_work: hci0 acl 10 sco 8 le 0
> [69713.867860] [28074] hci_sched_acl: hci0
> [69713.867861] [28074] hci_sched_sco: hci0
> [69713.867862] [28074] hci_sched_esco: hci0
> [69713.867863] [28074] hci_sched_le: hci0
> [69713.867865] [28074] hci_chan_sent: hci0
> [69713.867888] [5949] hci_sock_recvmsg: sock ffff8800941a9680, sk ffff88012bf4d000
> [69714.145661] [8909] hci_rx_work: hci0
> [69714.145666] [8909] hci_send_to_monitor: hdev ffff88021f0c7000 len 10
> [69714.145676] [8909] hci_rx_work: hci0 ACL data packet
> [69714.145679] [8909] hci_acldata_packet: hci0 len 6 handle 0x002d flags 0x0002
> [69714.145681] [8909] hci_conn_enter_active_mode: hcon ffff88021f65a000 mode 0
> [69714.145683] [8909] l2cap_recv_acldata: conn ffff880221005c00 len 6 flags 0x2
> [69714.145693] [8909] l2cap_recv_frame: len 2, cid 0x0006
> [69714.145696] [8909] hci_send_to_control: len 14
> [69714.145710] [8909] smp_chan_destroy:
> [69714.145713] [8909] pairing_complete: status 3
> [69714.145714] [8909] cmd_complete: sock ffff88010323ac00
> [69714.145717] [8909] hci_conn_drop: hcon ffff88021f65a000 orig refcnt 3
> [69714.145719] [5949] hci_sock_recvmsg: sock ffff8800941a9680, sk ffff88012bf4d000
> [69714.145720] [6450] bt_sock_poll: sock ffff88005e758500, sk ffff88010323b800
> [69714.145722] [6515] hci_sock_recvmsg: sock ffff88005e75a080, sk ffff88010323ac00
> [69714.145724] [6450] bt_sock_poll: sock ffff8801db6b4f00, sk ffff880160351c00
> ...
> [69714.145735] [6515] hci_sock_recvmsg: sock ffff88005e75a080, sk ffff88010323ac00
> [69714.145737] [8909] hci_conn_drop: hcon ffff88021f65a000 orig refcnt 2
> [69714.145739] [8909] l2cap_conn_del: hcon ffff88021f65a000 conn ffff880221005c00, err 13
> [69714.145740] [6450] bt_sock_poll: sock ffff8801db6b5400, sk ffff88021e775000
> [69714.145743] [6450] bt_sock_poll: sock ffff8801db6b5e00, sk ffff880160356000
> [69714.145744] [8909] l2cap_chan_hold: chan ffff88005ede2c00 orig refcnt 3
> [69714.145746] [6450] bt_sock_poll: sock ffff8800941ab700, sk ffff88005ede5800
> [69714.145748] [8909] l2cap_chan_del: chan ffff88005ede2c00, conn ffff880221005c00, err 13
> [69714.145749] [8909] l2cap_chan_put: chan ffff88005ede2c00 orig refcnt 4
> [69714.145751] [8909] hci_conn_drop: hcon ffff88021f65a000 orig refcnt 1
> [69714.145754] [6450] bt_sock_poll: sock ffff8800941ab700, sk ffff88005ede5800
> [69714.145756] [8909] l2cap_chan_put: chan ffff88005ede2c00 orig refcnt 3
> [69714.145759] [8909] hci_chan_del: hci0 hcon ffff88021f65a000 chan ffff88020d60b1c0
> [69714.145766] [5949] hci_sock_recvmsg: sock ffff8800941a9680, sk ffff88012bf4d000
> [69714.145787] [6515] hci_sock_release: sock ffff88005e75a080 sk ffff88010323ac00
> [69714.146002] [6450] hci_sock_recvmsg: sock ffff88005e758780, sk ffff88010323d400
> [69714.150795] [6450] l2cap_sock_release: sock ffff8800941ab700, sk ffff88005ede5800
> [69714.150799] [6450] l2cap_sock_shutdown: sock ffff8800941ab700, sk ffff88005ede5800
> [69714.150802] [6450] l2cap_chan_close: chan ffff88005ede2c00 state BT_CLOSED
> [69714.150805] [6450] l2cap_sock_kill: sk ffff88005ede5800 state BT_CLOSED
> [69714.150806] [6450] l2cap_chan_put: chan ffff88005ede2c00 orig refcnt 2
> [69714.150808] [6450] l2cap_sock_destruct: sk ffff88005ede5800
> [69714.150809] [6450] l2cap_chan_put: chan ffff88005ede2c00 orig refcnt 1
> [69714.150811] [6450] l2cap_chan_destroy: chan ffff88005ede2c00
> [69714.150970] [6450] bt_sock_poll: sock ffff88005e758500, sk ffff88010323b800
> ...
> [69714.151991] [8909] hci_conn_drop: hcon ffff88021f65a000 orig refcnt 0
> [69716.150339] [8909] hci_conn_timeout: hcon ffff88021f65a000 state BT_CONNECTED, refcnt -1
> 
> Signed-off-by: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
> ---
> v4: fixed commit msg to looks nicer 
> 
>  net/bluetooth/hci_conn.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index ca01d18..a7a27bc 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -289,10 +289,20 @@ static void hci_conn_timeout(struct work_struct *work)
>  {
>  	struct hci_conn *conn = container_of(work, struct hci_conn,
>  					     disc_work.work);
> +	int refcnt = atomic_read(&conn->refcnt);
>  
>  	BT_DBG("hcon %p state %s", conn, state_to_string(conn->state));
>  
> -	if (atomic_read(&conn->refcnt))
> +	WARN_ON(refcnt < 0);
As a fuzzer, syzbot hits this warning quite often. Thanks for adding this
WARN_ON. It is indicating that the issue of refcount getting less than 0 is
still present.

It would be best if a bluetooth dev can have a look at the error paths to
resolve this.

> +
> +	/* FIXME: It was observed that in pairing failed scenario, refcnt
> +	 * drops below 0. Probably this is because l2cap_conn_del calls
> +	 * l2cap_chan_del for each channel, and inside l2cap_chan_del conn is
> +	 * dropped. After that loop hci_chan_del is called which also drops
> +	 * conn. For now make sure that ACL is alive if refcnt is higher then 0,
> +	 * otherwise drop it.
> +	 */
> +	if (refcnt > 0)
>  		return;
>  
>  	switch (conn->state) {

-- 
BR,
Muhammad Usama Anjum
