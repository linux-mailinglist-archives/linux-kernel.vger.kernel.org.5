Return-Path: <linux-kernel+bounces-132390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C318993F3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 05:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA36E1F28E95
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 03:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61111C6A8;
	Fri,  5 Apr 2024 03:43:18 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E320328E2
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 03:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712288598; cv=none; b=K91ZWo8zMultU0U3VzWcHk7RSRuCm5+3WAsmpXVqGrRPD5X/8O+tTF8U6K/CGXfIc4Soo5czQMRSHOrGML5YooiLbYNs6lpZIS9vflwtuvdq5bgLhfLK6EAlo+M28l7DIPHymVIvi73fhQ/L9OAFJFPkiMlQm7RbtMemOkl4RRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712288598; c=relaxed/simple;
	bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=H4kokDHRB9NNKL4e/ojz/h1q0t8ItU9zb28BWUkItdkPbcAgD3rQKXUt57+mdFCfm2FpGDZH6W43q1oCOqTg6dfCWsNsJD5k0O2TpPgjOYa35B8x26N9lKZmyCUwSUtsVqyUbaDFVug+T3bwW9FBXk3cCwPZ3LcegZofOwIREJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-369b59962cfso16847055ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 20:43:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712288596; x=1712893396;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
        b=wyZLtgZCGh9YoYPFYTfhQlU9XZz1ALF7Uw0l0Y7Yqre3WveGaW02C+fd13FEUrxyeo
         ZfIW206gK6f5nN7xKePycoPhT0GGpOeY682OwAYG5QPgGlhzJj4xZGkCSE3R8Kuogjal
         pfN/lJaN8Tkpcl6OzoK4jfdSj8RtTl/H0UJ2qfj34IGfArwZG/mMDgBCwLJHoWmEmUqc
         DCUQUIpM1N7B0LPrv9/wk4cZcTFWoFv7ebXqc1LcTQjaXy4HqQvSa6X6QLLse8WerZfl
         wIW0FkJgRRX45E6+pXneHJqDfREgtltfXBRXjmT+oja+urH7C2zGeab/4q5WZJGnvc8l
         p9YA==
X-Forwarded-Encrypted: i=1; AJvYcCVdmsZc3jcER1D1vyVDClMDUt8z5uIEIlZk+bUPmUjiGbvqF6UUNV939psN32H6Ss5kBQmhp71ViY2O7urs2juahA+dgIXeTk5Y4Qhs
X-Gm-Message-State: AOJu0YyIrEIrS9R/TtklcKEG6PC2uOIlzqY0TOm2DF8k0b1wQUys7IhN
	TVWc7NQ9c0JCZDLQBkwzjperPZNoSwfHtn+VdWvpYOO15RM/RCNy0qj0tMi3wuqTOZGBNoQ2TgQ
	1UfW18SFFKgUa2AzQuRWL7JgHTIBJzZRL8tNQRvKjg/F2tmu3mRtppi4=
X-Google-Smtp-Source: AGHT+IHFjzv8CNoc6/4+S+f/8xeraOyYdzTyewDxgRGtLwR+czgNzeoy4SNazCpVhYvJOMTKJpxR6ioDqjc478Je8Q7mka4bDHJ7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3892:b0:36a:a46:69e1 with SMTP id
 cn18-20020a056e02389200b0036a0a4669e1mr8852ilb.6.1712288596096; Thu, 04 Apr
 2024 20:43:16 -0700 (PDT)
Date: Thu, 04 Apr 2024 20:43:16 -0700
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000086534706155141d5@google.com>
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

