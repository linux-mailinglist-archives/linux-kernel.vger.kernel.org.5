Return-Path: <linux-kernel+bounces-106595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBD387F0C2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E76D1F23DA2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88C35787B;
	Mon, 18 Mar 2024 20:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UR4BTesF"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2090.outbound.protection.outlook.com [40.107.21.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C5657879;
	Mon, 18 Mar 2024 20:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710792171; cv=fail; b=mkod9/qpVhNbz4VGbf8CtEvdtGAE2WlFuwdUGOJtOP7U1yx6GHVqUvcYQbxOMOeCmOjbvyiKZvpZNAT3CTxhF6e8N6s0BnIf7RVxUsukORiqifSlgg1i/JKTwI6MZh64DchhbXMyBw9Lf3b+hS/X5QsYpn9F8u5ssEyas13b8H4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710792171; c=relaxed/simple;
	bh=JTojZFCK65KDJqbhTqasg1kl3O41gBUBv+kaprN9iww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Qeo89Q6kbQUj6705JTt8kSBVlLARTF3hvCQQkbE6My2Afc5mMc4Qx80a72sF8nDjaXr3Igl4RN6zC7X8ZtsAAsVN37Y1+HmK9f6rhTEFw00ihbJuWHYPIHS3CHLihg/iRBYWI4d2Un5kSwPxc5Fvof3WbB7WSNWnynwlaOZIHAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=UR4BTesF; arc=fail smtp.client-ip=40.107.21.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/SsSkMD5ezqa9IjhBw+4ktXuhQEs7lIKplejQbZD2jaky5bjxQIQR3HHBfn0XSIU+JQioWtY9uWtNDcUGw+k7NFDNxapWhSMiBL5/87F4v+EBGk9MyJ+/9ndk5A2++WMMbcdj+pAO8Vl7xFZutjoGOMphUtkT4si+2hHMIMGVzMQPfHa5s7wdW2Me/V85LwWaYHeJ687Nb3se2hkdpOip7fu/MIZqq+lPmvadZRM+A863xv1gWWWWTR/AqIOLFqGGA2cuffLWRB3UhSw3WmdkTKecQSf4vTOE33r5sB2E6hLx6osryYdZx+0DpJ1JNjd+/IGWIK06d1ecVuMzanHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6Dt2mWJHL534nYeNRMUGwAviyOijujLkez0rZUPmnU=;
 b=aIFbSdQA2h/H5JEEYUdxZ9q3xt2f3t1oM0G6hNydMzT4uORxolV/Jke3PGVL4BipreGKAl2vzodnS8vW2xcsRrSX+VYAl0THbdbY3WzYc5nVDwwhAx1lJQYrev9HybIjIsXZi0wenWseMK4/EgaXa0neKIhgVQAKSOFC7bzFjkAg7mNpyuIrks42Ib9tvZtaOvGVSbEHdnTQ6ZfCnQZ2qBjuBlb/d7f2gx2emHrwUIrT4GTf4LFd9+VhHnr4W8JWD9QqXu6rwchlQ0BsOwbl7e7zOpybb+9lwkEZxkWdaWWhII7odI8lXnrtMBG9PZBtrXmHM2LgKj+xHVwcIdIT9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6Dt2mWJHL534nYeNRMUGwAviyOijujLkez0rZUPmnU=;
 b=UR4BTesFrP1GdrKevynfP8YICZbAXWiHyOFMji7POQIfI65HRNEiQLKgPjYvVFA+Mjc5SZBn5eFNmHqri0NmwKw+k1rXsHqrSwcfuWjcH4oBvmDmozBt07rsVqU9Dy8f39caAL0NIYq+9WB4PQX9MWhCLZ27GDtPbRqRaQRFX5M=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8790.eurprd04.prod.outlook.com (2603:10a6:10:2e1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25; Mon, 18 Mar
 2024 20:02:46 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 20:02:45 +0000
Date: Mon, 18 Mar 2024 16:02:36 -0400
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Joy Zou <joy.zou@nxp.com>, ping.bai@nxp.com, lgirdwood@gmail.com,
	broonie@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v5 3/3] arm64: dts: imx93-11x11-evk: add pca9451a support
Message-ID: <Zfid3D7JW5HGIZVc@lizhi-Precision-Tower-5810>
References: <20240318095633.4079027-1-joy.zou@nxp.com>
 <20240318095633.4079027-4-joy.zou@nxp.com>
 <7f601f5e-98af-4a78-a3eb-04d814669973@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f601f5e-98af-4a78-a3eb-04d814669973@linaro.org>
