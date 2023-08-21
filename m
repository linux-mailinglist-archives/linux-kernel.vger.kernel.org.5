Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857BC7827FC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbjHULdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjHULdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:33:13 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F020E4;
        Mon, 21 Aug 2023 04:33:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYDnRHC6WOfS0S2q/oO779uaTGlmsXgXVOz78tmCr0oTpW3hGysYfHkGQcNq/wKWMzzpaNmh9djuWw3NAF6MqPh6YiF2qwnicR1rtcLuIoxwk9LCt6eoor3aEJXqmU70liMZptCvLphaxWBWTTb58C+Jay4aebM/yZcT6LC0O4lYivH9F6plXKwRzeKXVQm0TutDlnDSbsWU/2f92yG4z92iZjb641LTPKXkoRZJbTiMrd3eHKmkaNaYmUUcRjc5iIzbY8bz3UmXwZmcXZHA4uSyLEEFYf5s921YEC/2HZqBqNpzfFO69JUlqZIn6RvL3hI9PKOxMgGlBAeR9/GAYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OfJXu1LYhFCTeTDCA2gLIqvQ2b3aZ3/DUdbn7RKKv2w=;
 b=crQnBYz+eW4chyQXergYepsSsMOph+uZSnzgN/0NKnEMHQagtV7vatnDlzA3W9OBH5CzAUpdP9WsD3lfk9p0HMvQhCq6UrytorWEKwjjy80DCgKjK5xXKSBRrCLXLVFgZMAGudCbtU8f4IN3f1IZD8t962ZygpdcWuz/WbYjNjtx9pdiHjYb/biE5jZwYs9+71wllKqsG1FG7mRVK3pQWdlb3wsoaMUiSwq4hCjO9VGIXqZ+JauyG2J7cUwQSJ4aIUm9jnUE4htCKpzdNIuCVc0xouhab3vtnx46aunYkv4JcdX6oZbGODBIJu/m8hQ0tUD0pJmoFTzsn9LF7vXcdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfJXu1LYhFCTeTDCA2gLIqvQ2b3aZ3/DUdbn7RKKv2w=;
 b=OF2vtrpDYHDqE2w3AD54Y/V045K4nQFSKvWqhBFpQGr286GN8pku+3O0cx95WoGVuA/tB9hkaN9LNlCY60ofIEgsc2TEqPyzNtOaMe5GGX6VMLfImtGD/0gRFYoVow51kkkNvTrMnw2TiG4m5FbsHzbnOpY32bmcVya4Ci12FXjw4NnjvDyWNlNMK6GIwAMpHGaqV5yhwhZnRFwxndNccLlP5xki/T4/cqHq/DiMiWvcYP34aF9K/LaI6u/S6ncJvFLAUkwycx1fqt7iK3RL+Yk0uggTj50hWNAvWgh7v74Xm3JHJOcatJZbST2hNo3hO7psfnzh9NYT7WgfSmha3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DM6PR12MB4433.namprd12.prod.outlook.com (2603:10b6:5:2a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 11:33:06 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::3bf6:11f3:64d7:2475]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::3bf6:11f3:64d7:2475%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 11:33:06 +0000
References: <20230721012932.190742-1-ying.huang@intel.com>
 <20230721012932.190742-2-ying.huang@intel.com>
 <87r0owzqdc.fsf@nvdebian.thelocal>
 <87r0owy95t.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <87sf9cxupz.fsf@nvdebian.thelocal>
 <878rb3xh2x.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <87351axbk6.fsf@nvdebian.thelocal>
 <87edkuvw6m.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <87y1j2vvqw.fsf@nvdebian.thelocal>
 <87a5vhx664.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <87lef0x23q.fsf@nvdebian.thelocal>
 <87r0oack40.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-acpi@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Wei Xu <weixugc@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH RESEND 1/4] memory tiering: add abstract distance
 calculation algorithms management
