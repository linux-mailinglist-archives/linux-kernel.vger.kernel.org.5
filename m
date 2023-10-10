Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336D17BF4D4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 09:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442604AbjJJHvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 03:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442606AbjJJHvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 03:51:39 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB059F;
        Tue, 10 Oct 2023 00:51:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQNU+tWO4HLzuE9wHD78J4UjuejaH+OfGVq2dX1ZPiq8Eoae1gdt9CLZ6KwlF2cshB9dHKY5ecEWfzJ2ZCzSrHds1VFRvD0VHkHTp6FokLaXCVEUgeE/tzK15ZqQ0vzaBMomlY7JV3v7fmQIj/wJRQrQfWItn3xRWKb2RTYlinpu+XnNLXA5HjBYP/h3RNjek/iEAxx3W4pKmMs6QQeu/lkCYfhoTJIwV8WjQDfb2EFjVa18wy/+RzjosElYDmWzyNsrv8fmAF9sWdKYqSdWRtM+28yh6RXDEwflaETz0xO53etuZltOyY+wYrncSB+QijB/yoK1O8LXQtyC5BUTLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lhw0s0RF3e+BJs1no0ywKTCYl20Gvq00iprhhUxD3HU=;
 b=iQT2yCujVwc4uWeh7qAjw2J3MQKV577blO+dGxSLWLUKKBoOjjIMEp0lv3YpoKDnqybZo1Dh2LJiS5e7TJXZMGOICa1FJcArdmeWINGUe5iS3DeuBaQbiQ/qCqtHUFiBJQUcD3DTyzUhJ8Qvqsd4FWrcFBA3gsG3WASRGXWQ7rECIxV7mja2ekGUFDacnNWsUKDlLROWJD49/5MrweJcH6sxfdftdUTCnjInJkintymOu42lpEaf9y472kD9R9L9AVlmtn8FHZcqprcCAgZuXBpWTqtq75EMDX2iEmqO5OUvQab1U7Bnh2I6JY9528q2lYqAbXCIJDrcrar2glAcfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lhw0s0RF3e+BJs1no0ywKTCYl20Gvq00iprhhUxD3HU=;
 b=fmojSHHNpDpqDE+Gnz2tZqyso8O03+hqvq76uGrfB6vkR8p815QF4XE0Ww0IR2KSiltrPbv6a6C640dsfx9Y/fkGxnp1MCH3z15vgLgXb7OOUNA0rNY/26DGXEVlebvwwwQVFrqONbESM30N1Z8UQz0E3GMLs5PmNqTpXjvDPFGS1VIxJO4BPp56LbLD19Ba2yYigyhfc+cYccAh0dkhAxu0F9JWvJA0LTLYIG2zbesReKI3ZMnyIbWfBuUDMEhTMATW5nnvKW84Pm9B7uAAw3mpg5K/15K+Lgkzwm4lAcTTpg5r6suY7TTezIqCwuu5JR+eUpuU1ZIS8VegYXo83w==
Received: from CH2PR20CA0017.namprd20.prod.outlook.com (2603:10b6:610:58::27)
 by CY5PR12MB6408.namprd12.prod.outlook.com (2603:10b6:930:3b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 07:51:34 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::26) by CH2PR20CA0017.outlook.office365.com
 (2603:10b6:610:58::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37 via Frontend
 Transport; Tue, 10 Oct 2023 07:51:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 07:51:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 10 Oct
 2023 00:51:22 -0700
Received: from [10.41.21.79] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 10 Oct
 2023 00:51:18 -0700
Message-ID: <af03ee80-9e72-eecf-2a81-78a35eb4a07c@nvidia.com>
Date:   Tue, 10 Oct 2023 13:21:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Patch v4 2/2] ACPI: processor: reduce CPUFREQ thermal reduction
 pctg for Tegra241
Content-Language: en-US
To:     <rafael@kernel.org>, <rui.zhang@intel.com>, <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <treding@nvidia.com>, <jonathanh@nvidia.com>, <bbasu@nvidia.com>,
        <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>,
        <srikars@nvidia.com>, <jbrasen@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>
