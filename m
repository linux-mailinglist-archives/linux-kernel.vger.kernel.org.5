Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39CD7F4A3F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjKVP3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjKVP3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:29:33 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FDB100;
        Wed, 22 Nov 2023 07:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700666970; x=1732202970;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IUVhPChgD+18ZXF6gOlX9SuawTWJlVN8fjL7Ah7crBw=;
  b=DFEqovOnZIeP04gmncMuvgTK1XagdBlesTOD7lzf4Oq01UBlKnHEqJ/Z
   ka3yNQfnjSKM9RRhq9r+3HrgeGQsadBwP4wIGy2OWq9uo0lMO8lzpClMp
   zijVb/m2sr2AJeNfehZJIF1iAd6vZAhvJTWqxsPIVA1tUpNh4aPQioDk0
   nvwVoMWK+9c6cwydoW3MCfImYTkAk8TpaI1Mrl510hXAvtAUW9oae0Dba
   4kPk7Bxgrutfut0wzjKfoRixXCCDoxF78RbCquFV5JCjRVEn0qgK0JbrI
   XPAlWdB6mphnpzKztN5AQKuAMOoaluspPnA8GM0W7SRy1g+gxVitZcftR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="13619571"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="13619571"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 07:29:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="8500717"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2023 07:29:29 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 22 Nov 2023 07:29:28 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 22 Nov 2023 07:29:28 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 22 Nov 2023 07:29:28 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 22 Nov 2023 07:29:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fd3YQgnxPo01RTqyPK5MiHfNPOHHelM76BqlFFRJ509s84sdJc9JD6+rvvgjnZX8X1qKTu69DcssMnrGtM9gf1CMQIrATx1+arpjy9YdUywVsljQO6h+M0DU4Nt4IxVK1549mUgZyNiXbqf7NIvmXbDWzqlSl/TPYQz/ftHiYNJBItLbmKTMKu/4HqPa0prvWVK/oBg1iYw9yrc15ljm4uUg+TDMKx1HRehEHVyqGCSgETgq043VbAyT44YTTyHYs+YetImkGcyQLzE6krO/sDWr9IAEmhb+TH+9Z1zzS8F70s3GgOYnC/SmjiOlFbkntX/kvxy6Kg0uaCrhOdDLBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUEE80e1UpAC9R3r4Bh6TVG8oO5K0g3L50Rx9WRGhSU=;
 b=Hr/7G76tIkPAllcmOaAzRmkqIZKshlqr5EyU0xoFyUPxp7u8vqs4Sd4wCG11va0Ddmbis/jSMR/5+W1dUyj4f6IMgpns1GoIpoj3+pnUhg+RFwbxjo/c+0ns+2yg54dCR/m/fbryoTfSCKIdRL7zTRmJTK+yT56e1SpfSoUQ7F1y0IEqpYrGMy7qpoMvp09LXUhyZ9bTBgGZpwhoH0Fu1xNQsf+PQ4+sjYhpVTH00UT7Cjz29iQgqXQe65VRMf3dPnMdKj5XEUUCM+Y5pHTb2zSiYU4/Eoc0LuUGGwA6KLxPK4bxUlIRe5S5CLxtBQL39ElhRmF8Zxqrqp77oNko5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SJ2PR11MB8472.namprd11.prod.outlook.com (2603:10b6:a03:574::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Wed, 22 Nov
 2023 15:29:25 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7002.028; Wed, 22 Nov 2023
 15:29:25 +0000
Message-ID: <1a52cedc-ca72-4237-b038-f0cfd0db8b29@intel.com>
Date:   Wed, 22 Nov 2023 08:29:21 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v2] acpi: Fix ARM32 platforms compile issue introduced by
 fw_table changes
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        <lenb@kernel.org>, <robert.moore@intel.com>,
        <Jonathan.Cameron@huawei.com>, <dan.j.williams@intel.com>,
        <guohanjun@huawei.com>, <arnd@arndb.de>,
        <linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <cfsworks@gmail.com>
References: <170060515641.2447486.11798332619205301829.stgit@djiang5-mobl3>
 <CAJZ5v0hkGfqzHwmhBKqwhcEchncM6kEgx_TJgJGgjiR5yMZkLg@mail.gmail.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <CAJZ5v0hkGfqzHwmhBKqwhcEchncM6kEgx_TJgJGgjiR5yMZkLg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0136.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::21) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SJ2PR11MB8472:EE_
