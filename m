Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E380376FB48
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 09:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjHDHgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 03:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjHDHgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 03:36:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7407D127;
        Fri,  4 Aug 2023 00:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691134580; x=1722670580;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LSHEHlVXA+0KLNAxwwvTot+i4R4uxys2a+aVFam7alU=;
  b=PcwBj9JUfqAzgejCS7OT3Iv0+GjrqZZUDPzaqYZ/PRq0WxrQEnBTKPfc
   cdA4cYBXSoDT16d3+fw3f9Sluehn+Vbf5h6+W3k3kNoquacLD9jVoFcmn
   fyKQpsT7NUe6MiXIAqidyh5BHT4KhQqSdj759g8wgsaR3SQGOirWr4xMm
   b6lSTRwLLKPQ1TteRRMdmiULbBqvOafZazJDWQ4VBX14A4aGsCrSaskVC
   juf4avxmG/WrER0vKgdU7QtNhTPudzVmFdzRlG45C9Tq+0TAHrnqyXOb0
   Wt6NcSKIaVFUKjK2dU4FIit30b9jRSiEaORTUjH5gMpqHiGXU/Or6kb9b
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="349687478"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="349687478"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 00:36:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="903779140"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="903779140"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 04 Aug 2023 00:36:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 00:36:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 00:36:17 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 4 Aug 2023 00:36:17 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 4 Aug 2023 00:36:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffSih8vp4y3MwUiSGNee2EWXFXPkXwjWT7i1zSxQs1vCS3clFjAg83/Tr1S7pfSZn2oaasEQ3P2tsyCZOXVvNl5a1X7U6ljD7nIMvpgCyEAQob+Naxe6pVKXR/6dqY95rQE7UkmGLebyU0zEmky43Uh8qyypyO5vljRS/MhLUrJzqeaxeDHAsFGDACplDUxzn4tJmuXkVLFuNKQovgSqwFHhle27VCqlTCbBiU8xV3BE6F5G+85sA9I61NFkCJCDhy3NBD7/AK5fZ2iK2TLt/68lsbbUMXOlqTZlXmO37bzK9kSqoSnn8S8gU+yIcYTKUWngS4FscUcxhtNu0Cf5hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHaWI2indlh3V7lRa5vg1Uq8wQ+CpTiTNaqJVn1P9DA=;
 b=Gt8pv1OJ702Jt2qNRl9FDTCjgTnnnOk9cakvdLX6Sgr4VafrIxaq0wzua/DHZ/vrM056jiFb3+ojgLi9f9y/X3UsNateFKRc77L5BgH5ROLX4u/j6/NDhfv8sgCHpHH70OCbRXgsI5Ua3px5WWQCUcunmdR/3sVu+nhyi2Jt7ErDuDbuGa/C53YQ+gICut+i1MEAve1hLkzu0TGQBczH5pWirLqJxnKszPIF1GjZSQ4ekI4mReVxbpETZ4Yu9h8Da0hnp0FRkLn8HyHNGg+Pf4oTfMInb91/z4GZjSz43XbfyduuoAfpHMXZccHv8woK4W62kyQ4AfEyOnHzEUyzjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CY8PR11MB6842.namprd11.prod.outlook.com (2603:10b6:930:61::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 07:36:15 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 07:36:15 +0000
Message-ID: <959095f6-8574-f5fc-812c-b0b9b9a3c101@intel.com>
Date:   Fri, 4 Aug 2023 15:36:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH 0/2] don't use mapcount() to check large folio sharing
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>, Yu Zhao <yuzhao@google.com>
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
X-ClientProxiedBy: SG2PR01CA0189.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::15) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CY8PR11MB6842:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c702604-db59-48d7-1519-08db94bd7bee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3QxXH0+WN7118/ntSN8+EGz+mimf4zqQzkPQJ1QtuVz+elQRyJ/O8Sh5SBDlgF55DS21bUiHhrpELmWPh66xknXdLplAh4gxgMQHsfGHeTH/42NI+7bgmTqAYMxsLeSo5Diuym5cCgeWWEkonk/Muc5UG7RuM2FgC+dU3Ga0PVkz3xfEshgx/og60T+1wLFA/70nKnLhEldT55HwBaYxKjRKoh6dff+nIvZHUa7ssqSPdMuGc/3l6uaEQ0wQMu+vkD7wMya592MppG3o5ZkozTzZSwR6fFfdoH07uAjq5P8WAuhGtwoxiD20vqjeGZy1cwLYOY1pJyS2bHnHjx+eCR6J1x8BbO8xh8oZEcS8OM80HqVDdySZKaYyRWKzryQoxolAiiuEK0+OSo44vlhH2GelbDFqF+aUJdjdICvQr41aoAp4K3qVc2q8wV57h3dIqNgfkh2DwTtJ2RA/wuIRpqu7in1oWCZJUQqRxETm7y6NW3Cvgj+dDn20WGZfZY3OcFitOaca6PMraFr1+BB67glKgn75mteHoNW5Qj+iZC61212TFAaWt5scDbTTNtuMV9cy30bZSlS1vws8JEUAiR5QGbclUVFakm0p937ENkPQOwNuLqqW8rxOz+vINI4Rq4Jl23GaoBIWfjdVfHkSPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(39860400002)(396003)(366004)(186006)(451199021)(1800799003)(66476007)(66946007)(66556008)(4326008)(2906002)(82960400001)(38100700002)(2616005)(53546011)(6506007)(7416002)(83380400001)(110136005)(86362001)(966005)(6512007)(31696002)(26005)(478600001)(36756003)(6486002)(6666004)(8936002)(8676002)(5660300002)(41300700001)(31686004)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHNSaEI3MlhTT1lsQXBZN1QzRnd3T3ZBWGRDOXNqVnh0VWwzYU1KdzdldWhw?=
 =?utf-8?B?TGFvKzdBd25mMFlRYW1NWGtnbXpVc3lRdnZXS1NpWkNNM3dsS0k0WnJoUlA1?=
 =?utf-8?B?T0tsRy9HSTRPV3RvZ2xWY1ErUmFIZkozVDBaVnUxMkRtVUdBa3JoK0k4em1p?=
 =?utf-8?B?WnQyc1B2ZUVDc0FQNlJ5ZDQvL3daUnhEZmszQWZCTVp2Q0ZZTFNObmxJSi9m?=
 =?utf-8?B?SllIRUJuRE81bDl0N001Q0grNXQ5c3IzNlpZSUV5Uk83ZDlmUGhlSkx1OG5N?=
 =?utf-8?B?RkVUbk0yU3pFY25FZGlkV3BMc1NZdThyLzRBRE54UjBkM2JnZXRqbEI4UUFE?=
 =?utf-8?B?SXFQNWJlY2x2b2NQZmpjVXdRVzhQK05VSTZsTGhNbHN0UGxtZEUxRW13bTRo?=
 =?utf-8?B?MC83NGdxQXJDeEgwVDFmQk5nTSs2Qm5hTXU1OWRua2RxTjF3bmNpZlc3Y1l2?=
 =?utf-8?B?eGVNT08xSFZOYjhyaTZXMTlHYTl3dm11NCt4aGxnOWhhOFVGSU9ISjRvSzU4?=
 =?utf-8?B?dmF0TTZ1c29JU28yT0VvVkh4WFlkNVRlRUpVYkV0Sis2THdheDQrbGRhVUNa?=
 =?utf-8?B?WExqb1YyaVRjZzdmc29WY001aFFZdDNYRDM1a0pMRTdheCt4UkJDZTdiYUEv?=
 =?utf-8?B?YTdxYnR1UG5JT1loVWdQQWhWeExxNk55NVVwbHRSeUNWdFg3R3MzQVV3UStr?=
 =?utf-8?B?eFB0cHM3aE10WVhMd0RkTkpOaGx1SWVyZlRVQzVuVFV1dVBXSHJGMmR1OGpG?=
 =?utf-8?B?aU5BYjBMSVI2ZUtGWlhiWldXR3BuVFlERkljNW5iSmFLeDNPY3ZjT2RIemlo?=
 =?utf-8?B?Y0g5VDM5V2dvYWdzSG9FVEwyaUJWbHpkVVQ4YVNSMC9OZGpNV1VSQy9SempF?=
 =?utf-8?B?cnI2d21QNnpjaUpiOEZyelFLVXQwSmVGQ3Zyc3RkNVdCQ1FJSzJKdUJJNE1x?=
 =?utf-8?B?SDdST3Y0dFNJMmtjc0dJUk40cU01WEhOWVdBZ0FZd1ZLU2pmQmlaQ1RDL2RI?=
 =?utf-8?B?aS9EQUxDclBXNURYMW1nczRub3l1OXZmMWVEVjZ6WkIvV0daZWozc0RuZlMy?=
 =?utf-8?B?cFR4U3E2bUlFQjdMRnZkendaS1grVnB1T3pkelhsUE1mVzBOWC9qYjcxZmUr?=
 =?utf-8?B?K0xHMi83cExTbFEwMnQ4eGhXOEo4VVZueGVCb2llTzRwOEJXTXkzdXBIb2tr?=
 =?utf-8?B?YjI5bmh5VGc4ZFBtNkZ3TnA4WWdqVDcxZ09NeXJJTFJzY3pwZTZwS1k4Q3dG?=
 =?utf-8?B?aGh4R213Vm5HRGRjcXhtL2hJazhsWWJxamt0Vko5UjQ0YnNwaWorM3dBV243?=
 =?utf-8?B?L0ZtbXFjR2ZLV0pHaFFwd3F3eWt3bUNiWis2aXJtM0JMYjl4RS8xRVRtRmQ4?=
 =?utf-8?B?VDc4cURwYUlLaEQyazFYdmxXd2RoOEhEL1ZTZjlqSHhVYkFRQ1RTS2c3QU5X?=
 =?utf-8?B?QWNBVURNTjlNSmNCYWYrUUU3MS9vdHZSdEhWTVdVZ1haWEw2TGNySjZSRUpB?=
 =?utf-8?B?YjdWaDZ1NzlIcW9CeUdMVWc1V1dwQ1NBL2NtOFFJY1R1a0RkaTl0NGI4WVEr?=
 =?utf-8?B?aEVIRytEellKUnE5Zkt3RkltcUlFNmR3aGRJT0JZWmE4VGcvZlB2RHdKSGxv?=
 =?utf-8?B?M3dDajFDRlJIM0J5UzhRN3hiNHE1aFlsN3poQ1VMNzFJaUpOM2NtK3NhMjYy?=
 =?utf-8?B?Q2JlRitMWmMwOEZKY2R3T0tBRTZYb0tPWlhGQ09iVnl5Wk05U21Ka1JxcnJm?=
 =?utf-8?B?RTNsTm5QRm1jQTFlOU1XQmlQUDZieGgvRUh1c082SmtPZXU2ZnZlVEN1bytI?=
 =?utf-8?B?RjZqb2kycEpqekMwUjU1R0p5NEp0Tnk2VnNMcXRvRG8zelloMk9nalJVdzE4?=
 =?utf-8?B?eUNRS3VaN3JWZWpYV0RzWGsvRUVhbkEyQitsUVU0SjBkNUtRc1djVlFPbTMr?=
 =?utf-8?B?TktiQnVWM09lby9JU2xva0lKYkxkS29WT3V3a2JTOTh3OTNOMGJWbGxXd3g1?=
 =?utf-8?B?M2hYaFRTTlpMNDlDME9GYzg5cDREb2Q1N3B6alcwTHdsRnNrVThNMVBBbU1U?=
 =?utf-8?B?M1ViUUZnK1NUOGxIbC9NSUFyNG5zQTZ5SmlqNGJVZmVFR1ZmVlY3M3hIU0tI?=
 =?utf-8?B?dGI1TldLSkVMOWhidFg2UjFlOEVuV3JKeW03cW5TNTBiNlNEbjFuWDFGR2Jl?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c702604-db59-48d7-1519-08db94bd7bee
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 07:36:15.4725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KwiJILftbVmVRrWfKGbBQVm0HQbhpVfOINIcuGnHccXlkLpDGjztcss44sOJFnm/SoRu5CTgHvV/NhmLci5E6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6842
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

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
> 
> 
> Probably all that is information worth having in the patch description.
Thanks a lot for checking this. I will try this patchset to see whether
it can restore the behavior (I suppose so from your broken commit info
but want to confirm).

Regards
Yin, Fengwei


