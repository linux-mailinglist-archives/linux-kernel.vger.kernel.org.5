Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0277BB00F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 03:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjJFBX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 21:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjJFBXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 21:23:52 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E1BED;
        Thu,  5 Oct 2023 18:23:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFVMAJRG3eAKGqlc4Iz85iKI/IOf18wkE3jGeV23AKL9D3Tfqq+lSH5ltSOZAx+D4OwmLQCIkjbIsuPMd3HSI81lRdAyUO9AGiVbaHAPTEvwIMfY5JXRiFONC/y6d0g5lK3uCIRaNAoK7jCXOHCD7+HVz2fBWm2O2B1Iddbh5KFQl9yMBw2l62uRjL+r6NTzfJCKju0Jssr/6IzqfVwkBYFKoXUt4h5EHyEan4JgHzmeg2GriYBMZK4m+7+Yd7+LUoWfEIYToRCOMW4NaoI6cDwcGuGv+gELLWuzjcE5rMPmPnEQ7KSXPtq6/YLTqkBTizqF1oE/3AMqnm4CC+EXqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mV9+34ehhT8U8RWPjqE1TbOEKqL9BioXhV8cgYJERiI=;
 b=DBemC4ZAKDJFxkx1ZUZziYrb0QfBs6R+geaD82jTlvfUfEC+DZ01xt9umeiBQUZdt1gIXys5IGyZjUzXNd2wWlbzPCxSb7j9XaG3WEw6khMl4cvIkz7T+OGpCSVdzIT+sG4gy4SeiW3u7CH8Q4BgVnmoSeW06ajGoUrI+CdncZgVgCN1wUmQYsyZgyLCR1FruyrNPBZEciSquGphM/4xsa7otv0gjmkMLCqfh0cOiDkzalHmKwC5Drd7CABlKtmZwMNOq46+xj530L8Q6EnqvXok1rx1LToirPjskhDFLOkevjHbeOqhEGyFss38pHauhe11oC2t7wkmDReFk+3rEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mV9+34ehhT8U8RWPjqE1TbOEKqL9BioXhV8cgYJERiI=;
 b=SoeQxsuzXkNbt3PUYat65+qqTWcmZcbDZvGp5vlHvmnyBrO6EwO2ywPKb9mxJ8gNAJMELxces8j3jT7qzxX1Fq2gY07gT2sHQXCKbr2u0WGe20u/O88UqkwunuFe059DzaTKNWOQOTUBiw3x/imGFM/13LWC4E0ygMkXiV+89ls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV8PR12MB9408.namprd12.prod.outlook.com (2603:10b6:408:208::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Fri, 6 Oct
 2023 01:23:48 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 01:23:47 +0000
Message-ID: <b2142a10-ba84-4a5e-aaae-a8b8cb036d7a@amd.com>
Date:   Thu, 5 Oct 2023 20:23:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build failure after merge of the pci tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20231006115604.42971aa0@canb.auug.org.au>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231006115604.42971aa0@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0037.namprd04.prod.outlook.com
 (2603:10b6:806:120::12) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV8PR12MB9408:EE_
X-MS-Office365-Filtering-Correlation-Id: 335c7e10-ec5d-49f3-dea7-08dbc60ae3d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yrCVivuqXn+do5M78+5UNRBmylam+xVQykPRAvFpm8wQHAxPB/W522z4satWaIcZNOntp3Yh1M+7auBfOzRe/+7E452gWF28GAAidV5o6eqsWwk61ucGxLbdp1jAvgjVJkZEdqEOJio+2EfrQ9yHiVzZDGvGLGfSeClYYAFbvPXxiQjnZoC5ckEn+Z6aW1BaB3j9xHuEgDLZOSBANQW4oi4dUuOA55ccpeOaQSVRP8V2/l1Os5s3A3jwfhy/NiKKlJN/+4ekhxpnWe+V+65rYJyTmnIelVR0veRx3cxS+sWT8PiRqhyLqmgysY0kqMvax5HgoMC0ld86CMQH+9Z8Oye1YGCBQXu+7SIwW0MrzoS52b/zrN72Is6HXJMUQEoFCEIggIZbU5/TODNtczjVp/osnTKajAOLiB3N20Vn8+nPxu5r5Wz7bU74xT+olaonrOQb4g6T4CXaZ28RLuf1cEKxlkyGpkfWdYOF99l77tyOzSx49v87WqwXroKEtgNrjKpWjJ150dYxfSpIBmjP1sHeKdIONyadg1iDpVeJLh0YXw7ovWJdqlfZofOG70u4/FU2xywQO3V7ticAFP8UYMKKIcbA4HA6rzKOg2kC3oAyj2WmiT1YCB5TuuzBeYzjshsGt+JjV9fro9AcgSonQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(346002)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(53546011)(41300700001)(54906003)(66556008)(66476007)(66946007)(316002)(6512007)(2616005)(36756003)(26005)(6666004)(6506007)(6486002)(38100700002)(478600001)(83380400001)(31696002)(86362001)(110136005)(2906002)(44832011)(8936002)(4326008)(31686004)(8676002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0RhL3dnNHIwSW94VGRhenQ2NE83cHZwdVAzNG1aR0JnQ210SUY4U3FaNmNL?=
 =?utf-8?B?eHdCUVVrWWpucWxEWWxxU1M5RU1NSGtCNHE2d2NCV1JvdmxVSTh4NUNLZDZv?=
 =?utf-8?B?b2x4OHQ5ZU85d0x0dEJUTDJLUkh3ZUUyVHdIbW9nQ1hzdEFrUGRwYk9nNGpu?=
 =?utf-8?B?NVgrYXpzR3o3RVBrRzdLOHpQVFRrdFVmUitFRWEwMXNYdmR0Z2tkdVhySTll?=
 =?utf-8?B?RC81RWZVZzFhcEZjTWMyUGhnYUVva0FvRkQ0QkpVeGVqTlY0ZzNFRXBjb05E?=
 =?utf-8?B?S2s4VXpwT08rUllVMVIxQ3cvc3lpMUthVzVMcUo0NWFLMUU4WHJQbFF6QzJh?=
 =?utf-8?B?aW9XT3hmTWJYU2o4c3NETnRPT2doa3VnRWkwVnRFa0F1cDVtNExCQmFkS01L?=
 =?utf-8?B?ekZxRzZDYUZnT0FDM2NnSHhYZ250YWRXdXVjRjRXenZZZ2NseWxVUFVrOVhs?=
 =?utf-8?B?amVVODBWd2JvUDhZZy9oZ20wMEFJREMwclBqeVlVQmhTRko2bGlrN01yWmw5?=
 =?utf-8?B?S2krelhFR1FXR0xlV09HaHp4UEs4d2FoRzlnK2RpNnRTWTZaVjFzUWU0YVli?=
 =?utf-8?B?ejBKL2ZWcUQ0SWpGY3dIakxyOHhzczdqT1I0REFRcTMrdHlJK21rTFRUcCt4?=
 =?utf-8?B?Q2x6eklRamgzL1FmRzgwUFZMQ2p4SkhUYkdmdDd2a2dRdWJIRkJZdEdubFZN?=
 =?utf-8?B?RDBTYUtwV09lWVBYL2xodHBubXZoM3g2NDAwc210dEoyT0ZiQjJEZFdjNnlj?=
 =?utf-8?B?UkNzbEVXNXJQK1lIOXlCRGthbU9hNHRGUVIvMTZYNi9ZMGlySGhJUnMvSlFF?=
 =?utf-8?B?Y1VsZ0hKMkxoTnY2Wk45cm5WVWd6K3VuN3V0WmFyTURXb21Hb3lMUU1OSmxv?=
 =?utf-8?B?cVpMVVNweFlDMkl2NWdGRzJrcW1waStDQnlHK1RLdVlaQ3NSdzNXVU5naFoy?=
 =?utf-8?B?aE9mR3oxQ1hQSThpM3NCZkgzVUFnYUNxeVRGcGV1MHNaaVBPQmxOb05tUEdj?=
 =?utf-8?B?S3VZYWYxRnF0c1NjTnh3d21WZTVscTI0dDU1WTlGUUxqUDRtU0J0Z21DeGhu?=
 =?utf-8?B?RnU4aUdEblQ1V1dQMVhObDZ4ZGxzR3JlaEcyQXMrWVN0YlJWTm5zaVc4eEhK?=
 =?utf-8?B?R2Q0VnRGVWJ1ejFDN1Y5cXlkUnE2MUtaWEpxeHo4aW1pRnFhaDhrWlNWbnpp?=
 =?utf-8?B?T3RQMDBwaGNyUVBmN211bTd6UjIvamJGRGlTZHR5WElpaUp3U2Yxb0NLeTVj?=
 =?utf-8?B?Tnl6RU1kTkIwdmMvK2diK2ZYNUVIdklUSGxNWWFmb3dLbGREVU9rYmlySHU4?=
 =?utf-8?B?alpRZUFHL0VOOVp3dFpjS1RXU1c5ck5tLzhyR3c4czk3V1JGdjl2UlYyNEtw?=
 =?utf-8?B?T3ZMZWNLS1ZKOU8xNUV2QWxuOWZzeHdQeEtXTlV0M2R1cGY2Z1EvbUlDdFhZ?=
 =?utf-8?B?N2ZyNnE5NDNaWHBlWEVoRlBwNGtwVWFUdW8xRVVYMzNKMDZzVnZQVXZyaVpx?=
 =?utf-8?B?UGREcDkrK0VSck9SbXcrRnY3N3JiTlBpNDMvQThUTE9ZMHM0Q3RZY0pRcDJn?=
 =?utf-8?B?amNBR24xMC9jems1MVlZdU1iZnJQVHhQNStURkhmNWRoMk9rMU9leGFwVlRG?=
 =?utf-8?B?MW5CSjQyWGdkY3pycVVYRnA1M1g5ckpOS0NkV3hzL1VJaHA3MUZrdU9UblpJ?=
 =?utf-8?B?REZTdncyVDRHdWdqTkI3MGtIZlFzZmJnZzk5K0hyRVhGZFdDUHJ2MzVZQzhk?=
 =?utf-8?B?YzhQZThCZ2NWeEdLcTdxTGEzNmFveW1wMWpiWmM2eHFzOTBhRk9EOXhNUUN3?=
 =?utf-8?B?U292bUxNV2pwbWNialZ4SUJRMEZSMTRDdENZZzJxWUt0YktwRTN1bVliZmc4?=
 =?utf-8?B?NG9RMzdIR3VhLzJkRjZCRUR0cFIwdVBuTUtoekZsM1haNHBBbGJpcmQ2NHdY?=
 =?utf-8?B?blFsK2M4d1dIcWpZc05Dd2tVaDFkWmR2TjMvUzhOZFZ5M0V4cjFiemNPaTlE?=
 =?utf-8?B?YlZtZ0V5a3pNY1VRUE9UUXI4N2xlT1hsblJPU3pUc1BFSVpUTTZpeDNPVEh4?=
 =?utf-8?B?a0JBUlFwcmlab3FYeUppR0xnS3VDOXJYNktRZzl4d0tObG9sVGQ3dUpaUjdK?=
 =?utf-8?Q?G8vCVmhxipnKlKZrwMwbZIPHl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 335c7e10-ec5d-49f3-dea7-08dbc60ae3d3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 01:23:47.9006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UNTV0g/qpVoI07eAgF6EcaRnELgk3pEiNkZKzSyrEjw/SCuiLI7UAxGXrOLaPD26KpDyFxdjqW0hgLJ0RZFZUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9408
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/2023 19:56, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the pci tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
> 
> arch/x86/pci/fixup.c: In function 'amd_rp_pme_suspend':
> arch/x86/pci/fixup.c:929:13: error: 'pm_suspend_target_state' undeclared (first use in this function)
>    929 |         if (pm_suspend_target_state == PM_SUSPEND_ON)
>        |             ^~~~~~~~~~~~~~~~~~~~~~~
> arch/x86/pci/fixup.c:929:13: note: each undeclared identifier is reported only once for each function it appears in
> arch/x86/pci/fixup.c:929:40: error: 'PM_SUSPEND_ON' undeclared (first use in this function); did you mean 'RPM_SUSPENDING'?
>    929 |         if (pm_suspend_target_state == PM_SUSPEND_ON)
>        |                                        ^~~~~~~~~~~~~
>        |                                        RPM_SUSPENDING
> arch/x86/pci/fixup.c: In function 'amd_rp_pme_resume':
> arch/x86/pci/fixup.c:951:27: error: implicit declaration of function 'FIELD_GET' [-Werror=implicit-function-declaration]
>    951 |         rp->pme_support = FIELD_GET(PCI_PM_CAP_PME_MASK, pmc);
>        |                           ^~~~~~~~~
> 
> Caused by commit
> 
>    624306d2c241 ("x86/PCI: Avoid PME from D3hot/D3cold for AMD Rembrandt and Phoenix USB4")
> 
> I have used the pci tree from next-20231005 for today.
> 

It happened because of a last minute decision to move to 
arch/x86/pci/fixup.c from drivers/pci/quirks.c when Bjorn committed it.

Here's the fix for it:

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index ee0509eb8674..f347c20247d3 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -3,9 +3,11 @@
   * Exceptions for specific devices. Usually work-arounds for fatal 
design flaws.
   */

+#include <linux/bitfield.h>
  #include <linux/delay.h>
  #include <linux/dmi.h>
  #include <linux/pci.h>
+#include <linux/suspend.h>
  #include <linux/vgaarb.h>
  #include <asm/amd_nb.h>
  #include <asm/hpet.h>
