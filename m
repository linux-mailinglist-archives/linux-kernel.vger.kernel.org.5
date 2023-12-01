Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D1D800135
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 02:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjLABrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 20:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjLABrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 20:47:42 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AF210F8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 17:47:46 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-54bf9a54fe3so1902274a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 17:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quora.org; s=google; t=1701395264; x=1702000064; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U3HR5X5vF0aKqgSP9mL/Ey54FJixI2TYNBnr1Kpa3lA=;
        b=jZ81U65kaOD0/3rQYu2vWPFxrVDVRjHJkc7k+GZbCTmv+KxXL5t4qU8SnjJrtR6+g+
         5k7+v3wQSmT0ZErYDQYJF2lXOHnH5vhq9pJ9VjLsoqs1Z1XaVqRVPwgJiPIllEMIr5Le
         0ATgBP+jBgZ7vjaju7C7tj7Jxpr6s7Eh3qXLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701395264; x=1702000064;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U3HR5X5vF0aKqgSP9mL/Ey54FJixI2TYNBnr1Kpa3lA=;
        b=UwwwfXHouutg6imHcNHMOwqFxm++NUVOr8HFiXqVkerI2ihxS9vzO5Bf/ogepsewl/
         E+zmiYBstgU7ph0/qx9KiOEM8mbFZEHx6p5ZSiH2g1HV7bXqkAOu25nzLBXlkBZVH5A3
         kqyAJVDeS/l2S5DQ0Fpi8yOWjio5W7+izaLClR4vcMoJOZgXR3/cALUarMKF/ua9C3LN
         AAkBbTIaxIT0WbsJXvOD/C2mqbGD6eCmkmBbN6/r9peQRw3sDmRXb8E6B63oZ5xFHuO6
         t5Eok8OlvMxnn/6HyqMTKa1yt/S9+LrPRmuwtrlD48OmQjOfHB6zAM0UROZS4EzqBZqI
         a1Pg==
X-Gm-Message-State: AOJu0YynsWlTTiTpfkrV5G6prlGDbH2Nyg0PCuMEPEXXg6hBZ89+MSlX
        XvilWuGWjYMoqcgEvkoP1XTDcZAo9zx8pT3YIGV5QA==
X-Google-Smtp-Source: AGHT+IFMjk3Jru4kwTyK0YO1wJLUrubA8qLhV6nWZbxfqk5xSfQaaYxT3uRNss6ItJ2sCUSdxVgBD8hsRcioCBGR05Y=
X-Received: by 2002:a17:906:d4:b0:a19:a1ba:8cbb with SMTP id
 20-20020a17090600d400b00a19a1ba8cbbmr213556eji.89.1701395264644; Thu, 30 Nov
 2023 17:47:44 -0800 (PST)
MIME-Version: 1.0
From:   Daniel J Blueman <daniel@quora.org>
Date:   Thu, 30 Nov 2023 20:47:33 -0500
Message-ID: <CAMVG2stxMYZbDoAHeVQjgJ7f+Td7+VJrLNRbY8au68ZVkzhb0g@mail.gmail.com>
Subject: bcachefs page fault oops after device evacuate/remove and unmount
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-bcachefs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kent et al,

On upstream bcachefs (master @ evilpiepirate.org/git/bcachefs.git) SHA
f8a1ba26, I was able to develop a minimal reproducer [1] for a page
not present oops I can provoke [2]. It appears we need further
synchronisation during unmount.

Let me know when there is a patch I can test, or for debug.

Thanks,
  Dan

-- [1]

modprobe brd rd_size=536870912 rd_nr=2
bcachefs format -f /dev/ram0 /dev/ram1
mount -t bcachefs /dev/ram0:/dev/ram1 /mnt
fio --group_reporting --ioengine=io_uring --directory=/mnt --size=16m
--time_based --runtime=60s --iodepth=256 --verify_async=8 --bs=4k-64k
--norandommap --random_distribution=zipf:0.5 --numjobs=16 --rw=randrw
--name=A --direct=1 --name=B --direct=0 >/dev/null &
bcachefs device evacuate /dev/ram0
bcachefs device remove --force --force-metadata /dev/ram1
bcachefs device remove --force --force-metadata /dev/ram1
kill %1
wait
umount /mnt

