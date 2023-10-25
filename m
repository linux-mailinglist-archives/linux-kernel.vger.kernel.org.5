Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6255D7D7911
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 02:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjJZAID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 20:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjJZAIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 20:08:00 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F7FDC
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 17:07:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtSi98FkMH6tpfQ6yvqWAsD7JNhcDX+QPm1WTTwJNhvnPvL6u/mfkqHC/7OniII/j/pR76th6uqNNh+IB4P9vLJYE2rW3WQ5su8zgkURzpg88ebFUzE7XLIz20sG//7I4lBi8ZTJtERoAR7H39wiW36OC3OhW9SaixkTxeBZViS7IyyirOGHTuE6IliZGhz8wOSfbxSM1nzk8BB/Jd0AfvCJYM0hQynkLzL6WK2KN6bDTF1njDdDHB58pw9tlMLnrgqGGdt4/k2G2PF9BDWvAESNZJhLfVEaDisuvW6/w4Do3oscjUnfp1HL38iLU66WQq3LNjBhSWiSy6zbk3l9Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1x+ZWdCs931XuniPNAjc9G5e75ecb2ar0YDaARlVTCI=;
 b=AU8bsM8q6MTpdP3SKGEZOV8INA5VnfvWPq0hqa3FhpwEEW04HdsiHX+o4mJpLvuV+otpZcEQz8f9/pSQOfM9GyGBD5FXK77Hngip20F+58nOOcKiMJK9SP2x5oKo5arFCsNaeFPhYUctSEiAk6n/AlddR9dJ5tr9je7Dg1iqztFYyURKxVLV3dWlLa49KgGK9amxsmPd0icAhV3C+KLMxHw3yRB8GVfIB8bQIh9iK9K0H+8JlwPzVv1FkXONedI2+jmvurnsZ/754JcCFcK0YTDWVqn0NaXTI3KdHKhiNP7acgRB+JM2/FQmxEVQGi35z2pAXxYrtB+ji6DgRs2NpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1x+ZWdCs931XuniPNAjc9G5e75ecb2ar0YDaARlVTCI=;
 b=psjwt1mYa/jgOr/8IaIEeqnEce5zd4KewJBXbqlZ+Fn1PAxVldDtnB2PwCNIq9PoinHa8m7ceCTHSo7PfgoKz7IIhxPj+NvRoBF/muUHtlPTdvFqe+ijEpdV7fPnwpikldaRJMOhz8uVWY1trxTVRUvEyrAxq7N7DVEAO96BogymFox3lhpUAtTc8sfwUeSfLNQFj7N4WPtyupInhX+ZLfXa0Qkl33cqNqSQvIGELH3JODO6gf1JIBclOa917fOc3sEKG2DbKLsZKu+v61cQYqhUGIwSN+h9QMataURTvBuwQAssu0jhftYLXvqS90QAoJFiLX39UE6Hv98ZTLEuYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DM6PR12MB4449.namprd12.prod.outlook.com (2603:10b6:5:2a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 00:07:55 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::d504:dd12:5218:c5d]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::d504:dd12:5218:c5d%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 00:07:55 +0000
References: <ae3115778a3fa10ec77152e18beed54fafe0f6e7.1698151516.git.baolin.wang@linux.alibaba.com>
 <CAGsJ_4zgdAmyU-075jd8KfXn=CdAVC8Rs481sCOd5N2a68yPUg@mail.gmail.com>
 <CAGsJ_4z1u4-_JXUM9GG2cqc4Nwrx1v69uHsbff5jDQZHQgWP+w@mail.gmail.com>
 <87y1frqz2u.fsf@nvdebian.thelocal>
 <CAGsJ_4wFiz-obaoXqfU9p-YqgFwExyXpGjpDKMOUt7mnenD-ew@mail.gmail.com>
 <87ttqfqw8f.fsf@nvdebian.thelocal>
 <d2d8062c-8248-b710-ccd6-e5359d15c385@linux.alibaba.com>
 <87bkcn1j5k.fsf@nvdebian.thelocal>
 <CAOUHufZ84aDmiW3Efh87q1oMJr-zk5cyaebucCFzevFHx77ngQ@mail.gmail.com>
 <CAGsJ_4zueK32KMHM0=EYjB3spYvh-yJU=buorG+6+Stnu=cypw@mail.gmail.com>
 <877cnb0zyk.fsf@nvdebian.thelocal>
 <CAOUHufbpyR_wFARsCZ-wVqN0w3ieW2RVfVaJkbikY_O8WGwF1g@mail.gmail.com>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Barry Song <21cnbao@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, v-songbaohua@oppo.com,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: mm: drop tlb flush operation when clearing the
 access bit
