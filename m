Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFFA782A6A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 15:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235387AbjHUNYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 09:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbjHUNYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 09:24:32 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2042.outbound.protection.outlook.com [40.107.100.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03A6CE;
        Mon, 21 Aug 2023 06:24:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPVLhif48DWgv066N6bMhUXqn27ryuDlFZASBkE92Yvv9CGvlIRHffQrrC/FHneh5l0FvRwsiUVMD49tUMO7lhdIc62STNjtDQHbSR7PFTc71ECq019fTIr+76vfXXvunBSW/aQeG+rqsR4eZ7mWVsk1uzaOWBI+DOYKEYpBTAxTdZa6BSUCWTnrdDEvZsvkq8sx5JrpaZ+McYZLN0oroZeoEaiACz1wARRvugEwNsPlF5Y8f2qDi3kzX5uWDuKo8DyHt4ov1tgr2OwjCGgy/4awul4vKacAgk/ErGqNnjW0X0SUVnW/cnNULfwPDxGrX68P4t8i72sMEygV5T5Wjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDZpIT3zL3f1kV1OplTws3X1idG7ly59oTANcv+FNDs=;
 b=MBDhajugmJCwNpimUEtNh5C1uytRtZA3HBlQZNxLPVpKy355WFTC7lZNGVpjjR9xOYxO6J038DpV+lPa1iEk58vvb0K2hsJDdmkZ/PpWgwF7kTpbxaaZZEh4M8WKw2PuCF+8gLhpqJCUaZVR2k6PFAm9AVdTCn6kPnl3g8NvxQVUU5El+GphzcVC3TiEaTMTH+RKaSS5fDRs7h8SfC2Gbp0OP4RfyAH33isSh59VgNZj+927dM4qVMmOf5JhB6W8uv/ezejQM+NOWECnPL51TciBrmTLLMEODqilK3tVbmrT1W36sfZzV2AsU4TB2qSQQbJcA055fEOz9usqfRDZcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDZpIT3zL3f1kV1OplTws3X1idG7ly59oTANcv+FNDs=;
 b=brI1hK9p0vbNlefaxFV+qj2BMEBh8Duslg659hmOlcA56B+rLBxeAFEa7zP8+Hbeaa+NTb8pLewvb0K5Hnb/cCg2qi6BNvLYLySpNFs2nZsBME+JEeYtf/QgAHI7IxKK6EkxnI3nx+k3cYc97PR2Ibbw0CGsJBYubkeGkcOudLKg0i3SgnKpLL6HbBQDoOdFnzhwa4XFznIhvZuo9rejQVw/LvTM6oIZLaGDBn2pcxNKjTdVpUXiQeQBznN/x1QK/RUtf0p20vfA7n8faSac+twpAjuyvKFBpomElI02MyDBF0ru1XkYNZe0rDjLfgKIwBtlAQGzGowx51aLxUVa1A==
Received: from CY5PR15CA0140.namprd15.prod.outlook.com (2603:10b6:930:67::10)
 by DM6PR12MB4089.namprd12.prod.outlook.com (2603:10b6:5:213::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 13:24:27 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:930:67:cafe::8c) by CY5PR15CA0140.outlook.office365.com
 (2603:10b6:930:67::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Mon, 21 Aug 2023 13:24:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.77) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Mon, 21 Aug 2023 13:24:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 21 Aug 2023
 06:24:15 -0700
Received: from [10.41.21.79] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 21 Aug
 2023 06:24:11 -0700
Message-ID: <63eea3ac-4714-2c54-c740-84f9f9e7fd64@nvidia.com>
Date:   Mon, 21 Aug 2023 18:54:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Patch 2/2] ACPI: processor: Add support to configure CPUFREQ
 reduction pctg
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <rui.zhang@intel.com>, <lenb@kernel.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sanjayc@nvidia.com>,
        <ksitaraman@nvidia.com>, <srikars@nvidia.com>,
        <jbrasen@nvidia.com>, <bbasu@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>
