Return-Path: <linux-kernel+bounces-88091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A62486DD41
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F2F41F26B04
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A20069E13;
	Fri,  1 Mar 2024 08:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orvWVvdk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DC169E0C;
	Fri,  1 Mar 2024 08:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709282428; cv=none; b=GyKw4PxgPRfLCf5T1eRl+nlwqj3SVXQydI5ZvP99hq03Crgixu6EKMH1vzm42TJNQ0zUxbqPlp+dKbZ4Mhz+TukuJJFEJTYEvjiZcTc8EDWeFQEVmbKFWyATCrAmIbnD7IQ2Gc3o+S6fedFVLWP9aoZNdWH5vuNyAXR3Z0dDuI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709282428; c=relaxed/simple;
	bh=jYs85NewVNSV/4PMIj8sEcbW+DtWsCJEA1C48BXtPIo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sME+MySfgsoIM6Q2sp7Ix2AGc7bu5HwmASDeF6dHprDZhHJspRVM6PQROEQvNy9+BM4MNfEYaSW0cdF1+8IEyqzMsiBtJ7VjTOHQ5PS9w//rMD8eKXQGgYjqJSZcaGXhP1VDT3sSRul7cVgBZ+Gz04Y/jsIALdrMNFuhsUuLMzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orvWVvdk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24EC6C43399;
	Fri,  1 Mar 2024 08:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709282428;
	bh=jYs85NewVNSV/4PMIj8sEcbW+DtWsCJEA1C48BXtPIo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=orvWVvdk+ha8aSBv0ROy2++85S3ud7baA7bNe5uVmdlXtHQZl9RT9qQRDczEGFVLl
	 6ht1hHS93YuWkpigCCZpRUHtW/wxJ9o1Esu2ngb4ZeIx2osTyAb08tDs2TX8P08rKk
	 sG+PXt4gsnvPZyzwyNertcltB6/M66cJP1iS1z0vgvZif7A+8OFe3RJKCxu2PeF2WG
	 iObCDTGLmORiv/6O81GRV7FaBqF6NbEdlgiO/739Pb2iYQCI6spbRaG6sY2qITnj3G
	 NjuZkKN/s9lw7aN3f+VXfAtRxqiUPFOPXVx/GoeNrE5SZTAztIOQJQuJLjW2/NPyy8
	 Xo5D/P2/0gR4A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0A3B9D990AE;
	Fri,  1 Mar 2024 08:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1 1/1] net: lan78xx: fix runtime PM count underflow on
 link stop
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170928242803.14717.6883191622320150450.git-patchwork-notify@kernel.org>
Date: Fri, 01 Mar 2024 08:40:28 +0000
References: <20240228124517.1702476-1-o.rempel@pengutronix.de>
In-Reply-To: <20240228124517.1702476-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, woojung.huh@microchip.com, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 28 Feb 2024 13:45:17 +0100 you wrote:
> Current driver has some asymmetry in the runtime PM calls. On lan78xx_open()
> it will call usb_autopm_get() and unconditionally usb_autopm_put(). And
> on lan78xx_stop() it will call only usb_autopm_put(). So far, it was
> working only because this driver do not activate autosuspend by default,
> so it was visible only by warning "Runtime PM usage count underflow!".
> 
> Since, with current driver, we can't use runtime PM with active link,
> execute lan78xx_open()->usb_autopm_put() only in error case. Otherwise,
> keep ref counting high as long as interface is open.
> 
> [...]

Here is the summary with links:
  - [net,v1,1/1] net: lan78xx: fix runtime PM count underflow on link stop
    https://git.kernel.org/netdev/net/c/1eecc7ab82c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



