Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17E679C1D0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 03:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235536AbjILBnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 21:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236118AbjILBnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 21:43:15 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2079.outbound.protection.outlook.com [40.107.105.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FC3184441;
        Mon, 11 Sep 2023 18:19:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyrSLZ2f4LUKlV8ph8lH/du4H2GPdfIK9Y+F8x2qXl5F0JqvOLa0ESiOI9pj53FHha+U1qjhFpMvGmmkeALzXLptXF5eiQLg70dskjytZjhli+qqFwxx7WXswSBvC0ksI3ynicC7QWDNsbOLDP913Mvd1sSbLL6YwvI4AgkuZTsYRlQdOryC+n8aC3Fvo8H8GDo+kqVVdama5WQZxnRBVmDQrYnl85E0loAhhh9Dr+YXs1uVnY/2sM6GwjVtLxQe9u9jUY6RkMoiZr5/jul4YUURAGGuiuWZSv8mAP6hEQWjIVX/L3WWb0wEroRtXACJV6ozyD9ovoL+XPnkFsrXag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Ki8/sXqreC+2zRFfvdl3VjIOQVNkHugK+w91ZpOhYk=;
 b=l03Ot5rJqecrYg1JVCIw3VJHiQI+tAmunCvTX+yTKLuwrQbn4aVGOngwCE+ahxjRjRtEeOJW4bEkOSUvqhUfvR+eGpikT2Uyv9NUPJEtC0i6CUhwfeAJGS1pQ4cFPdfzuiTWXC5bWaVDMtx0mLKzDlgjgeDi9WwhonjHoAeOFMFLsFu1x6rOPaMjzr1ZibbZut7DU/1iP7KdNdr8TmjSrgOGi0JtYuqUjZARCg8KZ2FiBhInZWEkkEeph3O6hn1k6j1vZokrt2z0fyWsMFJRqvq4ChmrT6RUtQfQOJf1DLwu73+e5+Fyr4MKumyy0iQwst8Jph4Yx1Xj9tZKNkyL2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Ki8/sXqreC+2zRFfvdl3VjIOQVNkHugK+w91ZpOhYk=;
 b=DcxoU2uPcXnYSLQCs0RXl++Y0WraafTT4iC0xDDjtu9JKoECdH4v1rcUDRZvlnLxhChRGMqiq2euLwVqaz4w/0d6olop9Spwa4Vch/gzCJ0YTUaFYxe3qC4r/IDptMC1I/z9RwRmkOz/9CxHkzl6AVNCDKHTOWMzHyAue82Yz24=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
 by VE1PR04MB7310.eurprd04.prod.outlook.com (2603:10a6:800:1a2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Mon, 11 Sep
 2023 22:45:31 +0000
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::ad2:49f8:14b:25c7]) by DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::ad2:49f8:14b:25c7%7]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 22:45:30 +0000
From:   "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mpuaudiosw <Mpuaudiosw@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     linux-imx <linux-imx@nxp.com>, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        LnxRevLi <LnxRevLi@nxp.com>
Subject: [PATCH 2/2] arm64: dts: imx8mp: add reserve-memory nodes for DSP
Date:   Tue, 12 Sep 2023 01:44:52 +0300
Message-Id: <20230911224452.15739-3-iuliana.prodan@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230911224452.15739-1-iuliana.prodan@oss.nxp.com>
References: <20230911224452.15739-1-iuliana.prodan@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0012.eurprd05.prod.outlook.com (2603:10a6:205::25)
 To DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8774:EE_|VE1PR04MB7310:EE_
