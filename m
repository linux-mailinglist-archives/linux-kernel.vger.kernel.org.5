Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E6377E1D7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 14:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245285AbjHPMpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 08:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245313AbjHPMpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 08:45:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A6126B7;
        Wed, 16 Aug 2023 05:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692189938; x=1723725938;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OIgMhe57rh+DQKF9GPZwxz/5MO78wOklMed5wNkXkKU=;
  b=VRXKIS/j0qpxRGUx/+Gk4TBuQCVI3XifjIG4DKEBKj07fPggmtJU+/sA
   uX3joRxHSnhlY14JZ5wv70gVa9mCiAKBCXnDVYZWsANJgqrMGAE8tOMon
   pff87TNAIqool2DT/+giiCdhU/rg8+MFsyk45QOgu1xRnlZJ8N1wP1kDX
   lpuWyc0sAyllInBxm9kfcS1tijrSf1eGhDclpd0v/Hm/Ptux6lYT0OeEQ
   0sO1z0kPsKZETkueTb8XTJRSTF8j42vZEtxw6Mog/y0iWsRHNd8d43quM
   ZrnMBOdK62g43JhuriVkCPV+X9NlXs96J/RZ1dMB86SgNEBogAkMiPiC1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="372522031"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="372522031"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 05:44:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="804217336"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="804217336"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 16 Aug 2023 05:44:47 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 05:44:47 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 05:44:46 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 16 Aug 2023 05:44:46 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 16 Aug 2023 05:44:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SlhdVbiZ4NKfRnAD1U86b/K3qQpaAl16tWlJYC07n3fuC21lWC/U1titmBUrOg25kKpfyPRVSUE1yom+jI9wZjrZLGXSHytucTywDII8RUvsLFG2sB8sjApzcO4tbCkY/zLWcdSx0P4FyOEr+SMIuL/bWpaENsM1cURXlGOhOuaTMtmykcrerttWgfowLPNqcTu1KCkHu79i7S7MLUEf8pLZlYkMMm63JYiNxZ5/eO6xLzwQNMBQEtsY+6k3SrFMiOqS9D+16cde8gcUy0GEPgnziRqqND+tDVYdmsH0W1lS0D328N73NaA6Gv4zuVffg7AeA7beo9k6YG/y54fTFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5goxF9gLkAEglcwl9p3jKyDxeXRPGXKZuvSt05BXu0=;
 b=hCAQ3zU0ITUpHd/zInlUgpNeGHKCCil6jnmC4frqjwj/Fe9WGIo5z9nz5j2VjKS28jLUUCBl7Hk2ams3CkVnxOLE4Z9ExUX2+kEIcg/53SFNIVQxTmNIT55T5xHvUyEPZHGsz3HqfSEJEa+YVTmNO3s3fFpE8KmxkLXa8cmvLhfoPqVHMIf52f1qWNG2uZ/rSk84IHZbO1UshvwYNccJQvvcG/eYwg9IPo/bsrOF/959f+RfdBcVd2SyhgeREsZwJ+i98qSx+VS5oLZkldPLBKvt3RmZr/iR4SqeHulM2eoqlo80iUPhMaB1sanRSzbjTZ72QYXCa0h6cjjXcCL0Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by BL1PR11MB5445.namprd11.prod.outlook.com (2603:10b6:208:30b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 12:44:43 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 12:44:43 +0000
Message-ID: <f510aabb-6ca3-28c9-fb47-3db3c712db79@intel.com>
Date:   Wed, 16 Aug 2023 14:44:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 net] octeontx2-pf: fix page_pool creation fail for
 rings > 32k
