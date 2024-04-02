Return-Path: <linux-kernel+bounces-128176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69256895739
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99FE01C2258C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4FF138484;
	Tue,  2 Apr 2024 14:40:33 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7138112D771
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 14:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068833; cv=none; b=LmnBP+NRCUmmS/p6Hef4sRZ3kdxRPiYIk6N4s/AXBErHwrEeh13ebdxJCPBUGTs2xMV5IRf+1u1eAOHuGpZjCsrDJNgPUmggT6vpb6mPJfsWL5uwjYFQwx2K2KVLd1ShbivgtPmBBXsCO15wtkVV35Yc/nwJlwRarLA56i/88QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068833; c=relaxed/simple;
	bh=LVDimP3t6ZMj5dMwpNvbfkYZM6CtRsyRKN+piPAFMZY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=N/A1HVDFdvnhkb0rsIe3BIpwfcf5GhX0Fq7Xz1YS9yNmKuLuEH3LQMILWAQVdcE8OEhlFmg+qXX29BNPrehzFszXFAJTFX7nOmsoLbO9t8keo1IBtHz8ATLMsUwt9QBAPIqCmVQaZQl5YhjZ4cOEaDsJD7eYglLsHd6bBlJIuzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cbf2ff0e33so509524539f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 07:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712068830; x=1712673630;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UBYFETW+ZOFXZPsaDOWdGcz8TLROU3zipO0hhmro3wQ=;
        b=SFtuKEyZ5wzqIT68OJYGXjJeOvfq8LCh5MNjXrPMXZBaYgabod4Fa5zoDZMbx5vydO
         c9tiSPJQ88Fnxry0GBB62pDdTMXiGWcRLOvl4GTi6FRbsT4cmVi0VRCq0vurlWx2AnQz
         xlCeqGjN1AWKEo/n0UezszEGs+fcKhx78hBBaQ8UZgf/Lr3vM/zgy2J9FDZ7ma+Uqzby
         EJJbChJV2E8H6sVNYqH1Z6mUrGg92QwY2Jvq/yARKtb02txs3UVFqmUarAtjF7CA3f5F
         MpK6RI4Kvv6tHk245t4bk4TBkCqYqCzgb8AIKlzeDuMtL03zWXWB2sNWq9GMYTzo4BIr
         1doA==
X-Forwarded-Encrypted: i=1; AJvYcCX33G0gPw1Q+Mp5iZ4B/RV/e5eUCLSYY6VG8nF3xj63v6wBKE1ek4bq1UVRdheyJYjW6Wq0PHWgEAKWp0p4TfOXhaY/GHhS6ro+gwH6
X-Gm-Message-State: AOJu0Yz5CEyNRFYrAs76w9BBukghDMJ7eVg1wWDTFSItCojUer4u2Wgw
	R1/fCJAplGbfSJeBWqHseifI1yIglWMt/djlvmlctaTIUhfFmTeqTTZ8/bf6Xd2fiyEmGy+Zta7
	75+jsByubCBs1HZ2QKmzOcVEaK6fuxaY5kM2jPjOpIwYKFOcc8v3sreU=
X-Google-Smtp-Source: AGHT+IFoDTCmhMGMkJIsXcSJqztYMJO/o1haJ7iPU0Ggf2VFpxHRlo0BXY1g1MqmV16vBjIpMYe5tH/1oVWQdZ/lp7/fyHrqHjhx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:371e:b0:47e:da4f:e1ae with SMTP id
 k30-20020a056638371e00b0047eda4fe1aemr730491jav.5.1712068830593; Tue, 02 Apr
 2024 07:40:30 -0700 (PDT)
Date: Tue, 02 Apr 2024 07:40:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007a9acb06151e1670@google.com>
Subject: [syzbot] [kvm?] WARNING in vmx_handle_exit
From: syzbot <syzbot+988d9efcdf137bc05f66@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	pbonzini@redhat.com, seanjc@google.com, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    480e035fc4c7 Merge tag 'drm-next-2024-03-13' of https://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=148aa5e5180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e5b814e91787669
dashboard link: https://syzkaller.appspot.com/bug?extid=988d9efcdf137bc05f66
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=157a2f45180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16126855180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5f73b6ef963d/disk-480e035f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/46c949396aad/vmlinux-480e035f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e3b4d0f5a5f8/bzImage-480e035f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+988d9efcdf137bc05f66@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5391 at arch/x86/kvm/vmx/vmx.c:6436 __vmx_handle_exit arch/x86/kvm/vmx/vmx.c:6436 [inline]
WARNING: CPU: 0 PID: 5391 at arch/x86/kvm/vmx/vmx.c:6436 vmx_handle_exit+0x14dc/0x1f40 arch/x86/kvm/vmx/vmx.c:6593
Modules linked in:
CPU: 0 PID: 5391 Comm: syz-executor617 Not tainted 6.8.0-syzkaller-08073-g480e035fc4c7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:__vmx_handle_exit arch/x86/kvm/vmx/vmx.c:6436 [inline]
RIP: 0010:vmx_handle_exit+0x14dc/0x1f40 arch/x86/kvm/vmx/vmx.c:6593
Code: 00 00 e8 47 53 6d 00 4c 89 f7 e8 ef da f1 ff 41 bf 01 00 00 00 e9 b1 ed ff ff e8 2f 53 6d 00 e9 45 f4 ff ff e8 25 53 6d 00 90 <0f> 0b 90 42 80 7c 25 00 00 74 08 4c 89 f7 e8 31 a2 d0 00 49 8b 2e
RSP: 0018:ffffc9000595f418 EFLAGS: 00010293
RAX: ffffffff8127a22b RBX: 0000000000000000 RCX: ffff888024ba0000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 1ffff1100f531518 R08: ffffffff81278fba R09: 1ffffffff259c2ba
R10: dffffc0000000000 R11: fffffbfff259c2bb R12: dffffc0000000000
R13: ffff88807a98cb90 R14: ffff88807a98a8c0 R15: 0000000080000021
FS:  00007f84df9ff6c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000015efe000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 vcpu_enter_guest arch/x86/kvm/x86.c:11080 [inline]
 vcpu_run+0x5ca0/0x8790 arch/x86/kvm/x86.c:11184
 kvm_arch_vcpu_ioctl_run+0xa7e/0x1920 arch/x86/kvm/x86.c:11410
 kvm_vcpu_ioctl+0x7f5/0xd00 arch/x86/kvm/../../../virt/kvm/kvm_main.c:4447
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:904 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:890
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f84e0287289
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 d1 1d 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f84df9ff218 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000000003f RCX: 00007f84e0287289
RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000005
RBP: 00007f84e031d038 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f84e031d030
R13: 00007f84e031d03c R14: 00007f84e02d74f8 R15: 6d766b2f7665642f
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

