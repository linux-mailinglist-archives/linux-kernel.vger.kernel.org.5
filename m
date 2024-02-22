Return-Path: <linux-kernel+bounces-77233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1AB860261
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B2BB1C215CA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4601414B838;
	Thu, 22 Feb 2024 19:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9SxmA64"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F7014B806;
	Thu, 22 Feb 2024 19:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708629209; cv=none; b=ANda7uU38XCmetHtUZf5+Z4x1yjsPmWunamfIHCOPPnmL3CPMDzvh0/Xi/ZyrWNWAIuVbB92NrV59kUqnrZwFlDbMLfgtax4uFg/wnLfLneI1ISBHVpv3NMVR13Vt0fFZrXQ0+QftSJRsRukI1eVil7pRwL2AXMFd607fv0k9+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708629209; c=relaxed/simple;
	bh=kaIGZ3DPJZsxCm36cEAfgwgEW5yONPtxQCzpckYrrYw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nuUoTb/IHQ2tLFpbOKpO1fYzkkGYQEg6N3RtSCROBsO3oUpWX8Sa9RpqVOOvcD7RbRRbvamJ+Rgt7L6NlX2HuvoRMm4alq8UslX9ZeABuIQhFSmuHT1i+o144pTMZtXiP7VqAPJTt/R9tG50Fd9j99l4xnNGAFCygI8a6fBTces=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9SxmA64; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CACBC433F1;
	Thu, 22 Feb 2024 19:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708629209;
	bh=kaIGZ3DPJZsxCm36cEAfgwgEW5yONPtxQCzpckYrrYw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=l9SxmA64ch506U420lDOiWT3NWVo03obfhb3jcl7Dw4Ls4EfLt/g3yoo0O99EujeJ
	 JfQbrvvKANNjchy03zj/yxMzSJNE80wTZmouU1GEyg0aFSPFbRyonDZ8nsbPywtZEv
	 qVT3CBSnuOFC2SeNRwOK3FdcsSPco4pFOYWiAUFxOtdssC1vF+/qxn7lN5Ws4H3yzV
	 0deNvus3AiihJdgDRBfdp19vnaMgX7uDYXh8azyfO4djOACARMg8oIDa378WlyuaRC
	 ry7nDJjM3tIJ9YLy2hFuUo9alShFGJNL3/QpqPOOvNhvApBZqej57BjKVA2K3FYrCt
	 kWhc6Da9RM7Uw==
From: Mark Brown <broonie@kernel.org>
To: Apurva Nandan <a-nandan@ti.com>, Dhruva Gole <d-gole@ti.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>
In-Reply-To: <20240209-cdns-qspi-pm-fix-v3-0-540ac222f26b@bootlin.com>
References: <20240209-cdns-qspi-pm-fix-v3-0-540ac222f26b@bootlin.com>
Subject: Re: [PATCH v3 0/4] spi: cadence-qspi: Fix runtime PM and
 system-wide suspend
Message-Id: <170862920709.104158.534609637151305429.b4-ty@kernel.org>
Date: Thu, 22 Feb 2024 19:13:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-a684c

On Fri, 09 Feb 2024 14:55:49 +0100, Théo Lebrun wrote:
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


