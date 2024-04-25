Return-Path: <linux-kernel+bounces-158902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 841D88B2680
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 396521F23EFF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF7E14D44E;
	Thu, 25 Apr 2024 16:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIk/Fgpu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A69B1E864;
	Thu, 25 Apr 2024 16:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714062633; cv=none; b=gguokfIKnBh29oq+NJ06b2Ms9PijbdOnYXLp3MikgOZI1LkXFN/Dm0l6Z49+4F2qE+cw8lft+uw/Ix5Ll/jSf8N5E+31qvB3kg+Na3KJn6T3HoY+6UUVbYGQrDl2lMnga767hEtAQ4KkViLPMiIHNqcJLFDSE4qZsbtEMUcYHAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714062633; c=relaxed/simple;
	bh=ANvZ/o/drE2FJG659vjthrk/HOXySmSBQTc5JTC0hrs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kMdYdhJp+nq+NFiwVrYFKmu5VviqPiIZqO3ORAunkHIMLzyDA1BAIddQj4FdYbFpytsoBDO1o4Wjb2cKUsclPQ1D9bv8p+CgGPvWj+LZy2da/+9QLPZEOSAoBMlmam2yUEq4+04kW/kGqMh0e09LyzXVQ4V7pnvkew07PnABjnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIk/Fgpu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20BFBC4AF07;
	Thu, 25 Apr 2024 16:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714062633;
	bh=ANvZ/o/drE2FJG659vjthrk/HOXySmSBQTc5JTC0hrs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KIk/FgpuGT0zgB1iMWU+1LOhuQvumdhmoP1YpV0A4T1yqFPTLWey60DlH34yUmoEy
	 g/ru7RLFpwN7S2umImvqLrBHO4cjGCVC9JF/UjUXM/q4pPdYO8P5I2taqJc5diUzKK
	 hvfzfNa7ejihxfJyaUF53+pZYlAygOaL0Hvim3za7FZEELTwncetIxMHDdAg1vTeIZ
	 jbnxkabBlNZnN6mt5M0EuClyzT8fRPWiyr6tOp3Cz4YBJRuMaiCI4OxiZhKDx1IaDa
	 vnY/Xh030R8KpSXEX6MZKKKc4ImdhLVwIUgqLH0rs5j1+uempXfkpxBXHE1r5tKSfx
	 SC8fYEB+SP4PA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0BA43C595CE;
	Thu, 25 Apr 2024 16:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: Fix use-after-free bugs caused by sco_sock_timeout
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171406263304.12899.3794414646890970390.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 16:30:33 +0000
References: <20240425142345.47229-1-duoming@zju.edu.cn>
In-Reply-To: <20240425142345.47229-1-duoming@zju.edu.cn>
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 luiz.dentz@gmail.com, johan.hedberg@gmail.com, marcel@holtmann.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 25 Apr 2024 22:23:45 +0800 you wrote:
> When the sco connection is established and then, the sco socket
> is releasing, timeout_work will be scheduled to judge whether
> the sco disconnection is timeout. The sock will be deallocated
> later, but it is dereferenced again in sco_sock_timeout. As a
> result, the use-after-free bugs will happen. The root cause is
> shown below:
> 
> [...]

Here is the summary with links:
  - Bluetooth: Fix use-after-free bugs caused by sco_sock_timeout
    https://git.kernel.org/bluetooth/bluetooth-next/c/1b69bacb11e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



