Return-Path: <linux-kernel+bounces-95708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC91875194
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71FC61F26C54
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4707C12DD96;
	Thu,  7 Mar 2024 14:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6PAGLgF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8098F12C52B;
	Thu,  7 Mar 2024 14:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709820751; cv=none; b=BFeZalbg3ZN/H1P24hdTzVdDqHVpG76aCrtIju/jv+imZy1L90ls1XlAqfP+Pr+UoSFWXekpurTd2AKRR5g5cMthWkhMxJeFyN34SgiagjC2IOL8TgZQzV7khx4vLTV7pyPpAI5sO25aMu+ZoaTjxSP3xEw6hVIrVl4pmn+q064=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709820751; c=relaxed/simple;
	bh=nvbQsr5KjGsdgCRWMMm6N+qmKuGEbiis9IDBpCnfHWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRIcObYYWvWDD5CNjGqiTVMQwvThZsRjoz1Wy6kmB4lHD6ZP5wb6/i0DsBi65Y7PcSZ5Xb9Mv5QnojvWJtJhKIIORjsi75o0inydAgJDn0qoehsvzyJy8SUEtBaLMwXa79amadWFt4CR76j5/lh8kN1iYrmurSOCe6HgFKEGj1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6PAGLgF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76175C433F1;
	Thu,  7 Mar 2024 14:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709820750;
	bh=nvbQsr5KjGsdgCRWMMm6N+qmKuGEbiis9IDBpCnfHWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S6PAGLgFEUhhVnJvxN9VBaasVy+W3B8NrblbXlXKVEObuLjkruTXouwbGYKa3GBI1
	 FJ0VlAfRtDaE5JJfuzJbej0DtmIINDKfOopCmms4fGTiC/gf6fd/jn9AmErabgyRXY
	 FVviSDnbtXKgXWetVHpzUBe50o7wsniQJz9BAQYTE+WY2iRACaHPqdA1U+p0TB3wxg
	 YTvrigZ9SNzD5itbbaw+okGwNGH2+NKjg5sDuxqthcxBh15/V4ZzX2uw4qnOWuTKIk
	 SiKQ8QZhMO+HiFSChgY86lRoZwtKUikxUNyToLVHB2q6z69CISeHTkAhft9xoZX2ww
	 NWn67JxkycS6g==
Date: Thu, 7 Mar 2024 08:12:28 -0600
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
Subject: Re: [PATCH v2 19/22] ASoC: dt-bindings: mt8192: Document
 audio-routing and dai-link subnode
Message-ID: <20240307141228.GA2491015-robh@kernel.org>
References: <20240307114445.196981-1-angelogioacchino.delregno@collabora.com>
 <20240307114445.196981-20-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307114445.196981-20-angelogioacchino.delregno@collabora.com>

On Thu, Mar 07, 2024 at 12:44:42PM +0100, AngeloGioacchino Del Regno wrote:
> Document the dai-link subnodes and the audio-routing property, allowing
> to describe machine specific audio hardware and links in device tree.
> 
> While at it, also deprecate the old properties which were previously
> used with the driver's partially hardcoded configuration.
> 

I replied on v1, but one more thing here.

> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../sound/mt8192-mt6359-rt1015-rt5682.yaml    | 124 ++++++++++++++++--
>  1 file changed, 115 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml b/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml
> index 7e50f5d65c8f..449454c50dcc 100644
> --- a/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml
> +++ b/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml
> @@ -13,6 +13,9 @@ maintainers:
>  description:
>    This binding describes the MT8192 sound card.
>  
> +allOf:
> +  - $ref: sound-card-common.yaml#
> +
>  properties:
>    compatible:
>      enum:
> @@ -20,6 +23,14 @@ properties:
>        - mediatek,mt8192_mt6359_rt1015p_rt5682
>        - mediatek,mt8192_mt6359_rt1015p_rt5682s
>  
> +  audio-routing:
> +    description:
> +      A list of the connections between audio components. Each entry is a
> +      pair of strings, the first being the connection's sink, the second
> +      being the connection's source.
> +      Valid names could be the input or output widgets of audio components,
> +      power supplies, MicBias of codec and the software switch.
> +
>    mediatek,platform:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description: The phandle of MT8192 ASoC platform.
> @@ -27,10 +38,12 @@ properties:
>    mediatek,hdmi-codec:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description: The phandle of HDMI codec.
> +    deprecated: true

The deprecated keyword doesn't do anything at the moment, but my plan 
there is to add a mode to the tools which disables all deprecated 
properties. That will give you want you want in terms of disallowing 
these properties.

That would require dropping them from "required" which I'm fine with you 
doing. (Though technically that's still an ABI change)

Rob

