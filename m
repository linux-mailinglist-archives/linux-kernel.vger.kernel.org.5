Return-Path: <linux-kernel+bounces-164696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 947CC8B812D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 22:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8421B20E75
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B428199E9A;
	Tue, 30 Apr 2024 20:09:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6374A17B514
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 20:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714507745; cv=none; b=eEoVFQboBLtOR39Y2PNK+NaRGhurMGCXFeXrSGFicLQN/mcjX1S78N/oksuvoBLiGVQ/261jH4aVHQUTA8/N+M5blNUICAQdriWisjIJWdJx4RrnTp5zQ1HAO1mksDUXsPQEZB1ZyobAO0pAaDswEnsk5bOYntR5fViQI1SMMqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714507745; c=relaxed/simple;
	bh=7UvtNB02k6VTmwy5zAsBPwBiLYmwGXAcoZOvRIL45Ek=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hUi5F3gVJRKi+lrjp67rA/d1gqn7BtvT+gk3Wkx1JtNpvdP+wEy0+7YuNgVyjbZO1qclAFLB7HO4ghSfBRkCSDNdkXeMSStcT7Ft3RFFF4krBzHT8KbPyZLSYcHEJx0/3nPUxDyIUQkMqXUUFlizEnaBESgrT2RLREoLuKvj//4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7dec39bc0a4so332887539f.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 13:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714507743; x=1715112543;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hY+v1AeEGfcOU76EUj+7NzLLLvKL0QKSQM+12WivBBk=;
        b=YTiEkSvzQUxkI0qJ9KKkyDBKpndmseSdHLWoC57z0zXFCUZbndznHz8oRSbErowLko
         g0ppHGIF9nBAflFMzlZkOe+B9Pp7sXQjEFZIABBgnbYKImHNEoiXTBuh95vMyEWMU98M
         EyIuQ/SHbYaEfoscOcrHcjb5aFPad6sZuFdEOwnHBHOhs3tBIXLy1AdsltMB7EF0/M1m
         ivH04ZhGNyIA0nIess7NnipYasyTYUdurmrNo9qJAU3M78PiGZGql020TCN0Xn+HpGMf
         4g+xGykspjtqHalt0Pj6/dSUGBDFLdeK6H0vgwFYoEfNBU0lEnnkSzwB+dVvKJQxWWit
         doLg==
X-Gm-Message-State: AOJu0YwS1M/tYNLGiQt84TqF0WcYY38m4C7TOpPuNl9rtAvZ5I6aNsGU
	lJzRL3E3vHormHz4D5Vy87tbS8+pUrQybBsz/y7vkWyi3iEbT7UpjE86yLvhwMmV9ps80TDIObs
	PYKAdGAypD/AGKrE5W6Gzg5CXSOaIs1dnoYcfdSO5j910kluwEPcCapM=
X-Google-Smtp-Source: AGHT+IEyF/4c/X1TtP9pPc5k2BsdF9vbmoLzQAN9NFguF2EbDjfL679JseeUwcT6Z903Fw5ugEVphxy1gbIe7ejYwS9/X7m0XkAb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:9316:b0:487:c135:f929 with SMTP id
 kw22-20020a056638931600b00487c135f929mr11165jab.5.1714507743435; Tue, 30 Apr
 2024 13:09:03 -0700 (PDT)
Date: Tue, 30 Apr 2024 13:09:03 -0700
In-Reply-To: <CABtBSaZ-Qqb0ZB7CC1JMuO2pkT6YmRvibhb67x=QkOQMCdq8ow@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000032c00061755f178@google.com>
Subject: Re: [syzbot] [ext4?] KMSAN: uninit-value in ext4_inlinedir_to_tree
From: syzbot <syzbot+eaba5abe296837a640c0@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, shenxiaxi26@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+eaba5abe296837a640c0@syzkaller.appspotmail.com

Tested on:

commit:         50dffbf7 Merge tag 'for-v6.9-rc' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1489a58b180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bbf567496022057b
dashboard link: https://syzkaller.appspot.com/bug?extid=eaba5abe296837a640c0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11ac32f8980000

Note: testing is done by a robot and is best-effort only.

