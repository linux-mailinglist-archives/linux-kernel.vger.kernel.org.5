Return-Path: <linux-kernel+bounces-110914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F09588659C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 04:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 143491F23353
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 03:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA6E79DD;
	Fri, 22 Mar 2024 03:43:13 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9CC4A2C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 03:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711078992; cv=none; b=J8NLdwj8bNYZIeawMBOPoYibsQHRE4PkmUQTo/1HzIJgCF8DRT1zoU/vFf74/3w4cpwYMN44r6e7CrxKDlw/3fhVdRwADEesyWZsr3hrKj6gPlDVVbd5LNqMv9ZcKD+1c+aeJXGloLsND6U98h0Xw7Wx255wUnPKsGw9+lVO3OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711078992; c=relaxed/simple;
	bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Liyjp2DMgSWMELwchD2YyN3jyX3SPnvzMmgTG9AJ826dTuDxFIbak8TCqBLKHMo/umsLOp/VFSpxqLEp3/XU1YICDHCiKaXPuxyb5eIjKRFJeLuFlPfbzKr0RXq4ysOvD/9hy8zdDcY+Kx5rk30ZXMD2it1C39Sfmv4gpVH6W4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cf265b30e2so176523939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 20:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711078990; x=1711683790;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
        b=J6JnwKIu1mgabKpIJuT1kz+YHnvge4r6sKE4qF0gQ2CqZLAjYAgdtPf0pWgNuOXccL
         S+htLYWJhb5XBl9jbNoPb8oyABtTwEsmAF2dOVPFdb73h0NJfirZsj0vqwNik6daNnJw
         g61vOAuMiYdYyPy4kmIJskcWeHdUaoWRLodiRWzhujLx7JnWzN2GYPlUdR3Hfm8R2a2r
         754O2uTNw8Ex5tu3VqxW4jmI7Ov2TzwrIJRe5Frr8BJimVM0VfLz4kTUNtAsG/lpmi15
         OnmN/BhESz3zcq50flpoenpV2pJvFQHwTe/JAORtskroQJNob9aHED9cSFPU9Rjv9AUv
         qzhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYDY3BaajZ4zOhgJkA3Phjbv1JLgjtpgMJJ7KuhUXHOu5zf5sb5XsjnYnmws7PZV7iQhh9AAIJPzBh0jBBARGZ9ZXgRaSV6NosIBKP
X-Gm-Message-State: AOJu0Yzj4ypEgpgRSC533uNZL/3ti3wTy+cwYfKq5eaSuWMdV+97TEX4
	S3X+tumjU2qlcUY53mNqS5P2C+tsv6y5ToVdN/CS2LFHXNivlmSzuAIK2fUx9lAwfv+gr0lOb1A
	/4QsSWkCgQPTWUQqsg3VHAwqrRoOsrqGCzdKX6g2yCMUzLjwImy1JgrI=
X-Google-Smtp-Source: AGHT+IEHxk8xSCWHhcDoCB7Keif1EAn8Bc3Wm7anJiX6s4lQ7mGl+EfpLANtSBAw8oWfeCh6UDat/0XrKUqX/usRC3mv5voXUGuX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:270b:b0:474:c3b5:a8b7 with SMTP id
 m11-20020a056638270b00b00474c3b5a8b7mr68265jav.6.1711078990482; Thu, 21 Mar
 2024 20:43:10 -0700 (PDT)
Date: Thu, 21 Mar 2024 20:43:10 -0700
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000069222e0614379f1f@google.com>
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

