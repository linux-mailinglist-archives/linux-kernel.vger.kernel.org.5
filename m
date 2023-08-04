Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF18476FBBE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbjHDIMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjHDIL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:11:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196454683;
        Fri,  4 Aug 2023 01:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691136717; x=1722672717;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GhK2I4kHXntqvlOMdfUJNyr0pL80k46qM44CpW6hDGQ=;
  b=cmYSEfRRZfxEHki0leCo7EEnMOWKwo75+12dtlE7AymUhdluPLyfNbVw
   wjmy+CYHw2E3HQ/dxuM20/iXE3jvsaEGwuB9llY8WlPeQwWmtuympb5Wq
   Yp657VpWxoOqvAymHn4U1OfmtrHghkAsBURToEavgkN979aFU1yi7xwoP
   yEYrEvRvAix91BF5rA/wObasvb4cMpud6R4e4WVxskMlb84iovMc/i0bU
   LGLoKQTbIs5er+3AkBc7EGSvt+YNN3X3MeSylmk3sb1jHZAd/Nqp5uFl2
   rm9SFijYRbHxSjm9z9skDYkBv70+c/lD5pgtg2dTeKkGLTMiWIxEI3Mtv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="372847249"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="372847249"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 01:11:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="765003076"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="765003076"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 04 Aug 2023 01:11:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 01:11:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 01:11:55 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 4 Aug 2023 01:11:55 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 4 Aug 2023 01:11:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xr1mdXMVSDNG5b1asqIB0wE7TevqqX+kgvB+23KgGkAjAuojcxgSk1yG+qL+OKIVCFrdw2cLk+UCyt1wYNrQKCbKncFXJdVnQdxiE/xo4nRpwvHTJ7bPvJi4xgnWsVpCD6UwwVZzTp2ajfct3o0oSAjdEzdZ4phovEYK6CBJKDQb7hJiSLQuNmqJF5Ok9jJgcK8/Q6vdzbsF69C/CVlZ870jpzMkL9rEUt7mMuxSfBdkaMCRFldWrpEPEZKQnW3hieBJB4DOabqbWnicdZOZO923n9oFM9NJ6nMEKgBIG8SijXuV2qCGJOmrPZRaZWaKwAtLE36/eJZnq7QdJlAKtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66NbjLYmSSXpiY8ESUzhNy4v+kK32CSvm4w7SBjzB6A=;
 b=W6asMJMDyVlgY8fTFi69g02o7EKm86PurOpHbGTpo4sNludoNyQgnL3bLfWSBlHiftFm5/2sbVQlo42Wcn0uVmsR6ojYj6k4TLsTxLyPUSo9DK+DZsOo6Iei9oDFSJoEiupxIsDhb2zmaducg20bo/oRruffKmebajai9U8B5Tno7GmoWyTWBAZNU2x8sQ9g9wMjmnk6SrN8DmaRZaDrrFUokGmor9y7Lo0WYdEcFIDV6OVH10iZP9brFOEeNNE4402MExxKFEbTw49lqx4M0m4m+Sh/qtznGXaz00L6abBEYgFONGIE7VrgNXbcxor/1BJf31YCJveVon4DjrWkmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SA2PR11MB5193.namprd11.prod.outlook.com (2603:10b6:806:fa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 08:11:53 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 08:11:53 +0000
Message-ID: <2fa4d5ca-b486-b246-e4a8-531e322e86e9@intel.com>
Date:   Fri, 4 Aug 2023 16:11:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH 0/2] don't use mapcount() to check large folio sharing
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, Yu Zhao <yuzhao@google.com>
CC:     Ryan Roberts <ryan.roberts@arm.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        <akpm@linux-foundation.org>, <willy@infradead.org>,
        <vishal.moola@gmail.com>, <wangkefeng.wang@huawei.com>,
        <minchan@kernel.org>, <shy828301@gmail.com>
