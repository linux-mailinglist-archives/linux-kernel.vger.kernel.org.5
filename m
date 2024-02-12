Return-Path: <linux-kernel+bounces-62223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F86851D37
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A970284F62
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F61487B3;
	Mon, 12 Feb 2024 18:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R7fHMqDr"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B86482EB
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 18:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707763596; cv=fail; b=K6loFPrhLAfTStEU6pL8g8+MSv4rWZbLyp2NSikFnnAGdcJYGCRyW6OYve+pH6MiBZ2SVybLAvRM8hBlaz87VQ+F+1pnhu53ygZ6Ki9afHmdY3xI9J14/bO96AHuiONsCLHXql1N5GAx/I6vhPCO+g3UDkrr7OVSMRUOI2bcP18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707763596; c=relaxed/simple;
	bh=cv0V8IneqCX3nfz002XcihPkXy+gOB0rCsZAI39S964=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tRPx6RswmNtZ2jFkYjXmBx4xjfHTP40dSoxxfirLXmbCNPLHH7BZOiO6MJUjSd9KmfCdZfWNEIavgoHEuEx12W1QduFz7w697baPM694pjo7slGTxuqPloz3saXDUjXjeemTqM4lpr5BYPBkZ9tTwXrSLCoWW6wf6GaTr3D1SWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R7fHMqDr; arc=fail smtp.client-ip=40.107.94.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrKPNgen6yJwhA0pkGxhRLBTYjav48qnwNEnEW7avFM3CmD5lBX88OppAMquvZm+xXctfGO1uC5NjmAWOqYAM353lC59oC8LOu/q4GolJBFe1s9WW0JyC4e41rNLBcn9idQ26MQDakSnPAwVYhEjEJ8xDBa0B1cWcZkiwyZalvay8FbdDTloYwP2Eir8LaYjweFjn1YKb7aUrKQDppRnTcsXHfq+9aTKx1Ot0QPRkQNPxW/0XF9ycTrObjcE1E4KzStZCxre3752wEu/2VGPbZSwL1PsqGA4na3iRDe48afS1On4Y3Uw/S7FCPvsaM8GSaBURiPfVuyJmYN7xhELhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+c4JIBtC0hXwuJs7ceZLrm1XVVB9owW/9wXvE/kbv8=;
 b=b4lylDxTth1ZCuZxw5+qeplS6ktRJpSC8gnFJGylTMvC75KIUZOvtgryJ9PlUGLosza+nbf9cgacEGqNddEt59xv56069deXwu0YKLE4zKA2se4/00H9Oc77OFNAV85+YYF61pnAfPZE2n8w2BDuVYdUggr5e0k7E5OMJD83A/8+4ZJYwcuasZa8UNe728F2wxM1letNMg25G6/ExTJbCXcCUyCAH4uW/8Y9ixUpKruOGZU1eSp04e6csTWG+yoiYX1Aizl03VTNBiJLqbpPfQtMV+cJ07vWaZz9sqm6/CGIyB3o77qRfF9/4BvOiEWFHDRXPWNeaGQL1w7S2ot6bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+c4JIBtC0hXwuJs7ceZLrm1XVVB9owW/9wXvE/kbv8=;
 b=R7fHMqDrVDCxUZYbYbamvbtNoLxVhR58cTkT9rs3q7VMZ9lx3p5MEoVu0YHqIj2UY8NPCwA975kVq2RufAXHNKuPtjcZa+OfePFD18NKv2qNt5HQmnxG30H/ceKTHDGdm4cxF4tPZao0mUXkvGP1FnRlOvPsaWQUwoGhHY3RYiX0dNP+UL9OkHg0ysLfGFWlYDRrlfOj0ZE//DCL2c1h7K5XjzwIEzfsXM3KFLVw2HVmjN09CGD4sETgyd3gew29fva+NGjfYc221FsTkBE1DELuil/lqNFiyZpzsDGL4MX17MFWHGrtdTTjpArBWm41+SjmPlDht2E+kfYiy7Qeug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CY8PR12MB7147.namprd12.prod.outlook.com (2603:10b6:930:5d::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.12; Mon, 12 Feb 2024 18:46:31 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15%5]) with mapi id 15.20.7292.013; Mon, 12 Feb 2024
 18:46:30 +0000
