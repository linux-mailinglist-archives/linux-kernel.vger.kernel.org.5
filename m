Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03AC7D5FDB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 04:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjJYCUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 22:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjJYCUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 22:20:10 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A0C10D5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 19:20:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iaR6f418mLOE73KNCzgsDKWivANHaZoBz3uHIIdQG8vIvNFtmBr1kl/2zT+CUruQmHz409aq25YeJxaO0XjGh7Slzb+jMpkJ/aX2X2clB6GGIe2paXgXKBaR7fQ+GKcEPPjyaRYP7TlqRFHspMYvFnGEGSMWAdgM87lRZpZOz3BMOq14/p9VFtlC92dl9q9M42Ouq6g4knaM0ftQFRF5vqWKBKKd+NEvEujSEZWlFHOZr+Ozx0V5MZ4uVLNmQWsd5GFob5cz9/yUvEWj8dCc7Ahmxr/yt9LryByyJAtGb4NdR3J4PoRPwIOxSSN3GHx5L0RXbYcha3RrarHg4CaiGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awJuTN9liZAzhcTys5nkbZ4pEzbmr+mjbj/l6vZ0WN8=;
 b=NTbcIQJIZcIG0VfUSrdo1V0WUSyN4Hcv9A9d8iyMD+fEeOSEH4Ie2cRueIGSCOXrbCWJkF31L/dsY+E7eUPjAdzPihpqo4rJTCSH0BQ6xdLtymsusvhoLMfTzwu6oBFNT+Xswx/gkHYbFjyimAca7EcWTFF0iXVRCbRsDPYU1FWypAipNG2y8AnsV5gI8EPdLNdbmhNjGQgoj9RhQCoifU9V1YrcxHGXnI4PCILUMCC+QA1Da0jjys6AltTqBcYNuG3cOl+FZFp1RoJNg75D7qkGgUspv5V0oupX8VPS+S8O6Lx0YcqANWY815WA7QnnZPfjq9L635sral/JyNnobA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awJuTN9liZAzhcTys5nkbZ4pEzbmr+mjbj/l6vZ0WN8=;
 b=VFqTxZg5rJZU+eF6Qn4wWGBF4a3H3qUEWPNzXpYA+Qm34dMIdwwmfxXRUiwJCxOAdR76EKiL5oMf4kyRCaUIgKCv/usRA8ginV62EHUR8cGylLE+jic9FVGI/jAcy+2FZTBnaL2znhGZSP8az7IQiQN6Pjq10qZfd+a0BSq/9CDxQpuj0ithpRmPxvFX+7BxBun1Xk3Kjlx8o2owXkYQPYRM/SH4nOqnt6sXylpyMiRPxPV0QsZSBD7GwFerPk+Ns6085gV0GJMbuUznB75KlqgqvrcGcgZdqRULQ7VA0h6vnMZ+9aJ2/2MauaER6oDhPq7A+t1EfBvFO8V37wX8kA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by BL1PR12MB5351.namprd12.prod.outlook.com (2603:10b6:208:317::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 02:20:04 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::d504:dd12:5218:c5d]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::d504:dd12:5218:c5d%4]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 02:20:04 +0000
References: <ae3115778a3fa10ec77152e18beed54fafe0f6e7.1698151516.git.baolin.wang@linux.alibaba.com>
 <CAGsJ_4zgdAmyU-075jd8KfXn=CdAVC8Rs481sCOd5N2a68yPUg@mail.gmail.com>
 <CAGsJ_4z1u4-_JXUM9GG2cqc4Nwrx1v69uHsbff5jDQZHQgWP+w@mail.gmail.com>
 <87y1frqz2u.fsf@nvdebian.thelocal>
 <CAGsJ_4wFiz-obaoXqfU9p-YqgFwExyXpGjpDKMOUt7mnenD-ew@mail.gmail.com>
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
Date:   Wed, 25 Oct 2023 12:58:03 +1100
In-reply-to: <CAGsJ_4wFiz-obaoXqfU9p-YqgFwExyXpGjpDKMOUt7mnenD-ew@mail.gmail.com>
Message-ID: <87ttqfqw8f.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SYBPR01CA0159.ausprd01.prod.outlook.com
 (2603:10c6:10:d::27) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|BL1PR12MB5351:EE_
X-MS-Office365-Filtering-Correlation-Id: c70df307-b5c6-41b9-d5a7-08dbd500e60b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mPqRlNhYMGksvyV920ACHUHPts9E3T4wiiuLE5+gT2ZpAu3qGIHPdzT+Rt8SdXCIpelhsCM/1fmEttaqJ8BKi7Wp8H+KWebcBeRO6ZV5LdOHo2pAUR5oPa+xQIn/8KaoEjW2zOC28O1Lbey3yl/J74E0fZ3FBlWg48KFUYzOcjyrrBaCnqTki53H4kHESI67BJs+GPhXtRyGaj19XSoCrd5nacdl74S8FgHpb6J4ays/8+U7VtktQ6PxzVrkZBukFcTyJBVM+BwLefMo43hpNsbY5MqIgPiVNOd4YOijzgAMejIeDu8cUMAxXVCSBoiP/fhyY2pWQT2UkG9R6Vc6oDHhvxodfQb1sIEY7ihhGO9GllaG7x9iE7AKPAKQgQ7nTUHDGUchOjTpbZoVs2uKkYdo7CTNjWOODU8FtgLvtQaSi6bPkF8PY93rw8X+ljQOWTikEJtejBNinI6jZjtl/9M/gYM5bhSl3ArZoUk/OtQeNv7VZRsjf0/lXdc0d4Wq8T7907z3EZKv65ngiGNHcWU+9jx6/Fp2J6/XfrtJ4PRlhXyEDBRXEWqD1vJ/pWwpIQ634E5CB32N7A0iKbYcAxhfNGh/FufAf4Y8ZwqbFM4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(376002)(39860400002)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(41300700001)(2906002)(38100700002)(66946007)(66476007)(316002)(66556008)(6506007)(478600001)(6916009)(53546011)(9686003)(966005)(6512007)(6486002)(83380400001)(5660300002)(86362001)(4326008)(8676002)(7416002)(8936002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFVqcy9jcVpkeWdxZWZwajhkY2dJZkxaV3RHZnpzbmxlYUpISk9pekVrOGdi?=
 =?utf-8?B?dDR6M0ZDOEF5Y1A1eEp4d0VrNWV4bjF3V2E2a1VvRkVNN2xlWTIvdDlQYnVH?=
 =?utf-8?B?VER1NXFNeGEzdzRxQ0JuSlN6Q29WNHMzengvek0vOUNaUjV5YWpmQVFCejlk?=
 =?utf-8?B?WG12V1JQOHhsTnEzSkdRaWlZSjJSZmNkZDVEV080bVE3NHorTVE4SDR6R0dY?=
 =?utf-8?B?a3ZDU25qd29YcWtMRktDZFNwdEVNL2tUOEFOSTJrZWVGdjUzT1JLaHI4SFBQ?=
 =?utf-8?B?VWxDUCtvN1R3VXJvS1Vna2VhelBYWUlvRzNRODdYU2pWWkJrb0JKR0tzb1Z1?=
 =?utf-8?B?dnlMRkRlYkcvQnd3a3hsc2hNcUNiN09WQldGdDVyUTBhckl4L0ZZeFJPMStQ?=
 =?utf-8?B?U2RPc2F6cFhGQjhJcm40Y3dZbGcrSW82S2huOWNtelBMY0ViZ28zZXJoejBJ?=
 =?utf-8?B?OFVXWWIveWsvbUtLeXNvcC83SVJ1MmVIT21xVXg1YnpzQmdCbTA2Z29jN0hP?=
 =?utf-8?B?UE0wOER4K1lHRFErcStQMVpBVVRlMnZ6SE1MSlNZeElwSGYzL0tHcUVrQTFj?=
 =?utf-8?B?bmx2V0E0aUtjSHZJODlmTDVpUGNndHlvLzBucW9zVkJmamlPVW9RMWR6K2JX?=
 =?utf-8?B?ZWVYcVhhRU8xdm9zcFlKZkhsdGU2VU9yV05oUC85cmxWdGVEZm1leVNKNVp0?=
 =?utf-8?B?ekNDNGJMc3IrdzhwdUVMblV6VG52UjdpU0tBV2hkREg2VlMzTEk5U3A0U2xC?=
 =?utf-8?B?NVZQQzRMc09jMXcrZVk3ektpN0x4OHN6enlKdVRYZDZSZDdFd2tCY1BQamxC?=
 =?utf-8?B?SGs3WHBuZlY5MktURWZ5Rm96MFY4S0swMmtiN2NsUElHOEFRNXRvTWo0bmNl?=
 =?utf-8?B?YmVQMVVteWhrM1FVY09pODdVTXBNeEVZOFVmd25ROXF6SVhUT1BYTDdNYXNi?=
 =?utf-8?B?dHVaS25EK0kybHRJNm52NWlGUFlKMHhBUnB4eDdpSXBhcXZyWTB1TktsTGtI?=
 =?utf-8?B?Y0JKUm5kbU1YWEg2Z0ZSbGtjazVrQzBFNi9RTXRlQUk3bVFGUCtMOG44Y01J?=
 =?utf-8?B?WjFzdjhaOGFicyt1VHoxQ3FkdW5vMXMvS1pSejFYVWhTbHZkWDZBZlYxcnhl?=
 =?utf-8?B?NmFKNkgxSGVvcStVajlpSUFGNnk1MnZqSTJxUDZvYXhmZVJGQjNPbUJGQzhh?=
 =?utf-8?B?YjlIOHFmUmdXTC94cFZvVFBGZlJjVW5LQVllc2ttZGJkcE5zSmRnUWo1NHp1?=
 =?utf-8?B?T3lDU2oySVphT2FUZVhnajc3T1VLODhUU21LeGZzQm1hVTMySFFhZ1ZrV3pw?=
 =?utf-8?B?dWhzOFNkWWt5cDYwMjZpQ3htcjczZlFKdDVjdUdzSXUwUTZQcU15SjFQajNX?=
 =?utf-8?B?RkhRT2MyaHJ0MUNmNTk5M3B4dTBrcUY0cjZWaWdCMlc5RnNZeTNFZnVlWndL?=
 =?utf-8?B?TkVDdEFYajBaaEprcGVsV1BMVURqOG9wMnM3ekRIVXZ0cDVMdUFFNHpsdGtM?=
 =?utf-8?B?Q3pDWnhtVkUwTTlEUUR0eVVUY3VyZXY5dDFYN2NNRVdlVXdkTkdaMmNQVlBN?=
 =?utf-8?B?QnBSOExmNHQxT0wrdmkyYjNsWjV2TVdEckhud0tCRmR1UllDWGpBaDhKNU4v?=
 =?utf-8?B?UUczUVllOUExMko5R3NpbDg2Lzk2dzdMMkJ5ZWg0ZVB3Q0p0ajd0elNLaFh2?=
 =?utf-8?B?NzBCTGtpTGJYZjVaWkRtRjBSTmFRQ2lFdnNXd2VvVVVvNWtYRCt3L0ZuZ1RY?=
 =?utf-8?B?SDhncVMrT3cwaUNabUQ0MnF3SzlLZHowN1ZHVTVHSjdGM3F1bW1CeGNvYk5Y?=
 =?utf-8?B?VmJnQXR1b1c5OHZEaVlJQk1JbEc1M2VMd0JoR0dKbUhzYWI0YWNYUjVzWk9E?=
 =?utf-8?B?ZFVTUWdLMU5hME0rcWF2ZmRic2ZHWGMvOG1TRlVObzNMWEQyeUtFVm56aGcx?=
 =?utf-8?B?SWRXQmdIK2YrVXNaSjk2UFNOb3NDeHF0c2dCVGZLZ1pLK2xVRTREZUNLTVp4?=
 =?utf-8?B?dE5tMTV5MThRMElIZDZRQTdWZ0ZzRy9LblhOMlp0WExCVmF2NVJmMnhMWUc0?=
 =?utf-8?B?dVNxSVVFV0hQZWZHbmNxVGhjSjN0TVdOT3pvRkp0NmdiL0YwQlRhZXdYZVJx?=
 =?utf-8?Q?3af4cl68FiZSr1pn+T8cjtX2h?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c70df307-b5c6-41b9-d5a7-08dbd500e60b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 02:20:04.0572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5yI3kZuPmS3zmg2FUgAjDXMViX1DZdB91vhBOEVFdqpbqMorLUYel1bTPJzKH453ka5b1f43guxXe8hf/eXcPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5351
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

> On Wed, Oct 25, 2023 at 9:18=E2=80=AFAM Alistair Popple <apopple@nvidia.c=
om> wrote:
>>
>>
>> Barry Song <21cnbao@gmail.com> writes:
>>
>> > On Wed, Oct 25, 2023 at 7:16=E2=80=AFAM Barry Song <21cnbao@gmail.com>=
 wrote:
>> >>
>> >> On Tue, Oct 24, 2023 at 8:57=E2=80=AFPM Baolin Wang
>> >> <baolin.wang@linux.alibaba.com> wrote:

[...]

>> >> (A). Constant flush cost vs. (B). very very occasional reclaimed hot
>> >> page,  B might
>> >> be a correct choice.
>> >
>> > Plus, I doubt B is really going to happen. as after a page is promoted=
 to
>> > the head of lru list or new generation, it needs a long time to slide =
back
>> > to the inactive list tail or to the candidate generation of mglru. the=
 time
>> > should have been large enough for tlb to be flushed. If the page is re=
ally
>> > hot, the hardware will get second, third, fourth etc opportunity to se=
t an
>> > access flag in the long time in which the page is re-moved to the tail
>> > as the page can be accessed multiple times if it is really hot.
>>
>> This might not be true if you have external hardware sharing the page
>> tables with software through either HMM or hardware supported ATS
>> though.
>>
>> In those cases I think it's much more likely hardware can still be
>> accessing the page even after a context switch on the CPU say. So those
>> pages will tend to get reclaimed even though hardware is still actively
>> using them which would be quite expensive and I guess could lead to
>> thrashing as each page is reclaimed and then immediately faulted back
>> in.
>
> i am not quite sure i got your point. has the external hardware sharing c=
pu's
> pagetable the ability to set access flag in page table entries by
> itself? if yes,
> I don't see how our approach will hurt as folio_referenced can notify the
> hardware driver and the driver can flush its own tlb. If no, i don't see
> either as the external hardware can't set access flags, that means we
> have ignored its reference and only knows cpu's access even in the curren=
t
> mainline code. so we are not getting worse.
>
> so the external hardware can also see cpu's TLB? or cpu's tlb flush can
> also broadcast to external hardware, then external hardware sees the
> cleared access flag, thus, it can set access flag in page table when the
> hardware access it?  If this is the case, I feel what you said is true.

Perhaps it would help if I gave a concrete example. Take for example the
ARM SMMU. It has it's own TLB. Invalidating this TLB is done in one of
two ways depending on the specific HW implementation.

If broadcast TLB maintenance (BTM) is supported it will snoop CPU TLB
invalidations. If BTM is not supported it relies on SW to explicitly
forward TLB invalidations via MMU notifiers.

Now consider the case where some external device is accessing mappings
via the SMMU. The access flag will be cached in the SMMU TLB. If we
clear the access flag without a TLB invalidate the access flag in the
CPU page table will not get updated because it's already set in the SMMU
TLB.

As an aside access flag updates happen in one of two ways. If the SMMU
HW supports hardware translation table updates (HTTU) then hardware will
manage updating access/dirty flags as required. If this is not supported
then SW is relied on to update these flags which in practice means
taking a minor fault. But I don't think that is relevant here - in
either case without a TLB invalidate neither of those things will
happen.

I suppose drivers could implement the clear_flush_young() MMU notifier
callback (none do at the moment AFAICT) but then won't that just lead to
the opposite problem - that every page ever used by an external device
remains active and unavailable for reclaim because the access flag never
gets cleared? I suppose they could do the flush then which would ensure
the page is marked inactive if it's not referenced between the two
folio_referenced calls().

But that requires changes to those drivers. SMMU from memory doesn't
even register for notifiers if BTM is supported.

 - Alistair

>>
>> Of course TLB flushes are equally (perhaps even more) expensive for this
>> kind of external HW so reducing them would still be beneficial. I wonder
>> if there's some way they could be deferred until the page is moved to
>> the inactive list say?
>>
>> >>
>> >> > [1] https://lore.kernel.org/lkml/20220617070555.344368-1-21cnbao@gm=
ail.com/
>> >> > Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> >> > ---
>> >> >  arch/arm64/include/asm/pgtable.h | 31 ++++++++++++++++------------=
---
>> >> >  1 file changed, 16 insertions(+), 15 deletions(-)
>> >> >
>> >> > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/=
asm/pgtable.h
>> >> > index 0bd18de9fd97..2979d796ba9d 100644
>> >> > --- a/arch/arm64/include/asm/pgtable.h
>> >> > +++ b/arch/arm64/include/asm/pgtable.h
>> >> > @@ -905,21 +905,22 @@ static inline int ptep_test_and_clear_young(s=
truct vm_area_struct *vma,
>> >> >  static inline int ptep_clear_flush_young(struct vm_area_struct *vm=
a,
>> >> >                                          unsigned long address, pte=
_t *ptep)
>> >> >  {
>> >> > -       int young =3D ptep_test_and_clear_young(vma, address, ptep)=
;
>> >> > -
>> >> > -       if (young) {
>> >> > -               /*
>> >> > -                * We can elide the trailing DSB here since the wor=
st that can
>> >> > -                * happen is that a CPU continues to use the young =
entry in its
>> >> > -                * TLB and we mistakenly reclaim the associated pag=
e. The
>> >> > -                * window for such an event is bounded by the next
>> >> > -                * context-switch, which provides a DSB to complete=
 the TLB
>> >> > -                * invalidation.
>> >> > -                */
>> >> > -               flush_tlb_page_nosync(vma, address);
>> >> > -       }
>> >> > -
>> >> > -       return young;
>> >> > +       /*
>> >> > +        * This comment is borrowed from x86, but applies equally t=
o ARM64:
>> >> > +        *
>> >> > +        * Clearing the accessed bit without a TLB flush doesn't ca=
use
>> >> > +        * data corruption. [ It could cause incorrect page aging a=
nd
>> >> > +        * the (mistaken) reclaim of hot pages, but the chance of t=
hat
>> >> > +        * should be relatively low. ]
>> >> > +        *
>> >> > +        * So as a performance optimization don't flush the TLB whe=
n
>> >> > +        * clearing the accessed bit, it will eventually be flushed=
 by
>> >> > +        * a context switch or a VM operation anyway. [ In the rare
>> >> > +        * event of it not getting flushed for a long time the dela=
y
>> >> > +        * shouldn't really matter because there's no real memory
>> >> > +        * pressure for swapout to react to. ]
>> >> > +        */
>> >> > +       return ptep_test_and_clear_young(vma, address, ptep);
>> >> >  }
>> >> >
>> >> >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> >> > --
>> >> > 2.39.3
>> >> >
>> >>
>> >> Thanks
>> >> Barry
>>
> Thanks
> Barry

