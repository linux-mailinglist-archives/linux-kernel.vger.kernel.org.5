Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F61C76F623
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 01:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbjHCX1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 19:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjHCX1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 19:27:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86531BF6;
        Thu,  3 Aug 2023 16:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691105250; x=1722641250;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XEY85hqzTu4MeOGcvbpUhtOQJxkr16cuhMq+JcwSPlg=;
  b=azqtq6iLJhGYy84XQrw5hAH+sri9mqcPnqcEDzrOjEiZSeKTIHDJSeNJ
   rPng8sSZ2zTVt4ERFhRrp1F/KLmdEbsLO95J/xroeCodthTIkLXje4UzB
   wOsJCb/qIXrZn656dS0tH9c8sgvjkSau6dHK3owsLyaTg5NIW5OI9B+Ab
   i05rfro34GXfF3xldIqhuAAYFPRe8GplahmTvwTZRY7c70DSuFaRwxbnQ
   PuUIknfGTYN/XGQR8xPdRishepkxF1qBdEK5a44qZstYxZ7rZs4HPbgd9
   KlGxyK0kHVIenaktGOYuOQw2EM3gV1EYu5q8+mrv+NOqsynZOV5R/BAO2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="349611026"
X-IronPort-AV: E=Sophos;i="6.01,253,1684825200"; 
   d="scan'208";a="349611026"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 16:27:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="759319260"
X-IronPort-AV: E=Sophos;i="6.01,253,1684825200"; 
   d="scan'208";a="759319260"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 03 Aug 2023 16:27:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 16:27:29 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 16:27:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 3 Aug 2023 16:27:28 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 3 Aug 2023 16:27:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HjgL+oaO86Nz9gbXSgqeJARKAJUhsc9EdEZeMCEV2L+u3BZ+h1gNBzRsIms5MD0nDCk2Ro1bEtvMyQl3QJHD3iuNNWZj0R4urFwKLWbyiMDajP/AF9IW1QBXCazkCEPhx3S/9YRN0eeIoWWNwca22sNtRMNyTjtk9hXs1/XwpjifxDnnMnzngm5o7j2xo0YBIE3jyImUL3i1WuaIWExs3X9Ked8he+jJFwE00W0nF4STyqZC93ZbIwCUdpxsGUQDDFGcyDt0Py4ZOv8keDUAbqxqNquGOiHsN9+kWpmgtqdmFHlrgDhVic1NNnvrI1+tlIWbhBNrNshKJWEAOOpcLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONmtCAT+kc9GFACZZRRlDK9CgQNw3KJNidP18zQEy6E=;
 b=SvI/62Bc6Sv6jS5NoUVvp0VFrhfL8pGVzyUzuQU5C1DavGwoumV0lStF/wXJLlplJIYVgD4I5SV+LsYRuJo7bR0LuLB56i/ifiD2hMRLGPbvsRSXfby4rTQUrweCeEbpoBtd8Rx5tbRZQe+c2xAs3Ljh0QVty0iJObl+XE+ZWZNdBkmjRWlwvi4dukpPRRvGtr+CBVp7/+YCSKtjIQUnA9fTAYcxoMS7EwuULdSEkkaLpDJXYsdoaEjvp1AnuZ7U9KoaQmvhYDTJIFiDbQvdEAv+e54JrDj7DVwe+Sv06KuefDt6O1TW+j9NyjcwZzzQ5OKc1hyHAeDfg0fZZIpQaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by LV8PR11MB8557.namprd11.prod.outlook.com (2603:10b6:408:1e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 23:27:26 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 23:27:26 +0000
Message-ID: <40d49276-fae9-e538-61cf-64bb79233bc3@intel.com>
Date:   Fri, 4 Aug 2023 07:27:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH 0/2] don't use mapcount() to check large folio sharing
Content-Language: en-US
To:     Yu Zhao <yuzhao@google.com>
CC:     Ryan Roberts <ryan.roberts@arm.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        <akpm@linux-foundation.org>, <willy@infradead.org>,
        <vishal.moola@gmail.com>, <wangkefeng.wang@huawei.com>,
        <minchan@kernel.org>, <david@redhat.com>, <shy828301@gmail.com>
