Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFE07D607D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 05:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbjJYDV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 23:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjJYDVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 23:21:54 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4C4E5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 20:21:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ar0MzkiCS22dbmtgxu0Avsv/cTSCCVZbjfQFqsJX15HMwjeCqrLqrJhGum7wZTivbhM08A7tInUH1QmNPjUr+sH/R4xVfzNoUTMKpFooq95Kd4LmmQEb86rz8D36qYkWH+PVv4izzRhWhLFN89ZNGFC+KNCEcSyLPg+PVyZ0AjpMD4k/B/8A1EZfL0ymdE0M6N13nU31fG+ASZL0i0rmFS3sx+7K3PwbmmxuSlVtNDcIo5ac3u58z5iUlPiILoKJTeHcjuzWcAFq0+XvvDailw8TiEtGCKDTk7rdRtnJKk4X+U5xGqAkseQLIWh3dHmpcrASlCTgEyjk2750FjRtbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YF3gw9W1FPoX+74v0AGt7yBEPQmP+38OItIO18CU7rU=;
 b=LxoeJAPmaNdWvQPfWasr6GnlO5CCvd8xeWj4GqXm3W02kHUlAhY7qsnhzrKa9tvFfvVoA8r4Y6kJGhtIqyZx9dRz3r5FwAkyOzEydIV4qGTF+bpa3hvnC0697Q6v0xPXYPiPWVO6IBywVCqh6a5mo2o1xc0ZulnXWk0X9T2k2Ts6Yl0Z86USOAUM7hb6xjn0f6j3aCCu3QcRN9KyxjuZmADqXJrK6eBHgs7c9hH/ztUBTKJf1bU4DRrEzh9AX9WvdUgjJ/3gpBxa03+zSZDGbYhUlT7DAQbh/5aX8W0WZ0vs6xdvz4FHXxgHNC8+Pphx6d18mJVdJ41uWW36XyXBTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YF3gw9W1FPoX+74v0AGt7yBEPQmP+38OItIO18CU7rU=;
 b=EOzWorcHv5rfZsG50tp8sH5S4iqD1St4JpQym8kblQzBZMfr6137GENxn2N95QuyYrnw10FFylJVG6pFz05EQL7K9kk6mOY8ShnZxfTy99aFzj70HwMq9NYjDC0smZW5qdI8G04d9CXvppgK10rA+TsaiYuvbUTvCqcIZOMhUFwFSfd2/J9Upowf2t2DttphBO49buQd9PwccpbFXW/vW5YH1a6SRO0QIExtRpJHNNWRUKVYUVEqM1As5Crx2SYwcK03hKRNTJsj1ZssPG6RYknncHj6tza5bbEiplCbAYFBkGgIx4chDQijkCFHs1CGOtUuLErojBCDaymKNtjinQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by CH0PR12MB8531.namprd12.prod.outlook.com (2603:10b6:610:181::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Wed, 25 Oct
 2023 03:21:49 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::d504:dd12:5218:c5d]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::d504:dd12:5218:c5d%4]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 03:21:48 +0000
References: <ae3115778a3fa10ec77152e18beed54fafe0f6e7.1698151516.git.baolin.wang@linux.alibaba.com>
 <CAGsJ_4zgdAmyU-075jd8KfXn=CdAVC8Rs481sCOd5N2a68yPUg@mail.gmail.com>
 <CAGsJ_4z1u4-_JXUM9GG2cqc4Nwrx1v69uHsbff5jDQZHQgWP+w@mail.gmail.com>
 <87y1frqz2u.fsf@nvdebian.thelocal>
 <CAGsJ_4wFiz-obaoXqfU9p-YqgFwExyXpGjpDKMOUt7mnenD-ew@mail.gmail.com>
 <87ttqfqw8f.fsf@nvdebian.thelocal>
 <d2d8062c-8248-b710-ccd6-e5359d15c385@linux.alibaba.com>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Barry Song <21cnbao@gmail.com>, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org, v-songbaohua@oppo.com,
        yuzhao@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: mm: drop tlb flush operation when clearing the
 access bit
Date:   Wed, 25 Oct 2023 14:09:36 +1100
In-reply-to: <d2d8062c-8248-b710-ccd6-e5359d15c385@linux.alibaba.com>
Message-ID: <87bkcn1j5k.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SYBPR01CA0012.ausprd01.prod.outlook.com (2603:10c6:10::24)
 To BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|CH0PR12MB8531:EE_
