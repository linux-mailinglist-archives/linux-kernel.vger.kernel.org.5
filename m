Return-Path: <linux-kernel+bounces-105230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B57187DACE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 17:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2862628236F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 16:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3A81BC4C;
	Sat, 16 Mar 2024 16:29:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124151BC20
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710606544; cv=none; b=Hg8xkrcvRpotR5aY89VSqeWPNfTxf7jBwYMw4E6HTXAEKzjnS4PD8ew52kVJImho9SrL92M81/1ouc9toBkjx7uZZT/ze1aHfZNOr7O3+JDixpf5HF6asRXWmaxUMu1O1l3AENlNT3NkCHKOpGRgo48c+mPtfWMk4EU+aOxXY6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710606544; c=relaxed/simple;
	bh=Y0yhbc7ydnQqmzLmsuHCZOKD7hhbhRbIktCPFdDExSo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hAs1Fq45aGwqiELnE9G05Upz6zo3bedEJKkMObFV0aUS01UsPI54j6dwhA33CsQf7bFkfjiJtEIw/472782iaRZp186XgwHYH+liHGnmJ4tWsMAEQ1GS/GXaotVKc1GG+ll8f03AN5EzO2zguw4uPGrXjWaVsdszD6H/YSnlmgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-366a7e3099bso11702525ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 09:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710606542; x=1711211342;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JKegllEXc4OdWtS04GQ5DNgtrIzoudxXYDeDXhOiLCA=;
        b=pmndI8/kO+yEyYGwe+icdr1GovcdPR0nOeFL65vCnRNZQqjjsS1mJRoEzIp6oKlNSc
         pXionzOofzr1v9PCl7noaqZmZX9IvrIQly95AGYcKt+Ls0r+mAm5JRRYoGOL2x7oETOh
         LGEKwMa5LdWMtQWOnoaNnUs+wduuccuVrtT6avS3PlhB+QIr/j81u2VeEZm5XMi0Oa28
         gDvA7U1EFf9pxctgeHiKDv8Q3aHtg2WDPr5zWNcPECPG3eeBImuGj6l1Mo2l3O09bi7L
         PJNBDhKkhUSAgWfyfnD4VvgA0/5/iMLIECdfDWKqPYQCrIx9GdZNphZzlGA4ZNVwb5pY
         EcoA==
X-Forwarded-Encrypted: i=1; AJvYcCUIoTurtbYEv080UMuSo2XPhO0fZU9eKtFr2VMawN6HR3JotSezfcRg/rZMZos6wnaLQe31S8Phy7TslYKKN/QlW54EQQjQDCg4Cd0O
X-Gm-Message-State: AOJu0YxZvhtkcvVizvPtIE70X3yk721l7BD1lxTwLRD5e7wMdrG1v+0c
	Wv0/AQLCtSuIoESQLSVSKT8VHXfDolaGQp5PYp1UEd+jmsAP1crO3B2I8bOX5FmME4BlIF3qYMr
	uFYe7dWZl2pHiQI0RkIrct/83+i/AXvlbqArF4CdPJz3gCeaiyVOxZrM=
X-Google-Smtp-Source: AGHT+IEoK+zNLWyJJmOEUTNpKE4dYQelUBa9p8rbSTAXYJ9sL6fs50GcdeMzNy5Q/oqRlPX9chbmssw0v+uvfVRMRYAJgM8FI8D5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d86:b0:366:b7d7:9734 with SMTP id
 h6-20020a056e021d8600b00366b7d79734mr48661ila.3.1710606542282; Sat, 16 Mar
 2024 09:29:02 -0700 (PDT)
Date: Sat, 16 Mar 2024 09:29:02 -0700
In-Reply-To: <6e00b097-99db-44dc-a87b-08925c1f044d@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004db6840613c99fc6@google.com>
Subject: Re: [syzbot] [io-uring?] KMSAN: uninit-value in io_sendrecv_fail
From: syzbot <syzbot+f8e9a371388aa62ecab4@syzkaller.appspotmail.com>
To: asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in io_sendrecv_fail

=====================================================
BUG: KMSAN: uninit-value in io_sendrecv_fail+0x91/0x1e0 io_uring/net.c:1334
 io_sendrecv_fail+0x91/0x1e0 io_uring/net.c:1334
 io_req_defer_failed+0x456/0x6d0 io_uring/io_uring.c:1050
 io_queue_sqe_fallback+0x1e3/0x280 io_uring/io_uring.c:2126
 io_submit_fail_init+0x4e1/0x790 io_uring/io_uring.c:2310
 io_submit_sqes+0x1a60/0x3030 io_uring/io_uring.c:2486
 __do_sys_io_uring_enter io_uring/io_uring.c:3662 [inline]
 __se_sys_io_uring_enter+0x409/0x4390 io_uring/io_uring.c:3597
 __x64_sys_io_uring_enter+0x11b/0x1a0 io_uring/io_uring.c:3597
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
 io_submit_sqes+0xaa2/0x3030 io_uring/io_uring.c:2475
 __do_sys_io_uring_enter io_uring/io_uring.c:3662 [inline]
 __se_sys_io_uring_enter+0x409/0x4390 io_uring/io_uring.c:3597
 __x64_sys_io_uring_enter+0x11b/0x1a0 io_uring/io_uring.c:3597
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

CPU: 0 PID: 5478 Comm: syz-executor.0 Not tainted 6.8.0-syzkaller-00721-g3fdefe13e0a9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
=====================================================


Tested on:

commit:         3fdefe13 io_uring: explicitly flag early request failure
git tree:       git://git.kernel.dk/linux.git io_uring-6.9
console output: https://syzkaller.appspot.com/x/log.txt?x=15c58006180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a271c5dca0ff14df
dashboard link: https://syzkaller.appspot.com/bug?extid=f8e9a371388aa62ecab4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

