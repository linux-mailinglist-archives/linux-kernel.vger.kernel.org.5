Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58ACA7DD83C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 23:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344904AbjJaW02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 18:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344905AbjJaW01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 18:26:27 -0400
X-Greylist: delayed 491 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 31 Oct 2023 15:26:24 PDT
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06183101
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 15:26:23 -0700 (PDT)
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
        by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id B84FE3006C4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 22:18:12 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 756BF8006A
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 22:18:10 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id ECAA713C2B0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 15:18:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com ECAA713C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1698790690;
        bh=MCx8uNDeBS3ISkNQCVyt9JoQgSCBguHd4uGmTGYR9uA=;
        h=Date:To:From:Subject:From;
        b=rTSJCAYU1UfYDNa8LlUaAQFjDLSkJfqfAmTP2zmp9M2UarfBBqDslvFO+o2cVhcW8
         10NyOwdZ195lDU8mEZjUNB9zclO0tyBrAVXpKFVBk4ZRlRI3J3oJleb7z5GRTjgJtT
         joOHhojWRFoSAwLIBvKjdy0QDU8WtG4gAdCh3Vyg=
Message-ID: <d94cd6aa-ab04-8d34-e1e7-9c7aae7f81e7@candelatech.com>
Date:   Tue, 31 Oct 2023 15:18:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     LKML <linux-kernel@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: wireless-next tree: ODEBUG: free active, object type timer_list
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1698790691-t42gQzffXN_O
X-MDID-O: us5;at1;1698790691;t42gQzffXN_O;<greearb@candelatech.com>;c71d53d8b4bf163c84f4470b0e4d7294
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

In an attempt to debug various crashes I've been seeing while testing on wireless-next (based on 6.6.0-rc5, plus hacks),
I enabled all of the useful looking debug options that I could find.

While looking through logs, I see this below.  Any idea on how to debug this further?  It looks
like just generic code to me...