-- [2]

BUG: kernel NULL pointer dereference, address: 0000000000000020
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 38 PID: 1778 Comm: umount Not tainted 6.7.0-rc2 #7
Hardware name: Supermicro AS -3014TS-i/H12SSL-i, BIOS 2.5 09/08/2022
RIP: 0010:bch2_journal_space_available
(fs/bcachefs/journal_reclaim.c:190 (discriminator 1))
Code: f1 74 2d 4d 8b 97 a8 06 00 00 eb 15 8d 46 01 31 d2 f7 f7 41 89
97 bc 06 00 00 89 d6 44 39 ca 74 0f 89 f0 48 8b 8b d0 04 00 00 <49> 39
0c c2 72 dc 41 8b 97 b8 06 00 00 39 f2 74 49 4d 8b 8f a8 06
All code
========
   0:    f1                       int1
   1:    74 2d                    je     0x30
   3:    4d 8b 97 a8 06 00 00     mov    0x6a8(%r15),%r10
   a:    eb 15                    jmp    0x21
   c:    8d 46 01                 lea    0x1(%rsi),%eax
   f:    31 d2                    xor    %edx,%edx
  11:    f7 f7                    div    %edi
  13:    41 89 97 bc 06 00 00     mov    %edx,0x6bc(%r15)
  1a:    89 d6                    mov    %edx,%esi
  1c:    44 39 ca                 cmp    %r9d,%edx
  1f:    74 0f                    je     0x30
  21:    89 f0                    mov    %esi,%eax
  23:    48 8b 8b d0 04 00 00     mov    0x4d0(%rbx),%rcx
  2a:*    49 39 0c c2              cmp    %rcx,(%r10,%rax,8)
<-- trapping instruction
  2e:    72 dc                    jb     0xc
  30:    41 8b 97 b8 06 00 00     mov    0x6b8(%r15),%edx
  37:    39 f2                    cmp    %esi,%edx
  39:    74 49                    je     0x84
  3b:    4d                       rex.WRB
  3c:    8b                       .byte 0x8b
  3d:    8f                       .byte 0x8f
  3e:    a8 06                    test   $0x6,%al

Code starting with the faulting instruction
===========================================
   0:    49 39 0c c2              cmp    %rcx,(%r10,%rax,8)
   4:    72 dc                    jb     0xffffffffffffffe2
   6:    41 8b 97 b8 06 00 00     mov    0x6b8(%r15),%edx
   d:    39 f2                    cmp    %esi,%edx
   f:    74 49                    je     0x5a
  11:    4d                       rex.WRB
  12:    8b                       .byte 0x8b
  13:    8f                       .byte 0x8f
  14:    a8 06                    test   $0x6,%al
