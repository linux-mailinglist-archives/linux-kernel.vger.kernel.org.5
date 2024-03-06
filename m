Return-Path: <linux-kernel+bounces-93891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC76287366A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77BC3B2250C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292B38063E;
	Wed,  6 Mar 2024 12:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwHuWyCM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679655D72F;
	Wed,  6 Mar 2024 12:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709728231; cv=none; b=BeyMZl1ksM3WkshEqXK8uT+wi5fxFFfFYLpF+yHLjlCgWTQ7YAjahydamgYVvJdvSxnAzANwbwm9UJouX2j7KA1CprYeccNXyD/etEqf07Y92BK+xglVJqUB2EYhGpcaPq31/wKcLdy7i1pITjy19SyH+cAvYTD/DNFJ3aj8NAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709728231; c=relaxed/simple;
	bh=Ix+FfAXcBUKh13sk+NOTEZ7IBFQR2jDzOXOAnRx0yKw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OtCFU6Z5vqJs6DKiQp2kPB+Cbg+b63S3RTgeRB8WlLz8DbVl8a06z8zrreM3s5/qmOoeQ458zQhI19D/aONqGJxvZH5BX0IMhknmPg4Odcl8GTAAWyWgRxrePOKLhBf3v38SwiVdO8LDpTvJdL7nEbDF7K0vk1kkGDVU9P1EyIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwHuWyCM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB2CC43390;
	Wed,  6 Mar 2024 12:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709728230;
	bh=Ix+FfAXcBUKh13sk+NOTEZ7IBFQR2jDzOXOAnRx0yKw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OwHuWyCMS3P3JaqWLfifteuKfRKiu58aIRAVz3urWEfqyZp0xETWff1hTlUQ+P9QC
	 L86aTv8MtN0CwTPXKER0F7HUZ+FfgHov8V4JT+iTUhPXKQ0GtEzRM95XzV6oUF0o0I
	 a2Erome4ZxFFYfgMTiweRa62mtFrGhMmKM5gKpXjoE3VhFLvLWhdRZeuNZIEZGJWef
	 WlYlWlgpbLW9zqWQjO87vKemv1dqoRI9ZzIXDmaBoTtepD9U8N53tbItgT7p2m0wpE
	 R78FywCN9oCyWl+MayYi+h1XUIBhAyBpc/uE4sy52SMz2+uDJdH72eDHfom425GUsj
	 l3rfN2kXSLz0Q==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Liam Girdwood <liam.r.girdwood@linux.intel.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20240305160723.1363534-1-andriy.shevchenko@linux.intel.com>
References: <20240305160723.1363534-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] ASoC: Intel: atom: sst_ipc: Remove unused
 intel-mid.h
Message-Id: <170972822557.17598.8700374385096227275.b4-ty@kernel.org>
Date: Wed, 06 Mar 2024 12:30:25 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Tue, 05 Mar 2024 18:07:22 +0200, Andy Shevchenko wrote:
> intel-mid.h is providing some core parts of the South Complex PM,
> which are usually are not used by individual drivers. In particular,
> this driver doesn't use it, so simply remove the unused header.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: atom: sst_ipc: Remove unused intel-mid.h
      commit: 8fedf4f1d62ed058958e7a46aa62c0cb656dc040

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


