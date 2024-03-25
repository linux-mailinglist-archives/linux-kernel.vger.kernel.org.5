Return-Path: <linux-kernel+bounces-118108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1818888B40F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4917B1C3FEFF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AEB86270;
	Mon, 25 Mar 2024 22:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCKe29nx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57B285280;
	Mon, 25 Mar 2024 22:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711405681; cv=none; b=uxmJC6KSMQpOaZuCHzU1RIjAIrnOM+uSiKKh5RGgw3dQNcREp3gUkdmG0n4njmS9/qwFiINZsP9RALcCW463/fQ9Xxo81hPoX4ReggPu3XEdwEfIE+sGtEyNe0RD2zOrGruckzgCVaYW+8KocEO+Kjz6+YEZWh6Iau5HEfV7A34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711405681; c=relaxed/simple;
	bh=JuRL/NLx4Ofr4TC9kRiPYG5Dd80BJiF+EAadQpS1jOk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OQQ9cEWW1h+szp95r02jKnnBuSeMaacqumDYr2lcjzhC2ai98sS/2dokQdWq2HGtXKEkADs1WXUbHyRKfL+momAG6dMZn0bLDww3QEcyOkHlZnEJO4lPJ6rijD6wCB75wZ6S9rKfxPmZb9R8Oj+rwBO5IL8nAw8AEr9m+vM12iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCKe29nx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385DBC433F1;
	Mon, 25 Mar 2024 22:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711405681;
	bh=JuRL/NLx4Ofr4TC9kRiPYG5Dd80BJiF+EAadQpS1jOk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=SCKe29nxAjJs0RDxWbnzWqj3UCmlCux+GnEczWX33pCCFb4hOnj2DqT1HPsYCi34I
	 OVMajZhVTHJIY3CALmXk7kPOmZq1YrrDU0mReoZ1xZE1P9YANcmszCRS3YThVlSiYf
	 08b8WSm1/B/U9uXv7erHoXZY2KAJY2TxlHz7xfTjR+QeWqTmIpWVR0I1A+k2GhHe64
	 3Zj3myRmtZe+1m2XER3/N9IzwV9RWToljACwdB6tHz2SGMIkMlJYfUMyIF62w6+eja
	 zAsBmwm6Al/YQI6VfLL+/ED50Mt8ZesZauy3u9B5VgxPbqbFw3asCGvmubz0EgD9Mf
	 CN9vD3ELz902Q==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, 
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com, 
 Simon Trimmer <simont@opensource.cirrus.com>
In-Reply-To: <20240325144450.293630-1-rf@opensource.cirrus.com>
References: <20240325144450.293630-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs-amp-lib: Check for no firmware controls when
 writing calibration
Message-Id: <171140567996.375229.415823964227571386.b4-ty@kernel.org>
Date: Mon, 25 Mar 2024 22:27:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Mon, 25 Mar 2024 14:44:50 +0000, Richard Fitzgerald wrote:
> When a wmfw file has not been loaded the firmware control descriptions
> necessary to write a stored calibration are not present. In this case
> print a more descriptive error message.
> 
> The message is logged at info level because it is not fatal, and does
> not necessarily imply that anything is broken.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs-amp-lib: Check for no firmware controls when writing calibration
      commit: e2d7ad717a6b0880843dbc60855a5b97ad0395f8

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


