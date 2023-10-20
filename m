Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583957D0A8A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 10:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376476AbjJTIbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 04:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376466AbjJTIbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 04:31:05 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2DF11B;
        Fri, 20 Oct 2023 01:31:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixnnFlAQ+8k+UBCCZN3LVXRy5PzlfPEecoFVujI/wG9e9XBWx5LR154mUSDeHnucYySxNHP/oMpffacA0sjquZrL0VrFKBETa37+oz+4oljb/7NFp73/txcDNbkEudfYlRaD7TF0KSZ3StEY215TNhmALbCJ2UHWXT+ZMb6iFTZIT5fSR0YSojudWVMFImBqcxgEu9/XQad7qrlLD7ePY1jfLJmSexgY+UvI52pcCPBIi00gu/el2KjS3C7Bxl7FCu7M/bCppL5apRuzY+mj2E9hooWQgiFKSzyWuSWpqhX1QIRLW+y4nBSp+Q026Ct+iI+hFJ3CZ5RO3s14Unfy5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=snh3cZM/THj9CYNLu+IK+Y1RfKdowuOD3Ek1VU6fXbU=;
 b=gUH0BP6LCdsC5+0yPVPqiAeEqpjuxf3GSDLjFInwSu6zwAv7jrpqFRx0lL03DiF49V2AN0OxVbnk+StiDlA1GWWKn+zoMGEtDDDK/HMjcEqxkG+Dsqazy+1d1n1FpQXgSvhH69lNKoRim8ALfnP5EQppqGJdAEXyb2uahMdVih0UAFdKF6TxrI0g1kZGJXwgPu0Ymk3Y5bWbfgd9I1ydtnMDU62DABeXzH85Wkr33JTNbLsuY6bIf379gwG5U/nARbSXW6qp2gySm7LSOkheMbat8X5/o3PfPnzS1piBVTRuJmCaIYoFJuC0/ZtQI5m5N3Ug6+I05BTapTjFF5h5Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=snh3cZM/THj9CYNLu+IK+Y1RfKdowuOD3Ek1VU6fXbU=;
 b=aDfxm37l5Gep714DkEZQVNz6Qv13Xc/52UkzmUhtR+j82LeXvdTv/o1BQMOOKqRzVsbJ9+xI1DAtZgEO/nqIDno6ZXbYAiI3fhLIZoHqO1WvXoP1qX0AWwt2FmWp7crZb78XYJn9EU0eDIo4leRH5Cb/Be+F6TwzHo0aseUMyHFXW1CU5INef3+Hq68pyZXvRw1M/jKPSO7a3P6ZhLN49nGc+ORDwiORai1Yczb+TwBgKizqsGj/FJXECD6pCHMcIgYd+Ug9WpJpJ3D75A8K/ITI+IpH3HS6pnniCzjcIWE9uZkzvAPJy56A1PyY68bQzKvkKAV5PtHPjK64m6Nyhw==
Received: from DS7PR03CA0205.namprd03.prod.outlook.com (2603:10b6:5:3b6::30)
 by SJ0PR12MB5485.namprd12.prod.outlook.com (2603:10b6:a03:305::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 08:31:00 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:5:3b6:cafe::8f) by DS7PR03CA0205.outlook.office365.com
 (2603:10b6:5:3b6::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Fri, 20 Oct 2023 08:31:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Fri, 20 Oct 2023 08:31:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 20 Oct
 2023 01:30:41 -0700
Received: from [10.41.21.79] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 20 Oct
 2023 01:30:36 -0700
Message-ID: <4fd879be-ae89-45a7-9607-b55606cfb3ac@nvidia.com>
Date:   Fri, 20 Oct 2023 14:00:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Patch v5 2/2] ACPI: processor: reduce CPUFREQ thermal reduction
 pctg for Tegra241
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>, <lpieralisi@kernel.org>,
        <guohanjun@huawei.com>, <sudeep.holla@arm.com>
