Return-Path: <linux-kernel+bounces-73213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 845E085BF6B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2A5728105B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7567573162;
	Tue, 20 Feb 2024 15:06:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7776F53C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708441565; cv=none; b=osuxDOsI+aeeJi+2fLGl/w9wpxYxo4nlGdbM8eo34bS2PY7XzUVn7tS/fWrADXgaGrpHMWzEO2sfCGBddQI+MqQBa6xvbbu4l6MbBSlD4G+2wNsylnT/bvTuwEdFDoB5iP6u4UlMD4xECOFzrt+S3wxckf2KJ6iiUOmuBHmpHZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708441565; c=relaxed/simple;
	bh=QGSpzD8IrL2IL2FVOH+KRPNBrRVxL+/XdPkqbD0Yrgs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NHrXTp0IfrScE6vpK0ZjavqFCIw29Ylv2TYxT1fqN+uJOUzy6bnMZdCGvWaTcMIwyf/vRvim+6yMNrLkmuqzltC/+QUumaFthi75Cb0bz9FdWB13MNKJp6sk095X6OmG/aB6tqUEDrMk09o7gZK9BG/ZfbuljzZyRzUkMTjf4ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3651a2610d8so33552065ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 07:06:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708441563; x=1709046363;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+yTxsOwUhHvJATauDuWZBUQRT5fbxREug4NmWnZkrzE=;
        b=okz8VKUWMbZdrsqyZFBaBuASbdoCCKtONqlQ6NZq4JmzPFspV32lS3RDr7DIIwWBOq
         uG0ugidOVUVb0zL/tfXvxyEe4QK/9FdSiSnScmOQvGWOZ5rzGc6M7W6yrvM6T5hNM4XQ
         4KWc/REb2AK3ipSwfV+y9+Ke+X2M1gGaCkkEjVyQTxL6gN3nJQdcFbKpH7VxNaQjOI76
         oH8szcU6kGAGSnfLxjYyN/3I9nSUC4SUYX2P3DIWge6X3HRCcd8P977AauWl1ujoe5G3
         qkk6OCF8x5bzZ4NkoN7WSUAoxCKfK327+Lk+xk4ZBLOBYn+YYGkrvAaRmhkplD0ruFvO
         y/wg==
X-Forwarded-Encrypted: i=1; AJvYcCWHJzRJeGvolGTG+CexEq6S62igxRCNi8u7mdraIFDPI8JIEiMsekBDHHsnbQdL4fGEzp8UeNHe2OXlg/NLV3+Ur/2A5lWuSvr8UnFZ
X-Gm-Message-State: AOJu0YwMkw+vosSMW2ts4NDIfe8HGY1YS4lFtC9+yMW60kOxbkeORaG8
	Bc59Nyg4TsHhb1HJtEA3HauuFZJC6hxZV02VsesFRbXPfnmmmU02PjcK0J3VKZgR3743RQT+Hg3
	ecqXrvfv2h2JzZUD8Xx9HGAo4AcLPbyPk2cVI/Ojt5lNka4ov/Ybwajs=
X-Google-Smtp-Source: AGHT+IFdqJve6wJsxc9By8rzEOYNew2XImrd8r7hRr7EXK4O0t9yzUL8Ic/2bOauglDK4zzjRVPIP13b8gmSQayyuKpXBAYVt79z
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d91:b0:365:88b:3fba with SMTP id
 h17-20020a056e021d9100b00365088b3fbamr794506ila.1.1708441562919; Tue, 20 Feb
 2024 07:06:02 -0800 (PST)
Date: Tue, 20 Feb 2024 07:06:02 -0800
In-Reply-To: <000000000000bdf37505f1a7fc09@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007a3b2a0611d18c03@google.com>
Subject: Re: [syzbot] [ntfs3?] kernel panic: stack is corrupted in run_unpack_ex
From: syzbot <syzbot+ba698041fcdf4d0214bb@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, axboe@kernel.dk, 
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk, 
	yuran.pereira@hotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=149d61e8180000
start commit:   41c03ba9beea Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=8cdb1e7bec4b955a
dashboard link: https://syzkaller.appspot.com/bug?extid=ba698041fcdf4d0214bb
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11e43f56480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13fbabea480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

