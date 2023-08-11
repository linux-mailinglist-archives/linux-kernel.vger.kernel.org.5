Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492FA778DA7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236458AbjHKL3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236416AbjHKL26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:28:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B59AEE62;
        Fri, 11 Aug 2023 04:28:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAEE3D75;
        Fri, 11 Aug 2023 04:29:38 -0700 (PDT)
Received: from [10.57.91.12] (unknown [10.57.91.12])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 521A53F6C4;
        Fri, 11 Aug 2023 04:28:54 -0700 (PDT)
Message-ID: <e98abbc3-dab6-414d-8ce7-8b9572be41a0@arm.com>
Date:   Fri, 11 Aug 2023 12:28:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v5] perf: arm_cspmu: Separate Arm and vendor module
To:     Besar Wicaksono <bwicaksono@nvidia.com>, robin.murphy@arm.com,
        ilkka@os.amperecomputing.com, catalin.marinas@arm.com,
        will@kernel.org, mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, treding@nvidia.com,
        jonathanh@nvidia.com, vsethi@nvidia.com, rwiley@nvidia.com,
        efunsten@nvidia.com
References: <20230705104745.52255-1-bwicaksono@nvidia.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230705104745.52255-1-bwicaksono@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2023 11:47, Besar Wicaksono wrote:
> Arm Coresight PMU driver consists of main standard code and
> vendor backend code. Both are currently built as a single module.
> This patch adds vendor registration API to separate the two to
> keep things modular. The main driver requests each known backend
> module during initialization and defer device binding process.
> The backend module then registers an init callback to the main
> driver and continue the device driver binding process.
> 
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>

Apologies for the delay.