Date:   Mon, 21 Aug 2023 21:26:24 +1000
In-reply-to: <87r0oack40.fsf@yhuang6-desk2.ccr.corp.intel.com>
Message-ID: <87cyzgwrys.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0089.ausprd01.prod.outlook.com
 (2603:10c6:10:1f5::8) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|DM6PR12MB4433:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bfb2ee7-46ed-4a1c-76ea-08dba23a62fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Y3QW3GMcANihZGzC7n6CqPOghHWyRyFMgfU6+G+rKC4KKJmwvc+/FaxHxVdPn99hZBZcGQhDQvNo9GlT/Z2GSu8UWfm1ItxFFvUPM3m4szSrYbSV/nTb6Hj1+igcSO51QH81lGXFIRK5ck4OO7vxAwLZtZkBWbQfo82ffH9yEPSUn6bWsFMJ3l8JFO42DWFiGRHA9gDa/3mnaQyHWShKyMcnACXO5CjTpgup6/MTtXUwPgJkHR3WXjAI9iP0rIhyCYDn1YN+nCgiDMxE+T1zilixWiJv3NWKOOK1U6W9PyuuVniX3rszYbvf260hIylXwUhM6ays9wulRAJLs2uNctob0r3rO5n+1npeQRYlY1e3OPRFo3XddrFRCXEf4B4I8UzpwbgB/wqprEP6wNZlxD8LtzSntFYj2Bnlbjkyd96yp+HOjyc04KxCa9DwF4GxAN5mtUKs6LTl9itO6Dx/7wDhEVqnFMLXQDzg2qt94MrN1jVFVq9lQFcT1H+MHQp38x3ySw12bttzYfW7ExVY6lcP3iUcX0lro8iMzG2yAqLdVr8+L8MMpPoWfXPXHqo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199024)(186009)(1800799009)(2906002)(7416002)(38100700002)(6506007)(6486002)(83380400001)(5660300002)(26005)(86362001)(8676002)(8936002)(4326008)(316002)(9686003)(66946007)(6512007)(54906003)(6916009)(66556008)(66476007)(478600001)(6666004)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CD5NvBMqEUreUa17lhONdCJubY/OQrwFmEBcvL2AhpE4V8oMwfZFRN2qzWMT?=
 =?us-ascii?Q?Of2Z8UdYbhqGas1r7ny6uX6wxNEkoooT2B5zeMK0dSwzd4Rq4Sxetv5ue/SF?=
 =?us-ascii?Q?qRiqGw4ryJGuIKBzpwV2EzpgpyS0rKqakg3kF2BhVrA7V63ALq3JPKr+8+V2?=
 =?us-ascii?Q?Y2DGpyqcR4Eeh4gmdAeWU1wjLojodu6m4gdtPYKpTD5C+8MbuMd29uYxmtd3?=
 =?us-ascii?Q?ESX8NfCwr+/UfwbNwusseNAjJA8FjjjxKBiWQ/dt0vIrquqrPSNf3jRr0Zk2?=
 =?us-ascii?Q?DSnp8UkBtvJaNoyFCFBtAkILsMGloZaXdM0PBdpn8/YtA53nrl+nWk7rHvP4?=
 =?us-ascii?Q?I4oO8w19oaX5AW/AzjLVVxEmF/hzh1nw7Y6rwOMnO52EiyvIzb8/bAb0E7uP?=
 =?us-ascii?Q?QRIvUlDcA28LA3jlVT4vBYuuXhsU567FxKpe18F+z/RMv99bIKbtqhe7FZhI?=
 =?us-ascii?Q?jzxSP/zl+9GiGordNq+eQ1c7hE38avtUhhkDs/euS4rg0sX6Pq3MeZtah8+w?=
 =?us-ascii?Q?38FN0zuQVeFR2wroMK+52euvZYzVq5oNI33DxQkIicwGJxlG+hY3Uu2FSX1X?=
 =?us-ascii?Q?QUda3ey493SAH6pjWMmEbBlOcza5cEBoxqcIihtzYQzld2U7WImRhsVOz1UP?=
 =?us-ascii?Q?z4TLlYdyACdxjfEossBRyiuWbfOmG4EzjAlrbT4V13AWNULUVGnNJTQIf1RZ?=
 =?us-ascii?Q?l8+9vComNQAeMSv9HYAfSGs866i7MRcha6CmtmvQgdyTRX8EmJDlILQcD+m/?=
 =?us-ascii?Q?KzH7sI+RazCOd57ZlFsim6kFQYF7MlyYD9/LrYsJXtkdMTK8fg0sqAFn8/y6?=
 =?us-ascii?Q?bCTSaVf2QF+r0bkZVW/z50gcDrdaYBEzKe0GeR0EXuZZ8qNQiBF44oad9YDD?=
 =?us-ascii?Q?sTEGzmN8y4wbXN+2Tn8+glD0SVD6VKxVqj/ulDoF3+uhOt+S+x6SQuc4/KNW?=
 =?us-ascii?Q?1L4N7He6QdQh6maH2qx3UuaQtO76Fj12eVEDFUs32OJbqY/zaChXLBzhl3BG?=
 =?us-ascii?Q?SAUtU6tNFkSxNMjJCtX/9j0SzKaViDgBvDi19a+GfX8/8bsGGtWcPYkXydBr?=
 =?us-ascii?Q?j8TpqwaggU2zJ3dvNZOv1lnc6j0n66JZlQ4/5f1P8MFuejxMS157L5FwmaW8?=
 =?us-ascii?Q?keHy/7aBVuFLl14FuImHf1rjDhS0UGEDlgCm2fZNdqfLIiRJaybfoB02DVuP?=
 =?us-ascii?Q?pZVRRt6YgmZVHyZkYVLWmw3Yoz5pI4XwcjqCFVgjSHck/ptm6YW9j0sx3wPs?=
 =?us-ascii?Q?wN1tOZYqZ/IRtPfFgs/aqBkAqALLaVR8pv9s/z9CnbyBjW4Yn2qlYsPwU/3s?=
 =?us-ascii?Q?a9WdRfwqEcOnidwcenDvYHMF7SzeMBtIDkAiIV/We7IEPnEpDjApfpERUxxL?=
 =?us-ascii?Q?pzo8IcCk9eH45i3KssAsjE55xEQhUg0p0Z4xje2RH22rkeFQRK4sWkzr1SgI?=
 =?us-ascii?Q?QTIap4fvF2aEV8t/9ZrHkS4RclsMPuGSdiFmVJlHLrY67hAElZ5gtJIflwNW?=
 =?us-ascii?Q?4hN3wft0bJczWrBRDcMv3Uem/6IMQZsteb7uaUPWdxanoXPSRC/bFOrPyhkD?=
 =?us-ascii?Q?c33+TPNMJ5ulrOICfKlJ/Pu47/9mor8tUtpJ0akx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bfb2ee7-46ed-4a1c-76ea-08dba23a62fc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 11:33:05.6718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pojw71rq2sBxaQVn1+9cWA3rseKKZLr4/qzCwRtNY/Vk+wpJe+WJxTmENhJHUWKMloctmrqAsQ0fBW4VH0WRqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4433
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


