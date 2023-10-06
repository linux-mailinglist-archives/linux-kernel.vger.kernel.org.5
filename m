Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967197BBB86
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 17:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbjJFPPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 11:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbjJFPPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 11:15:20 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C589ED;
        Fri,  6 Oct 2023 08:15:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ng2ypjX612H/jzB2ytWsRXYDW2g0k09NvLIoTR6G5/oit/yiWecnEu2EJOaoaI45s5G3zDN+QOkhlSNVULk1Tfnw5dn/VWeCE3xblfmNoUO24yxPN8O6YrzuOadNIO3GwN96kGY9aWF/KzUG/kiLYTPFLBh9cxs1fJuS+Sd9MWYCEE8MJ1Ym/69FaWPvwxDDqb3ln9P04+ORSNCLE3C8/9QzT+FE+BmAxc3EuoFIcCkt68vrCIzwijYTi2C4klLjNs4l9xlsihnIY2/HkdD0kNHt0t/OkynVdTispetAoXm17WuZaPwVIDUXesCwbW7Mj1eJbRoVUAwJ8b0VyWqnYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSwT6MFpwtGjJLKN/5hPfwBnARcc1hIrC4NKvbgyVzI=;
 b=NBb0RFmSXkVwmVq7g8D7bRPq/1tigI8k6+MNPA8/KvthKTNZhZbyKR2qa3IKWjRVVvYXNnavRTdznW/a87UWQ4FrmPfKzv5bUKnFnLSrILXEjXr5JhTAlRQGelLAcN0w9SKKPqBlDnpB0L4gS2vWrD7on5LlXZaV0SqM5/Quw81lz/azQplmXk4JPLBziMKHxR6siPCJJxwgbsOdOVOMyRhq608n1Kt1L+xYc+vTAV9V2goo0EfoQDiZPNGY6m6qVfWKMunAymcCbREps4GWM89IwyP8TKm8br58AuJmUpNcb1NDJ4g3T/DJT1Y9nt/Vh289t1Ozh/YKTR1oRgZcOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSwT6MFpwtGjJLKN/5hPfwBnARcc1hIrC4NKvbgyVzI=;
 b=YW3TCOORzRhgFQ858oyQZERCcHTYlT2lpb5O+nG0iqWuluxmnmp70x1m6wiw1YvUs+qX6Q65fEgU2IUD5jzEgwTK35ir87tmbhgNwoRDD8KQYL/L0kayGXOdHe5VDFUTtUzF1vLsL86zGwgaKsLhgG5U1BDp1yHTUkZd54WhHNbzyxBvO6LqHtRiIIUhhYHYm4KW/u/cTqoWMgmv+YoTpqekxXXQIdlg09vsexiXYXKdN7CbQIW9MJpC3h/JZRMYJsi3bvPze1xtbuTUpNcv3YMAOLX3rDsajfULdldsPSjBkJoubgqb2F+gxrhDpq/TBeiEEkWmIum6yj31mi+DnA==
Received: from PH7PR17CA0007.namprd17.prod.outlook.com (2603:10b6:510:324::18)
 by CY5PR12MB6250.namprd12.prod.outlook.com (2603:10b6:930:22::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Fri, 6 Oct
 2023 15:15:15 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:510:324:cafe::87) by PH7PR17CA0007.outlook.office365.com
 (2603:10b6:510:324::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.29 via Frontend
 Transport; Fri, 6 Oct 2023 15:15:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Fri, 6 Oct 2023 15:15:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 6 Oct 2023
 08:14:57 -0700
Received: from [10.41.21.79] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 6 Oct 2023
 08:14:52 -0700
Message-ID: <d0db37ef-fbf3-98f3-e3ee-13234cf39111@nvidia.com>
Date:   Fri, 6 Oct 2023 20:44:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Patch v2 2/2] ACPI: processor: reduce CPUFREQ thermal reduction
 pctg for Tegra241
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <rui.zhang@intel.com>, <lenb@kernel.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>,
        <srikars@nvidia.com>, <jbrasen@nvidia.com>, <bbasu@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>
References: <20230913164659.9345-1-sumitg@nvidia.com>
 <20230913164659.9345-3-sumitg@nvidia.com>
 <CAJZ5v0jcaskAa0DF3YjMEv=12d7bVst01iGKnKeVnhoUuOj6hQ@mail.gmail.com>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <CAJZ5v0jcaskAa0DF3YjMEv=12d7bVst01iGKnKeVnhoUuOj6hQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|CY5PR12MB6250:EE_
