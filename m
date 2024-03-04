Return-Path: <linux-kernel+bounces-90726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A31B1870409
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3548F28458F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FD146546;
	Mon,  4 Mar 2024 14:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLlpWI/p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A611C4644E;
	Mon,  4 Mar 2024 14:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709562289; cv=none; b=LIiP5xI2DmV2FMHhSK0zsV7xk5jFm/xH0VyAJoLfTBXvQBfXVrRG3CnX0KJclSTTakWPaB5VU6fTZNBqZDMDZA/SiZfWLBna+DZGg3+tWVJ2Xj+TWPiLt7DAEC6Jc2d03SBsPxrl3QNO88FmKHIQBpNKSWsibvnV9RpGK8Ks+PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709562289; c=relaxed/simple;
	bh=6gCiVFXmpuEznUgKdT1gpn2oh/lHn5kfV0SnIxnZcus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f66/c5VX8hmJDLKnZkiGkQ1lpto+GYPe049qGjOauBLLKd6mjWrE9F58lbJ2SySqB0+0jXsgKHBf2IIHiWl4x2UWOQZZ6vqEurrnbS5iMe5Gm6yEeMmmUCE920ZNWH1yDBcuhWyRAIUoFw41CmjUcK/kXJZYXdLvd2heIhsCKqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLlpWI/p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9ABEC433C7;
	Mon,  4 Mar 2024 14:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709562289;
	bh=6gCiVFXmpuEznUgKdT1gpn2oh/lHn5kfV0SnIxnZcus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LLlpWI/pBrzJtatXQW11HUwzKuXsVyGKKfBiSSowA2WXESzIhQfnBkrEpzBl7V0Nv
	 q2pxS5bCEpGYLg32QR2Tm5c0LnIDmwpdSp+RMa19knG97b3bvgw3njuCgv/oyJ/o7b
	 DrZg9BfvRaYfzndcxmrDqH9vjbU4TLg/WRLaaCjZdJbBFqHPbXZugIwDd9vBvMjvbU
	 P9KOQfg3KdqyBgxq71VObOK7ZS3L1VvR8/nnIefqsB6aO+fOJclNQ6Z92TMMaa8rkx
	 YDNZFqvAZ3wTH/Osq8uQvrg8WsfBXGn/PynwJKAjuPrNr+HL1SVCJiZniXKAZHOhPS
	 LA1aR6hX2oBww==
Date: Mon, 4 Mar 2024 08:24:46 -0600
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: broonie@kernel.org, wenst@chromium.org, lgirdwood@gmail.com,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	matthias.bgg@gmail.com, perex@perex.cz, tiwai@suse.com,
	trevor.wu@mediatek.com, maso.huang@mediatek.com,
	xiazhengqiao@huaqin.corp-partner.google.com, arnd@arndb.de,
	kuninori.morimoto.gx@renesas.com, shraash@google.com,
	amergnat@baylibre.com, nicolas.ferre@microchip.com,
	u.kleine-koenig@pengutronix.de, dianders@chromium.org,
	frank.li@vivo.com, allen-kh.cheng@mediatek.com,
	eugen.hristev@collabora.com, claudiu.beznea@tuxon.dev,
	jarkko.nikula@bitmer.com, jiaxin.yu@mediatek.com,
	alpernebiyasak@gmail.com, ckeepax@opensource.cirrus.com,
	zhourui@huaqin.corp-partner.google.com, nfraprado@collabora.com,
	alsa-devel@alsa-project.org, shane.chien@mediatek.com,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH 20/22] ASoC: dt-bindings: mt8186: Document audio-routing
 and dai-link subnode
Message-ID: <20240304142446.GA171936-robh@kernel.org>
References: <20240227120939.290143-1-angelogioacchino.delregno@collabora.com>
 <20240227120939.290143-21-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227120939.290143-21-angelogioacchino.delregno@collabora.com>

On Tue, Feb 27, 2024 at 01:09:37PM +0100, AngeloGioacchino Del Regno wrote:
> Document the dai-link subnodes and the audio-routing property, allowing
> to describe machine specific audio hardware and links in device tree.
> 
> While at it, also deprecate the old properties which were previously
> used with the driver's partially hardcoded configuration.

This can be combined with patch 19. Same comments apply.

> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../sound/mt8186-mt6366-da7219-max98357.yaml  | 112 ++++++++++++++++--
>  .../sound/mt8186-mt6366-rt1019-rt5682s.yaml   | 112 ++++++++++++++++--
>  2 files changed, 210 insertions(+), 14 deletions(-)

