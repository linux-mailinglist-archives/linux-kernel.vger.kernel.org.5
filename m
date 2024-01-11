Return-Path: <linux-kernel+bounces-23111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DD382A7C0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDC19B25AD8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 06:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FCD320A;
	Thu, 11 Jan 2024 06:44:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA7FEADD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 06:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7bb454e1d64so465880739f.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 22:44:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704955444; x=1705560244;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Go7MHHguEsXDJaMiDiMFUZrkJPCJjs8e6jnOcbKt05k=;
        b=NCHlsWTb938sIKsN6eqB+bnNcARFRIlYRkZFYwzp2VfdGYZ62tO1ym1H2Wtc1Z9XJJ
         6xQ5jSJ2QszBoPzRrzuZfvQxX9j1CsYS+ULwGT8cqlzR7zMjcS/wA/x0SAAprBbXI1Ge
         UBXw0Gwx9c2PlF49NN07+j6JhQuLIFtLFQUpNrtpInq3SFcgB0/6a9QpxisvU97XUdlL
         frdOX802kzIzPfINK47Fj9WxACINVhLj4nlT31p8+LUDjKWjDUJ6VRxYvr3awN4LJgyZ
         YfrZzIB7xx86Zuhh72XEXGOeXPsVXb7foz6gNQ3h86ai3mkGQZ1U+fpo1kie+8YcdXGt
         85FA==
X-Gm-Message-State: AOJu0Yy4tVtXVpqj4NuX7oaJkfx9jDKzAKoJS05D1ta77A6GfBlGuu/J
	VC8ACSRGUmMB70uXO+4xPO90Z/pqpGNbnKC1Dagy8Pr4+Xf4
X-Google-Smtp-Source: AGHT+IHkD2jmO/TL/yOssuiaFNilDxssd908YaoSm12wBNANAvPSwd623sCODi3g2j4cDI1dKtqu1f3WEK5dMfbA4SkkLKacv/vM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:210:b0:46e:50ab:6a4e with SMTP id
 e16-20020a056638021000b0046e50ab6a4emr31005jaq.3.1704955444335; Wed, 10 Jan
 2024 22:44:04 -0800 (PST)
Date: Wed, 10 Jan 2024 22:44:04 -0800
In-Reply-To: <000000000000fcfb4a05ffe48213@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009e1b00060ea5df51@google.com>
Subject: Re: [syzbot] [hfs] general protection fault in tomoyo_check_acl (3)
From: syzbot <syzbot+28aaddd5a3221d7fd709@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, jmorris@namei.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	penguin-kernel@I-love.SAKURA.ne.jp, penguin-kernel@i-love.sakura.ne.jp, 
	serge@hallyn.com, syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp, 
	tomoyo-dev-en-owner@lists.osdn.me, tomoyo-dev-en@lists.osdn.me
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15135c0be80000
start commit:   a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=7406f415f386e786
dashboard link: https://syzkaller.appspot.com/bug?extid=28aaddd5a3221d7fd709
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17b5bb80a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10193ee7280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