From: Zi Yan <ziy@nvidia.com>
To: Yu Zhao <yuzhao@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 "\"Huang, Ying\"" <ying.huang@intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>,
 "\"Yin, Fengwei\"" <fengwei.yin@intel.com>, Vlastimil Babka <vbabka@suse.cz>,
 "\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 Mel Gorman <mgorman@techsingularity.net>,
 Rohan Puri <rohan.puri15@gmail.com>, Mcgrof Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>,
 "\"Vishal Moola (Oracle)\"" <vishal.moola@gmail.com>,
 Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v4 0/3] Enable >0 order folio memory compaction
Date: Mon, 12 Feb 2024 13:46:28 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <0DE890C1-3347-43CA-BDD0-25244C8C2799@nvidia.com>
In-Reply-To: <CAOUHufa5c9592Vc=S=-Bdc4jy0HVRi2SGJkOQEqj6+CGP_uWxg@mail.gmail.com>
References: <20240212163510.859822-1-zi.yan@sent.com>
 <CAOUHufa5c9592Vc=S=-Bdc4jy0HVRi2SGJkOQEqj6+CGP_uWxg@mail.gmail.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_68EEDB6B-81D1-4B1D-9008-681FADA3654B_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:208:2d::36) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|CY8PR12MB7147:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fdd4497-bf96-4aec-9684-08dc2bfaed82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lv6kjJBF+v0REJsizS5kyknqELoF1AiNG26EHTZI1glmwhL3CZ8o3XKXr22RQpZvwpEZBpyTxm2PSPtw1ob88W2Sl3xXeaQxH7ViN8jIyYlbXshSEkDee3+JTw0357lOJM4p8iqKIVgjPn9g7WSjUViWfllCykfoy6J4Z/xUHwfLvNiege5ECKkXSuJnn+ZuzJpUpysfxBKuxHWFO/vNe4kGBcj2jX0dzd6IeS2orRNmKi4Iv3jocU2ayrDrip6AgxzIxXZ73AuLbphUzP++Yy7lFdfNotMS7p9K5WgMbuzv6jGQFD+7h1hBypfVJwd0z/HP7e+FB3wldcsQ3nRFZoECbn+VUaMOoIghztBbrjhQRp5bJUhHzKlG10m2AHzhsZmAi3tlnBUR90b2AVi8dfbaPGssj3Jrp0x8GNY0e7AUtQsp1SRqD8UQYf8/0EsBVeeqyPrt4d3XL3JhJ6hJiccstePGl4+zWqX/h6ND1b/20nPovPAmWSKvZMK8D5qO2JheOEAF0XVhW9gGCPhsFDMr//ZQYWZr+MEzJtCxIJA03JKKaHKEcxWoX1BuzSiB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(366004)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2906002)(7416002)(8936002)(4326008)(8676002)(5660300002)(30864003)(6916009)(83380400001)(235185007)(2616005)(86362001)(33656002)(36756003)(38100700002)(53546011)(66946007)(66556008)(316002)(26005)(66476007)(6506007)(33964004)(54906003)(478600001)(6512007)(6486002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHBCcGVmTHZDWHZ0ZERqaWRiazh5TUlibkJuMzdTRTJkQjUwYWhjVXpFNmR6?=
 =?utf-8?B?SHpob003RmZJMzZJRVErV0w1d3dyMG1LbTZGazcvWkY4cFREQ1gwcFpxdG9n?=
 =?utf-8?B?Z283RWVxV2FNR0craS9XcXlZWS8xUmxYVnJ2cjd4RG9Sd0FKQkRpTk9XZ3Nm?=
 =?utf-8?B?b09ndGJ3cmtUQ3N2RmU1dFBsd2NoSDJjTUZ6UmpncVJEeUt2K2Radkg5Vkla?=
 =?utf-8?B?bG41Mi9oNEVQOEEyM1VGSit0M2ZxSVAyN2laWUlmMFI5dEsrRVJIWkkwN3Ji?=
 =?utf-8?B?bm8wSEpVcStxdTl3emI2cDlVZDIyc3BoZjc2KzYrUzVYRTk4M040a2NuOXBa?=
 =?utf-8?B?c2M5UVJPZkc0dVlRVWoyUGpCTkh4aW0ycUJaRzhPeVEyQzZuRUxvcmRQWlZ6?=
 =?utf-8?B?OVhMY3hBcU9hZnBvVEVMWVIxNVlhRjAzNldwL3VjV2xLS2ZwWkY1VEZLRDFH?=
 =?utf-8?B?UXV1aWVuQWJWY0s4MDVZQXVKUXlkWGtBcEtPOUhEZGxPd2JpT1JBT0syMXNp?=
 =?utf-8?B?LzlMQmJyYUdMQ3JQaTE2YUdmaHRzb2FBVVp2Mk5NcXlzNkIreXlTWWNGaHhE?=
 =?utf-8?B?NDNocGM1TnVqVFFDVUVvcEN5aHVabml1c2N3MXlaQ1hDL3Rkb1dFMUYwOU5n?=
 =?utf-8?B?T3pRZVNEMHBtU3R6ZVZGbGN2WUtyYnl1VnB4bG5Gdno3aWFyZ2FaSVFQMG5p?=
 =?utf-8?B?ajJrRlpYMndzeVJZNzloVVVpVUhXczQwVlJnZktUcWJka0R1RGlSS3NhenNP?=
 =?utf-8?B?QS9qaVA0TGtzU1IwTTlsMHNtVEt2V3E2OTEwdENRU3RiVVEyQ2kweWE1c2dC?=
 =?utf-8?B?N1RBQ0FObXhMaXMvQWFoS2llQlMxdmlyWnF4MC9qSVppVllDRzZrcU9DSVJE?=
 =?utf-8?B?Q1dOWnVobkIwZjMxVXozdHByTll6NGNidnRtdlYxVCtuQmRlb1oyd1p6TzJS?=
 =?utf-8?B?L1hpSE9pN0tSYVdESlZzSnB6K0pkaSs4N0lFOEk4ZFlMdyttRi9nNis5TU5s?=
 =?utf-8?B?TzBsN3d0eUQxSXRpUkQrNHZpOG1VRWpkZk45VW9UK25pSzB0ak9UU2xzbk1j?=
 =?utf-8?B?MnVHTXJTUkJnOWtVQy92YlQvMXZTTkhWRzB3RGUwTDM3SS9WL2V6TThQZVRW?=
 =?utf-8?B?Z1F4OUtnWjQwSitIaE5YNlZHNDdHL0g5cjEwS1dPcHpEV1UzQ3dNcXRBNkxY?=
 =?utf-8?B?NmJQQkppNWdJZURnRGVSMXI0cDE4V0ZnMFZWejBWOWxuMEt1UFZCYWpqejZx?=
 =?utf-8?B?dWhoV3k1OWV1b0ZBT0FtbHdwNVR5U2xiVzFSNXFZMTBKb29QNGdIZ1JYdDli?=
 =?utf-8?B?U2Mzb3ZRNG8zRWxta2lEL1FpRXppTndQT2I0aW1EUTdKOE9iYmFsNEtBcUdp?=
 =?utf-8?B?elJvWHRWS251aW1tVklwQTByTXZwRUFCd0JGdmE1bVZNYTFtQUtabGRIcC9L?=
 =?utf-8?B?b2ZtV1M2SFJmQm13Q002M2NVYndhc2VGbWlKdTJFMGlhTDNPaWhwNkx3L3Jv?=
 =?utf-8?B?MGpaMHNuMFNGMUV2ZURQczZETHZOa0RVTit5bVJ2K083cEdUSEk2Vk5EaGN6?=
 =?utf-8?B?bm83c0JUaWpkQ1IxMlRMalJ0QUp3QUxMT01XNUlZRHdVYnVmWHJ6dzJ2YlFW?=
 =?utf-8?B?RXFLUXY3QmoyNFE0UmNLR2FwUlZ4SE5lVUVJWVJzYWh2UUlQL2hQWWp5TEdW?=
 =?utf-8?B?RXNVMDdycGl0KytZV0Y1Y2xTRjdDY0NRY0tXVEtsTzZJRXlPMUJOeFdUdENu?=
 =?utf-8?B?NEcrekV4NWdDQlV2OCtyR2NXcWl6WUJPT0RFTnNlTG5WcEhZQW82WmM1N3dU?=
 =?utf-8?B?UWZFVHRlNEE1ZWFiUGZ3MitBeTB6eHRFZWNiV0o0TEhWbDQ0Mkt6T3ZuNWlW?=
 =?utf-8?B?RlBXNCtzOU9CL3FvMTdKellDbThubFo2dUVZd3UraHM4RUdlT3RNWndRdHJW?=
 =?utf-8?B?UU13SmlqT3Rxb21mVTM4WnJEZ2V3WG1zcVZSTDhzQURZd2d4RVgyaFBkK2JZ?=
 =?utf-8?B?SjlBdlg3djVxNTI4K3FoUlFxam1Hd2I4QkdCVGdyL01lVkl6NzBjb21ORlpR?=
 =?utf-8?B?b2RoS1A1SEc0dUM0eGZJQ1NIS2Y5QVpGcS9DSXZQWGllUmQ0Wm9Cb0VWMmlp?=
 =?utf-8?Q?nXdvcafCiM0L2uSmGrnWJtkVn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fdd4497-bf96-4aec-9684-08dc2bfaed82
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 18:46:30.7708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0jASY0uWrNKoskJv/1TGGSs9szxz4+SdkHLr+GXd0zGQoNjqm4omVSxTc/1yO7qZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7147

