Return-Path: <linux-kernel+bounces-104958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B40E787D68F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 23:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 418221F23887
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 22:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C920256B90;
	Fri, 15 Mar 2024 22:28:19 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B06354F84
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 22:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710541699; cv=none; b=dvwuoGN+hwxbp0ok+Yx5n4VhRng3cNvl/v2l9FMqzM5a6w9rCfBs+VptYc3QCd+t/IJdtnSeKejBjIae24DlOmS0M0+HocejMDh2z2CQzIOXFh9leoDuOYQRhw508WOnUxvMz8ITR2Is/GDrPz6PSyGeL6xCD0GCHlFR7x/1gFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710541699; c=relaxed/simple;
	bh=gJ0G0ulTts/YnxVTHfudMlUZoq9ceBixQWWHLnY2QnE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PTq2QZEwGwFw2N3xU7i+Bh9l+UfBBzUbdhggt1Zj7lCy1Vg2RHobMbnsNZL6IPxvebZPnr9h5kzrOgeyWYfnkg4AL9nJRpjW1jTgmYP9uE8UkXqrew9W95p9Epa4kd1Hy5kel9pwiOpyV9OyfuZMIO7Kwz1yVJ8OsA9HoBcs/gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cbf1ea053cso132894939f.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 15:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710541695; x=1711146495;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AwXHKD0a4yfnFfWwYpSTyJLpYXi203ujvcaAn1vhbic=;
        b=W8WDoDJs2akhldz99rDsNhG7ci+SSk3i+pQlNf5lD0P0iDBS8pZ4dOmkPEAUHjoE0z
         cLmQ2INXXWO2l3WdIMHpyVPrBP16AUbEWdCY7dYC3JHd4JG9ese7d7gDy+xtLtg4qYj1
         UehrFmJ/mQsfwvvtAC8cPzcxMoCUPI5UNsi5ondMSxyrQKufhyJbON/O+HcTkynYAT93
         P3barzYB28iUiHav1kB++EZmbqiP9YYI1HSiLp4KrEKBybQ7eZt4VBsNPQxPqwEhEZak
         P0ogoJhlu3FTiZDkGqnCv0gzrAxN+yvhgPun+hee21Lr/nq04A9aLuKYKLmpY/Yhxq/S
         MLbA==
X-Forwarded-Encrypted: i=1; AJvYcCXiilcKjB95EMrzgYSrovfA3r/wUg6ip5+4Zuk1046CabaxDVTubYkOy9fyjGdk+sPc1AgWz0HtU11W0SRWECHrNhH9/Zvq9oo9kcO4
X-Gm-Message-State: AOJu0YzODbVx5biYKjTKARVoaTjRBIHF4i3a08kNI6hGWyh+xAnWcOR1
	9RjiyyS1jk6cbsOjbXLkiUXHirP3K0kndhPsQpdA7bUTj1trWeuCkWtt7hGAUKJgVrYusRn/EHl
	AzsbFRo3fwDTKaBrlMJr0UlM3wlNx0UKwrEOphQrUat3aam7N/jcLi+4=
X-Google-Smtp-Source: AGHT+IG0TqbeP+foZgrAAq6tzEZ5s6A4ruiRAfl8gtgMmF+4uHccNW5jO0jeP0irEV0PSRKdHpD4ybLdSqeW3YCdiBujgl9YVfTD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1653:b0:477:e8a:5719 with SMTP id
 a19-20020a056638165300b004770e8a5719mr302395jat.0.1710541695656; Fri, 15 Mar
 2024 15:28:15 -0700 (PDT)
Date: Fri, 15 Mar 2024 15:28:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000024b0820613ba8647@google.com>
Subject: [syzbot] [io-uring?] KMSAN: uninit-value in io_sendrecv_fail
From: syzbot <syzbot+f8e9a371388aa62ecab4@syzkaller.appspotmail.com>
To: asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8ede842f669b Merge tag 'rust-6.9' of https://github.com/Ru..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=138f0ad6180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a271c5dca0ff14df
dashboard link: https://syzkaller.appspot.com/bug?extid=f8e9a371388aa62ecab4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b4a6fa180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14a59799180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/af1cd47b84ef/disk-8ede842f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/be9297712c37/vmlinux-8ede842f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c569fb33468d/bzImage-8ede842f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f8e9a371388aa62ecab4@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in io_sendrecv_fail+0x91/0x1e0 io_uring/net.c:1334
 io_sendrecv_fail+0x91/0x1e0 io_uring/net.c:1334
 io_req_defer_failed+0x3bd/0x610 io_uring/io_uring.c:1050
 io_queue_sqe_fallback+0x1e3/0x280 io_uring/io_uring.c:2126
 io_submit_fail_init+0x4e1/0x790 io_uring/io_uring.c:2304
 io_submit_sqes+0x19cd/0x2fb0 io_uring/io_uring.c:2480
 __do_sys_io_uring_enter io_uring/io_uring.c:3656 [inline]
 __se_sys_io_uring_enter+0x409/0x43e0 io_uring/io_uring.c:3591
 __x64_sys_io_uring_enter+0x11b/0x1a0 io_uring/io_uring.c:3591
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
 __alloc_pages+0x9a6/0xe00 mm/page_alloc.c:4592
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page mm/slub.c:2190 [inline]
 allocate_slab mm/slub.c:2354 [inline]
 new_slab+0x2d7/0x1400 mm/slub.c:2407
 ___slab_alloc+0x16b5/0x3970 mm/slub.c:3540
 __kmem_cache_alloc_bulk mm/slub.c:4574 [inline]
 kmem_cache_alloc_bulk+0x52a/0x1440 mm/slub.c:4648
 __io_alloc_req_refill+0x248/0x780 io_uring/io_uring.c:1101
 io_alloc_req io_uring/io_uring.h:405 [inline]
 io_submit_sqes+0xaa1/0x2fb0 io_uring/io_uring.c:2469
 __do_sys_io_uring_enter io_uring/io_uring.c:3656 [inline]
 __se_sys_io_uring_enter+0x409/0x43e0 io_uring/io_uring.c:3591
 __x64_sys_io_uring_enter+0x11b/0x1a0 io_uring/io_uring.c:3591
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

CPU: 1 PID: 5021 Comm: syz-executor425 Not tainted 6.8.0-syzkaller-00648-g8ede842f669b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
=====================================================


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

