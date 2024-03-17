Return-Path: <linux-kernel+bounces-105504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F56C87DF6C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 19:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B90DF1F21245
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 18:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19661DA37;
	Sun, 17 Mar 2024 18:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5HhIvuv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E8C1CD1F;
	Sun, 17 Mar 2024 18:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710701814; cv=none; b=gXqleUvuPtnDvyN0U9GGyEgnAVmF8kgCkgSWZ4RA0RmBrOuLcSrh2aJUzhzgIbcTkdojCK6B4nWx++am2ASWnA20BXIu7TQME33bBeRMXIJ1jNxdGsB63hStu3iqs/MTy5ikuAInee9rl5MRk9H7MpYxN4YjS7SoB5wzw2S/s84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710701814; c=relaxed/simple;
	bh=C1Qhz7RVqLKa7aHBWi3LhaNuIEVA6aUWA51sPBVTAu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DR4VgQkG5Y+n4merscvACpphZn8dxBrGES+Q6X2TZOndIK64ekEouH4pfbwqs9b4A+CyQ04lBmCNJ0ZjSl/imscXKLaKoUjSTCQvy0paDtp6TCTh0DqB11o3HBmmj0Ogz351NLhbQFM8bIEogaHtizfBM2I6325EDY8SRDyvD58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5HhIvuv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5428C433F1;
	Sun, 17 Mar 2024 18:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710701813;
	bh=C1Qhz7RVqLKa7aHBWi3LhaNuIEVA6aUWA51sPBVTAu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L5HhIvuvC0Xd2nB2Rr2eXkrHIHAgMhFoOvCNUMOpvinqWDDpj6mnggSOFGku9EPup
	 6Qtd95gN3+9SoABc4z+wH3nBE+2f1pj5yhyJMKydaia7qcbD4NHBy4EUxtc7y/0c6i
	 0NpEi5e6pE5aoPkv8dy5P+A5vb6wgplbits4tFi0ewLe5lj8H8E7w67Pxb7E3Ea1Z0
	 EpIWZ2XRY7BZ2knGzqNrTJ6TAzBGF4q9AqNKVyRHtrI4XYdO4RfRYxpDpOtgV8DQSf
	 p8vK/0GAAo6N/VHP2GKg3Lb0ro8nnEjixcx5Jbz4wqns5olFR/Ez4Nq1tKqDCo1TV7
	 hz7tPsdQFoHnA==
Date: Sun, 17 Mar 2024 12:56:50 -0600
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: zhourui@huaqin.corp-partner.google.com, amergnat@baylibre.com,
	allen-kh.cheng@mediatek.com, trevor.wu@mediatek.com,
	wenst@chromium.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, u.kleine-koenig@pengutronix.de,
	shane.chien@mediatek.com, claudiu.beznea@tuxon.dev,
	ckeepax@opensource.cirrus.com, arnd@arndb.de, dianders@chromium.org,
	maso.huang@mediatek.com, linux-kernel@vger.kernel.org,
	broonie@kernel.org, matthias.bgg@gmail.com,
	kuninori.morimoto.gx@renesas.com, perex@perex.cz, frank.li@vivo.com,
	nicolas.ferre@microchip.com, eugen.hristev@collabora.com,
	linux-sound@vger.kernel.org, kernel@collabora.com,
	jiaxin.yu@mediatek.com, alsa-devel@alsa-project.org,
	xiazhengqiao@huaqin.corp-partner.google.com, conor+dt@kernel.org,
	shraash@google.com, krzysztof.kozlowski+dt@linaro.org,
	jarkko.nikula@bitmer.com, tiwai@suse.com,
	devicetree@vger.kernel.org, nfraprado@collabora.com,
	lgirdwood@gmail.com, alpernebiyasak@gmail.com
Subject: Re: [PATCH v3 18/22] ASoC: dt-bindings: mt8195: Document
 audio-routing and dai-link subnode
Message-ID: <171070180968.2064436.13730344505165818889.robh@kernel.org>
References: <20240313110147.1267793-1-angelogioacchino.delregno@collabora.com>
 <20240313110147.1267793-19-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313110147.1267793-19-angelogioacchino.delregno@collabora.com>


On Wed, 13 Mar 2024 12:01:43 +0100, AngeloGioacchino Del Regno wrote:
> Document the dai-link subnodes and the audio-routing property, allowing
> to describe machine specific audio hardware and links in device tree.
> 
> While at it, also deprecate the old properties which were previously
> used with driver hardcoded configuration.
> 
> Also, since describing machine specific audio hardware and links replaces
> the now deprecated old logic doing the same in a driver hardcoded fashion,
> it is not allowed to have both the old and new properties together.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/sound/mt8195-mt6359.yaml         | 134 ++++++++++++++++++
>  1 file changed, 134 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


