Return-Path: <linux-kernel+bounces-152353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 545858ABCC8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 20:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8A3C1F21264
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 18:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87103BBC7;
	Sat, 20 Apr 2024 18:35:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08343111A3
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 18:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713638106; cv=none; b=ZbbXFpZxU1WDijRZMnzJkEFca8eMvy6xzsxJZlVis+QUXla8ggQuXIMopeMuK94znsg86jL+t/yBW4i3ChQt5AZYDx5qHkaRv6Z5q1d22A9gBC+IIU5DBcyzzsIEOVd3tik2qzY/hk83MKxzZqBQxcXvEr3O9pt/+fIuhS3ZWJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713638106; c=relaxed/simple;
	bh=hdYBH6iHeFdCwus1qkWibPK9xXXOODQaZ79r1j4yrBI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JUXTMDyvg66/X18ulaT38d2Wsojgx9BYOETsRC923sGzqOcl+6v03qT0xE+Zjpd1/JHfaSbSsC6o+50VmCu83WmZE90R+vE1maCskscrxj/0LpBA4sNYzfGVfZhsjXDRoIplENFWUQ8NmCnPZ1EG4AxJocmK3sQvo1k5y+ac93I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36b28210f43so39134785ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 11:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713638104; x=1714242904;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E/RSUERUuEiGuR/bt0u6YwzU2HAwP9JNrb2sLt0V+TM=;
        b=ON+eAnE8aTU5sOwUIR5MxRpQ9EtBtDrvkHTRsX/eyOd5K8xQkYkt81g2ZzmHwUn+T6
         Jf0ixnL9MBp34niBksj/g883X45XX1YClyTxY7QM8+Zj/fGkE8BbLt1tXRbBiPUGZDTU
         lQwIy75s9HkFoN39Cmi+sHl1ufr4Qt7ieJwQR85eOpQkHn7ZAHkrJXMjF6lpIvHan24O
         CS3BmOQOv6IPWiIXBHg/efW29maEf1Hjd2jbGz+bPKzFGMOCtHt3vDcSM++xfCCgmayj
         iX47GhqrVLv3VDG748hk6bcvYKauA3fG4HKLCZfEsqKN2XV9UyCwOPZ7NWeaiiXSaB0t
         cPfw==
X-Forwarded-Encrypted: i=1; AJvYcCWCebC5IczpRlp2YtI+8qGoQHyzDTLHcRqYg0NyMZ+SyZyndAvIKpqld27jf/S71g+noyAa5YAQVyADpsiNTGyn5lvO+PEL7Vqh90ZR
X-Gm-Message-State: AOJu0YyPMOdddH0Tj9Ll1EFFL4OA1rn5PSu9dk7o4UGNUV6F71dnd+PP
	ZyPddOWHrJ3c+XoNnyMfgipvvNF3EwSOkg7cxyPyx+MSJ9+b/Wo8W8xAS+JKlyY5mVmPPVKoxDk
	/o0VIguZpiU870x28B3n6RV58FIS024Eqa1Y/4thTrpnZWi7t+smQBks=
X-Google-Smtp-Source: AGHT+IEIYRljOZ2wAtG68BgkwUPz1JJIzsBclxONGi2PdmpGI2v+nTHaehY42mQIKfag3/pz7z4wzM709vsB92+SFOsPU95f+07y
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c267:0:b0:36b:fbab:9f14 with SMTP id
 h7-20020a92c267000000b0036bfbab9f14mr386675ild.1.1713638104271; Sat, 20 Apr
 2024 11:35:04 -0700 (PDT)
Date: Sat, 20 Apr 2024 11:35:04 -0700
In-Reply-To: <000000000000c6405606166fdc68@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007aa28106168b76c9@google.com>
Subject: Re: [syzbot] [net?] WARNING in gre_tap_xmit (2)
From: syzbot <syzbot+c298c9f0e46a3c86332b@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, fw@strlen.de, 
	horms@kernel.org, kuba@kernel.org, kuniyu@amazon.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 219eee9c0d16f1b754a8b85275854ab17df0850a
Author: Florian Westphal <fw@strlen.de>
Date:   Fri Feb 16 11:36:57 2024 +0000

    net: skbuff: add overflow debug check to pull/push helpers

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=167a954f180000
start commit:   443574b03387 riscv, bpf: Fix kfunc parameters incompatibil..
git tree:       bpf
final oops:     https://syzkaller.appspot.com/x/report.txt?x=157a954f180000
console output: https://syzkaller.appspot.com/x/log.txt?x=117a954f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=c298c9f0e46a3c86332b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a94f00980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15bce6ab180000

Reported-by: syzbot+c298c9f0e46a3c86332b@syzkaller.appspotmail.com
Fixes: 219eee9c0d16 ("net: skbuff: add overflow debug check to pull/push helpers")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

