Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377B37EE628
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 18:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345324AbjKPRw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 12:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKPRwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 12:52:55 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD1A126;
        Thu, 16 Nov 2023 09:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700157171; x=1731693171;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=U9MOja6YxXwj8ftE3x6kj6q1MZZDLB9bkzIhTVZnuwE=;
  b=SY0KKWgnxED90EzO3FWl1tzoXM0F3d1kkrbUSTsgWdzQo9PkGAy7u6zi
   Knnfjj3jLsw6g5ib2RIg+yNKdFv0/oNqvJowobk/lP+HYn1NVUPuadWI1
   qC/7MhBucP9Mv8OHh+DuKlwD9RhDFGURD0X+L2xHwpvau8/lkmmisv/Af
   NrZCcou3EMsqYfOqMLE4A6avcFw+VrrJLiiIgH1ObBwUkYveenaHkZ9Pq
   vHHvScFoknE/Ff1BGFhb9nB+vQQEBidC9bTFUgPgTCZ+7EMXg2fBBiVJn
   sRiGZHwwPNuhgKwOGYusVX6/TZWgBsnOkZVhlm76KmeI+R7ubRQ2tJJ5r
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="4267594"
X-IronPort-AV: E=Sophos;i="6.04,204,1695711600"; 
   d="scan'208";a="4267594"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 09:52:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,204,1695711600"; 
   d="scan'208";a="6593395"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Nov 2023 09:52:49 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 09:52:49 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 09:52:48 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 16 Nov 2023 09:52:48 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 16 Nov 2023 09:52:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLF+TctzRZEbjdRJad1LEQwCWMPUWDYNi+DmxBe1VOmFJpWhXuID5aNX3nHMpw9WrAPkQRktaCo4ks4NmOq5FDJB1V+0IRAeyLbfe21Hye08T1I/Z3LI7IFLSVGMIH8KfCHE5mDISKKu+D3pbcc8K/4xXa8y1tkJDghCqq4iHuGFjp3u8qOEOc642QdmeDVZnATWtF05jW0LebtE8boHm6ZCHgXQtMwoLsNpKXjRN414McF3SyldOoIhrIDbNtRwRpl5YC4tjOAbO/FuU58GwmXAfy/pZV4M8nR7j0jKWy5lYBHGmBJVWMmw2GWKIgU2xDa9Ko9XhL99jynZmfiLyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iz4pSCliCw0apDT528Y4BoL6VJbMfe8wQlR07LLSTng=;
 b=hVf2VA4CB/h++fZRbZHW6QUgzpmy2hvlUqIoAMcdklOCaLrT1y8tr9KnojiKca5mAoqhsvGfbFb3unoaMpQvJLh49625bwB7Tby2Db0Kvp8ZU8p/XHOToW3Nl4Kcrz5osquQB/Hqq8IEg0e7Cq5Ld6MBSFKNhHxoc8o3NQksFULIPtVASqCIu4pCEN2SzdXHk6ZzIBHXpyTUhMcNZIHOJsLaJDrXWtC94tcs8lFl/OlnhSOHyfH7GRHwZI+EoFHS2/QjAmZtp/QcU25c1juVvgOfkFmHNThZt8uPUzXLMo+VDmpFGQUe4bJKa1V7so3ygJF0de5hUbOHjucuXB4wpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) by
 SA1PR11MB6894.namprd11.prod.outlook.com (2603:10b6:806:2b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Thu, 16 Nov
 2023 17:52:44 +0000
Received: from DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::66f8:2b23:6ddb:e566]) by DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::66f8:2b23:6ddb:e566%5]) with mapi id 15.20.7002.015; Thu, 16 Nov 2023
 17:52:44 +0000
Message-ID: <1db10ed4-8d1c-4dc4-9e9c-02ceaf62328a@intel.com>
Date:   Thu, 16 Nov 2023 10:52:32 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [RFC PATCH 5/6] cxl/memscrub: Add CXL device DDR5 ECS control
 feature
To:     <shiju.jose@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <jonathan.cameron@huawei.com>, <Vilas.Sridharan@amd.com>,
        <leo.duran@amd.com>, <Yazen.Ghannam@amd.com>,
        <rientjes@google.com>, <jiaqiyan@google.com>,
        <tony.luck@intel.com>, <Jon.Grimm@amd.com>,
        <dave.hansen@linux.intel.com>, <linux-acpi@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <lenb@kernel.org>, <naoya.horiguchi@nec.com>,
        <james.morse@arm.com>, <david@redhat.com>, <jthoughton@google.com>,
        <somasundaram.a@hpe.com>, <erdemaktas@google.com>,
        <duenwen@google.com>, <mike.malvestuto@intel.com>,
        <gthelen@google.com>, <tanxiaofei@huawei.com>,
        <prime.zeng@hisilicon.com>, <kangkang.shen@futurewei.com>,
        <wanghuiqiang@huawei.com>, <linuxarm@huawei.com>
