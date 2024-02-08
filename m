Return-Path: <linux-kernel+bounces-58688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A9184E9F8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 21:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4F901F23EFF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8CC3F9F2;
	Thu,  8 Feb 2024 20:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+3Bx4Xa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04B048CD1;
	Thu,  8 Feb 2024 20:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707425787; cv=none; b=tdlfi/mG8gdJmXG8qiX4A32DT6YvqDyGI6yCpChjWuOfMh4qLL31kYSwAtE3Qsm66pzNzESR8+2CgJldtnNEs4h6ZuW/stdUrsIrYsmr284HtdxlW9G/x4pV+eqRphurKvkbX2c1uQs460P4udnywxdYzHgc5Xp6PE1AW3sgAV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707425787; c=relaxed/simple;
	bh=T8EwgSBfhLdOsFciFuw6X5d9/0+41gQ0AA16Ecb/rcU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HChk7CWgexCAMfVxKLcNaNCdLGG3xcYgE93T9sSc3VHHsdhz+Q6VVCDsv888kZT3cu+1XyDbiRH4aTRfApGb/6vVB0LKnM35uuMWzN+kq3kFGcPkpfY1UbK55vKZ/1685ktTyncmchJ3wTmWmIWpfZS7GHjdn5y9QJArIYj9ioA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+3Bx4Xa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0D7C433C7;
	Thu,  8 Feb 2024 20:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707425786;
	bh=T8EwgSBfhLdOsFciFuw6X5d9/0+41gQ0AA16Ecb/rcU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=e+3Bx4Xa4325tK8mGNO/Jhz450pjYzUveah8U9GEFNEVNETIXzBDCIL0hMqyJRNMp
	 hkMIKP8aTyBdPP6zXFrfShdRBFeVDyoNM/E4fdxxSVpKon/5Gs1K0NWcyqqOMwsjOf
	 l+imnJ7ff+linFqmKB9Hy1V1B1y/kJ2hfwBvv1X9N+Caq/VIxA1e5uRHfCHs+pDDsN
	 Bd+BT4sgZbHkbxypldvwp2Kd4SXmciQ3dT67PqSC31WwgOQhWaFNB0J1A8CPwVSQLg
	 LTZ4RNobnmr70yKt/r30QM4wBiIpWDQ1z7KQ88kBKzPFEs1pHUtHN0J+j87J0EDBDM
	 g4eha5M4qEqWg==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20240208123742.1278104-1-rf@opensource.cirrus.com>
References: <20240208123742.1278104-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH v2] ASoC: cs35l56: Fix deadlock in ASP1 mixer register
 initialization
Message-Id: <170742578487.2206785.11509531249240507855.b4-ty@kernel.org>
Date: Thu, 08 Feb 2024 20:56:24 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Thu, 08 Feb 2024 12:37:42 +0000, Richard Fitzgerald wrote:
> Rewrite the handling of ASP1 TX mixer mux initialization to prevent a
> deadlock during component_remove().
> 
> The firmware can overwrite the ASP1 TX mixer registers with
> system-specific settings. This is mainly for hardware that uses the
> ASP as a chip-to-chip link controlled by the firmware. Because of this
> the driver cannot know the starting state of the ASP1 mixer muxes until
> the firmware has been downloaded and rebooted.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs35l56: Fix deadlock in ASP1 mixer register initialization
      commit: c14f09f010cc569ae7e2f6ef02374f6bfef9917e

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


