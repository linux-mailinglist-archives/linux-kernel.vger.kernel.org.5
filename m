Return-Path: <linux-kernel+bounces-60384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DED24850444
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 12:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B6F3B241D9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 11:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7118F3D0C5;
	Sat, 10 Feb 2024 11:39:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C912E632
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 11:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707565145; cv=none; b=VOCwaL69vCWNLIZea15Qb3H27gT/QfwbHYB/NJLeEwR/6eYFNtA5UpdPp7OpsnChL5ruiCCS4ucykz2RW6ego4Z3/swkVc4sbsbdHCIpR1GoBUg+NmPoQ7OTrJKhacrbI9pJq8a6OCg9nhGpqo8jmC8VWvbJky5GFgek/5DOWf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707565145; c=relaxed/simple;
	bh=psU5HZINV3lvtGwr7FIVv+Ynd5/O/IkxDoLcSw41HoY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WlujWtS2TXG5/K/mUeFr8icuO5YBZgw9hcu6r8zdPWDIwvhoXShBFcwCoiykWmnzGQ16ajfHHvn6MPEO6Zo2v5hYzTLs0YkApq4FVKl9jNbsgIolD1mpgXhIGtBzhrd++SaX4FZ+gOtCOnuDcW1awZTpIdjGfzgmbL0u9TZ002M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c064b035acso148766339f.3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 03:39:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707565142; x=1708169942;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PRmodYsFSUzbQ8C0tv4dmDfXeC5NYSRjiW55UJr6hsk=;
        b=c3uXxL+Di4q/Dt0hqWc2ngdn6bRMqX7UID6IewDv9vzVFQ8baxDv0t6OwDlbQaikff
         nUJ2WQDfT89YLmJVotHKliVXH1eM9j7i533PpDJLRG5g0G042VKJ08QDbyNyMOO6Aml2
         nTBnvYICHSVmu+qbxibgZ7o9I6/aPCleBEartQbI24ymT+qz98vO1VPpXNqSoPW9l/Wi
         4lRURNd/kxSxv4QpGoTMwaY9D+GfbDUyiebCRSPR8lVRhfEXEkDZUDamNAMzqA+blzHj
         V71WB7aeoq1CLdiWSGHz7i4knyRZErQC65YuBnHcGK1wv29hXG4KolbKGVtyhY8rQJxm
         FygQ==
X-Gm-Message-State: AOJu0YyKwa5neh4affCE/9x4qQ8Lmn/CnW9OB2XwGkkgmbN+zewocX9C
	le6V2FPtMoTbDBMOQ9ekDiZIaYBnWMi0FDOtEK0xnfJw7CH1Odzo/OABP48JfLC/iTBmnVS11hE
	lXy29xn1h/TPio9hp/4sTIp1STD6A9G6kYfeh4JN9Lsr3AghoOw+CUOQ=
X-Google-Smtp-Source: AGHT+IGyfm+2peLqyqC/wWoBPr3Kebc8m7e0uZUcKDZ/GvPMpqfnYdaK51OwEUrBhoqpQsaFivrdRNvaybejhptywuSh2I2k1c06
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3a14:b0:470:ae57:e1c8 with SMTP id
 cn20-20020a0566383a1400b00470ae57e1c8mr32125jab.5.1707565142663; Sat, 10 Feb
 2024 03:39:02 -0800 (PST)
Date: Sat, 10 Feb 2024 03:39:02 -0800
In-Reply-To: <20240210100707.817-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c273340611057dc6@google.com>
Subject: Re: [syzbot] [kernel?] KASAN: slab-use-after-free Read in __unix_gc
From: syzbot <syzbot+5a630f8ca0120ab43f55@syzkaller.appspotmail.com>
To: hdanton@sina.com, kuniyu@amazon.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+5a630f8ca0120ab43f55@syzkaller.appspotmail.com

Tested on:

commit:         b63cc733 net: phy: realtek: use generic MDIO helpers t..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
console output: https://syzkaller.appspot.com/x/log.txt?x=119e6c42180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ac1116e4986e7570
dashboard link: https://syzkaller.appspot.com/bug?extid=5a630f8ca0120ab43f55
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12fb6de0180000

Note: testing is done by a robot and is best-effort only.

