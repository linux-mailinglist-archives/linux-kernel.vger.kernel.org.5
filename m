Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708A87EF0AF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 11:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345924AbjKQKii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 05:38:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234972AbjKQKig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 05:38:36 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80ACD4D;
        Fri, 17 Nov 2023 02:38:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOvqTZHVa4lix9syKPt4shcH6LhMRPDZw1e0+ylWsTrxINMD0nTLyRF58kM2Q5De3VRP+RKs6Q3CKWUZZoGyL6D+okUujGwZ0zvIb4SV76R32K/rwHly0u9zDA/8dnukBvf9Q6Gga3hYsuNRT+qpdEeUqodNLPsdOTpXteHQ8b5E7LkHcJYwxjpqS2CLwfMAkYgC64mub2BYnJJWjHh+uxNfdHIjQZgbqaOSoq8luVIe9zRY9LIliHYPvqVB9iV9F9zDpLwB/TIFVMOAQ0jCFVI701eia1/EiqhERLmazcGbJuatO8UOEr0Tph+FoUuPiTM0eJkDc7wYRacx2yYyag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4J6mzjOC51bHlnWkNkFsK9sqod8LcIKsIgJMP2rilM=;
 b=U5pPLPj4ppN7lrn6A8NFt2LpiYDzFWW/R2fV3diODXYkTzqYDH9P70lUNpRLNJXYk5mC+AXhWPGF9WvN3fm0QQrtrQazZZKcSR862H4VNKTTkS+x799WVy55lD8Tdt/rlbIAxKu8lMXLKhTHwCdSCcvObUNxmZjnYIlneHj3wHlpeRjE5ziSl209J9vlmWxycCKsyGQ8JOZIreL+Bve6OW9NNg7YmUtQZsDIJYc9SMm2jmMS+Z/hEMVIbKGQmtAC08W6v9r53plmU1mk4X8eHj88o1iDJkdBgsb88OIJfFOVL97qvGLwM51bnUtIuMiN1kwVSNF6Ewjs9P6zuLLbWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4J6mzjOC51bHlnWkNkFsK9sqod8LcIKsIgJMP2rilM=;
 b=ogThwPXgWw3SQEATS0Surun68KUaGVHcNRflO0fhazsmuHOtDC59os6EyO3dmfoqievs2YBgE0xNTq2VDAgETj6dJreaCATq47uIsUV2yTpPIjXlhurlSLnTXZeyVa1XHoG5vnG7arpTWH2ZnSoVtTzD2OeODQ0Ctb4mmViuwEKqGLEMntBj10EJYgCVSemMvH5Pkxye0a4Wtkq1fi2ouH2U80HCzEfdPX2sA5fJYAeqVYGBDEShdrfPsSbfXz08A8bZnqOqglzmDJ1TZUTBk2InAYoaCrBwagEmYQ3pySEtLJCH2qKf5RoXAg/Z8GaSB1ySHkOZdLIOWnyWD38Tdg==
Received: from PA7P264CA0009.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2d3::7)
 by SJ0PR12MB6759.namprd12.prod.outlook.com (2603:10b6:a03:44b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18; Fri, 17 Nov
 2023 10:38:26 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10a6:102:2d3:cafe::25) by PA7P264CA0009.outlook.office365.com
 (2603:10a6:102:2d3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21 via Frontend
 Transport; Fri, 17 Nov 2023 10:38:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.12 via Frontend Transport; Fri, 17 Nov 2023 10:38:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 17 Nov
 2023 02:38:10 -0800
Received: from [10.41.21.79] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 17 Nov
 2023 02:38:05 -0800
Message-ID: <027b049d-28ad-fd13-d581-cda86041f7b6@nvidia.com>
Date:   Fri, 17 Nov 2023 16:08:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Patch v6 2/2] ACPI: processor: reduce CPUFREQ thermal reduction
 pctg for Tegra241
Content-Language: en-US
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     <rafael@kernel.org>, <rui.zhang@intel.com>, <lenb@kernel.org>,
        <lpieralisi@kernel.org>, <guohanjun@huawei.com>,
        <linux-acpi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <bbasu@nvidia.com>, <sanjayc@nvidia.com>,
        <ksitaraman@nvidia.com>, <srikars@nvidia.com>,
        <jbrasen@nvidia.com>, Sumit Gupta <sumitg@nvidia.com>
References: <20231109183322.28039-1-sumitg@nvidia.com>
 <20231109183322.28039-3-sumitg@nvidia.com> <20231110101507.GB1505974@bogus>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20231110101507.GB1505974@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|SJ0PR12MB6759:EE_
