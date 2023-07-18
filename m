Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F21375891F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 01:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjGRXrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 19:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjGRXro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 19:47:44 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E9DED
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 16:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689724063; x=1721260063;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=inIIllDwTTSa1KHxiXXD0pu8U76YkQHhWHDDFJFMG30=;
  b=e1hCbOtqoPfzEL+Ty+D/GmcfWsj9/woC0kSQFfJvAWQHFn1tmRRdmlcQ
   reQ+x9KSnbYEANeHDXAdPA03ZQZnwQfhroJ0UnAXVoSWyWpOAsRGDMutl
   YftS/mTc50aMAyewZ2qupuqfMxQtd7sa7ikMrIGoLBFh6mI+yTxMDPFku
   wv026RxpjlOwg4l7qHurzuGLC+f6ZVetBoi3lIel+o52nQ1PBa4eydnr2
   PCR9NNX2ppnSTbcjoUaUWzBiyfyvLeNtvnWggOGKRisk1G4HZcUHURBxH
   y8iOJ+jeXshNXywpgfOoo9H5VFf63oJV1mXqVcSs6DO8Kn+1OynX5cPSZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="346638125"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="346638125"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 16:47:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="837457888"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="837457888"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 18 Jul 2023 16:47:43 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 16:47:42 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 16:47:42 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 18 Jul 2023 16:47:42 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 18 Jul 2023 16:47:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kr+QwNTmbuLO1Pz5EHG3nvajpUpFwa8CxmQMLggwOYa9W2gYjcSJDEIzd8nbqMaGgbp4CiUN4xOGKW41GOijdXiDB7n7+eg2Gfd50UeRM9Wp0Wh/ZAkwLd0bpy9c2CWQidhWS43gdeypg4ZqAlLZ1Wex7K7Rk6viJP+6AjXD7hMNgq3dSbSuIHKTA+7dr7sWvaVJgAHVDk86DOMeoDSlJRAaYjixPha1eF1cSQ9BWQfhzQGy1A2DplRgoZMr47KBA4vZW2mTKab071VHyyPUjltqsk0QmKxgTDBguyVGBMc3qyZNWo8Pqn0pLYg7s+R/eUOiINi/CSHkWPg8BN9y5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evGRvKbgDGTpoTEDxDJEm3zuJq7B7viT6gLhXzhfz60=;
 b=Xn5FA+iKDAD0CFUM5Jq3EqAuo/GtsJ0RTzMsOwnt5hMJ0TigmRhtAbmfe2Gbv1XUPyUXhF3QDEx38sg5HPveUfMRbB12nynnF4LKrXUx4oGyswAWZvzY0hRrHS0XgxjcC1g+HkXCODraAhk5oHjEBkZw7TQcphpkPmB4mu4pzplQJZOmkWki43PP6G/ZPJCAeQaV2w64t3mXf0Dq8DPO1hEUBpS6WdjUYoQpvn2innpXfKfpEPgyRu+hA7hoWHqqVWWhqwz0BnxzPyrggE2qLnF7/ZeihXfQ4K3h1HgZ1t6tWTGkBoKnHKb3rV/2CyBXRBwlFYMdAccYm0trz6xTEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SJ1PR11MB6250.namprd11.prod.outlook.com (2603:10b6:a03:459::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 23:47:39 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e%5]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 23:47:39 +0000
Message-ID: <b995e802-1500-6930-79d0-8cc4bfe89589@intel.com>
Date:   Wed, 19 Jul 2023 07:47:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [RFC PATCH v2 3/3] mm: mlock: update mlock_pte_range to handle
 large folio
To:     Yosry Ahmed <yosryahmed@google.com>
CC:     Yu Zhao <yuzhao@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <willy@infradead.org>, <david@redhat.com>, <ryan.roberts@arm.com>,
        <shy828301@gmail.com>