--=_MailMate_68EEDB6B-81D1-4B1D-9008-681FADA3654B_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12 Feb 2024, at 13:44, Yu Zhao wrote:

> On Mon, Feb 12, 2024 at 9:35=E2=80=AFAM Zi Yan <zi.yan@sent.com> wrote:=

>>
>> From: Zi Yan <ziy@nvidia.com>
>>
>> Hi all,
>>
>> This patchset enables >0 order folio memory compaction, which is one o=
f
>> the prerequisitions for large folio support[1]. It is on top of
>> mm-everything-2024-02-10-00-56.
>>
>> I am aware of that split free pages is necessary for folio
>> migration in compaction, since if >0 order free pages are never split
>> and no order-0 free page is scanned, compaction will end prematurely d=
ue
>> to migration returns -ENOMEM. Free page split becomes a must instead o=
f
>> an optimization.
>>
>> lkp ncompare results (on a 8-CPU (Intel Xeon E5-2650 v4 @2.20GHz) 16G =
VM)
>> for default LRU (-no-mglru) and CONFIG_LRU_GEN are shown at the bottom=
,
>> copied from V3[4], since V4 is only a code refactoring of V3.
>> In sum, most of vm-scalability applications do not see performance
>> change, and the others see ~4% to ~26% performance boost under default=
 LRU
