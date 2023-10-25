Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB6D7D5F73
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 03:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjJYBSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 21:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJYBSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 21:18:43 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C1999
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 18:18:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLREZYnBHTFhhueSLTdWrAbx41ns5ZjTpd81U6uY70jqjoGnAll3HlL25p9o+736LMKg/y4cY8nPC+sADtY/q/lGh78V6pSJOLwkoVMRalneTDLTIqYza4qfVKpJAYYJ8koDwnz/nlkqsqtCVFfu4GVVeDdnnu8F4z2RR4d9rC4EMdKksgbuqAcDKcnJ7fjzoGsjEi2FXA1SDmM2pe9hwzXh00G0mcjycVfAqIT+w9XsqP0mJxL0/tKColOMXpelKtNqCDBQtFo483CNU3GNWnPisszdQitKCm9gMsDM8knR2+Ht1HzClXjgVii7JjQ29xwBaj3NRPXmFh5y0WFYxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Krhv20skpHqThINaoi4QYu2+0eUGBalHOz7QmJJSVmc=;
 b=IYvg4eZA7p3o8OGgWZK36Fxhoz+O6Z4ozptWeHMdGxa7x20Q1oxwYDTGpJLsTrKivC8fCtJbsBdls00oBkqQS7hZE1FRM/ct840YtTFUsBx/37aBaFCg5slZqh9M9gNYWPVN2vaw5TIJm7QMpIZ90brHEfnqOg6J/gmToBmTStkVc3uGA5m/hLUZG1ZGbusBgsknt6W/DN3FXHZh/pUi1McBLG+z8FJe6lOugJfxeDJuHV0dtAO1YbksbwGBwE1BVJ9zyMzBVdMPYSRLB3oEIxLHlc6Vj9ONfMcgEWaB1t2gk1EduYhCFtA9TMfTXqbDBqdGyMSGObpp6Tb0sLOzZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Krhv20skpHqThINaoi4QYu2+0eUGBalHOz7QmJJSVmc=;
 b=UzvbxWLTBphNUCCSE9a0ZUyCGIuc0/beqiOEJzrGR4MsAimT4X/rNzXSJCkQSZrGkTDTvMHh0cN3VZFBu79SHLFLqKl3sdmLPF9yyksCUIM38zXpE+1Ln/21VsWYGdrbuIuexibVW7nQC9v7dDGsrYC4FM/7MmQh+tcdWiBJxzEuH0LANon1sDoC3Un/tP78z0qSfUPIvihvPaPlowrMhsd0wsUFj+kP6ESzuhv0KIJkL10QSKykiqMtAWDT94KZxNQgAQhUT8jkQ8+nDbcGgRoiVWOUqUtW6H/DhnKxj/MXDCeoYo8QqAFEE9Mb+MFiHO/CAP5suicNl3lfr0raVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by PH7PR12MB5783.namprd12.prod.outlook.com (2603:10b6:510:1d2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 01:18:37 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::d504:dd12:5218:c5d]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::d504:dd12:5218:c5d%4]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 01:18:37 +0000
References: <ae3115778a3fa10ec77152e18beed54fafe0f6e7.1698151516.git.baolin.wang@linux.alibaba.com>
 <CAGsJ_4zgdAmyU-075jd8KfXn=CdAVC8Rs481sCOd5N2a68yPUg@mail.gmail.com>
 <CAGsJ_4z1u4-_JXUM9GG2cqc4Nwrx1v69uHsbff5jDQZHQgWP+w@mail.gmail.com>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Barry Song <21cnbao@gmail.com>
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, v-songbaohua@oppo.com,
        yuzhao@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: mm: drop tlb flush operation when clearing the
 access bit
