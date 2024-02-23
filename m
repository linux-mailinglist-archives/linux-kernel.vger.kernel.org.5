Return-Path: <linux-kernel+bounces-77722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAE4860977
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCF3F2842C1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20F0101C1;
	Fri, 23 Feb 2024 03:42:17 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC922CA73
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 03:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708659737; cv=none; b=qepGYV9nMNVoqAsJXX8+rXQyE/FoKdUHDGi7MpWM3uPxyyU4TkiSMmZXcX1IMnLDRU4MjNS16cBGGpzsPu0dxVH16Eq3q5tf7fdkyMR3PSvE/5HNbrpSrTN0eMzHN+66Jkk+pN1aUONUP1CpzTneRdaRh8/c/RHzPuEHkiYMRUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708659737; c=relaxed/simple;
	bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bnrzjWqM0eDru57n/3GDKORnqEOlFF6LWs9jR9HGQ6iidJs2Kr1htaCsh0JvcnaDNaIWxaFuwdJevd8FnQSdGsWFyu3HtsPyrzmlTK945fSuNFuztUHIWYe2Gz0yLnDtXrYl1gNFfJn2dsNxIBm6mYY7ajStHbEVF+Tjp3inBqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3650bfcb2bfso4636295ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 19:42:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708659735; x=1709264535;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
        b=PAZB5PpvXYcFed39wCizb1VVsyxKAgVk4PQFHOs8hdGFKXc1dsUPfkkejHtRzpRldI
         F7oRBRQZrTe/20bvPXYLsXMR8cz7qF0jj1jFE6bwA9vjGNCJTTrydu+azymCvem4H3KX
         2WfqC2Kkc2B4bjlD7eO679Uk2yNLyLyIuKrkL5xmKNZ5Tk0e0qPdJ/eRvd5OzszIsmUq
         /UyZFM6H5fvu0GiCcwh3AdaDn4Q1s6rrGtJ47iiMW8VsL8ED4vD+tZ49r6vyG+kq0sI9
         D4hqBFUKt+Xvr0TF534zss7Q+BBhk2d4FCpfIyUX5o/DJ0Ud1Yd5Ypw3OsbFSpWTSiCA
         96zg==
X-Forwarded-Encrypted: i=1; AJvYcCU8Pk154/AG0niwy9/ra3RMRWbNgJUwdQO6ksKPKBaJrTaBwvUmsPl3sU7hISLDBB2zJJgZNSguLaIm1c60qB7Ln+12g3ndApUgFBAT
X-Gm-Message-State: AOJu0YyQnX3EBUZ0guLP5eWEz1ihsHGZqhNH+jzOp6DItodpaKSETZWn
	3Atk+jqb0cvKyt2AusrN7PJx0ipm3PswsHp7xpsN0V6IRriPan6fh1LCp49cZzjBTOJ5cf6e7JW
	amcVncGmFA8/NIEw0MesYQ+LSeXhJSYrNg86GgrHKK9MbATGguBLPdjg=
X-Google-Smtp-Source: AGHT+IEHITDeGfXXKEEcbHVMaqOoheljYjlUsecct9kjAKXpEmDlVgujpax/NYL3RtH4uYF21UbJQOIW2GGvNrOkqD4amCBoXswK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0e:b0:365:616c:59de with SMTP id
 i14-20020a056e021d0e00b00365616c59demr62531ila.2.1708659735114; Thu, 22 Feb
 2024 19:42:15 -0800 (PST)
Date: Thu, 22 Feb 2024 19:42:15 -0800
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008dbd5306120458f9@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_write_inline_data
From: syzbot <syzbot+f4582777a19ec422b517@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, eadavis@qq.com, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nogikh@google.com, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
ext4: fix race condition between buffer write and page_mkwrite

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=f4582777a19ec422b517

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

