Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBBB787F79
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 08:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239896AbjHYGAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 02:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239973AbjHYF7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 01:59:41 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8031FE9;
        Thu, 24 Aug 2023 22:59:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=boZaM68C3SD32jQZdQ42G1ULLfg+KoILJdljIcaROZDqWcAZN8wDLxP4BywXyUeucYSq6oD4CSrDHZ5426GBnjf8q24CplRZxTFnC8vG5IVHCat7Kz+ORTq19S3mS30e9WejPUb+9VEQA71lI9oC9mKZ8EJzP+Oo+1OtI4anPLxk5OU/Yfo0NWNmDx1LPgcUDcAGzg8K2q9Xzyd4KoIU0Hk8uFASOIeCM3hs7YRk+Hn8VmpJHT/VMo4uuBNV3ooAHKbw6OcukUKTDDVB/pCDozXfgTPbOH1WxGifgy8nry811JuuSyJjaEyAqnaM4WgHFcw9XEeX955ZVyXBml9S6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNwJzQhlut9HUnTNyocIvHfnX84GIES6jg9s4mYbvh0=;
 b=L/vFfMfIdeAueu4ZE/nB4LT9rwHxFupEacxk3m9BvJ0tHBZAJEZpAxrHExF4/2IgAQa1BawERkueaU4h5Cg2ci47tJvGfrTuqaU8RpHIsSHmZQc5o+NmuJp63dv1q+Ihv8LC2M1XyHv/XwSpJhTPybJomjcCBcpCYt0wVwpgcl6BwPR5RDOSCvm3kf/z4Fbr7rAHeL1Q3d5Z/IRVkcMQFCUjATIY0N2KIHbaCFQ5UHytAqP+rCZKr1+kjc01wYL2ov1fWeeN0lbhN5O7RUvX+s5C0X+zutlThG2CpFUSiKUQUF9ziShoZpYkLcgTNzP3sDl3R7jzktrqVmkRyDzt6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNwJzQhlut9HUnTNyocIvHfnX84GIES6jg9s4mYbvh0=;
 b=Tn0vst7ipDZVefQVeaMOnZptIlRwiMbwNGEtMnZDwbgpFkikq7OpBSbTw6CBTMe3RbLo+h4u2ZLNgeRzZiO7wnlUCphjEW+3zf100wm8nSdfGvAMSGhlqOnx9dsWCUNeuXU6MATVZajzBZHuuo2TEvYgKjAhq5oWOGC22thbqOMQhr4QFLGo6IAmcG2Q182EQ+VIhAuKf/huW4Uc3pUgMAuG5vdEzDjNFIgiBuJg6jDtmp1lJB5P61g6nC60VOA0XHWU5WxU9fHobkrTnVY/VsfQVKK4GdG0haxja0haVETn6RfEqy8kl3O+7kce0vPq7nDcHdadazMpfL4dpoZ+ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by CY5PR12MB6202.namprd12.prod.outlook.com (2603:10b6:930:25::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Fri, 25 Aug
 2023 05:59:36 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::3bf6:11f3:64d7:2475]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::3bf6:11f3:64d7:2475%7]) with mapi id 15.20.6699.022; Fri, 25 Aug 2023
 05:59:36 +0000
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
 <87edjwlzn7.fsf@nvdebian.thelocal>
 <875y57dhar.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <87wmxnlfer.fsf@nvdebian.thelocal>
 <878ra2b8uk.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
