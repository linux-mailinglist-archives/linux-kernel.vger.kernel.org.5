Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B2D7E6E0D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 16:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343808AbjKIPva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 10:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234579AbjKIPv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 10:51:28 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2055.outbound.protection.outlook.com [40.107.247.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997471BD7;
        Thu,  9 Nov 2023 07:51:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtOSQh9A9BneofCz8v6pO1tLufTmgQ/Bz7LLw4TGtGUJS0iK+U62MOe2o3ifJBPmgX2A2fYfRNzK5zSEQdsDSgOKakpd+VmmUUvcvW3U0K3JGGWecEpsyhmHDggNe/w+vwaPBBtB7XBP5UaWAZYiCcGF8tH6WEyaC6mXtlM4PUriAF/ZChrTLM2k83U2YEcExkXEdZtjopg+gZZakLKwEKsspJmz+UKASmI84svT5v7zlyVFGcVXV6cmaSjBv9MiLlFvz0smPYXtiai6J6VORNaGbsjPzGZOlmmdZT3gMxAw7zzNEC6JFBQwC46It3ExJ9H4GwlevtLJNt+E0azmCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFFACPc5t80uex6CXSPHUI7DDVn4dUysbIN9+BVdNzk=;
 b=ntwYo719FmtA/CWhhTbwYiRV1bd1tCkGL3V/NX0oEi+LeIjmBuxGEWxQcPeFBRc/pBOFXY3lEVoT/PICBGe8V+Tit/0yatmM8iVA/4cCP8HLgxEVXbUh1FoRsZSKGsI0lWRbGuhDFn7A+GwNhG6VCioTnR1cC9UFctD8w3d83tc8CEmoMhn+Pq6BREuOZQAXb1PR5FZArj1jgqz21fyqRhy8iEHHWT7s/G0e1eyuEiIxAdSi7LkhJ3qPc2e0H4hZJTnvHjSh9qbC7YDkF4+iqsztE6MO+x/vmAAoDrCxv/3y5j6de1HMdc2v/kOxpL0Ce5rPxg1HXZRS/pwJeA4IHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFFACPc5t80uex6CXSPHUI7DDVn4dUysbIN9+BVdNzk=;
 b=piNG7yvmEl3NivrSmhvS4MNuOHfLOlbz1l2v6StAKsC7NrLpzFWtceZwHvKYWD7GnVVIDEh8VUWz5fQaqk6Qc8MZseHouUGEy9OO+Vyqz8m4rjgfqomMp7BPS4lGDYRBapMakkwc27T/J/iC9c0PyyOXVajQ/AjK2hFLTtSYrwE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM8PR04MB7827.eurprd04.prod.outlook.com (2603:10a6:20b:247::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.7; Thu, 9 Nov
 2023 15:51:24 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::55e7:3fd0:68f4:8885]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::55e7:3fd0:68f4:8885%4]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 15:51:23 +0000
Date:   Thu, 9 Nov 2023 10:51:13 -0500
From:   Frank Li <Frank.li@nxp.com>
To:     shawnguo@kernel.org
Cc:     alexander.stein@ew.tq-group.com, alexandre.belloni@bootlin.com,
        conor+dt@kernel.org, conor.culhane@silvaco.com, conor@kernel.org,
        devicetree@vger.kernel.org, festevam@gmail.com, haibo.chen@nxp.com,
        imx@lists.linux.dev, joe@perches.com, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-i3c@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com, ping.bai@nxp.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org,
        sherry.sun@nxp.com, xiaoning.wang@nxp.com
Subject: Re: [PATCH v2 2/2] arm64: dts: freescale: imx93: add i3c1 and i3c2
Message-ID: <ZUz/8fBWtnwdSW9w@lizhi-Precision-Tower-5810>
References: <20231017194657.3199749-1-Frank.Li@nxp.com>
 <20231017194657.3199749-2-Frank.Li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017194657.3199749-2-Frank.Li@nxp.com>
