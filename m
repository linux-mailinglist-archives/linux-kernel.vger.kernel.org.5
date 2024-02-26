Return-Path: <linux-kernel+bounces-80529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31677866929
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 05:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 633AC1C21409
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF291B947;
	Mon, 26 Feb 2024 04:09:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3BE19BBA
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 04:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708920545; cv=none; b=fxrTtlaKcz2y4G5k0KJcBFNiFll9AmKRoUpRRbpezr3NxUZYh9+6tE5neHmlDk7p7zYpZG9gXF9txc9XbgBeJ2lxzF6bgbxoB4lq5mgKMszL0b2a3AeaggMeOvZPdzMqncNIcxtK5lnIwbsvOsMx+OFp1zG5QskRmkSOnRkgdIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708920545; c=relaxed/simple;
	bh=sVf87IQzTzV0aVFiMywfSmA3BksnTd1FHjfXa6C0bbk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WwiQAtlkuRj/EEr+B1+l/flTxF4rucmNHJo0fh/N1A1zOmuepnJrqGK7XJmnz85Xq/biaDycDT3z1ChfjIK8aCnWjFgpZyCbCI0G0h80NOqMWIoOgYVELI4Q+Elo0y5InO07FIMWREvQJRzhB1DBwAFKMqDYqYNBonTbXyfD87Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3651fd50053so24969885ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 20:09:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708920543; x=1709525343;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNDjEj3dO41B6yHWj0vKf07JfaPf4wfX68sy+dsc0cc=;
        b=wlnFLARAHscIPnqgTmZ9/D1AYFyKtx/CPFDozo5Q4zrFkzFlcIWIGlNwfQZfdE+qr5
         D10Ol6kjiyEeMfXcJurFiEtAIh9gmNyugwmHd1vxYWUqC7YPcl35uV6r7KseuxSInuiN
         o87HuKwfhRQ4ydRfKV/mTxfEwnzATAvIe+a9xGVmEjZRyvUmP+G1Hu3GjVMCPDLihOx1
         QBpIwHbIyx4E8K652ILd/W9UbK1e8hy1zEoBE1TtLLn5PiYMzGQR/+HZkP4yIUnueTfh
         2nFlSAS5e8Xn5PWuM1uxJcOOAXjI0NvSNl7pvV89Hyp1EighrULb161VJTrWIFaGl6r0
         ItbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAPNduqr/lGIJyTZdxGDfWbu9CWd0Y3abfJBhf9LfxuKYqgJpWQLntvkBKxckEDfV6B5L3AaiJde18OoH/yBMClfx7W0yqdEOX3Kk6
X-Gm-Message-State: AOJu0Yz4c1h8MCBSBmYQ2uyryf51/ry7DnepuqA1npWGging0sDZscZe
	aAFfirXJkyBggwIYLI959XpfDqxgV1LEV+V973H7a/ngTbv9DuUFhrl7vUdmE+iU/P+fJR8nRbC
	hoUdXYU4mK9yiKOt9egfQVKXJcyh8217r5K/GzcKG+a0o4rXwoztLCgc=
X-Google-Smtp-Source: AGHT+IHGIB6xFgTBe8rarTPKRKsWIcHLb2B4v1XZJ1w4HhxteEbNfAkQ533BJ23mhdcAFx0a27dCQeZQZTB4NpfTSSMAAxlsZQQQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d13:b0:365:2f19:e597 with SMTP id
 i19-20020a056e021d1300b003652f19e597mr470242ila.5.1708920543138; Sun, 25 Feb
 2024 20:09:03 -0800 (PST)
Date: Sun, 25 Feb 2024 20:09:03 -0800
In-Reply-To: <001a113eba282f2ffc0568b76123@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ec5a2f0612411136@google.com>
Subject: Re: [syzbot] [reiserfs?] kernel BUG at fs/reiserfs/journal.c:LINE!
From: syzbot <syzbot+6820505ae5978f4f8f2f@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, alaaemadhossney.ae@gmail.com, 
	alex.shi@linux.alibaba.com, axboe@kernel.dk, baijiaju1990@gmail.com, 
	brauner@kernel.org, colin.king@canonical.com, dhowells@redhat.com, 
	gregkh@linuxfoundation.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mingo@kernel.org, rdunlap@infradead.org, 
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	yanaijie@huawei.com, zhengbin13@huawei.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16fcca02180000
start commit:   b85ea95d0864 Linux 6.7-rc1
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=b5bf1661f609e7f0
dashboard link: https://syzkaller.appspot.com/bug?extid=6820505ae5978f4f8f2f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1728c947680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1079c598e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

