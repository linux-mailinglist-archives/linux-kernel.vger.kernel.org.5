Return-Path: <linux-kernel+bounces-129943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E4F897257
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BD3E1C26275
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A52149DE5;
	Wed,  3 Apr 2024 14:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="GXQUyQ/F"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4251A147C6C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 14:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712154003; cv=fail; b=DFv1s8GDTXeNzbU4dngbSHAA2J1347hxGSee++dknPNrGFnDdirG0augaO3Xvf56fqesg/W7KPYUBCz35QTrTIh5Zme2RhFS4GaDlw9NgnWforbjoi03xXOPyY+9JjpNPZ/ChvxKHiDJFMzYO9vkWeBXn+FfC1AzWduMeoNHno8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712154003; c=relaxed/simple;
	bh=r5dyDCIsF8RVthFnlae12cwJGHApQnj6xQuneQ5DnFY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jx23W31sCnyo6Ioy7Mq4ymn7Tp5xIH+4FKRYpbqYBL8YHfTbXa4woHKtVq27ctH9H2FOSjF7d2zaYrF/D8aO5LA+C4jHCQAEyubvvQs8YNCU3Z0u94L9ll0/DLONgjctA/59l920EkprkkqSVP1YMAroAWp9Ry3RtQbcgNsReQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=GXQUyQ/F; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43394CCN021388;
	Wed, 3 Apr 2024 07:19:22 -0700
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3x945bh0hc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 07:19:22 -0700 (PDT)
Received: from m0045851.ppops.net (m0045851.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.24/8.17.1.24) with ESMTP id 433EJLWg001783;
	Wed, 3 Apr 2024 07:19:21 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3x945bh0ha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 07:19:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ga2u7E3NHgCVZNNKM8y9nKbw4L1LySQZMwEadXdIx2UvhIa/IGTnpDY6MVEh60h7YGaPW5jnClUrkB/kSSRYAvU0SJRDBL1kYz0CBwFEq8g7J6oUfMTn/tQUS3fQ6mq+tKuvFpcjYsPf2TqtfT5GmisIXsZ9bZW+ZRYrZss/RJR+38eZQC6tYl0p5qWexdFp0zZQoSlaQ4K6PwogZOTh2uMu68kiNWDJkip5+UtfNAins7/0CZa33aNlU9aaj6IU4go75Hl4MVBvpoybWajL8cRBIORFZjCuVKjixQYSNZb+CKyobQGXSKhJ619jkrmlUzkx82OlPZxv0cmpyW315w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgvLwQaNDjxdvR0kSvkyzhnyGl1wu72BpxMTyI69uwM=;
 b=a5zgMpn+p/IADn2mW6phoHIAdmJSx6n4PXFM/+w668JBx/vqUWIk0qw/BJFmh4qyrMh6CMa3v7pkhxRositKquFMYpXyKqxLxD8ivGIgptkvjc0EzFYgvPBaoKHQmkvQKuxvw4hWpzT6MLqNQkyodRx0RIWfWG5SAR0A9TwiBCMbFuVLRWvWaq/6nyfwbk7QdmefucTAMSK4A1t0iG1HZQ8SoYCZF/JFvhALGtLD0dbcqR0zGXCW74wK1PbMrrl6CcV5Tcdag1E7LAvXdi66Wsx7cngQBO2CP3moMEJLLhyafmJ3EjDVk8fywAoM8iczogk0T6WWR+0FHw/FacNdvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgvLwQaNDjxdvR0kSvkyzhnyGl1wu72BpxMTyI69uwM=;
 b=GXQUyQ/FbB8q1GUG4bsm/91wkfZk3Br03RkMAsyaoWS/QMknX2LWpPRuIYfKWwK5IhCZdyIgTFhrmxvS/QHl7KayHWFlYPsuXKovg/9KOxKgATtXKzVuRGoxKztLuNvjbpcHLFWrD15H1UOSqsRhv67IRvEjR+vMncETLh/veZs=
