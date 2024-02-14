Return-Path: <linux-kernel+bounces-65174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08608548E5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76F9828CAAC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A461B7EA;
	Wed, 14 Feb 2024 12:06:38 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142581AADC;
	Wed, 14 Feb 2024 12:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707912398; cv=none; b=Jc36pbIybtP+yxlnU6NAhNtj7pAjMI7mj4+WvDqa05wH8Mq/18YyY0vidcfss/qdz0jZMz8qA7d5wnTxuyxjH9s5uD5u1RZb0fil43ROgyM09/w9iDhNHNK1vWUPmfXxrFl69lSH1WRuSb0C8R6fWkN6Yjp+Z599fpbcberwc3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707912398; c=relaxed/simple;
	bh=OpGJVKdC/fGBc82A/zCyqry22fkLQp5s0JfMov9Hylk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SxeziULUw32uvUrMGONhPD4uZK+CyhzEqotbaQw4VY3h5Inakrx1vGp5Dcn6HQNY0ogPfMfI8ZAQG/NPoAnEjT9s5ISyMZLvZMY+MxQJea+j24UYrunB7wTatjmmsK/8IJA0FH+rsv5Whf5h95pK1Cz4Ug2wAEu26qRgFgXuwfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TZcJg0NPWz6D8X1;
	Wed, 14 Feb 2024 20:02:43 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 3591F1402CD;
	Wed, 14 Feb 2024 20:06:09 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 12:06:08 +0000
Date: Wed, 14 Feb 2024 12:06:07 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Hojin Nam <hj96.nam@samsung.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Wonjae Lee
	<wj28.lee@samsung.com>, KyungSan Kim <ks0204.kim@samsung.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "will@kernel.org" <will@kernel.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: Re: [PATCH] perf: CXL: fix CPMU filter value mask length
Message-ID: <20240214120607.00002bdd@Huawei.com>
In-Reply-To: <20240214045214epcms2p81d2ea826483fb4aecf19930f2755d55b@epcms2p8>
References: <CGME20240214045214epcms2p81d2ea826483fb4aecf19930f2755d55b@epcms2p8>
	<20240214045214epcms2p81d2ea826483fb4aecf19930f2755d55b@epcms2p8>
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
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 14 Feb 2024 13:52:14 +0900
Hojin Nam <hj96.nam@samsung.com> wrote:

> CPMU filter value is described as 4B length in CXL r3.0 8.2.7.2.2.
> However, it is used as 2B length in code and comments.
> 
> Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
> Signed-off-by: Hojin Nam
Sign off broken.

I have my suspicions about why this is the case (bit of history involved
that I won't go into) but indeed this is wrong. So with SoB fixed.

However, I think the driver only supports HDM filtering currently so
you can't actually hit this. Hence not sure the fixes tag is
appropriate. If you can hit this limitation please post the command.

Worth noting that we still don't have a way to attach this to
switch USPs or host bridges, so the increase in HDM decoders to 32 for
those in r3.1 isn't yet relevant.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
 
> ---
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