CC:     <rui.zhang@intel.com>, <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <bbasu@nvidia.com>, <sanjayc@nvidia.com>,
        <ksitaraman@nvidia.com>, <srikars@nvidia.com>,
        <jbrasen@nvidia.com>, Sumit Gupta <sumitg@nvidia.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Sumit Gupta <sumitg@nvidia.com>
References: <20231014105426.26389-1-sumitg@nvidia.com>
 <20231014105426.26389-3-sumitg@nvidia.com>
 <CAJZ5v0ivZd-+wRtCNE4t1P=SjJSEJmW6s7GyuYELWg-v87Tw2w@mail.gmail.com>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <CAJZ5v0ivZd-+wRtCNE4t1P=SjJSEJmW6s7GyuYELWg-v87Tw2w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|SJ0PR12MB5485:EE_
X-MS-Office365-Filtering-Correlation-Id: b2406880-96b2-4309-cf3b-08dbd146e3dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZnyctbFIZb5ckRqNhkrrx0Kgxdyw6hSCNEonZRSyHh9V0L1i6I5RVx3hrhXmzqubsz8BrIX7vC1FhaqdffnPv5qSLFg08MgIBKj5j/C8joWTQShUzjoPACHTttPQavIPT7Y51JxSH8EwYIfXRL773gkLxUZpU3w77EysB3aKaVj60dJlICHxkSIj2ieAxAU5iNw+yLDzL0T1+P7oco5K5z3voVDOhIlrTJGi8xu1iUeyZImDtqMStrr+BGyzvXLjy/TQPZvnd4Xa/zDke61apxZiyBOnRXhzfjtrwLPcTGhkQaThugTeBdk4Di2c652t4qN8kRrJIhxn34fUkS33tPFvZkJ2Z+zWCxKdUY04E8FP2aPUGyOFPTri8hPV360D3WZ69U/lAbkoF1H28qtaSwpLSdFsvoTxYhlx1zm/RHYxYnrYPY5YHzishVCJDdrSxerBXHJWkI1QnTg4ogI1ut+J49sLBhpDmC0ZaBdRsPOqRqc27Q9nqIFCmmtjobJ5L9xKU+JTaA2k9Rbhddhwms/OVnCybo3sjeg3B0/cxZgtogJ3y6rz2Mfge/imvlzZVS2QyZ+I6OsWjAfRUgBdMUUxTa+X0lycnWENZ0ZN5RYzhCWFhv0g1CHXEFKGqWnnXWaAGm2/T4bvdbbPFC3pfED3xqbBDdSKRA8X2+a/kJq6Ta/3rKyN5A/UQ6SxTRylYwA+rrgs6Xmoig4tSEq/izo/zoqOCVhXX/PYVMtb57XLqB/kfTuQMO1KdBVovvDYoBxB3PusbE+IBQEoZwHU7A==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(186009)(451199024)(1800799009)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(40480700001)(8676002)(4326008)(8936002)(5660300002)(40460700003)(2906002)(7416002)(41300700001)(83380400001)(16526019)(107886003)(47076005)(36860700001)(6666004)(2616005)(26005)(426003)(336012)(31686004)(86362001)(31696002)(356005)(7636003)(36756003)(82740400003)(316002)(54906003)(110136005)(70206006)(70586007)(478600001)(16576012)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 08:31:00.2375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2406880-96b2-4309-cf3b-08dbd146e3dd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5485
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
>> @@ -5,3 +5,4 @@ obj-$(CONFIG_ACPI_GTDT)         += gtdt.o
>>   obj-$(CONFIG_ACPI_APMT)        += apmt.o
>>   obj-$(CONFIG_ARM_AMBA)         += amba.o
>>   obj-y                          += dma.o init.o
>> +obj-$(CONFIG_ACPI)             += thermal_cpufreq.o
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
>> +       s32 soc_id = arm_smccc_get_soc_id_version();
>> +
>> +       /*
>> +        * Check JEP106 code for NVIDIA Tegra241 chip (036b:0241) and
>> +        * reduce the CPUFREQ Thermal reduction percentage to 5%.
>> +        */
>> +       if (soc_id == SMCCC_SOC_ID_T241)
>> +               return 5;
>> +
>> +       return 0;
>> +}
>> +#endif
> 
> This part needs an ACK from the ARM folks.
> 
Sorry, missed adding 'ACPI arm64' maintainers. Added Lorenzo, Sudeep and 
Hanjun.

>> diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
>> index b7c6287eccca..52f316e4e260 100644
>> --- a/drivers/acpi/processor_thermal.c
>> +++ b/drivers/acpi/processor_thermal.c
>> @@ -26,7 +26,16 @@
>>    */
>>
>>   #define CPUFREQ_THERMAL_MIN_STEP 0
>> -#define CPUFREQ_THERMAL_MAX_STEP 3
>> +
>> +static int cpufreq_thermal_max_step __read_mostly = 3;
>> +
>> +/*
>> + * Minimum throttle percentage for processor_thermal cooling device.
>> + * The processor_thermal driver uses it to calculate the percentage amount by
>> + * which cpu frequency must be reduced for each cooling state. This is also used
>> + * to calculate the maximum number of throttling steps or cooling states.
>> + */
>> +static int cpufreq_thermal_pctg __read_mostly = 20;
> 
> I'd call this cpufreq_thermal_reduction_step, because the value
> multiplied by it already is in percent.
> 

This is multiplied with reduction_pctg() which seem to be actually 
giving the reduction_step and not percentage.

Can we rather rename the existing 'reduction_pctg' to 'reduction_step' 
and 'cpufreq_thermal_pctg' to 'cpufreq_thermal_reduction_pctg' for more 
clarity. Please suggest.

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
>> @@ -126,10 +136,29 @@ static int cpufreq_set_cur_state(unsigned int cpu, int state)
>>          return 0;
>>   }
>>
>> +static void acpi_thermal_cpufreq_config(void)
>> +{
>> +       int cpufreq_pctg = acpi_thermal_cpufreq_pctg();
>> +
>> +       if (!cpufreq_pctg)
>> +               return;
>> +
>> +       cpufreq_thermal_pctg = cpufreq_pctg;
>> +
>> +       /*
>> +        * Derive the MAX_STEP from minimum throttle percentage so that the reduction
>> +        * percentage doesn't end up becoming negative. Also, cap the MAX_STEP so that
>> +        * the CPU performance doesn't become 0.
>> +        */
>> +       cpufreq_thermal_max_step = (100 / cpufreq_thermal_pctg) - 1;
> 
> Why don't you use the local variable in the expression on the right-hand side?
> 
Ok.

> Also please note that the formula doesn't allow the default
> combination of reduction_step and max_step to be produced which is a
> bit odd.
> 
> What would be wrong with max_step = 60 / reduction_step?
> 

The new formula will be applied only to Tegra241 as this function 
returns early for other SoC's. If we still want it to provide the 
default value of max step ('3') if the default pctg ('20') is returned 
by acpi_thermal_cpufreq_pctg(), then we can change to below.

  cpufreq_thermal_max_step = (100 / cpufreq_thermal_reduction_pctg) - 2;

>> +}
>> +
>>   void acpi_thermal_cpufreq_init(struct cpufreq_policy *policy)
>>   {
>>          unsigned int cpu;
>>
>> +       acpi_thermal_cpufreq_config();
>> +
>>          for_each_cpu(cpu, policy->related_cpus) {
>>                  struct acpi_processor *pr = per_cpu(processors, cpu);
>>                  int ret;
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index ba3f601b6e3d..407617670221 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -1541,4 +1541,13 @@ static inline void acpi_device_notify(struct device *dev) { }
>>   static inline void acpi_device_notify_remove(struct device *dev) { }
>>   #endif
>>
>> +#ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
>> +int acpi_thermal_cpufreq_pctg(void);
>> +#else
>> +static inline int acpi_thermal_cpufreq_pctg(void)
>> +{
>> +       return 0;
>> +}
>> +#endif
>> +
> 
> This can go into drivers/acpi/internal.h as far as I'm concerned.
> 

Ok. Will move this to 'internal.h' in v6.

>>   #endif /*_LINUX_ACPI_H*/
>> --
