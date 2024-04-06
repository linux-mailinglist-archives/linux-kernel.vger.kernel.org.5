Return-Path: <linux-kernel+bounces-133946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 316CE89AB47
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 16:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA7801F21989
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 14:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1173376EC;
	Sat,  6 Apr 2024 14:09:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A9A376E4
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712412545; cv=none; b=Cq7SqOSQ4m9P713VMdZvqJvMpoaJpbS08Ybg3isXaPMPN+3HGZQ3+6bE/+XamuNmBibIU10BrtYyPuMlCZjHR7996TQcyvdY8BKF+TZ0rraiF3yIWOVd7hgL+iNik1F0oh6jlgRr715YKKogCGbrw5ZkeVEZvKHn9yLrfM+RkZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712412545; c=relaxed/simple;
	bh=lxqXhKIfgwSldkkB/EYE3JGoDcYacDDLGkoI43QmqJ0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IPP6RlcHiB9vvcnB4UuHyX89g3L066r5+AX027ZG6SD/OgcrvFJIKxAJ6RnZnONmTULijpMsmmE5Ku9W2rSmHrxwyD9vumEom9zakFwFWuHur5gtIi5AtLYT5ADBgrLchLdtXMvJN/HP3K1o9ECAc3Veq0y5dohX63o9nPUKN60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-369fbbb2043so24258505ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2024 07:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712412543; x=1713017343;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKWOoWZQlo7H2+ITKV3F/IYQB6RTxP1xwdB1SVVmYJo=;
        b=Y77BwK1LN6Eaw+NQNd0FVTEbXOKYQfPbEwvCS4id/w4g61/NoeQyWmWhRrX6BUtw5I
         fNBytXpupjmgkk2uHFFU/vlKXr33HRbKIbqZ+dZrZF8bgicZQbuQ6s1eGU2moYuW1qbH
         acdXw5erv8MwDBs6D1t/7zcp5X0V1Xb1eaYV+oS6JpsBUQdzPJbh5dwt9PPLAfZ5J/bq
         PhvZCJF7Lz0cl64xVyp6r5+R/5zLGkGHCnXmZebOlPqtMSqS4dyXo2a9ER7M8PYlgK9C
         MJu+GYLr7Ra4MzQQyVhBnYlVkE3ZSCs2U17wP1VAwkVtM7pcSxgZ9511e3Sj30QyewWM
         8zzg==
X-Gm-Message-State: AOJu0YykQoV3Zd9EjfIVWb8ETSCs5s/RFoxnZHjtCOoja8mT1XCxHAF1
	ktlsCIJq5tf/y01xd2WkcAYjXkyY871mOcgYJUoz0J+6azsnm3n9rQZFh0EEZSHc5ISbwhasC9V
	gJ7Yv9iw2P0ECNi+xpFm5cQS7okOpWQc+8jubTbJW3kMPzI7h0U3uGpeYiw==
X-Google-Smtp-Source: AGHT+IEcE4Q1AYmcw9itu9vDyXGN40jJO7QgjeOC5fUi8hFAtNOdOfJLOUQ1FbQmCPJNicInZ9e8Tmicl7HLbS0dE5psu5538GST
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aab:b0:368:c9e2:b372 with SMTP id
 l11-20020a056e021aab00b00368c9e2b372mr216731ilv.0.1712412543016; Sat, 06 Apr
 2024 07:09:03 -0700 (PDT)
Date: Sat, 06 Apr 2024 07:09:02 -0700
In-Reply-To: <ZhAYgzZva7_u08lT@zeus>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000055f49906156e1d7e@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KMSAN: uninit-value in nci_rx_work
From: syzbot <syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, ryasuoka@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/nfc/nci/core.c
Hunk #1 FAILED at 1516.
1 out of 1 hunk FAILED



Tested on:

commit:         58c806d8 Merge tag 'phy-fixes2-6.8' of git://git.kerne..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=80c7a82a572c0de3
dashboard link: https://syzkaller.appspot.com/bug?extid=d7b4dc6cd50410152534
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13f7c615180000


