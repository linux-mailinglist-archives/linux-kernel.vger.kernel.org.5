Return-Path: <linux-kernel+bounces-101517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A1287A82B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D95591C21039
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CEE405FB;
	Wed, 13 Mar 2024 13:20:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C2D3B798
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 13:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710336006; cv=none; b=aU+OMM6t/ogB6/NN3vo4W6eBvwd7u7Dp3qGil7FxSvCq1TRKjU+iJFKO17eqTFSJQbpswW0rnrfwEcp36lQVXzAsYUhqIm+NkgfLHhJ4CLOyocoXuP6jXPcZZBYMhY7xmqpawZQJ7kMWF28MBjF3fhwskEkeesfe6CahhOGOD6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710336006; c=relaxed/simple;
	bh=KpzxgYvCxU+Sru5HuHeZFBAc42cCg9CRe4AituRaDhQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ALlRzcZpSt0Hvp/Ybtad9e1Vs48ANtzZgd0Px2gKUB6KmrYVho3AwkI47hdOp2WDz25KlBHsaMnZBjnLLinvVIV0/hTfhzoEMS+rdG/WbyCFvfQw9yPFKpEgN5xBGvF3daQ9z7FmSVlFlTcqY1xD+fTBBIyb2IzTg9NzhsropeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3657cf730a0so57531255ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 06:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710336004; x=1710940804;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0258IwDfndZxyHoyXgigB04BgoMbnpe3maXG+nLqbrc=;
        b=JPA6R9JJXjHSeYv4H6aEYTK3wwEoFINCYwmLimJN6JCKSUKMmAqhUIWa8gcskv2oth
         KHWXGDoNcsIevIqz3IDbPzSBk9yCsE6nLTeWreD8fBYZ5fYbEgi9ZkFhc3PsbMWddlji
         mvLZPUQTkO1SMvH1aq2AcF8sYM+lOxh0NXaU2Le7Jc2cfjbXAdaM5+OOJAYSFgeRoXfY
         VnYYBrTm2li0Zd5rokNk1cuswvbzx1R71KRP5+fT+cgNQgyNKxqP7sWZQbaaghEZEZbM
         9mdONpywcuBHfHpL+05uI17wm8cADBjUTA9a8+JWTEoX58fr0ZoGQ1h8R5qvLt/nMQXU
         hgqw==
X-Forwarded-Encrypted: i=1; AJvYcCVh6OU86eSBFOH7aVbDJMTBgL4DkZ+3L65Uz2NHzJaE9z8x2DRpRrVo/TSHffhmE6NmxcXfvxR39Wk/wc+GSxf203HVGgV6A3AqNWbl
X-Gm-Message-State: AOJu0Yz65228N7gHtGYrgJCMNaS09ht8+lEN3WbAxKp3LquAKyyKodIk
	lqMEH8U4YFIP6x7K0U32YxvokQ4Qh0KC7fgF2kLEfOaUat3Neo4SkGnwwrc2+9B+08sKHj8PWR3
	GXJ7BJ4otfi07u4acOX7lyLQBY3aEvRol1QVrVV8dxEvIwA3IHtiaPX4=
X-Google-Smtp-Source: AGHT+IF6c5ud0nuXfdYE+zH8P+M3Rgr/YXfrvR348/gz6EBMooHpNDiPjNL59qB8ppsqvCbNGksSEdALPNONAi/7ysRJ8Vg019zK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b24:b0:365:26e3:6e51 with SMTP id
 e4-20020a056e020b2400b0036526e36e51mr516457ilu.0.1710336004068; Wed, 13 Mar
 2024 06:20:04 -0700 (PDT)
Date: Wed, 13 Mar 2024 06:20:04 -0700
In-Reply-To: <20240313124204.2356-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f82ad206138aa1c4@google.com>
Subject: Re: [syzbot] [fs?] WARNING in stashed_dentry_prune
From: syzbot <syzbot+9b5ec5ccf7234cc6cb86@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+9b5ec5ccf7234cc6cb86@syzkaller.appspotmail.com

Tested on:

commit:         b0546776 Merge tag 'printk-for-6.9' of git://git.kerne..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=17c7b951180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=9b5ec5ccf7234cc6cb86
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=108c8dae180000

Note: testing is done by a robot and is best-effort only.

