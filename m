Return-Path: <linux-kernel+bounces-50820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4167847E4C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 03:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58FE21F28B36
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 02:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87F27462;
	Sat,  3 Feb 2024 02:07:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC09B6AAD
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 02:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706926026; cv=none; b=Co0Z/QdHX/bq3iBe3TiFYz+q7eJssZxKnvtcJex+7neC/oMce68SHVXcBiT3ARTgZmfoGKEF8kOhVK7xu95QiUgxTWlIfulKxXtbxSb4rUGnNyICtNj60UR8y0b5vkYNyiFj9fUeXKr3RbIMw3uYoa0OWQQwHS5DzWvsaAJ6FbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706926026; c=relaxed/simple;
	bh=i+JDF/U16A0h2ReCuKESPregCblwWsIb8m6CUL60Wpc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tqYy2e87dDmm2uVt3tZyGDvLOlTmfcGhyfQo+few0+H8oTmU9WSfevmL1lzzLQGqlO59mkQGc3i1FlZJij+A2D9u/JLhsuDkgbVV4hiRerMsyk6NwhBw4KXieoILuKGcq+wzXYZCo1HwPodj/XCF5yMu0MhfkISlrx+L74zQvBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-363930ba977so18549115ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 18:07:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706926024; x=1707530824;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gbrmRoGKWhe6TCC1sGE2MFNaSiHwcC3ZaDKpsmrHR/s=;
        b=t+AR+Qx8WM60kF1ktBGsj0VLNvMzTD1mbl7ahu3GKDid2vLMHybW+i8K0ZNEBpZb22
         DCnCbxchqoPVsW3IIHeRib1hEFl/DvJGxztuTFzheZWvbF8/pFVremwKyLs1/NxNWaJt
         XgT9b0NCEb/AoKMHhi9p3cjFR/zyDIF8z6wtDua9sQB853MRXEGUqK59dJMThGDkmsF2
         vYS681dhpbOIODskNXW04P7DW6G1LPZfB2kfxQ1/HWMTXh1q3DL7AwMY54cXhIFPR9rP
         kZVo7U+tPoWBIXrzP3qtwrfJyrAJMZYvaGgU72VC18xAKoae6IuPJvXlSZgT5Tr11fkl
         8YbQ==
X-Gm-Message-State: AOJu0YyHip1/lCHYVrhnPg78B7UeEbo7ql/sKGvMH1/tr/28J4Pthmvp
	/zpeN5Qh8fZ3+jfmQK/vh+EvZ+XBzEn+FBBO2/NEkFBA7tJflLKQGVz0UyykKBodBdRzMaG+fuf
	qK0/40gbbCT5ssE0ezstdY4byjEOCPv3nkwGu9uU59lboT9jS/ICaFB4=
X-Google-Smtp-Source: AGHT+IHwGrrxGICgqXvjF1ce4ToGFnpyWKkdzcU/b4TT1Lnl5bhAvElMzunisL/xzV0/F+QhMt/En7jAWF2jmQunOuCuK0a1HyCw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:170d:b0:363:85de:452c with SMTP id
 u13-20020a056e02170d00b0036385de452cmr341535ill.0.1706926024094; Fri, 02 Feb
 2024 18:07:04 -0800 (PST)
Date: Fri, 02 Feb 2024 18:07:04 -0800
In-Reply-To: <0000000000002a909705eb841dda@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000052fe42061070afc4@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in btrfs_block_rsv_release
From: syzbot <syzbot+dde7e853812ed57835ea@syzkaller.appspotmail.com>
To: 18801353760@163.com, anand.jain@oracle.com, brauner@kernel.org, clm@fb.com, 
	dsterba@suse.com, johannes.thumshirn@wdc.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, nathan@kernel.org, 
	ndesaulniers@google.com, syzkaller-bugs@googlegroups.com, trix@redhat.com, 
	yin31149@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit a1912f712188291f9d7d434fba155461f1ebef66
Author: Josef Bacik <josef@toxicpanda.com>
Date:   Wed Nov 22 17:17:55 2023 +0000

    btrfs: remove code for inode_cache and recovery mount options

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=149a0a38180000
start commit:   7287904c8771 Merge tag 'for-linus-2023011801' of git://git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d24faf5fc10540ae
dashboard link: https://syzkaller.appspot.com/bug?extid=dde7e853812ed57835ea
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14f7a805480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10df5afe480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: remove code for inode_cache and recovery mount options

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

