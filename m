Return-Path: <linux-kernel+bounces-136916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D11EF89D9D0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D10C281E9E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3B412FB15;
	Tue,  9 Apr 2024 13:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bx+QZYpi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068C512E1F2;
	Tue,  9 Apr 2024 13:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712668082; cv=none; b=IGFDRJNnppaVvySswlnLJlRNGkK28bqHkelQ5+ONByavDVvBm50fnr5iZNk6vGuUiNSt8+doaKktCznlvDQez6M8PCeeTECO0gzkmMbnDMGsBq7RVNJZ1zX4zczgsyNVrkHjWyLZVd52BDyKBQntvU/5IO2F0wCfWUHBlXkUsPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712668082; c=relaxed/simple;
	bh=6UT6JdRmlSUWwWxh7sOA/sm5C8Rr31qoQNdkYTzvIrw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=afji/0ICss3PyrTI6PQ+X1ad0zY1+FPoc2E4x5DV7qhN021ZM+IQNr8aJsZlWaYa/DaD5eejPmp5JdSRkE2MGDecyOLpLbJ63/+LmWrZMQtppVUCEtXFb78sgFOSegjtmzqTYUfNsMo9ktFFSn8eHD0CvL972jNQMPTjva249qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bx+QZYpi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD05BC433F1;
	Tue,  9 Apr 2024 13:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712668081;
	bh=6UT6JdRmlSUWwWxh7sOA/sm5C8Rr31qoQNdkYTzvIrw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Bx+QZYpiRMOXU7l9N991efCKp5nkeBbNXd8ijQiOJqbln0PQxAyKWoTs9PoERy8GS
	 foyS9A9C2vtkiLcBycvGw672yJQ7VyRpPUtiGRIudYBo6CSmV8UqjpcbYCYdS8SdAi
	 V3YWhkVe05zno8cUijUkt3Yye15l2+eG6RMmHmfGTnwLs9rTDzYJEii4YtJOx2o+QA
	 Dv0N2hum8lfAXaaXU2HukBQltEE2zJGWoLn80+2Vip3VL0pALRJgWtKKyMpWIsC+I8
	 ZsoxOdQ0l70D0QXjQipI1N4mQo6amL75z8T7hGE1g2oSgiR7hlO01KcEyREkt9H4+F
	 rPGirVMDMturw==
From: Mark Brown <broonie@kernel.org>
To: Brent Lu <brent.lu@intel.com>, Dan Carpenter <dan.carpenter@linaro.org>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Liam Girdwood <liam.r.girdwood@linux.intel.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Terry Cheong <htcheong@chromium.org>, Uday M Bhat <uday.m.bhat@intel.com>, 
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 Mac Chiang <mac.chiang@intel.com>, apoorv <apoorv@intel.com>, 
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <6e16433f-1897-46a2-b3ee-e177e7d846b8@moroto.mountain>
References: <6e16433f-1897-46a2-b3ee-e177e7d846b8@moroto.mountain>
Subject: Re: [PATCH] ASoC: Intel: sof_rt5682: Fix uninitialized variable in
 probe
Message-Id: <171266807748.28088.3831139815604734848.b4-ty@kernel.org>
Date: Tue, 09 Apr 2024 14:07:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Mon, 08 Apr 2024 10:35:59 +0300, Dan Carpenter wrote:
> Initialize "is_legacy_cpu" to false to prevent an uninitialized variable
> bug.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: sof_rt5682: Fix uninitialized variable in probe
      commit: 9cb83ed19b35e6c596b4e6644708ac4e011f32ab

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


