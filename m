Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9647F613E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345724AbjKWORw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345534AbjKWORu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:17:50 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C23C19E;
        Thu, 23 Nov 2023 06:17:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=em5LLrAz4DoNAM+RHUf7o6wlvaf15HO/yE9+VSeJb8tzhyjANJDxVtpmZAUJ2qpU+1HjnLDe+zhYYGlKmuVnFw93wjShpB+1iTFUCFWgEBBoi6lQK4BV0so/4OggjbQ5yXDK0Jx2B1FCA7jrM4gc0Rsi7qaK4Re8BsmSUkOD0a18bOmo9i10sfBQcWbApDTpQ5UptnfxfhUlRcBnWpEmSRognmW4ecdoTdUfKEyP/uYbBHfA/xCMtQYbJCAX/7XOhYc7mbApRTFjqV2A+3yp77RqMwwh3fwAQr1ZL+UIZ2X38MKDwOg8/RYZzBxsL+p06VFgQ67klkzOtWW0cJjl2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yv71PrJCMDp1YaR3fr+ovin7dssBb6PqrBXNPA0Tkc=;
 b=nOgcbZLVeGICJn3mLSFbCdlV1oe9lVyFT5KLI+wpzOrjlvA5i0z3NYbwzz+b3M82EdXWY0cC8pjmWswTxDic+a6Qo2H7yy/JQzgNFm5SkF3eXEk6gISRyOypFcKCpqoEebbkeGXSGEdNZgvLqmetoooDG+/tGWyKbszsuNDh00aJ/tuLjs0EF5mmJ1cwmz4G9uCJO0RQVEc8QdiyJshgZRWZXO7dweG8dZb9PyUcHBWWyee+ffp1sK8O8W21Ej3xTAzDfbf6jBCRtvZzR1uEEEgof0j08oJV7x9QwKO2MrE4j6ri0nqDReVCArGIWQlAcUco6hLmxInrfVUbGLIYDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yv71PrJCMDp1YaR3fr+ovin7dssBb6PqrBXNPA0Tkc=;
 b=pvAR5mV+FOtKOmQPZiAVz0VrHAlmVgdQ04gjaKNlV50OIgduFmEC4FliE+fo13LbLI24lRbtkD0OZvNtOoy+KIA3mDpcoeQMvFW3448J4EKUjAOPQoGjAG5Xg12ES3np2JQb//6BNVTyUnGn/xik/t2kLprKvKFqJEqlc1Y5Z7V6qtJr8dtAxJXZJIXvQY/XyqOTW/3vqot2kQ3d3FrTDqRrIO4aK/m4y7yti6OdgLCJvMvvqj/kCRCaFYgHKIztRcKnuQVtMA6myOERQmh/Yzzsl7RXAYf5mfOS5c4tXYh1pj9KJp8opsOHIWPeH19+VV1lH7/SZJuAn2KRqZJTQQ==