>> and ~2% to ~6% performance boost under CONFIG_LRU_GEN.
>
> Suren has been testing 64KB THP on Android and seeing regressions
> under memory pressure (a significant portion of client devices are
> always under memory pressure). Hopefully this series will help.
>
> I threw this series into some stress tests we have with both 64KB and
> 2MB THP enabled and didn't see any obvious problems.
>
> Tested-by: Yu Zhao <yuzhao@google.com>

Thank you for the testing.
>
>> Overview
>> =3D=3D=3D
>>
>> To support >0 order folio compaction, the patchset changes how free pa=
ges used
>> for migration are kept during compaction. Free pages used to be split =
into
>> order-0 pages that are post allocation processed (i.e., PageBuddy flag=
 cleared,
>> page order stored in page->private is zeroed, and page reference is se=
t to 1).
>> Now all free pages are kept in a MAX_ORDER+1 array of page lists based=

>> on their order without post allocation process. When migrate_pages() a=
sks for
>> a new page, one of the free pages, based on the requested page order, =
is
>> then processed and given out.
>
> And THP <2MB would need this feature (spell it out).

Will add this.
>
>
>
>> vm-scalability results on CONFIG_LRU_GEN
>> =3D=3D=3D
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>>   gcc-13/defconfig/debian/300s/qemu-vm/mmap-xread-seq-mt/vm-scalabilit=
y
>>
>> commit:
>>   6.8.0-rc1-mm-everything-2024-01-29-07-19+
>>   6.8.0-rc1-split-folio-in-compaction+
>>   6.8.0-rc1-folio-migration-in-compaction+
>>   6.8.0-rc1-folio-migration-free-page-split+
>>
>> 6.8.0-rc1-mm-eve 6.8.0-rc1-split-folio-in-co 6.8.0-rc1-folio-migration=
-i 6.8.0-rc1-folio-migration-f
>> ---------------- --------------------------- -------------------------=
-- ---------------------------
>>          %stddev     %change         %stddev     %change         %stdd=
ev     %change         %stddev
>>              \          |                \          |                \=
          |                \
>>   15107616            +3.2%   15590339            +1.3%   15297619    =
        +3.0%   15567998        vm-scalability.throughput
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>>   gcc-13/defconfig/debian/300s/qemu-vm/mmap-pread-seq/vm-scalability
>>
>> commit:
>>   6.8.0-rc1-mm-everything-2024-01-29-07-19+
>>   6.8.0-rc1-split-folio-in-compaction+
>>   6.8.0-rc1-folio-migration-in-compaction+
>>   6.8.0-rc1-folio-migration-free-page-split+
>>
>> 6.8.0-rc1-mm-eve 6.8.0-rc1-split-folio-in-co 6.8.0-rc1-folio-migration=
-i 6.8.0-rc1-folio-migration-f
>> ---------------- --------------------------- -------------------------=
-- ---------------------------
>>          %stddev     %change         %stddev     %change         %stdd=
ev     %change         %stddev
>>              \          |                \          |                \=
          |                \
>>   12611785            +1.8%   12832919            +0.9%   12724223    =
        +1.6%   12812682        vm-scalability.throughput
>>
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>>   gcc-13/defconfig/debian/300s/qemu-vm/lru-file-readtwice/vm-scalabili=
ty
>>
>> commit:
>>   6.8.0-rc1-mm-everything-2024-01-29-07-19+
>>   6.8.0-rc1-split-folio-in-compaction+
>>   6.8.0-rc1-folio-migration-in-compaction+
>>   6.8.0-rc1-folio-migration-free-page-split+
>>
>> 6.8.0-rc1-mm-eve 6.8.0-rc1-split-folio-in-co 6.8.0-rc1-folio-migration=
-i 6.8.0-rc1-folio-migration-f
>> ---------------- --------------------------- -------------------------=
-- ---------------------------
>>          %stddev     %change         %stddev     %change         %stdd=
ev     %change         %stddev
>>              \          |                \          |                \=
          |                \
>>    9833393            +5.7%   10390190            +3.0%   10126606    =
        +5.9%   10408804        vm-scalability.throughput
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>>   gcc-13/defconfig/debian/300s/qemu-vm/lru-file-mmap-read/vm-scalabili=
ty
>>
>> commit:
>>   6.8.0-rc1-mm-everything-2024-01-29-07-19+
>>   6.8.0-rc1-split-folio-in-compaction+
>>   6.8.0-rc1-folio-migration-in-compaction+
>>   6.8.0-rc1-folio-migration-free-page-split+
>>
>> 6.8.0-rc1-mm-eve 6.8.0-rc1-split-folio-in-co 6.8.0-rc1-folio-migration=
-i 6.8.0-rc1-folio-migration-f
>> ---------------- --------------------------- -------------------------=
-- ---------------------------
>>          %stddev     %change         %stddev     %change         %stdd=
ev     %change         %stddev
>>              \          |                \          |                \=
          |                \
