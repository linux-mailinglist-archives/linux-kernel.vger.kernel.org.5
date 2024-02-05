Return-Path: <linux-kernel+bounces-53963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C9F84A880
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 499981C2A135
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECC14F202;
	Mon,  5 Feb 2024 21:13:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F52E4CDFD
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 21:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707167586; cv=none; b=rSWvOhgzj8jRcxNXjOJJNpXeUam7OmdxAeBaKn28GHalVNH6NRTxYFkJEYfrKV454XsZfycXg/3bZpI3TVTQj0ick1/VJMUi6OjN/EkF3Nc3Qq4x69q91Lt17E2EQR3GIYep/J/4RcG/TKOhDioGqzW/VjctgIJ0DP6CEET/kQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707167586; c=relaxed/simple;
	bh=RERVg0NCmBPsnzb6n/jjfpC8aRmrtHhD3ZlQlxIVfBs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=swonWZ/K+B7c0snD43NuwWzkgt2DGI5DLH0ww57FzfYctZoG/4HyXr+W6gIrITdA8p8C8iyDyBYO5dbaqzK0e65nvIN7MeB6FKIeANj4588CYz5zT9H57oO2ujBUYo0+HC1+riMf6mPyruLrLMLPMcoSxgCOHztM/b0SX2gt/aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-363c3862a93so16777965ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 13:13:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707167584; x=1707772384;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Z0ihoDKUQq9Uqt/80kKGIwkNWhhfnyox0+aJomGQ+c=;
        b=WEi/gdu/zCFPEdszz3zNFtv56yP/Zro84ahw2594oYB8VU5/+asrZ0i2qw0WdMNHWw
         PbtMGWPy4zzAjQbnpihTqpojaXQMojtxlbitnV2R1EUFPoa2MmAekvnG+pNC5rr71Jl9
         omDKzZfl8W5LiGAvXH653B7BfDu31qBDYY/qY4U7jMqpp4/NQ5XnlPtnssV7NvXNmBJL
         OTgMKY83F30cC8LMqRYokrNnPV8NMWwg6irhJxTPB3y5Ieyai4W3YdbvzfDZponv4jWE
         5hzHUgDyoQ7YvdAvji5IoGBlWG3aymXVmeEEb+6Wf/xzGKGpOGLdFPhRmHoLYUpybG1k
         yjFg==
X-Gm-Message-State: AOJu0YxOrTFTLydQiulv5lRD1tvmf74Ac3zC18Lei2E87zycZAZ5b//P
	u0WnHJ2Tf2U49FgZI8dXvVW6L69+K1AxyFh05B0k/b3EMlHnixrgG/yMnDIXvODS0TUMg7bPnyT
	ekeBIYLsLC9fjTABqw/No7wVwIlps6pPbb8Ao0OSZSKKfIe8pc2SGvIE=
X-Google-Smtp-Source: AGHT+IEUIJq4+NI9WY9amk5S6XGpR/DU60PskU08/wZ5acN0mwT02+7/lbDHKIoPrXocNN1g8Li8iF6NRBWd9DCQRYIGP5il6yiN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9e:b0:363:ca05:c856 with SMTP id
 h30-20020a056e021d9e00b00363ca05c856mr55769ila.6.1707167584313; Mon, 05 Feb
 2024 13:13:04 -0800 (PST)
Date: Mon, 05 Feb 2024 13:13:04 -0800
In-Reply-To: <0000000000009c7eb105f5b88b70@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006f69c90610a8edb3@google.com>
Subject: Re: [syzbot] [xfs?] INFO: task hung in xfs_buf_item_unpin
From: syzbot <syzbot+3f083e9e08b726fcfba2@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, chandan.babu@oracle.com, 
	djwong@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=176f2d7be80000
start commit:   d2980d8d8265 Merge tag 'mm-nonmm-stable-2023-02-20-15-29' ..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=471a946f0dd5764c
dashboard link: https://syzkaller.appspot.com/bug?extid=3f083e9e08b726fcfba2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a077d8c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d91c74c80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

