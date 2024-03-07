Return-Path: <linux-kernel+bounces-95861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91112875436
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B48DD1C23170
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9465312FB3D;
	Thu,  7 Mar 2024 16:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oNZ3TVST"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A16F12EBEB;
	Thu,  7 Mar 2024 16:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709829280; cv=fail; b=VRDzwWOTsuDRVm5RcuPCLAIe5TvE3snFgGEO/lkg/yzExCOUMCl0ZB8g0g5bipqD9ICUUlVs2o7xQs5y2/9rMXf0ZjwldqkqgvyPGikTh6jsVKQSYuzeuGxf2IRaNBSXB4vqAqe8AodAvc80GB64gcVEUKfv8sM/7377gltPcDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709829280; c=relaxed/simple;
	bh=/d+9daW9Z7ssaMA1b61Bd1Ck/X+XQFe8/J5Z6CI+gTo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cfMNva2xwjkwIzVQ6+Q+NrrBmBmDdmssEbn8qk6MYsNYdv7MgIPA/RsuOlax72zjYj2FWJVO5KZC94wXfl9lvomGPk2Z0yImQKZ2TtA1u0wjKaVU04MRBVv+Ava+yaPIuZqnflhZA7Iw7XA7TdkZfLOVOqXbMk2EOjQmCdslCXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oNZ3TVST; arc=fail smtp.client-ip=40.107.220.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWYGCunEPtQe0//nZxMBX5DKPRJV4QT1A5XLq87Zc4wZhGwxQZh8yWMN5iBg8XQcO6MGqYzoSPi5ORREyyiYW24/C2VlGgvzoVShBkYHdVsNhVthHbZdtS1W3KvwFREq9HnpYFkE8OKCHZ9VbI1ZQlZtnkom7OumivoCvwu49zXTrpO1HPgvVuHApL9CKK55wKipGld7wY9K57n8Hxhv0So6T0kFF6VyBOSZ2rXGzj/I1VxBlKXIelOK7Bb421DtBcsYPzqI2nsLGcT/0l5Khl6/VAUqr8zMacxs3NV7fk0Ph18Zo3REjbv1cJtHteJwMqLWBZr10kaA0ffQijG5cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOM4P3PrhoDGYQGXO5A/BzCRmnNo4pdIHI1YBzopjT8=;
 b=SiZT/K0ViCPqqzl2M6HCA/2SF/Gnuor1BXzYHXM4dJDAYczmbCnpINBITiTFjqTPfjkE8XQY6CvOFJ0C1mqzKkAZL5oawCMbG1wJOwjsWxHxt3Ybi/1I385/KGoxPIfkgh6/sLgPRUhoMxj3prcPt+GExpYTaGXIbK+yqMIn0/dcI6YL1WFTQQ47Rs+fXMxPnp22z1I7+4w2dp8YzY2P14OTo35DwVnvv4Tbu2o3+nKgX/GBNltOU+Vo8++qOcHZ3uKS50KvUqwgDJts44K4Ayi70YJlWT2Qe+91DqsGyDd0B+IlpSX/NUOGMSil8PrKTUHZul/5GhsdrCmTjHAQkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOM4P3PrhoDGYQGXO5A/BzCRmnNo4pdIHI1YBzopjT8=;
 b=oNZ3TVSTn1Y37R3Pk0o3a6L1t6uoFfs0DBTJ1CxH/EwxHZDS0YhAGU+1ZeRIbtIBOJPu1ktoX4pvVkFfZd5QQ236p8EKiagYkuco8AZTpS5wjgQ6wFmqOY7TeCmPbKVkWvLkbAquXpGPUaUNB/CWCtJKJfhYT8f4m9jrCoAhUSE=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by SN7PR12MB8772.namprd12.prod.outlook.com (2603:10b6:806:341::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 16:34:36 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::ca5b:3117:e891:239c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::ca5b:3117:e891:239c%4]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 16:34:35 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: "Gupta, Suraj" <Suraj.Gupta2@amd.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"Simek, Michal" <michal.simek@amd.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "git
 (AMD-Xilinx)" <git@amd.com>, "Katakam, Harini" <harini.katakam@amd.com>,
	"Gupta, Suraj" <Suraj.Gupta2@amd.com>
