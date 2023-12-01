Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17811800C76
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 14:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379042AbjLANqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 08:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379031AbjLANqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 08:46:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2EB197
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 05:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701438403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CZOsoVNTrlsyDIj04ZnPkYY4FYY9jzgQ1kRjegPcrJ4=;
        b=hX24Ps1y1hHz3KE1vK5QzaGfgB+57yODmMAb76JCROyWlXUIPM2+Zvd2UevVrIRg2tLXs0
        Lu0z8+6BWQLEmWERCQAuCu+D0SkpTdSxC+DTAUK1/Lg0zqnswZ692FkS5LZZtDnQo7InFr
        rvw90BDy/TIDtHzYs51BqWrjpS9iOeQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-JxDopkrqPtS-12mHFloEHw-1; Fri, 01 Dec 2023 08:46:40 -0500
X-MC-Unique: JxDopkrqPtS-12mHFloEHw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B8D7C811E7B;
        Fri,  1 Dec 2023 13:46:39 +0000 (UTC)
Received: from [10.45.225.216] (unknown [10.45.225.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA6F12166B26;
        Fri,  1 Dec 2023 13:46:37 +0000 (UTC)
Message-ID: <27946430-66d0-4a09-b275-ead122a082ce@redhat.com>
Date:   Fri, 1 Dec 2023 14:46:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] i40e: Fix kernel crash during
 macvlan offloading setup
Content-Language: en-US
To:     "Brelinski, Tony" <tony.brelinski@intel.com>,
        Simon Horman <horms@kernel.org>
Cc:     Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>,
        "Drewek, Wojciech" <wojciech.drewek@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "moderated list:INTEL ETHERNET DRIVERS" 
        <intel-wired-lan@lists.osuosl.org>,
        "Keller, Jacob E" <jacob.e.keller@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
References: <20231124164233.86691-1-ivecera@redhat.com>
 <20231129163618.GD43811@kernel.org>
 <DM6PR11MB4218C83B7A07BB833D298D388282A@DM6PR11MB4218.namprd11.prod.outlook.com>
From:   Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <DM6PR11MB4218C83B7A07BB833D298D388282A@DM6PR11MB4218.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30. 11. 23 20:24, Brelinski, Tony wrote:
>> -----Original Message-----
>> From: Intel-wired-lan<intel-wired-lan-bounces@osuosl.org>  On Behalf Of
>> Simon Horman
>> Sent: Wednesday, November 29, 2023 8:36 AM
>> To: ivecera<ivecera@redhat.com>
>> Cc: Harshitha Ramamurthy<harshitha.ramamurthy@intel.com>; Drewek,
>> Wojciech<wojciech.drewek@intel.com>;netdev@vger.kernel.org;
>> Brandeburg, Jesse<jesse.brandeburg@intel.com>; open list <linux-
>> kernel@vger.kernel.org>; Eric Dumazet <edumazet@google.com>; Nguyen,
>> Anthony L<anthony.l.nguyen@intel.com>; Jeff Kirsher
>> <jeffrey.t.kirsher@intel.com>; moderated list:INTEL ETHERNET DRIVERS <intel-
>> wired-lan@lists.osuosl.org>; Keller, Jacob E <jacob.e.keller@intel.com>; Jakub
>> Kicinski<kuba@kernel.org>; Paolo Abeni<pabeni@redhat.com>; David S.
>> Miller<davem@davemloft.net>
>> Subject: Re: [Intel-wired-lan] [PATCH iwl-net] i40e: Fix kernel crash during
>> macvlan offloading setup
>>
>> On Fri, Nov 24, 2023 at 05:42:33PM +0100, Ivan Vecera wrote:
>>> Function i40e_fwd_add() computes num of created channels and num of
>>> queues per channel according value of pf->num_lan_msix.
>>>
>>> This is wrong because the channels are used for subordinated net
>>> devices that reuse existing queues from parent net device and number
>>> of existing queue pairs (pf->num_queue_pairs) should be used instead.
>>>
>>> E.g.:
>>> Let's have (pf->num_lan_msix == 32)... Then we reduce number of
>>> combined queues by ethtool to 8 (so pf->num_queue_pairs == 8).
>>> i40e_fwd_add() called by macvlan then computes number of macvlans
>>> channels to be 16 and queues per channel 1 and calls
>>> i40e_setup_macvlans(). This computes new number of queue pairs for PF
>>> as:
>>>
>>> num_qps = vsi->num_queue_pairs - (macvlan_cnt * qcnt);
>>>
>>> This is evaluated in this case as:
>>> num_qps = (8 - 16 * 1) = (u16)-8 = 0xFFF8
>>>
>>> ...and this number is stored vsi->next_base_queue that is used during
>>> channel creation. This leads to kernel crash.
>>>
>>> Fix this bug by computing the number of offloaded macvlan devices and
>>> no. their queues according the current number of queues instead of
>>> maximal one.
>>>
>>> Reproducer:
>>> 1) Enable l2-fwd-offload
>>> 2) Reduce number of queues
>>> 3) Create macvlan device
>>> 4) Make it up
>>>
>>> Result:
>>> [root@cnb-03 ~]# ethtool -K enp2s0f0np0 l2-fwd-offload on
>>> [root@cnb-03 ~]# ethtool -l enp2s0f0np0 | grep Combined
>>> Combined:       32
>>> Combined:       32
>>> [root@cnb-03 ~]# ethtool -L enp2s0f0np0 combined 8
>>> [root@cnb-03 ~]# ip link add link enp2s0f0np0 mac0 type macvlan mode
>>> bridge
>>> [root@cnb-03 ~]# ip link set mac0 up
>>> ...
>>> [ 1225.686698] i40e 0000:02:00.0: User requested queue count/HW max
>>> RSS count:  8/32 [ 1242.399103] BUG: kernel NULL pointer dereference,
>>> address: 0000000000000118 [ 1242.406064] #PF: supervisor write access
>>> in kernel mode [ 1242.411288] #PF: error_code(0x0002) - not-present
>>> page [ 1242.416417] PGD 0 P4D 0 [ 1242.418950] Oops: 0002 [#1]
>> PREEMPT
>>> SMP NOPTI [ 1242.423308] CPU: 26 PID: 2253 Comm: ip Kdump: loaded
>> Not
>>> tainted 6.7.0-rc1+ #20 [ 1242.430607] Hardware name: Abacus electric,
>>> s.r.o. -servis@abacus.cz  Super Server/H12SSW-iN, BIOS 2.4 04/13/2022
>>> [ 1242.440850] RIP:
>>> 0010:i40e_channel_config_tx_ring.constprop.0+0xd9/0x180 [i40e] [
>>> 1242.448165] Code: 48 89 b3 80 00 00 00 48 89 bb 88 00 00 00 74 3c 31
>>> c9 0f b7 53 16 49 8b b4 24 f0 0c 00 00 01 ca 83 c1 01 0f b7 d2 48 8b
>>> 34 d6 <48> 89 9e 18 01 00 00 49 8b b4 24 e8 0c 00 00 48 8b 14 d6 48 89
>>> 9a [ 1242.466902] RSP: 0018:ffffa4d52cd2f610 EFLAGS: 00010202 [
>>> 1242.472121] RAX: 0000000000000000 RBX: ffff9390a4ba2e40 RCX:
>>> 0000000000000001 [ 1242.479244] RDX: 000000000000fff8 RSI:
>>> 0000000000000000 RDI: ffffffffffffffff [ 1242.486370] RBP:
>>> ffffa4d52cd2f650 R08: 0000000000000020 R09: 0000000000000000 [
>>> 1242.493494] R10: 0000000000000000 R11: 0000000100000001 R12:
>>> ffff9390b861a000 [ 1242.500626] R13: 00000000000000a0 R14:
>>> 0000000000000010 R15: ffff9390b861a000 [ 1242.507751] FS:
>> 00007efda536b740(0000) GS:ffff939f4ec80000(0000)
>> knlGS:0000000000000000 [ 1242.515826] CS:  0010 DS: 0000 ES: 0000
>> CR0: 0000000080050033 [ 1242.521564] CR2: 0000000000000118 CR3:
>> 000000010bd48002 CR4: 0000000000770ef0 [ 1242.528699] PKRU:
>> 55555554 [ 1242.531400] Call Trace:
>>> [ 1242.533846]  <TASK>
>>> [ 1242.535943]  ? __die+0x20/0x70
>>> [ 1242.539004]  ? page_fault_oops+0x76/0x170 [ 1242.543018]  ?
>>> exc_page_fault+0x65/0x150 [ 1242.546942]  ?
>>> asm_exc_page_fault+0x22/0x30 [ 1242.551131]  ?
>>> i40e_channel_config_tx_ring.constprop.0+0xd9/0x180 [i40e] [
>>> 1242.557847]  i40e_setup_channel.part.0+0x5f/0x130 [i40e] [
>>> 1242.563167]  i40e_setup_macvlans.constprop.0+0x256/0x420 [i40e] [
>>> 1242.569099]  i40e_fwd_add+0xbf/0x270 [i40e] [ 1242.573300]
>>> macvlan_open+0x16f/0x200 [macvlan] [ 1242.577831]
>>> __dev_open+0xe7/0x1b0 [ 1242.581236]
>> __dev_change_flags+0x1db/0x250
>>> ...
>>>
>>> Fixes: 1d8d80b4e4ff ("i40e: Add macvlan support on i40e")
>>> Signed-off-by: Ivan Vecera<ivecera@redhat.com>
>> Thanks Ivan,
>>
>> I agree with the analysis and that the problem was introduced by the cited
>> patch.
>>
>> Reviewed-by: Simon Horman<horms@kernel.org>
>>
>> _______________________________________________
>> Intel-wired-lan mailing list
>> Intel-wired-lan@osuosl.org
>> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> The issue this patch is supposed to fix is resolved by this patch, but now there is a new crash seen with this patch.  Crash output below:
> 
> Crash logs:
> 
> [  315.844666] i40e 0000:86:00.0: Query for DCB configuration failed, err -EIO aq_err I40E_AQ_RC_EINVAL
> [  315.844678] i40e 0000:86:00.0: DCB init failed -5, disabled
> [  315.873394] i40e 0000:86:00.0: User requested queue count/HW max RSS count:  1/64
> [  315.900682] i40e 0000:86:00.0 eth4: Not enough queues to support macvlans

I'm able to reproduce now... I have found that the macvlan offloading is 
broken in several ways. I'm working to address theses issues.

Thanks,
Ivan

