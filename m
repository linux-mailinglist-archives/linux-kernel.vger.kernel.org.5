Return-Path: <linux-kernel+bounces-92975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D47538728D8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9EC61C28212
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3821C12C52F;
	Tue,  5 Mar 2024 20:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yu4QqFXd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CA312AAFE;
	Tue,  5 Mar 2024 20:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709671320; cv=none; b=hZM27hPESd/jiEHSI3nuV3odAZxGhKXv+1RBXwuwnXHFaoVv2phWaJDiTSQbdfwElE+pWIz5u8bHVRZBDewuY/ntRVtAhWQXVuZAnSqmAQezxcuOQNChQWVeBVjlBY3pRAhYF63mzzKfDwF8pd7HRJpQdkJtRgseCdwpRS0WGR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709671320; c=relaxed/simple;
	bh=wGu4QJOMPf4bGNsLXpFxU0DIZdI37Z4S5dsO3ofAR0k=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ON5gdFvMIf6Mrbs3RhXGy4tdnZdanOExaRHU2XNJ0KHz+te8i98/olzHH9M++ZOBk4MkwXwfDNPpJMW81aVHJBayXrIK+HgeoMj0gyJYadmxvUmJMqSAzjrV3SaYTGtqRxl+/EUaISsntmr3k6b/oM8Nct4JSzdIMmq/iiUAK4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yu4QqFXd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA72C433F1;
	Tue,  5 Mar 2024 20:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709671320;
	bh=wGu4QJOMPf4bGNsLXpFxU0DIZdI37Z4S5dsO3ofAR0k=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=Yu4QqFXdI04R9dsBWIcTkyRZYJD47OKlIKa6M3AMI8YhRMuj/XnejAW5gxnelXxPK
	 Dw11HqWrlNo3e05KiKyNp3pQhwKVOxszE0SP9N7uMbAYrPUd+vfotOMCTaye6uH9jy
	 QtxP752jcOu0IBqZXtpVX8QS6QOzQp6yiBKVWdgVmYEAdOAR4aynD1dmr+jQenngGe
	 4ZLqdLpb4TP/jq3dFsShuYJs8SC164twQL+KnPbe8tSSGdZ9Td4QpaJrVQ3kwPl9sI
	 m3x/WOGAkRvC0mb7fZqRMO2uhknyOPiqvCWDwNR4TKSkpNdWDzpQMy1sEW2CbtFCnY
	 s3t8QPk6JECzw==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 kuninori.morimoto.gx@renesas.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, 
 Chancel Liu <chancel.liu@nxp.com>
In-Reply-To: <20240304072128.2845432-1-chancel.liu@nxp.com>
References: <20240304072128.2845432-1-chancel.liu@nxp.com>
Subject: Re: [PATCH v3] ASoC: soc-core.c: Prefer to return
 dai->driver->name in snd_soc_dai_name_get()
Message-Id: <170967131843.228819.11945319282309242328.b4-ty@kernel.org>
Date: Tue, 05 Mar 2024 20:41:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Mon, 04 Mar 2024 16:21:28 +0900, Chancel Liu wrote:
> ASoC machine driver can use snd_soc_{of_}get_dlc() (A) to get DAI name
> for dlc (snd_soc_dai_link_component). In this function call
> dlc->dai_name is parsed via snd_soc_dai_name_get() (B).
> 
> (A)	int snd_soc_get_dlc(...)
> 	{
> 		...
> (B)		dlc->dai_name = snd_soc_dai_name_get(dai);
> 		...
> 	}
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-core.c: Prefer to return dai->driver->name in snd_soc_dai_name_get()
      commit: 755bb9a44f52dcc386c8db84d7c5a0f94ee95640

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


