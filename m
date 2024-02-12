Return-Path: <linux-kernel+bounces-61894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 878B28517EF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44A6A282A75
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FCD3C494;
	Mon, 12 Feb 2024 15:28:57 +0000 (UTC)
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5C13BB5E;
	Mon, 12 Feb 2024 15:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707751736; cv=none; b=QZT+TYlHrW3Y3oW6cpZR/eRMes6N95Rfw8RBAe/eCvc4kS0BnzkrWJapgpBbqOG/K3oPi+m9qCuT1PaelDWe0FZUzzYrE64u+Qk8+XFl8shylvrmBhfk0XRoc4db98K66RNWr/JyVwgS+4YgSkr0eHr4OQvRWmW0eEnchVfA2D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707751736; c=relaxed/simple;
	bh=UlNQdXdEu8GFaDckGHWpz0bCZpO+hsGs9qo4St9gRCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CeWnfqhDoh3vWr9JOyMOvnA0dtzxravDlsHGoZRuQDC5DruTRelR4zMc/rIhq2yz5VQlIX/1bQ0l7kNkLfdnOAHzYM0blnpjYRgNZKoVCGx6Fp0QFuOKYSmMdEdFZdsTCjhml4j6fg9zTE/jIe8b23gtAObA7JzPfHETGF8HpAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 2601B2F20241; Mon, 12 Feb 2024 15:28:52 +0000 (UTC)
X-Spam-Level: 
Received: from shell.ipa.basealt.ru (unknown [176.12.98.74])
	by air.basealt.ru (Postfix) with ESMTPSA id 7DF152F2023B;
	Mon, 12 Feb 2024 15:28:49 +0000 (UTC)
From: Alexander Ofitserov <oficerovas@altlinux.org>
To: astrajoan@yahoo.com
Cc: arnd@arndb.de,
	bridge@lists.linux-foundation.org,
	davem@davemloft.net,
	edumazet@google.com,
	f.fainelli@gmail.com,
	hkallweit1@gmail.com,
	ivan.orlov0322@gmail.com,
	keescook@chromium.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	mudongliangabcd@gmail.com,
	netdev@vger.kernel.org,
	nikolay@nvidia.com,
	pabeni@redhat.com,
	razor@blackwall.org,
	roopa@nvidia.com,
	skhan@linuxfoundation.org,
	syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	vladimir.oltean@nxp.com,
	dutyrok@altlinux.org,
	Alexander Ofitserov <oficerovas@altlinux.org>
Subject: Re: [Bridge] [PATCH] net: bridge: Fix refcnt issues in dev_ioctl
Date: Mon, 12 Feb 2024 18:28:28 +0300
Message-ID: <20240212152828.4049756-2-oficerovas@altlinux.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20230823093846.7wzrhnqdk2wyqud2@Astras-Ubuntu>
References: <20230823093846.7wzrhnqdk2wyqud2@Astras-Ubuntu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Aug 23, 2023 at 00:38:46PM +0300, Ziqi Zhao wrote:
> On Tue, Aug 22, 2023 at 01:40:45PM +0300, Nikolay Aleksandrov wrote:
> > Thank you for testing, but we really need to understand what is going on
> > and why the device isn't getting deleted for so long. Currently I don't
> > have the time to debug it properly (I'll be able to next week at the
> > earliest). We can't apply the patch based only on tests without
> > understanding the underlying issue. I'd look into what
> > the reproducer is doing exactly and also check the system state while the
> > deadlock has happened. Also you can list the currently held locks (if
> > CONFIG_LOCKDEP is enabled) via magic sysrq + d for example. See which
> > process is holding them, what are their priorities and so on.
> > Try to build some theory of how a deadlock might happen and then go
> > about proving it. Does the 8021q module have the same problem? It uses
> > similar code to set its hook.
>
> Hi Nik,
>
> Thank you so much for the instructions! I was able to obtain a decoded
> stacktrace showing the reproducer behavior in my QEMU VM running kernel
> 6.5-rc4, in case that would give us more context for pinpointing the
> problem. Here's a link to the output:
>
> https://pastecat.io/?p=IlKZlflN9j2Z2mspjKe7
>
> Basically, after running the reproducer (line 1854) for about 180
> seconnds or so, the unregister_netdevice warning was shown (line 1856),
> and then after another 50 seconds, the kernel detected that some tasks
> have been stalled for more than 143 seconds (line 1866), so it panicked
> on the blocked tasks (line 2116). Before the panic, we did get to see
> all the locks held in the system (line 2068), and it did show that many
> processes created by the reproducer were contending the br_ioctl_mutex.
> I'm now starting to wonder whether this is really a deadlock, or simply
> some tasks not being able to grab the lock because so many processes
> are trying to acquire it.
>
> Let me know what you think about the situation shown in the above log,
> and let's keep in touch for any future debugging. Thank you again for
> guiding me through the problem!
>
> Best regards,
> Ziqi

Hello,

I've also encountered this bug while fuzzing. Is there any going work on this
bug?


-- 
2.42.1


