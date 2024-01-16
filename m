Return-Path: <linux-kernel+bounces-26942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A4D82E847
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 04:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C04281F23A2F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 03:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71F079C1;
	Tue, 16 Jan 2024 03:35:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE416FBF
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 03:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3610073a306so7132515ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 19:35:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705376105; x=1705980905;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QDZPKLWcldx4Qh4G0TWmxOUwgI57VtugrnMHdb+OGCE=;
        b=ODrBE6DrtNW6rmBf5emjb013RZDG9QxX6fDDvoHnPeozvhdAshAbiYMyadww1a71hS
         wcBscR0K/GU/gUxcSqmNoCC6xvCZOWUxS+X/uHVWzs0nXjC/D4ljvxxH9edaR2Thsj0C
         bn92DZeI7Fm54d+NSWgRlFio2B7yMQTLmuoudH5OwUMUYVxo0Lt8Ck+fhAw5OS6BrTQb
         ajYaqJe9TAIbBdJrVE4ksp55ODy082f96vzcPwqfTVE8Ptspe1iwZFc7HzsnPu96fDZD
         VY4b3Fwm+kswhEPrtjxubCMB46FWfV4qxYrOu8ndm+lmF1ToHgMU79ijG7elKSsq+JQe
         Yv3Q==
X-Gm-Message-State: AOJu0YyqjJkvcOE4e7X/2spvq2z3fjpdw0ZY/xe2AHHijSwuCFlNoWVZ
	0+VPchL7YwQZLFsfCP/0RD65f882IeyyVmHeV2kp9/6BWE1d
X-Google-Smtp-Source: AGHT+IEmZtzkNJYz5yodsOTO/J/hRFV4GXetYqHl0g4+sQzW/5cRi3XB6vwH0HMFagaNmW5Hf5yS7qVF2+p4VnVeERztj0SwH9gi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c49:b0:360:6649:29da with SMTP id
 d9-20020a056e021c4900b00360664929damr962185ilg.3.1705376105526; Mon, 15 Jan
 2024 19:35:05 -0800 (PST)
Date: Mon, 15 Jan 2024 19:35:05 -0800
In-Reply-To: <00000000000057049306049e0525@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fa7c3b060f07d0ab@google.com>
Subject: Re: [syzbot] [gfs2?] BUG: sleeping function called from invalid
 context in glock_hash_walk
From: syzbot <syzbot+10c6178a65acf04efe47@syzkaller.appspotmail.com>
To: agruenba@redhat.com, axboe@kernel.dk, brauner@kernel.org, 
	cluster-devel@redhat.com, gfs2@lists.linux.dev, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rpeterso@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=165bebf5e80000
start commit:   3f86ed6ec0b3 Merge tag 'arc-6.6-rc1' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff0db7a15ba54ead
dashboard link: https://syzkaller.appspot.com/bug?extid=10c6178a65acf04efe47
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13e4ea14680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13f76f10680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

