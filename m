Return-Path: <linux-kernel+bounces-119313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D33C888C6EE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B3513207CC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7F713CC7A;
	Tue, 26 Mar 2024 15:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hxc4m8W1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B0413C91B;
	Tue, 26 Mar 2024 15:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711466883; cv=none; b=iwlXVv/Mu22cLJo0cZortVxNp7p8SWTbgvEGdZqX+cF1IvNbJ7Hdn7ROqrWiS45uIK8bKw++yjjaXdKRO7dGOEX0KNF5alnrRbNtL8e4cqDg4Vll8/VgrcDHjEtQj8qTw3j5M4pZLtZq1aypHkIDivaLEqaJMKs4HjvnnlLx+c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711466883; c=relaxed/simple;
	bh=rtyqG7tbP6UdPkekPZzDTtw8SgBNzRw2sMyiAo22mhs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jtSW4Gi4JSingdgB52czPAtiH5TcvTtG/u87D2v3QEa2eGWt0TJplObjQI2ccEc9yzMi4SptbcaNhyEf2jkthZYhyh8LQx6UANOr4OftFcMJBVkUB3J7PhKnx3E19eEqy/btOerlxgMddyQWnxRXAnyKMNdA6OEaMr7AwoOL6Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hxc4m8W1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038BDC433F1;
	Tue, 26 Mar 2024 15:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711466883;
	bh=rtyqG7tbP6UdPkekPZzDTtw8SgBNzRw2sMyiAo22mhs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Hxc4m8W14eaRDGErYkG+g97Das8kOomVfVpVzmgTi8R+hLsDJG1g0s/AyCfvuUk6f
	 IcWSC1pA1JrKLH4AEFZxSf3t9qYiTX2bOAs1iy17ylh96i2CnCPnquwew8XwLixVUt
	 h4WNokMzanCKMtItm6z42ROvj2D7F+GqcPYAT8N8ZfddJTaZ7RN+1a0V19F95nkOQY
	 lSsgz8i24rh8bxqNgBBfqRj2IjJpg+Hx787PQYjb4lqJqvZ5gkZdc6FO5crMPyjQDD
	 ZO6Fv6Gp4oLt6wqDC2kbKJ1YgGDVjOnwHzbW9WFSHAUBFkX5zgllVwFsLCj7wEb2FJ
	 QvvISKPVukXYg==
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
In-Reply-To: <20240319-xilinx-dp-audio-v2-0-92d6d3a7ca7e@ideasonboard.com>
References: <20240319-xilinx-dp-audio-v2-0-92d6d3a7ca7e@ideasonboard.com>
Subject: Re: (subset) [PATCH v2 0/4] drm: xlnx: zynqmp: Add DP audio
 support
Message-Id: <171146687873.132239.7709540608544229526.b4-ty@kernel.org>
Date: Tue, 26 Mar 2024 15:27:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Tue, 19 Mar 2024 10:22:35 +0200, Tomi Valkeinen wrote:
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


