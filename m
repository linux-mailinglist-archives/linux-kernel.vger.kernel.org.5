Return-Path: <linux-kernel+bounces-57885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FE284DE9D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87EE01C26357
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A216DCEC;
	Thu,  8 Feb 2024 10:50:54 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8E23399F
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 10:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707389453; cv=none; b=leQ9kkStNpBDWMrKnE5x5MgjZ4QoAw3TtK3PicKVVirjRcS3qvqNR340GraJN68Pg8zQu7oT5fZOPGxrDa7xghevRoYTw7H6vYdqA8hpoGDvREDU09nFl7ecoUdQbv+e+SoRvfuwzyU/9u7vmWyEs9dHHph5js2KQVq2H4/MC80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707389453; c=relaxed/simple;
	bh=/PSBCDalkGpt8rR1NUbQW00MuwRTUbAdd2X4QSlT568=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q4+4eI8tXq5XshUWrq8zYKHmFgEhSbdVJ/GYt9r6eOm9rwzpTlH0PaVeRcfj7THxRJ0NiXb3BfgqRjlJBff1+duTygVQQcrqhu4pIwX0iaRfYF6+xi5ZZ7gftuh+hRyUMVDmKdPaUMySgoGFSIvgBh7J9sqXV8na9kO+UaCcYRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TVtwg0HC7z6K8yL;
	Thu,  8 Feb 2024 18:47:31 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id DCC94140595;
	Thu,  8 Feb 2024 18:50:48 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 8 Feb
 2024 10:50:48 +0000
Date: Thu, 8 Feb 2024 10:50:47 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Junhao He <hejunhao3@huawei.com>
CC: <will@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
	<yangyicong@huawei.com>, <prime.zeng@hisilicon.com>
Subject: Re: [PATCH] drivers/perf: hisi: Enable HiSilicon Erratum 162700402
 quirk for UC PMU
Message-ID: <20240208105047.000023c7@Huawei.com>
In-Reply-To: <20240207094245.34195-1-hejunhao3@huawei.com>
References: <20240207094245.34195-1-hejunhao3@huawei.com>
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
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 7 Feb 2024 17:42:45 +0800
Junhao He <hejunhao3@huawei.com> wrote:

> HiSilicon UC PMU v2 suffers the erratum 162700402 that the PMU counter
> cannot be set due to the lack of clock under power saving mode. This will
> lead to error or inaccurate counts. The clock can be enabled by the PMU
> global enabling control.
> 
> This patch tries to fix this by set the UC PMU enable before set event
> period to turn on the clock, and then restore the UC PMU configuration.
> The counter register can hold its value without a clock.
> 
> Signed-off-by: Junhao He <hejunhao3@huawei.com>

Hi.

Some very minor comments about the comments inline.

Jonathan

> ---
>  drivers/perf/hisilicon/hisi_uncore_uc_pmu.c | 40 ++++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/hisilicon/hisi_uncore_uc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_uc_pmu.c
> index 636fb79647c8..8e7a9e1f419a 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_uc_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_uncore_uc_pmu.c
> @@ -287,10 +287,48 @@ static u64 hisi_uc_pmu_read_counter(struct hisi_pmu *uc_pmu,
>  	return readq(uc_pmu->base + HISI_UC_CNTR_REGn(hwc->idx));
>  }
>  
> -static void hisi_uc_pmu_write_counter(struct hisi_pmu *uc_pmu,
> +static bool hisi_uc_pmu_get_glb_en_state(struct hisi_pmu *uc_pmu)
> +{
> +	u32 val;
> +
> +	val = readl(uc_pmu->base + HISI_UC_EVENT_CTRL_REG);
> +	return !!FIELD_GET(HISI_UC_EVENT_GLB_EN, val);
> +}
> +
> +static void hisi_uc_pmu_write_counter_quirk_hip09(struct hisi_pmu *uc_pmu,
>  				      struct hw_perf_event *hwc, u64 val)
>  {
> +	bool enable = hisi_uc_pmu_get_glb_en_state(uc_pmu);
> +
> +	/* Set the UC PMU enable to turn on the clock. */

Comment from below here but adjusted to say which path has the device
already enabled.

> +	if (!enable)
> +		hisi_uc_pmu_start_counters(uc_pmu);
> +
>  	writeq(val, uc_pmu->base + HISI_UC_CNTR_REGn(hwc->idx));
> +
> +	/*
> +	 * The counter register can hold its value without a clock. We need
> +	 * restore the UC PMU configuration. The irq handler will also call
> +	 * the function to set period. At this time, PMU is still enabled and
> +	 * we cannot directly disable the PMU.
I think the comment is more relevant above...
> +	 */
> +	if (!enable)
> +		hisi_uc_pmu_stop_counters(uc_pmu);
> +}
> +
> +static void hisi_uc_pmu_write_counter(struct hisi_pmu *uc_pmu,
> +				      struct hw_perf_event *hwc, u64 val)
> +{
> +	/*
> +	 * HiSilicon UC PMU v2 suffers the erratum 162700402 that the PMU
> +	 * counter cannot be set due to the lack of clock under power saving
> +	 * mode. This will lead to error or inaccurate counts. The clock can
> +	 * be enabled by the PMU global enabling control.

I'd move the comment to next to the quirk function so that people can immediately
see what is being done.  Down here we just need to know there is a quirk.

> +	 */
> +	if (uc_pmu->identifier == HISI_PMU_V2)
> +		hisi_uc_pmu_write_counter_quirk_hip09(uc_pmu, hwc, val);
> +	else
> +		writeq(val, uc_pmu->base + HISI_UC_CNTR_REGn(hwc->idx));
>  }
>  
>  static void hisi_uc_pmu_enable_counter_int(struct hisi_pmu *uc_pmu,


