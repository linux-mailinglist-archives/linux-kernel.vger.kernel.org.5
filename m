Return-Path: <linux-kernel+bounces-158313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E248B1E2E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29544B263CA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C5A84D3E;
	Thu, 25 Apr 2024 09:39:07 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D6484D12
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 09:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714037947; cv=none; b=T2kX8tMtOxEz91s6TXRMyAyHgnZPnR3tRATMegwAcJrZbeEUf1deXQiEph14YVgbiFWymUmS1dfrp8KMi4hVEL3hVlCaue+DXKhayXr0gTi0SftxZUx7GDbIPKV/3MHKHhsYd0SiCk89a0zGABjasVKZiKnIaEkLFNMNzBfxSxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714037947; c=relaxed/simple;
	bh=03lT3XxSci3zPv9hrgEFljQ+R9NGQW8uarqB1lXxEPQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=th6mQ1ezJTDfAOGbqHeMJtzv+2NxLeFCFRCsDULchDp87mV1PYnqZXcpOQWGXnTPcsodbo78+CNVqlU1zrEHmk5xKgeGf9knQVKWtysQK6OQ+t4pBc/+nSZ0C1dNmIx0nCoRZu/N4bWxA2CZ2iHbXsu4pQQWM6OqOKD+hHG0BJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7ddf0219685so85141639f.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 02:39:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714037945; x=1714642745;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZT4FzdSo4L6YgWDEaAIanhrPCvvpAdi/DehWaqFisg=;
        b=MnMsC/2XW8JN/rdP9bRGptvrK8HQjYnYLTWmwovTcUeR/yO2w/Nj5RzdjTrFjAWTKk
         MsCUDGqyTgnq6vEMUZB7u1NI68nPqNIhhREBxz4f5211AYfGnNNWNrMPScnefwbbHVAI
         B01fE6CSClv1siILmX96/zyIeaKn4NUvepMB2e7OT3APotsspKUFTvALdd+fXZ5v8E5Z
         MB/DfEMnToWoI1E4aA2m100/wVT5Acbzth4Hp/ky2L+qeYs5OkCqhtx5wTGbFNr6S51m
         osP5RlW1LUyBdtDjd3/fAMKcHb9m5P6JsCPq4z6j0LrYCJaPMo0JOdsMG9pDOCPy/Bdx
         0WJA==
X-Forwarded-Encrypted: i=1; AJvYcCUviM7Hf/lUn8n1YOUraPQmQI/asspJisyf8Px9PY6XbXoBkkgnTqjc/lvpSw+uPDziEWXU1ItOGou8u0ibVaoTtsUIOmymPUvJNLz5
X-Gm-Message-State: AOJu0Yx1+B2m64D2WMW/c6/omHMa6c2xj9QHGVkjdAjDucgtZcdqefDf
	j35L/h7xicbOmKXcve/0IqTvHkyX1fh4aZeGq0DVgN6E3DAIqrEMtZNkTpbpNyRARsYDOT7rdN1
	7DOMH6h4RIB79fUHk3tuB0eXwtbpi0Ypfs93JiH32chDMASYq77PDO2k=
X-Google-Smtp-Source: AGHT+IHpUekD78pcsKwOWCM0FNp6vPL+TnGRCGFb+iegtNlyAHwEAPDflY5qr+SUES9Dcl14paCfW6BJuIRoKxMNsTMEGWQ1EG9Q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:150e:b0:485:7a8:42a6 with SMTP id
 b14-20020a056638150e00b0048507a842a6mr424174jat.0.1714037943921; Thu, 25 Apr
 2024 02:39:03 -0700 (PDT)
Date: Thu, 25 Apr 2024 02:39:03 -0700
In-Reply-To: <20240425090403.15270-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c780b90616e88e79@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in diFree
From: syzbot <syzbot+241c815bda521982cb49@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
UBSAN: array-index-out-of-bounds in diFree

140741783322624 13 524288
------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in fs/jfs/jfs_imap.c:888:2
index 524288 is out of range for type 'struct mutex[128]'
CPU: 1 PID: 111 Comm: jfsCommit Not tainted 6.9.0-rc5-syzkaller-00042-ge88c4cfcb7b8-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_out_of_bounds+0x121/0x150 lib/ubsan.c:429
 diFree+0x21ec/0x2fe0 fs/jfs/jfs_imap.c:888
 jfs_evict_inode+0x32d/0x440 fs/jfs/inode.c:156
 evict+0x2a8/0x630 fs/inode.c:667
 txUpdateMap+0x829/0x9f0 fs/jfs/jfs_txnmgr.c:2367
 txLazyCommit fs/jfs/jfs_txnmgr.c:2664 [inline]
 jfs_lazycommit+0x49a/0xb80 fs/jfs/jfs_txnmgr.c:2733
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
---[ end trace ]---
Kernel panic - not syncing: UBSAN: panic_on_warn set ...
CPU: 1 PID: 111 Comm: jfsCommit Not tainted 6.9.0-rc5-syzkaller-00042-ge88c4cfcb7b8-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 panic+0x349/0x860 kernel/panic.c:348
 check_panic_on_warn+0x86/0xb0 kernel/panic.c:241
 ubsan_epilogue lib/ubsan.c:236 [inline]
 __ubsan_handle_out_of_bounds+0x141/0x150 lib/ubsan.c:429
 diFree+0x21ec/0x2fe0 fs/jfs/jfs_imap.c:888
 jfs_evict_inode+0x32d/0x440 fs/jfs/inode.c:156
 evict+0x2a8/0x630 fs/inode.c:667
 txUpdateMap+0x829/0x9f0 fs/jfs/jfs_txnmgr.c:2367
 txLazyCommit fs/jfs/jfs_txnmgr.c:2664 [inline]
 jfs_lazycommit+0x49a/0xb80 fs/jfs/jfs_txnmgr.c:2733
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..


Tested on:

commit:         e88c4cfc Merge tag 'for-6.9-rc5-tag' of git://git.kern..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ master
console output: https://syzkaller.appspot.com/x/log.txt?x=135717bb180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a05c230e142f2bc
dashboard link: https://syzkaller.appspot.com/bug?extid=241c815bda521982cb49
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14aea028980000


