Return-Path: <linux-kernel+bounces-59113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6052084F16A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E477AB2513E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF187664A2;
	Fri,  9 Feb 2024 08:36:26 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D76137142
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 08:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707467786; cv=none; b=VkDl9tgtYN/R1MOpJmfxu8XOd+Rwd0TnMtj4v/xSLKLHhhD+yi3ypJztexJNt8SOZ5Ic0KEuJIl2qNrCsP8xUsSiU3/8Ep8cuI46F3k30gSQP8v1idGmyIf+U2Yl+FO/pPf4nora+lTKuNjypatO+fIWFpsdruCf1hRaJOIHAUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707467786; c=relaxed/simple;
	bh=Zck6MFVSsVoeJrJI9g41GzXMVLesXH2u0cKmmnlZ1JI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nYNp2eRnmqDmwN6rvBYfDwste59G5b12q6R8CRx5aExwD39HTbA5jFHVp4JQHmkdHzTdFZfXckVR906x1zSV11dYZFpdvEG9n792oiFUd0r4nE4paYE4lc+DANPvhmzL/xz1GwP/pHj3GZsPD93jQBaUzvuHuECDFbmB2nCFdG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-363da08fc19so5031355ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 00:36:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707467783; x=1708072583;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=24Yrgnnur9ND4ExOfD7XjN9zPiPpVt+LDVK8jBNwB24=;
        b=TWNGdGl45brF1XUIfpv1FwKcZ8FSQQndQRj0mzNj0EfjNRCks567fWXO+TemZwrUe9
         RlhGcVCkSZWVzSHuj9IInZDUEYVhD705d9XB/PvkasVO1dA6o7Y9yfBXObyvL9isT3+g
         govnabHNVoqJ5oBkI2YVUV7IJdNIYCn+OQqsQR4IKfEq0Ld6oVdle05DqU0aptRpELEn
         0p6c8Ifay6AlTFTNTtfoSemxADmZku9Kyfz3t7fZz2FGxmr8j3GtE1e6ZKnPr1UZ1dYk
         xTsMo+PSINjxUKPnWNgBnFveOTHzrsD+YPt5/yA+ExMPPZX61mhvF15V3XdnNzpjl1CC
         m/tg==
X-Forwarded-Encrypted: i=1; AJvYcCXmhLJfxFIzXEDiqD9mDHGF35WfG7ozlJwefjk0ZvNIx9Ks9jCyLuougzrfEP16EMkyuXcdHz6bRK3OWB3fmPaCgPbDNqciVupfrBMp
X-Gm-Message-State: AOJu0Yz207dd4xx7zJFDiN1plc+KROxSIBVguFBtmTcQN/r219vSy7SS
	etlG1RiCHP+my52M+c1Hj44ZbMW2O4Y7Hn39eU0tXMujYZojo3SveW4Qy9FcNsWl/5r7Jw34rw+
	9gQQrUHjk2V3tf5zQRtBcnT4x8l0ITIMGBLk374ZqkDVsyXaEn8JZK4k=
X-Google-Smtp-Source: AGHT+IHBJbYxhXRQMd9Rfmr15cbvFKFPUBuW/TZQdWNmRozZQaLQJqA9PD+aJwrcavFgPhXueA01XHrWSDiqo/QuAICTYy1825Nx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a07:b0:363:ca65:7d12 with SMTP id
 s7-20020a056e021a0700b00363ca657d12mr58589ild.6.1707467783730; Fri, 09 Feb
 2024 00:36:23 -0800 (PST)
Date: Fri, 09 Feb 2024 00:36:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b700a70610eed280@google.com>
Subject: [syzbot] Monthly netfilter report (Feb 2024)
From: syzbot <syzbot+list54bd6dcf58b0a6cd42fd@syzkaller.appspotmail.com>
To: fw@strlen.de, kadlec@netfilter.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello netfilter maintainers/developers,

This is a 31-day syzbot report for the netfilter subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/netfilter

During the period, 2 new issues were detected and 1 were fixed.
In total, 7 issues are still open and 158 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 47      Yes   INFO: rcu detected stall in gc_worker (3)
                  https://syzkaller.appspot.com/bug?extid=eec403943a2a2455adaa
<2> 38      Yes   INFO: rcu detected stall in worker_thread (9)
                  https://syzkaller.appspot.com/bug?extid=225bfad78b079744fd5e
<3> 29      Yes   WARNING: suspicious RCU usage in hash_netportnet6_destroy
                  https://syzkaller.appspot.com/bug?extid=bcd44ebc3cd2db18f26c

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