Subject: RE: [PATCH net-next] net: axienet: Fix kernel doc warnings
Thread-Topic: [PATCH net-next] net: axienet: Fix kernel doc warnings
Thread-Index: AQHab6d3NBiMWSRXE0GeVrWLLFvH4LEsetPw
Date: Thu, 7 Mar 2024 16:34:35 +0000
Message-ID:
 <MN0PR12MB59536E9DFE0751049F15C1A6B7202@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20240306091921.8665-1-suraj.gupta2@amd.com>
In-Reply-To: <20240306091921.8665-1-suraj.gupta2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|SN7PR12MB8772:EE_
x-ms-office365-filtering-correlation-id: 354c654d-db0f-427b-05f9-08dc3ec479df
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 UZ5oqwo/R9VjVKbp3mr6OgavGpSSYA4lRnfvPB6TX9fQLXyf91uXO619sHuz/ZaokRp+N5MQ2g/FHmTKyIS9EK2Eood5v3OjvKzjI/DDD1WAppnquKWl1xV14V18TYlNxhW1Qtk69GgAYmm0fXyBSuQKeW9QT290Rj4qCTXqGUYD4yMIwGyFezd06w9fqy6g+qriS7qLc4pPUR91xn2OGtjcyYJwla2qUkRHy9xoHo+ySGAh0cBQob8CCWjwcktVW8hyItLYkasQds0UE+r/1c1jsa7WJdxYSJ6rjRJ+ZSxrZXdU2c9C035pGJaFTz2euVr/mhHc7Tidqr1h3IBO095u7ol+ulSVGtQXmyZ44niss3iWCtpXLOGHxbpUI1kCBCRLI9hWGkPOu3H3prKQtNXfQTvQgtw+LGnHhKlRsxVwwKa5/YjM2AWDN6Rw3KZPPUUUF/Zy67aQqfSPbz4+oAA/40TnxcBc9VujloToWxemMmC/+XIP+OQ/+HV9iBqktQsVwrhPsXoTENAHslliK1FJC1rjrI3A/xe4c+uqAhbuXYN37GS/vaSvR6pbZHIlZtx5g1DQnzEnhYRH6Yam59UaJi5IGe+yxDyx0XpZ9XXDPcV6CFbyRArGxKwV/aMvY2KQuAAMteo8Z5PCXIW+hBW5kk5ap9t4JHxVAUqRozQBYqcfcndpf7b8MgmFKFQXb5S3bKjcyi/6AA3NRI4LwnHPVutZ+tYHh6FpI7zbg+Q=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hn8T2u9lgBG9OI1wbXlfAA8vpu2ZzP2vkdGvL07zkXnRhLgpnFIcFI1aOpyL?=
 =?us-ascii?Q?Aw+jgZsg2YalSJT3B3Mo60h941z4xaViHwKA7VpN1L5+09fFabE9vHidwyO9?=
 =?us-ascii?Q?5AF3yj3CqMhO7za25zCargyaSjivKHaigHn+MmVyWXxdSKoDxkaASxB+9onf?=
 =?us-ascii?Q?A1ee8EWxlf/bm9ZFI9rWc35a6X0PWD83tXHBfCZdY7kJapakU7IZXDvQjMuT?=
 =?us-ascii?Q?5WLiJwoEVDtAxfyhzwv6FBSIJQfQaEEl3IhG4UU0OAyghZi+POIilZDBmVex?=
 =?us-ascii?Q?pNMfGv0zbFjhrlfpZtqkXCheyuPahS0fPyfEX35Lw74I+BvE4781w0M8hztb?=
 =?us-ascii?Q?f2nZSu/+7iHDLDqNG1mZqGJU2qJNT5wqlui98Y5yeUBLFK9bgIejdUJRFUqp?=
 =?us-ascii?Q?6ciuq46fTV8RHjp08RYz0QLOmvyicsaE4jmLIEwzbes6aDC4ksHSPcSdtlEj?=
 =?us-ascii?Q?6+9lMf/MkIuWFsmG6Qcv1mOO/E0DbRWnZ0eoLRVfIbLoXCy4CeqdRySE2Kae?=
 =?us-ascii?Q?+T1IJ6VsrTieWrOxzB7/y0jHJa135dWcwMeXpUqx6alVHfFAGjmLlG8xKwHx?=
 =?us-ascii?Q?SNnzj25gpzdHOw+wqVzBMGe5KCGYCn/szlaLJv8OvTLalgYe8K6dNSKvcOXs?=
 =?us-ascii?Q?Iab8BuMqiVlJy5WnsdrGAe8E6DhR4ZzqrOuSgxkpfBzlx1KtZngBBVT211do?=
 =?us-ascii?Q?k8dL0SLm+nAN2jkpeIE7u+oSAZyoldUnDscvxQEaIXiQvqGqYGHIFBPgsof+?=
 =?us-ascii?Q?nLWFo6qrSDDocUWiz2WFfeTpCbl0We7c6zzzLoqTJFH6s8B4JCQk6deHBBOk?=
 =?us-ascii?Q?Ftwqd0H2iXVcP5gjiWdq3cVQ+UqF6+Cb+XgFHCcz/HiDnAZR6FirMV7RI7TK?=
 =?us-ascii?Q?iWpLxJHaySfvCdK5uMeC/956cLedKabxaRAYcCsqovn8aRdrRbDD+TQZpEw5?=
 =?us-ascii?Q?H2UxU0WNPeVsjCnxWvElBSzujyQUNrlWO1MlVCph/8SoJIRnuCMVwocDlR4r?=
 =?us-ascii?Q?1XNWCCIFqJEbr5Ho3EX+M8j4Ah2YMbCxL6lMfEv7fFqciMI4rPPGgUlKY/RR?=
 =?us-ascii?Q?vUucGoQgA/asyRs0tkGD0fLPwdR6syEUvFB4U8NIq6nudHV/l+5Mox32mWCs?=
 =?us-ascii?Q?zhCej7+JSfq9CT1MjozvFItlItM6MfhFfJ01fDx/KLJ7fSbnAUT4KPEMhk6l?=
 =?us-ascii?Q?i7Yn9GDgvOAa/e+f5tiQjlwyIt77Zjxc5p4/wo/KdZ2/P9qm7fl45yZogFXt?=
 =?us-ascii?Q?pnntdS1FKJAkJcmCecue/Fp9QpRnmY5VvWfTRBOq4DqsEjhYP5LgS03TMBZd?=
 =?us-ascii?Q?D2U4TVP74zXis6lDtomkkQJaBVyBy+cQJjE7wOS8IUJbABCe4PCNljb11kjI?=
 =?us-ascii?Q?/98Yrh3pas/iTx0/pqjnbGmjKneivdTBI3qrq7zWaH1AmWj2YufqAlCcvRIo?=
 =?us-ascii?Q?/iFJX5PdP6Hh1rl1nsRP4F8JRHKN8shhsUaQo/h7I9jqgbuMxYBXLctGkn4Z?=
 =?us-ascii?Q?ZETcgiRaVz0mWwQbEiiIdns4dYxC0E2sEzq2a64FZ/mzqSSdIfJuB6xXasO1?=
 =?us-ascii?Q?w6HxrSbEajGsWjQJtJM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 354c654d-db0f-427b-05f9-08dc3ec479df
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 16:34:35.8752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hpt6YMrtySoJgqvYWTL6adfcLQLcgU8MYwgb4NbHyXmheVnPxPukYeyGMQIo8Ph6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8772

