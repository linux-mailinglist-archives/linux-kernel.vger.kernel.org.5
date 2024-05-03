Return-Path: <linux-kernel+bounces-167211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B178BA5BC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 05:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A08C31C224B3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 03:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6A51CAB2;
	Fri,  3 May 2024 03:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Rbe7tw1p"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2048.outbound.protection.outlook.com [40.107.247.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D54D29E;
	Fri,  3 May 2024 03:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714706878; cv=fail; b=dPrZ8N/ejOZBsmJDBqGQkN+lzV3tDRxE639S0GHk7k/7Zy+HnQvJwU7OE5e4JuKw8wgxOFW3vqOQ0RKT/Nn4ctb6IvxhxOrmKOu4OLqxp3SjddeKeAA6FXHZ+DH1ppbbQm68WMiitHoOWAc7FC0E3jnKVHUMnL8Vqcqhd18Z3Xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714706878; c=relaxed/simple;
	bh=WeohTMcIlVRgnyVBzuCT530RL2JI+fgADHB/rcgOh5w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VIamqEx6Xi4b8WaxU4kTZgnw0dJXoSM9B7wwYttlNHJP3/UNGezd3HH8MiccellRw2X89FHTRR9r5byqrGDVnEpYWyKteQtgDiiXhrmnBeeYYEHCAFPV3XBnLKCQL65NCU1PyA+p/9dKs/aM4N24VB2SsKwj2mwYt8FUAmIgkCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Rbe7tw1p; arc=fail smtp.client-ip=40.107.247.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiecJtgdhRTpXCUdPohzlFv8pnR3Wjgx+wLxos42jfbDxJ5WgNFsWw3zEweGr1AbmgU9saPCqkUdVmJEG4jJ6YeEPYX688tIKLIUNH1qnaQH2EX//P6fKefoAlU1isQDhSqDivCd8FAuSpferxe2a/Z0AXC4AzcnXsjq73ywMesp1p3NPwuxO/jnfBIgdIuq1T2fBhpiohutrESOZJjBp386Ww/dAmxg2Bmz7LlsSgMoYAreHeDoS1vH/w+Menfx9XcCgE24e4675zbks7q2bUTfG+DZSM+qK09kF9hYvSzdn1MjVy8eV9oco2NTkJkAynT9khznaEEZwdNGsktW9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUKrg490zc0KmbJw7EDID2k/beoz42vRzvq7qdui/HM=;
 b=C5USODbGlC9gYynOLvDKGpCtaxzszzttzu4sc1XP1LDqaTjWYQyR1lE/pki3RPLOrJYazpLmncQ9kuv+cdG5KTsELQICTDEcJ/v7N7PWnYCjzXv641LXTfbJUg7sC1GRqBJqmL+xNDQll189vNQOO9QAPeD1R2hY7wfE0MwnWcjVXxMigExZzQsD4yg7sKVLqdZN/W6Qd5QzadOc+YIR+Q7O8l2vOSxC+lxmv6aMVIcgcjOsh2EWS762oV40nZE+tJgEh8rUndEQ5BIjlLKLhE5jEtTFd7o/xnR3Keh0tTiyVDSqOmKfddMaqAtVGBLxLlNXTt/TSYFjffratofIcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUKrg490zc0KmbJw7EDID2k/beoz42vRzvq7qdui/HM=;
 b=Rbe7tw1pq3N9BWYALZkVbzRnFfTzgbQFBkP1Mf4q4hbe2AnC34pdUCjlUarLIuqmsQJk9s3ZtAJlc+dVg3td/2u2x6Ma9DBKO0YMga6/2K0MhKIAOV5MxojdRwYd2oKrMdsPdgGEbnmid32PFZWAw6ltZTOXJJl0H0qc9tSwojw=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9564.eurprd04.prod.outlook.com (2603:10a6:10:316::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.26; Fri, 3 May
 2024 03:27:51 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 03:27:51 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Frank Li <frank.li@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Alexander Stein
	<alexander.stein@ew.tq-group.com>
Subject: RE: [PATCH v4 2/3] arm64: dts: freescale: add i.MX95 basic dtsi
Thread-Topic: [PATCH v4 2/3] arm64: dts: freescale: add i.MX95 basic dtsi
Thread-Index: AQHanPlY38GlXhK1oUSQ9eqcWXlvlbGE13GAgAACDEA=
Date: Fri, 3 May 2024 03:27:51 +0000
Message-ID:
 <DU0PR04MB94174211754FAC7117371436881F2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240503-imx95-dts-v3-v4-0-535ddc2bde73@nxp.com>
 <20240503-imx95-dts-v3-v4-2-535ddc2bde73@nxp.com>
 <ZjRXu5Oy2cLRtMh8@lizhi-Precision-Tower-5810>
In-Reply-To: <ZjRXu5Oy2cLRtMh8@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DU0PR04MB9564:EE_
x-ms-office365-filtering-correlation-id: f6fd31a1-a1a4-402a-4ce4-08dc6b21033c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|1800799015|366007|7416005|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?dv409Yk8zij+5QLRwVIRnnNPkEhSv6N7wWr3BWt39Cv4vZYOUb/9cT903N/C?=
 =?us-ascii?Q?+v1+X4PIr35DmeKT7i+LxZ3fDO2A96fZ9V8tRXXcWf5vJRio3JSDjv+wmAwD?=
 =?us-ascii?Q?U/ffu8l5vFi+RXjvDL8EBuAeWks4NhYJD7JRMexKZw03tjcY9QMVz5esgflH?=
 =?us-ascii?Q?qt1V4qSoRbUdSIrZujxOq/JQCnfb6Eu9UUBs/drVzNY0RFDkrEhvQDzlMigp?=
 =?us-ascii?Q?p9EWcWo5Esf1HlQC6IOu2wxFifAizfjBqRU8tCanc9IpHOBHDEgQ28z8mSmb?=
 =?us-ascii?Q?bQESJPguQywR0Q0GKH6lKRRoF7fAzUHrkO4QVfthOT1p0PyT31zWfwZhrQdC?=
 =?us-ascii?Q?WNHwEMpmyc5Qiwnzk594YmGDxnL3X0bLO6JeGdUbwAvSzmIxieaXv8Rb5G1R?=
 =?us-ascii?Q?G06QTjRspjYWq2ucjJc2hjR8Nflrl6Vs8JhrV1DvLwe/ajgIqVFbvGB/TDif?=
 =?us-ascii?Q?tygbrfR2QW63tWGRLdqI4TyN126wYvzf8GGjqhn0apG7EnCdi95/JjFA/BTU?=
 =?us-ascii?Q?WxMDGZ0tzZvGvTjLa3HuXrIMDA+xJiMuUWK2fMTEAXrpehjWwkEEa4xLnqWf?=
 =?us-ascii?Q?cjizQyXvZfgAmS9Xiu8JxRfs5YwzTPlZFQ1lNmDE9Rj0L1GVhTkLJeFTYHUL?=
 =?us-ascii?Q?dINFjU4diBzyGPyIcUkHvQ1UoROwLK8cQ6p8PYiN+vCbFNiR/ZpFYRqOuDDP?=
 =?us-ascii?Q?tGMVxDb24rn3+BK5D/7oJmvvTxjXm18QETvlRr2p/Ua7yPr7stRm8Bzgt6of?=
 =?us-ascii?Q?0cfX4OOQY7Zsjx9qYgJDHEhiy1Og59tQD5zuGTEUCvM3tteGyTpS4L29Zalz?=
 =?us-ascii?Q?JRtaGtUve+6VtVidctJNFEBTAbpk7FhPciOTJUYB1flHo0gDBVIrpRXx9C6c?=
 =?us-ascii?Q?he37wV6pjJp0ucDs6XQ/Qtd4V6vAkTQe8em/4rlv87LAYvcwcgJnwMmam2sR?=
 =?us-ascii?Q?/Lf+55UwGB8/5LBaJrJvMgIsR/merNd1gLzMoLvivwk+QHPK8SYZWrWazZAk?=
 =?us-ascii?Q?7K1ccemVLyugURU6ra4N4fC0TSK/+t9mRmm0GWcC+Z2ILB7YKyhfxTdU2S6w?=
 =?us-ascii?Q?oQrl5NO3v4TeH4jtEmmY4hvBuDWjYNLqjd1IDYXsJaWFBgAYxa6RYGDB0rRL?=
 =?us-ascii?Q?43XfngPU1Gs+u0oOsMD0rIpJmX3hxyG5g1DJUXfyF/t2z5zT32mGufhMsSlu?=
 =?us-ascii?Q?PKTXsCoQOo2B8nwIeK6oL9miSO46W+P9hQWuMuJ0tUat0pvfP7hXJe7PVtx4?=
 =?us-ascii?Q?2ebuqAwtznWFAXqPKw3KAUEjJtZHaFVlLcprOhCUzsXohec1af72D1laBNRk?=
 =?us-ascii?Q?Jc44R2O2NOb/CH+COTglY+tVec4bQ5BPVizrMQ8HLI/Bjg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vKyA8rYlR8aF/uu6zW6Dvlx2PZZxBB73s01Xte12RvKxWUARKYTFkGaig/pV?=
 =?us-ascii?Q?LxHOTkJevU/+kPZNJSSziIWRbrAsc+edCASMz9KLC6CUTLSnN4L093B+MY2P?=
 =?us-ascii?Q?yJ2FuQ2hF0QUPuX7aGN2QQf8rxNT9B3k38N3txxIdxov1MhRa2gE9I4g87aP?=
 =?us-ascii?Q?r1aK65XxhHlkleUT+JxBkO2ICljSi1QRihzEPEGG83Amo9iKiq5CvwDeW8MM?=
 =?us-ascii?Q?A8frWVg3FtnVqkbWLb+zwnNowSighaOa49406cxddiPLHJJRKHtU2mzf1oTF?=
 =?us-ascii?Q?iisRn0z5Pz2ZVJF5SO0ChVQ12Wlg9F1DiG+I+H6trYFATfyZMK7vsYxhDj8x?=
 =?us-ascii?Q?jjOsDYBT60/tFEgqpTcI+1Skd8TfnyueuvIHIqbyC/4EBjS3fk80FY60s721?=
 =?us-ascii?Q?6ABX0afleGEwZYQJuMlbpH3kskx4pqvW6Arq0R7xr7aOL0Ji+g+31En6J91D?=
 =?us-ascii?Q?ruSHulXRekHebNXYyXSgvU5XN0xKZB9CUkGCz1CEBhoRW0eYSQsXw87+K6wV?=
 =?us-ascii?Q?nRRK3Yw/2ILBAsOGVWOUw0txHt+b6Upf2qgQakBxe0YhcG8MHuUlRuW1CW3D?=
 =?us-ascii?Q?JSEb+dLnQdvxF2Jje9+hjmuz4IzFUnfCS26Sbm9ah2VYlBMjpKwI6MySRg7d?=
 =?us-ascii?Q?rBivcJEBbl+DPVjVvw5PBPU8aGDuxnbs/oBe0OAyF5uN6f9UD0uX2P2D/27y?=
 =?us-ascii?Q?DBpezDYVCzJ8/YkRHiRiXkhuB1sP4jf4CwPxsLzDK9IvsV8ce5/hK++LTLRW?=
 =?us-ascii?Q?ch0tlc1P2Qowd6cUTxlDv6KKFCIrhfwib1PhpOhydD346ovn61ZsiC+0OZrr?=
 =?us-ascii?Q?YqKtqXz7LiBSgTi1icNmFhD14l0FagvrMCZGR1UxPs6O+xbw1nHvXvNdFkgN?=
 =?us-ascii?Q?aVKCTR3XWFbY1Z9G+31xgqQkf5Tp88n5LLG7YIJYykJHM7JE2qVExfl/HIrt?=
 =?us-ascii?Q?JhqTlBQj8MuHPQ7cWlSDMfkTX1gdgHpDI3CcEX4yfflxEAgBeQEA1CYcKZQr?=
 =?us-ascii?Q?kpQY/Ls1hMnw2L+mt89IlGhH0d7CyKCSfP8VNXPDIO7cal/I70p5nQqmrTF3?=
 =?us-ascii?Q?Opn4jjVII890viLxy7SXl8RLCAdvBxR5tV9VRiNa0YxvYIqzGP8Hszs5kqtq?=
 =?us-ascii?Q?f9fq4Af19jAD6lZWwx0BXgrA/dEycSidszbrTJ7eFedXFAdr/LZ0Xp7fYdmv?=
 =?us-ascii?Q?P5xzfzsTXzwNHLbp8ynNFYuz3aJeVyORQqyVFBRcrBozdusu2fPkldWDcsUj?=
 =?us-ascii?Q?jYcgtHCz9xuemVtwOUaGsMMZb5qAZZSrZDB/Z/EyqlVVNSwRM/5XIIsyDMSF?=
 =?us-ascii?Q?tH1mNduqfJHW8YBPoZ6oyBxCts6GWCwyqz6yKo39w09YnTVT+MXfBtyO684q?=
 =?us-ascii?Q?qRBLRvS0x1WXAkoWhsXsG7NzRWLrQB+ktAS2uodRI9uob7kUXfdstM7oqIkw?=
 =?us-ascii?Q?Pm+FMJ6iQ3zMjI86OUMFIsGTqE97FZOuDMrST/Jdg0ynd27+Om0OC5gAASmO?=
 =?us-ascii?Q?Pvxf073+W8eKYC1HEuJ3Z6kLW6fsJJ282oYWurVqqxUISVE9Z0TeHu6WCZye?=
 =?us-ascii?Q?wQQbY+eIDKJOfRGmLOc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f6fd31a1-a1a4-402a-4ce4-08dc6b21033c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2024 03:27:51.2084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9N3h8Pr2qFDe+Pt//BkmspD9aG712PraP8hFvRtwi921TMXE4nkATe4JEg5D1Rdou5b0Irdk9kQ+UQaBeLChGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9564

> Subject: Re: [PATCH v4 2/3] arm64: dts: freescale: add i.MX95 basic dtsi
>=20
> On Fri, May 03, 2024 at 09:37:12AM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > i.MX95 features 6 A55 Cores, ARM Mali GPU, ISP, ML acceleration NPU,
> > and Edgelock secure enclave security. This patch is to add a minimal
> > dtsi, with cpu cores, coresight, scmi, gic, uart, mu, sdhc, lpi2c added=
.
> >

...
> > +	};
> > +
> > +	sram1: sram@20480000 {
> > +		compatible =3D "mmio-sram";
> > +		reg =3D <0x0 0x204c0000 0x0 0x18000>;
> > +		ranges =3D <0x0 0x0 0x204c0000 0x18000>;
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <1>;
> > +	};
>=20
> looks like it need general node name in
> https://github.com/devicetree-org/devicetree-
> specification/releases/download/v0.4/devicetree-specification-v0.4.pdf
> section 2.2.2
>=20
> look like should be "sram-controller", please also check other node name =
to
> match spec.

