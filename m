Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3802978464C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 17:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237409AbjHVPyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 11:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbjHVPyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:54:16 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD9BCF8;
        Tue, 22 Aug 2023 08:54:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKVpOou/cPnQiTxSLgY9scOjv7jnSCC4JNYfCTMqYAxP77fA20swIYgTz27D8INi9KE7PR315dfddvTvk3cyEmi/og4XVt66s2BfSapUbKqZ41wCakwSQzKQUFjoHzTKyLBSgLm8QL2uJuqBPhPZHB6ofsXjsf458+adzOEIaizR56+AWpGjXAbrIcyEJaU7pVwzALoJ/psAq7GiemI/V4D5zUvfdn+1Cu+cKS6/N1yJ+Fz7m3pHWM2sUu5n8Z05bqT8tyC8WNWXi40OVYCNWl8NhQinPMqgwc+IJ0+RiFdM1OzPXOFumzInU21/WJ+hMYwnWHta94Mmz5sEAewMXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWJcHHCIlLzpvJoqnUnnYZqk7TeNz1B21bOVgvrlAO4=;
 b=YQtUmYp3jNRY9gRzzCkrzRijcRnBlBiI4lApzxGDT79wsRzdXVcCjBWz2Ni2bC0eMhnTdG8gSyl2kaAYDAAIO3PZVjKbMYXBScCAIegLUcBiFOK4EyAEnwKGucGCp+u8WSUlo4XTOG6KlAC2IDegXUeUNqLbKYSdpVxEXOSMaVH+iWgPFMKVsVpEKruiOrnI0MOOkiXUnm8kVO8W5wGclpSJjCd4iIGkTKlESZdVx0tj2YULiYlZJAgRJ+qEd+N92XEUJK/9/st2cSWNktltUuuzDLYoA8S7lklAHwWq0wyiHoSa+KcwwUi746f7QVDZER8Nn17iky/Q8h1ADa2zPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWJcHHCIlLzpvJoqnUnnYZqk7TeNz1B21bOVgvrlAO4=;
 b=XxeVyGgV6BkqOGCmhbpny+d2q6hvPDOGkIyDANJDOkuEc8h//4xcMadZKeydlhDbd6uCwXSdmVK2ODTPuoUlXSY+Znd45k1wlFHuS7z29VYJtuQYBnhrKi7+cLrgLGz6/CFyZ/+OxyH5VGdyPR1q2a/P/nmiBmU96ZZTa4xNqGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PR3PR04MB7322.eurprd04.prod.outlook.com (2603:10a6:102:8e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 15:54:08 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 15:54:08 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, shawnguo@kernel.org, joy.zou@nxp.com,
        shenwei.wang@nxp.com, sherry.sun@nxp.com
Cc:     clin@suse.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
        eagle.zhou@nxp.com, festevam@gmail.com, imx@lists.linux.dev,
        kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        pierre.gondois@arm.com, robh+dt@kernel.org, s.hauer@pengutronix.de
