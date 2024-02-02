Return-Path: <linux-kernel+bounces-49533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B161E846B8B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2E541C2537B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFE86A002;
	Fri,  2 Feb 2024 09:08:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCE45FDA3
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 09:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706864886; cv=none; b=qHHa2j3Yf/0CyaHLhU5+qQrRiYZRWUiUhdBnS7fLhxXCuFbm2hrHp8LsccGr0HDtlI2M858Ceqm/fveBYFr0caNerYfEsjkjq+3AiKhv+s34+rmudpuQc7wFRRo9KOiU04k7DUhj6B2eM/D1ich4hA7n00FKL5aBJ5e67PVy478=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706864886; c=relaxed/simple;
	bh=XY0wgWCyBdKF2c9DVyjRU/KDnI870BxzE/LOzXqWTu0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WGjJU7GPHGSVz6artGm61NJgrWdFa4vuPqz2vwFT0oG1N5t1MYogimqf1TpsAdpZzSnEzw54DF5w1mvDMJ2ZtKmfu530WM79YEj4yaWvK6E+DNTWsx/Bq1WT2+fx2yowsUa2hlvj2PfwXxlQFnwF9JJRXGVFxqGYn9MUZFVNcFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-363b161279aso4586555ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 01:08:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706864883; x=1707469683;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XeDyEjCvb8uDBw570BFodqh+gAPdP68pZyBdqJtXcM0=;
        b=ZkCDEIXeeauw+t81sveXc9DkZ3yYRWf+rZ+9IHT8NHDugWzd/ktAnfVLEmC99JA/c2
         6nFeTht0Y+uWMn2mO/cdp8ON27QsVF+j9Ii4pkXX6ODIQgt9sM20Neegb/X58+YtlXA2
         6KgrhQd1zQTI+H/pwTDCL0ZHkD1IkGTD66fQn/mKSdzFB2HiI67LefRsUqOlIGjkiqnB
         wNH653f193UYVlUTe9kjBZzFxiEEZnOFgGUFRocLSilYPRgL9oMv9JMs2cxy2AA7RqX/
         m0CPP64sYf5b//Uhk8YqsQ4CPObftKknoP7IHuwU3fJIWqihKS2DJB8BkJTvdH2JfpHU
         QHFw==
X-Gm-Message-State: AOJu0YxWVdzObtjWtgGxFKmjp0TrQS9Vogq7awtg8UEFKSlDRJp/Ya9l
	2Yv/NW58V1j1s4oeXeJOz2jLFEMDz3uBM5ABxigwRJo7CYP1vMaZbjY2HeyyQcpoL2jljqWj7cY
	r9J6EhvoT63XQJEBQvvLjesZ4HCZ8CtrP23wW7hWOKCjhgJalWLLcMX1tPA==
X-Google-Smtp-Source: AGHT+IGwzbGXZSuQ8ya3zWymx/ZS2tMJ7Gxk15Q7LsFjWFECcoZ0SYcn98NhnI6ntgYiJky7awMmzXGg9AivbgpEKkBRkORmXuuj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b06:b0:363:7aed:f073 with SMTP id
 i6-20020a056e021b0600b003637aedf073mr95989ilv.0.1706864883646; Fri, 02 Feb
 2024 01:08:03 -0800 (PST)
Date: Fri, 02 Feb 2024 01:08:03 -0800
In-Reply-To: <20240202083546.2409378-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000011d1ee0610627308@google.com>
Subject: Re: [syzbot] [v9fs?] KASAN: slab-use-after-free Read in v9fs_stat2inode_dotl
From: syzbot <syzbot+7a3d75905ea1a830dbe5@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+7a3d75905ea1a830dbe5@syzkaller.appspotmail.com

Tested on:

commit:         076d56d7 Add linux-next specific files for 20240202
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=14811f1fe80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4eccd90d3ac887b2
dashboard link: https://syzkaller.appspot.com/bug?extid=7a3d75905ea1a830dbe5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15f20a38180000

Note: testing is done by a robot and is best-effort only.

