Return-Path: <linux-kernel+bounces-20719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD95828419
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F04F6B23DF0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49712364BA;
	Tue,  9 Jan 2024 10:38:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AA23609D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 10:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E4B7C15;
	Tue,  9 Jan 2024 02:39:25 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E39A3F73F;
	Tue,  9 Jan 2024 02:38:38 -0800 (PST)
Message-ID: <01c15dbe-57d3-4aa1-9d68-81a01ec2a3a7@arm.com>
Date: Tue, 9 Jan 2024 10:38:36 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] coresight: Remove unused stubs
Content-Language: en-US
To: James Clark <james.clark@arm.com>, coresight@lists.linaro.org
Cc: Mike Leach <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20231212155407.1429121-1-james.clark@arm.com>
 <20231212155407.1429121-9-james.clark@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20231212155407.1429121-9-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James

On 12/12/2023 15:54, James Clark wrote:
> These are a bit annoying to keep up to date when the function signatures
> change. But if CONFIG_CORESIGHT isn't enabled, then they're not used
> anyway so just delete them.
> 

Have you tried building an arm32 kernel with this change in ? Looks like
arch/arm/kernel/hw_breakpoint.c includes linux/coresight.h and a build 
with CONFIG_CORSIGHT=n might break the build ? So is 
drivers/accel/habanalabs/common/habanalabs.h. Now, I am not sure if they 
really need it (even if they do, we may be able to remove the dependency 
on the header file.

Suzuki

> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>   include/linux/coresight.h | 79 ---------------------------------------
>   1 file changed, 79 deletions(-)
> 
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 4400d554a16b..c5be46d7f85c 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -391,8 +391,6 @@ struct coresight_ops {
>   	const struct coresight_ops_helper *helper_ops;
>   };
>   
> -#if IS_ENABLED(CONFIG_CORESIGHT)
> -
>   static inline u32 csdev_access_relaxed_read32(struct csdev_access *csa,
>   					      u32 offset)
>   {
> @@ -611,83 +609,6 @@ void coresight_relaxed_write64(struct coresight_device *csdev,
>   			       u64 val, u32 offset);
>   void coresight_write64(struct coresight_device *csdev, u64 val, u32 offset);
>   
> -#else
> -static inline struct coresight_device *
> -coresight_register(struct coresight_desc *desc) { return NULL; }
> -static inline void coresight_unregister(struct coresight_device *csdev) {}
> -static inline int
> -coresight_enable_sysfs(struct coresight_device *csdev) { return -ENOSYS; }
> -static inline void coresight_disable_sysfs(struct coresight_device *csdev) {}
> -
> -static inline int coresight_timeout(struct csdev_access *csa, u32 offset,
> -				    int position, int value)
> -{
> -	return 1;
> -}
> -
> -static inline int coresight_claim_device_unlocked(struct coresight_device *csdev)
> -{
> -	return -EINVAL;
> -}
> -
> -static inline int coresight_claim_device(struct coresight_device *csdev)
> -{
> -	return -EINVAL;
> -}
> -
> -static inline void coresight_disclaim_device(struct coresight_device *csdev) {}
> -static inline void coresight_disclaim_device_unlocked(struct coresight_device *csdev) {}
> -
> -static inline bool coresight_loses_context_with_cpu(struct device *dev)
> -{
> -	return false;
> -}
> -
> -static inline u32 coresight_relaxed_read32(struct coresight_device *csdev, u32 offset)
> -{
> -	WARN_ON_ONCE(1);
> -	return 0;
> -}
> -
> -static inline u32 coresight_read32(struct coresight_device *csdev, u32 offset)
> -{
> -	WARN_ON_ONCE(1);
> -	return 0;
> -}
> -
> -static inline void coresight_write32(struct coresight_device *csdev, u32 val, u32 offset)
> -{
> -}
> -
> -static inline void coresight_relaxed_write32(struct coresight_device *csdev,
> -					     u32 val, u32 offset)
> -{
> -}
> -
> -static inline u64 coresight_relaxed_read64(struct coresight_device *csdev,
> -					   u32 offset)
> -{
> -	WARN_ON_ONCE(1);
> -	return 0;
> -}
> -
> -static inline u64 coresight_read64(struct coresight_device *csdev, u32 offset)
> -{
> -	WARN_ON_ONCE(1);
> -	return 0;
> -}
> -
> -static inline void coresight_relaxed_write64(struct coresight_device *csdev,
> -					     u64 val, u32 offset)
> -{
> -}
> -
> -static inline void coresight_write64(struct coresight_device *csdev, u64 val, u32 offset)
> -{
> -}
> -
> -#endif		/* IS_ENABLED(CONFIG_CORESIGHT) */
> -
>   extern int coresight_get_cpu(struct device *dev);
>   
>   struct coresight_platform_data *coresight_get_platform_data(struct device *dev);


