Return-Path: <linux-kernel+bounces-145061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B908A4EEC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A86501F22240
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B1A6AF88;
	Mon, 15 Apr 2024 12:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="NbLAhqZx"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2086.outbound.protection.outlook.com [40.92.20.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FC7634E2
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 12:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713183807; cv=fail; b=MCx1wgiNZn2MQSKPw8vC0cCq0ufa98dMJv0LeR7fXTar0LJYpjoGJ+NMFJpkENjuT2r0O3eyijBvO8esNRhq5nVRoMHPKMBujMswJ7Lo5y/JUR1qSIUNvOO14RMT0r3W/cuhlRBWR5sugkGAT6inoiL+SrHzFD9FvmQr0YZZ/R8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713183807; c=relaxed/simple;
	bh=u1BjbmFssoGsfl04oMfy1juLXrWUzob6y0M+X48jKSA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XSnjW7NGmveitmqnG8G26N6Tfy4Mr0tmUMeNK1CZ1PYHoWlqJJepBfOuqSdKTgRWenZftMDI4U260IkkaS3oWkg+vDI3JmhcdHdiGR7FBbNNKzymWUBN136A8PiJJOubpom4A0rtzUgR1MhYFtCd4auFs+NX4pyKDUHipijOH9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=NbLAhqZx; arc=fail smtp.client-ip=40.92.20.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUN6rfCd+3+u7WecpObDg3Q6+bYuD9V06JDy/JWYsgn+rg54bv7JIQPi+CUqO/H2imJbTJSC/Afjn6Rnc/24XMtCmN/iqRibdlnQ5YEbdanZ8CtvkRYnijxL6hPAZVKCKJpvLiio1m+CbFM+bV/v6gv7quJAkds2rrFSPYQ6LNgcycL05cAScInhvZiMikv15YavWoG8OHqshjExfNneejopanlrX5ndbrb8F200vEzdlCBz2bUwOIfxSA/5/FbHwYWYb+4VSmtHr2JYOvXmmDs8HP9Lds+3vC/MVwK5XktDVQi1giLHAVUFFCJwpL3IsblUQQRTcu5EnAY0uIjxXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MhZDabTrpvrJ2J9E/cCi/rE8K3tSlcY4iGhn8KHCGI=;
 b=K/wGIKAPdOkj+WVTCscpZE0zTD6atY4SfD3IjOogw30sSfF9CSnIGvfab2V9AVfgaIi1yLPC21FIFOki+ZNgdAH9OBfDDB0glKSTXX9Oq9/OhdCdraOtGkPCoi5u/6xksJyiLTPHqvywY0uoHAwMbzLc/b0UI+/QWgO+SAomVOzYiqfRGh7zn/I8w3GFlC14O56RG3wcRbAIIvvpGx/fo+ziFlOFSzHeOgnUSt1HL8SNaYDOGLCeJwqUnuPRbUzFVUWgA4WGPH2OUff3OIcHMih6y3YoT7Ysj28DZu2f/hToAbNdFu43ZC6zmhkXbAbyt2alFL7lIuVyZgAyawTTeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MhZDabTrpvrJ2J9E/cCi/rE8K3tSlcY4iGhn8KHCGI=;
 b=NbLAhqZxM0ymy5DJu9QhEe6mNJ9u9ZKooj/RFNicvJKCRwA8D9xrmqG65XcwnKNHeYnpSccsM3EPYphV0QiTmFMWS+tPSA+sZiNXl6nM5F0NbuSyQb72nfgJHiLFzGD51XkZYj3B4oW9Z5icCFd4HEX489BmwnoIoKU7wlkr1O58ca1rndbKy2B3tSpeN2g2xXogx12uuhngoBKMcCHXgJTMijifsWRP2kotAhZOzlryRn8/awMDRGF/gLafQIYVgODXDaW83gsGnwLlTTi8Cc8F8KcuuxItqD2AtCAwoFBcYBoigAAHUBj4dS0eJqzEuKGMPx7kWvbptq1uQOkong==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BL3PR02MB8185.namprd02.prod.outlook.com (2603:10b6:208:338::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 12:23:23 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596%5]) with mapi id 15.20.7409.053; Mon, 15 Apr 2024
 12:23:22 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: =?iso-8859-2?Q?Petr_Tesa=F8=EDk?= <petr@tesarici.cz>,
	"mhkelley58@gmail.com" <mhkelley58@gmail.com>
