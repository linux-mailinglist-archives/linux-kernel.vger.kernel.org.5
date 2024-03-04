Return-Path: <linux-kernel+bounces-90093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA7A86FA3D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE0A5B20CA1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 06:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF39C11729;
	Mon,  4 Mar 2024 06:51:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFB3BA2B
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 06:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709535065; cv=none; b=WNLiSJfgtP1Lx+BsoOzsfyFBmV9uQ+JEvOsvgIq2vTBDFB2MIRQI2Z69MguiBVyladt2gVKKxf6MooKpvMf23vmWDMuboJvyZRGCv3BCsn8eaHXWsbyliNSaTpXwF2ZafCsT4Ll+YvbSAUyHwR9QsyEmtMcQcubp342Felda5xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709535065; c=relaxed/simple;
	bh=d4fOgR5twC91SSleQjMplgd75qjKsgjnqJVbubhsbpg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TCzAJ2WnzYBUbOIvbWepMgYt+6gnOMM72UvmF3XdJ7cPw4VxKP4U6JHKfrUotldnj9MlqijsP3LszkRPkxT/fX+6EJFg2AG4qjvpZUAbFyztGABx83pddA6IDxCbiodIM0nOwmXpCq0uzSLWzBv2WoC0lnxfyn70gFFgrSzMHM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c784914db2so520116239f.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 22:51:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709535063; x=1710139863;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DEojSSr1JJCCTe1f41k1uKfweP4Gib3cKMfjn2Bpapg=;
        b=vNtpZsihIgwAyTwtKzJcdFyaFmv3NTwqUYDzQH1EdCWfkeDrt/dyGFaBVzV6E/UHms
         rz9rQQwVRwp/F0lmKCv2H/HbU3RYb4LkZ+nUuTIYqE3wiluEkELGmnb66/rjS8UDXaxm
         YEPPTMWcXuA6e1GYOieRXBkiQZDUdMHdi7A+Fy5IttCTxwz/25dcLn2lb4QVqzN+5hO5
         3Xv1o04yhnfEU5PNmJGaNmXABEWcHgkdfTAJkafcBqcosOA7XRUCm+mB1q1xGOx9BxgP
         ijx0enGYFHeu01NDBcIcR5Qub0Ydpxuo1Nl2LNe2I6v1kuBPAJZ5id6ji9bDO5H6HUJV
         9XuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQ8MZtqkk7GTNh1DEq6K9PAWkclIHBqAxWIj8REQc2cyPAXApJKXXENVdk1DoOZZCO2C2VO9gaFlgjUVRRCG47YPO3IB6G8YG/LZpm
X-Gm-Message-State: AOJu0YyGJ/hvWfAywdRazgS3rrUhrwsqbfaQP8+abzHJJgD7zSjsOhf0
	1p4NQqIGVXPp14pzBP3kFxBVy4ebr6lnacMU4kxjwxqNcRuEi0uOugnQ64Mm4tKoM9A+ZAjKSE6
	FrJPdvwcT3K/xhsHxgFRVrVvetRZftTvJB40NRCKDTB0Zu0+SG/THH6E=
X-Google-Smtp-Source: AGHT+IGmNUWUAUqGhO0qdcJQgLgYvG4EI9zj1Re8GV6F4C5VejF5vg4F5PoijEQqvolFbGzuu9fvyZsubMgsRSaj6BtsdKQSH+mp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:22c4:b0:474:bc7d:544b with SMTP id
 j4-20020a05663822c400b00474bc7d544bmr241175jat.6.1709535063114; Sun, 03 Mar
 2024 22:51:03 -0800 (PST)
Date: Sun, 03 Mar 2024 22:51:03 -0800
In-Reply-To: <dfd05ad0-1dae-4121-abba-59b55ad22c99@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002b07fe0612d02607@google.com>
Subject: Re: [syzbot] [erofs] KMSAN: uninit-value in ima_add_template_entry
From: syzbot <syzbot+7bc44a489f0ef0670bd5@syzkaller.appspotmail.com>
To: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp, 
	roberto.sassu@huaweicloud.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+7bc44a489f0ef0670bd5@syzkaller.appspotmail.com

Tested on:

commit:         4288d8d1 erofs: fix uninitialized page cache reported ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
console output: https://syzkaller.appspot.com/x/log.txt?x=10893754180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=db27810a659d0b3d
dashboard link: https://syzkaller.appspot.com/bug?extid=7bc44a489f0ef0670bd5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

