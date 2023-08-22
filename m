Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F41783B0F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbjHVHio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjHVHin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:38:43 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E12C116;
        Tue, 22 Aug 2023 00:38:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0D1onw0hdaMcWAZ3qQ2uLC54WJ63Huzh0exxM2EpUCCwo6iiivEoPezPgCNBFj/8iYX0CVUq679+byEkjltfawdD9BgIIXSdmQhdE4eSbLdVdCHlZClkG0FrUca81bYxqF3Zlv9nJ4RBrJCJ2HZ33rRB7OplsCcoQlc1OaskPkMh+C4BSC94vii3GlxnLmfDi9wfzszDPpi4YwFNUB/pt52HGDeUSzvCkk18eqIc2/oJqTu1zALb41rqViXLqlv9M9xWAEVqQaaARlsTmlY7edBpoLD/dXtPoHrqZS83rz2kPSIR265d5leR0Th3l2xCBjaiCHxSzSO11gVUgOviA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20o4qcor3z9cNEIevtNrbG9Jlr8wL1BRyiWOwNC3gYc=;
 b=Q61ArdWYDeHrdoKFC5QZAtMaWMUmIpk914vMF6GQeWCwhDQcj/rqlAD3+2x3uVd8CzmJpMFSNJFZYzfpe/qw8svWYuR3S8qtjHMTLMfO4vrr1KtSRf+OM5AoqQeXJspSsqMHLHbNGcdwXUtxuFFPdbHg8iv5fl/ceG4rJYhUoCvvVmWdj5p3sC5iHQeTppMC1o5VKNWFRCxF1PCVTSx8ey0KU2JMAJK6aQuUBcZ9PEr+dyX8wewRrbKIwxVt0ntT+0VLUgwfQwYeCpmY3kdny3KKf+KlhUUlNwttrXkuT2MCh5sV7VmJ0gjqnHJ+dUIi1gLJ6JghMPGeXKV8ol9CYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20o4qcor3z9cNEIevtNrbG9Jlr8wL1BRyiWOwNC3gYc=;
 b=rAIF/TUjhzV8SjnKoAHl1W/6frA9QI7sXgYgIjS5NqBnxV4LQ4KarWZ1C7i0O39FanIavo+gh/6yIqUvefNMkUH/QGNjmIipzGm76LmxDGCpY4b1gSI3NYYMvOkdkkJYvx/eiY9lXakVp5Y2pzd1uOy/WzJVtIZq1Lozw1m74jo4A4Ce9QLubfjpmY0YPi0oJyEIQPjxCtuKO4DLpL76q6TTgBmhQtqjAaxghgb1KtA3+0O6gx7POWnAsCtU0t60mqsJMsuBeAgdGbssiey5cy5UtFJpS9762LftZLLaBHRH3zMSI6OjHGTG0OI6QfNSwLgY/vX5N7qo/4FoOZYilQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by BY5PR12MB5000.namprd12.prod.outlook.com (2603:10b6:a03:1d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 07:38:39 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::3bf6:11f3:64d7:2475]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::3bf6:11f3:64d7:2475%7]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 07:38:38 +0000
References: <20230721012932.190742-1-ying.huang@intel.com>
 <20230721012932.190742-5-ying.huang@intel.com>
 <87edkwznsf.fsf@nvdebian.thelocal>
 <87cz0gxylp.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <871qfwwqi3.fsf@nvdebian.thelocal>
 <87a5ukc6nr.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
        Rafael J Wysocki <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH RESEND 4/4] dax, kmem: calculate abstract distance with
 general interface
Date:   Tue, 22 Aug 2023 17:36:22 +1000
In-reply-to: <87a5ukc6nr.fsf@yhuang6-desk2.ccr.corp.intel.com>
Message-ID: <87sf8ble6g.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0156.ausprd01.prod.outlook.com
 (2603:10c6:10:1ba::8) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|BY5PR12MB5000:EE_
