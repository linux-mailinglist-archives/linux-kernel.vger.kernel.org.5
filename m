Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A583B7DFDE2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 03:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjKCBti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 21:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjKCBth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 21:49:37 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901711A2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 18:49:31 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id D9F52500070;
        Fri,  3 Nov 2023 01:49:28 +0000 (UTC)
Received: from [192.168.1.115] (unknown [98.97.34.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 4A3C513C2B0;
        Thu,  2 Nov 2023 18:49:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 4A3C513C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1698976168;
        bh=LYI+3aqHZb0lzADrVA8HLoGv+jB2eeGgAMONzgHDAwk=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=Ypo4Rr2nU2mTNIrnCwG3IFCjUjT7L7HCVOw9wXU5XoYpk+v7JZSxCoaSAdj15o/r6
         3JT8VcwxDRFq/OMsf1i1hKX5Hu5Mszb5vAjPmhf2LNNh7XvfeEyRsSMFC7KV3MZl59
         IdmZg/9TySbCAJ/RDHO8OR7/GUvOvCJNvCE5wZhs=
Subject: Re: [PATCH/RFC] debugobjects/slub: Print slab info and backtrace.
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20231103013704.1232723-1-greearb@candelatech.com>
Cc:     Rodolfo Giometti <giometti@enneenne.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <92a422d6-76c8-ce25-c331-0718b73dd274@candelatech.com>
Date:   Thu, 2 Nov 2023 18:49:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20231103013704.1232723-1-greearb@candelatech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1698976169-l1-UbZrs9DoA
X-MDID-O: us5;ut7;1698976169;l1-UbZrs9DoA;<greearb@candelatech.com>;0029eaa282e2c2cd983ed90f0c3213c0
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/23 6:37 PM, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
> 
> When debugobjects detects a problem, it may be in generic code
> where the backtraces currently printed are not helpful.

And here is resulting splat from wireless-next tree I've been
debugging.

Note the subsequent splats from slub are due to some memory poisoning, for
one reason or another.  Maybe slub changes should not be included in this patch, not
sure if it can provide useful info in other cases though.

If I understand this correctly, then it appears the bug is related to the pps driver.

[snippet, see below for more context]

16140 Nov 02 17:28:25 ct523c-2103 kernel: ODEBUG: debugobjects: debug_obj allocated at:
16141 Nov 02 17:28:25 ct523c-2103 kernel:  init_timer_key+0x24/0x160
16142 Nov 02 17:28:25 ct523c-2103 kernel:  kobject_put+0x14f/0x190
16143 Nov 02 17:28:25 ct523c-2103 kernel:  pps_device_destruct+0x26/0xb0
16144 Nov 02 17:28:25 ct523c-2103 kernel:  device_release+0x57/0x100
16145 Nov 02 17:28:25 ct523c-2103 kernel:  kobject_delayed_cleanup+0xdf/0x140
16146 Nov 02 17:28:25 ct523c-2103 kernel:  process_one_work+0x475/0x920
16147 Nov 02 17:28:25 ct523c-2103 kernel:  worker_thread+0x38a/0x680
16148 Nov 02 17:28:25 ct523c-2103 kernel:  kthread+0x199/0x1e0
16149 Nov 02 17:28:25 ct523c-2103 kernel:  ret_from_fork+0x28/0x50
16150 Nov 02 17:28:25 ct523c-2103 kernel:  ret_from_fork_asm+0x11/0x20
16151 Nov 02 17:28:25 ct523c-2103 kernel: ODEBUG: end of stack dump



16084 Nov 02 17:28:25 ct523c-2103 kernel: ODEBUG: free active (active state 0) object: ffff888181c029a0 object type: timer_list hint: 
kobject_delayed_cleanup+0x0/0x140
16085 Nov 02 17:28:25 ct523c-2103 kernel: WARNING: CPU: 1 PID: 104 at lib/debugobjects.c:549 debug_print_object+0xf0/0x170
16086 Nov 02 17:28:25 ct523c-2103 kernel: Modules linked in: vrf nf_conntrack_netlink nfnetlink nf_nat(-) nf_conntrack nf_defrag_ipv6 
nf_defrag_ipv4 bpfilter 8021q garp mrp stp llc macvlan pktgen rpcrdma rdma_cm iw_cm ib_cm ib_core qrtr f71882fg iTCO_wdt intel_pmc_bxt       intel_rapl_msr 
ee1004 iTCO_vendor_support snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_intel         snd_intel_dspcfg coretemp 
snd_hda_codec snd_hda_core intel_rapl_common intel_tcc_cooling snd_hwdep x86_pkg_temp_thermal                      intel_powerclamp snd_seq snd_seq_device 
snd_pcm kvm_intel snd_timer kvm irqbypass intel_wmi_thunderbolt pcspkr snd i2c_i801 soundcore        i2c_smbus iwlmvm mac80211 iwlwifi cfg80211 bfq mei_pxp 
mei_hdcp intel_pch_thermal tpm_crb tpm_tis tpm_tis_core tpm acpi_pad                  sch_fq_codel nfsd auth_rpcgss nfs_acl lockd grace fuse sunrpc zram raid1 
dm_raid raid456 libcrc32c async_raid6_recov async_memcpy            async_pq async_xor xor async_tx raid6_pq i915 drm_buddy intel_gtt drm_display_helper 
drm_kms_helper cec rc_core ttm igb i2c_algo_bit         drm ixgbe agpgart
16087 Nov 02 17:28:25 ct523c-2103 kernel:  mdio dca mei_wdt xhci_pci hwmon i2c_core xhci_pci_renesas video wmi [last unloaded: nf_nat]
16088 Nov 02 17:28:25 ct523c-2103 kernel: CPU: 1 PID: 104 Comm: kworker/1:10 Tainted: G        W          6.6.0-rc7+ #17
16089 Nov 02 17:28:25 ct523c-2103 kernel: Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/21/2023
16090 Nov 02 17:28:25 ct523c-2103 kernel: Workqueue: events kobject_delayed_cleanup
16091 Nov 02 17:28:25 ct523c-2103 kernel: RIP: 0010:debug_print_object+0xf0/0x170
16092 Nov 02 17:28:25 ct523c-2103 kernel: Code: e8 a5 6a b7 ff 48 8b 14 ed 00 af c4 82 4d 89 f8 4c 89 e6 41 56 4c 8b 4c 24 10 48 c7 c7 c0 a1       c4 82 8b 4c 
24 0c e8 d0 eb 74 ff <0f> 0b 48 8d 6b 28 48 89 ef e8 72 6a b7 ff 48 83 7b 28 00 58 75 34
16093 Nov 02 17:28:25 ct523c-2103 kernel: RSP: 0018:ffff8881335a7be0 EFLAGS: 00010282
16094 Nov 02 17:28:25 ct523c-2103 kernel: RAX: 0000000000000000 RBX: ffff88813e0c1248 RCX: ffffffff81343788
16095 Nov 02 17:28:25 ct523c-2103 kernel: RDX: 1ffff110837d58a4 RSI: 0000000000000008 RDI: ffff88841beac520
16096 Nov 02 17:28:25 ct523c-2103 kernel: RBP: 0000000000000003 R08: 0000000000000001 R09: ffffed10266b4f41
16097 Nov 02 17:28:25 ct523c-2103 kernel: R10: ffff8881335a7a0f R11: 00000000000ec2f0 R12: ffffffff82c4a8c0
16098 Nov 02 17:28:25 ct523c-2103 kernel: R13: ffff88813e0c1260 R14: ffffffff8269fe20 R15: ffff888181c029a0
16099 Nov 02 17:28:25 ct523c-2103 kernel: FS:  0000000000000000(0000) GS:ffff88841be80000(0000) knlGS:0000000000000000
16100 Nov 02 17:28:25 ct523c-2103 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
16101 Nov 02 17:28:25 ct523c-2103 kernel: CR2: 0000000001d68428 CR3: 0000000003696004 CR4: 00000000003706e0
16102 Nov 02 17:28:25 ct523c-2103 kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
16103 Nov 02 17:28:25 ct523c-2103 kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
16104 Nov 02 17:28:25 ct523c-2103 kernel: Call Trace:
16105 Nov 02 17:28:25 ct523c-2103 kernel:  <TASK>
16106 Nov 02 17:28:25 ct523c-2103 kernel:  ? __warn+0x9c/0x1f0
16107 Nov 02 17:28:25 ct523c-2103 kernel:  ? debug_print_object+0xf0/0x170
16108 Nov 02 17:28:25 ct523c-2103 kernel:  ? report_bug+0x1aa/0x1e0
16109 Nov 02 17:28:25 ct523c-2103 kernel:  ? handle_bug+0x41/0x80
16110 Nov 02 17:28:25 ct523c-2103 kernel:  ? exc_invalid_op+0x13/0x40
16111 Nov 02 17:28:25 ct523c-2103 kernel:  ? asm_exc_invalid_op+0x16/0x20
16112 Nov 02 17:28:25 ct523c-2103 kernel:  ? __kobject_del+0xc0/0xc0
16113 Nov 02 17:28:25 ct523c-2103 kernel:  ? tick_nohz_tick_stopped+0x18/0x30
16114 Nov 02 17:28:25 ct523c-2103 kernel:  ? debug_print_object+0xf0/0x170
16115 Nov 02 17:28:25 ct523c-2103 kernel:  ? __kobject_del+0xc0/0xc0
16116 Nov 02 17:28:25 ct523c-2103 kernel:  debug_check_no_obj_freed+0x261/0x2b0
16117 Nov 02 17:28:25 ct523c-2103 kernel:  __kmem_cache_free+0x185/0x200
16118 Nov 02 17:28:25 ct523c-2103 kernel:  ? device_release+0x57/0x100
16119 Nov 02 17:28:25 ct523c-2103 kernel:  device_release+0x57/0x100
16120 Nov 02 17:28:25 ct523c-2103 kernel:  kobject_delayed_cleanup+0xdf/0x140
16121 Nov 02 17:28:25 ct523c-2103 kernel:  process_one_work+0x475/0x920
16122 Nov 02 17:28:25 ct523c-2103 kernel:  ? kick_pool+0x1b0/0x1b0
16123 Nov 02 17:28:25 ct523c-2103 kernel:  ? __list_add_valid_or_report+0x33/0xd0
16124 Nov 02 17:28:25 ct523c-2103 kernel:  worker_thread+0x38a/0x680
16125 Nov 02 17:28:25 ct523c-2103 kernel:  ? __kthread_parkme+0xc9/0xe0
16126 Nov 02 17:28:25 ct523c-2103 kernel:  ? create_worker+0x390/0x390
16127 Nov 02 17:28:25 ct523c-2103 kernel:  kthread+0x199/0x1e0
16128 Nov 02 17:28:25 ct523c-2103 kernel:  ? kthread+0xed/0x1e0
16129 Nov 02 17:28:25 ct523c-2103 kernel:  ? kthread_complete_and_exit+0x20/0x20
16130 Nov 02 17:28:25 ct523c-2103 kernel:  ret_from_fork+0x28/0x50
16131 Nov 02 17:28:25 ct523c-2103 kernel:  ? kthread_complete_and_exit+0x20/0x20
16132 Nov 02 17:28:25 ct523c-2103 kernel:  ret_from_fork_asm+0x11/0x20
16133 Nov 02 17:28:25 ct523c-2103 kernel:  </TASK>
16134 Nov 02 17:28:25 ct523c-2103 kernel: irq event stamp: 0
16135 Nov 02 17:28:25 ct523c-2103 kernel: hardirqs last  enabled at (0): [<0000000000000000>] 0x0
16136 Nov 02 17:28:25 ct523c-2103 kernel: hardirqs last disabled at (0): [<ffffffff811d8998>] copy_process+0xf68/0x32c0
16137 Nov 02 17:28:25 ct523c-2103 kernel: softirqs last  enabled at (0): [<ffffffff811d8998>] copy_process+0xf68/0x32c0
16138 Nov 02 17:28:25 ct523c-2103 kernel: softirqs last disabled at (0): [<0000000000000000>] 0x0
16139 Nov 02 17:28:25 ct523c-2103 kernel: ---[ end trace 0000000000000000 ]---
16140 Nov 02 17:28:25 ct523c-2103 kernel: ODEBUG: debugobjects: debug_obj allocated at:
16141 Nov 02 17:28:25 ct523c-2103 kernel:  init_timer_key+0x24/0x160
16142 Nov 02 17:28:25 ct523c-2103 kernel:  kobject_put+0x14f/0x190
16143 Nov 02 17:28:25 ct523c-2103 kernel:  pps_device_destruct+0x26/0xb0
16144 Nov 02 17:28:25 ct523c-2103 kernel:  device_release+0x57/0x100
16145 Nov 02 17:28:25 ct523c-2103 kernel:  kobject_delayed_cleanup+0xdf/0x140
16146 Nov 02 17:28:25 ct523c-2103 kernel:  process_one_work+0x475/0x920
16147 Nov 02 17:28:25 ct523c-2103 kernel:  worker_thread+0x38a/0x680
16148 Nov 02 17:28:25 ct523c-2103 kernel:  kthread+0x199/0x1e0
16149 Nov 02 17:28:25 ct523c-2103 kernel:  ret_from_fork+0x28/0x50
16150 Nov 02 17:28:25 ct523c-2103 kernel:  ret_from_fork_asm+0x11/0x20
16151 Nov 02 17:28:25 ct523c-2103 kernel: ODEBUG: end of stack dump
16152 Nov 02 17:28:25 ct523c-2103 kernel: slab-info, slab: ffffea0006070000
16153 Nov 02 17:28:25 ct523c-2103 kernel: Slab 0xffffea0006070000 objects=10 used=4 fp=0xffff888181c03400 
flags=0x5fff8000000840(slab|head|node=0|zone=2|lastcpupid=0x3fff)
16154 Nov 02 17:28:25 ct523c-2103 kernel: slab-tracking-info: cache: kmalloc-1k (ffff88812004d900)
16155 Nov 02 17:28:25 ct523c-2103 kernel: Allocated in 0x5a5a5a5a5a5a5a5a age=11936128522577591372 cpu=1515870810 pid=1515870810
16156 Nov 02 17:28:25 ct523c-2103 kernel: ------------[ cut here ]------------
16157 Nov 02 17:28:25 ct523c-2103 kernel: pool index 23130 out of bounds (688) for stack id 5a5a5a5a
16158 Nov 02 17:28:25 ct523c-2103 kernel: WARNING: CPU: 1 PID: 104 at lib/stackdepot.c:484 stack_depot_print+0x54/0x60
16159 Nov 02 17:28:25 ct523c-2103 kernel: Modules linked in: vrf nf_conntrack_netlink nfnetlink nf_nat(-) nf_conntrack nf_defrag_ipv6 
nf_defrag_ipv4 bpfilter 8021q garp mrp stp llc macvlan pktgen rpcrdma rdma_cm iw_cm ib_cm ib_core qrtr f71882fg iTCO_wdt intel_pmc_bxt       intel_rapl_msr 
ee1004 iTCO_vendor_support snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_intel         snd_intel_dspcfg coretemp 
snd_hda_codec snd_hda_core intel_rapl_common intel_tcc_cooling snd_hwdep x86_pkg_temp_thermal                      intel_powerclamp snd_seq snd_seq_device 
snd_pcm kvm_intel snd_timer kvm irqbypass intel_wmi_thunderbolt pcspkr snd i2c_i801 soundcore        i2c_smbus iwlmvm mac80211 iwlwifi cfg80211 bfq mei_pxp 
mei_hdcp intel_pch_thermal tpm_crb tpm_tis tpm_tis_core tpm acpi_pad                  sch_fq_codel nfsd auth_rpcgss nfs_acl lockd grace fuse sunrpc zram raid1 
dm_raid raid456 libcrc32c async_raid6_recov async_memcpy            async_pq async_xor xor async_tx raid6_pq i915 drm_buddy intel_gtt drm_display_helper 
drm_kms_helper cec rc_core ttm igb i2c_algo_bit         drm ixgbe agpgart
16160 Nov 02 17:28:25 ct523c-2103 kernel:  mdio dca mei_wdt xhci_pci hwmon i2c_core xhci_pci_renesas video wmi [last unloaded: nf_nat]
16161 Nov 02 17:28:25 ct523c-2103 kernel: CPU: 1 PID: 104 Comm: kworker/1:10 Tainted: G        W          6.6.0-rc7+ #17
16162 Nov 02 17:28:25 ct523c-2103 kernel: Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/21/2023
16163 Nov 02 17:28:25 ct523c-2103 kernel: Workqueue: events kobject_delayed_cleanup
16164 Nov 02 17:28:25 ct523c-2103 kernel: RIP: 0010:stack_depot_print+0x54/0x60
16165 Nov 02 17:28:25 ct523c-2103 kernel: Code: 04 25 f0 3f 00 00 48 01 c2 8b 72 0c 48 8d 7a 18 85 f6 74 07 31 d2 e9 3b ca 78 ff c3 89 f9 48       c7 c7 40 8a 
32 83 e8 9c df 64 ff <0f> 0b c3 66 0f 1f 84 00 00 00 00 00 89 f8 49 89 f1 48 89 d6 8b 15
16166 Nov 02 17:28:25 ct523c-2103 kernel: RSP: 0018:ffff8881335a7ba8 EFLAGS: 00010286
16167 Nov 02 17:28:25 ct523c-2103 kernel: RAX: 0000000000000000 RBX: ffff88812004d900 RCX: 0000000000000027
16168 Nov 02 17:28:25 ct523c-2103 kernel: RDX: 0000000000000027 RSI: ffffffff81413a9e RDI: ffff88841bea87c8
16169 Nov 02 17:28:25 ct523c-2103 kernel: RBP: ffff888181c029a0 R08: 0000000000000001 R09: ffffed10837d50f9
16170 Nov 02 17:28:25 ct523c-2103 kernel: R10: ffff88841bea87cb R11: 00000000000edd70 R12: 00000000ffff96a6
16171 Nov 02 17:28:25 ct523c-2103 kernel: R13: ffff88813e0c1260 R14: ffffffff8269fe20 R15: ffff888181c029a0
16172 Nov 02 17:28:25 ct523c-2103 kernel: FS:  0000000000000000(0000) GS:ffff88841be80000(0000) knlGS:0000000000000000
16173 Nov 02 17:28:25 ct523c-2103 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
16174 Nov 02 17:28:25 ct523c-2103 kernel: CR2: 0000000001d68428 CR3: 0000000003696004 CR4: 00000000003706e0
16175 Nov 02 17:28:25 ct523c-2103 kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
16176 Nov 02 17:28:25 ct523c-2103 kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
16177 Nov 02 17:28:25 ct523c-2103 kernel: Call Trace:
16178 Nov 02 17:28:25 ct523c-2103 kernel:  <TASK>
16179 Nov 02 17:28:25 ct523c-2103 kernel:  ? __warn+0x9c/0x1f0
16180 Nov 02 17:28:25 ct523c-2103 kernel:  ? stack_depot_print+0x54/0x60
16181 Nov 02 17:28:25 ct523c-2103 kernel:  ? report_bug+0x1aa/0x1e0
16182 Nov 02 17:28:25 ct523c-2103 kernel:  ? handle_bug+0x41/0x80
16183 Nov 02 17:28:25 ct523c-2103 kernel:  ? exc_invalid_op+0x13/0x40
16184 Nov 02 17:28:25 ct523c-2103 kernel:  ? asm_exc_invalid_op+0x16/0x20
16185 Nov 02 17:28:25 ct523c-2103 kernel:  ? __kobject_del+0xc0/0xc0
16186 Nov 02 17:28:25 ct523c-2103 kernel:  ? irq_work_claim+0x1e/0x40
16187 Nov 02 17:28:25 ct523c-2103 kernel:  ? stack_depot_print+0x54/0x60
16188 Nov 02 17:28:25 ct523c-2103 kernel:  ? stack_depot_print+0x54/0x60
16189 Nov 02 17:28:25 ct523c-2103 kernel:  print_tracking+0x3b/0x80
16190 Nov 02 17:28:25 ct523c-2103 kernel:  slab_print_mem_info+0xb0/0x120
16191 Nov 02 17:28:25 ct523c-2103 kernel:  debug_print_object+0x117/0x170
16192 Nov 02 17:28:25 ct523c-2103 kernel:  debug_check_no_obj_freed+0x261/0x2b0
16193 Nov 02 17:28:25 ct523c-2103 kernel:  __kmem_cache_free+0x185/0x200
16194 Nov 02 17:28:25 ct523c-2103 kernel:  ? device_release+0x57/0x100
16195 Nov 02 17:28:25 ct523c-2103 kernel:  device_release+0x57/0x100
16196 Nov 02 17:28:25 ct523c-2103 kernel:  kobject_delayed_cleanup+0xdf/0x140
16197 Nov 02 17:28:25 ct523c-2103 kernel:  process_one_work+0x475/0x920
16198 Nov 02 17:28:25 ct523c-2103 kernel:  ? kick_pool+0x1b0/0x1b0
16199 Nov 02 17:28:25 ct523c-2103 kernel:  ? __list_add_valid_or_report+0x33/0xd0
16200 Nov 02 17:28:25 ct523c-2103 kernel:  worker_thread+0x38a/0x680
16201 Nov 02 17:28:25 ct523c-2103 kernel:  ? __kthread_parkme+0xc9/0xe0
16202 Nov 02 17:28:25 ct523c-2103 kernel:  ? create_worker+0x390/0x390
16203 Nov 02 17:28:25 ct523c-2103 kernel:  kthread+0x199/0x1e0
16204 Nov 02 17:28:25 ct523c-2103 kernel:  ? kthread+0xed/0x1e0
16205 Nov 02 17:28:25 ct523c-2103 kernel:  ? kthread_complete_and_exit+0x20/0x20
16206 Nov 02 17:28:25 ct523c-2103 kernel:  ret_from_fork+0x28/0x50
16207 Nov 02 17:28:25 ct523c-2103 kernel:  ? kthread_complete_and_exit+0x20/0x20
16208 Nov 02 17:28:25 ct523c-2103 kernel:  ret_from_fork_asm+0x11/0x20
16209 Nov 02 17:28:25 ct523c-2103 kernel:  </TASK>
16210 Nov 02 17:28:25 ct523c-2103 kernel: irq event stamp: 0
16211 Nov 02 17:28:25 ct523c-2103 kernel: hardirqs last  enabled at (0): [<0000000000000000>] 0x0
16212 Nov 02 17:28:25 ct523c-2103 kernel: hardirqs last disabled at (0): [<ffffffff811d8998>] copy_process+0xf68/0x32c0
16213 Nov 02 17:28:25 ct523c-2103 kernel: softirqs last  enabled at (0): [<ffffffff811d8998>] copy_process+0xf68/0x32c0
16214 Nov 02 17:28:25 ct523c-2103 kernel: softirqs last disabled at (0): [<0000000000000000>] 0x0
16215 Nov 02 17:28:25 ct523c-2103 kernel: ---[ end trace 0000000000000000 ]---
16216 Nov 02 17:28:25 ct523c-2103 kernel: Freed in 0x5a5a5a5a5a5a5a5a age=11936128522577591372 cpu=1515870810 pid=1515870810
16217 Nov 02 17:28:25 ct523c-2103 kernel: ------------[ cut here ]------------
16218 Nov 02 17:28:25 ct523c-2103 kernel: pool index 23130 out of bounds (688) for stack id 5a5a5a5a
16219 Nov 02 17:28:25 ct523c-2103 kernel: WARNING: CPU: 1 PID: 104 at lib/stackdepot.c:484 stack_depot_print+0x54/0x60
16220 Nov 02 17:28:25 ct523c-2103 kernel: Modules linked in: vrf nf_conntrack_netlink nfnetlink nf_nat(-) nf_conntrack nf_defrag_ipv6 
nf_defrag_ipv4 bpfilter 8021q garp mrp stp llc macvlan pktgen rpcrdma rdma_cm iw_cm ib_cm ib_core qrtr f71882fg iTCO_wdt intel_pmc_bxt       intel_rapl_msr 
ee1004 iTCO_vendor_support snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_intel         snd_intel_dspcfg coretemp 
snd_hda_codec snd_hda_core intel_rapl_common intel_tcc_cooling snd_hwdep x86_pkg_temp_thermal                      intel_powerclamp snd_seq snd_seq_device 
snd_pcm kvm_intel snd_timer kvm irqbypass intel_wmi_thunderbolt pcspkr snd i2c_i801 soundcore        i2c_smbus iwlmvm mac80211 iwlwifi cfg80211 bfq mei_pxp 
mei_hdcp intel_pch_thermal tpm_crb tpm_tis tpm_tis_core tpm acpi_pad                  sch_fq_codel nfsd auth_rpcgss nfs_acl lockd grace fuse sunrpc zram raid1 
dm_raid raid456 libcrc32c async_raid6_recov async_memcpy            async_pq async_xor xor async_tx raid6_pq i915 drm_buddy intel_gtt drm_display_helper 
drm_kms_helper cec rc_core ttm igb i2c_algo_bit         drm ixgbe agpgart
16221 Nov 02 17:28:25 ct523c-2103 kernel:  mdio dca mei_wdt xhci_pci hwmon i2c_core xhci_pci_renesas video wmi [last unloaded: nf_nat]
16222 Nov 02 17:28:25 ct523c-2103 kernel: CPU: 1 PID: 104 Comm: kworker/1:10 Tainted: G        W          6.6.0-rc7+ #17
16223 Nov 02 17:28:25 ct523c-2103 kernel: Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/21/2023
16224 Nov 02 17:28:25 ct523c-2103 kernel: Workqueue: events kobject_delayed_cleanup
16225 Nov 02 17:28:25 ct523c-2103 kernel: RIP: 0010:stack_depot_print+0x54/0x60
16226 Nov 02 17:28:25 ct523c-2103 kernel: Code: 04 25 f0 3f 00 00 48 01 c2 8b 72 0c 48 8d 7a 18 85 f6 74 07 31 d2 e9 3b ca 78 ff c3 89 f9 48       c7 c7 40 8a 
32 83 e8 9c df 64 ff <0f> 0b c3 66 0f 1f 84 00 00 00 00 00 89 f8 49 89 f1 48 89 d6 8b 15
16227 Nov 02 17:28:25 ct523c-2103 kernel: RSP: 0018:ffff8881335a7bc8 EFLAGS: 00010282
16228 Nov 02 17:28:25 ct523c-2103 kernel: RAX: 0000000000000000 RBX: ffffea0006070000 RCX: 0000000000000027
16229 Nov 02 17:28:25 ct523c-2103 kernel: RDX: 0000000000000027 RSI: ffffffff81413a9e RDI: ffff88841bea87c8
16230 Nov 02 17:28:25 ct523c-2103 kernel: RBP: ffff888181c029a0 R08: 0000000000000001 R09: ffffed10837d50f9
16231 Nov 02 17:28:25 ct523c-2103 kernel: R10: ffff88841bea87cb R11: 00000000000ef478 R12: ffffffff82c4a8c0
16232 Nov 02 17:28:25 ct523c-2103 kernel: R13: ffff88813e0c1260 R14: ffffffff8269fe20 R15: ffff888181c029a0
16233 Nov 02 17:28:25 ct523c-2103 kernel: FS:  0000000000000000(0000) GS:ffff88841be80000(0000) knlGS:0000000000000000
16234 Nov 02 17:28:25 ct523c-2103 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
16235 Nov 02 17:28:25 ct523c-2103 kernel: CR2: 0000000001d68428 CR3: 0000000003696004 CR4: 00000000003706e0
16236 Nov 02 17:28:25 ct523c-2103 kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
16237 Nov 02 17:28:25 ct523c-2103 kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
16238 Nov 02 17:28:25 ct523c-2103 kernel: Call Trace:
16239 Nov 02 17:28:25 ct523c-2103 kernel:  <TASK>
16240 Nov 02 17:28:25 ct523c-2103 kernel:  ? __warn+0x9c/0x1f0
16241 Nov 02 17:28:25 ct523c-2103 kernel:  ? stack_depot_print+0x54/0x60
16242 Nov 02 17:28:25 ct523c-2103 kernel:  ? report_bug+0x1aa/0x1e0
16243 Nov 02 17:28:25 ct523c-2103 kernel:  ? handle_bug+0x41/0x80
16244 Nov 02 17:28:25 ct523c-2103 kernel:  ? exc_invalid_op+0x13/0x40
16245 Nov 02 17:28:25 ct523c-2103 kernel:  ? asm_exc_invalid_op+0x16/0x20
16246 Nov 02 17:28:25 ct523c-2103 kernel:  ? __kobject_del+0xc0/0xc0
16247 Nov 02 17:28:25 ct523c-2103 kernel:  ? irq_work_claim+0x1e/0x40
16248 Nov 02 17:28:25 ct523c-2103 kernel:  ? stack_depot_print+0x54/0x60
16249 Nov 02 17:28:25 ct523c-2103 kernel:  ? stack_depot_print+0x54/0x60
16250 Nov 02 17:28:25 ct523c-2103 kernel:  slab_print_mem_info+0xb0/0x120
16251 Nov 02 17:28:25 ct523c-2103 kernel:  debug_print_object+0x117/0x170
16252 Nov 02 17:28:25 ct523c-2103 kernel:  debug_check_no_obj_freed+0x261/0x2b0
16253 Nov 02 17:28:25 ct523c-2103 kernel:  __kmem_cache_free+0x185/0x200
16254 Nov 02 17:28:25 ct523c-2103 kernel:  ? device_release+0x57/0x100
16255 Nov 02 17:28:25 ct523c-2103 kernel:  device_release+0x57/0x100
16256 Nov 02 17:28:25 ct523c-2103 kernel:  kobject_delayed_cleanup+0xdf/0x140
16257 Nov 02 17:28:25 ct523c-2103 kernel:  process_one_work+0x475/0x920
16258 Nov 02 17:28:25 ct523c-2103 kernel:  ? kick_pool+0x1b0/0x1b0
16259 Nov 02 17:28:25 ct523c-2103 kernel:  ? __list_add_valid_or_report+0x33/0xd0
16260 Nov 02 17:28:25 ct523c-2103 kernel:  worker_thread+0x38a/0x680
16261 Nov 02 17:28:25 ct523c-2103 kernel:  ? __kthread_parkme+0xc9/0xe0
16262 Nov 02 17:28:25 ct523c-2103 kernel:  ? create_worker+0x390/0x390
16263 Nov 02 17:28:25 ct523c-2103 kernel:  kthread+0x199/0x1e0
16264 Nov 02 17:28:25 ct523c-2103 kernel:  ? kthread+0xed/0x1e0
16265 Nov 02 17:28:25 ct523c-2103 kernel:  ? kthread_complete_and_exit+0x20/0x20
16266 Nov 02 17:28:25 ct523c-2103 kernel:  ret_from_fork+0x28/0x50
16267 Nov 02 17:28:25 ct523c-2103 kernel:  ? kthread_complete_and_exit+0x20/0x20
16268 Nov 02 17:28:25 ct523c-2103 kernel:  ret_from_fork_asm+0x11/0x20
16269 Nov 02 17:28:25 ct523c-2103 kernel:  </TASK>
16270 Nov 02 17:28:25 ct523c-2103 kernel: irq event stamp: 0
16271 Nov 02 17:28:25 ct523c-2103 kernel: hardirqs last  enabled at (0): [<0000000000000000>] 0x0
16272 Nov 02 17:28:25 ct523c-2103 kernel: hardirqs last disabled at (0): [<ffffffff811d8998>] copy_process+0xf68/0x32c0
16273 Nov 02 17:28:25 ct523c-2103 kernel: softirqs last  enabled at (0): [<ffffffff811d8998>] copy_process+0xf68/0x32c0
16274 Nov 02 17:28:25 ct523c-2103 kernel: softirqs last disabled at (0): [<0000000000000000>] 0x0
16275 Nov 02 17:28:25 ct523c-2103 kernel: ---[ end trace 0000000000000000 ]---
16276 Nov 02 17:28:25 ct523c-2103 kernel: end of slab-tracking-info
16277 Nov 02 17:28:25 ct523c-2103 kernel: kobject: 'pps2': free name


Thanks,
Ben

> 
> To try to improve this, store the backtrace of where the
> debug_obj was created and print that out when problems
> are found.
> 
> Also print out slub info for the object held by the
> debug_obj.  In my particular case, this was not super
> useful, appearantly because of all of the KASAN and other
> debugging I have enabled.  Still, might provide a few
> clues.
> 
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
>   include/linux/debugobjects.h |  5 +++++
>   include/linux/slab.h         | 11 +++++++++++
>   include/linux/slab_def.h     |  2 ++
>   lib/debugobjects.c           | 37 ++++++++++++++++++++++++++++++++++++
>   mm/slab.h                    |  4 ++--
>   mm/slub.c                    | 34 +++++++++++++++++++++++++++++----
>   6 files changed, 87 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/debugobjects.h b/include/linux/debugobjects.h
> index 32444686b6ff..8e8df719bd88 100644
> --- a/include/linux/debugobjects.h
> +++ b/include/linux/debugobjects.h
> @@ -31,6 +31,11 @@ struct debug_obj {
>   	unsigned int		astate;
>   	void			*object;
>   	const struct debug_obj_descr *descr;
> +#ifdef CONFIG_STACKDEPOT
> +#define DEBUG_OBJ_ADDRS_COUNT 16
> +	/* Including stackdepot.h blows up the build, so open-code the handle. */
> +	u64 trace_handle;
> +#endif
>   };
>   
>   /**
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 8228d1276a2f..87a5da669eaf 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -793,4 +793,15 @@ int slab_dead_cpu(unsigned int cpu);
>   #define slab_dead_cpu		NULL
>   #endif
>   
> +
> +/**
> + * Calling this on allocated memory will print debugging info
> + * about the object, if CONFIG_SLAB_DEBUG is enabled.
> + */
> +#ifdef CONFIG_SLUB_DEBUG
> +void slab_print_mem_info(const void *x);
> +#else
> +static inline void slab_print_mem_info(const void *x) { }
> +#endif
> +
>   #endif	/* _LINUX_SLAB_H */
> diff --git a/include/linux/slab_def.h b/include/linux/slab_def.h
> index a61e7d55d0d3..db3ce19be339 100644
> --- a/include/linux/slab_def.h
> +++ b/include/linux/slab_def.h
> @@ -121,4 +121,6 @@ static inline int objs_per_slab(const struct kmem_cache *cache,
>   	return cache->num;
>   }
>   
> +static inline void slab_print_mem_info(const void *x) { }
> +
>   #endif	/* _LINUX_SLAB_DEF_H */
> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
> index a517256a270b..1f458e473bc5 100644
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -17,6 +17,8 @@
>   #include <linux/hash.h>
>   #include <linux/kmemleak.h>
>   #include <linux/cpu.h>
> +#include <linux/slab.h>
> +#include <linux/stackdepot.h>
>   
>   #define ODEBUG_HASH_BITS	14
>   #define ODEBUG_HASH_SIZE	(1 << ODEBUG_HASH_BITS)
> @@ -216,6 +218,33 @@ static struct debug_obj *__alloc_object(struct hlist_head *list)
>   	return obj;
>   }
>   
> +#ifdef CONFIG_STACKDEPOT
> +static void debug_print_stack_info(struct debug_obj *object)
> +{
> +	if (object->trace_handle) {
> +		pr_err("debugobjects: debug_obj allocated at:\n");
> +		stack_depot_print(object->trace_handle);
> +		pr_err("end of stack dump\n");
> +	}
> +}
> +
> +static noinline depot_stack_handle_t set_track_prepare(void)
> +{
> +	depot_stack_handle_t trace_handle;
> +	unsigned long entries[DEBUG_OBJ_ADDRS_COUNT];
> +	unsigned int nr_entries;
> +
> +	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 3);
> +	trace_handle = stack_depot_save(entries, nr_entries, GFP_NOWAIT);
> +
> +	return trace_handle;
> +}
> +
> +#else
> +static void debug_print_stack_info(struct debug_obj *object) { }
> +static depot_stack_handle_t set_track_prepare(void) { }
> +#endif
> +
>   static struct debug_obj *
>   alloc_object(void *addr, struct debug_bucket *b, const struct debug_obj_descr *descr)
>   {
> @@ -272,6 +301,12 @@ alloc_object(void *addr, struct debug_bucket *b, const struct debug_obj_descr *d
>   		obj->state  = ODEBUG_STATE_NONE;
>   		obj->astate = 0;
>   		hlist_add_head(&obj->node, &b->list);
> +
> +		/* Save stack of where object was created */
> +#ifdef CONFIG_STACKDEPOT
> +		/* kernel backtrace */
> +		obj->trace_handle = set_track_prepare();
> +#endif
>   	}
>   	return obj;
>   }
> @@ -515,6 +550,8 @@ static void debug_print_object(struct debug_obj *obj, char *msg)
>   				 "object: %p object type: %s hint: %pS\n",
>   			msg, obj_states[obj->state], obj->astate,
>   			obj->object, descr->name, hint);
> +		debug_print_stack_info(obj);
> +		slab_print_mem_info(obj->object);
>   	}
>   	debug_objects_warnings++;
>   }
> diff --git a/mm/slab.h b/mm/slab.h
> index 799a315695c6..d977c093e90d 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -399,14 +399,14 @@ DECLARE_STATIC_KEY_TRUE(slub_debug_enabled);
>   #else
>   DECLARE_STATIC_KEY_FALSE(slub_debug_enabled);
>   #endif
> -extern void print_tracking(struct kmem_cache *s, void *object);
> +extern void print_tracking(struct kmem_cache *s, const void *object);
>   long validate_slab_cache(struct kmem_cache *s);
>   static inline bool __slub_debug_enabled(void)
>   {
>   	return static_branch_unlikely(&slub_debug_enabled);
>   }
>   #else
> -static inline void print_tracking(struct kmem_cache *s, void *object)
> +static inline void print_tracking(struct kmem_cache *s, const void *object)
>   {
>   }
>   static inline bool __slub_debug_enabled(void)
> diff --git a/mm/slub.c b/mm/slub.c
> index f7940048138c..7d0c648369ab 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -760,10 +760,10 @@ static inline unsigned int get_info_end(struct kmem_cache *s)
>   		return s->inuse;
>   }
>   
> -static struct track *get_track(struct kmem_cache *s, void *object,
> +static struct track *get_track(struct kmem_cache *s, const void *object,
>   	enum track_item alloc)
>   {
> -	struct track *p;
> +	const struct track *p;
>   
>   	p = object + get_info_end(s);
>   
> @@ -841,11 +841,14 @@ static void print_track(const char *s, struct track *t, unsigned long pr_time)
>   #endif
>   }
>   
> -void print_tracking(struct kmem_cache *s, void *object)
> +void print_tracking(struct kmem_cache *s, const void *object)
>   {
>   	unsigned long pr_time = jiffies;
> -	if (!(s->flags & SLAB_STORE_USER))
> +	if (!(s->flags & SLAB_STORE_USER)) {
> +		pr_err("slub-print-tracking, STORE-USER not enabled, cache: %s flags: 0x%x\n",
> +		       s->name, s->flags);
>   		return;
> +	}
>   
>   	print_track("Allocated", get_track(s, object, TRACK_ALLOC), pr_time);
>   	print_track("Freed", get_track(s, object, TRACK_FREE), pr_time);
> @@ -1712,6 +1715,29 @@ slab_flags_t kmem_cache_flags(unsigned int object_size,
>   
>   	return flags | slub_debug_local;
>   }
> +
> +void slab_print_mem_info(const void *x)
> +{
> +	struct slab *slab;
> +
> +	if (unlikely(ZERO_OR_NULL_PTR(x)))
> +		return;
> +
> +	slab = virt_to_slab(x);
> +	if (!slab) {
> +		pr_err("slub-print-mem-info, could not find slab for virt addr: %p\n",
> +		       x);
> +		return;
> +	}
> +
> +	pr_err("slab-info, slab: %p\n", slab);
> +	print_slab_info(slab);
> +	pr_err("slab-tracking-info: cache: %s (%p)\n",
> +	       slab->slab_cache->name, slab->slab_cache);
> +	print_tracking(slab->slab_cache, x);
> +	pr_err("end of slab-tracking-info\n");
> +}
> +
>   #else /* !CONFIG_SLUB_DEBUG */
>   static inline void setup_object_debug(struct kmem_cache *s, void *object) {}
>   static inline
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
