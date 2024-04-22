Return-Path: <linux-kernel+bounces-153471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 818A48ACE7F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35E11C20FB7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329FB150980;
	Mon, 22 Apr 2024 13:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iixz3cF+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8DB13F45F;
	Mon, 22 Apr 2024 13:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713793150; cv=none; b=liovaRay6N+NAbmtYWbt3gGyZU7jRMwYSaf6YrsexGGMtwP+FsB7cTB0jdHHpG9We8IJn5Y1UKFa6xD0jOGoVbOyehOmvoxECYpMQNrye/MAxkCt9ngXu1G7dOmkJMom8BYYY0RgMy1rneP9BKCUgzvF8AmOioSd1rutgsVN+1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713793150; c=relaxed/simple;
	bh=aT4PQ5lC5s45eaoHkuUwSZZpTi8/HgCpiBvJiq65H6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUWTGwvefZQ0dUwhJdzyslEPErc8R+gGFGtVybcx8z60LEvj05ziVWPfTG5PbRDsci94mrKpzt91Fwvi+OCb+y9nt5qKku15ECLIOTPb+g/FQ0zrQ99ItDd2qfbEWB5Sg0PP54fvjRrsRkwYYSN1+j5of6xV6YcfzAD8ybnX5pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iixz3cF+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBABC113CC;
	Mon, 22 Apr 2024 13:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713793149;
	bh=aT4PQ5lC5s45eaoHkuUwSZZpTi8/HgCpiBvJiq65H6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iixz3cF+UZtX6hXDhGzB1/f/S2pBWT0Kx4vtFTQirpEOhjL/QuJJa7YPp5tS4wu39
	 f8qunA41uat41G3IvI6voh6PBMZAF49UtYI1X0M5Dy+xzyHF0vRVhXAogd0pPI3rjX
	 qzp5xaxRJgFigyl6IzetX8GCLxZzD2UuiTj9hpSP6mnSetZH4TSqW0i4KkimezbfzT
	 3HG6xQNbITqhszhY1MdSB8AqMAghqh+T8mdwwIrq3WyozrjKcWmReNGQDj8BzpUbyi
	 3nMcDiq36+siQ6Dfo3jn6P36uNwoWNRq5uxE0dhKEHtbbROeZoFvT78eG5vvb6Mo+v
	 zalyiQF9eBElQ==
Date: Mon, 22 Apr 2024 08:39:07 -0500
From: Rob Herring <robh@kernel.org>
To: Alexandre Mergnat <amergnat@baylibre.com>
Cc: David Airlie <airlied@gmail.com>, linux-pwm@vger.kernel.org,
	Philipp Zabel <p.zabel@pengutronix.de>, CK Hu <ck.hu@mediatek.com>,
	linux-arm-kernel@lists.infradead.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-mediatek@lists.infradead.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Fabien Parent <fparent@baylibre.com>, Will Deacon <will@kernel.org>,
	dri-devel@lists.freedesktop.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Stephen Boyd <sboyd@kernel.org>, Jitao Shi <jitao.shi@mediatek.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Daniel Vetter <daniel@ffwll.ch>, linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 07/17] dt-bindings: display: mediatek: dpi: add
 compatible for MT8365
Message-ID: <171379313275.1132930.2620391532022388821.robh@kernel.org>
References: <20231023-display-support-v3-0-53388f3ed34b@baylibre.com>
 <20231023-display-support-v3-7-53388f3ed34b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023-display-support-v3-7-53388f3ed34b@baylibre.com>


On Thu, 18 Apr 2024 16:16:55 +0200, Alexandre Mergnat wrote:
> Add dt-binding documentation of dpi for MediaTek MT8365 SoC.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


