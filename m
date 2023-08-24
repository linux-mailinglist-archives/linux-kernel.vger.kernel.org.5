Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2641478701D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 15:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241123AbjHXNSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 09:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241100AbjHXNS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 09:18:26 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FD3198D;
        Thu, 24 Aug 2023 06:18:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCXTFXyDyxF7DuTgES+pAZD3OVf/j/HAoZjDjQpGIxmTfu5zA9C0TjDXfCIiBhjruc4hfWY1qi0ySgEFA6le0h06bmdGLnwXw3mNLnhSdlcY+VlLvqRh/IWd9G8WMB7IW2Ba9b7uYNuK1PMQ2KPwaIHDRenGAv/dap4LORO4DWRyVv5J9IvaORr2tuQuHNYBxHD1n6mhizRt3J8VW0+YC1lwUxh4sWAWB7R7TnoLEJ7G6xIfODdsGCSa0beg84oQwdv7ZLug8BnMgsBJY2aAaP3bdD+5ITo/DnhKQ0SrmrLcXDTfJGlA53MfGyB9fWtX9QQOfkmfY/Uawh2/k6mbFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbmy87BFURB5psuKjpaHhZbimcVTQ0NyNrDtUbbr+FI=;
 b=dE7lSByqMJi/+IrcgY4qAmcEJHBblaixcMFLNPU0g3eHohAbByann/oiI3hE5cZeJjsSioXJCosQg3mbBiWEFpyMwTLc+kd9clovJ90OrfaLBJVzqiQ/jrWFZPEzZDs9f4llivtwfB08T7qdbXuKTzHi5gNjnmhaN8/x2UDV5Ax9TVGlzM6Ia7TmEbyjUllE75JMhP+gnTGiR7UfVGW882K9FUb5ZMRwteAE9ZPEVbRiLneghYU8rIqNHAWnN2tmuGqDIyOgnxLAVKKi0HIhOx8GYyrKxl11b8kdFuZzA2Z0SPEtDHSetvo35PCZI0MjUWsA+okG4mOLjNEHtSVZfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbmy87BFURB5psuKjpaHhZbimcVTQ0NyNrDtUbbr+FI=;
 b=NmYMo4sKdEv0LB6P+hApwRwVy/ktzreSjjYgl7+gIAocJBnhLf6jN2+V1IK0s17ZNLgLKMxn2QFlwf28FIxRTx2K3Ym5uSWw4B9/XCPIviMbcjDWbyCUjfrBrdfsmjZ3ogLsKsCZ8Rb7SoRR8jhIdOrEQfKk8i8zjIghHa+1XXvnqmcWycoxSIyqpunsHKiYWzfn8D2hySdYzmSmW+jN7098RAsZOhbD57jIPYH2XZ7pFCErG3pxXcNrZHwF2uJ/NmHtwoc+pltTpU/8Anrje2DtfAmyAVuhBpfaiNPSxRQbAfnSpNXgeuHXzYTyRQb3/ZVLlPZflW8W7viAM3VyUg==
Received: from CY8PR12CA0024.namprd12.prod.outlook.com (2603:10b6:930:4e::22)
 by BL1PR12MB5206.namprd12.prod.outlook.com (2603:10b6:208:31c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 13:18:21 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:930:4e:cafe::a9) by CY8PR12CA0024.outlook.office365.com
 (2603:10b6:930:4e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 13:18:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.78) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Thu, 24 Aug 2023 13:18:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 24 Aug 2023
 06:18:07 -0700
Received: from [10.41.21.79] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 24 Aug
 2023 06:18:04 -0700
Message-ID: <fe4e1458-c39a-339c-c7b0-1dfff8ed5c30@nvidia.com>
Date:   Thu, 24 Aug 2023 18:48:01 +0530
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
 <63eea3ac-4714-2c54-c740-84f9f9e7fd64@nvidia.com>
 <CAJZ5v0hBmOh3gOa71sAV1kbzCzoJO-gphr4CEgyA6+-+FquvOQ@mail.gmail.com>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <CAJZ5v0hBmOh3gOa71sAV1kbzCzoJO-gphr4CEgyA6+-+FquvOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|BL1PR12MB5206:EE_
