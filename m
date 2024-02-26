Return-Path: <linux-kernel+bounces-81751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D288679B8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 557A11C2B160
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D90E12F399;
	Mon, 26 Feb 2024 15:00:08 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFED12AACF
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 15:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708959607; cv=none; b=rV+rkBEAjgb46VKv02M5MDGxas8b8RrzteXglr7DWUgLTAxthXKC9al6D1HqXU21fZ8q0SoGuuh27fUOH1z9uf2EG3MVDhtgvk1gwueWMvVNvOCco8JeAGlAUlxsENIe9m2ckTckYDgvRfu/nFw3MgpNAvT2xewX+DCHCEERXH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708959607; c=relaxed/simple;
	bh=eHf6DhQsK0KZCPXgcrcFLMEU4s/axWJphZkoUqovX0s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cbDIkqqhxXSAVH5414ooNQxXzH5bzPv01gLMrRdLFx4q9wfjA5evjOrLAdvHH8n71ZD4T3k4bPhiM9OyR3okC9n1k3OkRGPcVuy3w4ibIYB5G0A0AJXaN92El9Mv0sM+z15wg2VPrEjh5iU9oXGZ42+TpterarE9whGLHFzSbOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3657ef5f01eso41899925ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 07:00:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708959604; x=1709564404;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XWnimLAcCCtkR0KSTmxlZv4XKOQ8UbGKnAa9ZHp8bn8=;
        b=himayRM/YD+6D5Fz1P6Y4gdKBPKV7JGIF4o3aMp57H2IEqRWafnfbaWDeGd8ZvuOT3
         OvPAfT5r5elMVHMBoV1uu4Bvtpc2hSV9yYee+iDGGRjW/XAiRiQif7hy6ID7RsOrW/X9
         F+da3hJfijeWifzwSpeR/dtGl0+Q1ylbWy5nAp9KubTYZ/c8Pwnnu4JbPanjWrD8XTGA
         wMQlC+m/C6H0A6NHfcdNMOmcenB9rOz42saVp4v89db6VwedzDD3Tsyvfl5OeWyDvKp0
         eBlFXcNr5aDL2diNb8EMU404kRWzuqsCLGVE5MSa8Y+T/nbk/hfYQ/lT/bpDHEKUOCzr
         kPlw==
X-Forwarded-Encrypted: i=1; AJvYcCUoIkUXj0iqqApD2oFxRd6gbmGtsRjGGm07LUZXpB/Ot8khHl5S0z1MqJ23FwXN6HCJ3+H0fThzWc5kCUtpIJZgPH3geW1sLXZP0UyS
X-Gm-Message-State: AOJu0YyS4GqDCfS44wFxEYMVpzG+mdOAqIqEv0t2v414dVB/aW/+C6By
	dSYCoKwetTtjKeRaZx86VwGHW1YC+WDn+4xRC90K3w/cGSySb7+kJgB0JKe1Rb2T4BiyEk9CS3d
	nsJJuIJihyg2D3p6p7sDwUa/pWHdizB5qthrk9QRJTxkgJzJyXs3G0eA=
X-Google-Smtp-Source: AGHT+IGzpCE2nfkAg7pqbTcBeh9cTuldlXFttxjcewZTsZ4GZdTghVX1twDE6ea2vwl4aPcyM9GMOXvl7BXzuKiAcjQlhh0h57no
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1562:b0:363:9d58:805b with SMTP id
 k2-20020a056e02156200b003639d58805bmr363419ilu.3.1708959604738; Mon, 26 Feb
 2024 07:00:04 -0800 (PST)
Date: Mon, 26 Feb 2024 07:00:04 -0800
In-Reply-To: <20240226120623.1464-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002d120806124a2afe@google.com>
Subject: Re: [syzbot] [ntfs3?] possible deadlock in ntfs_set_state (2)
From: syzbot <syzbot+c2ada45c23d98d646118@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, boqun.feng@gmail.com, 
	hdanton@sina.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, penguin-kernel@i-love.sakura.ne.jp, 
	syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c2ada45c23d98d646118@syzkaller.appspotmail.com

Tested on:

commit:         d206a76d Linux 6.8-rc6
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=10dec3aa180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fad652894fc96962
dashboard link: https://syzkaller.appspot.com/bug?extid=c2ada45c23d98d646118
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=163e9a9a180000

Note: testing is done by a robot and is best-effort only.

