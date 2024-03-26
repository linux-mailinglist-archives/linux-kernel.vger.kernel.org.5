Return-Path: <linux-kernel+bounces-119312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9EE88C6EB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DC7E1C3FC2A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04A813CC5E;
	Tue, 26 Mar 2024 15:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9H3froV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDA013C908;
	Tue, 26 Mar 2024 15:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711466879; cv=none; b=AkbJXjyc7VY40xincsXMMTjFg0pc8MwZmf/7cHRRgWLPX6WuE2EXrBYprLZLocL/qLYiet9Qh084iXLZ3/yDTpbFJ90VsXe9yy1DIqHPfQgr6vipmIPk/ktQnNKtrwUypffL0uYfQIrvZqj6StiTlNp4cIszJGwRUzxhyNpzi5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711466879; c=relaxed/simple;
	bh=hRH8KwD0yeb6Ii/FGemUiqr+aQmrUQOnUFhl/QaNG9o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PrPOc3l/jL5fhiAImbsm0v2uCGKey4Y+NR1DMmCSW2a+cdv+jv4TUdLPECXPunChJAhJAyw0PsBrlQXzw/MWSv9zVyds1pW2hyENjUX0amP4m+gAgNsk3dn6/tSiVc8PMKIrADNBXEUk9UiXUomAy5qdXVAYRiA71qHxYFTXZOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9H3froV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B18C433B1;
	Tue, 26 Mar 2024 15:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711466878;
	bh=hRH8KwD0yeb6Ii/FGemUiqr+aQmrUQOnUFhl/QaNG9o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=R9H3froV73QGMdXLc9BBRgXfXoWKxlqMl7mfPzkiV0Xotb+lR0OyS567kcVd2m/01
	 LInj8GTpsyRNN9SSVSTS6Lu3uLl2pGzZ7tAaBlgd7FKSj/5E1kuOSmiZ1sMVeENSLM
	 xC3kaP05IWC150YFK8BFnXYQv9W+B0928djHny3OBZ+24C3+glAUY2nff0owN2kgoJ
	 BG2o0V5bsX+KC9E7DnYDUK0aN50eMP/r2nNOzydUOmr0OEevwfIxqnVNe4F6PufLjR
	 xYJ4VHNDO7zKjJl7kFfXKdw5ZsK4z1va7FkozBAMAkJpHb14C9yHr5nhY65b2BypjN
	 jDxpj16VqKVtQ==
From: Mark Brown <broonie@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Vishal Sagar <vishal.sagar@amd.com>, 
 Anatoliy Klymenko <anatoliy.klymenko@amd.com>, 
 =?utf-8?q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20240312-xilinx-dp-audio-v1-0-696c79facbb9@ideasonboard.com>
References: <20240312-xilinx-dp-audio-v1-0-696c79facbb9@ideasonboard.com>
Subject: Re: (subset) [PATCH 0/4] drm: xlnx: zynqmp: Add DP audio support
Message-Id: <171146687400.132239.7354638412011978940.b4-ty@kernel.org>
Date: Tue, 26 Mar 2024 15:27:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Tue, 12 Mar 2024 11:41:01 +0200, Tomi Valkeinen wrote:
> Add DisplayPort audio support for Xilinx ZynqMP platforms.
> 
> This depends on patch adding cyclic DMA mode for DPDMA driver:
> 
> https://lore.kernel.org/all/20240228042124.3074044-3-vishal.sagar@amd.com/
> 
> If that patch is missing, starting an audio playback will fail with an
> ASoC error.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: dmaengine_pcm: Allow passing component name via config
      commit: cee28113db17f0de58df0eaea4e2756c404ee01f

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