References: <20230728161356.1784568-1-fengwei.yin@intel.com>
 <3bbfde16-ced1-dca8-6a3f-da893e045bc5@arm.com>
 <56c8f4f9-b54b-b0bb-250c-ec8643accfc7@intel.com>
 <3541d2de-5cf8-2f84-8153-277e2bfc0101@arm.com>
 <5f98748a-97ca-6426-1e24-a5675da75381@intel.com>
 <a590da86-0c42-7d46-d320-c661a59a46c1@arm.com>
 <837ba176-c97f-f81b-c044-eb6aa3d88bb7@intel.com>
 <CAOUHufY9EQ70Pn-n2zVa9=Gm3-WHxxphp7VHia4qv9x2domdbg@mail.gmail.com>
 <40d49276-fae9-e538-61cf-64bb79233bc3@intel.com>
 <CAOUHufbcAJWUoVuCYtaDZKdcw+JPWVV0EiB=JcDvz1Jt_Au2Tw@mail.gmail.com>
 <45457815-66c4-029f-42f9-6c377e4eb1e3@intel.com>
 <75996f6b-63fe-4878-c19d-bf35ee2ad20b@redhat.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <75996f6b-63fe-4878-c19d-bf35ee2ad20b@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0128.apcprd02.prod.outlook.com
 (2603:1096:4:188::20) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SA2PR11MB5193:EE_
