Return-Path: <linux-kernel+bounces-111442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 454E2886C6D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C85842847FF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B9245022;
	Fri, 22 Mar 2024 12:56:22 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93914438E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 12:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711112182; cv=none; b=bFXtvS2y4fyZHLNoOn5azbHw+V1cRwQqJ0bj4TYoqYWMztTlQDyINPSGrT5rTz2aQ5ujtcMJ9GHk5s6BrI/gkUq8sflBXCpQgfjNsts13OlK5xFtfqzSpwTUz0dtTWuVfrPof1BRK76UPzg4AwlRuG6tFhVCy0LMP4THWUy8sYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711112182; c=relaxed/simple;
	bh=AKxsIZe47m3HwkKzZpHYJnNtFzfNN0OZqc8+pBilnfo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GSW97jFmBYv6yT/cseasoEB4s3GLNubCqUDDLmRS3qAfTPvglaR9epvW4g3Av6HmMUUxhZ2KGlRX5KD/7FU4VVzQLLzb3p1ZXBde8xtXKW858xu7to91YN4yyulq9CLtvqpM2bHEPsI+08MaafZ5RPY4SexnT/cWbSPtLu3tUyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cc764c885bso230393539f.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 05:56:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711112180; x=1711716980;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=as3kHiPIe02alo97ccAAheYCyCVs1t+AreIadrBewbU=;
        b=vgin3pMx0Z2DkF95gkrDKesPQmAug5laveQrC7gUtOGiE9i+G354bmE2EYJJKRVbuu
         OmIhz44OfQi/91t7lHNqOAj8x+tjlwJ1ItII09fKGq3iORLW3ayJ4c+Bnyvlc1w8X0zd
         yQH+h2PFMT0A0K/Bj5znFcIrAaAWUxA/Rb8KjhTwvsVrtk09DteByQSJ8c0mtVGJB0Bo
         qRk4T6mrp+IMSl4sPgndqNjEh9Gtr4KwZ7O11bENwJZiBwp3znuWwdlPiyh8xMycEL1m
         PBcZGWo2sRhgwhZnyez6cD1GIbwa2+P/hRNDA4JDwE2mJkfg29+SecoswmaK5FJVWsoq
         OnJg==
X-Forwarded-Encrypted: i=1; AJvYcCV8gPDBwXnTIQhiaMHuhsmoA8LoBPlY8sOiuVxA8eiyK8eWXeSz8oViNAxI8LiUkyPmnjOc1HrDGk6Ty1nYG1mBVb05M4uknp19vwm7
X-Gm-Message-State: AOJu0Yy1jWosg4C8q1j8oc3k0TBZT6tXDJyP+CSNzHDkLAVIO5yPz3gO
	WTa64ZIvdATHEN2bb3CnWkWvHpDhuuBGQ/oyrPtHIuQzEMNLyJvcn9vjDAQBktE85NiRe3WMOG/
	SuLuE4ZewmrYOZ4Py/eNQHSY6cPJ4oJpw8kI8k10jJi4J/rCnjU+2Akg=
X-Google-Smtp-Source: AGHT+IG86pGwdCn0JEExxN2xo64ljJuewF8hAjPl93yXSVAUqGKIY+C7rCnNwzMBrtKUuEATBsFMxnyobTw3G0++DGZZWolC4u6/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3411:b0:7cc:1019:a69d with SMTP id
 n17-20020a056602341100b007cc1019a69dmr138660ioz.0.1711112179969; Fri, 22 Mar
 2024 05:56:19 -0700 (PDT)
Date: Fri, 22 Mar 2024 05:56:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a8810606143f5948@google.com>
Subject: [syzbot] Monthly hams report (Mar 2024)
From: syzbot <syzbot+list8065faf9059b8f933690@syzkaller.appspotmail.com>
To: linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hams maintainers/developers,

This is a 31-day syzbot report for the hams subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hams

During the period, 0 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 32 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 27      No    general protection fault in rose_transmit_link (3)
                  https://syzkaller.appspot.com/bug?extid=677921bcd8c3a67a3df3
<2> 13      Yes   KMSAN: uninit-value in ax25cmp (3)
                  https://syzkaller.appspot.com/bug?extid=74161d266475935e9c5d
<3> 6       Yes   KMSAN: uninit-value in nr_route_frame
                  https://syzkaller.appspot.com/bug?extid=f770ce3566e60e5573ac

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