RSP: 0018:ffffc90020f63be0 EFLAGS: 00010202
RAX: 0000000000000004 RBX: ffff8881532c9dc0 RCX: 0000000000000013
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000002000
RBP: ffffc90020f63c10 R08: 0000000000000000 R09: 0000000000000008
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888153284400
R13: ffff888153280268 R14: 0000000000000001 R15: ffff88811668c000
FS: 00007f1a40c1c800(0000) GS:ffff88bf4eb00000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000020 CR3: 00000001533de001 CR4: 0000000000770ef0
PKRU: 55555554
Call Trace:
<TASK>
? show_regs (arch/x86/kernel/dumpstack.c:479)
? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434)
? page_fault_oops (arch/x86/mm/fault.c:707)
? lock_acquire (kernel/locking/lockdep.c:467 (discriminator 4)
kernel/locking/lockdep.c:5755 (discriminator 4)
kernel/locking/lockdep.c:5718 (discriminator 4))
? do_user_addr_fault (arch/x86/mm/fault.c:1264)
? exc_page_fault (./arch/x86/include/asm/paravirt.h:689
./arch/x86/include/asm/irqflags.h:127 arch/x86/mm/fault.c:1513
arch/x86/mm/fault.c:1561)
? asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:570)
? bch2_journal_space_available (fs/bcachefs/journal_reclaim.c:190
(discriminator 1))
bch2_journal_reclaim_fast (fs/bcachefs/journal_reclaim.c:313)
bch2_journal_pin_drop (./include/linux/spinlock.h:391
fs/bcachefs/journal_reclaim.c:360)
bch2_btree_complete_write (fs/bcachefs/btree_io.c:1724)
bch2_fs_btree_cache_exit (fs/bcachefs/btree_cache.c:428 (discriminator 1))
bch2_fs_release (fs/bcachefs/super.c:523 fs/bcachefs/super.c:567)
kobject_put (lib/kobject.c:689 lib/kobject.c:716
./include/linux/kref.h:65 lib/kobject.c:733)
bch2_fs_free (fs/bcachefs/super.c:633)
bch2_kill_sb (fs/bcachefs/fs.c:1934)
deactivate_locked_super (fs/super.c:486)
deactivate_super (fs/super.c:519)
cleanup_mnt (fs/namespace.c:139 fs/namespace.c:1257)
__cleanup_mnt (fs/namespace.c:1264)
task_work_run (kernel/task_work.c:182)
exit_to_user_mode_prepare (./include/linux/resume_user_mode.h:49
kernel/entry/common.c:171 kernel/entry/common.c:204)
syscall_exit_to_user_mode (kernel/entry/common.c:130 kernel/entry/common.c:298)
do_syscall_64 (./arch/x86/include/asm/cpufeature.h:171
arch/x86/entry/common.c:97)
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:181)
? do_syscall_64 (./arch/x86/include/asm/cpufeature.h:171
arch/x86/entry/common.c:97)
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:181)
? do_syscall_64 (./arch/x86/include/asm/cpufeature.h:171
arch/x86/entry/common.c:97)
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:181)
? exit_to_user_mode_prepare (kernel/entry/common.c:212)
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:181)
? syscall_exit_to_user_mode (kernel/entry/common.c:299)
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:181)
? exit_to_user_mode_prepare (kernel/entry/common.c:212)
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:181)
? syscall_exit_to_user_mode (kernel/entry/common.c:299)
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:181)
? do_syscall_64 (./arch/x86/include/asm/cpufeature.h:171
arch/x86/entry/common.c:97)
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:181)
? do_syscall_64 (./arch/x86/include/asm/cpufeature.h:171
arch/x86/entry/common.c:97)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129)
RIP: 0033:0x7f1a40b2920b
Code: c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 f3 0f 1e fa 31 f6
e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48> 3d
00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 d9 4b 0d 00 f7 d8
All code
========
   0:    c3                       ret
   1:    66 2e 0f 1f 84 00 00     cs nopw 0x0(%rax,%rax,1)
   8:    00 00 00
   b:    0f 1f 40 00              nopl   0x0(%rax)
   f:    f3 0f 1e fa              endbr64
  13:    31 f6                    xor    %esi,%esi
  15:    e9 05 00 00 00           jmp    0x1f
  1a:    0f 1f 44 00 00           nopl   0x0(%rax,%rax,1)
  1f:    f3 0f 1e fa              endbr64
  23:    b8 a6 00 00 00           mov    $0xa6,%eax
  28:    0f 05                    syscall
  2a:*    48 3d 00 f0 ff ff        cmp    $0xfffffffffffff000,%rax
   <-- trapping instruction
  30:    77 05                    ja     0x37
  32:    c3                       ret
  33:    0f 1f 40 00              nopl   0x0(%rax)
  37:    48 8b 15 d9 4b 0d 00     mov    0xd4bd9(%rip),%rdx        # 0xd4c17
  3e:    f7 d8                    neg    %eax

