Return-Path: <linux-kernel+bounces-75663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D43E485ED13
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C1A31F23D58
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849C285927;
	Wed, 21 Feb 2024 23:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="itR2agdD"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2090.outbound.protection.outlook.com [40.92.45.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2D6126F37
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 23:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.45.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708558571; cv=fail; b=uVPUAV+R26vsfoJvwU+C2vIh2JyMvGxvVEkbIxFjmZIEeTMwU7z3zjGAu6pbd0YPLHYDLmSYboKynSHn1Ftb65YNgxCBLiTD7rm7/ta6AVgbtZWOO3QxpZhJn+AQE1rY1Dw5/EeCIQ1te3UHPYBwF55yplcmkQ8RodAxTG417pE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708558571; c=relaxed/simple;
	bh=gx8sThrShKdJQp/nWHh51nwKNU4lccCN7H5fBjztwng=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Psl6Qy2jGtC7WZDYBJ81Mv+6wYxORE4KpLW9b4CsdFaFpO2fH06cbuEohJViLXpbBWOhgr6jhVlf4ul8FHK+ZAnClSI6Ib5jPQHMR7goj164OJcMWWpk+ZELBdsjyDK16RhB4eVltZZvCaV5X3Rc5pxOpRK41CYzJe1IO41Iwz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=itR2agdD; arc=fail smtp.client-ip=40.92.45.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXrdLGLWQb0eGH/pLzQM+BYrsVy0xfKzx1VPFhcL1wqrmTM09LZw6aDqh8Ltpn4j4M7O1+vEgSZN1kgRVb75gkDn/yOCqGbkBXvIuyqOYjqGu2h72kqg+f2boBj/uiepb3JwRXx8PcztAHgRQqKVkYzYUbG7drD9vVwXo/h0R9aeeXJw/oj1bbJC8Kqfltrt1zSu3+/XrXysABkYQh0Ks3DoaZiNznfGd1pmXbMmKMBbUACUe/yohj+EJtOhxZN3vh7GCndeD5ml+KPZuC4qSFcH2YnheUkcVfrUpsnolxS607NfUIO3+NAbt4sbOE3KLQmknafkcBwQSwigZo4xwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SoFZ/G+X9qV9fbpGfE3Wwf5XHB9BjHzXeYdUwo0RjLA=;
 b=gqXh2DIQnSG3Lv4okY/0HpPtxPnAlgC5PUEPbHV2vOvuMN7m9ZJoKFqArluuIBNFISFD35lyzUIalAqW7JQnMiVClJZt9bXRjeJkOLTRp0JAC06VdoQtrax9LtUhCXM5L22MKAj2INxNPzsGlJ2gNZ8Z/4/qntryOko8NSWQrdnw+dhTVznDlSHkwIX0F0oTTlE/1Nm/EtZ25H0nRCCzZQn4/35oLJPcMqASe4Wd2PPbzs3EsjJ1O48rUGLxSaUwDe/AC0aGjzGNEIBYXChUuV9UXRgt+YvTxl486ZWqgt4eVfhCp2O7HzvkoyjRC+kJtYr9aVrJV3+/5wCmzkt2fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SoFZ/G+X9qV9fbpGfE3Wwf5XHB9BjHzXeYdUwo0RjLA=;
 b=itR2agdD+300IG2bvlcjk3qBYMKUrOgE/W8+PvLFJgjV7f9A5VTNczC6YgE6qULaaGAgHwgDHbOAkHVYbJLH5KJ45u02FqVGtnA+SNpZvY3sxzIyQmOoY8cd3YafR19Zi5y+vdZL/TVSkCsfr0V/TGo5V6H0A7o/LBGFOEN634sBTJ7LZulJRG90WMeWDTl/oRjks4KTe5WZHxPYFwioBYiAbrQMvpP5rjv18BSVlYB5A45svlN97vmiCGmlFusJpay3z96afUbH5qia8MfkP6CHFLiKJeQMOWL5ymtOQ7Qg3g6IULzvlMEzOiNnHFCP/r+TPDaVJtw/i1XHKwQ6Zw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ2PR02MB9754.namprd02.prod.outlook.com (2603:10b6:a03:539::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 23:36:04 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 23:36:04 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Will Deacon <will@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "kernel-team@android.com" <kernel-team@android.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Christoph Hellwig
	<hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Dexuan Cui <decui@microsoft.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v4 2/5] swiotlb: Enforce page alignment in swiotlb_alloc()
Thread-Topic: [PATCH v4 2/5] swiotlb: Enforce page alignment in
 swiotlb_alloc()
Thread-Index: AQHaZLoMQB65wbVJ4Uq3JwudUYM4ErEVbvAQ
Date: Wed, 21 Feb 2024 23:36:04 +0000
Message-ID:
 <SN6PR02MB4157D8FAD7FACBB25A0403DBD4572@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240221113504.7161-1-will@kernel.org>
 <20240221113504.7161-3-will@kernel.org>
In-Reply-To: <20240221113504.7161-3-will@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [yXZ+SM3Ra7fYwRlvpltnURLrq8IjPx7D]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ2PR02MB9754:EE_
x-ms-office365-filtering-correlation-id: c28c3809-c3fa-44e1-8f0c-08dc3335def8
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5e3yVB5gB3Z0wMvvVj+BY1ljToJLrjAaaCmlBDPsMm2zW8ptrfoEKT9sWJGtElL++tpohrPlLxYKpngZB2MnFKGhrDy5hJzGdCbags30Enwmh5w8kSJNAlnAaUREurlnlAUM9PWUM5CUARQbvaojiprB8eOhc7W8JjfN2q62GhefF4sGrmuQnnTQr5a3F/FgTkiZrBd2+zLxoWkLLxJuwI2r2L6nLOhfiSDzfSff5C2CZtfQEbitThWe2OyK/zzkx7frQx+GLz+qnVN8P3oXb7hZj9zH6D+MUJOxdMijmhE7BNXZrgRMbljHUlLPOtkV3CmYKSAjby31mu1hbNEkCW+oIlXUfk2rRhxF1XnhEMze9cBdMlPaSnnZRpivBiNCSUMObos42dIIxurvdZ77xGtBySOf2aydd0C1k3LKHk5lo7lyRtqtmsaFvp0TQayzt6huo+IBh2EpBUimk1nWYZZStWJwXlBVXRrOkLB+FUDpH78DPqzjLAynMD51nYEzmi50HF7H86df9sG1410IRikoTb4b/P8IxkWMWqDxql3CwXrtO4dTUQPwuz0gwz7K
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?x8O6QCxp2JqRddUF/BxScWtOfOq53KlNu213g9ErtsFzx/SVDYu7wFGxzDgO?=
 =?us-ascii?Q?GbY8kI2leiyZJsYMF7niH3N7M4tvKD1ayQ9NFPdUaV3p9K7VTONcrUsKkyhx?=
 =?us-ascii?Q?iZlWoySLP1erg0uvVRziizvakoBIK5XVs2YZFIDZUtzWqXK7HfFTESOidFno?=
 =?us-ascii?Q?kIP+dXvzHXMY6Ya4RRvs4VZEXm5gHqbc6U4V3Vbl7/CBKLXnRY3grYH7tLHT?=
 =?us-ascii?Q?xutCzOpz3wOOb50DzJTTe7UpkN5GVb9gIMqlmc0nw43FVfBH8Q8XCTmngAh6?=
 =?us-ascii?Q?Fq5+vi4q3J0/8w1YUKQc6LhXFSl/tnDYJLRxqcwRWWJJ1Pb9KXRjMI0EA+1w?=
 =?us-ascii?Q?ilj7YZtwL7lfQI9/gv9QuaijvBdU848LVT8TTz/05/kdNsWOCyB2S9+Ex5lg?=
 =?us-ascii?Q?SYlDK359Q1xkLAXT8/Ae93zBSzf+fyNqlrrYawlTNaxEc8xKxfouWRzn4/V4?=
 =?us-ascii?Q?js3dx1596xdHGZDbLQOH/B4WnFD0pMOZW9jT+OXn52zR3y0ARj1VJfd5dLU3?=
 =?us-ascii?Q?6wjIAN5vhmeGBiSMg46PijHntRLgJTrkShSY/jMijGXuPHWHIC5xw4E47bEO?=
 =?us-ascii?Q?9q2VsfGKOt4K7Gc/cay+1Mew9DZ3n/uqkseL03xwIk7OqgJFdIz0DWN9V3cc?=
 =?us-ascii?Q?jG2u7Hk7qHK/fiu4RhdpkJ0ARB8X6FF5V+BrR3b06oX1/768SS/fgQWI93L1?=
 =?us-ascii?Q?4kVy1Xx7aKR/RfpDOj4gbZK06LodHal4Ca/KLnDhU86JoxyiMOBZ1yn52N8i?=
 =?us-ascii?Q?9LqSgrwho1AsM6E5X3ugrzs8bfenDQJuam4FdxNRvENGCRLC1IxnDc8zyWPo?=
 =?us-ascii?Q?KhgukuaqDSXhXtNWFmA1nxARcrVTvJtocSbQKzAztJIfUWllWtVISBlVg0wh?=
 =?us-ascii?Q?+V8MIqrKUykjgBwPwAPEHhKDaoABq1rr/FsZTgNkwEHuU/2K6Qb2yXBxyaAx?=
 =?us-ascii?Q?uPiwpEqi9Lx4AeIarO8/kXfojIILdhLrACNbs/+40Iz/7NQ5Fijj9hTDsBrS?=
 =?us-ascii?Q?2XBWM81NVX3aXKTs5oEXNOyJF+21z4S5xCHgoh05aqpFmZvzHrzwyZiZ4xKs?=
 =?us-ascii?Q?JR4QfCnHM+Uana+tZgazUGGcjN1Tt1n+n3wX6DeVd8Bm710CqPKr8djtH1a3?=
 =?us-ascii?Q?Ktl/3X/GIBRrhMF3P04VvOnkCeLWMlANCe2yo5Yv8DVUbD0jfpcPRk4OhraJ?=
 =?us-ascii?Q?EbalCCMAaulkpEwDf2b0AAy99YQROGLUie9/zQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c28c3809-c3fa-44e1-8f0c-08dc3335def8
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 23:36:04.6817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9754

From: Will Deacon <will@kernel.org> Sent: Wednesday, February 21, 2024 3:35=
 AM
>=20
> When allocating pages from a restricted DMA pool in swiotlb_alloc(),
> the buffer address is blindly converted to a 'struct page *' that is
> returned to the caller. In the unlikely event of an allocation bug,
> page-unaligned addresses are not detected and slots can silently be
> double-allocated.
>=20
> Add a simple check of the buffer alignment in swiotlb_alloc() to make
> debugging a little easier if something has gone wonky.
>=20
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Dexuan Cui <decui@microsoft.com>
> Reviewed-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  kernel/dma/swiotlb.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 2ec2cc81f1a2..ab7fbb40bc55 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -1643,6 +1643,12 @@ struct page *swiotlb_alloc(struct device *dev,
> size_t size)
>  		return NULL;
>=20
>  	tlb_addr =3D slot_addr(pool->start, index);
> +	if (unlikely(!PAGE_ALIGNED(tlb_addr))) {
> +		dev_WARN_ONCE(dev, 1, "Cannot allocate pages from non page-aligned swi=
otlb addr 0x%pa.\n",
> +			      &tlb_addr);
> +		swiotlb_release_slots(dev, tlb_addr);
> +		return NULL;
> +	}
>=20
>  	return pfn_to_page(PFN_DOWN(tlb_addr));
>  }
> --
> 2.44.0.rc0.258.g7320e95886-goog

Reviewed-by: Michael Kelley <mhklinux@outlook.com>