X-MS-Office365-Filtering-Correlation-Id: 390fffac-04ac-40ab-720c-08dba4a496ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yuyinVYmDJt1O76cBv/udXIcmV9RNgNQ9qjpkIp5OSZizOJFXmHB54E9Kwo50bEFDEmMVBgruiYWlUvYuaBD0HG4Oa6I3ByE8ga4xa1XLaLR45c393GQ7yt9YaZcRm7wgLyWyDHatjHfPuOTpelmxRp1kpZ6JDNBT8tGAxq9NCjXxO+qEWk7TCrHe7UN22tzXWRDQrsUQRthMBNXE/28KBJJ+BwWhaWE8GzIlYPrj66cV/peRCgoo/8TyD8Zdgw9hoJgJR/vE4ZUuKplgQGOMGVQLh8IvLI8Ss8xfI7Hluclur0fx6v67gx7HM2a5F8RbAeeA8MY4Zh5XrhEt7kPvHvUECxFRivzxbjHWVVrPQL6RrJpRqkgQF+9xWCw0EMPgJJ92LPJpbCSK6i16csIaIZ5b6Q1qG7qT1Lk5ZJU1kDh34ohcKqHlXSUmcx7TrnLahLwrGUOb9xS1hv7UH1w4yjy417hfkmnheNdRZtbIPNznxM3bwOG5xZ78tTe3yD1u/1L1bhs6FuwLRv1UaqGTubl9F6FPqjbUkEyD+3M8ZV73NousyFoTmMbFsW7otX9ex7cHEUPi8xzbD0Vf6p/ag1Djp0uxhwU6dS7OXrN+NnpErKCfL/WrMBMqkPck3smmgh1ggzTwCE7JuGEMcP0iB0A6pwleSMOiMKl8p/syIfMQrWtaJEhC8cyzwkSa1BN9I9dy0Ivp4A2q2lWYCqHE9UJtEw1nNRsXr1P97Q485T1trGZ9ncLxNVrOsTm3bqi/YubSbZxG4HOnEXyIinx7eLf0S0a+1dDCFmNP5BMi/VCqylDTHbrAibJVc0WH4A+
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199024)(82310400011)(186009)(1800799009)(36840700001)(40470700004)(46966006)(54906003)(70586007)(70206006)(6916009)(316002)(16576012)(478600001)(26005)(36860700001)(356005)(7636003)(6666004)(16526019)(40480700001)(82740400003)(41300700001)(86362001)(31696002)(2906002)(31686004)(8676002)(8936002)(4326008)(66899024)(40460700003)(2616005)(107886003)(5660300002)(83380400001)(36756003)(336012)(47076005)(426003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 13:18:21.2043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 390fffac-04ac-40ab-720c-08dba4a496ba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5206
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>>
>>>> Add support to configure the CPUFREQ reduction percentage and set the
>>>> maximum number of throttling steps accordingly. Current implementation
>>>> of processor_thermal performs software throttling in fixed steps of
>>>> "20%" which can be too coarse for some platforms. Change that by adding
>>>> new config to provide the reduction percentage.
>>>>
>>>> Signed-off-by: Srikar Srimath Tirumala <srikars@nvidia.com>
>>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>>> ---
>>>>    drivers/acpi/Kconfig             | 15 +++++++++++++++
>>>>    drivers/acpi/processor_thermal.c | 19 ++++++++++++++++---
>>>>    2 files changed, 31 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>>>> index 00dd309b6682..287cf58defbf 100644
>>>> --- a/drivers/acpi/Kconfig
>>>> +++ b/drivers/acpi/Kconfig
>>>> @@ -254,6 +254,21 @@ config ACPI_DOCK
>>>>    config ACPI_CPU_FREQ_PSS
>>>>           bool
>>>>
>>>> +config ACPI_CPU_FREQ_THERM_HAS_PARAMS
>>>> +       bool "CPU frequency throttling control"
>>>> +       depends on ACPI_PROCESSOR
>>>> +
>>>> +config ACPI_CPU_FREQ_THERM_MIN_THROT_PCTG
>>>> +       int "Minimum throttle percentage for processor_thermal cooling device"
>>>> +       depends on ACPI_CPU_FREQ_THERM_HAS_PARAMS
>>>> +       default 20
>>>> +       help
>>>> +         The processor_thermal driver uses this config to calculate the
>>>> +         percentage amount by which cpu frequency must be reduced for each
>>>> +         cooling state. The config is also used to calculate the maximum number
>>>> +         of throttling steps or cooling states supported by the driver. Value
>>>> +         must be an unsigned integer in the range [1, 50].
>>>> +
>>>
>>> I don't think that the new Kconfig symbols are particularly useful.
>>> At least they don't help the distro vendors that each would need to
>>> pick up a specific value for their kernel anyway.
>>>
>>> I also wonder how the users building their own kernels are supposed to
>>> determine the values suitable for the target systems.
>>>
>>
>> We observed some perf gain after reducing the throttle percentage.
>> Currently, kept the default to '20%' as before.
> 
> So you should add this information to the patch changelog, ideally
> along with the description of the hardware configuration in which the
> improvement has been observed.
> 

Sure, will add in v2.

>> Based on need, a vendor can overwrite the default value with macro
>> 'CONFIG_ACPI_CPU_FREQ_THERM_MIN_THROT_PCTG'. Otherwise, the behavior
>> will remain same.
> 
> Yes, that's how it works.
> 
> What I'm saying is that the way it works does not appear to be
> particularly useful.
> 
> For example, how exactly is a distribution supposed to guess the
> "right" value for their general-purpose kernel?

We tested on Tegra241 (Grace) SoC with "5%" throttle percentage.
Didn't change the default value as behavior could be different on other 
chips.
An alternate way could be to overwrite the default value for the 
specific SoC using "arm_smccc_get_soc_id_version()" check. But not sure 
if such change in the generic "processor_thermal" driver is Okay?
Please suggest if the above sounds fine or any better way?

Thank you,
Sumit Gupta

