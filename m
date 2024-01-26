Return-Path: <linux-kernel+bounces-39572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F8983D2FE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 04:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4C041C233FC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 03:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38461B660;
	Fri, 26 Jan 2024 03:41:14 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7568E9479
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 03:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706240473; cv=none; b=ocIifLpMo38mSkNGjDTHIhg1gA7S3IIu/9hjjp4BVWygTAB8R4HRyhYH4x1qvyCvj5pnyNg3uQ6kccpclaSkCXKo1fxip45x/GHllkjuhJvypLJbp9hN5I4XtN6qzMpgKqjge4iRW0TDcdqrqmzIG7XUXN7YcEGpwpUnkuLvtao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706240473; c=relaxed/simple;
	bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=b1k8ChIQSVq8a3qTtsjwi3DQ0uEgVEtKYpb8eCqhxnXQ7QCEBdzEtIhl3KHghvPvcdTJKDz3ePz67HmfgsUgn4xLuuSjRK9rN/tf1Asz+Z8Sa9ntEriQZbOL+gDGhKung5q/i6VJYcUoXdxxl35EZcDuRZgiSkK0MPx5T714Now=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3618e013ec7so83426495ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 19:41:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706240471; x=1706845271;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
        b=HSxYlFcjLxa5dxPRY3kwo3LywVCVlTjkQ3jjcZA/AtjGrBY9w/JKNZ6XjftbqS1l42
         ezNbh4Sx2oOgELe13aQZ5TvnuARMuG4EfKCKvuMqYZ4TRgtEPF5SJV1F78tYmZggd4O0
         633nN3iUOA5x3EhYgpMBtzcfUMCpp3z2FttvVE3PLY3ACr4Cm8TzpUNXzn7omSX/FFo/
         Do9VZYp6faLDHFsKk8aAs4o9TrWxMejE6zcUJKQS7QG09lcenFR03xLFwR0mlb2tZg46
         CTeVmSkBo2tV91a/BI9zE+Tj66tDzhAlfGqC+upOv/6GxLKNY/BMfwJNUPktsOCDFrH9
         1Yhg==
X-Gm-Message-State: AOJu0YzeOLiKJ5sQYVfkdfuGLJYpOIE+y6sISz1/BP0RvYgiU4wr4Xlf
	YIU84XbSvfKLo8FDRN0AQ5HUlNw7145RGnVQG6BRVc4UXRzzrQoj673CcAm3AdHdwXnnEnL4gwO
	DghIIT4V99XXZOwnNWsLmkCEYgje4Y1N/g1bDPS1m3W5IJwTZc6p2Y+c=
X-Google-Smtp-Source: AGHT+IFz0qxmvUVhvPOqgIrXUDDVpxna4jQPfuOBVEfPvyygebPqZl5fDHsA4+R5BZ5kDHAvmukq1PwEVID+8OKOegIa7MVTh2wE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:144b:b0:35f:a338:44ae with SMTP id
 p11-20020a056e02144b00b0035fa33844aemr106434ilo.3.1706240471688; Thu, 25 Jan
 2024 19:41:11 -0800 (PST)
Date: Thu, 25 Jan 2024 19:41:11 -0800
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000376be5060fd11135@google.com>
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

