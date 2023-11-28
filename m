Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271F47FB22D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 07:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343676AbjK1Gy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 01:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjK1Gy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 01:54:26 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2089.outbound.protection.outlook.com [40.107.212.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BFFE1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 22:54:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyy0g/aYrFjDd5wgJH6EgiG1gkItiQiWQ4b1sxmr/InRggmYJ4+oBSxdPKGCETH8zsaocArE6kBFWD0vSKMi72Dq/1jz1S+r6s0NsJfD3ggAqkOvNTnNObOjN82oTz/HMIlEuvezSoQh5ieHX68k2ahXtpzCTvcoW/SffDcYB6cpRx6++l3vQBBBYDORhPKr+sa2NJG0hAxe1w+CmmG9ZEMHNOXCB6FLWlUDoEn80puZWB3og29wqFJzWb1qUi19Ya2yVIui/Let//EWqJ4Wxe3fnPfh8zUFCSI0uYrefOIvKw2OBMfqZVUD6waIyOk5FanNd+ueaOSFFbuJ1qoZSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8hbEPe+RQAkKSVILFgS/n68QWYRkoMX1z5bi/znFg8=;
 b=QFTr1qirX+DcKt2V1kzXJWWZImckzFdYtoOY7ROQzRV6Lhdz+uxR6UuAA0pEsOMzJgKs40hzfLmAXUBbV2UTDQju0+iTioDeA0pbrrWDHuh+nXjlfJEYNcGtzDBAYgaQ+eXhbj+BXgzVoWszA8iRkbrhrIizaB8sjid7EyrEh3bh9XHJ61fpfcqL9t64BxWteoWVK/F+ocO1td4kmBQ2SZVwrawiXlrhj3oEMhPygJmkvR26pxfy11OYQNolJngOVNJrYBsmTY4LB24bjqLQKiU+peFgqy1ugaYBxkRNAPjLEmvoF0ORSNAP+R2k9620HXpD9lwd0FPl3lpUluK4uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8hbEPe+RQAkKSVILFgS/n68QWYRkoMX1z5bi/znFg8=;
 b=Fz5ZW8WRITwAyahICCwfoqy+R49cw9gzkztNFEZMXMsmd2ACvdPotMDn1Q1rZ43doKz3wS2BCGhrq5xah7hRcsu0oJYN0JwYcw7YjAn6fc9QWfljviUkXn6FiY7mf3SJPbo3hMWgK4bMYQloegLxnVNQf5dP3OQEwfg1lCBfy5jW9xVK7RFP3Fxi788fewBEP7ROCPHXsiqkhptPU2a8/+Gc/bxIpsJ6U2HJYfaUpe7SCIUvak9+AwJN4/1iPfASz2s8zDTSQF9mnON0G9uLzRABsCHpYNvvSzZMWFOds3kmHMreEdH6KO5ZytgKzv3C7t1jQ8ojfZ1FQNkjAzMpJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DS7PR12MB8202.namprd12.prod.outlook.com (2603:10b6:8:e1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 06:54:28 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::b8a:1b58:1edf:90e6]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::b8a:1b58:1edf:90e6%7]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 06:54:28 +0000
References: <20231115163018.1303287-1-ryan.roberts@arm.com>
 <20231115163018.1303287-15-ryan.roberts@arm.com>
 <87fs0xxd5g.fsf@nvdebian.thelocal>
 <3b4f6bff-6322-4394-9efb-9c3b9ef52010@arm.com>
 <87y1eovsn5.fsf@nvdebian.thelocal>
 <8fca9ed7-f916-4abe-8284-6e3c9fa33a8c@arm.com>
 <87wmu3pro8.fsf@nvdebian.thelocal>
 <26c78fee-4b7a-4d73-9f8b-2e25bbae20e8@arm.com>
User-agent: mu4e 1.8.13; emacs 29.1
From:   Alistair Popple <apopple@nvidia.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/14] arm64/mm: Add ptep_get_and_clear_full() to
 optimize process teardown
Date:   Tue, 28 Nov 2023 17:54:56 +1100
In-reply-to: <26c78fee-4b7a-4d73-9f8b-2e25bbae20e8@arm.com>
Message-ID: <87o7fepdun.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SYAPR01CA0045.ausprd01.prod.outlook.com (2603:10c6:1:1::33)
 To BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|DS7PR12MB8202:EE_
