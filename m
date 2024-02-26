Return-Path: <linux-kernel+bounces-81467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 218E7867650
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 014C6B220FC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648E21272B9;
	Mon, 26 Feb 2024 13:19:25 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480BF128832
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 13:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708953564; cv=none; b=P1Xks+KwU0ufslLWwi9kJ0yTOOlBDV6EEiUrGty8h5l5vhdeewzoOi9NYIkASdERVcknWwBoUzuH+ztz2YWF8IF6+2S3K0Rq4GGEmPKkEyGTbpuc/IpMhCKKoyVSAIIt4K4cP36+vZPTBLV+GAbrXtgkMoufC1kiRJXc1PQUFsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708953564; c=relaxed/simple;
	bh=9Qx0X6N96a5bvYf78hnA8WJMdEzQ3DEBE5GYrA8/jUY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=inxLoOEo60O//Wn5/HU1EF7VAy7js8bwVMh76jsTYL5gqOD63jI8DXefTlcyEZYDmXkW3LI5F8UZaxJX7aqGvkinRV0Fh2OAeZtbFKcbIDIcD0+3YenytDaxWJ43NScXhqa5IE8rMQwbYY8Z9oq+fGrX+BBpWESXCCzcTy9JKl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7bfffd9b47fso298370639f.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 05:19:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708953562; x=1709558362;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MXuXfQWJYfhI3N1t9dswUoSOZrO136/zC4yXB1z1cNY=;
        b=T51Rfq7zMSNcnLmUTpbA85jeb8ymN3XPac19iuO8U8STLa9VvY7RVpFFnYAbUmvo+e
         yOSbRKNJlO7vY1r9Ex0yhoivrAqc+h61+nZKs852G0MYLDR7dEGlprutYZ7fk2fZFtUm
         V/ZBIERarl1gYTRQ53USN3dgzchru2ScN8we4iAe95ecCP0TFwj19xcryKmAsJlYFQLW
         JRkJDZP8yp3nXZXNo8jbGKFJXRH9ny/pvUwFWbUNqFT0QR6RTkINpLzOj1FLt7rfDyq+
         Q5i6+8aaAbmANKWeIDP/xd8fJUNFiugz/nFIclY1HYpSMK5/ynyi0/y9XC509zREyQi0
         MtNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVu+oLWHdTbUkGJJMDLJSkYX+t5DbutzaU5V/PfwRAB5YoNoQo5oV0gr0HzaWQrCNBLAZ2FiQw9Xg70yyDjgfNVUVkujA0/GlzcotTO
X-Gm-Message-State: AOJu0Yy/6jUo5aKs9IEATXIdB5lpu2F1hlgE43sNEoQoGwigq9HzAEVG
	6uf3ediWtzo4I8G9vuutXd+CgEs0ctaFHg0fkdZOWwsj27mukessLUXCyMFiWyG5l+Q7QSXhxf5
	RPHRlmdAO2poBjwiymmQ3poWVhcx96LBqyWamLGhhi/VPVJpPcJizHzs=
X-Google-Smtp-Source: AGHT+IGysToUbqQaeYt0IjPDwZGh+WRCUEQNfg9uTtRD0PXqy0+lIeWIjGxkZ3aH8vISieMF+AU+skk/evvYDYbU9KJidTdcOsB/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2710:b0:474:8b40:13fb with SMTP id
 m16-20020a056638271000b004748b4013fbmr118243jav.6.1708953560918; Mon, 26 Feb
 2024 05:19:20 -0800 (PST)
Date: Mon, 26 Feb 2024 05:19:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000efadd3061248c1cd@google.com>
Subject: [syzbot] [mm?] WARNING in kunmap_local_indexed
From: syzbot <syzbot+691cb37358791bebebe6@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    70ff1fe626a1 Merge tag 'docs-6.8-fixes3' of git://git.lwn...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17130f4a180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4cf52b43f46d820d
dashboard link: https://syzkaller.appspot.com/bug?extid=691cb37358791bebebe6
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=151e4e54180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=115b934a180000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/8ead8862021c/non_bootable_disk-70ff1fe6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bc398db9fd8c/vmlinux-70ff1fe6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6d3f8b72a671/zImage-70ff1fe6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+691cb37358791bebebe6@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 2978 at mm/highmem.c:611 kunmap_local_indexed+0x210/0x228 mm/highmem.c:611
Modules linked in:
Kernel panic - not syncing: kernel: panic_on_warn set ...
CPU: 1 PID: 2978 Comm: syz-executor914 Not tainted 6.8.0-rc5-syzkaller #0
Hardware name: ARM-Versatile Express
Backtrace: 
[<81837b0c>] (dump_backtrace) from [<81837c08>] (show_stack+0x18/0x1c arch/arm/kernel/traps.c:256)
 r7:00000000 r6:82622dc4 r5:60000093 r4:81fbd4bc