X-ClientProxiedBy: BYAPR11CA0060.namprd11.prod.outlook.com
 (2603:10b6:a03:80::37) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM8PR04MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: 11669db1-449b-49cd-48dd-08dbe13bb9a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: otKtvydhCGD8wY9NGBiBHkAqqc881t4IsAcfCW9GPVt1G3yvi3rbYwg8aoqZlhQxO/CZ9NFTORHplxumbQVGFBiH1Q61fwUhzoTK94ArjwjHsJ9kWL3m84tca1UM1JiBuWv43C7isBPvlH9XlHi8LsswIpxmMwbwMvqaQ+MWXMGj2BlX7IcWtcMSOSDBT5Hzd6bBhRcz63ncfCBK02plGhNn9cVF4aVPHWcsRHJc5yhfGTnpPkla7PGXJb/BaibZsrkeej/7FWEl/TEC+ctUOolR+7+iUiTzjmb9wggIc9s0GpcWDMc7pnIaNJRcvpJ3YzU2KCaapXg/iHQt+POLRlSkMjtLlrDR8sfnyl3CMUP7crsbxDgWuxdhfCXyh9zPhjWiPSQp0EtyEmx8QBLp5tmAcDbfZ9ntQYNUkQwObiSDDw9aEVTuL5cDtsvQJs+2UdHei5MdkL7UffCBf5Vt83sn6GB0ZG57LWpGefWoP+ryRzk+uQ2XeUq/TXW/F0pHSCA/txrISP28eoXegyzVM1NGaxVP8Wg2HXgFn9AKgDKoFu3QnXhFBwUvpFCstR83aq0YKqcG0m6okwyupKkqEWjNQtVQ1egFc81aOprIlI67JECZzIrNs/edZz+MfxzoCeCzeYWOoTM7B4NeVJEuKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(39860400002)(366004)(396003)(376002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6506007)(478600001)(6666004)(6486002)(9686003)(6512007)(26005)(41300700001)(2906002)(33716001)(8936002)(8676002)(4326008)(6916009)(66556008)(66946007)(66476007)(316002)(5660300002)(7416002)(38350700005)(86362001)(83380400001)(52116002)(38100700002)(138113003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f4njYIoZk28JNnUq0v2BmUNgG70c5vh5zTepeEEqFVO9kjsVEZwjMtZfDP86?=
 =?us-ascii?Q?Z6mzmkilMHxdia1cnhRO9+8/LWXVdoEasCXcWTls8xHJ3I9w/5r022cN5II6?=
 =?us-ascii?Q?+vHbe40PqZ63vb8V11DRpUNH7LPnLQIfntdFxcLOiZTSLI47OOL/xui+ExlK?=
 =?us-ascii?Q?L+2c5Op6k6TJ9+r9f31uWE4fdKgHPZ+cx+9Cg4eyk1HX8iYMLu0axXIUldwG?=
 =?us-ascii?Q?G8gbKTbBT7NNlWZWOjTTh77yOV96I0zla3shS0Smd0Xss+k33UKthVRXXH/t?=
 =?us-ascii?Q?GvvY+piAsHYjMPMWuOzyfdU5xILxccqOgUprtgfvBessL7EdZQL/3CBFy3Fk?=
 =?us-ascii?Q?STdWxXW8esrsmF37Q2lOTaKYwMY0dkQ8+PtpsHJz5m5jVvLojSePQf/JOjPY?=
 =?us-ascii?Q?/KCTTL6blEVf9vd6Hw1Qd+UNIJqhN5j7/fQrt8T+KYmz5EsOyc85DLlpvoMf?=
 =?us-ascii?Q?yvQwoBVE9lEeM/31F4ODfSVL9bV/J2PPdnJgfuDk2y2WB4r7qShxeIxU1Vj6?=
 =?us-ascii?Q?Cq1gURvWTOfiEhC1YZvP5hZ/H0oookCLOCvna5rJRfMkD+VItnAWKwFN610K?=
 =?us-ascii?Q?V+4WGEd8kiedwo64CUO0HdjXaWiTqUisSo15LCAQnLmVCdJ15W7KisLmRoXc?=
 =?us-ascii?Q?szDvNUKk/ZkVYf3WRHGgV4vgoVFIoMOkmYtn17b9py2lW6MmH62n+ydfI2fy?=
 =?us-ascii?Q?7c9dl3WyBb7RgtVBuxw4PWmqoqNjEvQ5sB3Ib3k5LOQlHA251bkPEob6tOzZ?=
 =?us-ascii?Q?dArLbPO7394fnbf7mdckFDz/lE5q6gg0gKMS6nfv9/9SYmeIGuMXDlU+0NNz?=
 =?us-ascii?Q?8x3BCgSv9F75CQbLpcrmr8X7ApTjQ2eev1KOPgeym5jQvo3CdpXH6ih+I/wn?=
 =?us-ascii?Q?2voV/y1Zxu7r2hL5s/FwwxqvKF2EYztO/fJfd1C49EIXXeSllkRTcvlsrT9s?=
 =?us-ascii?Q?7JPFc1NKso1k2n5TP0Mm87S0u5y1zMyZtN+s25zxGzPheW21kzM/aHIZCwsk?=
 =?us-ascii?Q?F3UpUUZ5sga0Y2kWepwQyChwQJ5k/FcbU8RT3WUPDTrySR0Blo0QEIxsdikt?=
 =?us-ascii?Q?87iODGGXOg3kC0V3LZMZYW07g6x+nZ4huG4Vwu5olUlKHc3RN8whNcdZlXSW?=
 =?us-ascii?Q?9ISxEDrcQResVqm3BbZueIvMOEGP75pRIVQ4gvkD46fYaS9AWXjCnlLIPN6Q?=
 =?us-ascii?Q?PLCsUnA4xhWUPUeX2j1NDIu+hJaC2sDBVBf/eEOhjuRWEROC9oaB4OOB7xZf?=
 =?us-ascii?Q?SIWvawQdHfmKSNE7qHM/k80pfn2Ui/Av72IxWmhlHfXX6jP2Ft7TadOi5SDa?=
 =?us-ascii?Q?r4i6+6X+7AJwiRnC9LW9mB62vQiKn+xoEm3nC0PNAGJr7MpNM3gjBLrnk568?=
 =?us-ascii?Q?VFh2DD5lqbMWVqL4hoyyYlrCJ7wQSCKH9rut1jKK3KZhB7puac2XzrsJB+EY?=
 =?us-ascii?Q?7d9ni4KXvcG8HegCNh1/qbLmxdPKva8FpbV81Dqr/giRvHTFJE6efj4iqFu6?=
 =?us-ascii?Q?rkLrxHloMPkrHQr3FAkmcwhAo5CeOTLnEXRSZvR94EL8a3qcczL5KlSPsop/?=
 =?us-ascii?Q?dPGO7cv+/I6LaBIBLAw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11669db1-449b-49cd-48dd-08dbe13bb9a4
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 15:51:23.8666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3wM6dT15VCBeX9tRA1tNvmg6DJU7+lm588/1uS0MauAYF5E2oGmfgoEDIKNHbsv0VAaduQaIGCQucCCeNUoSKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7827
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 03:46:57PM -0400, Frank Li wrote:
> Add I3C1 and I3C2.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

@Guo Shawn:

Driver part already merged. 

Please pick up dts part

Frank

> 
> Notes:
>     Change from v1 to v2
>     - using compatible string silvaco,i3c-master-v1
> 
>  arch/arm64/boot/dts/freescale/imx93.dtsi | 26 ++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
> index 6f85a05ee7e1a..c6ad9ba9eb9af 100644
> --- a/arch/arm64/boot/dts/freescale/imx93.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
> @@ -242,6 +242,19 @@ tpm2: pwm@44320000 {
>  				status = "disabled";
>  			};
>  
> +			i3c1: i3c-master@44330000 {
> +				compatible = "silvaco,i3c-master-v1";
> +				reg = <0x44330000 0x10000>;
> +				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <3>;
> +				#size-cells = <0>;
> +				clocks = <&clk IMX93_CLK_BUS_AON>,
> +					 <&clk IMX93_CLK_I3C1_GATE>,
> +					 <&clk IMX93_CLK_I3C1_SLOW>;
> +				clock-names = "pclk", "fast_clk", "slow_clk";
> +				status = "disabled";
> +			};
> +
>  			lpi2c1: i2c@44340000 {
>  				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
>  				reg = <0x44340000 0x10000>;
> @@ -496,6 +509,19 @@ tpm6: pwm@42510000 {
>  				status = "disabled";
>  			};
>  
> +			i3c2: i3c-master@42520000 {
> +				compatible = "silvaco,i3c-master-v1";
> +				reg = <0x42520000 0x10000>;
> +				interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <3>;
> +				#size-cells = <0>;
> +				clocks = <&clk IMX93_CLK_BUS_WAKEUP>,
> +					 <&clk IMX93_CLK_I3C2_GATE>,
> +					 <&clk IMX93_CLK_I3C2_SLOW>;
> +				clock-names = "pclk", "fast_clk", "slow_clk";
> +				status = "disabled";
> +			};
> +
>  			lpi2c3: i2c@42530000 {
>  				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
>  				reg = <0x42530000 0x10000>;
> -- 
> 2.34.1
> 
