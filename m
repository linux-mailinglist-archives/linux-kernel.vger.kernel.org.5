Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818927A0C9B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238847AbjINSUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjINSUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:20:00 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2103.outbound.protection.outlook.com [40.107.92.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9C01FD5;
        Thu, 14 Sep 2023 11:19:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZNUkKX21I7neKSsYIobGtQcDEidp6Zmm7XxjvEHuZ7orKjpAUi2uiqpgrLqAKfRfdu22rGjvUXN2IalrwphhqBHZS7DBbicOPEEPxdfYHiOeOk1MIZmUBNSYU9YSdKzhPgd4zCr62Z8OrW/ia1Ls82nFRIkOQAcl+TrssrV4zcr36KFKrpFBtw02dDPAUaZXSRgauY6Eg58IGLaIYF4ucTy7kZ9pTciEvJH96D1/qUtkJ5jlEFzEh07sym85M2YIm+Jt+inrRwc+x29UfuRDj1qlFaJTuIp9ZjZisxS5kw4wtK1hzBhUrHmbOuwdSb/WqjWXgqVnukOTpxOKTq1jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCNFyA6IcqPTyQ1PcdYvIcXBiolAeF0S+FYL5x7kToA=;
 b=XJaDHY+vlgUFpElpJhFujYaYwtTudtewGfD8i1ZR7RoXyey6iS20m5GTHg09qOq1p9cuXxI0tM9Sa5bMpLOkt0h5ZT8DR13sQ0RCfkTH5qTqqyzowFh/AQHqyjth1ssdyMnZ5fZbCNa3wEN9ezwIx1kB2C0M2jiSo3mISmQT4T0Gyl/EP3e4txL7zkFIQcub4QGYIy9Y+9iCw9Dx86LeRqb/DW9YXZpUFLz+MFFp09VG0c6HzvwECqcrC8FOciw9PIlukGWgxyP4MeRBBDtHuuANDWsEzNtuKytn20j5nY5sbxgDTPcTImIHQ+3oKH3HZSbx61uZvhfxbNdFYzF8UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCNFyA6IcqPTyQ1PcdYvIcXBiolAeF0S+FYL5x7kToA=;
 b=c+lQaEB0kssT3s9l3+Jccb7OWgBoMbvPCGgrzNwkHVFuPI13/M9jMhjyI5G3+EHRPvRWqaUAot5KqOr818fskyjpXwDE9vITlmu4nFd7625ngUJS+kBJBRwPwulp967frFI442QdSliZiD5N2LDvsFCTv2ZkXhiPIT2V13QjYiU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 DM8PR01MB7144.prod.exchangelabs.com (2603:10b6:8:6::22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20; Thu, 14 Sep 2023 18:19:52 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::bfa4:8250:f526:5015]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::bfa4:8250:f526:5015%6]) with mapi id 15.20.6792.019; Thu, 14 Sep 2023
 18:19:52 +0000
Date:   Thu, 14 Sep 2023 11:19:20 -0700 (PDT)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Besar Wicaksono <bwicaksono@nvidia.com>
cc:     suzuki.poulose@arm.com, robin.murphy@arm.com,
        ilkka@os.amperecomputing.com, catalin.marinas@arm.com,
        will@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, treding@nvidia.com,
        jonathanh@nvidia.com, vsethi@nvidia.com, rwiley@nvidia.com,
        efunsten@nvidia.com
