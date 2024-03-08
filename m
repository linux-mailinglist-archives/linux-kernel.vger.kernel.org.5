Return-Path: <linux-kernel+bounces-96485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEA3875CD7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 04:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1785D2825FA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 03:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8BC2C6AD;
	Fri,  8 Mar 2024 03:42:20 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823132C1A7
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 03:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709869340; cv=none; b=BGI8x4tb06PHdDbld5agllM7Q5/92FhrJh77uRdJ6flkIXSu2kglBzo7nzpvP49wO3pAGKFiop5wXUgtlXB5ipil9IW5NKRkgA2hBnuQjIPTCvSQqsm5p7PRxazwtXZaezdjPzYDE0tpyUZpGOQB4FxyO+0jS1pTI5k+IDUajyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709869340; c=relaxed/simple;
	bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aSH8ap4wdV0qnEcUU2o9zDCRIWd/42QcxMdavxajIZ9YSGWbqu/PigMzwducOHQgiZCzP0fj6OTTrDPp9JWTCQIvaZLcCJuys7K/A9NkWXAunSAs4RYVK9HuM43jZ0ElHG4FmznFkf7hd5+ozFAqeTpZGl1blFIiVChTL74gk2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c75dee76c0so125620539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 19:42:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709869337; x=1710474137;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
        b=jcDx/n2OoGUw15oRtZ3tEcrdQSGIRt1Uxeg3KVgBIhD3exXjzbuetUq22mr3YMwn5E
         jn6zMqAPAE6MTQyFqlbxhldCb+XrNjGhHWKMXCED08hX/UYfJ07L/syat+JYWtw9apc0
         nebEHQYi8yFXh2k5DuOqchrM/LFYQROx/YxXkngai6ElKcaLSX6KfqzcDmRasOb/xE2r
         eDmjEgJxlsSMVPPncWxVNar1QN8i6A9FZ2DXgkETg9W77k8iNvtUCsNiqm6jf06RhqbK
         CG6r9JDA9m6G2Fz4ejOg/bsrtIAIGThxOxnzXVu5eDbuda02uhPflDUMGCPQc5LJPWA0
         3m1g==
X-Forwarded-Encrypted: i=1; AJvYcCURokpaJiTMY6Gy/Rdsg2FgpMQoDBNM574QieT20C2esUMQg6bYx4aSpabkz+D60uqTQaoYWckZPqzdZyM0hApT47gAQtPpjCJ+X5Lt
X-Gm-Message-State: AOJu0YzhAf1FVnAFcGoem+iqzQo4uHv7k9CcFzzJiUZ+RbfmYyENH+QG
	v3KCTFpjw4GVuBXt15MHH5GZFVdYo2xpFJrS7Guew451qQa7dt4+p0N4XdC5xVBGt7SpKDBV0Vy
	poy2d+TSsRyhyJ+ofmoV47IJp3PV5FNRtmvXa96CV4aaK0uUZwjydyKY=
X-Google-Smtp-Source: AGHT+IEfm4T3ox+Arg1FX0HDoKBf8GotmyyS9mYWuGNzH8O8IDART7Br5RhAcWTaqRvmJbP+PX/UzLeeC2tHO2MZ9l1ucsbwX/bl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2b18:b0:476:b3e5:4392 with SMTP id
 fm24-20020a0566382b1800b00476b3e54392mr150721jab.2.1709869337792; Thu, 07 Mar
 2024 19:42:17 -0800 (PST)
Date: Thu, 07 Mar 2024 19:42:17 -0800
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007de36306131dfa42@google.com>
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

