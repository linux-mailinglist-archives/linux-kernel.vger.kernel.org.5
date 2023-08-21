Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628A778367F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 01:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjHUXzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 19:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjHUXzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 19:55:03 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CEEC7;
        Mon, 21 Aug 2023 16:55:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cn3jq/HMdSsfSntQFkL5fvViXLYnGk/B+YKjPtXBr5RhhYvo3fueXEKbE4YlJASj7TeJ3Ui1MZVId8evSnVdsvKRrltIyK+qM1lrrB8GiNTIw5wv1VO1a92ZptcSR0qZt08AshKrIUZmGMi3QPp8PQEPF13e+OGuvSiiTZ3WwXY5XXA1iLDjMYclM5q/ryejUNctbLxevbz0glGFmqzlxoF/lxZeOEtuhztyNIXEPQeAni0WZZ3Ln70lOiYEMxbaCgMz7HWegkFUWWzEwodOBGSmerS0KeVpKKsBmRN2LdlmJQu5S9Ag5KcSDrvCpSkM7/8xsiSRgMisIVVM94ZKow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YAPhyAjM9sfPgHTxyFF6lDwkpDeRats9oCZWInAwDqc=;
 b=dDZ6Jz0DA/LHmXjmyWkb/QYUHN+bCkJVK1D0mNrb9wYqclIEnL3HreW685XRT8Afq4wNPlGsBN0Xc8FxB1S7IgNLgxw0y6U4GOox/hJxcgQrlSKOixwP8JgBp6rguBxP3Syi+nOyUgIXZR8L3aVquzK8cU+QRpKhP7PAyRyp6PSda3JlwUaSF5fl3N2oZNy408kD2KNyBbWXWRchS6hG0rcw5yN1AMjojOiLjIwckh3/ZZWuLKoTgf95IgKO3MCqmH7O92xxXR1h4cCUZj0WEwod2vVDQPPd8T0E4L8cxG4ph3+2nKKO+PzLZkLIvU+KxKQMmkkREs/fbEjwgbO6KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YAPhyAjM9sfPgHTxyFF6lDwkpDeRats9oCZWInAwDqc=;
 b=JqY/xfBzwnI4/BJPDW0N0Gy94TGPDhY5Vcl04e+wdHjom1XU/lFaKDPIZN6oj+4QG03XF0NAtvtemVDA0Erk053sMTiELZidhmSpxhOEisX3bAtc9/lIhveHRx3RHApA7Fx3IhZ/GcoQQZIe3P42yZDYLvPEvmzihs615RcnyqO8BZiRJ5JWeUvHWF7x7tsb+qpEH5OKHiGYY8BcadrscwnnpR4MO+fKOfjCdUNJW3QxdT8rufRZRWXyahR5Jw1vF/xRYLG3F0jusZzuivtmPN3+frMyEaeernojy7YETAYfvfm7Juw3BsgarAbLLFGa0A6iYZKryFbKCq14PtK5Kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by IA1PR12MB9061.namprd12.prod.outlook.com (2603:10b6:208:3ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 23:54:59 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::3bf6:11f3:64d7:2475]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::3bf6:11f3:64d7:2475%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 23:54:59 +0000
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
 <87cyzgwrys.fsf@nvdebian.thelocal>
 <87il98c8ms.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
Date:   Tue, 22 Aug 2023 09:52:43 +1000
In-reply-to: <87il98c8ms.fsf@yhuang6-desk2.ccr.corp.intel.com>
Message-ID: <87edjwlzn7.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0104.ausprd01.prod.outlook.com
 (2603:10c6:10:1::20) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|IA1PR12MB9061:EE_
