Return-Path: <linux-kernel+bounces-153876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 835398AD462
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E56C1C21115
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AF1155A33;
	Mon, 22 Apr 2024 18:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KLCkVirc"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED4415535D;
	Mon, 22 Apr 2024 18:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713811766; cv=fail; b=HVv90ND3HBoenTO6lthJd9DPYnz59i71eQHAtk3fw8Ptg2EKIPfPyddUQFlZTxQXyPh9nuzlFNCLZuH6hapYBgZZT4yq3PRrgc0QijCPabgYishbL0BSMW5TK7P7s1L+aY4Nn31UG8/GZq/GXeenchycNrv5b3ulEXLSTWV/tY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713811766; c=relaxed/simple;
	bh=fpdBgmuKGokRLQ5G7wCluoqHo4fbKsRFUZ6OWOnWDxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YnrcJE8zG9AL0zlCyNQMg9a1Rn0I2tn2/1C3iQ45vGznt5WsuxZdPMLzSOD9haV4FAaHcnECmvhZ9ISHIkvPtX9G9wPDEQLAYznlGa1E1xLICbwx8wLR/alVpOPGfL2o6XQJIv/EAlJUMlL9tRWi9IAtHnlXvAIk3+EQj58HiGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=KLCkVirc; arc=fail smtp.client-ip=40.107.21.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODGHM9fRhM/iImH053qTI9BfQVbtQTvySfoKrvBe1M9U34Zla8WnCifIEfnLJ0Ynyc36FC1HQ9hZ+60q1uMBmqifxHbLK8lZNBVCxu/d+X9qu4Dk/8vqyFvTnPogmntpVNOnOyy2NSQ93Wq9akQ04j8ISU/2M2Tz1PBirvnFt+pbwCrJBij01MOCdGvlLBrYzEnKUrWb0G76qfsg9ydOyuIzD4gsBmqVWRL/iV+smRHLWC31EyRE9sSbG9POl8+OgyE8+1RqyArS/8E4WgSDU/i1srODLgZNC9qmVTjlvlB4Y4RXeRSuIx1TWGmJJofpHTZkXQEGaUoHugUlZjGy9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTfhLCIBZ2tLwwt/6sSnwKfRgRw85hqSKV3Y0AVYIfw=;
 b=RjldsYQnVVoyWnxXKD/nDk41UDtkl0TJNs12XdMt9QGk2XI28d+yuouqxmVdo7xOrguXrqhbPgdTYSSFT+e9qypqdMiN3xRAo4CBVchfFjSPTy3JSL7k2yZ3iC/UzHtb0MgixhOibx8M0MjAjzXwJjyTkrp7Kpv8QSCRgmNtLRawJ/s5NApriyqOlL0Rv60cJeREzFAjST67vZq6Ksd7JQOt677gY/QyvXL05nJGVIIUokl55jcLZEvFM3GmZ1xWXcMJyLwsP/vXCR9ezq7P30kz/RL2KOng8q2g+Iu3ctFaW/cyPkHqz1IJhJVVZbfz/tZg2PkBGHkdNzrj8DGLLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTfhLCIBZ2tLwwt/6sSnwKfRgRw85hqSKV3Y0AVYIfw=;
 b=KLCkVircJxuzWHZknZWzUnDw7cJmYxcI48T0Okk9Lc1ifACg93LV2nrFeJ7iBDom5DI5MAfFFaJjN8PpWkrzjA+Z1N3YWhyLhr+35pCHpTUEvHWik9GJ3ZtybE5nHGBh98E6DZmXAsSQutIBlmGtErgF4/wQkOsLoxlIf6BYZrQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8853.eurprd04.prod.outlook.com (2603:10a6:10:2e0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 18:49:20 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 18:49:20 +0000
Date: Mon, 22 Apr 2024 14:49:12 -0400
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] arm64: dts: imx8dxl-evk: add audio nodes
Message-ID: <ZiaxKIy3LAx2C7zq@lizhi-Precision-Tower-5810>
References: <20240422-b4-dts_dxl_audio-v3-0-5017511f399e@nxp.com>
 <20240422-b4-dts_dxl_audio-v3-3-5017511f399e@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422-b4-dts_dxl_audio-v3-3-5017511f399e@nxp.com>
