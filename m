Return-Path: <linux-kernel+bounces-95857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 083A187542A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DD4C1C209B0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CAB12FB1A;
	Thu,  7 Mar 2024 16:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UNWAGU5O"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2062.outbound.protection.outlook.com [40.107.22.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801A312F394;
	Thu,  7 Mar 2024 16:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709828805; cv=fail; b=LqUTcKACAwKXIErQtwDZacgXZ0UZmR2SWJYGzP07Z8gPMuXGtYbvSMjkXsEF8Aw5tmFjJ/n58vSl28/YhfiXrBFaeWvS3QEdifK9IHOge13RtbL9rmrKwlkHENw5G8Q4u0BCI7+6tXh1Q2x8DNYxYXXnZlBBsTiZEIEJlIj4+z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709828805; c=relaxed/simple;
	bh=Kv/Ek7Gj10PjKGLPkuaHkR4yZYehSehqRzRhqRghW50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iexizDcCQofsXyWZ9OiJGdiEU7OqRAuI7d4bbnnZxl3BgoIaV9hYfF7PxiA+OIyk6O/cq9TEt+JoH9CC5mbYYbVkS5gDULABfQE16lQyDJ0B5orOTLV6yUdrbWhXicH5OrQVn8D4ImBCWB29UrdO502R2gqZE6h6N600mcflF+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=UNWAGU5O reason="signature verification failed"; arc=fail smtp.client-ip=40.107.22.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSHwz3iek3yWVSdy2H/BrXM4HfVEKlQivol0l1R+cKQ6L+f+iCpgb/IW55FLSj5t68VwyX5SKK8N8GYDmBk6pFr4AdJAQe8pO0pU2eB+RDI1SlZh2Ckx5X/7v5i1OiFivsW7hlLkdvT72bEyBpqyJbKneiLQmjZiqXTC1iJYnJZnirj51FSYKoOu6xpfJbqt8GgJlOxiJdQ3/CExsX2pgiENWMotjgcByfZZRkHl/dKHyoD1gH2QHptYq19seYO5LiRYHfLBB7tsa7HuF13tuaa7hL3OMR1EvfTxUMADlQr+b/zSblc0kqBTL+u9ZMi/rDo6gSPv7v2m7R7Hp+T8qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8e9MF3jWYJqKvHcU93bCQHgAP04vYKMokXOYjx6sbg=;
 b=E6pBOdMM1gJ76P/blWE5kD5eNBG3uHbczmRHlzdxqmALYUIsqOXgaLq5WsZNplJIdhW9cacO6P9TZjKooJedkvOwlYXj7I12SB0bCcNh/H+RxlayXwUOVcRfPR7uTIcy5bRcrFh16IUmxzVi2uRGyuVXvvBjp0xLXHU9nF068mSCuLojHlQ7guIbTn+u9XhAmG++rL6RRf1hjGsbwzXsQclVU4W7UoNxo8/G37Eqj2eWHXMtlWYq15/RCZgU5qT5d/92Ph10dxkrMiw3MGJLz5xRNxygOgayAmBGaRtf690207lTF8NP8tGblQcpYloaMu7pF40UiupUiQecQJzEIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8e9MF3jWYJqKvHcU93bCQHgAP04vYKMokXOYjx6sbg=;
 b=UNWAGU5Oy1TjhZW1WftD/aU/RbJLt3YP3vJzluvX7H0DlTsUvIc/EUTD24hGvZRQaE0ZBqFSROWvujy9Nmcaml2Zv8+ocna2GfxJhx/KPAgZN7ZDKa5BSapAs59DELrcAIVvCOCJVzJQcz34n0jTlx1+1EdIhSB9avNbUSjsqtg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8881.eurprd04.prod.outlook.com (2603:10a6:20b:42c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 16:26:38 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 16:26:38 +0000
Date: Thu, 7 Mar 2024 11:26:29 -0500
From: Frank Li <Frank.li@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] arm64: dts: imx8qxp: add asrc[0, 1], esai0,
 spdif[0, 1] and sai[4, 5]
