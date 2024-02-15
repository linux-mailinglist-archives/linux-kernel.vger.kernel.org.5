Return-Path: <linux-kernel+bounces-66536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11031855E0A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4439D1C21466
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A0117585;
	Thu, 15 Feb 2024 09:27:18 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0ACF1BC26;
	Thu, 15 Feb 2024 09:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989238; cv=none; b=iHjkZZsj1SryQP5sLm0HiWTrV12rIbquNwYs3zly83z3esQ7Z08Mkle95krydRjNdxPNayFV6xrMqk8TSxjlmTVX+KTFzjY5KXn+w7Dl2z1GX9iaJMT6NGD8Pnl9jzYCqBe7CRxTQ10k9X4eKVvEOdjsGfLZinvr44W3eF3MH0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989238; c=relaxed/simple;
	bh=JdUXTgfRhqmsxEasxutphA+qDVTuj0FX7QgjojjkOfI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q4nWIfeD0fAZDv+xiGt6jzC4FuvIX3ZtA+zgsu9pHsZxRQ/Pis27AInj0hvDUh/2eVFHrbPI2PnrnzWLhzJPnj+2wuqIwI9V5WfW5yTcwf8OY+ntHgejcjF7zavJz30KqtjSn2teJ44737K949PkT95OqpHGHcCmM95j05tMyh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tb8k74NXPz6J9hM;
	Thu, 15 Feb 2024 17:23:11 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 8FAD91400D4;
	Thu, 15 Feb 2024 17:27:13 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 09:27:13 +0000
Date: Thu, 15 Feb 2024 09:27:12 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Hojin Nam <hj96.nam@samsung.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Wonjae Lee
	<wj28.lee@samsung.com>, KyungSan Kim <ks0204.kim@samsung.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "will@kernel.org" <will@kernel.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: Re: [PATCH v2] perf: CXL: fix CPMU filter value mask length
Message-ID: <20240215092712.000048cd@Huawei.com>
In-Reply-To: <20240215080906epcms2p2c49c6b9bfe271e1d089ad35ab527b958@epcms2p2>
References: <CGME20240215080906epcms2p2c49c6b9bfe271e1d089ad35ab527b958@epcms2p2>
	<20240215080906epcms2p2c49c6b9bfe271e1d089ad35ab527b958@epcms2p2>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 15 Feb 2024 17:09:06 +0900
Hojin Nam <hj96.nam@samsung.com> wrote:

> CPMU filter value is described as 4B length in CXL r3.0 8.2.7.2.2.
> However, it is used as 2B length in code and comments.
> 
> Signed-off-by: Hojin Nam <hj96.nam@samsung.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks for tidying this up.

> ---
> 
> Hi Jonathan,
> as you said, I didn't actually hit this. I just found it by simply
> comparing the code to the CXL Spec. I removed Fixes tag and 
> repaired broken sign off, Thank you!
> 
> Changes since v1:
> - Remove Fixes tag (Jonathan)
> - Repair broken sign off (Jonathan)
> 
>  drivers/perf/cxl_pmu.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index 365d964b0f6a..ca5e92f28b4a 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -59,7 +59,7 @@
>  #define   CXL_PMU_COUNTER_CFG_EVENT_GRP_ID_IDX_MSK     GENMASK_ULL(63, 59)
> 
>  #define CXL_PMU_FILTER_CFG_REG(n, f)   (0x400 + 4 * ((f) + (n) * 8))
> -#define   CXL_PMU_FILTER_CFG_VALUE_MSK                 GENMASK(15, 0)
> +#define   CXL_PMU_FILTER_CFG_VALUE_MSK                 GENMASK(31, 0)
> 
>  #define CXL_PMU_COUNTER_REG(n)         (0xc00 + 8 * (n))
> 
> @@ -314,9 +314,9 @@ static bool cxl_pmu_config1_get_edge(struct perf_event *event)
>  }
> 
>  /*
> - * CPMU specification allows for 8 filters, each with a 16 bit value...
> - * So we need to find 8x16bits to store it in.
> - * As the value used for disable is 0xffff, a separate enable switch
> + * CPMU specification allows for 8 filters, each with a 32 bit value...
> + * So we need to find 8x32bits to store it in.
> + * As the value used for disable is 0xffff_ffff, a separate enable switch
>   * is needed.
>   */
> 
> @@ -642,7 +642,7 @@ static void cxl_pmu_event_start(struct perf_event *event, int flags)
>                 if (cxl_pmu_config1_hdm_filter_en(event))
>                         cfg = cxl_pmu_config2_get_hdm_decoder(event);
>                 else
> -                       cfg = GENMASK(15, 0); /* No filtering if 0xFFFF_FFFF */
> +                       cfg = GENMASK(31, 0); /* No filtering if 0xFFFF_FFFF */
>                 writeq(cfg, base + CXL_PMU_FILTER_CFG_REG(hwc->idx, 0));
>         }
> 
> --
> 2.34.1


