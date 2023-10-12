Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE887C6F19
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 15:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378866AbjJLNYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 09:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378843AbjJLNYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 09:24:33 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4361C9;
        Thu, 12 Oct 2023 06:24:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0Vu-veev_1697117058;
Received: from 30.221.128.246(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Vu-veev_1697117058)
          by smtp.aliyun-inc.com;
          Thu, 12 Oct 2023 21:24:26 +0800
Message-ID: <54d5b5cc-ba87-69df-3eda-4e7d04218b83@linux.alibaba.com>
Date:   Thu, 12 Oct 2023 21:24:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
From:   Wen Gu <guwen@linux.alibaba.com>
Subject: Re: [PATCH net-next v4 06/18] net/smc: extend GID to 128bits only for
 virtual ISM device
To:     dust.li@linux.alibaba.com, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     wintera@linux.ibm.com, schnelle@linux.ibm.com,
        gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1695568613-125057-1-git-send-email-guwen@linux.alibaba.com>
 <1695568613-125057-7-git-send-email-guwen@linux.alibaba.com>
 <20231012075410.GQ92403@linux.alibaba.com>
In-Reply-To: <20231012075410.GQ92403@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/10/12 15:54, Dust Li wrote:

> On Sun, Sep 24, 2023 at 11:16:41PM +0800, Wen Gu wrote:
>> Virtual ISM devices are introduced to SMC-Dv2.1 protocal, whose GIDs
>> are 128-bits UUIDs as defined by RFC4122. And note that the GIDs of
>> ISM devices still remain 64-bits.
>>
>> This patch adapts the relevant codes, such as CLC handshake, to make
>> it compatible with 128 bits GID.
>>
>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>> ---
>> drivers/s390/net/ism_drv.c    | 18 +++++++------
>> include/net/smc.h             | 15 +++++++----
>> include/uapi/linux/smc.h      |  3 +++
>> include/uapi/linux/smc_diag.h |  2 ++
>> net/smc/af_smc.c              | 60 +++++++++++++++++++++++++++++++++----------
>> net/smc/smc_clc.c             | 43 +++++++++++++++++++++----------
>> net/smc/smc_clc.h             |  4 +--
>> net/smc/smc_core.c            | 41 +++++++++++++++++++++--------
>> net/smc/smc_core.h            |  7 ++---
>> net/smc/smc_diag.c            | 11 ++++++--
>> net/smc/smc_ism.c             | 18 ++++++++-----
>> net/smc/smc_ism.h             |  3 ++-
>> net/smc/smc_pnet.c            |  4 +--
>> 13 files changed, 163 insertions(+), 66 deletions(-)
>>

<...>