Subject: [PATCH 3/5] arm64: dts: imx8: Add edma for uart[1..3]
Date:   Tue, 22 Aug 2023 11:53:31 -0400
Message-Id: <20230822155333.2261262-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822155333.2261262-1-Frank.Li@nxp.com>
References: <20230822155333.2261262-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0231.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::26) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PR3PR04MB7322:EE_
X-MS-Office365-Filtering-Correlation-Id: b5264f49-e06f-4a1a-5ec1-08dba3280527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gy3q9mQw8wWxmuCPCF0xIHJQrtAYHR5Zpd02BusyrFwXkxOtKCgUu7EujwdIC9+Sk+6gz1UB4udTcGU5ulKOpi9e2fbC7chGBxhij7QnEOHskqsak7bXgQ3jodhI3JmUW9nnvQ7Xr7naJW0gkR/HjKfuI5C4mGhs7L61C2G01GmUGRgwsbHPmC8EZwTUs/ix9FuHDUE5PkbFbb956Eu+B1imaVzhHT87uAIPgNbcTlFlyxCuC4JbTDe4L2ZWMeabXgeO70Jdz/pJxJGWib/u6gc+Z86dQo7InYoSsCilMlLh5Y84WK6XfxwliIGCEhRgAo+RO1hHadgoM3JMa9kLUOoWUmVNEWymg3MbojLRSGPHPEjs0VRwUGSRg7c7rU5W388PGYsBYpM3p9u5HNOaTPSY68rSz7ChcHVy8iVPI5fRUMCPYyVBTIEfbvKnIvj6L+UFUAsO/iLFav3JVbY96Ca9U3M5POppt+bTF4bVMwzJ9sOP6N0RvnxDBsZWBZ9zt6cfrSFLW9RJpQX1eKnBH3IFjtqDs+Hs+G3uny6K7diStmVj6/ILF64xa0TH5GACCLYOt4rm6n+fj1HuQhDNWUI5CJHhLr4vTY78gOBM5o0EkoX6soPqPGgQkVBg+nnvfLxowd2PhZArPb6BxiwXPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199024)(186009)(1800799009)(2906002)(7416002)(38350700002)(52116002)(6486002)(38100700002)(6506007)(83380400001)(5660300002)(86362001)(26005)(8936002)(2616005)(4326008)(66946007)(316002)(66476007)(66556008)(6512007)(6636002)(478600001)(8676002)(6666004)(41300700001)(36756003)(1076003)(101420200003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7DsDsstPK/RIeit+rJtEsWmgay8Zi/zncB4h4isUlhEt21vn2m8wz525W6iR?=
 =?us-ascii?Q?8oL4szjFAPpWt3oQNFUezbWVGiqIr3InMVbKPsohjuas7Iad9Io392Qed+9y?=
 =?us-ascii?Q?Y24QMDvagbUBeHyhRHN20K++JGqzFniPiFY+o1izPoQPo2PSODiXkm2s2VCU?=
 =?us-ascii?Q?jPeXLOM2aWjI5PwT2Lrn4I5EAvB0jYbxPHApU8g2zzsTWuhwynv7UoIxn5vt?=
 =?us-ascii?Q?ZQ3OEzwZASI/GGUI//34qtFNs8fbmcvjqLdCFBmT2QNBFi7mNjlm2cJFqdQc?=
 =?us-ascii?Q?E9bwrMysDDfohwiiGxF6thPX4sQj+GK0UFDFbpjGrniCG2JVDjj3ntcs2oB3?=
 =?us-ascii?Q?4aSkdCLdgTekKKs8okVu7CpZrrdfQheT2xPY1kkTrpJKf5hxnrRtKJui2bZx?=
 =?us-ascii?Q?9i0jpQVQ8YoPGDftG3YEozzcMMaAzf6ZFOGjZmkKwLMrL3zbMpxquFdHZSP9?=
 =?us-ascii?Q?pJ1OlCIQ10XFYwuGPjru1DlZ9yVkJn8Zd7uiWcXsFAr35ZRI5P8xjxMdG9Z/?=
 =?us-ascii?Q?H7wFLMKz6JGTHmrLvzwHd9RG9xDxERKtRh86s5mQi+7qdZ/PWvWlEW7b7bo9?=
 =?us-ascii?Q?Ad+qW7zpdZ+w5i6Y+B+zSp0/6VqLktOoq0haf/vKU4wd92sTlRqrKLtJ+Gy7?=
 =?us-ascii?Q?GfW54KsGSfAhnv/01fWQr5WzMHWGx632enFEjqVhYd1rEZsi4RLtaqFRrpGL?=
 =?us-ascii?Q?XaTkrbeX36PcQcSkQx0OjTHvBeex4fdzmqg2OdLni7HUGPlCn3tRkJVDi+ck?=
 =?us-ascii?Q?HDZjUnoK+4A6pIJhpTH9cwK9002QnL5T4Bxb/x86ce5xmxUSmJAqYNXfii3O?=
 =?us-ascii?Q?XQwBMlslT//+l6lZt0ACC61N/JHbYsftns2MQBsUZgnaGPHVNYgBepfk52GO?=
 =?us-ascii?Q?ynXTU2WdeadyD4LfRmMsR2T58A87wAvXBqXq/kjtuvkCsZrkEBBudOL6FvdI?=
 =?us-ascii?Q?5DEI7fQ076kb20dMNSs73Iz+loKaVI08O++pdxpPe+d0qlCsDUSha/Q87HKC?=
 =?us-ascii?Q?GAVMSKGWZo44382KpDN7T/n+bzLr27z89VIHZzu4zb0AqB6sg1E94s1fZvwy?=
 =?us-ascii?Q?8mcwBXkDVDsB+UvczUtTbWNhNyouxAA/zi/YfsMNewiMjzchlrU8PwV93Iai?=
 =?us-ascii?Q?LRgnTkQ/2GiBYxpknEikguTILAMDEosGgx0oZ0ky+kJyo+kw3iXsdFHAO9ln?=
 =?us-ascii?Q?wMpu1DylWPNIdL6LceUQ53H+SnL0bTKaJDJ9c30JRasd/PcGIEO02SLGOqt0?=
 =?us-ascii?Q?M+lLOyRjJMcZa3fwjfCrkSmv/aWyCcVJlzP7Tp8GH0gg0X79Y6GUGKi6axOp?=
 =?us-ascii?Q?ag/8gtzxFTgz0X1vxCMIdhRREFwM/8Ex2Ei0mPkklhuMG1pBYrHzUFr8CN8M?=
 =?us-ascii?Q?MUrIaVfnC2fPVL1hwsiUK7Tj48YNALUAjIYhpLUEAyd1FuyAH5VelNvP3Md2?=
 =?us-ascii?Q?zybWSGtJnuHZ2bhsOx0x0FZQxg2o8K4oGZ6l3mWUzB6CCgKOyvsdqPVzv9bt?=
 =?us-ascii?Q?1cea8R3wH7O9DflhJnJyafBEtfExvO4HYEesfGI7Vop2mnIYB+j5irFKyVkv?=
 =?us-ascii?Q?oaknAEKcWz/ttWBWKSfBvQ54qFp5dD+ee7slm4vY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5264f49-e06f-4a1a-5ec1-08dba3280527
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 15:54:08.6450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H8LcMntcIHI9cJ0I1SF4RFtwL2wQiUJcDYs38bCp0ixoNIJMc3WydxDTs7H5yigKew7LF2dn3UNTNXVGZA7Ivw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7322
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dma support uart[1..3].

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
index 76e4aaaf307f..92ed02e6048c 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
@@ -105,6 +105,8 @@ lpuart1: serial@5a070000 {
 		assigned-clocks = <&clk IMX_SC_R_UART_1 IMX_SC_PM_CLK_PER>;
 		assigned-clock-rates = <80000000>;
 		power-domains = <&pd IMX_SC_R_UART_1>;
+		dma-names = "tx","rx";
+		dmas = <&edma2 11 0 0>, <&edma2 10 0 1>;
 		status = "disabled";
 	};
 
@@ -117,6 +119,8 @@ lpuart2: serial@5a080000 {
 		assigned-clocks = <&clk IMX_SC_R_UART_2 IMX_SC_PM_CLK_PER>;
 		assigned-clock-rates = <80000000>;
 		power-domains = <&pd IMX_SC_R_UART_2>;
+		dma-names = "tx","rx";
+		dmas = <&edma2 13 0 0>, <&edma2 12 0 1>;
 		status = "disabled";
 	};
 
@@ -129,6 +133,8 @@ lpuart3: serial@5a090000 {
 		assigned-clocks = <&clk IMX_SC_R_UART_3 IMX_SC_PM_CLK_PER>;
 		assigned-clock-rates = <80000000>;
 		power-domains = <&pd IMX_SC_R_UART_3>;
+		dma-names = "tx","rx";
+		dmas = <&edma2 15 0 0>, <&edma2 14 0 1>;
 		status = "disabled";
 	};
 
-- 
2.34.1

