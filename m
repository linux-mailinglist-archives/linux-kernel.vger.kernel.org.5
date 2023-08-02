Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242AA76CBBE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbjHBLZj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 2 Aug 2023 07:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbjHBLZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:25:37 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F521FED
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 04:25:33 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qR9ys-0003FX-Or; Wed, 02 Aug 2023 13:25:30 +0200
Message-ID: <32c3d93c-c320-0f88-87db-003f51bfc039@leemhuis.info>
Date:   Wed, 2 Aug 2023 13:25:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: Kernel memory management bug at mm/migrate.c:662 when
 flushing caches
Content-Language: en-US, de-DE
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Alistair Popple <apopple@nvidia.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco <rodomar705@protonmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Regressions <regressions@lists.linux.dev>
References: <428d8fe9-8c19-ddba-b36e-7db5524e8d04@gmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <428d8fe9-8c19-ddba-b36e-7db5524e8d04@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1690975533;0d21b54a;
X-HE-SMSGID: 1qR9ys-0003FX-Or
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.08.23 13:08, Bagas Sanjaya wrote:
> 
> I notice a regression report on Bugzilla [1]. Quoting from it:
> 
>> I hit this kernel bug on the latest 6.3.9 kernel after executing this script to cleanup hugepages from the kernel before booting up a Windows 11 VM with QEMU (otherwise I don't have enough contiguous memory to allocate the pages to the VM)
>>
>> snip
>> if [[ $VM_ACTION == 'prepare' ]];
>> then
>>     sync
>>     echo 3 > /proc/sys/vm/drop_caches
>>     echo 1 > /proc/sys/vm/compact_memory
>> endsnip
>>
>> Attached is the full QEMU script that I used. I do use ZFS as a root filesystem, as you can see from the loaded modules.

Bagas, FWIW, I'd totally understand if developers will ignore this
(remains to be seen if that is the case, maybe we are lucky and somebody
will take a look), as I think you for now shouldn't have forwarded this
for two reasons:

* 6.3.y is old and EOL; testing mainline or at least a fresh 6.4.y
kernel) would have been a must here.
* with out-of-tree modules like ZFS anything can happen, the user is own
its own.

As I can see from the bug both things will likely clear up soon, hence
waiting would have been wise here.

Please in the future do not forward such bugs, as developers might
otherwise start to ignore mails wrt to regression tracking -- which we
really need to avoid, as that will make things a lot harder.

Ciao, Thorsten

