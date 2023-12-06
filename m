Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579F3806B9D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377541AbjLFKOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377395AbjLFKOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:14:15 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C6A10E7;
        Wed,  6 Dec 2023 02:14:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dc54RT1ZIqtddVhLiT2OGbclY06uX8B+f2YI0jrr4/pXUHPQpm13SJQWN74qG47fIScwPVTvaqyyEm4YBXUDG1t77ppRP5MKqHjNuNOzSTfSZwi9mZZIbttMGiTyGuZWbtKF9OQ8hfc9gnO5oJGrhQu4McpP/DRYqmuv1p3dl0DfTxe91uPpbioAsuR65UW16ya9FkkDlUVPM2Fvf6Wb3Poccia6BHW70AH7hpHjax9Upcy3PmuH7iK6qOXvrTTSxWlqNZSgGVPAia8xrTg44RYzQAcLPjexbrc3vh2gmqWIrOLwHWbsxAN/4Ejd50wIi9AWl1Aun7kopdGitbBICQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+R6R5QRMx/gk3jD1WOGmyo6xeaSQOeCpkP4sEHifp24=;
 b=Fr/l9NRtP4SckzD+4FOVPUGFDeup2+bY+jVgUB9UtU5NY8b4cCYWDMxJlN7GI0wRBeAaBL6NyA8rqQXbvf+wUgml9kTAMIo1MSTeuirOrb5JhgXJGflzNuc8fhRcn16b0bosR7wuE3eUyJaEft9DaIbasLeXAXqX9QY2+1/Z9+2a/uA63EJeoMiLUEEQkLIm+NGkXpggpBn3x4R0QW/hhbolvaez6w4/IoZOWk7g/Ih2bd1o0m7QbsnAviPsGv0UzpVmLVNfxNA7r8tvXFc9Mrvh1qB1w3df/3Z9IKKKptdvludmZzzZLgdbxB6EmU5YplYgmzDRcJc7lnWH58N8Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+R6R5QRMx/gk3jD1WOGmyo6xeaSQOeCpkP4sEHifp24=;
 b=L168jq3+gGnuz8a+bk/UTvWsbjoxpKv2NenhcXom35C8S8D9GczOJc+sR5x8hIy6W5TH1sjukmlSAypdl9LQhztxLYDreL0+pK2Mpxpypo3AEVdEgmjO4HKtkJ439Xb/R8YXKIYOf40XtYa0N+BTGFknOw1JuANlQAwITZE257IQck6FzfDyG1xDTsmtie42vUP9nBINl0nUl/eNh7VeHVd1ZdLiS6M0p0cejSZEFQe6tpa57PHiY5U7ly3+JwDxkd2q2AYnX00ZcM5+LEJEEczVjTadnKUvjkHDN0PyeVQdM1xapHd/EPBlE5Eq/zRth6NnOOo2miuIM5+cUBF9ww==
Received: from CY5PR18CA0056.namprd18.prod.outlook.com (2603:10b6:930:13::23)
 by MN2PR12MB4223.namprd12.prod.outlook.com (2603:10b6:208:1d3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.35; Wed, 6 Dec
 2023 10:13:58 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:930:13:cafe::dc) by CY5PR18CA0056.outlook.office365.com
 (2603:10b6:930:13::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 10:13:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 10:13:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 6 Dec 2023
 02:13:48 -0800
Received: from [10.41.21.79] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 6 Dec 2023
 02:13:43 -0800
Message-ID: <fd877ca8-6deb-9bc1-877d-57817a8913ac@nvidia.com>
Date:   Wed, 6 Dec 2023 15:43:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Patch v7] ACPI: processor: reduce CPUFREQ thermal reduction pctg
 for Tegra241
Content-Language: en-US
To:     <rafael@kernel.org>
CC:     <rui.zhang@intel.com>, <lenb@kernel.org>, <lpieralisi@kernel.org>,
        "Sudeep Holla" <sudeep.holla@arm.com>,
        <linux-acpi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <bbasu@nvidia.com>, <sanjayc@nvidia.com>,
        <ksitaraman@nvidia.com>, <srikars@nvidia.com>,
        <jbrasen@nvidia.com>, "Hanjun Guo" <guohanjun@huawei.com>,
        Sumit Gupta <sumitg@nvidia.com>
References: <20231123121433.12089-1-sumitg@nvidia.com>
 <ZV9bGtUsjF1v1oIW@bogus> <6ccd1598-3c8b-1290-9494-01a3cdbb3003@huawei.com>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <6ccd1598-3c8b-1290-9494-01a3cdbb3003@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|MN2PR12MB4223:EE_