"Huang, Ying" <ying.huang@intel.com> writes:

> Hi, Alistair,
>
> Sorry for late response.  Just come back from vacation.

Ditto for this response :-)

I see Andrew has taken this into mm-unstable though, so my bad for not
getting around to following all this up sooner.

> Alistair Popple <apopple@nvidia.com> writes:
>
>> "Huang, Ying" <ying.huang@intel.com> writes:
>>
>>> Alistair Popple <apopple@nvidia.com> writes:
>>>
>>>> "Huang, Ying" <ying.huang@intel.com> writes:
>>>>
>>>>> Alistair Popple <apopple@nvidia.com> writes:
>>>>>
>>>>>>>>> While other memory device drivers can use the general notifier chain
>>>>>>>>> interface at the same time.
>>>>>>
>>>>>> How would that work in practice though? The abstract distance as far as
>>>>>> I can tell doesn't have any meaning other than establishing preferences
>>>>>> for memory demotion order. Therefore all calculations are relative to
>>>>>> the rest of the calculations on the system. So if a driver does it's own
>>>>>> thing how does it choose a sensible distance? IHMO the value here is in
>>>>>> coordinating all that through a standard interface, whether that is HMAT
>>>>>> or something else.
>>>>>
>>>>> Only if different algorithms follow the same basic principle.  For
>>>>> example, the abstract distance of default DRAM nodes are fixed
>>>>> (MEMTIER_ADISTANCE_DRAM).  The abstract distance of the memory device is
>>>>> in linear direct proportion to the memory latency and inversely
>>>>> proportional to the memory bandwidth.  Use the memory latency and
>>>>> bandwidth of default DRAM nodes as base.
>>>>>
>>>>> HMAT and CDAT report the raw memory latency and bandwidth.  If there are
>>>>> some other methods to report the raw memory latency and bandwidth, we
>>>>> can use them too.
>>>>
>>>> Argh! So we could address my concerns by having drivers feed
>>>> latency/bandwidth numbers into a standard calculation algorithm right?
>>>> Ie. Rather than having drivers calculate abstract distance themselves we
>>>> have the notifier chains return the raw performance data from which the
>>>> abstract distance is derived.
>>>
>>> Now, memory device drivers only need a general interface to get the
>>> abstract distance from the NUMA node ID.  In the future, if they need
>>> more interfaces, we can add them.  For example, the interface you
>>> suggested above.
>>
>> Huh? Memory device drivers (ie. dax/kmem.c) don't care about abstract
>> distance, it's a meaningless number. The only reason they care about it
>> is so they can pass it to alloc_memory_type():
>>
>> struct memory_dev_type *alloc_memory_type(int adistance)
>>
>> Instead alloc_memory_type() should be taking bandwidth/latency numbers
>> and the calculation of abstract distance should be done there. That
>> resovles the issues about how drivers are supposed to devine adistance
>> and also means that when CDAT is added we don't have to duplicate the
>> calculation code.
>
> In the current design, the abstract distance is the key concept of
> memory types and memory tiers.  And it is used as interface to allocate
> memory types.  This provides more flexibility than some other interfaces
> (e.g. read/write bandwidth/latency).  For example, in current
> dax/kmem.c, if HMAT isn't available in the system, the default abstract
> distance: MEMTIER_DEFAULT_DAX_ADISTANCE is used.  This is still useful
> to support some systems now.  On a system without HMAT/CDAT, it's
> possible to calculate abstract distance from ACPI SLIT, although this is
> quite limited.  I'm not sure whether all systems will provide read/write
> bandwith/latency data for all memory devices.
>
> HMAT and CDAT or some other mechanisms may provide the read/write
> bandwidth/latency data to be used to calculate abstract distance.  For
> them, we can provide a shared implementation in mm/memory-tiers.c to map
> from read/write bandwith/latency to the abstract distance.  Can this
> solve your concerns about the consistency among algorithms?  If so, we
> can do that when we add the second algorithm that needs that.

I guess it would address my concerns if we did that now. I don't see why
we need to wait for a second implementation for that though - the whole
series seems to be built around adding a framework for supporting
multiple algorithms even though only one exists. So I think we should
support that fully, or simplfy the whole thing and just assume the only
thing that exists is HMAT and get rid of the general interface until a
second algorithm comes along.
