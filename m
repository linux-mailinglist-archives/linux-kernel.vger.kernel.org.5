Return-Path: <linux-kernel+bounces-25768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6601482D582
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D53D281D08
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE288F9EC;
	Mon, 15 Jan 2024 09:05:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2458AF9C2
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 09:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bf4f260421so11961939f.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 01:05:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705309504; x=1705914304;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LVx/TRY5+aM3lFW0CEf4g6+AvX+H1vWHWxhHpajIqc4=;
        b=cY9nB0djouAsTahzfgfxK5Ncktyr1wu7PjeRDSu60APHEmp2aomhl9Bo5Q371SjOn9
         fsKsC85OQUdowZEkHGHl8QNTEzFm1NShhYhqjI7Lqf+T+T1SnyGzuUzzuB7PaZqUYeqD
         GVoJRUdZU4ZOcXjLA+lBHkPVHg6T5jZ5XuLtHpmrs8DifCq99DQjaNH5QayIOSB5nB3f
         TpKkDoUJ63LmfkAk+JUM8kHSdspfLT1mIogfVm9fir8acHE6Co22PAGE8Sf3/473wTyx
         C1Vt6612SNWlsTgfIQ+DEjNj7l0GrVZK/ZAMudnMkJiSrbnmmqdCjStQB/j2ng8uAvrj
         1Kbw==
X-Gm-Message-State: AOJu0YysLqvMeeSsDFj34B7mhth5b3bnmDG43G8DPIIEEjAdVD/AgAf0
	dI9M/J5sFsPCHGoQVDXRZY+1q39qhhMOHuG96oKQfXjR0U2w
X-Google-Smtp-Source: AGHT+IFAHtwXsKwRc2tGaNFSUZ/qG8YpZXq3pp2yPUkA8Lw9Fb6OwGxvac+9eyj/z3Ljf8TR9XhcSxHYsB9JfXyjfMYncGkXFaPd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1515:b0:46e:6732:763f with SMTP id
 b21-20020a056638151500b0046e6732763fmr221883jat.0.1705309504269; Mon, 15 Jan
 2024 01:05:04 -0800 (PST)
Date: Mon, 15 Jan 2024 01:05:04 -0800
In-Reply-To: <0000000000002562100600ed9473@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003bf67c060ef84f04@google.com>
Subject: Re: [syzbot] [ntfs?] BUG: unable to handle kernel paging request in lookup_open
From: syzbot <syzbot+84b5465f68c3eb82c161@syzkaller.appspotmail.com>
To: anton@tuxera.com, axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-ntfs-dev@lists.sourceforge.net, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11feec2be80000
start commit:   831fe284d827 Merge tag 'spi-fix-v6.5-rc1' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ae56ea581f8fd3f3
dashboard link: https://syzkaller.appspot.com/bug?extid=84b5465f68c3eb82c161
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13a52a24a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=156f908aa80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