CC: "robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>, "jgross@suse.com"
	<jgross@suse.com>, "sstabellini@kernel.org" <sstabellini@kernel.org>,
	"oleksandr_tyshchenko@epam.com" <oleksandr_tyshchenko@epam.com>, "hch@lst.de"
	<hch@lst.de>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
	"roberto.sassu@huaweicloud.com" <roberto.sassu@huaweicloud.com>
Subject: RE: [PATCH 1/2] swiotlb: Remove alloc_size argument to
 swiotlb_tbl_map_single()
Thread-Topic: [PATCH 1/2] swiotlb: Remove alloc_size argument to
 swiotlb_tbl_map_single()
Thread-Index: AQHaiWsCp8JQSGA74EyasRMxVkBb5LFpQj8AgAAIqdA=
Date: Mon, 15 Apr 2024 12:23:22 +0000
Message-ID:
 <SN6PR02MB4157C8206FE193B2C5B2A93FD4092@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240408041142.665563-1-mhklinux@outlook.com>
 <20240415134624.22092bb0@meshulam.tesarici.cz>
In-Reply-To: <20240415134624.22092bb0@meshulam.tesarici.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn:
 [LWNEHOfj6DDOT/nyurn4SJkUTEsWk85TEa4IfLRChvEwrvZhf/lhCuh9QOWDtEVmrd6meoCL3Uc=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BL3PR02MB8185:EE_
x-ms-office365-filtering-correlation-id: 24bf1e2d-6ad3-4727-0ec2-08dc5d46d77f
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 RgGwZzlvwRuOuNVG0dcPFfPNkwrhYDk/rME9bThLq/YMO1SNhseZB+ZsC8JRybttGqsJ8jHNHMGYbwJ1NhvexkuPOYck2CgkD3IT0KjsmhFV7TYmhPIrGvANVMRjSmh/MBGlWVDX5IwvVV4noOcZp0NjFVVzdbQhn5Y+Z/2Ibs72nYabTqWBla/4nIdaoQsW5wOqPEK0LgLjg7EU9FrhzwJPGRJXwTJaTD00nkMrISXFE+5RnPdjlsDpqU2hXzkM2tycb0ncWfqs1TYOOTBHWqcBFESqAHlq8e9XdIIkcRRYyOhObCw3riyqV5Dv/vZ8Uw4zQTeH2XS2ndWBwHw/mC5YplLxa6DcN/tLtlrDH7mt0rI0nyoZ+7QSiyIqer13P+AfoWucVfMEQnavVNVD9r7SxAOYfUxq0wghoC64WQeTPC1ojbT4Wx7+DKmRzc1I10tU1Aw3kUAEJp+wuhcc+YeVXI7I43oiLS7axMgTxUwekWh7N5l2kZ1ub1u5UBxNzw15hf8HhNfQstYlUv5XJ2oSw6haTgWrW644eIteSlWiTUbRMvQIbz7loU532yTB
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?tiaqRuH7lsvYapt1Sm7t4lcaedyTTyH1r3jfUXn5lkYlv/y1Vzkv07+goT?=
 =?iso-8859-2?Q?v9YPma/rA2Al/gPTJc6Bqe1GRPnbssM/uNXQQY/JBr5xZbgkskCSucCpNR?=
 =?iso-8859-2?Q?UYxd878BZpTyDc+5nKYjpbfW5wdZuAPDPtDPgLXDCaKptzqDKt2zkOD+tg?=
 =?iso-8859-2?Q?y1cB9TITk/TXjM7qdjuZwtZYzOUR0JTlAde2BxaLvguUPQNY7pYxHPPn3c?=
 =?iso-8859-2?Q?vSLKBqypZwzELQOV3OPQigVSqXFIixpudnsl+CBpvcVCNAmUAaMfTlhl3H?=
 =?iso-8859-2?Q?qh4j17sZrEuhVB0aOdI5L9F79aNbLAo0+q4wC3SOygrKYCeNU8aBjm/DKg?=
 =?iso-8859-2?Q?nof+dJarJoIehA5j56RKFLhE64D0cpnK+S8v7EhveKT3U4Ybs8tNbI/7cw?=
 =?iso-8859-2?Q?RdiBoYhfW/uJQF1Myjfk4kMJ6UVW9Vn3iYD/3wFZjWHigEojgnDrshEjXh?=
 =?iso-8859-2?Q?jI++8i99bmB1Lig2LiVmYbHwTyQfOuyycsdmltMGwqx230q/4IKgspsrgv?=
 =?iso-8859-2?Q?4Pe01ucibVgeE+Ifpa5CUxh+XdImY4hessuZ0Mdrzg9T4+HyjXnEcDPJyf?=
 =?iso-8859-2?Q?1li/yHSzrv4vjZ3UXp8/3RLa5AdVtah+XbDTLnJgjg92YssLnyMZG/VyLY?=
 =?iso-8859-2?Q?n+X9H25Mo4ZAmyK55celMwn1gUHDdnJ1y8A/pFvy+phbkkZFfqPEuUnflZ?=
 =?iso-8859-2?Q?qvqSbHBZ0yNCs68G9UIu68UZnD3hPVQrwL4+SE2QvC/qXKwl1o2XQ/EEdA?=
 =?iso-8859-2?Q?1Jm2bK9X0PU5V0tSvP9kxoAfsOFsDT1calK1fT3NOYRAYcdMatB6hBhGNy?=
 =?iso-8859-2?Q?hygwS48Ki8h0gHRUc5Y4K2yhEOnZmeTt7UzOMuqZH01NaVo1pV91MsT2dj?=
 =?iso-8859-2?Q?lgXaszVJd+nImZLi12uKhVMVLUCeuA8mCYnOxmuzfCjEiz1j8+PDT7yVfS?=
 =?iso-8859-2?Q?Q016AK7ClMvOsh0B2oyLqiREKoKfRPEOySn+ls5he1y4P86BssaSKPZ5zl?=
 =?iso-8859-2?Q?o1xFlNzWy1Z413Vc7ZiqA+uOojU0ayT8K29vU4lgQPeyuFWXgynfGhBZ+i?=
 =?iso-8859-2?Q?TNtl9/pRmsGAeAotXxcp8waAzB0Axfcx2WSC4GdOrTIhLv7+Cy8RbkyDy8?=
 =?iso-8859-2?Q?wVqnrFbEHy13yC5FVLnaDE41uqDoptphQnrCjoCXKfnvtbVpD2Xvaioak6?=
 =?iso-8859-2?Q?eXilC3mRHJkR9mAw9BhmHEM8636zOWTdcbbIYt6Sk4cpNQl3woCuGMethT?=
 =?iso-8859-2?Q?NGgIWKk9YAxwSDnP4ow4Phs3eIpvDuf7hfAVwxutd5wT7srxiFDQBRkqpr?=
 =?iso-8859-2?Q?ItTbRc3Y4TrQaGaNJSTLW/reug1TGx0+tXbYyPaqmUjBobY=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 24bf1e2d-6ad3-4727-0ec2-08dc5d46d77f
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 12:23:22.3777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8185

From: Petr Tesa=F8=EDk <petr@tesarici.cz> Sent: Monday, April 15, 2024 4:46=
 AM
>=20
> Hi Michael,
>=20
> sorry for taking so long to answer. Yes, there was no agreement on the
> removal of the "dir" parameter, but I'm not sure it's because of
> symmetry with swiotlb_sync_*(), because the topic was not really
> discussed.
>=20
> The discussion was about the KUnit test suite and whether direction is
> a property of the bounce buffer or of each sync operation. Since DMA API
> defines associates each DMA buffer with a direction, the direction
> parameter passed to swiotlb_sync_*() should match what was passed to
> swiotlb_tbl_map_single(), because that's how it is used by the generic
> DMA code. In other words, if the parameter is kept, it should be kept
> to match dma_map_*().
>=20
> However, there is also symmetry with swiotlb_tbl_unmap_single(). This
> function does use the parameter for the final sync. I believe there
> should be a matching initial sync in swiotlb_tbl_map_single(). In
> short, the buffer sync for DMA non-coherent devices should be moved from
> swiotlb_map() to swiotlb_tbl_map_single(). If this sync is not needed,
> then the caller can (and should) include DMA_ATTR_SKIP_CPU_SYNC in
> the flags parameter.
>=20
> To sum it up:
>=20
> * Do *NOT* remove the "dir" parameter.
> * Let me send a patch which moves the initial buffer sync.
>=20

I'm not seeing the need to move the initial buffer sync.  All
callers of swiotlb_tbl_map_single() already have a subsequent
check for a non-coherent device, and a call to=20
arch_sync_dma_for_device().  And the Xen code has some=20
special handling that probably shouldn't go in
swiotlb_tbl_map_single().  Or am I missing something?

Michael