Message-ID: <Zenqtcg8HuGNN9L5@lizhi-Precision-Tower-5810>
References: <20240305-asrc_8qxp-v4-0-c61b98046591@nxp.com>
 <2177674.irdbgypaU6@steina-w>
 <ZeiJdoTqWd8h0Q5I@lizhi-Precision-Tower-5810>
 <1961523.PYKUYFuaPT@steina-w>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1961523.PYKUYFuaPT@steina-w>
X-ClientProxiedBy: SJ0PR13CA0162.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8881:EE_
X-MS-Office365-Filtering-Correlation-Id: 8df6b6a5-bc68-440b-afd5-08dc3ec35cec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BZQhZP6b4MPLat01vpeqV1c3SjOuqKyPqR8hOGjpJbgNE5EFwdRvX+M9VSxHsxnLsY5s5NW6sKCKqGVv8MDqpQndm+5IGpiMSQisHm62n16CZ8I4EcxtPS2YHXlRJufGKgzGUVPAK2y30sONdNsdDiey/cG6ZZsNwRTPHFLzB6A24bCwX8ptC8t8fvP4zMS/wgPB5FiS+Httfrr3eyGRKiWj7TySMmIbA5s9jJ52RFOHVuzwGJ9TBRhhb2flKdslyMrTk6YWZ03r2tIosT97we5Q4Em0oGnrBu0/2HhoXRC1HFNYJhwUrFlkIpSo4Mu9YyeCWasBOfCzNMDvaZSFBLdZa0lq4edNDkcEjtLJjSmSUmsW6HmcB/ioqwHMlVkT0Bzu3Vx7yQNpnPfZ31JFvVHJprxaVgWtOH2gZS1phkwy2zELqdUZbiP6BRcKEdG8W+RdFuNrgEQg8UF3NDgKir/njnCRL1+4KYXDwtZx39JFM2tbKxlmqVlRlZzqEFs0Wdzxae6OFysZdcvjX+hwveFB7mlaBwZ9UlEaL2g0ELtqiErOJdC7nP4L1AD1/o7XVmj2RsJZH+gyb8E4mH6/DVjTvZUW9FRnsNk1IrI4W9LCX3tP2bsKMrhVB2TiQ+yy+PLVOiAEgvH7TP6a0kenOkzxEB4FYBWS80ljJ9M5trM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?9xzelrCkN4S8M86PEUHBAUV/+J7kFJiendwiNNypJ4Lt7HpZlepaID/NPw?=
 =?iso-8859-1?Q?LLvKl7U6EKEzV+FUI5SEfb/KCNNf6nOOiaIM9lshrp/LKlHGc9zw5CyC+j?=
 =?iso-8859-1?Q?6x+gCeBs5Tkdt+koOwwhYy0DzDM3IUbiV7+jHqbi9SE95S78TVuA9IjtX4?=
 =?iso-8859-1?Q?UGlCZERyaFTJEU5mcjRkrjzQBxzzpgeC9e0sFlyd/b9Ah5LnqqX4WPvDJt?=
 =?iso-8859-1?Q?3Xt0a3Uw4zguiRIlpnKyJ62s4WmaycJi+o7WiLFQSsg7LZHRLoZGwnzFJv?=
 =?iso-8859-1?Q?89gwXeekB9aKwDrx5lo+caRVEtcLlBcjmeCrfhRbMoBvIIKEmef9k/ZigB?=
 =?iso-8859-1?Q?8IhufLBgfZeve3jvlelpZgejYyWxSm1xtfrTAmBueqqbbyiMsND+nzWQq8?=
 =?iso-8859-1?Q?BdcPHWwiZC+xjGaAEOjnQPv7OfbZqJyYC8zgtZt6FHeDpNBmhgwcmC8/5G?=
 =?iso-8859-1?Q?BJrnmPtllkTah4OC2yWBZq9VXPFUwzDfxQWKmGLj5ZxxkAzxMOyUCFPQcG?=
 =?iso-8859-1?Q?ok1VnKE/7nP//3JjroBJPxMv3LN0lSv8HWUPfkQ6sIN3ZoCn+M3d9zaxIu?=
 =?iso-8859-1?Q?DO9dIdWvnRxCIdlxZcADlZ00rqonsok1Qx51vQbpl43SUysiKYNCujufU7?=
 =?iso-8859-1?Q?NYF4UPNwsEyFX9cVnjmCHV0WSaHOA8eR93oGPOhVUHgseSxUOmAVVbNk1x?=
 =?iso-8859-1?Q?+d3yC4zsTVNBwL7OB6w7dbjYWjW8Swp6nniOtHdt6euj17fQCnUWEiIpYh?=
 =?iso-8859-1?Q?tnXAOwLg+ibkD3VeruYNgRhV01LaYGB8lhnB7zZSN6y+gPjsJq4JY3hsxo?=
 =?iso-8859-1?Q?DecwSs3+EKs4qTCeS3iqvQfaV5TSNDPfwU6CcK0FHcG57CbRMQWq67GXPu?=
 =?iso-8859-1?Q?cUa4c3g5K8R+BakA0z2U8pOWcAXZhexQGv3kC7FoEWWGHi1V5UDnOb1vKL?=
 =?iso-8859-1?Q?4QxyYiYuLd32Yrr9Ov7wRZQfbMPBK1sukNuTsPl+2fCHEq85QgPNMCAG7U?=
 =?iso-8859-1?Q?/bQ1eORsP8+xCsj6xxn5uDtVtbyZc2XnvpOwhuXlBcGfvYk08izZQv7dMI?=
 =?iso-8859-1?Q?9oTw+3Q8Hg+a2rZgFwctFrx3l+YXKlpzf/zqoTY42dVwvjc1/UPYlVvwbN?=
 =?iso-8859-1?Q?QfQ1oZGGcoaTH0xX5ynzLGNBns/vTtwuCi0MxYVSPNO7c/BydGsTg//Dmu?=
 =?iso-8859-1?Q?PkzEAZ+iC8SzPWlNDj8nBhwz+J2VGdhSl/5rBt6+lhgA2tzAf5/i0XCjrU?=
 =?iso-8859-1?Q?UJFiWfhaiuCOIq3ZfQxkFEXiVqp1nemqvN5GydlbcmVaAUKVaGb+mHEwbT?=
 =?iso-8859-1?Q?usZ5DZblq5LC98e4g9hnWYwEmFmipnG92jUTr9R8LvfRqZZSJxpvYJD90f?=
 =?iso-8859-1?Q?O7QmvQQ2BWx6lrsVXkqPCd25Jg0zJK06+LeDxsK1KZE1dzhU35e/5R5NjR?=
 =?iso-8859-1?Q?O3BUJYOUwuYDEEgqz6WwS1xtVqbQ2AW7FoRBrQ4rgLWDbY0RwjdGnc4xjn?=
 =?iso-8859-1?Q?fWIwvr1gdzNr5+VBrvG5hkz0VLDxrEnPTW17pItvaFTYxvFWYvvke0+IDC?=
 =?iso-8859-1?Q?6VGZEi159A4M1INc6YUXzbRF34bqxnUOPmzr5H1Ty3CSlebOkLxbJ3wM04?=
 =?iso-8859-1?Q?arDjpnInqz9dk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df6b6a5-bc68-440b-afd5-08dc3ec35cec
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 16:26:37.9459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TcUO8Ci8lPdVvVJLb9FAPkTSVnjQslEML+wWMz+DoV0RDtXNn0X8diisbnBi/BQVZw7fYsGThyeFuHAmFhJkkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8881

