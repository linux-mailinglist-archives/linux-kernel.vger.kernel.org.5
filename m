Return-Path: <linux-kernel+bounces-159839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7445A8B3504
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C32428914A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6764D143881;
	Fri, 26 Apr 2024 10:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="E8kpd8kH"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2083.outbound.protection.outlook.com [40.107.105.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9AD1428E0;
	Fri, 26 Apr 2024 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714126230; cv=fail; b=FybNv+GCDdbBoWNDVIp3wEaW217Tqu0eMus89KVjaXGezidQ4G40PGq5s9mWD+5k1MfLiBuAuk3djnu+RiBzE+P0D3cGu394Ird93xW55sH7B+KcxqfzXhBPb3+fPx3K5TjJ8uV7o+D8mU6DRO9FfWxiu4k4YzVJKX8givzBF2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714126230; c=relaxed/simple;
	bh=po0GayxekJ1HYpAJiRp9paB+b+FhwvYH4T5zA8vD2Rw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YfTiRUaLVYh56RdUNa/FTVSgf67f2PbPMy2Gtfo3iVB2j5zJGtTL9IajdcinbfXsCtMkCJjsn5Hwtvkfdwdfon65tARqKt/NyEh5lphNIK5A0HhewBx3kEyCubMWMNJ90ckMkttEj0Lp7DSTe6/wYS5r/C0hld1GaVXo9BI29Sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=E8kpd8kH; arc=fail smtp.client-ip=40.107.105.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTT73/dzeB3fd8oa4t3EjKrP1L/OE1ZL7MLv5f68pIOX5Dxn9jUdgdm7Rf4mfXzaFrhvoiKYKtApk4DVxQzvU0HuMS/WOgUquMpD71t6exLHsLGMikK5f6vdgVy0ThTisC0X81T6O4RUaP1/HLy079WGKPn/a3GxnHqFP74T3TH5p+eWLDJPwhggjcsqq59dkdMRhXHGgJOF59vSn9Eo928oqTmaGOWMYLTNnebsqMQVPpAGXMJr8zOA3f2/nLNtMSLW9Vpy0TAhzplHUQTPFiQWkuy9bNu9kLy7jJ/eM9RGEAAcKaDeP4hC3roTsNq5wT6puCYHYe4EfJIc9B5EzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hGxVUqVCxuWJU4UZhn0gBBzvtQgU7jxQochLDt7oSxw=;
 b=LvMpCgSHgq/3UwsoV3CJ8ixEoZX28F4zRAeL6KOeDobNEoEctpk8X+Zy3bJY7QF7sxDw3khXaB9/48CRw6dpaWJoxNeasS58SFuRANWRvRle3rh9QlvfW4djQMQEfw+5239qt/596GZGWNYn5ZRR3KSr+Rg0H59Mo9c1GoPN3CGmIHsVyjSYS+VUAFVNFpqQ+G0ebWzkhdgJKXl4aXuDj14zxCkc0dV9ChHXaovoFjgLRnrAx7mj64+sBEkSIjB4FamnWf42T5E+6PYR/qRtwwjAS2spiWCybmCHFStxtj5MkEYJIkUHTcA5/bInGycjRMDyGL5V0w4KG0zzBhjS9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGxVUqVCxuWJU4UZhn0gBBzvtQgU7jxQochLDt7oSxw=;
 b=E8kpd8kHkhRqibSzuz3Kk9kNZk3QqDr3gfaDgPxTeFJsXBG4fFc/11B3XJ4pY4GJuOOcbpMPU4U0e+vkEgt+NDovFM+AT0+8gPHyJpI9dXwu/8Aj1vOBkP+1ymRq6i2JSXJ1fYW6t6z0YV/WQ3Xb7h5/BMp5ysSwn1I7zp3Xha8=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8335.eurprd04.prod.outlook.com (2603:10a6:102:1c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Fri, 26 Apr
 2024 10:10:24 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7472.044; Fri, 26 Apr 2024
 10:10:24 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Linus Walleij
	<linus.walleij@linaro.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] dt-bindings: firmware: arm,scmi: Add properties
 for i.MX95 Pinctrl OEM extensions
Thread-Topic: [PATCH v2 1/2] dt-bindings: firmware: arm,scmi: Add properties
 for i.MX95 Pinctrl OEM extensions
Thread-Index: AQHakTp0F0gZzKwEJ0KLehvuXBXWtLF32SuAgADPKOCAAICOAIAAbbtwgADKY7A=
Date: Fri, 26 Apr 2024 10:10:24 +0000
Message-ID:
 <DU0PR04MB941797EF90762D901B46EB0E88162@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240418-pinctrl-scmi-oem-v1-v2-0-3a555a3c58c3@nxp.com>
 <20240418-pinctrl-scmi-oem-v1-v2-1-3a555a3c58c3@nxp.com>
 <20240424193007.GA329896-robh@kernel.org>
 <DU0PR04MB9417C67342B1DD6CC299B4CE88172@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20240425153140.GA2556348-robh@kernel.org>
 <DU0PR04MB9417CC2150FF2F038202433F88162@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To:
 <DU0PR04MB9417CC2150FF2F038202433F88162@DU0PR04MB9417.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PAXPR04MB8335:EE_
x-ms-office365-filtering-correlation-id: c2dbc641-a89d-47df-757b-08dc65d916fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|1800799015|7416005|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?fDOIyQ4LGDeqb9Xv7OWxtH/6dRuo5m3Ewme75k4ivd0vELxuLUBF8I1EpNQ6?=
 =?us-ascii?Q?upA27b1V5q4eyv1g06SXdRLQWFuoxv2XRsatU0MMWYkr99W04bqKrr8Rio8X?=
 =?us-ascii?Q?A0z9etYAYGCErSSiZa8oDTRSp/NM2ffkUYscGL5URvmD40hlqbbyoYFg0Pr5?=
 =?us-ascii?Q?r920kfIPvVyFaO5MdkqEkjRT0gk4mzIIAbdpfviBYxEZbEKUVswIZ830JuCn?=
 =?us-ascii?Q?gg60Ee+T8yYV85yyT6N80c853nTpC4wdwuSlk5VN3vQ/7uPO2fKgW3l/L+r3?=
 =?us-ascii?Q?BAPkRKlFdGOVEw9HybtfXnBQ8QeXBVLcDchM9RnepxdzW+gbBCnbA5x6Gb+D?=
 =?us-ascii?Q?7iPPvnctvZoH28F6J9gajX5/9qAO2QOg0yOiatU+Zkgd7cnE0PuZ4nV/MOrd?=
 =?us-ascii?Q?3Z8aOxC93Gbz+U1dXHrJEoHOALB/eOWEkAIwttCuOihR5PxJP++J+4zKkwe3?=
 =?us-ascii?Q?CqswBBNboEsdMScrWQuEx4jD8MatgzwxbQCcCBkqoFKTMD9QS6loU66TJX/m?=
 =?us-ascii?Q?109CpffKQn52s4Oep0ay0TgnzyMeBUZx+EgahJRP6Ciw9qbHyd45E9JLkknB?=
 =?us-ascii?Q?4zOxAgiQEdZeZFW/0Ax2TOfYAxCvt90w1Gzsn0owm3HPxiLzrDXYTCpcksR0?=
 =?us-ascii?Q?32XRyUjbqstpMOkL4mNyKaAk9mv90wO39AiplDB501viGhoU5JU1GpHsx39M?=
 =?us-ascii?Q?9skoV5TP1FWk7G9IAhugEq77ama81ByJRVoAMuJb0vgcBBme2gyCeWsmr4zv?=
 =?us-ascii?Q?pRgafCiMuLxqkc3jkneTASbNm24ePqXDfj85A6l8GYv9h5PC23X89geysTto?=
 =?us-ascii?Q?7hgYZweNvN+AQx71JeAG6G2/hxDZENLyRI12EfpkFBtAcUINI/pdV3D27QyW?=
 =?us-ascii?Q?+JEtfOl8WACZENeBW7hChMfQ43TRt5cAjqgdqegG3Tzg5RmvdMFlNE2OCLCP?=
 =?us-ascii?Q?A80fb1g9koWj+w/hH1k0xNr4zIDFkASeFkJL13GKk5XDjBqTdTRnYeX/AAKs?=
 =?us-ascii?Q?EtKXZRKS2PmY6KRm42+Cu7a/mPEpRGNv5pOmU+eKWJPt/y6XiEJILpDo9JtF?=
 =?us-ascii?Q?aKJWXYwZ1+u5ZIK3P5nhEGP+cBQUfuo7p/NuRVoPz62Iv0j83uMQIeOQ5uKR?=
 =?us-ascii?Q?R6ZYT9DxlmtsTiANk6lDyMdX9643i864NYI6cIupas9nN3NX3sgHoJB4yrDs?=
 =?us-ascii?Q?k1H5aCV+dZHDzpZyryVX6krbVYnWffNuNlPEXinG3By/qya4dlwFYLgVNi0a?=
 =?us-ascii?Q?4Iru0Suchj6OdQHq0w/+jF0/KXaIVp8FBVWK9AG29ZQm6UGVAl5f9jhuLgi+?=
 =?us-ascii?Q?d9FmPmufyNxRFvgEzdV0eaIM6XoqVsVy2gW2Kf+bUTjTyw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IkRDf23h/M3zeLyM7i74O2w6fv2dpUswGzpIvyjGuJdH9zIffVTOvYys0+qq?=
 =?us-ascii?Q?IWqsDAjxcwNxv4AntyovskfAMnlLxbAYOOuhqtYtbAEBNoxatk1StSrTguwO?=
 =?us-ascii?Q?Tc7GdbHy/pSrZPSdDqzL+KbWBv1ObG457Gg3cz5by3280xsuq0M5VqPQMUyP?=
 =?us-ascii?Q?dLjz5zi9d9UKZ3Cu0etIvCzaoQr6DfgG8eb4/OGKVhHhI071ZH9mHZdM86Td?=
 =?us-ascii?Q?5Ad0/QDUzNn9A6rVWkqrCnXyEaUKCPM+QxJOT7++sCD3R+zrNolcTX7JW3YD?=
 =?us-ascii?Q?rfWoIdmqcO33CrtopLeoE1LVEbDVJSLBhqRRjxnOJZj9bhTLbHq0ICIbFG6B?=
 =?us-ascii?Q?c8ZpvPVZxyAeAFaqOMMXPfjCud9gdqlRZ3arlgctcw+cmyYW0S/2ONKb7gjN?=
 =?us-ascii?Q?3cYB5nMHBlmpIUNhQCPKWWACoVP3xXhRhY4QkTec2nntE8Zq1FVrStrAlOsJ?=
 =?us-ascii?Q?dE3qbS4aeC7igY6Gex8kPkl1syNEcBFF3Ecm6vTe9BrjNXkcdXzHPfc5M5xC?=
 =?us-ascii?Q?P5QsWj1yH99SQYqpkTXTjaNq0L4FxttkD6XYTazVJ62+PXXwrGM28Xc4LZd+?=
 =?us-ascii?Q?vGhLREyR5KpZP2ksTyKpTOvc8Du2j/y9seP2P5Ymj3n9u+9/Vra3epQZz2Et?=
 =?us-ascii?Q?8j3Pnv0BMo1r+njByT0YY7ZiNiYVxlYYK0FU4p/Uv2WVZUiq0PaYOB/pLTkm?=
 =?us-ascii?Q?er0OmQhCIAIPbJtRuTslfD0+tdV06bimXlLqbbx3QCam5V3skGeVyQjAu5vq?=
 =?us-ascii?Q?+nKVlrFq4ZCzKUr9LlhG4J+X5XEcOz3O4VsG+PTYWDj1+LiZMqBnq+Y/lbYs?=
 =?us-ascii?Q?yWicaOqBKMI6VQon6TykQAPQdEwZI40DLfcVmox07BV5uiW2GXvMSUYqCEcm?=
 =?us-ascii?Q?FqbD+GsOaQvyRMZ1DnH2lHH4XJiWKQ0oILKannQh/WRuZSN+GwB/mPseMt0U?=
 =?us-ascii?Q?522u4mHGxnUUocifBpzQqTDLRUM9VY+v2w9TD1nvO2xxiQC1PJCGzzB5J7KC?=
 =?us-ascii?Q?j5IIKhhqmt2XK+WBhfhZBrZY3vb/3I6vhSyD7xEKvFsf9zDhv+mopWEE9hZ4?=
 =?us-ascii?Q?eC5Os6iRt88h+LUddu+O5h/eoA6mLRUFHciYkhRCWWun/y29t/IXElzOMqm7?=
 =?us-ascii?Q?L7d31YzIt5hp2HSaHX+PGioVgFQoMoUd1U73SbvGmTk2R0rSNvTtGaZblted?=
 =?us-ascii?Q?PnWIpZwRdXP77zw5drC/e+pFfxm6r/yDpU0drsWaPp0F3CtH6ZM2MhdGsETp?=
 =?us-ascii?Q?+zcIKyCyN0/aF7PjuNnazTyX1R4hl7HiiMhaCHVGqkstltTQ5hJwrtOKP6FM?=
 =?us-ascii?Q?WX/B0ArbseDrIZbmglDAktK7APFEXN78jFfytlFFJ5jHrmc21cIpDIXeUeqH?=
 =?us-ascii?Q?5xxcG4HcCHtBkBcbbIGuDoGVsKDrnSdeD+lZiuIvuLZkaRQcHD6iiwC/ru2E?=
 =?us-ascii?Q?UX8+/GTt9/D6M/8AjutSXM9RIIqLEOIW5eGLeUbodhjmQZ1ylxdrZpwSuYyZ?=
 =?us-ascii?Q?tQSnWQDj4WnpNqGtqtWh2qP3iHkvgj7Jc/D09zK6+ImXXkc/hM7vv0ZHAFTI?=
 =?us-ascii?Q?GLYTPDO2C3E5HJBTIAA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c2dbc641-a89d-47df-757b-08dc65d916fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2024 10:10:24.7516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SnPfdfDwR/p8S+SSXQckKNLB+6zPu7SHyNmNgBs31tnzIHnmwWmzTDqEi2pAEKtNWxBxtA0zIyg5TMYk5XxLWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8335

> Subject: RE: [PATCH v2 1/2] dt-bindings: firmware: arm,scmi: Add properti=
es
> for i.MX95 Pinctrl OEM extensions
>=20
> Hi Rob, Sudeep, Cristian, Linus

Is it ok to use fsl,pins for i.MX95 SCMI pins, just like previous i.MX proc=
essors?
In this way, I need write a new driver, could not reuse pinctrl-scmi.c for =
i.MX95.
+        properties:
+          fsl,pins:
+            description:
+              each entry consists of 6 integers and represents the mux and=
 config
+              setting for one pin. The first 5 integers <mux_reg conf_reg =
input_reg
+              mux_val input_val> are specified using a PIN_FUNC_ID macro, =
which can
+              be found in <arch/arm64/boot/dts/freescale/imx95-pinfunc.h>.=
 The last
+              integer CONFIG is the pad setting value like pull-up on this=
 pin. Please
+              refer to i.MX95 Plus Reference Manual for detailed CONFIG se=
ttings.
+            $ref: /schemas/types.yaml#/definitions/uint32-matrix
+            items:
+              items:
+                - description: |
+                    "mux_reg" indicates the offset of mux register.
+                - description: |
+                    "conf_reg" indicates the offset of pad configuration r=
egister.
+                - description: |
+                    "input_reg" indicates the offset of select input regis=
ter.
+                - description: |
+                    "mux_val" indicates the mux value to be applied.
+                - description: |
+                    "input_val" indicates the select input value to be app=
lied.
+                - description: |
+                    "pad_setting" indicates the pad configuration value to=
 be applied.


Thanks,
Peng.
>=20
> Although this is dt-binding stuff, I hope you could also help suggest how=
 to
> support NXP SCMI OEM extensions. There is less chance NXP will change
> SCMI firmware to make linux happy using generic conf stuff, because the
> SCMI firmware will also need to work for FreeRTOS/GHS/QNX and etc.
>=20
> > Subject: Re: [PATCH v2 1/2] dt-bindings: firmware: arm,scmi: Add
> > properties for i.MX95 Pinctrl OEM extensions
> >
> > On Thu, Apr 25, 2024 at 09:06:00AM +0000, Peng Fan wrote:
> > > Hi Rob,
> > >
> > > > Subject: Re: [PATCH v2 1/2] dt-bindings: firmware: arm,scmi: Add
> > > > properties for i.MX95 Pinctrl OEM extensions
> > > >
> > > > On Thu, Apr 18, 2024 at 10:53:17AM +0800, Peng Fan (OSS) wrote:
> > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > >
> > > > > i.MX95 Pinctrl is managed by SCMI firmware using OEM extensions.
> > > > > This patch is to add i.MX95 Pinctrl OEM extensions properties.
> > > > >
> > > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > > ---
> > > > >  .../devicetree/bindings/firmware/arm,scmi.yaml     |  9 ++-
> > > > >  .../bindings/firmware/nxp,imx95-scmi-pinctrl.yaml  | 66
> > > > > ++++++++++++++++++++++
> > > > >  2 files changed, 72 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git
> > > > > a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > > > b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > >
> > > ....
> > >
> > > > > +
> > > > > +title: i.MX System Control and Management Interface (SCMI)
> > > > > +Pinctrl Protocol
> > > > > +
> > > > > +maintainers:
> > > > > +  - Peng Fan <peng.fan@arm.com>
> > > > > +
> > > > > +patternProperties:
> > > > > +  '[a-f0-9]+$':
> > > > > +    type: object
> > > > > +    unevaluatedProperties: false
> > > > > +
> > > > > +    properties:
> > > > > +      pins:
> > > > > +        $ref: /schemas/types.yaml#/definitions/string
> > > > > +        description: name of the pin
> > > > > +        items:
> > > > > +          enum: [ daptdi, daptmsswdio, daptclkswclk, daptdotrace=
swo,
> > > > > +                  gpioio00, gpioio01, gpioio02, gpioio03,
> > > > > + gpioio04,
> > > >
> > > > ioio?
> > >
> > > Yes. The name is exported from SCMI firmware.
> > >
> > > >
> > > > > +                  gpioio05, gpioio06, gpioio07, gpioio08, gpioio=
09,
> > > > > +                  gpioio10, gpioio11, gpioio12, gpioio13, gpioio=
14,
> > > > > +                  gpioio15, gpioio16, gpioio17, gpioio18, gpioio=
19,
> > > > > +                  gpioio20, gpioio21, gpioio22, gpioio23, gpioio=
24,
> > > > > +                  gpioio25, gpioio26, gpioio27, gpioio28, gpioio=
29,
> > > > > +                  gpioio30, gpioio31, gpioio32, gpioio33, gpioio=
34,
> > > > > +                  gpioio35, gpioio36, gpioio37, ccmclko1, ccmclk=
o2,
> > > > > +                  ccmclko3, ccmclko4, enet1mdc, enet1mdio, enet1=
td3,
> > > > > +                  enet1td2, enet1td1, enet1td0, enet1txctl, enet=
1txc,
> > > > > +                  enet1rxctl, enet1rxc, enet1rd0, enet1rd1, enet=
1rd2,
> > > > > +                  enet1rd3, enet2mdc, enet2mdio, enet2td3, enet2=
td2,
> > > > > +                  enet2td1, enet2td0, enet2txctl, enet2txc, enet=
2rxctl,
> > > > > +                  enet2rxc, enet2rd0, enet2rd1, enet2rd2, enet2r=
d3,
> > > > > +                  sd1clk, sd1cmd, sd1data0, sd1data1, sd1data2, =
sd1data3,
> > > > > +                  sd1data4, sd1data5, sd1data6, sd1data7, sd1str=
obe,
> > > > > +                  sd2vselect, sd3clk, sd3cmd, sd3data0, sd3data1=
,
> > > > > +                  sd3data2, sd3data3, xspi1data0, xspi1data1, xs=
pi1data2,
> > > > > +                  xspi1data3, xspi1data4, xspi1data5, xspi1data6=
,
> > > > > +                  xspi1data7, xspi1dqs, xspi1sclk, xspi1ss0b, xs=
pi1ss1b,
> > > > > +                  sd2cdb, sd2clk, sd2cmd, sd2data0, sd2data1, sd=
2data2,
> > > > > +                  sd2data3, sd2resetb, i2c1scl, i2c1sda, i2c2scl=
, i2c2sda,
> > > > > +                  uart1rxd, uart1txd, uart2rxd, uart2txd, pdmclk=
,
> > > > > +                  pdmbitstream0, pdmbitstream1, sai1txfs, sai1tx=
c,
> > > > > +                  sai1txd0, sai1rxd0, wdogany, fccuerr0 ]
> > > > > +
> > > > > +      nxp,func-id:
> > > > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > > > +        description: Indicates the PAD connections which
> > > > > + function module
> > > >
> > > > The description makes no sense...
> > >
> > > I will use below description in v3:
> > > For each pin, there are up to 8 muxing options (called ALT modes).
> > > For
> > example:
> > > Select 1 of 5 iomux modes to be used for pad: DAP_TCLK_SWCLK.
> > > 000b - Select mux mode: ALT0 mux port: JTAG_MUX_TCK of instance:
> > > jtag_mux 010b - Select mux mode: ALT2 mux port: CAN4_RX of instance:
> > > imx95_wakeupmix_top 100b - Select mux mode: ALT4 mux port:
> > > FLEXIO1_FLEXIO30 of instance: imx95_wakeupmix_top 101b - Select mux
> > > mode: ALT5 mux port: GPIO3_IO30 of instance: imx95_wakeupmix_top
> > 110b
> > > - Select mux mode: ALT6 mux port: LPUART5_CTS_B of instance:
> > imx95_wakeupmix_top The nxp,func-id property is selecting one ALT mode.
> >
> > Looks like constraints on the values. Please add schema for them. I
> > don't think you need to list an example.
>=20
> Will add maxItems: 8, minItems: 1
> >
> > Perhaps you should be using 'pinmux' property. That is the standard
> > way to specify a numeric mux mode.
>=20
> Ok let me try.
>=20
> >
> >
> > > >
> > > > > +
> > > > > +      nxp,pin-conf:
> > > > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > > > +        description: The PAD configuration
> > > >
> > > > PAD stands for? Or is it pin configuration as the property name say=
s?
> > >
> > > It is pin configuration which includes pull up/down, drive strength a=
nd etc.
> > >
> > > >
> > > > This is just a raw register values?
> > >
> > > Yes.
> > >
> > > Why can't standard pinctrl properties be
> > > > used here. What's the point of using SCMI pinctrl if you are just
> > > > shuttling register values to SCMI?
> > >
> > > Standard pinctrl properties will need more memory in our SCMI
> > > firmware design. We have limited on-chip memory for SCMI firmware
> usage.
> >
> > Then maybe you shouldn't be using SCMI and just write a pinctrl driver.
>=20
> I think I have to. pinctrl-scmi-imx.c was not preferred by ARM SCMI
> maintainer.
>=20
> If Linus, Cristian, Sudeep are ok, I could add back pinctrl-scmi-imx.c fo=
r some
> OEM mapping/unmapping stuff.
>=20
> > Or, Linux has to parse the DT anyways, so use standard properties and
> > transform them into your register values and send that to SCMI.
>=20
> Cristian, Sudeep, Linus,
>=20
> Is this ok for you? Before sending to SCMI, linux driver transform the bi=
ts into
> register value, and send to SCMI firmware.
>=20
> >
> > > > > +
> > > > > +      nxp,daisy-id:
> > > > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > > > +        description: The select input register ID
> > > > > +
> > > > > +      nxp,daisy-conf:
> > > > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > > > +        description: The select input register value
> > > >
> > > > I remember some daisy chaining stuff in iomuxc, but otherwise
> > > >
> > > > What's the relationship between these 2 properties? Is it valid if
> > > > only
> > > > 1 is present? I doubt it.
> > >
> > > The scmi firmware will convert the daisy-id into register address,
> > > and write the daisy-conf value into the register.
> > >
> > >  Looks like an address and value pair. Either the
> > > > schema needs to define allowed combinations
> > >
> > > The firmware will check whether id and conf is valid, is there a
> > > need to
> > define
> > > allowed combinations? There will be lots of check to define allowed
> > > combinations.
> >
> > The firmware can't check that the DT contains nxp,daisy-id but not
> > nxp,daisy-conf or vice-versa. Of course the kernel could check that,
> > but validating the DT is not the kernel's job.
> >
> >
> > >  or design the properties in a
> > > > way you don't have too. IOW, make a single property that's a tuple
> > > > of
> > register
> > > > ID and value.
> > >
> > > Define tuple will make the property not able to use linux generic
> > > pinconf driver. The current parse_dt_cfg for custom_dt_params only
> > > support a single u32 value and not easy to support tuple.
> >
> > Sounds like a Linux problem. We're talking about bindings. Fix Linux
> > if it doesn't meet your needs.
> >
> >
> > How many bits of id and conf do you need? This too could just be part
> > of 'pinmux' property. It's value is entirely h/w specific and up to you=
.
> > You just need to fit it into 32-bits (though we could perhaps enlarge
> > it).
>=20
> For conf, 4 bits is find. For id, 12 bits is fine I think.
>=20
> Using pinmux property with some vendor handing code. Not sure ARM SCMI
> maintainer is happy or not.
>=20
> Thanks,
> Peng.
>=20
> >
> > Rob


