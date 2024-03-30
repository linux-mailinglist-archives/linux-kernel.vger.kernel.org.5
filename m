Return-Path: <linux-kernel+bounces-125756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17050892BB8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 16:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74AC7B223F6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 15:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453E93985A;
	Sat, 30 Mar 2024 15:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="bCb7qoaX"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCA4381AD;
	Sat, 30 Mar 2024 15:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711810883; cv=none; b=kzxRggpSMd24NcVUnOdbQCZofSslYsOyZrJR4HFyJSGGcqWc3tcIWX/SHKlhrjTAr6c4qBcWHToIG+QKcpdA9lKny0FFm5jUiacZYN8vaCHAzYdsU0eXJN1ZmIdNiISMIghFpUSYFVQH8Pz1ty6Qp06eCDhHcBgOPMfQ9AmsM2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711810883; c=relaxed/simple;
	bh=UpG0pNNz0UCVWmvsbXQVEXQ/6mDrx9jEGm5zWGOIxjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hg3BAM+zunznsWxTztvFVo/IeWIT+Oz8o0KXw/AawnpYKU92Hg6FO/zz4tUxj+n5NtUxXChj9Mr8glBVELqlXHXfp9TIwFlZRk5EIuegbeQXh+8Y9msKqbU22E5SnJSMsBxzRdB4uk7vrlZ2eBj9rn0XIpIQBQxht86JUapuCJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=bCb7qoaX; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=RxaF8TkWhlnlwjvCnhKUHNDn2G5e8bYdQQRjBXH51b4=;
	b=bCb7qoaX1TiksdYOCBMLdtpivJtTEZUjgH/6t1P10j/QZn8Sux/X9hnm7cAuyL
	ww7e/gO2panbHn4YEWLFloIEDxhQOYQ+xnGlE0M0jD4H4dP0XTssOzeRaqTMQ7we
	eashzqvYmSSYyfSpFBGXRnf5+uVbyxKUgXes4v4aE3+N0=
Received: from dragon (unknown [183.213.196.225])
	by smtp2 (Coremail) with SMTP id C1UQrAD3X4TPKAhm88N4Ag--.46810S3;
	Sat, 30 Mar 2024 22:59:29 +0800 (CST)
Date: Sat, 30 Mar 2024 22:59:27 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	x86@kernel.org, linux-perf-users@vger.kernel.org,
	jialong.yang@shingroup.cn, Russell King <linux@armlinux.org.uk>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 10/10] ARM: Use common uncore PMU capabilities
Message-ID: <Zggoz46PSlCN5Bt+@dragon>
References: <cover.1710257512.git.robin.murphy@arm.com>
 <de2646ca1d333cd9286f22ed3a5e8d57d22833b1.1710257512.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de2646ca1d333cd9286f22ed3a5e8d57d22833b1.1710257512.git.robin.murphy@arm.com>
X-CM-TRANSID:C1UQrAD3X4TPKAhm88N4Ag--.46810S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxCFW8CF4xAw13ArykGr4fAFb_yoW5Xry3p3
	4xAwnIyF10gw17Xas8AF4qv3WFvwnYgrWqqw15ua4Fvw10k3y3XF1UKw1rZw15JFW8Aw4I
	yw10vFWUZ34UZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jwwIDUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiFRGxZV6NnBG+IQAAsR

On Tue, Mar 12, 2024 at 05:34:12PM +0000, Robin Murphy wrote:
> Switch the ARM system PMU drivers over to the new common capabilities,
> allowing to remove all the checks that perf core now takes care of.
> 
> CC: Russell King <linux@armlinux.org.uk>
> CC: Shawn Guo <shawnguo@kernel.org>
> CC: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  arch/arm/mach-imx/mmdc.c     | 16 +---------------

Acked-by: Shawn Guo <shawnguo@kernel.org>

>  arch/arm/mm/cache-l2x0-pmu.c | 12 +-----------
>  2 files changed, 2 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
> index 444a7eaa320c..806ab6675b37 100644
> --- a/arch/arm/mach-imx/mmdc.c
> +++ b/arch/arm/mach-imx/mmdc.c
> @@ -280,20 +280,6 @@ static int mmdc_pmu_event_init(struct perf_event *event)
>  	struct mmdc_pmu *pmu_mmdc = to_mmdc_pmu(event->pmu);
>  	int cfg = event->attr.config;
>  
> -	if (event->attr.type != event->pmu->type)
> -		return -ENOENT;
> -
> -	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
> -		return -EOPNOTSUPP;
> -
> -	if (event->cpu < 0) {
> -		dev_warn(pmu_mmdc->dev, "Can't provide per-task data!\n");
> -		return -EOPNOTSUPP;
> -	}
> -
> -	if (event->attr.sample_period)
> -		return -EINVAL;
> -
>  	if (cfg < 0 || cfg >= MMDC_NUM_COUNTERS)
>  		return -EINVAL;
>  
> @@ -445,7 +431,7 @@ static int mmdc_pmu_init(struct mmdc_pmu *pmu_mmdc,
>  			.start          = mmdc_pmu_event_start,
>  			.stop           = mmdc_pmu_event_stop,
>  			.read           = mmdc_pmu_event_update,
> -			.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
> +			.capabilities	= PERF_PMU_UNCORE_CAPS,
>  		},
>  		.mmdc_base = mmdc_base,
>  		.dev = dev,
> diff --git a/arch/arm/mm/cache-l2x0-pmu.c b/arch/arm/mm/cache-l2x0-pmu.c
> index 993fefdc167a..a2567d953fdb 100644
> --- a/arch/arm/mm/cache-l2x0-pmu.c
> +++ b/arch/arm/mm/cache-l2x0-pmu.c
> @@ -295,16 +295,6 @@ static int l2x0_pmu_event_init(struct perf_event *event)
>  {
>  	struct hw_perf_event *hw = &event->hw;
>  
> -	if (event->attr.type != l2x0_pmu->type)
> -		return -ENOENT;
> -
> -	if (is_sampling_event(event) ||
> -	    event->attach_state & PERF_ATTACH_TASK)
> -		return -EINVAL;
> -
> -	if (event->cpu < 0)
> -		return -EINVAL;
> -
>  	if (event->attr.config & ~L2X0_EVENT_CNT_CFG_SRC_MASK)
>  		return -EINVAL;
>  
> @@ -524,7 +514,7 @@ static __init int l2x0_pmu_init(void)
>  		.del = l2x0_pmu_event_del,
>  		.event_init = l2x0_pmu_event_init,
>  		.attr_groups = l2x0_pmu_attr_groups,
> -		.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
> +		.capabilities = PERF_PMU_UNCORE_CAPS,
>  	};
>  
>  	l2x0_pmu_reset();
> -- 
> 2.39.2.101.g768bb238c484.dirty
> 


