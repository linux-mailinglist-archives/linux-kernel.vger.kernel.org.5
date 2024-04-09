Return-Path: <linux-kernel+bounces-137695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5239289E61A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDFBCB21EC3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628EA158DCA;
	Tue,  9 Apr 2024 23:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inKl7M5c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A451B158A28;
	Tue,  9 Apr 2024 23:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712705646; cv=none; b=pKfzS/v62yohvzkOXLYpeOwlW6fgvuC6iUPtJAR6nb1vaincCENvJN49a+20kRKUsefs2maYgMLx7dZoiQYxsHQr3UACayLn1rU24gs3NGuR/SPxH5rIfdt6rdXjXAI7oym3UuVFCkaipJWbf5WkepWiNoBRMlpYO844yXx4vM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712705646; c=relaxed/simple;
	bh=EHUY8OohkhvETd/zbs6k/hjYDaaHAvq8ARw7exxy4kM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=N9mpmdLnVfrl0c3WgEtCAgYFBr1J7IXp+DmoLMSxMCRq2+4sdoMNmol9opnqPKG8XEKbeRCe0mfZtJKKdRxRRNE2h2n8XLHmA5ILdn41XB9YYoFoLqetLGLEYaWwClZ24N2bRS8sBHYd0UjJ0QRi7s6JhgeiKaLaBAHdFqD0ogY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=inKl7M5c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F9BC433C7;
	Tue,  9 Apr 2024 23:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712705646;
	bh=EHUY8OohkhvETd/zbs6k/hjYDaaHAvq8ARw7exxy4kM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=inKl7M5cC/hJXwHuKxuCIq+dO0q0yHjMdFH0yGnAN/XWT8eXHQNt6vbxbzfStqxMV
	 0R01qb7pcoiVLwAoroGjjdK2yGi8JkQp0BpBI3ekqEZJ+Z6Nf6H44QxjU6HNF923bU
	 izYYmenSfqW6b4S07q8lAHmd6t3+pVvI6TtNTXSR3qV9c0iuMupg0QgRCvsed4fvI4
	 lNQfT5kkaok5oCFuVv3k0YgOkmJP9g+a7fLEzQlsZvlIeeZ6bylQD17sVC2p36iqBa
	 JYmZ/vkRc4+808T0U4C+pFf+8t8njndsaxLK48CfNZQCM4yRgwO3VqIB6Q9aHvVMJH
	 UsdRF6NZVAdxA==
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.com, Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, 
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20240408101803.43183-1-rf@opensource.cirrus.com>
References: <20240408101803.43183-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH 0/4] ASoC: cs35l56: Fixes to handling of ASP1 config
 registers
Message-Id: <171270564469.199334.16192675337091991799.b4-ty@kernel.org>
Date: Wed, 10 Apr 2024 00:34:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Mon, 08 Apr 2024 11:17:59 +0100, Richard Fitzgerald wrote:
> This chain fixes some problems with some previous patches for handling
> the ASP1 config registers. The root of the problem is that the ownership
> of these registers can be either with the firmware or the driver, and that
> the chip has to be soft-reset after downloading the firmware.
> 
> This chain adds and uses a regmap_read_bypassed() function so that the
> driver can leave the regmap in cache-only until the chip has rebooted,
> but still poll a register to detect when the chip has rebooted.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] regmap: Add regmap_read_bypassed()
      commit: 70ee853eec5693fefd8348a2b049d9cb83362e58
[2/4] ALSA: hda: cs35l56: Exit cache-only after cs35l56_wait_for_firmware_boot()
      commit: 73580ec607dfe125b140ed30c7c0a074db78c558
[3/4] ASoC: cs35l56: Fix unintended bus access while resetting amp
      commit: d4884fd48a44f3d7f0d4d7399b663b69c000233d
[4/4] ASoC: cs35l56: Prevent overwriting firmware ASP config
      commit: dfd2ffb373999630a14d7ff614440f1c2fcc704c

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


