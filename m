Return-Path: <linux-kernel+bounces-166524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AAB8B9BD2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 060821C2139F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAC613C67D;
	Thu,  2 May 2024 13:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="AfbzXStU"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02olkn2023.outbound.protection.outlook.com [40.92.15.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9896B7441E;
	Thu,  2 May 2024 13:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.15.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714657557; cv=fail; b=pCKlVwN9He9CIeaiCvZ+jgxMfU0kzvE24gLePvHv/BsAPR9LoXQ7wsF4ds7THV8q+ejoaQspTP4p/K9gZhNI+xhF5yKhHSnNEbSjP7l4wQTeTtXKA2rfuxaYOuEczWCubxRd++Va1m02x47GyuIPCrqf1dRMCp6HHBs5VUs6MPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714657557; c=relaxed/simple;
	bh=HWck4i3GXgewUmHoX+KxIZebKrV1W7CiWL6Jk2Okdq0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iQrhvPrfy+SpOZ0qEdxtCbzlJ9GWH27kNdsBzS6TO8XEVJozMgIxK2cgQrUakJM+9fdX1XkjD/sNFjNaSlD8VV+FQLW6PwOgeukNbUBqeGEzzZf28CwhlcJ/2GvNQx+04AfvW6kH0iUwQHyEkyQScYCxpFG6B00eTO4gc6+lu7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=AfbzXStU; arc=fail smtp.client-ip=40.92.15.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGlSuP0VVXnQenxXfixeWt34TQYZ4Ess5j9XDWGkKhGTt5Bv4A8/8PF38xELfMoKLPE1BmyA7yIZsebgw9JsABf/m4edHvaV3wSv67xN779bKgOAPS4biJaMoDipxt62EMIBGvaGmp/g8i3O+AbzGm4YZCAA5a68hTOt68meA6YH4RU93yk1MiTTCHqbuYAdF/DHQDAzQs9/kiKXuMWs5m44qMTDlAtf1t/zuB7HRZnRwsPCXShAXoJXDhoyurz7Bk93wuJWBj1flSgdCQYp5lse5zvZnTQKVNbRDjhZYOhWtaqZeAQt+Iafih9/as2uJBiG9P3V2G9YhUq1laZY+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWck4i3GXgewUmHoX+KxIZebKrV1W7CiWL6Jk2Okdq0=;
 b=DGvqkt6GyGcLEmOjX3kJGJmFAvMf0TEHZ+NFnM9orrApshg42n/OFsEbqGIIayHEu9y1sCQd1eUueUB8uLf4ix8Y0vD43nDzX0TGSJY7Kpq5m3xdrpqpNg6J7w1Rt2jo6cXnFda/pb95wPx/254t40oV4YGNS/Uj1nACgHtEV6cYTiSkIYj0VnclFO+Gcfqna3x3gt6gMqkeJWawZJvxs+EPcH87vgYG8+Wew62mAcLV7PMjqZerXhsyTMNBjJ4le1f43yXLO88OA0vmikp4HTbIymEiJuAijHkk1/4St2mrpskBs8mNn6e/J3Wdp+TkmxzPMtOYDiGg17mFUcHItg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWck4i3GXgewUmHoX+KxIZebKrV1W7CiWL6Jk2Okdq0=;
 b=AfbzXStUqRDaaKDgO0jC69KTa4iTjVyKHybHIrvG4RyQAZjyufjTneAjcIuVGqAKpYhgPxusWgs2YBBo2lqFbXMvXmtMlbMCy/vU9sF1f7MsXiOi1LQCqMfTg3JMQW1RbtEe9127DjH0SvwTXUCc8y/pcTSk3et2q+5cjrOsaGjKqhUAYo4rdxNaR3O9fuPlrqADkm8Fp7xol6trcJq8YcwDWltdTkLxCn7TtBJ0tYtsRI5S1zU7pvTre2h94IrJgpQ3EcUt+vlKNKSk4P35y2gyMEd68DlMj13kqNDhMFWL9EqG9g6t+O6f2aHX2hZg2KeGiQtO3eJHNcYHcqryMQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS0PR02MB9078.namprd02.prod.outlook.com (2603:10b6:8:132::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 13:45:53 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596%5]) with mapi id 15.20.7519.031; Thu, 2 May 2024
 13:45:53 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Christoph Hellwig <hch@lst.de>, Bagas Sanjaya <bagasdotme@gmail.com>