X-MS-Office365-Filtering-Correlation-Id: 638cfd6e-01e9-4762-62fa-08dbe7595396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NMFSR15VS7sZh6mSZ5NK3XHbqYMLI3oQ1WPDXgsPNZTPkmKdYuilEPNUOlGd+GnxKJBgJ2NAeYkMIPo4JMeB963jrHN68DOQA/Tt9Hs26B/ETj5PYP5hnsE5M/vRrnZPqijnue4xElocWBx/OD2bLtLyW32fftMw4bDw2mEInVa4XNBdPEp3f4gw5Ea7WYlCOhuUGavzqN0B6ky2ihVoImWJgskQkYb4oEqsLej+ZpvV9W3qdHxhsWagQN8q1nuywURI2Xf2iy4II6qu5o2jWUBsGzIllh7qWxC9QDK3cwxiaIIjpUrR5c0mn+vpLehzCOV9KWviQ+YxeZ6LQFNB+CE2C6k+JeZkLx0BhpOeAfq1lcZ9D10Bf065kcBkOxHpY9vqasty5DU0wkGX69DSJhU0VoqPZOVZBOAeA8wQ2wE2S/oKD/8AVCAcNigkWW1+jUZ57lYQbwsWEQozHS0KzS99rX4JP7mV6dXSGp/fUJCDcMX7+sDxhkrOrZQLYfNCEpSPk5EltPX7b3mzB2m2Ab+Y7FZbHJO7dIOIwt07bPBraqLVFnDBLMsPVMt+1ti13ajYQQz4n248J7CR0dYDu1lyqO9oteTY/BSH/FSd+tVE1f80gfuFSNCfEwo30+Kxmjwe1xAFPSz9cylaG2qOOR10y0CqYw6kPx/DASNk9ihIcd0zvshMHUu47ofKvGoMTXjK1NmZ6vuaa+Nn0PBFUYApwhhrMTYu2Y24Z+lzuEca9LroKS7V+cH8cDexfjyNLeol9bPkONHPhaY2T6ChHw==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(64100799003)(186009)(1800799009)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(2616005)(36756003)(36860700001)(40480700001)(107886003)(8676002)(2906002)(4326008)(8936002)(31686004)(82740400003)(16526019)(26005)(83380400001)(41300700001)(426003)(356005)(47076005)(7636003)(336012)(6666004)(6916009)(316002)(16576012)(54906003)(70206006)(70586007)(86362001)(7416002)(40460700003)(5660300002)(478600001)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 10:38:24.2121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 638cfd6e-01e9-4762-62fa-08dbe7595396
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6759
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


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
>>   drivers/acpi/arm64/thermal_cpufreq.c | 22 +++++++++++++
>>   drivers/acpi/internal.h              |  9 +++++
>>   drivers/acpi/processor_thermal.c     | 49 +++++++++++++++++++++++-----
>>   4 files changed, 72 insertions(+), 9 deletions(-)
>>   create mode 100644 drivers/acpi/arm64/thermal_cpufreq.c
>>
>> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
>> index 143debc1ba4a..726944648c9b 100644
>> --- a/drivers/acpi/arm64/Makefile
>> +++ b/drivers/acpi/arm64/Makefile
>> @@ -5,3 +5,4 @@ obj-$(CONFIG_ACPI_GTDT)       += gtdt.o
>>   obj-$(CONFIG_ACPI_APMT)      += apmt.o
>>   obj-$(CONFIG_ARM_AMBA)               += amba.o
>>   obj-y                                += dma.o init.o
>> +obj-y                                += thermal_cpufreq.o
>> diff --git a/drivers/acpi/arm64/thermal_cpufreq.c b/drivers/acpi/arm64/thermal_cpufreq.c
>> new file mode 100644
>> index 000000000000..40d5806ed528
>> --- /dev/null
>> +++ b/drivers/acpi/arm64/thermal_cpufreq.c
>> @@ -0,0 +1,22 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +#include <linux/acpi.h>
>> +
>> +#include "../internal.h"
>> +
>> +#ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
>> +#define SMCCC_SOC_ID_T241      0x036b0241
> 
> Sorry for missing this earlier. Not sure if the above define needs to be
> conditional. Even if it has to be, CONFIG_ARM_SMCCC_SOC_ID is more
> appropriate.
> 

Will remove the ifdef.

>> +
>> +int acpi_arch_thermal_cpufreq_pctg(void)
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
>> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
>> index 866c7c4ed233..ee213a8cddc5 100644
>> --- a/drivers/acpi/internal.h
>> +++ b/drivers/acpi/internal.h
>> @@ -85,6 +85,15 @@ bool acpi_scan_is_offline(struct acpi_device *adev, bool uevent);
>>   acpi_status acpi_sysfs_table_handler(u32 event, void *table, void *context);
>>   void acpi_scan_table_notify(void);
>>
>> +#ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
> 
> It looks weird to add a such specific ARM config option in generic ACPI
> code/header.
> 
> Does it make sense to add some new config this new feature you are adding
> or just use ARM64 and have CONFIG_HAVE_ARM_SMCCC_DISCOVERY check internally
> in the arch specific call.
> 
> --
> Regards,
> Sudeep

Ok, will use CONFIG_ARM64 instead.
I think we don't need to check for CONFIG_HAVE_ARM_SMCCC_DISCOVERY 
inside the arch call as it returns zero if the soc_id value is different 
from Tegra241.

Best Regards,
Sumit Gupta



