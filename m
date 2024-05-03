Return-Path: <linux-kernel+bounces-167092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2228BA46F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 02:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 219881F2478F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE4923BE;
	Fri,  3 May 2024 00:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JjnXDsnW"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2054.outbound.protection.outlook.com [40.107.6.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72CF4A09;
	Fri,  3 May 2024 00:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714695354; cv=fail; b=ThxXneqCqrRapFSBNCt/6IDdwLAJ2g6VcVVzBMLnGSZpy6/ho9kCigMtuAoRUfjck4rM+kHbvVIpnHXRC62T2Pc8rOHJ5Pj7X28s2eTsEMoq9jIxQpiEAvj9wmI+hK9AfJcSTEyoGIVZ1FD1krzgpgZtTeQBrc2DPgTcgRw2A2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714695354; c=relaxed/simple;
	bh=zgnXw7x58vHqsKMZVBhT/F92eFGQc5VFcF6aOb4n/dY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aeF3orzOLoLr417XI/8pLJQv7NGWBZW8K0CyKL19VKYlbtV+2OEB7h56y/Vws0j/jAg/EQ3sxXad95z7UYNhifdv4fl3xzpWPjJt2hUWz3kymFbP8oz6AEN+oMTG0k2GZ1yPAky5yii9ljgBnarLzPDzMLUiMdJjm/EDSL0Pq5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=JjnXDsnW; arc=fail smtp.client-ip=40.107.6.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GL24QJ7yqoyJIs8HqMliRsfCfEf/MlwHhsQuRGEwR8cyYLIkUszb35Bzu85CDqIEbou1u46m4rpjEWEm68XEZNyOB7o8MteVGGYA7NOKBjCK1tNdaVB1EVy/FhBQe2UH9fsFSX4dJPLpXy+oNfJrQLvSibajd4J3xEWk0tVzzP/jIcI8407w9Jl/AGSjOfOKcpkJzm0yIapG+Y9Ks1Nu2G7n3T8tIr6QRGvEWnFhP+xBAZC7+m5o68veYQh7K/paXBtd9h7oZvlBpBQ4Gaa6ylPxlyIp+mT1Wjcnud5lw9EpDuA9niJqZIPFVz0khJ64+pF3Hs5+3FIQZfoKdvBGog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/RZ3QSmHt04sCa+0cjdoExSHtx7uQgvR6qXxM2IVMaM=;
 b=P/zEbP1d1txMvvgxkNZz99SadEsU9CmCR6JqmN8ead+EpV4sA+7E8b1p2PgLj0cY698/DSuDM/BQMRtOer418gWooFZBXo+buwORnHBFJa1cDZRuXlfOpmGoj35pvRUzsCmPvpjuxCI7qqo8xUTnJyg4r45LE5/zdI10BUiew6Bp7uTl71GRiKNDqmiThA0sc7iXvLM1xaJ9sRMWba0/GXAUb/8ZMD72R4HVgsupcGeZLo400ZPZmJ5Rg/CFSPfKmHAwFIovmQG2QH35qJOo05UXPz/DdeF22aHnc/xA4ED0BYyIhtSsSxvNuKv+GdhdOYFTyKqQXTRwSx1rSBceag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RZ3QSmHt04sCa+0cjdoExSHtx7uQgvR6qXxM2IVMaM=;
 b=JjnXDsnWOKE30um9itZC4uYAJzB7d3j4rt6Aw3xvPY7mQGKGv3sfGQGym4I7kFgAt1j2K8H9gbgDrU+geW8omhO5ez70hsM8wJXqN194Iipr0thoqM2unEB/C9xQs6hG+WVfTSuC72P2FAi8htOMEzPJBzBuQD9s5d+ore9t61U=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7307.eurprd04.prod.outlook.com (2603:10a6:102:84::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Fri, 3 May
 2024 00:15:47 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 00:15:47 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
Subject: RE: [PATCH v3 2/3] arm64: dts: freescale: add i.MX95 basic dtsi
Thread-Topic: [PATCH v3 2/3] arm64: dts: freescale: add i.MX95 basic dtsi
Thread-Index: AQHamWWkIJiJhAdaIkCK0hDnA+kWZLF+4uyAgAXEwFA=
Date: Fri, 3 May 2024 00:15:47 +0000
Message-ID:
 <DU0PR04MB94177B9F0B13FF0A0992A7B6881F2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240428-imx95-dts-v3-v3-0-765395f88b9f@nxp.com>
 <20240428-imx95-dts-v3-v3-2-765395f88b9f@nxp.com>
 <4938664.31r3eYUQgx@steina-w>
In-Reply-To: <4938664.31r3eYUQgx@steina-w>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PR3PR04MB7307:EE_
x-ms-office365-filtering-correlation-id: f239bc0e-7c69-4591-67fa-08dc6b062e58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|7416005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Ru07msUGOz4aq61EO9ikWRKE2euhd8PscxxJN7/EHncdPKKAuq971Z1yqV?=
 =?iso-8859-1?Q?75PLX0XvOlaYgWzA2AH1Stx8Yc5CXB+lMv6hnsejNf9M/Y5ymsA3Yokam5?=
 =?iso-8859-1?Q?+e3huBL/L2DR4gHjdEnyDCwULZUnnNMgaU7GFCwEK63bA5nujhZalsDYmD?=
 =?iso-8859-1?Q?TAXfgrEBQIlxLvVGSUCFaijJLibqAWnK23GU2mSQ78DJHF6W5gHe95R61L?=
 =?iso-8859-1?Q?1cLhKsEwWtXvLWM/1QtHCtytVZA/Whhfz6YZe9eu3vJS/Yg6E6OgNCwzPS?=
 =?iso-8859-1?Q?L+J35RhecUR39PHb03lPpBkskmNErgEZgVtzTH3vIjiN3JzsxgyjHWuvYQ?=
 =?iso-8859-1?Q?p3Ckhh+7mLMTU48AGer/JkQXFX6BBT+1a/XgXLQ1/0MDVdFlY0m0/BR0nX?=
 =?iso-8859-1?Q?aVfoYWEiCcxcpuIX8pA9U1NrTNH+9w0MYraz8P6lbp7JEC8mVa3k8KJUMh?=
 =?iso-8859-1?Q?itoDRZHsrghV9J8Ve/m24LPjU+61mtqi/r+EYteyJ7xNfOv9x/MKJAJZTo?=
 =?iso-8859-1?Q?NsWYprETCjjp2uKGOrQ4Dr9OeJA7h0q3fNd2xhr23JO0yu8+Xkqez4xuHs?=
 =?iso-8859-1?Q?bTU8bginH4M9J3U9lajZ1F41bwV1x2iJMT0Attq3+O0emz0CbtpqV7kCRy?=
 =?iso-8859-1?Q?1UyVfpjvmd8AcoRABCAfU+att8BnYfzW1m4ClfNxxJgWWMsyeW2+Tzqo4l?=
 =?iso-8859-1?Q?KRkSHpcnjU0DUYf/5IeKNWuqqznhQV1GRCJaHHtxH/0azrxMJYRSIOxsIU?=
 =?iso-8859-1?Q?LY2Ms3tFk6O73VMpDUHLxRM+QtVJyzu0FXlu3L9jebTK/p04m5XeHirEKO?=
 =?iso-8859-1?Q?BXMEpyBD40OpqfZq5NediEilXpgBo45rKL6meMizM80IbkygQbjrfbHyjN?=
 =?iso-8859-1?Q?nhBpuA7zm579Baw+Bdf6n18NWNB6ISvIDhdKu6kNT7PAxERb1wz6kZgwgX?=
 =?iso-8859-1?Q?/s32nr1vTNxWkcPzxNY05AcX80tCafxCs10PQgYGCIY8g0KpFxe1uwLYVv?=
 =?iso-8859-1?Q?OJv2ePn/bv+3gwOZPAZs96fKEb+LJIaM8SMDF21y/lR68dSQz00pNr9oQ9?=
 =?iso-8859-1?Q?Ivv9W9Yp+G2sH6IRidhqS4o5ZAUDeOVv9geRpiE8alyweNEn+irkVqNyJj?=
 =?iso-8859-1?Q?NW168ZEczZuMMpCBsjjAFG2mUa15cKX5M9aJfzVlW5FZ/etfZAoC76hMdo?=
 =?iso-8859-1?Q?zEqMtZxDpkLetKfILQCr4CD1qEyHfGxpTQCrdubRLPIHAhnfP+7zVvjBpu?=
 =?iso-8859-1?Q?/hD0iLobW4hXxmKxBl5TOJFzMwH4lDUg/rqhczHavddBdsWINebD3mhD3k?=
 =?iso-8859-1?Q?9CFaVHYQI71irIv+Z2MAfQHAUg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?gqkwU/1HvwTnzxB2BWIQKLtMJrs/FpTmGNM6WkNacF83v5RS/nbUNku+aA?=
 =?iso-8859-1?Q?YTpXF5QlbqiuCH2bxSKb/T53YFn7rJXQjLzWtnbrmZC+joqnj/CB8iEE1m?=
 =?iso-8859-1?Q?vdRsUFpPNDDFnDHN2xusUbDo0vrcZHS77crllvI1kEyl0gQ7bh207p6YyH?=
 =?iso-8859-1?Q?L0h/qY7j2mkggk1uxSJdsxtW4MT7IbzrHGNFvzS1zzv1QZAJ0bdTFKsNGB?=
 =?iso-8859-1?Q?SxqnT4Iir1DGFWZ2avjkUui4G87vjgUSy3AdVnMLIK9HNVM0ttbRtPJwi5?=
 =?iso-8859-1?Q?4AF2znfciKQyXm4sBgRfLiD20196zq/d4uIvJdNWrIPG5cTmR2MK5C6N+u?=
 =?iso-8859-1?Q?7NMnCTEEA4LSV4Pb9G45bWVbbiuDwrGYyGbOxYMm09992KVMdAPQOj9yCc?=
 =?iso-8859-1?Q?zW4mQsezmAdAXiSgqnBcapsbWtI96tZNSMB7+cFbbXI0ZYVRtAhv+8GVO/?=
 =?iso-8859-1?Q?v28SFG07NtGur6oPuNi43YJsuFxM3nW0PjpiGvR2LFqxlOPa6BEkEYpYOP?=
 =?iso-8859-1?Q?ZnrsUEs/SH+gTHak745Fmluk9aqC41h14/IjfB9CFkvAPoN+nlN0rAfXoJ?=
 =?iso-8859-1?Q?k4dzvDgTqF05W4nbiPBWMs0uIGfaaXt5cp29BXN3O+S+ZqSQDAU7a0qN+7?=
 =?iso-8859-1?Q?HtsNHoe1ggqaYi6zc9TNQZoTE9EZQRlQSidi+loT+Si72lmX2vTuV6RY1D?=
 =?iso-8859-1?Q?VKo0/Cmu0Aj6nwMWwoUAaT/nbjgk10OAJGH21gO5i4dKSF3TPb32n5tboS?=
 =?iso-8859-1?Q?4pTAX4kKrVN4LCAUTCUx0q0QSX4bRI+extdzQoM1m/d9H96XwYwZi8tflJ?=
 =?iso-8859-1?Q?nNHLJSa6ROWrPNjq5Sah/arjYF1MQRIdtDUHDxZfh+Bbu/60yP160TgtrW?=
 =?iso-8859-1?Q?vjvdKxdHdnFhBsRyYy81kQOMXahhXmfw8qsWFM0K7/JQq/4hqOdW94d0pJ?=
 =?iso-8859-1?Q?9EvVM0I3zC8/4sfTEXH5iXwoT7993boVR+LWZz16Q46aJNbV/BvStG6rFC?=
 =?iso-8859-1?Q?PK4Af5YMbrLoJFG3/VLaUnla4daGHtH/M0KPQBjjGfsTgrKoZNeG6fwFWf?=
 =?iso-8859-1?Q?SbSzCHICkaeFjNhbBU3fy7RxfRGdtG3iAsajL67hE2kk82fK5tMhzKo9vQ?=
 =?iso-8859-1?Q?pficqFxmEm4zJVndbdDUxrpug/uKRiqIqhk4IHtxwgEy01CMvbrjABZzl+?=
 =?iso-8859-1?Q?eGThA3SAaQircqe4pYn44cVvoVFlQXdZU4GUZvFKG5Qm4HxyTLdU1YAyy/?=
 =?iso-8859-1?Q?hTX7qFy+l4avITBhcscjPkbSiGLFR2OXIclYsT/RUsRHwJS/Lj2/EztQx5?=
 =?iso-8859-1?Q?+DjC75EY6PizSdPGb6cBuK1k43qxAuCkZPg95UvM2VgROrSvlhPg/jfdV0?=
 =?iso-8859-1?Q?pIiEkQTMEUDR8C9N452HeRTP5Hl201dodanWcvTSkMBC8SYAiQ9bLwxMnn?=
 =?iso-8859-1?Q?Vgco1vvpt47PPCLF00pmbKJCs4+Vjw01YKqF9kQENZLg8Eg5uA6OSpRfEX?=
 =?iso-8859-1?Q?sbgaPANEGadfjvn42Y3W13L8DecjyQZ38gE8PtAT29FdsrrN9qpiHXO2kh?=
 =?iso-8859-1?Q?JZYUo4MQAt7CoB0S2gPFgaeHzwWoh9f5z2B2e7LEU7R/zcMccMtIs6VN50?=
 =?iso-8859-1?Q?ajGu/oObhi0XU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f239bc0e-7c69-4591-67fa-08dc6b062e58
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2024 00:15:47.0825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cYe3B799/gS0r+d+llbIESxoiXpiAa2X1n3VMUcvI8nfsLyytHQNNsckihgahRCppAsylCfKgsQjL+IY2uzYUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7307

> Subject: Re: [PATCH v3 2/3] arm64: dts: freescale: add i.MX95 basic dtsi
>
> Hi Peng,
>
> thanks for your patch.
>
> Am Sonntag, 28. April 2024, 14:22:20 CEST schrieb Peng Fan (OSS):
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > i.MX95 features 6 A55 Cores, ARM Mali GPU, ISP, ML acceleration NPU,
> > and Edgelock secure enclave security. This patch is to add a minimal
> > dtsi, with cpu cores, coresight, scmi, gic, uart, mu, sdhc, lpi2c added=
.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx95-clock.h |  187 +++++
> >  arch/arm64/boot/dts/freescale/imx95-power.h |   55 ++
> >  arch/arm64/boot/dts/freescale/imx95.dtsi    | 1152
> +++++++++++++++++++++++++++
> >  3 files changed, 1394 insertions(+)
> >
> > [snip]
> > diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi
> > b/arch/arm64/boot/dts/freescale/imx95.dtsi
> > new file mode 100644
> > index 000000000000..f52023ec7f0c
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
> > [snip]
> > +   soc {
> > +           compatible =3D "simple-bus";
> > +           #address-cells =3D <2>;
> > +           #size-cells =3D <2>;
> > +           ranges;
> > +
> > +           aips2: bus@42000000 {
> > +                   compatible =3D "fsl,aips-bus", "simple-bus";
> > +                   reg =3D <0x0 0x42000000 0x0 0x800000>;
> > +                   ranges =3D <0x42000000 0x0 0x42000000
> 0x8000000>,
> > +                            <0x28000000 0x0 0x28000000
> 0x10000000>;
> > +                   #address-cells =3D <1>;
> > +                   #size-cells =3D <1>;
> > +
> > +                   mu7: mailbox@42430000 {
> > +                           compatible =3D "fsl,imx95-mu";
> > +                           reg =3D <0x42430000 0x10000>;
> > +                           interrupts =3D <GIC_SPI 234
> IRQ_TYPE_LEVEL_HIGH>;
> > +                           clocks =3D <&scmi_clk
> IMX95_CLK_BUSWAKEUP>;
> > +                           #mbox-cells =3D <2>;
> > +                           status =3D "disabled";
> > +                   };
> > +
> > +                   mu8: mailbox@42730000 {
>
> Please sort all nodes by address.

Sure. fix in v4.
>
> > +                           compatible =3D "fsl,imx95-mu";
> > +                           reg =3D <0x42730000 0x10000>;
> > +                           interrupts =3D <GIC_SPI 235
> IRQ_TYPE_LEVEL_HIGH>;
> > +                           clocks =3D <&scmi_clk
> IMX95_CLK_BUSWAKEUP>;
> > +                           #mbox-cells =3D <2>;
> > +                           status =3D "disabled";
> > +                   };
> > +
> > +                   wdog3: watchdog@42490000 {
> > +                           compatible =3D "fsl,imx93-wdt";
> > +                           reg =3D <0x42490000 0x10000>;
> > +                           interrupts =3D <GIC_SPI 77
> IRQ_TYPE_LEVEL_HIGH>;
> > +                           clocks =3D <&scmi_clk
> IMX95_CLK_BUSWAKEUP>;
> > +                           timeout-sec =3D <40>;
> > +                           fsl,ext-reset-output;
>
> Isn't this board specific?

Yeah. Board specific, remove it.
>
> > +                           status =3D "disabled";
> > +                   };
> > +
> > +                   tpm3: pwm@424e0000 {
> > +                           compatible =3D "fsl,imx7ulp-pwm";
> > +                           reg =3D <0x424e0000 0x1000>;
> > +                           clocks =3D <&scmi_clk
> IMX95_CLK_BUSWAKEUP>;
> > +                           #pwm-cells =3D <3>;
> > +                           status =3D "disabled";
> > +                   };
> > [snip]
> > +           };
> > +
> > +           aips3: bus@42800000 {
> > +                   compatible =3D "fsl,aips-bus", "simple-bus";
> > +                   reg =3D <0 0x42800000 0 0x800000>;
> > +                   #address-cells =3D <1>;
> > +                   #size-cells =3D <1>;
> > +                   ranges =3D <0x42800000 0x0 0x42800000 0x800000>;
> > +
> > +                   usdhc1: mmc@42850000 {
> > +                           compatible =3D "fsl,imx95-usdhc",
> "fsl,imx8mm-usdhc";
> > +                           reg =3D <0x42850000 0x10000>;
> > +                           interrupts =3D <GIC_SPI 86
> IRQ_TYPE_LEVEL_HIGH>;
> > +                           clocks =3D <&scmi_clk
> IMX95_CLK_BUSWAKEUP>,
> > +                                    <&scmi_clk
> IMX95_CLK_WAKEUPAXI>,
> > +                                    <&scmi_clk IMX95_CLK_USDHC1>;
> > +                           clock-names =3D "ipg", "ahb", "per";
> > +                           assigned-clocks =3D <&scmi_clk
> IMX95_CLK_USDHC1>;
> > +                           assigned-clock-parents =3D <&scmi_clk
> IMX95_CLK_SYSPLL1_PFD1>;
> > +                           assigned-clock-rates =3D <400000000>;
> > +                           bus-width =3D <8>;
> > +                           fsl,tuning-start-tap =3D <1>;
> > +                           fsl,tuning-step=3D <2>;
>
> Isn't this board specific? Or is there a hardware limitation?

Yeah, just follow what imx93 has, board could override them.
No hardware limitation as I know.

>
> > +                           status =3D "disabled";
> > +                   };
> > +
> > +                   usdhc2: mmc@42860000 {
> > +                           compatible =3D "fsl,imx95-usdhc",
> "fsl,imx8mm-usdhc";
> > +                           reg =3D <0x42860000 0x10000>;
> > +                           interrupts =3D <GIC_SPI 87
> IRQ_TYPE_LEVEL_HIGH>;
> > +                           clocks =3D <&scmi_clk
> IMX95_CLK_BUSWAKEUP>,
> > +                                    <&scmi_clk
> IMX95_CLK_WAKEUPAXI>,
> > +                                    <&scmi_clk IMX95_CLK_USDHC2>;
> > +                           clock-names =3D "ipg", "ahb", "per";
> > +                           assigned-clocks =3D <&scmi_clk
> IMX95_CLK_USDHC2>;
> > +                           assigned-clock-parents =3D <&scmi_clk
> IMX95_CLK_SYSPLL1_PFD1>;
> > +                           assigned-clock-rates =3D <200000000>;
>
> Why is usdhc2 only 200 MHz but usdhc1 400 MHz?

No specific reason, 400M should also work.

>
> > +                           bus-width =3D <4>;
> > +                           fsl,tuning-start-tap =3D <1>;
> > +                           fsl,tuning-step=3D <2>;
>
> Isn't this board specific? Or is there a hardware limitation?

Yes, just follow what i.MX93 has and board could override them.

>
> > +                           status =3D "disabled";
> > +                   };
> > +
> > +                   usdhc3: mmc@428b0000 {
> > +                           compatible =3D "fsl,imx95-usdhc",
> "fsl,imx8mm-usdhc";
> > +                           reg =3D <0x428b0000 0x10000>;
> > +                           interrupts =3D <GIC_SPI 191
> IRQ_TYPE_LEVEL_HIGH>;
> > +                           clocks =3D <&scmi_clk
> IMX95_CLK_BUSWAKEUP>,
> > +                                    <&scmi_clk
> IMX95_CLK_WAKEUPAXI>,
> > +                                    <&scmi_clk IMX95_CLK_USDHC3>;
> > +                           clock-names =3D "ipg", "ahb", "per";
>
> No need to configure IMX95_CLK_USDHC3?

I will add it.

>
> > +                           bus-width =3D <4>;
> > +                           fsl,tuning-start-tap =3D <1>;
> > +                           fsl,tuning-step=3D <2>;
> > +                           status =3D "disabled";
> > +                   };
> > +           };
> > +
> > +           gpio2: gpio@43810000 {
> > +                   compatible =3D "fsl,imx95-gpio", "fsl,imx8ulp-gpio"=
;
> > +                   reg =3D <0x0 0x43810000 0x0 0x1000>;
> > +                   gpio-controller;
> > +                   #gpio-cells =3D <2>;
> > +                   interrupts =3D <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
> > +                                <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
> > +                   interrupt-controller;
> > +                   #interrupt-cells =3D <2>;
> > +                   clocks =3D <&scmi_clk IMX95_CLK_BUSWAKEUP>,
> > +                            <&scmi_clk IMX95_CLK_BUSWAKEUP>;
> > +                   clock-names =3D "gpio", "port";
> > +           };
> > +
> > +           gpio3: gpio@43820000 {
> > +                   compatible =3D "fsl,imx95-gpio", "fsl,imx8ulp-gpio"=
;
> > +                   reg =3D <0x0 0x43820000 0x0 0x1000>;
> > +                   gpio-controller;
> > +                   #gpio-cells =3D <2>;
> > +                   interrupts =3D <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>,
> > +                                <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
> > +                   interrupt-controller;
> > +                   #interrupt-cells =3D <2>;
> > +                   clocks =3D <&scmi_clk IMX95_CLK_BUSWAKEUP>,
> > +                            <&scmi_clk IMX95_CLK_BUSWAKEUP>;
> > +                   clock-names =3D "gpio", "port";
> > +           };
> > +
> > +           gpio4: gpio@43840000 {
> > +                   compatible =3D "fsl,imx95-gpio", "fsl,imx8ulp-gpio"=
;
> > +                   reg =3D <0x0 0x43840000 0x0 0x1000>;
> > +                   gpio-controller;
> > +                   #gpio-cells =3D <2>;
> > +                   interrupts =3D <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
> > +                                <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
> > +                   interrupt-controller;
> > +                   #interrupt-cells =3D <2>;
> > +                   clocks =3D <&scmi_clk IMX95_CLK_BUSWAKEUP>,
> > +                            <&scmi_clk IMX95_CLK_BUSWAKEUP>;
> > +                   clock-names =3D "gpio", "port";
> > +           };
> > +
> > +           gpio5: gpio@43850000 {
> > +                   compatible =3D "fsl,imx95-gpio", "fsl,imx8ulp-gpio"=
;
> > +                   reg =3D <0x0 0x43850000 0x0 0x1000>;
> > +                   gpio-controller;
> > +                   #gpio-cells =3D <2>;
> > +                   interrupts =3D <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
> > +                                <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> > +                   interrupt-controller;
> > +                   #interrupt-cells =3D <2>;
> > +                   clocks =3D <&scmi_clk IMX95_CLK_BUSWAKEUP>,
> > +                            <&scmi_clk IMX95_CLK_BUSWAKEUP>;
> > +                   clock-names =3D "gpio", "port";
> > +           };
> > +
> > +           aips1: bus@44000000 {
> > +                   compatible =3D "fsl,aips-bus", "simple-bus";
> > +                   reg =3D <0x0 0x44000000 0x0 0x800000>;
> > +                   ranges =3D <0x44000000 0x0 0x44000000 0x800000>;
> > +                   #address-cells =3D <1>;
> > +                   #size-cells =3D <1>;
> > +
> > +                   mu1: mailbox@44220000 {
> > +                           compatible =3D "fsl,imx95-mu";
> > +                           reg =3D <0x44220000 0x10000>;
> > +                           interrupts =3D <GIC_SPI 224
> IRQ_TYPE_LEVEL_HIGH>;
> > +                           clocks =3D <&scmi_clk IMX95_CLK_BUSAON>;
> > +                           #mbox-cells =3D <2>;
> > +                           status =3D "disabled";
> > +                   };
> > +
> > +                   mu2: mailbox@445b0000 {
> > +                           compatible =3D "fsl,imx95-mu";
> > +                           reg =3D <0x445b0000 0x1000>;
> > +                           ranges;
> > +                           interrupts =3D <GIC_SPI 226
> IRQ_TYPE_LEVEL_HIGH>;
> > +                           #address-cells =3D <1>;
> > +                           #size-cells =3D <1>;
> > +                           #mbox-cells =3D <2>;
> > +
> > +                           sram0: sram@445b1000 {
> > +                                   compatible =3D "mmio-sram";
> > +                                   reg =3D <0x445b1000 0x400>;
> > +                                   ranges =3D <0x0 0x445b1000 0x400>;
> > +                                   #address-cells =3D <1>;
> > +                                   #size-cells =3D <1>;
> > +
> > +                                   scmi_buf0: scmi-sram-section@0 {
> > +                                           compatible =3D "arm,scmi-
> shmem";
> > +                                           reg =3D <0x0 0x80>;
> > +                                   };
> > +
> > +                                   scmi_buf1: scmi-sram-section@80
> {
> > +                                           compatible =3D "arm,scmi-
> shmem";
> > +                                           reg =3D <0x80 0x80>;
> > +                                   };
> > +                           };
>
> I guess this MU depends on the system manager firmware, no?

Yes, depends on firmware.

>
> > +                   };
> > +
> > +                   mu3: mailbox@445d0000 {
> > +                           compatible =3D "fsl,imx95-mu";
> > +                           reg =3D <0x445d0000 0x10000>;
> > +                           interrupts =3D <GIC_SPI 228
> IRQ_TYPE_LEVEL_HIGH>;
> > +                           clocks =3D <&scmi_clk IMX95_CLK_BUSAON>;
> > +                           #mbox-cells =3D <2>;
> > +                           status =3D "disabled";
> > +                   };
> > +
> > +                   mu4: mailbox@445f0000 {
> > +                           compatible =3D "fsl,imx95-mu";
> > +                           reg =3D <0x445f0000 0x10000>;
> > +                           interrupts =3D <GIC_SPI 230
> IRQ_TYPE_LEVEL_HIGH>;
> > +                           clocks =3D <&scmi_clk IMX95_CLK_BUSAON>;
> > +                           #mbox-cells =3D <2>;
> > +                           status =3D "disabled";
> > +                   };
> > +
> > +                   mu6: mailbox@44630000 {
> > +                           compatible =3D "fsl,imx95-mu";
> > +                           reg =3D <0x44630000 0x10000>;
> > +                           interrupts =3D <GIC_SPI 206
> IRQ_TYPE_LEVEL_HIGH>;
> > +                           clocks =3D <&scmi_clk IMX95_CLK_BUSAON>;
> > +                           #mbox-cells =3D <2>;
> > +                           status =3D "disabled";
> > +                   };
> > +
> > +                   tpm1: pwm@44310000 {
> > +                           compatible =3D "fsl,imx7ulp-pwm";
> > +                           reg =3D <0x44310000 0x1000>;
> > +                           clocks =3D <&scmi_clk IMX95_CLK_BUSAON>;
> > +                           #pwm-cells =3D <3>;
> > +                           status =3D "disabled";
> > +                   };
> > +
> > +                   tpm2: pwm@44320000 {
> > +                           compatible =3D "fsl,imx7ulp-pwm";
> > +                           reg =3D <0x44320000 0x1000>;
> > +                           clocks =3D <&scmi_clk IMX95_CLK_TPM2>;
> > +                           #pwm-cells =3D <3>;
> > +                           status =3D "disabled";
> > +                   };
> > +
> > +                   lpi2c1: i2c@44340000 {
> > +                           compatible =3D "fsl,imx95-lpi2c", "fsl,imx7=
ulp-
> lpi2c";
> > +                           reg =3D <0x44340000 0x10000>;
> > +                           interrupts =3D <GIC_SPI 13
> IRQ_TYPE_LEVEL_HIGH>;
> > +                           clocks =3D <&scmi_clk IMX95_CLK_LPI2C1>,
> > +                                    <&scmi_clk IMX95_CLK_BUSAON>;
> > +                           clock-names =3D "per", "ipg";
> > +                           status =3D "disabled";
> > +                   };
> > +
> > +                   lpi2c2: i2c@44350000 {
> > +                           compatible =3D "fsl,imx95-lpi2c", "fsl,imx7=
ulp-
> lpi2c";
> > +                           reg =3D <0x44350000 0x10000>;
> > +                           interrupts =3D <GIC_SPI 14
> IRQ_TYPE_LEVEL_HIGH>;
> > +                           clocks =3D <&scmi_clk IMX95_CLK_LPI2C2>,
> > +                                    <&scmi_clk IMX95_CLK_BUSAON>;
> > +                           clock-names =3D "per", "ipg";
> > +                           status =3D "disabled";
> > +                   };
> > +
> > +                   lpspi1: spi@44360000 {
> > +                           #address-cells =3D <1>;
> > +                           #size-cells =3D <0>;
> > +                           compatible =3D "fsl,imx95-spi", "fsl,imx7ul=
p-
> spi";
> > +                           reg =3D <0x44360000 0x10000>;
> > +                           interrupts =3D <GIC_SPI 16
> IRQ_TYPE_LEVEL_HIGH>;
> > +                           clocks =3D <&scmi_clk IMX95_CLK_LPSPI1>,
> > +                                    <&scmi_clk IMX95_CLK_BUSAON>;
> > +                           clock-names =3D "per", "ipg";
> > +                           status =3D "disabled";
> > +                   };
> > +
> > +                   lpspi2: spi@44370000 {
> > +                           #address-cells =3D <1>;
> > +                           #size-cells =3D <0>;
> > +                           compatible =3D "fsl,imx95-spi", "fsl,imx7ul=
p-
> spi";
> > +                           reg =3D <0x44370000 0x10000>;
> > +                           interrupts =3D <GIC_SPI 17
> IRQ_TYPE_LEVEL_HIGH>;
> > +                           clocks =3D <&scmi_clk IMX95_CLK_LPSPI2>,
> > +                                    <&scmi_clk IMX95_CLK_BUSAON>;
> > +                           clock-names =3D "per", "ipg";
> > +                           status =3D "disabled";
> > +                   };
> > +
> > +                   lpuart1: serial@44380000 {
> > +                           compatible =3D "fsl,imx95-lpuart",
> "fsl,imx8ulp-lpuart",
> > +                                        "fsl,imx7ulp-lpuart";
> > +                           reg =3D <0x44380000 0x1000>;
> > +                           interrupts =3D <GIC_SPI 19
> IRQ_TYPE_LEVEL_HIGH>;
> > +                           clocks =3D <&scmi_clk IMX95_CLK_LPUART1>;
> > +                           clock-names =3D "ipg";
> > +                           status =3D "disabled";
> > +                   };
> > +
> > +                   lpuart2: serial@44390000 {
> > +                           compatible =3D "fsl,imx95-lpuart",
> "fsl,imx8ulp-lpuart",
> > +                                        "fsl,imx7ulp-lpuart";
> > +                           reg =3D <0x44390000 0x1000>;
> > +                           interrupts =3D <GIC_SPI 20
> IRQ_TYPE_LEVEL_HIGH>;
> > +                           clocks =3D <&scmi_clk IMX95_CLK_LPUART2>;
> > +                           clock-names =3D "ipg";
> > +                           status =3D "disabled";
> > +                   };
> > +
> > +                   adc1: adc@44530000 {
> > +                           compatible =3D "nxp,imx93-adc";
> > +                           reg =3D <0x44530000 0x10000>;
> > +                           interrupts =3D <GIC_SPI 199
> IRQ_TYPE_LEVEL_HIGH>,
> > +                                        <GIC_SPI 200
> IRQ_TYPE_LEVEL_HIGH>,
> > +                                        <GIC_SPI 201
> IRQ_TYPE_LEVEL_HIGH>;
> > +                           clocks =3D <&scmi_clk IMX95_CLK_ADC>;
> > +                           clock-names =3D "ipg";
> > +                           status =3D "disabled";
> > +                   };
>
> Please sort the nodes by address.

Sure.

>
> > +           };
> > +
> > +           aips4: bus@49000000 {
> > +                   compatible =3D "fsl,aips-bus", "simple-bus";
> > +                   reg =3D <0x0 0x49000000 0x0 0x800000>;
> > +                   ranges =3D <0x49000000 0x0 0x49000000 0x800000>;
> > +                   #address-cells =3D <1>;
> > +                   #size-cells =3D <1>;
> > +
> > +                   smmu: iommu@490d0000 {
> > +                           compatible =3D "arm,smmu-v3";
> > +                           reg =3D <0x490d0000 0x100000>;
> > +                           interrupts =3D <GIC_SPI 325
> IRQ_TYPE_EDGE_RISING>,
> > +                                        <GIC_SPI 328
> IRQ_TYPE_EDGE_RISING>,
> > +                                        <GIC_SPI 334
> IRQ_TYPE_EDGE_RISING>,
> > +                                        <GIC_SPI 326
> IRQ_TYPE_EDGE_RISING>;
> > +                           interrupt-names =3D "eventq", "gerror", "pr=
iq",
> "cmdq-sync";
> > +                           #iommu-cells =3D <1>;
> > +                           status =3D "disabled";
> > +                   };
> > +           };
> > +
> > +           gpio1: gpio@47400000 {
> > +                   compatible =3D "fsl,imx95-gpio", "fsl,imx8ulp-gpio"=
;
> > +                   reg =3D <0x0 0x47400000 0x0 0x1000>;
> > +                   gpio-controller;
> > +                   #gpio-cells =3D <2>;
> > +                   interrupts =3D <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
> > +                                <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> > +                   interrupt-controller;
> > +                   #interrupt-cells =3D <2>;
> > +                   clocks =3D <&scmi_clk IMX95_CLK_M33>,
> > +                            <&scmi_clk IMX95_CLK_M33>;
> > +                   clock-names =3D "gpio", "port";
> > +                   status =3D "disabled";
>
> I'm wondering of there should be a comment here that gpio1 usually is und=
er
> exclusive control of SM.

Ok, will add comment.
>
> > +           };
> > +
> > +           elemu0: mailbox@47520000 {
> > +                   compatible =3D "fsl,imx95-mu-ele";
> > +                   reg =3D <0x0 0x47520000 0x0 0x10000>;
> > +                   interrupts =3D <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
> > +                   #mbox-cells =3D <2>;
> > +                   status =3D "disabled";
> > +           };
> > +
> > +           elemu1: mailbox@47530000 {
> > +                   compatible =3D "fsl,imx95-mu-ele";
> > +                   reg =3D <0x0 0x47530000 0x0 0x10000>;
> > +                   interrupts =3D <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
> > +                   #mbox-cells =3D <2>;
> > +                   status =3D "disabled";
> > +           };
> > +
> > +           elemu2: mailbox@47540000 {
> > +                   compatible =3D "fsl,imx95-mu-ele";
> > +                   reg =3D <0x0 0x47540000 0x0 0x10000>;
> > +                   interrupts =3D <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
> > +                   #mbox-cells =3D <2>;
> > +                   status =3D "disabled";
> > +           };
> > +
> > +           elemu3: mailbox@47550000 {
> > +                   compatible =3D "fsl,imx95-mu-ele";
> > +                   reg =3D <0x0 0x47550000 0x0 0x10000>;
> > +                   interrupts =3D <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
> > +                   #mbox-cells =3D <2>;
> > +           };
> > +
> > +           elemu4: mailbox@47560000 {
> > +                   compatible =3D "fsl,imx95-mu-ele";
> > +                   reg =3D <0x0 0x47560000 0x0 0x10000>;
> > +                   interrupts =3D <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> > +                   #mbox-cells =3D <2>;
> > +                   status =3D "disabled";
> > +           };
> > +
> > +           elemu5: mailbox@47570000 {
> > +                   compatible =3D "fsl,imx95-mu-ele";
> > +                   reg =3D <0x0 0x47570000 0x0 0x10000>;
> > +                   interrupts =3D <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> > +                   #mbox-cells =3D <2>;
> > +                   status =3D "disabled";
> > +           };
> > +
> > +           v2x_mu: mailbox@47350000 {
> > +                   compatible =3D "fsl,imx95-mu-v2x";
> > +                   reg =3D <0x0 0x47350000 0x0 0x10000>;
> > +                   interrupts =3D <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>;
> > +                   #mbox-cells =3D <2>;
> > +           };
> > +
> > +           v2x_mu6: mailbox@47320000 {
> > +                   compatible =3D "fsl,imx95-mu-v2x";
> > +                   reg =3D <0x0 0x47320000 0x0 0x10000>;
> > +                   interrupts =3D <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH>;
> > +                   #mbox-cells =3D <2>;
> > +           };
>
> Please sort nodes by address.

Yeah. Fix in v4.

Thanks,
Peng.
>
> Best regards,
> Alexander
>
> > +   };
> > +};
> >
> >
>
>
> --
> TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
> Amtsgericht M=FCnchen, HRB 105018
> Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
> http://www.t/
> q-
> group.com%2F&data=3D05%7C02%7Cpeng.fan%40nxp.com%7C50f2e03eeb9d4
> b5ec44008dc6822023c%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C
> 0%7C638499742474895703%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
> wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%
> 7C%7C&sdata=3DQQTX4gXs3a%2FXizeqgzpaq3n0vmoQRUYkSufNKVu7LE8%3D
> &reserved=3D0
>


