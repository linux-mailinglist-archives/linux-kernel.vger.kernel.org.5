Return-Path: <linux-kernel+bounces-89704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE65986F45F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 11:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34ABA1F214E8
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 10:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64EEB669;
	Sun,  3 Mar 2024 10:22:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2B47F
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 10:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709461325; cv=none; b=LPzHgV7hMG9CBokYvPBMLtZ3sQK0mO8xH5rcVHaLZ1VmCjv5e6y+0qY2jGbKRbYjM/r0eDMFuWvGj7Cdk9qCX/iNO/9HMRpYHGlgGoC8hG533AbiWAyXAmA8f5UaPel0ld3glmCPNJFJSpOeBvKm6qa23qtXMCkk9ynW5TU6OEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709461325; c=relaxed/simple;
	bh=T2GckUfT1kubMvx4hDGAFlKROBuOPNRLy3B5v24NIGA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SX/O8KYP8HjYmSLp0abcw08Ui7Dh0xLxcjkV6mTF+2a2bIAFYf0sdTCW+EjNyrMFmJcvmexxODzUGQ8uyz+rKGFMAZV9jXVkpIu+u5DANsommktt1C7dqiBaccNsdXtBxurAOC5pauaR164j5kAz6bBt4DPAREWhLknV3NUeGfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-363b161279aso42107855ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 02:22:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709461323; x=1710066123;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tRpa0j+9Zj5GA3qCyCFeEGQCktjrjYJq4RIenD5VSQA=;
        b=YkkKNa7KU43isNp5GkehFT/uIxjYGs6SKbGyqUC4XakJIi9tmlO92t6BfE96gcnGWT
         r7eZUhrBJHSVBbyNOd34lE6TmhO4PiDdZreevz5M3Ei61o5DmY9tFgL5ldC+H6ARU4ar
         v82Z62wO7rV/9qhmQDeiudGPtfkwfzBFrXsKMD1Zj1upx+kvlDHisWbtZ5Oghu/1oeyP
         cSF9+hc4pXMDIxfPHMmmtkp3sR2dgZi4t3Op/3xdRNJ/ZyHjXEZewgQgnklubrfaaZTO
         GvShEhXjy87up1GVf9KQl+rpI0u0MEvTtHgpL+B1EdWWWFpWSJmS9lchAJz3HgoqJhAE
         3t/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWraD4PN2f7LjxOvmwouBBFaBXOmt7NoMxb0RzRpHsb7t7wMKE55ONJWQipklrUpfzkTBZl9OgdcIEPGm5R9mV5wVFnUCTRoyMpXa1E
X-Gm-Message-State: AOJu0Yz1BTzfQs5lCZ+fZC01YSjpogGuFya418Saxmyu+KjKBwOyu4Aa
	01uMYBsZ18FcaeiV1ucI0aBGhx0Z40/mwSzc21VMzT3n9487PqhYsDVQhgJea8KlKAf29TWP3f0
	iY2Ct0azosoOk0uZBKYTResT3BMplI74o8Pnj1V328eDExvR+Dk3uw5M=
X-Google-Smtp-Source: AGHT+IFjDqjIacp7wGSRSbfJtL0LsH7fLDXjvEYQRAnxwE+sy3Jjq/KwpnLRZ2UrT4jQWMeHlmtmEcUBPqnHeM7K2vs2Bxx/145U
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b25:b0:365:26e3:6e51 with SMTP id
 e5-20020a056e020b2500b0036526e36e51mr224187ilu.0.1709461323118; Sun, 03 Mar
 2024 02:22:03 -0800 (PST)
Date: Sun, 03 Mar 2024 02:22:03 -0800
In-Reply-To: <tencent_BF366E402C056C3C97D8E9DEEE0ECDEC7A0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ebfeba0612befaaa@google.com>
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in sys_io_cancel
From: syzbot <syzbot+b91eb2ed18f599dd3c31@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+b91eb2ed18f599dd3c31@syzkaller.appspotmail.com

Tested on:

commit:         04b8076d Merge tag 'firewire-fixes-6.8-rc7' of git://g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=14602c6a180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fad652894fc96962
dashboard link: https://syzkaller.appspot.com/bug?extid=b91eb2ed18f599dd3c31
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1575e754180000

Note: testing is done by a robot and is best-effort only.