Content-Language: en-US
To:     Ratheesh Kannoth <rkannoth@marvell.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
References: <20230816090718.2481252-1-rkannoth@marvell.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230816090718.2481252-1-rkannoth@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0229.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8c::19) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|BL1PR11MB5445:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a7dcefd-d2bb-4346-e9fd-08db9e5690bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UPcf1pbEbYG7mmToAZz3Y4c6MwMberYzUyFmVs3cWYJcUkrVLcqAz7Fjc+Unn+tie0OqC6gTQpw49QFK9Pr29mQ7OnKvJmQHPc4H+V3YFf3EtGTRrahyBl8WvmqanazBA0ZHxBFR0WT8yES0BTUdKQoa3EZasX4V1xKxg2j7aZsUbDvhHpIv8gG4dL7uykEHuZLyqLZ2FTHi16THZKzBjShnwxq0OFxQSleypu7TNqR3jPKJpe9HkwYPggIgwsIUjvzlAVn0fiHoOCpDH2/GcYwlQto3tHC9FlZrd53vYS6+/NrkoEK9xwvXz1s77C5hK9Z6d5jd34zdFwhgyJOoOpcHQPnuap5ldXZZ4CvamxYNcUmgLywCXNbP5Zz08YyU6vVGMA0RUKYlwQjgztV/pfPoWKHFSRV4lqncbgu++T12wEFE3iqaUY87QA+Vqt+xaJIct8Jndega8V+iL61I1qRtNV8LLgpMxsdCuXtp2H+iX7dkMWtdPRlqTxni0zlAc0WufVl/pXbuCCmRJETBR2sBE7MeLacYODscF6t3CsiTmEUXFwcuBd+ooe0Ce05W/Ifuy2BpJ6URqSNBOpCgQuHtTiesYJgC/RIeBXFlSih1aryLD4VjW7SHJwYr1cgVuPvyhGrtJxWZe0biu1WtAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(6916009)(66946007)(66476007)(66556008)(41300700001)(5660300002)(38100700002)(31686004)(8676002)(4326008)(8936002)(82960400001)(2906002)(83380400001)(26005)(478600001)(7416002)(86362001)(31696002)(6512007)(6506007)(36756003)(6666004)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SS8xdUNUNTh1dXJodUtZd0VHd2Ixem0zbFJFZEJWcGl5ckVoYS9ocXNIajNB?=
 =?utf-8?B?WEJoODVZQnlXcmNiSnJBWFhaV3A0YU1sRnFrb3ozRlVVWElKWnc3d2xvZXBJ?=
 =?utf-8?B?Z0RIRDVGTVRwemxicGZkb3VhNzZrcDRKaXd4OXc1UnJESjNHZFQvZk02aUtn?=
 =?utf-8?B?c2JqQjRBSFdUditZWUs3TW9LcWJGbXplQ3pGOC95b0VhRW9aMXVyM01PMmwv?=
 =?utf-8?B?VkF5S2xrajkzc1pYaXMxUWJRM01NSm9aVDVWVFFpNWhjWjdjbzFiMHg2d0hB?=
 =?utf-8?B?Vnh1OFhpNVViSGJFRWl4OW15R0o0alYwVkZjK29pWm45Z1FjdmFZVFViVTVp?=
 =?utf-8?B?THAxeFU3dzVSVVJWR3NzSGI1NzVwWmZ5ZllpcFRqWm1kOW0rWFNoSW5kNE52?=
 =?utf-8?B?KzNlelBjVUUxTVJrcjA1cDl1c3BlRkRmcTBCZExFK09CaUNvQTUzdUZiaEJi?=
 =?utf-8?B?MmNxbFFUMUpONjNzblJFYmR3Y1AvTVJNTG9ieUo5VG14VzlHOWo0NnRwYWtU?=
 =?utf-8?B?Y0ZmN3FmOEtHc3FxdUI0eEYwTlE0U1ZCY05ESFkyaCt5TmVsb096QTlGOUds?=
 =?utf-8?B?c1pDL0RRa3lWaEYzajdEY3lHT2xEY1A5NU5SWENQT1psWTlRaGMyRDdpM0xQ?=
 =?utf-8?B?WktqdlgvVmdidmhHOUNaWVVzaU55bVdrb3ZwNGxwRmZzWkNobTBIOEpOb2dT?=
 =?utf-8?B?Zk55M2ZKbS9OWGttQkYya1h3Uk9mWE4zYUZRZ3JLMW5aaU14OTRvSWViTXNF?=
 =?utf-8?B?ZzRva3kweDZOOGVpU2oyNjg3VW15a3I5V3k3OCtrc2pCMXpPekE3RW1HQ1Ry?=
 =?utf-8?B?NjBCWDYyNHo4akRjMnZGZU1XdzJ6QnNia0R0VUtob3lyM1puVGJRNjgweTNu?=
 =?utf-8?B?ci9QcURwYk5EWlNuWEhXWm9zYXJvMnRpWDV5YzFBUzJvKzlCS3JZeEVqNjUw?=
 =?utf-8?B?RytSTi82SjlyQXBBc2JzQ01saWJDTjQ2N2lUWDdSMUpLR0M4QnhXWXc0dytq?=
 =?utf-8?B?SDMrck9qMURtd1RORW4wNUYrN3hyMnRyNlN2SEM3OWx4M3VoQmQwTzJyMk03?=
 =?utf-8?B?cVdhdHQ0bC9pdHVGVVNYQ3puYXoyMXhkMjlrOHdTKzhCK2ZES1JXRlRwRWJO?=
 =?utf-8?B?bUxaTFdScU1QMzM1S0RXZVNmbkZCV29uYmZTMVNFUGp4TnNHand1THNJdEFI?=
 =?utf-8?B?ekZOTHZPbUtxYkticWF2VUN0WFdlQ3Zub1pTQm5JVUxOUGhuMHhtQS9jWDI1?=
 =?utf-8?B?dEtRMUlSRENYeElWSTlkL25xdlFIK1FmbERJVVl6NXFMU1JnN0M4UVNNZU1x?=
 =?utf-8?B?aWhlcjZpYVRmOGpPTXhHTEFkbWNzNmlHeXdLL25BYitLK2JBcHk1b2hNYnpU?=
 =?utf-8?B?T0pFZ2JacC9qMVV5SUU1NDEwUmdHYkNuTlhTaWN6eEhBSXJ6a2xXdDEvUTRM?=
 =?utf-8?B?UFM0K1ErU2U3R2NicitPblUyUmVUQldIb2VWTUVYbGxsUW9nUjFVQzdDUExt?=
 =?utf-8?B?ektsaW5sblJDV0JoWWZNa0l6VEpYTUEwczE0eEpFT0dHYTlvcWpISVJEaEZu?=
 =?utf-8?B?Y0txcnFubFhKanZYRVphWTFGWVRBdlkvS1JzTTZVZnprb2JxMHZHdlhINkd4?=
 =?utf-8?B?UURaRWg1R2QyaFpOcldKMHprZFRlT2xCVDV2TzBvUkRQdUQ1b1J1SXJnbkVS?=
 =?utf-8?B?N2ptMklTRmxtRkluVjE3TmNRcUhtQ0dqQVY5dTFsVW5NS0YvR2ZWNHQ1Z2dU?=
 =?utf-8?B?Vlg1dkZRNi9mYmxLenphdytteVZNcWEwcThLN1JreWNqKzZqb092aloyTUYr?=
 =?utf-8?B?ZHJ2QlFPUm5OUUppV3hobndWUGxEVldoa3I1WXJJVit4aE5UaWVPRjEwQmtu?=
 =?utf-8?B?R3I0Z3lodEhvWENOMUt5YTZNM2pOQnhlbUI1WVhETVB4T0tiejIyekU2djhZ?=
 =?utf-8?B?bmw1WmJrT2ZUd3FIVzBKdEI1eGpuNE1KVTdhUFBmUDFZT1dScHJsRHR2c2Yw?=
 =?utf-8?B?TDZSenJUTXNyRDdsUHgxM1R1M0VJQzNOUmtad2RQZ0hKeXNLZVV0TnduT0FJ?=
 =?utf-8?B?YjhGalA4MGlsRHJBdzhiMkx4cTYxSXhTZlJEUlhaZEJVMWJBbUJ3Q3FyZjB3?=
 =?utf-8?B?dFlzSktZb3k4UloxYkVNbzJhaVpXeTk1R2tPZ25haDhmbG1YOEZ3MENLYnRQ?=
 =?utf-8?B?TkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a7dcefd-d2bb-4346-e9fd-08db9e5690bf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 12:44:43.7809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QyrJAT2O2bT6Q673U+aRjBUu8IO7th6u84ZAGKhUQlhoXxl3Yzo0/QrrO114y3lV9ThGVleyjKjM8zmyCg/fjfOfJjkqu5Wu92mc//er5tY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5445
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ratheesh Kannoth <rkannoth@marvell.com>
Date: Wed, 16 Aug 2023 14:37:18 +0530