X-MS-Office365-Filtering-Correlation-Id: 1834ea56-0897-4c22-0527-08dbefdedd6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vLGaWG94z2QGmg5TSCg6jtIcE5V2pxfFge3KVeTC2lBXYytDKx4vZc1sBrteVPitVR7C54jQSaG2imYo1ig7ynQWZsxIZTHqJPmYWqtsfPcgOyMEHJzs9n+lc1cUMW26abIVmii1Ok3Djwih/S8oPAHR03+NPUuoamNcHO0Qfo+Ql925o/HQ3IpwDVSHaccB6AhbWBvxePYYllJryvFIlQIMQ80ewwYMYNjwfj4uPU8dJ9wVLL/c2cmOZLmEPaiS+qFljW1j7P6uuoTKUIbT3DwDhTHyyonkto/FpOxyKVozJ0RU3BucP2QadbarwAoQCMG4VuXpjx6eE2qRRVpP77cTSO8NtlUz95WIC416Bwr9Qz+4Pw5ivW+32Y6kgsW1kxP8pI4oQkhw668oI764bLtws8SPAl/l6tqT4vH3D9+X58PDqpYtmh3lNh3udbVIe4eJfcyTUpjR86tTq24H3tfnv9aVVgLrLv87CnZw7DjuRQ8pAbwHgTbYLywFtxtGHkESuxyx0O/EhGw7s0Xgd3qnwai8XzWArWS0AEwlX8X+V3J5VLOZCqm+dunDgjvX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(376002)(396003)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(30864003)(7416002)(5660300002)(2906002)(66899024)(6666004)(9686003)(6512007)(41300700001)(478600001)(8936002)(4326008)(8676002)(38100700002)(6486002)(53546011)(83380400001)(6506007)(86362001)(316002)(66476007)(6916009)(66556008)(66946007)(54906003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?onOYdq0du8OTGBK3idqF0Fxn18ioflXDW+AjPlYOBswK2xtC+LkQw/11khEw?=
 =?us-ascii?Q?MvJctIb1o26aJTc6XH+ichFdurTFxfzlYuvEzk+AwEwTWadLmLp+WWtKNX0v?=
 =?us-ascii?Q?JkjGJUVvNZKSjVMd9jPahzaij8bsGIcxd3g1WMiXkEf45zq6CTWW5naXMvPN?=
 =?us-ascii?Q?6j+TC2kuSGbJhgk/HvDzvsjq7bnBtBKkG/JiZkZAeLOueU5+dl4+orbGBA26?=
 =?us-ascii?Q?ohVPu5+rSUZdCIjVJ850rIIy65KjnD00mUJDk4O4tK8J4Et1s74/YMdyCObf?=
 =?us-ascii?Q?TnwdRr4k5eXinJbSbq99Oy/ilxcJi8MKg5m1KWo10/gwf61SYoJaSB8dhVYA?=
 =?us-ascii?Q?maDVN2EtpX2evGIHPkA4PEytzP7XJ6be52Za0+e+RY1afSytDEEVhAo0xz7q?=
 =?us-ascii?Q?68lyhiGr+uhp2buuAsDGUkjalyoX2I4Uh7/hJxEp6tbcZqhNuSJpIc3bX6tR?=
 =?us-ascii?Q?81NlCtv5qDYJqnaIoVj+VztVoZUBCvzEScXmN4jq0zl64wmjOFufSgVHWDR5?=
 =?us-ascii?Q?vlCxyPPH9xKS0qqbXAL+LFz9fZ5JTL7+ED7lKCvdmdJHchMOUedlaOb6BDZp?=
 =?us-ascii?Q?IZXomfnPc1MdeAQWh0YH6K5Rs2Bb1aci2LLNdGuvzk/9fmikwjCINBWEf/it?=
 =?us-ascii?Q?NiTDOcbtWAAy7iwAvxmir5ua7kJYBX2ZeCmV1XQWrytJcXWLbzJnYk6VRNYG?=
 =?us-ascii?Q?Xccq1+k198hAZgLCAioEEczM8enxEZ/IuScxH2ybGFWgTcjDcQGB4NPDK/EK?=
 =?us-ascii?Q?1UhppP1gS3hLh6fLSDsfFTbVHZZJCMpIdHl2q8rTjinp79djrCuWxXmDbMh2?=
 =?us-ascii?Q?pwV8oZxnsH+Rh9U5EXCNZ7Kk+5daJUmVJeZdRKkmaD9Wprqt0qy9gN0ZAj1m?=
 =?us-ascii?Q?Pa7FWpLc8coiaQ2HltreFfdjdJBdKScx9V8Ng2A64oCv6rRe5CJ3kurxWWWr?=
 =?us-ascii?Q?oZbcB3P7ttunlQjKvfafA7o+SabwHSslv8gSxflnBrIwr7Fi0YE+7J6568wb?=
 =?us-ascii?Q?h1P8P6SbZw5ne3hJdjQYZ98OQIfdVc7+OKyT8IV+Z+GUkPtb1ELSXp7dU7cy?=
 =?us-ascii?Q?3dwpgM3FwaGyERnDbfVegHVRxsSU9dJaGD5F4mlIthZnX4uE5R9F5PpZc3UA?=
 =?us-ascii?Q?ytDmO3RHfKVqnJF750jo94wqrGU4c9D/LYJeay2LVzzoefAQD8TKjCj7UBC4?=
 =?us-ascii?Q?boCGE6P/X2puruw/RlwrOfQ0yR+VtTGGyBH5Bnl+1fKfqpd9uw7tB7AhhLer?=
 =?us-ascii?Q?c24bgD+/9zZU9/RVAS81okT3rVQ0WTgC8t5Cp/QPtpeXBAS9R9rwOG3G31gs?=
 =?us-ascii?Q?JE+xioCv2GJEiqQtl3N9qKrBvgYXJtKsnEmaPVss1qwC9IJQNlg6LeM5lCk8?=
 =?us-ascii?Q?P8p3gJwDmklEwtZ6rXELzb1D0BnQsUmcF7Dk7GoG2WlSylEvaGmu0GjAE0TY?=
 =?us-ascii?Q?wwHut85pZrcaX8tA8yMCN/mbjuhkhQp3ILVvP6y/4Lxa8yBtP7BOu1v4fugx?=
 =?us-ascii?Q?MZdbYAYkpypuRYZTJgGzurL2OMkaaePJDKFqY8dgtCbXv07SNDmtMV4m03to?=
 =?us-ascii?Q?IgyXR95vFFiVJMkE3H2l4Gui/aufDzoa5ofEbvPV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1834ea56-0897-4c22-0527-08dbefdedd6b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 06:54:28.2568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nB9eiQI80hen2bKd/ENDo0m9YGa4Q0hTBnkmCVgrW9A/IaxsEaaquhp8trzVMv2tQ7TJ1TnBhiro4cO2/Tx87A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8202
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ryan Roberts <ryan.roberts@arm.com> writes:

> On 27/11/2023 07:34, Alistair Popple wrote:
>> 
>> Ryan Roberts <ryan.roberts@arm.com> writes:
>> 
>>> On 24/11/2023 01:35, Alistair Popple wrote:
>>>>
>>>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>>>
>>>>> On 23/11/2023 05:13, Alistair Popple wrote:
>>>>>>
>>>>>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>>>>>
>>>>>>> ptep_get_and_clear_full() adds a 'full' parameter which is not present
>>>>>>> for the fallback ptep_get_and_clear() function. 'full' is set to 1 when
>>>>>>> a full address space teardown is in progress. We use this information to
>>>>>>> optimize arm64_sys_exit_group() by avoiding unfolding (and therefore
>>>>>>> tlbi) contiguous ranges. Instead we just clear the PTE but allow all the
>>>>>>> contiguous neighbours to keep their contig bit set, because we know we
>>>>>>> are about to clear the rest too.
>>>>>>>
>>>>>>> Before this optimization, the cost of arm64_sys_exit_group() exploded to
>>>>>>> 32x what it was before PTE_CONT support was wired up, when compiling the
>>>>>>> kernel. With this optimization in place, we are back down to the
>>>>>>> original cost.
>>>>>>>
>>>>>>> This approach is not perfect though, as for the duration between
>>>>>>> returning from the first call to ptep_get_and_clear_full() and making
>>>>>>> the final call, the contpte block in an intermediate state, where some
>>>>>>> ptes are cleared and others are still set with the PTE_CONT bit. If any
>>>>>>> other APIs are called for the ptes in the contpte block during that
>>>>>>> time, we have to be very careful. The core code currently interleaves
>>>>>>> calls to ptep_get_and_clear_full() with ptep_get() and so ptep_get()
>>>>>>> must be careful to ignore the cleared entries when accumulating the
>>>>>>> access and dirty bits - the same goes for ptep_get_lockless(). The only
>>>>>>> other calls we might resonably expect are to set markers in the
>>>>>>> previously cleared ptes. (We shouldn't see valid entries being set until
>>>>>>> after the tlbi, at which point we are no longer in the intermediate
>>>>>>> state). Since markers are not valid, this is safe; set_ptes() will see
>>>>>>> the old, invalid entry and will not attempt to unfold. And the new pte
>>>>>>> is also invalid so it won't attempt to fold. We shouldn't see this for
>>>>>>> the 'full' case anyway.
>>>>>>>
>>>>>>> The last remaining issue is returning the access/dirty bits. That info
>>>>>>> could be present in any of the ptes in the contpte block. ptep_get()
>>>>>>> will gather those bits from across the contpte block. We don't bother
>>>>>>> doing that here, because we know that the information is used by the
>>>>>>> core-mm to mark the underlying folio as accessed/dirty. And since the
>>>>>>> same folio must be underpinning the whole block (that was a requirement
>>>>>>> for folding in the first place), that information will make it to the
>>>>>>> folio eventually once all the ptes have been cleared. This approach
>>>>>>> means we don't have to play games with accumulating and storing the
>>>>>>> bits. It does mean that any interleaved calls to ptep_get() may lack
>>>>>>> correct access/dirty information if we have already cleared the pte that
>>>>>>> happened to store it. The core code does not rely on this though.
>>>>>>
>>>>>> Does not *currently* rely on this. I can't help but think it is
>>>>>> potentially something that could change in the future though which would
>>>>>> lead to some subtle bugs.
>>>>>
>>>>> Yes, there is a risk, although IMHO, its very small.
>>>>>
>>>>>>
>>>>>> Would there be any may of avoiding this? Half baked thought but could
>>>>>> you for example copy the access/dirty information to the last (or
>>>>>> perhaps first, most likely invalid) PTE?
>>>>>
>>>>> I spent a long time thinking about this and came up with a number of
>>>>> possibilities, none of them ideal. In the end, I went for the simplest one
>>>>> (which works but suffers from the problem that it depends on the way it is
>>>>> called not changing).
>>>>
>>>> Ok, that answers my underlying question of "has someone thought about
>>>> this and are there any easy solutions". I suspected that was the case
>>>> given the excellent write up though!
>>>>
>>>>> 1) copy the access/dirty flags into all the remaining uncleared ptes within the
>>>>> contpte block. This is how I did it in v1; although it was racy. I think this
>>>>> could be implemented correctly but its extremely complex.
>>>>>
>>>>> 2) batch calls from the core-mm (like I did for pte_set_wrprotects()) so that we
>>>>> can clear 1 or more full contpte blocks in a single call - the ptes are never in
>>>>> an intermediate state. This is difficult because ptep_get_and_clear_full()
>>>>> returns the pte that was cleared so its difficult to scale that up to multiple ptes.
>>>>>
>>>>> 3) add ptep_get_no_access_dirty() and redefine the interface to only allow that
>>>>> to be called while ptep_get_and_clear_full() calls are on-going. Then assert in
>>>>> the other functions that ptep_get_and_clear_full() is not on-going when they are
>>>>> called. So we would get a clear sign that usage patterns have changed. But there
>>>>> is no easy place to store that state (other than scanning a contpte block
>>>>> looking for pte_none() amongst pte_valid_cont() entries) and it all felt ugly.
>>>>>
>>>>> 4) The simple approach I ended up taking; I thought it would be best to keep it
>>>>> simple and see if anyone was concerned before doing something more drastic.
>>>>>
>>>>> What do you think? If we really need to solve this, then option 1 is my
>>>>> preferred route, but it would take some time to figure out and reason about a
>>>>> race-free scheme.
>>>>
>>>> Well I like simple, and I agree the risk is small. But I can't help feel
>>>> the current situation is too subtle, mainly because it is architecture
>>>> specific and the assumptions are not communicated in core-mm code
>>>> anywhere. But also none of the aternatives seem much better.
>>>>
>>>> However there are only three callers of ptep_get_and_clear_full(), and
>>>> all of these hold the PTL. So if I'm not mistaken that should exclude
>>>> just about all users of ptep_get*() which will take the ptl before hand.
>>>
>>> The problem isn't racing threads because as you say, the PTL is already
>>> serializing all calls except ptep_get_lockless(). And although there are 3
>>> callers to ptep_get_and_clear_full(), only the caller in zap_pte_range() ever
>>> calls it with full=1, as I recall.
>>>
>>> The problem is that the caller in zap_pte_range() does this:
>>>
>>> ptl = lock_page_table()
>>> for each pte {
>>> 	ptent = ptep_get(pte);
>>> 	if (pte_present(ptent) {
>>> 		ptent = ptep_get_and_clear_full(ptent);
>>> 		if (pte_dirty(ptent))
>>> 			...
>>> 		if (pte_young(ptent))
>>> 			...
>>> 	}
>>> }
>>> unlock_page_table(ptl)
>>>
>>> It deliberately interleves calls to ptep_get() and ptep_get_and_clear_full()
>>> under the ptl. So if the loop is iterating over a contpte block and the HW
>>> happens to be storing the access/dirty info in the first pte entry, then the
>>> first time through the loop, ptep_get() will return the correct access/dirty
>>> info, as will ptep_get_and_clear_full(). The next time through the loop though,
>>> the access/dirty info which was in the previous pte is now cleared so ptep_get()
>>> and ptep_get_and_clear_full() will return old/clean. It all works, but is fragile.
>> 
>> So if ptep_get_lockless() isn't a concern what made the option posted in
>> v1 racy (your option 1 above)? Is there something else reading PTEs or
>> clearing PTE bits without holding the PTL that I'm missing?
>
> The HW could be racing to set access and dirty bits. Well actually, I'm not
> completely sure if that's the case here; if full=1 then presumably no other
> threads in the process should be running at this point, so perhaps it can be
> guarranteed that nothing is causing a concurrent memory access and the HW is
> therefore definitely not going to try to write the access/dirty bits
> concurrently. But I didn't manage to convince myself that's definitely the case.

I suppose it's possible something attached to an SMMU or some such could
still be running and causing accesses so agree it's probably not the
case (although it would be an odd corner case).

> So if we do need to deal with racing HW, I'm pretty sure my v1 implementation is
> buggy because it iterated through the PTEs, getting and accumulating. Then
> iterated again, writing that final set of bits to all the PTEs. And the HW could
> have modified the bits during those loops. I think it would be possible to fix
> the race, but intuition says it would be expensive.

So the issue as I understand it is subsequent iterations would see a
clean PTE after the first iteration returned a dirty PTE. In
ptep_get_and_clear_full() why couldn't you just copy the dirty/accessed
bit (if set) from the PTE being cleared to an adjacent PTE rather than
all the PTEs?

That would fix the inconsistency as far as subsequent iterations of
ptep_get_and_clear_full() returning the dirty/accessed if a previous
iteration did. Obviously HW could still race and cause a previously
clean iteration to return dirty, but that seems ok.

However all this has just left me with more questions :-)