X-MS-Office365-Filtering-Correlation-Id: 4505881f-8ee1-4adb-8de8-08dbc67f0aab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1M1wswLB4ftUpACA/d4p8O2ei2VGePTMrWWt4GwJO0jP60vVvWvZdcwgdMCpyPO9lEQp6zNG48pcgdpg9tWs2xGFBsrypPOE1sTgIuJDD/DLWqPas0W62/HDyJ00oXY/pNhZEcwd98+lqNuobyHOW8i3WkXAspQ8xDeJFUkRnXE5b6Yj9CNXhBdWPATIiCWAnHSFgPc/ixr96ue66dBTB+vbeu+jwlmOuTgvl9HmfR4le1GQuCC95O+JyzhgM1ENeEERkTCoSdJaeYwQG2ZwJog7Dzun50WeFY54ErJgMV/2hlHngFBiGAOcq210HBhOvA4ieOhPJpktk8flaRffF/gG77becCkX7SV5CXEn8kB9vDn1JPiA/5cLPp8BJlMwlBhRwhmW6EoqaXrknZZaxNB8NKgwjeJ8yK/VrwoMC+bHdHy4SB4e4lK9YkWaOrjI+R9qRqRJ1IwrVhIIRybl0trVy6+J7GzW15WfpR/q44golxHj53uMh+7lholu4CEWi0GVT6dmQ4UljXqa0SiMhQfBPIiTA9vINSKeiIiG70WjcPYLU65x0v2CTr7heenfDLhnXbI9Hvakl43k9H0+l3LbU+PLodVk6fW2kH3wfBtMV9otIb/RAUIr8x1FeUgKbEwe7nXRfRXc+xKTPRK7L8er4A0S1tejQw/joAV9Ysr2HU4FQcB+3wQ4qMdKOz9XTjjZp7Xt1A2fdHdl5AwAOVcGJy1FzHrvOCmE/lBzc26lX5KwPTt+azDeK8/e3v4qxjTCG9BYt2y05wIxemQKsQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(1800799009)(82310400011)(64100799003)(451199024)(186009)(36840700001)(40470700004)(46966006)(31686004)(70206006)(36756003)(82740400003)(6666004)(31696002)(86362001)(7636003)(478600001)(356005)(53546011)(316002)(6916009)(70586007)(41300700001)(2616005)(107886003)(16526019)(26005)(16576012)(54906003)(4326008)(8936002)(8676002)(426003)(336012)(5660300002)(83380400001)(40460700003)(47076005)(36860700001)(2906002)(40480700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 15:15:14.3968
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4505881f-8ee1-4adb-8de8-08dbc67f0aab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6250
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/10/23 01:07, Rafael J. Wysocki wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Wed, Sep 13, 2023 at 6:47 PM Sumit Gupta <sumitg@nvidia.com> wrote:
>>
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
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/acpi/processor_thermal.c | 41 +++++++++++++++++++++++++++++---
>>   1 file changed, 38 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
>> index b7c6287eccca..30f2801abce6 100644
>> --- a/drivers/acpi/processor_thermal.c
>> +++ b/drivers/acpi/processor_thermal.c
>> @@ -26,7 +26,16 @@
>>    */
>>
>>   #define CPUFREQ_THERMAL_MIN_STEP 0
>> -#define CPUFREQ_THERMAL_MAX_STEP 3
>> +
>> +static int cpufreq_thermal_max_step = 3;
> 
> __read_mostly I suppose?
> 

Added in v3.

>> +
>> +/*
>> + * Minimum throttle percentage for processor_thermal cooling device.
> 
> + *
> 
>> + * The processor_thermal driver uses it to calculate the percentage amount by
>> + * which cpu frequency must be reduced for each cooling state. This is also used
>> + * to calculate the maximum number of throttling steps or cooling states.
>> + */
>> +static int cpufreq_thermal_pctg = 20;
> 
> __read_mostly here too?
> 

Added in v3.

>>
>>   static DEFINE_PER_CPU(unsigned int, cpufreq_thermal_reduction_pctg);
>>
>> @@ -71,7 +80,7 @@ static int cpufreq_get_max_state(unsigned int cpu)
>>          if (!cpu_has_cpufreq(cpu))
>>                  return 0;
>>
>> -       return CPUFREQ_THERMAL_MAX_STEP;
>> +       return cpufreq_thermal_max_step;
>>   }
>>
>>   static int cpufreq_get_cur_state(unsigned int cpu)
>> @@ -113,7 +122,8 @@ static int cpufreq_set_cur_state(unsigned int cpu, int state)
>>                  if (!policy)
>>                          return -EINVAL;
>>
>> -               max_freq = (policy->cpuinfo.max_freq * (100 - reduction_pctg(i) * 20)) / 100;
>> +               max_freq = (policy->cpuinfo.max_freq *
>> +                           (100 - reduction_pctg(i) * cpufreq_thermal_pctg)) / 100;
>>
>>                  cpufreq_cpu_put(policy);
>>
>> @@ -126,10 +136,35 @@ static int cpufreq_set_cur_state(unsigned int cpu, int state)
>>          return 0;
>>   }
>>
> 
> #ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
> 
>> +#define SMCCC_SOC_ID_T241      0x036b0241
>> +
>> +void acpi_thermal_cpufreq_config_nvidia(void)
> 
> static void ?
> 

Added in v3.

>> +{
>> +#ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
>> +       s32 soc_id = arm_smccc_get_soc_id_version();
>> +
>> +       /* Check JEP106 code for NVIDIA Tegra241 chip (036b:0241) */
>> +       if ((soc_id < 0) || (soc_id != SMCCC_SOC_ID_T241))
> 
> Inner parens are redundant.
> 

Removed in v3.

>> +               return;
>> +
>> +       /* Reduce the CPUFREQ Thermal reduction percentage to 5% */
>> +       cpufreq_thermal_pctg = 5;
>> +
>> +       /*
>> +        * Derive the MAX_STEP from minimum throttle percentage so that the reduction
>> +        * percentage doesn't end up becoming negative. Also, cap the MAX_STEP so that
>> +        * the CPU performance doesn't become 0.
>> +        */
>> +       cpufreq_thermal_max_step = ((100 / cpufreq_thermal_pctg) - 1);
> 
> Outer parens are redundant.
> 

ACK.

>> +#endif
>> +}
> 
> #else
> static inline void void acpi_thermal_cpufreq_config_nvidia(void) {}
> #endif
> 
>> +
>>   void acpi_thermal_cpufreq_init(struct cpufreq_policy *policy)
>>   {
>>          unsigned int cpu;
>>
>> +       acpi_thermal_cpufreq_config_nvidia();
>> +
>>          for_each_cpu(cpu, policy->related_cpus) {
>>                  struct acpi_processor *pr = per_cpu(processors, cpu);
>>                  int ret;
>> --
> 
> And patch [1/2] needs to be rebased on the current ACPI thermal
> material in linux-next.
> 

Ok.

> Thanks!
