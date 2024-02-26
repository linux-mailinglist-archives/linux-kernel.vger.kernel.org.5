Return-Path: <linux-kernel+bounces-80353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9E7866748
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 01:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B28C01F2158B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 00:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72FE3D6B;
	Mon, 26 Feb 2024 00:17:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DE0EC4
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 00:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708906626; cv=none; b=u3rlFv8fADme2LNxG8O1mDMN+HmH7sYipG4u+pfONLx3Cc4zLoKbpr+O1G/CSbUydY92QwHJVgvkbEkFaCiMl2O3x+grf8tv2w3h1sNNFwyLFPJi4JV6YOaFQuTTNAkSan7ZUrxX6yh8YuGRveBOIntCVLOuhzMCbNXut5LxgtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708906626; c=relaxed/simple;
	bh=uEPs3JVf4orzGIZKaOSre7Yc6cd3i87Gg03dlkfwZjo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TL0yIlB38opYkamBRICCjQudlHM0bLGPMGN+lXgp4pFAjKSQgH4QoGHqYDcewtgU5xenOoaQMPS3gAAJOX35Cn+UVGdgvmUg5+28JEbBFfn4fOM7FAngON9QlJ2moeZHELHCwQztXhoQg8x6KgMcgaIJevm4ZE74OMxYwPq4ftE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bfe777fe22so189257739f.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 16:17:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708906624; x=1709511424;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+KxGTuAn7JS3VSjYdk/J4G72DLu6mPsYSoTotXdZcE8=;
        b=lxpk+5/G0Nz9eySdzuqEvEasRSHoKMkYFmKgPaphFtyKEBbQhakUgu67KaGwUZSpzO
         FScv63s+kt1vbp8myP/kiylSHceZHKtR9NBB6k4ncunq0BPAuRVw/iSPlkJruLZgytPp
         NLn/I6Tjyp0ECszWMYwuk8/IVTbhjFFyKBe3U/s2sABXr2LXyYvIYY0WZfqBjuKCEkBh
         HFPvuvNDmrJJGyrxmCSj1vYoChU6H0IhX4rC4HJpR6JF5K5uXzqqxjPA557kK2rw/QE2
         n1NxivuRCtfymCLeYpxAUVSjIExFLyCZQcjRlr/A4flZZFwv+szRZgYO3Jxy3zwdLME2
         Y7hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPMY8HSt2hKbizE5MkQO5TuPashXyaFVP8jyAyRbVqUoqt63mnW/xQgeKoZtvVoDdkkKtiBvuZLuAA3GRMMKBsKsvps/ng2Z3lHQFs
X-Gm-Message-State: AOJu0Yygg1lREk4shdIAho9gvZKwpr18/rpVu1/kRyr0bPnpD+r6ubNW
	XQ2dgbH5Iv410MTqitQu2lsxI6B8j5jtE+3x2EKLkBcQFh+zdNXd1o2A/wjOVT05RSztGPOy9LB
	7YURp5rpL3GoOtifkdqhX1x7zfDuQtp4oj5QczXbm1vetRNJthG4fWUE=
X-Google-Smtp-Source: AGHT+IEPdJiPXQk/Y5Ki4jmV6bC+J2REozS48fthEdh4ECHPMOB3DaTaQA533+TxJ4Giih0NBiJmzLT2i4axTx7Ya5eMyMIBM8aQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2710:b0:474:77e9:bb16 with SMTP id
 m16-20020a056638271000b0047477e9bb16mr134065jav.0.1708906624287; Sun, 25 Feb
 2024 16:17:04 -0800 (PST)
Date: Sun, 25 Feb 2024 16:17:04 -0800
In-Reply-To: <000000000000a2c13905fda1757e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004b8d8206123dd402@google.com>
Subject: Re: [syzbot] [hfs?] KASAN: slab-out-of-bounds Write in hfs_bnode_read_key
From: syzbot <syzbot+4f7a1fc5ec86b956afb4@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12e81c54180000
start commit:   e5282a7d8f6b Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=162cf2103e4a7453
dashboard link: https://syzkaller.appspot.com/bug?extid=4f7a1fc5ec86b956afb4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12feb345280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=123cb2a5280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