16876 Oct 31 15:05:08 ct523c-2103 kernel: ODEBUG: free active (active state 0) object: ffff888158c465a0 object type: timer_list hint: 
kobject_delayed_cleanup+0x0/0x140
16877 Oct 31 15:05:08 ct523c-2103 kernel: WARNING: CPU: 5 PID: 80 at lib/debugobjects.c:514 debug_print_object+0xdf/0x110
16878 Oct 31 15:05:08 ct523c-2103 kernel: Modules linked in: vrf nf_conntrack_netlink nfnetlink iptable_nat(-) nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 
bpfilter 8021q garp mrp stp llc              macvlan pktgen rpcrdma rdma_cm iw_cm ib_cm ib_core qrtr f71882fg snd_hda_codec_hdmi snd_hda_codec_realtek 
intel_rapl_msr snd_hda_codec_generic ledtrig_audio iTCO_wdt intel_pmc_bxt ee1004              iTCO_vendor_support coretemp intel_rapl_common snd_hda_intel 
snd_intel_dspcfg snd_hda_codec intel_tcc_cooling x86_pkg_temp_thermal intel_powerclamp snd_hda_core snd_hwdep snd_seq snd_seq_device       kvm_intel snd_pcm kvm 
intel_wmi_thunderbolt irqbypass snd_timer snd pcspkr i2c_i801 soundcore iwlmvm i2c_smbus mac80211 iwlwifi cfg80211 bfq mei_hdcp mei_pxp intel_pch_thermal 
tpm_crb tpm_tis         tpm_tis_core tpm acpi_pad sch_fq_codel nfsd auth_rpcgss nfs_acl lockd grace fuse sunrpc zram raid1 dm_raid raid456 libcrc32c 
async_raid6_recov async_memcpy async_pq async_xor xor async_tx             raid6_pq i915 drm_buddy intel_gtt drm_display_helper drm_kms_helper cec rc_core ttm 
igb i2c_algo_bit drm
16879 Oct 31 15:05:08 ct523c-2103 kernel:  agpgart mei_wdt xhci_pci ixgbe mdio xhci_pci_renesas dca i2c_core hwmon video wmi [last unloaded: iptable_nat]
16880 Oct 31 15:05:08 ct523c-2103 kernel: CPU: 5 PID: 80 Comm: kworker/5:1 Tainted: G        W          6.6.0-rc5+ #8
16881 Oct 31 15:05:08 ct523c-2103 kernel: Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/21/2023
16882 Oct 31 15:05:08 ct523c-2103 kernel: Workqueue: events kobject_delayed_cleanup
16883 Oct 31 15:05:08 ct523c-2103 kernel: RIP: 0010:debug_print_object+0xdf/0x110
16884 Oct 31 15:05:08 ct523c-2103 kernel: Code: a0 ab c4 82 e8 b2 6d b7 ff 4d 89 f9 4d 89 f0 89 e9 41 55 48 8b 14 dd a0 ab c4 82 4c 89 e6 48 c7 c7 00 9f c4 82 
e8 21 0b 75 ff <0f> 0b 58 5b 83 05 82 8d       49 02 01 5d 41 5c 41 5d 41 5e 41 5f c3 c3
16885 Oct 31 15:05:08 ct523c-2103 kernel: RSP: 0000:ffff8881131f7bf0 EFLAGS: 00010286
16886 Oct 31 15:05:08 ct523c-2103 kernel: RAX: 0000000000000000 RBX: 0000000000000003 RCX: ffffffff81343598
16887 Oct 31 15:05:08 ct523c-2103 kernel: RDX: 1ffff110838158a4 RSI: 0000000000000008 RDI: ffff88841c0ac520
16888 Oct 31 15:05:08 ct523c-2103 kernel: RBP: 0000000000000000 R08: 0000000000000001 R09: ffffed102263ef43
16889 Oct 31 15:05:08 ct523c-2103 kernel: R10: ffff8881131f7a1f R11: 00000000000fa8d0 R12: ffffffff82c4a560
16890 Oct 31 15:05:08 ct523c-2103 kernel: R13: ffffffff82696e20 R14: ffff888158c465a0 R15: ffffffff82ac32a0
16891 Oct 31 15:05:08 ct523c-2103 kernel: FS:  0000000000000000(0000) GS:ffff88841c080000(0000) knlGS:0000000000000000
16892 Oct 31 15:05:08 ct523c-2103 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
16893 Oct 31 15:05:08 ct523c-2103 kernel: CR2: 00007fe266cb2000 CR3: 0000000003696004 CR4: 00000000003706e0
16894 Oct 31 15:05:08 ct523c-2103 kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
16895 Oct 31 15:05:08 ct523c-2103 kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
16896 Oct 31 15:05:08 ct523c-2103 kernel: Call Trace:
16897 Oct 31 15:05:08 ct523c-2103 kernel:  <TASK>
16898 Oct 31 15:05:08 ct523c-2103 kernel:  ? __warn+0x9c/0x1f0
16899 Oct 31 15:05:08 ct523c-2103 kernel:  ? debug_print_object+0xdf/0x110
16900 Oct 31 15:05:08 ct523c-2103 kernel:  ? report_bug+0x1aa/0x1e0
16901 Oct 31 15:05:08 ct523c-2103 kernel:  ? handle_bug+0x41/0x80
16902 Oct 31 15:05:08 ct523c-2103 kernel:  ? exc_invalid_op+0x13/0x40
16903 Oct 31 15:05:08 ct523c-2103 kernel:  ? asm_exc_invalid_op+0x16/0x20
16904 Oct 31 15:05:08 ct523c-2103 kernel:  ? __kobject_del+0xc0/0xc0
16905 Oct 31 15:05:08 ct523c-2103 kernel:  ? tick_nohz_tick_stopped+0x18/0x30
16906 Oct 31 15:05:08 ct523c-2103 kernel:  ? debug_print_object+0xdf/0x110
16907 Oct 31 15:05:08 ct523c-2103 kernel:  ? __kobject_del+0xc0/0xc0
16908 Oct 31 15:05:08 ct523c-2103 kernel:  debug_check_no_obj_freed+0x261/0x2b0
16909 Oct 31 15:05:08 ct523c-2103 kernel:  __kmem_cache_free+0x185/0x200
16910 Oct 31 15:05:08 ct523c-2103 kernel:  ? device_release+0x57/0x100
16911 Oct 31 15:05:08 ct523c-2103 kernel:  device_release+0x57/0x100
16912 Oct 31 15:05:08 ct523c-2103 kernel:  kobject_delayed_cleanup+0xdf/0x140
16913 Oct 31 15:05:08 ct523c-2103 kernel:  process_one_work+0x475/0x920
16914 Oct 31 15:05:08 ct523c-2103 kernel:  ? kick_pool+0x1b0/0x1b0
16915 Oct 31 15:05:08 ct523c-2103 kernel:  ? __list_add_valid_or_report+0x33/0xd0
16916 Oct 31 15:05:08 ct523c-2103 kernel:  worker_thread+0x38a/0x680
16917 Oct 31 15:05:08 ct523c-2103 kernel:  ? __kthread_parkme+0xc9/0xe0
16918 Oct 31 15:05:08 ct523c-2103 kernel:  ? create_worker+0x380/0x380
16919 Oct 31 15:05:08 ct523c-2103 kernel:  kthread+0x199/0x1e0
16920 Oct 31 15:05:08 ct523c-2103 kernel:  ? kthread+0xed/0x1e0
16921 Oct 31 15:05:08 ct523c-2103 kernel:  ? kthread_complete_and_exit+0x20/0x20
16922 Oct 31 15:05:08 ct523c-2103 kernel:  ret_from_fork+0x28/0x50
16923 Oct 31 15:05:08 ct523c-2103 kernel:  ? kthread_complete_and_exit+0x20/0x20
16924 Oct 31 15:05:08 ct523c-2103 kernel:  ret_from_fork_asm+0x11/0x20
16925 Oct 31 15:05:08 ct523c-2103 kernel:  </TASK>
16926 Oct 31 15:05:08 ct523c-2103 kernel: irq event stamp: 33601
16927 Oct 31 15:05:08 ct523c-2103 kernel: hardirqs last  enabled at (33607): [<ffffffff812c876d>] console_unlock+0x15d/0x170
16928 Oct 31 15:05:08 ct523c-2103 kernel: hardirqs last disabled at (33612): [<ffffffff812c8752>] console_unlock+0x142/0x170
16929 Oct 31 15:05:08 ct523c-2103 kernel: softirqs last  enabled at (33112): [<ffffffff811ea631>] __irq_exit_rcu+0x81/0xa0
16930 Oct 31 15:05:08 ct523c-2103 kernel: softirqs last disabled at (33107): [<ffffffff811ea631>] __irq_exit_rcu+0x81/0xa0
16931 Oct 31 15:05:08 ct523c-2103 kernel: ---[ end trace 0000000000000000 ]---
16932 Oct 31 15:05:08 ct523c-2103 kernel: kobject: 'pps2': free name

Thanks,
Ben
-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

