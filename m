Return-Path: <linux-kernel+bounces-131718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33712898B09
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDADF28C007
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D7612AACB;
	Thu,  4 Apr 2024 15:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZXS+h1j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAA176408;
	Thu,  4 Apr 2024 15:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712244262; cv=none; b=AtdfqWlNG+RsUfCxp0DU2DmiT/YBI+UxG39WgTTMMHQA92Dcu79/0LnsTmua59nGysdWYsSh2Tkv5JDfjlAwYV18IhhBK68jgecoxnEz/XDtGeVISCZNMa2W1mMeBvKT1aHDMvjSNt6Wd+dBoc+KoVNBM2YHLbNQOJHDUj4H/rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712244262; c=relaxed/simple;
	bh=/knebWZeaaEDHH+qAZ96R0RgaVmS7oZA7zCTSzDKjuY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=d3EINFr/nDCuy2MQNZTgr3dLAnmyKTODPMnPVRQYDbeoAWiwrwAiBcdofBXORWjjCALKQxZ5DplZclbo8fzNl3kAPG9v36AORRsSxBdBDyUT9I4vl+f2UbnQNzN6exLeoob9l5uos3Xa6wJ/DDINVXQndHc+EZSI0YhAxoN+iok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZXS+h1j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F17C433C7;
	Thu,  4 Apr 2024 15:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712244261;
	bh=/knebWZeaaEDHH+qAZ96R0RgaVmS7oZA7zCTSzDKjuY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mZXS+h1jP5e1ftHIhw6bJjSrAeelq+ogn5rVYsS0ZEzBL8YQk0sYPi7wUmXZz/U9A
	 JC49Q4Dnv0mHGisesAqspV6Oe/7jlbTa1VYbuSHc0QW+wUFaPdApNhtimMWjcrYfeO
	 Z8ltojDLVGnzlHj4Ns2tDmni1R0zLmmCPZw57ezQyetvfqrcDs/3Auu/jtDOdkcnnZ
	 2zESNKZQAg5lmR6nCXyvf7rYQPwi9EE23XUDYKS4TO4QaE1n6UsqOCYbcPexqDzjVn
	 D+GbXGna9NjF8skj+FagEt4saLBrX+8HN8K1khNMAVtZ3VgXmPkxjHZ669ETTdauKg
	 L6KktWSgGulig==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, Sunil-kumar.Dommati@amd.com, 
 Basavaraj.Hiregoudar@amd.com, venkataprasad.potturu@amd.com, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Emil Velikov <emil.velikov@collabora.com>, 
 Mastan Katragadda <Mastan.Katragadda@amd.com>, 
 Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>, 
 "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" <sound-open-firmware@alsa-project.org>, 
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, 
 open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20240404041717.430545-1-Vijendar.Mukunda@amd.com>
References: <20240404041717.430545-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH] ASoC: SOF: amd: fix for false dsp interrupts
Message-Id: <171224425713.53181.6209478455097069217.b4-ty@kernel.org>
Date: Thu, 04 Apr 2024 16:24:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Thu, 04 Apr 2024 09:47:13 +0530, Vijendar Mukunda wrote:
> Before ACP firmware loading, DSP interrupts are not expected.
> Sometimes after reboot, it's observed that before ACP firmware is loaded
> false DSP interrupt is reported.
> Registering the interrupt handler before acp initialization causing false
> interrupts sometimes on reboot as ACP reset is not applied.
> Correct the sequence by invoking acp initialization sequence prior to
> registering interrupt handler.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: amd: fix for false dsp interrupts
      commit: b9846a386734e73a1414950ebfd50f04919f5e24

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