References: <20231114125648.1146-1-shiju.jose@huawei.com>
 <20231114125648.1146-6-shiju.jose@huawei.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20231114125648.1146-6-shiju.jose@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0023.namprd10.prod.outlook.com
 (2603:10b6:a03:255::28) To DS7PR11MB5990.namprd11.prod.outlook.com
 (2603:10b6:8:71::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5990:EE_|SA1PR11MB6894:EE_
X-MS-Office365-Filtering-Correlation-Id: f48694af-ff18-4031-cc16-08dbe6ccd5eb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7hiRLwdqyzI81YVaZGF7nbGVLthZ+bxc+P7fcTaef89XZyZxk9wPxHBYyjL2i3an8OyO5hpGIZ7lOCUNIs8j1lGQCL+KgxxWnIIisXjdpQWYxNVdKGZLj8/R0QzAQG+xW9pTFvg3R98V9NYIWru2pbzWcC69aC0o7FUXjDVdtGLQwDFhqgFEaSMVX/AVlxUiMUlPHYzvIayZpDsXX8bvQRHr0KjWtizkqbatJn5KHoVX96IjgfkxUbFyjXbt1Ur84ziZcVF42XK5rEycFzE1usksbcShjf4v7J1csaJQwwYWWtCl66olYPxyjmdsHi3cJRIDlDV/LkAT7NIUtKWIpy3ZQi7ux/ZjOYM7uCuV749NGbWdxJpvkm2flHsnh38n0JYEIriki6URyWLwk0888xRoIY8nLfRfx3wCYqM+bab9+lZjt3SjXKDYOX8nqBk1cqRCdgIllJMf19hzZg28je9hSV+1Nv5MCncIofKwDBK6vbTnw7GQysizgiCKbQlSTr7tg+Y8pvGf1b+DfDQOIZEGY9+gycO6Ua0dX+nXOKb7VCfUPmzkcxX/1iM59VNCy/hkY2zQ3/fLfEqHke8yXgVpRI630jzL4QzXfkDBDmk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5990.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(346002)(376002)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(8936002)(478600001)(41300700001)(38100700002)(36756003)(966005)(86362001)(66946007)(31696002)(66476007)(66556008)(5660300002)(82960400001)(316002)(7416002)(6486002)(2616005)(2906002)(26005)(6512007)(53546011)(6506007)(44832011)(6666004)(8676002)(83380400001)(30864003)(4326008)(31686004)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1NBakFlUkVwQTlLdHhGZGcrUHRNYmZJMDlacVdEblpsamRFVUxsb3pwTTRF?=
 =?utf-8?B?Nkw2UTU4ZUZQYXByLzlvODlvTmpXNGczdmVWQVFUMWlFWlFQVjJPQXpRTWtq?=
 =?utf-8?B?dnlld0pXZjQ4Rkc5ZGlQZTRSVkdSYXlvOEZBdS9kWWJoMU80QkNZeFgwcjZJ?=
 =?utf-8?B?UXZiMGlIM2VkaWcxNjI1WkVPMDh4ZUtwdHpUK3owY25QR0M2ejB1dzY1d2ls?=
 =?utf-8?B?YXpWSlhNVmMrdThmOEFoVkpyMkp3RFlnK1RnbTdMSGxKMTVqQXRoVGlXQkR0?=
 =?utf-8?B?SUw1dmdPSnBDWldZUWJBUkJvWUF0cTNtMjJnTGZpa1JSRmtUbjVlck52R3cv?=
 =?utf-8?B?YWJTR1cyakN3NWlKVlZ0ZmtaODk0R21nbk5KZ2pVNWxBTnRJN1phTnE5cDlk?=
 =?utf-8?B?Zm96YmFVVjExYVRKOEhBd1d4VkExMXh3SnMyM0lJMnNnZjZmZ0lXaHNzSFR1?=
 =?utf-8?B?QjI1YVcveTFWRnlMYW1qR1F5K3ZPUGJGaG5hcVpvMHFRVTYxN29YU1QwdldL?=
 =?utf-8?B?M2cvUG1KUFNoejFmT2xZUnhsby93NTZmMk9mR3dMaWQ1WExDbkVIS203c09V?=
 =?utf-8?B?VW1JazBkcDU3anVlMlVjemp0ZFI2NVdPYlZKeE9ESGY2c2hOdGYzQVdCbWpI?=
 =?utf-8?B?amhrZU1Dci9MS3ZtcG13VytPdHJ4UUJxV0hDaE9WMWpVRlNiUERKSTBhRnd5?=
 =?utf-8?B?REhsSFZmMmNoaC9yLzZVclBFaHM5TDErenZpTjJ4cCtyd2l4V0Y1L0IvN2l0?=
 =?utf-8?B?RktNekljbmh3b1JSd2R2NlZDZFdsM0FhZFE2b2pnYXJqZnFKU3NBN1EwcGZI?=
 =?utf-8?B?WjZNazl1M1FvQlhjKzlNZVU5Wm1CekZVd1NHeGlseUVzREVhUVRtTGZCNXJD?=
 =?utf-8?B?MTVPekQrWTlLK29PeVcrN0VLY3N6b2xiNjg1YTJGQk9BbllwZHZtV3cvanB5?=
 =?utf-8?B?eit1UzdhYVpkOEFTSy81UVFDRzU2TkhzcjRlTGJVT0RjWUxnY3ZnaGNSNW9X?=
 =?utf-8?B?OW1ZekFmd1NsUmVGNThXcjhTZFdFQ2JuTEJVZmNUWUxMOUVXT3V4T0VlUHhG?=
 =?utf-8?B?M0o4Q0N4ZDZUaitiOXFBbW5PNTQycTAva2s3N2gxOXVBQ1pzQkJWZGtBNkxY?=
 =?utf-8?B?Uzg0aGNEb0lOT1g3anFpSGN4aW9DK3dFM1ROd3lYUm0wT1kxMVIyMVhmUVN5?=
 =?utf-8?B?Wjg5cnBSRTZBa1pqa0kyeThRd1gxS3pqOVJXUmpsdFlEZkZ2ekRud1dzZ0VQ?=
 =?utf-8?B?UzdXTDA5R2VqQ3VaTFBPL2VZM1NGVjExdks0dkxHd25RUk14Ykd2SGJlUjVE?=
 =?utf-8?B?U2duajJTRTdqWFlXL1NFOFFNZTlZalAwSHF6d1Nib0QwTHZWK25DbW5lVkRo?=
 =?utf-8?B?ZXlIQ3l1M1pwOVpYcFhaN1oyc1JzeGNSZE9EUWttNERLNWxGb0p6TjRXOWNy?=
 =?utf-8?B?cE11dDBXcG5mOHhVVEtEUEphbW9hRW1GZTVVVkNNS3pXenVXQ3pZdlRFazFK?=
 =?utf-8?B?QTdSTlQvbEV3ZFdyQ1J6bnliZzZYRGRsUy9QYWxpODE1eEJsWGZjckg2K3Rq?=
 =?utf-8?B?djhkSEx5UlB4RURmNVl5WHRaVWJaL0JyV0I2cStmdy9XMzdrV2xRZERqSkRz?=
 =?utf-8?B?dmlkMjNjYUtnUUJpc3hqZzM2ZDhDQzYrS2tIY1FYYzZFRy9nU2cyenFtNjg3?=
 =?utf-8?B?WTdVQllqTjFkOEpLeVNWT3BWYW1xcSt2NENDTytRRjdxRkVBU1h1WDFyZ1lS?=
 =?utf-8?B?ZWlKakwyR3Y5NHhCU2t1QTYvMUFhclY2c1pIWjVJQnhJZXZwbnl2MUpBMGZE?=
 =?utf-8?B?bXNQQ2ZUUTZaMHZJdkY1dUFxQmxoMVQwUEhLb3IwUzFMVDMxYlRGcEc0bUhw?=
 =?utf-8?B?eklleWZoZjhqM3JNVFRUMGxZblhJd04ycnVrRDhPUDdmbzBJeWNUcEJBeklm?=
 =?utf-8?B?SW5Dd3M1OE5hSHVPSGpocUhaSEdWVW9Hc1pXTUlSVTZCSW5PUEQ2WFVqa043?=
 =?utf-8?B?Rk90SzNyMmdyb2dNL2NlSjE4OWsxaTFZZ0NPd0YrOTN3NlhnYS9MaURNTzd1?=
 =?utf-8?B?M0lDSncvUVZhK1hTd1ZYQS9KWmsyOGRWRkFwbmY1a0lPZ0V3MVlCb0hnVmw3?=
 =?utf-8?Q?92V7X3Z5XFE9pABpU8K2qTyj+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f48694af-ff18-4031-cc16-08dbe6ccd5eb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5990.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 17:52:44.2317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3sv1Hnlcp1FZ8cLNyBonzn/mHMYSZSus0w0tQbkyak3d/x4UhGTwaLLIZYueIhJaoaREY369Mqiq/95bOmRzTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6894
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/14/23 05:56, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.1 section 8.2.9.9.11.2 describes the DDR5 Error Check Scrub (ECS)
> control feature.
> 
> The Error Check Scrub (ECS) is a feature defined in JEDEC DDR5 SDRAM
> Specification (JESD79-5) and allows the DRAM to internally read, correct
> single-bit errors, and write back corrected data bits to the DRAM array
> while providing transparency to error counts. The ECS control feature
> allows the request to configure ECS input configurations during system
> boot or at run-time.
> 
> The ECS control allows the requester to change the log entry type, the ECS
> threshold count provided that the request is within the definition
> specified in DDR5 mode registers, change mode between codeword mode and
> row count mode, and reset the ECS counter.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  drivers/cxl/core/memscrub.c | 557 +++++++++++++++++++++++++++++++++++-
>  drivers/cxl/cxlmem.h        |   2 +
>  drivers/cxl/pci.c           |   2 +
>  3 files changed, 559 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/memscrub.c b/drivers/cxl/core/memscrub.c
> index ec67ffc81363..1c7031166ba0 100644
> --- a/drivers/cxl/core/memscrub.c
> +++ b/drivers/cxl/core/memscrub.c
> @@ -5,9 +5,9 @@
>   * Copyright (c) 2023 HiSilicon Limited.
>   *
>   *  - Provides functions to configure patrol scrub
> - *    feature of the CXL memory devices.
> + *    and DDR5 ECS features of the CXL memory devices.
>   *  - Registers with the scrub driver for the
> - *    memory patrol scrub feature.
> + *    memory patrol scrub and DDR5 ECS features.
>   */
>  
>  #define pr_fmt(fmt)	"CXL_MEM_SCRUB: " fmt
> @@ -453,3 +453,556 @@ int cxl_mem_patrol_scrub_init(struct cxl_memdev *cxlmd)
>  	return ret;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mem_patrol_scrub_init, CXL);
> +
> +/* CXL DDR5 ECS control definitions */
> +#define CXL_MEMDEV_ECS_GET_FEAT_VERSION	0x01
> +#define CXL_MEMDEV_ECS_SET_FEAT_VERSION	0x01
> +
> +#define CXL_DDR5_ECS	"cxl_ecs"
> +
> +/* The default number of regions for CXL memory device patrol scrubber */
> +#define CXL_MEMDEV_ECS_NUM_REGIONS	1
> +
> +static const uuid_t cxl_ecs_uuid =
> +	UUID_INIT(0xe5b13f22, 0x2328, 0x4a14, 0xb8, 0xba, 0xb9, 0x69, 0x1e,     \
> +		  0x89, 0x33, 0x86);
> +
> +/* CXL DDR5 ECS control functions */
> +struct cxl_ecs_context {
> +	struct device *dev;
> +	u16 nregions;
> +	u16 get_feat_size;
> +	u16 set_feat_size;
> +};
> +
> +/**
> + * struct cxl_memdev_ecs_params - CXL memory DDR5 ECS parameter data structure.
> + * @log_entry_type: ECS log entry type, per DRAM or per memory media FRU.
> + * @threshold: ECS threshold count per GB of memory cells.
> + * @mode:	codeword/row count mode
> + *		0 : ECS counts rows with errors
> + *		1 : ECS counts codeword with errors
> + * @reset_counter: [IN] reset ECC counter to default value.
> + * @log_entry_type_avail: Supported ECS log entry types.
> + * @threshold_avail: Supported ECS threshold counts.
> + * @mode_avail: Supported ECS count mode.
> + */
> +struct cxl_memdev_ecs_params {
> +	u8 log_entry_type;
> +	u16 threshold;
> +	u8 mode;
> +	bool reset_counter;
> +	char log_entry_type_avail[CXL_SCRUB_MAX_ATTRB_RANGE_LENGTH];
> +	char threshold_avail[CXL_SCRUB_MAX_ATTRB_RANGE_LENGTH];
> +	char mode_avail[CXL_SCRUB_MAX_ATTRB_RANGE_LENGTH];
> +};
> +
> +enum {
> +	CXL_MEMDEV_ECS_PARAM_LOG_ENTRY_TYPE = 0,
> +	CXL_MEMDEV_ECS_PARAM_THRESHOLD,
> +	CXL_MEMDEV_ECS_PARAM_MODE,
> +	CXL_MEMDEV_ECS_PARAM_RESET_COUNTER,
> +};
> +
> +#define	CXL_MEMDEV_ECS_LOG_ENTRY_TYPE_MASK	GENMASK(1, 0)
> +#define	CXL_MEMDEV_ECS_REALTIME_REPORT_CAP_MASK	BIT(0)
> +#define	CXL_MEMDEV_ECS_THRESHOLD_COUNT_MASK	GENMASK(2, 0)
> +#define	CXL_MEMDEV_ECS_MODE_MASK	BIT(3)
> +#define	CXL_MEMDEV_ECS_RESET_COUNTER_MASK	BIT(4)
> +
> +static const u16 ecs_supp_threshold[] = { 0, 0, 0, 256, 1024, 4096 };
> +
> +enum {
> +	ECS_LOG_ENTRY_TYPE_DRAM = 0x0,
> +	ECS_LOG_ENTRY_TYPE_MEM_MEDIA_FRU = 0x1,
> +};
> +
> +enum {
> +	ECS_THRESHOLD_256 = 3,
> +	ECS_THRESHOLD_1024 = 4,
> +	ECS_THRESHOLD_4096 = 5,
> +};
> +
> +enum {
> +	ECS_MODE_COUNTS_ROWS = 0,
> +	ECS_MODE_COUNTS_CODEWORDS = 1,
> +};
> +
> +struct cxl_memdev_ecs_feat_read_attrbs {
> +	u8 ecs_log_cap;
> +	u8 ecs_cap;
> +	__le16 ecs_config;
> +	u8 ecs_flags;
> +}  __packed;
> +
> +struct cxl_memdev_ecs_set_feat_pi {
> +	struct cxl_mbox_set_feat_in pi;
> +	struct cxl_memdev_ecs_feat_wr_attrbs {
> +		u8 ecs_log_cap;
> +		__le16 ecs_config;
> +	} __packed wr_attrbs[];
> +}  __packed;
> +
> +static int cxl_mem_ecs_get_attrbs(struct device *dev, int fru_id,
> +				  struct cxl_memdev_ecs_params *params)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev->parent);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +	struct cxl_mbox_get_feat_in pi = {
> +		.uuid = cxl_ecs_uuid,
> +		.offset = 0,
> +		.selection = CXL_GET_FEAT_CURRENT_VALUE,
> +	};
> +	struct cxl_memdev_ecs_feat_read_attrbs *rd_attrbs;
> +	struct cxl_ecs_context *cxl_ecs_ctx;
> +	u8 threshold_index;
> +
> +	if (!mds)
> +		return -EFAULT;
> +	cxl_ecs_ctx = dev_get_drvdata(dev);
> +
> +	pi.count = cxl_ecs_ctx->get_feat_size;
> +	rd_attrbs = cxl_get_feature(mds, &pi);
> +	if (PTR_ERR_OR_ZERO(rd_attrbs)) {

Why not just IS_ERR()? 
> +		params->log_entry_type = 0;
> +		params->threshold = 0;
> +		params->mode = 0;
> +		snprintf(params->log_entry_type_avail, CXL_SCRUB_MAX_ATTRB_RANGE_LENGTH,
> +			 "Unavailable");
> +		snprintf(params->threshold_avail, CXL_SCRUB_MAX_ATTRB_RANGE_LENGTH,
> +			 "Unavailable");
> +		snprintf(params->mode_avail, CXL_SCRUB_MAX_ATTRB_RANGE_LENGTH,
> +			 "Unavailable");

Given that these are static values, maybe change the string params to enums and then have a static string table you can index to?

> +		return PTR_ERR_OR_ZERO(rd_attrbs);

at this point you can just return PTR_ERR()

> +	}
> +	params->log_entry_type = FIELD_GET(CXL_MEMDEV_ECS_LOG_ENTRY_TYPE_MASK,
> +					   rd_attrbs[fru_id].ecs_log_cap);
> +	threshold_index = FIELD_GET(CXL_MEMDEV_ECS_THRESHOLD_COUNT_MASK,
> +				    rd_attrbs[fru_id].ecs_config);
> +	params->threshold = ecs_supp_threshold[threshold_index];
> +	params->mode = FIELD_GET(CXL_MEMDEV_ECS_MODE_MASK,
> +				 rd_attrbs[fru_id].ecs_config);
> +	snprintf(params->log_entry_type_avail, CXL_SCRUB_MAX_ATTRB_RANGE_LENGTH,
> +		 "Log Entry Type 0:per DRAM  1:per Memory Media FRU");
> +	snprintf(params->threshold_avail, CXL_SCRUB_MAX_ATTRB_RANGE_LENGTH,
> +		 "Threshold count per Gb of memory cells: 256,1024,4096");
> +	snprintf(params->mode_avail, CXL_SCRUB_MAX_ATTRB_RANGE_LENGTH,
> +		 "Mode 0:ECS counts rows with errors  1:ECS counts codewords with errors");
> +
> +	kvfree(rd_attrbs);
> +
> +	return 0;
> +}
> +
> +static int cxl_mem_ecs_set_attrbs(struct device *dev, int fru_id,
> +				  struct cxl_memdev_ecs_params *params, u8 param_type)
> +{
> +	int ret = 0;
> +	u32 set_pi_size;
> +	u16 nmedia_frus, count;
> +	struct cxl_memdev_ecs_set_feat_pi *set_pi;
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev->parent);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +	struct cxl_mbox_get_feat_in pi = {
> +		.uuid = cxl_ecs_uuid,
> +		.offset = 0,
> +		.selection = CXL_GET_FEAT_CURRENT_VALUE,
> +	};
> +	struct cxl_memdev_ecs_feat_read_attrbs *rd_attrbs;
> +	struct cxl_memdev_ecs_feat_wr_attrbs *wr_attrbs;
> +	struct cxl_ecs_context *cxl_ecs_ctx;
> +	struct cxl_memdev_ecs_params rd_params;
> +
> +	if (!mds)
> +		return -EFAULT;
> +
> +	cxl_ecs_ctx = dev_get_drvdata(dev);
> +	nmedia_frus = cxl_ecs_ctx->nregions;
> +
> +	pi.count = cxl_ecs_ctx->get_feat_size;
> +	rd_attrbs = cxl_get_feature(mds, &pi);
> +	if (PTR_ERR_OR_ZERO(rd_attrbs))
> +		return PTR_ERR_OR_ZERO(rd_attrbs);

