Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69CE37D6C5F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343645AbjJYMvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234787AbjJYMvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:51:49 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7701E90;
        Wed, 25 Oct 2023 05:51:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUtdaGsA+wKzGzJu2Wa6QddgvaGvIM9rFzO3Ud9CX5tTg3SLi+MCc2s0/RWqzJ2a0q0JCZ1jdJhnUG/33/F2E6BxaED028qRvG3VNmlbP+hkeLCCIYHj0l6QRKmUKS7QhZLLvJ8FWgv7QUnQ/NSSIHMmSlNHuqJzwrxU6NJG9Q3tIDiobtMM5zKMlH08fq+7xTMvIAIFtjmoTvsSRBDDpnL2i1G4GAh9T0KLjMpIZHv8qZQAL54TK0/J2iF4nxOq1d6i3emCuHoW37NmC6zUutnwwpJG1+gKL4Ai+FDlFoULyVRp2i/1zrDdezz7ztqqddkBPLRQe/NiG72B7Bf7/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhNDAMBHBUAE9AgQLqC37belLm58JOb9FdF0rvzMK5s=;
 b=Gm/zmkve+38id0yf7kdZ0XyuZjx7MxminMnRbvjHbcAHLwm3QVAlkS8MYA52WdwUwWaMd36q/J5SObaaw24P7V6h4Vo1gC+dpUxqvYs1jCznufUHHN5jp3FJFSneTyKwyayGmvzMAqPj7lxYs6G7SvxdO5/myVFsd7ldYADBECnBrPrcpybqjG5RFaHwpFAkAymMf1XdNXV/VhuiYickVBq46bo0DKLt7IP8zb9zJDLNlWkDgoyIfOxbzDOmH2CqGls+5/2nkTngsnHPjOwDKki1yZ2uB0ZmH9w54JCBynRoVFX/JnHtswSWVryoLeRr1+7OtgD4+2F+2wz9tM6+jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhNDAMBHBUAE9AgQLqC37belLm58JOb9FdF0rvzMK5s=;
 b=c3HfrxNVbpnO8Ngul7p6D/caxhFlsppd4qdXy0MBnNN6NP9RjBLdUPfQ/7UA+8r+L/uo6kRN3w5LUOVLD5My1qiB6eRJ+Co4MW6RCdhNZz3dMHo6t1ZuGID5uwnxgh8F84rs4CHCIMMWwAty4fvkHFDpxN0IwtonYpHeTLys8m5pcrqjxvliOww76J+nX8YCqNuo5Xl/PHfI7N+B30jEw9xeuKkwttrYjdU1ilIjXJTI9WHxtzyUi3cQFLzeh2hGNpQaAct8MG2NWdoaGZrKiv50mt6UXnxHIWhzH0uL/5iMrYFq2yrXH28FUPywqc6tsks7vjulbXbvPl3qQPFb1Q==
Received: from BL1PR13CA0150.namprd13.prod.outlook.com (2603:10b6:208:2bb::35)
 by SN7PR12MB6766.namprd12.prod.outlook.com (2603:10b6:806:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 12:51:45 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:2bb:cafe::12) by BL1PR13CA0150.outlook.office365.com
 (2603:10b6:208:2bb::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Wed, 25 Oct 2023 12:51:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 12:51:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 25 Oct
 2023 05:51:31 -0700
Received: from [10.41.21.79] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 25 Oct
 2023 05:51:27 -0700
Message-ID: <0e2b8fc9-a84d-2bf2-91b7-6556bad43ede@nvidia.com>
Date:   Wed, 25 Oct 2023 18:21:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Patch v5 2/2] ACPI: processor: reduce CPUFREQ thermal reduction
 pctg for Tegra241
Content-Language: en-US
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     <rafael@kernel.org>, <rui.zhang@intel.com>, <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <bbasu@nvidia.com>, <sanjayc@nvidia.com>,
        <ksitaraman@nvidia.com>, <srikars@nvidia.com>,
        <jbrasen@nvidia.com>, Sumit Gupta <sumitg@nvidia.com>
References: <20231014105426.26389-1-sumitg@nvidia.com>
 <20231014105426.26389-3-sumitg@nvidia.com> <ZTY0gMOAKbugxDIJ@bogus>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <ZTY0gMOAKbugxDIJ@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|SN7PR12MB6766:EE_