References: <20231009171839.12267-1-sumitg@nvidia.com>
 <20231009171839.12267-3-sumitg@nvidia.com>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20231009171839.12267-3-sumitg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|CY5PR12MB6408:EE_
X-MS-Office365-Filtering-Correlation-Id: e6d3d4eb-08d5-48e5-d633-08dbc965b973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +nTSqjLNG/gy4MmaSuZntaifnBR/hzZ9mJWEz6jTAbn6jqyKdiX/OUVJN1atqHSgnEmWSYetz0yIcTIpfjJTqgkTSGZIZBHpsNbRzVSRHhKSIfYCWXOfWUBEdzG1j59H5PkcRRQ7SDiE8Cmzcww3YtEsU5AvsefuCv49WUJGEM3qAZFe+wM8J+EbmMDKOaWIqzi5h2ApLLyI//rl3Bb8Uxx2ZL1MA7zwUEhQd+7edeOvnzFPj/ldlAcJz0aBHU5vzTgLDW0pEDppJed7tso8XJcVHI3IWlYh1C5GclzuHFP9YGSOhatCPuDTcz+bp1s40hK9i+0WicytzTNX0jeOcjq4HK2aqdtD+Nk3H7jY/QtJCdc7855eCtjrc+MJvEMcvoHgNJ7rNGobobpBGZOSci+gdEyqpoXbWI1lRvzf10sJUTsTmzULKQ4A9oIVE59syuScn0l48V3+nhJ5wc8AivhbGsX5tmxgIl3OPkbGi8wjYSWT/47KUg90dA7zKG0CMs6oPRbEg1v9eJgZkA/eBgWA0u/2TRnu88GP+BLi7TxAqcqqMVfby/ey/h96AhqUD3q4oSqMBq4BnK2TPAw2U9TvocYTdcWg7dCiXknY3PAP4vietvVfr00q2xNh4a2SYHxrSQ40Uv2zGWvhB9r2w7dthBaa3+ATw8TUWzRHRZklAkEM5xihYQ1gOZrtrQsYLEIQ8rdvuz+NSRKwHYMamyMPLuiTYRbFRwFu7fXONCVVvnpx6LYvQ99+BeW8LdLKyIyuUhi1YThpAgUW2cpblcSBT4nm/pcGmuwdu2GLbeQ=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(31686004)(86362001)(31696002)(36756003)(40480700001)(107886003)(5660300002)(2616005)(2906002)(110136005)(70586007)(16576012)(478600001)(41300700001)(316002)(54906003)(40460700003)(53546011)(336012)(47076005)(26005)(426003)(16526019)(70206006)(36860700001)(8676002)(4326008)(83380400001)(8936002)(7636003)(356005)(82740400003)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 07:51:34.1750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6d3d4eb-08d5-48e5-d633-08dbc965b973
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6408
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/10/23 22:48, Sumit Gupta wrote:
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
>   drivers/acpi/arm64/Makefile          |  1 +
>   drivers/acpi/arm64/thermal_cpufreq.c | 20 ++++++++++++++++
>   drivers/acpi/processor_thermal.c     | 35 +++++++++++++++++++++++++---
>   include/linux/acpi.h                 |  9 +++++++
>   4 files changed, 62 insertions(+), 3 deletions(-)
>   create mode 100644 drivers/acpi/arm64/thermal_cpufreq.c
> 
> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
> index 143debc1ba4a..3f181d8156cc 100644
> --- a/drivers/acpi/arm64/Makefile
> +++ b/drivers/acpi/arm64/Makefile
> @@ -5,3 +5,4 @@ obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
>   obj-$(CONFIG_ACPI_APMT) 	+= apmt.o
>   obj-$(CONFIG_ARM_AMBA)		+= amba.o
>   obj-y				+= dma.o init.o
> +obj-$(CONFIG_ACPI)		+= thermal_cpufreq.o
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
> diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
> index b7c6287eccca..52f316e4e260 100644
> --- a/drivers/acpi/processor_thermal.c
> +++ b/drivers/acpi/processor_thermal.c
> @@ -26,7 +26,16 @@
>    */
>   
>   #define CPUFREQ_THERMAL_MIN_STEP 0
> -#define CPUFREQ_THERMAL_MAX_STEP 3
> +
> +static int cpufreq_thermal_max_step __read_mostly = 3;
> +
> +/*
> + * Minimum throttle percentage for processor_thermal cooling device.
> + * The processor_thermal driver uses it to calculate the percentage amount by
> + * which cpu frequency must be reduced for each cooling state. This is also used
> + * to calculate the maximum number of throttling steps or cooling states.
> + */
> +static int cpufreq_thermal_pctg __read_mostly = 20;
>   
>   static DEFINE_PER_CPU(unsigned int, cpufreq_thermal_reduction_pctg);
>   
> @@ -71,7 +80,7 @@ static int cpufreq_get_max_state(unsigned int cpu)
>   	if (!cpu_has_cpufreq(cpu))
>   		return 0;
>   
> -	return CPUFREQ_THERMAL_MAX_STEP;
> +	return cpufreq_thermal_max_step;
>   }
>   
>   static int cpufreq_get_cur_state(unsigned int cpu)
> @@ -113,7 +122,8 @@ static int cpufreq_set_cur_state(unsigned int cpu, int state)
>   		if (!policy)
>   			return -EINVAL;
>   
> -		max_freq = (policy->cpuinfo.max_freq * (100 - reduction_pctg(i) * 20)) / 100;
> +		max_freq = (policy->cpuinfo.max_freq *
> +			    (100 - reduction_pctg(i) * cpufreq_thermal_pctg)) / 100;
>   
>   		cpufreq_cpu_put(policy);
>   
> @@ -126,10 +136,29 @@ static int cpufreq_set_cur_state(unsigned int cpu, int state)
>   	return 0;
>   }
>   
> +static void acpi_thermal_cpufreq_config(void)
> +{
> +	int cpufreq_pctg = acpi_thermal_cpufreq_pctg();
> +
> +	if (!cpufreq_pctg)
> +		return;
> +
> +	cpufreq_thermal_pctg = cpufreq_pctg;
> +
> +	/*
> +	 * Derive the MAX_STEP from minimum throttle percentage so that the reduction
> +	 * percentage doesn't end up becoming negative. Also, cap the MAX_STEP so that
> +	 * the CPU performance doesn't become 0.
> +	 */
> +	cpufreq_thermal_max_step = (100 / cpufreq_thermal_pctg) - 1;
> +}
> +
>   void acpi_thermal_cpufreq_init(struct cpufreq_policy *policy)
>   {
>   	unsigned int cpu;
>   
> +	acpi_thermal_cpufreq_config();
> +
>   	for_each_cpu(cpu, policy->related_cpus) {
>   		struct acpi_processor *pr = per_cpu(processors, cpu);
>   		int ret;
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index ba3f601b6e3d..052c90d7479a 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1541,4 +1541,13 @@ static inline void acpi_device_notify(struct device *dev) { }
>   static inline void acpi_device_notify_remove(struct device *dev) { }
>   #endif
>   
> +#ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
> +int acpi_thermal_cpufreq_pctg(void);
> +#else
> +inline int acpi_thermal_cpufreq_pctg(void)
> +{
> +	return 0;
> +}
> +#endif
> +
>   #endif	/*_LINUX_ACPI_H*/

Hi Rafael,

The below change fixes the issue reported by the kernel test robot.
If there are no further comments, then I can send a v5 with this change?

+++ b/include/linux/acpi.h
@@ -1542,7 +1542,7 @@ static inline void 
acpi_device_notify_remove(struct device *dev) { }
  #ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
  int acpi_thermal_cpufreq_pctg(void);
  #else
-inline int acpi_thermal_cpufreq_pctg(void)
+static inline int acpi_thermal_cpufreq_pctg(void)
  {
         return 0;
  }

Best Regards,
Sumit Gupta