X-MS-Office365-Filtering-Correlation-Id: e3591aba-e20e-4385-7fd7-08dbf6440f39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FVs6X2tHfCAUHgxL9pTIKRlcb88pa3VNVP18ovxMr780pvqiwwrkNIko7Cc0sQMfcGYzC5QLayPiY/DTOFpmc/3aR9PMZt86zJ+dsdmG12cpAiAyLhukWPCxxBCH0IipftD8A1T5AVFzQ28n38AGGPW9cmKhL09GW6RxodFQo2s09eypX+R8j4BGVm6o90iwITD7OAYliCfBQmunkfRwEFwuFJUKjaAAFCorX6jgwBJn/vz0BJSPKGh+/LqLYjqddYM8szCbH526sf2XPX8gpFX97MnCzHwE66TQOgZYqVuDs4NOQbJ1XJiQGGnSuGJRxcN3Uob3ntCf44938HKh3nI30rZlMYKrJeyrb4TMmK8r6aiN1kkDJsGqTF0PQr9CwfQQsu9f8d3u8GtMZfCR3swvzaiFqjm+IYGO64RiNXlvfEYD+9a8eqOkTJGOCYkbChTHqkKywFQG+ndQUlX1PLxPNPq8Pbl3sgFviX8Z6snQGsGoUS/7MuLSFcTDkghJ8DHzAS/OJZLuGBKDqdyEC8VAoyPLba68YSd/liCAsMTOttw7hC0OxqjfDsg88XZK2jAcNmUwskfvZwAmVfP1W/9KLGwi7H6BPaVgs2wnhw1DcmuqdJl7H1AgZqRx3et+hrnOQiPgplx804Nh0V/ddeK/lNv7trk7vJ9+HH1C8pNUveIIxeyDxIWSqZCgjO+txyt4IgE3j9BgAbWrA71lQh/avdUNH6cL2WGLrdxy9WAgY75lVJ9E3+FWT5xj9Rw2M+DtY4IQg+L2G8vG5tTqBg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(64100799003)(82310400011)(186009)(451199024)(1800799012)(36840700001)(40470700004)(46966006)(478600001)(2616005)(31686004)(16526019)(26005)(426003)(316002)(83380400001)(336012)(16576012)(6916009)(70586007)(70206006)(54906003)(4326008)(8676002)(8936002)(36860700001)(47076005)(5660300002)(7416002)(2906002)(31696002)(40480700001)(86362001)(356005)(7636003)(41300700001)(36756003)(82740400003)(107886003)(40460700003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 10:13:57.5598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3591aba-e20e-4385-7fd7-08dbf6440f39
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4223
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> From: Srikar Srimath Tirumala <srikars@nvidia.com>
>>>
>>> Current implementation of processor_thermal performs software throttling
>>> in fixed steps of "20%" which can be too coarse for some platforms.
>>> We observed some performance gain after reducing the throttle 
>>> percentage.
>>> Change the CPUFREQ thermal reduction percentage and maximum thermal 
>>> steps
>>> to be configurable. Also, update the default values of both for Nvidia
>>> Tegra241 (Grace) SoC. The thermal reduction percentage is reduced to 
>>> "5%"
>>> and accordingly the maximum number of thermal steps are increased as 
>>> they
>>> are derived from the reduction percentage.
>>>
>>> Signed-off-by: Srikar Srimath Tirumala <srikars@nvidia.com>
>>> Co-developed-by: Sumit Gupta <sumitg@nvidia.com>
>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>> ---
>>>
>>> Sending this patch separately as the other patch in the series is
>>> applied by Rafael in v6[1]. Revision history before this version is
>>> in the cover letter of v6[1].
>>>
>>> Please review and provide ACK if looks fine.
>>>
>>
>> For arm64 specific changes(a minor nit below though),
>>
>> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
>>
>>
>> [...]
>>
>>> diff --git a/drivers/acpi/arm64/thermal_cpufreq.c 
>>> b/drivers/acpi/arm64/thermal_cpufreq.c
>>> new file mode 100644
>>> index 000000000000..d524f2cd6044
>>> --- /dev/null
>>> +++ b/drivers/acpi/arm64/thermal_cpufreq.c
>>> @@ -0,0 +1,20 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +#include <linux/acpi.h>
>>> +
>>> +#include "../internal.h"
>>> +
>>> +#define SMCCC_SOC_ID_T241      0x036b0241
>>> +
>>
>> [nit] We really need to find better place to define this globally and not
>> locally at each usage site like this. We already have it in GICv3 driver.
>> But that can come as a cleanup later if it causes issue for merging this
>> change.
> 
> Agreed.
> 
> Looks good to me as well.
> 
> Acked-by: Hanjun Guo <guohanjun@huawei.com>
> 

Hi Rafael,

If the change seems fine, could you please apply this patch?

Thanks,
Sumit

