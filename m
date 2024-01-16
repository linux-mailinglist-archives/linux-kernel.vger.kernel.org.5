Return-Path: <linux-kernel+bounces-27544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D47A282F1EA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3458B28593B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB341C69E;
	Tue, 16 Jan 2024 15:54:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C7F1C68D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 15:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-35fc70bd879so82628825ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 07:54:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705420442; x=1706025242;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WjLKJeIUZFZaxihu0DFtFUlDAFoZeUeFTWq4/cmqec4=;
        b=WVmSCYC6H+qCwd14+m/bEu7N/7ZnxppUQUjXOAWICJPfBq4cyEgC6OJJgVlCw2nx8d
         CFD//K7yb1ukNJpArQfDRW0YPUDW2Ze5wCjd7ZOinh2bIVT3atlfP1qNQJT3t0Ed14TK
         A3ceIonMTBIsUEliZwdVVoXlusKf50KtQT/8nLKyMElf8cbiFDKE7cwDff5yJTyTKnFQ
         DlPWb6FnfWNZ01VYdSxzpIBZ7jZDiVJPGjET+N5q4rGwIymQQAvVVmHyWOc0PYcwnVKH
         /No+XndOobJgDL/VDCYxhouzgvUKyNOxOEsk2hmFZy5C2UK6UgL/B6nBTyPgymTF5G37
         +mGQ==
X-Gm-Message-State: AOJu0Ywg+n7cPY1b76x/FZkXQF1MApwluDy4ohblrZfBYZohqXLTQywn
	eQ/oC0zz7MZdeFQRDkBZpWwW5boVgGfpHpEj8GjGZKtBgUdw
X-Google-Smtp-Source: AGHT+IFlxGeh6AVV3dy7wQP5TLN9X3pB0gPsRG+Ydvt6+VGd2M1Ue/mlIulGQpjXlNXkskBWVWAg5PmI8zIRlMA1Gap7ra3eI7D3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a03:b0:35f:affb:bd7b with SMTP id
 s3-20020a056e021a0300b0035faffbbd7bmr1234893ild.2.1705420442573; Tue, 16 Jan
 2024 07:54:02 -0800 (PST)
Date: Tue, 16 Jan 2024 07:54:02 -0800
In-Reply-To: <0000000000008d00ec05f06bcb35@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ac2378060f12234c@google.com>
Subject: Re: [syzbot] [gfs2?] BUG: unable to handle kernel NULL pointer
 dereference in gfs2_rindex_update
From: syzbot <syzbot+2b32df23ff6b5b307565@syzkaller.appspotmail.com>
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12452f7be80000
start commit:   0a924817d2ed Merge tag '6.2-rc-smb3-client-fixes-part2' of..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e2d7bfa2d6d5a76
dashboard link: https://syzkaller.appspot.com/bug?extid=2b32df23ff6b5b307565
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14860f08480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=174d24b0480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

