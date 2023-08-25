Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD624787F88
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 08:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240516AbjHYGGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 02:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235624AbjHYGFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 02:05:42 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2083.outbound.protection.outlook.com [40.107.102.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427E91BC7;
        Thu, 24 Aug 2023 23:05:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SP04/inhNo7EPtBRe2cz62GN8jiQxcmowOl7NFdSYzFA37Gm/5CjwgcmnQknIE0qWaFRSTtSbhAP/p+IQgr1iZh7lGCUKBryEyTHFdngAvgBK4YuGufpE7uNDkZofXdjhcGFBLrCqFbi/D40Wg25+mOfJmcmADXAAg5F83TejwFrjiXEwOU8JZAYC2rptr1t9qJLWc7IteYBKo49607XgTaPd+NVck7aKtzBggY+mh4qHIE0FQaRvj7PBryxjKyIT59BILznMbRngP1L/Rm3VSgabpvAgmLhpHArKBMZOQpen7IeTApxwRUpZ61jBl5gZxh7ELwjzFSn7PZ6DO6M1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvbV5hPrhiWL/ZCaymdF+2Ma7RnVsHLWvSAkvMJjB2M=;
 b=MTHSIil1p7U5aJPHV7vqxRmCrjSsQC4+oQlNxcJdFyeLU3PPWCcZlY3oXsvu7VNqJlphm6/50GsLEWD31Al7+zI0frllLdzbuOSEBkA79okPKjCwjPdeKIZk1J0xuXqxE1syYzgqk/iSSl+whV+q16WUohpZqsJHnuAvccp2j6TQ3Zu2uMKDY8cN0LNFj7RniO3RAbdZ6ze/6MTmAeNMK6SitdVq2n/QN8hdyZjpLy8jduGvL2GNbV0zmrzF3kd9MWiJyUilZR4m6+suCO0X4SkNq1AT1L1/7SVAhJnUKLpOuAfEhtttVMqur55vy0qoe0S/lwmAdkJ045LxovgK2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvbV5hPrhiWL/ZCaymdF+2Ma7RnVsHLWvSAkvMJjB2M=;
 b=cXuHFbcIzWG4D1B+ha0oQRoMlPeXtqCUuoLppGuRFhH7Vo0dW1gfrpKFgMvQFQ+BxSbB3YfxBCzCGq0fPI27LIXCLMtzJTGn+ef1Yq720wmWv5aIlwbjk4gyS1+G5LHMCrWb4RGmRXAFlFy11thElduxbGYBitWtP22MmUdjGPirHAxK9FGHJu6qYnLxbt+bAp2YlkcIMxhpPbbLZ0iLSJFA998jeexQIoHAJiSesnVxC8dMapObzdNBAVlmDVaO9FUwauhuwlb9ZMolMgnX3iHTS/g+07y5gj7fFwbDTMkDn7EPsJNJCqwVMuLrXRI8aIMTiRh8Yzidrde3N0e/kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by CH2PR12MB4937.namprd12.prod.outlook.com (2603:10b6:610:64::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 06:05:38 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::3bf6:11f3:64d7:2475]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::3bf6:11f3:64d7:2475%7]) with mapi id 15.20.6699.022; Fri, 25 Aug 2023
 06:05:37 +0000
References: <20230721012932.190742-1-ying.huang@intel.com>
 <20230721012932.190742-5-ying.huang@intel.com>
 <87edkwznsf.fsf@nvdebian.thelocal>
 <87cz0gxylp.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <871qfwwqi3.fsf@nvdebian.thelocal>
 <87a5ukc6nr.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <87sf8ble6g.fsf@nvdebian.thelocal>
 <87lee2bj5g.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
Date:   Fri, 25 Aug 2023 16:00:28 +1000
In-reply-to: <87lee2bj5g.fsf@yhuang6-desk2.ccr.corp.intel.com>
Message-ID: <87wmxj7j2v.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: MEWPR01CA0018.ausprd01.prod.outlook.com
 (2603:10c6:220:1e4::17) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|CH2PR12MB4937:EE_