> octeontx2 driver calls page_pool_create() during driver probe()
> and fails if queue size > 32k. Page pool infra uses these buffers
> as shock absorbers for burst traffic. These pages are pinned down
> over time as working sets varies, due to the recycling nature
> of page pool, given page pool (currently) don't have a shrinker
> mechanism, the pages remain pinned down in ptr_ring.
> Instead of clamping page_pool size to 32k at
> most, limit it even more to 2k to avoid wasting memory.
> 
> This have been tested on octeontx2 CN10KA hardware.
> TCP and UDP tests using iperf shows not performance regressions.
> 
> Fixes: b2e3406a38f0 ("octeontx2-pf: Add support for page pool")
> Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Sunil Goutham <sgoutham@marvell.com>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> ---
> 
> ChangeLogs:
> 
> vi->v2: Commit message changes and typo fixes
> v0->v1: Commit message changes.
> ---
>  drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c | 2 +-
>  drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> index 77c8f650f7ac..fc8a1220eb39 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> @@ -1432,7 +1432,7 @@ int otx2_pool_init(struct otx2_nic *pfvf, u16 pool_id,
>  	}
>  
>  	pp_params.flags = PP_FLAG_PAGE_FRAG | PP_FLAG_DMA_MAP;
> -	pp_params.pool_size = numptrs;
> +	pp_params.pool_size = OTX2_PAGE_POOL_SZ;

You still didn't respond to my previous message or maybe I missed the
reply somewhere: why not min(numptrs, OTX2_PAGE_POOL_SZ)? Why create
page_pool with 2k elements for rings with 128 descriptors?

>  	pp_params.nid = NUMA_NO_NODE;
>  	pp_params.dev = pfvf->dev;
>  	pp_params.dma_dir = DMA_FROM_DEVICE;
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> index ba8091131ec0..f6fea43617ff 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> @@ -30,6 +30,8 @@
>  #include <rvu_trace.h>
>  #include "qos.h"
>  
> +#define OTX2_PAGE_POOL_SZ 2048
> +
>  /* IPv4 flag more fragment bit */
>  #define IPV4_FLAG_MORE				0x20
>  

Thanks,
Olek
