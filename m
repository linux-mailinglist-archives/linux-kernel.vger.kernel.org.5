Return-Path: <linux-kernel+bounces-145390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 392EB8A559E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8C911F22909
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33F674E37;
	Mon, 15 Apr 2024 14:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWrs5fKI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB853679E5;
	Mon, 15 Apr 2024 14:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713192777; cv=none; b=nfQsGIXZk/KcRzhHspHbElF6AeBCMLJ78zbuvexALqpuJMnIjLKlE95NvxWkrgom2dNX+Q7RVemoMzcai04bXAHsO7BhIYl1neZSXCgJ5jhXNBQrpELlmYxTMYBWK/N+A8GZ0ctLurRNZ2Qza/GbHXw/gQmcXMjJbZj6Y8e7p6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713192777; c=relaxed/simple;
	bh=NhbAtc6tAGccokWSTjoKOMtgLuAbLGDa8a3OfLwV230=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLodLUgG5tV921jANIqjXwrZDqPDNMwnbtc448V9clnxuI5aV09SoRzAK/OxOvxDpzQLMJha6fGGYK89u9eWEbWCpydwXO/5Oqr23wiTNyRxvxKF3K/fFFBF8rDU8VOti+wLxyK2+syr3bfGEKnPervk9hUUQYUYli0HtEqL2wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWrs5fKI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267E2C113CC;
	Mon, 15 Apr 2024 14:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713192776;
	bh=NhbAtc6tAGccokWSTjoKOMtgLuAbLGDa8a3OfLwV230=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PWrs5fKIlnzoyDAUHDWP4Y/Pvl09ehPKzlzipssc5llEgsM4XodZX0woW/NTST5B0
	 B03GQhlkgJcyHjeYjkF3SyUa20g6XEuS8KiTh2nzLYc3Gze0gL4BErAp+FmCxJDLqi
	 bvUg4CwKXnhE2lYPOVePRzcbQQ8MsTc1venCKXnd1OzvhSY+Hnj1xlWlPSkFUF+Jvi
	 bUpSa71+FXCgHH2/wOsYHf8ByDStbIrmopHRqOwEf0qZSD6UPlNaOMa+5qLAXv2G6P
	 0KWdSBJRQ3odCtfC+CFjNz5OBy/p8Co9ZLQ0bETvoKnFjr2C56WASlvyOKZAExb91o
	 UjHI3ixedmu6Q==
Date: Mon, 15 Apr 2024 15:52:48 +0100
From: Simon Horman <horms@kernel.org>
To: Yi-De Wu <yi-de.wu@mediatek.com>
Cc: Yingshiuan Pan <yingshiuan.pan@mediatek.com>,
	Ze-Yu Wang <ze-yu.wang@mediatek.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
	David Bradil <dbrazdil@google.com>,
	Trilok Soni <quic_tsoni@quicinc.com>,
	My Chuang <my.chuang@mediatek.com>,
	Shawn Hsiao <shawn.hsiao@mediatek.com>,
	PeiLun Suei <peilun.suei@mediatek.com>,
	Liju Chen <liju-clr.chen@mediatek.com>,
	Willix Yeh <chi-shen.yeh@mediatek.com>,
	Kevenny Hsieh <kevenny.hsieh@mediatek.com>
Subject: Re: [PATCH v10 15/21] virt: geniezone: Add demand paging support
Message-ID: <20240415145248.GD2320920@kernel.org>
References: <20240412065718.29105-1-yi-de.wu@mediatek.com>
 <20240412065718.29105-16-yi-de.wu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412065718.29105-16-yi-de.wu@mediatek.com>

On Fri, Apr 12, 2024 at 02:57:12PM +0800, Yi-De Wu wrote:
> From: "Yingshiuan Pan" <yingshiuan.pan@mediatek.com>
> 
> This page fault handler helps GenieZone hypervisor to do demand paging.
> On a lower level translation fault, GenieZone hypervisor will first
> check the fault GPA (guest physical address or IPA in ARM) is valid
> e.g. within the registered memory region, then it will setup the
> vcpu_run->exit_reason with necessary information for returning to
> gzvm driver.
> 
> With the fault information, the gzvm driver looks up the physical
> address and call the MT_HVC_GZVM_MAP_GUEST to request the hypervisor
> maps the found PA to the fault GPA (IPA).
> 
> There is one exception, for protected vm, we will populate full VM's
> memory region in advance in order to improve performance.
> 
> Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
> Signed-off-by: Jerry Wang <ze-yu.wang@mediatek.com>
> Signed-off-by: kevenny hsieh <kevenny.hsieh@mediatek.com>
> Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
> Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>

..

> diff --git a/drivers/virt/geniezone/gzvm_exception.c b/drivers/virt/geniezone/gzvm_exception.c
> new file mode 100644
> index 000000000000..475bc15b0689
> --- /dev/null
> +++ b/drivers/virt/geniezone/gzvm_exception.c
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 MediaTek Inc.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/soc/mediatek/gzvm_drv.h>
> +
> +/**
> + * gzvm_handle_guest_exception() - Handle guest exception
> + * @vcpu: Pointer to struct gzvm_vcpu_run in userspace
> + * Return:
> + * * true - This exception has been processed, no need to back to VMM.
> + * * false - This exception has not been processed, require userspace.
> + */
> +bool gzvm_handle_guest_exception(struct gzvm_vcpu *vcpu)

Hi Yi-De Wu,

The return type is bool, however the function actually
returns either a bool or signed int.

I think that either:

1. The return type should be changed to int,
   and returning true and false should be updated.

2. The function should always return true or false.

Flagged by Smatch.

> +{
> +	int ret;
> +
> +	for (int i = 0; i < ARRAY_SIZE(vcpu->run->exception.reserved); i++) {
> +		if (vcpu->run->exception.reserved[i])
> +			return -EINVAL;
> +	}
> +
> +	switch (vcpu->run->exception.exception) {
> +	case GZVM_EXCEPTION_PAGE_FAULT:
> +		ret = gzvm_handle_page_fault(vcpu);
> +		break;
> +	case GZVM_EXCEPTION_UNKNOWN:
> +		fallthrough;
> +	default:
> +		ret = -EFAULT;
> +	}
> +
> +	if (!ret)
> +		return true;
> +	else
> +		return false;
> +}

..