> -----Original Message-----
> From: Suraj Gupta <suraj.gupta2@amd.com>
> Sent: Wednesday, March 6, 2024 2:49 PM
> To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; Simek, Michal <michal.simek@amd.com>;
> netdev@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org; git (AMD-Xilinx) <git@amd.com>; Katakam=
,
> Harini <harini.katakam@amd.com>; Gupta, Suraj <Suraj.Gupta2@amd.com>
> Subject: [PATCH net-next] net: axienet: Fix kernel doc warnings
>=20
> Add description of mdio enable, mdio disable and mdio wait functions.
> Add description of skb pointer in axidma_bd data structure.
> Remove 'phy_node' description in axienet local data structure since it is=
 not a
> valid struct member.
> Correct description of struct axienet_option.
>=20
> Fix below kernel-doc warnings in drivers/net/ethernet/xilinx/:
> 1) xilinx_axienet_mdio.c:1: warning: no structured comments found
> 2) xilinx_axienet.h:379: warning: Function parameter or struct member 'sk=
b'
> not described in 'axidma_bd'
> 3) xilinx_axienet.h:538: warning: Excess struct member 'phy_node'
> description in 'axienet_local'
> 4) xilinx_axienet.h:1002: warning: expecting prototype for struct
> axiethernet_option. Prototype was for struct axienet_option instead
>=20
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>

Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