X-MS-Office365-Filtering-Correlation-Id: 66310b58-9b30-4442-d00b-08dba5314d6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JNxqpEi26bSwdRwHpk8ecm3ggIsshloqQFO3wKVdu0E2Q1lRi/5KcPUUFVeari1ISqHdyzy9dC7DWdlshNM4NLXphMlEw3P8duOD98Ia6CoqOWU/nNOyU4FD7vdbH8wFmKm+NykIJcQTA8hs5RHc3gVFtwsAkKsb77MiG7Skhn5NX2FPuYygAHR9Ie5Vz1+OxcPrn6swzexJym6OAYpNDUSarDMHDDYR4mNKV+IDJh6eqtEYHdJWzDDMTG2+k4Y8K91HVeN2KwxJMtzGQKoiJ4B0iuHGOlm8mdr8s9sz7txfd0YsUrs9+xIgelxKaxSkCsnfL2OntPm2mR6BJ18f1gcosoGdoBeD50HKOz/iGKRNYqdGpY/NVIL4A0ezBBWI5o/19kBxAhzZCm+vkX3hgcFWnpInyUDckm7Zd866pxgjQSEgH/xRhkwgNblzGiCLzri6DH+I9aHcPSL+mdsjU7yPiLQWxi95Z9xvMQf3HyQ2EcFBBmNk9T/i6BcgCXXprFCyVnxmWoCz9bdbTtAoeWMR98Lf/YvzyqfgagdOqWKzhadU9b50V00XsJIfNUBX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(366004)(376002)(39860400002)(1800799009)(186009)(451199024)(8936002)(4326008)(8676002)(83380400001)(5660300002)(7416002)(26005)(6666004)(38100700002)(66946007)(66556008)(66476007)(54906003)(2906002)(6916009)(316002)(478600001)(41300700001)(6512007)(9686003)(6506007)(6486002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mTREJ/PCJqx1wme6yS8Tp2RdSueUTuM6KstnlJb/6zq5jyYmED9IN/DzMMvY?=
 =?us-ascii?Q?TDK1ivr4AKB3tNjEYAuCV34C/I1dzr0HkOXN8/QbhZ1TweFAxfwx4owNM4xw?=
 =?us-ascii?Q?CpZhB+I4D6GTWChTkfvyKCCDPPaRVE8S4h7380Oi0mWzmL19V9qGjSUZbCIO?=
 =?us-ascii?Q?EXuklaWzChHGZreCfijLTlBXmhGd2ByVZPGIhOFeH0bjvQcgGlyFGjaNq4fo?=
 =?us-ascii?Q?HZWDNvxaavUsD7zKgh28Pc+O46V5MVs1Jis4tL35vVqPsHwAigPVk3nWMTkD?=
 =?us-ascii?Q?kIkBKzFmkSfazonF+ayC7EhMioBzIBhAdXOKgmALkUfAUsRCXrA5XtWDl5J8?=
 =?us-ascii?Q?SMBSpzqDQ0LviL2sKarctT3sAad8ifiUuTw8JarQmMCIxVpZsS6PyOmuExjb?=
 =?us-ascii?Q?bcZgqzrhGb63qBe2zUXdCIxwEFsMZL1kl9GHqqA0ZO4VE0hCSsbUcDhDFCcC?=
 =?us-ascii?Q?a4f/DSNkG4eLqhxJxOt5vwbV5Gs0WKI4ZGFrAKUWnq6Pw70Id56iRBJlgDzu?=
 =?us-ascii?Q?LrwQyBbdk6DU6opgqravn2EApFnfYGMtahuazjGypOXAlRYlXDFc2OQIR+KG?=
 =?us-ascii?Q?RP4gMDhaYlL8O1PFnP/pHaFaYIuBXsRTKA4qcCj8pmXdT/LJ/ZNUL0ou3R4J?=
 =?us-ascii?Q?rTNxcIE2xxIcngGABS5pstYfuSfyU9xlFHsxblLH6ZxqRe43bXiWHn8ALQrg?=
 =?us-ascii?Q?Zi/ohH00rPvCRbAbOTTm3RtxzhTQbWUcO0lfM9sp9TTIMdWGK+hXMdoVYewV?=
 =?us-ascii?Q?xBUZknCpYnxlQBaowbRZBAlc3MBAxJEKEhmj6nYpxVRR+KlL1iCp8jXyDpv4?=
 =?us-ascii?Q?bPxZw4L3FpdPipxONgVaDTWi8NbPJEkJfmDlTlWsHmgyh6XqKK1eyBso0iM2?=
 =?us-ascii?Q?RpGytEkAxCQtxhyYNiNZjVdEtGbd8G7cpPuywPCS2mn7Gh5km5pE5VaPX58i?=
 =?us-ascii?Q?77nxGXEDOeVM4ZsQCJtZjs/RWvoQIzLjxRla2DPDxgtqTTgecBK8OlBM3U6w?=
 =?us-ascii?Q?Pfy4DFctrqiV072j3zvqQ5w61FX47R/ODPA89w+7f7dxkcswfGVY7k1N6rdV?=
 =?us-ascii?Q?tow2EUt7hxmPwogZc54xPgahR06+pC1w/WTabUdXRHH7lGhj7KVBhIjTJfL/?=
 =?us-ascii?Q?ZqE0AqkzgR7aCWMjMft0NHqBmYyMAORmT6ccJ/JkvXxTOkI1TqzDAM7kk517?=
 =?us-ascii?Q?z7jR/8ybaCafJom6M2dfVZt7HCuveL2J/6InBgRWU6vR6i13/uB8lJmQgHHH?=
 =?us-ascii?Q?FCzG3tEhxBuKxCrWDdAmc+/OSGiIgbBqs8I7Avu7h+xpLgnih+bBrHR0RbxF?=
 =?us-ascii?Q?2ePdjEuKy0mf6cp/4AOoZ15DeYd4Vz11DGGB0c/eY27oZJtlvREuOkS7TPg8?=
 =?us-ascii?Q?IHVJuS4xnvCqSvXgM5eAp+1rJHamkR7gEaxpOYO8vGiqdbXFYIW35Q9OgRM4?=
 =?us-ascii?Q?0iLr77L0Ojs83BQ6Z1QR+xFH2MezJg7BQP/E71mE+fkcNzQCZWMdgEjt502r?=
 =?us-ascii?Q?xV/xytBG/KIJUdbCu8mtGeyzUv3WrgZm+OzccRI+b/UvzuEo0h9R7jmTWeb2?=
 =?us-ascii?Q?fJ6W6WC60gEEOaHWbnbI15kcTZ89NB4luUP68cx7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66310b58-9b30-4442-d00b-08dba5314d6e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 06:05:37.8978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 07PWGzwalyDAHYcNc8pZlaeQO+tTbKDSFG4mEb6oPR7Etmc5Fr5UoNwscl4I+6kVIIQ7wwOdnTmCWYQ6bnCmyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4937
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
>>> Alistair Popple <apopple@nvidia.com> writes:
>>>
>>>> "Huang, Ying" <ying.huang@intel.com> writes:
>>>>
>>>>> Alistair Popple <apopple@nvidia.com> writes:
>>>>>
>>>>>> Huang Ying <ying.huang@intel.com> writes:
>>>>>>
>>>>>>> Previously, a fixed abstract distance MEMTIER_DEFAULT_DAX_ADISTANCE is
>>>>>>> used for slow memory type in kmem driver.  This limits the usage of
>>>>>>> kmem driver, for example, it cannot be used for HBM (high bandwidth
>>>>>>> memory).
>>>>>>>
>>>>>>> So, we use the general abstract distance calculation mechanism in kmem
>>>>>>> drivers to get more accurate abstract distance on systems with proper
>>>>>>> support.  The original MEMTIER_DEFAULT_DAX_ADISTANCE is used as
>>>>>>> fallback only.
>>>>>>>
>>>>>>> Now, multiple memory types may be managed by kmem.  These memory types
>>>>>>> are put into the "kmem_memory_types" list and protected by
>>>>>>> kmem_memory_type_lock.
>>>>>>
>>>>>> See below but I wonder if kmem_memory_types could be a common helper
>>>>>> rather than kdax specific?
>>>>>>
>>>>>>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>>>>>>> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>>>>>> Cc: Wei Xu <weixugc@google.com>
>>>>>>> Cc: Alistair Popple <apopple@nvidia.com>
>>>>>>> Cc: Dan Williams <dan.j.williams@intel.com>
>>>>>>> Cc: Dave Hansen <dave.hansen@intel.com>
>>>>>>> Cc: Davidlohr Bueso <dave@stgolabs.net>
>>>>>>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>>>>>>> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>>>>> Cc: Michal Hocko <mhocko@kernel.org>
>>>>>>> Cc: Yang Shi <shy828301@gmail.com>
>>>>>>> Cc: Rafael J Wysocki <rafael.j.wysocki@intel.com>
>>>>>>> ---
>>>>>>>  drivers/dax/kmem.c           | 54 +++++++++++++++++++++++++++---------
>>>>>>>  include/linux/memory-tiers.h |  2 ++
>>>>>>>  mm/memory-tiers.c            |  2 +-
>>>>>>>  3 files changed, 44 insertions(+), 14 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
>>>>>>> index 898ca9505754..837165037231 100644
>>>>>>> --- a/drivers/dax/kmem.c
>>>>>>> +++ b/drivers/dax/kmem.c
>>>>>>> @@ -49,14 +49,40 @@ struct dax_kmem_data {
>>>>>>>  	struct resource *res[];
>>>>>>>  };
>>>>>>>  
>>>>>>> -static struct memory_dev_type *dax_slowmem_type;
>>>>>>> +static DEFINE_MUTEX(kmem_memory_type_lock);
>>>>>>> +static LIST_HEAD(kmem_memory_types);
>>>>>>> +
>>>>>>> +static struct memory_dev_type *kmem_find_alloc_memorty_type(int adist)
>>>>>>> +{
>>>>>>> +	bool found = false;
>>>>>>> +	struct memory_dev_type *mtype;
>>>>>>> +
>>>>>>> +	mutex_lock(&kmem_memory_type_lock);
>>>>>>> +	list_for_each_entry(mtype, &kmem_memory_types, list) {
>>>>>>> +		if (mtype->adistance == adist) {
>>>>>>> +			found = true;
>>>>>>> +			break;
>>>>>>> +		}
>>>>>>> +	}
>>>>>>> +	if (!found) {
>>>>>>> +		mtype = alloc_memory_type(adist);
>>>>>>> +		if (!IS_ERR(mtype))
>>>>>>> +			list_add(&mtype->list, &kmem_memory_types);
>>>>>>> +	}
>>>>>>> +	mutex_unlock(&kmem_memory_type_lock);
>>>>>>> +
>>>>>>> +	return mtype;
>>>>>>> +}
>>>>>>> +
>>>>>>>  static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>>>>>>>  {
>>>>>>>  	struct device *dev = &dev_dax->dev;
>>>>>>>  	unsigned long total_len = 0;
>>>>>>>  	struct dax_kmem_data *data;
>>>>>>> +	struct memory_dev_type *mtype;
>>>>>>>  	int i, rc, mapped = 0;
>>>>>>>  	int numa_node;
>>>>>>> +	int adist = MEMTIER_DEFAULT_DAX_ADISTANCE;
>>>>>>>  
>>>>>>>  	/*
>>>>>>>  	 * Ensure good NUMA information for the persistent memory.
>>>>>>> @@ -71,6 +97,11 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>>>>>>>  		return -EINVAL;
>>>>>>>  	}
>>>>>>>  
>>>>>>> +	mt_calc_adistance(numa_node, &adist);
>>>>>>> +	mtype = kmem_find_alloc_memorty_type(adist);
>>>>>>> +	if (IS_ERR(mtype))
>>>>>>> +		return PTR_ERR(mtype);
>>>>>>> +
>>>>>>
>>>>>> I wrote my own quick and dirty module to test this and wrote basically
>>>>>> the same code sequence.
>>>>>>
>>>>>> I notice your using a list of memory types here though. I think it would
>>>>>> be nice to have a common helper that other users could call to do the
>>>>>> mt_calc_adistance() / kmem_find_alloc_memory_type() /
>>>>>> init_node_memory_type() sequence and cleanup as my naive approach would
>>>>>> result in a new memory_dev_type per device even though adist might be
>>>>>> the same. A common helper would make it easy to de-dup those.
>>>>>
>>>>> If it's useful, we can move kmem_find_alloc_memory_type() to
>>>>> memory-tier.c after some revision.  But I tend to move it after we have
>>>>> the second user.  What do you think about that?
>>>>
>>>> Usually I would agree, but this series already introduces a general
>>>> interface for calculating adist even though there's only one user and
>>>> implementation. So if we're going to add a general interface I think it
>>>> would be better to make it more usable now rather than after variations
>>>> of it have been cut and pasted into other drivers.
>>>
>>> In general, I would like to introduce complexity when necessary.  So, we
>>> can discuss the necessity of the general interface firstly.  We can do
>>> that in [1/4] of the series.
>>
>> Do we need one memory_dev_type per adistance or per adistance+device?
>>
>> If IUC correctly I think it's the former. Logically that means
>> memory_dev_types should be managed by the memory-tiering subsystem
>> because they are system wide rather than driver specific resources. That
>> we need to add the list field to struct memory_dev_type specifically for
>> use by dax/kmem supports that idea.
>
> In the original design (page 9/10/11 of [1]), memory_dev_type (Memory
> Type) is driver specific.

Oh fair enough. I was making these comments based on the incorrect
understanding that these were a global rather than driver specific
resource. Thanks for correcting that!

>> Also I'm not sure why you consider moving the
>> kmem_memory_types/kmem_find_alloc_memory_type()/etc. functions into
>> mm/memory-tiers.c to add complexity. Isn't it just moving code around or
>> am I missing some other subtlety that makes this hard? I really think
>> logically memory-tiering.c is where management of the various
>> memory_dev_types belongs.
>
> IMHO, it depends on whether these functions are shared by at least 2
> drivers.  If so, we can put them in mm/memory-tiers.c.  Otherwise, we
> should keep them in the driver.

Ok. Not sure I entirely agree because I suspect it would still make the
code clearer even for a single user. But generally you're correct and as
these memory_dev_type's are *supposed* to be driver specific (rather
than one per adistance) I don't think it's such a big issue.