if (IS_ERR(rd_attribs))
	return PTR_ERR(rd_attrbs);


> +	set_pi_size = sizeof(struct cxl_mbox_set_feat_in) +
> +				cxl_ecs_ctx->set_feat_size;
> +	set_pi = kvmalloc(set_pi_size, GFP_KERNEL);

I think you can use the auto clean declaration. Then you don't need to call kvfree() every time you return with error or use the goto.

struct cxl_memdev_ecs_set_feat_pi *set_pi __free(kvfree) = kvmalloc(set_pi_size, GFP_KERNEL);

https://lwn.net/Articles/934679/

> +	if (!set_pi) {
> +		kvfree(rd_attrbs);
> +		return -ENOMEM;
> +	}
> +
> +	set_pi->pi.uuid = cxl_ecs_uuid;
> +	set_pi->pi.flags = CXL_SET_FEAT_FLAG_MOD_VALUE_SAVED_ACROSS_RESET |
> +				CXL_SET_FEAT_FLAG_ACTION_FULL_DATA_TRANSFER;
> +	set_pi->pi.offset = 0;
> +	set_pi->pi.version = CXL_MEMDEV_ECS_SET_FEAT_VERSION;
> +	/* Fill writable attributes from the current attributes read for all the media FRUs */
> +	count = 0;
> +	wr_attrbs = set_pi->wr_attrbs;
> +	while (count < nmedia_frus) {

for loop?
> +		wr_attrbs[count].ecs_log_cap = rd_attrbs[count].ecs_log_cap;
> +		wr_attrbs[count].ecs_config = rd_attrbs[count].ecs_config;
> +		count++;
> +	}
> +	kvfree(rd_attrbs);

