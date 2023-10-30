Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604647DB744
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbjJ3KBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbjJ3KAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:00:53 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2089.outbound.protection.outlook.com [40.107.15.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4251BD5;
        Mon, 30 Oct 2023 03:00:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LSYl6ZGLYirKSmJp84sIDUB3rsmUqgT7kO305+Uu+xgzstghhPOXVY7OdjoIELYrWNIOIUNFq77+xBYErKD4skT61Lp7JHPcl0XViAim2oTSf4sHN7v4cMh9hyf0Ir98u4JNsQ2rYoGMXLaHPuesDiu009/AQC/+47vByxJ7RBHZ+c5U+8pksySMkaza8czUqne09ZJFnhaPIstWojFOkKRfbwI32tP2ONlgY+0lkwYjuU6hdt/BxHmUgBCQUUJkjikBCfk30SYrEK6Xp8FsI3GPd8gpKALQzVmnFrm3t/jQjCFA/DnrziN1AfPdcwdMpeeA9EpYlIzZWfAcSgtjvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkxK78kc0GzJ1PAmyygOuLjTJ7Q7J4gC8xHgZpVpz5g=;
 b=J+fY4uqiyu7OnqtqhFcaotoBj5HmBSqIqaLxcwNL3PniUftNdl23isvhp3LmlVA84Gv8hWeLS+zKt8hFcGfkzq+1FEH3glw1ZO+Qq+escdONFd6bhKVMixjz1Hy++2b9sdTC2UQs3qxrXQD5oSZvmvP4S86Ovycl0Gn96sbbSIPybtb0iyVmjXGDkUDcHRpTbVVPlyP9krecQFHd2WylPN3/kAgtcqNI6tFxa9MrcGGAQVSlTJhntlN2xKO/lbxXFGm4KCSSGfqEQgLWZaSAuuCHjlfvoyGDIExKmM8U0PL1QNWd5oJwPMqKCfhaGWGWCmgJcWQe3AoELUXITBQSAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkxK78kc0GzJ1PAmyygOuLjTJ7Q7J4gC8xHgZpVpz5g=;
 b=baeBXbhgbaVoyikyHQEY6AeMl480xKnF3HGa+rW6bvAJ1tk9YHxGN0GZJgrdAT5Ot96C0xkCn5FU/fdh7mRdcoQSsX5MAUSpRYJgANK+OIjGew8LduIE3pZ7KesQqtb50032E1raarNohMbTrePwoFVakfImVrGcR7U3tX5u2ZM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AS8PR04MB8513.eurprd04.prod.outlook.com (2603:10a6:20b:340::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.16; Mon, 30 Oct
 2023 10:00:01 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::9ba:8e4f:1465:9351]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::9ba:8e4f:1465:9351%4]) with mapi id 15.20.6954.016; Mon, 30 Oct 2023
 10:00:01 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        clin@suse.com, conor+dt@kernel.org, pierre.gondois@arm.com,
        festevam@gmail.com, linux-imx@nxp.com, davem@davemloft.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH v7 06/11] arm64: dts: imx93-11x11-evk: reserved mem-ranges
Date:   Mon, 30 Oct 2023 15:28:44 +0530
Message-Id: <20231030095849.3456820-7-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030095849.3456820-1-pankaj.gupta@nxp.com>
References: <20231030095849.3456820-1-pankaj.gupta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0100.apcprd03.prod.outlook.com
 (2603:1096:4:7c::28) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|AS8PR04MB8513:EE_