References: <20230817093011.1378-1-sumitg@nvidia.com>
 <20230817093011.1378-3-sumitg@nvidia.com>
 <CAJZ5v0hkm6eou9E+CVwasURjPG3RtVH+TMvvzGqVwQnDDrBocA@mail.gmail.com>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <CAJZ5v0hkm6eou9E+CVwasURjPG3RtVH+TMvvzGqVwQnDDrBocA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|DM6PR12MB4089:EE_
X-MS-Office365-Filtering-Correlation-Id: 9114d8dd-3e0f-4f8b-e275-08dba249f1a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: //GyECLmB56FIz1JuoyY7tgsJ150qVlLSBU/dMz6mXEm1hmM6397mq6/YtecCaxkMZbWRgz9jobiunOXuAHsn4FERlKXQqqLEcfbTi1zr43bPSJoh4lDKGlMhA5KyIpVYy4o2/t94pqGmbUYflZGNdB7igB0DXff2xz9JjPujeBoDA990+Mn4vMYv/WQX1KKQ3W/CMGaqqBtwWzPDjKhAQTBNT8R/WcgyCxFKvu125oTuTP03W+tAJ+LSeh4jLp1aAU0LF8aiI2mf3wpWNtJIuepH7FAwl2BwrtcXaVgyJ47rY0hrAEpjKsEOlu12ME0zBeNKVqBBHJzwZrnBElvhi+MY4Fwu0G1a5oWn1lsjktMR8JbazgnXwvV6pkkWD7NhCb8pxa/p3x1SBEdemINsj1f77wWuOqSyminonlu9h0D9/6Zk0Qnu+KwcdzoXj6PIgna7JtyomTO3+HGmNrh+pZpyDl8hOdn9FbCerhcWqOmbwlVftDmX/d+2AT29KgOzzhgH7cmZiNv7ik+fNTcv7svKuEBFkPZCF75vVNN/46Nxsym/PJ8qrY+WZbdwxoYR04385QQOg4IRHOyv5M14QnZYchqgKIXi9tvtnkkt+phy5Ya97fcdv8OpT1GnV+yTj1C39ZFhLY4Ftwv/eTthldLHjC2qgFXz1PIXECls/q5Zsg+rnXQSEGWkx7QfIvJADPJfTax6jqD2qKMmPIMQfrOwyZusedRgOu2E+iFiz74LeR6OYZdp8dvmfyoNpTa9ryqjpGUOmDxmzDa7Qi2rg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(82310400011)(451199024)(186009)(1800799009)(36840700001)(40470700004)(46966006)(2906002)(53546011)(40480700001)(83380400001)(5660300002)(336012)(426003)(16526019)(26005)(86362001)(31686004)(36860700001)(31696002)(47076005)(8676002)(2616005)(8936002)(107886003)(4326008)(70206006)(316002)(16576012)(54906003)(6916009)(70586007)(478600001)(82740400003)(356005)(6666004)(36756003)(41300700001)(40460700003)(7636003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 13:24:27.2209
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9114d8dd-3e0f-4f8b-e275-08dba249f1a6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4089
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/08/23 00:10, Rafael J. Wysocki wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Thu, Aug 17, 2023 at 11:31 AM Sumit Gupta <sumitg@nvidia.com> wrote:
>>
>> From: Srikar Srimath Tirumala <srikars@nvidia.com>
>>
>> Add support to configure the CPUFREQ reduction percentage and set the
>> maximum number of throttling steps accordingly. Current implementation
>> of processor_thermal performs software throttling in fixed steps of
>> "20%" which can be too coarse for some platforms. Change that by adding
>> new config to provide the reduction percentage.
>>
>> Signed-off-by: Srikar Srimath Tirumala <srikars@nvidia.com>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/acpi/Kconfig             | 15 +++++++++++++++
>>   drivers/acpi/processor_thermal.c | 19 ++++++++++++++++---
>>   2 files changed, 31 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index 00dd309b6682..287cf58defbf 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -254,6 +254,21 @@ config ACPI_DOCK
>>   config ACPI_CPU_FREQ_PSS
>>          bool
>>
>> +config ACPI_CPU_FREQ_THERM_HAS_PARAMS
>> +       bool "CPU frequency throttling control"
>> +       depends on ACPI_PROCESSOR
>> +
>> +config ACPI_CPU_FREQ_THERM_MIN_THROT_PCTG
>> +       int "Minimum throttle percentage for processor_thermal cooling device"
>> +       depends on ACPI_CPU_FREQ_THERM_HAS_PARAMS
>> +       default 20
>> +       help
>> +         The processor_thermal driver uses this config to calculate the
>> +         percentage amount by which cpu frequency must be reduced for each
>> +         cooling state. The config is also used to calculate the maximum number
>> +         of throttling steps or cooling states supported by the driver. Value
>> +         must be an unsigned integer in the range [1, 50].
>> +
> 
> I don't think that the new Kconfig symbols are particularly useful.
> At least they don't help the distro vendors that each would need to
> pick up a specific value for their kernel anyway.
> 
> I also wonder how the users building their own kernels are supposed to
> determine the values suitable for the target systems.
> 