>> Ever seen something similar? On first bootup this is fine, it works fine. Any subsequent call cause to kill the script with the error below.
>>
>> [ 2682.534320] bash (54689): drop_caches: 3
>> [ 2682.624207] ------------[ cut here ]------------
>> [ 2682.624211] kernel BUG at mm/migrate.c:662!
>> [ 2682.624219] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
>> [ 2682.624223] CPU: 2 PID: 54689 Comm: bash Tainted: P           OE      6.3.9-arch1-1 #1 124dc55df4f5272ccb409f39ef4872fc2b3376a2
>> [ 2682.624226] Hardware name: System manufacturer System Product Name/ROG STRIX B450-F GAMING, BIOS 5102 05/31/2023
>> [ 2682.624228] RIP: 0010:migrate_folio_extra+0x6c/0x70
>> [ 2682.624234] Code: de 48 89 ef e8 35 e2 ff ff 5b 44 89 e0 5d 41 5c 41 5d e9 e7 6d 9d 00 e8 22 e2 ff ff 44 89 e0 5b 5d 41 5c 41 5d e9 d4 6d 9d 00 <0f> 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f
>> [ 2682.624236] RSP: 0018:ffffb4685b5038f8 EFLAGS: 00010282
>> [ 2682.624238] RAX: 02ffff0000008025 RBX: ffffd9f684f02740 RCX: 0000000000000002
>> [ 2682.624240] RDX: ffffd9f684f02740 RSI: ffffd9f68d958dc0 RDI: ffff99d8d1cfe728
>> [ 2682.624241] RBP: ffff99d8d1cfe728 R08: 0000000000000000 R09: 0000000000000000
>> [ 2682.624242] R10: ffffd9f68d958dc8 R11: 0000000004020000 R12: ffffd9f68d958dc0
>> [ 2682.624243] R13: 0000000000000002 R14: ffffd9f684f02740 R15: ffffb4685b5039b8
>> [ 2682.624245] FS:  00007f78b8182740(0000) GS:ffff99de9ea80000(0000) knlGS:0000000000000000
>> [ 2682.624246] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [ 2682.624248] CR2: 00007fe9a0001960 CR3: 000000011e406000 CR4: 00000000003506e0
>> [ 2682.624249] Call Trace:
>> [ 2682.624251]  <TASK>
>> [ 2682.624253]  ? die+0x36/0x90
>> [ 2682.624258]  ? do_trap+0xda/0x100
>> [ 2682.624261]  ? migrate_folio_extra+0x6c/0x70
>> [ 2682.624263]  ? do_error_trap+0x6a/0x90
>> [ 2682.624266]  ? migrate_folio_extra+0x6c/0x70
>> [ 2682.624268]  ? exc_invalid_op+0x50/0x70
>> [ 2682.624271]  ? migrate_folio_extra+0x6c/0x70
>> [ 2682.624273]  ? asm_exc_invalid_op+0x1a/0x20
>> [ 2682.624278]  ? migrate_folio_extra+0x6c/0x70
>> [ 2682.624280]  move_to_new_folio+0x136/0x150
>> [ 2682.624283]  migrate_pages_batch+0x913/0xd30
>> [ 2682.624285]  ? __pfx_compaction_free+0x10/0x10
>> [ 2682.624289]  ? __pfx_remove_migration_pte+0x10/0x10
>> [ 2682.624292]  migrate_pages+0xc61/0xde0
>> [ 2682.624295]  ? __pfx_compaction_alloc+0x10/0x10
>> [ 2682.624296]  ? __pfx_compaction_free+0x10/0x10
>> [ 2682.624300]  compact_zone+0x865/0xda0
>> [ 2682.624303]  compact_node+0x88/0xc0
>> [ 2682.624306]  sysctl_compaction_handler+0x46/0x80
>> [ 2682.624308]  proc_sys_call_handler+0x1bd/0x2e0
>> [ 2682.624312]  vfs_write+0x239/0x3f0
>> [ 2682.624316]  ksys_write+0x6f/0xf0
>> [ 2682.624317]  do_syscall_64+0x60/0x90
>> [ 2682.624322]  ? syscall_exit_to_user_mode+0x1b/0x40
>> [ 2682.624324]  ? do_syscall_64+0x6c/0x90
>> [ 2682.624327]  ? syscall_exit_to_user_mode+0x1b/0x40
>> [ 2682.624329]  ? exc_page_fault+0x7c/0x180
>> [ 2682.624330]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
>> [ 2682.624333] RIP: 0033:0x7f78b82f5bc4
>> [ 2682.624355] Code: 15 99 11 0e 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 80 3d 3d 99 0e 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 48 83 ec 28 48 89 54 24 18 48
>> [ 2682.624356] RSP: 002b:00007ffd9d25ed18 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
>> [ 2682.624358] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f78b82f5bc4
>> [ 2682.624359] RDX: 0000000000000002 RSI: 000055c97c5f05c0 RDI: 0000000000000001
>> [ 2682.624360] RBP: 000055c97c5f05c0 R08: 0000000000000073 R09: 0000000000000001
>> [ 2682.624362] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000002
>> [ 2682.624363] R13: 00007f78b83d86a0 R14: 0000000000000002 R15: 00007f78b83d3ca0
>> [ 2682.624365]  </TASK>
>> [ 2682.624366] Modules linked in: vhost_net vhost vhost_iotlb tap tun snd_seq_dummy snd_hrtimer snd_seq xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp ip6table_mangle ip6table_nat ip6table_filter ip6_tables iptable_mangle iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c iptable_filter bridge stp llc intel_rapl_msr intel_rapl_common edac_mce_amd kvm_amd snd_hda_codec_realtek snd_hda_codec_generic kvm snd_hda_codec_hdmi snd_usb_audio btusb btrtl snd_hda_intel btbcm snd_intel_dspcfg crct10dif_pclmul btintel crc32_pclmul snd_intel_sdw_acpi btmtk vfat polyval_clmulni snd_usbmidi_lib polyval_generic fat snd_hda_codec ext4 gf128mul snd_rawmidi eeepc_wmi bluetooth ghash_clmulni_intel snd_hda_core sha512_ssse3 asus_wmi snd_seq_device aesni_intel mc ledtrig_audio snd_hwdep crc32c_generic crypto_simd snd_pcm sparse_keymap crc32c_intel igb ecdh_generic platform_profile sp5100_tco cryptd snd_timer mbcache rapl rfkill wmi_bmof pcspkr dca asus_wmi_sensors snd i2c_piix4 zenpower(OE) ccp
>> [ 2682.624417]  jbd2 crc16 soundcore gpio_amdpt gpio_generic mousedev acpi_cpufreq joydev mac_hid dm_multipath i2c_dev crypto_user loop fuse dm_mod bpf_preload ip_tables x_tables usbhid zfs(POE) zunicode(POE) zzstd(OE) zlua(OE) zavl(POE) icp(POE) zcommon(POE) znvpair(POE) spl(OE) nouveau nvme nvme_core xhci_pci nvme_common xhci_pci_renesas vfio_pci vfio_pci_core irqbypass vfio_iommu_type1 vfio iommufd amdgpu i2c_algo_bit drm_ttm_helper ttm mxm_wmi video wmi drm_buddy gpu_sched drm_display_helper cec
>> [ 2682.624456] ---[ end trace 0000000000000000 ]---
>> [ 2682.624457] RIP: 0010:migrate_folio_extra+0x6c/0x70
>> [ 2682.624461] Code: de 48 89 ef e8 35 e2 ff ff 5b 44 89 e0 5d 41 5c 41 5d e9 e7 6d 9d 00 e8 22 e2 ff ff 44 89 e0 5b 5d 41 5c 41 5d e9 d4 6d 9d 00 <0f> 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f
>> [ 2682.624463] RSP: 0018:ffffb4685b5038f8 EFLAGS: 00010282
>> [ 2682.624465] RAX: 02ffff0000008025 RBX: ffffd9f684f02740 RCX: 0000000000000002
>> [ 2682.624466] RDX: ffffd9f684f02740 RSI: ffffd9f68d958dc0 RDI: ffff99d8d1cfe728
>> [ 2682.624467] RBP: ffff99d8d1cfe728 R08: 0000000000000000 R09: 0000000000000000
>> [ 2682.624469] R10: ffffd9f68d958dc8 R11: 0000000004020000 R12: ffffd9f68d958dc0
>> [ 2682.624470] R13: 0000000000000002 R14: ffffd9f684f02740 R15: ffffb4685b5039b8
>> [ 2682.624472] FS:  00007f78b8182740(0000) GS:ffff99de9ea80000(0000) knlGS:0000000000000000
>> [ 2682.624473] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [ 2682.624475] CR2: 00007fe9a0001960 CR3: 000000011e406000 CR4: 00000000003506e0
> 
> See Bugzilla for the full thread and attached QEMU hook script to
> reproduce this regression.
> 
> Anyway, I'm adding it to regzbot:
> 
> #regzbot introduced: v6.2..v6.3 https://bugzilla.kernel.org/show_bug.cgi?id=217747
> #regzbot title: kernel memory bug when cleaning hugepages before QEMU boot
> 
> Thanks.
> 
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217747
> 
