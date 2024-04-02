Return-Path: <linux-kernel+bounces-128830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA611896023
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FA871F21C25
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5313547A53;
	Tue,  2 Apr 2024 23:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLIyZLxX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B111E531;
	Tue,  2 Apr 2024 23:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712100571; cv=none; b=OmbiBuxS5ErpTzHC2w9smv5JocB6O2JiS76h6+IUboGknwF/tlDcnJS3hYXqIdW04hi8CZ0B82NZp2jbUekaLNJLHuBSNN93yNTSTDQU34ChzzozaAxIVYrO+pcP4HglpKueMOXdHahwSlkYtBPxrCbzYfMXErYqCaO+eGLXqPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712100571; c=relaxed/simple;
	bh=oKQ0VJW7bHDzLwWr3TpWv+xHaaTKQu+N/4JyHM68B1I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uuCtRlY2fWdr4KaqCLAALvwVHqkxFLeKu3ShRPsoxxsNY46P4G2+dMa7DWbYi9K/p7shhgK4EGLHHCbtgFyUxnOk1inwrOuoxb+ClOPltmH0sjoLjvBn4UxIx67bvWLd7bBHbmyY/9i9Sfh9Z7faeH2ta04S6bxmrLj4xcSTuL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qLIyZLxX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4CE8C433F1;
	Tue,  2 Apr 2024 23:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712100570;
	bh=oKQ0VJW7bHDzLwWr3TpWv+xHaaTKQu+N/4JyHM68B1I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qLIyZLxXLNgeDMDYzwXORviptrgRd1XrD0Ztt0yrpeG9RMOG0BJcK+JDVMxSRPbKS
	 BTrFfmCBbwDsKNnVx4dTugJY79oySnTCD/A1PPZ/2tECgObRSd5Z86rFfRSUOGEHXU
	 JB9w+8yVJhR/sit5Z8w+pKGyMF1asLdGnl7RWZVZUPOQju1CS56VESVB+a4OlFC0tP
	 A85r0egfur7VqJGPSo4yhFktoE5l0N53v035eLS/z0cexa0SvSJp08IacvkWF0n4N1
	 rZZa2DpVe7gHJUWMEjOou+mp/9/FtJMHn8NrHYxB2FhX8q7tZJwyQG1mYhA+jR10n4
	 pHSkjh2gyjG3Q==
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.com, Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, 
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20240401100210.61277-1-rf@opensource.cirrus.com>
References: <20240401100210.61277-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH v2 0/3] ASoC: Use snd_ctl_find_id_mixer() instead of
 open-coding
Message-Id: <171210056940.279166.10362892119296653551.b4-ty@kernel.org>
Date: Wed, 03 Apr 2024 00:29:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Mon, 01 Apr 2024 10:02:07 +0000, Richard Fitzgerald wrote:
> The first two patches change snd_soc_card_get_kcontrol() to use the
> core snd_ctl_find_id_mixer() functionality instead of open-coding its
> own list walk.
> 
> The last patch adds a KUnit test for this, which was tested on the
> original and modified code.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ALSA: control: Introduce snd_ctl_find_id_mixer_locked()
      commit: 08ea486a61451189b190c7b89e406b889cf693fa
[2/3] ASoC: soc-card: Use snd_ctl_find_id_mixer() instead of open-coding
      commit: 897cc72b08374c1224a9ded03c82dfc8e41f80c2
[3/3] ASoC: soc-card: Add KUnit test case for snd_soc_card_get_kcontrol
      commit: ef7784e41db73f3d31ce545227ebba4483479a26

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


