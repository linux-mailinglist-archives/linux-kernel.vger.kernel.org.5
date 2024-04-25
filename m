Return-Path: <linux-kernel+bounces-158293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FEA8B1DF2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDD22283052
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6488127E2E;
	Thu, 25 Apr 2024 09:23:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DD4127E10
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 09:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714036984; cv=none; b=lUZH4d7eYkRJUNi2cZIHaIlyf94ciOV15joUFmuSmrG9FDQEEUoRltvIAl0qmdtNbouRZ78juaHwV+l5Y5YVz4l7ExdND5WjBIL+FTD2x6xkUHqF1hQfLyBmMLLxcmlW7VjSCf0LJ1nODbUN0/oZ9TEKn/IWRRBTWi4iV5AO7x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714036984; c=relaxed/simple;
	bh=C8pKvelxTl855r1qnodZl3DM2DjQHEGYnIW4pA2VVEE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Vt0FHOvn2Lnmx5R9313HTlaNNs7Iru7s5ZgPXJjMA+nXu/smNhXGF+rF5zfG01xAjksGhEtwOzQ02Dnb6Hx81xtmF4/UOOOz38WAOCr4Kr7CV58OqtrUszzk90H65lPBdqPB7HFudKj0e78ZdA1G8suh55b3+/H5sDMht0IOoxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7d667dd202cso127176339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 02:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714036982; x=1714641782;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GxgnLbVsF+cdI25nLGbFIVjccBnjxuF1lXju4CE03lM=;
        b=sLtJ+r+Ulj34uvP90R4X0Lygolz/8ExTIUuXjxqQmOaxrluG/oh1wpJBA4vwOAh5O+
         hHTItxLrdHRNoW8BtvycaugCD1GRzCscTR80q4MaGQvF8NM7/amC1qvYCh4mcud3IGQb
         wFgv04Ma9BnWm5Oxec3hhfwl1fIWEiYJ+zKafNAnnZGx2cTqdEwEy+Imh5o4ImnfwFPm
         8Z+hfM/28lJQpvZMSHnW7Dm8nI4kzVIjotNd2/EMpsnEG+PT6368FD1eOVXC0LoxAtGt
         Te5rkaEP3eitlol5HuQ4UArC5zlBbCTYVsd2f29hvJtyVlf2DOkWoiANy8bhdTMMZcUE
         92GA==
X-Forwarded-Encrypted: i=1; AJvYcCUcuBNkfk1hf5IFcTNsS+Wgv0DrkJL9z/XcFVWVBAt/ySh+clmrrU77uIsbbJq/JckTdWnO+5LdDOV22hZi4b5jma0Rrb4c+GR1FoyB
X-Gm-Message-State: AOJu0Yyid6xnYUTEcgIoNxqcefylK+9FIQHv3jIVb3iGe2mk8YDOqxXW
	Qcxiht8uMejvLEQsMjpcmZ/AXnW3CPqIYtTl0P3/4h1N7EbSHGEVqRExV5SoUu0hAtgKcc9GzG4
	3LNMTsPg1e9bFsvsbMtpHQtb+zEWgjnSQH5Laxl6luM9h4pZNPEDoFwY=
X-Google-Smtp-Source: AGHT+IEQD7NcOiXARGmbNmQ+ifrpftRyMRydp0cQoNoJfXA94iJc4xGfU8Kn6822jC9cSsNfRw9RgGxTKObJ7P+/k1fNJd/p1ehu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3789:b0:487:2743:dcba with SMTP id
 w9-20020a056638378900b004872743dcbamr2094jal.2.1714036981937; Thu, 25 Apr
 2024 02:23:01 -0700 (PDT)
Date: Thu, 25 Apr 2024 02:23:01 -0700
In-Reply-To: <20240425085654.10967-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000070cba60616e855eb@google.com>
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
CPU: 0 PID: 112 Comm: jfsCommit Not tainted 6.9.0-rc5-syzkaller-00042-ge88c4cfcb7b8-dirty #0
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
CPU: 0 PID: 112 Comm: jfsCommit Not tainted 6.9.0-rc5-syzkaller-00042-ge88c4cfcb7b8-dirty #0
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
console output: https://syzkaller.appspot.com/x/log.txt?x=1151ccef180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a05c230e142f2bc
dashboard link: https://syzkaller.appspot.com/bug?extid=241c815bda521982cb49
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=145717bb180000