X-ClientProxiedBy: SJ0PR03CA0076.namprd03.prod.outlook.com
 (2603:10b6:a03:331::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8790:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6nJ81cethsgohCUVjy68MD+oksYFyng8ZpT1sQODdpCQ80ZB0eyB+CVnsFymjl3Vf1vVPIR6FNO5hglX2XFH7mPP4d2geuU4HsRm9hR6nAo7XanI4c424vbj1aDITCsNIGYxAbVZnpXOZftPdGao8Z1T9qP7v5Nnib5deuez0vJQuGESY9IASFYAVxstaZHrZ6QcdwTp0q0/MJaugq41zvqwG+WTyvsc2EC1plN4MU2RbWk+OcKHlPUxtukb/k3uYSzv2lZQeyY1melKatGZD5XlTnEEUkmkOvUj09zzu974FGNapNTw84aYwBOYj4a6wHY6hT2MPEUoM7Gknpb5JWEpK1Kin6LIad+qRHWKBZGR+qKrGVZCmzRkLH1VUdFBrb4Q94jT8z/jiWDZYB9N0IBbgmY4T+fvHvuDDRf6vUbsTlZ/ny1P0bYQxxgWRrVqJTmnWWdCWi2folb6eEx5nQB6a8uWhvxDKprEKxZV8gIC1YxXk4HU8MWaGIHB5XRsD2eUy1wylNVt+uQGNy5vJoM6Lq2cc1+BGQYRZIMVTelNnw16Oz5WeMgE3BckBH475zYQNE/eUK2pr52B+3kWZe5nvSCCw0c4m6wc+jIDvx4Yi7aEY1yzSwYNkjV4WhYMF7ZlfB/5qcYIElt3WXN/MoPPO2mHLLzrG5GpQkg8Z520Kp/ZY52BAqXgEGVs/iCtofbVnfZMQhrxg5pLAalx0Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MX3VQIPFP9nE1WXWiVE+M6oZ+is7mYStT1JkZ9BBiNyndl+xSjMAlzTy5vi5?=
 =?us-ascii?Q?r/A0j1ovJ4CjUFuBKmg1crqJxhIGlUb4W4/fgX902GhPg6RlslFKjANNk1W6?=
 =?us-ascii?Q?0PNIBuAMQj1RhjK2FWDtD6whDt7RhtuzipZOud8WmNQkZHPFPVjUgNRIieM/?=
 =?us-ascii?Q?EGAqV1+wTA8u+ObI2PDPJqtTHRYLhIDaA8OtoIBF5NUcaQfXzsfDJ8Vwa5fE?=
 =?us-ascii?Q?Ww1kDiS7wjljskw2vM1AyD8JNd7BsY68pcdmTzSLJWjNF/ckDfyS+i7BBXmd?=
 =?us-ascii?Q?yz/cHw5fCHuy8b0YJ8LtYcn3B91NOoemcG/eNX+szFsdSeb4tXMrPtoryzRZ?=
 =?us-ascii?Q?qe2s7baivw4rDo8vxaZsgwJu0+qa3lvs1BMK4TlBdwcwomjFb/UJnAqwKqmp?=
 =?us-ascii?Q?mmMxdvpaP/Qm2YaoEID1gtYitJv28uju4nybn9p5YtuLJrbhi/kf1rsDuFYb?=
 =?us-ascii?Q?NIxu2c/S/HdEMeHrkx1m9ywCZ8E9fpfwczGxlrvR+0qGHPDFowhfQJ3a1xvd?=
 =?us-ascii?Q?Pkavauug7GYj/jkIasvfwrqKgcf//F/FSNcpl0k0BSSjsNRFwUWlA2gjrkM1?=
 =?us-ascii?Q?OdjXuKOoa5jgnlhgYPNwis9fkR8C0poDf6w28KXZOngyrg0Qdy23v+cRL361?=
 =?us-ascii?Q?eQsYJkA3qfvBZ3m1C6yy3ZowqV2rV1Lr4mMvkMpAl/i5NOq1xICfXVmr03mu?=
 =?us-ascii?Q?z0YDozv6q4+NBEG8swqX98mxYrAfvYzcmF9oHjkEB9dGG58QEKgbIk2T5/kG?=
 =?us-ascii?Q?eoZyQ9uOlCxlRCQ2+6ZRkozDCASLtw2pwO0+ID1ysm9lcc9gLFVr0W24xNiC?=
 =?us-ascii?Q?GEj+B7PvGRo4FWtuwfz1hFn/Xvl5YtfbaX2on54/4ljkKzoEpP+yNu8osnxJ?=
 =?us-ascii?Q?CsERaoUUSHg0Ew4+5ZZxrpBpEAcaV+WswMtWE0+mmayeccWmUbz3N1id5CY6?=
 =?us-ascii?Q?UPtf+SXGomGalF9fuuLuYuxzWY8Lr80g9aM4IqYAg71CA9UxMGAihSi+j25Z?=
 =?us-ascii?Q?/WRLFdhvKCfPZwulZjIyE0mXTG4F2w2H1q7p3x7gP7WfcNAmokc58o3GhQXF?=
 =?us-ascii?Q?J6znBNMMNA8tmCIJi/hACuyEfo/eg8YgGmSzmirGkvUP8rV1zqlt5mEq2nOE?=
 =?us-ascii?Q?UJQ/ZRhqeqj07Z7C/Gmu8WwPoYTTonuJTi+6pvv1Usq9LX1aGLIRRq56R3sx?=
 =?us-ascii?Q?ahbA5LUkJk6tFMHsfWb5/2YVJAJi00I42NpkgOzWBHXv20atyvMV7OLAfxex?=
 =?us-ascii?Q?CvH3jrzUXKE9hbCRH4uirsOpJq8mR9LLW54Gyp6RDHtcIKKOJ0eHQwRaGgnS?=
 =?us-ascii?Q?ApHL39cfbBdgay51WyHo0GHQrbx9FKBdYpjr7dn2DZqG1PIrTu0xDzW+tGGM?=
 =?us-ascii?Q?k+CyZ7szRUAZBBhIBtQ3KhgJefv9s26kIK35CIqCHOHNVB3iVpT18kqb2mEV?=
 =?us-ascii?Q?+waq3aoOTiovLr3dc+X/kXgeEY9mdnFldJ9LUe+WRwSTSgqpB6nq1PIChoRq?=
 =?us-ascii?Q?KmOs0C3ENi58A4dlXMWiiMT3IU6ciVGQ6GhQMLQbJwpFRHS/mbsYQiU1J4Xx?=
 =?us-ascii?Q?pla6k716m5MUJH8PFv06wkQwbxQt03CGy094IFLB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b4e32a-e396-4e47-0593-08dc478660f6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 20:02:45.8554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AR9220nBBlENoXlNgeZaFaRQrydHpRNbVNYZ0iJEE7M3VdZ7xUjO1uehCtdbyqNWZR9djcoIs/fZgkLcpaxqfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8790

On Mon, Mar 18, 2024 at 07:50:51PM +0100, Krzysztof Kozlowski wrote:
> On 18/03/2024 10:56, Joy Zou wrote:
> > Support pca9451a on imx93-11x11-evk.
> > 
> > Signed-off-by: Joy Zou <joy.zou@nxp.com>
> > ---
> > Changes in v5:
> > 1.adjust gpio@22 to the front of pmic@25.
> > 
> > Changes in v4:
> > 1. modify the comment for uSDHC but not i2c.
> > 
> > Changes in v3:
> > 1. modify the voltages constraints according to the imx93 datasheet.
> > ---
> >  .../boot/dts/freescale/imx93-11x11-evk.dts    | 111 ++++++++++++++++++
> >  1 file changed, 111 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> > index 9921ea13ab48..478a134d4416 100644
> > --- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> > @@ -183,6 +183,104 @@ &wdog3 {
> >  	status = "okay";
> >  };
> >  
> > +&lpi2c2 {
> > +	#address-cells = <1>;
> > +	#size-cells = <0>;
> > +	clock-frequency = <400000>;
> > +	pinctrl-names = "default", "sleep";
> > +	pinctrl-0 = <&pinctrl_lpi2c2>;
> > +	pinctrl-1 = <&pinctrl_lpi2c2>;
> > +	status = "okay";
> > +
> > +	pcal6524: gpio@22 {
> > +		compatible = "nxp,pcal6524";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_pcal6524>;
> > +		reg = <0x22>;
> 
> reg is the second property. Please do not introduce some other coding style.

Yes, Do you know if there are any tools to check it? If no, which tools
should be good to add such check. I may add it if have free time.

Frank Li

> 
> Best regards,
> Krzysztof
> 

