Return-Path: <linux-kernel+bounces-133146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AE5899F7F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5779D1C22BCB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46E016EC0B;
	Fri,  5 Apr 2024 14:25:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DF916EBEB
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 14:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712327106; cv=none; b=KMKcMs0qqbZLG5W0nKnNd8kvBZaAcqXeTf+8qse6TsPyLMl57gQYoedfEz+SuVTi7KMtpWztVdhuLlQNr3t8ZjEzWpuzH6AjSwGgDhbi4fzwlcUcXGVoca/8o4O9K6VXHPjLUHuUyX6kNY6erU3k2J/T3xL7JpBKGg1eBn1EbhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712327106; c=relaxed/simple;
	bh=cuEO7vqKjzgwUrWsarUircwTjd771GhXXOLQG5x5mPM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FKNhlugi/52IQbOri513GINw7CpGrwFxdpGemsM2cW+2GflXsdKKX7NFRUd52uz+Lvq5lxx+ckzDIbVSMbiLy3Rr0Ng0nHyaABftCI9rH8mqSPGQMg7NbYOqXXFc3CXHQGUAQq3mQ/G/KAell+VYy/Io/OhScYHT503CdrTm20o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cc78077032so216946639f.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 07:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712327104; x=1712931904;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=laQPa37WZVRnQ0n/tGH7oSPgcFcCrPtU6u7CAqIV8mA=;
        b=R556ujsRSgn1N68MR/ajdYd5Nffk0AnOQ2e2FSYXSWkfCNnmqOWCyMV3ZROy4XqALL
         3W0TOJwmAG+381WNmmGjesJ1+FPnFbvwxe6drg0FXeInFp73PS/0tGWVuNurUS0wVN/Y
         5HXQtethqu3SypYNmQYIP7jqH3U8xZAe5G6VNbR5yrNCURneF6TTMLgPbChBoSUMKEuG
         Z1l35PLCw/Fj+3OgqDu0lmSpUFaymrfsjz50gQiy0SGYr34KPtA7lH5jlnsFDiYqMw2W
         RIKn9nCmtIn/ezN56xg+IeGbXf7BWD0Ry+Wf9R4emQbOXdPe7XMb2Heb1++iQ+nrhFK+
         rFsA==
X-Forwarded-Encrypted: i=1; AJvYcCXv7w1SSIX6rYUtraLAj5SsqUvT0gScVJo2vpiWH2di8L/bq8cgOGx/b51fHameI1oV6QykvoNsW6EJI5z0L4z9EjKGU8afsUOQF17I
X-Gm-Message-State: AOJu0YxmrYdQUKzhZU5AQVXsJS9H9/bAVRL3D/T55cDFO6LE96u2lRnc
	hsp7x8i9lCI9+iX8OnZgLiTjwVpywttaxauYI2gj/6/VlUowV1Dw7GJWSOoXl4mxcRi0p7rGmea
	JnuaaxZTboMZh3l//mqJziyVPvm+2Ex1ZirbGZg/8t+NDTba0GH8AIlg=
X-Google-Smtp-Source: AGHT+IEDA/lUAfIO2TSFdjwJB94S9+jQ2873WHGNSKcC0Ig9wjgHPpBBegvmnzqPEP36QS8uJQ+irazk+l2jQZNi5gs9czIX9I2T
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e3:b0:368:727e:ec80 with SMTP id
 l3-20020a056e0212e300b00368727eec80mr89661iln.5.1712327103934; Fri, 05 Apr
 2024 07:25:03 -0700 (PDT)
Date: Fri, 05 Apr 2024 07:25:03 -0700
In-Reply-To: <cb6d724f-7afb-44c6-835c-6c8c229b70a0@I-love.SAKURA.ne.jp>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c5572506155a38b8@google.com>
Subject: Re: [syzbot] [arm] BUG: bad usercopy in fpa_set
From: syzbot <syzbot+cb76c2983557a07cdb14@syzkaller.appspotmail.com>
To: keescook@chromium.org, linux-kernel@vger.kernel.org, 
	penguin-kernel@i-love.sakura.ne.jp, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+cb76c2983557a07cdb14@syzkaller.appspotmail.com

Tested on:

commit:         8cb4a9a8 x86/cpufeatures: Add CPUID_LNX_5 to track rec..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14d6c52d180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=39e01873cab062c1
dashboard link: https://syzkaller.appspot.com/bug?extid=cb76c2983557a07cdb14
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14c42099180000

Note: testing is done by a robot and is best-effort only.

