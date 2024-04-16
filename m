Return-Path: <linux-kernel+bounces-146562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 448C18A6745
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8EFB1F21851
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E153985C68;
	Tue, 16 Apr 2024 09:37:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D498594D;
	Tue, 16 Apr 2024 09:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713260229; cv=none; b=qib9KZe1/9RSe0XB5IexRf+LHalugaNdTIPWpL/eylqpKguVo1w6MI0thBhQ+Ln6Jc+XZRdflFMFyPRdDboPRQWUYI4Sk1cCBunPOl4ZfdZqkRV8xhsFRf4e5YhIvh2vFEcSPPyqFXS/00eKpr/NrzZYtJ3iZLpzxnM1O0obw4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713260229; c=relaxed/simple;
	bh=yBI9KZPzbMre2zuqLdHyFt55ETKgaaVCW0a5Z76vWxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QyhbPXpkEOba6coSfD9Trko56ynUvwsbrq/sFrr/UoY1X32MmboQmP/3EBabPvw13YvKAeJ0U2/a4N+XHrc87pjYVqRpNCokYHkLeaCl3z8TutneTPOqFsfLbXQUxewF0DTam+R1KWcTIXzQW4SLjSzt5gG+e0P+d22xexm+K0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C56EF339;
	Tue, 16 Apr 2024 02:37:35 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B4893F792;
	Tue, 16 Apr 2024 02:37:04 -0700 (PDT)
Message-ID: <d8d5b480-ec59-4fc5-a726-34aec5575a8d@arm.com>
Date: Tue, 16 Apr 2024 10:36:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/30] perf/arm_pmu: Assign parents for event_source
 devices
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org
Cc: linuxarm@huawei.com, Shaokun Zhang <zhangshaokun@hisilicon.com>,
 Yicong Yang <yangyicong@hisilicon.com>, Jiucheng Xu
 <jiucheng.xu@amlogic.com>, Khuong Dinh <khuong@os.amperecomputing.com>,
 Atish Patra <atishp@atishpatra.org>, Anup Patel <anup@brainfault.org>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Frank Li <Frank.li@nxp.com>, Shuai Xue <xueshuai@linux.alibaba.com>,
 Vineet Gupta <vgupta@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Fenghua Yu <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
 linux-fpga@vger.kernel.org, Liang Kan <kan.liang@linux.intel.com>
References: <20240412161057.14099-1-Jonathan.Cameron@huawei.com>
 <20240412161057.14099-17-Jonathan.Cameron@huawei.com>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20240412161057.14099-17-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/04/2024 17:10, Jonathan Cameron wrote:
> Currently the PMU device appears directly under /sys/devices/
> Only root busses should appear there, so instead assign the pmu->dev
> parent to be the platform device.
> 
> Link: https://lore.kernel.org/linux-cxl/ZCLI9A40PJsyqAmq@kroah.com/
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   drivers/perf/arm_pmu_platform.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/perf/arm_pmu_platform.c b/drivers/perf/arm_pmu_platform.c
> index 3596db36cbff..4b1a9a92ea11 100644
> --- a/drivers/perf/arm_pmu_platform.c
> +++ b/drivers/perf/arm_pmu_platform.c
> @@ -196,6 +196,7 @@ int arm_pmu_device_probe(struct platform_device *pdev,
>   	if (!pmu)
>   		return -ENOMEM;
>   
> +	pmu->pmu.parent = &pdev->dev;
>   	pmu->plat_device = pdev;
>   
>   	ret = pmu_parse_irqs(pmu);


Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>


