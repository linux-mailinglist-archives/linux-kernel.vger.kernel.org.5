Return-Path: <linux-kernel+bounces-88416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8AA86E14D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 831821F21AA4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970526A329;
	Fri,  1 Mar 2024 12:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="17zvLga4"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED15742AB5;
	Fri,  1 Mar 2024 12:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709297249; cv=none; b=H4qK/FX09nyWMjwFWQnJ0AqaETI2yHeNEnowxlIdDsh5OKfcy6RRyAL9zV+95wro069XxbDvHo42dOKnsHC8FnrSHRVJh8wf8VxBJjcQG2WmOqiwuoF5+oe2LpLATawIKOvRQkFPwDweIWF11cfgqrj8JX5BCyY6JkGuvICUp1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709297249; c=relaxed/simple;
	bh=hA0oxwD27gd74f5RciQ0gAwJyLc3AOc6ENazGRzlsA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cfoZjahUq3l+yScVLWlGSno08DbXOeYGdDERBlcJ3z1pJEVixW6p3YbuDYKQLy9YWBMucRCacQyQUAJUy/jRI8W/SQVQl5yOWe1FIflkZRiPXKhsQCvqz89JFuI7XYxV4XXKP505uG4YnQ42v57/v1yTVSG9pjOwPVvgyV/iy5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=17zvLga4; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe0c3c.dip0.t-ipconnect.de [79.254.12.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id B32031C2C89;
	Fri,  1 Mar 2024 13:47:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1709297243;
	bh=hA0oxwD27gd74f5RciQ0gAwJyLc3AOc6ENazGRzlsA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=17zvLga4k0NTgX7vMeySb0BST/85bdOAY7Tbmc6qXLWdcX5iiVdGYAFNMGHwTHhaD
	 283fe6n+XYrQ/bHfCjsAfEvCK0QPphrx/G0/uJLueU+GPWo0u0fURkWHAClQ45C9uI
	 uIvO1RmSja0KtwTEwIzL5JJM9GJ/LcAvmkyaz6Qi9DbfkNzr9uSWNtRbOriy+5pRPV
	 2gQtzJ+O2Br8Ta3rRxwqFFTiug2NvFzLQFRpROnF95KN8tzg5yj5MpDAvgx2Dm/psw
	 sDfN2jQw/qIHXKrhff0JF5WdLh5syukwy7nwIhemdPGPS4RXoyorYt7ID45BQAFQpD
	 VrRA+CYGCvnTg==
Date: Fri, 1 Mar 2024 13:47:21 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Rob Clark <robdclark@gmail.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Yong Wu <yong.wu@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Heiko Stuebner <heiko@sntech.de>, Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH 1/4] iommu: constify pointer to bus_type
Message-ID: <ZeHOWXuNLhQlSrxM@8bytes.org>
References: <20240216144027.185959-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216144027.185959-1-krzysztof.kozlowski@linaro.org>

On Fri, Feb 16, 2024 at 03:40:24PM +0100, Krzysztof Kozlowski wrote:

Applied all, thanks.