Date:   Fri, 25 Aug 2023 15:41:26 +1000
In-reply-to: <878ra2b8uk.fsf@yhuang6-desk2.ccr.corp.intel.com>
Message-ID: <871qfr8xx9.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0233.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::28) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|CY5PR12MB6202:EE_
X-MS-Office365-Filtering-Correlation-Id: c64781cf-0d23-484e-b6bb-08dba53075ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O+jTIZcsOgK0vAZXBGI5kPUNRxTeDEd36DN8vrpKSxaWHxZTiyPWamYJr0vC2yXNLtjhpm045NNKV97udoZUsia+2lN2qRMJsu7mNzqc9F9flJmwO0DplePvYDn4CRSFDKOtgTN5jzXOjn3hM6pkEScaDeGweoKobipWBNoUpcjOnjfxPKnIKyIedZrRUn1oQKqIf360KoO6cc8Az+ObW+SiNhTGcfMX3OrNIne0OGxv0+q2olfHYc7rAqtOLgNy1chuUeH5vaee3njYNpRcyA4jbxDYh09rdJYyKIQLli9DYHokIwuvNCN5SqNFI1pHA8mM9hPglKt8zok9MoATyieEkPz61c4XS62aPMuQL4rhlCl18OmTZaAofK/rEnuQLWlVlbEJak0dVvOWiCDhLAz8if53D7M5sSfDFxMv+bKhLg0hgmrKbA+CwZfP7M6fbTevC89ptTQTC6awzAMZ03k206hnA7S1cVUtC9L9Oku5Vjl3eRmR5AKMSCxZeJZakt1fI9fo8Jxw3aX/xsxi9LOk62tM3cMeK36YaSQkvJRhZJNJErcRsaeVnIrEGv/p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199024)(1800799009)(186009)(38100700002)(8676002)(4326008)(8936002)(54906003)(41300700001)(6486002)(6506007)(6666004)(316002)(6916009)(66476007)(66556008)(66946007)(86362001)(6512007)(9686003)(26005)(478600001)(7416002)(83380400001)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sVQczOmd9yQ4olMOLpMWsagQvUUiZKrHghtrIdzd769rnn0C3779R4tJqYz9?=
 =?us-ascii?Q?OCxi2KPS9pzTtz6AgZD1W02bdFexeosH0eswSRRj1+1SRQaT72zTWi3FtukS?=
 =?us-ascii?Q?x3geylzv3AQx5bLhK21TZ6MtwYRu/4Z1EozDL+dcmsqRFCgeO1boOA/xto/e?=
 =?us-ascii?Q?FOF/HYBAE3XY75cMIOR2tZgdA5qNMtdGgFUM1tM8z3mS3DQNgFvlIsoVEM23?=
 =?us-ascii?Q?vPwSVyP/RyJ9r2lhU4qga+ddRanzTnZmO6N07eDQdVF7yX8ZvaoNlNLgvfDD?=
 =?us-ascii?Q?vZfpVDZaY0gCQES/PhtyQO6CWUfQ7mbk4oss73dg3nmZJoJpKrZFLqhxuIK9?=
 =?us-ascii?Q?jsOGZOHI/9JUPdnB/tvQM2pj957fGFflHV08FgfgsOErHK5V30XQIXAAWTKc?=
 =?us-ascii?Q?PI9T+iCVGV/ddBALw5AFxHCndUozq7bkuiLJFNvlby0uIG2e9T+lwRmW6MLC?=
 =?us-ascii?Q?NmBFiuzxI+d/WfFySRCau9P1K5Y2cbBVYKJ4EXXn5/YlDRLpYAYjuy3Lh+Xq?=
 =?us-ascii?Q?VzOCeLy+L3Egm6GW43qhgIHvD+Xv+EYrush3TiQf/iqeYDEsxFDwjM7vUPhL?=
 =?us-ascii?Q?8kr8/kexRwiDzTQ1/UloqSe9GaICftT01C1v8kuFVZvaYBXJ2lLeFc6z1VIO?=
 =?us-ascii?Q?u8ez3F9t9LMjCWXduQrW+u4yv2nWjsjd+Pejn509iBjC+VSpvo8i1C5fIilG?=
 =?us-ascii?Q?lX19TsERCxXxBDfewksWoZDhVch7nmLCqyfvfC4IU856ZiwDFDQEK3/80ITD?=
 =?us-ascii?Q?64czmUYQNvGxIM/QTA3g19qjn+yK/65pD4GTVDGZXcrNV3MfYBytIphP0enK?=
 =?us-ascii?Q?tDdjex/UEY8fMFb32dKe3YbCc6cawKqx02J/qaRpw/GEgL8zQqdDNiTTOAeO?=
 =?us-ascii?Q?Q95DAA91iqIsl145U3N1ov/RlbqU2Q0b35I6b5ckgG/iuIchHq5ls1mc4+gY?=
 =?us-ascii?Q?tOwrhWkTiKa5G9yY93DgGD6R3MqcplwBpCy5NwWrE8Y+1oplxedctVif1Y5M?=
 =?us-ascii?Q?dqWMEmcLokF7e8rke9QWCZv/iBRrHILs5pggF9TIGnFS3jTukyNPa2u9G8ct?=
 =?us-ascii?Q?P0iUm/C/2Hfe26KW7QY7aY/7gzafbhSD674lkSxADFwKRrF3h6a451aBfvHl?=
 =?us-ascii?Q?MRzffZMN/a8T3Pt1i6oiXC7gNIiPIhbtxITailcas07E5cue96All3O3pDaZ?=
 =?us-ascii?Q?rz3N7JtdIcBUASyL7qxJMg8rCc/4b9UZM5v+92Mn91kMzei+i3mVig9yOL+6?=
 =?us-ascii?Q?Oewt68xjiTdx43DtTpE8GrgAAQXq/+wZjtTi+k+g9/VxctpFd6RLBf2w96Go?=
 =?us-ascii?Q?y+eApK1kZxEANY8zyqBdOJvYgkMzi0+psJ4D7VOpDkRyScchkVu0F164PElg?=
 =?us-ascii?Q?R+754bjE0vtEGJ15ED0e3NEbtol3JZF5yBxNRTyfDADozBphh7gAaUlTvPzd?=
 =?us-ascii?Q?rMb5Faz3Nt9r5AyViSKkEFt2N6tOiacUjoyDXYwQsx4fXxcpGW+f2VXjbazf?=
 =?us-ascii?Q?HGo3XkvOCYAY0NOziZ9SM2ayuMVcVy+/7YmnvddNCJYpLZaAmJ+NcV81myqn?=
 =?us-ascii?Q?5bQaLo8mQO0+8iFsimzVClkN4QO1tHNuqRVl5y08?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c64781cf-0d23-484e-b6bb-08dba53075ab
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 05:59:35.9623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 65f2mxhXnx7sRyNPTVqsLax8tJqrQDfEmdzHBqd1t1mVVMTqO7vE16eVlOAKVf/s5OzM5YD7Gqz/IJN4lRkZDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6202
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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
>>>>>> "Huang, Ying" <ying.huang@intel.com> writes:
>>>>>>
>>>>>>> Hi, Alistair,
>>>>>>>
>>>>>>> Sorry for late response.  Just come back from vacation.
>>>>>>
>>>>>> Ditto for this response :-)
>>>>>>
>>>>>> I see Andrew has taken this into mm-unstable though, so my bad for not
>>>>>> getting around to following all this up sooner.
>>>>>>
>>>>>>> Alistair Popple <apopple@nvidia.com> writes:
>>>>>>>
>>>>>>>> "Huang, Ying" <ying.huang@intel.com> writes:
>>>>>>>>
>>>>>>>>> Alistair Popple <apopple@nvidia.com> writes:
>>>>>>>>>
>>>>>>>>>> "Huang, Ying" <ying.huang@intel.com> writes:
>>>>>>>>>>
>>>>>>>>>>> Alistair Popple <apopple@nvidia.com> writes:
>>>>>>>>>>>
>>>>>>>>>>>>>>> While other memory device drivers can use the general notifier chain
>>>>>>>>>>>>>>> interface at the same time.
>>>>>>>>>>>>
>>>>>>>>>>>> How would that work in practice though? The abstract distance as far as
>>>>>>>>>>>> I can tell doesn't have any meaning other than establishing preferences
>>>>>>>>>>>> for memory demotion order. Therefore all calculations are relative to
>>>>>>>>>>>> the rest of the calculations on the system. So if a driver does it's own
>>>>>>>>>>>> thing how does it choose a sensible distance? IHMO the value here is in
>>>>>>>>>>>> coordinating all that through a standard interface, whether that is HMAT
>>>>>>>>>>>> or something else.
>>>>>>>>>>>
>>>>>>>>>>> Only if different algorithms follow the same basic principle.  For
>>>>>>>>>>> example, the abstract distance of default DRAM nodes are fixed
>>>>>>>>>>> (MEMTIER_ADISTANCE_DRAM).  The abstract distance of the memory device is
>>>>>>>>>>> in linear direct proportion to the memory latency and inversely
>>>>>>>>>>> proportional to the memory bandwidth.  Use the memory latency and
>>>>>>>>>>> bandwidth of default DRAM nodes as base.
>>>>>>>>>>>
>>>>>>>>>>> HMAT and CDAT report the raw memory latency and bandwidth.  If there are
>>>>>>>>>>> some other methods to report the raw memory latency and bandwidth, we
>>>>>>>>>>> can use them too.
>>>>>>>>>>
>>>>>>>>>> Argh! So we could address my concerns by having drivers feed
>>>>>>>>>> latency/bandwidth numbers into a standard calculation algorithm right?
>>>>>>>>>> Ie. Rather than having drivers calculate abstract distance themselves we
>>>>>>>>>> have the notifier chains return the raw performance data from which the
>>>>>>>>>> abstract distance is derived.
>>>>>>>>>
>>>>>>>>> Now, memory device drivers only need a general interface to get the
>>>>>>>>> abstract distance from the NUMA node ID.  In the future, if they need
>>>>>>>>> more interfaces, we can add them.  For example, the interface you
>>>>>>>>> suggested above.
>>>>>>>>
>>>>>>>> Huh? Memory device drivers (ie. dax/kmem.c) don't care about abstract
>>>>>>>> distance, it's a meaningless number. The only reason they care about it
>>>>>>>> is so they can pass it to alloc_memory_type():
>>>>>>>>
>>>>>>>> struct memory_dev_type *alloc_memory_type(int adistance)
>>>>>>>>
>>>>>>>> Instead alloc_memory_type() should be taking bandwidth/latency numbers
>>>>>>>> and the calculation of abstract distance should be done there. That
>>>>>>>> resovles the issues about how drivers are supposed to devine adistance
>>>>>>>> and also means that when CDAT is added we don't have to duplicate the
>>>>>>>> calculation code.
>>>>>>>
>>>>>>> In the current design, the abstract distance is the key concept of
>>>>>>> memory types and memory tiers.  And it is used as interface to allocate
>>>>>>> memory types.  This provides more flexibility than some other interfaces
>>>>>>> (e.g. read/write bandwidth/latency).  For example, in current
>>>>>>> dax/kmem.c, if HMAT isn't available in the system, the default abstract
>>>>>>> distance: MEMTIER_DEFAULT_DAX_ADISTANCE is used.  This is still useful
>>>>>>> to support some systems now.  On a system without HMAT/CDAT, it's
>>>>>>> possible to calculate abstract distance from ACPI SLIT, although this is
>>>>>>> quite limited.  I'm not sure whether all systems will provide read/write
>>>>>>> bandwith/latency data for all memory devices.
>>>>>>>
>>>>>>> HMAT and CDAT or some other mechanisms may provide the read/write
>>>>>>> bandwidth/latency data to be used to calculate abstract distance.  For
>>>>>>> them, we can provide a shared implementation in mm/memory-tiers.c to map
>>>>>>> from read/write bandwith/latency to the abstract distance.  Can this
>>>>>>> solve your concerns about the consistency among algorithms?  If so, we
>>>>>>> can do that when we add the second algorithm that needs that.
>>>>>>
>>>>>> I guess it would address my concerns if we did that now. I don't see why
>>>>>> we need to wait for a second implementation for that though - the whole
>>>>>> series seems to be built around adding a framework for supporting
>>>>>> multiple algorithms even though only one exists. So I think we should
>>>>>> support that fully, or simplfy the whole thing and just assume the only
>>>>>> thing that exists is HMAT and get rid of the general interface until a
>>>>>> second algorithm comes along.
>>>>>
>>>>> We will need a general interface even for one algorithm implementation.
>>>>> Because it's not good to make a dax subsystem driver (dax/kmem) to
>>>>> depend on a ACPI subsystem driver (acpi/hmat).  We need some general
>>>>> interface at subsystem level (memory tier here) between them.
>>>>
>>>> I don't understand this argument. For a single algorithm it would be
>>>> simpler to just define acpi_hmat_calculate_adistance() and a static
>>>> inline version of it that returns -ENOENT when !CONFIG_ACPI than adding
>>>> a layer of indirection through notifier blocks. That breaks any
>>>> dependency on ACPI and there's plenty of precedent for this approach in
>>>> the kernel already.
>>>
>>> ACPI is a subsystem, so it's OK for dax/kmem to depends on CONFIG_ACPI.
>>> But HMAT is a driver of ACPI subsystem (controlled via
>>> CONFIG_ACPI_HMAT).  It's not good for a driver of DAX subsystem
>>> (dax/kmem) to depend on a *driver* of ACPI subsystem.
>>>
>>> Yes.  Technically, there's no hard wall to prevent this.  But I think
>>> that a good design should make drivers depends on subsystems or drivers
>>> of the same subsystem, NOT drivers of other subsystems.
>>
>> Thanks, I wasn't really thinking of HMAT as an ACPI driver. I understand
>> where you're coming from but I really don't see the problem with using a
>> static inline. It doesn't create dependencies (you could still use
>> dax/kmem without ACPI) and results in smaller and easier to follow code.
>>
>> IMHO it's far more obvious that a call to acpi_hmat_calcaulte_adist()
>> returns either a default if ACPI HMAT isn't configured or a calculated
>> value than it is to figure out what notifiers may or may not be
>> registered at runtime and what priority they may be called in from
>> mt_calc_adistance().
>>
>> It appears you think that is a bad design, but I don't understand
>> why. What does this approach give us that a simpler approach wouldn't?
>
> Think about all these again.  Finally I admit you are right.  The
> general interface is better mainly if there are multiple implementations
> of the interface.
>
> In this series, we provide just one implementation: HMAT.  And, the
> second one: CDAT will be implemented soon.  And, CDAT will use the same
> method to translate from read/write bandwidth/latency to adistance.  So,
> I suggest to:
>
> - Keep the general interface (and notifier chain), for HMAT and soon
>   available CDAT
>
> - Move the code to translate from read/write bandwidth/latency to
>   adistance to memory-tiers.c.  Which is used by HMAT now and will be
>   used by CDAT soon.  And it can be used by other drivers.
>
> What do you think about that?

That sounds great. I had kinda assumed CDAT was around the corner, and
was "the other driver" I was thinking of hence the suggestion to make it
a bit more general (or alternatively ignore that and make it specific,
but you've already done the work to make it general so happy to keep
it).

BTW for what it's worth I still think it might be best to have the
notifiers return bandwidth/latency numbers. In practice though that
would actually make my life harder so I'm happy to see where the above
takes us.