X-MS-Office365-Filtering-Correlation-Id: 926ed73a-4c77-4896-4dc8-08dbd5098626
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Py9WFq0wH983DKPbEe5YB69q+1b37RyE+HvsuIZFUDZ8Z8ScIh4a1klECN3IfmWGuD6gk/I9wazEnhdXRMcHUjnEUfn3GH/LZddht/RcXMtMDbJcm8D3g/qScHhqk/19JqAaOMHsPUXa3ZsXJaAxJsPcbIPqsihvruceZDUJAvVxrj8RDuGQrUe+GB2m4qj9XFoB3uaq8qwxEpPew9gFzmoPdAb4kSW8c12+WNe0mNTCnlH9ntXN56AczlGVMIpuiGQOI9BsaaGYHRfxeL7YS7B0LWqkgCfs9TyZ1MCKx8Mrnp+QGv6ALvlpfblS5nwpJAW1Ei1zuX5gGijRU5x0bm3MyApUH6W1HT3/j32+9GoSfQ4JX6eNCJqqUPyKlZ4pPlCwBQlHcM6xYxQzFQbeCM2vebSy3hvCgkbGMGEzFELF4oyAN7UV/piFYZxQGsPm50a6wS4fWvLdqKRfd305o6zCAF7Hn+RsU2z6fs77FSgJMec0m4n7wUidGGJ4L5JqwECPOrHUtZcOOhvanZKdHR5XHiQv89lLx/49h1baPBqsGph4uE333xCC7d5Cf5WXNgEMHa1Tk50bW5wVTE+QL7gxji8YOs4/Cz0zlmKT8RQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(366004)(396003)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(7416002)(83380400001)(66899024)(8936002)(53546011)(2906002)(38100700002)(4326008)(26005)(8676002)(86362001)(9686003)(6512007)(6506007)(6916009)(316002)(478600001)(966005)(6666004)(5660300002)(6486002)(66476007)(66556008)(41300700001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3RJaDJoYnVjc21ZYTVNS0VERkpZeThza0IraVR6Y09idndMVzFqdnRXNFZF?=
 =?utf-8?B?dzF5dFlzeng1a1R4ZGR5Vy9vSGNNdnNnTnRza25xVjNkTVpBSTBXSzE2Mm5W?=
 =?utf-8?B?akI5M2RHTmFEOUE0OFI0T29va1Y5WTkrZkpkS0tkMGxCSERvUjVvL2VGSDd1?=
 =?utf-8?B?RFRJcU5XWXI3VTN6RmhJdng0Mjh2enlsSWk2U3FGUzlubmtvS3pPekoyeWtM?=
 =?utf-8?B?T1dGL3U0SE9xN2RiOE5sS2htNDh3Z0hqajhRVXJFMDRLV05rSjNucnR1UFUv?=
 =?utf-8?B?QTdGd3JCK0pBZEZXcHJqckF5R3g5bzV5UXo5cUhsVUNnTldhbTlDK1NGa1dl?=
 =?utf-8?B?VmxXdlVqWUdRajBDS1pnL2hEdFYwK3JEOFlHd1hkd3lLc1RYa3RPRmhMRnZx?=
 =?utf-8?B?OGpBaFI1TkhQNU5xejhrSjdPUkNmOUFuMFQzZmtheHkzTzlxaEwzaU1XejNk?=
 =?utf-8?B?djAwUzkwQjRqOFlQUzRoRFRjK3h5YUpNRGx4bXcydzFCRzZZSHZHYlNsVnAy?=
 =?utf-8?B?ZUxUbWVKVjY4Vm1VSW4vMjNBVW1uR1J1S1hhcGVrOGhkTGRkeTRwZ2pENkRE?=
 =?utf-8?B?MEphQ3dzektCVXptQ0p5TnZ2STRZWTA2cVhYbGhLcHdFOVVGOHZpcThqdFNs?=
 =?utf-8?B?Q2lwZnRBODBRZlRwbWkwYWpleFBkZmhIZXljMUZUOWtEMkFPemhMMTFMaW1I?=
 =?utf-8?B?Rm1nbUVjdE9wWkpYMHdXZUxBZUxiNVQxbVU2azQxcXpLSTlWbkdTQjZ1SmZC?=
 =?utf-8?B?bUFVN2JiRUFOSXhRaHk0dFcydVdGcjJOajNzcVJkLzVZaXF2dlZ0OHVHUS9L?=
 =?utf-8?B?d2ZKVW1ENHhGQkZ2MWRjQjJKSlFJbGJqUjZvRjJiNHZvNjdxOEpld2d3T1h6?=
 =?utf-8?B?S05SdTJDOEhsM2RQUTJmb1NOU0E0WVJPRFI2djgyWXB6S1llNVZoRm5OcDN2?=
 =?utf-8?B?UDQvdGJqKzNxOUw4SUNFbmdnc2NHZS8rc1I1TC96TTdZZjRXc3d2S2phdjQy?=
 =?utf-8?B?ZmZOVmZsSVgzUFV5Q01adFRRZHRRNTh1cTY0VUY1NFc4T3BqZlFmZ20yVVpm?=
 =?utf-8?B?Z3NHbVVGZjJidUw2WXN2OEM0eWU0U3NGelJEaXIrWHo2dTk5WDhWSGxYVUJG?=
 =?utf-8?B?SkhxZi82QXRzSUl0OGZRb1J6bjg5dmh2QmdOd1RDTGx0MkFHUnJGWHI0b3dS?=
 =?utf-8?B?bFpSazRKZlN2cDN6UEZZS1ZaSTd3UmNFTSs3VEJ0YVZRYkRDWS9CSzJvOE1B?=
 =?utf-8?B?cmxCdWhpNFV0dGxuME1NTjN6ZExoQzl4ZlAvWDNnY1ZXczJYSVlJcWZnUDFr?=
 =?utf-8?B?bytzeXhLZ1pQOGpNTE4zV1JiSXdWcU5PWEduK3FyalZlVjB3MDdBN2pwbjZj?=
 =?utf-8?B?cUlIbi9UOGtMcnlPaGYrS3hvdFJhd3krekdXV0szZHVjSFRORThRZTNsKzZx?=
 =?utf-8?B?TWlPT0NDMU03RzJwcmZVOG9pdHZ2SGF4cXJCSEVyRmI1Y0Fwd3lHOUFXZGsv?=
 =?utf-8?B?TVpIYkZxUEZ1OXFtWm5CR3VXMXVzRjZrUTcrQkQyNG1tRk9RdzJycjVkb0V5?=
 =?utf-8?B?MC9HVXJtZXIyUDR0Q2d1b043ZUdVTTUySFFRZ0xaQnQvODh4cWREd2Q0YVRr?=
 =?utf-8?B?T3lMVVlQdzl3OVBvdHpjdjY0RG42MlJFQ2FETkN6cGNGUVk5TWhmK2k1cU5s?=
 =?utf-8?B?SWpFZDg4ZFdabUhaL1RKWXZ4dlJOYjhMYTV6ZHU5QVpVNTNSVEhVVEtMaEQ0?=
 =?utf-8?B?MlMxazhVbGVQYmhYdFpUYzFVclVPemU4K1RTY041VC9venVWQnpVSUg3UXBl?=
 =?utf-8?B?L1I2S3J4TEVKRjVFSmhLc2N6dkQ2N0hVMmMwN2o2NnVLMnZLNzhEYzJtNkhT?=
 =?utf-8?B?c3pFVjN1WWJPMlZ0NHV0SUVoRVhycGQvV3RVS1FJSXo5akgyN0lCWU51NGlI?=
 =?utf-8?B?WUNJaTNpSS9aZjlQTGxzZ1dpSFpQaXY0dUhGTlNaMnE5UnRINit6bGZKZUwz?=
 =?utf-8?B?bWRoQzk3dDI3N1lRYnBLVUtGQ25pQXk3MjBadWpqMG92S0RoZ0x1KzA0aHZo?=
 =?utf-8?B?YnNTVjNpSWlDMFBXK1pldHlRNG1zeC9NeW9BNFY3WnpPcVloVHkwUTRsNDhI?=
 =?utf-8?Q?ddbmGdpxSO6eLcfahQfrpAvY8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 926ed73a-4c77-4896-4dc8-08dbd5098626
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 03:21:48.6567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qo5TcgVpY8XsUj8MR70gl35X7O/vGwo08xiFvigymitrVnM6Lftmz5fQSWcTbIygz4CpqopByNNNM9fbklGB5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8531
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> On 10/25/2023 9:58 AM, Alistair Popple wrote:
>> Barry Song <21cnbao@gmail.com> writes:
>>=20
>>> On Wed, Oct 25, 2023 at 9:18=E2=80=AFAM Alistair Popple <apopple@nvidia=
.com> wrote:
>>>>
>>>>
>>>> Barry Song <21cnbao@gmail.com> writes:
>>>>
>>>>> On Wed, Oct 25, 2023 at 7:16=E2=80=AFAM Barry Song <21cnbao@gmail.com=
> wrote:
>>>>>>
>>>>>> On Tue, Oct 24, 2023 at 8:57=E2=80=AFPM Baolin Wang
>>>>>> <baolin.wang@linux.alibaba.com> wrote:
>> [...]
>>=20
>>>>>> (A). Constant flush cost vs. (B). very very occasional reclaimed hot
>>>>>> page,  B might
>>>>>> be a correct choice.
>>>>>
>>>>> Plus, I doubt B is really going to happen. as after a page is promote=
d to
>>>>> the head of lru list or new generation, it needs a long time to slide=
 back
>>>>> to the inactive list tail or to the candidate generation of mglru. th=
e time
>>>>> should have been large enough for tlb to be flushed. If the page is r=
eally
>>>>> hot, the hardware will get second, third, fourth etc opportunity to s=
et an
>>>>> access flag in the long time in which the page is re-moved to the tai=
l
>>>>> as the page can be accessed multiple times if it is really hot.
>>>>
>>>> This might not be true if you have external hardware sharing the page
>>>> tables with software through either HMM or hardware supported ATS
>>>> though.
>>>>
>>>> In those cases I think it's much more likely hardware can still be
>>>> accessing the page even after a context switch on the CPU say. So thos=
e
>>>> pages will tend to get reclaimed even though hardware is still activel=
y
>>>> using them which would be quite expensive and I guess could lead to
>>>> thrashing as each page is reclaimed and then immediately faulted back
>>>> in.
>
> That's possible, but the chance should be relatively low. At least on
> x86, I have not heard of this issue.

Personally I've never seen any x86 system that shares page tables with
external devices, other than with HMM. More on that below.

>>> i am not quite sure i got your point. has the external hardware sharing=
 cpu's
>>> pagetable the ability to set access flag in page table entries by
>>> itself? if yes,
>>> I don't see how our approach will hurt as folio_referenced can notify t=
he
>>> hardware driver and the driver can flush its own tlb. If no, i don't se=
e
>>> either as the external hardware can't set access flags, that means we
>>> have ignored its reference and only knows cpu's access even in the curr=
ent
>>> mainline code. so we are not getting worse.
>>>
>>> so the external hardware can also see cpu's TLB? or cpu's tlb flush can
>>> also broadcast to external hardware, then external hardware sees the
>>> cleared access flag, thus, it can set access flag in page table when th=
e
>>> hardware access it?  If this is the case, I feel what you said is true.
>> Perhaps it would help if I gave a concrete example. Take for example
>> the
>> ARM SMMU. It has it's own TLB. Invalidating this TLB is done in one of
>> two ways depending on the specific HW implementation.
>> If broadcast TLB maintenance (BTM) is supported it will snoop CPU
>> TLB
>> invalidations. If BTM is not supported it relies on SW to explicitly
>> forward TLB invalidations via MMU notifiers.
>
> On our ARM64 hardware, we rely on BTM to maintain TLB coherency.

Lucky you :-)

