Return-Path: <linux-kernel+bounces-106378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E5587ED72
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9BDA1C20852
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D961535C1;
	Mon, 18 Mar 2024 16:25:33 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75453535A3
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 16:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710779133; cv=none; b=ShDXT8+yaf4zefikQEv8OFIccXs7MjROMKF6zpfmMM5cld/AYMUEAwqKzfvZTw1akrBr6nZnY0HMXV5/fXulwU4PxCQX2HLnYu/eYzNN0GGvXX+s+fVCHQuNMheufJ1uSkxAUQTMQLxi531dgDGjJdSdPXNBGaPkVWQBVBbXxyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710779133; c=relaxed/simple;
	bh=ALel0ZJlWQ1S5d8q7GgW3Bf+9WRhNeEBXuP/qt6gvVg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OexqEIncYFsdsP0MIBB6/jJxY6GZ0hLNgI2d08VdUW6020sHCyMZ8JmhwE0AXszPEAvC8bwxLumI3ShM/ecE1xrE7AEhUjrILVjMtfcPb2ei3oj7KnQc/9kbV3VSC1E6Z3v7+vIMx2Shfm+icbiT1/NEdCiwOh1q4AGUdkA13bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cbf4635bfaso326761639f.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 09:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710779130; x=1711383930;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0HXjl2GOOAysogl8K31WTn4QnOI9Necaavd1Q3QMQQo=;
        b=e+5Al18HIkGPVMzR+w65/MBsd8Rb7Tsb4l1H0cmnv49xTrKNxMYth/dO31DKGXCftl
         fB00s2u1JfY5vhy5VNAoHCp1Hpn+DoeWUyFViKtUVSn1oCAPjpbiz8mkLLFyRGKBWpd5
         mws0z/EMw8Xj2hmBTiMjOVZrlqUrIRvJHSNCSCrWDZvZPHMsljPS88KdrTkAkNV/lvCp
         b60iLmHPsRBipZVCNqydzvEYmp8fC1MO6LGdG597aUyhUrjjCPwfg/2FnxA5LwiHFhq2
         W2n1fGVfgdXxsy0xIsVyL5EuWXTq//zT/fTRqPXXnZqjkRZmJi6gekXI1AYLc/kcKmY3
         D4Vg==
X-Forwarded-Encrypted: i=1; AJvYcCURzTHA584tqn1Q2B50fcTZ2uRqlXqMqsr0hrFHRA+WfLiNBkWAQuO0PAbQmqCvZsIWrUbezfd1w8ryM5FL0tKYo22SRQsEaQpe/MoC
X-Gm-Message-State: AOJu0YzUeE8GuHthhiXcLxNBxvphWMCwny8FBRwsNY9ZYtisJvKh0uO8
	b9WWCq8I1G/tb+We5cJONTQ5/TMDshUU4vtvz/8m9FoxNeVBMterxzMl3t07f2TPVS8VLKjSA95
	FxHM9z+ei+ZxsHqGZ5k9HdOD6TzDZVyNUt14pUeQIhWymcSwCFFSXRz0=
X-Google-Smtp-Source: AGHT+IF9jzNrwrcmkdpA1lQvGAoTz2bFyLlbeVuCVfRw3wBIXP2dn89+GZrUSmmFZ7zSC2BAM6uNJ0xTb85/ScU/F3O6WoHFsm3N
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2d91:b0:7c8:d517:1008 with SMTP id
 k17-20020a0566022d9100b007c8d5171008mr359658iow.0.1710779130679; Mon, 18 Mar
 2024 09:25:30 -0700 (PDT)
Date: Mon, 18 Mar 2024 09:25:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005fa5cc0613f1cebd@google.com>
Subject: [syzbot] [kvm?] WARNING in __kvm_gpc_refresh
From: syzbot <syzbot+106a4f72b0474e1d1b33@syzkaller.appspotmail.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    277100b3d5fe Merge tag 'block-6.9-20240315' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17c96aa5180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1c6662240382da2
dashboard link: https://syzkaller.appspot.com/bug?extid=106a4f72b0474e1d1b33
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14358231180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=110ed231180000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-277100b3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6872e049b27c/vmlinux-277100b3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/68ec7230df0f/bzImage-277100b3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+106a4f72b0474e1d1b33@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5192 at arch/x86/kvm/../../../virt/kvm/pfncache.c:247 __kvm_gpc_refresh+0x15e2/0x2200 arch/x86/kvm/../../../virt/kvm/pfncache.c:247
Modules linked in:
CPU: 1 PID: 5192 Comm: syz-executor422 Not tainted 6.8.0-syzkaller-11063-g277100b3d5fe #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:__kvm_gpc_refresh+0x15e2/0x2200 arch/x86/kvm/../../../virt/kvm/pfncache.c:247
Code: 48 c7 c2 a0 5e 02 8b be 5d 03 00 00 48 c7 c7 60 5e 02 8b c6 05 bd 89 7c 0e 01 e8 a9 23 5e 00 e9 31 fb ff ff e8 5f 85 80 00 90 <0f> 0b 90 e9 69 f7 ff ff e8 51 85 80 00 48 8b 54 24 40 48 b8 00 00
RSP: 0018:ffffc9000317f940 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffffffffffffff RCX: ffffffff810c86ad
RDX: ffff888022360000 RSI: ffffffff810c9c31 RDI: 0000000000000000
RBP: ffff88802f2c0948 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000002 R12: ffff888000000000
R13: ffff887fffffff01 R14: 0000000000000020 R15: 0000000000000001
FS:  000055555b2d9380(0000) GS:ffff88806b300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000002fa8a000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kvm_gpc_refresh+0x7d/0xe0 arch/x86/kvm/../../../virt/kvm/pfncache.c:364
 kvm_setup_guest_pvclock+0x5b/0x6f0 arch/x86/kvm/x86.c:3174
 kvm_guest_time_update+0x935/0xeb0 arch/x86/kvm/x86.c:3313
 vcpu_enter_guest arch/x86/kvm/x86.c:10769 [inline]
 vcpu_run+0x1993/0x4e60 arch/x86/kvm/x86.c:11211
 kvm_arch_vcpu_ioctl_run+0x42e/0x1680 arch/x86/kvm/x86.c:11437
 kvm_vcpu_ioctl+0x5a1/0x1060 arch/x86/kvm/../../../virt/kvm/kvm_main.c:4464
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:904 [inline]
 __se_sys_ioctl fs/ioctl.c:890 [inline]
 __x64_sys_ioctl+0x193/0x220 fs/ioctl.c:890
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7fb4618fd069
Code: 48 83 c4 28 c3 e8 d7 19 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd71e140e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fb4618fd069 RCX: 00007fb4618fd069
RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000006
RBP: 00007fb46194a07e R08: 00007ffd71e14218 R09: 00007ffd71e14218
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd71e14150
R13: 00007ffd71e14130 R14: 00007ffd71e14120 R15: 00007fb46194a012
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

