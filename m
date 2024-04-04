Return-Path: <linux-kernel+bounces-131861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBD4898CD0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80A221C27113
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB5212BF06;
	Thu,  4 Apr 2024 16:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0j3p/rQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A371D559;
	Thu,  4 Apr 2024 16:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712249927; cv=none; b=c2jBTOq9L/uP/4QbhpSfRHgyH8iWL6447CNdgrGjTEBn23KEDPoAJyZw1vhvFrukRxhFZQGvsfMfSU5gvduaVtSLCp486ST5dVhc0vCumN3vzSc9tNl+E5fDD18cy33B12dCQ3+/Aaq9XZIMrjC1MdV8XhyqnfYLQXGWnIp5+js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712249927; c=relaxed/simple;
	bh=vYAdJExLD0Pba8+2LILXT/H49qXYZgBBf2Q0yYemBxA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MgavfmxPvXZckqJPvaz1wrw3HOH4t6opBjKjHfimRQJtaB2AiGD47UNSG0MtwtA4+hHWVP3FNfxXwNAsyjP4XZa6QibxwFdVcypnZPGFcfdm79LnJegcZYFyAH6cEbTPZop/60cJvQrPER5avTOoef+NPS88lQZ4TU3ZZONbhD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0j3p/rQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA94C433C7;
	Thu,  4 Apr 2024 16:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712249926;
	bh=vYAdJExLD0Pba8+2LILXT/H49qXYZgBBf2Q0yYemBxA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=d0j3p/rQQpf1uHNZz+bARmhaiknJY5BzUDYV4N4dsxFM4zVkcJArJh1WkwhaYLxqM
	 AfEFrRroN5hIbNAioWiZntCjm+6E5J8GIcRdwmm39bJUirtP6sfCTs6dDM2pSW6paH
	 tlvIrgSg46q5k0OzND6gEuFBmlkVts0ml/JBSsjjKAt4qM7PzadZPdJgE/8yLOB5LV
	 bJm7LhTy9mwO81Sy+JamcYyBcnbYduDE8El+PIq9hWLas/lxvOd1c/w7t2v20SP0Wn
	 B/wwglprYs63C03p9F+FfZAnrdn0zVWfHptZ4S66KveekU/KiePcD4jfSFkvipA4Nx
	 wljbKF520fP1A==
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <9d2477cf-25aa-4d12-818f-fdafc9aaa28a@moroto.mountain>
References: <9d2477cf-25aa-4d12-818f-fdafc9aaa28a@moroto.mountain>
Subject: Re: [PATCH] ASoC: SOF: Disable pointless writes to debugfs file
Message-Id: <171224992349.92541.12088841230483454478.b4-ty@kernel.org>
Date: Thu, 04 Apr 2024 17:58:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Thu, 04 Apr 2024 10:38:45 +0300, Dan Carpenter wrote:
> The permissions on this debugfs file are 0444 so it can't be written to.
> And writing to the file hasn't done anything since commit 6e9548cdb30e
> ("ASoC: SOF: Convert the generic IPC flood test into SOF client").
> Delete the write function.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: Disable pointless writes to debugfs file
      commit: 84ae7d9cfa5f6ec284efccedcb7baf7c075774d4

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