> ---
> 
> Changes from v4:
>   * Fix warning reported by kernel test robot
> v4: https://lore.kernel.org/linux-arm-kernel/20230620041438.32514-1-bwicaksono@nvidia.com/T/#u
> 
> Changes from v3:
>   * Move impl registration module back to main driver module.
>   * Rebase from will (for-next/perf)
> Thanks to Robin for the feedback.
> v3: https://lore.kernel.org/linux-arm-kernel/20230505005956.22837-1-bwicaksono@nvidia.com/T/#u
> 
> Changes from v2:
>   * Move sysfs_event/format_show definition to arm_cspmu.h and move impl
>     registration API definition to a separate module so main driver and vendor
>     module are independent.
>   * The registration API now just sets the impl_init_ops callback, no reprobe.
>   * Add PMIIDR table that maps to the vendor module name. During device probe,
>     main driver requests the vendor module if PMIIDR is matching.
>   * Keeping the name of the main driver module as arm_cspmu_module.
> Thanks to Robin and Suzuki for the feedback.
> v2:  https://lore.kernel.org/linux-arm-kernel/20230418062030.45620-1-bwicaksono@nvidia.com/T/#u
> 
> Changes from v1:
>   * Added separate Kconfig entry for nvidia backend
>   * Added lock to protect accesses to the lists
>   * Added support for matching subset devices from a vendor
>   * Added state tracking to avoid reprobe when a device is in use
> Thanks to Suzuki for the feedback.
> v1: https://lore.kernel.org/linux-arm-kernel/20230403163905.20354-1-bwicaksono@nvidia.com/T/#u
> 
> ---
>   drivers/perf/arm_cspmu/Kconfig        |   9 +-
>   drivers/perf/arm_cspmu/Makefile       |   6 +-
>   drivers/perf/arm_cspmu/arm_cspmu.c    | 166 +++++++++++++++++++++-----
>   drivers/perf/arm_cspmu/arm_cspmu.h    |  24 +++-
>   drivers/perf/arm_cspmu/nvidia_cspmu.c |  34 +++++-
>   drivers/perf/arm_cspmu/nvidia_cspmu.h |  17 ---
>   6 files changed, 199 insertions(+), 57 deletions(-)
>   delete mode 100644 drivers/perf/arm_cspmu/nvidia_cspmu.h
> 
> diff --git a/drivers/perf/arm_cspmu/Kconfig b/drivers/perf/arm_cspmu/Kconfig
> index 25d25ded0983..d5f787d22234 100644
> --- a/drivers/perf/arm_cspmu/Kconfig
> +++ b/drivers/perf/arm_cspmu/Kconfig
> @@ -1,6 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0
>   #
> -# Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
> +# Copyright (c) 2022-2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
>   
>   config ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU
>   	tristate "ARM Coresight Architecture PMU"
> @@ -10,3 +10,10 @@ config ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU
>   	  based on ARM CoreSight PMU architecture. Note that this PMU
>   	  architecture does not have relationship with the ARM CoreSight
>   	  Self-Hosted Tracing.
> +
> +config NVIDIA_CORESIGHT_PMU_ARCH_SYSTEM_PMU
> +	tristate "NVIDIA Coresight Architecture PMU"
> +	depends on ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU
> +	help
> +	  Provides NVIDIA specific attributes for performance monitoring unit
> +	  (PMU) devices based on ARM CoreSight PMU architecture.
> diff --git a/drivers/perf/arm_cspmu/Makefile b/drivers/perf/arm_cspmu/Makefile
> index fedb17df982d..0309d2ff264a 100644
> --- a/drivers/perf/arm_cspmu/Makefile
> +++ b/drivers/perf/arm_cspmu/Makefile
> @@ -1,6 +1,8 @@
> -# Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
> +# Copyright (c) 2022-2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
>   #
>   # SPDX-License-Identifier: GPL-2.0
>   
>   obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += arm_cspmu_module.o
> -arm_cspmu_module-y := arm_cspmu.o nvidia_cspmu.o
> +arm_cspmu_module-y := arm_cspmu.o
> +
> +obj-$(CONFIG_NVIDIA_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += nvidia_cspmu.o
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> index e2b7827c4563..04be94b4aa48 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -16,7 +16,7 @@
>    * The user should refer to the vendor technical documentation to get details
>    * about the supported events.
>    *
> - * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
> + * Copyright (c) 2022-2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
>    *
>    */
>   
> @@ -26,11 +26,11 @@
>   #include <linux/interrupt.h>
>   #include <linux/io-64-nonatomic-lo-hi.h>
>   #include <linux/module.h>
> +#include <linux/mutex.h>
>   #include <linux/perf_event.h>
>   #include <linux/platform_device.h>
>   
>   #include "arm_cspmu.h"
> -#include "nvidia_cspmu.h"
>   
>   #define PMUNAME "arm_cspmu"
>   #define DRVNAME "arm-cs-arch-pmu"
> @@ -112,11 +112,10 @@
>    */
>   #define HILOHI_MAX_POLL	1000
>   
> -/* JEDEC-assigned JEP106 identification code */
> -#define ARM_CSPMU_IMPL_ID_NVIDIA		0x36B
> -
>   static unsigned long arm_cspmu_cpuhp_state;
>   
> +static DEFINE_MUTEX(arm_cspmu_lock);
> +
>   static struct acpi_apmt_node *arm_cspmu_apmt_node(struct device *dev)
>   {
>   	return *(struct acpi_apmt_node **)dev_get_platdata(dev);
> @@ -373,27 +372,37 @@ static struct attribute_group arm_cspmu_cpumask_attr_group = {
>   	.attrs = arm_cspmu_cpumask_attrs,
>   };
>   
> -struct impl_match {
> -	u32 pmiidr;
> -	u32 mask;
> -	int (*impl_init_ops)(struct arm_cspmu *cspmu);
> -};
> -
> -static const struct impl_match impl_match[] = {
> +static struct arm_cspmu_impl_match impl_match[] = {
>   	{
> -	  .pmiidr = ARM_CSPMU_IMPL_ID_NVIDIA,
> -	  .mask = ARM_CSPMU_PMIIDR_IMPLEMENTER,
> -	  .impl_init_ops = nv_cspmu_init_ops
> +		.module_name	= "nvidia_cspmu",
> +		.pmiidr_val	= ARM_CSPMU_IMPL_ID_NVIDIA,
> +		.pmiidr_mask	= ARM_CSPMU_PMIIDR_IMPLEMENTER,
> +		.module		= NULL,
> +		.impl_init_ops	= NULL,
>   	},
> -	{}
> +	{0}
>   };
>   
> +static struct arm_cspmu_impl_match *arm_cspmu_impl_match_get(u32 pmiidr)
> +{
> +	struct arm_cspmu_impl_match *match = impl_match;
> +
> +	for (; match->pmiidr_val; match++) {
> +		u32 mask = match->pmiidr_mask;
> +
> +		if ((match->pmiidr_val & mask) == (pmiidr & mask))
> +			break;
> +	}
> +
> +	return match;
> +}
> +
>   static int arm_cspmu_init_impl_ops(struct arm_cspmu *cspmu)
>   {
> -	int ret;
> +	int ret = 0;
>   	struct arm_cspmu_impl_ops *impl_ops = &cspmu->impl.ops;
>   	struct acpi_apmt_node *apmt_node = arm_cspmu_apmt_node(cspmu->dev);
> -	const struct impl_match *match = impl_match;
> +	struct arm_cspmu_impl_match *match;
>   
>   	/*
>   	 * Get PMU implementer and product id from APMT node.
> @@ -405,16 +414,31 @@ static int arm_cspmu_init_impl_ops(struct arm_cspmu *cspmu)
>   				       readl(cspmu->base0 + PMIIDR);
>   
>   	/* Find implementer specific attribute ops. */
> -	for (; match->pmiidr; match++) {
> -		const u32 mask = match->mask;
> +	match = arm_cspmu_impl_match_get(cspmu->impl.pmiidr);
> +
> +	/* Load implementer module and initialize the callbacks. */
> +	if (match) {
> +		mutex_lock(&arm_cspmu_lock);
> +
> +		if (match->impl_init_ops) {
> +			if (try_module_get(match->module)) {
> +				cspmu->impl.match = match;
> +				ret = match->impl_init_ops(cspmu);
> +				module_put(match->module);
> +			} else {
> +				WARN(1, "arm_cspmu failed to get module: %s\n",
> +					match->module_name);
> +				ret = -EINVAL;
> +			}
> +		} else {
> +			request_module_nowait(match->module_name);
> +			ret = -EPROBE_DEFER;
> +		}
>   
> -		if ((match->pmiidr & mask) == (cspmu->impl.pmiidr & mask)) {
> -			ret = match->impl_init_ops(cspmu);
> -			if (ret)
> -				return ret;
> +		mutex_unlock(&arm_cspmu_lock);
>   
> -			break;
> -		}
> +		if (ret)
> +			return ret;
>   	}
>   
>   	/* Use default callbacks if implementer doesn't provide one. */
> @@ -478,11 +502,6 @@ arm_cspmu_alloc_attr_group(struct arm_cspmu *cspmu)
>   	struct attribute_group **attr_groups = NULL;
>   	struct device *dev = cspmu->dev;
>   	const struct arm_cspmu_impl_ops *impl_ops = &cspmu->impl.ops;
> -	int ret;
> -
> -	ret = arm_cspmu_init_impl_ops(cspmu);
> -	if (ret)
> -		return NULL;
>   
>   	cspmu->identifier = impl_ops->get_identifier(cspmu);
>   	cspmu->name = impl_ops->get_name(cspmu);
> @@ -1129,6 +1148,11 @@ static int arm_cspmu_get_cpus(struct arm_cspmu *cspmu)
>   	return arm_cspmu_acpi_get_cpus(cspmu);
>   }
>   
> +static inline struct module *arm_cspmu_get_module(struct arm_cspmu *cspmu)
> +{
> +	return (cspmu->impl.match) ? cspmu->impl.match->module : THIS_MODULE;
> +}
> +
>   static int arm_cspmu_register_pmu(struct arm_cspmu *cspmu)
>   {
>   	int ret, capabilities;
> @@ -1149,7 +1173,7 @@ static int arm_cspmu_register_pmu(struct arm_cspmu *cspmu)
>   
>   	cspmu->pmu = (struct pmu){
>   		.task_ctx_nr	= perf_invalid_context,
> -		.module		= THIS_MODULE,
> +		.module		= arm_cspmu_get_module(cspmu),

We are accessing the module field without the mutex and the
impl.match->module could be reset ?

>   		.pmu_enable	= arm_cspmu_enable,
>   		.pmu_disable	= arm_cspmu_disable,
>   		.event_init	= arm_cspmu_event_init,
> @@ -1196,6 +1220,10 @@ static int arm_cspmu_device_probe(struct platform_device *pdev)
>   	if (ret)
>   		return ret;
>   
> +	ret = arm_cspmu_init_impl_ops(cspmu);
> +	if (ret)
> +		return ret;
> +
>   	ret = arm_cspmu_register_pmu(cspmu);
>   	if (ret)
>   		return ret;
> @@ -1300,6 +1328,80 @@ static void __exit arm_cspmu_exit(void)
>   	cpuhp_remove_multi_state(arm_cspmu_cpuhp_state);
>   }
>   
> +int arm_cspmu_impl_register(const struct arm_cspmu_impl_match *impl_match)
> +{
> +	struct arm_cspmu_impl_match *match;
> +	int ret = 0;
> +
> +	match = arm_cspmu_impl_match_get(impl_match->pmiidr_val);
> +
> +	if (match) {
> +		mutex_lock(&arm_cspmu_lock);
> +
> +		if (!match->impl_init_ops) {
> +			match->module = impl_match->module;
> +			match->impl_init_ops = impl_match->impl_init_ops;
> +		} else {
> +			/* Broken match table may contain non-unique entries */
> +			WARN(1, "arm_cspmu backend already registered for module: %s, pmiidr: 0x%x, mask: 0x%x\n",
> +				match->module_name,
> +				match->pmiidr_val,
> +				match->pmiidr_mask);
> +
> +			ret = -EINVAL;
> +		}
> +
> +		mutex_unlock(&arm_cspmu_lock);
> +
> +		if (!ret)
> +			ret = driver_attach(&arm_cspmu_driver.driver);
> +	} else {
> +		pr_err("arm_cspmu reg failed, unable to find a match for pmiidr: 0x%x\n",
> +			impl_match->pmiidr_val);
> +
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(arm_cspmu_impl_register);
> +
> +static int arm_cspmu_match_device(struct device *dev, const void *match)
> +{
> +	struct arm_cspmu *cspmu = platform_get_drvdata(to_platform_device(dev));
> +
> +	return (cspmu && cspmu->impl.match == match) ? 1 : 0;
> +}
> +
> +void arm_cspmu_impl_unregister(const struct arm_cspmu_impl_match *impl_match)
> +{
> +	struct device *dev;
> +	struct arm_cspmu_impl_match *match;
> +
> +	match = arm_cspmu_impl_match_get(impl_match->pmiidr_val);
> +
> +	WARN_ON(!match);
> +
> +	if (match) {
> +		/* Unbind the driver from all matching backend devices. */
> +dev_release:
> +		dev = driver_find_device(&arm_cspmu_driver.driver, NULL,
> +			match, arm_cspmu_match_device);
> +		if (dev) {
> +			device_release_driver(dev);
> +			goto dev_release;
> +		}

minor nit: We could simply do :

static int arm_cspmu_release_driver(struct device *dev, void *data)
{
	struct arm_cspmu *cspmu = platform_get_drvdata(to_platform_device(dev));

	if (cspmu && cspmu->impl.match == match)
		device_release_driver(dev);
	return 0;
}

		ret = driver_for_each_device(&driver, NULL, match, 
arm_csmpu_release_driver);


Rest looks fine to me.

Suzuki

> +
> +		mutex_lock(&arm_cspmu_lock);
> +
> +		match->module = NULL;
> +		match->impl_init_ops = NULL;
> +
> +		mutex_unlock(&arm_cspmu_lock);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(arm_cspmu_impl_unregister);
> +
>   module_init(arm_cspmu_init);
>   module_exit(arm_cspmu_exit);
>   
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h b/drivers/perf/arm_cspmu/arm_cspmu.h
> index 83df53d1c132..e5c6dff2ce7f 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.h
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.h
> @@ -1,7 +1,7 @@
>   /* SPDX-License-Identifier: GPL-2.0
>    *
>    * ARM CoreSight Architecture PMU driver.
> - * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
> + * Copyright (c) 2022-2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
>    *
>    */
>   
> @@ -69,6 +69,9 @@
>   #define ARM_CSPMU_PMIIDR_IMPLEMENTER	GENMASK(11, 0)
>   #define ARM_CSPMU_PMIIDR_PRODUCTID	GENMASK(31, 20)
>   
> +/* JEDEC-assigned JEP106 identification code */
> +#define ARM_CSPMU_IMPL_ID_NVIDIA	0x36B
> +
>   struct arm_cspmu;
>   
>   /* This tracks the events assigned to each counter in the PMU. */
> @@ -106,9 +109,22 @@ struct arm_cspmu_impl_ops {
>   					 struct attribute *attr, int unused);
>   };
>   
> +/* Vendor/implementer registration parameter. */
> +struct arm_cspmu_impl_match {
> +	/* Backend module. */
> +	struct module *module;
> +	const char *module_name;
> +	/* PMIIDR value/mask. */
> +	u32 pmiidr_val;
> +	u32 pmiidr_mask;
> +	/* Callback to vendor backend to init arm_cspmu_impl::ops. */
> +	int (*impl_init_ops)(struct arm_cspmu *cspmu);
> +};
> +
>   /* Vendor/implementer descriptor. */
>   struct arm_cspmu_impl {
>   	u32 pmiidr;
> +	struct arm_cspmu_impl_match *match;
>   	struct arm_cspmu_impl_ops ops;
>   	void *ctx;
>   };
> @@ -147,4 +163,10 @@ ssize_t arm_cspmu_sysfs_format_show(struct device *dev,
>   				    struct device_attribute *attr,
>   				    char *buf);
>   
> +/* Register vendor backend. */
> +int arm_cspmu_impl_register(const struct arm_cspmu_impl_match *impl_match);
> +
> +/* Unregister vendor backend. */
> +void arm_cspmu_impl_unregister(const struct arm_cspmu_impl_match *impl_match);
> +
>   #endif /* __ARM_CSPMU_H__ */
> diff --git a/drivers/perf/arm_cspmu/nvidia_cspmu.c b/drivers/perf/arm_cspmu/nvidia_cspmu.c
> index 72ef80caa3c8..0382b702f092 100644
> --- a/drivers/perf/arm_cspmu/nvidia_cspmu.c
> +++ b/drivers/perf/arm_cspmu/nvidia_cspmu.c
> @@ -1,14 +1,15 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
> - * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
> + * Copyright (c) 2022-2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
>    *
>    */
>   
>   /* Support for NVIDIA specific attributes. */
>   
> +#include <linux/module.h>
>   #include <linux/topology.h>
>   
> -#include "nvidia_cspmu.h"
> +#include "arm_cspmu.h"
>   
>   #define NV_PCIE_PORT_COUNT           10ULL
>   #define NV_PCIE_FILTER_ID_MASK       GENMASK_ULL(NV_PCIE_PORT_COUNT - 1, 0)
> @@ -351,7 +352,7 @@ static char *nv_cspmu_format_name(const struct arm_cspmu *cspmu,
>   	return name;
>   }
>   
> -int nv_cspmu_init_ops(struct arm_cspmu *cspmu)
> +static int nv_cspmu_init_ops(struct arm_cspmu *cspmu)
>   {
>   	u32 prodid;
>   	struct nv_cspmu_ctx *ctx;
> @@ -395,6 +396,31 @@ int nv_cspmu_init_ops(struct arm_cspmu *cspmu)
>   
>   	return 0;
>   }
> -EXPORT_SYMBOL_GPL(nv_cspmu_init_ops);
> +
> +/* Match all NVIDIA Coresight PMU devices */
> +static const struct arm_cspmu_impl_match nv_cspmu_param = {
> +	.pmiidr_val	= ARM_CSPMU_IMPL_ID_NVIDIA,
> +	.module		= THIS_MODULE,
> +	.impl_init_ops	= nv_cspmu_init_ops
> +};
> +
> +static int __init nvidia_cspmu_init(void)
> +{
> +	int ret;
> +
> +	ret = arm_cspmu_impl_register(&nv_cspmu_param);
> +	if (ret)
> +		pr_err("nvidia_cspmu backend registration error: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static void __exit nvidia_cspmu_exit(void)
> +{
> +	arm_cspmu_impl_unregister(&nv_cspmu_param);
> +}
> +
> +module_init(nvidia_cspmu_init);
> +module_exit(nvidia_cspmu_exit);
>   
>   MODULE_LICENSE("GPL v2");
> diff --git a/drivers/perf/arm_cspmu/nvidia_cspmu.h b/drivers/perf/arm_cspmu/nvidia_cspmu.h
> deleted file mode 100644
> index 71e18f0dc50b..000000000000
> --- a/drivers/perf/arm_cspmu/nvidia_cspmu.h
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0
> - *
> - * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
> - *
> - */
> -
> -/* Support for NVIDIA specific attributes. */
> -
> -#ifndef __NVIDIA_CSPMU_H__
> -#define __NVIDIA_CSPMU_H__
> -
> -#include "arm_cspmu.h"
> -
> -/* Allocate NVIDIA descriptor. */
> -int nv_cspmu_init_ops(struct arm_cspmu *cspmu);
> -
> -#endif /* __NVIDIA_CSPMU_H__ */
> 
> base-commit: ea8d1c062a0e876e999e4f347daeb598d5e677ab

