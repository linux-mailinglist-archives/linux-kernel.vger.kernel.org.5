Return-Path: <linux-kernel+bounces-79442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2127862250
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 03:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 125D41C22EED
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9D8101CA;
	Sat, 24 Feb 2024 02:30:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174AD11190
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 02:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708741805; cv=none; b=h/GNGEbu/QAD1wdVbtLqaaR1OM8oeQukqOfcU5LIs7XlORfxIpMxdJYpTsGLcJuc7wCWDQ9W+S6SW56W1GA7uzrPZTIx/NVwtDoNiFxa1IoLgU+aJeahW2igfNSU/+wdcm8GEVgQSzK3Pd8hDfjG+dKr+Dzdno37Xj87FPJGEPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708741805; c=relaxed/simple;
	bh=lO8+0fB7NnVvtPXNDyYgYYTfdUM+648iykiu1S9ppKc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Y8Fdfepn3JiIQslIJmAWddSqYeuDhBtkdzjq31pEE83JKVHGNVi6TQ/oaG8Lz3IwSEq8vepW3ZA3m0/kuYM/QwHvK903H1TMKIepm7kduFnI6UUyAsW6Czj4uOHfRymbM6NuSPTVctIvEt5JXsYY6qzZcG4APLubLzoNf7CuzOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3651fd50053so10317095ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 18:30:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708741803; x=1709346603;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8vVYj9raZx8skgSNVsrzSEwduK1VjVE0vpTnBMHSrXs=;
        b=IaJq/+iXn4pHcO/b7V4pUFtlfodkMDHvShrvYKar871t/0ZHl51O3YHsDSIVyF5MIG
         OHR0c6OE075Vaao0xL+TYvp3aOHfRpKGl/ol11epYdO1AhewKyQCeg7D66z+CCbXsXTI
         0M4yB9VGzi3xEBv2Q5UW2d7VuCZNi14gzDdQa4lLn3fLO7Wie+B+KZRzoQRuLs42C/ub
         8KGwL8zuAibng1yWk0CBTsk6dKT853J9uF4sngpkR3GBN3RFM9nKWkykUWwrP0SGDQ3o
         sP1boE0blCDc7nqlZXz3d8m+enynaYeXWJHa9rAXaZKftgpGK9HNt6UQ8QfxRe1mfoTR
         ZF9g==
X-Forwarded-Encrypted: i=1; AJvYcCUTVf+b5W6g87SGiTtWW99rLVWXX9nZo9ymlvKVMiHtTpdKgeyJHMXvWRTWpDG0I5nYZcM5sK9m9Xwrhd+c4yRri5VA7zv3jhcgeh6f
X-Gm-Message-State: AOJu0YwsGR3491yJYh97OQwfS9IYDAadJ54it6y2zNUByXKmbakjnPEb
	xcujvJziKYGzXAcWwvc2G8X/jrbauF7HI8aUcsAstVsGjrzUII9wXYimYBqZ7lyp422QU1JD6J5
	xrrGyzVQHl4HlBvvm/49zLmZbX0I43g2w/8oLtjsg3g5AfPIi1vc0a5Y=
X-Google-Smtp-Source: AGHT+IG0LjMBUp/tT43QHObNQpe04c7vZisDl0LoV5pYe5RiKglzWiPruPMAzzjLKAGWmmTzYZuUnO5H870H2dfUjbewKrzNj0t5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2147:b0:365:38db:a585 with SMTP id
 d7-20020a056e02214700b0036538dba585mr99864ilv.1.1708741803039; Fri, 23 Feb
 2024 18:30:03 -0800 (PST)
Date: Fri, 23 Feb 2024 18:30:03 -0800
In-Reply-To: <tencent_9FD786C5D2F74645C989AECE6EF64CA52706@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002ee3850612177453@google.com>
Subject: Re: [syzbot] [usb?] [input?] WARNING in input_unregister_device (2)
From: syzbot <syzbot+617f4ccb03b9869f6494@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+617f4ccb03b9869f6494@syzkaller.appspotmail.com

Tested on:

commit:         603c04e2 Merge tag 'parisc-for-6.8-rc6' of git://git.k..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=16ded6e2180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eff9f3183d0a20dd
dashboard link: https://syzkaller.appspot.com/bug?extid=617f4ccb03b9869f6494
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14e60122180000

Note: testing is done by a robot and is best-effort only.

