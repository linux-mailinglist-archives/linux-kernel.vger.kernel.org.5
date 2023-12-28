Return-Path: <linux-kernel+bounces-12414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A76A981F470
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 04:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E4481F22552
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 03:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2158B15CE;
	Thu, 28 Dec 2023 03:38:05 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6771E1104
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 03:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7b7fac89006so732926139f.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 19:38:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703734682; x=1704339482;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwwRsR2RsGSvqYppsdxwv/R0tnZKoPBI+4HEp499yd8=;
        b=FVJO2fpLZN0I2h/R1d8HSsh0DhhAIoAMLoXtiHQBS9uyl9a3yWb/BTFmJkUtunBkRB
         kM4vb6h7aguKL5VffFCt8MEbvJoIzQXKiOpwjC180KRBkUb/QvL58YyFbsEyv9dw4Rky
         cmGuQ40K9fhRjf54UtSeVrhYCr57jpxz0yHOiN4SeqQi2g71IDPi67ufBPunXNHIvKPt
         DMIcD5EBo6S8rWH3/3hB8b7J/K2vKhBLB0phzqitG90nGTOxyb/a2EN80ldQ9dIHIYRS
         DrNYmM6Io5O/Kh8LA3inFVCJZxCyFY1gJv04jN77L0okUmejGvzbIYj1VX3SKtLNlJsD
         8d1Q==
X-Gm-Message-State: AOJu0YxVLAMbWcIV5Vp3R+SUC0vcRc/KwM6PCqpCtaEvQ1iWryLMWgSo
	1piGMY7Jkrc3r4uSVba2LGP6U3nHBpuSvZAncPmX3Y/ql7Q/Djk=
X-Google-Smtp-Source: AGHT+IFZun6R3kRPuzEgKl+IiHKaHyzAqegidP17pbBv2Q0JMPe/A0vk2nNeqq98rCXh8V/H9RQRD5y2U4Al0Ds2P2mHs9SmzDOR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0c:b0:35f:c8aa:b526 with SMTP id
 i12-20020a056e021d0c00b0035fc8aab526mr1307617ila.2.1703734682707; Wed, 27 Dec
 2023 19:38:02 -0800 (PST)
Date: Wed, 27 Dec 2023 19:38:02 -0800
In-Reply-To: <20231228011133.3820766-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008df07a060d89a473@google.com>
Subject: Re: [syzbot] [erofs?] KMSAN: uninit-value in z_erofs_lz4_decompress (2)
From: syzbot <syzbot+6c746eea496f34b3161d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in z_erofs_lz4_decompress

erofs: (device loop0): mounted with root inode @ nid 36.
erofs: (device loop0): z_erofs_lz4_decompress_mem: failed to decompress -12 in[46, 4050] out[917]
=====================================================
BUG: KMSAN: uninit-value in hex_dump_to_buffer+0xae9/0x10f0 lib/hexdump.c:194
 hex_dump_to_buffer+0xae9/0x10f0 lib/hexdump.c:194
 print_hex_dump+0x14c/0x3d0 lib/hexdump.c:278
 z_erofs_lz4_decompress_mem fs/erofs/decompressor.c:252 [inline]
 z_erofs_lz4_decompress+0x257e/0x2a70 fs/erofs/decompressor.c:311
 z_erofs_decompress_pcluster fs/erofs/zdata.c:1290 [inline]
 z_erofs_decompress_queue+0x338c/0x6460 fs/erofs/zdata.c:1372
 z_erofs_runqueue+0x36cd/0x3830
 z_erofs_read_folio+0x435/0x810 fs/erofs/zdata.c:1843
 filemap_read_folio+0xce/0x370 mm/filemap.c:2323
 do_read_cache_folio+0x3b4/0x11e0 mm/filemap.c:3691
 read_cache_folio+0x60/0x80 mm/filemap.c:3723
 erofs_bread+0x286/0x6f0 fs/erofs/data.c:46
 erofs_find_target_block fs/erofs/namei.c:103 [inline]
 erofs_namei+0x2fe/0x1790 fs/erofs/namei.c:177
 erofs_lookup+0x100/0x3c0 fs/erofs/namei.c:206
 lookup_one_qstr_excl+0x233/0x520 fs/namei.c:1609
 filename_create+0x2fc/0x6d0 fs/namei.c:3876
 do_mkdirat+0x69/0x800 fs/namei.c:4121
 __do_sys_mkdirat fs/namei.c:4144 [inline]
 __se_sys_mkdirat fs/namei.c:4142 [inline]
 __x64_sys_mkdirat+0xc8/0x120 fs/namei.c:4142
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
 __alloc_pages+0x9a4/0xe00 mm/page_alloc.c:4591
 alloc_pages_mpol+0x62b/0x9d0 mm/mempolicy.c:2133
 alloc_pages mm/mempolicy.c:2204 [inline]
 folio_alloc+0x1da/0x380 mm/mempolicy.c:2211
 filemap_alloc_folio+0xa5/0x430 mm/filemap.c:974
 do_read_cache_folio+0x163/0x11e0 mm/filemap.c:3655
 read_cache_folio+0x60/0x80 mm/filemap.c:3723
 erofs_bread+0x286/0x6f0 fs/erofs/data.c:46
 erofs_find_target_block fs/erofs/namei.c:103 [inline]
 erofs_namei+0x2fe/0x1790 fs/erofs/namei.c:177
 erofs_lookup+0x100/0x3c0 fs/erofs/namei.c:206
 lookup_one_qstr_excl+0x233/0x520 fs/namei.c:1609
 filename_create+0x2fc/0x6d0 fs/namei.c:3876
 do_mkdirat+0x69/0x800 fs/namei.c:4121
 __do_sys_mkdirat fs/namei.c:4144 [inline]
 __se_sys_mkdirat fs/namei.c:4142 [inline]
 __x64_sys_mkdirat+0xc8/0x120 fs/namei.c:4142
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

CPU: 1 PID: 5483 Comm: syz-executor.0 Not tainted 6.7.0-rc7-syzkaller-00003-gfbafc3e621c3-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
=====================================================


Tested on:

commit:         fbafc3e6 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=167c416ee80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0c7078a6b901aa3
dashboard link: https://syzkaller.appspot.com/bug?extid=6c746eea496f34b3161d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1576ce6ee80000


