Return-Path: <linux-kernel+bounces-103366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3482087BE9E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61BA71C20BCD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA99E6FE09;
	Thu, 14 Mar 2024 14:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSSAhDw4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ECE58ACF;
	Thu, 14 Mar 2024 14:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710425645; cv=none; b=kMDIDJENdNfkszhK9VXnn4B74BRmMXCpGwL0VNVooey9vxqRfZp/7LWV9EeR6wFmFhJo7Kw6mML3l5eJne/yhPyunxvnkeOCUkwyQqm5sKsH9Kb2jsZR5Y4CZcxhaVS4zJ/XfFre41SKaAzt+lZ/ce883IKydHxjzz4i31+lGjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710425645; c=relaxed/simple;
	bh=FerPbPo1b+6O/ruKqXQBtdgpigRD+nF5Ksu/pHN8ClU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JF9n6YnoKl6wFheGqQwPNM4Rddoz7VTT+B6sERw2TAXGh3oYeY4lgkLOsd8wxy8sXQNRgIBvyLfhDUIJCWw/WpYSFgmsFAfpXBnL4/43vgsCHg/xeu9DNuQdalE6OpHtQeWJBuPBz5nVoVGN++mqnNfcAYuacsThn3Yd+Jj6JaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSSAhDw4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302D1C433F1;
	Thu, 14 Mar 2024 14:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710425644;
	bh=FerPbPo1b+6O/ruKqXQBtdgpigRD+nF5Ksu/pHN8ClU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WSSAhDw4Z5ZLcJGAmyA6kxGlc7cihVc6++TE1MY35x74aM0e5T1V9MTrEt8ooq1og
	 Krwp2N7XA2ZUuvKPFpENy9fzHKJSkaN0p/Ujcte4cG+Ea9YTJLV7lCPQbAzex6l2ii
	 7PyPXnFULxciT0Jr+mLyMiWpIdBLaGY6A8w59okHeIOkkVzbwlQz9x2qYMmsyiakyx
	 3wvlAHv9XY67wX7qt3wXd5NwLvPmxAKZH/Z/G5N9lbWWgenAzv3uYCk7a3qgzaSCik
	 muKHwTHvBh8rHx7jOHIx5ql+0WD4B+dwjtYOYixeeyljtrphe3vPG/Vwobk7/vMgBw
	 ZrsCCXNuQ3isA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Chancel Liu <chancel.liu@nxp.com>
Cc: Zhipeng Wang <zhipeng.wang_1@nxp.com>
In-Reply-To: <20240305065606.3778642-1-chancel.liu@nxp.com>
References: <20240305065606.3778642-1-chancel.liu@nxp.com>
Subject: Re: [PATCH] ASoC: soc-core.c: Skip dummy codec when adding
 platforms
Message-Id: <171042564292.33758.12106139288585646564.b4-ty@kernel.org>
Date: Thu, 14 Mar 2024 14:14:02 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Tue, 05 Mar 2024 15:56:06 +0900, Chancel Liu wrote:
> When pcm_runtime is adding platform components it will scan all
> registered components. In case of DPCM FE/BE some DAI links will
> configure dummy platform. However both dummy codec and dummy platform
> are using "snd-soc-dummy" as component->name. Dummy codec should be
> skipped when adding platforms otherwise there'll be overflow and UBSAN
> complains.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-core.c: Skip dummy codec when adding platforms
      commit: 23fb6bc2696119391ec3a92ccaffe50e567c515e

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


