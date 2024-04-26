Return-Path: <linux-kernel+bounces-159445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A218B2EB5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 04:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07D9F1F22332
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 02:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B0263AE;
	Fri, 26 Apr 2024 02:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOPT3X7I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37D71C3E;
	Fri, 26 Apr 2024 02:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714098628; cv=none; b=HH7+7RjzJpXKX9uqECgAHtH9M029jsqdn/FqFR43dUUrODShZ8ZrOtRsQJXNnLr2kJ1Q1dr8llhtfSYvrCGtA7WD24oFQIU/XiHyZdUYpFgxIFCWHcX6Zx7g7dShMAbw2Zi8G7JjNQjF6IHhvIiSI5aMVRXvaIsXTQKoNTqcWt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714098628; c=relaxed/simple;
	bh=eurkqHk3uRy+1rn1ochibBTH2vrQVR6SvX9c5yj2Uag=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FS2Xh4Wc3XuqXO9IUFE9ZOYjR6BZ1FADqx9dgTlMtOucoRra9AM9l8mF5bWFiI0e346TspkQYeYQZlYwd1248FU5ORmaEoLX/H/Gud8Tzdhe/i2l4BWVL4wWVqMNyS0BSmExdvnaW6F/Oi6lEEq5mjN1ABjHsbpfHOREjgcuVYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOPT3X7I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F0BBC2BBFC;
	Fri, 26 Apr 2024 02:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714098628;
	bh=eurkqHk3uRy+1rn1ochibBTH2vrQVR6SvX9c5yj2Uag=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NOPT3X7IeFl2EkRwRIVLn4bp/lBz/P9PVLpmU9i7nHEZYzqAUBm4JX8rsMrSnUrHN
	 biPRfnqFQwOqKrc2TyuER/CO+VOUls/m+Bfs6Tn8XAL3l4UkdOhHhk76HEj4cwp4hQ
	 NVdcdArE9v4DyIPjgZHDoIE3elvaxeY7BjGuHqNUi3HvZKjRjiffVLypz+eCRBMvtk
	 9ngzeTfWdgizj3jykjL6O7COU44bMoHxTyA009S8sPutklby/m3IAfmRrx71xeNJVJ
	 uWblH+kbfyJIZ3Z7B+4JMlVR8Xu42lFf2i0lGzxILzaWRd/57kt/uZGL9wqNi70AK5
	 i5D4EHTpsudSw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 17608C43140;
	Fri, 26 Apr 2024 02:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/6] Ensure the copied buf is NUL terminated
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171409862809.13456.12723948130853178022.git-patchwork-notify@kernel.org>
Date: Fri, 26 Apr 2024 02:30:28 +0000
References: <20240424-fix-oob-read-v2-0-f1f1b53a10f4@gmail.com>
In-Reply-To: <20240424-fix-oob-read-v2-0-f1f1b53a10f4@gmail.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 paul.m.stillwell.jr@intel.com, rmody@marvell.com, skalluru@marvell.com,
 GR-Linux-NIC-Dev@marvell.com, anil.gurumurthy@qlogic.com,
 sudarsana.kalluru@qlogic.com, James.Bottomley@HansenPartnership.com,
 martin.petersen@oracle.com, fabf@skynet.be, skashyap@marvell.com,
 GR-QLogic-Storage-Upstream@marvell.com, nilesh.javali@cavium.com,
 arun.easi@cavium.com, manish.rangankar@cavium.com, vneethv@linux.ibm.com,
 oberpar@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 saurav.kashyap@cavium.com, linux-s390@vger.kernel.org, axboe@kernel.dk,
 przemyslaw.kitszel@intel.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Apr 2024 21:44:17 +0700 you wrote:
> Hi everyone,
> 
> I found that some drivers contains an out-of-bound read pattern like this
> 
> 	kern_buf = memdup_user(user_buf, count);
> 	...
> 	sscanf(kern_buf, ...);
> 
> [...]

Here is the summary with links:
  - [v2,1/6] ice: ensure the copied buf is NUL terminated
    https://git.kernel.org/netdev/net/c/666854ea9cad
  - [v2,2/6] bna: ensure the copied buf is NUL terminated
    https://git.kernel.org/netdev/net/c/8c34096c7fdf
  - [v2,3/6] bfa: ensure the copied buf is NUL terminated
    (no matching commit)
  - [v2,4/6] qedf: ensure the copied buf is NUL terminated
    (no matching commit)
  - [v2,5/6] cio: ensure the copied buf is NUL terminated
    (no matching commit)
  - [v2,6/6] octeontx2-af: avoid off-by-one read from userspace
    https://git.kernel.org/netdev/net/c/f299ee709fb4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



