Return-Path: <linux-kernel+bounces-98125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 910AA87756F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 06:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABD7C1C20F86
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 05:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF16B13AF2;
	Sun, 10 Mar 2024 05:44:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40151FA5
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 05:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710049445; cv=none; b=ZPOc2gX9aqOhrWwupQMtqvC+n6fWFFotmtyDdvqCbz+DoBp49nBzxE2+eXzkqLuCbv17Y6Rpb5l/rUN4Zjb2o4qoAoYLTPXIpRQtffRkn6HUN+2V+qaYOjwSt4zm5WILUDpowuO/8TyJvuE82fZim+QTCpSrBEnq8nXnGCXFRNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710049445; c=relaxed/simple;
	bh=ZxvTrZvmElY1CLAgfzYeDqqQvYhtj7zE1J1bRkS5iHw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lr8abodhDfIk5T9CMJCgSNVJq0tdoqiWm/ACAWfAY0yJ69b6vJkU0dsYfNs0JcRpT6fE/Z46FygaxMMWqYe1j/bEvTFSKkbrcJvt29L4CTknO5GNb7ehVu4356WbtwY6HatziMIvwQnbBf1F/vlFRFmXVuWaeBkmgZl/tZ0HKlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c8b4d00be6so3663039f.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 21:44:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710049443; x=1710654243;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fg9QOOfct5u/YyIAQwTiYotjgDmWTjZzqZwfCzBZFWw=;
        b=hbyC+UsMYIotSWXtebxoQoYJC45v7szyUBVL0dlm+8DZ6YbmxPMQex4wnxF9X8Q9FZ
         MkOI8Xi54NzCrLrHu6QKLkTGuqLto7UHYoJq0VIYIZtV93seWk6zvpItsz5yorttxQmY
         hGxk0SYIC4fqURu/AFV4ZFh5L2hTh9tLZoyJ6Gu6DQIkc71djQAFBLJW9zkvuK9SY10K
         WGIgclSqpJXe5Ty9kV+Iijz+/93MD3RU5R3hUOK/hbEqfogui5h2rtMb+ie+bSyLJGY0
         NPloFYiDcE4Foushu78LkGiNTihMA0RjlHrO431eYUG7XtgqORXnJqOUsLqXs/KJ4Gp0
         UGug==
X-Forwarded-Encrypted: i=1; AJvYcCWvqpj/7mqZHyzk4zMOUcjdN1l17EwKC0+rLQsmSoeHApjweo6z1w0GbtI2OXmqZ7eSogx2ize4tMpBru4db/lxILRGVdMFL23XSYsr
X-Gm-Message-State: AOJu0Yx4oriwNKqngfU25+54LT9rnFph6CYBFYUvFnH2I5PDewoc1Kxj
	3HmBpAM/WrdMj1+Cjcz+oinzLuaxsynqNMv1FphweKCYiNGNC9DUpW4A0WMLfb9gtlWYU7g42i4
	hORH/biN7jStJt5eKAXjR+qBq3QpoWDMuSX1sYWbX+hoQd8hrZ74y1Fs=
X-Google-Smtp-Source: AGHT+IHGuE8tlKNpBq7UBPAiDHGfgfS32D+fq5AisT1M0C6jjo7+Ub+MTJTJqsrkMo+fWNY8qg3OeFo4P6GJCJ3izohXRV8SZBFU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2dc7:b0:7c8:7bdc:c69b with SMTP id
 l7-20020a0566022dc700b007c87bdcc69bmr82809iow.3.1710049443141; Sat, 09 Mar
 2024 21:44:03 -0800 (PST)
Date: Sat, 09 Mar 2024 21:44:03 -0800
In-Reply-To: <00000000000088981b06133bc07b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009b68ac061347e975@google.com>
Subject: Re: [syzbot] [net?] kernel BUG in __nla_validate_parse
From: syzbot <syzbot+65bb09a7208ce3d4a633@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	idosch@nvidia.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, petrm@nvidia.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 2118f9390d83cf942de8b34faf3d35b54f9f4eee
Author: Petr Machata <petrm@nvidia.com>
Date:   Wed Mar 6 12:49:15 2024 +0000

    net: nexthop: Adjust netlink policy parsing for a new attribute

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13293b36180000
start commit:   d7e14e534493 Merge tag 'mlx5-socket-direct-v3' of git://gi..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10a93b36180000
console output: https://syzkaller.appspot.com/x/log.txt?x=17293b36180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=63afafeedf00ef8f
dashboard link: https://syzkaller.appspot.com/bug?extid=65bb09a7208ce3d4a633
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113a3399180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=156404d6180000

Reported-by: syzbot+65bb09a7208ce3d4a633@syzkaller.appspotmail.com
Fixes: 2118f9390d83 ("net: nexthop: Adjust netlink policy parsing for a new attribute")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

