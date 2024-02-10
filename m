Return-Path: <linux-kernel+bounces-60354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 864808503A1
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 10:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CED81F234AC
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 09:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5052436137;
	Sat, 10 Feb 2024 09:23:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834F133CF1
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 09:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707556985; cv=none; b=EQFUTUh3q0MrAztxD759bToPKRbWLavOXtRuoUb5+6MuW/i1dGcC0TvovNOFrt2SbKFA2QE2OwiUtjIG0S57nKHGJTjbb13X+FFv5Z+1JvyD/InLTagYJ98bt4C3OKgHV7ZH7l8xOe+ZJhHwbhL3CNhCvgDZmAAdCc4fXuZjS9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707556985; c=relaxed/simple;
	bh=3r3XMRsm9E2/82rvdkdZixYcLy7dHpfiFRvdLE6tp1Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UezKEWuNHyReDZxt9h6Kl8TSeCJ7MJmh0QK8a6cVgXIZe9EhUPXwoW0BjnLUSSeP7n3Q+ETc/cbGYIBvrAcLGkx7xERGpMkzQ/QhzJwMMN6azqojcaEpISkLGOiEdMCaWARiVLgVq1rwLjTEX+geLHvJl6ui4Lglo4KHyuyTxSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-363d169c770so20830565ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 01:23:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707556983; x=1708161783;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GqCsyr+HbbKsXAANM7RDwJf0XiYCIX6FiahqV8RdlFI=;
        b=QUJMdgWW/m3VEPuYMQPG2KXE7VAzoj+D+a8qSS8ujdn56PEgf4jgr6wiQKwBlhIqTF
         qimkDeTD0IolflabpGGTmHDaO9HBnbu/zdsM4lZwPx1Jp7xjyTiTdmei88x/nfiE6abb
         4A+FYfSRqFI1Frf+PYpmYnb1CiHaARelXY2zzSla9UaWvnlNWmxtpUvAKWNQJDFSoyrE
         2R9vvCpQ38FdcbXP64WDcZr5iLtuDdAjyvkVy19Ob6CpW/9TLOkYrs8ThZ8xKMZCTkIm
         tS6xMDBTbyoexkKhpf6EkOln+l8sCxzf9r17HItFJp2H6PYrUfR2AZs01N5LTY/rrnaV
         dUGw==
X-Gm-Message-State: AOJu0YzOq7ssnP10/GadQ2rkQ67in1J4LuQoOt/oOEJKK6/okdTfPFFP
	VyVvDmLvVOgW8BfyMjKgEZThpUWaTgw+fHPDHt6niY49rOYCvLKNHif66kG9tn/VgBXub3x1G3L
	gjzskOsOEZYd3lLBrzP4UYUUFnXFFO3QbM84NnvBR26YvEtODwyFkORE=
X-Google-Smtp-Source: AGHT+IEENhUIL8V8bhMbxxhXr1L245/BaAsWAlkUA6s3NzTp92+K8tCQ31DYFl7ZNlJoeeFvGQKJSr5nsX7yo3j+A1LYCCvpyHpA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ee:b0:363:c288:f8d5 with SMTP id
 q14-20020a056e0220ee00b00363c288f8d5mr127626ilv.3.1707556983767; Sat, 10 Feb
 2024 01:23:03 -0800 (PST)
Date: Sat, 10 Feb 2024 01:23:03 -0800
In-Reply-To: <20240210-bekunden-glasvitrine-9c43d2672a55@brauner>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000738b7906110397e8@google.com>
Subject: Re: [syzbot] [block?] WARNING in bdev_file_open_by_dev
From: syzbot <syzbot+96f61f1ad84e33cee93e@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+96f61f1ad84e33cee93e@syzkaller.appspotmail.com

Tested on:

commit:         672cf418 Merge series 'Open block devices as files' of..
git tree:       https://gitlab.com/brauner/linux vfs.super
console output: https://syzkaller.appspot.com/x/log.txt?x=157f9cec180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1ee6536d236103ff
dashboard link: https://syzkaller.appspot.com/bug?extid=96f61f1ad84e33cee93e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

