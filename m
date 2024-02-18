Return-Path: <linux-kernel+bounces-70479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9DE859875
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC441F21334
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68766F07C;
	Sun, 18 Feb 2024 18:20:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46B510A0D
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 18:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708280406; cv=none; b=CtHqxJK2RMIVYYVvH1/XXZfRwtp/9wIZLR7voMi7RT4X4pJMpM9UnzaYRcPAkg85W+XB8nCfsQrurrbriUkLUP3h6cDR9Psb9j5gHIFYpKDJ/pArBlXfvk+0dktLA68ByIlb32weN2sHS4cgICiBf5pYM5PpEiKIAkQYxQ2oask=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708280406; c=relaxed/simple;
	bh=OjZOhk1V36DUvjvKyFQZuCTHYsyk52FnsJ6tpim6bu0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=i0Pm5/LJKxjYeqhXb7edPM5yVwh3G2YOu/FVKuSWAtSirq4FsTg5MCHzzrwzjlgWdSgOfKRrbWXWE80KIAP0XGfdCsvH1uetUtkDGg683GupC0kH5/UQT1VXn/V3NyYiEmflIk6HnXwofDKyBkcXuGjvFTr3Nhj60zfJxTCpk/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3651d2b88aeso8684875ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 10:20:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708280404; x=1708885204;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ag1C/pfftsxznqlU7qI7nLJfRxsAdzy+OeJxgj8iLpk=;
        b=eXSUe+WespZSmPdazW1l8dVdGjWKs17jO4wQwZ8g5jhY1PaKiCTQuAe+GV208qyvEH
         NEquN7v2W51p/sGNrBq9W6uNnrF618EOBts21YTJEjVqVK6w2Mo508onrES7Ez63hOew
         iFydzOBvSDiyw6Uh+O8IKTeSC2VqLUNj1eF7doyA/Lq5oWTzGExFP6OLzH69CK2kMM/8
         gQ/V2PcYNMQ7fCaeZRwLzYkBpZMtyRK6p15JFQ8QHS9DrikGB/3DoLEusjYtZfIMeJ/j
         eoX19bDw11WgJEowwxm3/16tCXEbgxWNg8NmpO61FNGD7Lt79X6ax4c8tfwdsMdpvpnA
         PmxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaYep2JjEUgcspGsqggruhI43BL6jg4BiyVM7r7FFFLZRKh770Rhqb8qDnllPHSzirvgDrUXpn+byigwhZiHXMR60dA+4SNWkgXeol
X-Gm-Message-State: AOJu0YzZx3tHBNQFMKjw5a8MQfDwmBUG1hLdpKVyBoDMoD+psQ0Z0i4f
	rs0Jwh73kwttkGKxmrADn8fCPza6YWb+0yDPyXVzFGfgH6h96gNQgJAEHSqjSmwdO923qlcONAX
	CNPxF8dCWS986r7AhVd8qKOP5fygoirtAyx8b5HNucPmcxkfDGyVyrP4=
X-Google-Smtp-Source: AGHT+IFnDU07sQlq4O12VDuAhS+4piwxVJQKUAR3f4kON13CbyGVPuv0aaJ/5vl8jzwTrJ7Q9uOPC1OLLEvLWeIlnjJyQg1dKDm1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4d:0:b0:365:21f4:7008 with SMTP id
 q13-20020a92ca4d000000b0036521f47008mr336981ilo.4.1708280404175; Sun, 18 Feb
 2024 10:20:04 -0800 (PST)
Date: Sun, 18 Feb 2024 10:20:04 -0800
In-Reply-To: <00000000000056e02f05dfb6e11a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aaf29f0611ac0603@google.com>
Subject: Re: [syzbot] [udf?] KASAN: use-after-free Write in udf_close_lvid
From: syzbot <syzbot+60864ed35b1073540d57@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, alden.tondettar@gmail.com, axboe@kernel.dk, 
	brauner@kernel.org, dvyukov@google.com, hch@infradead.org, hdanton@sina.com, 
	jack@suse.com, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pali@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12c941c2180000
start commit:   f016f7547aee Merge tag 'gpio-fixes-for-v6.7-rc8' of git://..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8e72bae38c079e4
dashboard link: https://syzkaller.appspot.com/bug?extid=60864ed35b1073540d57
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c2caf9e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11f518f9e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

