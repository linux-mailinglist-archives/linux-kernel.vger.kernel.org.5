Return-Path: <linux-kernel+bounces-105188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BB387DA4E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 14:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1F6D282041
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 13:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E727F18B1B;
	Sat, 16 Mar 2024 13:37:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B67018C38
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 13:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710596225; cv=none; b=CuVOnRCxsdSD/VrfRbj8RON+jFZL52y1809Gk2uI6x1CfLw/kUOZbVIkCt5tWIFWy/E/qcJPz0AOhnWMX3zbS1DH0jwx/1qkxra3ZL1KWSRtTk5CrFZTLB3LdzLSNMEhNR2sb826rHkjw2D2sjxTVLluBEl+CZTL1itKLeSz07g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710596225; c=relaxed/simple;
	bh=Mhpu59xZgowwIwUTjJY/1f/xvIuQiNd67W3gnE58C6Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bdH9GbP8TfP2WKj2wr/BoFEUgXi5MBjUsT8qq5oQa0Qd1JXKaIqgaQ3xDoeEK+Ksl8zpUDW0E+wLPvA7xcDNrxl6dPGcbPhP8RxiNNquJ5k48GRXaboeOCUj0+pdxo2ctI9KBsBFGyWCaECqgtpxmsTuZw5DZxQNsShlvK1IB9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c846da7ad2so238824139f.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 06:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710596223; x=1711201023;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f2eMB14kyCcI2k4DTY1kMN6ecp75HepgrKrxW4tAY7Q=;
        b=fjej7H7IIZ7MD9gj3w2mtYl5Azl/9hnAlNJB4OVirphvk+hUjH1ZpitHokgX/urtqt
         6cHzdcs4VlKB5ENk9vHf+s0RdwoZRB5ELWaztHtJw37SAOyh4uGTpMEK9PWpFQA0DnjY
         Ary2Ote0oSs3GcgeZzxDAFGE+0ZFlvg0GmVU8B+K2wud/gbLWLGX6rM7lw1HgJXBYe1r
         6LnS9PS4XPi0NCIc834Ergo8ktEobiLGDkZ5dTqivH7jFLWoydvaAWmgEGrynIm3qBsS
         SpAs0cFZECeqgD1M7kjO9VPEkic/oQ90taW/y/y53i1bSRwDMKf8+mMyKud1I38UxhC0
         p++Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6SPM5/HwdSzRh6F7wgqRV3CIgFebCXcb9fcIhbYvQnh77Pw2HQK/oK7b9cr4oj7F+Yf/TNu+nwf9B0MPTdFG/gd+Zk+BxcQ4dFUjJ
X-Gm-Message-State: AOJu0YzTpGcFujkq+XXKByfmSb9KCl5t+lgLmkdX2ndjnRcrOvRjUdcw
	fDCB/MK4IyMHkMWHo6VSwO11Zax/nhpUxwJ2b9CmlK9x1ds6x9eMLetHVhjrsZcNRkcoklSL2Cc
	7jtHHaPWNDLfuSMgaPgeGYo82TI6N4z0XFG6QxkJFp0/7G3b0vWxe6u8=
X-Google-Smtp-Source: AGHT+IEd/ZZ8j4C7jdDR/4rCLZP4lHEFBEDZVz3tKDOKV/a7LhGGgArnWbHXgMJUUl/GuEqBKVOTn+0Q7/46kFfowo3iZO4OFdWl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218b:b0:366:2f1c:2b94 with SMTP id
 j11-20020a056e02218b00b003662f1c2b94mr288664ila.5.1710596223292; Sat, 16 Mar
 2024 06:37:03 -0700 (PDT)
Date: Sat, 16 Mar 2024 06:37:03 -0700
In-Reply-To: <dc93c896-19f9-4b6b-aabd-742cc8afae84@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003e6b710613c738d4@google.com>
Subject: Re: [syzbot] [io-uring?] KMSAN: uninit-value in io_sendrecv_fail
From: syzbot <syzbot+f8e9a371388aa62ecab4@syzkaller.appspotmail.com>
To: asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in io_sendrecv_fail

=====================================================
BUG: KMSAN: uninit-value in io_sendrecv_fail+0x91/0x1e0 io_uring/net.c:1341
 io_sendrecv_fail+0x91/0x1e0 io_uring/net.c:1341
 io_req_defer_failed+0x3bd/0x610 io_uring/io_uring.c:1050
 io_queue_sqe_fallback+0x1e3/0x280 io_uring/io_uring.c:2126
 io_submit_fail_init+0x4e1/0x790 io_uring/io_uring.c:2304
 io_submit_sqes+0x19cd/0x2fb0 io_uring/io_uring.c:2480
 __do_sys_io_uring_enter io_uring/io_uring.c:3656 [inline]
 __se_sys_io_uring_enter+0x409/0x4390 io_uring/io_uring.c:3591
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
 __se_sys_io_uring_enter+0x409/0x4390 io_uring/io_uring.c:3591
 __x64_sys_io_uring_enter+0x11b/0x1a0 io_uring/io_uring.c:3591
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

CPU: 0 PID: 5482 Comm: syz-executor.0 Not tainted 6.8.0-syzkaller-00721-g6c677dd4eac2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
=====================================================


Tested on:

commit:         6c677dd4 io_uring/net: ensure async prep handlers alwa..
git tree:       git://git.kernel.dk/linux.git io_uring-6.9
console output: https://syzkaller.appspot.com/x/log.txt?x=17f26711180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a271c5dca0ff14df
dashboard link: https://syzkaller.appspot.com/bug?extid=f8e9a371388aa62ecab4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

