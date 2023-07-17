Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457D07565EB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjGQOLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjGQOLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:11:40 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2059.outbound.protection.outlook.com [40.107.6.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E62D1;
        Mon, 17 Jul 2023 07:11:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0ZsR4ikWM3hPa8zxNivXbjO30bkHGDg0ll+xsGr9Sshb8anK39F54AKPfARc0yLySIzQeYDAk2QSVK5bsr8LaWK5/Zb2sdPJRAEktWZhpbYdxezSvKZ4qtK4J/CxGum0qL3IzRXg8Zkny0J/+JYxHusmWimH06z53DMkhVMmVYCPV3yeqEk9APX3PVqkNHV6ymadFYqLAAlp3JMaS3Tr17j48gfE2TrvsJEgwC1DuI0IxfmGUH/D85xEU+p5z+uKrkOdvrcZWDTlFmfyuIMEXU5wYlE1RdwvgQNPN8UKmLtWh+xzcPuURXlTG0STPbRT6MFNyVMyQ9AwADTVvoK9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UoX2QODrX61kcO/6Dd27KIGWx9kbL/02+7CQqI7Rr4Q=;
 b=fyJ/XWmaqbxHzDzgziz6V3QM13OZaPmopM1Grl6WEwuEggzz0tu/QDxFPX9vmT6bjrlJtVKJPZ8CByznn0JEzKKPXmF6u7bHdBHJVhmYHYL4OT/0oOS1+hSeLxc15kYrOpybh1EUn5luchi9wOjpoeLvkmQSu2dqh8dXe3EoCGOGU8TrV75yNuNe6nWArCNz91weA84zaLM7puNUTUkvZARaHiRf8x4cUzvxzr9pW3WsMIQBT9UJVNd2eTFsD4MPtUHeVJ29FJbDXU5VSha+Y4FAVBN8f/AVldM9SCyMlTgDRETCno+HjqP2YyWUyTh7htVx3luElh61nm3h9FG6vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UoX2QODrX61kcO/6Dd27KIGWx9kbL/02+7CQqI7Rr4Q=;
 b=EqnZ7ydFQoTBZrlJh/Wu7UTcrHn/18b5VsSCR6RcQh/uhTJMpdI5jIIiLX6wZs75KUCs8cje4iMCLXqa70zUXL0UySTmSiFJTdPtF2XJcCWIH/yjqlGM0GLg+/Ndie6PuIruII6ucZsZFNeEAlwPo08EvQGWjE7yE09vy4Fe0zo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU0PR04MB9419.eurprd04.prod.outlook.com (2603:10a6:10:35a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 14:11:36 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::6cc2:14b2:ca51:6c0]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::6cc2:14b2:ca51:6c0%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 14:11:36 +0000
Date:   Mon, 17 Jul 2023 10:11:22 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        imx@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Adam Ford <aford173@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] arm64: dts: imx8mp: remove arm,primecell-periphid at
 etm nodes
Message-ID: <ZLVMCpNWB1xCvQzM@lizhi-Precision-Tower-5810>
References: <20230705205954.4159781-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705205954.4159781-1-Frank.Li@nxp.com>
X-ClientProxiedBy: SJ0PR05CA0087.namprd05.prod.outlook.com
 (2603:10b6:a03:332::32) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU0PR04MB9419:EE_
