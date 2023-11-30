Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985387FFB7F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376503AbjK3Tjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376470AbjK3Tjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:39:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFD6D67
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 11:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701373180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HM4F7OE1559KbABAGdnrTVNXg7QPyAtsmZBpHcmKxsk=;
        b=ZtltpQ3fhdtcoO9VZrmeGX4W9jwPAgU6Xx4DX2fgqbAxBp1Q/6cb2WBOfLrtcYcxDwUGO4
        XpYSFYS/q1EVl14MvQHHJydoP2f43v4CMFn/7HrRT42jCZyV8V2/4qyergYhW/1bJykqzw
        GHDogyjcPwT5nGBTLKa/Xe8mAopkZ/A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-gL_IEYpFP-qurbFQW1wDwg-1; Thu, 30 Nov 2023 14:39:36 -0500
X-MC-Unique: gL_IEYpFP-qurbFQW1wDwg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F531101A52D;
        Thu, 30 Nov 2023 19:39:36 +0000 (UTC)
Received: from [10.45.225.216] (unknown [10.45.225.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A8D5810E46;
        Thu, 30 Nov 2023 19:39:33 +0000 (UTC)
Message-ID: <dcee6dfa-b5b9-4921-a88e-96ff2aa125ce@redhat.com>
Date:   Thu, 30 Nov 2023 20:39:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] i40e: Fix kernel crash during
 macvlan offloading setup
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
Content-Language: en-US
From:   Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <DM6PR11MB4218C83B7A07BB833D298D388282A@DM6PR11MB4218.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30. 11. 23 20:24, Brelinski, Tony wrote:
>> -----Original Message-----
>> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>> Simon Horman
>> Sent: Wednesday, November 29, 2023 8:36 AM
>> To: ivecera <ivecera@redhat.com>
>> Cc: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>; Drewek,
>> Wojciech <wojciech.drewek@intel.com>; netdev@vger.kernel.org;
>> Brandeburg, Jesse <jesse.brandeburg@intel.com>; open list <linux-
>> kernel@vger.kernel.org>; Eric Dumazet <edumazet@google.com>; Nguyen,
>> Anthony L <anthony.l.nguyen@intel.com>; Jeff Kirsher
>> <jeffrey.t.kirsher@intel.com>; moderated list:INTEL ETHERNET DRIVERS <intel-
>> wired-lan@lists.osuosl.org>; Keller, Jacob E <jacob.e.keller@intel.com>; Jakub
>> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; David S.
>> Miller <davem@davemloft.net>
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
>>> s.r.o. - servis@abacus.cz Super Server/H12SSW-iN, BIOS 2.4 04/13/2022
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
>>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>>
>> Thanks Ivan,
>>
>> I agree with the analysis and that the problem was introduced by the cited
>> patch.
>>
>> Reviewed-by: Simon Horman <horms@kernel.org>
>>
>> _______________________________________________
>> Intel-wired-lan mailing list
>> Intel-wired-lan@osuosl.org
>> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> 
> The issue this patch is supposed to fix is resolved by this patch, but now there is a new crash seen with this patch.  Crash output below:

Hi, could you please share the reproducer?

Thanks,
Ivan

> Crash logs:
> 
> [  315.844666] i40e 0000:86:00.0: Query for DCB configuration failed, err -EIO aq_err I40E_AQ_RC_EINVAL
> [  315.844678] i40e 0000:86:00.0: DCB init failed -5, disabled
> [  315.873394] i40e 0000:86:00.0: User requested queue count/HW max RSS count:  1/64
> [  315.900682] i40e 0000:86:00.0 eth4: Not enough queues to support macvlans
> [  316.021500] i40e 0000:86:00.0: Query for DCB configuration failed, err -EIO aq_err I40E_AQ_RC_EINVAL
> [  316.021510] i40e 0000:86:00.0: DCB init failed -5, disabled
> [  316.055114] i40e 0000:86:00.0: User requested queue count/HW max RSS count:  3/64
> [  316.314535] i40e 0000:86:00.0: Query for DCB configuration failed, err -EIO aq_err I40E_AQ_RC_EINVAL
> [  316.314544] i40e 0000:86:00.0: DCB init failed -5, disabled
> [  316.341128] i40e 0000:86:00.0: User requested queue count/HW max RSS count:  8/64
> [  316.360934] i40e 0000:86:00.0: Error adding mac filter on macvlan err -EIO, aq_err I40E_AQ_RC_ENOENT
> [  316.360945] mac0: L2fwd offload disabled to L2 filter error
> [  316.423043] i40e 0000:86:00.0: Error adding mac filter on macvlan err -EIO, aq_err I40E_AQ_RC_ENOENT
> [  316.423053] mac0: L2fwd offload disabled to L2 filter error
> [  317.450445] BUG: kernel NULL pointer dereference, address: 00000000000000f4
> [  317.450455] #PF: supervisor read access in kernel mode
> [  317.450460] #PF: error_code(0x0000) - not-present page
> [  317.450465] PGD 0 P4D 0
> [  317.450472] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [  317.450480] CPU: 24 PID: 0 Comm: swapper/24 Kdump: loaded Not tainted 6.7.0-rc2_next-queue_29th-Nov-2023-00580-ga1c79fa9e5cd #1
> [  317.450488] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0010.010620200716 01/06/2020
> [  317.450492] RIP: 0010:i40e_process_skb_fields+0x32/0x200 [i40e]
> [  317.450621] Code: 89 f5 41 54 55 48 89 fd 53 4c 8b 66 08 48 89 d3 4c 89 e2 4d 89 e0 81 e2 ff ff 07 00 41 f6 c4 80 0f 85 84 01 00 00 48 8b 45 18 <f6> 80 f4 00 00 00 80 74 14 4c 89 c0 25 00 30 00 00 48 3d 00 30 00
> [  317.450627] RSP: 0018:ffffc90006f60df0 EFLAGS: 00010246
> [  317.450633] RAX: 0000000000000000 RBX: ffff8881067f4400 RCX: 0000000000000056
> [  317.450638] RDX: 0000000000003003 RSI: ffff888c4918e000 RDI: ffff888c7bf799c0
> [  317.450642] RBP: ffff888c7bf799c0 R08: 0000159780003003 R09: ffff888107f3e0c0
> [  317.450646] R10: ffff888c4918e000 R11: ffffc90006f60ff8 R12: 0000159780003003
> [  317.450650] R13: ffff888c4918e000 R14: ffff8881067f4400 R15: ffff888c7bf799c0
> [  317.450654] FS:  0000000000000000(0000) GS:ffff88980f200000(0000) knlGS:0000000000000000
> [  317.450659] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  317.450663] CR2: 00000000000000f4 CR3: 0000000761020006 CR4: 00000000007706f0
> [  317.450667] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  317.450671] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  317.450674] PKRU: 55555554
> [  317.450677] Call Trace:
> [  317.450684]  <IRQ>
> [  317.450689]  ? __die+0x20/0x70
> [  317.450704]  ? page_fault_oops+0x76/0x170
> [  317.450716]  ? exc_page_fault+0x65/0x150
> [  317.450727]  ? asm_exc_page_fault+0x22/0x30
> [  317.450737]  ? i40e_process_skb_fields+0x32/0x200 [i40e]
> [  317.450845]  i40e_clean_rx_irq+0x5e3/0x7e0 [i40e]
> [  317.450943]  i40e_napi_poll+0x13a/0x4f0 [i40e]
> [  317.451037]  __napi_poll+0x29/0x1b0
> [  317.451046]  net_rx_action+0x29b/0x370
> [  317.451052]  ? __napi_schedule_irqoff+0x58/0xa0
> [  317.451062]  __do_softirq+0xc8/0x2a8
> [  317.451071]  irq_exit_rcu+0xa6/0xc0
> [  317.451080]  common_interrupt+0x80/0xa0
> [  317.451086]  </IRQ>
> [  317.451089]  <TASK>
> [  317.451091]  asm_common_interrupt+0x22/0x40
> [  317.451097] RIP: 0010:cpuidle_enter_state+0xc2/0x420
> [  317.451107] Code: 00 e8 12 53 4c ff e8 4d f4 ff ff 8b 53 04 49 89 c5 0f 1f 44 00 00 31 ff e8 8b 2c 4b ff 45 84 ff 0f 85 3a 02 00 00 fb 45 85 f6 <0f> 88 6e 01 00 00 49 63 d6 4c 2b 2c 24 48 8d 04 52 48 8d 04 82 49
> [  317.451113] RSP: 0018:ffffc90004847e80 EFLAGS: 00000206
> [  317.451118] RAX: ffff88980f232040 RBX: ffff88980f23d600 RCX: 000000000000001f
> [  317.451122] RDX: 0000000000000018 RSI: 000000003d188150 RDI: 0000000000000000
> [  317.451126] RBP: 0000000000000003 R08: 00000049e9852dad R09: 0000000000000000
> [  317.451130] R10: 0000000000000210 R11: ffff88980f230c24 R12: ffffffff940b3a60
> [  317.451134] R13: 00000049e9852dad R14: 0000000000000003 R15: 0000000000000000
> [  317.451143]  cpuidle_enter+0x29/0x40
> [  317.451157]  cpuidle_idle_call+0xfa/0x160
> [  317.451171]  do_idle+0x7b/0xe0
> [  317.451179]  cpu_startup_entry+0x26/0x30
> [  317.451188]  start_secondary+0x115/0x140
> [  317.451196]  secondary_startup_64_no_verify+0x17d/0x18b
> [  317.451210]  </TASK>
> [  317.451212] Modules linked in: macvlan snd_seq_dummy snd_hrtimer snd_seq snd_timer snd_seq_device snd soundcore qrtr rfkill vfat fat xfs libcrc32c rpcrdma sunrpc rdma_ucm ib_srpt ib_isert iscsi_target_mod intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common target_core_mod ib_iser isst_if_common skx_edac libiscsi nfit scsi_transport_iscsi libnvdimm rdma_cm ipmi_ssif iw_cm x86_pkg_temp_thermal intel_powerclamp ib_cm coretemp kvm_intel kvm irqbypass rapl intel_cstate irdma iTCO_wdt ib_uverbs iTCO_vendor_support intel_uncore acpi_ipmi mei_me pcspkr ipmi_si i2c_i801 ib_core mei ipmi_devintf i2c_smbus lpc_ich ioatdma intel_pch_thermal ipmi_msghandler joydev acpi_power_meter acpi_pad ext4 mbcache jbd2 ast drm_shmem_helper drm_kms_helper sd_mod t10_pi sg ice ixgbe drm i40e ahci crct10dif_pclmul libahci crc32_pclmul igb crc32c_intel ghash_clmulni_intel libata mdio i2c_algo_bit dca gnss wmi fuse [last unloaded: macvlan]
> [  317.451344] CR2: 00000000000000f4
> 
> Thanks,
> Tony B.
> 

