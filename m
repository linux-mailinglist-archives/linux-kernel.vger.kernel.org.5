Return-Path: <linux-kernel+bounces-74414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE9885D3B2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19CD81F23FC9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA3E3D569;
	Wed, 21 Feb 2024 09:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="LZGTk4XD"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2041.outbound.protection.outlook.com [40.107.249.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B553A26E;
	Wed, 21 Feb 2024 09:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708507922; cv=fail; b=dauNpLevcSJmFxD8iEBi1cgQP3dk8Ea9yED2TeCWsOLuxGBT2JaDUZ41LlWDiRGZsQwRwdmljgYbM0TDlSwUTN4OoJSPsi6g4qw88xoiKj+VIrBAh1lC+/lEeUhbjOShxPxYsP1x1FkRo/CyJNBY0yuPptkUzQc4hUDA3ia7XQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708507922; c=relaxed/simple;
	bh=v8oVJ8Jb/+botyf64Egq0spGaEWrKhBV2z2OaJGO2tM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=clIby0PHIOuPtMJpGg9T9m21jMeG4oGmgDiPWck+8H1fxf1Mt5jsa4TEhVcZ0tf4IFi6yzhFGPa/p2AJmRZHHtVi9y6tbLz0pcY88BczSL0E72p/9tV1aYAww7itPXw8vSzIfe3CxaA1M4KCP54ENIBEegQo6G4x0LteYTsgPTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=LZGTk4XD; arc=fail smtp.client-ip=40.107.249.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yuml9dCcpnMmcYYsyDnglNs5xfyQmTt98RBSW/QEoSVTt77Gje0pidE1u0ERpg56/nmImVxiFBLDBccAS7OWWKjDM/W6d59uWK3v6b3SCegnssGVtR+DkjElRd9GWoF0FY12QegBYciLhpcJlXosljtNSMhT4vIBnIm/9qn2v6xHtPHDwO749qQNrqqxSPr+kRWhiBtnzjoWSGZWF9cLWJM0O8XIWD15NlX8jno4ArKjQsrdFHd94LsaRHfXDILtvC+9zHvP2dhrza/wq3nap5ExRdreLCeNGWJKyPEl9pboZQx1BPDGuvo1GBMdex2uckhs/oVE99G3JHe/fMtx+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDnv04x1steAAQSGaGR5quUG5pdBuKZ4BfgoXGcS2Uc=;
 b=g+B51P+/8x4CviVe+bxtuWHLnhvQD/GqVC9MFoEbXkhVwlw/jROsH6tsQsYXg/dpCeQXNqbTueSB2mlLCYGA4FNE+lkzIRYuFf9LCiwR2Rclh1MTwCcteX7W+INx9IJozhdDjphMCGxwda4J+kSjfl/OXIqJK60msFq0KwiB4rQ/frPOoPD42afpZC3jma95fW6+WcgbnxOtQaWRzMkh0y48J1hYhpw1vPtQMi4mj4Ws5EJiL7e26bnEZksUvXLKwfqfhOjpvZEPUe1OQ38sftzHR9WEBttLC/YROy9AqqbUF5yvBfqurExshWxLesmEf2ooynMZhkCSBTs3a9HDuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDnv04x1steAAQSGaGR5quUG5pdBuKZ4BfgoXGcS2Uc=;
 b=LZGTk4XDzegZKfrIf3pjfftaABcT8Qk+o1DdvbUicpJVGztm6/oowbhXnjRGMERYcegpM+5G79cefEPmkTzIIbCpat2smjH+IMoJpRFzjipGmIFXaQ86ScMFW4lyeoQSJzVx7gNBCNcK/ncWj1BQVdo4oNtkyA41oE0AtjsWRF8=
Received: from DB9PR04MB8185.eurprd04.prod.outlook.com (2603:10a6:10:240::22)
 by DU2PR04MB8789.eurprd04.prod.outlook.com (2603:10a6:10:2e0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Wed, 21 Feb
 2024 09:31:57 +0000
Received: from DB9PR04MB8185.eurprd04.prod.outlook.com
 ([fe80::c528:7058:f179:f2ba]) by DB9PR04MB8185.eurprd04.prod.outlook.com
 ([fe80::c528:7058:f179:f2ba%7]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 09:31:57 +0000
From: "Madalin Bucur (OSS)" <madalin.bucur@oss.nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Sean Anderson <sean.anderson@seco.com>, Russell King
	<linux@armlinux.org.uk>, Zachary Goldstein
	<zachary.goldstein@concurrent-rt.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] net: dpaa: fman_memac: accept phy-interface-type =
 "10gbase-r" in the device tree
Thread-Topic: [PATCH net] net: dpaa: fman_memac: accept phy-interface-type =
 "10gbase-r" in the device tree
Thread-Index: AQHaZE0LMk4KrQ7VzUK8EAUOlg4LgbEUiC/Q
Date: Wed, 21 Feb 2024 09:31:56 +0000
Message-ID:
 <DB9PR04MB8185D8B7368797935FCDB5B2EC572@DB9PR04MB8185.eurprd04.prod.outlook.com>
References: <20240220223442.1275946-1-vladimir.oltean@nxp.com>
In-Reply-To: <20240220223442.1275946-1-vladimir.oltean@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8185:EE_|DU2PR04MB8789:EE_
x-ms-office365-filtering-correlation-id: 3616977b-e85e-4c42-1dba-08dc32bff29c
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 X+eEAb1fwwOHqXFU7hYk0oddHqs59NiwSZKNxMGDx8yL/d+nSXMvNAAIwLAq3UUzQVSf1T2o3bmawYMDEFnJaSLXGf0eS8+vzAW7WNJpkaBueQtn2Wbjmw9xKbnFwhfTF6bSfHaJOD2B1DVAL5UBa2SX8WTjVWG4vZyk/JzIRZlW1Y7ubZhlkTTePcC7ehtFcQ2q7TpYFVbKxHY/fDfRYqFd4K0wm0PA1dTGNKOKSTSrkPjaM3uN3tjbZGtTmW6u1YkHrWFkFcPbUiZW80Y1+yIqHuJ11y16DfhVI6ExaPgd0i4Sh9NMm+VzS2W3FYqpz2tq551KiUsJob3lFJhREFnLtkMW4ZLpGKyplSR/iTUSLaPw6yLKKC9oMUYm7vIFxyZuamnhgWSbzvHbRDH7+09uFDUsixueSivTxijTsA/DaSqTtjWsD+VpdGpaL9FkEsKUaB5MD+MUX7z3F1O92Q7YYyHh+q+JfK5uaPRUKU7S57CHjaiAn8keZBg0xPKmoMLB5ugwmWU5A5gp1aXB7xbv6VnHowPMk67i4OqfIdJT1DNly+d/5IbvaRkTi5mABQr42/AegsOBnYA4rgsWDIiRN+RyHg7Q1oP7HddLd/8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3l68cBdpZ+cdJW+ClXfaJLVVVcV6H+U0EJ12HwDlT4RLsJkGvPXGkz0xa+Jn?=
 =?us-ascii?Q?H8cc65I6HysAhba4pWfrREIbMfOvcZqTMwX8vAZS9YNI48b2ZXU7/1NCK6zw?=
 =?us-ascii?Q?Z3QmiLsbNVwjs93z+8HLgCfUyiLe4jriL2HLQxeaxYtT1YwbNnIUZYq0pIoY?=
 =?us-ascii?Q?pwO/ItleTztlK5/B8OIom9O6TpK2JNQuCwa0nf48GFPM0KLrkJ3vfrshCEVA?=
 =?us-ascii?Q?Ho7r3F9JfFxiZBgTejAlB06z/zPpARRPaooqx6fFVzgnEZje1gmwmS/AZHD8?=
 =?us-ascii?Q?Djelh22d6O4gdFXVXkIwLB74mA2kUMtDOOOILCMGSftkF8Q1Zk5wsuiP/pPR?=
 =?us-ascii?Q?qUCpyKK09YNaUfznYeidUCAX9ZXCinBBXqeT7sHQPdycQcuF7JGjbHjGGt7l?=
 =?us-ascii?Q?9w1IULqbrnUjaczfkb/NQzofYn5DOHjTYY0Lq/d1a+cz8mz/Fyw4cuE7bvYi?=
 =?us-ascii?Q?qeeCnJzjheh4bB1GvP9doaZ+m9dgZ4W+uUAZLiEQMsslFrmYqS7o8sAmX34D?=
 =?us-ascii?Q?Hw/UJgmeGfK99w/BXVNppEPMK8np8betuUvNMMh/QhVZFYzdLJYdmN81C2Ga?=
 =?us-ascii?Q?942N/mgYnv10PiXyA9Zt5j6cHHUwzZrkSNxWfewGb6SFv+YfHlMt7Q9mTNYr?=
 =?us-ascii?Q?oNghKXsXtOfBpkJYulzItEcIuRvNfirOJLlpOfO+pgL8L+ATDrU1prOwzDaU?=
 =?us-ascii?Q?vOh05LgyLttgVbezkowKgioGLUVgUS4jMT422yyRSucst8LMnFY3B6OCTuym?=
 =?us-ascii?Q?fD8ZtjFdwrXZdqAFKPLbWJZnxL0gLXF9AJssgrPIHL77C7PR3BDJW6WtVSf+?=
 =?us-ascii?Q?PmIDx9RSNgbuTsEUh4jREdzyLZgDqiROjIO56OHuM3wnJ6svvG/KCmhG2dzV?=
 =?us-ascii?Q?RWQIWD3RZ2rKLt0hckLJigDRSufsMk66MkOjmk4l8LYxRsrA9YF2KZQZAviy?=
 =?us-ascii?Q?kKbnZDzxLEXLAOoHm2kaqfTDkTbwn2A23rNKlx2pBdBpOhVp7naErFGHGZ9y?=
 =?us-ascii?Q?J52UNkjTM5MoemHdFrRxVTGinl5Ko14WYfd63hnPk70oSftiQUpXUbjV3G7g?=
 =?us-ascii?Q?WYjMJnOVyQVFravAtgJJyO9V0IqhmqOnQgCekRilwP0+Og7qFHnyCFA2pgB4?=
 =?us-ascii?Q?nN8fOyKU26C+CllFS4PGs9tEytw0clrX2xTBsdv3vPrEpqFA0REqbQzaDdhA?=
 =?us-ascii?Q?90gJJH/hYZVdzjN2GL/I+oHdXMV33vlHK6bAfTyPcoeAbePnG70MhK/0tFag?=
 =?us-ascii?Q?y/24EMhPh9y6hedZiIhXPGM7T1HEKfvlVXpP8nt2HGsPgItfAglYxdBIbtfI?=
 =?us-ascii?Q?IjM3dyeQlAUUhhs6KF62VTQQp+y6sJ/eSxweO8Yv5fI4jzraZyU91v4SYE6a?=
 =?us-ascii?Q?OlNSKa7XGlFsXsJfNzy7xTOLdAmkr8Wcort0L9NSKcjqdYXAulDAK6lz3mjN?=
 =?us-ascii?Q?1eJ/ixbaUAY7XL4/roQFgxdIOqC0SBQnC+2Skgz1T5ToL89SskbtVF+EU8pn?=
 =?us-ascii?Q?CcwnMztHPNfinvPvEwXlNcam3JuroKrtwQoDE+BRqxlcTOqpoBhLBi7LEO5O?=
 =?us-ascii?Q?eNdn5datfbjvMDRRpOci07l4lJJ/Ej+Ua6vpIn+K?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3616977b-e85e-4c42-1dba-08dc32bff29c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 09:31:56.9982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pdB8kROY91iQ5z402rSwkKgzzjiWBUeb3kSXRZrB0vgVMqEIfvp5yQnRJ80gCju1xyF+FZ9NgmVUrHG1Ndd3lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8789

> -----Original Message-----
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> Sent: Wednesday, February 21, 2024 12:35 AM
> To: netdev@vger.kernel.org
> Cc: David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Madalin Bucur <madalin.bucur@nxp.com>; Sean
> Anderson <sean.anderson@seco.com>; Russell King <linux@armlinux.org.uk>;
> Zachary Goldstein <zachary.goldstein@concurrent-rt.com>; linux-
> kernel@vger.kernel.org
> Subject: [PATCH net] net: dpaa: fman_memac: accept phy-interface-type =3D
> "10gbase-r" in the device tree
>=20
> Since commit 5d93cfcf7360 ("net: dpaa: Convert to phylink"), we support
> the "10gbase-r" phy-mode through a driver-based conversion of "xgmii",
> but we still don't actually support it when the device tree specifies
> "10gbase-r" proper.
>=20
> This is because boards such as LS1046A-RDB do not define pcs-handle-names
> (for whatever reason) in the ethernet@f0000 device tree node, and the
> code enters through this code path:
>=20
> 	err =3D of_property_match_string(mac_node, "pcs-handle-names", "xfi");
> 	// code takes neither branch and falls through
> 	if (err >=3D 0) {
> 		(...)
> 	} else if (err !=3D -EINVAL && err !=3D -ENODATA) {
> 		goto _return_fm_mac_free;
> 	}
>=20
> 	(...)
>=20
> 	/* For compatibility, if pcs-handle-names is missing, we assume this
> 	 * phy is the first one in pcsphy-handle
> 	 */
> 	err =3D of_property_match_string(mac_node, "pcs-handle-names",
> "sgmii");
> 	if (err =3D=3D -EINVAL || err =3D=3D -ENODATA)
> 		pcs =3D memac_pcs_create(mac_node, 0); // code takes this
> branch
> 	else if (err < 0)
> 		goto _return_fm_mac_free;
> 	else
> 		pcs =3D memac_pcs_create(mac_node, err);
>=20
> 	// A default PCS is created and saved in "pcs"
>=20
> 	// This determination fails and mistakenly saves the default PCS
> 	// memac->sgmii_pcs instead of memac->xfi_pcs, because at this
> 	// stage, mac_dev->phy_if =3D=3D PHY_INTERFACE_MODE_10GBASER.
> 	if (err && mac_dev->phy_if =3D=3D PHY_INTERFACE_MODE_XGMII)
> 		memac->xfi_pcs =3D pcs;
> 	else
> 		memac->sgmii_pcs =3D pcs;
>=20
> In other words, in the absence of pcs-handle-names, the default
> xfi_pcs assignment logic only works when in the device tree we have
> PHY_INTERFACE_MODE_XGMII.
>=20
> By reversing the order between the fallback xfi_pcs assignment and the
> "xgmii" overwrite with "10gbase-r", we are able to support both values
> in the device tree, with identical behavior.
>=20
> Currently, it is impossible to make the s/xgmii/10gbase-r/ device tree
> conversion, because it would break forward compatibility (new device
> tree with old kernel). The only way to modify existing device trees to
> phy-interface-mode =3D "10gbase-r" is to fix stable kernels to accept thi=
s
> value and handle it properly.
>=20
> One reason why the conversion is desirable is because with pre-phylink
> kernels, the Aquantia PHY driver used to warn about the improper use
> of PHY_INTERFACE_MODE_XGMII [1]. It is best to have a single (latest)
> device tree that works with all supported stable kernel versions.
>=20
> Note that the blamed commit does not constitute a regression per se.
> Older stable kernels like 6.1 still do not work with "10gbase-r", but
> for a different reason. That is a battle for another time.
>=20
> [1] https://lore.kernel.org/netdev/20240214-ls1046-dts-use-10gbase-r-v1-1=
-
> 8c2d68547393@concurrent-rt.com/
>=20
> Fixes: 5d93cfcf7360 ("net: dpaa: Convert to phylink")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  .../net/ethernet/freescale/fman/fman_memac.c   | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/fman/fman_memac.c
> b/drivers/net/ethernet/freescale/fman/fman_memac.c
> index e30bf75b1d48..0996759907a8 100644
> --- a/drivers/net/ethernet/freescale/fman/fman_memac.c
> +++ b/drivers/net/ethernet/freescale/fman/fman_memac.c
> @@ -1076,6 +1076,14 @@ int memac_initialization(struct mac_device
> *mac_dev,
>  	unsigned long		 capabilities;
>  	unsigned long		*supported;
>=20
> +	/* The internal connection to the serdes is XGMII, but this isn't
> +	 * really correct for the phy mode (which is the external connection).
> +	 * However, this is how all older device trees say that they want
> +	 * 10GBASE-R (aka XFI), so just convert it for them.
> +	 */
> +	if (mac_dev->phy_if =3D=3D PHY_INTERFACE_MODE_XGMII)
> +		mac_dev->phy_if =3D PHY_INTERFACE_MODE_10GBASER;
> +
>  	mac_dev->phylink_ops		=3D &memac_mac_ops;
>  	mac_dev->set_promisc		=3D memac_set_promiscuous;
>  	mac_dev->change_addr		=3D memac_modify_mac_address;
> @@ -1142,7 +1150,7 @@ int memac_initialization(struct mac_device *mac_dev=
,
>  	 * (and therefore that xfi_pcs cannot be set). If we are defaulting to
>  	 * XGMII, assume this is for XFI. Otherwise, assume it is for SGMII.
>  	 */
> -	if (err && mac_dev->phy_if =3D=3D PHY_INTERFACE_MODE_XGMII)
> +	if (err && mac_dev->phy_if =3D=3D PHY_INTERFACE_MODE_10GBASER)
>  		memac->xfi_pcs =3D pcs;
>  	else
>  		memac->sgmii_pcs =3D pcs;
> @@ -1156,14 +1164,6 @@ int memac_initialization(struct mac_device
> *mac_dev,
>  		goto _return_fm_mac_free;
>  	}
>=20
> -	/* The internal connection to the serdes is XGMII, but this isn't
> -	 * really correct for the phy mode (which is the external connection).
> -	 * However, this is how all older device trees say that they want
> -	 * 10GBASE-R (aka XFI), so just convert it for them.
> -	 */
> -	if (mac_dev->phy_if =3D=3D PHY_INTERFACE_MODE_XGMII)
> -		mac_dev->phy_if =3D PHY_INTERFACE_MODE_10GBASER;
> -
>  	/* TODO: The following interface modes are supported by (some)
> hardware
>  	 * but not by this driver:
>  	 * - 1000BASE-KX
> --
> 2.34.1

Thank you for the detailed description of the situation.

Acked-by: Madalin Bucur <madalin.bucur@oss.nxp.com>

