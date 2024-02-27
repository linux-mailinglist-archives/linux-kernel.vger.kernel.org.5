Return-Path: <linux-kernel+bounces-82479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB044868520
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9005E282B29
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623591859;
	Tue, 27 Feb 2024 00:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bm6VWl2c"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2042.outbound.protection.outlook.com [40.107.15.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8949415D0;
	Tue, 27 Feb 2024 00:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708994706; cv=fail; b=aF+CRSnY2nlt7Ewm9KLrBe82sbrVmzEiOu0CaA47i9S2BckNiyAER2obX7+WMdpXoAa4eRwHat8P/8Z3RCcgEwXGz/QXcrBSiNIOUF6mSJeTKLs2mX3E6HcIgUI8eQxpyG9WnH58jAYe5oPIVUG7XJqwebLkdducs9AXuGWwXVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708994706; c=relaxed/simple;
	bh=fW4b1bf+zJx9U90icQQ/xeXFLXlnVrf0VCYMQcWyypE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XbOzwcCxDkkW4/RbOKwIRtnkxk09aqqxbpD/Q8aPGPIxnvZEsIBXqJrH2RTtBbFl5uQxbUuoDp0jNgdFwDC4hIDOIDytwkOXcVHyOH3ODdCclG2rMmoiRzi38kXqDjmL7bTrvOhDz2R0A0vbHfKQbwP2Z4d9gfGgr81Glx9ZJxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=bm6VWl2c; arc=fail smtp.client-ip=40.107.15.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nt8jPQMc6GagJPeoVj51f+pzpj/+jWPImmpyIO/6RxQNeG9Q/gGQUEyQddstjtj8re8Hl32DiHAi3YtzSwIsXDmrBGWzq03BNiDnAFEVbrO5x6KhmfbaIYvD02fIAKeM25K9M4MrG5YML9NETj4Nj9gYqhBNl/B+pk+EnUYMzdqoqlx+c0tdJ2dY1JIn8e+qyH/KV4w+J8opfqs5rj6+nzRnfYoaSJINY+W2rv/WCFnSgL7im2Melr5yVRkpw1sMwVedY0goNFLPOxax8qc1RrspNHzqPy7yMeYz77Gf9SRPfgJAnCGgLYkH+wkp2951TaGQN237vWKlD+R6s5Ddhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S58BsEEMsR7gV+yAsW4QvkObg9X5qUs8n2SyTx3fhp0=;
 b=X+MtL4wuPwSNnvQgebpL11S7al7doV8/Mh2eRCMMJobjEJMzLUnH3ryVCnqvTj6BRViN7Khf1jfJyNetLGNi3h7zvKXU8lspx5b7P5PmG+O0pVg+vvEGhQmkUsFgizYtPwonRosJW1Ja6yV1uQ9/5iOBWoTFBPJMmdONyvNarSzeadrS6KUoy9ySu27q5xhDiRFv/ACZwi6cHL6DxmEaGagzvYffy0bzBh6HhbEjH6uwTx01JR+8zYwKJgJWoUlbsKTPq/CoamYTChSwDmWkRpO+/oYwdcaz9MB54l9y2kGOLYa0gM3amrdtaUAcpBc3T3umzyX7uk3oq5OAdZBXjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S58BsEEMsR7gV+yAsW4QvkObg9X5qUs8n2SyTx3fhp0=;
 b=bm6VWl2ciK1uxjINOd73QFb2vxB4EvYz+lqEp9DY49FeqfNy3LXYZfuY5vdo1C7pPGv4F980bGiPE36VPjKQgf8l08ympvPw+5zhFWKnRT1ZO2/1Ezt0s6ItY4niPhv01Cn2as/vSKHmzGy6ygDE6VgqyAS2T+5cNTcqHPaoUBw=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Tue, 27 Feb
 2024 00:45:01 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd%4]) with mapi id 15.20.7316.034; Tue, 27 Feb 2024
 00:45:00 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Conor Dooley <conor@kernel.org>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2 1/3] dt-bindings: arm: fsl: add i.MX95 19x19 EVK board
Thread-Topic: [PATCH v2 1/3] dt-bindings: arm: fsl: add i.MX95 19x19 EVK board
Thread-Index: AQHaaLVlJNiUTWM6k0We1s83lBIh07EcziIAgACMdqA=
Date: Tue, 27 Feb 2024 00:45:00 +0000
Message-ID:
 <DU0PR04MB9417A3C2D711A9137B6E3B9588592@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240226-imx95-dts-v2-0-00e36637b07e@nxp.com>
 <20240226-imx95-dts-v2-1-00e36637b07e@nxp.com>
 <20240226-sharpness-material-54a8e719ce91@spud>
