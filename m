Return-Path: <linux-kernel+bounces-142465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A918A2BE9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AAE81F241A3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6969954FAC;
	Fri, 12 Apr 2024 10:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="ic/stN0y"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD75754BF7
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 10:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712916310; cv=none; b=qI+rAQyBzn4B3ZNNXUs/9zgJt3HpJ2wuov7TC8+T6LgeRUXCV9DMIosOceXOxdmttUjwddFNGhchGMVwnXs4kWVp4/xWGkjrO354qJFw73C4wLngBr8SuArbOxYS+REGasHXuAbfMHvaD9WLbkGZLEVPO0gcA2jHOayZRHLekYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712916310; c=relaxed/simple;
	bh=cnwn92O/aPD8VcGrVVyUI2Ec0rIsBja+Z57i++X8koc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbcKck+wINtVmkO5bIcR6AiQjyD/YrURXSKpka6imE4M4sVq/lrdhT9Zqu232c7RKPU8uk2tjauck47Jlo+ZmjEAoSF0+RMao/FnZEnCnC6GkafjyA3zRBOO994cj9jAbcfcZtO8D4V4L959+k8kNvOefQ2soY0q/DnzKvJyO1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=ic/stN0y; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe0bdf.dip0.t-ipconnect.de [79.254.11.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id E632B281A38;
	Fri, 12 Apr 2024 12:05:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1712916308;
	bh=cnwn92O/aPD8VcGrVVyUI2Ec0rIsBja+Z57i++X8koc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ic/stN0y2+5Xrx0L17IZc3CGfAvF5YONhO/Wi2KQgna8jhEm38FzziU/YUKg+d4qu
	 3XQHBV0FSZDR1ieSDOnA+gUG2vXlE0mxrbYcmwB8XE5jnIRaaAyUUKv4INTZDFLRjg
	 zVr7+UeeWSzO9A1EIT1nV6CeAHm7XGO29yI/Ynj1Ll2snh21wYYuSyuZk00kv2nomS
	 gbZSPB06UHAOTxkEOBdtrIv1x0K0nIuR+u2KpVOJGM/7j06JgjEbq9skkM2ufK/rOC
	 J1NM9kGxBrpEP/8jOJD0tAUW1X4VbsiIjlZFA/++epaTdxBqCsvqyjeuHB959u2tP0
	 4G2r5MKjyI/NQ==
Date: Fri, 12 Apr 2024 12:05:06 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Yong Wu <yong.wu@mediatek.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] iommu: mtk: fix module autoloading
Message-ID: <ZhkHUnXcGxbiqSFz@8bytes.org>
References: <20240410164109.233308-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410164109.233308-1-krzk@kernel.org>

On Wed, Apr 10, 2024 at 06:41:09PM +0200, Krzysztof Kozlowski wrote:
> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
> based on the alias from of_device_id table.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/iommu/mtk_iommu.c    | 1 +
>  drivers/iommu/mtk_iommu_v1.c | 1 +
>  2 files changed, 2 insertions(+)

Applied, thanks.

