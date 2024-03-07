Return-Path: <linux-kernel+bounces-95967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AC387556C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D389C1C224D1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EA2130E5E;
	Thu,  7 Mar 2024 17:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzVGMf8r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4101DA27;
	Thu,  7 Mar 2024 17:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709833390; cv=none; b=cPI2LLx0xGYISrsgzcwP4cc/mcUYls9HcJA7wQdHLAMWaUff2zVO/RvscIamGIyOak8Cd1KuC8AqKBRUoQWlLt3qvMswiExDeMS4en/X0T6VFfAUkUO8nRe9Zgg2dbBHC79nNquDqxLJU0NLk8gydv+QP15Kw3JQZwL7P9o+7o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709833390; c=relaxed/simple;
	bh=FxTN8wmTOOtkcRhR+GPUgI7j4Kh31mD0hBGQBSjSMwo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bG4fP/OfL5C022bknNtbf2IoC95286jzyBjazbL4Ebtr+RjV+J+i1O17d/RMvp8COYUHLzG1YoHtfpfrl7qRQEYeAqTgSQX4vLgJsN6v0aUWDea+APsNDdFzGtUkY0zCwgLeG6SKrnbJFp6UifWIPh76JjqL7liQYD8bYtWd0hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YzVGMf8r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 119E0C43390;
	Thu,  7 Mar 2024 17:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709833390;
	bh=FxTN8wmTOOtkcRhR+GPUgI7j4Kh31mD0hBGQBSjSMwo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YzVGMf8rd3vB3hJ2jU7a3m5TXdZpMFZlgd9Ht/oLnYSkbxw4QUUBfw0t0fs8xs5ha
	 FdPBK9BVprmfdnEM3DOaPLzDutl0qNUZAF1WKRCCHC8mCQ3krO8ZfjDrOOI89Mn72J
	 i3A0v1Dvs4Wg0/WX7uPORJI5ZGuUMMLxPFITOtALC/m48gF4sLagvWSEnois8scp94
	 Ol7lNmwroRlZ3vlCUtvI9JVOWdU4aMPaX0Cfo/1y3xjzFbVJhuOhOqmm1zvbFGkp2m
	 +nEOvIhID8bjPDzE3HCvBKL/xNbL1PN+7vaJyHB8SK/YxpBEkA6ajTeIluVd21gVj9
	 jd2J41PPLo3bQ==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, 
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20240307110227.41421-1-rf@opensource.cirrus.com>
References: <20240307110227.41421-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: wm_adsp: Fix missing mutex_lock in
 wm_adsp_write_ctl()
Message-Id: <170983338880.97308.14001370070298134572.b4-ty@kernel.org>
Date: Thu, 07 Mar 2024 17:43:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Thu, 07 Mar 2024 11:02:27 +0000, Richard Fitzgerald wrote:
> wm_adsp_write_ctl() must hold the pwr_lock mutex when calling
> cs_dsp_get_ctl().
> 
> This was previously partially fixed by commit 781118bc2fc1
> ("ASoC: wm_adsp: Fix missing locking in wm_adsp_[read|write]_ctl()")
> but this only put locking around the call to cs_dsp_coeff_write_ctrl(),
> missing the call to cs_dsp_get_ctl().
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm_adsp: Fix missing mutex_lock in wm_adsp_write_ctl()
      commit: f193957b0fbbba397c8bddedf158b3bf7e4850fc

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