We observed some perf gain after reducing the throttle percentage.
Currently, kept the default to '20%' as before.

Based on need, a vendor can overwrite the default value with macro
'CONFIG_ACPI_CPU_FREQ_THERM_MIN_THROT_PCTG'. Otherwise, the behavior
will remain same.

Thank you,
Sumit Gupta

>>   config ACPI_PROCESSOR_CSTATE
>>          def_bool y
>>          depends on ACPI_PROCESSOR
>> diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
>> index b7c6287eccca..ee443cc69b73 100644
>> --- a/drivers/acpi/processor_thermal.c
>> +++ b/drivers/acpi/processor_thermal.c
>> @@ -25,8 +25,20 @@
>>    * _any_ cpufreq driver and not only the acpi-cpufreq driver.
>>    */
>>
>> -#define CPUFREQ_THERMAL_MIN_STEP 0
>> -#define CPUFREQ_THERMAL_MAX_STEP 3
>> +#define CPUFREQ_THERMAL_MIN_STEP       0
>> +#ifdef CONFIG_ACPI_CPU_FREQ_THERM_HAS_PARAMS
>> +#define CPUFREQ_THERMAL_PCTG           CONFIG_ACPI_CPU_FREQ_THERM_MIN_THROT_PCTG
>> +
>> +/* Derive the MAX_STEP from minimum throttle percentage so that the reduction
>> + * percentage does end up becoming negative. Also cap the MAX_STEP so that
>> + * the CPU performance doesn't become 0.
>> + */
>> +#define CPUFREQ_THERMAL_MAX_STEP       ((100 / CPUFREQ_THERMAL_PCTG) - 1)
>> +
>> +#else
>> +#define CPUFREQ_THERMAL_MAX_STEP       3
>> +#define CPUFREQ_THERMAL_PCTG           20
>> +#endif
>>
>>   static DEFINE_PER_CPU(unsigned int, cpufreq_thermal_reduction_pctg);
>>
>> @@ -113,7 +125,8 @@ static int cpufreq_set_cur_state(unsigned int cpu, int state)
>>                  if (!policy)
>>                          return -EINVAL;
>>
>> -               max_freq = (policy->cpuinfo.max_freq * (100 - reduction_pctg(i) * 20)) / 100;
>> +               max_freq = (policy->cpuinfo.max_freq *
>> +                           (100 - reduction_pctg(i) * CPUFREQ_THERMAL_PCTG)) / 100;
>>
>>                  cpufreq_cpu_put(policy);
>>
>> --