References: <20230712060144.3006358-1-fengwei.yin@intel.com>
 <20230712060144.3006358-4-fengwei.yin@intel.com>
 <CAOUHufYef--8MxFettL6fOGjVx2vyZHZQU6EEaTCoW0XBvuC8Q@mail.gmail.com>
 <CAOUHufZ6=9P_=CAOQyw0xw-3q707q-1FVV09dBNDC-hpcpj2Pg@mail.gmail.com>
 <40cbc39e-5179-c2f4-3cea-0a98395aaff1@intel.com>
 <CAOUHufZHyEvU-c2O6B6stM_QVMxc22zV4Szn52myYqjdZvptUA@mail.gmail.com>
 <16844254-7248-f557-b1eb-b8b102c877a2@intel.com>
 <CAJD7tkYAkVOE2caqEj_hTmm47Kex451prBQ1wKTRUiOwnDcwNA@mail.gmail.com>
Content-Language: en-US
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <CAJD7tkYAkVOE2caqEj_hTmm47Kex451prBQ1wKTRUiOwnDcwNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:195::17) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SJ1PR11MB6250:EE_
X-MS-Office365-Filtering-Correlation-Id: f6860b04-3831-4e9a-5031-08db87e95f26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z5W36h/LPrrN3sPuGnoGvui4bfZobNAwSCBYMNzCshpGFqHACC0/n28NiesFp9L7lcB8ZbROuvp1jJWR4qUhlnMyaTPvQunSC0J6kxv1OuNGXCB00CQN0bhu5rLJuL52SpKuvpGAxUXYO/0kPO75agM/jAIKwpjGMaMUO/Z/uomvmvLmHr+g3OphV1DqsGYDRSZcHp7k2cpx07r4wGW/frjLlFoQ48dZWSFg5zXf6aXEXQ70IWStNLQVjICzPitFDMupCL5dAtMPncrGHcrLgHUe7vbTTBIX/B57wlN4pjgy93+OSNyOzyim8112ctxtQiCmLrHgR5DcOAS0nQ9FjjhlC9N2mmVsybinSGGYBqIpQYkQgM3G/8aaco2vBzk+hIl5rqSI80jd9lGxnWqf59L6/wqCy5+BwCatWJT75ior/YgT6qDeb0XjurgoFqIRCTuZ1Fd8sheuGKZPM8XtTUmTw+zfFmnvI5Rkn3eqVu/QJQoMF5UR2bJkxZQ/7PWP7ookSbWHy8X+CJYQ/UVNKLQpEf9w19on4+ejM2S/PBniFQi3Q0ZfcnGhwwtUVe+R73E0BvoRPahbYrR7JQ4AanRrSqUUIFgzDTdHYDVvGW8ahJg200VA3USRH/L43H051Dn9hhe8Bvn9xZBbNREoZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(366004)(39860400002)(396003)(451199021)(8936002)(8676002)(31686004)(66476007)(66556008)(41300700001)(6512007)(6486002)(66946007)(316002)(6916009)(5660300002)(4326008)(82960400001)(36756003)(2906002)(478600001)(26005)(83380400001)(53546011)(6506007)(2616005)(38100700002)(31696002)(86362001)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzBmK21pdjZwZmpsUWliVjVRa2ZFUFFvRzFIOXpzNkFRSEJIOHl0ckZJOEUr?=
 =?utf-8?B?ZmxJak9IS3lSNXF0LzkvVFZzWFJqNys4MGhzMUdsUDI5Q0tENGFJVXMwZTlu?=
 =?utf-8?B?b0FLQWtMSnIvY2cyaWIrS1gyN0JqZ1BzVzhnL0JVbVdrTjE1TFVJcFFJekFK?=
 =?utf-8?B?cG5zaTVhcm5ORm9KQzhXUU5qbGprYVN0WWFXc1Zid2k5TGhTeVpMbjBpYVZm?=
 =?utf-8?B?cUhwbG5lNFRsN2pya04zUXZibUg3ZUR6ejQ3T1dCNVRlcldENWxHenFBaHl3?=
 =?utf-8?B?K1hIeHRHbGpjNkZranVVaU82amQxQ2dicEpMaHBNdUFScnVqYjlSdlE2b0RK?=
 =?utf-8?B?a2VEYWN3WTlKSXFQa1ZQQXV6bFMrUVpuaDZYMDY0Mm9OczF5TnRoNjQ4VmZX?=
 =?utf-8?B?N3Bwb1E0K3RzNmZZQ1RuTWhaN2RzbEcyT0VwbENtSXNmdXJhSzBDNmVYdWZp?=
 =?utf-8?B?dngzZ3NWRVV2eFczWU9xYTNVWnFSa2ZmZGhvTnU3TGtMOVgvMmVIUVI4eXNH?=
 =?utf-8?B?Q2F3MTRRY3FENnhUVU5aaFQzZmNuYjVYSVYwaVpkMi9IUDVST1JmNm91ZG8x?=
 =?utf-8?B?alIxSVpHeS9yVk5acU1PamxqM0libTYxbzlUeGN2bVdNNTBWRGgrUFNNNmx6?=
 =?utf-8?B?MFE5WllzTEJ3b08wdEErV1BYbHdaUFhyc00rZGRuZ0dTclI2QVVDU3poYXBk?=
 =?utf-8?B?akJZT0NUdXRDb2lUVDQwVEwvWG5OWEVWK2pkaWpZS3FyV1NBaVFpSVZnVGJJ?=
 =?utf-8?B?QUt1em5CUHNHUmNQbEFQejJ1eVpXMjlhaUY5ZC8zamhjR0YzNlNTbnFPd1dZ?=
 =?utf-8?B?N1EwL3Q2UURIRW02cm5ibWVkRmFISTNqa2pZajl5WXRVYldQVCsydE1lbnBG?=
 =?utf-8?B?K1c5TmxKRFBrTkIrUldwaFZwb2RBRHhHYkJ5TFdqRXE3ZW4wV1AvTm4zQlN1?=
 =?utf-8?B?OFNJTTg0WG9CYjdKKzNFYjdwY0NmR1ppa25BbDdPTlVkY2NMYTIwUmtXY2Rq?=
 =?utf-8?B?ZnRqQ2VySzVqZDVDM3drUmJ3Zmh3ZDZTa084eWNVVG9lWUVpbXY3QTRsakVh?=
 =?utf-8?B?cW50QmNydTllUEhUTmhJQzkybEk3aUFuaGdEZXJEdzhKaEtocVBDWkpiMEJ4?=
 =?utf-8?B?N2NMU0hLdDhUUXhnUnEzNmVtMFhjOFBWOEljQ0lOMmFRWTBwSHJET0JKSzdj?=
 =?utf-8?B?VkJmL25COFlwM0lRbGY3WDU4QjJlRUp4SUEzVVRiR09CTnd3M3ZDTUZCOWpC?=
 =?utf-8?B?T1ZlSUhkYmM1UTgvcDd6ZHJ1Lyt4NTcyZ01VN29mYkxnSVIydlhwd0hSUjY0?=
 =?utf-8?B?YW1TcWtQT1ZMazltbWE2RzZ4Ym9GOTlIQXlXaHZvdHQ0dlRzSGhtQ3k5YWVz?=
 =?utf-8?B?NVlYMktoWlJGR2ZYYWgrV3o1KytUSERnR1JZbTlYRFk4QldrUzl1Rk9ZUnRD?=
 =?utf-8?B?bkp1Q3RlZ1licnBEOFlTZXNqWmgwN2tjTkNRRHAwc3JDNk5xcWlOTmNjcWFN?=
 =?utf-8?B?SG5LVm5SRVRVclNHVE42cVpSS01kSFUwV3ZDU3ZQZ3BzTnZ3LzQyY0MyZ0My?=
 =?utf-8?B?TC9xS1E0ekl6VU1GRUw1Q2xiKzVBRkhXYktRbmFZOU1uNSs1TEo2TEVzellZ?=
 =?utf-8?B?a1NXN0dvSktOM3YxV0J1ejUrOFlxQ3VIMjQveEpkRjNrREUwc3JTZlVuUkxp?=
 =?utf-8?B?QXhjL3lMSEhKaVpKc0NBUUhnSTNwUkZtZFJDRW05SFlxOXFkSFNSNGFiK3lI?=
 =?utf-8?B?b2diM2ZNVlB2MWdpZ3BPbytpVzhVbFE4cVJKMnZiYjNhbjlndkhQeHErcVZ6?=
 =?utf-8?B?MkwzNEk5K1VWN2hpYWFWQkw2WlBYYnpIR01SOWU4OUcybkpQcjdqelA4Q3ZW?=
 =?utf-8?B?bldVSHEyWVJjbVNXOENyMXE2cXZCVmk0M0ZQYXEyb21WbkNjZy84RFZDTXhq?=
 =?utf-8?B?N0hrMmxCMVJwQ2FKTFhDMER5aG5qSzlpWXJQSVhHWVFZMWpTMVRJcVB2T1VG?=
 =?utf-8?B?bnRlemVtbzFGVzN6Q1RUU3BldTE4K2Y1SEdHZXh1NTErSUVJWkxLOXJ1Yy9L?=
 =?utf-8?B?M01qTXZNK2gwYWl6Q3lUVlE5dkhRTHBwUDVqTWhpZmlaL3JpODhldlowVTNZ?=
 =?utf-8?Q?l6BMi45SoCdh2Wm4HifXJ6T2K?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6860b04-3831-4e9a-5031-08db87e95f26
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 23:47:39.7478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +U+JRRj82UmUaJfcwHFu+zS1l9x4MGsgziPEy04WDy2k2H2DcAU4CVIxOkeeDsJfo26VWel4mRb/caUWw8F9Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6250
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/19/23 06:48, Yosry Ahmed wrote:
> On Sun, Jul 16, 2023 at 6:58 PM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>
>>
>>
>> On 7/17/23 08:35, Yu Zhao wrote:
>>> On Sun, Jul 16, 2023 at 6:00 PM Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>>>
>>>> On 7/15/2023 2:06 PM, Yu Zhao wrote:
>>>>> There is a problem here that I didn't have the time to elaborate: we
>>>>> can't mlock() a folio that is within the range but not fully mapped
>>>>> because this folio can be on the deferred split queue. When the split
>>>>> happens, those unmapped folios (not mapped by this vma but are mapped
>>>>> into other vmas) will be stranded on the unevictable lru.
>>>>
>>>> This should be fine unless I missed something. During large folio split,
>>>> the unmap_folio() will be migrate(anon)/unmap(file) folio. Folio will be
>>>> munlocked in unmap_folio(). So the head/tail pages will be evictable always.
>>>
>>> It's close but not entirely accurate: munlock can fail on isolated folios.
>> Yes. The munlock just clear PG_mlocked bit but with PG_unevictable left.
>>
>> Could this also happen against normal 4K page? I mean when user try to munlock
>> a normal 4K page and this 4K page is isolated. So it become unevictable page?
> 
> Looks like it can be possible. If cpu 1 is in __munlock_folio() and
> cpu 2 is isolating the folio for any purpose:
> 
> cpu1                                        cpu2
>                                                 isolate folio
> folio_test_clear_lru() // 0
>                                                 putback folio // add
> to unevictable list
> folio_test_clear_mlocked()
Yes. Yu showed this sequence to me in another email. I thought the putback_lru()
could correct the none-mlocked but unevictable folio. But it doesn't because
of this race.

> 
> 
> The page would be stranded on the unevictable list in this case, no?
> Maybe we should only try to isolate the page (clear PG_lru) after we
> possibly clear PG_mlocked? In this case if we fail to isolate we know
> for sure that whoever has the page isolated will observe that
> PG_mlocked is clear and correctly make the page evictable.
> 
> This probably would be complicated with the current implementation, as
> we first need to decrement mlock_count to determine if we want to
> clear PG_mlocked, and to do so we need to isolate the page as
> mlock_count overlays page->lru. With the proposal in [1] to rework
> mlock_count, it might be much simpler as far as I can tell. I intend
> to refresh this proposal soon-ish.
> 
> [1]https://lore.kernel.org/lkml/20230618065719.1363271-1-yosryahmed@google.com/
> 
>>
>>
>> Regards
>> Yin, Fengwei
>>
