Return-Path: <linux-kernel+bounces-98239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3618877738
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 14:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E2DD28157B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 13:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60FF2D79D;
	Sun, 10 Mar 2024 13:58:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38A02C6B2
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 13:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710079084; cv=none; b=dsPnN3NSKHoRI+VX2/ED6e5lufU4/Xcr5JYwQ+NZSxhQBjaazT24oZs/igReA7x/YnsVw2do8bGqNym6vKFpvkjAtPLqRbS4V9gdbTQ9VJfzPbrj8MTsovLkXCGPydW9LJhKzs0XQ0+F/U0Nxse4UmZ3tI5KPIhGUYzgoz3a8O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710079084; c=relaxed/simple;
	bh=JyzhFgbDOx6Af7bUiMEd5wkx93ZXqSufoFai6eWCL4Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=et1JoEGn1u6SvBNxFwJzpS/gpk3ccgOrMHPM+wYs9qz5TsEDXr4035LpvIopXDjTH+DI4SesHb2YfhNz1z1JOObXMIA9rJvuT9tnIC+5pgd2sQyttEKMajiO6F4CpAfCWWcpuBtanpdZeLf8eB0Tgunxxie3lhyol4EWfxz7G9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3663022a5bdso22594455ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 06:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710079082; x=1710683882;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E7Pfnp5j39cfC/fSqSZPc3kGFvrwJmOZXFYwh42T5KY=;
        b=FcEMCFIYTqWuUq9ZEcHnWnGmmoPxxxcn5HdAHAKkgPlEHbcgaofhAxISCgnVkuUPCd
         T9jEo4YF9AfiikczGGjdE30KCXOab0nhLrkLZslo82snLsdl9uB+/86naiebUZK12ksH
         JV046mmNjgLuRZ1+P/stKwe0kmbttFCSmw6GXJPMM/4/HWZCMoBcsr3JFl/NfFsDf53y
         94eiRA97uTvVaBdNWeqT0kowt61vd4VE86nt9ySzXxN9ryQvmqDzBgl0b7oc0L1KOW54
         2JbT8YY4PQ1LPN4yMbZ5PJnVcIdl5uhHyJtzU+8Oo210sX5YMlX5MreikTQ94ADTxpN0
         9FhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEbNCdjdj/trOCvh9qWI34T61vke0cg7F3PvYpS0ojKiK1R6Tme8duFkJxbOeTnCLgTznIUF20qAN6vB5KLGQkA1ro09KKz1wt2NoF
X-Gm-Message-State: AOJu0Yw0/ncR6MdwAENbnv4vcKt4gXjv45Sxigsa81qNbdS6lo1WFlcc
	0d9/GEtpdTUwHtCaVBvHoBl1beOVe6e9BtS3cWLOkhvyLNRf+/iNz7nL/+5p4cclObjHrehg+Q1
	FlFWpdtD5/ErkWS3neflBA03NMwF7EeBp3TweeiMd3DjesSqVqAshyA0=
X-Google-Smtp-Source: AGHT+IExp4lwXhNhAd5/3buXSf98psR5D7lEbmBh/I8nG3rHvlv7l+v7cW1K/yhJZmdwAlLr/Tjob2ioIYNPPYX5UR/n1ISmSGkT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214c:b0:363:b9d6:1261 with SMTP id
 d12-20020a056e02214c00b00363b9d61261mr309014ilv.0.1710079082223; Sun, 10 Mar
 2024 06:58:02 -0700 (PDT)
Date: Sun, 10 Mar 2024 06:58:02 -0700
In-Reply-To: <0000000000007898e505e9971783@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003becc106134ed015@google.com>
Subject: Re: [syzbot] [jfs?] BUG: unable to handle kernel NULL pointer
 dereference in dtInsertEntry
From: syzbot <syzbot+c853277dcbfa2182e9aa@syzkaller.appspotmail.com>
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16cb0da6180000
start commit:   a4d7d7011219 Merge tag 'spi-fix-v6.4-rc5' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=7474de833c217bf4
dashboard link: https://syzkaller.appspot.com/bug?extid=c853277dcbfa2182e9aa
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15cc622d280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1762cf83280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

