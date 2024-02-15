Return-Path: <linux-kernel+bounces-66721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAD38560A5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7B381F21EA7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267DD13172F;
	Thu, 15 Feb 2024 10:55:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00423131724;
	Thu, 15 Feb 2024 10:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707994537; cv=none; b=EqHYBCkYC9FoXMWnlGfRQRKoYq0aA6P3Uuubh/EeINkQho0xWfcesiGbrXYkwjexCkzm73qq5fRp1lgH1wjXXu+ah9db1s8SpJhL3L9olBPwgLmrVLVCkq4kMTjB7IDNWZ8TkGEhOtnHNM2Wp5wdEcy8CaA9g5FVXkim6jbk4Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707994537; c=relaxed/simple;
	bh=LoA5sWoZO8pD3VB5bo+8CWwWCpCXLeSRWHC2fiM65fI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GHrzApZdQ5WN1tU9h9doGauw6eMYZE8DEJyJMNlKC6D4vX3l/eTLBUitNVYC9xc1JfqCESJ9Xt6lu/h0ncUvU+VOK/HiZqnWHMa4h1aZE3tteKe3Rzedmpppsq1TAOu/MLLkJvvnUMEsgke0X6X2/8XU45LdaGklTcTWqP2UoFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2108D1FB;
	Thu, 15 Feb 2024 02:56:16 -0800 (PST)
Received: from [10.57.49.250] (unknown [10.57.49.250])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AABD83F7B4;
	Thu, 15 Feb 2024 02:55:33 -0800 (PST)
Message-ID: <56d56f85-6172-4fb1-a002-fe82ffc8a66a@arm.com>
Date: Thu, 15 Feb 2024 10:55:32 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 02/11] coresight: stm: Extract device name from AMBA
 pid based table lookup
Content-Language: en-GB
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Mike Leach <mike.leach@linaro.org>,
 James Clark <james.clark@arm.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20240123054608.1790189-1-anshuman.khandual@arm.com>
 <20240123054608.1790189-3-anshuman.khandual@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20240123054608.1790189-3-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/01/2024 05:45, Anshuman Khandual wrote:
> Instead of using AMBA private data field, extract the device name from AMBA
> pid based table lookup using new coresight_get_uci_data_from_amba() helper.
> 
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: James Clark <james.clark@arm.com>
> Cc: coresight@lists.linaro.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-stm32@st-md-mailman.stormreply.com
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-priv.h | 10 ++++++++++
>   drivers/hwtracing/coresight/coresight-stm.c  | 14 +++++++++++++-
>   2 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index 767076e07970..68cbb036cec8 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> @@ -221,6 +221,16 @@ static inline void *coresight_get_uci_data(const struct amba_id *id)
>   	return uci_id->data;
>   }
>   
> +static inline void *coresight_get_uci_data_from_amba(const struct amba_id *table, u32 pid)
> +{
> +	while (table->mask) {
> +		if ((table->id & table->mask) == pid)

Why are we masking table->id ? table->id is a static value that the
driver wants to check for "variants" of a given device. The table->mask
is there to filter out the "irrelevant" bits of the PID that we read
from the device. So this should instead be:

		if ((table->mask & pid) == table->id)

> +			return coresight_get_uci_data(table);
> +		table++;
> +	};
> +	return NULL;
> +}
> +
>   void coresight_release_platform_data(struct coresight_device *csdev,
>   				     struct device *dev,
>   				     struct coresight_platform_data *pdata);
> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> index a1c27c901ad1..9cdca4f86cab 100644
> --- a/drivers/hwtracing/coresight/coresight-stm.c
> +++ b/drivers/hwtracing/coresight/coresight-stm.c
> @@ -804,6 +804,18 @@ static void stm_init_generic_data(struct stm_drvdata *drvdata,
>   	drvdata->stm.set_options = stm_generic_set_options;
>   }
>   
> +#define STM_AMBA_MASK 0xfffff
> +
> +static const struct amba_id stm_ids[];
> +
> +static char *stm_csdev_name(struct coresight_device *csdev)
> +{
> +	u32 stm_pid = coresight_get_pid(&csdev->access) & STM_AMBA_MASK;

Similar to above:

Why do we apply a "custom" mask to the PID and later check the PID with
that of the table->pid.

The way it is supposed work is :

	(table->mask & dev_pid) == table->pid

the table->mask is there for a reason: i.e., to get the relevant bits 
from the device_pid and compare it against "the" expected value 
(table->pid).


Suzuki

> +	void *uci_data = coresight_get_uci_data_from_amba(stm_ids, stm_pid);
> +
> +	return uci_data ? (char *)uci_data : "STM";
> +}
> +
>   static int stm_probe(struct amba_device *adev, const struct amba_id *id)
>   {
>   	int ret, trace_id;
> @@ -900,7 +912,7 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
>   	pm_runtime_put(&adev->dev);
>   
>   	dev_info(&drvdata->csdev->dev, "%s initialized\n",
> -		 (char *)coresight_get_uci_data(id));
> +		 stm_csdev_name(drvdata->csdev));
>   	return 0;
>   
>   cs_unregister:


