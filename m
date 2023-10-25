Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9D27D680C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbjJYKQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234453AbjJYKQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:16:30 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E990D11F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 03:16:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDVdrYuIi5Y7QUIp3C4AJWWu1zdY6vmwZDPJD8CMtiVZC95bcaEfIXFu/GBSvk9KasZ//IrXVhLxf3w/nkkVD2t4c98L6K9g3jLohcULqvgUSiuAxppjux3G4jk390dBPWbyW8ry5HzZdnkGGvTek5AOvg1M2CgsF5ro7Q62lHqcZDs+u4P5BfQKvQj7a16f/90+Xj+/QtLUlUwBx9Ufo7RwKA7LoEncY3+d91kRQ00fh63WxPh/bjgmm/FabZM4Ecvlzv8AAJA30fEpsZOBS+FxbqGw72Sh5Zpvoa/8gqDAT20QASUebkoQ1k3eQnlT/s3fwCQVXE7JScz20ZAUkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtcaeZq09A2N8+PpBMSl31DF6Qx1zJf7Rbqt5btFvYs=;
 b=ZPulbhdKz23F/L/ivPtwNS8+WgAbasIgNXhdjTvShpG2srURYi+X1lZgV1LZ/7egVfGTLhYuQfPoZc/a18E9TkIgaCv1Y/yHrJ6lCP7UCkfd0O5byxD7hx25CkNEkKoFo5mDHkQYCnb2wShHVyywox6mMs8fyX8H/FAFhiUn3vHRDD2PM4lPurRTKbRZTrJ2pG1AE5Ol6fKd1YzQ4eyzdp5gE6Nc6OhdBfndZSUgPQfQ3PrfO1ZZSZNRvhuMECrqujGslKyPL3KWB8M/DO0cqNSVnY8b+k4sIC8jWZZ3yBk8ifH/7UACSTyJpWI23mXVgwq8AP8qjsEqLVVc4UYacA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtcaeZq09A2N8+PpBMSl31DF6Qx1zJf7Rbqt5btFvYs=;
 b=pE6ZNLNZKl4XguFQlOScL4++Di16Fwew76EszIQDVgcVLBAqNRrM9HrYbDNvzb6M9V0qwURyVBdUfHRriCA4rCIPB3aHaovt9YKwanq2rm2fa576YueVxd8BTwtGEYEBm5QFbmDhIrFDwWeETjLpFCamNB6r14xqJqWsY6Afu7plYV/PiSkojuXSQkwYzBgOI/2a7/OVj+HcyXPsUrh9ylp6KHWNi3/n6bjSJrcRF0CAENflTqbxaa9FQALlrayYhWHvGy02ba/WOFgAmSCOY8eCsfNesN47Gj/mhtOww3cWvxCkMvo/L38YLCYvA9M8i9FfJdDpuJFG5iaTWrYRfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by BL0PR12MB4867.namprd12.prod.outlook.com (2603:10b6:208:17e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Wed, 25 Oct
 2023 10:16:24 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::d504:dd12:5218:c5d]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::d504:dd12:5218:c5d%4]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 10:16:24 +0000
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
User-agent: mu4e 1.8.13; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Barry Song <21cnbao@gmail.com>
Cc:     Yu Zhao <yuzhao@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, v-songbaohua@oppo.com,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: mm: drop tlb flush operation when clearing the
 access bit
Date:   Wed, 25 Oct 2023 21:12:37 +1100
In-reply-to: <CAGsJ_4zueK32KMHM0=EYjB3spYvh-yJU=buorG+6+Stnu=cypw@mail.gmail.com>
Message-ID: <877cnb0zyk.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SY4P282CA0012.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:a0::22) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|BL0PR12MB4867:EE_
X-MS-Office365-Filtering-Correlation-Id: c1dfa721-9a25-4c0b-deb9-08dbd54370dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qFTMve3uPmghpYMga+v+gzZADRMppak0A8iYoj5fgCha4zzho7aAMm/eYjXmZbAbtyzmNSmsa9NnqmngZ+O7B5YQLh0rDWxmkouyKtSMC193D2Qc11UEgkVRPcnVGvr8NlqTetAG//JoFpXR4KBUHIpu2F43R9onf+f5uByLqHMHPyhq2pKVLflZLH68zCrqoCbuzpvhuQzwu+1MjFH7Uxsd9bkI22fod1wh4Emlar/4QCiKUTBry5jhxQVHNF7ahuSqvvDQb2U7MdCwj4T3fbMFV/MRvWhm9IXoVf7QVA+KJ4ToGdku+JeyLioxpJYrIGuUieR0daHwhRh50yht/+azL0V8GRwQZOnGaY1FS9HqJVgYIu4qqGyYurAjOQeiBidubbE28h0xDlRkE0HTn114K8SXYswNbSDi4p10mCuKcsncqCu2gyvp3GNhIMRPdsVS324NDJ9MSC7rNnwaQXM46lFBPOMm0rUZdVamNeyR4QUDra0LUnS1RaF70+aunDEKGAiFoutqQwko57NBV49xgFPb2j2kdfOny4x/Z8Y938vT5J8EmXa/jX8DCO0T5mJ6u5znsIy9RjnMjhhHd42mB770dMoIb/J0BABMSyc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(376002)(39860400002)(366004)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(2906002)(38100700002)(5660300002)(66946007)(66556008)(66476007)(6916009)(54906003)(316002)(6666004)(6506007)(478600001)(41300700001)(53546011)(9686003)(966005)(6512007)(83380400001)(6486002)(86362001)(7416002)(4326008)(8676002)(8936002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2RLZEpYTHlReks5RThodXQvR2JNVlVCY2c0WnMrc2QrM1pQK3h0YmRoblZT?=
 =?utf-8?B?Q2ZSbWhrRU5TOE5LUzlLc0tKVUhqS1ZxbDdzcVQyeGl4SjV2NzR5Q3hDOFBj?=
 =?utf-8?B?aTdSYUpPYm5VcUtYcDc1RDdDcmNSUldtMDIwK25QaFRGYXVTUVE1bE5qVUJq?=
 =?utf-8?B?RWNSdlNiUlJENVVQUDJXUmZRbWZELzJtZ0RLQzNDeDZXZTF5VWhMRndsYVkx?=
 =?utf-8?B?YmtQMTFvY2MvODZWOFFZRXFLSlRoUEduUHVuRGNDdGUrWk1ZMElaTVphcGUz?=
 =?utf-8?B?VG9mMXZGU05Dc29wTlI3S3dnb3IzZTJHS0F1djdJZmlCZVEwRVhRMElRYUNN?=
 =?utf-8?B?dThwcy9KczhWdzlnLzZ1Yno4ZDFvcmkwalY5VGtBNVd2VEZRSWRkUXpmTW5G?=
 =?utf-8?B?NHZBNUllR0pPdzhGbGFHY3BxUzg4REVVcnZ1QXVQVytpckpiY2toQkhVUTZQ?=
 =?utf-8?B?clp0TTEzR25jMGFuN2dZZDBIWFg5YUJkSEV1anZBYWNrU3pNZHRXMWdoWFJR?=
 =?utf-8?B?Ukd2L1NoMXFybk1WUmR5OXJ0UDltZVZUOEUxL2dEclZXdGhneS9laG4xZlBR?=
 =?utf-8?B?eEJBcXRNY1RyS0YvRU9kRGJLTzFBbUNxS3FJS0ZnUzdId3oxWHBEREMySzMx?=
 =?utf-8?B?Ti9NeGpkd0V3b3lCTkFMS0ZQVmpZR1NFNnk1d3A4K0pHYlV5VFlaQXdiOCs2?=
 =?utf-8?B?UkpEd3hxOUZlTittTStyWHU1eFFOZE5IWHI0MWorNGVnbzNWOVBReW1jK05E?=
 =?utf-8?B?Z3FmNnF0WVJ2UGNERWYvVTc0bTBKRkhST3k4UzRFR0ZkMnluQis1VzhFVlp3?=
 =?utf-8?B?bU9KNjE1OXFPQmY3NnhmaW0xcFh2dFpmZGVPc1g2VXpjNzZ4ZGppbnliTHMx?=
 =?utf-8?B?WCtOaUlwU0E0ZmgwQlRta240L0xwS3NTcUNlYjBMRDRONUVpV0xnaThkekF6?=
 =?utf-8?B?VGJoNll5dm10MWdnWk5FbE5UVHh6YlQvR0p0SmFXbnhMZkwyLytodkkvQm1o?=
 =?utf-8?B?RENETXhlL1N3TmZVLzBrdDlaZXZqR1Y3d1NYdWN1c2dCTVRhcVp0amhJeHUx?=
 =?utf-8?B?WGlPc2gyRDlYL2lBSXZPdWFkQ2ozczhhRzNoVStnQy8zWjByL1dxaGdUK0xJ?=
 =?utf-8?B?L0NYTmdxRFhjNTJJU2U3eWRmTVdqVmVIV29aMnppT2thTDdwd3NYMkRqZUZP?=
 =?utf-8?B?VVVoRU9vSVI2QWxKQ3Y5NkIwNzN1RTY4b1Z0R0xYQm5qVk1GKzVZNlh4a2Rp?=
 =?utf-8?B?R2tvODhNYXBGZkpZcThqNHowQkVFRkJqVWdHRHo5NTNhbTNBdnBjYjgxdFhm?=
 =?utf-8?B?MDExQWRDdWFua1VQUC8rZFIzd25hY0RqSm55bXc5RSt2SzhPQjlpOGowZ0F6?=
 =?utf-8?B?VnkrdktxYngyY0tQcE1xTDA3bEh4cW5FR3JKV2hHVnQ4K3hrb255Z2pVOTRy?=
 =?utf-8?B?ZDNqeHo2ZE9CbmJJaU1STVBGVzJZWmliYzhOaDM0VXhsaDY2Y0JzdmZDbTVY?=
 =?utf-8?B?SGJXaWM5Z0dXZ3RqL3psSnFUTXl0aFVVRTdya1hQR0xzZUlicitaSUlDUTNI?=
 =?utf-8?B?YjN4QVF4bE45UkdqVlJzbkN6ZXJxaWpwdjdOOG9OcFE2OXIrWlBsb0s5UUFh?=
 =?utf-8?B?QlR0bEUrWEtBWVJDdDEzZnl3Z0NIdzlJMnJ6dloydjVoTGowdUkya1VwN054?=
 =?utf-8?B?MTlxWDh4UmNaZ0FUUGh0K0VjLzQ3eUh5V29XVXU3WkZNcnBtT0xUUzU3YUVD?=
 =?utf-8?B?SS90R1NRK2RqVjhjSXdqdnc0VGhuTFFQZlo3Y2ptYVBudmNDbFRlZExDMU5p?=
 =?utf-8?B?VmlrSU50YUxodHAxS3NpalZzMm83S0FzNlNnYXB0bFg1WWpJaGhmK1JNNnBL?=
 =?utf-8?B?Z2FRZ1hvUE1nSDVCRUtXaytvTk9TT09tVkxjVVFRYWN6MCtobU1DM1VmYm1L?=
 =?utf-8?B?STJNSWlpMUVBdG5rbC9QcGNuU0xXY3pNYVRDSzFjdzI2dzlibE1IZ29KNWto?=
 =?utf-8?B?ZnJhY1ZudGFyK25Gd0VTcnhHZytSaERiNW1FNlFadU9YOEd6WVA4UjNxMHRz?=
 =?utf-8?B?cEFCTUZmUFV4cDRzODRsZ0xtOHExNDMra2Jpd2gwNXQ0cEpPcVZSdlplRm1l?=
 =?utf-8?Q?m9o7HaN/ydQz0s9z2bSBpKQkI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1dfa721-9a25-4c0b-deb9-08dbd54370dc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 10:16:23.7711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E5c4s4v3lC/n6rLXjtLoAM9u0y9knrBgtgbJlPGiaNZk8UHL1Bx3Dm4su8urdLn0cNUboi0UXyptV4SMyKBSFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4867
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Barry Song <21cnbao@gmail.com> writes:

> On Wed, Oct 25, 2023 at 2:17=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote=
:
>>
>> On Tue, Oct 24, 2023 at 9:21=E2=80=AFPM Alistair Popple <apopple@nvidia.=
com> wrote:
>> >
>> >
>> > Baolin Wang <baolin.wang@linux.alibaba.com> writes:
>> >
>> > > On 10/25/2023 9:58 AM, Alistair Popple wrote:
>> > >> Barry Song <21cnbao@gmail.com> writes:
>> > >>
>> > >>> On Wed, Oct 25, 2023 at 9:18=E2=80=AFAM Alistair Popple <apopple@n=
vidia.com> wrote:
>> > >>>>
>> > >>>>
>> > >>>> Barry Song <21cnbao@gmail.com> writes:
>> > >>>>
>> > >>>>> On Wed, Oct 25, 2023 at 7:16=E2=80=AFAM Barry Song <21cnbao@gmai=
l.com> wrote:
>> > >>>>>>
>> > >>>>>> On Tue, Oct 24, 2023 at 8:57=E2=80=AFPM Baolin Wang
>> > >>>>>> <baolin.wang@linux.alibaba.com> wrote:
>> > >> [...]
>> > >>
>> > >>>>>> (A). Constant flush cost vs. (B). very very occasional reclaime=
d hot
>> > >>>>>> page,  B might
>> > >>>>>> be a correct choice.
>> > >>>>>
>> > >>>>> Plus, I doubt B is really going to happen. as after a page is pr=
omoted to
>> > >>>>> the head of lru list or new generation, it needs a long time to =
slide back
>> > >>>>> to the inactive list tail or to the candidate generation of mglr=
u. the time
>> > >>>>> should have been large enough for tlb to be flushed. If the page=
 is really
>> > >>>>> hot, the hardware will get second, third, fourth etc opportunity=
 to set an
>> > >>>>> access flag in the long time in which the page is re-moved to th=
e tail
>> > >>>>> as the page can be accessed multiple times if it is really hot.
>> > >>>>
>> > >>>> This might not be true if you have external hardware sharing the =
page
>> > >>>> tables with software through either HMM or hardware supported ATS
>> > >>>> though.
>> > >>>>
>> > >>>> In those cases I think it's much more likely hardware can still b=
e
>> > >>>> accessing the page even after a context switch on the CPU say. So=
 those
>> > >>>> pages will tend to get reclaimed even though hardware is still ac=
tively
>> > >>>> using them which would be quite expensive and I guess could lead =
to
>> > >>>> thrashing as each page is reclaimed and then immediately faulted =
back
>> > >>>> in.
>> > >
>> > > That's possible, but the chance should be relatively low. At least o=
n
>> > > x86, I have not heard of this issue.
>> >
>> > Personally I've never seen any x86 system that shares page tables with
>> > external devices, other than with HMM. More on that below.
>> >
>> > >>> i am not quite sure i got your point. has the external hardware sh=
aring cpu's
>> > >>> pagetable the ability to set access flag in page table entries by
>> > >>> itself? if yes,
>> > >>> I don't see how our approach will hurt as folio_referenced can not=
ify the
>> > >>> hardware driver and the driver can flush its own tlb. If no, i don=
't see
>> > >>> either as the external hardware can't set access flags, that means=
 we
>> > >>> have ignored its reference and only knows cpu's access even in the=
 current
>> > >>> mainline code. so we are not getting worse.
>> > >>>
>> > >>> so the external hardware can also see cpu's TLB? or cpu's tlb flus=
h can
>> > >>> also broadcast to external hardware, then external hardware sees t=
he
>> > >>> cleared access flag, thus, it can set access flag in page table wh=
en the
>> > >>> hardware access it?  If this is the case, I feel what you said is =
true.
>> > >> Perhaps it would help if I gave a concrete example. Take for exampl=
e
>> > >> the
>> > >> ARM SMMU. It has it's own TLB. Invalidating this TLB is done in one=
 of
>> > >> two ways depending on the specific HW implementation.
>> > >> If broadcast TLB maintenance (BTM) is supported it will snoop CPU
>> > >> TLB
>> > >> invalidations. If BTM is not supported it relies on SW to explicitl=
y
>> > >> forward TLB invalidations via MMU notifiers.
>> > >
>> > > On our ARM64 hardware, we rely on BTM to maintain TLB coherency.
>> >
>> > Lucky you :-)
>> >
>> > ARM64 SMMU architecture specification supports the possibilty of both,
>> > as does the driver. Not that I think whether or not BTM is supported h=
as
>> > much relevance to this issue.
>> >
>> > >> Now consider the case where some external device is accessing mappi=
ngs
>> > >> via the SMMU. The access flag will be cached in the SMMU TLB. If we
>> > >> clear the access flag without a TLB invalidate the access flag in t=
he
>> > >> CPU page table will not get updated because it's already set in the=
 SMMU
>> > >> TLB.
>> > >> As an aside access flag updates happen in one of two ways. If the
>> > >> SMMU
>> > >> HW supports hardware translation table updates (HTTU) then hardware=
 will
>> > >> manage updating access/dirty flags as required. If this is not supp=
orted
>> > >> then SW is relied on to update these flags which in practice means
>> > >> taking a minor fault. But I don't think that is relevant here - in
>> > >> either case without a TLB invalidate neither of those things will
>> > >> happen.
>> > >> I suppose drivers could implement the clear_flush_young() MMU
>> > >> notifier
>> > >> callback (none do at the moment AFAICT) but then won't that just le=
ad to
>> > >> the opposite problem - that every page ever used by an external dev=
ice
>> > >> remains active and unavailable for reclaim because the access flag =
never
>> > >> gets cleared? I suppose they could do the flush then which would en=
sure
>> > >
>> > > Yes, I think so too. The reason there is currently no problem, perha=
ps
>> > > I think, there are no actual use cases at the moment? At least on ou=
r
>> > > Alibaba's fleet, SMMU and MMU do not share page tables now.
>> >
>> > We have systems that do.
>>
>> Just curious: do those systems run the Linux kernel? If so, are pages
>> shared with SMMU pinned? If not, then how are IO PFs handled after
>> pages are reclaimed?

Yes, these systems all run Linux. Pages shared with SMMU aren't pinned
and fault handling works as Barry notes below - a driver is notified of
a fault and calls handle_mm_fault() in response.

> it will call handle_mm_fault(vma, prm->addr, fault_flags, NULL); in
> I/O PF, so finally
> it runs the same codes to get page back just like CPU's PF.
>
> years ago, we recommended a pin solution, but obviously there were lots o=
f
> push backs:
> https://lore.kernel.org/linux-mm/1612685884-19514-1-git-send-email-wangzh=
ou1@hisilicon.com/

Right. Having to pin pages defeats the whole point of having hardware
that can handle page faults.

> Thanks
> Barry

