Return-Path: <linux-kernel+bounces-106655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3B087F196
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFD381F2224B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A18E1862C;
	Mon, 18 Mar 2024 20:52:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945D543AA3
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 20:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710795125; cv=none; b=NOoBrw7rAORXsJXz1DywhDZmVaOfTqiyWOcTGqun26SVLIIbw7YvM7Fc2YzfZBlbTFPwkBmYIBHDmZP2TGm7pDsjgSusP4jsgLacG+O7bAjTNLwfX4rN2TQJ7agMDOiQddhj2nibR+iPPenkWKFERuAsj65LzdEhtScM1ugI+8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710795125; c=relaxed/simple;
	bh=HEUE3wIivBf8wAHJFNdwE1Tb+ZJpLXeAcd5W9IpJEVs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sMhHzmfgPfqrE06CmiSslyXNMBQjw8qaip9ixei/9e8mGrH0b0k6h8+F/wXxd2fkuoIqRdfN9XDy097eAdrEah8P0H84H3hEguKEJNeyD1lMs/z0xH6qPqF8V46BnI20I62cPs702JmxJCsVuRBU4+NCyxZajtKjXQv+N8PYhL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cc70b85c48so107547539f.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 13:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710795122; x=1711399922;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IPRKdmMv9VGR7u9mGNuOA5GolZfpzVmf+geOTdGMtGI=;
        b=gn9yTXk9vF0IijM0EhmcViPncXqUwiPtjnzNkv6alwPZS6wo8J2TBp130CWXFuSs+S
         Nq5EgyzIXFcVZi8CX2zMLNT8FYNsdMVNDp53B3Qf7mViAecR4B6oyyapSFo+ncKr274y
         l/86ehcdnXfTiG5+e+kyB9Uz5SANKX3p/snGaFYa7/7AiV3fkbXugzeDT/9uDmjMKeV2
         NJEWS5IsVX9b0KNNLYfL6I4ck6vzS8LLVF3WWSyacvXYBBnI46GVV4AMtp7wacnw60et
         u1g8oaDAcOUSmCXXaMzt9Q00R6VNsziIH6ljRCrDledde8NC5jvvVwNy30XNx2S4pWfV
         IVnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtHkVVCBMF7k0JBXz+rEDEotVSI4MDLJMeOZ5kAObMVrC83fUYksFd2JJMFOstoCX2HlwuEh10O/YddOQlxP5Oibi306mGh2c+VR/f
X-Gm-Message-State: AOJu0Yz/7yvridMBd9aqZ6qeC52y2SVGXsGLi5HuwIAPB96n5z8ajrHq
	O3f3fIj3NryXSkwaZ/Q+BHCdqYG6Eah6c3FSA1en6e38GbYnYoF7AaLwV+qEk7Gq+JPm8OHbxRj
	YeR9slxtaFDqWqrPhfM815Hj71ax+IgznPspcxkODzPELci0UQ9zAqMo=
X-Google-Smtp-Source: AGHT+IHXI+OIILEa0jZdjsW0+t1H2RQUmkH69aO9YyE7mppvpnn9ibbZfBaJlRoL7j31p2ZQbD5nLLPRuKJR5Mi2Ok1++lX6jyKL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd83:0:b0:366:c326:f305 with SMTP id
 r3-20020a92cd83000000b00366c326f305mr22043ilb.4.1710795122674; Mon, 18 Mar
 2024 13:52:02 -0700 (PDT)
Date: Mon, 18 Mar 2024 13:52:02 -0700
In-Reply-To: <20240318204212.36505-1-21cnbao@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009221d60613f58726@google.com>
Subject: Re: [syzbot] [mm?] kernel BUG in sg_init_one
From: syzbot <syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com>
To: 21cnbao@gmail.com, akpm@linux-foundation.org, chengming.zhou@linux.dev, 
	hannes@cmpxchg.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	nphamcs@gmail.com, syzkaller-bugs@googlegroups.com, yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in __kmap_to_page

------------[ cut here ]------------
WARNING: CPU: 0 PID: 3529 at mm/highmem.c:167 __kmap_to_page+0x100/0x194 mm/highmem.c:167
Modules linked in:
Kernel panic - not syncing: kernel: panic_on_warn set ...
CPU: 0 PID: 3529 Comm: syz-executor.0 Not tainted 6.8.0-syzkaller #0
Hardware name: ARM-Versatile Express
Backtrace: 
[<8185fe64>] (dump_backtrace) from [<8185ff60>] (show_stack+0x18/0x1c arch/arm/kernel/traps.c:256)
 r7:00000000 r6:82622e44 r5:00000000 r4:81fc00fc
[<8185ff48>] (show_stack) from [<8187d720>] (__dump_stack lib/dump_stack.c:88 [inline])
[<8185ff48>] (show_stack) from [<8187d720>] (dump_stack_lvl+0x54/0x7c lib/dump_stack.c:114)
[<8187d6cc>] (dump_stack_lvl) from [<8187d760>] (dump_stack+0x18/0x1c lib/dump_stack.c:123)
 r5:00000000 r4:82857d18
