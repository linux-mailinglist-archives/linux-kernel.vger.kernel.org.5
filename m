Return-Path: <linux-kernel+bounces-164163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E28108B7A0D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E3C2280D53
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6B3179972;
	Tue, 30 Apr 2024 14:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDLYhQNv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755943AC16;
	Tue, 30 Apr 2024 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714487497; cv=none; b=jCSU8w0xHjeHz4nv67t2l33g7kjeQwelf6ibk7TdgqZa95JlWXjjulHFvwZ/YrVs5jFLiessYlxSUpnVexi0LkdWvd1njGlrvhuDq1elqXiEKhhivCBNI+TJ3ITsdbKl4n7cmzA9n/ciehRgJFupEIaA0GJpWIaBA6o0Sn6rMRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714487497; c=relaxed/simple;
	bh=rAZcmLCKs6C3ZgBBEHG7AWSAjm/WmGO8airtDzp/QGk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=f6Q10fQGj141PsuxPpgWcjCqZgXDIDVAJ+napG6yU3COAMGqVwmcNl3x9jA4w/sR+UK7gfiyZyB2Z8qxxRpNTvLdjU44KAqGkQMq2fQWZJMjG3ZxcDP7+A18uvMbdjlVbupk2U/HrOdDR8+wjTTu2NBtdQwzVXittzzFsOUr6BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDLYhQNv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FBF9C4AF1D;
	Tue, 30 Apr 2024 14:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714487496;
	bh=rAZcmLCKs6C3ZgBBEHG7AWSAjm/WmGO8airtDzp/QGk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WDLYhQNvf2fu44bGta60FeP2ltWuqBq25yIETMyjyaRLOf0R0dBo3EkBFcjSGYYKl
	 sjZHjwCmwL7y2zunGhlRgrA9L5PD5yGRwBQqpFpI0vHYcw9dPrilRXDxHSYRLIty6M
	 eCPTh+REpLaMHnsPNucEPeSLJHfiIEWNdTywAgPYi35Sjx53lK+SPmmwpCqgnFhmED
	 UMuniQnAz5+7tCJD4m4bl3JH73h9+muxvPBhRwEo2Z87PWvoZuoQkNUTrHeGO6AUCy
	 w7wf01nrJILxMHp4lPHq9Nw0VvUv3q5YxFeMRvpT0rBg5jawK3SQT+RrjnZgabGkc4
	 EaNnnu/rqisow==
From: Mark Brown <broonie@kernel.org>
To: Ban Tao <fengzheng923@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Joao Schim <joao@schimsalabim.eu>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240429194920.1596257-1-joao@schimsalabim.eu>
References: <20240429194920.1596257-1-joao@schimsalabim.eu>
Subject: Re: [PATCH v2] ASoC: sunxi: DMIC: Add controls for adjusting the
 mic gains
Message-Id: <171448749392.1870439.1399491803158865203.b4-ty@kernel.org>
Date: Tue, 30 Apr 2024 23:31:33 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Mon, 29 Apr 2024 21:49:20 +0200, Joao Schim wrote:
> The AllWinner H6 and later SoCs that sport a DMIC block contain a set of registers to control
> the gain (left + right) of each of the four supported channels.
> 
> Add ASoC controls for changing each of the stereo channel gains using alsamixer and alike
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sunxi: DMIC: Add controls for adjusting the mic gains
      commit: 9a8cadddd9303ae15d1d518c4f2ddf00ee668729

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


