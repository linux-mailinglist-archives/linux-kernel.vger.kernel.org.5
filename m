Return-Path: <linux-kernel+bounces-119009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0977988C295
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23FC71C6074C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1ADC6EB56;
	Tue, 26 Mar 2024 12:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sEPxM8BV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD55495FD;
	Tue, 26 Mar 2024 12:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711457475; cv=none; b=OPWcEUjWJ21p7R0agJmKtEe6/mQ/drUEZpBTBL8R72N8WLx4GeNr8f98Viy0QMsxEoeyDpCUpZzmLQqcZKxhcRmeB86nkI08YkgWA5Uev/cAUONIhpHF2tdOF0qIEBroA2lwEVtAOupvsWo8QaYOX6hRrr5OqgPT527qPR7D+xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711457475; c=relaxed/simple;
	bh=Hnsmw4cSlCWFWusJgFgXB9IFNQHqwcx52ZbhZkS1BMc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fVUqqyYARKqXpg4wqiUyA+ggU1mNaPsu2vr4Qgx5pO5E0Wam8hYNLskGg9rBCPIhF+1XH7p4ZRlIbPyToohz+l2WlhKdbJ/QMOGv4d69t0ZtvasgAnE4Yyy8SAY3D91/Hl3XzuWXLImUB0GewfZNsqv/olqeHqqacJfvmFgmFOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sEPxM8BV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C07FC43394;
	Tue, 26 Mar 2024 12:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711457474;
	bh=Hnsmw4cSlCWFWusJgFgXB9IFNQHqwcx52ZbhZkS1BMc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sEPxM8BVbQ07kjm4amF/00CiTgh1i2KSrruwCtk1gy5l57g81+eu/IVT1/qPM6PCt
	 6C7ar8Me3JW30/ZCq8HNP5Gxzu0Q5lFimE3pAh1S6KHchXGQygXkKp4MHyBcfCsHDB
	 aamnyV2tG/zleVfYnqAf6knJ9SMbX2+xb8LXr1U89fFxtf+dl57q6BG3o8zy1/m2KL
	 u43T+2gL2C5qq1jv4rxNcm9D5aGE88x4XKp6iPP0GfFEQsJz0ForRWeP+xAiqam/Sh
	 HMPA3Qal319cQxp+Hj/EWNEw+E+bJlDQIeOWAQr5oNUI5c4dCFpxCVWucPQ+4ouIEx
	 PETXvB7mo3aXQ==
From: Mark Brown <broonie@kernel.org>
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, 
 linux-sound@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20240325191341.3977321-1-andriy.shevchenko@linux.intel.com>
References: <20240325191341.3977321-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] ASoC: fsl: imx-es8328: Remove leftover gpio
 initialisation
Message-Id: <171145746963.70451.9741731830919913816.b4-ty@kernel.org>
Date: Tue, 26 Mar 2024 12:51:09 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Mon, 25 Mar 2024 21:13:41 +0200, Andy Shevchenko wrote:
> The gpio field is not used anymore, remove the leftover.
> This also fixes the compilation error after the ...
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl: imx-es8328: Remove leftover gpio initialisation
      commit: 6a92834166b16babd70e99c3e0ce9262893ad6ae

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