X-MS-Office365-Filtering-Correlation-Id: ebeca8ee-dec5-4989-28ae-08dba2e2ccf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yPddi3rG4JQoOmvZOyBxUllQqqCsCdMJhzN1RDqj4wYUxgIa9RVRCU8Q8Rb3DR02CAYomIPhDOTuy39wbG9GLq9hxIFgKhs5VnDegTtEd0eWezU/iXDhcL+mbFmGm/B4DU+UJTC8kBeqbTW0cz+zZTnmQF6MuQfPqxajQfzEDfBB+/uBotEw6zvIhm2SItBhQVXWcongEEyKPRbGjxWybWCsQcikgXVLLwAq5XjhzmkNjRW8TvyTT6A/Bf/kGNAc6X+MOvB41A8WO7yEryQAUruIZlFLS5ePMNEjQKX6w6+z0W2IyJDPp8ccS/MoU7l6aY6Px48RBfNIH3ScTUyvPXx7RAvUihRJSKhuQDtqBYjilPdsnip8pmdVImFJSb1JGUn/EZf23/BhJT1C8bhP3Sm9lzQODTagIBUdyhIWpJvRYDl+Z5JfEujlKLVSaSw0T0rXtsJC4iVl4ShM86QC3JiaiaC/vDIvDyzxMcqZHveXNan01pyfGmIqtxS+sNqKaa6FPcSaub8DvV0ip3Wrx8PO7Zl+aqmxgFATFTdjPjMeWmRM95sWMM0djqe3oyIk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(346002)(376002)(366004)(1800799009)(186009)(451199024)(54906003)(6916009)(66476007)(66556008)(316002)(66946007)(6512007)(9686003)(8676002)(8936002)(4326008)(41300700001)(478600001)(6666004)(38100700002)(6506007)(6486002)(83380400001)(2906002)(7416002)(86362001)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?grYESB61KVLkveFW0QlOTpSJ+IUU8YpftgH3kqdm0bPtbHmBNnXMsjvMqW69?=
 =?us-ascii?Q?IcD5Z6vCcz4UyWBnEJANnsBGcKYypKg+bkYGC6HaX9Qk7YznmNi8wNdeXGpw?=
 =?us-ascii?Q?Pc2b5ZyAuSpmuuFgkZw16lYHVzlWnwqWJZcq00+5xoF6MiXPo7bgqBXG/xdt?=
 =?us-ascii?Q?AI+2fxsyVP6pot09MfBlS/uuRjyHa/HbD5NJ0GgxnE+uylXX/+kgLPk+yPpb?=
 =?us-ascii?Q?mYHocfiCJJwfJooxfo+n4wHq3PSiMaB7WlnOHOFZZhg+SwkFIxhDk5MJybMl?=
 =?us-ascii?Q?8tRVtTYDLFhlvvrqqhsGxtO+IQ+jcGWAqjZaTjjO9KTVU8i+82lSDXbiTKqX?=
 =?us-ascii?Q?KWnWyJWyF2gdeA/voA7iiO0j0bthvDdRXtvDyWbk9jCvnojSRvwrOVUUcH9R?=
 =?us-ascii?Q?bZJirvvYjfsmWkEY7V/Gruoko94rma8W0E/qus2pwD3LOmSwkbq5XKm/zBXJ?=
 =?us-ascii?Q?rW9fxIrsI4Vcw4oPCov8smJITioOv7g3Cjuf+R/v+/gjlC4qQ7yQIli9TZJD?=
 =?us-ascii?Q?REpBEt5z2yjKkLVXulh9oc/Yy1TCRywl4l9x/SKR7nOGx7ZK1v33PlQPsBtm?=
 =?us-ascii?Q?9mGk7nhHTuxhheEooyEVw0vamM7BBR8FqkmSI3c2H5KtcNNoQdxaOgZ7lmzO?=
 =?us-ascii?Q?KJrsftVAMPFSqOxyzU3ZV6RTvfFJu7TnV8GbBRQSsV+ONccgtRFi+sPela6s?=
 =?us-ascii?Q?QxCIHkBY7adnNx2b3ElxEq0gPuw8V2SCl1H5GIDD0gmFGWGkEO3WIfKJtaK9?=
 =?us-ascii?Q?Y0t0HVL0zr6Qv3B/NLjKRWFQj/G3rvwp37N4Ic+IqzPj9ZHWa8g8osbiyHj3?=
 =?us-ascii?Q?AkhxAAPPq+gBbGBHLspmvpmp2ZmNdUITUziUSxu2sFDHRtSlhmlSTs8VHUAS?=
 =?us-ascii?Q?IataYGpHwc+H0tiuy4q995599POalmzGKfDwN9YMj4oZwCqNfU6lb/0I6j4D?=
 =?us-ascii?Q?X71w/nTrSYmNyEKT1EfuftPOtwMLcDvT8avqS5yq4Vodu+FvOb8qHR0iAHmX?=
 =?us-ascii?Q?ND1m3/LaWiUHIdiFXetK27L1JzGcCAdpSD3hShfqqJrfkREskCcEFOvWDdGI?=
 =?us-ascii?Q?5BKWC8ScDbxw5/hS/fnrqLC35WQ2ao+UwIHaK8nPmmq5dRTmlfFv94rS/Fzr?=
 =?us-ascii?Q?ch5ABLMp1+gGrilai+nvFJEZtregqiJTFuW0gn6bmRw97SxMYcCRwhalllso?=
 =?us-ascii?Q?2hZDRwMXKSUC3rFezuvMKlvuUqKXNOILCZA5R/8GmzXYptEX2ZfF9KNWDgJt?=
 =?us-ascii?Q?VKV+dZH5XBNhmUdPT3a+E3XQcs/AChd6qPACs8bZBQOF51ACa53h/T+jdurr?=
 =?us-ascii?Q?x581QnAtDvOfLjE2zFDDrvW+m3lWdeydm57yIKIWAFyO1yuoXZpuWQj5u0Ih?=
 =?us-ascii?Q?8rSOuQLyqvyV58hRP+DbxiouyfgfLrgsdlM+R2HLAufN4GprSepcW3t6V48d?=
 =?us-ascii?Q?32TlWDj7f8WrNSDqg1pU4uZ20RXZ/aN38ZbcVR7tXhkQtLa5i5FZMWJ+ZlTr?=
 =?us-ascii?Q?c5G5NfUiplYa3QlB/99TgpKuUc/MZJuKcJXacHyxXoNk1IHtprjwlMuDakkE?=
 =?us-ascii?Q?iyukYQFR1cj56jy2OAKo0iJ4YBT3TZVLk/yr1wO5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebeca8ee-dec5-4989-28ae-08dba2e2ccf2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 07:38:38.9170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: skMOyU08HLQcKG/fU+y4xExwZLBaEKRhZdEBvspagUqejgaMWDmwvm3zgRokWywpFdC5lE4kqQsxu0b1vfLe+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5000
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
>>>> Huang Ying <ying.huang@intel.com> writes:
>>>>
>>>>> Previously, a fixed abstract distance MEMTIER_DEFAULT_DAX_ADISTANCE is
>>>>> used for slow memory type in kmem driver.  This limits the usage of
>>>>> kmem driver, for example, it cannot be used for HBM (high bandwidth
>>>>> memory).
>>>>>
>>>>> So, we use the general abstract distance calculation mechanism in kmem
>>>>> drivers to get more accurate abstract distance on systems with proper
>>>>> support.  The original MEMTIER_DEFAULT_DAX_ADISTANCE is used as
>>>>> fallback only.
>>>>>
>>>>> Now, multiple memory types may be managed by kmem.  These memory types
>>>>> are put into the "kmem_memory_types" list and protected by
>>>>> kmem_memory_type_lock.
>>>>
>>>> See below but I wonder if kmem_memory_types could be a common helper
>>>> rather than kdax specific?
>>>>
>>>>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>>>>> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>>>> Cc: Wei Xu <weixugc@google.com>
>>>>> Cc: Alistair Popple <apopple@nvidia.com>
>>>>> Cc: Dan Williams <dan.j.williams@intel.com>
>>>>> Cc: Dave Hansen <dave.hansen@intel.com>
>>>>> Cc: Davidlohr Bueso <dave@stgolabs.net>
>>>>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>>>>> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>>> Cc: Michal Hocko <mhocko@kernel.org>
>>>>> Cc: Yang Shi <shy828301@gmail.com>
>>>>> Cc: Rafael J Wysocki <rafael.j.wysocki@intel.com>
>>>>> ---
>>>>>  drivers/dax/kmem.c           | 54 +++++++++++++++++++++++++++---------
>>>>>  include/linux/memory-tiers.h |  2 ++
>>>>>  mm/memory-tiers.c            |  2 +-
>>>>>  3 files changed, 44 insertions(+), 14 deletions(-)
>>>>>
>>>>> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
>>>>> index 898ca9505754..837165037231 100644
>>>>> --- a/drivers/dax/kmem.c
>>>>> +++ b/drivers/dax/kmem.c
>>>>> @@ -49,14 +49,40 @@ struct dax_kmem_data {
>>>>>  	struct resource *res[];
>>>>>  };
>>>>>  
>>>>> -static struct memory_dev_type *dax_slowmem_type;
>>>>> +static DEFINE_MUTEX(kmem_memory_type_lock);
>>>>> +static LIST_HEAD(kmem_memory_types);
>>>>> +
>>>>> +static struct memory_dev_type *kmem_find_alloc_memorty_type(int adist)
>>>>> +{
>>>>> +	bool found = false;
>>>>> +	struct memory_dev_type *mtype;
>>>>> +
>>>>> +	mutex_lock(&kmem_memory_type_lock);
>>>>> +	list_for_each_entry(mtype, &kmem_memory_types, list) {
>>>>> +		if (mtype->adistance == adist) {
>>>>> +			found = true;
>>>>> +			break;
>>>>> +		}
>>>>> +	}
>>>>> +	if (!found) {
>>>>> +		mtype = alloc_memory_type(adist);
>>>>> +		if (!IS_ERR(mtype))
>>>>> +			list_add(&mtype->list, &kmem_memory_types);
>>>>> +	}
>>>>> +	mutex_unlock(&kmem_memory_type_lock);
>>>>> +
>>>>> +	return mtype;
>>>>> +}
>>>>> +
>>>>>  static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>>>>>  {
>>>>>  	struct device *dev = &dev_dax->dev;
>>>>>  	unsigned long total_len = 0;
>>>>>  	struct dax_kmem_data *data;
>>>>> +	struct memory_dev_type *mtype;
>>>>>  	int i, rc, mapped = 0;
>>>>>  	int numa_node;
>>>>> +	int adist = MEMTIER_DEFAULT_DAX_ADISTANCE;
>>>>>  
>>>>>  	/*
>>>>>  	 * Ensure good NUMA information for the persistent memory.
>>>>> @@ -71,6 +97,11 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>>>>>  		return -EINVAL;
>>>>>  	}
>>>>>  
>>>>> +	mt_calc_adistance(numa_node, &adist);
>>>>> +	mtype = kmem_find_alloc_memorty_type(adist);
>>>>> +	if (IS_ERR(mtype))
>>>>> +		return PTR_ERR(mtype);
>>>>> +
>>>>
>>>> I wrote my own quick and dirty module to test this and wrote basically
>>>> the same code sequence.
>>>>
>>>> I notice your using a list of memory types here though. I think it would
>>>> be nice to have a common helper that other users could call to do the
>>>> mt_calc_adistance() / kmem_find_alloc_memory_type() /
>>>> init_node_memory_type() sequence and cleanup as my naive approach would
>>>> result in a new memory_dev_type per device even though adist might be
>>>> the same. A common helper would make it easy to de-dup those.
>>>
>>> If it's useful, we can move kmem_find_alloc_memory_type() to
>>> memory-tier.c after some revision.  But I tend to move it after we have
>>> the second user.  What do you think about that?
>>
>> Usually I would agree, but this series already introduces a general
>> interface for calculating adist even though there's only one user and
>> implementation. So if we're going to add a general interface I think it
>> would be better to make it more usable now rather than after variations
>> of it have been cut and pasted into other drivers.
>
> In general, I would like to introduce complexity when necessary.  So, we
> can discuss the necessity of the general interface firstly.  We can do
> that in [1/4] of the series.

Do we need one memory_dev_type per adistance or per adistance+device?

If IUC correctly I think it's the former. Logically that means
memory_dev_types should be managed by the memory-tiering subsystem
because they are system wide rather than driver specific resources. That
we need to add the list field to struct memory_dev_type specifically for
use by dax/kmem supports that idea.

Also I'm not sure why you consider moving the
kmem_memory_types/kmem_find_alloc_memory_type()/etc. functions into
mm/memory-tiers.c to add complexity. Isn't it just moving code around or
am I missing some other subtlety that makes this hard? I really think
logically memory-tiering.c is where management of the various
memory_dev_types belongs.

Thanks.
Alistair