X-ClientProxiedBy: SJ0PR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8853:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e177931-b12e-4e88-1d0a-08dc62fcebcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?02RUAZIL4VB+Cf/1oaPueQauByDecsuLp58xkAa1HjgHuWoFLGWHwazN7g93?=
 =?us-ascii?Q?yBdrngCOGwLt4hJy1v7lOx8AfpykuryIFyKvdh8FLXcKp/yUPpRBlthEJ5DL?=
 =?us-ascii?Q?MRZoMEHYeA60xI0CfjIlL2ekvF2bm1Gv+XxrhWYLs0vGTWqCknnyziocJBdr?=
 =?us-ascii?Q?TSPZ2YKHrj1YToFtQvLd2Xu89usAwJu2KjTA6hO6sFOcs9nPMCW3P0iElu12?=
 =?us-ascii?Q?XPTynagIDyVdXacePt83eW5POjmnXWiJToOacSrqzp/iSAF28YzCXyhlNaK0?=
 =?us-ascii?Q?RI7dED/N35dIFnHvQfp7Fk6pfhzSnt/cR/kkSwDstQ6QHIyNXW1eLaD99S0o?=
 =?us-ascii?Q?1DTmPAhk/YjnsYsA9apYL3pCRSlslvKIj2dG/jNC0NH5gdxIFc7Bx6T0J58X?=
 =?us-ascii?Q?9mlLEJQQ9bBTYvTbQ2UqF+ihOUS4bA9yT0uzSnY3T7NnBN3iOvcrhRceerGY?=
 =?us-ascii?Q?EOE5a4doYEBFXOMFfhi/jDL5krzOm0y4ZoSzo6lQ+ZtAc0lQXO8wcFEWOvIu?=
 =?us-ascii?Q?litvEdFYekElO6LRYNaX3+FSz5fh/PfIqkXwVDNYuZzw0qSCcmq/SJDutNez?=
 =?us-ascii?Q?wVdIa78K3lbBtslr4rDXaemyCGuYQC2+ar2/tx0/DlspIzAhXxOm6/jcmi4o?=
 =?us-ascii?Q?Eh1nOu051bdSsHMeNT5YppHIQA+SizpUISyFw41LrGUhww4WR2PaUYtsgaBO?=
 =?us-ascii?Q?G9OuGUONc5lxB6GJKC2He3raNa9AxoRFQSyGsPDUGrOoyHqKTdqIbY3akMG+?=
 =?us-ascii?Q?oaNlhjri9eRGzBuUP5jGGSSMo3XzwnhQNNLXzQ9O9OfpIJ3ifYfutV3Wukxk?=
 =?us-ascii?Q?wo1DAcX7j54nrVdEAhFR7yemcOTgXpvZb59lSjo1dTbdCs5LrIpCJXjIGma8?=
 =?us-ascii?Q?vPDPyRwHz0O5o6fMrOsZS4JMQOIoMpcWvqSG/2nVnTe7iC/eY0F5UqcUyK/r?=
 =?us-ascii?Q?4n/rYJmyzhSopKwxhoFJcZHKV4fy3OZEMi1sLc9+9w9kqYNf0ZDiqR9YaArf?=
 =?us-ascii?Q?PIu8d8jo43Uaz7FV5e4jViZujrp3lHnTGcZmL+eQ+kzQz1FKKwk1MDGpmXf8?=
 =?us-ascii?Q?OkEEvwwFLCSMvf7YGkxyDM71B4b+JxwVChOe+pLnC7o4l/lQy0XBz83byo+d?=
 =?us-ascii?Q?fKsV12JjxzdkLHL7r4lz7SXpkX5K7Vpzc/bjmRG76GvqD8ypTSf+vibScVKZ?=
 =?us-ascii?Q?usaGcU6nyCB/AH1/HBJq3BZOIQL4Rm4QCs0DumOC78VZRBtVd/rsLOFbHHYQ?=
 =?us-ascii?Q?dlwjl0Q/HiVsQdf/Lwi2yxlGH1wglXZYo5fZJbvbggPG+3bgMdRj7iTIkFCJ?=
 =?us-ascii?Q?D3MigvyV+bgpvkQFCii/wlWfU9ANVW4BozGEbuwHTH3pBw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(7416005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?96YFcKqr6J56cwzxcY6Ko7S/sz9axguJ2tbhxrnn/8jjzztqAIErZd2pcPVm?=
 =?us-ascii?Q?v7poZfD1I4Mo2c67xsgbxbd9mq7H9+oz1VIzK/ZDBP9+B/T/kFh0c3//FcDP?=
 =?us-ascii?Q?53n+AwrLJV2BU01hZzvD0378byHlqqu3eN6dG1PoSV/q7UVyv5W3HXLvuMUV?=
 =?us-ascii?Q?xiFeyi8iF4NCjVPkseltUdzn/9v3YkK8zwWmRZQln3SiFu32zOEPXdoQsKGQ?=
 =?us-ascii?Q?5xF3NAdvnOQ6Y7ukVGdZ3l4u+CN74oHOAuCN4vwtc4d7A6v/J6wOhT7ke7t4?=
 =?us-ascii?Q?6vVudu2Sl8jeyK0xIBFmnDDtJMYC5WV2LGo+U0HUESY30rGruEY1JDhRBsK6?=
 =?us-ascii?Q?ncr3v2Z8bV1HSDHIlhr5AlGfQ2FIVV2z+7ame89otzcHQHUiYtwpl4fJnRSk?=
 =?us-ascii?Q?ZVbvGh7dviaVqDaqnz8QCEsTVuf5YtNQRu60v788ChjHlPBqaf/pJSw8bTEw?=
 =?us-ascii?Q?B0MWSdyvIa2Dg8a3lSdFjR5H28ksp18X/7d2rRmt2M8lXLC4HfcoFZ45f8hI?=
 =?us-ascii?Q?FWglL9uuYGkYMC/OhcQ234Jo9OKSYj9dsVPUZcoh3jorIRWGrSXQ7wWGKsw9?=
 =?us-ascii?Q?gB/9DEmPbnNvBtWh9zpTnAiIOAKFWACyPNfJNwEiyycEITv6YEx+yNKQawd6?=
 =?us-ascii?Q?bgVS54rrook69nGudhwMuY2e6hQ7Hh79dy1bE0V5gew618ME2Cwd6+mIvEbc?=
 =?us-ascii?Q?N80VHz09rElkP8Un74Q7uCnVUuInmewv6nLGNh/m/XP6YKHSf41FSI7M1NSt?=
 =?us-ascii?Q?T4ol7WZr25bWLtQnfsU6s+pozTG+BKiiHcYwicsbhrQiHPklnL7hoSBMzkCP?=
 =?us-ascii?Q?+/3Fl14bxgy2ieMF/Ntf+FNVa2vrSuRY1mclCD9dc5tYKDxG2VkZ4FCNaUH+?=
 =?us-ascii?Q?6wku7w4GeOYe7Zwa4RunvN3TsBheo7dGMwmBqkxt/3PfVLUaeFZWJEkLKMuH?=
 =?us-ascii?Q?D4QOEQxW9Ea/fSZkuYeY5fVJFqJOMoxvN27YBIbAwsPgSEDCNsRhuNTtVuWB?=
 =?us-ascii?Q?G7enO2D52svdbrEEMZB53xNnLkd3G3Okk3tFDHRtZGCWHeEpFqgqy/LhCsrp?=
 =?us-ascii?Q?IcqKHRq+DPTq6AFWD3Lha+UJ5HNL0oyDjaG1fXFOuF70Ii+xWlmpaX6CUS+Y?=
 =?us-ascii?Q?7SFK5EN7gCT14Ffxk1XqWKMmY5Nfb7kV4PPbkfcyS7evlMTO9k2N2/cF9rh6?=
 =?us-ascii?Q?1Vx8YJTXur5JGl5oNo8XDFxX2rzK+5UvufnItwQ7nIwUZ1LlSIsUlXnPRmZ8?=
 =?us-ascii?Q?oKR4ndsaQLVT4t6oSIB/5DSFFznBepz4P9LBGHiEVXyNCt3cB5pYcvYPOVNV?=
 =?us-ascii?Q?F+LUftym5xowKWocXlmhGR/ozHD7+E+Yo+k4dmU7jnazXCnhh69MQwT/wutp?=
 =?us-ascii?Q?NXxtFNgDVKLcsnjtKp+0++Z+Qvz+cPSi2I31AcEmSf+bnswX2fbCmoXclBFm?=
 =?us-ascii?Q?bWcWUf7Hhlp/dnZSdPRgE0k2w2iYYlTL1dZQ3pvsShMvXE3alxEYm4rGMmCP?=
 =?us-ascii?Q?2rsnA/FYLpJecV5wbsNtRR0jxcomlItckPEUUE1TW2reH73TN9UIf9E+CTF/?=
 =?us-ascii?Q?GhryNmNn0fcLyr72WwrtiPG0uMQmYjC7DIisIwoc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e177931-b12e-4e88-1d0a-08dc62fcebcb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 18:49:20.9198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YrjIq6T5QQYAshj5diNdj1QrhsxyfQP2N+2hyPoedXvC3HtDSLIgkS85124F6hVkvo0TihsC786PE0rTC11Ffg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8853

On Mon, Apr 22, 2024 at 02:44:54PM -0400, Frank Li wrote:
> Add audio nodes for imx8dxl-evk boards.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 231 ++++++++++++++++++++++++++
>  1 file changed, 231 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
> index 2123d431e0613..5b5a7b47217c3 100644
> --- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
> @@ -125,6 +125,78 @@ mii_select: regulator-4 {
>  		enable-active-high;
>  		regulator-always-on;
>  	};
> +
> +	bt_sco_codec: audio-codec-bt {
> +		compatible = "linux,bt-sco";
> +		#sound-dai-cells = <1>;
> +	};
> +
> +	sound-bt-sco {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "bt-sco-audio";
> +		simple-audio-card,format = "dsp_a";
> +		simple-audio-card,bitclock-inversion;
> +		simple-audio-card,frame-master = <&btcpu>;
> +		simple-audio-card,bitclock-master = <&btcpu>;
> +
> +		btcpu: simple-audio-card,cpu {
> +			sound-dai = <&sai0>;
> +			dai-tdm-slot-num = <2>;
> +			dai-tdm-slot-width = <16>;
> +		};
> +
> +		simple-audio-card,codec {
> +			sound-dai = <&bt_sco_codec 1>;
> +		};
> +	};
> +
> +	sound-wm8960-1 {
> +		compatible = "fsl,imx7d-evk-wm8960", "fsl,imx-audio-wm8960";
> +		model = "wm8960-audio";
> +		audio-cpu = <&sai1>;
> +		audio-codec = <&wm8960_1>;
> +		audio-asrc = <&asrc0>;
> +		audio-routing = "Headphone Jack", "HP_L",
> +				"Headphone Jack", "HP_R",
> +				"Ext Spk", "SPK_LP",
> +				"Ext Spk", "SPK_LN",
> +				"Ext Spk", "SPK_RP",
> +				"Ext Spk", "SPK_RN",
> +				"LINPUT1", "Mic Jack",
> +				"Mic Jack", "MICB";
> +	};
> +
> +	sound-wm8960-2 {
> +		compatible = "fsl,imx7d-evk-wm8960", "fsl,imx-audio-wm8960";
> +		model = "wm8960-audio-2";
> +		audio-cpu = <&sai2>;
> +		audio-codec = <&wm8960_2>;
> +		audio-routing =
> +			"Headphone Jack", "HP_L",
> +			"Headphone Jack", "HP_R",
> +			"Ext Spk", "SPK_LP",
> +			"Ext Spk", "SPK_LN",
> +			"Ext Spk", "SPK_RP",
> +			"Ext Spk", "SPK_RN",
> +			"LINPUT1", "Mic Jack",
> +			"Mic Jack", "MICB";

Sorry, I just change sound-wm8960-1 and forget change this one and
sound-wm8960-3, will fix it at next version.

Frank

> +	};
> +
> +	sound-wm8960-3 {
> +		compatible = "fsl,imx7d-evk-wm8960", "fsl,imx-audio-wm8960";
> +		model = "wm8960-audio-3";
> +		audio-cpu = <&sai3>;
> +		audio-codec = <&wm8960_3>;
> +		audio-routing =
> +			"Headphone Jack", "HP_L",
> +			"Headphone Jack", "HP_R",
> +			"Ext Spk", "SPK_LP",
> +			"Ext Spk", "SPK_LN",
> +			"Ext Spk", "SPK_RP",
> +			"Ext Spk", "SPK_RN",
> +			"LINPUT1", "Mic Jack",
> +			"Mic Jack", "MICB";
> +	};
>  };
>  
>  &adc0 {
> @@ -132,6 +204,11 @@ &adc0 {
>  	status = "okay";
>  };
>  
> +&asrc0 {
> +	fsl,asrc-rate = <48000>;
> +	status = "okay";
> +};
> +
>  &eqos {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_eqos>;
> @@ -259,6 +336,78 @@ max7322: gpio@68 {
>  			};
>  		};
>  
> +		i2c@1 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x1>;
> +
> +			wm8960_1: audio-codec@1a {
> +				compatible = "wlf,wm8960";
> +				reg = <0x1a>;
> +				clocks = <&mclkout1_lpcg IMX_LPCG_CLK_0>;
> +				clock-names = "mclk";
> +				assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
> +						  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
> +						  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
> +						  <&mclkout1_lpcg IMX_LPCG_CLK_0>;
> +				assigned-clock-rates = <786432000>,
> +						       <49152000>,
> +						       <12288000>,
> +						       <12288000>;
> +				wlf,shared-lrclk;
> +				wlf,hp-cfg = <2 2 3>;
> +				wlf,gpio-cfg = <1 3>;
> +			};
> +		};
> +
> +		i2c@2 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x2>;
> +
> +			wm8960_2: audio-codec@1a {
> +				compatible = "wlf,wm8960";
> +				reg = <0x1a>;
> +				clocks = <&mclkout1_lpcg IMX_LPCG_CLK_0>;
> +				clock-names = "mclk";
> +				assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
> +						  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
> +						  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
> +						  <&mclkout1_lpcg IMX_LPCG_CLK_0>;
> +				assigned-clock-rates = <786432000>,
> +						       <49152000>,
> +						       <12288000>,
> +						       <12288000>;
> +				wlf,shared-lrclk;
> +				wlf,hp-cfg = <2 2 3>;
> +				wlf,gpio-cfg = <1 3>;
> +			};
> +		};
> +
> +		i2c@3 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x3>;
> +
> +			wm8960_3: audio-codec@1a {
> +				compatible = "wlf,wm8960";
> +				reg = <0x1a>;
> +				clocks = <&mclkout1_lpcg IMX_LPCG_CLK_0>;
> +				clock-names = "mclk";
> +				assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
> +						  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
> +						  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
> +						  <&mclkout1_lpcg IMX_LPCG_CLK_0>;
> +				assigned-clock-rates = <786432000>,
> +						       <49152000>,
> +						       <12288000>,
> +						       <12288000>;
> +				wlf,shared-lrclk;
> +				wlf,hp-cfg = <2 2 3>;
> +				wlf,gpio-cfg = <1 3>;
> +			};
> +		};
> +
>  		i2c@4 {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> @@ -362,6 +511,53 @@ &lsio_gpio5 {
>  	status = "okay";
>  };
>  
> +&sai0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sai0>;
> +	#sound-dai-cells = <0>;
> +	assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
> +			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
> +			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
> +			  <&sai0_lpcg IMX_LPCG_CLK_0>;
> +	assigned-clock-rates = <786432000>, <49152000>, <12288000>, <49152000>;
> +	status = "okay";
> +};
> +
> +&sai1 {
> +	assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
> +			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
> +			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
> +			  <&sai1_lpcg IMX_LPCG_CLK_0>;
> +	assigned-clock-rates = <786432000>, <49152000>, <12288000>, <49152000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sai1>;
> +	status = "okay";
> +};
> +
> +&sai2 {
> +	assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
> +			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
> +			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
> +			  <&sai2_lpcg IMX_LPCG_CLK_0>;
> +	assigned-clock-rates = <786432000>, <49152000>, <12288000>, <49152000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sai2>;
> +	fsl,sai-asynchronous;
> +	status = "okay";
> +};
> +
> +&sai3 {
> +	assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
> +			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
> +			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
> +			  <&sai3_lpcg IMX_LPCG_CLK_0>;
> +	assigned-clock-rates = <786432000>, <49152000>, <12288000>, <49152000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sai3>;
> +	fsl,sai-asynchronous;
> +	status = "okay";
> +};
> +
>  &thermal_zones {
>  	pmic-thermal {
>  		polling-delay-passive = <250>;
> @@ -595,6 +791,41 @@ IMX8DXL_UART0_TX_ADMA_UART0_TX		0x06000020
>  		>;
>  	};
>  
> +	pinctrl_sai0: sai0grp {
> +		fsl,pins = <
> +			IMX8DXL_SPI0_CS0_ADMA_SAI0_RXD		0x06000060
> +			IMX8DXL_SPI0_CS1_ADMA_SAI0_RXC		0x06000040
> +			IMX8DXL_SPI0_SCK_ADMA_SAI0_TXC		0x06000060
> +			IMX8DXL_SPI0_SDI_ADMA_SAI0_TXD		0x06000060
> +			IMX8DXL_SPI0_SDO_ADMA_SAI0_TXFS		0x06000040
> +		>;
> +	};
> +
> +	pinctrl_sai1: sai1grp {
> +		fsl,pins = <
> +			IMX8DXL_FLEXCAN0_RX_ADMA_SAI1_TXC	0x06000040
> +			IMX8DXL_FLEXCAN0_TX_ADMA_SAI1_TXFS	0x06000040
> +			IMX8DXL_FLEXCAN1_RX_ADMA_SAI1_TXD	0x06000060
> +			IMX8DXL_FLEXCAN1_TX_ADMA_SAI1_RXD	0x06000060
> +		>;
> +	};
> +
> +	pinctrl_sai2: sai2grp {
> +		fsl,pins = <
> +			IMX8DXL_SNVS_TAMPER_OUT3_ADMA_SAI2_RXC	0x06000040
> +			IMX8DXL_SNVS_TAMPER_IN0_ADMA_SAI2_RXFS	0x06000040
> +			IMX8DXL_SNVS_TAMPER_OUT4_ADMA_SAI2_RXD	0x06000060
> +		>;
> +	};
> +
> +	pinctrl_sai3: sai3grp {
> +		fsl,pins = <
> +			IMX8DXL_SNVS_TAMPER_IN1_ADMA_SAI3_RXC	0x06000040
> +			IMX8DXL_SNVS_TAMPER_IN3_ADMA_SAI3_RXFS	0x06000040
> +			IMX8DXL_SNVS_TAMPER_IN2_ADMA_SAI3_RXD	0x06000060
> +		>;
> +	};
> +
>  	pinctrl_usdhc1: usdhc1grp {
>  		fsl,pins = <
>  			IMX8DXL_EMMC0_CLK_CONN_EMMC0_CLK	0x06000041
> 
> -- 
> 2.34.1
> 