CC: "robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "petr@tesarici.cz"
	<petr@tesarici.cz>, "roberto.sassu@huaweicloud.com"
	<roberto.sassu@huaweicloud.com>
Subject: RE: [PATCH v4 1/1] Documentation/core-api: Add swiotlb documentation
Thread-Topic: [PATCH v4 1/1] Documentation/core-api: Add swiotlb documentation
Thread-Index: AQHam9uYmmZ7tb8fB0Sy4MuIy9Y4ybGDcgGAgABEBICAADCZgIAADz6w
Date: Thu, 2 May 2024 13:45:52 +0000
Message-ID:
 <SN6PR02MB415704C5C2EF87C290D179C0D4182@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240501151651.2912-1-mhklinux@outlook.com>
 <20240502055205.GA28436@lst.de> <ZjNjE2KyLxdT0HSR@archie.me>
 <20240502124927.GA20542@lst.de>
In-Reply-To: <20240502124927.GA20542@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [OVoVZj3DiPf4gvZUzqTj1ee4jEBgVFaM]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS0PR02MB9078:EE_
x-ms-office365-filtering-correlation-id: 21593702-d2a6-40f4-c0e2-08dc6aae2f33
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199019|440099019|102099023|3412199016;
x-microsoft-antispam-message-info:
 vcs9V9p3/C4zBcEAl1ua0HwURrp6y2ib0BbXY3VGnsNSsbHXn5c5l64Lff53GEbKbqsg2oC7RJem5AWq3skVSiPO0YeXS9kZm6TgR/NsWwIVGKAtGk0dSV9elXDBgQmTxKGPOvl/rW25p72w1OhWA3dwOc2qbm7jsJ/iYY52PXBqeW4EmWYcRGHky4kFuBOwhfGQ32dsTvCW4cFnJtca3XrxofBtWnG1IVV/arltVCLtfvjWV4O4VAHdDuKJAZV/o8aCSoEeSSYyp7KuBL06/LndIU3efcFAP/zFjpTq3E/SyRgaEVkn4tDe47o0blL9rlfgbfN7D2zCDTznecH5kH3qiV9+pO8WSWBNWT3o+qju/WcBBP9m2mrxk0098ESwYCRx+3Ii9WiQCJBAYOfqwnBbrMweKYB6BCy84oi50pmq61Iov1UxHSijglgAic20BA61EBh9JZEkQTV4O7teyTUI3z+yhbeXObYIiMFxFBGzdUqmUXUftPN8Nq62F+5HxbahzWgX4m+GKVpUg+qsEP4XVzheLGSHoPaUnRs+CREGzhVqBj8d9q+yQI9tX3Vr
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QZP+mhC6f2vh8RmoyUboR5tDfUdgJXMFJ2Yonh6nl8w9wz+GPH6P8TlaVSkY?=
 =?us-ascii?Q?3DAmBdomXr1t3+bJdRQsOhp6jxC+o+IFqcxblOX2mMC4B4BZzU5DFlzStOJ7?=
 =?us-ascii?Q?5lGufBMQ7HXCzQXMXd6nwFoGl7IcR98R8putOAIcJRunHmkv2twL1lE1TYNo?=
 =?us-ascii?Q?sTP/MtUumsHxFk1Atvga/Pk/z6RQjilZyhdU2tjxmwjjGPUC8iFHbzB7JhOn?=
 =?us-ascii?Q?4Ep7k6l04TesuQyaRCMWhv6xkvq1qs6uKuc4qZK3oPEdnhU6VQdJXUBXpZ8X?=
 =?us-ascii?Q?H61G0hqvHGptos4d7rfbOxR6t9Y9t9gQka8aC3J7RTuQYv3XLt2RYM+HL0j8?=
 =?us-ascii?Q?KUcAUbJvFP8Svvw5LtW3jKFZIwc4ZyILTJ0dU0z8htWoO8S9/FsUhB3MDt4K?=
 =?us-ascii?Q?sxsia7p2fxGNrSgxUuzdwauspnN/gcgOWRMlBFKHUpz93N3Q3vpzN0MW+5jB?=
 =?us-ascii?Q?ZZvoqgBClOoP1howcOSGMaSLF7tIYX2ytqUrFXn+MTvGBzbTpt5prTS7d0lR?=
 =?us-ascii?Q?RmiT1GQ7V4hBK57P18zsjpFabf3deyYKEgR3ptDOPk8NXKK+cVVDaK8ErN95?=
 =?us-ascii?Q?7waI8ohaesQQ7ZWgqxFhIwX0bmwopHNuh4OUTo1Q74C89CCQRDcWkKOJdEKE?=
 =?us-ascii?Q?VtrtoIbZZdN7q5QH+oLVR7LNDgjA+/3UNbEgY1/X5Q/iOXnplsOBNvTuJQcj?=
 =?us-ascii?Q?8C3vEgsHYs1c6v9mGMoCTEcBKoe9VunH6IUDsxv2goeNwNk8hRFP4k1NxfOr?=
 =?us-ascii?Q?0gWMeFFXymdGRrNrFWoETBRUIZHDvZ7g0oeSBsO0O75LufJWfEaq1kqwOVCr?=
 =?us-ascii?Q?OA6yEgSUU7iYkBtICLuK3LKVzgituRnwtFRl+dLA0SvyZlyYou354lNn9XhH?=
 =?us-ascii?Q?mKBh48/8zlrnqAE1NXM/wjI4Gy6mk8IAT+eEL06Z1XCMgGPLyh9XSZ1cZf0h?=
 =?us-ascii?Q?zlQ6vtVbde+4hBsZO7hpOh84snlNYqQhgidhjicfnKV/R9zpQ7cYiRDzf2An?=
 =?us-ascii?Q?sJUukL56yNnLLV1WMThHdEc7mSEgqAFHBrOHwDl4mBnaFuX23VVodF9FTqbN?=
 =?us-ascii?Q?vp9uA9hTqZQ7bS01Dv7IVct5BuqZPl9ngzuDP4ZFlsw7yJWEwC/u07hhXAMV?=
 =?us-ascii?Q?b6SOOqmRyp4zbiEpcM08hJZLgGM0MSxdfsbV+S+IkuPGLjPvuqZOSf62caDI?=
 =?us-ascii?Q?bYaW/gEKtfH+bp3WaDL/vRKIK4rzOCbueP/Zg3h7JdYJO5rIMgBuUQIGhZI?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 21593702-d2a6-40f4-c0e2-08dc6aae2f33
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 13:45:52.8441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9078

From: Christoph Hellwig <hch@lst.de> Sent: Thursday, May 2, 2024 5:49 AM
>=20
> Fixed.

Still has a typo -- "Reviewed-bu" instead of "Reviewed-by". :-)

Documentation/core-api: add swiotlb documentation

There's currently no documentation for the swiotlb. Add documentation
describing usage scenarios, the key APIs, and implementation details.
Group the new documentation with other DMA-related documentation.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-bu: Bagas Sanjaya <bagasdotme@gmail.com>
Reviewed-by: Petr Tesarik <petr@tesarici.cz>
Signed-off-by: Christoph Hellwig <hch@lst.de>

