Return-Path: <linux-kernel+bounces-157096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8898B0CC4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C13AB28461
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690B715ECE1;
	Wed, 24 Apr 2024 14:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="K89jbApV"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2042.outbound.protection.outlook.com [40.107.7.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74DC15E5CB;
	Wed, 24 Apr 2024 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713969577; cv=fail; b=iBAZ6CzH9g9BLfWTTE3hFwZ27uB5pK/Pf+IdTSaTpL+l1uYXvsLv4TYv/91wU5W9bGZHxjABunkiVnBp+a+n8VOEeuTWdKBr9saUTjHc/5YIpuBxTLi3mA/rdPRtfOKWKvtM0n99szXurg2VaSXxA50h2e82sXr2SYbHWZCYxN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713969577; c=relaxed/simple;
	bh=IXe0o7aHjDhP7b57jGh12HIHVJwtNk7Cd3/aLn/Hd/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HEaf+D2amwPk5qDNCsEXFpFQriQWXoLcPJq4vgYQD1sYpkFEOBVYgHDQPMPmh5SRFjJl5awxh5fU8/wwnoIa6hDIfTV9GuTFok3a7dLpSNs4uT+EI3NqJiinAkNzvFkCVOm3vDlOywOcFyViC4FkoX/XXFspkp0okdCgugwiCYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=K89jbApV; arc=fail smtp.client-ip=40.107.7.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QE69dY0jFvutYIgCnzOAztqhaDK6gwNed5iehetrLISQT3nizCjbV/jMcOM9GJeom815+MY55VZoFd36hlg0h5Rdu0v/VwtwtFo+uDd3/Ic66pzICp+27OR3GBckzxtmEFXKe3vPPtyGd6x7ueSPoJ6RlvsSj4pcjR/G7HTc8J2BH9J3WuvELL7OpUB0U2s2Dx+gplfRsveB4mamMgg+3XlR79PbNtlLFhwbeWZM5haikB3iY4dpb9G+HRoFU817qwyXvlo0sMK6xOIPkaL9Y6wPLHUEoSiiBu+jKE6NmnOWKWxFZZS1di1B9RRdHMTj0WC31kvZ8+FnE0oGIy3iiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXU511AQf5kMI1PsSDJkHhJ14JiSmVUY/R2f3smwCOo=;
 b=Pzk7yE8/nyTTq31lG0xRU2CGFxe4JoGi95WEYY/l8dJZhzY4ge02MQBrxnzsxvTO+MLePNLDU7C666LDE6Nl1KhKEEUsIawmXKQHxZNIg/ctHqqEqkBLvPQN32n5ltv+f2Df1shp8JKbN7YpTIKqwO0oClNKdGQyr16K34pN+bdO9PkF5MpffTWoMVpzf7uXhRzylAIsygUadg2apKVANgWfLzwImK6Ag8xELROlu7r/zH0ricSZQ7EIDg1fgyQ2HiLiEPKi0pT2awxviQbUvkhI6Lgm2e10Pq4TyPxgUWXPVmMb9gjN6KRPo0jPY5CKcHUFGtgw33UC1eVbSZXiYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXU511AQf5kMI1PsSDJkHhJ14JiSmVUY/R2f3smwCOo=;
 b=K89jbApV4FccVWOUDQogYkdsdB/D4GqsDKrcyyvSeYyevI0vnSRPNFDYSMGR8yN8YmXi824mR375WJXe8jxNbCd1jEUVAp6I91ssgOpZM08NJHtP4tj+RGx7/gdvUCHiMvQ6e1tr0hucGosgQjiXzdTJzjTJqvTM/bcYJodz4tw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9453.eurprd04.prod.outlook.com (2603:10a6:20b:4da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23; Wed, 24 Apr
 2024 14:39:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 14:39:31 +0000
Date: Wed, 24 Apr 2024 10:39:22 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, vkoul@kernel.org, kishon@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	imx@lists.linux.dev
Subject: Re: [PATCH v3 2/3] dt-bindings: phy: Add i.MX8Q HSIO SerDes PHY
 binding
Message-ID: <ZikZmo3420wqx16E@lizhi-Precision-Tower-5810>
References: <1713939683-15328-1-git-send-email-hongxing.zhu@nxp.com>
 <1713939683-15328-3-git-send-email-hongxing.zhu@nxp.com>
 <20240424-lustfully-region-826b9570bc38@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424-lustfully-region-826b9570bc38@spud>
X-ClientProxiedBy: SJ0PR13CA0065.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9453:EE_
X-MS-Office365-Filtering-Correlation-Id: f0a6aad5-1b79-4030-ea6a-08dc646c5a26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|1800799015|376005|366007|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9MuXpyukn3MwyWPXMvNTUxA/a3G+LZFIv1kuUkUHgvDbgJ6l5o6KK/Yf0rbB?=
 =?us-ascii?Q?cV2efsbSZTKWDK3EL4k9zqSpFCzRezGIT9CSvHtxNl19b4171xQkQS/tm0A4?=
 =?us-ascii?Q?/LkhlUrEsBfF6255TQ/U7g9dXSuM2RPnLAuvigI8LQRFioYGfCZrEOvR+RgG?=
 =?us-ascii?Q?p4JByX4X4DQ10BfllaCxh06mC0z86A3Rt34GZcebmqlhVm3UavtD5mCm6Tlx?=
 =?us-ascii?Q?J60MCGB/55CMguEwgkOcrWYfdDGAmuwi2bhA9TZ5kvcwbni0EYd0w2a20fso?=
 =?us-ascii?Q?VvdQ5ptEH5C5ZQb4+4WvoBLjphdokRwC6LUlSbovrTgAxcUyw1TSg9+14GQE?=
 =?us-ascii?Q?x8y2CfziIVXo/bUKtruedklq3Ka4MIMZVqQx0Sjn7TxiUJ2pzM96Wxw5DY2E?=
 =?us-ascii?Q?9WmVqbgRR4NgPj5BIzTqN9HIg69XcGU1Tmxa3utUQ++U3HD04HY1Igk1wqXL?=
 =?us-ascii?Q?2Z5HD0ZKaruiBzbNo9CwgZC1InkYirCe0Rr+VPQX3fmXpkmXIEyU74beyXxh?=
 =?us-ascii?Q?CMTrnmkJ9lM9uZJTbmTN+KhGLsVdZT/eKaSkoXCGzKe4TcxbOjk5rSAnx/b8?=
 =?us-ascii?Q?PBdXvx97rx2rl6zhvdLgN8qftezuisiEdZ8p3sfRXutC9rGTe3hkd+DN5Kvs?=
 =?us-ascii?Q?WGQ8aOvKKxmEyNVt6eg6oDAAeQPHAQGCmRnUZYUyTU0MxwH91ESCb34YMC8l?=
 =?us-ascii?Q?En9oZnIDPTSYuubVAV29rG6V/YVCnTcaEFopgJsGfJqKOBDqb+XlNWxWYj96?=
 =?us-ascii?Q?bcRSbioapXrVqFhmNl9OUZIqCeP1cFRHVpsdEnJkabLy1bhCSUDG2e8I8oyt?=
 =?us-ascii?Q?BbaDP41DwCxq98abOgRNF67bH7GSCZdhxdkdYVDfDLgTyIQB7b1d87mumu5s?=
 =?us-ascii?Q?Y0LG5NX7aSZkmKwYgycGMlCajinN8cf4LJBADlcyVDcwajqYbjm/0ZO4furl?=
 =?us-ascii?Q?9bM0EQTucWdoaUKHSpPgoHi5oWxk+S7G/cF9tyP4h+1MDUVEe4DLA7hzw3+v?=
 =?us-ascii?Q?6S3x0qFzQWxixktv3kqmpx8KT8aavsfMrAHlSBGYciJT/F0/u6OM81zXDaAF?=
 =?us-ascii?Q?khusQHmrfb2qNn6rYiMR/brmWDtDpVCR0jwaWMO4l8j6/8yL5mfq1Hd4LHi9?=
 =?us-ascii?Q?1CwDuHdvPF32e4o4YVLGxC0rI/qRkuGTFNNL0c8kbL/6R2BbAJDxiMV/hD3o?=
 =?us-ascii?Q?XUqfVfcpt/iOR94QfMkyS3bCvx/w0wCsPF9TKE/R2ojAGeCV+9CXrTmXbBX0?=
 =?us-ascii?Q?Wfjm5SN2AEKCymKMIVTi6jRasCgvS6SfqYoRFVzdfY7uCfIYBGtMUw/Mcv9a?=
 =?us-ascii?Q?qak=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gze8w4ilMGlTssjKdJDuPpWjCMdszE5bK9sW8ts1OF12xn0jB4jFBozoaY6X?=
 =?us-ascii?Q?0DK783NDUEfn3VRFFzwAI7xtwLhfgNOINakKkf8ypktXLA8XLqwnPfBPrxKO?=
 =?us-ascii?Q?CRuaElKMFoLIXB0ThM+ae8o97fLqXVFEvOlTGte0I5q0AoX5Bv8G+LcJxUoA?=
 =?us-ascii?Q?RjmhnvtshqTawyPTsgU2eItE6/jSVWNFkck4SyJ8sZy0K6sv0d7wT3df90Mg?=
 =?us-ascii?Q?Y9XyyxmqBPV3/rmsYeN+OXW+Lx70km1XWeG/vXGi9mgr8iz2edSq53wREq7k?=
 =?us-ascii?Q?yW7FmnwimMt4CDBZy58SSBADqFHwYHFxrdZ2riKfaZF03Xxl8JDD7XKTCEZF?=
 =?us-ascii?Q?ZyZnFRXM3MPUEe9kglxFRMeDZV+4eS7/4RSxVeUUtnDZwNurZ3dfCpRBZDBH?=
 =?us-ascii?Q?D7nVfe+YvpW0UFbZIZsGC9GyJ5GQJ/gwTSxWSi/pDuldY4mO4MwgN31aXjRp?=
 =?us-ascii?Q?80DHAxII+xWZDxFPu5HPM1fCDyo4/1lpf04OjdBK0XD8S/k75f2W1d6ZJhX/?=
 =?us-ascii?Q?pY9rwUekHr6xm+/Gymzz+vvAYnEUgzZNbLTrTL0+imm2n85Uty3EGLzACQA2?=
 =?us-ascii?Q?uzvdNYm7tu+IRGAv+V2jkh8e5C3wnQpGzqB6XUzONvgnJBCHHHz4F0pXU4/n?=
 =?us-ascii?Q?XPZUODjoJapRaTZ2J7HFdq25LlUFlUzkzxWlfPfbjpDHLDZMMAAfQOJCdUXl?=
 =?us-ascii?Q?xgsC4qQwBIkDp3ZNQEQ+e4/7p6d/dPnphyGq2AzBlUiITssDhaAIlCFa93NO?=
 =?us-ascii?Q?LeClULVB2aWmcafZs0q+OkkoQmsF192n+EWgJZTw+NkCau5Utu6NZXtRYipr?=
 =?us-ascii?Q?044T/dHsNX5O4jJOQDwOu/ZRLGlJLQ4aSLZqWTqX9T4hRnHtrnX8lKUKG8OT?=
 =?us-ascii?Q?6X8Cc5MejE8uEg1J9jda8b6M6vDkuUfhmeAAxCCxbugCZYeGqhIuG1gWSsdC?=
 =?us-ascii?Q?IVyw/vTZBTAHrjVv1uzkSkozQz/BtxkOme54WVTSRjeWN2iX8msqDI8gXYyx?=
 =?us-ascii?Q?vQi8UOV6nPHZ4LeFtxSLGMHoar8ozP6628qx1n4wXPJ1TdaMWtB2NdKrA9oK?=
 =?us-ascii?Q?Mh9CuxtMjACfh4PIWMjUIGpSsUJhvtG8zT5WpHznnv4ah7FAle3y2O50DlPV?=
 =?us-ascii?Q?/rYC35dkMOsSKtYNzN+6Yab8I2Iq+mKqkSm8M5I+c/tFv8TPDZRsoVv5famD?=
 =?us-ascii?Q?D2pxuGooQHv+Pi3piOF3XOYaKKI5CRAkF2yZtGoQL8DgM6QlewB2KRJ8fhsA?=
 =?us-ascii?Q?VjmP6+Km37zPfIvXUOJ1FeuxZ1Xw/qeLPvXs2GflfUrQ0c+zgrCxdtV3xCck?=
 =?us-ascii?Q?Tn6bBNltzL7skuq84Kk1hlR35i3BlkxMGt1i8LynED0YR7ajkK3/7ZbdIp/3?=
 =?us-ascii?Q?PPswItn0B4ixnJSlE+le8mP58zo4NKcDa8qUHMgp92Zax+D7CFRf7MUtix9f?=
 =?us-ascii?Q?XfDkaahN0m+Ias67brLCPPIvTacvLpWD+c70JthQKml887+R/MpvhoEy0lSL?=
 =?us-ascii?Q?yraoSwXOd5n91bJ4/1hFUubpRGqwTioYPPLpoitPSfzL4cTFjmfOHiABgUs/?=
 =?us-ascii?Q?0M1VWpFO5UYNGjXRP44+JEvwvtjFNReonkCEleV3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a6aad5-1b79-4030-ea6a-08dc646c5a26
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 14:39:31.4091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tEk5SIIpzYs+t6nEVH2swLVc/E+r4tRRk1zIJAJRssKY8vkS35pyviiPSDO/cOxj3ZtpYvLj+SAfVZz3ZN/i0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9453

On Wed, Apr 24, 2024 at 01:04:27PM +0100, Conor Dooley wrote:
> On Wed, Apr 24, 2024 at 02:21:22PM +0800, Richard Zhu wrote:
> > Add i.MX8QM and i.MX8QXP HSIO SerDes PHY binding.
> > Introduce one HSIO configuration 'fsl,hsio-cfg', which need be set at
> > initialization according to board design.
> > 
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > ---
> >  .../bindings/phy/fsl,imx8qm-hsio.yaml         | 146 ++++++++++++++++++
> >  1 file changed, 146 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/fsl,imx8qm-hsio.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/fsl,imx8qm-hsio.yaml b/Documentation/devicetree/bindings/phy/fsl,imx8qm-hsio.yaml
> > new file mode 100644
> > index 000000000000..3e2824d1616c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/fsl,imx8qm-hsio.yaml
> > @@ -0,0 +1,146 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/phy/fsl,imx8qm-hsio.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Freescale i.MX8QM SoC series HSIO SERDES PHY
> > +
> > +maintainers:
> > +  - Richard Zhu <hongxing.zhu@nxp.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - fsl,imx8qm-hsio
> > +      - fsl,imx8qxp-hsio
> > +  reg:
> > +    minItems: 4
> > +    maxItems: 4
> > +
> > +  "#phy-cells":
> > +    const: 3
> > +    description:
> > +      The first defines the type of the PHY refer to the include phy.h.
> > +      The second defines controller index.
> > +      The third defines the lane mask of the lane ID, indicated which
> > +      lane is used by the PHY. They are defined as HSIO_LAN* in
> > +      dt-bindings/phy/phy-imx8-pcie.h
> > +
> > +  reg-names:
> > +    items:
> > +      - const: reg
> > +      - const: phy
> > +      - const: ctrl
> > +      - const: misc
> > +
> > +  clocks:
> > +    minItems: 5
> > +    maxItems: 14
> > +
> > +  clock-names:
> > +    minItems: 5
> > +    maxItems: 14
> > +
> > +  fsl,hsio-cfg:
> > +    description: Refer macro HSIO_CFG* include/dt-bindings/phy/phy-imx8-pcie.h.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +  fsl,refclk-pad-mode:
> > +    description:
> > +      Specifies the mode of the refclk pad used. It can be UNUSED(PHY
> > +      refclock is derived from SoC internal source), INPUT(PHY refclock
> > +      is provided externally via the refclk pad) or OUTPUT(PHY refclock
> > +      is derived from SoC internal source and provided on the refclk pad).
> > +      Refer include/dt-bindings/phy/phy-imx8-pcie.h for the constants
> > +      to be used.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    default: IMX8_PCIE_REFCLK_PAD_OUTPUT
> 
> My comments on this are still not addressed. Please go back and read my
> comments about this property on v1.

Richard: I think we missunderstand conor's means at v1.

"Why do we need numbers and a header here at all? The enum should be an
enum of strings input, output & unused. Oh and "unused" can just be
dropped, and not having the property at all would mean "unused"."

fsl,refclk-pad-mode:
  description:
    ...
  enum: ["input", "output"].

If not exist "fsl,refclk-pad-mode" means "unused".

Frank


