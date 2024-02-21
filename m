Return-Path: <linux-kernel+bounces-73985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 945C185CE78
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 04:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32D0AB22A4B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE9D2BAE3;
	Wed, 21 Feb 2024 03:00:29 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D90728374
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 03:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708484429; cv=none; b=uxzWJgV/nMMl3D312pVXjoEM8GISPZFLOs4DkkeEfRCDwOelYHkNVj9ftCC5GBMaxpqG5jzkmjYB8HqoZPSDyuLhVkxg30aQJLRzVyfRGXqi6s/ewJIWGeTAucnfNZ2l0vuInmgd7pnLAwAzGLiyk3ZIeWnIc4+X6vSv4CjNyro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708484429; c=relaxed/simple;
	bh=rkLKCDZNjb6J0IiHPCSnK1SOv3Zj9iEVmYNgMObi7/Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TagSFBjKPTiHqVbzwKeasVm1tSTR4xGWC+faaI9BgJveylx21ZnemBG2gu/5LqRRYEiHJzlQ1benuGGvqWs2uXx3V2vd5XCc6jrp3wN5Ng8ZJvQ3SsfWYUVA7aXkpXcPoVpurQbs6FyplEKPx9IZiqrRm93IJ70Ei8epAYU0ha0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36424431577so47950165ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 19:00:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708484427; x=1709089227;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HKC2FBRzuJ/NpphNyy1cXiWj+k3pGRIjMpvVMN1CXGA=;
        b=boLqqgfbXKXNefTdDuLAIkngQiUj0YujNtNTXGpmW4OPHkt2rP7bBEeU/OozN+jgyX
         2AbygwM9jTYOaLyFrCEh1tKTa5oNy95ANNPXq6UrWNgi24Rm0Mav6PGKfWd/PYzkqwKw
         i+X20ZDgXpN1WVsMK8SQxx1nPNhhLjF8EZE9fbTBjXGi5jqxfiD4JxbJC0IHVJP8jHqp
         M4XYaHTkaZMafuv5/iMhOcxi0EPtwD+L631/MkKm4CzY3ihSdBO18nQN9gXq5CJCZEmP
         CfQIcpNikD4yKmh7F7sD/1kX51k0hLuZ155YyfGnR0t7kec+9EjYin+mLS+VZyXh0Wy5
         0fIQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/HNR6r7Vea+grOn9xqrQvXjDenY9JKCjbwk1P1JOUG0W1Jb4VXLo68te6RQEFCrA304lx+q6c3vfQhM2ujkKUSx0w/Rz6qvsdZPYD
X-Gm-Message-State: AOJu0YwSabxZWcaAghOnoTQXtYh4rYVJ7PzC53L8b1YICGIV3ErCVGIv
	LW6Wh0lYvjfzZEggBA/AkyrIHlVekeuL7yLbteE11VJ8bThCGQajiAtyQw6hyJ0zY74SIYVc4P6
	QnQ5U5PkxDyMnc8A/f0WkvKn6A5b+ASXVJTb0i+qOBdiqYMnoep8hQeQ=
X-Google-Smtp-Source: AGHT+IFhevZLLMLv1IVMNBUKv01dHF2q9cfQse+2XCEwbDYmSERfOxBEyUgWtenQFYc/t3MOcpGbZpvWrk5sSN0cP3XHp8gbRQvt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1889:b0:365:3355:38fe with SMTP id
 o9-20020a056e02188900b00365335538femr402622ilu.5.1708484427281; Tue, 20 Feb
 2024 19:00:27 -0800 (PST)
Date: Tue, 20 Feb 2024 19:00:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000647d640611db8789@google.com>
Subject: [syzbot] [kvm?] KMSAN: uninit-value in em_ret_near_imm
From: syzbot <syzbot+c9aca2253922f806a75a@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	pbonzini@redhat.com, seanjc@google.com, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0f1dd5e91e2b Merge tag 'sound-6.8-rc5' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17bec778180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e3dd779fba027968
dashboard link: https://syzkaller.appspot.com/bug?extid=c9aca2253922f806a75a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b6e52e101a62/disk-0f1dd5e9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/64025c9168bf/vmlinux-0f1dd5e9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/491e1a922dc9/bzImage-0f1dd5e9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c9aca2253922f806a75a@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in assign_eip_near arch/x86/kvm/emulate.c:829 [inline]
BUG: KMSAN: uninit-value in em_ret_near_imm+0x13c/0x580 arch/x86/kvm/emulate.c:3192
 assign_eip_near arch/x86/kvm/emulate.c:829 [inline]
 em_ret_near_imm+0x13c/0x580 arch/x86/kvm/emulate.c:3192
 x86_emulate_insn+0x1d87/0x5880 arch/x86/kvm/emulate.c:5292
 x86_emulate_instruction+0x13c9/0x30a0 arch/x86/kvm/x86.c:9175
 kvm_emulate_instruction arch/x86/kvm/x86.c:9255 [inline]
 complete_emulated_io arch/x86/kvm/x86.c:11212 [inline]
 complete_emulated_mmio+0x70b/0x8b0 arch/x86/kvm/x86.c:11272
 kvm_arch_vcpu_ioctl_run+0x1837/0xb890 arch/x86/kvm/x86.c:11384
 kvm_vcpu_ioctl+0xbfc/0x1770 arch/x86/kvm/../../../virt/kvm/kvm_main.c:4441
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0x225/0x410 fs/ioctl.c:857
 __x64_sys_ioctl+0x96/0xe0 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Local variable eip created at:
 em_ret_near_imm+0x3a/0x580 arch/x86/kvm/emulate.c:3189
 x86_emulate_insn+0x1d87/0x5880 arch/x86/kvm/emulate.c:5292

CPU: 0 PID: 6232 Comm: syz-executor.3 Not tainted 6.8.0-rc4-syzkaller-00267-g0f1dd5e91e2b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