X-MS-Office365-Filtering-Correlation-Id: 518cf3c4-46d0-4801-d5af-08dbd55924d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t8ThrPbXsYZ0SDdd3J3+e09Gif8JyFnk8XKeRpcteV9pqjaSf9mghh8uHcS1we/E2kH47Xzt/p/0owPoKD2Xt2xmlw4il7gYcfS7CQ/Bdic0EXyQoqEqj7CqXfaSQbykzdRbm5mZhc6ypAUR6rTSY0t43Rg3gjQMfqlp2t5CR3guAAPrVvoy2JK+wi3tKw28vyv3d8rtta9AAzXvyrzUVK41pe4lO7yribroJ7n1tQJaKcQbTSgwx1gIMg9L1L39pbUadLCHM0Nuc9tqfOTucdpwU++gfc5hbWp5MAdqKkHyF+cIwPdXgQHTthLTtBNb7V3lFEhr/fUfR8MZYKpEeJKk18WWaA20XAdjNzyeLqlTNZsGIB6Nfej3yNOGbGWKQp/6ZXZH5r4VVWYC9wBetJ9H+wNTNwt8yPjql9Jhv84oWbtUEyS/ZWqSHR4xDhd7010qb13YEl1PXOX+Nff/1fsBOuoUZeLXt1lJkNSkHjz4tXqkJPT5dYpK/cKjAlZ07+ck2uvqGLz2w/AUhj+XrN+VcJ1j8R88ggSPur8JTpyxo6ypTLx+hsOKWOmj0cr9U5NkcRjApm3jEGzOijzpNgJNlIBKkk9dc44/6BBiBJ8nkzzWj/Hfqfymc1ltWuyQl/42Tdd3971UDIr4NaICYJpShREzQQl+BX8GjxFnkPoQEMXmcVHqZB4no+nuKbrh0H+3BDnEBSRKm+8bNx00W6752CTj9iz+eOCCGFJ8DjVKpZianU7jHAY1XXYSWq1lxtsO4mW8r3Wyz44MTOhNrw==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(82310400011)(451199024)(1800799009)(186009)(64100799003)(40470700004)(46966006)(36840700001)(53546011)(36860700001)(40480700001)(5660300002)(2906002)(40460700003)(26005)(16526019)(426003)(83380400001)(336012)(41300700001)(107886003)(36756003)(2616005)(82740400003)(356005)(7636003)(47076005)(86362001)(31696002)(478600001)(16576012)(54906003)(70586007)(6916009)(316002)(31686004)(70206006)(8936002)(8676002)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 12:51:44.7497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 518cf3c4-46d0-4801-d5af-08dbd55924d0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6766
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/10/23 14:23, Sudeep Holla wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Sat, Oct 14, 2023 at 04:24:26PM +0530, Sumit Gupta wrote:
>> From: Srikar Srimath Tirumala <srikars@nvidia.com>
>>
>> Current implementation of processor_thermal performs software throttling
>> in fixed steps of "20%" which can be too coarse for some platforms.
>> We observed some performance gain after reducing the throttle percentage.
>> Change the CPUFREQ thermal reduction percentage and maximum thermal steps
>> to be configurable. Also, update the default values of both for Nvidia
>> Tegra241 (Grace) SoC. The thermal reduction percentage is reduced to "5%"
>> and accordingly the maximum number of thermal steps are increased as they
>> are derived from the reduction percentage.
>>
>> Signed-off-by: Srikar Srimath Tirumala <srikars@nvidia.com>
>> Co-developed-by: Sumit Gupta <sumitg@nvidia.com>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/acpi/arm64/Makefile          |  1 +
>>   drivers/acpi/arm64/thermal_cpufreq.c | 20 ++++++++++++++++
>>   drivers/acpi/processor_thermal.c     | 35 +++++++++++++++++++++++++---
>>   include/linux/acpi.h                 |  9 +++++++
>>   4 files changed, 62 insertions(+), 3 deletions(-)
>>   create mode 100644 drivers/acpi/arm64/thermal_cpufreq.c
>>
>> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
>> index 143debc1ba4a..3f181d8156cc 100644
>> --- a/drivers/acpi/arm64/Makefile
>> +++ b/drivers/acpi/arm64/Makefile
>> @@ -5,3 +5,4 @@ obj-$(CONFIG_ACPI_GTDT)       += gtdt.o
>>   obj-$(CONFIG_ACPI_APMT)      += apmt.o
>>   obj-$(CONFIG_ARM_AMBA)               += amba.o
>>   obj-y                                += dma.o init.o
>> +obj-$(CONFIG_ACPI)           += thermal_cpufreq.o
> 
> Do we really need CONFIG_ACPI here ? We won't be building this if it
> is not enabled.
> 

I think we can remove the CONFIG_ACPI macro here and enable it by default.

> If this is for some module building, then does it make sense to have
> more specific config ? May be CONFIG_ACPI_THERMAL ?
> 
>> diff --git a/drivers/acpi/arm64/thermal_cpufreq.c b/drivers/acpi/arm64/thermal_cpufreq.c
>> new file mode 100644
>> index 000000000000..de834fb013e7
>> --- /dev/null
>> +++ b/drivers/acpi/arm64/thermal_cpufreq.c
>> @@ -0,0 +1,20 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +#include <linux/acpi.h>
>> +
>> +#ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
>> +#define SMCCC_SOC_ID_T241      0x036b0241
>> +
>> +int acpi_thermal_cpufreq_pctg(void)
>> +{
>> +     s32 soc_id = arm_smccc_get_soc_id_version();
>> +
>> +     /*
>> +      * Check JEP106 code for NVIDIA Tegra241 chip (036b:0241) and
>> +      * reduce the CPUFREQ Thermal reduction percentage to 5%.
>> +      */
>> +     if (soc_id == SMCCC_SOC_ID_T241)
>> +             return 5;
>> +
>> +     return 0;
>> +}
>> +#endif
> 
> Since this looks like arch specific hook/callback, not sure if it is good
> idea to have "arch_" in the function name. But if Rafael is OK with the name
> I am fine with this as well.
> 
> --
> Regards,
> Sudeep

Will change the name from acpi_thermal_cpufreq_* to 
acpi_arch_thermal_cpufreq_* if this suits more.

Best Regards,
Sumit Gupta

