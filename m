Return-Path: <linux-kernel+bounces-55239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D96D584B97F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 904A6289CAE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47DE1339B7;
	Tue,  6 Feb 2024 15:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hrB9zkto"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2063.outbound.protection.outlook.com [40.107.22.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C298412B14D;
	Tue,  6 Feb 2024 15:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707233094; cv=fail; b=MMyA3/nh73y/S1xbxgnf8xYz0bF7pcWefbXsni6WlqozXgE33MSdI+v3FUB3oypQ5Q+NxxrOOPEcVnC8jWPp5kl892/+YGbrxN+RVGNaEcgKO7FcGrsi34mffYKKzSLpstjXa8kCS1jfnvi27vowZg+0+KBLUcRT4NMX1jbxXh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707233094; c=relaxed/simple;
	bh=AlZ2B3rvnUlx/NaBv+214fBKg/Pp3HnBK7NCUHC0in4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oQ8qBl/q8D1CsXeSrZXkA6NFodd1T+3tbpCurZfZ4U2wZUKBDY8zB1nWVp5DUNkpeqN3Xp2xx1JiHh6LMZzNLemz9BHI0RhapgYOo5HA2s28yj1bGhm2IkYi03X4Q3d5t14t8Rqbl2G/fOZDXW5n3B4AP3TUGf03rrFkT3fGwJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=hrB9zkto; arc=fail smtp.client-ip=40.107.22.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9FSly8gBVlogkdJ5nw+fSVt5KU/bM9PY+3n7JIZX3M+Vjii3INDY7P7mad6aiug73Cj5Bzjd9iXOGfoiCKnAqsyp9WO1lwxWI83EqLE2lKHQnWRvoCrhVhPM4H0HtrKpJS4yobaCC6D7yuTLxteIpRAydmlWEKC5ICpU6t1KSq974E+yyXGmL0XBFyfKArTa/emrYovnPAtHNuX7xYHFUstMZHmpVodzmLmC62y4uIU2ri/JvOMyIdlui5oVaNLjn0A0KvAYy9ziso2EX30O9sqwOuScHg89GzgyPl5SQAUzvrWgn6boC32O4DfXFOkiFGDAllceMZ3zo50c/XZfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ciuZcoSot9LCQ2spSferKHawCRT+VfikCn8NrHdlbxI=;
 b=Jeg8EF50DwfG8SP7CIiGYjQb293I5n6UkikAzU74jBiWnms7nOMU1b6SoEsW+ZklxumpDK8eszACRFASCtsYssoG0AekmoyNUuhPUDLOqH7qbkurv/ZtnfonUTe8wcQ64Iu/wi9WyYjcFpat1j5r4N3vNaeAg5T9qNumDHRrRVhkrjaqDAHfj0CO1B1KLIN+jWOyzx5m1iKpv93ryjz43nZJOczrxpx3BAcsQd8AGgbbztE089OQPH5cUE2ueGy2aPEeooYKpsZpaxbtHvqTKJv+MKpnIKoB30QqnXhM7XFH9Q7BLwGokbQnS4ddaDqF601s5Rh2rCZ5u/S6qmuNMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciuZcoSot9LCQ2spSferKHawCRT+VfikCn8NrHdlbxI=;
 b=hrB9zktoI8PcXiXYWvQyLOmuxCK04r5LaWw2qt4lwBpZLLPntV0hGlfkSv6MkyMUpSRFn/jqy3Sr86517CA/eTU/L67QcTKkrkn3HV+vWNL33n0bKYs0deKRvfI8FJfG4cmXuni4+5A+iP7IRRV9gHdc+kK3bMCDjxMp8SyVOME=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9439.eurprd04.prod.outlook.com (2603:10a6:102:2ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Tue, 6 Feb
 2024 15:24:50 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.032; Tue, 6 Feb 2024
 15:24:50 +0000
Date: Tue, 6 Feb 2024 10:24:42 -0500
From: Frank Li <Frank.li@nxp.com>
To: Shawn Guo <shawnguo2@yeah.net>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 2/2] arm64: dts: imx8dxl update edma0 information
Message-ID: <ZcJPOldJBIo3E7RK@lizhi-Precision-Tower-5810>
References: <20240129201633.234255-1-Frank.Li@nxp.com>
 <20240129201633.234255-2-Frank.Li@nxp.com>
 <ZcIMJWKBrPW4Y5R8@dragon>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcIMJWKBrPW4Y5R8@dragon>