In-Reply-To: <20240226-sharpness-material-54a8e719ce91@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PAXPR04MB9644:EE_
x-ms-office365-filtering-correlation-id: 9d5a081b-8534-4229-eeb2-08dc372d5440
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 eG8MwEc0HvWAZzXJHgUvzT4WM5H8mGYfuaRymeTlWkvntSZoA3puV004FxzN25TucqE+50Ts91aL7bgyO5VlqDUZRlU4R4X/M7Hx3Lt4eJgTaJbNJU7OYZ99Rn0HXFMsI5MvYSlcacn4PUrXK1XyseYbSQ+0MOpq7eqRYysaabqu+uMCuBawRGbOTFOSN9lR2G+5k2xmaCf1pmqk1ZhPgP7DDy4bgieGgOYpR559psQnI5KqkZNpkqUWKdGZmpKG4Xp3XJUz4uhJcSUxS/DdnSbOwDAwgyEWeF4I3QA7b1H1eUweJ9rlK1/CEM+phWHPhf+TfaUdUpKMp1iuFOKDwWmE5p07LleF+uY3yt6/LbGW6cisaUGZA3NLPvAJXqEC2Zt5UwiE49jvS0IXMfEtN3O8e8WQOGynZVgFFfl3Tsk8Xr0JqfZYQL4on6Q/jNhmJonkUol7Da1wxj+Gc/AkPmaa/LI90tIT2XlRS1XW2cXBqxPZsh+0fRZcCZlP55JhxWpTbqLuQ2EoudkV6cSzV0imHQ0quJhwLKGBqXgXuoJ10RapLlVg7AQihh8ct1rz6jcp0efp5ED5L1i2aXXQLDGbzwOXfcWmtNAY3OYvWSgg5d4mlQBqC95HX7g0rJ2CxkH6ssD8olgS6ll2G8mn85NoOOpCWXoZh0L2gTLCwpomcz2lo/Kq3n0JUG4oGhlpYrIqNpnoPPUZ8P9wuocSHQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lEDQ3SM1qRR9oH9YTIpv0Ak0Dvr0J25sUx0sbKEZIvxhx/YHgRJRXA4LF6vN?=
 =?us-ascii?Q?RPO8rIxazrCFGocQsa77FDUCiPRoFo0cd7nuDp1e3a1NzfMi7E7m7A2a7NKW?=
 =?us-ascii?Q?bWIC7srdUqDfToEqlSU7dtn+AFbsKAoDPLSitU5pHmXAE4hwzCenPTe9NPbS?=
 =?us-ascii?Q?WjgLgILI13Q2J4b9a0tJRXIV0ipjO70MaIPPjgQK0n4NEhFEq5U7wG8AiZJI?=
 =?us-ascii?Q?2MtoMZ4GRjKmxOID5pTe3Xm3aDJGtWKLCURYD483ffIQwrbX8zbhCYQ2xxGQ?=
 =?us-ascii?Q?Zf2SdEoS4qpDLOiodfyCGKVg08zuVYTuV+TTDdjZBtBYHpLVukagkjfmDpRd?=
 =?us-ascii?Q?xnpnpz0cXsisy9M3j5mk8fj91eQQtshyFU95lhIOSBiDhObTz/q372MMVNyr?=
 =?us-ascii?Q?V8+pCOW9Yb+gOFp7jGyfRxHNiWn+xhQSB5WV7A1AUGzIXlT/QWmUwOKlZxpi?=
 =?us-ascii?Q?D5Ya8aPAA8udBJWy74YmnAha88x3QJggYt8Tfd9luOHRzUt04hgfdqbZgLQX?=
 =?us-ascii?Q?udHiuNB+Psm2AGtCb2NYY3Gjg0TBxNO6qUCVfTUfM8U9V+dL0WNL7eHxPaue?=
 =?us-ascii?Q?s9BP/VAFv3BulWOLv24KCjMPUDSoq1MU9s+2p58AW9HYYq+yE8OGdg6cpZEw?=
 =?us-ascii?Q?h2vQpmKmG4eWGMQLNCTF+4c5Tq8sQuB6gtTYKMxMRqsOtoq5Nx57caVPw3NV?=
 =?us-ascii?Q?qtRN/FGV7Jk6/GQEejN6Zt0Z/LgVfU2Yi1q2MAk4j3bz4psuRxXxT1wI/qsz?=
 =?us-ascii?Q?TqzEQCylKvJ7B/bOsJ5QTZiQNPRRh+kvx3Rms/Rahei5acnnQS9QfrFe655S?=
 =?us-ascii?Q?M/tDjcAqCMd0L1vsM7Kan6l4RTACAuKh+lvnw1dDEQ0uRJHHGQhKfAnc6meU?=
 =?us-ascii?Q?Gn2UoSVNJHjD6cJ+dGpkpLDMBO5x9+uyNKVWFrRojyumL0isBnlnrRRARLJP?=
 =?us-ascii?Q?CyAlH/Ay7q2oAuuxb3fKYxkFb5HdruhFAfEaU1MGLGv6AtmvnfiETgpdsnzA?=
 =?us-ascii?Q?u3g+9U5FWCcgWXk4znJso1+VDpgaQnlf3faR27nx1NKcF942sz+syJ3jiK23?=
 =?us-ascii?Q?fGUJpj9inJ2fFTA+wTU84ALtPb5pTOlnlpPDALyGnlDpXc7lu/CyasUsE5g5?=
 =?us-ascii?Q?fxUWBRtqEeuBZXX/a5O79I0GeqVQi59f9E2r/YjM27A/uqMYAFhGg0Qh6DNL?=
 =?us-ascii?Q?bJ+np//+1PQJ1eW3+qk710aE/8QXeDyy1BxddhmrewXHc2eYDFzre+v/jquT?=
 =?us-ascii?Q?1I3kjw83gX3f8VhOGGBvTLhI8NX99sC4cG1S7meTEWok0DwRtwE59aYfUmAn?=
 =?us-ascii?Q?m+00EkW2cPHOhRl4SHtKFtN5gl16AfaH9IhdQ4DaihVNDB4AQGWxSeRWUtlF?=
 =?us-ascii?Q?oC5zihSkLTum6aXCv0lADNifFJfjp/jrH8YDdSpANosqPAJnIqUk4Wt7UZ4O?=
 =?us-ascii?Q?GBsy2i7De7sMRkKIfIErev8zYLRgbS8XbZDv4drMeXLHSFU4JXa8UbUq3jOW?=
 =?us-ascii?Q?UbTereJ1DdFU+TBVdMiHR3ttZn0CcEfENFD+XT+34LY0j8jZWRkOkLpStFke?=
 =?us-ascii?Q?cMkU8BiGTEZusPpfkao=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d5a081b-8534-4229-eeb2-08dc372d5440
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2024 00:45:00.6076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pGZmjQBOWrUoTc2u4zyubEB41ohXEJPRro87LoEbuP7J5INlv+ZktptlE/Ku0n+zE5/AmSwPyuqOnMxH4f5NVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9644

