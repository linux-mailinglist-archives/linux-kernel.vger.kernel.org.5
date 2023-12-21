Return-Path: <linux-kernel+bounces-7855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB9B81AE4D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 06:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84B3F1F2441C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 05:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688CF9474;
	Thu, 21 Dec 2023 05:18:09 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC399461
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 05:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7ba74d90a71so50928339f.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 21:18:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703135887; x=1703740687;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v4ZkyA5+SiRjJqcofWEqkvzt/zC/2mStdLzsZTHNcbM=;
        b=FPT5aNXLkGS+cLiiDnc4wHhQNz/u0IFe/m9v+25LvedYr3xpJdYbwaLqYumgSbdpH3
         jUFhlyx2a818EUk3Vvgdia8SDD3Nm6FU1YGWZ62px0obhPSGYvdSmYp1AEu0cYk9+OK4
         ulQQJR6InjnBvq94HCbQCgwbWGq02UPmeiYUBdbpPga0x8jMsDh/F4iC8gLNzC+Rjxcw
         2oRH1cT33OgzINpMCbojPTyqdyljiwpIDfBoBcaNV9oxv7cFJqeAAcKkTEHO+KSh6FsN
         /N1yXQPDgd6J4Gk8aI4vUzCxgegdpFgP/c9GlqmAWIE5dbzr6FSIba4y6sqdyRLqZyAO
         +Pdg==
X-Gm-Message-State: AOJu0YynbI2GzDNN3XhvVxTtPfHZKCAGD1h05TTZYwuyuwx5N++V5sjU
	+l1nhpN/EY5dkGgooUDpQELvDeOsTUu4BoJd5FOSq7+96IKIp4A=
X-Google-Smtp-Source: AGHT+IFOzbTj3PK/tOufiGHRLD7Nvcmw6fc8EPtgFhlG1tZHldwUiROKmCR0I/PO3BgmTEsSy0n7Ev56hoDouGz1WP0vsjoLwQwc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2189:b0:35f:cb88:883e with SMTP id
 j9-20020a056e02218900b0035fcb88883emr291458ila.6.1703135887033; Wed, 20 Dec
 2023 21:18:07 -0800 (PST)
Date: Wed, 20 Dec 2023 21:18:07 -0800
In-Reply-To: <20231221045014.3986230-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008d0e75060cfe396b@google.com>
Subject: Re: [syzbot] [exfat?] INFO: task hung in exfat_write_inode
From: syzbot <syzbot+2f73ed585f115e98aee8@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in corrupted

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P5348 } 2631 jiffies s: 2881 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         f9ff5644 Merge tag 'hsi-for-6.2' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=110d6fb6e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1bf08f50e8fff9ad
dashboard link: https://syzkaller.appspot.com/bug?extid=2f73ed585f115e98aee8
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17028ec9e80000


