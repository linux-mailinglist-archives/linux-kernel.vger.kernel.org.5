Return-Path: <linux-kernel+bounces-78756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5A6861863
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88E77283DDE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957CA5B1E0;
	Fri, 23 Feb 2024 16:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/ldrGtS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57603FF1;
	Fri, 23 Feb 2024 16:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708706824; cv=none; b=ewI/C7tYjacCcc5TNC8dqLadwlsR23ODPIePYjczOCWOevrm6DHxmhsEf6RwYrbFzrUFqOnmhV4GYYHF+OarjpfXDbXY4mllJyNArtmGH6w5jqiCVUeBbiGmBR3MMFhJJmI6+2+8IamwFlDzsGwsXrXzo4ygPtZpeoZiPSRuTSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708706824; c=relaxed/simple;
	bh=BesFWAtuTprjWylLkXSgMFyYOvsUukjAQwbOy9l/KHM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fACDoh/dPGoUa/3R+8xKQY8sdBJ91boWcsBEhjgBx+xE4NKqYcVxSwtO521Po0Yf5VCKfZd8FUox8Cw5x/l8PrjhiY8jM9HVMrxMD8Iob9Y0SVRSWJHr451Jy5mwj+j1PI4kkbeUzoFFe3T0q/CwsWVt7+hPP6VB/scl50Kr2Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/ldrGtS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A36D1C43390;
	Fri, 23 Feb 2024 16:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708706824;
	bh=BesFWAtuTprjWylLkXSgMFyYOvsUukjAQwbOy9l/KHM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=a/ldrGtSSfN/5ylfj5KLaM0svgwwTwG7L3iT1TvCMv+me9j8uswywGNPKVtvDO/pv
	 jvHa9sxagoBw0mc5TWkO3GCU9qxBMj1D5cBTiPNGowEox60TSujga1DTrdunar2KFh
	 6HjqrLlVB/V7tQqQwBFkTnUZiABawY79VDb0j4FFGN8tj5kH+dgST9txDFV5xag2PJ
	 c8Kk/SyrNrcFP5S29sD8T/HzhlALn4tcF+scn0J8bHTQq1B2ycE9HBRRpj9GeGQlwk
	 Rv/BaMwFdAz49QF9s/ys7R2s8i/rPG3mpJfMkNtYfM/qI3iyb5qGtCKPlvrFip0StD
	 QSWEMbQo16JLA==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, 
 Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 patches@opensource.cirrus.com
In-Reply-To: <20240221123710.690224-1-rf@opensource.cirrus.com>
References: <20240221123710.690224-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: soc-card: Fix missing locking in
 snd_soc_card_get_kcontrol()
Message-Id: <170870682233.2835191.8056467761867046237.b4-ty@kernel.org>
Date: Fri, 23 Feb 2024 16:47:02 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Wed, 21 Feb 2024 12:37:10 +0000, Richard Fitzgerald wrote:
> snd_soc_card_get_kcontrol() must be holding a read lock on
> card->controls_rwsem while walking the controls list.
> 
> Compare with snd_ctl_find_numid().
> 
> The existing function is renamed snd_soc_card_get_kcontrol_locked()
> so that it can be called from contexts that are already holding
> card->controls_rwsem (for example, control get/put functions).
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-card: Fix missing locking in snd_soc_card_get_kcontrol()
      commit: eba2eb2495f47690400331c722868902784e59de

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