[<81837bf0>] (show_stack) from [<81855124>] (__dump_stack lib/dump_stack.c:88 [inline])
[<81837bf0>] (show_stack) from [<81855124>] (dump_stack_lvl+0x48/0x54 lib/dump_stack.c:106)
[<818550dc>] (dump_stack_lvl) from [<81855148>] (dump_stack+0x18/0x1c lib/dump_stack.c:113)
 r5:00000000 r4:82850d18
[<81855130>] (dump_stack) from [<818386b0>] (panic+0x120/0x378 kernel/panic.c:344)
[<81838590>] (panic) from [<802439cc>] (check_panic_on_warn kernel/panic.c:237 [inline])
[<81838590>] (panic) from [<802439cc>] (print_tainted+0x0/0xa0 kernel/panic.c:232)
 r3:8260c484 r2:00000001 r1:81fa5e94 r0:81fadb60
 r7:8046cfa0
[<80243958>] (check_panic_on_warn) from [<80243bc0>] (__warn+0x7c/0x180 kernel/panic.c:677)
[<80243b44>] (__warn) from [<80243e3c>] (warn_slowpath_fmt+0x178/0x1f4 kernel/panic.c:702)
 r8:00000009 r7:81fd3b7c r6:df961b84 r5:83668c00 r4:00000000
[<80243cc8>] (warn_slowpath_fmt) from [<8046cfa0>] (kunmap_local_indexed+0x210/0x228 mm/highmem.c:611)
 r10:200fb000 r9:ffeda7d8 r8:836c9830 r7:84151500 r6:00000003 r5:83668c00
 r4:ffedc000
[<8046cd90>] (kunmap_local_indexed) from [<804d9c84>] (__kunmap_local include/linux/highmem-internal.h:94 [inline])
[<8046cd90>] (kunmap_local_indexed) from [<804d9c84>] (move_pages_pte mm/userfaultfd.c:1162 [inline])
[<8046cd90>] (kunmap_local_indexed) from [<804d9c84>] (move_pages+0x5a4/0x1050 mm/userfaultfd.c:1452)
 r7:84151500 r6:00000000 r5:00000000 r4:fffffffe
[<804d96e0>] (move_pages) from [<80551f30>] (userfaultfd_move fs/userfaultfd.c:2047 [inline])
[<804d96e0>] (move_pages) from [<80551f30>] (userfaultfd_ioctl+0x117c/0x211c fs/userfaultfd.c:2169)
 r10:8415157c r9:00000000 r8:00000000 r7:00000001 r6:20000080 r5:84151500
 r4:84468000
[<80550db4>] (userfaultfd_ioctl) from [<80502158>] (vfs_ioctl fs/ioctl.c:51 [inline])
[<80550db4>] (userfaultfd_ioctl) from [<80502158>] (do_vfs_ioctl fs/ioctl.c:831 [inline])
[<80550db4>] (userfaultfd_ioctl) from [<80502158>] (__do_sys_ioctl fs/ioctl.c:869 [inline])
[<80550db4>] (userfaultfd_ioctl) from [<80502158>] (sys_ioctl+0x118/0xb58 fs/ioctl.c:857)
 r10:83668c00 r9:00000003 r8:842e2900 r7:20000080 r6:842e2900 r5:00000000
 r4:c028aa05
[<80502040>] (sys_ioctl) from [<80200060>] (ret_fast_syscall+0x0/0x1c arch/arm/mm/proc-v7.S:66)
Exception stack(0xdf961fa8 to 0xdf961ff0)
1fa0:                   ffffffff 00000000 00000003 c028aa05 20000080 00000000
1fc0: ffffffff 00000000 0008e050 00000036 000f4240 00000000 00000001 00003a97
1fe0: 7ebe5c70 7ebe5c60 00010694 0002e7e0
 r10:00000036 r9:83668c00 r8:80200288 r7:00000036 r6:0008e050 r5:00000000
 r4:ffffffff
Rebooting in 86400 seconds..


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

