Return-Path: <linux-kernel+bounces-127973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3486A8953E2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65D731C22187
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EC97F46B;
	Tue,  2 Apr 2024 12:53:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4CC7A15B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 12:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712062384; cv=none; b=MPjZBc7EFY4slzGuG8Qs/k0TFQDPpYPQKltT4rwhjjBY7e+BTL2B/PoemvjyQDpOJhZdeRYYErW3WNzFVLlcEV2jLS9yuZL39ysQ7D7JCQqzJQWo9aQfNzN9S7uDztjdNe8bdb/bMaS+aPtu6ZIkdYT33ictX7NtmojOYlTb1B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712062384; c=relaxed/simple;
	bh=T5O8RYK86fpjMvzIllXc6AdWut+HOJCNf2vCbH5dfaA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RHilUI3MXGjYuPexVm1GrK3S2AcaGpLYm1aUDMKCvQTR7K0Ezspac7q5I7UyAc9Mjbhyk0dYKAMUnF2kAbEyVY3wt9YCCYXPslYjiOTQ1CFmWMQ/9+M08TNfB8K+KtG8vpv5QdVP5yQYaHF7Iy8mVLKjpjILdKGrHfP98eVi4Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-368814a0181so45223915ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 05:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712062382; x=1712667182;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dDFD6hPb2m34Jatgwto+6Sh/QU8P295nFH21ySfga5U=;
        b=vZ2EJuN75YnFOds9Yoj/YP9UXzEjpm3TeVi+wJKcNZ4Xw6pWCdhjqdgMOMZl9OvmeD
         U8HDgZfGsKcRbVZbNBwZ4v4lSWyW/VqADhvePTexwjZjNvQl1Ba9WC1HEZ/1U/F8iiu5
         QGQJgt8PaemP1nLbz2JTFMl+hLZ7N+Br1OSvOjBDob6zvemD6uWOkcxVwT3lMgXiiEq7
         lnHYKtIHK6KPxS5qScg6yNbBqmWDflXVAh/8SmhSPXPd5903Os82L6+if+5lbdUaSGQX
         HbtB09kyMVaYGJ1Qexrq9wYBl6FNWA6SFvjdeOxDmpUa+a2QIMn2TZSM2tD09sXLYK2X
         fovQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAebG3vK93TYcSgqmxIxrDnB1L1lu+vgvf4pqHGEijmc83MKVbeYuyOzQNSkYhN5r/OoqihuLdZf9uqWjHiPTV2kTAI9aP5fHCOfnk
X-Gm-Message-State: AOJu0YwwKiEa0zgiFXhUPNOBNyxZw+ehbk8KOdzLJ8LfhxzIH2FOB4kD
	E0ub1rO/y4Baoi09do9grU+oyESZdlb8zKeMdgea0qvLGvgO4TvTFPXtUjOCM5ohhYxb8CCgdF9
	YQEPKDpdv8dI3PVD53VlbwZ45wtiNS77wYLsUlDLQ96udkf1ZglKc69U=
X-Google-Smtp-Source: AGHT+IENf7UMfM52wKZGqfUzY+0pbi7hSTUlEJlOvyacgpVivWnyIVILUDtKttcgoxSiNmEyIDZASTB7sqvysDNHZGqOVMBszIjR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218f:b0:369:9361:5b6a with SMTP id
 j15-20020a056e02218f00b0036993615b6amr458434ila.5.1712062382117; Tue, 02 Apr
 2024 05:53:02 -0700 (PDT)
Date: Tue, 02 Apr 2024 05:53:02 -0700
In-Reply-To: <00000000000082de1c05f81467ed@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001ea9dc06151c9630@google.com>
Subject: Re: [syzbot] [reiserfs?] INFO: task hung in deactivate_super (2)
From: syzbot <syzbot+aa7397130ec6a8c2e2d9@syzkaller.appspotmail.com>
To: axboe@kernel.dk, boqun.feng@gmail.com, brauner@kernel.org, 
	dvyukov@google.com, hdanton@sina.com, jack@suse.com, jack@suse.cz, 
	jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp, 
	reiserfs-devel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16799ab5180000
start commit:   ac865f00af29 Merge tag 'pci-v6.7-fixes-2' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=655f8abe9fe69b3b
dashboard link: https://syzkaller.appspot.com/bug?extid=aa7397130ec6a8c2e2d9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1669644de80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=137d7db5e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