X-MS-Office365-Filtering-Correlation-Id: 58878001-1fb5-47c7-4c59-08dba2a20707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q8JPLRqak26Gwrsw5YANo+CMe+K73poqgUcDseY+q3IahXFAnXx1j1hVIx+sOgG47Q1rUC8f621Z3RevumVOv/TZOLEu6ImbVNej6aTPypk7jgriMRuPiVnYbbF3ithpIWCB+YmeuEpb95m0wr3QhCrU0rxC6iUMJ74uJIUT2dgXI3N4DzK+WUx8hcc9Yd4fU+BQFLJxjMhwuoAs8x9kNNzgT1BOQbSFP5crrAVp5LADlFWDoh3LrAsOndGo6LFOaR0XcUgOq5/5UZC8dO4SA0MpI8QKuyNMxSIF7bFkQSNk3549BV8UdRcD4WiduA/j9XWGyTgX5AkPqvw03uzrjCvYqsvtnuEZpfUyJ6l59F0arnHzG0GmqQaOckl5dyLPH1APw7vyK9Te3IMU3NdXRp2cSUZrllNKRXf7FVQYUvRkzsIiEVpCjsvEveY5T7ZdGkh1mhC4C1qBheum2omgnxxss3U/o5aTDxg5GEwGCSVyRg4dMfCvP173TLA8ykA1stBqDLIkcPVeI1Iq5mWkjgPyQAe0+TlIwZX4IpkbyvlJyXcE0QBOKJkB3pTOPGJn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199024)(186009)(1800799009)(86362001)(5660300002)(66556008)(41300700001)(66476007)(2906002)(66946007)(316002)(6916009)(54906003)(7416002)(8676002)(478600001)(8936002)(4326008)(6666004)(6486002)(9686003)(38100700002)(6506007)(6512007)(26005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?os0fBQyGy7KMeJ0viAXnlLwxlRslA4/9wa6qEwEBu5itVN4EDQ50twHkRGXX?=
 =?us-ascii?Q?5ehcMaT4Ifx6uBV5FGwRe7rTfWUd4AvFcmhHFrppBrupnjcqPzpicIm2I4Ex?=
 =?us-ascii?Q?3SF6nTLHEQv4u8epWnoFTmK8ugwW/c4RJIUUFqBg4rNbxWTKr6Debtmb5GG7?=
 =?us-ascii?Q?o7/nwaDBPQrKB+aPVvmygmohg/h3B3vQCaFREKT1ApoewAZ/wsJ5CmVpkGCd?=
 =?us-ascii?Q?BIUa1iDOjdycJ80tz3X5nVVaia/faIfnf3YYSPXvlKplUVELumwJ40SBVkh6?=
 =?us-ascii?Q?TxRi26j6NR8twQneG/GWuEhG6JhTS2F+D2sOoJT12eCq4ZJfEDuf+Kr+Bv7y?=
 =?us-ascii?Q?HDYBxOiRUKwOx9KB+7odLj7zlQmIFVdDipvkfn6M5TWa20Vc0YCPqOL5gpq1?=
 =?us-ascii?Q?eYD84/RI+RXuMTo3dKt7uhI1fvhk75EYrl62VO1Fxlk+K9bddAM1kK6SDQNn?=
 =?us-ascii?Q?7QKLgVGyfirR7rS8d7v4knwhuSBDlFPosRAwH9zWCHYo/DKLVi0AD1WN8tE0?=
 =?us-ascii?Q?dFxcL/wdNUJiPJ/2wB2DhBs9dLGNNhf4WcUyt5Y/nCmgvTHVKWAdWpuEdCkE?=
 =?us-ascii?Q?PShe7nfY/xtaFzaMkhCLY/L3G5xvsrrCPM6UWX+/VgLrMU2CXVvxT+JrjF2r?=
 =?us-ascii?Q?AmC0Br5i8oXp7xyLAfiEBdidaR6ZSBpWAFKu9AVTlSSJF+MW7hRZXPj+avJI?=
 =?us-ascii?Q?pyta8gNYCI5GPvjnSQmvLRDFSDMPsoQQ3o3rvrHDPokuSwaHSVZiHADzVKHv?=
 =?us-ascii?Q?vU4GjrOxOW7I8mK/udU3Uu2lhDsaXwlY39rYNuYQK+yEG67SxZ7INstzOsg2?=
 =?us-ascii?Q?LEyKdjxmrNYD7yP7aR54lByOaHC0nhvT+rjQtRlbdeFcRjAz7CYzTfejZYQm?=
 =?us-ascii?Q?06PNDktFLDzLxJSHFMgy7uxbx5p79Aak9RAWCVHxioX2tFlhlwtDIbDvChBX?=
 =?us-ascii?Q?90DeNhBv0irnDxHPJ+/et6qhmvtrSIDMqCq7imz8eh2HWqn7klpC11rSr+Zn?=
 =?us-ascii?Q?3gp9uiaemss3Fwabh5XMiWzqiZxUwt9N9H/QthyLtffY50cI3cO4c+Ri3Jnj?=
 =?us-ascii?Q?YJCAd/lmqwGGbO///E5SODdirZhavrNJUb3rQklDz8G3oR8IBj4PmQOprDwq?=
 =?us-ascii?Q?mKvJ0abk/jNzKA8/f5S3pClN5d5SpNWUI1MVQCe1OXkk58HgqjjiUsOouclU?=
 =?us-ascii?Q?NFmSIQrGsl+iXN3laSk24cMDmG6p2ZgmdheTU7kkUoJiQaNJLGerGnXUoePz?=
 =?us-ascii?Q?B8jEQIg5twmKtxHA6A5qQeZ883v7YO+ybGrJ4o9C9xpTXMNpP6G6Sx9GioSV?=
 =?us-ascii?Q?zk6HVw9uOOR7DrRcWZyoXbgyAJ5US5m0YhTmF61mZh0OlFOmw9BAV4BPTcgo?=
 =?us-ascii?Q?pPe7M9Z6vT59VK+VVyaV4e0jzkc3orONa7fBm9DSC7fd7kHEBGIyflQRQth7?=
 =?us-ascii?Q?x9WbKzVGAlGl+vgypXQPQBWn1lV69JBNg560owQddRDJlGsTfz20IdZpvVRb?=
 =?us-ascii?Q?4Em4lDjZNrnf9j5ZfaSQF1oc1c/t/DLnqA3hGPlKRtPaAsAQoPWKp5y2YoYc?=
 =?us-ascii?Q?/Ov6pcUnfuE+cecHss8EJgqBmApgeSC8KDRvBlEj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58878001-1fb5-47c7-4c59-08dba2a20707
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 23:54:59.1137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IIfksOrK2pvgvtdXcDLcUtlIa+t1rP2LXMnPhXo0KV6yDLLt0rrVaw4vnCQkvxAg1jpTR1ZLwksDZw70dImoEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9061
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

> Alistair Popple <apopple@nvidia.com> writes:
>
>> "Huang, Ying" <ying.huang@intel.com> writes:
>>
>>> Hi, Alistair,
>>>
>>> Sorry for late response.  Just come back from vacation.
>>
>> Ditto for this response :-)
>>
>> I see Andrew has taken this into mm-unstable though, so my bad for not
>> getting around to following all this up sooner.
>>
>>> Alistair Popple <apopple@nvidia.com> writes:
>>>
>>>> "Huang, Ying" <ying.huang@intel.com> writes:
>>>>
>>>>> Alistair Popple <apopple@nvidia.com> writes:
>>>>>
>>>>>> "Huang, Ying" <ying.huang@intel.com> writes:
>>>>>>
>>>>>>> Alistair Popple <apopple@nvidia.com> writes:
>>>>>>>
>>>>>>>>>>> While other memory device drivers can use the general notifier chain
>>>>>>>>>>> interface at the same time.
>>>>>>>>
>>>>>>>> How would that work in practice though? The abstract distance as far as
>>>>>>>> I can tell doesn't have any meaning other than establishing preferences
>>>>>>>> for memory demotion order. Therefore all calculations are relative to
>>>>>>>> the rest of the calculations on the system. So if a driver does it's own
>>>>>>>> thing how does it choose a sensible distance? IHMO the value here is in
>>>>>>>> coordinating all that through a standard interface, whether that is HMAT
>>>>>>>> or something else.
>>>>>>>
>>>>>>> Only if different algorithms follow the same basic principle.  For
>>>>>>> example, the abstract distance of default DRAM nodes are fixed
>>>>>>> (MEMTIER_ADISTANCE_DRAM).  The abstract distance of the memory device is
>>>>>>> in linear direct proportion to the memory latency and inversely
>>>>>>> proportional to the memory bandwidth.  Use the memory latency and
>>>>>>> bandwidth of default DRAM nodes as base.
>>>>>>>
>>>>>>> HMAT and CDAT report the raw memory latency and bandwidth.  If there are
>>>>>>> some other methods to report the raw memory latency and bandwidth, we
>>>>>>> can use them too.
>>>>>>
>>>>>> Argh! So we could address my concerns by having drivers feed
>>>>>> latency/bandwidth numbers into a standard calculation algorithm right?
>>>>>> Ie. Rather than having drivers calculate abstract distance themselves we
>>>>>> have the notifier chains return the raw performance data from which the
>>>>>> abstract distance is derived.
>>>>>
>>>>> Now, memory device drivers only need a general interface to get the
>>>>> abstract distance from the NUMA node ID.  In the future, if they need
>>>>> more interfaces, we can add them.  For example, the interface you
>>>>> suggested above.
>>>>
>>>> Huh? Memory device drivers (ie. dax/kmem.c) don't care about abstract
>>>> distance, it's a meaningless number. The only reason they care about it
>>>> is so they can pass it to alloc_memory_type():
>>>>
>>>> struct memory_dev_type *alloc_memory_type(int adistance)
>>>>
>>>> Instead alloc_memory_type() should be taking bandwidth/latency numbers
>>>> and the calculation of abstract distance should be done there. That
>>>> resovles the issues about how drivers are supposed to devine adistance
>>>> and also means that when CDAT is added we don't have to duplicate the
>>>> calculation code.
>>>
>>> In the current design, the abstract distance is the key concept of
>>> memory types and memory tiers.  And it is used as interface to allocate
>>> memory types.  This provides more flexibility than some other interfaces
>>> (e.g. read/write bandwidth/latency).  For example, in current
>>> dax/kmem.c, if HMAT isn't available in the system, the default abstract
>>> distance: MEMTIER_DEFAULT_DAX_ADISTANCE is used.  This is still useful
>>> to support some systems now.  On a system without HMAT/CDAT, it's
>>> possible to calculate abstract distance from ACPI SLIT, although this is
>>> quite limited.  I'm not sure whether all systems will provide read/write
>>> bandwith/latency data for all memory devices.
>>>
>>> HMAT and CDAT or some other mechanisms may provide the read/write
>>> bandwidth/latency data to be used to calculate abstract distance.  For
>>> them, we can provide a shared implementation in mm/memory-tiers.c to map
>>> from read/write bandwith/latency to the abstract distance.  Can this
>>> solve your concerns about the consistency among algorithms?  If so, we
>>> can do that when we add the second algorithm that needs that.
>>
>> I guess it would address my concerns if we did that now. I don't see why
>> we need to wait for a second implementation for that though - the whole
>> series seems to be built around adding a framework for supporting
>> multiple algorithms even though only one exists. So I think we should
>> support that fully, or simplfy the whole thing and just assume the only
>> thing that exists is HMAT and get rid of the general interface until a
>> second algorithm comes along.
>
> We will need a general interface even for one algorithm implementation.
> Because it's not good to make a dax subsystem driver (dax/kmem) to
> depend on a ACPI subsystem driver (acpi/hmat).  We need some general
> interface at subsystem level (memory tier here) between them.

I don't understand this argument. For a single algorithm it would be
simpler to just define acpi_hmat_calculate_adistance() and a static
inline version of it that returns -ENOENT when !CONFIG_ACPI than adding
a layer of indirection through notifier blocks. That breaks any
dependency on ACPI and there's plenty of precedent for this approach in
the kernel already.

Thanks,
Alistar.

> Best Regards,
> Huang, Ying