Code starting with the faulting instruction
===========================================
   0:    48 3d 00 f0 ff ff        cmp    $0xfffffffffffff000,%rax
   6:    77 05                    ja     0xd
   8:    c3                       ret
   9:    0f 1f 40 00              nopl   0x0(%rax)
   d:    48 8b 15 d9 4b 0d 00     mov    0xd4bd9(%rip),%rdx        # 0xd4bed
  14:    f7 d8                    neg    %eax
RSP: 002b:00007fff13f8bca8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 000055c4aed6c5c0 RCX: 00007f1a40b2920b
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000055c4aed70d80
RBP: 000055c4aed6c6c0 R08: 000055c4aed68010 R09: 0000000000000007
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000055c4aed70d80 R14: 000055c4aed6c9d0 R15: 000055c4aed6c5c0
</TASK>
Modules linked in: brd cfg80211 ipmi_ssif binfmt_misc intel_rapl_msr
intel_rapl_common amd64_edac edac_mce_amd kvm_amd kvm irqbypass
wmi_bmof rapl nls_iso8859_1 ccp acpi_ipmi i2c_piix4 ptdma k10temp
ipmi_si ipmi_devintf joydev input_leds ipmi_msghandler mac_hid
dm_multipath msr efi_pstore dmi_sysfs ip_tables x_tables autofs4 btrfs
blake2b_generic raid10 raid456 async_raid6_recov async_memcpy async_pq
async_xor async_tx raid1 raid0 multipath linear hid_generic rndis_host
usbhid cdc_ether usbnet hid mii crct10dif_pclmul ast crc32_pclmul
i2c_algo_bit polyval_clmulni drm_shmem_helper polyval_generic
ghash_clmulni_intel sha512_ssse3 drm_kms_helper sha256_ssse3
sha1_ssse3 nvme ahci drm tg3 libahci xhci_pci nvme_core
xhci_pci_renesas wmi aesni_intel crypto_simd cryptd
CR2: 0000000000000020
---[ end trace 0000000000000000 ]---
RIP: 0010:bch2_journal_space_available
(fs/bcachefs/journal_reclaim.c:190 (discriminator 1))
Code: f1 74 2d 4d 8b 97 a8 06 00 00 eb 15 8d 46 01 31 d2 f7 f7 41 89
97 bc 06 00 00 89 d6 44 39 ca 74 0f 89 f0 48 8b 8b d0 04 00 00 <49> 39
0c c2 72 dc 41 8b 97 b8 06 00 00 39 f2 74 49 4d 8b 8f a8 06
All code
========
   0:    f1                       int1
   1:    74 2d                    je     0x30
   3:    4d 8b 97 a8 06 00 00     mov    0x6a8(%r15),%r10
   a:    eb 15                    jmp    0x21
   c:    8d 46 01                 lea    0x1(%rsi),%eax
   f:    31 d2                    xor    %edx,%edx
  11:    f7 f7                    div    %edi
  13:    41 89 97 bc 06 00 00     mov    %edx,0x6bc(%r15)
  1a:    89 d6                    mov    %edx,%esi
  1c:    44 39 ca                 cmp    %r9d,%edx
  1f:    74 0f                    je     0x30
  21:    89 f0                    mov    %esi,%eax
  23:    48 8b 8b d0 04 00 00     mov    0x4d0(%rbx),%rcx
  2a:*    49 39 0c c2              cmp    %rcx,(%r10,%rax,8)
<-- trapping instruction
  2e:    72 dc                    jb     0xc
  30:    41 8b 97 b8 06 00 00     mov    0x6b8(%r15),%edx
  37:    39 f2                    cmp    %esi,%edx
  39:    74 49                    je     0x84
  3b:    4d                       rex.WRB
  3c:    8b                       .byte 0x8b
  3d:    8f                       .byte 0x8f
  3e:    a8 06                    test   $0x6,%al

Code starting with the faulting instruction
===========================================
   0:    49 39 0c c2              cmp    %rcx,(%r10,%rax,8)
   4:    72 dc                    jb     0xffffffffffffffe2
   6:    41 8b 97 b8 06 00 00     mov    0x6b8(%r15),%edx
   d:    39 f2                    cmp    %esi,%edx
   f:    74 49                    je     0x5a
  11:    4d                       rex.WRB
  12:    8b                       .byte 0x8b
  13:    8f                       .byte 0x8f
  14:    a8 06                    test   $0x6,%al
