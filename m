Return-Path: <linux-kernel+bounces-60347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1DD850378
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 09:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10C8D1F22CA6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 08:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02D72FC29;
	Sat, 10 Feb 2024 08:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="uPi8XWBb"
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9507F6AB7;
	Sat, 10 Feb 2024 08:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707552664; cv=none; b=bF34ObFzJo+IGVvofLUBJmcyzJjAqyzXFgg9KisNPICTaCQGngKv7t+0aaLUD4/eXUQIY81tBPlJlp2wDPkV1FdzFQiZm5ktg7aJhhu9M3ButdMRl3tZSlqVSqACNYtmJgDcrIbzMRZ6CKGiMlhUqwOugJXisRzu+g40c/mwi7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707552664; c=relaxed/simple;
	bh=AbPkgCagtD1y8tlVBlOB0QD3Xfspe8K5xQIIKN6dAOA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SjTUd9lVyfHxHl5y8Wc/1IoE3PSb+I5XCLsSRCs0XgN56b/rq0TBToHV3UFTCyD4weHEQzL7hnegZefsXI/zT67kHMHgcmgKncQTNmIz/X6GvhdVi2fq5k3HID5KpJx5R+7zfC5IiMyGL0om8XeweuyR03n5ZuELtoZah8vlgyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=uPi8XWBb; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707552662; x=1739088662;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rYl2d4jg8VGr885odBjyaGJb+lzTLraSiU4iM1Tv/Gk=;
  b=uPi8XWBbPP/QN33M3JmF1svtCCSFZxqIPKhaZDLu80rkSxQOvc2h5AE/
   GVYPrxkl4x+p/Kxvq71nIUa8EBEXulMgGeQoKZStml7lAdu79oRUDk1+X
   csiXzdaLuDLLxWgN/q/hCIXqjZkFIO3JmJhc/4LLmM8lHkwQCawmCuP87
   A=;
X-IronPort-AV: E=Sophos;i="6.05,259,1701129600"; 
   d="scan'208";a="704049959"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2024 08:10:57 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:38610]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.244:2525] with esmtp (Farcaster)
 id 35e6c251-706a-4da4-a450-c46bb1c47596; Sat, 10 Feb 2024 08:10:56 +0000 (UTC)
X-Farcaster-Flow-ID: 35e6c251-706a-4da4-a450-c46bb1c47596
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 10 Feb 2024 08:10:56 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.24) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 10 Feb 2024 08:10:53 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <syzbot+5a630f8ca0120ab43f55@syzkaller.appspotmail.com>
CC: <bp@alien8.de>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<linux-kernel@vger.kernel.org>, <mingo@redhat.com>, <netdev@vger.kernel.org>,
	<syzkaller-bugs@googlegroups.com>, <tglx@linutronix.de>, <x86@kernel.org>
Subject: Re: [syzbot] [kernel?] KASAN: slab-use-after-free Read in __unix_gc
Date: Sat, 10 Feb 2024 00:10:45 -0800
Message-ID: <20240210081045.46999-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <000000000000ee09930610f42470@google.com>
References: <000000000000ee09930610f42470@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB001.ant.amazon.com (10.13.139.152) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: syzbot <syzbot+5a630f8ca0120ab43f55@syzkaller.appspotmail.com>
Date: Fri, 09 Feb 2024 06:57:17 -0800
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    e7689879d14e ethtool: do not use rtnl in ethnl_default_dum..
> git tree:       net-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1195b6e0180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ac1116e4986e7570
> dashboard link: https://syzkaller.appspot.com/bug?extid=5a630f8ca0120ab43f55
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=121d9b5c180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=165f9cec180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/c5b791d72e1e/disk-e7689879.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/472cf2131e7b/vmlinux-e7689879.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/c1e5a4b33244/bzImage-e7689879.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+5a630f8ca0120ab43f55@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in __unix_gc+0xe0f/0xf70

#syz dup: INFO: task hung in unix_dgram_sendmsg

Here's a fix.
https://lore.kernel.org/netdev/20240209220453.96053-1-kuniyu@amazon.com/

Thanks!

