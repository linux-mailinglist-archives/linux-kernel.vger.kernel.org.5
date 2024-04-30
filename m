Return-Path: <linux-kernel+bounces-163232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A82C68B677C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6C51B22B61
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBD3523A;
	Tue, 30 Apr 2024 01:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="K422g1vn"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2087.outbound.protection.outlook.com [40.107.14.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E28D2107;
	Tue, 30 Apr 2024 01:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714440963; cv=fail; b=lvZYtclW4asxJfHMRbpYGlhZY16GAIamcpQkjYdZhHf8MF6TWdgl5BaBFJdHITaqcn/4LrzsTEwhJex9bGu5l934V8vn7pIdDIpMEThNuMGkerOrsitCRGE1rcq3YXh/w/Fu0SPNCe37s6XReKuX6xP6BwsS1I9eF6l5YN7xSBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714440963; c=relaxed/simple;
	bh=KkBgzYdZChOPaOKO1sYWw/4+VsCthzql/WvIah3pt6k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FBcbRz6bUKJVJB0pXl1DOZ/dWAERNfXTdv2VBRtXPrSzNZxqoCoHG+Q+jwtWoLADOc4+WZ4uNIJ6+CNj5D6d9dQDQ0ypf+oJivRh1mWWp+poc5R9z6CoFTWl9Wq7KSAyrb6pJKv+olDe+XyoB3MX7Z6m8MmsHGiYHYb6Z/Ztd3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=K422g1vn; arc=fail smtp.client-ip=40.107.14.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6dqPd57WRccX6mm8Oey8Jwe5krA6h7Nr+KEYV6EyMftkVP1lt9GqeWGNI+aJCUwhvO+1PQr5zIQNx6u3oKhtnCVBaqy+02Z+K+g2vDLSFP4cDQ6yPdZKUjSLEjCRkeJQb9BFhXVclXCVnF8DxDxVvEScap1ztBZqwMfFicwKYvaYFOq3ZdqhmjfKIA51DQeglh5/CMX4vpENR0Yp1BfhlMTdeiAgqawvP1PgmoOhxtCY01EHYJM7GyzUaiIxiqj9ViunSlQ7qSzIp7ngmf3Wo9WAd146s+/SthTFPVrBmZswaRwygm7Y5M+vQsc4Mq0sz2m5K58LtAbK16PHwUTIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pegJENGeOLPIoMKiw+r3KT+1RrUtAkn/peNh8PeBCh0=;
 b=FM8qvGtAkeCIAnSrepBTvAipYM4cZX6dRkoRLJl+tykuwVBsQ3f40nRVEvFa2CKYVE2JJ7Y+7ihVJMS1ZI0Ooi08ZJ2tRK9hOMgTZ3mSZj0+R4W97tELj8KEoqKkQlUNynxOHyQorOacQFfyNXRNBQL+6BOsWJCQyxLjEth38uyn9z73if3o5D6F+8RV7/0DFf6A83MejOHneBpFEf0KOjuCMayboYEvvdDVmQ/fy5GuK3n+aP5RtCIKdN5bOCCgsq/lkpD3tXOT0Fx8XW24SBPeCC21Dn/ZO8UK4oEVJ4sHGzodDCj8oDzz1Lai8KpFoLtUTQL2czJWoUc7jw32lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pegJENGeOLPIoMKiw+r3KT+1RrUtAkn/peNh8PeBCh0=;
 b=K422g1vnOst2WYeBk32WNWjuptULC5SOAeyhKXjvBgFnECRoU/mz7gf838so9Wy088+7NgT9XUus9kwnDQcY4pd/g158zexHlcFhz9/OYXSdmzSYGpAuR0QiagEZ47HavQCWJ5Tok2toz3JETVIkK7aCmgIgTN9rbPwyqwyP7g0=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB9233.eurprd04.prod.outlook.com (2603:10a6:10:361::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 01:35:58 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 01:35:58 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
CC: Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/8] spi: imx: use 'time_left' variable with
 wait_for_completion_timeout()
Thread-Topic: [PATCH 3/8] spi: imx: use 'time_left' variable with
 wait_for_completion_timeout()
Thread-Index: AQHamiiNOsJ4Qs/zq0GM8oZ4i8dzArGACQ4w
Date: Tue, 30 Apr 2024 01:35:57 +0000
Message-ID:
 <DU0PR04MB9417662086BA0D4847CD1637881A2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240429112843.67628-1-wsa+renesas@sang-engineering.com>
 <20240429112843.67628-4-wsa+renesas@sang-engineering.com>
In-Reply-To: <20240429112843.67628-4-wsa+renesas@sang-engineering.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DB9PR04MB9233:EE_
x-ms-office365-filtering-correlation-id: a4728718-1b88-44d0-eef6-08dc68b5e29d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|366007|7416005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?RbKqxqY0sD4+/t2uTYh9Z0I5LGi0TtoZJ4O2VQylM5Fnc3+9rIDxAly4KxVE?=
 =?us-ascii?Q?s8xPQrEDhW3Tr+WHI0AoKr7eWcCRzXp0JvmINGplDxUmv1wwQvPe97qDytBM?=
 =?us-ascii?Q?tNxRbes64rKiJMBk4iYeNCYuHzfoFNhPIjDq2bisbnlfMsDAXAASnFiyeaHj?=
 =?us-ascii?Q?SgoodkUT+GvK1/JqGlnCDiFFTHRaEhOEp677k+HtG2J7PzyxCs96Rj5aHfme?=
 =?us-ascii?Q?eRNboc0F0sPXyrDeLzJerqsBYZyk7lwZbRrlE8iEyA+/5D2vPulHpb0fcAnp?=
 =?us-ascii?Q?tTDNk+P465qWIrsHn/a/0jajghSLSKL8CPl8RBfEs8rBF/jXkP9nCZtux4X3?=
 =?us-ascii?Q?QeBFlHIlGFWx4DjHy+PPbdoR4BwA9FBfPooa3coFeb+hEd84K2m6ttoJ2atR?=
 =?us-ascii?Q?ZBtntTtv4UFjT3Snn9AKlZm2VLfQlGd09tP950OWHPzvgG96B0qYK3OcnJfs?=
 =?us-ascii?Q?IOTxz529WNAF/9FF1Nz74ZrS+7xOM+AC//dT9iHJUffhOEJEbstVJGgk+/te?=
 =?us-ascii?Q?zTDpBR0J1td6n+Ezx4r8ZJodG1qt5D3H6UcNzpz8dJwMfIHnvDmkYnvOF38f?=
 =?us-ascii?Q?YH1UmCKykJLWEzB/z9dCrey5EDVPYwdsxeIlKduneJzgsEp/2TtKrcm5ZZ+C?=
 =?us-ascii?Q?To5CjGcJCNdjh1u1EQbRFk5hWoU41Hn0EuoalGPhdJqjd+W362CwEsrE/kpq?=
 =?us-ascii?Q?Rih5cx02w8C6XcjEq5Y2GQ5aP6Lfi5w+G4n2GtZvdNENoY4KPDPLC8SCcNtw?=
 =?us-ascii?Q?tDsnlMzmER60ousG2X3BdW5sNV087rdNwo8DfWM+T82RtlEFQYPUnNpStZFV?=
 =?us-ascii?Q?WE+VSEprqHu0OeJ1OUHYpQ92zi2RlVeD75Jqy328n5GwOl0xhJImeH2TzJWv?=
 =?us-ascii?Q?jfcSZoTBLpyk27uui6Gu0QhnafUkEE7DECZ9FzHSczgR1WdyBFnxzqfAC6PN?=
 =?us-ascii?Q?zFrlKxmS6SdqMmWdVPyg7FeSch6dLNcdpc++sIz17bc058/694Cwhw/ZRa51?=
 =?us-ascii?Q?d7kjlgsa5FoEqPJxZfm9s6AWsSseuX4rOWG/VW8hDgckHtZ8kGC9IMFwI1yB?=
 =?us-ascii?Q?GJECUfY1P6f7wK2/vSoSnhM1z4pA0HqDwzYZEUX18kjv6S8jw4lRXKnERItO?=
 =?us-ascii?Q?vWJcR+5KJBdNpAYu67SDtcXWYfz9uuzlcyhoWv0d9HEDeIU90XNHhmI7su+I?=
 =?us-ascii?Q?nWrAMhVCrePtIAYgueBOYR+qi/IJBkLNexFE5QBuMzST1pn+bgkIrArYUKnK?=
 =?us-ascii?Q?AcMaAo0DLIIMOdu3x4VzvyAwDmN7tTSBGuH4GX8qn7G2c1dnxuEcge1DUR/P?=
 =?us-ascii?Q?aOgRmJjAvQYVsVEiEbhmKv5ZiUP1/Y+PL2iF3x/KFMGxSw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?v0tIe/zbdADSmd8tU/PNixxoXgKkzGoaN0Qo+EnDTq4G/Ef/sYipF8EEBf6k?=
 =?us-ascii?Q?mYKw/vPWeEzvq6TAFXFmkx/+hXZ6fwW3+APil9ONaneJh1TXKW0mQoHJwuAF?=
 =?us-ascii?Q?QpAoUEdLxijHU9E7EYya6G4ArnHC+JIrHU5PTloWjc8aDG+Hn9uBqN5LjVEd?=
 =?us-ascii?Q?1tOk2LfvJdq6Lt8w3T9/dsdminBU+6vMtSLe+CIeol2rKAtbWch7XRLzu94h?=
 =?us-ascii?Q?2AZh4MGkrIMXPJT9ES7qjosdmFD73uA+Mfeq3HLOyuHwcxO4WfMc8XAAyoR3?=
 =?us-ascii?Q?234oZU1iBcr52rzHOikOy1C9D0Tl6qA/gPYwp5RsxgJ7Kkqk+7iKXQhOVMPI?=
 =?us-ascii?Q?FvILb09KM5nj6QB0V0xdxq4k2r//HwH06F9xN0gv2Qou4xZf8T8iMVYB6oZp?=
 =?us-ascii?Q?qGqFr5fYC0fzshDWrfiNu0WPCAwS3mXKPaViHWxSm/3RghTuV23T5Nm1BMqh?=
 =?us-ascii?Q?htmjLqTNezZ3nAb18BMwbLkpXoQjdf/0xjkK9HNkjczPXK8PWj4DC2Mj65/x?=
 =?us-ascii?Q?f4XU/zdlyd7fO8pSpyuxciHHIb5slSwBIEAGwRgce834/BVldz1IppyRJXUx?=
 =?us-ascii?Q?uWNw+WGX0z2hJXGROo5YJXWgaZ7aYpDpVDejeEIWUle3/STNoLDALsjeAF79?=
 =?us-ascii?Q?xiOJ2/UnTnAWzgYZnM9BiqKWSJFXOUJ7vhjqge3E8Tr3syueyPcccyf81mdM?=
 =?us-ascii?Q?IsSenrXMWtYBiOnu4kmy3iJGa7JPPuyprf3cf8nkROFcnIr73p4cW+VAasWL?=
 =?us-ascii?Q?NwEvVLeiT+rmcDbG/onJF1Bw1hxglnGMu+dYrJl2x3hp9RiQ01XUhYU4rFyT?=
 =?us-ascii?Q?c2dD1VKyoh5tRTzsxsZptslH8epkvaPV4zz0wLNW6EqXfHih0mZzAvJ9yaZp?=
 =?us-ascii?Q?Cdl7eypqHJdTCaW8AZR0TRmQzrQXYGF3jH1Oga8QtZoJDrOuXbNh7QEqI0IN?=
 =?us-ascii?Q?DfAid9Wz+ZKqGbO/5Vp/pxwGobNMSXO3GW/sXWCLT9Jq0+HM7nDo/xbzY787?=
 =?us-ascii?Q?49n5vpCCyaNt7U8Mfi/sxc8EIqdkoYfIx78fwcZKJPrfKxT1dpqbJyT4yqSm?=
 =?us-ascii?Q?FZ9mSkUtjqH4nkV/5NJzd266S9zdD9o2Lm2PT/KFfXePSOIActG/VRrBHk6G?=
 =?us-ascii?Q?ugEYbNBtnFKcxxtdYhU0JHIlR/F4hNUaJBqh7UVqMm/ziuOBMeJlK4j4zoGb?=
 =?us-ascii?Q?XlEbjvvCDmQdDc5wprUgDDcTP/jSFZdZxvCUUvr/Z+XY/NWStEL2KESNbP5I?=
 =?us-ascii?Q?dHnu1DmDMMOxRXsaLEBvBCXd0oPGzgSORmayfN0g9kYHL9LrCfw/ybAI9nit?=
 =?us-ascii?Q?Kswo6V+DKhgxdvPUzvwUhRWpYnn+eSe3gOzOWrChrM7DM6EioAOivTpJ0JL3?=
 =?us-ascii?Q?8kmIk377LUS49Xm6x7K5fuFa3boE3Ah/alWZiStiaOYS7GZsOA5DjzNHP/7i?=
 =?us-ascii?Q?q0z1CaEvg+Sxm5NckOh27W/Pke1s8wm1iugQeTVnZ1G+2uEvL8IwDaXVGsYV?=
 =?us-ascii?Q?10ZB0xm5TAik06402SMFoet3K/Q4mMVMcgCMYAm4NRQlIUuPFt2DhikuqVsQ?=
 =?us-ascii?Q?ngxJv4UbH/DoGZX3Pc4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4728718-1b88-44d0-eef6-08dc68b5e29d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 01:35:57.9562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b1AvjRmX0fL4GuhoN+V2JPFlZcJkDKS7/F+C1aZEtfMukmKsGwhdwyHN5VZTUv6JTlYOkGA02qp2kcDWgjBRSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9233

> Subject: [PATCH 3/8] spi: imx: use 'time_left' variable with
> wait_for_completion_timeout()
>=20
> There is a confusing pattern in the kernel to use a variable named 'timeo=
ut' to
> store the result of wait_for_completion_timeout() causing patterns like:
>=20
> 	timeout =3D wait_for_completion_timeout(...)
> 	if (!timeout) return -ETIMEDOUT;
>=20
> with all kinds of permutations. Use 'time_left' as a variable to make the=
 code
> self explaining.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/spi/spi-imx.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c index
> c3e5cee18bea..f4006c82f867 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -1405,7 +1405,7 @@ static int spi_imx_dma_transfer(struct
> spi_imx_data *spi_imx,  {
>  	struct dma_async_tx_descriptor *desc_tx, *desc_rx;
>  	unsigned long transfer_timeout;
> -	unsigned long timeout;
> +	unsigned long time_left;
>  	struct spi_controller *controller =3D spi_imx->controller;
>  	struct sg_table *tx =3D &transfer->tx_sg, *rx =3D &transfer->rx_sg;
>  	struct scatterlist *last_sg =3D sg_last(rx->sgl, rx->nents); @@ -1471,1=
8
> +1471,18 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
>  	transfer_timeout =3D spi_imx_calculate_timeout(spi_imx, transfer->len);
>=20
>  	/* Wait SDMA to finish the data transfer.*/
> -	timeout =3D wait_for_completion_timeout(&spi_imx-
> >dma_tx_completion,
> +	time_left =3D wait_for_completion_timeout(&spi_imx-
> >dma_tx_completion,
>  						transfer_timeout);
> -	if (!timeout) {
> +	if (!time_left) {
>  		dev_err(spi_imx->dev, "I/O Error in DMA TX\n");
>  		dmaengine_terminate_all(controller->dma_tx);
>  		dmaengine_terminate_all(controller->dma_rx);
>  		return -ETIMEDOUT;
>  	}
>=20
> -	timeout =3D wait_for_completion_timeout(&spi_imx-
> >dma_rx_completion,
> -					      transfer_timeout);
> -	if (!timeout) {
> +	time_left =3D wait_for_completion_timeout(&spi_imx-
> >dma_rx_completion,
> +						transfer_timeout);
> +	if (!time_left) {
>  		dev_err(&controller->dev, "I/O Error in DMA RX\n");
>  		spi_imx->devtype_data->reset(spi_imx);
>  		dmaengine_terminate_all(controller->dma_rx);
> @@ -1501,7 +1501,7 @@ static int spi_imx_pio_transfer(struct spi_device
> *spi,  {
>  	struct spi_imx_data *spi_imx =3D spi_controller_get_devdata(spi-
> >controller);
>  	unsigned long transfer_timeout;
> -	unsigned long timeout;
> +	unsigned long time_left;
>=20
>  	spi_imx->tx_buf =3D transfer->tx_buf;
>  	spi_imx->rx_buf =3D transfer->rx_buf;
> @@ -1517,9 +1517,9 @@ static int spi_imx_pio_transfer(struct spi_device
> *spi,
>=20
>  	transfer_timeout =3D spi_imx_calculate_timeout(spi_imx, transfer->len);
>=20
> -	timeout =3D wait_for_completion_timeout(&spi_imx->xfer_done,
> -					      transfer_timeout);
> -	if (!timeout) {
> +	time_left =3D wait_for_completion_timeout(&spi_imx->xfer_done,
> +						transfer_timeout);
> +	if (!time_left) {
>  		dev_err(&spi->dev, "I/O Error in PIO\n");
>  		spi_imx->devtype_data->reset(spi_imx);
>  		return -ETIMEDOUT;
> --
> 2.43.0
>=20