Maybe cxl_get_feature() should take a ptr to an allocated rd_attrbs rather than doing the allocation then expect the caller to free it.
 
> +
> +	/* Fill attribute to be set for the media FRU */
> +	if (param_type == CXL_MEMDEV_ECS_PARAM_LOG_ENTRY_TYPE) {

I think this entire if/else block can be setup as a switch block since it's checking aainst param_type for all branches?

> +		if (params->log_entry_type != ECS_LOG_ENTRY_TYPE_DRAM &&
> +		    params->log_entry_type != ECS_LOG_ENTRY_TYPE_MEM_MEDIA_FRU) {
> +			dev_err(dev->parent,
> +				"Invalid CXL ECS scrub log entry type(%d) to set\n",
> +			       params->log_entry_type);
> +			dev_err(dev->parent,
> +				"Log Entry Type 0: per DRAM  1: per Memory Media FRU\n");
> +			ret = -EINVAL;
> +			goto set_attrbs_exit;
> +		}
> +		wr_attrbs[fru_id].ecs_log_cap = FIELD_PREP(CXL_MEMDEV_ECS_LOG_ENTRY_TYPE_MASK,
> +							   params->log_entry_type);
> +	} else if (param_type == CXL_MEMDEV_ECS_PARAM_THRESHOLD) {
> +		wr_attrbs[fru_id].ecs_config &= ~CXL_MEMDEV_ECS_THRESHOLD_COUNT_MASK;
> +		switch (params->threshold) {
> +		case 256:
> +			wr_attrbs[fru_id].ecs_config |= FIELD_PREP(
> +						CXL_MEMDEV_ECS_THRESHOLD_COUNT_MASK,
> +						ECS_THRESHOLD_256);
> +			break;
> +		case 1024:
> +			wr_attrbs[fru_id].ecs_config |= FIELD_PREP(
> +						CXL_MEMDEV_ECS_THRESHOLD_COUNT_MASK,
> +						ECS_THRESHOLD_1024);
> +			break;
> +		case 4096:
> +			wr_attrbs[fru_id].ecs_config |= FIELD_PREP(
> +						CXL_MEMDEV_ECS_THRESHOLD_COUNT_MASK,
> +						ECS_THRESHOLD_4096);
> +			break;
> +		default:
> +			dev_err(dev->parent,
> +				"Invalid CXL ECS scrub threashol count(%d) to set\n",
> +				params->threshold);
> +			dev_err(dev->parent,
> +				"Threshold count per Gb pf memory cells: 256,1024,4096\n");
> +			ret = -EINVAL;
> +			goto set_attrbs_exit;
> +		}
> +	} else if (param_type == CXL_MEMDEV_ECS_PARAM_MODE) {
> +		if (params->mode != ECS_MODE_COUNTS_ROWS &&
> +		    params->mode != ECS_MODE_COUNTS_CODEWORDS) {
> +			dev_err(dev->parent,
> +				"Invalid CXL ECS scrub mode(%d) to set\n",
> +				params->mode);
> +			dev_err(dev->parent,
> +				"Mode 0: ECS counts rows with errors"
> +				" 1: ECS counts codewords with errors\n");
> +			ret = -EINVAL;
> +			goto set_attrbs_exit;
> +		}
> +		wr_attrbs[fru_id].ecs_config &= ~CXL_MEMDEV_ECS_MODE_MASK;
> +		wr_attrbs[fru_id].ecs_config |= FIELD_PREP(CXL_MEMDEV_ECS_MODE_MASK,
> +							  params->mode);
> +	} else if (param_type == CXL_MEMDEV_ECS_PARAM_RESET_COUNTER) {
> +		wr_attrbs[fru_id].ecs_config &= ~CXL_MEMDEV_ECS_RESET_COUNTER_MASK;
> +		wr_attrbs[fru_id].ecs_config |= FIELD_PREP(CXL_MEMDEV_ECS_RESET_COUNTER_MASK,
> +							   params->reset_counter);
> +	} else {
> +		dev_err(dev->parent, "Invalid CXL ECS parameter to set\n");
> +		ret = -EINVAL;
> +		goto set_attrbs_exit;
> +	}
> +
> +	ret = cxl_set_feature(mds, set_pi, set_pi_size);
> +	if (ret) {
> +		dev_err(dev->parent, "CXL ECS set feature fail ret=%d\n", ret);
> +		goto set_attrbs_exit;
> +	}
> +
> +	/* Verify attribute is set successfully */
> +	ret = cxl_mem_ecs_get_attrbs(dev, fru_id, &rd_params);
> +	if (ret) {
> +		dev_err(dev->parent, "Get cxlmemdev ECS params fail ret=%d\n", ret);
> +		return ret;
Leaking set_pi, but shouldn't be an issue once you go to autoclean. Same with switch block below.

> +	}
> +	switch (param_type) {
> +	case CXL_MEMDEV_ECS_PARAM_LOG_ENTRY_TYPE:
> +		if (rd_params.log_entry_type != params->log_entry_type)
> +			return -EFAULT;
> +		break;
> +	case CXL_MEMDEV_ECS_PARAM_THRESHOLD:
> +		if (rd_params.threshold != params->threshold)
> +			return -EFAULT;
> +		break;
> +	case CXL_MEMDEV_ECS_PARAM_MODE:
> +		if (rd_params.mode != params->mode)
> +			return -EFAULT;
> +		break;
> +	}
> +
> +set_attrbs_exit:
> +	kvfree(set_pi);
> +	return ret;
> +}
> +
> +static int cxl_mem_ecs_log_entry_type_write(struct device *dev, int region_id, long val)
> +{
> +	int ret;
> +	struct cxl_memdev_ecs_params params;
> +
> +	params.log_entry_type = val;
> +	ret = cxl_mem_ecs_set_attrbs(dev, region_id, &params,
> +				     CXL_MEMDEV_ECS_PARAM_LOG_ENTRY_TYPE);
> +	if (ret) {
> +		dev_err(dev->parent, "Set CXL ECS params for log entry type fail ret=%d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_mem_ecs_threshold_write(struct device *dev, int region_id, long val)
> +{
> +	int ret;
> +	struct cxl_memdev_ecs_params params;
> +
> +	params.threshold = val;
> +	ret = cxl_mem_ecs_set_attrbs(dev, region_id, &params,
> +				     CXL_MEMDEV_ECS_PARAM_THRESHOLD);
> +	if (ret) {
> +		dev_err(dev->parent, "Set CXL ECS params for threshold fail ret=%d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_mem_ecs_mode_write(struct device *dev, int region_id, long val)
> +{
> +	int ret;
> +	struct cxl_memdev_ecs_params params;
> +
> +	params.mode = val;
> +	ret = cxl_mem_ecs_set_attrbs(dev, region_id, &params,
> +				     CXL_MEMDEV_ECS_PARAM_MODE);
> +	if (ret) {
> +		dev_err(dev->parent, "Set CXL ECS params for mode fail ret=%d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_mem_ecs_reset_counter_write(struct device *dev, int region_id, long val)
> +{
> +	int ret;
> +	struct cxl_memdev_ecs_params params;
> +
> +	params.reset_counter = val;
> +	ret = cxl_mem_ecs_set_attrbs(dev, region_id, &params,
> +				     CXL_MEMDEV_ECS_PARAM_RESET_COUNTER);
> +	if (ret) {
> +		dev_err(dev->parent, "Set CXL ECS params for reset ECC counter fail ret=%d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * cxl_mem_ecs_is_visible() - Callback to return attribute visibility
> + * @drv_data: Pointer to driver-private data structure passed
> + *	      as argument to devm_scrub_device_register().
> + * @attr: Scrub attribute
> + * @region_id: ID of the memory region
> + *
> + * Returns: 0 on success, an error otherwise
> + */
> +static umode_t cxl_mem_ecs_is_visible(const void *drv_data, u32 attr, int region_id)
> +{
> +	switch (attr) {
> +	case scrub_reset_counter:
> +		return 0200;
> +	case scrub_ecs_log_entry_type_per_dram:
> +	case scrub_ecs_log_entry_type_per_memory_media:
> +	case scrub_mode_counts_rows:
> +	case scrub_mode_counts_codewords:
> +	case scrub_threshold_available:
> +		return 0444;
> +	case scrub_ecs_log_entry_type:
> +	case scrub_mode:
> +	case scrub_threshold:
> +		return 0644;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +/**
> + * cxl_mem_ecs_read() - Read callback for data attributes
> + * @dev: Pointer to scrub device
> + * @attr: Scrub attribute
> + * @region_id: ID of the memory region
> + * @val: Pointer to the returned data
> + *
> + * Returns: 0 on success, an error otherwise
> + */
> +static int cxl_mem_ecs_read(struct device *dev, u32 attr, int region_id, u64 *val)
> +{
> +	int ret;
> +	struct cxl_memdev_ecs_params params;
> +
> +	if (attr == scrub_ecs_log_entry_type ||
> +	    attr == scrub_ecs_log_entry_type_per_dram ||
> +	    attr == scrub_ecs_log_entry_type_per_memory_media ||
> +	    attr == scrub_mode ||
> +	    attr == scrub_mode_counts_rows ||
> +	    attr == scrub_mode_counts_codewords ||
> +	    attr == scrub_threshold) {
> +		ret = cxl_mem_ecs_get_attrbs(dev, region_id, &params);
> +		if (ret) {
> +			dev_err(dev->parent, "Get CXL ECS params fail ret=%d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	switch (attr) {
> +	case scrub_ecs_log_entry_type:
> +		*val = params.log_entry_type;
> +		return 0;
> +	case scrub_ecs_log_entry_type_per_dram:
> +		if (params.log_entry_type == ECS_LOG_ENTRY_TYPE_DRAM)
> +			*val = 1;
> +		else
> +			*val = 0;
> +		return 0;
> +	case scrub_ecs_log_entry_type_per_memory_media:
> +		if (params.log_entry_type == ECS_LOG_ENTRY_TYPE_MEM_MEDIA_FRU)
> +			*val = 1;
> +		else
> +			*val = 0;
> +		return 0;
> +	case scrub_mode:
> +		*val = params.mode;
> +		return 0;
> +	case scrub_mode_counts_rows:
> +		if (params.mode == ECS_MODE_COUNTS_ROWS)
> +			*val = 1;
> +		else
> +			*val = 0;
> +		return 0;
> +	case scrub_mode_counts_codewords:
> +		if (params.mode == ECS_MODE_COUNTS_CODEWORDS)
> +			*val = 1;
> +		else
> +			*val = 0;
> +		return 0;
> +	case scrub_threshold:
> +		*val = params.threshold;
> +		return 0;
> +	default:
> +		return -ENOTSUPP;
> +	}
> +}
> +
> +/**
> + * cxl_mem_ecs_write() - Write callback for data attributes
> + * @dev: Pointer to scrub device
> + * @attr: Scrub attribute
> + * @region_id: ID of the memory region
> + * @val: Value to write
> + *
> + * Returns: 0 on success, an error otherwise
> + */
> +static int cxl_mem_ecs_write(struct device *dev, u32 attr, int region_id, u64 val)
> +{
> +	switch (attr) {
> +	case scrub_ecs_log_entry_type:
> +		return cxl_mem_ecs_log_entry_type_write(dev, region_id, val);
> +	case scrub_mode:
> +		return cxl_mem_ecs_mode_write(dev, region_id, val);
> +	case scrub_reset_counter:
> +		return cxl_mem_ecs_reset_counter_write(dev, region_id, val);
> +	case scrub_threshold:
> +		return cxl_mem_ecs_threshold_write(dev, region_id, val);
> +	default:
> +		return -ENOTSUPP;
> +	}
> +}
> +
> +/**
> + * cxl_mem_ecs_read_strings() - Read callback for DDR5 ECS string attributes
> + * @dev: Pointer to ECS scrub device
> + * @attr: ECS scrub attribute
> + * @region_id: ID of the memory media FRU.
> + * @buf: Pointer to the buffer for copying returned string
> + *
> + * Returns: 0 on success, an error otherwise
> + */
> +static int cxl_mem_ecs_read_strings(struct device *dev, u32 attr,
> +				    int region_id, char *buf)
> +{
> +
> +	switch (attr) {
> +	case scrub_threshold_available:
> +		sprintf(buf, "256,1024,4096\n");
sysfs_emit()?

> +		return 0;
> +	default:
> +		return -ENOTSUPP;
> +	}
> +}
> +
> +static const struct scrub_ops cxl_ecs_ops = {
> +	.is_visible = cxl_mem_ecs_is_visible,
> +	.read = cxl_mem_ecs_read,
> +	.write = cxl_mem_ecs_write,
> +	.read_string = cxl_mem_ecs_read_strings,
> +};
> +
> +int cxl_mem_ddr5_ecs_init(struct cxl_memdev *cxlmd)
> +{
> +	int nmedia_frus; /* number of memory media FRUs in the device */
> +	int ret = 0;
> +	struct device *cxl_scrub_dev;
> +	char scrub_name[CXL_MEMDEV_MAX_NAME_LENGTH];
> +	struct cxl_mbox_supp_feat_entry feat_entry;
> +	struct cxl_ecs_context *cxl_ecs_ctx;
> +
> +	ret = cxl_mem_get_supported_feature_entry(cxlmd, &cxl_ecs_uuid, &feat_entry);
> +	if (ret < 0)
> +		goto cxl_ecs_reg_fail;
> +
> +	if (!(feat_entry.attrb_flags & CXL_FEAT_ENTRY_FLAG_CHANGABLE))
> +		goto cxl_ecs_init_exit;
> +	nmedia_frus = feat_entry.get_feat_size/
> +				sizeof(struct cxl_memdev_ecs_feat_read_attrbs);
> +	if (nmedia_frus) {
> +		cxl_ecs_ctx = devm_kzalloc(&cxlmd->dev, sizeof(*cxl_ecs_ctx), GFP_KERNEL);
> +		if (!cxl_ecs_ctx)
> +			goto cxl_ecs_init_exit;
> +
> +		cxl_ecs_ctx->nregions = nmedia_frus;
> +		cxl_ecs_ctx->get_feat_size = feat_entry.get_feat_size;
> +		cxl_ecs_ctx->set_feat_size = feat_entry.set_feat_size;
> +
> +		snprintf(scrub_name, sizeof(scrub_name), "%s_%s",
> +			 CXL_DDR5_ECS, dev_name(&cxlmd->dev));
> +		cxl_scrub_dev = devm_scrub_device_register(&cxlmd->dev, scrub_name,
> +							  cxl_ecs_ctx, &cxl_ecs_ops,
> +							  cxl_ecs_ctx->nregions);
> +		if (PTR_ERR_OR_ZERO(cxl_scrub_dev)) {
IS_ERR()?

> +			ret = PTR_ERR_OR_ZERO(cxl_scrub_dev);

PTR_ERR()
> +			goto cxl_ecs_reg_fail;
> +		}
> +	}
> +
> +cxl_ecs_reg_fail:
> +cxl_ecs_init_exit:
> +	return ret;

Why goto label if it just return directly w/o additional operations?

> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_mem_ddr5_ecs_init, CXL);
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 1d0fad0dc5ae..4da0b0ec3b1e 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -972,8 +972,10 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
>  /* cxl memory scrub functions */
>  #ifdef CONFIG_CXL_SCRUB
>  int cxl_mem_patrol_scrub_init(struct cxl_memdev *cxlmd);
> +int cxl_mem_ddr5_ecs_init(struct cxl_memdev *cxlmd);
>  #else
>  int cxl_mem_patrol_scrub_init(struct cxl_memdev *cxlmd) { return -ENOTSUP; }
> +int cxl_mem_ddr5_ecs_init(struct cxl_memdev *cxlmd) { return -ENOTSUP; }
>  #endif
>  
>  #ifdef CONFIG_CXL_SUSPEND
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 86bba8794bb4..75ce4f41c5c0 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -886,6 +886,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	 */
>  	if (cxl_mem_patrol_scrub_init(cxlmd))
>  		dev_dbg(&pdev->dev, "cxl_mem_patrol_scrub_init failed\n");
> +	if (cxl_mem_ddr5_ecs_init(cxlmd))
> +		dev_dbg(&pdev->dev, "cxl_mem_ddr5_ecs_init failed\n");
>  
>  	rc = devm_cxl_sanitize_setup_notifier(&pdev->dev, cxlmd);
>  	if (rc)