X-MS-Office365-Filtering-Correlation-Id: a102e838-5927-43f6-6382-08dbd92efb7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3e338KJ1PIA5YruDphHsqxuItJimJ6/LBDseMFS3sfqplLo6R9muSnowYp6dRjepKLqXWCFuPnBtcVU7NVJVHXp0TBb7Q4IWIsy+1CnwQbSoJqXqaDtwckv0EmItEBtpPQiltqSPrAdRzmrq2RzHkHb4lDJR2SlUOCmHRz/TZwO9dY9WYQD9d4v1LWaUltfrWqmXMRIf/QO+bjkvGjzGFnsmwShGTcECFQl3Fw4QF201N7R6CrmZdVl2btdzqj56gvBrWclllKVUj03VqqxzY+f/sxeo37p5vXk9Dqb+D1YsFp7HldUoTnwPLiNxQ+7nBR0KKKNwU91SFdlWiFStLlq61igCW/q7pnWbBT62WWKWZo4UpymURF36ParGVGqMBM6vZ2zWrR+makhacsulU2bOiaR6WJ/F9DlQwPrivS2LXESugqaGx1psERKakVDq7okeYURDt6tGvUjPGPoAushDJfwJ5HNGqwx2lT+KEWnlbJm/YdHFUoMUlIr37MWpewV03nC8aLijBdLBR4J7/62IP5b8eLUDGFaRSeZWCfBxvB8owBc3ZaDNsvEeWk/jCNoio5LdB/FAKm/i2AWQ2HCtLtP/btkwovqvfio2yrGS9jr1DYxxiqd0yCBtxY1xdouuojmkxvTggpKkUHsJDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39860400002)(376002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(478600001)(6666004)(66946007)(6486002)(6506007)(83380400001)(36756003)(38100700002)(66556008)(1076003)(2616005)(66476007)(2906002)(41300700001)(26005)(52116002)(6512007)(44832011)(86362001)(38350700005)(921008)(54906003)(6636002)(8676002)(4326008)(5660300002)(8936002)(316002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lJohgmzjIswe418Nth3jSCvPHhjqIqKsYFITdq2LIOdOQ/7hCl0/7MTmDNsx?=
 =?us-ascii?Q?xZVRIvDlv12wBeJbBQi6KiyZVU2o4W7MBm0JdqZRX9p3pmGv01jOSCAmMU9B?=
 =?us-ascii?Q?EZ261isU2sSXzBL8UyOIQaDTyBFpL59EXwDVxZPrx+KBmpP4FwJwI6o2IFgf?=
 =?us-ascii?Q?N7JYH0tc7FL5pvlMqPPLRkjqJnKECzhdTJuVyt4EFdk93bsTEow9Ke0iH/F7?=
 =?us-ascii?Q?qJXXIJcYNoR/+G0xW1ZUdWJOp323HkFpF2Zpibu30nI0Fp+fBlTmlIOvNoOd?=
 =?us-ascii?Q?NqD1BGnr7QkR+sRBodfCmxylSx/VT4IUlxp1vJgTlSrXxrHHRrDwTdpcqEox?=
 =?us-ascii?Q?+IQ6ir6leU8Ub0yNqjPgsqu1s/MfE2Vchty1WWiuvJPVT/kEzD+3EeI9X36y?=
 =?us-ascii?Q?iCx8z+pwumv9OoLpQc6w3ZNJ1X0kVTi7Jr19NmOqPbxUy1s92AmBTcENeqOP?=
 =?us-ascii?Q?aBM2s7yHoAa5YkvwZENlFdvYbPkiMUnYyod9iGnS3TfqOsyhqONMBgrtwtkk?=
 =?us-ascii?Q?IfvaIKVhKTxxODRxMQhDQ59fEFd5NeDaqOTn/aJ+qmOf84K6gFCG4v3uSkj/?=
 =?us-ascii?Q?QAT25xHV1V+Zxm3yf9mVfHkW60yQOJeOPdjVYCEhOMSKxSGcZN3R03hYldRu?=
 =?us-ascii?Q?F1Hkhg4lhvU28o/zmr+EYUPaAxlTuDZEztoErZkDr6TUHGDlwDZS3T/wuPfE?=
 =?us-ascii?Q?tH/TnsHXQbos235sx9gtteY/G6RIT+opojH8fSRIBYo8/eKieqFXP12s33BI?=
 =?us-ascii?Q?0T9D4Gv1gb4wlBTpHAEc44U3jXoJ5lLYv/CKaaiacn5xYUaf+WIfpY7lYh1e?=
 =?us-ascii?Q?o6ZOmdPcUAE66anaLmuq9T3IwvLzNhDgquTFEPLNN/U+hbPdv9OC/a3XXPW5?=
 =?us-ascii?Q?OjLIaZDlT0simsv7pszl64iMdCgIa7fPnoX6JXe6RPwBhOougystmxC3nAMQ?=
 =?us-ascii?Q?uscFm2SyxZCSArizfxcYJq3PJDx5mhQhzLpO8MJO/r7S6wc1VMzjnGg44cso?=
 =?us-ascii?Q?nGhIbHXhxINnjI/q8iuIg1iGULoXEDiE6FqaP+3uvAAHMI6kDz2byOa4WOHu?=
 =?us-ascii?Q?15W0kISALTEoMqpEtoR517nNZyNtPFXneGvihsq1LajsTNoMVc84ssItV6da?=
 =?us-ascii?Q?VTsxxsjc8sisA3JBU0YjTG0dJmSg+GEYj4BzWaS8d7TtW6EMXS9IRGfCW+Tu?=
 =?us-ascii?Q?JgazVWlJahE/5KZtqACOZU3CscDuAA/GWipbh/3vmGkcArZMxGlIncVNXM0X?=
 =?us-ascii?Q?5hDkuci18XgJmtTTVeYIwnxZkGjFUE5einEm1+Ust68nLqcBf1s1IxHbNFTJ?=
 =?us-ascii?Q?Zmslg6AYK94JCk0VbKQS0jcwRroxvbD+g3XPhNLHjF2KEs9SWoKffpFmL87/?=
 =?us-ascii?Q?UfD9D1o3jMwnLFSHx3Q4WOjnYtq9fbF2uLXwlnMa9i384V358CmSp/7X4w5F?=
 =?us-ascii?Q?M8QIamKDcRh/doMDqIv6WLY7IeRP5anklZLebE7odeF+41+eZNpH0pl+23+2?=
 =?us-ascii?Q?DRghNidCBrzp9dzDcjKLfGTFygRABB3GFc7bSjqMhEUuW09cUDh6n6bfon7E?=
 =?us-ascii?Q?s0hHzMiri3oTTn8JhEgwXp/1VKkCb9KDzPAaYltG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a102e838-5927-43f6-6382-08dbd92efb7f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 10:00:01.7355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nGbw5P/LMNABCTZePFH9f+ri60wUG6paNmqbri86YYunwa9OFnrPrX3hDW7Sss8o5VcnGMPBHR+xfCtc8s2ONg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8513
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EdgeLock Enclave are has a hardware limitation of restricted access
to the DDR memory range:
- 0x80000000  0x9FFFFFFF

ELE-MU driver requireis 1MB of memory. In this patch, reserving
1MB of ddr memory region from the lower 32-bit range.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index cafd39130eb8..bcb4ae931c64 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -7,6 +7,10 @@
 
 #include "imx93.dtsi"
 
+&ele_fw2 {
+	memory-region = <&ele_reserved>;
+};
+
 / {
 	model = "NXP i.MX93 11X11 EVK board";
 	compatible = "fsl,imx93-11x11-evk", "fsl,imx93";
@@ -68,6 +72,17 @@ reg_vref_1v8: regulator-adc-vref {
 		regulator-max-microvolt = <1800000>;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		ele_reserved: ele-reserved@a4120000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0xa4120000 0 0x100000>;
+			no-map;
+		};
+	};
+
 	reg_usdhc2_vmmc: regulator-usdhc2 {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
-- 
2.34.1