[<8187d748>] (dump_stack) from [<81860a08>] (panic+0x120/0x358 kernel/panic.c:348)
[<818608e8>] (panic) from [<80243844>] (check_panic_on_warn kernel/panic.c:241 [inline])
[<818608e8>] (panic) from [<80243844>] (print_tainted+0x0/0xa0 kernel/panic.c:236)
 r3:8260c584 r2:00000001 r1:81fa8e48 r0:81fb09f0
 r7:80477264
[<802437d0>] (check_panic_on_warn) from [<80243a38>] (__warn+0x7c/0x180 kernel/panic.c:694)
[<802439bc>] (__warn) from [<80243cb4>] (warn_slowpath_fmt+0x178/0x1f4 kernel/panic.c:719)
 r8:00000009 r7:81fd71bc r6:df9b1bf4 r5:83682400 r4:00000000
[<80243b40>] (warn_slowpath_fmt) from [<80477264>] (__kmap_to_page+0x100/0x194 mm/highmem.c:167)
 r10:00000000 r9:ff7e7f14 r8:83e402c0 r7:dedf0b48 r6:800fd004 r5:ffefd000
 r4:7fefd004
[<80477164>] (__kmap_to_page) from [<804c248c>] (kmap_to_page include/linux/highmem-internal.h:63 [inline])
[<80477164>] (__kmap_to_page) from [<804c248c>] (zswap_decompress+0xc0/0x23c mm/zswap.c:1090)
 r9:ff7e7f14 r8:83e402c0 r7:dedf0b48 r6:ffefd004 r5:840fb8e8 r4:ff7e7ef4
[<804c23cc>] (zswap_decompress) from [<804c449c>] (zswap_load+0x15c/0x198 mm/zswap.c:1638)
 r9:846e3240 r8:846e3240 r7:846e3244 r6:dedf0b48 r5:00000010 r4:840fb8e8
[<804c4340>] (zswap_load) from [<804b9644>] (swap_read_folio+0xa8/0x498 mm/page_io.c:518)
 r9:8420fa00 r8:83682400 r7:00000000 r6:df9b1d4c r5:00000000 r4:dedf0b48
[<804b959c>] (swap_read_folio) from [<804bb064>] (swap_cluster_readahead+0x1c4/0x34c mm/swap_state.c:684)
 r10:00000000 r9:00000017 r8:df9b1d4b r7:00000000 r6:00000000 r5:00100cca
 r4:00000010
[<804baea0>] (swap_cluster_readahead) from [<804bb3b8>] (swapin_readahead+0x68/0x4a8 mm/swap_state.c:904)
 r10:df9b1eb8 r9:00000000 r8:00100cca r7:8371e2a0 r6:00000012 r5:00000000
 r4:00000001
[<804bb350>] (swapin_readahead) from [<8047cde0>] (do_swap_page+0x200/0xcc4 mm/memory.c:4046)
 r10:00000040 r9:00000000 r8:8420fa00 r7:8371e2a0 r6:00000012 r5:00000000
 r4:df9b1eb8
[<8047cbe0>] (do_swap_page) from [<8047e6c4>] (handle_pte_fault mm/memory.c:5301 [inline])
[<8047cbe0>] (do_swap_page) from [<8047e6c4>] (__handle_mm_fault mm/memory.c:5439 [inline])
[<8047cbe0>] (do_swap_page) from [<8047e6c4>] (handle_mm_fault+0x3d8/0x12b8 mm/memory.c:5604)
 r10:00000040 r9:83dfb900 r8:83682400 r7:8371e2a0 r6:001403b8 r5:83682400
 r4:00001254
[<8047e2ec>] (handle_mm_fault) from [<80215da8>] (do_page_fault+0x1c8/0x3a8 arch/arm/mm/fault.c:292)
 r10:00000007 r9:83dfb900 r8:83682400 r7:00000207 r6:00000254 r5:001403b8
 r4:df9b1fb0
[<80215be0>] (do_page_fault) from [<80216170>] (do_DataAbort+0x38/0xa8 arch/arm/mm/fault.c:558)
 r10:7eded670 r9:00000000 r8:80215be0 r7:df9b1fb0 r6:001403b8 r5:00000207
 r4:8261d0e0
[<80216138>] (do_DataAbort) from [<80200e3c>] (__dabt_usr+0x5c/0x60 arch/arm/kernel/entry-armv.S:427)
Exception stack(0xdf9b1fb0 to 0xdf9b1ff8)
1fa0:                                     00000000 00000000 00000000 00000000
1fc0: 00000002 7eded61c 00000000 000001f4 00140000 00000000 7eded670 00001238
1fe0: 00000000 7eded5a8 00000001 00021804 60000010 ffffffff
 r8:824a9044 r7:83682400 r6:ffffffff r5:60000010 r4:00021804
Rebooting in 86400 seconds..


Tested on:

commit:         e5eb28f6 Merge tag 'mm-nonmm-stable-2024-03-14-09-36' ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1491ea6e180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=19bb57c23dffc38e
dashboard link: https://syzkaller.appspot.com/bug?extid=adbc983a1588b7805de3
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12651546180000