Subject: Re: [PATCH v6] perf: arm_cspmu: Separate Arm and vendor module
In-Reply-To: <20230821231608.50911-1-bwicaksono@nvidia.com>
Message-ID: <f3784fae-154e-784b-bbf2-72dc6ecaf9e9@os.amperecomputing.com>
References: <20230821231608.50911-1-bwicaksono@nvidia.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: CH2PR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:610:4e::34) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|DM8PR01MB7144:EE_
X-MS-Office365-Filtering-Correlation-Id: e5bce4b3-8259-4251-7364-08dbb54f3057
X-LD-Processed: 3bc2b170-fd94-476d-b0ce-4229bdc904a7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wsTGmArpFNHGEgAJDHFfsNxh0y5AmmC5DfJFP+rckV3yATBLTyRUiY5wOeZO2opLzL8gnvXNAfMK0GfRlndfhslQQXIX8YHP8gVxZe4zMqu9+35HRsdv4W4/Ift0IUqAXpHDIZ878bygz+0NP8g7krtIcNdUNzGs5UaVWPVJCGtkwL7b9LOeHtedPJ1si2+m3+9mxqDzq4OcVDXj3CJLeEzuDakGQujSbHfbJR59mHoC0bjNw6ccDl14rHFwd530vEMlAGj5DJfLojkBebt+8Vz4W7vBMTI4pfOkT5mAk3zv9qXXMeDaNDm0HpibhMbqJZ/mbq8UfNPpuxItFyHPlDACPVcrvhAZTL1PDTRTdb2LE3ERZIqbgxbilIeV9tVTbq3A+rn3M9ujzUyQg8sLRbu2fh+vauRN0cmx5mOeYCJ7DE4aoxxGGCGqKSBO9kOOVfPxMOH2771Zgg67nqkUfyx8YAIiDaZZlwbPtg8EjWtiiGEXFr0ymTw5xFciWMbofjnbrq2pTq1Fs0x1Vb2obkBgEQHkV+D8qij99loJtpHKiR9wcjoaj1FJwiYI3X4peTEluXgt18BCN0xQop2nYC+nMGwHuO/EbleHptpRyo4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(376002)(366004)(136003)(396003)(346002)(451199024)(186009)(1800799009)(41300700001)(7416002)(8676002)(4326008)(8936002)(31686004)(66556008)(66946007)(5660300002)(316002)(66476007)(6916009)(30864003)(2906002)(38100700002)(38350700002)(83380400001)(31696002)(52116002)(2616005)(966005)(26005)(86362001)(478600001)(6512007)(6666004)(6486002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AXSVFeckDFckiwlscWwUUVQ9aa2b0jNe+aXMxT7U4Bf3Y06zeLt/zpw7VTB5?=
 =?us-ascii?Q?2s/87zCkNgN1CzOzFTooePKYHSg/Y+s7kpvDEKPQw4FcHFu4iyH/H1tRJQGb?=
 =?us-ascii?Q?fAhVYIByZv7ZzuKY9TsWimh9y+szV+s0rrECn7fLDKDeAOmMipwaCoQB0qRj?=
 =?us-ascii?Q?SVJDTFRBz7LreORLXTdu8FW9JhmvWm3NKAl0svkXjaljJDXCUobnniA06UWX?=
 =?us-ascii?Q?eJATC6MvvYo9WoWg1iihtJ6c3RDW8ipvR/tp+CXhYMXYhMikCyX6CIXm71H8?=
 =?us-ascii?Q?VBLQn/2mB0y2xQE4+mJ1Lh+rnhOtaB29UeYWhFNTj2WQrDdvs5El4aJ9B/Xr?=
 =?us-ascii?Q?mdYSK4t56mXcyAxW8nLMPYHoTt/JjpIpjSwfmu1waHv1oDCtqxu1Ge/4DlIf?=
 =?us-ascii?Q?ORq4IT/nvoAPIa//8lJlm9omg2Rtvuv5FndV5RN5ueGc2IjOKuffYqYL0aYu?=
 =?us-ascii?Q?ROdXk1Ul2ATJt8M46lDIywwiPY0KL5JAT56SGf50NfvrIHKxMW9BO9zmtv7W?=
 =?us-ascii?Q?8KQjzH+53zICGOMo15BTZl6TqDCH7kyqDAasENi1WGIuvbvWekcTYdkxIJIy?=
 =?us-ascii?Q?IaBgJPg7BLzipss2qD5Z3XsWfu5tXsSRoEz2fMCzgV8kdqnJQ6QBlzCdrSlW?=
 =?us-ascii?Q?oXIQ1Bl+p6czu812Tf5QAdhKJhUKDtXb5WWWrABiP7tBnmLivPNQKyDYKGVT?=
 =?us-ascii?Q?r2zqF73Pek6uecfeXreenPSAjuIY87Axr/wJovVUtwamCGJWp/R10cE8wxzD?=
 =?us-ascii?Q?cwUg1juqf0Wo/UL5qEefF3JUZrMrH1MNwTV2xql8nhgT4giEJupAwXrtavLR?=
 =?us-ascii?Q?jeEyWRVFrFr/pBzU+zYhdYJQyOjbS568/cXpxVqQv13wsX7jV5zavQBjClaU?=
 =?us-ascii?Q?bo5pcmvUKhSzKcA4d+iAgYq/mL5gBoPdLdwXs9LoFpuJNFJKsO3E4PNoTz4I?=
 =?us-ascii?Q?jKDU6aIG+j+E3FthEGL5TzkSCVm90fV24V6dW2MGTpS1XyMlavxPyukZUN0s?=
 =?us-ascii?Q?oRyqh+eMHzH1EEBlW7aEyj5FVUGfnpE0SQtY+u6Ro+oxe1kKLFytxBw7/U/v?=
 =?us-ascii?Q?mcdcA8simwqqZCWt/IAG+SXiqKp94GrPraGfTCV+nB5XBVxzFmtd8ERowr+H?=
 =?us-ascii?Q?7bELmJb+H2euI/KiWQRv1wWtIoF3RpL4zP4c+3zd5SFXBiuv4oe6wezy0AXH?=
 =?us-ascii?Q?XK3gdktVGkue2ZmJUzmvFV0CC4jvGqXak3mKHY0nI0EuOPf5es3O5OvnH8nV?=
 =?us-ascii?Q?cZfqlrax3OKQtaxOrKXLv7uifM3Q/YI9WXCqf+iaDBFjWikz/IHKEvi79TOw?=
 =?us-ascii?Q?JGs3Iut8yNE2zcKY5OSNvgSDpOiwxtPuBTMvn9QbcN83++ea89mXV1lsn8gO?=
 =?us-ascii?Q?0gx03Svq3IeZhHfJyfdaZOG85utqXN91KrX9azJxfJKyASTNNjxmATm1xRNg?=
 =?us-ascii?Q?Qu16ksHEOlzW2KsSbAVPfpUwWH0dv7hYuUA3A0115Rtt3tMnzBevTcmEXo9r?=
 =?us-ascii?Q?/M4Oz0YeTHCBdu1EaDmQwQZTul1TbczN8N2rtkJ5Est2s7AvpijfdZIoXD/0?=
 =?us-ascii?Q?B0aocTkpJ3/+oOsTI3MD/SH0hXL6OK9qTBN4EWXCVzFnXvkyYXDenLhn6UCY?=
 =?us-ascii?Q?K1fSHgN40FtRVWYiHJFo5EM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5bce4b3-8259-4251-7364-08dbb54f3057
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 18:19:52.4315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KX4idsr0shSPyrAAfO7areMCmlL2JKVmcmvdOuGnSKPIwmPCJVlS1aPJGrKrmKq57kb/SKdP5NyRJjxeFnZ24Ls3DpiaRng6mKKYWO05IitC3kH/eav0sCbA7gfrXP7z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR01MB7144
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Besar,

On Mon, 21 Aug 2023, Besar Wicaksono wrote:
> Arm Coresight PMU driver consists of main standard code and
> vendor backend code. Both are currently built as a single module.
> This patch adds vendor registration API to separate the two to
> keep things modular. The main driver requests each known backend
> module during initialization and defer device binding process.
> The backend module then registers an init callback to the main
> driver and continue the device driver binding process.
>
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>

I tested the patch with AmpereOne patchset on top of it and it seemed to 
work fine. In addition, the patch looks good to me.

Reviewed-and-tested-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>


Cheers, Ilkka

> ---
>
> Changes from v5:
> * Incorporate review comments.
> * Fix arm_cspmu_impl_match_get not returning NULL if no matching impl.
> * Fix impl_match.module may reset when registering PMU.
> * Maintain backend module ref count until PMU registration is done.
> Thanks to Will, Suzuki, and Robin for the feedback.
> v5: https://lore.kernel.org/linux-arm-kernel/20230705104745.52255-1-bwicaksono@nvidia.com/T/#u
>
> Changes from v4:
> * Fix warning reported by kernel test robot
> v4: https://lore.kernel.org/linux-arm-kernel/20230620041438.32514-1-bwicaksono@nvidia.com/T/#u
>
> Changes from v3:
> * Move impl registration module back to main driver module.
> * Rebase from will (for-next/perf)
> Thanks to Robin for the feedback.
> v3: https://lore.kernel.org/linux-arm-kernel/20230505005956.22837-1-bwicaksono@nvidia.com/T/#u
>
> Changes from v2:
> * Move sysfs_event/format_show definition to arm_cspmu.h and move impl
>   registration API definition to a separate module so main driver and vendor
>   module are independent.
> * The registration API now just sets the impl_init_ops callback, no reprobe.
> * Add PMIIDR table that maps to the vendor module name. During device probe,
>   main driver requests the vendor module if PMIIDR is matching.
> * Keeping the name of the main driver module as arm_cspmu_module.
> Thanks to Robin and Suzuki for the feedback.
> v2:  https://lore.kernel.org/linux-arm-kernel/20230418062030.45620-1-bwicaksono@nvidia.com/T/#u
>
> Changes from v1:
> * Added separate Kconfig entry for nvidia backend
> * Added lock to protect accesses to the lists
> * Added support for matching subset devices from a vendor
> * Added state tracking to avoid reprobe when a device is in use
> Thanks to Suzuki for the feedback.
> v1: https://lore.kernel.org/linux-arm-kernel/20230403163905.20354-1-bwicaksono@nvidia.com/T/#u
>
> ---
> drivers/perf/arm_cspmu/Kconfig        |   9 +-
> drivers/perf/arm_cspmu/Makefile       |   6 +-
> drivers/perf/arm_cspmu/arm_cspmu.c    | 168 ++++++++++++++++++++------
> drivers/perf/arm_cspmu/arm_cspmu.h    |  25 +++-
> drivers/perf/arm_cspmu/nvidia_cspmu.c |  34 +++++-
> drivers/perf/arm_cspmu/nvidia_cspmu.h |  17 ---
> 6 files changed, 199 insertions(+), 60 deletions(-)
> delete mode 100644 drivers/perf/arm_cspmu/nvidia_cspmu.h
>
> diff --git a/drivers/perf/arm_cspmu/Kconfig b/drivers/perf/arm_cspmu/Kconfig
> index 25d25ded0983..d5f787d22234 100644
> --- a/drivers/perf/arm_cspmu/Kconfig
> +++ b/drivers/perf/arm_cspmu/Kconfig
> @@ -1,6 +1,6 @@
> # SPDX-License-Identifier: GPL-2.0
> #
> -# Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
> +# Copyright (c) 2022-2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
>
> config ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU
> 	tristate "ARM Coresight Architecture PMU"
> @@ -10,3 +10,10 @@ config ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU
> 	  based on ARM CoreSight PMU architecture. Note that this PMU
> 	  architecture does not have relationship with the ARM CoreSight
> 	  Self-Hosted Tracing.
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
> #
> # SPDX-License-Identifier: GPL-2.0
>
> obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += arm_cspmu_module.o
> -arm_cspmu_module-y := arm_cspmu.o nvidia_cspmu.o
> +arm_cspmu_module-y := arm_cspmu.o
> +
> +obj-$(CONFIG_NVIDIA_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += nvidia_cspmu.o
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> index e2b7827c4563..c59f1e5a35a3 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -16,7 +16,7 @@
>  * The user should refer to the vendor technical documentation to get details
>  * about the supported events.
>  *
> - * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
> + * Copyright (c) 2022-2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
>  *
>  */
>
> @@ -26,11 +26,11 @@
> #include <linux/interrupt.h>
> #include <linux/io-64-nonatomic-lo-hi.h>
> #include <linux/module.h>
> +#include <linux/mutex.h>
> #include <linux/perf_event.h>
> #include <linux/platform_device.h>
>
> #include "arm_cspmu.h"
> -#include "nvidia_cspmu.h"
>
> #define PMUNAME "arm_cspmu"
> #define DRVNAME "arm-cs-arch-pmu"
> @@ -112,11 +112,10 @@
>  */
> #define HILOHI_MAX_POLL	1000
>
> -/* JEDEC-assigned JEP106 identification code */
> -#define ARM_CSPMU_IMPL_ID_NVIDIA		0x36B
> -
> static unsigned long arm_cspmu_cpuhp_state;
>
> +static DEFINE_MUTEX(arm_cspmu_lock);
> +
> static struct acpi_apmt_node *arm_cspmu_apmt_node(struct device *dev)
> {
> 	return *(struct acpi_apmt_node **)dev_get_platdata(dev);
> @@ -373,27 +372,37 @@ static struct attribute_group arm_cspmu_cpumask_attr_group = {
> 	.attrs = arm_cspmu_cpumask_attrs,
> };
>
> -struct impl_match {
> -	u32 pmiidr;
> -	u32 mask;
> -	int (*impl_init_ops)(struct arm_cspmu *cspmu);
> -};
> -
> -static const struct impl_match impl_match[] = {
> +static struct arm_cspmu_impl_match impl_match[] = {
> 	{
> -	  .pmiidr = ARM_CSPMU_IMPL_ID_NVIDIA,
> -	  .mask = ARM_CSPMU_PMIIDR_IMPLEMENTER,
> -	  .impl_init_ops = nv_cspmu_init_ops
> +		.module_name	= "nvidia_cspmu",
> +		.pmiidr_val	= ARM_CSPMU_IMPL_ID_NVIDIA,
> +		.pmiidr_mask	= ARM_CSPMU_PMIIDR_IMPLEMENTER,
> +		.module		= NULL,
> +		.impl_init_ops	= NULL,
> 	},
> -	{}
> +	{0}
> };
>
> +static struct arm_cspmu_impl_match *arm_cspmu_impl_match_get(u32 pmiidr)
> +{
> +	struct arm_cspmu_impl_match *match = impl_match;
> +
> +	for (; match->pmiidr_val; match++) {
> +		u32 mask = match->pmiidr_mask;
> +
> +		if ((match->pmiidr_val & mask) == (pmiidr & mask))
> +			return match;
> +	}
> +
> +	return NULL;
> +}
> +
> static int arm_cspmu_init_impl_ops(struct arm_cspmu *cspmu)
> {
> -	int ret;
> +	int ret = 0;
> 	struct arm_cspmu_impl_ops *impl_ops = &cspmu->impl.ops;
> 	struct acpi_apmt_node *apmt_node = arm_cspmu_apmt_node(cspmu->dev);
> -	const struct impl_match *match = impl_match;
> +	struct arm_cspmu_impl_match *match;
>
> 	/*
> 	 * Get PMU implementer and product id from APMT node.
> @@ -405,17 +414,36 @@ static int arm_cspmu_init_impl_ops(struct arm_cspmu *cspmu)
> 				       readl(cspmu->base0 + PMIIDR);
>
> 	/* Find implementer specific attribute ops. */
> -	for (; match->pmiidr; match++) {
> -		const u32 mask = match->mask;
> +	match = arm_cspmu_impl_match_get(cspmu->impl.pmiidr);
> +
> +	/* Load implementer module and initialize the callbacks. */
> +	if (match) {
> +		mutex_lock(&arm_cspmu_lock);
> +
> +		if (match->impl_init_ops) {
> +			/* Prevent unload until PMU registration is done. */
> +			if (try_module_get(match->module)) {
> +				cspmu->impl.module = match->module;
> +				cspmu->impl.match = match;
> +				ret = match->impl_init_ops(cspmu);
> +				if (ret)
> +					module_put(match->module);
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
> -	}
> +		if (ret)
> +			return ret;
> +	} else
> +		cspmu->impl.module = THIS_MODULE;
>
> 	/* Use default callbacks if implementer doesn't provide one. */
> 	CHECK_DEFAULT_IMPL_OPS(impl_ops, get_event_attrs);
> @@ -478,11 +506,6 @@ arm_cspmu_alloc_attr_group(struct arm_cspmu *cspmu)
> 	struct attribute_group **attr_groups = NULL;
> 	struct device *dev = cspmu->dev;
> 	const struct arm_cspmu_impl_ops *impl_ops = &cspmu->impl.ops;
> -	int ret;
> -
> -	ret = arm_cspmu_init_impl_ops(cspmu);
> -	if (ret)
> -		return NULL;
>
> 	cspmu->identifier = impl_ops->get_identifier(cspmu);
> 	cspmu->name = impl_ops->get_name(cspmu);
> @@ -1149,7 +1172,7 @@ static int arm_cspmu_register_pmu(struct arm_cspmu *cspmu)
>
> 	cspmu->pmu = (struct pmu){
> 		.task_ctx_nr	= perf_invalid_context,
> -		.module		= THIS_MODULE,
> +		.module		= cspmu->impl.module,
> 		.pmu_enable	= arm_cspmu_enable,
> 		.pmu_disable	= arm_cspmu_disable,
> 		.event_init	= arm_cspmu_event_init,
> @@ -1196,11 +1219,17 @@ static int arm_cspmu_device_probe(struct platform_device *pdev)
> 	if (ret)
> 		return ret;
>
> -	ret = arm_cspmu_register_pmu(cspmu);
> +	ret = arm_cspmu_init_impl_ops(cspmu);
> 	if (ret)
> 		return ret;
>
> -	return 0;
> +	ret = arm_cspmu_register_pmu(cspmu);
> +
> +	/* Matches arm_cspmu_init_impl_ops() above. */
> +	if (cspmu->impl.module != THIS_MODULE)
> +		module_put(cspmu->impl.module);
> +
> +	return ret;
> }
>
> static int arm_cspmu_device_remove(struct platform_device *pdev)
> @@ -1300,6 +1329,75 @@ static void __exit arm_cspmu_exit(void)
> 	cpuhp_remove_multi_state(arm_cspmu_cpuhp_state);
> }
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
> +	if (WARN_ON(!match))
> +		return;
> +
> +	/* Unbind the driver from all matching backend devices. */
> +	while ((dev = driver_find_device(&arm_cspmu_driver.driver, NULL,
> +			match, arm_cspmu_match_device)))
> +		device_release_driver(dev);
> +
> +	mutex_lock(&arm_cspmu_lock);
> +
> +	match->module = NULL;
> +	match->impl_init_ops = NULL;
> +
> +	mutex_unlock(&arm_cspmu_lock);
> +}
> +EXPORT_SYMBOL_GPL(arm_cspmu_impl_unregister);
> +
> module_init(arm_cspmu_init);
> module_exit(arm_cspmu_exit);
>
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h b/drivers/perf/arm_cspmu/arm_cspmu.h
> index 83df53d1c132..7936a90ded7f 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.h
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.h
> @@ -1,7 +1,7 @@
> /* SPDX-License-Identifier: GPL-2.0
>  *
>  * ARM CoreSight Architecture PMU driver.
> - * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
> + * Copyright (c) 2022-2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
>  *
>  */
>
> @@ -69,6 +69,9 @@
> #define ARM_CSPMU_PMIIDR_IMPLEMENTER	GENMASK(11, 0)
> #define ARM_CSPMU_PMIIDR_PRODUCTID	GENMASK(31, 20)
>
> +/* JEDEC-assigned JEP106 identification code */
> +#define ARM_CSPMU_IMPL_ID_NVIDIA	0x36B
> +
> struct arm_cspmu;
>
> /* This tracks the events assigned to each counter in the PMU. */
> @@ -106,9 +109,23 @@ struct arm_cspmu_impl_ops {
> 					 struct attribute *attr, int unused);
> };
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
> /* Vendor/implementer descriptor. */
> struct arm_cspmu_impl {
> 	u32 pmiidr;
> +	struct module *module;
> +	struct arm_cspmu_impl_match *match;
> 	struct arm_cspmu_impl_ops ops;
> 	void *ctx;
> };
> @@ -147,4 +164,10 @@ ssize_t arm_cspmu_sysfs_format_show(struct device *dev,
> 				    struct device_attribute *attr,
> 				    char *buf);
>
> +/* Register vendor backend. */
> +int arm_cspmu_impl_register(const struct arm_cspmu_impl_match *impl_match);
> +
> +/* Unregister vendor backend. */
> +void arm_cspmu_impl_unregister(const struct arm_cspmu_impl_match *impl_match);
> +
> #endif /* __ARM_CSPMU_H__ */
> diff --git a/drivers/perf/arm_cspmu/nvidia_cspmu.c b/drivers/perf/arm_cspmu/nvidia_cspmu.c
> index 72ef80caa3c8..0382b702f092 100644
> --- a/drivers/perf/arm_cspmu/nvidia_cspmu.c
> +++ b/drivers/perf/arm_cspmu/nvidia_cspmu.c
> @@ -1,14 +1,15 @@
> // SPDX-License-Identifier: GPL-2.0
> /*
> - * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
> + * Copyright (c) 2022-2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
>  *
>  */
>
> /* Support for NVIDIA specific attributes. */
>
> +#include <linux/module.h>
> #include <linux/topology.h>
>
> -#include "nvidia_cspmu.h"
> +#include "arm_cspmu.h"
>
> #define NV_PCIE_PORT_COUNT           10ULL
> #define NV_PCIE_FILTER_ID_MASK       GENMASK_ULL(NV_PCIE_PORT_COUNT - 1, 0)
> @@ -351,7 +352,7 @@ static char *nv_cspmu_format_name(const struct arm_cspmu *cspmu,
> 	return name;
> }
>
> -int nv_cspmu_init_ops(struct arm_cspmu *cspmu)
> +static int nv_cspmu_init_ops(struct arm_cspmu *cspmu)
> {
> 	u32 prodid;
> 	struct nv_cspmu_ctx *ctx;
> @@ -395,6 +396,31 @@ int nv_cspmu_init_ops(struct arm_cspmu *cspmu)
>
> 	return 0;
> }
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
> MODULE_LICENSE("GPL v2");
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
> -- 
> 2.17.1
>
>