X-MS-Office365-Filtering-Correlation-Id: fa1ccd67-9a1b-4aa4-18b6-08db94c27641
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nhzq1OvM9+s6qHVpTtfLjUc3DkN0vRP52VMksbHvRJz3qi2/bg2q9C24oZjvVvEcxS/ebXjcn8awb9rf7EuUQNTk7rgnVNva2wfS3lo/H0pyYYOmb/kLFhL81ORr93njSoV442nIGw/7sApPYChkZ/8sT7YYX7nG+nL0n6wfaIR6n10O2LrJPOdjDhCQabjn/xFyQ/ba289+V2Du+WyqEvFKHWDmFHS7NzhlzKO43fqNJE779Z2t9hNSTJfV6mq0XBPLGmp15t2y3vRa0vShg7cvfjllA39cQZjOD08USzPchNTHvyxQQOMRDP3ZeU1KnhSTp7Rb4Su2Uiam+7cUCs3+3hHFQNiU/3dLM15ZWVWF9KV6JQYscIxRRb7jBVYWeDrn6nTiVejgQS2goFyb43CYmRn9+dAVRa9BtAP5US4K2D9XRaLATQTZ/5tOSsZOZ5qnWJjvgWW5kuOoekwtFOAj3pJiYB0iZWjo9+UqTtl0cOJ0PZ98XHEJaAhGAYaMd+Dz4KAd9FSvBTkdj2q9bmc8dCLzm2jWkrDAe63wvB1dXVmZxqS4u8yvsF11y+fSCxLUWMwaY4VGqRqHt/kX57n5l6x+2B1/vbflfcEWwYWmT1DjfYhrSf0WzcWn7nh4KTk49yIUmUywkq3WwoKdjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199021)(1800799003)(186006)(2616005)(83380400001)(53546011)(26005)(6506007)(8676002)(66556008)(316002)(2906002)(66946007)(5660300002)(66476007)(4326008)(7416002)(41300700001)(8936002)(6486002)(6512007)(6666004)(966005)(478600001)(110136005)(38100700002)(82960400001)(31696002)(86362001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnB3ZDFuZ1MvalR6NjhvK0Q1ZXI4WVhheFhHbDNkTHo5QVhXb3VISVBhVjF2?=
 =?utf-8?B?WTBZdEhCVTd6bmFQRU1WR1VuUDFpRlAvdmJyNmRpVVkvVk1Ic3MrbEhlU2lh?=
 =?utf-8?B?Q2NCcHZQdGI3eENrekdsd2pjL1lBRHJpLzBXbjBDWXBuVlVweDRJLzRMcGtW?=
 =?utf-8?B?Y3FHQTZOL043Rm9mdUhGRTN3NUtaZGVESytDS3NkbkNYdmZHM09DVTZlVnJz?=
 =?utf-8?B?VG9HT09pM2hMLzZXVDg5Q1RCWUg2cndOS0kxZHRYVDRTd2FyTjBua3hCMkky?=
 =?utf-8?B?YjBDMEo0VGxJbUhheXA3SFpEa1EvbVBYS1c0K3FDRURCQUFkdjlHQ2xtVEJT?=
 =?utf-8?B?RzAvdHBPMDE1M3NDcXRDY3RDYTJ5SnV4YlA5OEZxVC9ubTEzKzQxWkorL0NZ?=
 =?utf-8?B?OWlQdEJ6a0I2S250ZFJkR1hNSTY4YlJTRU4yRjJsdFdxNDlJeHgrcVdGMU9i?=
 =?utf-8?B?Qk1Lekl0c3g3K1dvNUQxKzVMSmgrWGE0dGtkNFNvaVlLb0RzZVljRkFSVCtY?=
 =?utf-8?B?UjFJQUlXUG5mUmZtbDNuV0p4aENQMmlmY3pHelh1ZUZYcnpaMHIyOWtYZEFn?=
 =?utf-8?B?UUNzTXF2aWVFWlV3dkJhTmR0eGI1Z3ZRTjVxY01JZEZSbUpvMDF1SFI5Ly9s?=
 =?utf-8?B?M09zYnBCTXVIWjVLYldkcUJ3NnhwMGZVcG9qSlRDOUJ5elhvZVExY1ZqeXYy?=
 =?utf-8?B?dXJpTTFqZmwyaUoyTnFlQlQ3R0hWUEZqdnZzdU1SR1dEaWtZNWt3Ly9xUEx6?=
 =?utf-8?B?VEVqTUhvWGJUY25Pc1ZydWFaUnh3MW5GUVFZRzROZERWaXRocWg5blhNRWdr?=
 =?utf-8?B?TzZudVdSSklYOW10S25qSzE4b0FtMS9BbldjZXNIbjhoeWJoaHBBZy9IL1cr?=
 =?utf-8?B?dU1XQ3VxS1NiVnhNZzMyYTFaMzhpQVhORnRiSFBzK2lKbFIvazl2a2dmMjIy?=
 =?utf-8?B?Vk5XeENvd0Evb1FtNjVXaGthbkduc2JzUzU5NTlDc3NKeWVYZll5OFBxTXl3?=
 =?utf-8?B?NmVxVGZudThSRnJRVGxmbDV6RVdpNyt1bjhuRmxWTXNrV2VQbDRMN0ZUbzhl?=
 =?utf-8?B?TWtRbVZITEloeVcwdHFMTmU1S1NVNlhJMVpBWXppMjk5Ump2TjdPRXVvRS9z?=
 =?utf-8?B?NGdVT1k1ejVHbUZLTlZVWWhaRWZUOEh5c2s1NndSUVg2aEIydWdvSlZNaDZn?=
 =?utf-8?B?MWQxbUxpaEx0Y2FiOU5YN0l5R2xFWSszTmU0dHpDanI2bTBYNlhTVEYycjVR?=
 =?utf-8?B?WVMySTFLTXlKSmFBWkM1eHJwb0w1ckxzTW5TT3VXUnk5ZEhyRmFlRytiMzBk?=
 =?utf-8?B?UVNxdjg1VE8wbitic2FkYm1JVWQ0VTNGUVJiYWtNRzR1VXVaUGZUWUROcVJz?=
 =?utf-8?B?SFpaOURpa2g2YWNMMjdYbHp5eUlSU3BpRnVWRmU5UG5ld3JDMHpiZWZkZWs5?=
 =?utf-8?B?UHArNjlkOUpHODJ1Yy9Tc1EycUJXREdTR1h3UDM3M0RQbEdBL2ErMklPQTdX?=
 =?utf-8?B?QTFIRi9KeUJlODloUHhXS2hSdk5xRnZzSlJKNVNzUzI2ODlEWjl2eS9uTEhF?=
 =?utf-8?B?SVI1MkRGWWpzMHFUN3hMcEZNTjR0QkQ2OFFJNTBMMFdQbktFTDhTYXMyRm9h?=
 =?utf-8?B?d1hVWnZrbDY4VHRQeXpVaWd2WncwdVBXY3k4ckxIbVVpZ3g3cDlQSHBkOHBj?=
 =?utf-8?B?MHJDMW1RNHdDN0c3SkV5MVQzTEQzSkRVNXBaK2s0emkxYkloNEdUckFFVFhr?=
 =?utf-8?B?b1NIMUp6dHpIdGE4OXBId0UrYWxZWTMrUmJocGNydGMveVN4ajErUm55RjVy?=
 =?utf-8?B?bVg5K3RpRWhJOGpoSE4xYUtIdmhVeHVFNXA0QTl1QktjUFZDbll5VW10Y2Nw?=
 =?utf-8?B?cXpoSzFEd3dFWk05cnMxeEsxRE1samVwK0N5em8zaVVKWTZ5cWlRZEZteHpC?=
 =?utf-8?B?RGZWd3oweDZJRXlrNE9JSUQwOGJ0NEJxMVJoYS8vZG5oUzN1UGhRSEN5OE9B?=
 =?utf-8?B?aURWQzc3VWRyei9qR2tJWm9IWFh5VHhJd2ZOcHZXUUc5VEIwalh2VWQyQk9x?=
 =?utf-8?B?WXltL2QvVm0vWGRad1dSZHE1bi9sd0VaaVhIMGhXR0t4ak5mT2tNeEs3TDBy?=
 =?utf-8?B?bXF4ZXpYbndmZFNqbTRBM21VVVBTN3N1MGFwU0Vrc2ZjN3VZL1NOeCtnaTlq?=
 =?utf-8?B?UWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fa1ccd67-9a1b-4aa4-18b6-08db94c27641
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 08:11:53.2953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2F6an1DiJ2Li5J05IqlyZ8UfJXM34inTnZyHrNp/Lzlo5RSE2SaImPLgl9kx7lE78VBIdFG9IM+NFTKqshSOFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5193
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/4/2023 3:31 PM, David Hildenbrand wrote:
> On 04.08.23 02:17, Yin, Fengwei wrote:
>>
>>
>> On 8/4/2023 7:38 AM, Yu Zhao wrote:
>>> On Thu, Aug 3, 2023 at 5:27 PM Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>>>
>>>>
>>>>
>>>> On 8/4/2023 4:46 AM, Yu Zhao wrote:
>>>>> On Wed, Aug 2, 2023 at 6:56 AM Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>>>>>
>>>>>> "
>>>>>>
>>>>>> On 8/2/2023 8:49 PM, Ryan Roberts wrote:
>>>>>>> On 02/08/2023 13:42, Yin, Fengwei wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 8/2/2023 8:40 PM, Ryan Roberts wrote:
>>>>>>>>> On 02/08/2023 13:35, Yin, Fengwei wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 8/2/2023 6:27 PM, Ryan Roberts wrote:
>>>>>>>>>>> On 28/07/2023 17:13, Yin Fengwei wrote:
>>>>>>>>>>>> In madvise_cold_or_pageout_pte_range() and madvise_free_pte_range(),
>>>>>>>>>>>> folio_mapcount() is used to check whether the folio is shared. But it's
>>>>>>>>>>>> not correct as folio_mapcount() returns total mapcount of large folio.
>>>>>>>>>>>>
>>>>>>>>>>>> Use folio_estimated_sharers() here as the estimated number is enough.
>>>>>>>>>>>>
>>>>>>>>>>>> Yin Fengwei (2):
>>>>>>>>>>>>    madvise: don't use mapcount() against large folio for sharing check
>>>>>>>>>>>>    madvise: don't use mapcount() against large folio for sharing check
>>>>>>>>>>>>
>>>>>>>>>>>>   mm/huge_memory.c | 2 +-
>>>>>>>>>>>>   mm/madvise.c     | 6 +++---
>>>>>>>>>>>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> As a set of fixes, I agree this is definitely an improvement, so:
>>>>>>>>>>>
>>>>>>>>>>> Reviewed-By: Ryan Roberts
>>>>>>>>>> Thanks.
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> But I have a couple of comments around further improvements;
>>>>>>>>>>>
>>>>>>>>>>> Once we have the scheme that David is working on to be able to provide precise
>>>>>>>>>>> exclusive vs shared info, we will probably want to move to that. Although that
>>>>>>>>>>> scheme will need access to the mm_struct of a process known to be mapping the
>>>>>>>>>>> folio. We have that info, but its not passed to folio_estimated_sharers() so we
>>>>>>>>>>> can't just reimplement folio_estimated_sharers() - we will need to rework these
>>>>>>>>>>> call sites again.
>>>>>>>>>> Yes. This could be extra work. Maybe should delay till David's work is done.
>>>>>>>>>
>>>>>>>>> What you have is definitely an improvement over what was there before. And is
>>>>>>>>> probably the best we can do without David's scheme. So I wouldn't delay this.
>>>>>>>>> Just pointing out that we will be able to make it even better later on (if
>>>>>>>>> David's stuff goes in).
>>>>>>>> Yes. I agree that we should wait for David's work ready and do fix based on that.
>>>>>>>
>>>>>>> I was suggesting the opposite - not waiting. Then we can do separate improvement
>>>>>>> later.
>>>>>> Let's wait for David's work ready.
>>>>>
>>>>> Waiting is fine as long as we don't miss the next merge window -- we
>>>>> don't want these two bugs to get into another release. Also I think we
>>>>> should cc stable, since as David mentioned, they have been causing
>>>>> selftest failures.
>>>>
>>>> Stable was CCed.
>>>
>>> Need to add the "Cc: stable@vger.kernel.org" tag:
>>> Documentation/process/stable-kernel-rules.rst
>> OK. Thanks for clarification. I totally mis-understanded this. :).
>>
>> I'd like to wait for answer from Andrew whether these patches are suitable
>> for stable (I suppose you think so) branch.
> 
> Note that the COW test does not fail -- it skips -- but the behavir changed:
> 
> $ ./cow
> # [INFO] detected THP size: 2048 KiB
> # [INFO] detected hugetlb page size: 2048 KiB
> # [INFO] detected hugetlb page size: 1048576 KiB
> # [INFO] huge zeropage is enabled
> TAP version 13
> 1..190
> # [INFO] Anonymous memory tests in private mappings
> # [RUN] Basic COW after fork() ... with base page
> ok 1 No leak from parent into child
> # [RUN] Basic COW after fork() ... with swapped out base page
> ok 2 No leak from parent into child
> # [RUN] Basic COW after fork() ... with THP
> ok 3 No leak from parent into child
> # [RUN] Basic COW after fork() ... with swapped-out THP
> ok 4 No leak from parent into child
> # [RUN] Basic COW after fork() ... with PTE-mapped THP
> ok 5 No leak from parent into child
> # [RUN] Basic COW after fork() ... with swapped-out, PTE-mapped THP
> ok 6 # SKIP MADV_PAGEOUT did not work, is swap enabled?
> # [RUN] Basic COW after fork() ... with single PTE of THP
> ok 7 No leak from parent into child
> # [RUN] Basic COW after fork() ... with single PTE of swapped-out THP
> ok 8 No leak from parent into child
> # [RUN] Basic COW after fork() ... with partially mremap()'ed THP
> ok 9 No leak from parent into child
> # [RUN] Basic COW after fork() ... with partially shared THP
> ok 10 No leak from parent into child
> ...
> 
> Observe how patch #6 skips because the MADV_PAGEOUT was not effective (which might have happened due to other reasons as well, thus no failure).
> 
> The code that broke it is
> 
> commit 07e8c82b5eff8ef34b74210eacb8d9c4a2886b82
> Author: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> Date:   Wed Dec 21 10:08:46 2022 -0800
> 
>     madvise: convert madvise_cold_or_pageout_pte_range() to use folios
>         This change removes a number of calls to compound_head(), and saves
>     1729 bytes of kernel text.
>         Link: https://lkml.kernel.org/r/20221221180848.20774-3-vishal.moola@gmail.com
>     Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
>     Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>     Cc: SeongJae Park <sj@kernel.org>
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> 
> 
> Ever since v6.3.
> 
> The simplest way to fix it would be to revert the page_mapcount() -> folio_mapcount(),
> conversion.
Confirmed this patchset also can make swapped-out, PTE-mapped THP related tests from
skip to pass.


Regards
Yin, Fengwei 

> 
> 
> Probably all that is information worth having in the patch description.
> 