>>    7034709 =C2=B1  3%      +2.9%    7241429            +3.2%    725668=
0 =C2=B1  2%      +3.9%    7308375        vm-scalability.throughput
>>
>>
>>
>> vm-scalability results on default LRU (with -no-mglru suffix)
>> =3D=3D=3D
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>>   gcc-13/defconfig/debian/300s/qemu-vm/mmap-xread-seq-mt/vm-scalabilit=
y
>>
>> commit:
>>   6.8.0-rc1-mm-everything-2024-01-29-07-19-no-mglru+
>>   6.8.0-rc1-split-folio-in-compaction-no-mglru+
>>   6.8.0-rc1-folio-migration-in-compaction-no-mglru+
>>   6.8.0-rc1-folio-migration-free-page-split-no-mglru+
>>
>> 6.8.0-rc1-mm-eve 6.8.0-rc1-split-folio-in-co 6.8.0-rc1-folio-migration=
-i 6.8.0-rc1-folio-migration-f
>> ---------------- --------------------------- -------------------------=
-- ---------------------------
>>          %stddev     %change         %stddev     %change         %stdd=
ev     %change         %stddev
>>              \          |                \          |                \=
          |                \
>>   14401491            +3.7%   14940270            +2.4%   14748626    =
        +4.0%   14975716        vm-scalability.throughput
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>>   gcc-13/defconfig/debian/300s/qemu-vm/mmap-pread-seq/vm-scalability
>>
>> commit:
>>   6.8.0-rc1-mm-everything-2024-01-29-07-19-no-mglru+
>>   6.8.0-rc1-split-folio-in-compaction-no-mglru+
>>   6.8.0-rc1-folio-migration-in-compaction-no-mglru+
>>   6.8.0-rc1-folio-migration-free-page-split-no-mglru+
>>
>> 6.8.0-rc1-mm-eve 6.8.0-rc1-split-folio-in-co 6.8.0-rc1-folio-migration=
-i 6.8.0-rc1-folio-migration-f
>> ---------------- --------------------------- -------------------------=
-- ---------------------------
>>          %stddev     %change         %stddev     %change         %stdd=
ev     %change         %stddev
>>              \          |                \          |                \=
          |                \
>>   11407497            +5.1%   11989632            -0.5%   11349272    =
        +4.8%   11957423        vm-scalability.throughput
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>>   gcc-13/defconfig/debian/300s/qemu-vm/mmap-pread-seq-mt/vm-scalabilit=
y
>>
>> commit:
>>   6.8.0-rc1-mm-everything-2024-01-29-07-19-no-mglru+
>>   6.8.0-rc1-split-folio-in-compaction-no-mglru+
>>   6.8.0-rc1-folio-migration-in-compaction-no-mglru+
>>   6.8.0-rc1-folio-migration-free-page-split-no-mglru+
>>
>> 6.8.0-rc1-mm-eve 6.8.0-rc1-split-folio-in-co 6.8.0-rc1-folio-migration=
-i 6.8.0-rc1-folio-migration-f
>> ---------------- --------------------------- -------------------------=
-- ---------------------------
>>          %stddev     %change         %stddev     %change         %stdd=
ev     %change         %stddev
>>              \          |                \          |                \=
          |                \
>>   11348474            +3.3%   11719453            -1.2%   11208759    =
        +3.7%   11771926        vm-scalability.throughput
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>>   gcc-13/defconfig/debian/300s/qemu-vm/lru-file-readtwice/vm-scalabili=
ty
>>
>> commit:
>>   6.8.0-rc1-mm-everything-2024-01-29-07-19-no-mglru+
>>   6.8.0-rc1-split-folio-in-compaction-no-mglru+
>>   6.8.0-rc1-folio-migration-in-compaction-no-mglru+
>>   6.8.0-rc1-folio-migration-free-page-split-no-mglru+
>>
>> 6.8.0-rc1-mm-eve 6.8.0-rc1-split-folio-in-co 6.8.0-rc1-folio-migration=
-i 6.8.0-rc1-folio-migration-f
>> ---------------- --------------------------- -------------------------=
-- ---------------------------
>>          %stddev     %change         %stddev     %change         %stdd=
ev     %change         %stddev
>>              \          |                \          |                \=
          |                \
