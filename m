Return-Path: <linux-kernel+bounces-127351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C02894A29
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 05:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 417B2B22B58
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 03:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE6E1759E;
	Tue,  2 Apr 2024 03:52:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA44168B1
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 03:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712029925; cv=none; b=t/SWIP5Xg3J5gjxNUxXwJo//edLre4uryWcR5BNbMThDytN2h0F6zW7rXMQG/0H9H9UfKjlW8XEPjWTomsoJVIFHIUbnQTWpUrLgpHm8N4iI6mNvo/BHSGMZIFHnsIWGtLR2cmth13qVeZuAlGbYXoGBg1zsx28dt1YOMzIIGNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712029925; c=relaxed/simple;
	bh=G0IwExIEFgJIfZrp+Nko9MTFW8rdtxlZtGN9KIUkNiE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tSlsa5WS7Ht5TgmkTWx0rkxpAbO9XdZSSNQQnKEKGIK4kbjZfvHD8MdLPP7ruixfHZ5cLz0amPjaEaMRd5ujCf1g5xzzOzT2fK6DwkSS6jK4VG/7eW8be2gB63IdQ+wbIDmEJFnVCQzbT3sWggd6jeJV8lb061b2gCPC+aHhZO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cc01445f6bso549802939f.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 20:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712029923; x=1712634723;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=suybyOoFwcpCDHMAw8Om9CcoZMbKwOnR4XdhaOIDPjQ=;
        b=VNy81mPxjhFLssWN3xg6H/HZSZNtUPhCrxJR5A5MLpBd+ZDzk0jiqDfWBHUzpe6td4
         YQidAAETJS5kegejvECHFXvTtvn/UcjbNu/34bCEIebkXBnA5vM8GKe0t8wnBUoi9vrP
         ZDe2OdWhmLAAGkJSDqsoAF/aioDjysaKeEx74wBwQOFnsA8PFz69FA5Z8iwy7uWvpXt6
         FwvZw8WLek79JZk3DRr4KT+8+MJKjea6nVY+BC3McMK+gc6nhlu4oUhdIzX9GbdeuA1U
         o9MIU6gnaHMNT9fXy80KN3qasq3rpofcafIZZ6V+DLrtmFDJntzUKKR0H1rwy4emTVSX
         3ecA==
X-Forwarded-Encrypted: i=1; AJvYcCXBjMTZbpVAE5cXnFdhx3RUJstfKGrboZQLotSrLQheuf7/gPKAnSg43krCn84MaJES1192bFKKT56/T4RsHHoP6NqdpjrNHF/Y+Sem
X-Gm-Message-State: AOJu0YzcP2vjYXyt/QXSz4fX7zjTvaEHW7+g0a6X/P4/1dC7aCQw/afk
	4aRhmEM7azLitlD085G0yfBurCESbRknL2UNJ7ssvYatXKcmck6Ka6Aj3EUon1KIcaqoEyX1/yP
	vU1iS+wCe0n9/f6FqobfFh1+Bh0dtKElmgIEFDcANXuHYxrdOH2h7yr0=
X-Google-Smtp-Source: AGHT+IGCpZ5IhzK/baYOBbYvO2tKi06n3naIhJ1MESe6cNNtuib5PbvTxRzHdde9tMNbGVkgA7FunXZtVhRlwFXEDPCdRTjiVYcu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2b0b:b0:47e:cfc4:319e with SMTP id
 fm11-20020a0566382b0b00b0047ecfc4319emr816496jab.4.1712029923157; Mon, 01 Apr
 2024 20:52:03 -0700 (PDT)
Date: Mon, 01 Apr 2024 20:52:03 -0700
In-Reply-To: <20240401230144.3642-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006a37bc06151507a7@google.com>
Subject: Re: [syzbot] [usb?] KASAN: slab-use-after-free Write in
 usb_anchor_suspend_wakeups (2)
From: syzbot <syzbot+9a3c54f52bd1edbd975f@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+9a3c54f52bd1edbd975f@syzkaller.appspotmail.com

Tested on:

commit:         480e035f Merge tag 'drm-next-2024-03-13' of https://gi..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=137a04c5180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e5b814e91787669
dashboard link: https://syzkaller.appspot.com/bug?extid=9a3c54f52bd1edbd975f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10f48795180000

Note: testing is done by a robot and is best-effort only.

