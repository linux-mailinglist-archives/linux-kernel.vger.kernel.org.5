Return-Path: <linux-kernel+bounces-77234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9DC860263
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 876072921B2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C189548FF;
	Thu, 22 Feb 2024 19:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOag+8Gz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A21548E5;
	Thu, 22 Feb 2024 19:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708629211; cv=none; b=hJh8IgE5jMvCaeI9loBcIQngvNLcZGhP4V30F9Y+Kw0OM+q2Ziguo1nHesHclt2c98s7RB5mO+AVZrpz6ZGfNzdX6EUvm85Y4Q8jpCvYXwm26m3UgAfIlJFhRYxly2QwoWbk4P6BctGrX0af5lbRsQuYhcANI/rBxrIDpbY7n/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708629211; c=relaxed/simple;
	bh=rO1Xx2bE0zpvlD7Ucov+IqFVFfoifsTDYhtrmsU8+Lg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LwxzxeyOUtl1+rctCvnOr6aqckyIRBo0o2X8HzRAW3ixAXQisxm7VHIND14gu9aTabiarUstfIZdYd1Qk1kH+teorHx4s1XCeB7f7HSra5OFZpYmsXaHfxhfZEItT3mT5vnkNBS1UWEZx0Mc0khDR6dCc9lwMFMnXbGaV+ywCAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOag+8Gz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80617C433C7;
	Thu, 22 Feb 2024 19:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708629211;
	bh=rO1Xx2bE0zpvlD7Ucov+IqFVFfoifsTDYhtrmsU8+Lg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jOag+8Gz6GHXA5L8dOaUyfXFXI6ZKpuzrPB1fQpbH3mFcYpLNw2jpZvve3WbNywhb
	 ABcPqx7c6QQwO8A5S1P1YvC02SP5BdvvP+B9S/+wlo+G5f78cNQIaDUAnuoWO5vEV5
	 jDuPGF83TRFCNR61uYMJ/VqeyLTb1YWtu5feB3kJLmg1C2lQm9pmU5gP5UEidPdl2V
	 QFNAe470H0mMRI89hQdl8EBQFGzF1MhbSjR4i1SA0lUYjoZkj3R4Couej1xdjRLBZ2
	 dQX87i7Dxiat+/7yp36VPzr55/wItPwzJ7YxhVAe30Ucj1nCti2OJ4kHgjYnv2dCtZ
	 RJp4yYoZDziHQ==
From: Mark Brown <broonie@kernel.org>
To: Apurva Nandan <a-nandan@ti.com>, Dhruva Gole <d-gole@ti.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>
In-Reply-To: <20240222-cdns-qspi-pm-fix-v4-0-6b6af8bcbf59@bootlin.com>
References: <20240222-cdns-qspi-pm-fix-v4-0-6b6af8bcbf59@bootlin.com>
Subject: Re: [PATCH v4 0/4] spi: cadence-qspi: Fix runtime PM and
 system-wide suspend
Message-Id: <170862920925.104158.14642580909914879148.b4-ty@kernel.org>
Date: Thu, 22 Feb 2024 19:13:29 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-a684c

On Thu, 22 Feb 2024 11:12:28 +0100, Théo Lebrun wrote:
> This fixes runtime PM and system-wide suspend for the cadence-qspi
> driver. Seeing how runtime PM and autosuspend are enabled by default, I
> believe this affects all users of the driver.
> 
> This series has been tested on both Mobileye EyeQ5 hardware and the TI
> J7200 EVM board, under s2idle.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/4] spi: cadence-qspi: fix pointer reference in runtime PM hooks
      commit: 32ce3bb57b6b402de2aec1012511e7ac4e7449dc
[2/4] spi: cadence-qspi: remove system-wide suspend helper calls from runtime PM hooks
      commit: 959043afe53ae80633e810416cee6076da6e91c6
[3/4] spi: cadence-qspi: put runtime in runtime PM hooks names
      commit: 4efa1250b59ebf47ce64a7b6b7c3e2e0a2a9d35a
[4/4] spi: cadence-qspi: add system-wide suspend and resume callbacks
      commit: 078d62de433b4f4556bb676e5dd670f0d4103376

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


