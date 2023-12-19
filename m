Return-Path: <linux-kernel+bounces-5591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1481818CBF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4221BB240BF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D27234554;
	Tue, 19 Dec 2023 16:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgoRzOOo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FDC3527C;
	Tue, 19 Dec 2023 16:45:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB5EFC433C7;
	Tue, 19 Dec 2023 16:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703004300;
	bh=Ghx71bROc6fu886X5uqaeBYzUHSm6JygoJVtGTyZCJc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bgoRzOOoWfw1cESntV9UlskeW7XD1Czov9dsg9QwhLH0tNGH8dJ9gIJd3v0rEiy+x
	 hR7KwecPe0DL41PHcZLyWp4aKOb2b7U+mir7SO3WFbWB98aotxiHbRF3AF7jp+vqkZ
	 v1J7b5wuID+2jL+eu6/SgfTIZQb77DkCQPnxAB2fPgX9UJlEey7+qhT/wQNoUGAkEt
	 8id/HUZe3FKPXvc+PvdAzYfC6RxLgrJSJDC+xXIR4QN1UnRautngwUy2g4v/Jw6yBK
	 dAy5vTD6mmJAkcC9R3NA7VS9W5xRry+jgxhgtPLbpICt29Me/ojNhmtnoWuDklmmZZ
	 ahp/UUp4c4bXg==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, 
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc: Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com, 
 Sunil-kumar.Dommati@amd.com, syed.sabakareem@amd.com, 
 cristian.ciocaltea@collabora.com, emil.velikov@collabora.com, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Iuliana Prodan <iuliana.prodan@nxp.com>, Paul Olaru <paul.olaru@nxp.com>, 
 V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>, 
 Mastan Katragadda <Mastan.Katragadda@amd.com>, 
 "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" <sound-open-firmware@alsa-project.org>, 
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, 
 open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20231219112416.3334928-1-venkataprasad.potturu@amd.com>
References: <20231219112416.3334928-1-venkataprasad.potturu@amd.com>
Subject: Re: [PATCH 1/5] ASoC: SOF: amd: Refactor
 spinlock_irq(&sdev->ipc_lock) sequence in irq_handler
Message-Id: <170300429567.102048.6886729222618655061.b4-ty@kernel.org>
Date: Tue, 19 Dec 2023 16:44:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Tue, 19 Dec 2023 16:54:09 +0530, Venkata Prasad Potturu wrote:
> Refactor spinlock_irq(&sdev->ipc_lock) sequence in irq_handler
> to avoid race conditions for acquiring hw_semaphore.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: SOF: amd: Refactor spinlock_irq(&sdev->ipc_lock) sequence in irq_handler
      commit: 802134c8c2c8889f7cc504ab1ba6ada9816ca969
[2/5] ASoC: SOF: Refactor sof_i2s_tokens reading to update acpbt dai
      commit: 3953de2dbdcd0592aa7f877b67135a51e18f006a
[3/5] ASoC: SOF: Add i2s bt dai configuration support for AMD platforms
      commit: de111c9b521ddea4c7609155a617b5a0e93ad833
[4/5] ASoC: SOF: Rename amd_bt sof_dai_type
      commit: ced7151b9b0c74af1bc05ac4ad93648900709bb0
[5/5] ASoC: SOF: amd: Add acp-psp mailbox interface for iram-dram fence register modification
      commit: 55d7bbe433467a64ac82c41b4efd425aa24acdce

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


