Return-Path: <linux-kernel+bounces-89643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6E886F383
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 04:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 221A6B224F3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 03:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0AB566D;
	Sun,  3 Mar 2024 03:32:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB927F
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 03:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709436725; cv=none; b=TOm5FbqNuVcoDkOjL819HjNsL8bjQT4towZakOOKvwDMoRibBGnyMG/F8kFt2NFfCvvWvnUIFHFWRRLrdt8D/FRqucypSGsu/XO+nSXsPpdizITnwGgEq3Zxtg2UutAwLaL+GFJDIio15L64LRGh1JKaKrBBKFV+h32X5qIMCns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709436725; c=relaxed/simple;
	bh=7F27g76O/3Kwht8hvrPpNnKLfEt5/A1Oo0QEJwz7IoI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=klnSN1dYsxJXuQojv62YAxj6FyNnKspzoxD8NSmkS4aImvNmK9enMQKx97i6IuTWpuwm65fi5nKZeeMaDkCtgag+ip+8BUcmKfBk7OzzOTDUwz0i9JwIhouOE+VGs0XJKOyJdy+OtNxYA5wLuQ9dPEP0YVjNPkKmyYiHGys0cGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c49c867608so371333739f.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 19:32:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709436723; x=1710041523;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aNZb/Zi73x+E8vkJJgvZSx/ipGNVfIr8rYMqwrAdp9k=;
        b=mzHTtxUrH/zcXGLQvG73FKz2t4lDZEyORCVRO/zss3FbYaVNrgXj0cyIOSs0Q+NAmK
         CaWh1UcwBKsMvv8BCV4WAOFIKEB33gAkBnQEcSaD4CBzF3ZjaZz46+GKhDRIHqOlaWRn
         barS3P1LqOWbyvw8yf2R3Yrtp9pMXGGtbOXPilnmtK8ZHh9a2ipVay5MyZVHVjAGLC7n
         ++ueskNsAgZLmY2ATRRUUFQNPzL51vd74ujA9hIg+o1Kniw+kfL/yvT/lo03Xq5p1L/k
         cZE1jmPlgNId1XK2TfMjeb0mqIKTwQrVCU3DsnTKbWTQWT0GEmDhvEYihjGJmTSAPurT
         yyhA==
X-Forwarded-Encrypted: i=1; AJvYcCVkv0VWh6mXHZaSiCm8zZsyliOOa5rObt2TLxeunOxUd98mPQceahTSRygg3U6WhcXgQTZ4jvfB6sJE2GBt2GKYQbFd2rwk4Yf8JQM/
X-Gm-Message-State: AOJu0Yz/oOnAaTMHZ70g2NasMDmHPFdJsgX31BCRy2BJ+aFFZ+xhHYMw
	zTywHZBx6k876fNByYgLAIY4zG1Ev6/DZQ5bKBBk3X/tc7ITDhBHI48japH2DTiWAzsWoOSxA+r
	jsVOARqzNvXV4eI157CyNnnlNAM9EPh3KiisqbiH7XVUY9nzahF0p5qg=
X-Google-Smtp-Source: AGHT+IHUA7lrMvxcHGD8eU214F3hqzU/Wd5nC1WVccZoCvs55keHUn9t90y8EdE/XU9fFS/iMuzeKEx6ZOAh9Vs4xQ56HL2hcoYb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:35a6:b0:474:d358:7f4e with SMTP id
 v38-20020a05663835a600b00474d3587f4emr194874jal.2.1709436723251; Sat, 02 Mar
 2024 19:32:03 -0800 (PST)
Date: Sat, 02 Mar 2024 19:32:03 -0800
In-Reply-To: <tencent_5436144A4A74DD76DD66D03C89363E96E009@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a7ceb20612b940b4@google.com>
Subject: Re: [syzbot] [rds?] WARNING in rds_conn_connect_if_down
From: syzbot <syzbot+d4faee732755bba9838e@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d4faee732755bba9838e@syzkaller.appspotmail.com

Tested on:

commit:         04b8076d Merge tag 'firewire-fixes-6.8-rc7' of git://g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=133adc36180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fad652894fc96962
dashboard link: https://syzkaller.appspot.com/bug?extid=d4faee732755bba9838e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1429e874180000

Note: testing is done by a robot and is best-effort only.