ARM64 SMMU architecture specification supports the possibilty of both,
as does the driver. Not that I think whether or not BTM is supported has
much relevance to this issue.

>> Now consider the case where some external device is accessing mappings
>> via the SMMU. The access flag will be cached in the SMMU TLB. If we
>> clear the access flag without a TLB invalidate the access flag in the
>> CPU page table will not get updated because it's already set in the SMMU
>> TLB.
>> As an aside access flag updates happen in one of two ways. If the
>> SMMU
>> HW supports hardware translation table updates (HTTU) then hardware will
>> manage updating access/dirty flags as required. If this is not supported
>> then SW is relied on to update these flags which in practice means
>> taking a minor fault. But I don't think that is relevant here - in
>> either case without a TLB invalidate neither of those things will
>> happen.
>> I suppose drivers could implement the clear_flush_young() MMU
>> notifier
>> callback (none do at the moment AFAICT) but then won't that just lead to
>> the opposite problem - that every page ever used by an external device
>> remains active and unavailable for reclaim because the access flag never
>> gets cleared? I suppose they could do the flush then which would ensure
>
> Yes, I think so too. The reason there is currently no problem, perhaps
> I think, there are no actual use cases at the moment? At least on our
> Alibaba's fleet, SMMU and MMU do not share page tables now.

