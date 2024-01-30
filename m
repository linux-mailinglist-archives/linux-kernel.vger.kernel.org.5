Return-Path: <linux-kernel+bounces-44862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F06C4842841
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 772C7B22160
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A8C82D95;
	Tue, 30 Jan 2024 15:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIPWTimC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5870F81AB6;
	Tue, 30 Jan 2024 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706629421; cv=none; b=YKcL14B+JBYeU6I/VdnlovkccynPRUwRH/whj6dnosdzfZF6MqjNfpMdlpLXYkPveR15QqnkcRK93TQANTgiS7gOFtbQr0GOaUcgSMN/XrhjCneiT3sQWcD9afKKyvgKg0+ZaEqRlodmzPEMY/zkz10ii10jV/C91mkQVjPHT6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706629421; c=relaxed/simple;
	bh=WMy6RRsQJLRJBWnLJ89lCoe7Y2F1OmudZmS9VXnXbF0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BdMVVHCTRmcWbfgN0yj/Jo39w5IK4AWlQ76JothPXNQ2Zf3A1IAorONP7b0G/vM0zPehQV2LRcvvKdPIngte+rRdwSwOJjN3OQBgcEfMLgkIsKjt5AqGJgN7nt3/WPa2E9XBksimLLh3VNjJuCaZjNNdSGFp4f1vVNF/jLkHvYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIPWTimC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3FFC433F1;
	Tue, 30 Jan 2024 15:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706629420;
	bh=WMy6RRsQJLRJBWnLJ89lCoe7Y2F1OmudZmS9VXnXbF0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=XIPWTimC4vkbKvCeyHE5AQ73La6/FDJpl9jnJKlCmjVKEnoDHYUTIatIZlVXwAg5U
	 Pk0a3PR9adimq8/TbjBoMg/G0aWvD/sR+WdMV4lmWT+rzQ8mu1qHeKEVH2b/GXhmYj
	 viKITSR98ijF31um22mekf8HEVrJXbxgpyr0v+FrpxOA8NbEQXi5u3mwzBm1YJRUWa
	 uwxAwfysaL0mQ0VKUg8nlPkaeMIQqwxfSiJ58JKl6PqyObHkaV3RsJSFgBol+lgSEd
	 rBLzNgqBlZDxNpy+oPFMeKvW7gAI87vKVr3bGao074pSg27TvZE8Fjjq3tpRndC8i9
	 7PsTpI64hgG5w==
From: Mark Brown <broonie@kernel.org>
To: Maciej Strozek <mstrozek@opensource.cirrus.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, alsa-devel@alsa-project.org, 
 patches@opensource.cirrus.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240123113246.75539-1-mstrozek@opensource.cirrus.com>
References: <20240123113246.75539-1-mstrozek@opensource.cirrus.com>
Subject: Re: [PATCH v3] ASoC: Intel: mtl-match: Add cs42l43_l0 cs35l56_l23
 for MTL
Message-Id: <170662941829.37296.6809902115507707468.b4-ty@kernel.org>
Date: Tue, 30 Jan 2024 15:43:38 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Tue, 23 Jan 2024 11:32:46 +0000, Maciej Strozek wrote:
> The layout is configured as:
> - Link0: CS42L43 Jack and mics (2ch)
> - Link2: 2x CS35L56 Speaker (amps 3 and 4, right)
> - Link3: 2x CS35L56 Speaker (amps 1 and 2, left)
> 
> Corresponding SOF topology:
> https://github.com/thesofproject/sof/pull/8773
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: mtl-match: Add cs42l43_l0 cs35l56_l23 for MTL
      commit: 84b22af29ff6c74e09e3faa0ad52c843cca1f426

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