X-ClientProxiedBy: BYAPR11CA0039.namprd11.prod.outlook.com
 (2603:10b6:a03:80::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB9439:EE_
X-MS-Office365-Filtering-Correlation-Id: ff027dcc-55ae-480e-c088-08dc2727c25b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dquqzfmf4UkoZFoF8OcdyxFg4/d7OnQnwwr9UVBT3CLTzcYVkMj4d3C2WSqCFNIPtRi+H1UiFr7DIssGtYEADlMxqyHYwWtu/e/nPIIROT3DLskJDuRl6M0m0+Qkf4P2fW3FF7ohzD9oEyEPIG4OGBcqcGVea5u975GXuiL1pGGjEXHuNi9a1Xctj36y4uZ8+900+LQDPzkKKJBSWiNE0NZ8Z9yA/OIY4NxMn6EtqvVT8ykJ0EjvlAo6RdyCOKYA0qzRmkeezBeHIZWmIUS+2bQarKy2eXk5IsUU1x1nP2JbshiMKTTpJgcw8mZNm+pl6hDsAufSGXr1vqU/pYSc4fFrCeFWuvjf4/N8E23RfFgMk39rXSk0A9x/rcvrk5RRpERJnrnUttV0aT/3HBoKGcYWYFPy29HnT7oTDj4posjsv2hxtTwnY0hPWGj9xQhj0+IG46YI9i6GiyipqiUORXRB5Cm/2381S/Wsk/w9Bz/mtYVjd11aQeZb7a+mC3ZBlA1agI59ahExmc/tvLh8EmtD8an51C3JRKYZcbj1+ESDFMxIKJq7V9TIpA8sNPf8CMxnQeik/eZHEuHpfJhlgmP5URUdytzLBrAlMHn2F1YzEq0q0frkVFowbhq28QlE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(39860400002)(396003)(366004)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(33716001)(38350700005)(41300700001)(6486002)(26005)(6512007)(52116002)(66476007)(54906003)(6666004)(316002)(6506007)(9686003)(83380400001)(478600001)(6916009)(66556008)(66946007)(5660300002)(7416002)(8936002)(15650500001)(8676002)(4326008)(2906002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k6O9aqvuZscFd9itcNjJjCQYP2mNRIDa+b284s+SlTPBdSQSQP64tZmQpsew?=
 =?us-ascii?Q?/JiArq1Tc3WAxv9vUctzWaxcYqVubsywmNDvo9nxv8NcMBlMXWvv3Ls/vfzM?=
 =?us-ascii?Q?s40DoYSdw086pe5/Otm9zAX5rs5NFu0CkSzr2jnSCYh+sf1lcG1KVzg5ijou?=
 =?us-ascii?Q?nDGzsME7Jvk/6si5qDkMWf1ZQxe/38KL+YKdq/JQdIiUPNzaB7fqoy9yxQM8?=
 =?us-ascii?Q?uxzTJLNtSzPK3tmSXiAa/jllm2H+cS/Z17+f/OtQHJ74L4NQ27mw8ATcUTug?=
 =?us-ascii?Q?5B8uLrGN1Ib/DvIB35hM3bP7WgN576vwdSyL4h9G63PsxYhkGAPOKEJ3flKm?=
 =?us-ascii?Q?qmgVY0F4yDGaDnAEdJzgMyzFTMK1l9bd64hluVmML1T14HKlpYwzHIAYTLnc?=
 =?us-ascii?Q?hSQXSh5Dz7N5YYUXgEDz/p2y2MIOUr8sUYapGEl4sWMvhKGPa4IP+DJ5okd/?=
 =?us-ascii?Q?wWCJcEWLAfLcc7Mhcz9hplVCo+4qKe8vra21CkigEC9u+dvwgNT0Mi75XvMW?=
 =?us-ascii?Q?i+X+xLikMkE4kQjwe92TMVQH8viYYB5CWupR6CMfq6wmA8i9kxaN4zQ7VlIW?=
 =?us-ascii?Q?ISRfqtxdnuaA6XLpYtsr+Kwim7/L8fO4DKGujYf7HAdE4AzDKP66906wvEUF?=
 =?us-ascii?Q?6DcymvAbL1dAmqy+0a5O6DvXGfuVQRgutKykLjppoc3wIZKjZmDaHH3eqbU+?=
 =?us-ascii?Q?R9YNZJ086q1M6Ljy8U/zCPHH6l1hHqX4FhjOUDrWbcOwoEGbUOr6KNRiAT6f?=
 =?us-ascii?Q?Mylj7lXAvorFytf4VX2Bf+jNAI3lOhGf2jmgIqOO2JvSkZXJiCGe6mW3nyEU?=
 =?us-ascii?Q?24o5zqsmpXp4DeUofLovTmJTIc9hmnHJsRp0SXmFXEpIFRZWuctszZx5Spw9?=
 =?us-ascii?Q?zN6rjlhmMtWYATFW4snE2qhhFgEWZ2OW5dVXETEqEuPC7G3iqMBPbYmwbvKM?=
 =?us-ascii?Q?HNZkqSgxftYgiw6Rm3qpdSMdsv/f2cc+s9XZMAvPfLCxxX4/sRppwya59Goj?=
 =?us-ascii?Q?KuXZBk15FdhbEdtBSeHsvntB5nQhG/6s6HBQesBW7e1W+lrhomKg7gNISzH5?=
 =?us-ascii?Q?XTujplWSVhgdakxlUY6fbVSJfg8ig92bUMVZj4htEUJ0LWDiSqWTsvL+5Swl?=
 =?us-ascii?Q?0Xloot5okOX2XF4YuL0FqAipsEsztMSw1kFBltQe8ZaKg5d8DTm//iJbG7sx?=
 =?us-ascii?Q?6cV2n2sggeOOllGjBQmFKZtdaXB+fUDbqIRly+9fbWFvFpNf1o1qPJR0ivCM?=
 =?us-ascii?Q?XCDlg5wZFPAVBXtVb7hIujlGmP2r4db/yPvjbiusIVbrudVTXqUbhCtcmsjE?=
 =?us-ascii?Q?MOc61l5LTfsY7P1DHQ9NRYIOjsCo8YkF6ufgg6VxvAsWL1HI1epjHIn2b2ZI?=
 =?us-ascii?Q?PVc5svQrzSfPxpr8axZ+h0Mf+xCqqeFDDgB4kaLgpAoaJ+QWp9VL3WSjO3T7?=
 =?us-ascii?Q?fWJf9xf4+p12Gq5tnvenwGhR4v+KvaQpTHE90Wxcx8Ks62DxAKlWSZT3sCRC?=
 =?us-ascii?Q?X2D+n++zvT2dv/n4zz/tAiT+ZU1N8ft3JZts5VbKhx5SFm/ew7aXaCOyJbFT?=
 =?us-ascii?Q?RXLyh1FodfzWH5yWF0o0JPKHVBR/8eeFV7VY04J7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff027dcc-55ae-480e-c088-08dc2727c25b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 15:24:49.9475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L2oIxTqHQaBPJuOkN559qlPhTR7k/ARHP0pNDQjY9XgNvD4P2R5xXIXpwL9eoG+/fk5GanXEGW22z4rob5GG6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9439

On Tue, Feb 06, 2024 at 06:38:29PM +0800, Shawn Guo wrote:
> On Mon, Jan 29, 2024 at 03:16:32PM -0500, Frank Li wrote:
> > edma0 of iMX8DXL is difference with other imx8 chips. Update register's
> > size, channel number and power-domain.
> > Update i2c[0-3] channel number information.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  .../boot/dts/freescale/imx8dxl-ss-adma.dtsi   | 65 +++++++++++++++++++
> >  1 file changed, 65 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
> > index 0a477f6318f15..f8fca86babda7 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
> > @@ -15,6 +15,63 @@ &adc0 {
> >  	interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
> >  };
> >  
> > +&edma0 {
> > +	reg = <0x591f0000 0x1a0000>;
> > +	#dma-cells = <3>;
> > +	dma-channels = <25>;
> > +	dma-channel-mask = <0x1c0cc0>;
> > +	interrupts = <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>, /* asrc 0 */
> > +		<GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>,
> > +		<GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>,
> > +		<GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>,
> > +		<GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>,
> > +		<GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>,
> > +		<GIC_SPI 0   IRQ_TYPE_LEVEL_HIGH>,
> > +		<GIC_SPI 0   IRQ_TYPE_LEVEL_HIGH>,
> > +		<GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>, /* spdif0 */
> > +		<GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>,
> > +		<GIC_SPI 0   IRQ_TYPE_LEVEL_HIGH>,
> > +		<GIC_SPI 0   IRQ_TYPE_LEVEL_HIGH>,
> > +		<GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>, /* sai0 */
> > +		<GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
> > +		<GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>, /* sai1 */
> > +		<GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
> > +		<GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>, /* sai2 */
> > +		<GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>, /* sai3 */
> > +		<GIC_SPI 0   IRQ_TYPE_LEVEL_HIGH>,
> > +		<GIC_SPI 0   IRQ_TYPE_LEVEL_HIGH>,
> > +		<GIC_SPI 0   IRQ_TYPE_LEVEL_HIGH>,
> > +		<GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>, /* gpt0 */
> > +		<GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH>, /* gpt1 */
> > +		<GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH>, /* gpt2 */
> > +		<GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>; /* gpt3 */
> > +	power-domains = <&pd IMX_SC_R_DMA_0_CH0>,
> > +			<&pd IMX_SC_R_DMA_0_CH1>,
> > +			<&pd IMX_SC_R_DMA_0_CH2>,
> > +			<&pd IMX_SC_R_DMA_0_CH3>,
> > +			<&pd IMX_SC_R_DMA_0_CH4>,
> > +			<&pd IMX_SC_R_DMA_0_CH5>,
> > +			<&pd IMX_SC_R_DMA_0_CH6>,
> > +			<&pd IMX_SC_R_DMA_0_CH7>,
> > +			<&pd IMX_SC_R_DMA_0_CH8>,
> > +			<&pd IMX_SC_R_DMA_0_CH9>,
> > +			<&pd IMX_SC_R_DMA_0_CH10>,
> > +			<&pd IMX_SC_R_DMA_0_CH11>,
> > +			<&pd IMX_SC_R_DMA_0_CH12>,
> > +			<&pd IMX_SC_R_DMA_0_CH13>,
> > +			<&pd IMX_SC_R_DMA_0_CH14>,
> > +			<&pd IMX_SC_R_DMA_0_CH15>,
> > +			<&pd IMX_SC_R_DMA_0_CH16>,
> > +			<&pd IMX_SC_R_DMA_0_CH17>,
> > +			<&pd IMX_SC_R_DMA_0_CH18>,
> > +			<&pd IMX_SC_R_DMA_0_CH19>,
> > +			<&pd IMX_SC_R_DMA_0_CH20>,
> > +			<&pd IMX_SC_R_DMA_0_CH21>,
> > +			<&pd IMX_SC_R_DMA_0_CH22>,
> > +			<&pd IMX_SC_R_DMA_0_CH23>,
> > +			<&pd IMX_SC_R_DMA_0_CH24>;
> > +};
> > +
> >  &edma2 {
> >  	interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>,
> >  		     <GIC_SPI 289 IRQ_TYPE_LEVEL_HIGH>,
> > @@ -48,21 +105,29 @@ &edma3 {
> >  &i2c0 {
> >  	compatible = "fsl,imx8dxl-lpi2c", "fsl,imx7ulp-lpi2c";
> >  	interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
> > +	dma-names = "tx","rx";
> > +	dmas = <&edma3 1 0 0>, <&edma3 0 0 FSL_EDMA_RX>;
> >  };
> >  
> >  &i2c1 {
> >  	compatible = "fsl,imx8dxl-lpi2c", "fsl,imx7ulp-lpi2c";
> >  	interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
> > +	dma-names = "tx","rx";
> > +	dmas = <&edma3 3 0 0>, <&edma3 2 0 FSL_EDMA_RX>;
> 
> No FSL_EDMA_TX for "tx"?

Yes, only defined FSL_EDMA_RX. It is bitmask. If no FSL_EDMA_RX, means
TX channel.

Frank

> 
> Shawn
> 
> >  };
> >  
> >  &i2c2 {
> >  	compatible = "fsl,imx8dxl-lpi2c", "fsl,imx7ulp-lpi2c";
> >  	interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
> > +	dma-names = "tx","rx";
> > +	dmas = <&edma3 5 0 0>, <&edma3 4 0 FSL_EDMA_RX>;
> >  };
> >  
> >  &i2c3 {
> >  	compatible = "fsl,imx8dxl-lpi2c", "fsl,imx7ulp-lpi2c";
> >  	interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
> > +	dma-names = "tx","rx";
> > +	dmas = <&edma3 7 0 0>, <&edma3 6 0 FSL_EDMA_RX>;
> >  };
> >  
> >  &lpuart0 {
> > -- 
> > 2.34.1
> > 
> 

