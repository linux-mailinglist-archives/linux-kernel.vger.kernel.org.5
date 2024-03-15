Return-Path: <linux-kernel+bounces-103931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EC487C6AF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 01:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E52C282141
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70271EC4;
	Fri, 15 Mar 2024 00:10:18 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5B063B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 00:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710461418; cv=none; b=OnVIs/3ZHHqF+M+6jx3EftrNrclZSVl5B4E3bnktZmbJdzVXmtfVghp9A4Zd8RFeIrlo51IMNnljkH4+g1uk+sI78MIPBTqA5TYG8VuCYbzmeaziCSD/iERBKZ78vy8AF6HwqdSqYXCqCuSauurSSXwaTCk6m1oZkvN8rRH70Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710461418; c=relaxed/simple;
	bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FlDWBGr3IktaFDSyb6XRbG4FVDH/Hey+yQ26GPPhcjZ0w8hGO9dYAfuz47qfIzX3oy1exNodgJKHP/E2H2hzaI+60+g37EVe8ILj+WvAczDeBbaqsn0ldqr6IbIklp0Tms1v0yhX/lk4XYIC63K5YHVdInnEECqx9M3ECXbqZxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3662fce6f54so15549805ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 17:10:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710461416; x=1711066216;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
        b=f8DrEdpgm0VLBzKqFfN3rl+NTDDrqPHIq9ecwqZ2DUKTFMAfEtDvKfsYIKQ9cqnn5U
         7Tm7wGnDI1Rzb61rpFWM23w9uTPMV5PVNQO3wu0F5EXLsX0Kw8afZV75/Rk9Y2hM9Sh3
         nAUk/mO/Mcqi7YLf/g8+wtj6/pN0pdR0zvCf3gSk0QG/eSGqUuzM41EH22dwPQ9sxJ6I
         Y0phWJVUsBEaCdDmDVU1M+6331PIiDIfY3JWBnJhDoW11U+r4LUONnZGAfAnVqUjf/++
         pcJm1PdCgT8wgu1B9GGI5wX065Pv1TtzyR9F9zUxzBGCbBObLEinxpmvheV92GIiyPZe
         lntw==
X-Forwarded-Encrypted: i=1; AJvYcCUWk1V2P6rTiCnCByDiA50xwTvzfKkOiXDbimXqrZToQ5c0rVjaexIBFCleXuD1u1TlmGOrXW2zdfZDD01i4zGqbn26ESLuAR293bl/
X-Gm-Message-State: AOJu0YwRW1g/9lZWrU6caLvT6AJ+oiaiQJ2dUQXUNLPN2oPmoL7Gbd+/
	yfylN6gvpEotYXVZ3n5qbT0YGAXU2J26qK0lnhj3sPLeZ1eb15QkBLP2kAgTVm9sM712EtWniDn
	jceDXC7UTbxqq7NoF1mIm/dY2mA28WwFecho15AVEMONUilFQPikKfo8=
X-Google-Smtp-Source: AGHT+IEwia3UBhvywO+h+u2pfZqh0yKTnkD0W9jpgVSgia1FcpQaoAm3+nW32+O04ra6I7mwds9hpKK7s+2ic/riJCglBAUa7ZfJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d16:b0:366:7922:950e with SMTP id
 i22-20020a056e021d1600b003667922950emr87913ila.6.1710461415855; Thu, 14 Mar
 2024 17:10:15 -0700 (PDT)
Date: Thu, 14 Mar 2024 17:10:15 -0700
In-Reply-To: <0000000000006fd14305f00bdc84@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000182dd10613a7d554@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_do_writepages
From: syzbot <syzbot+d1da16f03614058fdc48@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
ext4: fix race condition between buffer write and page_mkwrite

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=d1da16f03614058fdc48

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 9 trees can be found at
https://syzkaller.appspot.com/upstream/repos