>>    8065614 =C2=B1  3%      +7.7%    8686626 =C2=B1  2%      +5.0%    8=
467577 =C2=B1  4%     +11.8%    9016077 =C2=B1  2%  vm-scalability.throug=
hput
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>>   gcc-13/defconfig/debian/300s/qemu-vm/lru-file-mmap-read/vm-scalabili=
ty
>>
>> commit:
>>   6.8.0-rc1-mm-everything-2024-01-29-07-19-no-mglru+
>>   6.8.0-rc1-split-folio-in-compaction-no-mglru+
>>   6.8.0-rc1-folio-migration-in-compaction-no-mglru+
>>   6.8.0-rc1-folio-migration-free-page-split-no-mglru+
>>
>> 6.8.0-rc1-mm-eve 6.8.0-rc1-split-folio-in-co 6.8.0-rc1-folio-migration=
-i 6.8.0-rc1-folio-migration-f
>> ---------------- --------------------------- -------------------------=
-- ---------------------------
>>          %stddev     %change         %stddev     %change         %stdd=
ev     %change         %stddev
>>              \          |                \          |                \=
          |                \
>>    6438422 =C2=B1  2%     +27.5%    8206734 =C2=B1  2%     +10.6%    7=
118390           +26.2%    8127192 =C2=B1  4%  vm-scalability.throughput
>
> Thanks for the data! Based on the above:
>
> Test case                          default   MGLRU     Change
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> mmap-xread-seq-mt/vm-scalability   14975716  15567998  +4%
> mmap-pread-seq/vm-scalability      11957423  12812682  +7%
> mmap-pread-seq-mt/vm-scalability   11771926  unavail   N/A
> lru-file-readtwice/vm-scalability  9016077   10408804  +15%
> lru-file-mmap-read/vm-scalability  8127192   7308375   -10%
>
> So it seems that MGLRU regressed for the last test. I'll find someone
> on our team to take a look.

Thanks.

--
Best Regards,
Yan, Zi

--=_MailMate_68EEDB6B-81D1-4B1D-9008-681FADA3654B_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXKZ4QPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU9HcQAImd3sZt22jkGCoynIBZzaY9Bty9Xml/Jbwv
zp0PMQp54J1Oh4aU0dAfoXI3RXNy+l+TsRNDG+0L0r+H+0715EPTlPcXw1+zJUgA
CCNfRmej6HOcadLuUkXvr5d6k140v3taciUVV2O7dUZxZYLYE1HlgPVW7iK7l3RM
Ay7YxOQ8vnIrMLB7Dxd5/4dhMTs6pcnoOkCZKHKoYxCP5gk2EQXzsHTgW5QSwY+v
mxPRfmKRv026a0yIYik2+GyzGNE4fUAq+yiMJFcBL/djpoJb/iAguqobQD0uhjHN
tSfclnM/Sq1XngGupFgk2usoEXMMEJhc7AyzA/tUbh1QeZv1QA000r2ls3fVOJk4
Uni0vKwqcZTEQFvmOphHTbxm1GL1P1AmQh9PqXNgsoUCjOEbAKt4uDk0Bt8Sb4eS
tW8eRwbjSyOnZCVkvQ/KspUcjqQJeOD4HBUNuTpMfIX6Ie2CcCz1h8zRyj4JBBtB
Lh39Yj0J1vUOw/5BjjqSySWC5suB/f4I8fBCYJYyZvqoCjm+M8UuJO5YXVuW6V93
I1qdleFM0rQKD9MOqSbxW+7jLcIWcaq1RybDekGr91oMONsPQmNV1CWJnSPm7TK1
H1m9eQv5DAdR5OJBudNTJxwZYOXk1cfklk2mAZRWBWeEs5yM8Ro/mMFEAS8zPqlU
KRSvpk4D
=JqOh
-----END PGP SIGNATURE-----

--=_MailMate_68EEDB6B-81D1-4B1D-9008-681FADA3654B_=--