X-MS-Office365-Filtering-Correlation-Id: d49218d9-8d11-4cf5-bbe2-08db86cfbb58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Kai7IchwqRs64pLrty3KX3LDwJuTXXUppNAubVVBrcmVQ/6iR3wViWlNaXeDu5TzzIg0ZVS1UC5QkdvL5mS0s8TFCHu5xB+0xUO1B+FM6hc8wSxxoaxpf+u4+8reVyLjeknSwublM8zIDsqYoIytP29Ulqr9LyfqlgDip0DBVvZnCxiyFJBm1E5YSoQ65Sm3aPrBHBCixQUK+1GDfcGdH6RgDzO1Uscuoglv6OXCnBePqb0bTtZT2OA5aiB3XGCTDgRkCS7yxx0RVPKryPQg21b5Lm2fu7QoT4mea7VOAZgbnN8Lm0oJ9IDm+WUNhA9WPZlltwC/QkuykvpDKrBGgICGnyrdCaY7XWCcoLSOuFcOMeEUEpvSW78Lx8cKktVI1kg+f+jSjItx5fQZqdttUADcbO7rx+OY2zWEcdu8VUl4xEGSmQItMnFa5KNax5WyT/jEN4dxU1HL+zd8mVHWqUHKw+Xv9a+6UEvTZV4GYMw9oVxD1jAZ3OX8yep8oLtmdOvDGYqARA3NFKa+zX/Gdquvt0gupgDK3+2f0j9RBkR+ximWKxssrn61HsPMajzzFuKbxaoZPRuSZpjq4EySubxE4mu8LPAUu7R6ZmLKK1iwBcS6fuAeQpAKpMtlFQwVtsuLHqrMGVedvEqmOghWbcvZIeZSOthizw6dfvgQ4o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199021)(6486002)(52116002)(6506007)(9686003)(26005)(6512007)(33716001)(83380400001)(38350700002)(86362001)(38100700002)(921005)(186003)(8676002)(8936002)(2906002)(41300700001)(478600001)(7416002)(316002)(5660300002)(66946007)(66476007)(66556008)(110136005)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u4dss/ZMlkuvUFpQZhWnN2aG8tPfIvoVrIR6RY7E1FwtTqR/+I2p2aRs2ZtF?=
 =?us-ascii?Q?ZitrsMQFHx7OqozhQKuu6TjmvY5T6iePfxuCBz2DlrttJHBdE2jnOjCoRkMc?=
 =?us-ascii?Q?ixjOrWHFRztoWE4/2J11DT8vFNtbG444zEiaTfscaBOHkaDkJ46azZXUkDik?=
 =?us-ascii?Q?QotBaJOIaZ2h+LyZsGyGF74SQpmWbgwT1u3QZMk6pF3v37hfYw6HcAmkbC0i?=
 =?us-ascii?Q?4vsP7ZlRw7K3yIU9Nq7iZSfDk5stbWQfDPtAjzLgcuSjWZe5wUyOTi3RBQ7D?=
 =?us-ascii?Q?+TFD71fv+0d2FdBud2I5hUZLJZy2NttTyeHqtnhCqdN1mX1f5fLZpg9gkOGM?=
 =?us-ascii?Q?yHeo16efoduXF34HrtZ+2axlj+Qm0JpLFtf2U5ZgyHn5n6kXWerKsGIJnFWr?=
 =?us-ascii?Q?vGXG/IoArK+Fd4h74pBWzHVY3XNDpr40egCju3pmVhhIYAvH4AA569Vt5JLC?=
 =?us-ascii?Q?zMobt5XybNBUF+csik6m6+39AT7Q5MlaPny6LWKm3uXKZslhKVzKH/zL2xOL?=
 =?us-ascii?Q?Qdd3/KWdYhSo9tbkgBif/DzRRCxDjKSCvoDwHrEyK3yIeQF/ZRd0Z+EkLHeM?=
 =?us-ascii?Q?sSyVcTx5hHQOLWXTd8vIO71u3NlTxxsq3Xl4WxaAxAFAHjpwrfa9bwCPUVt4?=
 =?us-ascii?Q?D4VCf984K+aZk3ILr19C32l78Jn60QnHnc9DBi07mEVvW+nt+KcXk3Vh/0o0?=
 =?us-ascii?Q?v2exG9fIsbtaArZhzPUU/tZWz56XoFA40WNAMCeJoGP0jjUUW/4zPJ7f6nm1?=
 =?us-ascii?Q?NC1BH9iBMrHBmZKY8WYO3rc9cLGuNCCCdHLe35KxlCBbnrXtchglUXPolOgo?=
 =?us-ascii?Q?4dj0FUrb7Z4TFaBJmSxeU/ndzFtZ8c60VQ5lr4iEGdNohoaawdsyjhLv6QQ3?=
 =?us-ascii?Q?a8Y5BRMow8m7/9x3l8UAf5YbI0B+UofDGGg4bVKIBZEUJhBtWwoFLwlOIbLA?=
 =?us-ascii?Q?0rSstVRovRSmyLC5KPGbaO/tzCBpy3PYAdtmlV3zH/fWKf+GkPsYZpp5RFpg?=
 =?us-ascii?Q?GFLeiXz/N3LGwKGHLNAwexjBSWC98dzZrXeAkPow/Y73zrhM3WyrhStuvskY?=
 =?us-ascii?Q?cE3LA2iB18W9N/qYIFsZKNtTIPXSW+y2Glo61o27aomfDazEBrmadE9+F0s1?=
 =?us-ascii?Q?BwVNxbARoEMFSBiBXBNJmMzCkWGiQwkDffxREULQ2noP7Lkhb6C/mlRwPzVP?=
 =?us-ascii?Q?+R67EOyztyHkMscPUwXLvxltt7wdv7ntwdhhZ890xG5uSZ6lCMQkyA0+AN2p?=
 =?us-ascii?Q?K0yktTXmvgs5gtTSeulelf071VVK9hYBNbar5NVobYOtMl1/oNhE5W4C1bAo?=
 =?us-ascii?Q?MXRIHA5rWlp4yFDzWxCQeL73A600BPim4E4Tj6Tewb+mjCDT0gBQn9Wh16Y8?=
 =?us-ascii?Q?R5dWlZcQ+9LI9h0CWmqj+rZ29xIpXj0ml6YiV2m5PuKVL4Su9XeIF0dvMTPD?=
 =?us-ascii?Q?iqhZqPQT3hv5Mn54/DHpYJlGeYrwvWOceKKBXdQxPFotIMv6hIjr7KMI4R1Q?=
 =?us-ascii?Q?EzEpaGTmrx3dpI7ABMNPhrDm2Hz0NbE5esl591n/tNuLuUWa7a/c3dbYBCB6?=
 =?us-ascii?Q?hWe6Nphf3aWf54TZ64QfD6GT3QqfTfL9dOZZqfW6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d49218d9-8d11-4cf5-bbe2-08db86cfbb58
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 14:11:36.3946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kyE0HN9ESch5lvQ6gQ9h0WwewbG+J3QRVKNyrEG5vdR8xZ0kbAHjtQQmI+8A+Pf+lNQTqx3iLGkOiAF8MiNPBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9419
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 04:59:53PM -0400, Frank Li wrote:
> The reg size of etm nodes is incorrectly set to 64k instead of 4k. This
> leads to a crash when calling amba_read_periphid().  After corrected reg
> size, amba_read_periphid() retrieve the correct periphid.
> arm,primecell-periphid were removed from the etm nodes.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

