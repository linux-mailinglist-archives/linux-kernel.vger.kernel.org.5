Return-Path: <linux-kernel+bounces-69449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B3F858926
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9411B2829FE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61C61487FE;
	Fri, 16 Feb 2024 22:48:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C231487C0
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 22:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708123685; cv=none; b=iQQd4CpDunK0E9sSoDse+Z7s55R8sfx/cwhkCxS60QUsokm06Uvx7Jl9/TFHejCQ6hBAjgBQvXL7BtrxXLBZJ7n/M5+hv/2WCP/Yo3oJegwCnUw79bfvBvlcHHj5mBm7BetsH8sIYev1OZMtpHR6XaqTFa85UQNQQqcZ45uqeuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708123685; c=relaxed/simple;
	bh=Oc8/VVHL3mJzxSm9wwcBnL/NkDYsxziPs924FwSBpcw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gmlHHFemdRXd7JxMJpcR7I6QdXfkmZ4bSY4NvrZx4eIp/bArSNvQsn7czELOtFeMhQv0YQpdBYaYXbBNpPbHp0R/LwwgS2S/Xd/iMi7m86O9ow94IUOOkwGfCMR0P48UyU0gsGz6OH9YTtYfhN2i9DprZj7EHVZ0GVqhbrz1p4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c43aeb2970so163267039f.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 14:48:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708123683; x=1708728483;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FgA0grvx/iurskLb7osrvJiMpOml1Vk2dU3E8tYqYNQ=;
        b=J43Zzak7pD9bv9C4mM0RxSpfCQ+at4NP7k9+DopMg84HKcYwHBZzMWVyUh8ikQcotu
         I23SQAmFZa98AS3Es1w/Kovr8t8RZIbEFvsKP4E/D4H7P+WNyIdDDAbQbXlIhFnNL3rY
         HZcyvqf1y6gPs4x3CxAI8ybk9Gpuf1TEtb7hLKuTyp0h+yw9x2tdb/bM+gqQY5MsFk+1
         zsJuwMYySMi3z+JXepXNkAyKJ46b31tizU0N6cZ84kcHkocqnZvAvaAUSg3dbYQlvoae
         VXIuJaiZEqWRvrwN77zhAGbSFUSjNFTdlgMQvfwfFV60vUwBL6h844Ej2P/sIYqKVjR6
         32WQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6hnGRdK27PawepQ2O/XS1IvBR7+atFo6x+/O8v7tLlltaQZWBWxkpU0C2qH05dxUAHCcmY6Jp0bCsNlU4RFcqTt82hs4CuL6DAGht
X-Gm-Message-State: AOJu0YxR3D2S6P5g31izWJUs/EuECmUfOA0+Do5ag8qyHQBFVtmwTKFu
	2Q43oyuY5TolqCIcPR2QFYuez6+pLuBQioh/qYo/ONwcTugs2f+SPwJISXnQ9NNMpdUaL/S0ESx
	IqzLev6YzBqaHPpRl7jL/7L3is1Gzh5XBrijWZMYzZY7x2AO8YZpZRV0=
X-Google-Smtp-Source: AGHT+IG7sgyLqJEM4CdSPqmCU6u6X75Kn3VHzvRg1bqrsbQgtfcdDFL24k1piEhpu3S3maBCtZ+28CkM1eb1SnD5QQSXMiwAp8np
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d1e:b0:363:c25b:75e4 with SMTP id
 i30-20020a056e021d1e00b00363c25b75e4mr545125ila.5.1708123683116; Fri, 16 Feb
 2024 14:48:03 -0800 (PST)
Date: Fri, 16 Feb 2024 14:48:03 -0800
In-Reply-To: <000000000000520d3405f075a026@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005d6c8106118789ea@google.com>
Subject: Re: [syzbot] [reiserfs?] divide error in do_journal_end (3)
From: syzbot <syzbot+74b838cfa47fc9554471@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, bvanassche@acm.org, jack@suse.cz, 
	jlayton@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org, yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15009b1c180000
start commit:   610a9b8f49fb Linux 6.7-rc8
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=655f8abe9fe69b3b
dashboard link: https://syzkaller.appspot.com/bug?extid=74b838cfa47fc9554471
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177f6ca1e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11e6349ae80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

