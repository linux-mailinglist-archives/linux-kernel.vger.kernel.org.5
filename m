Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA307AFA43
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 07:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjI0Fpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 01:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjI0FpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 01:45:03 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2043.outbound.protection.outlook.com [40.107.8.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF78C7D86;
        Tue, 26 Sep 2023 19:33:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCTSHmXXx3N0v3F8CcnriTOhpLN55XAafUGnvDuHA4I0jwOPo3LVdmH07/1Tj0wmGQkclKPVx41yX0YBLCvTa5LbjP8SEXnkA/yxNYJ9VgwuXAmFIOSXmM02tL1PMYx3Rtbe+7hwYcYBmbRNzSDpsdsGf9iYcyxOhYYxcg9yTIk/T1X6yhP+Q0Ru7tFwsUkIsRc+AJaoGdr50weifPUUzJis5gEj6pMRVR8ksCLK0jDfJIVv9vBa6k2EOGrYDyMQpX/aOiglhCrKzCmjKkSAn2Okgj1Hu3d2QpzKaqEl8hm0dd4v1Ob6QdbAc0DQF7x/PpPdHkvwUwhEeibox5JN4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9FpLIN1RUmK4rm+I//sIZ6gM2u6MNHhFZYAVseBpx4=;
 b=Xq3mmocZYzOqB9HvVsOSJfpXyobiSzaXy8EGUOCBYzbgrNBRZUJwfhzgf3ETxkPGaJa3MZFXCDmENf1emfz8TsJ1aIpSGEZ/8SkaXWU+gRsgxqrsjhgzU3l48Z23A0yXXNngSL7MmnkPQ8bHHIGITIQLwuyi7qWV3XlyijqEmJyQILygsSEKFJADpDKKwBbN6ncs/MqdyZP9JlmOsRcyK1uplIOhJ4M2hFhLHaTTaWSvCkMx7ygHWWEMw/LwklQFmV43YDTslBCL+rloGUiEdSnGilUHbdwV+xtmUWLCZnVY3E9qJw3gi3EqgWiHP2cxGh9YfHYyMeiI31uB79yQ0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9FpLIN1RUmK4rm+I//sIZ6gM2u6MNHhFZYAVseBpx4=;
 b=mT7Fal1v2qAx1UvVwxZ+MRglEiFjYw6Ns4HDBR/Q+LoPkgVvzkc+urrZ6UmVQ+bNxgVb9UFANkrBROJvOBgzDuT+Iui3RxI6VyK+NMQhJFbaCKOWhchxyEi2K/+EAblYb0jGFL7v3n3WpdS/0vQcXQUnTvAVwVOywz+v2qxZHPU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com (2603:10a6:10:360::21)
 by AM0PR04MB7090.eurprd04.prod.outlook.com (2603:10a6:208:19e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Wed, 27 Sep
 2023 02:33:55 +0000
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::51f9:b8d2:7ddd:c74f]) by DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::51f9:b8d2:7ddd:c74f%6]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 02:33:55 +0000
From:   Chancel Liu <chancel.liu@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Chancel Liu <chancel.liu@nxp.com>
Subject: [PATCH 2/2] arm64: dts: imx93: Configure clock rate for audio PLL
Date:   Wed, 27 Sep 2023 10:33:21 +0800
Message-Id: <20230927023321.3955170-2-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230927023321.3955170-1-chancel.liu@nxp.com>
References: <20230927023321.3955170-1-chancel.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0197.apcprd04.prod.outlook.com
 (2603:1096:4:14::35) To DB9PR04MB9498.eurprd04.prod.outlook.com
 (2603:10a6:10:360::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9498:EE_|AM0PR04MB7090:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a09ec0f-a52b-43ec-fa95-08dbbf0231b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o/fdJF/7bVVwVGZ4XXp4OyLC31+szuoJOuR3OStut8qQ+aEJ/y0oroaqHfKBkRdfczJC4MCDdKCA1nIPgwBCJUiR1F4fQ/VqG/liWRVi0Wy/Y9YEnlrcv3f+Y9LpLyCAX5S6CPskSzW9jM7EHk3MS8saOIuqbeCsGHTrEhymjqljB6GFcK9VCB39PqXv5kODJyUlQ0HLYkZTLf+7SQtTXnI929JK+6hJLGxdkF9NUO+PwinTYXFafJ2sL7yhDpOj9naopyu5XDsMGnCGwRmZ8h1d5+l7r+iz+XZk0VAXiuNo7qMbydQDnjdL77orfb6Cl2Qr/kAOsXdaB58Xzg3QJSCF8VoQhkl4GYtdsN1SYymE/2+g1QV4F1jNFCdMISe0wNnXcIAsQ3IldqmC22CFZQcrGTzZZBzJxetAPqTfuSMaAdc7sXeq/2ucWP+/Kr8Tkw09jB53iYRi1zLaH9U31WbMH6m6aZpABKoXoMMFqfn+UDo5+o3z91A1ezU7/exqrJUA6ZqydrlRKwHia21NgnMG+KtXHPU6NChM4ceUCWIa5jXJLXxG2CDub2sRGx8GngilbQw4vOL0/gZd5LEnuOw4EgA5SE0kvYI5K2XAc3Kv/9sLuUVuywkSOB8SpJERhM3dXFWN+e5QQjtjkukk7hWITfBUW0zIbcGXtI/4TTw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9498.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(39860400002)(376002)(136003)(230922051799003)(451199024)(1800799009)(186009)(1076003)(52116002)(6512007)(83380400001)(2616005)(38100700002)(921005)(6666004)(6506007)(26005)(36756003)(38350700002)(6486002)(66476007)(478600001)(66946007)(66556008)(41300700001)(316002)(5660300002)(8676002)(8936002)(2906002)(4744005)(44832011)(86362001)(2013699003)(7416002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iiMvL4VFjxlEX3zG4tgIdbNaHKKNftDUY+R8qmYoQiC/BHMJ2bwxSmgfdS4B?=
 =?us-ascii?Q?Qd8WZbpKwQZcW4gtgwFDuytnrpbe0ojNTCFiz37MjA9l5Jfga/PJyTeIZdao?=
 =?us-ascii?Q?+aR+g9ElxEsnoSuxuJqGkcH7fnCOjQB/9ueBujpBysYMSL75nE0yalWfsIkr?=
 =?us-ascii?Q?Y9x7VeEq77tGuzepXSx/ozvt/3r/hSYRLSOvpT2Pd4CxIoyf86yHWAvDWbJo?=
 =?us-ascii?Q?Q0rvLiZXBV5+kVO2Z49Z1HQ3mAtdrab50Fi+TxQeucjioZUNDo/9CWQqe6Ew?=
 =?us-ascii?Q?Q1W+AVSGRa2bwJWk3TT/tvlqeyjJzI32eBySMytNl1PPhiHZnCJPvobb1ezH?=
 =?us-ascii?Q?FmdM1NVEPAmKzv/aBQnEHru4MwO9ZIKwaERY1KyyjvpgCBLcYmRa+Gx5OFpk?=
 =?us-ascii?Q?mKn0igITHupu7yeo9VXCzX4EwwyK4WFCa+pYP0Gyc0Imd75xZwm8fetYUgOY?=
 =?us-ascii?Q?2NdFVlLi9wmQmbpMAoWULvNqm+GgYHdceM1FLpcqdYV0nKp3GDX5ycLy7pBK?=
 =?us-ascii?Q?dSDFsQ2mnx92xGiGyH6WcJAF1TGOCdTTjEFa6bJz00pnG2lZ7Mr+P22V/cBc?=
 =?us-ascii?Q?Hp2n8VxTGH9PmxH6nJBI5mJK8Gsm6XwDa5BhGWqppNilL9Zb7vVhVUKbGkj4?=
 =?us-ascii?Q?RNK7EHfS/fqGC7b/G4VRr+yzX5wcZU4QUoPfNs8w7bfBJYYzqgfhlR+zcfSi?=
 =?us-ascii?Q?KtEGf3KTnF3RDeqsMjiVlDvBBmwpLKZEMiMFbSyBuYD/OzfMZdd3yWRAOZup?=
 =?us-ascii?Q?OuUo2O4xZCm1sN0ZNKfYXlaEyggTIHF3o+4dxO5JpcOktF/d+EcmoK3w42Mn?=
 =?us-ascii?Q?n36/mA2tQOg3Zv9lfRxpOZRevW3zQBFD9EF2Y2Vtj9QfPfdqoVi3TUZhAJD0?=
 =?us-ascii?Q?7fqXFYvkdQq+s/F1tGItHOyJgWNXg5blsTsY42b9m8hd6YQrapwZICyOa0vC?=
 =?us-ascii?Q?5TT9f7hWFfLq7N21dzncn6C6HOB2Wx8o+ii4lO7r34gZEzkePi8zil2Rw8Eu?=
 =?us-ascii?Q?zXmqK1d+L7NJYFOOlwgGuQBLx3lgscrAed8QIoSpOiLNGwrptmYJYAUqWnXT?=
 =?us-ascii?Q?Nh5yOIrdAwzPIbogEM89DiSpwHkdHL+0+ZSLXLiXdQOO+Zm6xFliSMyo7MaG?=
 =?us-ascii?Q?YtLu2QSJg0rxR0eamsdItQFecwxk7ZLfHIk+mvNR/FmHSCc2cm2ddMMRzQ87?=
 =?us-ascii?Q?+mQCN2RaG/SZKOS+98IyPQEWJa5dsSwu1hPBZ3KPyoG3MfZtvuC69rJXIlq7?=
 =?us-ascii?Q?L2JaJ0Q72KghigI9Sglz/e5CIzEvBcQUh8c7BLmEfjRdzg1OHC3goSC6UKT6?=
 =?us-ascii?Q?bD+v+u/2V0JhXVjv6ahAn3qxt1jg1UoyG+dysinfT5+jR/VVMK+OMqurCEyE?=
 =?us-ascii?Q?FOsYwkHQ/G20GNNE8VzvvNmQvx6bDmfnXj6gRJpn1sYg4j8kOvDdG9mhirkT?=
 =?us-ascii?Q?mOq7D08HO3D6NW3jHSRBRTX6h8hxD5vdA1DkzWdv/r8Q7txhUue173P6ElwI?=
 =?us-ascii?Q?rMvK7In5eSz2v2c9+cTSfTDj7lQuzVLxWjiPPd6y1btleB8PNqYn97qlKSVI?=
 =?us-ascii?Q?ahbNjFSBmq4io2jj6gtS2M2382Y8UOBSkaMfI25Q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a09ec0f-a52b-43ec-fa95-08dbbf0231b7
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9498.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 02:33:55.0850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9t0hQs2RsdOOrjKLcCkgZre9sK8zaQdJcPTa4XDA/i9h6eCkF8SmKqDYdDjurMD7sJQHgsWHyCfBPnXi5pLjdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7090
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure clock rate for audio PLL. There's one audio PLL on i.MX93. It
is used as parent clock for clocks that are multiple of 8kHz.

Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 6ed7b156c633..0a0bfb7bccd6 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -413,6 +413,8 @@ clk: clock-controller@44450000 {
 				#clock-cells = <1>;
 				clocks = <&osc_32k>, <&osc_24m>, <&clk_ext1>;
 				clock-names = "osc_32k", "osc_24m", "clk_ext1";
+				assigned-clocks = <&clk IMX93_CLK_AUDIO_PLL>;
+				assigned-clock-rates = <393216000>;
 				status = "okay";
 			};
 
-- 
2.25.1