@shawn:
	Acutally the all comments is clear. No further change needed.

Frank

>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index cc406bb338fe..e0ca82ff6f15 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -306,8 +306,7 @@ soc: soc@0 {
>  
>  		etm0: etm@28440000 {
>  			compatible = "arm,coresight-etm4x", "arm,primecell";
> -			reg = <0x28440000 0x10000>;
> -			arm,primecell-periphid = <0xbb95d>;
> +			reg = <0x28440000 0x1000>;
>  			cpu = <&A53_0>;
>  			clocks = <&clk IMX8MP_CLK_MAIN_AXI>;
>  			clock-names = "apb_pclk";
> @@ -323,8 +322,7 @@ etm0_out_port: endpoint {
>  
>  		etm1: etm@28540000 {
>  			compatible = "arm,coresight-etm4x", "arm,primecell";
> -			reg = <0x28540000 0x10000>;
> -			arm,primecell-periphid = <0xbb95d>;
> +			reg = <0x28540000 0x1000>;
>  			cpu = <&A53_1>;
>  			clocks = <&clk IMX8MP_CLK_MAIN_AXI>;
>  			clock-names = "apb_pclk";
> @@ -340,8 +338,7 @@ etm1_out_port: endpoint {
>  
>  		etm2: etm@28640000 {
>  			compatible = "arm,coresight-etm4x", "arm,primecell";
> -			reg = <0x28640000 0x10000>;
> -			arm,primecell-periphid = <0xbb95d>;
> +			reg = <0x28640000 0x1000>;
>  			cpu = <&A53_2>;
>  			clocks = <&clk IMX8MP_CLK_MAIN_AXI>;
>  			clock-names = "apb_pclk";
> @@ -357,8 +354,7 @@ etm2_out_port: endpoint {
>  
>  		etm3: etm@28740000 {
>  			compatible = "arm,coresight-etm4x", "arm,primecell";
> -			reg = <0x28740000 0x10000>;
> -			arm,primecell-periphid = <0xbb95d>;
> +			reg = <0x28740000 0x1000>;
>  			cpu = <&A53_3>;
>  			clocks = <&clk IMX8MP_CLK_MAIN_AXI>;
>  			clock-names = "apb_pclk";
> -- 
> 2.34.1
> 
