Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5F376612B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 03:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjG1BVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 21:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjG1BVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 21:21:40 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5DD9E;
        Thu, 27 Jul 2023 18:21:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TpPZBEPIC9Wgqh4o0JGjJEhxCs6a2k7diLKBF0HGMSv11lvyrsF9+UTZ9Yxl+7AAyblmoMStysZ4QMPpycpfn0hBC4BEtaqrhtOU415hjWc7qt5+G3ceD1xruhsOavuT+tqHTCHuoW6bM+Krqzg+ADFbbr+gtvGTgQH5kbQY0RdDN+9EYXiX3uzdQBJedIWk7TvUrF4riFgjuGr0dSrLqaD7BfV/bK/wC3NMw/XPqJamzhJwyo/X8XOavw15HhQu9MV2dyOUFOIOvGCiEKuu7FSApHz5m7tPXtTfw5bCeTAh37HimLVAHGxiy/EsXVh6mkyWfZpw+NbcB/ESLf37BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+DZV8Lv76DOb1vqBeMy1Rl2q+T8/vMW333RmpiUqjo=;
 b=ZRO9H7L/H1pS25YXztieryZDxXrrUd/3tRTO2Ub/cnThUkPO6A/Oeqs3JzZSCWm3jDf4g1UavNMKxCo2pFgnG0pJeR5DaZIVq0hWr8fb0KRiz8XEejkXvUeGjQiNzeDe4GBk8mpj/R974R83CrNdXhaAp9moO4tCiBddvPUhvgUWJXZ8oqSd3sApsKCZpnhSqX7+lZSSfmGgFwwvDQypDEQGMdrHJr20VtlD9xUOmK6nUkxBvIzxupwEIYfEFcw/sAUAa4rnUfFkbTk10Lv1v2jx0KOU1ItUM+Zug1AtsUmSn+/s9jQGjCxR1uXNhUDp7LmTCKHCGqjX/H4P5P3TwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+DZV8Lv76DOb1vqBeMy1Rl2q+T8/vMW333RmpiUqjo=;
 b=KMyO4JKjl0k/MG9gGrCXucqtQhMpiCX+nDiTCYnhO74qkUdnVU4slJUKlzpaRjsmqddFQ0glM7DNa3sQYTtEG0RPdwcGw0WbaxCruijDoK172D1SAIHXAFWnwn+icp1lyVLKRZGwcePUGHyP9lbURn5+THdnEDVzAkhh546Rzwu1gEBCPLr0LKhSXY5HqlkGUezI65YrRMSqd/Ct1HvQ6OuubizbyYh/HWmKl0uUn3kgoujJ9OA/J6ZSXf89kmyYdMfG7xdTANMrpvH5UGR+Au1ggsJivsVrdVPVRs0sV9vi7sKpmvPTkziPU26OZohWzvrHTHA5akhjSwzSReYOjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by MW6PR12MB8833.namprd12.prod.outlook.com (2603:10b6:303:23f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 28 Jul
 2023 01:21:35 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::c833:9a5c:258e:3351]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::c833:9a5c:258e:3351%4]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 01:21:35 +0000
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
Date:   Fri, 28 Jul 2023 11:20:05 +1000
In-reply-to: <87a5vhx664.fsf@yhuang6-desk2.ccr.corp.intel.com>
Message-ID: <87lef0x23q.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0058.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:20a::17) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|MW6PR12MB8833:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f4b5d1d-f65d-4000-e3f4-08db8f08fbf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K3996lDQectkgq0XvMXoX14QM9tXU668dmoINjrblh7lwG+6plR9qmFKDjrJ9gc6ISumh3C4cSAcrOsO+eik5TAWf7Rm+fES82oSfALvD4u+xzIi9+CbtwM2WPOHYentUNgNdHjSKZiM6OCGfrRL/VpSHSdfgRfD/nfM/94fKhaKuV0EqZj06F0td9P9R3BCNlRPdhTE7Ai9/zae+9vfzCuwkNaZV/i3ox0/ZGQ4zUip/3x/3CsReb9HY2fbz4+YRTKH7SGOZcOjUWLCAVg1YebdrhM2dpnt6Kmm+5yAq6Aw7gd0ibcPiK4n2XkasOSvmNI+Y411culDzsVVC6fluXQ6SFRSOXXVWxRpEiMrXUyWqxaI/RCU8wZUWXCI34Jn4wSDgusIpiXzXaxKZBFeEAqH0kLtipxVmh3YKDDTgOIqF1HpnHkNJvhmAf8pn4ags+hD28BYj3J8Urk0C1Dzx7+VVWIp+RD15KMLs7pM7V0aY05+twu9jDlqYkIYGepNKPwBV8oD5oy/BPnS1EtTcrzXrbBYtqPc/s3ewBc+A/u39YkeI6AVfIzNvABnLo8j
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199021)(8676002)(8936002)(7416002)(5660300002)(316002)(6916009)(41300700001)(4326008)(6512007)(83380400001)(54906003)(2906002)(66946007)(66556008)(66476007)(6666004)(26005)(186003)(6506007)(478600001)(6486002)(9686003)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2pBuRFF0grMABRybRcUU1KoLaqyjB4e9qt2KK3zdQn/5CH5dCrXaayzd6BmH?=
 =?us-ascii?Q?rD0/lqaZ7DbS+qogyHXNBUisne4Ud34NWqmeWki/Oz0eAFVPHxzPoExHVJae?=
 =?us-ascii?Q?PwDNyVwI2yQvD87SNdgCT78rpz2w+/fXye6+wiCOvCZY7kcbqTyJaK7t1SUV?=
 =?us-ascii?Q?tkQfyryEpIy3zOFttbD1dgtf8P+HQF90ykK75uoCbXsA87o6AkCPiD2GI9Cg?=
 =?us-ascii?Q?Puxc9ijLEP4WlZFtv4QgTpVh+h3tiXe0txFLu0lZZCAGGudqMPmyZuN2eOmd?=
 =?us-ascii?Q?jDv4eqr0XDLKbfSb3PBlqgGUBsxUICGbDjQbEOmahxAXbKblnhEZ9JgJKJiL?=
 =?us-ascii?Q?2DnEoG1HHHrNo8SFf/6rlhunwcWWELrhKZKCX7KAr9NhgOtvoPASk2E24UeO?=
 =?us-ascii?Q?8e1z0vLn70of/5Hsr2BYARpPEz6GzWKUJEPN8cpWq/+Qj8AGF7zlIJKiZDch?=
 =?us-ascii?Q?Ud+iToswu1L0Vj5DyEqBT52vPhmvZhifnKPglpd2lB4wgKr3io32DU1CLkQ7?=
 =?us-ascii?Q?2EolfupBkLmSVkIoQcO8Wll0LAtgsAf4OLhYPnOkEUFWY6Ac0kZCrnJ+z/Ab?=
 =?us-ascii?Q?A9pv8LEYaUF6iwUY1aBGm9UVQYLiWYau5tP5YBiS0BRD6Jg8fSyI2jbegnbl?=
 =?us-ascii?Q?9u0EDG2IR53fFT//+ReCpEkXVnoQojrOUR+KrjWVbeVX+VA1sWgazY08A98j?=
 =?us-ascii?Q?dBM1pkeZJfFWLGpiaUgMzHyXoy18m3ic2xS7W07i8W+CS1N5rp1AL47M8j6N?=
 =?us-ascii?Q?rOCkYEnHOGISFSEzOh3TvKJ+nhGCozTzYyojDIbuJIEUzbaMr2hXLYuP4fIk?=
 =?us-ascii?Q?ba1GfsQtAyTJYH9t9/At3cjQ8agXnlPYOOyxK3seN0gfaUQmmaQ2qMekcxtu?=
 =?us-ascii?Q?OQqyE/FJNqjOTdSzB+kJ2x/CDie7IcJ1GQEUaOz8DXgkgi40zrdIf1noaTxg?=
 =?us-ascii?Q?ZnXyrKomV0sCckf7rEXoVX/iltgaLXo5JW8bs9yediPBB4TRFa8Vh/KC4Npe?=
 =?us-ascii?Q?8WhVUa73cHdlcCyt37v1xHYGWoyQKQBEx1uEfqCMm/vctC3fnPZ41zqXwnOI?=
 =?us-ascii?Q?VO4yEl7oy8iWZVuLiLHPz+mQaLMgodJqN7tUImjbWpmMB5+PcvhUDdCGHK+0?=
 =?us-ascii?Q?lx/s6v4+vVjJ6rLd+Fz5LvbGH22FmR3Vl4ni1+r+oGdcwubTi4K5/rOAWTXa?=
 =?us-ascii?Q?OWbDc2CpKnUnfVrybFPh71uLPqvGYVfOKsC3V70fSlcuVZyOdphB1Bjp8g/o?=
 =?us-ascii?Q?4LMFnclqG7L+aKJflhLtP+Nw8So3Ea4wN0QDlYl0CsVSOopaz064fwzycWJ8?=
 =?us-ascii?Q?EP1mz/Q4o4KEMQ9qKM2Q0NWa4zj3+vvNYpc51z5JTF298p15fvTmwpGUZLry?=
 =?us-ascii?Q?QfLXqAvrRxoirlKyVyRObsCAHf158CR4BmYZJvAJhkLnxSosy94mjmqWobVk?=
 =?us-ascii?Q?nDXZkMieZm2CX+/eizjweqy6qL0XWk0sTbFxOk/PlYgA9OR+4VhgIRxz7Dea?=
 =?us-ascii?Q?ytF4P7qFWjh3RYKD4dQyyYSGq94uzca0ae0Bume/vCcBJfkACYhWeUlS6jj9?=
 =?us-ascii?Q?0wOdrAWwGz799P7LPdNjBnozjIXmj0bsDPF1ijQ6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f4b5d1d-f65d-4000-e3f4-08db8f08fbf5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 01:21:35.4742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u0mOLnO3YgQy8Qq7Xt99WXmPjZrt5cqjsFFAizLjTktY04OcVFLK07gb6n1dunk5tbS/UeLQXSBV/hUuwAgvQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8833
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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
>>> Alistair Popple <apopple@nvidia.com> writes:
>>>
>>>>>>> While other memory device drivers can use the general notifier chain
>>>>>>> interface at the same time.
>>>>
>>>> How would that work in practice though? The abstract distance as far as
>>>> I can tell doesn't have any meaning other than establishing preferences
>>>> for memory demotion order. Therefore all calculations are relative to
>>>> the rest of the calculations on the system. So if a driver does it's own
>>>> thing how does it choose a sensible distance? IHMO the value here is in
>>>> coordinating all that through a standard interface, whether that is HMAT
>>>> or something else.
>>>
>>> Only if different algorithms follow the same basic principle.  For
>>> example, the abstract distance of default DRAM nodes are fixed
>>> (MEMTIER_ADISTANCE_DRAM).  The abstract distance of the memory device is
>>> in linear direct proportion to the memory latency and inversely
>>> proportional to the memory bandwidth.  Use the memory latency and
>>> bandwidth of default DRAM nodes as base.
>>>
>>> HMAT and CDAT report the raw memory latency and bandwidth.  If there are
>>> some other methods to report the raw memory latency and bandwidth, we
>>> can use them too.
>>
>> Argh! So we could address my concerns by having drivers feed
>> latency/bandwidth numbers into a standard calculation algorithm right?
>> Ie. Rather than having drivers calculate abstract distance themselves we
>> have the notifier chains return the raw performance data from which the
>> abstract distance is derived.
>
> Now, memory device drivers only need a general interface to get the
> abstract distance from the NUMA node ID.  In the future, if they need
> more interfaces, we can add them.  For example, the interface you
> suggested above.

Huh? Memory device drivers (ie. dax/kmem.c) don't care about abstract
distance, it's a meaningless number. The only reason they care about it
is so they can pass it to alloc_memory_type():

struct memory_dev_type *alloc_memory_type(int adistance)

Instead alloc_memory_type() should be taking bandwidth/latency numbers
and the calculation of abstract distance should be done there. That
resovles the issues about how drivers are supposed to devine adistance
and also means that when CDAT is added we don't have to duplicate the
calculation code.