Thanks!
> ---
>  drivers/net/ethernet/xilinx/xilinx_axienet.h  |  4 ++--
> .../net/ethernet/xilinx/xilinx_axienet_mdio.c | 23 ++++++++++++++++---
>  2 files changed, 22 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h
> b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> index 807ead678551..d0d1ae3b4e2c 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> @@ -359,6 +359,7 @@
>   * @app2:         MM2S/S2MM User Application Field 2.
>   * @app3:         MM2S/S2MM User Application Field 3.
>   * @app4:         MM2S/S2MM User Application Field 4.
> + * @skb:	  Pointer to SKB transferred using DMA
>   */
>  struct axidma_bd {
>  	u32 next;	/* Physical address of next buffer descriptor */
> @@ -399,7 +400,6 @@ struct skbuf_dma_descriptor {
>   * struct axienet_local - axienet private per device data
>   * @ndev:	Pointer for net_device to which it will be attached.
>   * @dev:	Pointer to device structure
> - * @phy_node:	Pointer to device node structure
>   * @phylink:	Pointer to phylink instance
>   * @phylink_config: phylink configuration settings
>   * @pcs_phy:	Reference to PCS/PMA PHY if used
> @@ -537,7 +537,7 @@ struct axienet_local {  };
>=20
>  /**
> - * struct axiethernet_option - Used to set axi ethernet hardware options
> + * struct axienet_option - Used to set axi ethernet hardware options
>   * @opt:	Option to be set.
>   * @reg:	Register offset to be written for setting the option
>   * @m_or:	Mask to be ORed for setting the option in the register
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
> b/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
> index 2f07fde361aa..9ca2643c921e 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
> @@ -20,7 +20,14 @@
>  #define DEFAULT_MDIO_FREQ	2500000 /* 2.5 MHz */
>  #define DEFAULT_HOST_CLOCK	150000000 /* 150 MHz */
>=20
> -/* Wait till MDIO interface is ready to accept a new transaction.*/
> +/**
> + * axienet_mdio_wait_until_ready - MDIO wait function
> + * @lp:	Pointer to axienet local data structure.
> + *
> + * Return :	0 on success, Negative value on errors
> + *
> + * Wait till MDIO interface is ready to accept a new transaction.
> + */
>  static int axienet_mdio_wait_until_ready(struct axienet_local *lp)  {
>  	u32 val;
> @@ -30,14 +37,24 @@ static int axienet_mdio_wait_until_ready(struct
> axienet_local *lp)
>  				  1, 20000);
>  }
>=20
> -/* Enable the MDIO MDC. Called prior to a read/write operation */
> +/**
> + * axienet_mdio_mdc_enable - MDIO MDC enable function
> + * @lp:	Pointer to axienet local data structure.
> + *
> + * Enable the MDIO MDC. Called prior to a read/write operation  */
>  static void axienet_mdio_mdc_enable(struct axienet_local *lp)  {
>  	axienet_iow(lp, XAE_MDIO_MC_OFFSET,
>  		    ((u32)lp->mii_clk_div | XAE_MDIO_MC_MDIOEN_MASK));
> }
>=20
> -/* Disable the MDIO MDC. Called after a read/write operation*/
> +/**
> + * axienet_mdio_mdc_disable - MDIO MDC disable function
> + * @lp:	Pointer to axienet local data structure.
> + *
> + * Disable the MDIO MDC. Called after a read/write operation  */
>  static void axienet_mdio_mdc_disable(struct axienet_local *lp)  {
>  	u32 mc_reg;
> --
> 2.43.0


