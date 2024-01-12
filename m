Return-Path: <linux-kernel+bounces-24267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C8182BA03
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 04:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48C4DB235B3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 03:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD441B282;
	Fri, 12 Jan 2024 03:39:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463841A733
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 03:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7bc3dd97ddaso521643239f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 19:39:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705030743; x=1705635543;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xsULNSwGIqV6VUSGukBMzcLGajKxNSaJ734615aHwHA=;
        b=DmIXDS4EvF7Ve1ciJ6xOE8MbOGRn8SWms9OdvHZrD7JlH7DaanUN5TDLp5aEyS+LKn
         wAqchWdvSLgWGNNNmmbsv24kJehvspVyo2qtCm9C/78PpUIykNkpLEh+awDvo/R4oog4
         6RKXkgvIheLCYMNoErHrguE/lbin4Q75dtA42plaS+M6hBrkTOrtV39PVZyzWQBVrKvG
         Gnrw6D/P1mVwHgOQMWJ8B+1WZPlgUnEmQ4HuUTFw/6iAZY4VWULAjojfGXvdtzAzpfTt
         +BkjFG95+8H9iY4sugplxCHZAB5C+eybMBiULkLrvCW+zzvW84dwb+cVmhUXE+m3h1wA
         yysw==
X-Gm-Message-State: AOJu0YyVDIIaEpm0wvxIIdlG8P6arzvlM0fnuO+jrpdKMqY9KFZe0hlA
	rVAOToT4PZwju7/nlS32/s1wGKaifKioLnS7aSuxrzI3AJ+Y
X-Google-Smtp-Source: AGHT+IFGqlpsi8dlH+HvtsYNFd8ARrOfbhWwGMTrVn2p9Ud5mrQRWT6kM7YT+oCmAt1Ng0h+W+FtJ+N/1VkAem0GQDq7T9nGEFaW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:304a:b0:46e:50ab:6a54 with SMTP id
 u10-20020a056638304a00b0046e50ab6a54mr43374jak.1.1705030743535; Thu, 11 Jan
 2024 19:39:03 -0800 (PST)
Date: Thu, 11 Jan 2024 19:39:03 -0800
In-Reply-To: <000000000000ff4a1505e9f961a2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ccb6c6060eb767bd@google.com>
Subject: Re: [syzbot] [jfs?] general protection fault in dtSplitUp
From: syzbot <syzbot+172bdd582e5d63486948@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1268fc69e80000
start commit:   a70385240892 Merge tag 'perf_urgent_for_v6.1_rc2' of git:/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea03ca45176080bc
dashboard link: https://syzkaller.appspot.com/bug?extid=172bdd582e5d63486948
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15692dba880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15017b2c880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

