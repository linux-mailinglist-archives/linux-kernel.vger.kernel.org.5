Return-Path: <linux-kernel+bounces-2395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5D4815C8D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 00:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6751F1F2267B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 23:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C95374F2;
	Sat, 16 Dec 2023 23:19:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF6C36B07
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 23:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7b70a24dd1dso222499339f.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 15:19:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702768745; x=1703373545;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c52hql8OhpFGWUCpBSY9HFLOe21/vbBOPBZxmXhJo0Q=;
        b=JTR57pDgUW27RJ5PCX9wNgh8VC2y2akUeuAnnT+55Z7vJYJKCwhZe1JAQMISMim6QA
         MR3cXkxo/kLTaqJVdc+M0qq2dW9Ssv4geOstwZXhC2Z32e/bB5wny6fDDn7u78dNrLx1
         qdbknK4nf8KYkiwsNGB4sJiSE1Db7s9fRFvA253R7MNKwK35z6fkjhKV2Z0i2rrK23yE
         gfbEhOJU777Hu+exvZVq2PLBEXC07K788et6/6eOfMmxzoKyPJknHxY3vNKt7evYVtRG
         QlIV5JdfeNv9yb5n9UZQB7hTqG+db3SBf/sy10w6xR2cJ0wCBfTm87roJXnx5zzHX9M5
         xSsA==
X-Gm-Message-State: AOJu0YwtK0K+zsotnM/UaCQRBO9932l4V6yhui8mVpezk6Nx/ShCTLfh
	5eDsB7wEpxQ8Fg3EROTxaVQVEv9Ih8LiR9Z3B6sDeCnVv8WA
X-Google-Smtp-Source: AGHT+IHDVyY7Y+OhPQm2R8skr3NKrKEStHWWVq31UhLGAIELz046qwbxaseC4Yb7zNKtGrn8LA/5/EjYapDqtVDeSayU8Rg3TLKm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5d:8544:0:b0:7b7:446a:e7bc with SMTP id
 b4-20020a5d8544000000b007b7446ae7bcmr317095ios.4.1702768745338; Sat, 16 Dec
 2023 15:19:05 -0800 (PST)
Date: Sat, 16 Dec 2023 15:19:05 -0800
In-Reply-To: <000000000000863a7305e722aeeb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003362ba060ca8beac@google.com>
Subject: Re: [syzbot] [reiserfs?] [squashfs?] BUG: Dentry still in use in unmount
From: syzbot <syzbot+8608bb4553edb8c78f41@syzkaller.appspotmail.com>
To: amir73il@gmail.com, chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, phillip@squashfs.org.uk, 
	reiserfs-devel@vger.kernel.org, squashfs-devel@lists.sourceforge.net, 
	syzkaller-bugs@googlegroups.com, terrelln@fb.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit c63e56a4a6523fcb1358e1878607d77a40b534bb
Author: Amir Goldstein <amir73il@gmail.com>
Date:   Wed Aug 16 09:42:18 2023 +0000

    ovl: do not open/llseek lower file with upper sb_writers held

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13723c01e80000
start commit:   3bd7d7488169 Merge tag 'io_uring-6.7-2023-12-15' of git://..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10f23c01e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=17723c01e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=53ec3da1d259132f
dashboard link: https://syzkaller.appspot.com/bug?extid=8608bb4553edb8c78f41
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17b8b6e1e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ec773ae80000

Reported-by: syzbot+8608bb4553edb8c78f41@syzkaller.appspotmail.com
Fixes: c63e56a4a652 ("ovl: do not open/llseek lower file with upper sb_writers held")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

