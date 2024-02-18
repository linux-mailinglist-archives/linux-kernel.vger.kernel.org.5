Return-Path: <linux-kernel+bounces-70372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B21AD8596BB
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 12:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C05751C20AFC
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 11:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6936341B;
	Sun, 18 Feb 2024 11:53:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75C863123
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 11:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708257185; cv=none; b=snGX4BJguA+ibd3AoXUL2223I6VCZSIDpfu6PNNIqCmBEqaDOSS3QWaoljnABomZCVwj5vwiflpmeY2/d1XjiOkq9osXOf71CxFc4m/agu60XPFCOjTH61F0qZpLPVWCfY8xeQj0XKbW1p9oKMTkqPo37O/wyVVJcVsHZ+D+8WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708257185; c=relaxed/simple;
	bh=6+hmd+W4BV+dvIrq+c8lyx1zUvi2WhOlm4Y9/3qs7UE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sSSUlIfVDZx5CAtsQJdx2+dxGvqDw2df/g3PWutxv4Wq9zjaADEOFmBWS29QkaESfpv5IJ/vIzZpzCQ88FVz4J31BeHxSYz0uM+g0Q/8/mLwzRZZ+/6qPaXSyZPQMmYDCxgtOpdq/DMvOyBACGM1SZJ3SyUGlNL2nT8rlVC1We4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3650280b271so16101615ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 03:53:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708257183; x=1708861983;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BWsbO4aSSs4DO+xVFIe6sZD6wCzyO5IWX6HRTcWueSM=;
        b=t35+FUNQHowG/6lzwnVEwQDINbJaAGd9TizPkEB6yfmb1XH9r8QmF2SsckiIaxXgVF
         grT5/7mVAMzyj5zx1x0UNT0R5JexOfvKDrr76t6fdt96tfCZjW4HGncSJEqfsYVNdXhV
         rmvhQHhmcvJxUeqtVg/i/4EJac7ukpjMVHM8iPAJJiR50bz2hjiN72h0iBRJLUxsNOWZ
         vwoQ5DKb8dWbS1DAWo1dzMVESmgvz0X0GbQ99GFkfZ6TDoEgiqpGs2Vb4Fgp3M+ofm6T
         dgFE8WNHwykkMP71suRfgV79sqR4E5sHKREgN+HckOoVmoycmOYcCwxJtGfFZ2Is/x8U
         sz4w==
X-Forwarded-Encrypted: i=1; AJvYcCWqcijUe59lrAo5AtcnRXlZB+hIXNxljI7W4xt5QyrCL1ovHwrtSwr7LitTAdqZLGPnUWpYOX+3gyr+ixpCIGufdbLHaev+Q90jQv9r
X-Gm-Message-State: AOJu0YwbcQwy0XpWF3sT2KO/yN47VepFLkM0q78K6D8rJ2wuqYjV/45g
	7MNgnNwSp+CsD+4U2iD6nzNG3JCMZzMR0nHpo0Yv4Fzj22bvEPKiajzwBl/N2OKMRFAF3lWvokP
	o4Ow8jczDm0K14lQw2kQDAYNOuBELGuCaSVycMbJ2nblCk9PczpwIQRk=
X-Google-Smtp-Source: AGHT+IFIXT3OhUsCbMVjYYsUWl3l9wpox5NiVMHC1HP2UXvlCL7fbuxvKuCnoQpKXDGz68p2pMLDaqBASQ70HUFhk4Qbd0wtQ812
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c568:0:b0:363:8b04:6df7 with SMTP id
 b8-20020a92c568000000b003638b046df7mr783797ilj.0.1708257183250; Sun, 18 Feb
 2024 03:53:03 -0800 (PST)
Date: Sun, 18 Feb 2024 03:53:03 -0800
In-Reply-To: <0000000000004b7b3a05f0bc25f8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000097c4480611a69ec8@google.com>
Subject: Re: [syzbot] [ntfs3?] kernel panic: stack is corrupted in
 __lock_acquire (5)
From: syzbot <syzbot+0bc4c0668351ce1cab8f@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, axboe@kernel.dk, 
	brauner@kernel.org, hdanton@sina.com, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1301e1d0180000
start commit:   ce9ecca0238b Linux 6.6-rc2
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e4ca82a1bedd37e4
dashboard link: https://syzkaller.appspot.com/bug?extid=0bc4c0668351ce1cab8f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11814954680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=103bc138680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

