Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784FE7D2D41
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjJWIxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjJWIx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:53:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DFBCA9;
        Mon, 23 Oct 2023 01:53:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6349C2F4;
        Mon, 23 Oct 2023 01:54:05 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF9893F64C;
        Mon, 23 Oct 2023 01:53:22 -0700 (PDT)
Date:   Mon, 23 Oct 2023 09:53:20 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     <rafael@kernel.org>, <rui.zhang@intel.com>, <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <bbasu@nvidia.com>, <sanjayc@nvidia.com>,
        <ksitaraman@nvidia.com>, <srikars@nvidia.com>, <jbrasen@nvidia.com>
Subject: Re: [Patch v5 2/2] ACPI: processor: reduce CPUFREQ thermal reduction
 pctg for Tegra241
Message-ID: <ZTY0gMOAKbugxDIJ@bogus>
References: <20231014105426.26389-1-sumitg@nvidia.com>
 <20231014105426.26389-3-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231014105426.26389-3-sumitg@nvidia.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 14, 2023 at 04:24:26PM +0530, Sumit Gupta wrote:
> From: Srikar Srimath Tirumala <srikars@nvidia.com>
>
> Current implementation of processor_thermal performs software throttling
> in fixed steps of "20%" which can be too coarse for some platforms.
> We observed some performance gain after reducing the throttle percentage.
> Change the CPUFREQ thermal reduction percentage and maximum thermal steps
> to be configurable. Also, update the default values of both for Nvidia
> Tegra241 (Grace) SoC. The thermal reduction percentage is reduced to "5%"
> and accordingly the maximum number of thermal steps are increased as they
> are derived from the reduction percentage.
>
> Signed-off-by: Srikar Srimath Tirumala <srikars@nvidia.com>
> Co-developed-by: Sumit Gupta <sumitg@nvidia.com>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/acpi/arm64/Makefile          |  1 +
>  drivers/acpi/arm64/thermal_cpufreq.c | 20 ++++++++++++++++
>  drivers/acpi/processor_thermal.c     | 35 +++++++++++++++++++++++++---
>  include/linux/acpi.h                 |  9 +++++++
>  4 files changed, 62 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/acpi/arm64/thermal_cpufreq.c
>
> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
> index 143debc1ba4a..3f181d8156cc 100644
> --- a/drivers/acpi/arm64/Makefile
> +++ b/drivers/acpi/arm64/Makefile
> @@ -5,3 +5,4 @@ obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
>  obj-$(CONFIG_ACPI_APMT) 	+= apmt.o
>  obj-$(CONFIG_ARM_AMBA)		+= amba.o
>  obj-y				+= dma.o init.o
> +obj-$(CONFIG_ACPI)		+= thermal_cpufreq.o

Do we really need CONFIG_ACPI here ? We won't be building this if it
is not enabled.

If this is for some module building, then does it make sense to have
more specific config ? May be CONFIG_ACPI_THERMAL ?

> diff --git a/drivers/acpi/arm64/thermal_cpufreq.c b/drivers/acpi/arm64/thermal_cpufreq.c
> new file mode 100644
> index 000000000000..de834fb013e7
> --- /dev/null
> +++ b/drivers/acpi/arm64/thermal_cpufreq.c
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/acpi.h>
> +
> +#ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
> +#define SMCCC_SOC_ID_T241      0x036b0241
> +
> +int acpi_thermal_cpufreq_pctg(void)
> +{
> +	s32 soc_id = arm_smccc_get_soc_id_version();
> +
> +	/*
> +	 * Check JEP106 code for NVIDIA Tegra241 chip (036b:0241) and
> +	 * reduce the CPUFREQ Thermal reduction percentage to 5%.
> +	 */
> +	if (soc_id == SMCCC_SOC_ID_T241)
> +		return 5;
> +
> +	return 0;
> +}
> +#endif

Since this looks like arch specific hook/callback, not sure if it is good
idea to have "arch_" in the function name. But if Rafael is OK with the name
I am fine with this as well.

--
Regards,
Sudeep