X-MS-Office365-Filtering-Correlation-Id: 79440ab2-7320-455e-3741-08dbeb6fcf21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VxjMka/yyZyhDv2Xs+6I+2QYoxa2+dU6WVnATTZueFA4gzrlSwiSzVDr0jwvtW5CsySvwcY2TO41KvlsYR9e6C/BtPXB7IPNsD2foSD7Rf7mMKBPMRxLD2/xGNZdYshUoxa1bhplYxj28UiP2qu/M7TGjeqNSS7ehB+EG4dJXAjBJOLnWIkQcPQAF422e4edLbt9G8U99syUGtSmjfB747l/1KbG+hKJF+kDUNvZa2XKX3M2jZdBWmkw/09ZGW28STBAcaDlSLQzsLFuRP4GZ6bByred2TAAFlIO37vaLRMfQlCpTfkyL51aV1E2ybjTybvfoLjI+pCKZ6pUVKfe6CutvOalJCph73aThs3lEFkHnkbHxopCg4l14DAL2a+5VI+i/33xLRyNhrwW1wAghQ2BP0jMGRrOy+BEErOBQeUARKjFMoK8rlesCremsB0pXtU1Mzob3ACxs1Gk3/9RkGzgV5aS8Nr3JAV2K7TkbxsBlsDM/Ej1o+Rcxs16AvkH3ySdrTr4atzcFmQl2V+5VtzZg2WrHZDPOJ/VVpcxJDl1LIg+IGDFBrWCWDTlvntLJ/re99rF/AtLkIaxVwB7HOeau0Ehz945n7RHryRsTdc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(5660300002)(7416002)(6666004)(966005)(38100700002)(478600001)(4326008)(6486002)(8936002)(31696002)(8676002)(86362001)(44832011)(2906002)(66556008)(66946007)(6916009)(316002)(26005)(2616005)(82960400001)(66476007)(36756003)(53546011)(31686004)(41300700001)(83380400001)(6506007)(6512007)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sm93L2xrYWEzWlNadUY3WU5SY21HQTFOWXFSWlBFeFpTUnllYzZycE9SQlYy?=
 =?utf-8?B?V01WQmxiSjlkVUZsT1BuazA0cUtyY3NaeWRvRTZRd1d5WEZHODRXQWhrM1or?=
 =?utf-8?B?MzdISWF5dzd6ZmlIbjkzd2JVK1FLakowK1M0VU1QUExlREJHN1JISFdBVnU2?=
 =?utf-8?B?UlNmMG9uUXZ0amxLMnlEbzJIYjJGb0JsalZPTE1wcEg2T3RHWUR5aXU2RStS?=
 =?utf-8?B?eHJiaTcrYWdjRk9aYWYwbGdaWkdmSGhEN0E4VDl4U1dZRk5XeW9GL0MvRWR3?=
 =?utf-8?B?THFVR0VXUWVIRlNQdEllZ0tiZVBkMFQzV0lFTVhHV2tOd2k5UkU4U1daZkJ0?=
 =?utf-8?B?ZllpVUQ3U2Q2SEhtZHllSW1FeEtPVHMxNFdtT29xRXlMK21ZaVV6dzhYbWNy?=
 =?utf-8?B?WmpKdGhLRXpQb1JOa3J4a1d3ajB2S3NXZWNsYWNCaXEzN2JJR3FUM0V5SWp5?=
 =?utf-8?B?MlI4UVc1TU1jcG9KUEI4bHdWajNSanMrZE10OENtN0VYVlBBektuOVVMVUVS?=
 =?utf-8?B?aGxZRXpwMTFScmVJTTZSaGxleGZOWFBtQk43Qm1QcFdiZ2E4T2Q2TjlheDB2?=
 =?utf-8?B?ZGhNVjdmdWFOb2puQlRnWXYzenF3WFY0UnR3c2Zwd3pkVlFsK2w5c1pXS0Vh?=
 =?utf-8?B?MEllMW9XWUZRNWlNUXVLQ2puT1JlVVZGbzJDZjk5WncyTzFBMzhIY0ovV3dr?=
 =?utf-8?B?QVkrdXV3T243TS9aTFAxUm1xSDF2TldKUlJ6LzdPS0VrTlE5TUpSME1HRm1U?=
 =?utf-8?B?MDRReEZ0YTNTcjJ1a1hobHJOOSs1TjUxeWROV0RxVWs2RS91SERYWXJJMTdD?=
 =?utf-8?B?VVNFQXJHTEJmZ2p1cUJwZmV6c0RJQlZOYWJ4YlEreTRoRDFTQW96MC82OFR5?=
 =?utf-8?B?RVRIblh3UGIrSVpCRXJQSTE3S0lBRzJMUjlwbExrRkhvTENjaFp4WnN2a2Mv?=
 =?utf-8?B?TS8xMVpsaFR1cmF3THZXQU54dzVhMmxHN0J6WkxIbFRtcTUzdkFmTWpHZnFU?=
 =?utf-8?B?VUlEYnM0YTRvL0piMWo4cUNUbkh4bmxlWWtTbzlFWWlwQXFDem02ck01b1Ji?=
 =?utf-8?B?OGZNbzVJd0p0d3BlVGljNzBTd21vdjkvc1ZSQ3IzNCtrTkFoaFlLdzNvZkxV?=
 =?utf-8?B?VG45dXF3U2tjLzZYbXp1aGhpMU5UeWdJc1JrZ2FhQVRTSkt4cFBWYmRlcWxl?=
 =?utf-8?B?RUF0a2xWd3AwazFCWS81alRCcFlBa3dWaEppWnliUzI4RlhnYk9YNTM4U2Na?=
 =?utf-8?B?TEMzb2FPNkw0ZmFSYmYybTYrSVhCVFZoYzFjckZ6Y1ZTOTMzbHdiWDBiU2ZP?=
 =?utf-8?B?dTI2eVJtSnQ1VkNTSm4wT2QvdWxuNm5KeXNNSk9ReDVvTklkQ2szS1VQSktC?=
 =?utf-8?B?b1ZEWndEa3RSUWd4V1V5QkcxTjlwWitvOFNEdVd3M0lFZVhzaXRFMzNLY1dm?=
 =?utf-8?B?Vlp2aHQ2bU5KQVMvZWtNbmYwenp0TDVhSGlEN3VGdXBZQS9BWXR1V2Nndzdy?=
 =?utf-8?B?L2RsaGwxdDNvU3hrcFJ4ajE0bm1YbmVvbmtjSXE2WkV3NzhscDYrYjhCK1VX?=
 =?utf-8?B?R1JsYjF4QVE4RE5HV2VJVUNuTE0yQVBQN2FrM3MvSTdVelFEdjQrU29lM1Rx?=
 =?utf-8?B?Tm55QVU0ak5yMFlQSFFFT1p4VGVIVVFvcjF2MWMyd1FaTEN1eTRIeHgwSTUz?=
 =?utf-8?B?dHkrVWpEa2hLQkdQTyt6TmhwWloxSTlxWmQwaEpScTgxbkhMek5odnJzNnZP?=
 =?utf-8?B?QndnaUxFWTFvRHVXMTgrYW5QTjYzdTJqaUhLRHN4djYrRktwa1JxVUxrOVJE?=
 =?utf-8?B?QkJlOHpmUWVSbmIxTTkwellxdTdmMnlGdEtOQnRZb3BxR3JnVGtTSXg0K05H?=
 =?utf-8?B?M0xJYSt6bU1kUU1JbmszNW9VWHpETi80S3M2UW96T3dEM1Q4b045RlpESlRZ?=
 =?utf-8?B?WjNtS2dGeVRWWnZhRTJ6Q1g3VERXYzRkL1pwamxCMFpjQWV4ZzFiK2N1cFBa?=
 =?utf-8?B?alpKTWFURnA0VEdiU2MzWjJyVjVSQkx6L1ZQQ1dVRVk1SkNzNWVwTkE5NFFQ?=
 =?utf-8?B?NHp2T29oenBxVk9VdE8vemlBYlZUTnBNeE5Ydktwd2VxMnFOZDlkb2JMRzBn?=
 =?utf-8?Q?mbZTWNO82LC1gHUCoff1FjAP/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 79440ab2-7320-455e-3741-08dbeb6fcf21
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 15:29:25.3579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8wZsQw3A9kQGwC8CfbARan73ZYG1Y8hDmygHLbp14aWGCvZswOBJicfdq4u6r4QXgX7AnX8uZiKzitarxeOBCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8472
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/22/23 06:14, Rafael J. Wysocki wrote:
> On Tue, Nov 21, 2023 at 11:19 PM Dave Jiang <dave.jiang@intel.com> wrote:
>>
>> Linus reported that:
>> After commit a103f46633fd the kernel stopped compiling for
>> several ARM32 platforms that I am building with a bare metal
>> compiler. Bare metal compilers (arm-none-eabi-) don't
>> define __linux__.
>>
>> This is because the header <acpi/platform/acenv.h> is now
>> in the include path for <linux/irq.h>:
>>
>>   CC      arch/arm/kernel/irq.o
>>   CC      kernel/sysctl.o
>>   CC      crypto/api.o
>> In file included from ../include/acpi/acpi.h:22,
>>                  from ../include/linux/fw_table.h:29,
>>                  from ../include/linux/acpi.h:18,
>>                  from ../include/linux/irqchip.h:14,
>>                  from ../arch/arm/kernel/irq.c:25:
>> ../include/acpi/platform/acenv.h:218:2: error: #error Unknown target environment
>>   218 | #error Unknown target environment
>>       |  ^~~~~
>>
>> The issue is caused by the introducing of splitting out the ACPI code to
>> support the new generic fw_table code.
>>
>> Rafael suggested [1] moving the fw_table.h include in linux/acpi.h to below
>> the linux/mutex.h. Remove the two includes in fw_table.h. Add include of
>> linux/acpi.h in fw_table.c before the fw_table.h include.
>>
>> Link: https://lore.kernel.org/linux-acpi/CAJZ5v0idWdJq3JSqQWLG5q+b+b=zkEdWR55rGYEoxh7R6N8kFQ@mail.gmail.com/
>> Fixes: a103f46633fd ("acpi: Move common tables helper functions to common lib")
>> Reported-by: Linus Walleij <linus.walleij@linaro.org>
>> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> v2:
>> - Remove linux/acpi.h include as well in fw_table.h. (Sam)
>> ---
>>  include/linux/acpi.h     |   22 +++++++++++-----------
>>  include/linux/fw_table.h |    3 ---
>>  lib/fw_table.c           |    1 +
>>  3 files changed, 12 insertions(+), 14 deletions(-)
>>
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index 54189e0e5f41..4db54e928b36 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -15,7 +15,6 @@
>>  #include <linux/mod_devicetable.h>
>>  #include <linux/property.h>
>>  #include <linux/uuid.h>
>> -#include <linux/fw_table.h>
>>
>>  struct irq_domain;
>>  struct irq_domain_ops;
>> @@ -25,22 +24,13 @@ struct irq_domain_ops;
>>  #endif
>>  #include <acpi/acpi.h>
>>
>> -#ifdef CONFIG_ACPI_TABLE_LIB
>> -#define EXPORT_SYMBOL_ACPI_LIB(x) EXPORT_SYMBOL_NS_GPL(x, ACPI)
>> -#define __init_or_acpilib
>> -#define __initdata_or_acpilib
>> -#else
>> -#define EXPORT_SYMBOL_ACPI_LIB(x)
>> -#define __init_or_acpilib __init
>> -#define __initdata_or_acpilib __initdata
>> -#endif
>> -
>>  #ifdef CONFIG_ACPI
>>
>>  #include <linux/list.h>
>>  #include <linux/dynamic_debug.h>
>>  #include <linux/module.h>
>>  #include <linux/mutex.h>
>> +#include <linux/fw_table.h>
>>
>>  #include <acpi/acpi_bus.h>
>>  #include <acpi/acpi_drivers.h>
>> @@ -48,6 +38,16 @@ struct irq_domain_ops;
>>  #include <acpi/acpi_io.h>
>>  #include <asm/acpi.h>
>>
>> +#ifdef CONFIG_ACPI_TABLE_LIB
>> +#define EXPORT_SYMBOL_ACPI_LIB(x) EXPORT_SYMBOL_NS_GPL(x, ACPI)
>> +#define __init_or_acpilib
>> +#define __initdata_or_acpilib
>> +#else
>> +#define EXPORT_SYMBOL_ACPI_LIB(x)
>> +#define __init_or_acpilib __init
>> +#define __initdata_or_acpilib __initdata
>> +#endif
>> +
>>  static inline acpi_handle acpi_device_handle(struct acpi_device *adev)
>>  {
>>         return adev ? adev->handle : NULL;
>> diff --git a/include/linux/fw_table.h b/include/linux/fw_table.h
>> index ff8fa58d5818..ca49947f0a77 100644
>> --- a/include/linux/fw_table.h
>> +++ b/include/linux/fw_table.h
>> @@ -25,9 +25,6 @@ struct acpi_subtable_proc {
>>         int count;
>>  };
>>
>> -#include <linux/acpi.h>
>> -#include <acpi/acpi.h>
>> -
>>  union acpi_subtable_headers {
>>         struct acpi_subtable_header common;
>>         struct acpi_hmat_structure hmat;
>> diff --git a/lib/fw_table.c b/lib/fw_table.c
>> index b51f30a28e47..c4831f3378be 100644
>> --- a/lib/fw_table.c
>> +++ b/lib/fw_table.c
>> @@ -7,6 +7,7 @@
>>   *  Copyright (C) 2023 Intel Corp.
>>   */
>>  #include <linux/errno.h>
>> +#include <linux/acpi.h>
>>  #include <linux/fw_table.h>
> 
> Because fw_table.h is included via acpi.h, do you still need to
> include it directly here?

No. I'll drop.

> 
>>  #include <linux/init.h>
>>  #include <linux/kernel.h>
>>
>>
>>
