Return-Path: <linux-kernel+bounces-60792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DEE85097E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 14:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC576B220A6
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674D35B5D5;
	Sun, 11 Feb 2024 13:54:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8F65A11F
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 13:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707659645; cv=none; b=pqJdCFS+Mb4PPaSbdfgOEQRAaZLGnWSVpMUybdJsND4kx9OcQoE6QJ9oWzzjsM3BeuqZ9qr7NIZ6PIDxaBVkO0UcrI40az8l28BdTpXfx839jyHPLwtvB5i5HSzNO/P5XFYxp/BVY4eI65B/AiuyFk+MtmadbVpaQ80oQCjaf1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707659645; c=relaxed/simple;
	bh=QfskRQ2tZ6z9kHMofE2PlUlWAZ+urn2hRUM0gskw7w0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=A0weBT+AW6dkmOUHve69syta5QDJLVAiTyN9KVrc58N7naDKH6uoJw5M37nbyAuasf6F+6aYuKS5o26xeVrTFIHw+vxz592mAhmSvp2o7tpPBeKDTXzliKdkYzQ/kvfiqpfVWftLnU1zA3rh41SwCemkSqCWly1aXw8sXd/8XX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-35fc6976630so23190545ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 05:54:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707659643; x=1708264443;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ADU4lvVGHE+3HsoT81VTSwjst6sh3uN/uviuVPMtQJo=;
        b=GO3QQ3LwzyeX7OyYiuQ3vvsebk8IwTFEMk7Gu9YkyUfOdvNTeEE975GyWnwCvT3wFp
         wgVmXNEhf0d51S6U6vrTmL2eMYWzQ6GdCjrvBLC8/pmgbiuyArD5fMEh0jH48BUFCFfo
         S28uDvkcy9NwXnmyVyLOHG9mQgfaaXYPCPeTL3G65ojRSTS35WCpqy7LbMJAgcE2qyOe
         Qkwjkr1vNsZwncmuux4Xo39Xpd4/L6Wl5EeLtXfQiBdkXcJEhbUqmnT3Xwqha7y/Ng00
         M/ADC3T30oe14Ek9iEEFXnW08HSl7PNISGiPXgjp8svxJH98y5H5qOFYgcfy+JsD8/tv
         g15Q==
X-Gm-Message-State: AOJu0YxLsV0d+/cZxsuKx14LWZu8jcpjtXoXOL+zwURcr98+LbB0YaxE
	quHi3DETpRAiM8Jpp61vBmpNyz7RFFBlfS84IjwSp12RjoCkCjE1/yE4I+Ks8Pe7FrAWm88a7Kj
	mWlD90zp2FH8tVv6lKfIQ3venQtuJdgTKvuSoyRBiNibfhBsz2VhObII=
X-Google-Smtp-Source: AGHT+IEz0MKD6kefqXkAR8vdX7DHm+pBCnj4hCMq0YjZ2b81XNvAEYMDkgb9lwV3dq8/C/1XVyKqbkLkaD23oLLgYdyAf2Qpun4S
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d02:b0:363:d720:a9d0 with SMTP id
 i2-20020a056e021d0200b00363d720a9d0mr383219ila.3.1707659642864; Sun, 11 Feb
 2024 05:54:02 -0800 (PST)
Date: Sun, 11 Feb 2024 05:54:02 -0800
In-Reply-To: <0000000000001655710600710dd0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000690cfd06111b7ee6@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: out-of-bounds Read in ext4_ext_remove_space
From: syzbot <syzbot+6e5f2db05775244c73b7@syzkaller.appspotmail.com>
To: achender@linux.vnet.ibm.com, achender@us.ibm.com, adilger.kernel@dilger.ca, 
	alex@clusterfs.com, axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	kernel@collabora.com, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu, 
	usama.anjum@collabora.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1764f648180000
start commit:   e6fda526d9db Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e3d5175079af5a4
dashboard link: https://syzkaller.appspot.com/bug?extid=6e5f2db05775244c73b7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a56679a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d76b5da80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