References: <20230728161356.1784568-1-fengwei.yin@intel.com>
 <3bbfde16-ced1-dca8-6a3f-da893e045bc5@arm.com>
 <56c8f4f9-b54b-b0bb-250c-ec8643accfc7@intel.com>
 <3541d2de-5cf8-2f84-8153-277e2bfc0101@arm.com>
 <5f98748a-97ca-6426-1e24-a5675da75381@intel.com>
 <a590da86-0c42-7d46-d320-c661a59a46c1@arm.com>
 <837ba176-c97f-f81b-c044-eb6aa3d88bb7@intel.com>
 <CAOUHufY9EQ70Pn-n2zVa9=Gm3-WHxxphp7VHia4qv9x2domdbg@mail.gmail.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <CAOUHufY9EQ70Pn-n2zVa9=Gm3-WHxxphp7VHia4qv9x2domdbg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU1PR03CA0003.apcprd03.prod.outlook.com
 (2603:1096:802:18::15) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|LV8PR11MB8557:EE_
X-MS-Office365-Filtering-Correlation-Id: 498d4927-087c-4116-b877-08db94793277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 39aRirNaWvqmu00ZVFYZE1sM30YuhlzYvXEtTS1lpaY2MHZ3bjDFoL+BAB4OYLQ20Tqyps8w1+PWqPG4ox2uNe0FG0nfZx+cnradqVUNJ2AKIdBsVdmRli+nfpU6F+GUphxvyZRIHYbGE/d9II2n91AhWIAIwNZ+Pct6CQdYj+CxvSjQT2RwvG/gKrBFVXUymiWJ1VvKIm8HwbsaOlD0ldjh6rhIiMhxYRfASYbrS+jRScSeUJOP41l5G4yKZZy4whPzt/n2Z47LnJWM7tGzr2ibw7YXqqfQozt9zKSyCxiErBFP/bZAEgj+DDTnpCvXdNstXS9q+kODzQ+MVF/f0rqYMUuwjgAew7JJO7FDoLaz9UP/gG5ROJkz24ToO6aE3Ik++ok6zlYxO953QNuYbRzAEbo4CuEdKeHYp5GzNokgZc7/DHrlierA+0zaao5fXC/8CNrWpAJrsTkiGjfWJT9z7Kh3O4gZmRal0b2odPOcpGPEAItMsXveFAf1Kai5/aoa6YjEyLzmvoD2JsGKo2XTO6aOdUGFX+SVNQVQJXWa0S0TQI4KlInZIGze6/ORV9A2yILWxouWzFQtm+eMktH418y8oc8P3hebOXlwxtXI7aJkKcMDsZWzyGTLJEbt7IjgpLyOCUxS25CprpKNCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(346002)(39860400002)(396003)(376002)(186006)(451199021)(7416002)(31686004)(5660300002)(8936002)(8676002)(41300700001)(66476007)(66556008)(66946007)(6916009)(4326008)(316002)(2906002)(966005)(6486002)(6666004)(478600001)(6512007)(82960400001)(86362001)(83380400001)(2616005)(53546011)(26005)(38100700002)(6506007)(36756003)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0Q2aGVtQmNuWVpZRGdjU0VCUGtWTy9rb0E3c0sybnU5azVydDAxY0I3VG5V?=
 =?utf-8?B?eWZIbW91Q3g4SEo1T0JQdjIweUt4Wk1tekdLdWFWOUIwV05JYU9aNmJMRGhj?=
 =?utf-8?B?OEYyK0s3aE5xU0sxb2dpc0htNG85em9VeVpFK1ZmNVYreVU3SDZhTHg2K3F3?=
 =?utf-8?B?T1pJYUg2dTcwYzdwSldRS0pzMFJ1UHVuN2U5Ty9QQW1WVjkvOFVNTytPSzly?=
 =?utf-8?B?czFSL2NRRUQ3aXI1V2pwUGNaK3lwa1Nlbi9KZEVxcS9HSXE5bVFnSDlGVGdi?=
 =?utf-8?B?U1ZVQ3cvQWtYSGpwRDRDQ2RqY2owU2Q5bStHd2w1LzdISG9tWEVGcG5WU3F0?=
 =?utf-8?B?NGJET0pJVHJDMllKNHJ5czhPeXZReEVhSVNXVnZDdFNtUVdlQVhPc3lhK0hi?=
 =?utf-8?B?OWM0NnkzakxONjhwWklqN1VnViszL0VlVkVXV1R3T1hWdm9PWDJJVmFDUVJl?=
 =?utf-8?B?V0k3S2NYRWpMcEluVWg1cThiRXpjZ0thSit0Q2tuNGhEN3JOVXpYcFV2VWsx?=
 =?utf-8?B?UnZwVzBVL29mY21jUCsvS1NmdG1mYURuMG94b0dzZ3cwekRTWEtQZTBIazM5?=
 =?utf-8?B?SmZhNGp5TlBZeit1WE5QNHZ4V1UycVAxZHF0dlFORjgwWnAzRzhKbFlnN2xh?=
 =?utf-8?B?bi95L2FWc0R6dG45Y0tiU2lNY3JsVFd6bnZvb01HZ0xyQzU3STkwd01ycWZo?=
 =?utf-8?B?T3QwcnBDUEtNZGJsUitzVDJWcXcydUszQS9neDBYQndyTnljQTNxcVpJL3ow?=
 =?utf-8?B?K1RIYzVwcFdBME0ycEszSjROam9haUhYWnpwdmQ0ZzUycC9KcnhyQUQxV3Jl?=
 =?utf-8?B?Y2M5TkQ4WkFHa2s2VnlGK3RxbE9BNTh3K1B0VVJXV01xaFRtMWFvaml5V0Ju?=
 =?utf-8?B?YUdSak84NlVzcWt3aXYwVW1SZW1HTExSU0lHZVRIQXBFWFZkUU5qa1JQaCt6?=
 =?utf-8?B?WDEzaWduTDYrN3NuZHdUaXFqSFI3c3VXUzFhRXZHbWtBT2RDdWRtNzRNbmNE?=
 =?utf-8?B?RTNacGpFaTAyd01ibTRKcXZXZ3hzdWVWZjNBL3ZNOVVtK3d4N2pRQ2w2ZGtl?=
 =?utf-8?B?WVA1Q0ZTd29iczBZUFdSbzJNcm4yTGsyWHJIc1RpODJjOGdkOHBySjR6T2pD?=
 =?utf-8?B?S0ZEeE4vMFR3dCsyZERzbzZrSTRKV2xwWmRjOGV1WThXYUZ0cXd0cFRVblNx?=
 =?utf-8?B?UjhoSG9Vcm9jek5SNmFYTlo3SS9aa21kQ2xqVzQ2RzlsakNabTdONks4bXhJ?=
 =?utf-8?B?OUFOaTJMdStxUEJ6bHZFcmQxRkJHNlQrR0RUOHpodTdLV1dFN21lc1Z5UU9Q?=
 =?utf-8?B?aHl4bk5HM2kzRXhpd1c3aHg3Y3dsOEdGSnhEeFZtTTUxajZJK2dKTHhHUmN6?=
 =?utf-8?B?SWdRbmFXVlBUcUJDT1hrbXRRY2RDZnZRdkFqaUdFWFFySUpFc3pNTUJVUm9v?=
 =?utf-8?B?c0xabkttdlZlb2loUVNaREMraU1IMnBRaGplSUtTTFhyR29XNXBpTjZETngv?=
 =?utf-8?B?ZExPZ1FSM2pUeWk3SnJuRERaam9KRE1GME9SNEdVbTZhVnU2UlpDYVZZRG5Y?=
 =?utf-8?B?WmFmOHJXWDVQaXVrbmxxaHZqMlpQVVhPRXpZeVZVdGk1WkJVbnhwWFVicm9h?=
 =?utf-8?B?a05JTGUvVGFXYTU0Y2lGc0pYTUFxcmFoaytKUTA0L3BjZnQyOTNJN1ZzS2sv?=
 =?utf-8?B?SS9VRnJjQ2hEVWFtRDZ3bUtXODJoZ2ZFNDJVbTN6RDNGanNYNjFReXFlTGFG?=
 =?utf-8?B?ckdEMEJad2ZxRkFYbWM3SGIvNFVYYnc3Slh4dm0rZUEvT2tUVkkrOGdSRWNV?=
 =?utf-8?B?aTZuUm1zK0FzTjRRQy85L2VrNThVUjRkOGV0cklPVTR3bHRFWmJUbkdxWFAy?=
 =?utf-8?B?UER1YXJTN0pieDcwQlNxZ1g0S2JZNGVZeHNvMm5tWVIrV1I3SFp0UTdDTDQv?=
 =?utf-8?B?N3YxaXZUKzMyT2VlbFRPajdGelR1OVY1VTdncHFyUVV6QjRPWXJ0di96YlpY?=
 =?utf-8?B?blB5SkFqS3RFN1FWQy82Rk15cC9CUWZ0SG5qc3NSL0pRZ3k2YkhqaU5mYnln?=
 =?utf-8?B?d3MxcmFXZFF6VTBhR2E2T3kyOG5DOGJrSTlYemhQNlFDREhIODBlK3ZPLzhP?=
 =?utf-8?B?L0UwUlRyellnTzA4dzY2amppbHA5MlF6UXYrSmtFbEhOWU1LaUJWUGxYV0FC?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 498d4927-087c-4116-b877-08db94793277
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 23:27:26.4472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3PhzIQXnwuwbQOW1fJ1UI2oOT/fPM4Gbj/R+nW6Y9yYZOsT/rJh3iRQ2A65ecam956BtQya2FKtyorm1YRVeDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8557
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/4/2023 4:46 AM, Yu Zhao wrote:
> On Wed, Aug 2, 2023 at 6:56 AM Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>
>>
>>
>> On 8/2/2023 8:49 PM, Ryan Roberts wrote:
>>> On 02/08/2023 13:42, Yin, Fengwei wrote:
>>>>
>>>>
>>>> On 8/2/2023 8:40 PM, Ryan Roberts wrote:
>>>>> On 02/08/2023 13:35, Yin, Fengwei wrote:
>>>>>>
>>>>>>
>>>>>> On 8/2/2023 6:27 PM, Ryan Roberts wrote:
>>>>>>> On 28/07/2023 17:13, Yin Fengwei wrote:
>>>>>>>> In madvise_cold_or_pageout_pte_range() and madvise_free_pte_range(),
>>>>>>>> folio_mapcount() is used to check whether the folio is shared. But it's
>>>>>>>> not correct as folio_mapcount() returns total mapcount of large folio.
>>>>>>>>
>>>>>>>> Use folio_estimated_sharers() here as the estimated number is enough.
>>>>>>>>
>>>>>>>> Yin Fengwei (2):
>>>>>>>>   madvise: don't use mapcount() against large folio for sharing check
>>>>>>>>   madvise: don't use mapcount() against large folio for sharing check
>>>>>>>>
>>>>>>>>  mm/huge_memory.c | 2 +-
>>>>>>>>  mm/madvise.c     | 6 +++---
>>>>>>>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>>>>>>>
>>>>>>>
>>>>>>> As a set of fixes, I agree this is definitely an improvement, so:
>>>>>>>
>>>>>>> Reviewed-By: Ryan Roberts
>>>>>> Thanks.
>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> But I have a couple of comments around further improvements;
>>>>>>>
>>>>>>> Once we have the scheme that David is working on to be able to provide precise
>>>>>>> exclusive vs shared info, we will probably want to move to that. Although that
>>>>>>> scheme will need access to the mm_struct of a process known to be mapping the
>>>>>>> folio. We have that info, but its not passed to folio_estimated_sharers() so we
>>>>>>> can't just reimplement folio_estimated_sharers() - we will need to rework these
>>>>>>> call sites again.
>>>>>> Yes. This could be extra work. Maybe should delay till David's work is done.
>>>>>
>>>>> What you have is definitely an improvement over what was there before. And is
>>>>> probably the best we can do without David's scheme. So I wouldn't delay this.
>>>>> Just pointing out that we will be able to make it even better later on (if
>>>>> David's stuff goes in).
>>>> Yes. I agree that we should wait for David's work ready and do fix based on that.
>>>
>>> I was suggesting the opposite - not waiting. Then we can do separate improvement
>>> later.
>> Let's wait for David's work ready.
> 
> Waiting is fine as long as we don't miss the next merge window -- we
> don't want these two bugs to get into another release. Also I think we
> should cc stable, since as David mentioned, they have been causing
> selftest failures.

Stable was CCed. Andrew asked about the user-visible impact and I replied:
https://lore.kernel.org/linux-mm/24e7429c-14ed-d953-e652-eac178de76e3@intel.com/

I was not aware that selftest is impact by the issue. And waiting for whether these
patches are necessary for stable.

But I don't want to promote this kind of change in other place as we will move to
David's solution.


Regards
Yin, Fengwei
