Return-Path: <linux-kernel+bounces-32192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CB08357F5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 22:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52B26281967
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 21:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895F338DEC;
	Sun, 21 Jan 2024 21:38:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3994DF51
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 21:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705873086; cv=none; b=QS4fefezhNaWYOd4C2bjW5EgtHAYvsbWhCpsNMz0T/qpAJ1uY1/cDGm20ywm+YvcjeGWOyLpXUCXw6fG44xBHbG/gEEj6ct6n7+3c43i6nGYCc/XQC3g6OprWM+MK0wuX5OTUz39EqMZf1+DL9fo4wKMx3878GUDXHrX+WtKUmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705873086; c=relaxed/simple;
	bh=ADtN1ZtRhdvwA5SdPpt6av/OuYK6N5Bzl984h3cTbck=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=elgvSNyZFv6VvQhxfB57QxTtR20+0fTbhaSy3EnKx80BJdpEy/Hc5kDYo52nJtgvgROo+mYQdS9/G/jphSkP6LD9r1u3c2kaUUWMF0lkPqsLgHvNdXLISAWVEmxS8qGpVCFUoIDtH25Sbs5t12+B4u6FvPxBN29EI54vXEr/ljI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7bc2b7bef65so214884339f.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 13:38:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705873084; x=1706477884;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HfXiDPxljx4DtQYUMkH1jn3pRTh3NiwPfhc+Si6O028=;
        b=sYwIk7PpeJbRyi6wV0b/Iaw/we/tyI5bd4yEV9bAwQElVDO6hRKcuUxuw+r/X3p8JV
         oaEsitnO6pqBgLUPYtHUyH5C2vrufwvKdieyo3YCLnhMP5iUUJQ/sIs8Ep9l/ia/HDmF
         AGEfMkVJigq4biFM4Yzsra8Z6Q056THjmJpSf5OKI76E4kCsZ8vC7SWkQPL4IpBDfCbb
         0DMTJAlK6QOWavM/q0HZCBn795l6OT4PEEQgsgj/KWhAfnr3IRj+3Ye8nd/Df5kIxzTC
         Y2gDRUQVZOp8kyW3mpRADFSVOBEc2r9Dncz4O9sGNbnTiaOnt9MirBJwrPZZnKCELiKM
         M2rQ==
X-Gm-Message-State: AOJu0Ywz6r8h+ddJ35oYhZlUph8RgKy25I0QIur/1aa3wk4F6AzYpGAj
	rmh2S5Ikwrj/fraYxpuES8gCPvgoJTYAYJbjZaQPo9chJc/koLaHlRClU5RCCljJ3sz4pYITpKJ
	QHSDZ5T84tDBeDk/V0PzMsR41P+DIZzAWaBx0oy/KGb+Lvz9naL0kz2M=
X-Google-Smtp-Source: AGHT+IFtw+I9gj7qbGr9UFRCY4KkCPGRElTHhUML0jEx0K8voDN5+lX4C6oO2F04Gf6gZ94y/s6i4OtORoTdBF4fRcEQyrmv4KZc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:194b:b0:361:9a35:48f5 with SMTP id
 x11-20020a056e02194b00b003619a3548f5mr235049ilu.0.1705873084079; Sun, 21 Jan
 2024 13:38:04 -0800 (PST)
Date: Sun, 21 Jan 2024 13:38:04 -0800
In-Reply-To: <0000000000005f0b2f05fdf309b3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003567b1060f7b8724@google.com>
Subject: Re: [syzbot] [reiserfs?] kernel BUG in flush_journal_list
From: syzbot <syzbot+7cc52cbcdeb02a4b0828@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	paul@paul-moore.com, reiserfs-devel@vger.kernel.org, roberto.sassu@huawei.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1556b3dde80000
start commit:   4652b8e4f3ff Merge tag '6.7-rc-ksmbd-server-fixes' of git:..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d855e3560c4c99c4
dashboard link: https://syzkaller.appspot.com/bug?extid=7cc52cbcdeb02a4b0828
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=103dee6f680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12883df7680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