Date:   Thu, 26 Oct 2023 10:32:28 +1100
In-reply-to: <CAOUHufbpyR_wFARsCZ-wVqN0w3ieW2RVfVaJkbikY_O8WGwF1g@mail.gmail.com>
Message-ID: <8734xy1c14.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SY5P300CA0043.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fd::16) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|DM6PR12MB4449:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d4dcf1c-e6c7-4a00-ad2e-08dbd5b79a5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YabicRyoy3qHQLWEUZBvMZSSq2xZk+pDsA28xHYm2Unlsz9dKoi6GTbTPsODarmay2JPvYYjgqz2jMeXWF25CHDbxgxnfdNsN6Jmk6Y4fhXMKvQ8/9FbAPaChSsVyAqKI2buR61wWd9IJQ+Fsr3OAA7PQgPTjsudQrC1g/LZ36JiDOvI9XjCysZ9HjBhmZ9n8OXi2Gic5PuTkU4qMkdNLDHgFyH2dDwrLkVjBfCBSoz4TQxuX2GGGpi6RVNgVm8p32dbrQnbTywfYTvnU4Z/YTJ070Pt/nDnhK/UlccMkQXcEmf5ztiK2gREzFNpqmHxHZk1z+1stRI/0cVURVpjh1d/QrEyztdWYo1LnsbZ/6Sg2p5OE5cGRY0enfaY28nl3wBDlkQMogN+vfBq0aDc8PqZn7TajptVS5j5CgxX1Dx9ThqTMPsQ1iKdUP7BJ+jUEMzwUdDev0iF+rTmoD1jXaZj43nUI8lJBVN5tPABg/w2ulp2lmRYoyHujwC67jUNC5Ou4duA/Y3LX8szW6oB3EUP2kFf6oN6ZCVFKMbjqbBxlTX4SYhwj+ip6/7guez9PHmGQl/HgWbJTto9Hp7X/LmgtElkE14PNOBK6LypxiY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(346002)(136003)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(7416002)(83380400001)(54906003)(5660300002)(6666004)(66476007)(66946007)(41300700001)(86362001)(66556008)(478600001)(9686003)(6916009)(6506007)(6512007)(316002)(6486002)(966005)(2906002)(4326008)(8676002)(53546011)(38100700002)(26005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDlTSTFtMTJLMVlYa29QS2NuR2R4cmJ4OFJ3dXV2bEpueSttK25DTHYzbEpp?=
 =?utf-8?B?MFpsZk9qdU9XQlpCc2UyUVdrOE0zT0p5Tk90RWljZmIyOWM4SXg0TDgwQkR1?=
 =?utf-8?B?eXgzZENzN3VGSFlEZlNJdHVWNVcwZTZ5TGJYVm9NVXdXeitIdE5QZ0J5MXY3?=
 =?utf-8?B?aTdBT0lEbWtXcFV4akUxNDdDbG5iWU1MTnlZVWo4QjlXOVN6N2RnQy9jbXpI?=
 =?utf-8?B?azV4MEdTL09vaVNLQ2Q1N0pWNmxnL0VYSFlBMEtncitkTjNxaE55TC9iNThl?=
 =?utf-8?B?MXlzaWZNMU9mUitZRnhlSFhXMGRzeVViTU43UzQ3L2RsTDRqRHNxV2VpOVhM?=
 =?utf-8?B?UFlaV1dPb2ZSTDVxaWhVNGF1SUZCcHpUdXAya1ZNbXZxZHQ2UVpZSFgxS1V6?=
 =?utf-8?B?dXhyZU1laUdTeXVCbDM5ak5HZ2U0SUY2MWQ5b3VVYnl5czdJYmxzZWJQRE5s?=
 =?utf-8?B?bEwzVXc2YVBmTTZFVUpNbHZqdUk3S0ZtNGlKSlJTNThYUWhZSGRMdDRQeElG?=
 =?utf-8?B?VWhBZ3lvaWRyL1A1bVBSN2thSDA5aEVGRzRxS1FjMWFlMGJpQnBpVHJzQk9u?=
 =?utf-8?B?RHFFYTRDMVUvRFFDZDdsallzZ1FXS1FiVmQ0V2ZMSVRlZ20yMytaZFBMY01w?=
 =?utf-8?B?d09OUy9hK1hWMTdKSXF2OGZNVmlick5tc1hqU1QzK2xkc0k4ai9RL1RNWGIz?=
 =?utf-8?B?d0dETW5NQlQyVDhZbXRuaWJRZktlOEtvVlFSYUo0d0ZRN1Vqdmh1bmR3T2dS?=
 =?utf-8?B?cUFwUVplTDJTMVpvcjVKdTV2RElQZzJxdFBCRzJJa3A1RHIyS3JETE9Cb2c0?=
 =?utf-8?B?RnArQVNaNGlBejYxOEgvS3B6RGFzRnJLQlZ0Q1BMdlQ3UWowVm5MY0o1K2ZX?=
 =?utf-8?B?Y3FnckRReWkya3RzOVc3TmtlMWRxOTg3OHdNU1JNVkkwa1FqSHlFT2lRZlBD?=
 =?utf-8?B?ckcrMm1qMnRzblRFRVptc3R2YnRZc3VqMUJ3NWJCWk5WMVNCdm1hQ0tOVnZS?=
 =?utf-8?B?OXNJY0NmN09jM0pOVGlMRjNKcnRYS1VWSEh0TWJwMjR3T25LOXlIU0RFSWJP?=
 =?utf-8?B?YTAzTGcyWHpUZGNxUUlhWGdqb1c5MzFRRlY2eGgxeGw4dFdxUG16QURUMW03?=
 =?utf-8?B?VkVyd0JwYjRPdDFFdmpwb2RsMVEyTkVwOUlVemQvUEd1blBkdzRnZ3JwNEZi?=
 =?utf-8?B?TTFFOHZvM01IZlBSWnllMlRhTFpxSk9ld3d3Tk1mMlkzaUQ5NmtueXN6d3RH?=
 =?utf-8?B?ckVpUFZvcU81eTArZXZOcHFZOG9BWmVrVC9heXV6NElaU3grK0Nwc3J3MjQz?=
 =?utf-8?B?empnbmwwbVc4UmkxajIzc1J4SEIzQVkwSUNKaXdiUkRPK2VkMm1jZy9EQ1Nh?=
 =?utf-8?B?SHVUdXVxRUVQeHVMcGRXSnY2ZWJwOUdielM4OENocUhGbjQ5OGFJalA3TEVY?=
 =?utf-8?B?Yk53bkxYZVdsUUU5TnhsZGsxUkJ5SEdMRzA5d2xyMTdJMzZac1VUUWwvNXNU?=
 =?utf-8?B?bFdEd0Q1NFEwUU9pUXlRLy90eDZBM0tMWXNoWmdEdDlWWkp6eE1sZkMxQ2dO?=
 =?utf-8?B?Z1V2cm8yTTBKaUJuaTYzY1pIWVY3TFM2ZHphb0YvTUNRMDRDeGNzejJubytu?=
 =?utf-8?B?eWxjWWRObU5MN2lreUxMd2o1WGNXRXM4QXJoOXR1Z25kaUNpd1RERytSRFZM?=
 =?utf-8?B?YVZlUkhWa1lGQzl6L0NNOG9VVmZ3ZzlqRS9uWmpRVHZ2d1dzQzVTNjF1eGYy?=
 =?utf-8?B?aVhqTTVkMmRzY1FFTXo2T1NPcWNJV283ZUJ1UTFyV3k3ME5IUGppM242NnFF?=
 =?utf-8?B?OTdSK25XYkV6ZjlRdXpEWnVqSVVxOWZURG5TUVk2cWNETkxsbFAwY3RWNFZP?=
 =?utf-8?B?UlBMaVdVSFpaWGorNS90SjZ4T1QvYzFVYllBMEloMmtkc01obTVBNzdhaGFl?=
 =?utf-8?B?SWZwV1dIVGNVaEhQNkVKZWxVUngwaTIxelVYcFkwVk94Rk8vaHU0bUgrT1Vq?=
 =?utf-8?B?RUFvQ1cwOUZyUkFzR2gvK3ZxVCtaOFdqQm83ZHZ1dEtvcmh6SGhuMExpQmQv?=
 =?utf-8?B?VFBUM09Vakcza0ttT0lMdHNlaC82Zm5Ebko5d3drdzQ0TVJSRjdyNUMyZGNV?=
 =?utf-8?Q?Tgb+99m4dokK1VXdhNAHIRHvF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d4dcf1c-e6c7-4a00-ad2e-08dbd5b79a5a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 00:07:55.0052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Y3p0xf6vo6BNnuJ1bJ4ORZDdPe2CWdV+bT+3fGtCxCokShj4FAM9GsingQ7tzoNTerHRZ+VVJsPMi7P/VMM6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4449
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Yu Zhao <yuzhao@google.com> writes:

> On Wed, Oct 25, 2023 at 4:16=E2=80=AFAM Alistair Popple <apopple@nvidia.c=
om> wrote:
>> >> > >> Now consider the case where some external device is accessing ma=
ppings
>> >> > >> via the SMMU. The access flag will be cached in the SMMU TLB. If=
 we
>> >> > >> clear the access flag without a TLB invalidate the access flag i=
n the
>> >> > >> CPU page table will not get updated because it's already set in =
the SMMU
>> >> > >> TLB.
>> >> > >> As an aside access flag updates happen in one of two ways. If th=
e
>> >> > >> SMMU
>> >> > >> HW supports hardware translation table updates (HTTU) then hardw=
are will
>> >> > >> manage updating access/dirty flags as required. If this is not s=
upported
>> >> > >> then SW is relied on to update these flags which in practice mea=
ns
>> >> > >> taking a minor fault. But I don't think that is relevant here - =
in
>> >> > >> either case without a TLB invalidate neither of those things wil=
l
>> >> > >> happen.
>> >> > >> I suppose drivers could implement the clear_flush_young() MMU
>> >> > >> notifier
>> >> > >> callback (none do at the moment AFAICT) but then won't that just=
 lead to
>> >> > >> the opposite problem - that every page ever used by an external =
device
>> >> > >> remains active and unavailable for reclaim because the access fl=
ag never
>> >> > >> gets cleared? I suppose they could do the flush then which would=
 ensure
>> >> > >
>> >> > > Yes, I think so too. The reason there is currently no problem, pe=
rhaps
>> >> > > I think, there are no actual use cases at the moment? At least on=
 our
>> >> > > Alibaba's fleet, SMMU and MMU do not share page tables now.
>> >> >
>> >> > We have systems that do.
>> >>
>> >> Just curious: do those systems run the Linux kernel? If so, are pages
>> >> shared with SMMU pinned? If not, then how are IO PFs handled after
>> >> pages are reclaimed?
>>
>> Yes, these systems all run Linux. Pages shared with SMMU aren't pinned
>> and fault handling works as Barry notes below - a driver is notified of
>> a fault and calls handle_mm_fault() in response.
>>
>> > it will call handle_mm_fault(vma, prm->addr, fault_flags, NULL); in
>> > I/O PF, so finally
>> > it runs the same codes to get page back just like CPU's PF.
>> >
>> > years ago, we recommended a pin solution, but obviously there were lot=
s of
>> > push backs:
>> > https://lore.kernel.org/linux-mm/1612685884-19514-1-git-send-email-wan=
gzhou1@hisilicon.com/
>>
>> Right. Having to pin pages defeats the whole point of having hardware
>> that can handle page faults.
>
> Thanks. How would a DMA transaction be retried after the kernel
> resolves an IO PF? I.e., does the h/w (PCIe spec, etc.) support auto
> retries or is the s/w responsible for doing so? At least when I worked
> on the PCI subsystem, I didn't know any device that was capable of
> doing auto retries. (Pasha and I will have a talk on IOMMU at the
> coming LPC, so this might be an interesting intersection between IOMMU
> and MM to discuss.)

Generally what happens if a device encounters a page fault is that it
notifies the kernel or driver (eg. via an interrupt) that it has
faulted. It is then up to SW to resolve the fault and tell HW to retry
the translation request once SW thinks the fault is resolved. I'm not
aware of HW that does automatic retries (although I'm a little unclear
what exactly is meant by automatic retry).

In the case of an IOMMU faulting (eg. SMMU on ARM) on a DMA access I
believe it stalls the transaction and SW is responsible for processing
the fault and signalling that the translation should be retried.

It's also possible for the device itself to detect a fault prior to
issuing a DMA request if it's using something like PCIe page request
services. Note my experience with this is more with non-PCIe devices
that are coherently attached, but the concepts are all much the same as
they all channel through the same IOMMU.

Unfortunately it doesn't look I will be at LPC this year otherwise it
would have been good to discuss. Happy to continue the discussion here
or via some other channel though. Hopefully I will be able to see your
talk online.