Won't clearing bits like this result in inconsistent programming of the
PTE_CONT bit? What happens if HW access a page in the contiguous region
while some of the PTEs are invalid? And same question for programming
them really - I don't think we can atomically set PTE_CONT on multiple
PTEs all at once so if we assume something can be accessing them
concurrently how do we do that without having some HW observing an
intermediate state where PTE_CONT is misprogrammed?

Thanks.

>> 
>>>>
>>>> So really that only leaves ptep_get_lockless() that could/should
>>>> interleave right? 
>>>
>>> Yes, but ptep_get_lockless() is special. Since it is called without the PTL, it
>>> is very careful to ensure that the contpte block is in a consistent state and it
>>> keeps trying until it is. So this will always return the correct consistent
>>> information.
>>>
>>>> From a quick glance of those users none look at the
>>>> young/dirty information anyway, so I wonder if we can just assert in the
>>>> core-mm that ptep_get_lockless() does not return young/dirty information
>>>> and clear it in the helpers? That would make things explicit and
>>>> consistent which would address my concern (although I haven't looked too
>>>> closely at the details there).
>>>
>>> As per explanation above, its not ptep_get_lockless() that is the problem so I
>>> don't think this helps.
>>>
>>> Thanks,
>>> Ryan
>>>
>>>>
>>>>> Thanks,
>>>>> Ryan
>>>>
>> 

