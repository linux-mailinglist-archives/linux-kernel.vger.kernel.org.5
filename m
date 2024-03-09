Return-Path: <linux-kernel+bounces-97915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4B3877194
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 15:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B69C91C20C6C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 14:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6D040BEF;
	Sat,  9 Mar 2024 14:09:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52431BDF4
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 14:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709993346; cv=none; b=OsWBgRvzmKet/UoarWUYWSfkExhf0zPP0ii028g+NCZj231WxvD73hUB+JW5r0SJNIDkmE40+Pd5INlGlbcCQCN3UxbzHsnosisxqaSfyDD4Nwc/J/eq/K+dYps6e/SafY9LeVuJ4mzLNUXPDfPcAyQQAhmvteSS2L3W1SaO7nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709993346; c=relaxed/simple;
	bh=2+frEfNY9kCZ1DL3xeqyryfAD6b5yyHATCqZqM5CrB8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SNFKfUCcJYdi1nJ8kZCS7BNHpiwmJMpLm61F4mfvIuccgzbF7Ws//zjKoEiFjDQgX9Q2spsl7JFrskIaMzK76Z9Oql+PltA5/oG06lM8tKOvuG1oqQeMLgR/MbIufbjE5+Pb9bk0CptsR82BkTNttsBuWGDGL1efWgPAqp1/A+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c84b3570cfso299467639f.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 06:09:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709993344; x=1710598144;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2LGzq8t2cO0APm/rv1jJdipgtRW0jr2Ew9T+G34Z8Vk=;
        b=tWUHI/rMi4ZxS5jV+Y8hd6J99l9Dnk2VM97wt2QQCIQ3rMP2lbQRslzZAbyeAPBtG6
         FMRgf4rZR2x8dSpabiAHaVwKhtA26rkKLrYLSVbyEzV1RKDzDY04JQNlrvUvyaJlJVgs
         5dDJ7U+mXAZ/j2HUKUWqV8gTPF2L3HbqU+cnSiCLcIa/GbFYi5t2X1CCpwSq4khpG5bg
         UQ64EaVKRO4SPzZjMez3wbOjMDtEBvcI/4vWvbyweL39ev2CY2k5KZwdLp11TFyozGe4
         GcAbN8Fdzl8eaAa000RHD8fueBmFECqFw3Q+pEEv2b0cJm10khVK89g1PQED9YSsu1lM
         tFJw==
X-Forwarded-Encrypted: i=1; AJvYcCWKW3s8pAqSbJcWFvmDb7PJEZbYppIACXvv6MJCmhwpdVjFrN+1BGkfRZrAYg52gdKSHPKIAVTZraHhpkBk3q+e8xKE4kTqBCtAFv2K
X-Gm-Message-State: AOJu0YxkNRlH2dYcnK0hwLUd7heo019iVkDDD4nZZVEcCV78aDIV1y6n
	5pP8Moo+//TRM/GVhEUPZuz0Wt/mxYgUdO9ASSUoJZY4VTcV6/yUKmldla9t+SeHjbzXEgYOECo
	G+CTKOF5LUppyl2Y9fnTS8iUiNWpBBcBbBC5UUN6/jAxG3sOyThjRzc0=
X-Google-Smtp-Source: AGHT+IEwvoaxIjpkkmAaqdrdf8pyKru+spENnqat1cc0Qzw8RLRm6Fge27YlG5LX18apnrqnwtvO3b/C7CB8oBa7ib0ryoatqXZ2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1654:b0:476:d5dc:b729 with SMTP id
 a20-20020a056638165400b00476d5dcb729mr79848jat.4.1709993344002; Sat, 09 Mar
 2024 06:09:04 -0800 (PST)
Date: Sat, 09 Mar 2024 06:09:03 -0800
In-Reply-To: <000000000000f250a605ec981d41@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d682ec06133ad9d2@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in mnt_want_write_file
From: syzbot <syzbot+1047e42179f502f2b0a2@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, hdanton@sina.com, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=164f208e180000
start commit:   ac865f00af29 Merge tag 'pci-v6.7-fixes-2' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=655f8abe9fe69b3b
dashboard link: https://syzkaller.appspot.com/bug?extid=1047e42179f502f2b0a2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=116d8055e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15687d81e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