Date:   Wed, 25 Oct 2023 12:07:05 +1100
In-reply-to: <CAGsJ_4z1u4-_JXUM9GG2cqc4Nwrx1v69uHsbff5jDQZHQgWP+w@mail.gmail.com>
Message-ID: <87y1frqz2u.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SY5P300CA0014.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fb::19) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|PH7PR12MB5783:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a4085dc-0da8-417a-ba4b-08dbd4f8508e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +URlexvnDZ+WUNzeA8t4oSh0zDfghlZfmbvZcQHyg3IQ5oC9lcji2bBAtp95dbensye7OJ2iwupoXAODy45jogyiajcWGahFORKx2k/LLL1vlSKM2EBPPvmNrq5//+nVoA1X04CazO3lWuieZIoKKO6qBM6VRlsYA8Fdllg7qSe9HqHYcEtlAjA8chKjeLfxiJDbhLCZwqBLfR3HUFU9z7g1AURAbKzqB+Ecgsf5D+YSB9s6aM2oYyopRreGx/IWiLRl1yGYzdo4T7EF39XzjIm+MS38wmiEmJrt7oykruIeCuh7TmPX9rS9b/P60VaNLkLhdD59oFHiHkbXoghSvrOzZoGTR4U2s0nNbzYXuy4+zTjIuD2seQ4IlnjFacBuY4JztMW65AO+tHoN22ivWPg5P58gZiLgIO2c/X18xFbmmkdIv6x+DPmjPpVPyBVbzWfkc8qJHrTDj2RNnQ+225SObBrrcGxxij/3oXBqOX4JMrkb3Z5ljnjeaUNR1F7iB88mfPmaviBFwGJEx+CRl7WB6Rpgvzn7MhA3LpyXLyOPrJKZH/AJcAXW1lAbGNvMsIsp8SxMybLxHKMIkqMUnBO3QGvtvwoWUbWXQOCeN0c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(41300700001)(2906002)(38100700002)(66476007)(6916009)(66946007)(66556008)(478600001)(6506007)(6486002)(966005)(53546011)(6666004)(6512007)(9686003)(83380400001)(5660300002)(86362001)(4326008)(8676002)(7416002)(316002)(8936002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z051V2gvaW9WVGNJVmRwWEthNUdKaWxESmxyeVB5eVpQN2tJU2tERWlkSjho?=
 =?utf-8?B?RXJWUXZWa1IrN0pYVUR1WUtBdEN4WkxabHhEVmVlUE1CYnZKOGhDNE14QnFH?=
 =?utf-8?B?RXp2RDBROU9uNTVLSzFteVNCSnliK3hQRHhYbzNUV25xVXFLUzdkNGppSjMv?=
 =?utf-8?B?SkdzRW1reXVYdTAzTlU0WjVXWnh5T3J2N2Y0UUViU0FkNWw4WjBzRnBCZmVC?=
 =?utf-8?B?UC9pczN3a1RLd29jL3VReFI1NWVuRTV4bXdFQnJOeTBJbEpheFZGK1FJTFk2?=
 =?utf-8?B?TDVrQWpuUVdKSlo2dGVkSUpiOExBeVAzTTZHYzU2UHhLZnVHRzMrdUxWcmUy?=
 =?utf-8?B?QzgzM2NBakRWWTg3WE1VbTgzWE55V2YzUWxyc2dVTFlxMFdXdGNDV2ZSZmhS?=
 =?utf-8?B?TjIzd21lSU0yKzhqUnZsRXROK243b3UzQnhFcE9lVU5UUXoyWk52ZHIyTFRn?=
 =?utf-8?B?cWRvaGNPVTFTZTdsV0dORFM2TnZhcEk2UEFvNlUvc2xDL1d0ZkczOCtIMlpt?=
 =?utf-8?B?Nnc2ZlpQQS9VZUZjNXlMZjVITzh4VDJ5dklVVVFHclg4RlNCbVh0Z2x6WEZl?=
 =?utf-8?B?RkNZUHpXQUFtc1lYUW41QloxTEpIUDNodCtMMm9MY2dUOTlMZncyRGtXazUy?=
 =?utf-8?B?N1VLRyt5UkRSTUdUV2ZGUnpCazZrVFRaSUxXKzFqVWhHd1JmMmFMVlErR2hs?=
 =?utf-8?B?aTJOVkhVSDlFb3ZOM0lUc2s0MXd5V2RIa0ZNVHlsd0NlWkVLdDZQOTFlNHND?=
 =?utf-8?B?emdjRFFCVVM4VUhsbWk4Y0k0K2JraXhPQkh4QVViYnJITkVRT0xWUFB4RCtr?=
 =?utf-8?B?a1VNY2JUS3lGaWJCT0tBazVNR1NZZTBIMFN3QTVjaVF1RDVRS21SZk1vUExx?=
 =?utf-8?B?WlBlRmxPL0VkR0pDZVIrenhSNGp0bXUyNVhGNzRhM3lLMTRjQlhCWjFpV1VV?=
 =?utf-8?B?djZBcmZSK05Wa0xycmtqclNNbmhiQ05TQjV0S1lzOHVMRmdxWkl0KzRRZkhM?=
 =?utf-8?B?RXVNN2hTbXZReE91aG9IU3ArOE1md3I4dHBPaTIvVzdnc2ZiOCtSZHgxMkxL?=
 =?utf-8?B?SHFZWWI1dlhGMDFCVEVEOXRaR3FYN2xhNkRMeTdqU2VwdjBrODAzL0d6d0lh?=
 =?utf-8?B?SlNTVjI3TGhYM2xiRmFvVEhJSWdrYUl5bDdiNnMxUHMyZy9Ka2dmLzJSNHZE?=
 =?utf-8?B?OVVKdTJ5WDI2dEU1cVJXZmEzdWVxT29xTVFPc2p0cEFxdlRBc2szZC96L3h6?=
 =?utf-8?B?M3dMNDY5NEo0VUhXR2gzYlRPMXpCWGNrQzM3TXFCOWF5a3gweDJWY0UzWmVJ?=
 =?utf-8?B?bmxENG5RWGtzTFg1TndjSzh5bXZGVmFyWlBNTnpDM3VuMzNvanVCVHFyWnBq?=
 =?utf-8?B?a1BLaWZrSTU4eFhDMER5MkJSRGhFWEVrSEd1WGV6TWxsWjBIcjlDQk1qRGhS?=
 =?utf-8?B?OVpFN1duUzhwNzVOQ0hBMTdaaTVLa3VYM1V1bEVmalhaeVlaK1czZEd4aE0w?=
 =?utf-8?B?QWtSRW1vY29BS1VoaCtiRFQvREFObGtCVDNGSEQrbW5XQVdjK3hrUnRQamNZ?=
 =?utf-8?B?ZThtaFgyUkM1T015WVRITXhHelY2ZlNuTlJpblVsUWQrMjNEWnJDWjMzdHJM?=
 =?utf-8?B?MXpGS0pZaDZVMndzZTVVWC9NU3pyemdkdWxJM3BEVjBiMHJQTTJ0TDZ2TFM1?=
 =?utf-8?B?N3U3cG1hMVBCL1dGRlplOVFBZ1V3NjIyaWpoVFVBMEhQUGhheldpS2gzaml1?=
 =?utf-8?B?ZnRDeDRQVVRLNlViVmVOVS83VnhUYzl1MTlnSzVWM0JqUFlWN25GU2o3aWRu?=
 =?utf-8?B?RTVRaUlRRDRuQW5BRmhQMHFvSEUzL05jd29yblVBUTdpQ3lvMExFLzB0cEhh?=
 =?utf-8?B?MFY0cld0R09vbng0Qk56bjk0YURNbVJDM3NHdnFiZWZMOWd3MEt3VTkvNm92?=
 =?utf-8?B?ZDZ2V29vZ0dNQWxOWlE0em9tVmFKZE9qM3p4cm03Mm9kK0tYdVp6by9ST3NP?=
 =?utf-8?B?MXdyTExQUElGVnA1WnF4b0xxNkt4RnI4UjBaY1ZEQzRNQWlKaDlDdHdiQWVP?=
 =?utf-8?B?L0tLelFQS1pQUzJVMDJtK1UxT3Z1NG80T2cyeE5hanRDbm9QcUNDOGdQY3Ri?=
 =?utf-8?Q?Dgh2+4hrJKRIyfA5Extj2TeLV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a4085dc-0da8-417a-ba4b-08dbd4f8508e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 01:18:37.3181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7jk9isVUU6+O0BGXNv1D1jO07i4MCKTSlDwjAgzOLeWTuepN5piS9uDi/jtv+hkTpNHXvM5y9Wro7AWI2erHoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5783
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Barry Song <21cnbao@gmail.com> writes:

> On Wed, Oct 25, 2023 at 7:16=E2=80=AFAM Barry Song <21cnbao@gmail.com> wr=
ote:
>>
>> On Tue, Oct 24, 2023 at 8:57=E2=80=AFPM Baolin Wang
>> <baolin.wang@linux.alibaba.com> wrote:
>> >
>> > Now ptep_clear_flush_young() is only called by folio_referenced() to
>> > check if the folio was referenced, and now it will call a tlb flush on
>> > ARM64 architecture. However the tlb flush can be expensive on ARM64
>> > servers, especially for the systems with a large CPU numbers.
>> >
>> > Similar to the x86 architecture, below comments also apply equally to
>> > ARM64 architecture. So we can drop the tlb flush operation in
>> > ptep_clear_flush_young() on ARM64 architecture to improve the performa=
nce.
>> > "
>> > /* Clearing the accessed bit without a TLB flush
>> >  * doesn't cause data corruption. [ It could cause incorrect
>> >  * page aging and the (mistaken) reclaim of hot pages, but the
>> >  * chance of that should be relatively low. ]
>> >  *
>> >  * So as a performance optimization don't flush the TLB when
>> >  * clearing the accessed bit, it will eventually be flushed by
>> >  * a context switch or a VM operation anyway. [ In the rare
>> >  * event of it not getting flushed for a long time the delay
>> >  * shouldn't really matter because there's no real memory
>> >  * pressure for swapout to react to. ]
>> >  */
>> > "
>> > Running the thpscale to show some obvious improvements for compaction
>> > latency with this patch:
>> >                              base                   patched
>> > Amean     fault-both-1      1093.19 (   0.00%)     1084.57 *   0.79%*
>> > Amean     fault-both-3      2566.22 (   0.00%)     2228.45 *  13.16%*
>> > Amean     fault-both-5      3591.22 (   0.00%)     3146.73 *  12.38%*
>> > Amean     fault-both-7      4157.26 (   0.00%)     4113.67 *   1.05%*
>> > Amean     fault-both-12     6184.79 (   0.00%)     5218.70 *  15.62%*
>> > Amean     fault-both-18     9103.70 (   0.00%)     7739.71 *  14.98%*
>> > Amean     fault-both-24    12341.73 (   0.00%)    10684.23 *  13.43%*
>> > Amean     fault-both-30    15519.00 (   0.00%)    13695.14 *  11.75%*
>> > Amean     fault-both-32    16189.15 (   0.00%)    14365.73 *  11.26%*
>> >                        base       patched
>> > Duration User         167.78      161.03
>> > Duration System      1836.66     1673.01
>> > Duration Elapsed     2074.58     2059.75
>> >
>> > Barry Song submitted a similar patch [1] before, that replaces the
>> > ptep_clear_flush_young_notify() with ptep_clear_young_notify() in
>> > folio_referenced_one(). However, I'm not sure if removing the tlb flus=
h
>> > operation is applicable to every architecture in kernel, so dropping
>> > the tlb flush for ARM64 seems a sensible change.
>> >
>> > Note: I am okay for both approach, if someone can help to ensure that
>> > all architectures do not need the tlb flush when clearing the accessed
>> > bit, then I also think Barry's patch is better (hope Barry can resend
>> > his patch).
>> >
>>
>> Thanks!
>>
>> ptep_clear_flush_young() with "flush" in its name clearly says it needs =
a
>> flush. but it happens in arm64, all other code which needs a flush has
>> called other variants, for example __flush_tlb_page_nosync():
>>
>> static inline void arch_tlbbatch_add_pending(struct
>> arch_tlbflush_unmap_batch *batch,
>>  struct mm_struct *mm, unsigned long uaddr)
>> {
>>  __flush_tlb_page_nosync(mm, uaddr);
>> }
>>
>> so it seems folio_referenced is the only left user of this
>> ptep_clear_flush_young().
>> The fact makes Baolin's patch look safe now.
>>
>> but this function still has "flush" in its name, so one day, one person =
might
>> call it with the understanding that it will flush tlb but actually it
>> won't. This is
>> bad smell in code.
>>
>> I guess one side effect of not flushing tlb while clearing the access
>> flag is that
>> hardware won't see this cleared flag in the tlb, so it might not set thi=
s bit in
>> memory even though the bit has been cleared before in memory(but not in =
tlb)
>> while the page is accessed *again*.
>>
>> next time, someone reads the access flag in memory again by folio_refere=
nced,
>> he/she will see the page is cold as hardware has lost a chance to set
>> the bit again
>> since it finds tlb already has a true access flag.
>>
>> But anyway, tlb is so small, it will be flushed by context switch and
>> other running
>> code soon. so it seems we don't actually require the access flag being i=
nstantly
>> updated. the time gap, in which access flag might lose the new set by ha=
rdware,
>> seems to be too short to really affect the accuracy of page reclamation.=
 but its