Received: from SN7PR04CA0095.namprd04.prod.outlook.com (2603:10b6:806:122::10)
 by MW3PR12MB4442.namprd12.prod.outlook.com (2603:10b6:303:55::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Thu, 23 Nov
 2023 14:17:54 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:122:cafe::cf) by SN7PR04CA0095.outlook.office365.com
 (2603:10b6:806:122::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20 via Frontend
 Transport; Thu, 23 Nov 2023 14:17:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.12 via Frontend Transport; Thu, 23 Nov 2023 14:17:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 23 Nov
 2023 06:17:48 -0800
Received: from [10.41.21.79] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 23 Nov
 2023 06:17:43 -0800
Message-ID: <0903863d-f5b2-6caa-c75f-889e47cab058@nvidia.com>
Date:   Thu, 23 Nov 2023 19:47:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Patch v7] ACPI: processor: reduce CPUFREQ thermal reduction pctg
 for Tegra241
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
References: <20231123121433.12089-1-sumitg@nvidia.com>
 <ZV9bGtUsjF1v1oIW@bogus>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <ZV9bGtUsjF1v1oIW@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|MW3PR12MB4442:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e794569-7809-42be-8b84-08dbec2efbbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qL5B66N/YYomB81EoKQZxgKlW/uq+mPpR5X21+iITIrW+7lzbNhwCSu9yPR8dwWSPNYymR6JUkfNXsBtGkMhZKARFlKWvdp4vomnCQB/GO19Iaj3/nKABGQEQHDPpbCnRSbsaR8K+hm7TveqpcsSU6W6nPLjL5vklHpeHkPnyKbLOejg6QYmdn+wyLkHHqWJtU1rhayKsivI/UNbesiDyycvixHKcFcKLqij9wPVBpHW5D0RlfStSeUAyHKdeQ2ZYi/lZ17kPWTUC0vm0BXFcCY2zjB2T9BTfxXTE7iqYSwlHl8Hc5xf9cGXBiAWYvsYs4q7aGzQjW9uEP3WOLG0N9ILlRPD+vr7Zu9pokOT84zvTAFtM87BeS1zUYnoDsQMmKS9OomQljcAppy521Oz1doKyaJW4RwMlVbZ0D7+X1xbBbMit6P31SYpYnvvGT8mVzumc8z4xaChDT4/bNLmUpBSxgG/rq0x8Sv9g1LU/wfhBxpQEyncuE7jJabVBZEIGlJtsbE3oysL7Kzh5QGe8Pdg3OVQqItuCn+B9lC7aXCcZUQk63Cazf+QFdZQaZSX222Py9UcUEj9aDOaJY+JAnJ2MeZF+Dv5rXRksseKq9iexwA7zFrKoNuL6frH1YsBm1tgWSYcoks7rOpw6AGZezJAJhb7RRVNGGh4jjha2unwmGK+YetslV13p5DoTHiSmNYdIj/D0B7rAuOWfkjgxWsqybzBhIM4bCg7+hmODdo2QaU8PoZVlCqgSoF48tH2heQJ6aRIs3VzlILD88RS9YGsRXteThEOYmeBCazDpI9Pt1IwQAs/Rkfm8P3ZuuZs
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(230173577357003)(230922051799003)(230273577357003)(451199024)(1800799012)(82310400011)(64100799003)(186009)(36840700001)(46966006)(40470700004)(40460700003)(54906003)(336012)(426003)(83380400001)(53546011)(2616005)(36860700001)(107886003)(47076005)(316002)(8676002)(4326008)(5660300002)(8936002)(41300700001)(7416002)(2906002)(478600001)(16526019)(26005)(6916009)(16576012)(70206006)(70586007)(31696002)(86362001)(82740400003)(7636003)(356005)(36756003)(40480700001)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 14:17:53.7870
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e794569-7809-42be-8b84-08dbec2efbbe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4442
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/11/23 19:30, Sudeep Holla wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Thu, Nov 23, 2023 at 05:44:33PM +0530, Sumit Gupta wrote:
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
>>
>> Sending this patch separately as the other patch in the series is
>> applied by Rafael in v6[1]. Revision history before this version is
>> in the cover letter of v6[1].
>>
>> Please review and provide ACK if looks fine.
>>
> 
> For arm64 specific changes(a minor nit below though),
> 
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> 
> [...]
> 

Thank you.

>> diff --git a/drivers/acpi/arm64/thermal_cpufreq.c b/drivers/acpi/arm64/thermal_cpufreq.c
>> new file mode 100644
>> index 000000000000..d524f2cd6044
>> --- /dev/null
>> +++ b/drivers/acpi/arm64/thermal_cpufreq.c
>> @@ -0,0 +1,20 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +#include <linux/acpi.h>
>> +
>> +#include "../internal.h"
>> +
>> +#define SMCCC_SOC_ID_T241      0x036b0241
>> +
> 
> [nit] We really need to find better place to define this globally and not
> locally at each usage site like this. We already have it in GICv3 driver.
> But that can come as a cleanup later if it causes issue for merging this
> change.
> 
> --
> Regards,
> Sudeep

Sure, will check and send a separate patch later on top.

Best Regards,
Sumit Gupta
