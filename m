Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98B27E69C9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 12:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbjKILhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 06:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjKILhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 06:37:12 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E93A269A;
        Thu,  9 Nov 2023 03:37:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xpkf9wfZJVZLOnbAzVNvBXONphp7J3v6xSu+RIhl8+po41TOKf25YQ3dKiHdGFT2QNT0Be6u8F+0i/Wj7HjYWkSHV/ZwCPY3QlJARXjXoVbZRlHBfBWOzpec09142wDiESlCbzbW3mU8AkikzMJhnu+17LryyBkycQTcDBQNihG5cGNqJ48/gmIV3+hwSM6Obxf7v42UMA5o7rENDZDVi7X6NsLg/q7Q8hcVVOdBnj0lVCkuFCqFOsoI5tPwLg769Go1WVbQfsd3joqKDFcNYvm9bc54tbRFQG3vRn6SNzpDNbhWcWIrtrQCbQNnfSdwegPDiTQYYxSpAIZVqjVB5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Na2msQSAmWfxUs73SyYJLFCD+NzFcs8CqrH+Jt1fMA=;
 b=WXuMshcXTXH2WWQqdqF7gJ/Nwnk4MzQWT3d5yoE0ez7yYX2m12JX4+Kw34KWNUn6QYET+mRIbYlFYcsVOswZYa1wlMSk6BhUm41LU21xEYXDlmsVjuga0MJiC4n2okqRDPvs1QQo3xWWzIRz7qk/PUCVnw8cixAvIwJslTAZwh6pwt6w2iAmgKI3EOYYCOJ8hG56VGA+HCH2ijh3b7hB3bgVKYB8xwTjTPpHsw7Z+Z9JJSaA907ZECm8r2CSk2JmWH1Paj6GxMRJ59qE/UsKudBO1d+nPRTBG38R3nGRDly2YciYExdEJ9DtvMTGKR73tFXvRgK8gl8A5QpWv3lZSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Na2msQSAmWfxUs73SyYJLFCD+NzFcs8CqrH+Jt1fMA=;
 b=Ks0cy16yLtU6LQ5ONQji2e5kHoNzH9VXNnzP4hKkqD/WQbljq6G3BRziIsIZUVoO1rvr+ag712Ue02O5K8Rp+Hy+G5aJMas4/qF25nQass2s2RXezrRj/sUFw/W5oAxQpXbo+MgUUdTPeo3r8jcEU9OY2LEf0eRq828YNM40c4BYBM4ytM/HCVo8+afT2Hcxb/xLjql+ZYwoyIr+6NjVcbN0RxVE+mtVvRnLFislUjvDyEc5d2EE/WXm/DzItQYZOUWb0W69Tx2/Nd/uoBm14RwHi/rQJOibQzkhVb1XAZZLuH/qUrP2qsNAO7DaRcaP3nZK42RnY64AeL6//N4UWg==
Received: from CH2PR18CA0038.namprd18.prod.outlook.com (2603:10b6:610:55::18)
 by PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Thu, 9 Nov
 2023 11:37:06 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::16) by CH2PR18CA0038.outlook.office365.com
 (2603:10b6:610:55::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Thu, 9 Nov 2023 11:37:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.16 via Frontend Transport; Thu, 9 Nov 2023 11:37:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 9 Nov 2023
 03:36:52 -0800
Received: from [10.41.21.79] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 9 Nov 2023
 03:36:47 -0800
Message-ID: <94a329fe-52d2-eb8d-9c6f-c1bdf59ffe44@nvidia.com>
Date:   Thu, 9 Nov 2023 17:06:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Patch v5 2/2] ACPI: processor: reduce CPUFREQ thermal reduction
 pctg for Tegra241
Content-Language: en-US
To:     Hanjun Guo <guohanjun@huawei.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, <lpieralisi@kernel.org>,
        <sudeep.holla@arm.com>
CC:     <rui.zhang@intel.com>, <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <bbasu@nvidia.com>, <sanjayc@nvidia.com>,
        <ksitaraman@nvidia.com>, <srikars@nvidia.com>,
        <jbrasen@nvidia.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "Sumit Gupta" <sumitg@nvidia.com>
References: <20231014105426.26389-1-sumitg@nvidia.com>
 <20231014105426.26389-3-sumitg@nvidia.com>
 <CAJZ5v0ivZd-+wRtCNE4t1P=SjJSEJmW6s7GyuYELWg-v87Tw2w@mail.gmail.com>
 <4fd879be-ae89-45a7-9607-b55606cfb3ac@nvidia.com>
 <7f17a560-f26a-eae5-f8d5-1f6602ed8f7c@huawei.com>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <7f17a560-f26a-eae5-f8d5-1f6602ed8f7c@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|PH7PR12MB5951:EE_