>> cost is large.
>>
>> (A). Constant flush cost vs. (B). very very occasional reclaimed hot
>> page,  B might
>> be a correct choice.
>
> Plus, I doubt B is really going to happen. as after a page is promoted to
> the head of lru list or new generation, it needs a long time to slide bac=
k
> to the inactive list tail or to the candidate generation of mglru. the ti=
me
> should have been large enough for tlb to be flushed. If the page is reall=
y
> hot, the hardware will get second, third, fourth etc opportunity to set a=
n
> access flag in the long time in which the page is re-moved to the tail
> as the page can be accessed multiple times if it is really hot.

This might not be true if you have external hardware sharing the page
tables with software through either HMM or hardware supported ATS
though.

In those cases I think it's much more likely hardware can still be
accessing the page even after a context switch on the CPU say. So those
pages will tend to get reclaimed even though hardware is still actively
using them which would be quite expensive and I guess could lead to
thrashing as each page is reclaimed and then immediately faulted back
in.

Of course TLB flushes are equally (perhaps even more) expensive for this
kind of external HW so reducing them would still be beneficial. I wonder
if there's some way they could be deferred until the page is moved to
the inactive list say?

>>
>> > [1] https://lore.kernel.org/lkml/20220617070555.344368-1-21cnbao@gmail=
.com/
>> > Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> > ---
>> >  arch/arm64/include/asm/pgtable.h | 31 ++++++++++++++++---------------
>> >  1 file changed, 16 insertions(+), 15 deletions(-)
>> >
>> > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm=
/pgtable.h
>> > index 0bd18de9fd97..2979d796ba9d 100644
>> > --- a/arch/arm64/include/asm/pgtable.h
>> > +++ b/arch/arm64/include/asm/pgtable.h
>> > @@ -905,21 +905,22 @@ static inline int ptep_test_and_clear_young(stru=
ct vm_area_struct *vma,
>> >  static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
>> >                                          unsigned long address, pte_t =
*ptep)
>> >  {
>> > -       int young =3D ptep_test_and_clear_young(vma, address, ptep);
>> > -
>> > -       if (young) {
>> > -               /*
>> > -                * We can elide the trailing DSB here since the worst =
that can
>> > -                * happen is that a CPU continues to use the young ent=
ry in its
>> > -                * TLB and we mistakenly reclaim the associated page. =
The
>> > -                * window for such an event is bounded by the next
>> > -                * context-switch, which provides a DSB to complete th=
e TLB
>> > -                * invalidation.
>> > -                */
>> > -               flush_tlb_page_nosync(vma, address);
>> > -       }
>> > -
>> > -       return young;
>> > +       /*
>> > +        * This comment is borrowed from x86, but applies equally to A=
RM64:
>> > +        *
>> > +        * Clearing the accessed bit without a TLB flush doesn't cause
>> > +        * data corruption. [ It could cause incorrect page aging and
>> > +        * the (mistaken) reclaim of hot pages, but the chance of that
>> > +        * should be relatively low. ]
>> > +        *
>> > +        * So as a performance optimization don't flush the TLB when
>> > +        * clearing the accessed bit, it will eventually be flushed by
>> > +        * a context switch or a VM operation anyway. [ In the rare
>> > +        * event of it not getting flushed for a long time the delay
>> > +        * shouldn't really matter because there's no real memory
>> > +        * pressure for swapout to react to. ]
>> > +        */
>> > +       return ptep_test_and_clear_young(vma, address, ptep);
>> >  }
>> >
>> >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> > --
>> > 2.39.3
>> >
>>
>> Thanks
>> Barry