>> diff --git a/include/uapi/linux/smc.h b/include/uapi/linux/smc.h
>> index 837fcd4..0d2f020 100644
>> --- a/include/uapi/linux/smc.h
>> +++ b/include/uapi/linux/smc.h
>> @@ -99,6 +99,9 @@ enum {
>> 	SMC_NLA_LGR_V2_OS,		/* u8 */
>> 	SMC_NLA_LGR_V2_NEG_EID,		/* string */
>> 	SMC_NLA_LGR_V2_PEER_HOST,	/* string */
>> +	SMC_NLA_LGR_V2_PAD,		/* flag */
>> +	SMC_NLA_LGR_V2_GID_EXT,		/* u64 */
>> +	SMC_NLA_LGR_V2_PEER_GID_EXT,	/* u64 */
> 
> Why those abbributes are add here, which was supposed to add common
> abbritubtes ?
> 

Thanks! After looking back at this code, I also feel that the extended GID
attributes should be moved to other places. The nested attributes here are
shared by both SMC-R and SMC-D.

So similar to the SMC_NLA_LGR_R_V2 nested attributes introduced by SMC-R,
a new SMC_NLA_LGR_D_V2 nested attributes may be more suitable,
and processed by a new smc_nl_fill_smcr_lgr_v2() helper in smc_nl_fill_smcd_lgr().

<...>

>> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
>> index d520ee6..6d7c738 100644
>> --- a/net/smc/smc_core.c
>> +++ b/net/smc/smc_core.c
>> @@ -284,6 +284,9 @@ static int smc_nl_fill_lgr_v2_common(struct smc_link_group *lgr,
>> {
>> 	char smc_host[SMC_MAX_HOSTNAME_LEN + 1];
>> 	char smc_eid[SMC_MAX_EID_LEN + 1];
>> +	struct smcd_dev *smcd = lgr->smcd;
>> +	struct smcd_gid smcd_gid;
>> +	bool is_virtdev;
>>
>> 	if (nla_put_u8(skb, SMC_NLA_LGR_V2_VER, lgr->smc_version))
>> 		goto errv2attr;
>> @@ -299,6 +302,16 @@ static int smc_nl_fill_lgr_v2_common(struct smc_link_group *lgr,
>> 	smc_eid[SMC_MAX_EID_LEN] = 0;
>> 	if (nla_put_string(skb, SMC_NLA_LGR_V2_NEG_EID, smc_eid))
>> 		goto errv2attr;
>> +	smcd->ops->get_local_gid(smcd, &smcd_gid);
>> +	is_virtdev = smc_ism_is_virtdev(smcd);
>> +	if (nla_put_u64_64bit(skb, SMC_NLA_LGR_V2_GID_EXT,
>> +			      is_virtdev ? smcd_gid.gid_ext : 0,
>> +			      SMC_NLA_LGR_V2_PAD))
>> +		goto errv2attr;
>> +	if (nla_put_u64_64bit(skb, SMC_NLA_LGR_V2_PEER_GID_EXT,
>> +			      is_virtdev ? lgr->peer_gid.gid_ext : 0,
>> +			      SMC_NLA_LGR_V2_PAD))
>> +		goto errv2attr;
> 
> I ran into a kernel panic which pointed to here, and it turns out the
> smcd here is NULL. See below:
> 
> But taking a closer look at the code, I'm wondering why those SMCD
> related attributes are filled in smc_nl_fill_lgr_v2_common() which
> should only fill the common attributes ?
> 
> 

I guess the crash occurs when running in SMC-R. Due to this improper
code, the invalid lgr->smcd was accessed mistakenly in the common helper.

So as mentioned above, this extended GID related code will be moved out
of this common helper and fix this issue. Thanks!

Regards,
Wen Gu

> 
> [17567.395214] BUG: kernel NULL pointer dereference, address:
> 0000000000000000
> [17567.395729] #PF: supervisor read access in kernel mode
> [17567.396086] #PF: error_code(0x0000) - not-present page
> [17567.396442] PGD 0 P4D 0
> [17567.396623] Oops: 0000 [#1] SMP NOPTI
> [17567.396873] CPU: 7 PID: 34729 Comm: smcr Tainted: G        W   E
> 6.6.0-rc2-00669-gf4cfa8873d90-dirty #577
> [17567.397528] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [17567.398272] RIP: 0010:smc_nl_fill_lgr_v2_common.isra.0+0x1e0/0x2e0
> [smc]
> [17567.398734] Code: 21 0f 87 0e 01 00 00 0f 84 fc 00 00 00 8d 50 01 48
> 8d 4c 24 3f be 03 00 00 00 48 89 ef e8 28 c4 1a e1 85 c0 0f 85 72 fe ff
> ff <49> 8b 45 00 4c 89 ef 48 8d 74 24 08 48 8b 40 68 ff d0 0f 1f 00 49
> [17567.399950] RSP: 0018:ffffc90002adb820 EFLAGS: 00010246
> [17567.400297] RAX: 0000000000000000 RBX: ffff8881cad2402c RCX:
> 0000000000000057
> [17567.400769] RDX: 0000000000000000 RSI: ffffc90002adb85f RDI:
> ffff8881cad24074
> [17567.401237] RBP: ffff888107d4cd00 R08: 0020202020202020 R09:
> 2020202020202020
> [17567.401709] R10: 2020202020202020 R11: 2020202020415955 R12:
> ffff8882673e0000
> [17567.402176] R13: 0000000000000000 R14: ffff8881cad23fe4 R15:
> ffff88813fbe4b60
> [17567.402650] FS:  00007f679f655740(0000) GS:ffff88842fdc0000(0000)
> knlGS:0000000000000000
> [17567.403179] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [17567.403561] CR2: 0000000000000000 CR3: 00000001680d2005 CR4:
> 0000000000370ee0
> [17567.404029] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [17567.404501] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [17567.404968] Call Trace:
> [17567.405140]  <TASK>
> [17567.405287]  ? __die_body+0x1f/0x70
> [17567.405533]  ? page_fault_oops+0x14c/0x440
> [17567.405813]  ? exc_page_fault+0x69/0x120
> [17567.406079]  ? asm_exc_page_fault+0x26/0x30
> [17567.406361]  ? smc_nl_fill_lgr_v2_common.isra.0+0x1e0/0x2e0 [smc]
> [17567.406778]  smc_nl_fill_lgr_list.constprop.0+0x368/0x4e0 [smc]
> [17567.407180]  smcr_nl_get_link+0x17/0x20 [smc]
> [17567.407484]  genl_dumpit+0x32/0x90
> [17567.407722]  netlink_dump+0x19d/0x3b0
> [17567.407971]  __netlink_dump_start+0x1d3/0x290
> [17567.408266]  genl_family_rcv_msg_dumpit.isra.0+0x7d/0xd0
> [17567.408625]  ? __pfx_genl_start+0x10/0x10
> [17567.408897]  ? __pfx_genl_dumpit+0x10/0x10
> [17567.409172]  ? __pfx_genl_done+0x10/0x10
> [17567.409437]  genl_rcv_msg+0x113/0x2a0
> [17567.409690]  ? __pfx_smcr_nl_get_link+0x10/0x10 [smc]
> [17567.410040]  ? __pfx_genl_rcv_msg+0x10/0x10
> [17567.410312]  netlink_rcv_skb+0x58/0x110
> [17567.410567]  genl_rcv+0x28/0x40
> [17567.410777]  netlink_unicast+0x181/0x240
> [17567.411033]  netlink_sendmsg+0x240/0x4a0
> [17567.411288]  sock_sendmsg+0xb1/0xc0
> [17567.411524]  ____sys_sendmsg+0x20f/0x300
> [17567.411780]  ? copy_msghdr_from_user+0x62/0x80
> [17567.412067]  ___sys_sendmsg+0x81/0xc0
> [17567.412306]  ? folio_add_lru+0x2b/0x30
> [17567.412555]  ? do_anonymous_page+0x18d/0x4e0
> [17567.412837]  ? __handle_mm_fault+0x47f/0x7c0
> [17567.413115]  __sys_sendmsg+0x4d/0x80
> [17567.413349]  ? exit_to_user_mode_prepare+0x3c/0x190
> [17567.413669]  do_syscall_64+0x3c/0x90
> [17567.413908]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [17567.414234] RIP: 0033:0x7f679f79c177
> [17567.414467] Code: 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f
> 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00 00 00 0f
> 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89 74 24 10
> [17567.415640] RSP: 002b:00007ffe6d08c168 EFLAGS: 00000246 ORIG_RAX:
> 000000000000002e
> [17567.416119] RAX: ffffffffffffffda RBX: 00005619cb470390 RCX:
> 00007f679f79c177
> [17567.416574] RDX: 0000000000000000 RSI: 00007ffe6d08c1a0 RDI:
> 0000000000000003
> [17567.417026] RBP: 00005619cb4702a0 R08: 0000000000000004 R09:
> 0000000000000300
> [17567.417481] R10: 0000000000000004 R11: 0000000000000246 R12:
> 00005619cb4704b0
> [17567.417932] R13: 00007ffe6d08c1a0 R14: 0000000000000000 R15:
> 0000000000000000
> [17567.418385]  </TASK>
> [17567.418535] Modules linked in: smc_diag(E) smc(E) rpcrdma(E)
> sunrpc(E) ib_srpt(E) ib_isert(E) iscsi_target_mod(E) target_core_mod(E)
> ib_ipoib(E) ib_iser(E) libiscsi(E) scsi_transport_iscsi(E) mlx5_ib(E)
> rfkill(E)
> [17567.419722] CR2: 0000000000000000
> [17567.419940] ---[ end trace 0000000000000000 ]---
> [17567.420237] RIP: 0010:smc_nl_fill_lgr_v2_common.isra.0+0x1e0/0x2e0
> [smc]
> [17567.420676] Code: 21 0f 87 0e 01 00 00 0f 84 fc 00 00 00 8d 50 01 48
> 8d 4c 24 3f be 03 00 00 00 48 89 ef e8 28 c4 1a e1 85 c0 0f 85 72 fe ff
> ff <49> 8b 45 00 4c 89 ef 48 8d 74 24 08 48 8b 40 68 ff d0 0f 1f 00 49
> [17567.421842] RSP: 0018:ffffc90002adb820 EFLAGS: 00010246
> [17567.422176] RAX: 0000000000000000 RBX: ffff8881cad2402c RCX:
> 0000000000000057
> [17567.422631] RDX: 0000000000000000 RSI: ffffc90002adb85f RDI:
> ffff8881cad24074
> [17567.423082] RBP: ffff888107d4cd00 R08: 0020202020202020 R09:
> 2020202020202020
> [17567.423536] R10: 2020202020202020 R11: 2020202020415955 R12:
> ffff8882673e0000
> [17567.423987] R13: 0000000000000000 R14: ffff8881cad23fe4 R15:
> ffff88813fbe4b60
> [17567.424438] FS:  00007f679f655740(0000) GS:ffff88842fdc0000(0000)
> knlGS:0000000000000000
> [17567.424950] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [17567.425317] CR2: 0000000000000000 CR3: 00000001680d2005 CR4:
> 0000000000370ee0
> [17567.425773] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [17567.426225] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [17567.426677] Kernel panic - not syncing: Fatal exception in interrupt
> [17567.427583] Kernel Offset: disabled
> [17567.427817] ---[ end Kernel panic - not syncing: Fatal exception in
> interrupt ]---
> 
> 
> Best regards,
> Dust
> 
> 
> 
>>
>> 	nla_nest_end(skb, v2_attrs);
>> 	return 0;