Hi Conor

> Subject: Re: [PATCH v2 1/3] dt-bindings: arm: fsl: add i.MX95 19x19 EVK
> board
>=20
> On Mon, Feb 26, 2024 at 09:20:16PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Add DT compatible string for NXP i.MX95 19x19 EVK board.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
>=20
> Acked-by: Conor Dooley <conor.dooley@microchip.com> A passing comment,
> it feels like it'd be good to add a Link: pointing to the docs for this b=
oard. This
> is true generally, but doubly so when googling the name above doesn't giv=
e
> me anything other than LKML.

NXP website not show this board as of now. The silicon is still in preprodu=
ction
stage, so less information on web. For reference on i.MX95:

https://www.nxp.com/products/processors-and-microcontrollers/arm-processors=
/
i-mx-applications-processors/i-mx-9-processors/i-mx-95-applications-process=
or-
family-high-performance-safety-enabled-platform-with-eiq-neutron-npu:iMX95

Regards,
Peng.

>=20
> Cheers,
> Conor.
>=20
> > ---
> >  Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml
> > b/Documentation/devicetree/bindings/arm/fsl.yaml
> > index 39378879777b..42c6e8467dc5 100644
> > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > @@ -1264,6 +1264,12 @@ properties:
> >                - fsl,imx93-11x11-evk       # i.MX93 11x11 EVK Board
> >            - const: fsl,imx93
> >
> > +      - description: i.MX95 based Boards
> > +        items:
> > +          - enum:
> > +              - fsl,imx95-19x19-evk       # i.MX95 19x19 EVK Board
> > +          - const: fsl,imx95
> > +
> >        - description: i.MXRT1050 based Boards
> >          items:
> >            - enum:
> >
> > --
> > 2.37.1
> >