RSP: 0018:ffffc90020f63be0 EFLAGS: 00010202
RAX: 0000000000000004 RBX: ffff8881532c9dc0 RCX: 0000000000000013
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000002000
RBP: ffffc90020f63c10 R08: 0000000000000000 R09: 0000000000000008
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888153284400
R13: ffff888153280268 R14: 0000000000000001 R15: ffff88811668c000
FS: 00007f1a40c1c800(0000) GS:ffff88bf4eb00000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000020 CR3: 00000001533de001 CR4: 0000000000770ef0
PKRU: 55555554
note: umount[1778] exited with irqs disabled
note: umount[1778] exited with preempt_count 1
BUG: sleeping function called from invalid context at
include/linux/percpu-rwsem.h:49
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1778, name: umount
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
INFO: lockdep is turned off.
CPU: 38 PID: 1778 Comm: umount Tainted: G   D      6.7.0-rc2 #7
Hardware name: Supermicro AS -3014TS-i/H12SSL-i, BIOS 2.5 09/08/2022
Call Trace:
<TASK>
dump_stack_lvl (lib/dump_stack.c:107)
dump_stack (lib/dump_stack.c:114)
__might_resched (kernel/sched/core.c:10152)
__might_sleep (kernel/sched/core.c:10081)
exit_signals (./include/linux/kernel.h:107
./include/linux/percpu-rwsem.h:49 ./include/linux/cgroup-defs.h:772
kernel/signal.c:2996)
do_exit (kernel/exit.c:832)
? _printk (kernel/printk/printk.c:2332)
make_task_dead (kernel/exit.c:969)
rewind_stack_and_make_dead (??:?)
RIP: 0033:0x7f1a40b2920b
Code: c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 f3 0f 1e fa 31 f6
e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48> 3d
00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 d9 4b 0d 00 f7 d8
All code
========
   0:    c3                       ret
   1:    66 2e 0f 1f 84 00 00     cs nopw 0x0(%rax,%rax,1)
   8:    00 00 00
   b:    0f 1f 40 00              nopl   0x0(%rax)
   f:    f3 0f 1e fa              endbr64
  13:    31 f6                    xor    %esi,%esi
  15:    e9 05 00 00 00           jmp    0x1f
  1a:    0f 1f 44 00 00           nopl   0x0(%rax,%rax,1)
  1f:    f3 0f 1e fa              endbr64
  23:    b8 a6 00 00 00           mov    $0xa6,%eax
  28:    0f 05                    syscall
  2a:*    48 3d 00 f0 ff ff        cmp    $0xfffffffffffff000,%rax
   <-- trapping instruction
  30:    77 05                    ja     0x37
  32:    c3                       ret
  33:    0f 1f 40 00              nopl   0x0(%rax)
  37:    48 8b 15 d9 4b 0d 00     mov    0xd4bd9(%rip),%rdx        # 0xd4c17
  3e:    f7 d8                    neg    %eax

Code starting with the faulting instruction
===========================================
   0:    48 3d 00 f0 ff ff        cmp    $0xfffffffffffff000,%rax
   6:    77 05                    ja     0xd
   8:    c3                       ret
   9:    0f 1f 40 00              nopl   0x0(%rax)
   d:    48 8b 15 d9 4b 0d 00     mov    0xd4bd9(%rip),%rdx        # 0xd4bed
  14:    f7 d8                    neg    %eax
RSP: 002b:00007fff13f8bca8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 000055c4aed6c5c0 RCX: 00007f1a40b2920b
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000055c4aed70d80
RBP: 000055c4aed6c6c0 R08: 000055c4aed68010 R09: 0000000000000007
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000055c4aed70d80 R14: 000055c4aed6c9d0 R15: 000055c4aed6c5c0
</TASK>
-- 
Daniel J Blueman