On Thu, Mar 07, 2024 at 08:22:25AM +0100, Alexander Stein wrote:
> Hi Frank,
> 
> Am Mittwoch, 6. März 2024, 16:19:18 CET schrieb Frank Li:
> > On Wed, Mar 06, 2024 at 08:20:00AM +0100, Alexander Stein wrote:
> > > Hi Frank,
> > > 
> > > thanks for the patch.
> > > 
> > > Am Dienstag, 5. März 2024, 18:33:05 CET schrieb Frank Li:
> > > > Add asrc[0,1], esai0, spdif[0,1], sai[4,5] and related lpcg node for
> > > > imx8 audio subsystem.
> > > > 
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > >  arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi | 304 +++++++++++++++++++++++
> > > >  1 file changed, 304 insertions(+)
> > > > 
> > > > diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
> > > > index 07afeb78ed564..78305559f15c9 100644
> > > > --- a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
> > > > +++ b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
> > > > @@ -6,6 +6,7 @@
> > > >  
> > > >  #include <dt-bindings/clock/imx8-clock.h>
> > > >  #include <dt-bindings/clock/imx8-lpcg.h>
> > > > +#include <dt-bindings/dma/fsl-edma.h>
> > > >  #include <dt-bindings/firmware/imx/rsrc.h>
> > > >  
> > > >  audio_ipg_clk: clock-audio-ipg {
> > > > @@ -481,4 +482,307 @@ acm: acm@59e00000 {
> > > >  			      "sai3_rx_bclk",
> > > >  			      "sai4_rx_bclk";
> > > >  	};
> > > > +
> > > > +	asrc0: asrc@59000000 {
> > > 
> > > Please insert nodes sorted by address. ASRC0 is the very first node.
> > > 
> > > > +		compatible = "fsl,imx8qm-asrc";
> > > > +		reg = <0x59000000 0x10000>;
> > > > +		interrupts = <GIC_SPI 372 IRQ_TYPE_LEVEL_HIGH>;
> > > > +		clocks = <&asrc0_lpcg 0>,
> > > > +			 <&asrc0_lpcg 0>,
> > > > +			 <&aud_pll_div0_lpcg 0>,
> > > > +			 <&aud_pll_div1_lpcg 0>,
> > > > +			 <&acm IMX_ADMA_ACM_AUD_CLK0_SEL>,
> > > > +			 <&acm IMX_ADMA_ACM_AUD_CLK1_SEL>,
> > > > +			 <&clk_dummy>,
> > > > +			 <&clk_dummy>,
> > > > +			 <&clk_dummy>,
> > > > +			 <&clk_dummy>,
> > > > +			 <&clk_dummy>,
> > > > +			 <&clk_dummy>,
> > > > +			 <&clk_dummy>,
> > > > +			 <&clk_dummy>,
> > > > +			 <&clk_dummy>,
> > > > +			 <&clk_dummy>,
> > > > +			 <&clk_dummy>,
> > > > +			 <&clk_dummy>,
> > > > +			 <&clk_dummy>;
> > > > +		clock-names = "mem", "ipg",
> > > > +			      "asrck_0", "asrck_1", "asrck_2", "asrck_3",
> > > > +			      "asrck_4", "asrck_5", "asrck_6", "asrck_7",
> > > > +			      "asrck_8", "asrck_9", "asrck_a", "asrck_b",
> > > > +			      "asrck_c", "asrck_d", "asrck_e", "asrck_f",
> > > > +			      "spba";
> > > > +		dmas = <&edma0 0 0 0>,
> > > > +		       <&edma0 1 0 0>,
> > > > +		       <&edma0 2 0 0>,
> > > > +		       <&edma0 3 0 FSL_EDMA_RX>,
> > > > +		       <&edma0 4 0 FSL_EDMA_RX>,
> > > > +		       <&edma0 5 0 FSL_EDMA_RX>;
> > > > +		/* tx* is output channel of asrc, it is rx channel for eDMA */
> > > > +		dma-names = "rxa", "rxb", "rxc", "txa", "txb", "txc";
> > > > +		fsl,asrc-rate  = <8000>;
> > > > +		fsl,asrc-width = <16>;
> > > > +		fsl,asrc-clk-map = <0>;
> > > > +		power-domains = <&pd IMX_SC_R_ASRC_0>;
> > > > +		status = "disabled";
> > > > +	};
> > > > +
> > > > +	esai0: esai@59010000 {
> > > > +		compatible = "fsl,imx8qm-esai", "fsl,imx6ull-esai";
> > > > +		reg = <0x59010000 0x10000>;
> > > > +		interrupts = <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>;
> > > > +		clocks = <&esai0_lpcg 1>, <&esai0_lpcg 0>, <&esai0_lpcg 1>, <&clk_dummy>;
> > > > +		clock-names = "core", "extal", "fsys", "spba";
> > > > +		dmas = <&edma0 6 0 FSL_EDMA_RX>, <&edma0 7 0 0>;
> > > > +		dma-names = "rx", "tx";
> > > > +		power-domains = <&pd IMX_SC_R_ESAI_0>;
> > > > +		status = "disabled";
> > > > +	};
> > > > +
> > > > +	spdif0: spdif@59020000 {
> > > > +		compatible = "fsl,imx8qm-spdif";
> > > > +		reg = <0x59020000 0x10000>;
> > > > +		interrupts =  <GIC_SPI 456 IRQ_TYPE_LEVEL_HIGH>, /* rx */
> > > > +			      <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>; /* tx */
> > > > +		clocks = <&spdif0_lpcg 1>,	/* core */
> > > > +			 <&clk_dummy>,		/* rxtx0 */
> > > > +			 <&spdif0_lpcg 0>,	/* rxtx1 */
> > > > +			 <&clk_dummy>,		/* rxtx2 */
> > > > +			 <&clk_dummy>,		/* rxtx3 */
> > > > +			 <&clk_dummy>,		/* rxtx4 */
> > > > +			 <&audio_ipg_clk>,	/* rxtx5 */
> > > > +			 <&clk_dummy>,		/* rxtx6 */
> > > > +			 <&clk_dummy>,		/* rxtx7 */
> > > > +			 <&clk_dummy>;		/* spba */
> > > > +		clock-names = "core", "rxtx0", "rxtx1", "rxtx2", "rxtx3", "rxtx4",
> > > > +			      "rxtx5", "rxtx6", "rxtx7", "spba";
> > > > +		dmas = <&edma0 8 0 (FSL_EDMA_MULTI_FIFO | FSL_EDMA_RX)>,
> > > > +		       <&edma0 9 0 FSL_EDMA_MULTI_FIFO>;
> > > > +		dma-names = "rx", "tx";
> > > > +		power-domains = <&pd IMX_SC_R_SPDIF_0>;
> > > > +		status = "disabled";
> > > > +	};
> > > > +
> > > > +	spdif1: spdif@59030000 {
> > > 
> > > That's imx8qm only, no?
> > 
> > I am not sure what means. why do you think it is imx8qm only? It is for
> > imx8qm, imx8qxp, imx8dxl.
> 
> According to Table- 2-6 (Audio DMA memory Map) in i.MX8X RM Rev. 0 05/2020,
> the lasted one available on the webpage, address 0x59030000 is reserved.
> I read that as there is no periphery available. This matches the feature list
> in 1.1.2 Features, where "1x SPDIF" is stated.
> 
> So spdif1 is only for imx8qm (no idea about imx8dxl though) and should be
> listed in a file called imx8qm-ss-audio.dtsi which is only included in
> imx8qm.dtsi.
> 

Thanks, I will do that.

> Thanks and best regards
> Alexander
> 
> > 
> > Frank
> > 
> > > 
> > > > +		compatible = "fsl,imx8qm-spdif";
> > > > +		reg = <0x59030000 0x10000>;
> > > > +		interrupts =  <GIC_SPI 460 IRQ_TYPE_LEVEL_HIGH>, /* rx */
> > > > +			      <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH>; /* tx */
> > > > +		clocks = <&spdif1_lpcg 1>,	/* core */
> > > > +			 <&clk_dummy>,		/* rxtx0 */
> > > > +			 <&spdif1_lpcg 0>,	/* rxtx1 */
> > > > +			 <&clk_dummy>,		/* rxtx2 */
> > > > +			 <&clk_dummy>,		/* rxtx3 */
> > > > +			 <&clk_dummy>,		/* rxtx4 */
> > > > +			 <&audio_ipg_clk>,	/* rxtx5 */
> > > > +			 <&clk_dummy>,		/* rxtx6 */
> > > > +			 <&clk_dummy>,		/* rxtx7 */
> > > > +			 <&clk_dummy>;		/* spba */
> > > > +		clock-names = "core", "rxtx0", "rxtx1", "rxtx2", "rxtx3", "rxtx4",
> > > > +			      "rxtx5", "rxtx6", "rxtx7", "spba";
> > > > +		dmas = <&edma0 10 0 (FSL_EDMA_MULTI_FIFO | FSL_EDMA_RX)>,
> > > > +		       <&edma0 11 0 FSL_EDMA_MULTI_FIFO>;
> > > > +		dma-names = "rx", "tx";
> > > > +		power-domains = <&pd IMX_SC_R_SPDIF_1>;
> > > > +		status = "disabled";
> > > > +	};
> > > > +
> > > > +	asrc1: asrc@59800000 {
> > > 
> > > Insert this between dsp and edma1, sorted by address.
> > > 
> > > > +		compatible = "fsl,imx8qm-asrc";
> > > > +		reg = <0x59800000 0x10000>;
> > > > +		interrupts = <GIC_SPI 380 IRQ_TYPE_LEVEL_HIGH>;
> > > > +		clocks = <&asrc1_lpcg 0>,
> > > > +			 <&asrc1_lpcg 0>,
> > > > +			 <&aud_pll_div0_lpcg 0>,
> > > > +			 <&aud_pll_div1_lpcg 0>,
> > > > +			 <&acm IMX_ADMA_ACM_AUD_CLK0_SEL>,
> > > > +			 <&acm IMX_ADMA_ACM_AUD_CLK1_SEL>,
> > > > +			 <&clk_dummy>,
> > > > +			 <&clk_dummy>,
> > > > +			 <&clk_dummy>,
> > > > +			 <&clk_dummy>,
> > > > +			 <&clk_dummy>,
> > > > +			 <&clk_dummy>,
> > > > +			 <&clk_dummy>,
> > > > +			 <&clk_dummy>,
> > > > +			 <&clk_dummy>,
> > > > +			 <&clk_dummy>,
> > > > +			 <&clk_dummy>,
> > > > +			 <&clk_dummy>,
> > > > +			 <&clk_dummy>;
> > > > +		clock-names = "mem", "ipg",
> > > > +			      "asrck_0", "asrck_1", "asrck_2", "asrck_3",
> > > > +			      "asrck_4", "asrck_5", "asrck_6", "asrck_7",
> > > > +			      "asrck_8", "asrck_9", "asrck_a", "asrck_b",
> > > > +			      "asrck_c", "asrck_d", "asrck_e", "asrck_f",
> > > > +			      "spba";
> > > > +		dmas = <&edma1 0 0 0>,
> > > > +		       <&edma1 1 0 0>,
> > > > +		       <&edma1 2 0 0>,
> > > > +		       <&edma1 3 0 FSL_EDMA_RX>,
> > > > +		       <&edma1 4 0 FSL_EDMA_RX>,
> > > > +		       <&edma1 5 0 FSL_EDMA_RX>;
> > > > +		/* tx* is output channel of asrc, it is rx channel for eDMA */
> > > > +		dma-names = "rxa", "rxb", "rxc", "txa", "txb", "txc";
> > > > +		fsl,asrc-rate  = <8000>;
> > > > +		fsl,asrc-width = <16>;
> > > > +		fsl,asrc-clk-map = <1>;
> > > > +		power-domains = <&pd IMX_SC_R_ASRC_1>;
> > > > +		status = "disabled";
> > > > +	};
> > > > +
> > > > +	sai4: sai@59820000 {
> > > > +		compatible = "fsl,imx8qm-sai";
> > > > +		reg = <0x59820000 0x10000>;
> > > > +		interrupts = <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>;
> > > > +		clocks = <&sai4_lpcg 1>,
> > > > +			 <&clk_dummy>,
> > > > +			 <&sai4_lpcg 0>,
> > > > +			 <&clk_dummy>,
> > > > +			 <&clk_dummy>;
> > > > +		clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
> > > > +		dmas = <&edma1 8 0 FSL_EDMA_RX>, <&edma1 9 0 0>;
> > > > +		dma-names = "rx", "tx";
> > > > +		power-domains = <&pd IMX_SC_R_SAI_4>;
> > > > +		status = "disabled";
> > > > +	};
> > > > +
> > > > +	sai5: sai@59830000 {
> > > > +		compatible = "fsl,imx8qm-sai";
> > > > +		reg = <0x59830000 0x10000>;
> > > > +		interrupts = <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>;
> > > > +		clocks = <&sai5_lpcg 1>,
> > > > +			 <&clk_dummy>,
> > > > +			 <&sai5_lpcg 0>,
> > > > +			 <&clk_dummy>,
> > > > +			 <&clk_dummy>;
> > > > +		clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
> > > > +		dmas = <&edma1 10 0 0>;
> > > > +		dma-names = "tx";
> > > > +		power-domains = <&pd IMX_SC_R_SAI_5>;
> > > > +		status = "disabled";
> > > > +	};
> > > > +
> > > > +	amix: amix@59840000 {
> > > > +		compatible = "fsl,imx8qm-audmix";
> > > > +		reg = <0x59840000 0x10000>;
> > > > +		clocks = <&amix_lpcg 0>;
> > > > +		clock-names = "ipg";
> > > > +		power-domains = <&pd IMX_SC_R_AMIX>;
> > > > +		dais = <&sai4>, <&sai5>;
> > > > +		status = "disabled";
> > > > +	};
> > > > +
> > > > +	mqs: mqs@59850000 {
> > > > +		compatible = "fsl,imx8qm-mqs";
> > > > +		reg = <0x59850000 0x10000>;
> > > > +		clocks = <&mqs0_lpcg 0>,
> > > > +			<&mqs0_lpcg 1>;
> > > > +		clock-names = "mclk", "core";
> > > > +		power-domains = <&pd IMX_SC_R_MQS_0>;
> > > > +		status = "disabled";
> > > > +	};
> > > > +
> > > > +	asrc0_lpcg: clock-controller@59400000 {
> > > 
> > > Please insert he lpcg nodes according to their address.
> > > 
> > > > +		compatible = "fsl,imx8qxp-lpcg";
> > > > +		reg = <0x59400000 0x10000>;
> > > > +		#clock-cells = <1>;
> > > > +		clocks = <&audio_ipg_clk>;
> > > > +		clock-indices = <IMX_LPCG_CLK_4>;
> > > > +		clock-output-names = "asrc0_lpcg_ipg_clk";
> > > > +		power-domains = <&pd IMX_SC_R_ASRC_0>;
> > > > +	};
> > > > +
> > > > +	esai0_lpcg: clock-controller@59410000 {
> > > > +		compatible = "fsl,imx8qxp-lpcg";
> > > > +		reg = <0x59410000 0x10000>;
> > > > +		#clock-cells = <1>;
> > > > +		clocks = <&acm IMX_ADMA_ACM_ESAI0_MCLK_SEL>,
> > > > +			 <&audio_ipg_clk>;
> > > > +		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> > > > +		clock-output-names = "esai0_lpcg_extal_clk",
> > > > +				     "esai0_lpcg_ipg_clk";
> > > > +		power-domains = <&pd IMX_SC_R_ESAI_0>;
> > > > +	};
> > > > +
> > > > +	spdif0_lpcg: clock-controller@59420000 {
> > > > +		compatible = "fsl,imx8qxp-lpcg";
> > > > +		reg = <0x59420000 0x10000>;
> > > > +		#clock-cells = <1>;
> > > > +		clocks = <&acm IMX_ADMA_ACM_SPDIF0_TX_CLK_SEL>,
> > > > +			 <&audio_ipg_clk>;
> > > > +		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> > > > +		clock-output-names = "spdif0_lpcg_tx_clk",
> > > > +				     "spdif0_lpcg_gclkw";
> > > > +		power-domains = <&pd IMX_SC_R_SPDIF_0>;
> > > > +	};
> > > > +
> > > > +	spdif1_lpcg: clock-controller@59430000 {
> > > 
> > > That's imx8qm only as well, no?
> > > 
> > > Thanks and best regards,
> > > Alexander
> > > 
> > > > +		compatible = "fsl,imx8qxp-lpcg";
> > > > +		reg = <0x59430000 0x10000>;
> > > > +		#clock-cells = <1>;
> > > > +		clocks = <&acm IMX_ADMA_ACM_SPDIF1_TX_CLK_SEL>,
> > > > +			 <&audio_ipg_clk>;
> > > > +		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> > > > +		clock-output-names = "spdif1_lpcg_tx_clk",
> > > > +				     "spdif1_lpcg_gclkw";
> > > > +		power-domains = <&pd IMX_SC_R_SPDIF_1>;
> > > > +		status = "disabled";
> > > > +	};
> > > > +
> > > > +	asrc1_lpcg: clock-controller@59c00000 {
> > > > +		compatible = "fsl,imx8qxp-lpcg";
> > > > +		reg = <0x59c00000 0x10000>;
> > > > +		#clock-cells = <1>;
> > > > +		clocks = <&audio_ipg_clk>;
> > > > +		clock-indices = <IMX_LPCG_CLK_4>;
> > > > +		clock-output-names = "asrc1_lpcg_ipg_clk";
> > > > +		power-domains = <&pd IMX_SC_R_ASRC_1>;
> > > > +	};
> > > > +
> > > > +	sai4_lpcg: clock-controller@59c20000 {
> > > > +		compatible = "fsl,imx8qxp-lpcg";
> > > > +		reg = <0x59c20000 0x10000>;
> > > > +		#clock-cells = <1>;
> > > > +		clocks = <&acm IMX_ADMA_ACM_SAI4_MCLK_SEL>,
> > > > +			 <&audio_ipg_clk>;
> > > > +		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> > > > +		clock-output-names = "sai4_lpcg_mclk",
> > > > +				     "sai4_lpcg_ipg_clk";
> > > > +		power-domains = <&pd IMX_SC_R_SAI_4>;
> > > > +	};
> > > > +
> > > > +	sai5_lpcg: clock-controller@59c30000 {
> > > > +		compatible = "fsl,imx8qxp-lpcg";
> > > > +		reg = <0x59c30000 0x10000>;
> > > > +		#clock-cells = <1>;
> > > > +		clocks = <&acm IMX_ADMA_ACM_SAI5_MCLK_SEL>,
> > > > +			 <&audio_ipg_clk>;
> > > > +		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> > > > +		clock-output-names = "sai5_lpcg_mclk",
> > > > +				     "sai5_lpcg_ipg_clk";
> > > > +		power-domains = <&pd IMX_SC_R_SAI_5>;
> > > > +	};
> > > > +
> > > > +	amix_lpcg: clock-controller@59c40000 {
> > > > +		compatible = "fsl,imx8qxp-lpcg";
> > > > +		reg = <0x59c40000 0x10000>;
> > > > +		#clock-cells = <1>;
> > > > +		clocks = <&audio_ipg_clk>;
> > > > +		clock-indices = <IMX_LPCG_CLK_0>;
> > > > +		clock-output-names = "amix_lpcg_ipg_clk";
> > > > +		power-domains = <&pd IMX_SC_R_AMIX>;
> > > > +	};
> > > > +
> > > > +	mqs0_lpcg: clock-controller@59c50000 {
> > > > +		compatible = "fsl,imx8qxp-lpcg";
> > > > +		reg = <0x59c50000 0x10000>;
> > > > +		#clock-cells = <1>;
> > > > +		clocks = <&acm IMX_ADMA_ACM_MQS_TX_CLK_SEL>,
> > > > +			 <&audio_ipg_clk>;
> > > > +		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> > > > +		clock-output-names = "mqs0_lpcg_mclk",
> > > > +				     "mqs0_lpcg_ipg_clk";
> > > > +		power-domains = <&pd IMX_SC_R_MQS_0>;
> > > > +	};
> > > >  };
> > > > 
> > > > 
> > > 
> > > 
> > 
> > 
> 
> 
> -- 
> TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
> Amtsgericht München, HRB 105018
> Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
> http://www.tq-group.com/
> 
> 