X-MS-Office365-Filtering-Correlation-Id: fbddd0da-b626-49d4-cfce-08dbb318cd31
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gsLtTqEg1fixbUoaeGGQacuOGn1EbwAE1j2fSCoRXvIAFPGdkpkncM29IcXaRyoAfvAjSbyowgb5AlahDFMB6s1v6S8utOlZN/Qulvd6ENzegETnBrpIShrr9+K/k585uQNC48JKlsrHICLHsqLxcjh6pzeWKwnBw0+E3CBf0+tTlAP3/9pjug91jeVuXCiJ4ENyjYJGuFtwIjslXtrGpa+JObaMPsU639bfm2wzURcTySo9Y9WnXyBrhrJp16/IyDGg10a/x3hegs7rRQ2r0V5cQEBGdLzvO50SP222pSTzGaZTpf2QqiqLgU0tZz12BFZ1Q5iO+a2fnhBGABBOLMz31Ww9sGXd6VXX/Rnw/WuLAQT4mrqhnZfgqxBXehqPoG7/9qoWJEB6Acx1wJvr+v6UV9Scso0DzujZ/3SgNR7qFuculHmrpse+OYLaxrJkpwxj+gkQLJ2thXI6s9urHQhW1dWWBRf0kdbnKwbWDp66KCNA/LCg3iwGj8jf5Hp2D6DIlBIh5Xjl8lAEnk8TjQeT4ilO3B3XViJBh1pe8cdW1b7fqHFpjiwKam3feKYV0/Yu8SuWLkP1gk7edBhK+M4amVb4stHH3EsV+UfsVGEzAPfL9C0SH97DPDqlCBMkXgJUvU4b1YuivrXfQ8pPTP/HkXkFgefM9tF4+wQCBNw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8774.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199024)(186009)(1800799009)(6506007)(6486002)(52116002)(6512007)(6666004)(921005)(86362001)(38100700002)(38350700002)(2616005)(1076003)(26005)(316002)(7416002)(41300700001)(66556008)(66946007)(66476007)(54906003)(4326008)(8936002)(8676002)(110136005)(478600001)(5660300002)(2906002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nz9vH80WUt6ZVsjqDZDpluLEf/vYQnDNyeb+xdOhQLhzPtWwmHzLbfKmPeHj?=
 =?us-ascii?Q?Aoba+p8UJ+uJxCyeolpK5ku75bRCBrC2u8W6kvRjKqvhk0An/ZK8hH8HF/yA?=
 =?us-ascii?Q?vMly3mDIOSPeELFhlNadhBNNapkGQJziRX5Ws4kusOPeX/jwupcDC0QJMxIz?=
 =?us-ascii?Q?yDFBdP83oLhKNJqX8Mk8nYvJhl8BD8ceerU/zTkGgnC88twLtnyr+zZy2wGw?=
 =?us-ascii?Q?3ChEDEiFuKAKJvlzlSgTmrM/SQ8ewmdSrxefal1nfPcfO6GwGv5dPu1Bh2zM?=
 =?us-ascii?Q?leKzjaHyz8qdvulBd69YbYglRZ6lbC9Bvekm81VcHw/2jaANn3VCKx2WYa9q?=
 =?us-ascii?Q?+6HyD11hVBFec3xWG/eHN1mJVgzIlA39Mspz4KVPUdrxtkzPBUnTr/WgWBzS?=
 =?us-ascii?Q?Y42QxTSWHJTX5z4pSEW/2oSGHIUXtQ8LpEQzgcsR7t62gmSMbVHi2G38Vyji?=
 =?us-ascii?Q?qUPCozVuaucXQeO6KJO2w3caGPw8aHbNW4FC8TNSFQOrpeShJk3u97zWEQxD?=
 =?us-ascii?Q?4ycc9I6tTOA+OBHrHJDBWJJDrMT/rx9OGD+PgkRgstk93LN8ywJxNQl9jDfK?=
 =?us-ascii?Q?fsYOn2B993cYEoF/6fBBw95X1Ts3kzSWI5mzag/FpWrXy5PE6sOhZUAYrYZx?=
 =?us-ascii?Q?idZmNfuhmiErNED/lYvGp1eep24qkFx0npS9+X/mQJgyWSo8zf++ckGm1ujI?=
 =?us-ascii?Q?I3PM+MlJgNOg1Ydl8caWNwQqqS2/KaFwkDbjSBcDSVLgERtgdXPDpX4ytx5Q?=
 =?us-ascii?Q?9s0+gAZJLwGkXVNhFD8P0B6CnWTlwodbVolfe67dkGPCUyj6ndspUg4MZwkR?=
 =?us-ascii?Q?m1Zyqkn3m8LR5/5tkHkRfwCWJ0tedTPNbdLyeesQPLtVngeYXQkR8BDgRgIh?=
 =?us-ascii?Q?mvxduCH+VEgrVhTo8TdnDy5e7fEhyjjLxTd+lUICBqQIGWNx4VLsxY2s/Red?=
 =?us-ascii?Q?W1P+xkPLDjiKzsii07sDTsRD5zOQjZfezdDHGonZJIydq0XqKLAejt8UJ1gV?=
 =?us-ascii?Q?nWozBotfllA4C3u/Ji0UW9PDfHDvGyaT4tc/jDRaWv6nTpCxbsHm8eBXZeDL?=
 =?us-ascii?Q?cIBhviq8E9FxdjNOiNhhzQyo9KuNcRr0RYeP8gFyqZbgxjDFuvRqFqLNMtiE?=
 =?us-ascii?Q?H3lec0KcpROMo4wFJrhENFEONuaDa4C6FX6fM0cA2Bl0b4lZI0XnJ/YHXe8Y?=
 =?us-ascii?Q?2pldF3wN6O0Jdv0/QUpwwAXufO4wMK+0XuKM8xP8JZLOm7Vweys0GruhN/kE?=
 =?us-ascii?Q?B069V4ren2nVWeH5NjHaVv8Ie0to76ImgDnVTz/tyL9AdVbkF6PipC1XmiIo?=
 =?us-ascii?Q?pEV94HclGxPjL1/0ST6caUQ6MOwir8c4FfwVVKE/dVVjF0jngCloKgI3EFFF?=
 =?us-ascii?Q?S7lF4mEZhR/xJJWI5HdMEzUNQKkdhevYXHyS5VZOeKhM2TPRsbEQMUusaGZu?=
 =?us-ascii?Q?huLEREikz2PXrcdVR075/fvxagH3rorhdOVh8DGN+AHlODjS1i7owL6x4fbo?=
 =?us-ascii?Q?xZD5xfGj8drWWDDF1Xy/t9canUG7xIPFK8HIe2YdPkKdYf6j8hZc18YmT0Co?=
 =?us-ascii?Q?+enw85+cZQ2CT62i6RBsvgkHQDvTGjUY+/av/xrgp4eYlId03Z12Ss4fsCqR?=
 =?us-ascii?Q?OA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbddd0da-b626-49d4-cfce-08dbb318cd31
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8774.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 22:45:30.8399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KZY0liBpdN8mNdexybfCqpHjXvxzS4957UymEmVWA3qWNhWwDLYYtI/n6IGJBjMzecYYy2JJyvmp6ehfTps/6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7310
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Iuliana Prodan <iuliana.prodan@nxp.com>

Add the reserve-memory nodes used by DSP when the rpmsg
feature is enabled.
These can be later used in a dsp node, like:
dsp: dsp@3b6e8000 {
	compatible = "fsl,imx8mp-dsp";
	reg = <0x3b6e8000 0x88000>;
	mbox-names = "tx0", "rx0", "rxdb0";
	mboxes = <&mu2 2 0>, <&mu2 2 1>,
		<&mu2 3 0>, <&mu2 3 1>;
	memory-region = <&dsp_vdev0buffer>, <&dsp_vdev0vring0>,
		<&dsp_vdev0vring1>, <&dsp_reserved>;
	status = "okay";
};

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index cc406bb338fe..eedc1921af62 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -210,6 +210,18 @@
 		dsp_reserved: dsp@92400000 {
 			reg = <0 0x92400000 0 0x2000000>;
 			no-map;
+		dsp_vdev0vring0: vdev0vring0@942f0000 {
+			reg = <0 0x942f0000 0 0x8000>;
+			no-map;
+		};
+		dsp_vdev0vring1: vdev0vring1@942f8000 {
+			reg = <0 0x942f8000 0 0x8000>;
+			no-map;
+		};
+		dsp_vdev0buffer: vdev0buffer@94300000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x94300000 0 0x100000>;
+			no-map;
 		};
 	};
 
-- 
2.17.1