We have systems that do. Also HMM (used by Nouveau and AMD among others)
is a SW implementation of page table sharing and would suffer similar
issues. That said if the flush is already being skipped on x86 then it's
already an issue for HMM. HMM based drivers can at least deal with this
by implementing the clear_flush_young() notifier though. The same
doesn't apply to eg. the SMMU driver.

>> the page is marked inactive if it's not referenced between the two
>> folio_referenced calls().
>> But that requires changes to those drivers. SMMU from memory doesn't
>> even register for notifiers if BTM is supported.
>>   - Alistair
>>=20
>>>>
>>>> Of course TLB flushes are equally (perhaps even more) expensive for th=
is
>>>> kind of external HW so reducing them would still be beneficial. I wond=
er
>>>> if there's some way they could be deferred until the page is moved to
>>>> the inactive list say?
>>>>
>>>>>>
>>>>>>> [1] https://lore.kernel.org/lkml/20220617070555.344368-1-21cnbao@gm=
ail.com/
>>>>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>>>> ---
>>>>>>>   arch/arm64/include/asm/pgtable.h | 31 ++++++++++++++++-----------=
----
>>>>>>>   1 file changed, 16 insertions(+), 15 deletions(-)
>>>>>>>
>>>>>>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/=
asm/pgtable.h
>>>>>>> index 0bd18de9fd97..2979d796ba9d 100644
>>>>>>> --- a/arch/arm64/include/asm/pgtable.h
>>>>>>> +++ b/arch/arm64/include/asm/pgtable.h
>>>>>>> @@ -905,21 +905,22 @@ static inline int ptep_test_and_clear_young(s=
truct vm_area_struct *vma,
>>>>>>>   static inline int ptep_clear_flush_young(struct vm_area_struct *v=
ma,
>>>>>>>                                           unsigned long address, pt=
e_t *ptep)
>>>>>>>   {
>>>>>>> -       int young =3D ptep_test_and_clear_young(vma, address, ptep)=
;
>>>>>>> -
>>>>>>> -       if (young) {
>>>>>>> -               /*
>>>>>>> -                * We can elide the trailing DSB here since the wor=
st that can
>>>>>>> -                * happen is that a CPU continues to use the young =
entry in its
>>>>>>> -                * TLB and we mistakenly reclaim the associated pag=
e. The
>>>>>>> -                * window for such an event is bounded by the next
>>>>>>> -                * context-switch, which provides a DSB to complete=
 the TLB
>>>>>>> -                * invalidation.
>>>>>>> -                */
>>>>>>> -               flush_tlb_page_nosync(vma, address);
>>>>>>> -       }
>>>>>>> -
>>>>>>> -       return young;
>>>>>>> +       /*
>>>>>>> +        * This comment is borrowed from x86, but applies equally t=
o ARM64:
>>>>>>> +        *
>>>>>>> +        * Clearing the accessed bit without a TLB flush doesn't ca=
use
>>>>>>> +        * data corruption. [ It could cause incorrect page aging a=
nd
>>>>>>> +        * the (mistaken) reclaim of hot pages, but the chance of t=
hat
>>>>>>> +        * should be relatively low. ]
>>>>>>> +        *
>>>>>>> +        * So as a performance optimization don't flush the TLB whe=
n
>>>>>>> +        * clearing the accessed bit, it will eventually be flushed=
 by
>>>>>>> +        * a context switch or a VM operation anyway. [ In the rare
>>>>>>> +        * event of it not getting flushed for a long time the dela=
y
>>>>>>> +        * shouldn't really matter because there's no real memory
>>>>>>> +        * pressure for swapout to react to. ]
>>>>>>> +        */
>>>>>>> +       return ptep_test_and_clear_young(vma, address, ptep);
>>>>>>>   }
>>>>>>>
>>>>>>>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>>>>> --
>>>>>>> 2.39.3
>>>>>>>
>>>>>>
>>>>>> Thanks
>>>>>> Barry
>>>>
>>> Thanks
>>> Barry