But this is not controller, it is just a piece of on chip memory.

Thanks,
Peng.
>=20
> Frank
>=20
> > +
> > +	firmware {
> > +		scmi {
> > +			compatible =3D "arm,scmi";
> > +			mboxes =3D <&mu2 5 0>, <&mu2 3 0>, <&mu2 3 1>;
> > +			shmem =3D <&scmi_buf0>, <&scmi_buf1>;
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +
> > +			scmi_devpd: protocol@11 {
> > +				reg =3D <0x11>;
> > +				#power-domain-cells =3D <1>;
> > +			};
> > +
> > +			scmi_perf: protocol@13 {
> > +				reg =3D <0x13>;
> > +				#power-domain-cells =3D <1>;
> > +			};
> > +
> > +			scmi_clk: protocol@14 {
> > +				reg =3D <0x14>;
> > +				#clock-cells =3D <1>;
> > +			};
> > +
> > +			scmi_sensor: protocol@15 {
> > +				reg =3D <0x15>;
> > +				#thermal-sensor-cells =3D <1>;
> > +			};
> > +		};
> > +	};
> > +
> > +	pmu {
> > +		compatible =3D "arm,cortex-a55-pmu";
> > +		interrupts =3D <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(6) |
> IRQ_TYPE_LEVEL_HIGH)>;
> > +	};
> > +
> > +	thermal-zones {
> > +		a55-thermal {
> > +			polling-delay-passive =3D <250>;
> > +			polling-delay =3D <2000>;
> > +			thermal-sensors =3D <&scmi_sensor 1>;
> > +
> > +			trips {
> > +				cpu_alert0: trip0 {
> > +					temperature =3D <85000>;
> > +					hysteresis =3D <2000>;
> > +					type =3D "passive";
> > +				};
> > +
> > +				cpu_crit0: trip1 {
> > +					temperature =3D <95000>;
> > +					hysteresis =3D <2000>;
> > +					type =3D "critical";
> > +				};
> > +			};
> > +
> > +			cooling-maps {
> > +				map0 {
> > +					trip =3D <&cpu_alert0>;
> > +					cooling-device =3D
> > +						<&A55_0
> THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +						<&A55_1
> THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +						<&A55_2
> THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +						<&A55_3
> THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +						<&A55_4
> THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +						<&A55_5
> THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> > +				};
> > +			};
> > +		};
> > +	};
> > +
> > +	psci {
> > +		compatible =3D "arm,psci-1.0";
> > +		method =3D "smc";
> > +	};
> > +
> > +	timer {
> > +		compatible =3D "arm,armv8-timer";
> > +		interrupts =3D <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(6) |
> IRQ_TYPE_LEVEL_LOW)>,
> > +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(6) |
> IRQ_TYPE_LEVEL_LOW)>,
> > +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(6) |
> IRQ_TYPE_LEVEL_LOW)>,
> > +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(6) |
> IRQ_TYPE_LEVEL_LOW)>;
> > +		clock-frequency =3D <24000000>;
> > +		arm,no-tick-in-suspend;
> > +		interrupt-parent =3D <&gic>;
> > +	};
> > +
> > +	gic: interrupt-controller@48000000 {
> > +		compatible =3D "arm,gic-v3";
> > +		reg =3D <0 0x48000000 0 0x10000>,
> > +		      <0 0x48060000 0 0xc0000>;
> > +		#address-cells =3D <2>;
> > +		#size-cells =3D <2>;
> > +		#interrupt-cells =3D <3>;
> > +		interrupt-controller;
> > +		interrupts =3D <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> > +		interrupt-parent =3D <&gic>;
> > +		dma-noncoherent;
> > +		ranges;
> > +
> > +		its: msi-controller@48040000 {
> > +			compatible =3D "arm,gic-v3-its";
> > +			reg =3D <0 0x48040000 0 0x20000>;
> > +			msi-controller;
> > +			#msi-cells =3D <1>;
> > +			dma-noncoherent;
> > +		};
> > +	};
> > +
> > +	soc {
> > +		compatible =3D "simple-bus";
> > +		#address-cells =3D <2>;
> > +		#size-cells =3D <2>;
> > +		ranges;
> > +
> > +		aips2: bus@42000000 {
> > +			compatible =3D "fsl,aips-bus", "simple-bus";
> > +			reg =3D <0x0 0x42000000 0x0 0x800000>;
> > +			ranges =3D <0x42000000 0x0 0x42000000
> 0x8000000>,
> > +				 <0x28000000 0x0 0x28000000
> 0x10000000>;
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <1>;
> > +
> > +			mu7: mailbox@42430000 {
> > +				compatible =3D "fsl,imx95-mu";
> > +				reg =3D <0x42430000 0x10000>;
> > +				interrupts =3D <GIC_SPI 234
> IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks =3D <&scmi_clk
> IMX95_CLK_BUSWAKEUP>;
> > +				#mbox-cells =3D <2>;
> > +				status =3D "disabled";
> > +			};
> > +
> > +			wdog3: watchdog@42490000 {
> > +				compatible =3D "fsl,imx93-wdt";
> > +				reg =3D <0x42490000 0x10000>;
> > +				interrupts =3D <GIC_SPI 77
> IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks =3D <&scmi_clk
> IMX95_CLK_BUSWAKEUP>;
> > +				timeout-sec =3D <40>;
> > +				status =3D "disabled";
> > +			};
> > +
> > +			tpm3: pwm@424e0000 {
> > +				compatible =3D "fsl,imx7ulp-pwm";
> > +				reg =3D <0x424e0000 0x1000>;
> > +				clocks =3D <&scmi_clk
> IMX95_CLK_BUSWAKEUP>;
> > +				#pwm-cells =3D <3>;
> > +				status =3D "disabled";
> > +			};
> > +
> > +			tpm4: pwm@424f0000 {
> > +				compatible =3D "fsl,imx7ulp-pwm";
> > +				reg =3D <0x424f0000 0x1000>;
> > +				clocks =3D <&scmi_clk IMX95_CLK_TPM4>;
> > +				#pwm-cells =3D <3>;
> > +				status =3D "disabled";
> > +			};
> > +
> > +			tpm5: pwm@42500000 {
> > +				compatible =3D "fsl,imx7ulp-pwm";
> > +				reg =3D <0x42500000 0x1000>;
> > +				clocks =3D <&scmi_clk IMX95_CLK_TPM5>;
> > +				#pwm-cells =3D <3>;
> > +				status =3D "disabled";
> > +			};
> > +
> > +			tpm6: pwm@42510000 {
> > +				compatible =3D "fsl,imx7ulp-pwm";
> > +				reg =3D <0x42510000 0x1000>;
> > +				clocks =3D <&scmi_clk IMX95_CLK_TPM6>;
> > +				#pwm-cells =3D <3>;
> > +				status =3D "disabled";
> > +			};
> > +
> > +			lpi2c3: i2c@42530000 {
> > +				compatible =3D "fsl,imx95-lpi2c", "fsl,imx7ulp-
> lpi2c";
> > +				reg =3D <0x42530000 0x10000>;
> > +				interrupts =3D <GIC_SPI 58
> IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks =3D <&scmi_clk IMX95_CLK_LPI2C3>,
> > +					 <&scmi_clk
> IMX95_CLK_BUSWAKEUP>;
> > +				clock-names =3D "per", "ipg";
> > +				status =3D "disabled";
> > +			};
> > +
> > +			lpi2c4: i2c@42540000 {
> > +				compatible =3D "fsl,imx95-lpi2c", "fsl,imx7ulp-
> lpi2c";
> > +				reg =3D <0x42540000 0x10000>;
> > +				interrupts =3D <GIC_SPI 59
> IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks =3D <&scmi_clk IMX95_CLK_LPI2C4>,
> > +					 <&scmi_clk
> IMX95_CLK_BUSWAKEUP>;
> > +				clock-names =3D "per", "ipg";
> > +				status =3D "disabled";
> > +			};
> > +
> > +			lpspi3: spi@42550000 {
> > +				#address-cells =3D <1>;
> > +				#size-cells =3D <0>;
> > +				compatible =3D "fsl,imx95-spi", "fsl,imx7ulp-
> spi";
> > +				reg =3D <0x42550000 0x10000>;
> > +				interrupts =3D <GIC_SPI 61
> IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks =3D <&scmi_clk IMX95_CLK_LPSPI3>,
> > +					 <&scmi_clk
> IMX95_CLK_BUSWAKEUP>;
> > +				clock-names =3D "per", "ipg";
> > +				status =3D "disabled";
> > +			};
> > +
> > +			lpspi4: spi@42560000 {
> > +				#address-cells =3D <1>;
> > +				#size-cells =3D <0>;
> > +				compatible =3D "fsl,imx95-spi", "fsl,imx7ulp-
> spi";
> > +				reg =3D <0x42560000 0x10000>;
> > +				interrupts =3D <GIC_SPI 62
> IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks =3D <&scmi_clk IMX95_CLK_LPSPI4>,
> > +					 <&scmi_clk
> IMX95_CLK_BUSWAKEUP>;
> > +				clock-names =3D "per", "ipg";
> > +				status =3D "disabled";
> > +			};
> > +
> > +			lpuart3: serial@42570000 {
> > +				compatible =3D "fsl,imx95-lpuart",
> "fsl,imx8ulp-lpuart",
> > +					     "fsl,imx7ulp-lpuart";
> > +				reg =3D <0x42570000 0x1000>;
> > +				interrupts =3D <GIC_SPI 64
> IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks =3D <&scmi_clk IMX95_CLK_LPUART3>;
> > +				clock-names =3D "ipg";
> > +				status =3D "disabled";
> > +			};
> > +
> > +			lpuart4: serial@42580000 {
> > +				compatible =3D "fsl,imx95-lpuart",
> "fsl,imx8ulp-lpuart",
> > +					     "fsl,imx7ulp-lpuart";
> > +				reg =3D <0x42580000 0x1000>;
> > +				interrupts =3D <GIC_SPI 65
> IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks =3D <&scmi_clk IMX95_CLK_LPUART4>;
> > +				clock-names =3D "ipg";
> > +				status =3D "disabled";
> > +			};
> > +
> > +			lpuart5: serial@42590000 {
> > +				compatible =3D "fsl,imx95-lpuart",
> "fsl,imx8ulp-lpuart",
> > +					     "fsl,imx7ulp-lpuart";
> > +				reg =3D <0x42590000 0x1000>;
> > +				interrupts =3D <GIC_SPI 66
> IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks =3D <&scmi_clk IMX95_CLK_LPUART5>;
> > +				clock-names =3D "ipg";
> > +				status =3D "disabled";
> > +			};
> > +
> > +			lpuart6: serial@425a0000 {
> > +				compatible =3D "fsl,imx95-lpuart",
> "fsl,imx8ulp-lpuart",
> > +					     "fsl,imx7ulp-lpuart";
> > +				reg =3D <0x425a0000 0x1000>;
> > +				interrupts =3D <GIC_SPI 67
> IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks =3D <&scmi_clk IMX95_CLK_LPUART6>;
> > +				clock-names =3D "ipg";
> > +				status =3D "disabled";
> > +			};
> > +
> > +			lpuart7: serial@42690000 {
> > +				compatible =3D "fsl,imx95-lpuart",
> "fsl,imx8ulp-lpuart",
> > +					     "fsl,imx7ulp-lpuart";
> > +				reg =3D <0x42690000 0x1000>;
> > +				interrupts =3D <GIC_SPI 68
> IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks =3D <&scmi_clk IMX95_CLK_LPUART7>;
> > +				clock-names =3D "ipg";
> > +				status =3D "disabled";
> > +			};
> > +
> > +			lpuart8: serial@426a0000 {
> > +				compatible =3D "fsl,imx95-lpuart",
> "fsl,imx8ulp-lpuart",
> > +					     "fsl,imx7ulp-lpuart";
> > +				reg =3D <0x426a0000 0x1000>;
> > +				interrupts =3D <GIC_SPI 69
> IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks =3D <&scmi_clk IMX95_CLK_LPUART8>;
> > +				clock-names =3D "ipg";
> > +				status =3D "disabled";
> > +			};
> > +
> > +			lpi2c5: i2c@426b0000 {
> > +				compatible =3D "fsl,imx95-lpi2c", "fsl,imx7ulp-
> lpi2c";
> > +				reg =3D <0x426b0000 0x10000>;
> > +				interrupts =3D <GIC_SPI 181
> IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks =3D <&scmi_clk IMX95_CLK_LPI2C5>,
> > +					 <&scmi_clk
> IMX95_CLK_BUSWAKEUP>;
> > +				clock-names =3D "per", "ipg";
> > +				status =3D "disabled";
> > +			};
> > +
> > +			lpi2c6: i2c@426c0000 {
> > +				compatible =3D "fsl,imx95-lpi2c", "fsl,imx7ulp-
> lpi2c";
> > +				reg =3D <0x426c0000 0x10000>;
> > +				interrupts =3D <GIC_SPI 182
> IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks =3D <&scmi_clk IMX95_CLK_LPI2C6>,
> > +					 <&scmi_clk
> IMX95_CLK_BUSWAKEUP>;
> > +				clock-names =3D "per", "ipg";
> > +				status =3D "disabled";
> > +			};
> > +
> > +			lpi2c7: i2c@426d0000 {
> > +				compatible =3D "fsl,imx95-lpi2c", "fsl,imx7ulp-
> lpi2c";
> > +				reg =3D <0x426d0000 0x10000>;
> > +				interrupts =3D <GIC_SPI 183
> IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks =3D <&scmi_clk IMX95_CLK_LPI2C7>,
> > +					 <&scmi_clk
> IMX95_CLK_BUSWAKEUP>;
> > +				clock-names =3D "per", "ipg";
> > +				status =3D "disabled";
> > +			};
> > +
> > +			lpi2c8: i2c@426e0000 {
> > +				compatible =3D "fsl,imx95-lpi2c", "fsl,imx7ulp-
> lpi2c";
> > +				reg =3D <0x426e0000 0x10000>;
> > +				interrupts =3D <GIC_SPI 184
> IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks =3D <&scmi_clk IMX95_CLK_LPI2C8>,
> > +					 <&scmi_clk
> IMX95_CLK_BUSWAKEUP>;
> > +				clock-names =3D "per", "ipg";
> > +				status =3D "disabled";
> > +			};
> > +
> > +			lpspi5: spi@426f0000 {
> > +				#address-cells =3D <1>;
> > +				#size-cells =3D <0>;
> > +				compatible =3D "fsl,imx95-spi", "fsl,imx7ulp-
> spi";
> > +				reg =3D <0x426f0000 0x10000>;
> > +				interrupts =3D <GIC_SPI 177
> IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks =3D <&scmi_clk IMX95_CLK_LPSPI5>,
> > +					 <&scmi_clk
> IMX95_CLK_BUSWAKEUP>;
> > +				clock-names =3D "per", "ipg";
> > +				status =3D "disabled";
> > +			};
> > +
> > +			lpspi6: spi@42700000 {
> > +				#address-cells =3D <1>;
> > +				#size-cells =3D <0>;
> > +				compatible =3D "fsl,imx95-spi", "fsl,imx7ulp-
> spi";
> > +				reg =3D <0x42700000 0x10000>;
> > +				interrupts =3D <GIC_SPI 178
> IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks =3D <&scmi_clk IMX95_CLK_LPSPI6>,
> > +					 <&scmi_clk
> IMX95_CLK_BUSWAKEUP>;
> > +				clock-names =3D "per", "ipg";
> > +				status =3D "disabled";
> > +			};
> > +
> > +			lpspi7: spi@42710000 {
> > +				#address-cells =3D <1>;
> > +				#size-cells =3D <0>;
> > +				compatible =3D "fsl,imx95-spi", "fsl,imx7ulp-
> spi";
> > +				reg =3D <0x42710000 0x10000>;
> > +				interrupts =3D <GIC_SPI 179
> IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks =3D <&scmi_clk IMX95_CLK_LPSPI7>,
> > +					 <&scmi_clk
> IMX95_CLK_BUSWAKEUP>;
> > +				clock-names =3D "per", "ipg";
> > +				status =3D "disabled";
> > +			};
> > +
> > +			lpspi8: spi@42720000 {
> > +				#address-cells =3D <1>;
> > +				#size-cells =3D <0>;
> > +				compatible =3D "fsl,imx95-spi", "fsl,imx7ulp-
> spi";
> > +				reg =3D <0x42720000 0x10000>;
> > +				interrupts =3D <GIC_SPI 180
> IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks =3D <&scmi_clk IMX95_CLK_LPSPI8>,
> > +					 <&scmi_clk
> IMX95_CLK_BUSWAKEUP>;
> > +				clock-names =3D "per", "ipg";
> > +				status =3D "disabled";
> > +			};
> > +
> > +			mu8: mailbox@42730000 {
> > +				compatible =3D "fsl,imx95-mu";
> > +				reg =3D <0x42730000 0x10000>;
> > +				interrupts =3D <GIC_SPI 235
> IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks =3D <&scmi_clk
> IMX95_CLK_BUSWAKEUP>;
> > +				#mbox-cells =3D <2>;
> > +				status =3D "disabled";
> > +			};
> > +		};
> > +
> > +		aips3: bus@42800000 {
> > +			compatible =3D "fsl,aips-bus", "simple-bus";
> > +			reg =3D <0 0x42800000 0 0x800000>;
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <1>;
> > +			ranges =3D <0x42800000 0x0 0x42800000 0x800000>;
> > +
> > +			usdhc1: mmc@42850000 {
> > +				compatible =3D "fsl,imx95-usdhc",
> "fsl,imx8mm-usdhc";
> > +				reg =3D <0x42850000 0x10000>;
> > +				interrupts =3D <GIC_SPI 86
> IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks =3D <&scmi_clk
> IMX95_CLK_BUSWAKEUP>,
> > +					 <&scmi_clk
> IMX95_CLK_WAKEUPAXI>,
> > +					 <&scmi_clk IMX95_CLK_USDHC1>;
> > +				clock-names =3D "ipg", "ahb", "per";
> > +				assigned-clocks =3D <&scmi_clk
> IMX95_CLK_USDHC1>;
> > +				assigned-clock-parents =3D <&scmi_clk
> IMX95_CLK_SYSPLL1_PFD1>;
> > +				assigned-clock-rates =3D <400000000>;
> > +				bus-width =3D <8>;
> > +				fsl,tuning-start-tap =3D <1>;
> > +				fsl,tuning-step=3D <2>;
> > +				status =3D "disabled";
> > +			};
> > +
> > +			usdhc2: mmc@42860000 {
> > +				compatible =3D "fsl,imx95-usdhc",
> "fsl,imx8mm-usdhc";
> > +				reg =3D <0x42860000 0x10000>;
> > +				interrupts =3D <GIC_SPI 87
> IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks =3D <&scmi_clk
> IMX95_CLK_BUSWAKEUP>,
> > +					 <&scmi_clk
> IMX95_CLK_WAKEUPAXI>,
> > +					 <&scmi_clk IMX95_CLK_USDHC2>;
> > +				clock-names =3D "ipg", "ahb", "per";
> > +				assigned-clocks =3D <&scmi_clk
> IMX95_CLK_USDHC2>;
> > +				assigned-clock-parents =3D <&scmi_clk
> IMX95_CLK_SYSPLL1_PFD1>;
> > +				assigned-clock-rates =3D <400000000>;
> > +				bus-width =3D <4>;
> > +				fsl,tuning-start-tap =3D <1>;
> > +				fsl,tuning-step=3D <2>;
> > +				status =3D "disabled";
> > +			};
> > +
> > +			usdhc3: mmc@428b0000 {
> > +				compatible =3D "fsl,imx95-usdhc",
> "fsl,imx8mm-usdhc";
> > +				reg =3D <0x428b0000 0x10000>;
> > +				interrupts =3D <GIC_SPI 191
> IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks =3D <&scmi_clk
> IMX95_CLK_BUSWAKEUP>,
> > +					 <&scmi_clk
> IMX95_CLK_WAKEUPAXI>,
> > +					 <&scmi_clk IMX95_CLK_USDHC3>;
> > +				clock-names =3D "ipg", "ahb", "per";
> > +				assigned-clock-parents =3D <&scmi_clk
> IMX95_CLK_SYSPLL1_PFD1>;
> > +				assigned-clock-rates =3D <400000000>;
> > +				bus-width =3D <4>;
> > +				fsl,tuning-start-tap =3D <1>;
> > +				fsl,tuning-step=3D <2>;
> > +				status =3D "disabled";
> > +			};
> > +		};
> > +
> > +		gpio2: gpio@43810000 {
> > +			compatible =3D "fsl,imx95-gpio", "fsl,imx8ulp-gpio";
> > +			reg =3D <0x0 0x43810000 0x0 0x1000>;
> > +			gpio-controller;
> > +			#gpio-cells =3D <2>;
> > +			interrupts =3D <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-controller;
> > +			#interrupt-cells =3D <2>;
> > +			clocks =3D <&scmi_clk IMX95_CLK_BUSWAKEUP>,
> > +				 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
> > +			clock-names =3D "gpio", "port";
> > +		};
> > +
> > +		gpio3: gpio@43820000 {
> > +			compatible =3D "fsl,imx95-gpio", "fsl,imx8ulp-gpio";
> > +			reg =3D <0x0 0x43820000 0x0 0x1000>;
> > +			gpio-controller;
> > +			#gpio-cells =3D <2>;
> > +			interrupts =3D <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-controller;
> > +			#interrupt-cells =3D <2>;
> > +			clocks =3D <&scmi_clk IMX95_CLK_BUSWAKEUP>,
> > +				 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
> > +			clock-names =3D "gpio", "port";
> > +		};
> > +
> > +		gpio4: gpio@43840000 {
> > +			compatible =3D "fsl,imx95-gpio", "fsl,imx8ulp-gpio";
> > +			reg =3D <0x0 0x43840000 0x0 0x1000>;
> > +			gpio-controller;
> > +			#gpio-cells =3D <2>;
> > +			interrupts =3D <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-controller;
> > +			#interrupt-cells =3D <2>;
> > +			clocks =3D <&scmi_clk IMX95_CLK_BUSWAKEUP>,
> > +				 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
> > +			clock-names =3D "gpio", "port";
> > +		};
> > +
> > +		gpio5: gpio@43850000 {
> > +			compatible =3D "fsl,imx95-gpio", "fsl,imx8ulp-gpio";
> > +			reg =3D <0x0 0x43850000 0x0 0x1000>;
> > +			gpio-controller;
> > +			#gpio-cells =3D <2>;
> > +			interrupts =3D <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-controller;
> > +			#interrupt-cells =3D <2>;
> > +			clocks =3D <&scmi_clk IMX95_CLK_BUSWAKEUP>,
> > +				 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
> > +			clock-names =3D "gpio", "port";
> > +		};
> > +
> > +		aips1: bus@44000000 {
> > +			compatible =3D "fsl,aips-bus", "simple-bus";
> > +			reg =3D <0x0 0x44000000 0x0 0x800000>;
> > +			ranges =3D <0x44000000 0x0 0x44000000 0x800000>;
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <1>;
> > +
> > +			mu1: mailbox@44220000 {
> > +				compatible =3D "fsl,imx95-mu";
> > +				reg =3D <0x44220000 0x10000>;
> > +				interrupts =3D <GIC_SPI 224
> IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks =3D <&scmi_clk IMX95_CLK_BUSAON>;
> > +				#mbox-cells =3D <2>;
> > +				status =3D "disabled";
> > +			};
> > +
> > +			tpm1: pwm@44310000 {
> > +				compatible =3D "fsl,imx7ulp-pwm";
> > +				reg =3D <0x44310000 0x1000>;
> > +				clocks =3D <&scmi_clk IMX95_CLK_BUSAON>;
> > +				#pwm-cells =3D <3>;
> > +				status =3D "disabled";
> > +			};
> > +
> > +			tpm2: pwm@44320000 {
> > +				compatible =3D "fsl,imx7ulp-pwm";
> > +				reg =3D <0x44320000 0x1000>;
> > +				clocks =3D <&scmi_clk IMX95_CLK_TPM2>;
> > +				#pwm-cells =3D <3>;
> > +				status =3D "disabled";
> > +			};
> > +
> > +			lpi2c1: i2c@44340000 {
> > +				compatible =3D "fsl,imx95-lpi2c", "fsl,imx7ulp-
> lpi2c";
> > +				reg =3D <0x44340000 0x10000>;
> > +				interrupts =3D <GIC_SPI 13
> IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks =3D <&scmi_clk IMX95_CLK_LPI2C1>,
> > +					 <&scmi_clk IMX95_CLK_BUSAON>;
> > +				clock-names =3D "per", "ipg";
> > +				status =3D "disabled";
> > +			};
> > +
> > +			lpi2c2: i2c@44350000 {
> > +				compatible =3D "fsl,imx95-lpi2c", "fsl,imx7ulp-
> lpi2c";
> > +				reg =3D <0x44350000 0x10000>;
> > +				interrupts =3D <GIC_SPI 14
> IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks =3D <&scmi_clk IMX95_CLK_LPI2C2>,
> > +					 <&scmi_clk IMX95_CLK_BUSAON>;
> > +				clock-names =3D "per", "ipg";
> > +				status =3D "disabled";
> > +			};
> > +
> > +			lpspi1: spi@44360000 {
> > +				#address-cells =3D <1>;
> > +				#size-cells =3D <0>;
> > +				compatible =3D "fsl,imx95-spi", "fsl,imx7ulp-
> spi";
> > +				reg =3D <0x44360000 0x10000>;
> > +				interrupts =3D <GIC_SPI 16
> IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks =3D <&scmi_clk IMX95_CLK_LPSPI1>,
> > +					 <&scmi_clk IMX95_CLK_BUSAON>;
> > +				clock-names =3D "per", "ipg";
> > +				status =3D "disabled";
> > +			};
> > +
> > +			lpspi2: spi@44370000 {
> > +				#address-cells =3D <1>;
> > +				#size-cells =3D <0>;
> > +				compatible =3D "fsl,imx95-spi", "fsl,imx7ulp-
> spi";
> > +				reg =3D <0x44370000 0x10000>;
> > +				interrupts =3D <GIC_SPI 17
> IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks =3D <&scmi_clk IMX95_CLK_LPSPI2>,
> > +					 <&scmi_clk IMX95_CLK_BUSAON>;
> > +				clock-names =3D "per", "ipg";
> > +				status =3D "disabled";
> > +			};
> > +
> > +			lpuart1: serial@44380000 {
> > +				compatible =3D "fsl,imx95-lpuart",
> "fsl,imx8ulp-lpuart",
> > +					     "fsl,imx7ulp-lpuart";
> > +				reg =3D <0x44380000 0x1000>;
> > +				interrupts =3D <GIC_SPI 19
> IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks =3D <&scmi_clk IMX95_CLK_LPUART1>;
> > +				clock-names =3D "ipg";
> > +				status =3D "disabled";
> > +			};
> > +
> > +			lpuart2: serial@44390000 {
> > +				compatible =3D "fsl,imx95-lpuart",
> "fsl,imx8ulp-lpuart",
> > +					     "fsl,imx7ulp-lpuart";
> > +				reg =3D <0x44390000 0x1000>;
> > +				interrupts =3D <GIC_SPI 20
> IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks =3D <&scmi_clk IMX95_CLK_LPUART2>;
> > +				clock-names =3D "ipg";
> > +				status =3D "disabled";
> > +			};
> > +
> > +			adc1: adc@44530000 {
> > +				compatible =3D "nxp,imx93-adc";
> > +				reg =3D <0x44530000 0x10000>;
> > +				interrupts =3D <GIC_SPI 199
> IRQ_TYPE_LEVEL_HIGH>,
> > +					     <GIC_SPI 200
> IRQ_TYPE_LEVEL_HIGH>,
> > +					     <GIC_SPI 201
> IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks =3D <&scmi_clk IMX95_CLK_ADC>;
> > +				clock-names =3D "ipg";
> > +				status =3D "disabled";
> > +			};
> > +
> > +			mu2: mailbox@445b0000 {
> > +				compatible =3D "fsl,imx95-mu";
> > +				reg =3D <0x445b0000 0x1000>;
> > +				ranges;
> > +				interrupts =3D <GIC_SPI 226
> IRQ_TYPE_LEVEL_HIGH>;
> > +				#address-cells =3D <1>;
> > +				#size-cells =3D <1>;
> > +				#mbox-cells =3D <2>;
> > +
> > +				sram0: sram@445b1000 {
> > +					compatible =3D "mmio-sram";
> > +					reg =3D <0x445b1000 0x400>;
> > +					ranges =3D <0x0 0x445b1000 0x400>;
> > +					#address-cells =3D <1>;
> > +					#size-cells =3D <1>;
> > +
> > +					scmi_buf0: scmi-sram-section@0 {
> > +						compatible =3D "arm,scmi-
> shmem";
> > +						reg =3D <0x0 0x80>;
> > +					};
> > +
> > +					scmi_buf1: scmi-sram-section@80
> {
> > +						compatible =3D "arm,scmi-
> shmem";
> > +						reg =3D <0x80 0x80>;
> > +					};
> > +				};
> > +
> > +			};
> > +
> > +			mu3: mailbox@445d0000 {
> > +				compatible =3D "fsl,imx95-mu";
> > +				reg =3D <0x445d0000 0x10000>;
> > +				interrupts =3D <GIC_SPI 228
> IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks =3D <&scmi_clk IMX95_CLK_BUSAON>;
> > +				#mbox-cells =3D <2>;
> > +				status =3D "disabled";
> > +			};
> > +
> > +			mu4: mailbox@445f0000 {
> > +				compatible =3D "fsl,imx95-mu";
> > +				reg =3D <0x445f0000 0x10000>;
> > +				interrupts =3D <GIC_SPI 230
> IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks =3D <&scmi_clk IMX95_CLK_BUSAON>;
> > +				#mbox-cells =3D <2>;
> > +				status =3D "disabled";
> > +			};
> > +
> > +			mu6: mailbox@44630000 {
> > +				compatible =3D "fsl,imx95-mu";
> > +				reg =3D <0x44630000 0x10000>;
> > +				interrupts =3D <GIC_SPI 206
> IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks =3D <&scmi_clk IMX95_CLK_BUSAON>;
> > +				#mbox-cells =3D <2>;
> > +				status =3D "disabled";
> > +			};
> > +		};
> > +
> > +		mailbox@47320000 {
> > +			compatible =3D "fsl,imx95-mu-v2x";
> > +			reg =3D <0x0 0x47320000 0x0 0x10000>;
> > +			interrupts =3D <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH>;
> > +			#mbox-cells =3D <2>;
> > +		};
> > +
> > +		mailbox@47350000 {
> > +			compatible =3D "fsl,imx95-mu-v2x";
> > +			reg =3D <0x0 0x47350000 0x0 0x10000>;
> > +			interrupts =3D <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>;
> > +			#mbox-cells =3D <2>;
> > +		};
> > +
> > +		/* GPIO1 is under exclusive control of System Manager */
> > +		gpio1: gpio@47400000 {
> > +			compatible =3D "fsl,imx95-gpio", "fsl,imx8ulp-gpio";
> > +			reg =3D <0x0 0x47400000 0x0 0x1000>;
> > +			gpio-controller;
> > +			#gpio-cells =3D <2>;
> > +			interrupts =3D <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-controller;
> > +			#interrupt-cells =3D <2>;
> > +			clocks =3D <&scmi_clk IMX95_CLK_M33>,
> > +				 <&scmi_clk IMX95_CLK_M33>;
> > +			clock-names =3D "gpio", "port";
> > +			status =3D "disabled";
> > +		};
> > +
> > +		elemu0: mailbox@47520000 {
> > +			compatible =3D "fsl,imx95-mu-ele";
> > +			reg =3D <0x0 0x47520000 0x0 0x10000>;
> > +			interrupts =3D <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
> > +			#mbox-cells =3D <2>;
> > +			status =3D "disabled";
> > +		};
> > +
> > +		elemu1: mailbox@47530000 {
> > +			compatible =3D "fsl,imx95-mu-ele";
> > +			reg =3D <0x0 0x47530000 0x0 0x10000>;
> > +			interrupts =3D <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
> > +			#mbox-cells =3D <2>;
> > +			status =3D "disabled";
> > +		};
> > +
> > +		elemu2: mailbox@47540000 {
> > +			compatible =3D "fsl,imx95-mu-ele";
> > +			reg =3D <0x0 0x47540000 0x0 0x10000>;
> > +			interrupts =3D <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
> > +			#mbox-cells =3D <2>;
> > +			status =3D "disabled";
> > +		};
> > +
> > +		elemu3: mailbox@47550000 {
> > +			compatible =3D "fsl,imx95-mu-ele";
> > +			reg =3D <0x0 0x47550000 0x0 0x10000>;
> > +			interrupts =3D <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
> > +			#mbox-cells =3D <2>;
> > +		};
> > +
> > +		elemu4: mailbox@47560000 {
> > +			compatible =3D "fsl,imx95-mu-ele";
> > +			reg =3D <0x0 0x47560000 0x0 0x10000>;
> > +			interrupts =3D <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> > +			#mbox-cells =3D <2>;
> > +			status =3D "disabled";
> > +		};
> > +
> > +		elemu5: mailbox@47570000 {
> > +			compatible =3D "fsl,imx95-mu-ele";
> > +			reg =3D <0x0 0x47570000 0x0 0x10000>;
> > +			interrupts =3D <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> > +			#mbox-cells =3D <2>;
> > +			status =3D "disabled";
> > +		};
> > +
> > +		aips4: bus@49000000 {
> > +			compatible =3D "fsl,aips-bus", "simple-bus";
> > +			reg =3D <0x0 0x49000000 0x0 0x800000>;
> > +			ranges =3D <0x49000000 0x0 0x49000000 0x800000>;
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <1>;
> > +
> > +			smmu: iommu@490d0000 {
> > +				compatible =3D "arm,smmu-v3";
> > +				reg =3D <0x490d0000 0x100000>;
> > +				interrupts =3D <GIC_SPI 325
> IRQ_TYPE_EDGE_RISING>,
> > +					     <GIC_SPI 328
> IRQ_TYPE_EDGE_RISING>,
> > +					     <GIC_SPI 334
> IRQ_TYPE_EDGE_RISING>,
> > +					     <GIC_SPI 326
> IRQ_TYPE_EDGE_RISING>;
> > +				interrupt-names =3D "eventq", "gerror", "priq",
> "cmdq-sync";
> > +				#iommu-cells =3D <1>;
> > +				status =3D "disabled";
> > +			};
> > +		};
> > +	};
> > +};
> >
> > --
> > 2.37.1
> >

