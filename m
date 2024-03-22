Return-Path: <linux-kernel+bounces-110927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9A78865C9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 05:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79A4BB239AC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 04:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C9D6FB2;
	Fri, 22 Mar 2024 04:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="JDz5wVA7"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2049.outbound.protection.outlook.com [40.92.40.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438B2BA39
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 04:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711082014; cv=fail; b=lYK/BQTJ0zcg3dt42+pv3tJAkJPziK7BGPuZ4fgxYm5MlqYJ8cC/wREoVaNMtOIES76++Ed3sdix3VV1QPwH3Bb3XEU6JiWnk+iTuMhtJJQuq/K95qynsqwcDTkTX/wfEFIopN+ixYnQAuUk4Z48R0KLTy5eAKAou1tBCFtQF3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711082014; c=relaxed/simple;
	bh=FW/br+odTt5hLql6ER81GxbxyAz4RSdnyD/i4dL0EwY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lehtupvd7cQmKAeTTP0+RZum7qQvKkGan6A6z/KSb7kzh+cv2VDSvih3P6Hsih+Jkz8OhlEBVyhkrY9RlxjPeJOrgPO1mEwKiqV543j6xnEq8KFs0yEMOX0khKD/+CmVTyzy1a4cKqv11z9XJ7BJDT9dCq0OnM0H9fjYDXzvKaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=JDz5wVA7; arc=fail smtp.client-ip=40.92.40.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TziwDzZOuUKtenroyvezS/OrNzXlXCt3PiMFHhdULNC9JWODE3hPfO+2CMDe7BdnesOdtOvitZqldAndJcRrU35ZFAvet+3XO2/rpofyGqvJ1iAECbxh0JO09btG0MvaFeSRntoMl/fioPpG4e05j7kV02ag9jl2iOtFcsH+8EGcnPZ1FzlR7HCbEdNeisyASVYl3dNTdMO7d7KOZf+zYyZFxLT7Q53XxMfp/pNvRAPqlO+S2FHMzO0NRYkvrFJZBvo32jURH3dblbejfXHeMXKZlFH7ki/8ZW24V9mgzhzOhR9GWbfPF1u+gs6VSRiUNZkAlRWcsA/Wl2MU8H0tMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b7psU5XsXry4v0BRa/FruTU3qN1svpVFhkzZ2j0W4xI=;
 b=HQeNA/LDse8iuL4bSXwB26ME8BQGZDnFY9EaEzBQfw0RGIoEbwipx4Ah1maWkmPdVmnddss+6qpoQMnsHlTdZYYhc2iNjRAqjZqjQTZwmDMiy9KCuho9+TpY86qfyGJv8ZTsd+35YP+oVqApNlJMPpaJW1T9U+sT43FHyz0N79+Pt50jO/m5g0CzCi3E0yCkG9fJ2AmdBuByrhzdedP8gT/qGG9G5KdRCHT4IIgjqKFFQbHTsFIiTig6lhqoWJrRB4BIHTiD198r397+xCWfZiDIXJbu94NchGKzbojOzaiVUNL1i0X327fLQc9ERnrGTHVW05sGjdyo49jyVL2EKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7psU5XsXry4v0BRa/FruTU3qN1svpVFhkzZ2j0W4xI=;
 b=JDz5wVA72P1vUMGGTMXCf7BeipgZzBb18NT2kntkuoH+kbQiC5dxspGNI7vFw5sr2f7b2KcMnpcohMEe90eUY07uw6KNYEny1wrVlrq500HooAJ0ouhhrbpyXBERCADceoWvOZ2+MQaZ81Rh0gZGVgc10IdNflbGdWW8PYR0fRC2brM+bLGyqqS+ali1IesbDQXT9ZwTA/n8CflB1DmJtVSKC50ot+iYV5waJW0yc0Ob8j6RsPx87hgVXU62vxeA/3lndN5oj9inmfStYN0HfgWycFjw+3ItWNLqCwEpiqd/j4x7LOpmx4Mtrd9oH0mOvLI0TlffevWdpd+YnNOO8g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV8PR02MB10336.namprd02.prod.outlook.com (2603:10b6:408:1f5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 04:33:27 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7386.030; Fri, 22 Mar 2024
 04:33:27 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Petr Tesarik <petrtesarik@huaweicloud.com>, Christoph Hellwig
	<hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Will Deacon <will@kernel.org>, open list <linux-kernel@vger.kernel.org>,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
CC: Roberto Sassu <roberto.sassu@huaweicloud.com>, Petr Tesarik
	<petr@tesarici.cz>
Subject: RE: [PATCH v3 2/2] bug: introduce ASSERT_VAR_CAN_HOLD()
Thread-Topic: [PATCH v3 2/2] bug: introduce ASSERT_VAR_CAN_HOLD()
Thread-Index: AQHae7P8YK5+vxRKhkyT7q/3TX9dpbFDK5Ww
Date: Fri, 22 Mar 2024 04:33:27 +0000
Message-ID:
 <SN6PR02MB41579FDA4C3A34A1466FF707D4312@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240321171902.85-1-petrtesarik@huaweicloud.com>
 <20240321171902.85-3-petrtesarik@huaweicloud.com>
In-Reply-To: <20240321171902.85-3-petrtesarik@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [0gXHdzBXTUFNliKlEG2y8zBJkhBPp86n]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV8PR02MB10336:EE_
x-ms-office365-filtering-correlation-id: 48a961af-6a05-43bb-0171-08dc4a293839
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Fyxs9MKyr1nRSxdgx8PqRp3HbcU1RTWqIzmImf+FGUx3xR3aPsFDGj5aophnLWW2t9kxlK5A6ItvkXA7LSyoEHqiXn6iQKOJQ0y6op9qycVsoxJdHai2IJfNjbB9SsaucTvvfkplkGkLLS6DOErcSXjg7BsEncu+MZYI5uP8TZKOMHPDvtHa3pGKroDBDpCslwYqK/1SnIFDO80ArXomsU/+ym7Ux/I+d+ILK7/w0eviqsP4hmbZbAaiUptm12Yyox6K/+0qW15UO/r5rWi769NY9hZSyZZNCIKEqIQ+MyKscvUVPeu+suxNV922Lf8xt4roEacvlNJM5lR7W2e3N7PcIcRzVBEYMtscI8apzjrFS5drf+fEye86Uk5nOouzrk8PD+V2w9er7zQ0UyXrAOrgNZKg63ugiuD5CiUWS88MYOLpl2lCTS7tgzgPvEbPf34TEM2qiAskp/O1esOlD86X8l4pSXDMnLHIi/7o/mbnKTtPWFfsPAAe7voV2v7KNWCfWeeLGB/IKzCtphQsM7LOmH3d3lENui+ttf+m8v1uojt53OI6NNnEzN/5CX/m
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3hPJFcUxz/wxuF1UA5NU6cd2O3FfcYh2it0iOOF4eSG3qtzs8msEw5zMwV8j?=
 =?us-ascii?Q?+m1IZ1JYKYsmxSuv5sXltx1gO9QTtQ6OQwWEFGJkds9BW9zSpDPwq4urFFEL?=
 =?us-ascii?Q?utkqbAIuLD9qIsChS0vtxpjOPYvLWHLAYZwO96R2XICSMjQVs7w83CIUrClj?=
 =?us-ascii?Q?qCiytCbd/6F3z45IaRCTplLVGOZEhkfoLAmrRRblIdY2TCfEVYb7xDRGlEP3?=
 =?us-ascii?Q?d+nK/u1A+2vCiOeVfM7Od19hCCPGEUEgj6qckliZZ6CGQAdpAEagdYkQ2Xol?=
 =?us-ascii?Q?mPjMidW6hJE0wilseiivpgPApkS6Jj0KeKcdiLF3WLgwo01muAfXW2+ATpXs?=
 =?us-ascii?Q?mc9TDJh4YmAlWNwlnmA+pOSkTLVhOypJIokVb/LiO//PGP7D5tAZYHYuJa1u?=
 =?us-ascii?Q?1xxNFXLnDRPKn79yG1NHZ69u8z3aHttLjFypU38MqoBRoFzhmICEw9lGsosh?=
 =?us-ascii?Q?NokXAPau3FAUgsDZRftCQx5UF1434OmLUO+xAQsvKhHrTUNtSz7nAAMlKWhj?=
 =?us-ascii?Q?7jsCuUaa+T1rXAdY+jIf+gzkuzMWdEo7e4Wjl6ZWGdeItuFVtCfWZf5JtCji?=
 =?us-ascii?Q?g4G2WVrOyryYZWHsT9s7HbbPraBOo77ilwU6lYzA15OyKA2VM683FviXHLz3?=
 =?us-ascii?Q?nLytVEaAthfFAooqhy7i6ldcM4tcZBgVeVefRHRFpgR1rSmuVZPMMj7NTMU2?=
 =?us-ascii?Q?B4ZXogDNhq4pT5rBuj3JTlZfxi8qorge6U5i42Jx2a6e1/Sz5VuklNTLm3Dv?=
 =?us-ascii?Q?kY1XjBmmG3Srwan+hvSH/zFHkcAoiPjJM+WuUHi4+NxSU/kcTOEWtHaL3ewz?=
 =?us-ascii?Q?Xb4dO09m2bdjZbPMvpzqJ7ikzczStNf/pdZRrv+yqjd4HT9EYJEJC61fzT7i?=
 =?us-ascii?Q?V5f0E9ODaL4OilR41ztV4kFWu2rs+YRnVa0OORMnzhcVP531/0yhHZTUQV2h?=
 =?us-ascii?Q?T0VcG2fBEtfAChhaksc98dxQaka8PAT0eD1NkxBdKWJYQYu4S6NVmVUc/aF0?=
 =?us-ascii?Q?HwWzmk1tsw7uLfg2DYF9MPOBFda3ql0J6xTdlgrN0lW/j/7XXsIB0CwF4WxY?=
 =?us-ascii?Q?+NOyaPsJbGQoXODA1eLPbJgazSeFkv9cp+i92+j813TZVVZEesLECkBukooc?=
 =?us-ascii?Q?/BPFQiWcM/xOdKF6amwlwiiBJLR0vMsYpSbVCVjlXh5rJkmpJ1kcb+cyb+qE?=
 =?us-ascii?Q?G005odn65LARJv9Jp4qsxPN6DSqZXPBJg+IkGw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a961af-6a05-43bb-0171-08dc4a293839
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 04:33:27.6703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR02MB10336

From: Petr Tesarik <petrtesarik@huaweicloud.com> Sent: Thursday, March 21, =
2024 10:19 AM
>=20
> Introduce an ASSERT_VAR_CAN_HOLD() macro to check at build time that a
> variable can hold the given value.
>=20
> Use this macro in swiotlb to make sure that the list and pad_slots fields
> of struct io_tlb_slot are big enough to hold the maximum possible value o=
f
> IO_TLB_SEGSIZE.
>=20
> Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> ---
>  include/linux/build_bug.h | 10 ++++++++++
>  kernel/dma/swiotlb.c      |  2 ++
>  2 files changed, 12 insertions(+)
>=20
> diff --git a/include/linux/build_bug.h b/include/linux/build_bug.h
> index 3aa3640f8c18..6e2486508af0 100644
> --- a/include/linux/build_bug.h
> +++ b/include/linux/build_bug.h
> @@ -86,4 +86,14 @@
>  		"Offset of " #field " in " #type " has changed.")
>=20
>=20
> +/*
> + * Compile time check that a variable can hold the given value
> + */
> +#define ASSERT_VAR_CAN_HOLD(var, value) ({		\
> +	typeof(value) __val =3D (value);			\
> +	typeof(var) __tmp =3D __val;			\
> +	BUILD_BUG_ON_MSG(__tmp !=3D __val,		\
> +		#var " cannot hold " #value ".");	\
> +})
> +
>  #endif	/* _LINUX_BUILD_BUG_H */
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 3779a48eec9b..8256fcdc0cf6 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -285,6 +285,8 @@ static void swiotlb_init_io_tlb_pool(struct io_tlb_po=
ol *mem, phys_addr_t start,
>  		mem->areas[i].used =3D 0;
>  	}
>=20
> +	ASSERT_VAR_CAN_HOLD(mem->slots[0].list, IO_TLB_SEGSIZE);
> +	ASSERT_VAR_CAN_HOLD(mem->slots[0].pad_slots, IO_TLB_SEGSIZE);
>  	for (i =3D 0; i < mem->nslabs; i++) {
>  		mem->slots[i].list =3D min(IO_TLB_SEGSIZE - io_tlb_offset(i),
>  					 mem->nslabs - i);
> --
> 2.34.1

This was tested implicitly as part of my broader testing of
Patch 1 of the series.  From a code review standpoint, I
don't feel very competent to recognize potential problems
in ASSERT_VAR_CAN_HOLD(), so I haven't given a
"Reviewed-by:" for this patch.

Tested-by: Michael Kelley <mhklinux@outlook.com>

