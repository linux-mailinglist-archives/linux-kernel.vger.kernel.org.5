Return-Path: <linux-kernel+bounces-158032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E7E8B1A6D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A07CB2423E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC0E3C08D;
	Thu, 25 Apr 2024 05:50:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D083BBD6
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 05:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714024205; cv=none; b=NC9VpeNGCqL7eNX6zBI8NB6THTIUHY+f0QlUGEvDJ5ZiWngl73ar7kE3XsSo+toM7gVkRJXQKKybUzn9zrSxgdDhMRN5ocM2q6hcKmJytq/MVd4j3t4jE9KXGzywTO8dTo4DcbypxmCwpngkOqYPLVTCC2JkktY9rqGsCJsUz1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714024205; c=relaxed/simple;
	bh=DS8+UoARwYL4pBRF3hGOmYjTIW5bgTAhHnDVVHKtn2Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=o11jIT4hVGkzHiLPe8eF+tbgvw0OFsjqEwGjTJiPemeJ8Cqefqu0XJZltPpauhCUpE0hA34AdhjF5hpb09qixTLvrJbYqs6973VLPeh0vFLvMtDFswYFurq+1tPfhWs2y9ZIXDf+pva+CW+dzdGUuedDYcMBy3aJMYd/CHtSRhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7dda529a35cso66755139f.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 22:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714024203; x=1714629003;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8/x6bdGbpARWvs13fzGI269cZymC7yzllj2CI+dsG0Q=;
        b=deMECbtCixWQeqLtrBXQ4Uo2TNEx5BrTJ8Nah4VzAyvbB/wNNmKp5UMDjHs+kevkv+
         DZ9R1Anm3cXGISsx383aAAhp8oXQbPBb9meWLswBvPbLGsuRd3zLIF4J6aGegt/DW2ve
         wl1YAm1uMZZeNy9ti1WUTFY9Yw700kGWFr3Pn8Gr2KyZwUE7IBTfyYvosHPHK4ZYXKEr
         O280j9MqSRfGg2KsBI3TaJ1vcHCoW2AEswpgYovgJrioi8cpv/3YR8YERofeVijrISIG
         pVZdzsyD4eJ/5o/+A+wHBF7KsW8ZhuIAXcGZnOJEdCl20DrHm0XJN+80kZvaRip8kIIR
         QSBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfbeNyYJJ0lr4pODNDwKGIqVcz35gMaFYT8ITyC9ndmELyWaBb4/dn+435olZ/JVi04msK0EhPIRXlKsCLAfcfwur7WbdmkCnHb91Y
X-Gm-Message-State: AOJu0YxoeNvomobcZbjJh1hsdyZXv3P3cWN3kg3TN/gZU2qJtazduttA
	sNA352GYK5IcbcLU0CsKwYUd3wAFy/879xZH4xuuywoqONvj8SrcnJwPJDLGL49EPXJPjVolHIL
	VGRyIrP92hoc1U4ValoKCUBCrZMR/O4kHy9jJ9LqtYh+4ekTny/IuSZE=
X-Google-Smtp-Source: AGHT+IEl8K6QtgtS8wSZGB4ofv4LO2dBnrafZMIOWkU+BL6NM/k6fBECzQhVRNCBM9+D8TgzvHzBVxaW/8azYLJNaFa9db2bvqFs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8629:b0:486:e04f:90c2 with SMTP id
 iu41-20020a056638862900b00486e04f90c2mr392399jab.4.1714024203141; Wed, 24 Apr
 2024 22:50:03 -0700 (PDT)
Date: Wed, 24 Apr 2024 22:50:03 -0700
In-Reply-To: <20240425045953.6360-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c3d7500616e55b38@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in diFree
From: syzbot <syzbot+241c815bda521982cb49@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
UBSAN: array-index-out-of-bounds in diFree

------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in fs/jfs/jfs_imap.c:886:2
index 524288 is out of range for type 'struct mutex[128]'
CPU: 1 PID: 111 Comm: jfsCommit Not tainted 6.9.0-rc5-syzkaller-00042-ge88c4cfcb7b8-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_out_of_bounds+0x121/0x150 lib/ubsan.c:429
 diFree+0x21c3/0x2fb0 fs/jfs/jfs_imap.c:886
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
 diFree+0x21c3/0x2fb0 fs/jfs/jfs_imap.c:886
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
console output: https://syzkaller.appspot.com/x/log.txt?x=1104a90f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a05c230e142f2bc
dashboard link: https://syzkaller.appspot.com/bug?extid=241c815bda521982cb49
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17d15237180000