Received: from PH0PR18MB5002.namprd18.prod.outlook.com (2603:10b6:510:11d::12)
 by SA1PR18MB5791.namprd18.prod.outlook.com (2603:10b6:806:3af::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 14:19:17 +0000
Received: from PH0PR18MB5002.namprd18.prod.outlook.com
 ([fe80::8bf7:91cd:866c:68b0]) by PH0PR18MB5002.namprd18.prod.outlook.com
 ([fe80::8bf7:91cd:866c:68b0%7]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 14:19:17 +0000
From: Linu Cherian <lcherian@marvell.com>
To: =?iso-8859-2?Q?Petr_Tesa=F8=EDk?= <petr@tesarici.cz>
CC: Petr Tesarik <petrtesarik@huaweicloud.com>,
        Christoph Hellwig
	<hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy
	<robin.murphy@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open
 list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
        Will Deacon
	<will@kernel.org>, Michael Kelley <mhklinux@outlook.com>,
        Roberto Sassu
	<roberto.sassu@huaweicloud.com>
Subject: RE: [EXTERNAL] Re: [PATCH 1/1] swiotlb: add a KUnit test suite
Thread-Topic: [EXTERNAL] Re: [PATCH 1/1] swiotlb: add a KUnit test suite
Thread-Index: AQHaf3YSt7N4hRILAEKaKw3KpKkMsbFWjwQQ
Date: Wed, 3 Apr 2024 14:19:17 +0000
Message-ID: 
 <PH0PR18MB50024739F4DCF8FCEB6F0CADCE3D2@PH0PR18MB5002.namprd18.prod.outlook.com>
References: <20240313092740.192-1-petrtesarik@huaweicloud.com>
	<20240326030851.GA64024@hyd1403.caveonetworks.com>
 <20240326130635.64fb3a98@meshulam.tesarici.cz>
In-Reply-To: <20240326130635.64fb3a98@meshulam.tesarici.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB5002:EE_|SA1PR18MB5791:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 UXDR0nHWnzoAFSKPDtLgIHo1vao8owlPjq1nNnYvmW+zbJxU1bM9m2jxM0/4oMDjfksSNshp4z5N+KUJFhFAp2hNtbCoZQAnwCz40c9o1qu+1RRazn2oIgpdpgh8tIQH996faYjHPeWclBWMFHf/V4WbIq+1pt2gSUw/j6aR+z/FrTdV0e4YDS+jeY0ZDgnaLia7PGhZyu55tYiR8rPm1Eqcruog8+csWxeCuVHJAiKC1dsryaSO3NHvAMszUdaSHlj6a+dGjblkauDXisNB08BR84ijA7NvAtHVLL1FdfmAorpyRASPurwfOb+igWcytaFzQ6ZbdueOczV7zmm7tQIOtxoNt0jWB20LyO3Z7gQUM4sWXBdxOH7NAQQRZQku13h3WpFfCBl4fCN4v0PWqLG70Qcc5b/p0zm+XR8XU/sSwFBrIhaKl8/6TKqJHrtUFTCnw5t0t4Q5W6M2HOavIOg6eGzWmyCpRCIY+GiGTz6PSsorc2dYeX2R41VGxJ1Ncb106Q89vgvzkl54yGRRHqYu2vCtcj6Ob1EvJHHvdz/wgwSRl0ambj2fuTfKbr1kJiUqz5+3mB34+xp5uZ9KCfspozMIMsDJk0l99jAIKrxbv43qZZWngthw2IooRuHMxGsA0REfEu9OCnT9TYYrpR8u0hphA8YcFfd8FcnrNJ4=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB5002.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-2?Q?WMnNuTj8gO+pxNsbhQmoHI0Vtr83WEzwpJDMo1eEDPaMab5CVzHbJ2b3xb?=
 =?iso-8859-2?Q?VyzDqHCTkU77/YsJUZI1nA7PGH+3J1vbR/GPhAvjDTVQhAXjSIK4ncdH8F?=
 =?iso-8859-2?Q?2jPafI+9ODnSL3ULIiveQBn1pfVzEr1+XSPT8luma7pMqJTwU5L6Jbx5Qx?=
 =?iso-8859-2?Q?M8xKA9OIoZ7AejQjgPbPe4LaZIr6jp4arxx1AnZuCNsJXIaUjqeQShyspz?=
 =?iso-8859-2?Q?8ZynJMNmhQSfmbY44MMbEmcsNCNmwIP/GO6OL6TsJYmbxiHsl6LDoG63X2?=
 =?iso-8859-2?Q?N8RV71Ai95F6gWGsEhBddP0GcDerL4yxau0ChtfonrIkYzX84KqZgWCfq3?=
 =?iso-8859-2?Q?bEltXWb1dckQvtXekjYc2bLNuFCPH1lIe3cnv7HvYWFDYC7xEsPxPRZqIa?=
 =?iso-8859-2?Q?uvD8OfvJipZI9VpASfyYavOP/PL+8LF5nla6qcgiT2FqBO+Q7ykSPehzMB?=
 =?iso-8859-2?Q?vNc1OxXU2lBIsjcrqYKcoqkds4hK9staEjBJqm8lpZgPmb2pk6jBR5Rzei?=
 =?iso-8859-2?Q?anIXIAjKLRqoCJL8FWt4FurIkCVmn+6AsQU8ykkuAW52RRro3oZnBIJQb7?=
 =?iso-8859-2?Q?SzOJE2OpU0bQFjLxkXK+FtjiLRnqNgnpJ3YRs7NS8FM5YwGCi1q+wVr18b?=
 =?iso-8859-2?Q?wETBKTnDsp8bInYOqQ/FJtl6qD6qIwNdwBAggzigbrYYxoRVOtMncHLZe4?=
 =?iso-8859-2?Q?PR8RqiV8cm2KOg8ShFoJ7ZYZc4Tzh9edBa1Suk7PMX/Y09J39TWQRRLBql?=
 =?iso-8859-2?Q?UNdG3B1e2pbH2dAj7A8/Z3q85AoRLmTyL4twm9u1yAjunVgJFTRWPa8/Rj?=
 =?iso-8859-2?Q?I4TAc8tDBd72pdhpt6Q+p869oYy9UteQVDDqYQnV1R2F0irqAYfXviJNsC?=
 =?iso-8859-2?Q?3MJUZHrgiJi1k2FvJBjDezAQA0WnSbqBqWRumLFbARN+xRtQhaXwic2leG?=
 =?iso-8859-2?Q?FPy3yOvjElm9enrCJjVQSYBCm/fos8nkD+8T0lvRgiImXX7/wnrzFxOxft?=
 =?iso-8859-2?Q?mwhNUxqx9sIpQ5lz8kA8/6oea8Jkrd87eEaeQB+E4zXEedwpbhLKyuXPHZ?=
 =?iso-8859-2?Q?6NcgmXziZjmI+thPsgUPMCRmYb8oPLRAY5f0SklBrP/Ja9oKj0/lzpVmK8?=
 =?iso-8859-2?Q?1Gwu2nls/wUI3fZ0f0byRLs4ifZWtstdteISImGejAIlP5h9Ne5zouCd1H?=
 =?iso-8859-2?Q?fiYKSE2QHeOQ6txhHwbo4BUrdT+0kWDGP5I51S/DmBihtcvTG9PPvlPY7M?=
 =?iso-8859-2?Q?g3Nv0H/vaW48rMUQMb1BHjOV2wQbX7bFjUS6npeAvq1bXm8Gd04KTyKZPT?=
 =?iso-8859-2?Q?klfBol2vk5YeaWH01bmXv6oLCf12Tj1nq+ozGJBNIfYsW4pe2K810eWH5O?=
 =?iso-8859-2?Q?0iLcg6fEZKsIe/M5BSbVjxIE6VI2QUGfNij0jgUkKcZDX2/UYstZLqBe6A?=
 =?iso-8859-2?Q?XLg7dhqPtRtI29Fv9mkkflr5HUcX5LfKdJHXUok3Ubz3ZjwpLHRoKIATpN?=
 =?iso-8859-2?Q?LEcQ7rlIoJLWf4+hDvvQSFZydUHuO7SaPMk6Oj/td5fX/mAV3sjnXZPHPG?=
 =?iso-8859-2?Q?ZtJwbRNacrqYsIraehM3FG1V8QekIkWPda98D/bnQuPAGTvP2d6YNS/8D3?=
 =?iso-8859-2?Q?BpK3lWsaYW4Y6jVIGMoYVPyq8IZZP3LzEi?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB5002.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82da514c-86cd-4a81-2b72-08dc53e90c2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 14:19:17.6237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sUt/4mlBStxLViTTE6++cuEGMbzxIWRXZGY0hJeFpUVLZIWcA3SWdwZxBA8lMxikUn+qdP7wJrpImC+sRUu4JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB5791
X-Proofpoint-GUID: 5FcV1ceOG8wFmigOanSSKDvfMPw16qww
X-Proofpoint-ORIG-GUID: 6V9hi-iUtLk8-2xesruZv5AcjTEmdFun
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_13,2024-04-03_01,2023-05-22_02

Hi Petr,

> -----Original Message-----
> From: Petr Tesa=F8=EDk <petr@tesarici.cz>
> Sent: Tuesday, March 26, 2024 5:37 PM
> To: Linu Cherian <lcherian@marvell.com>
> Cc: Petr Tesarik <petrtesarik@huaweicloud.com>; Christoph Hellwig
> <hch@lst.de>; Marek Szyprowski <m.szyprowski@samsung.com>; Robin
> Murphy <robin.murphy@arm.com>; open list <linux-
> kernel@vger.kernel.org>; open list:DMA MAPPING HELPERS
> <iommu@lists.linux.dev>; Will Deacon <will@kernel.org>; Michael Kelley
> <mhklinux@outlook.com>; Roberto Sassu
> <roberto.sassu@huaweicloud.com>
> Subject: [EXTERNAL] Re: [PATCH 1/1] swiotlb: add a KUnit test suite
>=20
> Prioritize security for external emails: Confirm sender and content safet=
y
> before clicking links or opening attachments
>=20
> ----------------------------------------------------------------------
> On Tue, 26 Mar 2024 08:38:51 +0530
> Linu Cherian <lcherian@marvell.com> wrote:
>=20
> > On 2024-03-13 at 14:57:40, Petr Tesarik (petrtesarik@huaweicloud.com)
> wrote:
> > > From: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> >
> > Hi,
>=20
> Hi Linu,
>=20
> > >
> > > Add unit tests to help avoid regressions in the SWIOTLB code.
> > >
> > > These features are covered by the test suite:
> > >
> > > * basic functionality (map, sync)
> > > * alignment based on mapping size
> > > * alignment based on min_align_mask
> > > * explicit alignment with alloc_align_mask
> > > * combination of alignment constraints
> > >
> > > Select CONFIG_SWIOTLB rather than depend on it, because it allows to
> > > run the test with UML (default KUnit target).
> > >
> > > Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> > > ---
> > >  kernel/dma/Kconfig        |  13 ++
> > >  kernel/dma/Makefile       |   1 +
> > >  kernel/dma/swiotlb_test.c | 413
> > > ++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 427 insertions(+)
> > >  create mode 100644 kernel/dma/swiotlb_test.c
> > >
> > > diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig index
> > > d62f5957f36b..44c62faa8d89 100644
> > > --- a/kernel/dma/Kconfig
> > > +++ b/kernel/dma/Kconfig
> > > @@ -103,6 +103,19 @@ config SWIOTLB_DYNAMIC
> > >
> > >  	  If unsure, say N.
> > >
> > > +config SWIOTLB_KUNIT_TEST
> > > +	tristate "Unit tests for software IO TLB" if !KUNIT_ALL_TESTS
> > > +	select SWIOTLB
> > > +	depends on KUNIT
> > > +	default KUNIT_ALL_TESTS
> > > +	help
> > > +	  Build unit tests for software IO TLB.
> > > +
> > > +	  For more information on KUnit and unit tests in general, please r=
efer
> > > +	  to the KUnit documentation in Documentation/dev-tools/kunit/.
> > > +
> > > +	  If unsure, say N.
> > > +
> > >  config DMA_BOUNCE_UNALIGNED_KMALLOC
> > >  	bool
> > >  	depends on SWIOTLB
> > > diff --git a/kernel/dma/Makefile b/kernel/dma/Makefile index
> > > 21926e46ef4f..bfb130020219 100644
> > > --- a/kernel/dma/Makefile
> > > +++ b/kernel/dma/Makefile
> > > @@ -7,6 +7,7 @@ obj-$(CONFIG_DMA_CMA)			+=3D
> contiguous.o
> > >  obj-$(CONFIG_DMA_DECLARE_COHERENT)	+=3D coherent.o
> > >  obj-$(CONFIG_DMA_API_DEBUG)		+=3D debug.o
> > >  obj-$(CONFIG_SWIOTLB)			+=3D swiotlb.o
> > > +obj-$(CONFIG_SWIOTLB_KUNIT_TEST)	+=3D swiotlb_test.o
> > >  obj-$(CONFIG_DMA_COHERENT_POOL)		+=3D pool.o
> > >  obj-$(CONFIG_MMU)			+=3D remap.o
> > >  obj-$(CONFIG_DMA_MAP_BENCHMARK)		+=3D map_benchmark.o
> > > diff --git a/kernel/dma/swiotlb_test.c b/kernel/dma/swiotlb_test.c
> > > new file mode 100644 index 000000000000..46e4d8055ef5
> > > --- /dev/null
> > > +++ b/kernel/dma/swiotlb_test.c
> > > @@ -0,0 +1,413 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Copyright (C) 2024 Huawei Technologies Duesseldorf GmbH  */
> > > +
> > > +#include <kunit/test.h>
> > > +#include <kunit/device.h>
> > > +
> > > +#include <linux/device.h>
> > > +#include <linux/dma-mapping.h>
> > > +#include <linux/io.h>
> > > +#include <linux/kdev_t.h>
> > > +#include <linux/swiotlb.h>
> > > +
> > > +/* Alignment check repeat count. */
> > > +#define NUM_CHECK_ALIGNED	5
> > > +
> > > +/* Offset of mapped data inside the allocated buffer. */
> > > +#define MAP_OFF	128
> > > +
> > > +#define PASS	0x600d600d
> > > +#define FAIL	0xbad00bad
> > > +
> > > +static struct {
> > > +	unsigned char pad1[MAP_OFF];
> > > +	unsigned long value;
> > > +	unsigned char pad2[PAGE_SIZE];
> > > +} test_data __page_aligned_bss;
> > > +
> > >
> +/**********************************************************
> ****
> > > + * Various helper functions.
> > > + */
> > > +
> > > +static int swiotlb_suite_init(struct kunit_suite *suite) {
> > > +	if (is_swiotlb_allocated())
> > > +		return 0;
> > > +
> > > +	return swiotlb_init_late(swiotlb_size_or_default(), GFP_KERNEL,
> > > +NULL); }
> > > +
> > > +static int swiotlb_drv_probe(struct device *dev) {
> > > +	dev->dma_parms =3D devm_kzalloc(dev, sizeof(*dev->dma_parms),
> > > +				      GFP_KERNEL);
> > > +	if (!dev->dma_parms)
> > > +		return -ENOMEM;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int swiotlb_test_init(struct kunit *test) {
> > > +	struct device_driver *driver;
> > > +
> > > +	driver =3D kunit_driver_create(test, "swiotlb_driver");
> > > +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, driver);
> > > +	driver->probe =3D swiotlb_drv_probe;
> > > +
> > > +	test->priv =3D driver;
> > > +	return 0;
> > > +}
> > > +
> > > +/**
> > > + * test_device() - get a dummy device for testing
> > > + * @test:  KUnit test instance.
> > > + *
> > > + * Allocate a device suitable for SWIOTLB.
> > > + */
> > > +static struct device *test_device(struct kunit *test) {
> > > +	struct device_driver *driver =3D test->priv;
> > > +	struct device *dev;
> > > +	u64 mask;
> > > +
> > > +	dev =3D kunit_device_register_with_driver(test, "swiotlb", driver);
> > > +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
> > > +
> > > +	mask =3D DMA_BIT_MASK(64);
> > > +	KUNIT_ASSERT_EQ(test, dma_coerce_mask_and_coherent(dev,
> mask), 0);
> > > +
> > > +	return dev;
> > > +}
> > > +
> > > +/**
> > > + * check_aligned() - check that bounce buffers are aligned
> > > + * @test:   KUnit test instance.
> > > + * @dev:    Device.
> > > + * @buf:    Pointer to the original buffer.
> > > + * @size:   Size of the original buffer.
> > > + * @align:  Allocation alignment (in bytes).
> > > + * @check_bits:
> > > + *          Number of low bits checked in the swiotlb address.
> > > + * @preserve_bits:
> > > + *          Number of low bits preserved from the original address.
> > > + *
> > > + * Mapping is repeated a few times, and a small buffer is allocated
> > > +after
> > > + * each attempt. This should cover the case when the first free
> > > +slot merely
> > > + * happens to be suitably aligned.
> > > + */
> > > +static void check_aligned(struct kunit *test, struct device *dev,
> > > +			  void *buf, size_t size, unsigned long align,
> > > +			  int check_bits, int preserve_bits) {
> > > +	dma_addr_t tlb_addr[NUM_CHECK_ALIGNED];
> > > +	dma_addr_t pad_addr[NUM_CHECK_ALIGNED];
> > > +	u64 check_mask, check_val;
> > > +	phys_addr_t phys_addr;
> > > +	char *orig, *tlb;
> > > +	int i;
> > > +
> > > +	orig =3D (char *)buf;
> > > +	phys_addr =3D virt_to_phys(buf);
> > > +	check_mask =3D DMA_BIT_MASK(check_bits);
> > > +	check_val =3D phys_addr & DMA_BIT_MASK(preserve_bits);
> > > +
> > > +	for (i =3D 0; i < NUM_CHECK_ALIGNED; ++i) {
> > > +		tlb_addr[i] =3D
> > > +			swiotlb_tbl_map_single(dev, phys_addr, size, size,
> > > +					       align - 1, DMA_TO_DEVICE, 0);
> > > +		KUNIT_ASSERT_NE(test, tlb_addr[i], DMA_MAPPING_ERROR);
> > > +		KUNIT_EXPECT_TRUE(test, is_swiotlb_buffer(dev, tlb_addr[i]));
> > > +		KUNIT_EXPECT_EQ(test, tlb_addr[i] & check_mask,
> check_val);
> > > +
> > > +		/* Check sync in both directions. */
> > > +		tlb =3D phys_to_virt(tlb_addr[i]);
> > > +		KUNIT_EXPECT_EQ(test, *orig, *tlb);
> > > +		*orig ^=3D 0xff;
> > > +		swiotlb_sync_single_for_device(dev, tlb_addr[i],
> sizeof(*orig),
> > > +					       DMA_TO_DEVICE);
> > > +		KUNIT_EXPECT_EQ(test, *orig, *tlb);
> > > +		*tlb ^=3D 0xff;
> > > +		swiotlb_sync_single_for_cpu(dev, tlb_addr[i], sizeof(*orig),
> > > +					    DMA_FROM_DEVICE);
> > > +		KUNIT_EXPECT_EQ(test, *orig, *tlb);
> > > +
> > > +		pad_addr[i] =3D swiotlb_map(dev, phys_addr, sizeof(long),
> > > +					  DMA_TO_DEVICE, 0);
> > > +		KUNIT_ASSERT_NE(test, pad_addr[i], DMA_MAPPING_ERROR);
> > > +	}
> > > +
> > > +	for (i =3D 0; i < NUM_CHECK_ALIGNED; ++i) {
> > > +		swiotlb_tbl_unmap_single(dev, pad_addr[i], sizeof(long),
> > > +					 DMA_FROM_DEVICE, 0);
> > > +		swiotlb_tbl_unmap_single(dev, tlb_addr[i], size,
> > > +					 DMA_FROM_DEVICE, 0);
> > > +	}
> > > +}
> > > +
> > >
> +/**********************************************************
> ****
> > > + * Map a DMA buffer.
> > > + *
> > > + * Test that a DMA buffer can be mapped and synced.
> > > + */
> > > +
> > > +static void swiotlb_test_map(struct kunit *test) {
> > > +	struct device *dev =3D test_device(test);
> > > +	phys_addr_t phys_addr;
> > > +	dma_addr_t tlb_addr;
> > > +	unsigned long *tlb;
> > > +
> > > +	phys_addr =3D virt_to_phys(&test_data.value);
> > > +	test_data.value =3D PASS;
> > > +	tlb_addr =3D swiotlb_map(dev, phys_addr, sizeof(unsigned long),
> > > +			       DMA_TO_DEVICE, 0);
> > > +	KUNIT_ASSERT_NE(test, tlb_addr, DMA_MAPPING_ERROR);
> > > +	KUNIT_EXPECT_TRUE(test, is_swiotlb_buffer(dev, tlb_addr));
> > > +	tlb =3D phys_to_virt(tlb_addr);
> > > +
> > > +	/* Bounce buffer is initialized to original buffer. */
> > > +	KUNIT_EXPECT_EQ(test, *tlb, PASS);
> > > +
> > > +	/* Bounce buffer is updated on sync to device. */
> > > +	test_data.value =3D PASS + 1;
> > > +	swiotlb_sync_single_for_device(dev, tlb_addr, sizeof(unsigned long)=
,
> > > +				       DMA_TO_DEVICE);=09
> > > +	KUNIT_EXPECT_EQ(test, *tlb, PASS + 1);
> > > +
> > > +	/* Original buffer is updated on sync from device. */
> > > +	*tlb =3D PASS + 2;
> > > +	swiotlb_sync_single_for_cpu(dev, tlb_addr, sizeof(unsigned long),
> > > +				    DMA_FROM_DEVICE);
> > > +	KUNIT_EXPECT_EQ(test, test_data.value, PASS + 2);
> >
> > Should we not try this on a buffer that is mapped with DMA_FROM_DEVICE =
?
>=20
> I'm afraid I don't follow.
>=20
> AFAICT the direction is a property of the sync operation. In fact,
> swiotlb_tbl_map_single() does not even use its direction parameter at all=
.
> Removing that parameter is already on my TODO list of cleanups.
>=20

Okay. Got it.

> swiotlb_map() uses its direction parameter only to perform the initial ar=
ch
> sync if DMA is non-coherent.
>=20
> OTOH I may be missing some high-level logical concepts which do not
> correspond to any actual code in the swiotlb implementation, so my use is=
 still
> wrong.
>=20

Just thought that the keeping the DMA direction consistent for the map and =
sync would be more aligned to typical use case.
For example, a buffer used for transmit in case of networking. OTOH, since =
the API by itself doesn't have such constraints on the direction parameter,=
 may be it makes sense to test those scenarios.


> > > +
> > > +	/* Original buffer is also updated on unmap. */
> > > +	*tlb =3D PASS + 3;
> > > +	swiotlb_tbl_unmap_single(dev, tlb_addr, sizeof(unsigned
> > > long),
> > > +				 DMA_FROM_DEVICE, 0);
> > > +	KUNIT_EXPECT_EQ(test, test_data.value, PASS + 3); }
> > > +
> > >
> +/**********************************************************
> ****
> > > + * Map DMA buffer as bi-directional.
> > > + *
> > > + * Test that buffer is synced with DMA_BIDIRECTIONAL.
> > > + */
> > > +
> > > +static void swiotlb_test_bidirectional(struct kunit *test) {
> > > +	struct device *dev =3D test_device(test);
> > > +	phys_addr_t phys_addr;
> > > +	dma_addr_t tlb_addr;
> > > +	unsigned long *tlb;
> > > +
> > > +	test_data.value =3D PASS;
> > > +	phys_addr =3D virt_to_phys(&test_data.value);
> > > +	tlb_addr =3D swiotlb_map(dev, phys_addr, sizeof(unsigned
> > > long),
> > > +			       DMA_BIDIRECTIONAL, 0);
> > > +	KUNIT_ASSERT_NE(test, tlb_addr, DMA_MAPPING_ERROR);
> > > +	KUNIT_EXPECT_TRUE(test, is_swiotlb_buffer(dev, tlb_addr));
> > > +	tlb =3D phys_to_virt(tlb_addr);
> > > +
> > > +	/* Bounce buffer is initialized to original buffer. */
> > > +	KUNIT_EXPECT_EQ(test, *tlb, PASS);
> > > +
> > > +	/* Original buffer is updated on unmap. */
> > > +	*tlb =3D PASS + 1;
> > > +	swiotlb_tbl_unmap_single(dev, tlb_addr, sizeof(unsigned
> > > long),
> > > +				 DMA_BIDIRECTIONAL, 0);
> > > +	KUNIT_EXPECT_EQ(test, test_data.value, PASS + 1); }
> > > +
> > >
> +/**********************************************************
> ****
> > > + * Skip sync on unmap.
> > > + *
> > > + * Test that sync does not happen with DMA_ATTR_SKIP_CPU_SYNC.
> > > + * On swiotlb_map(), this flag skips only sync for non-coherent
> > > + * DMA; the bounce buffer itself is always synced to the
> > > + * original buffer.
> > > + */
> > > +
> > > +static void swiotlb_test_skip_sync(struct kunit *test) {
> > > +	struct device *dev =3D test_device(test);
> > > +	phys_addr_t phys_addr;
> > > +	dma_addr_t tlb_addr;
> > > +	unsigned long *tlb;
> > > +
> > > +	test_data.value =3D PASS;
> > > +	phys_addr =3D virt_to_phys(&test_data.value);
> > > +	tlb_addr =3D swiotlb_map(dev, phys_addr, sizeof(unsigned
> > > long),
> > > +			       DMA_TO_DEVICE,
> > > DMA_ATTR_SKIP_CPU_SYNC);
> > > +	KUNIT_ASSERT_NE(test, tlb_addr, DMA_MAPPING_ERROR);
> > > +	KUNIT_EXPECT_TRUE(test, is_swiotlb_buffer(dev, tlb_addr));
> > > +	tlb =3D phys_to_virt(tlb_addr);
> > > +
> > > +	/* Bounce buffer is initialized to original buffer anyway.
> > > */
> > > +	KUNIT_EXPECT_EQ(test, *tlb, PASS);
> > > +
> > > +	/* Original buffer is not updated on unmap. */
> > > +	*tlb =3D FAIL;
> > > +	swiotlb_tbl_unmap_single(dev, tlb_addr, sizeof(unsigned
> > > long),
> > > +				 DMA_FROM_DEVICE,
> > > DMA_ATTR_SKIP_CPU_SYNC);
> > > +	KUNIT_EXPECT_EQ(test, test_data.value, PASS); }
> > > +
> > >
> +/**********************************************************
> ****
> > > + * Historical page alignment.
> > > + *
> > > + * Test that mappings of at least PAGE_SIZE get a page-aligned
> > > + * DMA address.
> > > + */
> > > +
> > > +static void swiotlb_test_page_align(struct kunit *test) {
> > > +	struct device *dev =3D test_device(test);
> > > +
> > > +	/* Bounce buffer is page-aligned. */
> > > +	check_aligned(test, dev, &test_data, sizeof(test_data), 1,
> > > +		      PAGE_SHIFT, 0);
> > > +
> > > +	/* Even if the original buffer is not page-aligned. */
> > > +	check_aligned(test, dev, &test_data.value, PAGE_SIZE, 1,
> > > +		      PAGE_SHIFT, 0);
> > > +}
> > > +
> > >
> +/**********************************************************
> ****
> > > + * Device physical address alignment.
> > > + *
> > > + * Test that physical address low bits are preserved.
> > > + */
> > > +
> > > +static void check_min_align(struct kunit *test, int bits) {
> > > +	u64 min_align_mask =3D DMA_BIT_MASK(bits);
> > > +	struct device *dev =3D test_device(test);
> > > +	unsigned long vaddr;
> > > +	void *ptr;
> > > +
> > > +	KUNIT_ASSERT_EQ(test, dma_set_min_align_mask(dev,
> > > min_align_mask), 0); +
> > > +	vaddr =3D devm_get_free_pages(dev, GFP_KERNEL,
> > > +				    bits > PAGE_SHIFT ? bits -
> > > PAGE_SHIFT : 0);
> > > +	KUNIT_ASSERT_NE(test, vaddr, 0);
> > > +
> > > +	/* Check low bits */
> > > +	ptr =3D (void *)vaddr + MAP_OFF;
> > > +	check_aligned(test, dev, ptr, sizeof(long), 1, bits, bits);
> > > +
> > > +	/* Check high bits */
> > > +	ptr =3D (void *)vaddr + (1UL << bits) - MAP_OFF -
> > > sizeof(long);
> > > +	check_aligned(test, dev, ptr, sizeof(long), 1, bits, bits);
> > > +
> > > +	kunit_device_unregister(test, dev); }
> > > +
> > > +static void swiotlb_test_min_align(struct kunit *test) {
> > > +	check_min_align(test, 12);
> > > +	check_min_align(test, PAGE_SHIFT);
> > > +	check_min_align(test, 16);
> > > +}
> > > +
> > >
> +/**********************************************************
> ****
> > > + * Explicit allocation alignment.
> > > + *
> > > + * Test that the bounce buffer is aligned to an explicit value
> > > + * regardless of allocation size.
> > > + */
> > > +
> > > +static void check_alloc_align(struct kunit *test, int bits) {
> > > +	struct device *dev =3D test_device(test);
> > > +	void *base, *ptr;
> > > +	size_t size;
> > > +
> > > +	size =3D 1UL << bits;
> > > +	base =3D devm_kmalloc(dev, size, GFP_KERNEL);
> > > +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, base);
> > > +
> > > +	/* Check low bits */
> > > +	ptr =3D base + MAP_OFF;
> > > +	check_aligned(test, dev, ptr, sizeof(long), size, bits, 0);
> > > +
> > > +	/* Check high bits */
> > > +	ptr =3D base + size - MAP_OFF - sizeof(long);
> > > +	check_aligned(test, dev, ptr, sizeof(long), size, bits, 0);
> > > +
> > > +	kunit_device_unregister(test, dev); }
> > > +
> > > +static void swiotlb_test_alloc_align(struct kunit *test) {
> > > +	check_alloc_align(test, 12);
> > > +	check_alloc_align(test, 14);
> > > +}
> > > +
> > >
> +/**********************************************************
> ****
> > > + * Both allocation and device physical address alignment.
> > > + *
> > > + * Test that the bounce buffer is aligned to an explicit value
> > > + * regardless of allocation size and it also preserves physical
> > > + * address low bits.
> > > + */
> > > +
> > > +static void check_both_align(struct kunit *test, int
> > > min_align_bits,
> > > +			     int alloc_align_bits)
> > > +{
> > > +	u64 min_align_mask =3D DMA_BIT_MASK(min_align_bits);
> > > +	struct device *dev =3D test_device(test);
> > > +	void *base, *ptr;
> > > +	size_t size;
> > > +
> > > +	KUNIT_ASSERT_EQ(test, dma_set_min_align_mask(dev,
> > > min_align_mask), 0); +
> > > +	size =3D 1UL << max(min_align_bits, alloc_align_bits);
> > > +	base =3D devm_kmalloc(dev, size, GFP_KERNEL);
> > > +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, base);
> > > +
> > > +	/* Check low bits */
> > > +	ptr =3D base + MAP_OFF;
> > > +	check_aligned(test, dev, ptr, sizeof(long), size,
> > > +		      min_align_bits, min_align_bits);
> > > +
> > > +	/* Check high bits */
> > > +	ptr =3D base + size - MAP_OFF - sizeof(long);
> > > +	check_aligned(test, dev, ptr, sizeof(long), size,
> > > +		      min_align_bits, min_align_bits);
> > > +
> > > +	kunit_device_unregister(test, dev); }
> > > +
> > > +static void swiotlb_test_both_align(struct kunit *test) {
> > > +	check_both_align(test, 12, 12);
> > > +	check_both_align(test, 12, 16);
> > > +	check_both_align(test, 14, 16);
> > > +}
> > > +
> > >
> +/**********************************************************
> ****
> > > + * Test suite metadata.
> > > + */
> > > +
> > > +static struct kunit_case swiotlb_test_cases[] =3D {
> > > +	KUNIT_CASE(swiotlb_test_map),
> > > +	KUNIT_CASE(swiotlb_test_bidirectional),
> >
> > For better coverage, can we keep seperate tests for each direction ?
> > May be we could have a common function that takes direction as an
> > argument.
>=20
> Ack. Finer granularity will help us understand test reports.
>=20
> Thank you for looking at my code!
>=20
> Petr T