X-MS-Office365-Filtering-Correlation-Id: 1713bb87-4df2-4dd5-8472-08dbe11832ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aersys4RWAzOKRnl8cuLwZROXniqu2Q71LGdg3E/xLtbNFh0DRnQSNz/1RB5HdKqC+G5TjzhPZ5uQ22H08154ZwKPGXIbemX1JS2fLfNbY6LXa6LFCwSvevTbiToww3a85zVT8PS+kzCpthRK7fFrkuUnQz+6zepJjCMeXD06FAp2CegL1l+d5UTTZCwODsWauOuWb7Ys+iipg37c+fAxjABlhACGZeqST5S8aSZo+chDuisGkTk4kaxO197f+qQFqwc+G0vzKRJjnczji1r8dLyp6Ro8xUMjGYaPblF9qNPnw6T5mCqbGwqzy8tYCKRnsdbBbXZUmv5W89fzh/aLJr3ZbnkHBpyBICjbw+0svfUB5tMsxioCJfe1HtTvngre8J1P5qctDJ+xTJbmifaZsQRvrN1n4DG2OFLgdYMgLOQ3lJMXcSF8v9dGR10UyOhYZPcByB4XByL2LpPRxf3BE9JKUOWrywMD3NEZegn1tsaN0rEeBigAZQk9VCjM1mSnmonugtMgEmUHHXvGaUZdmSsIfRmRBx3jvRRFNmD9k3DqxwxISoOoI9T9JMV4pC93/O0qfHQH+RqljKvCdAXN+OI9aNe7D1Ykn+XFN6XzHv7hDth5HHw8ghiYU99B+b38K1US4TRFgWSZAfxjVstfEXmTIwChn5oNTl8kj6zJGkbobOxQtyaI6UgQ09ojSwahHR5Hk+TPy16wg/LBNNz74qCsCBOWjBSu+DFxBG3fSfgECywHd7Rx/MMrLS4u7KwG+Td8ILq4E1ayTmh1vykgN/5a5uKzX1V8vhXwysQYRZQErMlLpH8BmVjzf7JcZMnBM5kAQvEOcoJWT6qc2NJoEaHd8/oX3ta9tScq+uPv/o=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(39860400002)(346002)(230922051799003)(230273577357003)(230173577357003)(1800799009)(186009)(64100799003)(451199024)(82310400011)(36840700001)(46966006)(40470700004)(36756003)(41300700001)(82740400003)(8676002)(4326008)(8936002)(356005)(7636003)(40460700003)(2906002)(7416002)(5660300002)(86362001)(31696002)(16526019)(26005)(6666004)(36860700001)(2616005)(107886003)(53546011)(478600001)(966005)(47076005)(83380400001)(110136005)(54906003)(40480700001)(70206006)(70586007)(16576012)(31686004)(316002)(336012)(426003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 11:37:04.8936
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1713bb87-4df2-4dd5-8472-08dbe11832ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5951
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/11/23 13:20, Hanjun Guo wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 2023/10/20 16:30, Sumit Gupta wrote:
>>
>>>> Current implementation of processor_thermal performs software 
>>>> throttling
>>>> in fixed steps of "20%" which can be too coarse for some platforms.
>>>> We observed some performance gain after reducing the throttle
>>>> percentage.
>>>> Change the CPUFREQ thermal reduction percentage and maximum thermal
>>>> steps
>>>> to be configurable. Also, update the default values of both for Nvidia
>>>> Tegra241 (Grace) SoC. The thermal reduction percentage is reduced to
>>>> "5%"
>>>> and accordingly the maximum number of thermal steps are increased as
>>>> they
>>>> are derived from the reduction percentage.
>>>>
>>>> Signed-off-by: Srikar Srimath Tirumala <srikars@nvidia.com>
>>>> Co-developed-by: Sumit Gupta <sumitg@nvidia.com>
>>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>>> ---
>>>>   drivers/acpi/arm64/Makefile          |  1 +
>>>>   drivers/acpi/arm64/thermal_cpufreq.c | 20 ++++++++++++++++
>>>>   drivers/acpi/processor_thermal.c     | 35 
>>>> +++++++++++++++++++++++++---
>>>>   include/linux/acpi.h                 |  9 +++++++
>>>>   4 files changed, 62 insertions(+), 3 deletions(-)
>>>>   create mode 100644 drivers/acpi/arm64/thermal_cpufreq.c
>>>>
>>>> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
>>>> index 143debc1ba4a..3f181d8156cc 100644
>>>> --- a/drivers/acpi/arm64/Makefile
>>>> +++ b/drivers/acpi/arm64/Makefile
>>>> @@ -5,3 +5,4 @@ obj-$(CONFIG_ACPI_GTDT)         += gtdt.o
>>>>   obj-$(CONFIG_ACPI_APMT)        += apmt.o
>>>>   obj-$(CONFIG_ARM_AMBA)         += amba.o
>>>>   obj-y                          += dma.o init.o
>>>> +obj-$(CONFIG_ACPI)             += thermal_cpufreq.o
>>>> diff --git a/drivers/acpi/arm64/thermal_cpufreq.c
>>>> b/drivers/acpi/arm64/thermal_cpufreq.c
>>>> new file mode 100644
>>>> index 000000000000..de834fb013e7
>>>> --- /dev/null
>>>> +++ b/drivers/acpi/arm64/thermal_cpufreq.c
>>>> @@ -0,0 +1,20 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>> +#include <linux/acpi.h>
>>>> +
>>>> +#ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
>>>> +#define SMCCC_SOC_ID_T241      0x036b0241
>>>> +
>>>> +int acpi_thermal_cpufreq_pctg(void)
>>>> +{
>>>> +       s32 soc_id = arm_smccc_get_soc_id_version();
>>>> +
>>>> +       /*
>>>> +        * Check JEP106 code for NVIDIA Tegra241 chip (036b:0241) and
>>>> +        * reduce the CPUFREQ Thermal reduction percentage to 5%.
>>>> +        */
>>>> +       if (soc_id == SMCCC_SOC_ID_T241)
>>>> +               return 5;
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +#endif
>>>
>>> This part needs an ACK from the ARM folks.
>>>
>> Sorry, missed adding 'ACPI arm64' maintainers. Added Lorenzo, Sudeep and
>> Hanjun.
> 
> Sorry for the late reply, would mind giving me the link which the ID
> (SMCCC_SOC_ID_T241) is documented?
> 
> Thanks
> Hanjun

The ID is already used in file 'irq-gic-v3.c'. Please refer change [1].

[1] 
https://lore.kernel.org/linux-arm-kernel/20230319024314.3540573-2-sdonthineni@nvidia.com/

Best Regards,
Sumit Gupta
