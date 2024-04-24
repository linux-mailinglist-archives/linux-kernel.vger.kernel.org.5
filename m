Return-Path: <linux-kernel+bounces-157579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BCA8B1325
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37DBB2820EB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A311D556;
	Wed, 24 Apr 2024 19:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOqJHgg7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EE61D53C;
	Wed, 24 Apr 2024 19:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713985449; cv=none; b=AiKpI3evK+lAmAqZL9wKc9oWIIpU/qEWPC5V8/xKodWRvJmkrF5DoRBTsMszzEutk7Wi+ngYYnXKEAlyrvVxDRaqg5N76Qt3KC6EN/ll6THS6B04tliVnjdZrAr+Gjb6frkiHS4rFi7FevN/N5mA+u+RKR4d8wUcmkusNVT1z0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713985449; c=relaxed/simple;
	bh=lf3gUKAZg+5HWPL/HBuxTOwojliXLX/XwXpqq85sjDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDIpBLCGkSFP634GdQqI8dkZxbEce9aAANgzfcsrPwMBMV8jWelnyhSctmt2BqF0Fj01OMnm4LC2yjcXvovyYfAJzYZ5dnoZSdt5SAioOF3m9HSza4IBrwC8zyamjnZiUaWcsvG02J615TX7z006qXoa6Nw3iwMAWOKNq1drwtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOqJHgg7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88102C113CD;
	Wed, 24 Apr 2024 19:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713985448;
	bh=lf3gUKAZg+5HWPL/HBuxTOwojliXLX/XwXpqq85sjDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AOqJHgg7/rdvu8eCspTWBEqD70ZnfT8SNhnp/IZYYQTTarBB4oqAw/KnEO338S/4f
	 OzZ3G/GoLvNy55uIm6S3UrKwdJEPyvOlC70Cm0tHmxoTvCNpPYMYuodz4HCgYtYzZd
	 yPXWHDKaLmyuhUeADnLTMucGYePF9piKD2Y47rfj7e2tcDPuLP5gjWMwuawWDcQHoM
	 FnVZSdIZEX+3DdyJoySR3+EIBTKiAGXFVoEWpdbESZuuiqkJSXSvB8pQOhtWTbxxtK
	 aUij5Wxps3qvVBIUB+MHizJDaj2O0r/9m1RWN2Vv52tDJX0QkP77TVo+jFk2fUYwC3
	 FukUwxLvHsYFw==
Date: Wed, 24 Apr 2024 12:04:05 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: djakov@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, matthias.bgg@gmail.com, lgirdwood@gmail.com,
	broonie@kernel.org, keescook@chromium.org, gustavoars@kernel.org,
	henryc.chen@mediatek.com, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel@collabora.com,
	wenst@chromium.org, amergnat@baylibre.com,
	Dawei Chien <dawei.chien@mediatek.com>
Subject: Re: [PATCH v5 4/7] soc: mediatek: Add MediaTek DVFS Resource
 Collector (DVFSRC) driver
Message-ID: <20240424190405.GA2803128@dev-arch.thelio-3990X>
References: <20240424095416.1105639-1-angelogioacchino.delregno@collabora.com>
 <20240424095416.1105639-5-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424095416.1105639-5-angelogioacchino.delregno@collabora.com>

Hi Angelo,

On Wed, Apr 24, 2024 at 11:54:13AM +0200, AngeloGioacchino Del Regno wrote:
> The Dynamic Voltage and Frequency Scaling Resource Collector (DVFSRC) is a
> Hardware module used to collect all the requests from both software and the
> various remote processors embedded into the SoC and decide about a minimum
> operating voltage and a minimum DRAM frequency to fulfill those requests in
> an effort to provide the best achievable performance per watt.
> 
> This hardware IP is capable of transparently performing direct register R/W
> on all of the DVFSRC-controlled regulators and SoC bandwidth knobs.
> 
> This driver includes support for MT8183, MT8192 and MT8195.
> 
> Co-Developed-by: Dawei Chien <dawei.chien@mediatek.com>
> [Angelo: Partial refactoring and cleanups]
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
..
>  drivers/soc/mediatek/mtk-dvfsrc.c        | 551 +++++++++++++++++++++++
..
> +#define KBPS_TO_MBPS(x)			((x) / 1000)
..
> +static void __dvfsrc_set_dram_bw_v1(struct mtk_dvfsrc *dvfsrc, u32 reg,
> +				    u16 max_bw, u16 min_bw, u64 bw)
> +{
> +	u32 new_bw = (u32)div_u64(KBPS_TO_MBPS(bw), 100);
> +
> +	/* If bw constraints (in mbps) are defined make sure to respect them */
> +	if (max_bw)
> +		new_bw = min(new_bw, max_bw);
> +	if (min_bw && new_bw > 0)
> +		new_bw = max(new_bw, min_bw);
> +
> +	dvfsrc_writel(dvfsrc, reg, new_bw);
> +}

Using KBPS_TO_MBPS here results in

  ERROR: modpost: "__aeabi_uldivmod" [drivers/soc/mediatek/mtk-dvfsrc.ko] undefined!

when building ARCH=arm allmodconfig with clang. I did not check to see
if this is visible with GCC but if it is not, it is only because GCC
implements certain transformations for constant division that clang may
or may not have implemented (there was some work on getting all
transformations that GCC has supported in clang as well but I do not
think was ever completed). Perhaps KBPS_TO_MBPS() should be dropped and
the new_bw assignement turned into

  u32 new_bw = (u32)div_u64(bw, 100 * 1000); /* Multiply divisor by 1000 to convert bw from Kbps to Mbps */

or something like that.

Cheers,
Nathan

