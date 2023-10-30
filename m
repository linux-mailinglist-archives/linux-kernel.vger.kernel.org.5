Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115F47DB74F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbjJ3KCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbjJ3KA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:00:59 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2069.outbound.protection.outlook.com [40.107.22.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2E210DD;
        Mon, 30 Oct 2023 03:00:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cx2wzxhZmPEzzODh99pYFShPxHdwfOKlLYF0FX0vo7Asi3TCpRcSjFzw/P58ffyiGCPzHspU3MhRJpkwQev6Zgy/lCT6CTY44RRWMgse3RJv1v1qsLZvuvx3dBVg/yrDyE9Mm+Xqj4pE1h/Duu1S+GCoiDjFkoRiVMdNUuqha9kydeQrJINZluuzldNU5mQT9LYzLylL0ANwwogS0g1HGoDwouvLvlv2VAlEtMSLnT7SfZqRHYy6S/EzhQfS+D6OIJJyWbbfjuoHD3VCHZdX0otcWH2x+b0hsqRWCb5VcJ5tUGpX3qkawTOBWFCZ35DQSMeBuwFw8k5SCLNUgD0t3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0Gl73D3Z01os1JfF/f5yYMjVSKDswmv4vCyPTiid8M=;
 b=Zu/3PW690AQNzpHbAULNFuRsprznBRx2vhux81zlpZTyjbxcFOucVZmbGVVLHMB4l0vYyiWejVojyDr3jpFN08wR4HM/0kldo1sI1ka0yj5N37uBE+w4yAnlTCz/EIJt9uuwClztqBTyCv7evRG8CKsHEdBQxkr1YOPmCr9CPtndxrlxI/nbF6TIfBoAyeJkP5ID7SSJ+xGYGRo78TWh7BYwSWXEYw4PwaBo6OpHnava8/LxzkuSXFBJCVZAVtj46P713i7Bwy0VGtnIEeCaz83N/SGKvxuHfVybzHFgoYSzFbGxaI80dL14KxiB2FWa1y073nb/IGF0Be2FA5a/ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0Gl73D3Z01os1JfF/f5yYMjVSKDswmv4vCyPTiid8M=;
 b=DIV1dlUx0x488jPwGTSnAvELqyM5mNhAqKVmt7bi85PUM61NzQtl+FWyKpwznsdJ+kLpg08t+7NRZdLXoDTs5FHS+hCWUtyCtsgqdKMjNEDLjxkOAPQXxqDZV3Y6Nhsfg+a0IBfCtKlXlMmfj/8rAQYt7tSiXPiloo/cJGzumDM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AS8PR04MB8482.eurprd04.prod.outlook.com (2603:10a6:20b:34a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.16; Mon, 30 Oct
 2023 10:00:31 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::9ba:8e4f:1465:9351]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::9ba:8e4f:1465:9351%4]) with mapi id 15.20.6954.016; Mon, 30 Oct 2023
 10:00:30 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        clin@suse.com, conor+dt@kernel.org, pierre.gondois@arm.com,
        festevam@gmail.com, linux-imx@nxp.com, davem@davemloft.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v7 11/11] MAINTAINERS: Added maintainer details
Date:   Mon, 30 Oct 2023 15:28:49 +0530
Message-Id: <20231030095849.3456820-12-pankaj.gupta@nxp.com>
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
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|AS8PR04MB8482:EE_
X-MS-Office365-Filtering-Correlation-Id: f5e86bfe-8955-4314-4391-08dbd92f0cde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qk8ewj55Ouqra4IPwyggdRv2hMpt/vVIETTBI7Gb8xc/fq6ycCKU77+OHd3xChU65m2XZzY3RU8MpVvLDguKhCQ0GkZSnwOQI+hYe6tpFRBSt7u5O8xS18GZDTY+PLa2AcITtZSfSI5twbu+mBti5rXl2y8xTV8NVmg0CMdRrOkg3mVfVPb6vuBOkaz8cfWW7yN37K2yPFIugN7ehfazPAG95hqSEr22NjDcVQrT5vfPfXfm52CPS98ILiHthPyc6UivXUfncPKN6k0NlBqqY1YTyFXBBELmchk7QZrrb62Tc15YsA0SAFnqMOudc4iGkwGpgBQRuWTzH6M8JnnWj2Zj7w30S0QRpOJ6V6rRO5+rfMu+Y1iswEyRtZ2xTrQzyoVobVuIM0M5zg6wRkQ7XYQjmcDy6F6/UlJOoDsh496NMozKAAE2UInDlamBF9oHi5kx2e6nzXYn8vr+VgIR2W7v36ekUMP4exR98uHczARXtLTDcGxwna4PSnHmSm7EKWrW5sN0muTaxqu2plLmJrh2UzDfbKqUkP5DD1SX+vcmsd/b4pjyNS3hnitJe8WuxS25XluUHYCln31EhUxkiJk7HcbM7F2YZE/DwXFNh2D1QtaWwYTR7zVjOCH4WohD4VYwYZu0cKem14t0sJMYxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(346002)(396003)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(921008)(4744005)(2906002)(5660300002)(44832011)(7416002)(41300700001)(4326008)(8676002)(38350700005)(8936002)(86362001)(36756003)(66946007)(38100700002)(316002)(6636002)(6666004)(66476007)(66556008)(83380400001)(1076003)(26005)(2616005)(52116002)(6506007)(478600001)(6512007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zlAK5HvsfkrAT0jiwsjWD2Rdk1AC2ZFUaFYwol1vjwsLHAZTT81KA6+AMOdv?=
 =?us-ascii?Q?aHcS9BmCtTWaH3WE+g0FsFxjtKaXfmuFEetTwT+BcQfksr+Mn7jY7ZvUrKo2?=
 =?us-ascii?Q?PQmPd3yFdBjCtsgQNO32UVKYvo1kzdWF9N+XaV5Ou55Toy0MlAEOePIobejZ?=
 =?us-ascii?Q?HWOHO5JRzzT+zVvnOupfVW/H5nUjmwT4vx71HXJwPKx1uZQotgxRA20DEmLP?=
 =?us-ascii?Q?NLo3a0xiKYuPbUukUSlmzqUzT68w31ZiEG/8ubU3VLaEmf3INHMtd3be9gGp?=
 =?us-ascii?Q?EYW5H+Q2EzTY7Ht9KFO1Iz0JiGIsSdUPZ7PKkXTfD1Vvw8n+sDxBtoQ4EnEP?=
 =?us-ascii?Q?xR15rE69vIaspC5VnWtEfBnnK0LKlY0r2tIqSRlP/ZCQzKUMLacrweIyypRG?=
 =?us-ascii?Q?sV49C+MEAI0ROSmEpkyyef3tW5aUY4aMvgE2/xWafdyL3pKVFu+gjSAuRY/B?=
 =?us-ascii?Q?mZU0QYXQXk/81QYMdnk2Pf5T+k+phErq3lywCxJSexeafGkRaYuc1BgI6TJY?=
 =?us-ascii?Q?J/43Tl4hqZzAH+hYKKcPSEYjwF5TZjulDzKwH94wMED4goeE5LELK8iToPBL?=
 =?us-ascii?Q?X1EALiXHD00vOpypXu3tYHBbyn5mJ/FWp/m3NfZiKQm9Zo0yyxVNgZGVth0A?=
 =?us-ascii?Q?ZKDsbAqv/b2HGwNJR+ahEUVAxQF0stuIMzm/IIn8DXW/tBac93Jl2Xyxsipf?=
 =?us-ascii?Q?3d7X0O8eMxKkA2Ziv0rbcoki5gZq8x7YQ9fcvCahPjhp521gSaMnxzro6Jmy?=
 =?us-ascii?Q?dh3rZsXMtF5Xd6ZhGQGHaR/PKRp+Yh35JbHNvcTOEajC812JsZRzlN5wwv+H?=
 =?us-ascii?Q?1TwoHLX3keNMZ77s8mc1gCDMb/FMy69N6l+VpbxW4hC9ktth4MyXVZHlWNIr?=
 =?us-ascii?Q?ZuY32ppMSIP7UILKtPD64fENhi+utzKV89SXthskZ1f0dO47dXOu58HXG4ib?=
 =?us-ascii?Q?D7ufsawKLd9yHUvrWI30owrBDT4T7uRQtS5TqXSBdDlDXScwa9iumJLbRg0O?=
 =?us-ascii?Q?lYUcQb5mIhdVCjkE1gGNKQ7OEWF69ZNYp7mp5FIcWgSPQmI6DdUZuFe83Tu2?=
 =?us-ascii?Q?LrBgKdD8z7Iv+smS+pBwWrOvvVDe34iNJWewh0KZ3BD8w0KOMjYKszZjs+7k?=
 =?us-ascii?Q?O2UbGBuXYIQ091nuDLFJ4ZTxf9Wz8U+rGV6QzDjMfqUdmfg1wU3HjSKDPEwP?=
 =?us-ascii?Q?R5ZwOpdU6LEgo6zrMG8C+D0N5bWUpqvFzhVjhnvDBDqQvBJuzz3k9qoenIcE?=
 =?us-ascii?Q?xPOVencctwRBYdemXATHb/djC6BOiRHAmiI5gRpSnkYexQAOuGq5aUsZ13dO?=
 =?us-ascii?Q?ktrS/Y2a6piN09tFAKhAnHIIYe6hYfZgkIqOVnyiIVsSOx4vP2+TdBYtU0p4?=
 =?us-ascii?Q?t2cMyBgDAAuqvqgay1zE/I5EPyIuKD4Dnl0wPSiQSSOfWXK3FMHLVktuZ8FF?=
 =?us-ascii?Q?PzKvlUFRi0omjmnrx4Az+FHRsJUhzAJ+I7c5wgwk42A50hby3s/KVser8v5i?=
 =?us-ascii?Q?1Hv12yOxHaUv2ZEoRLSMQLyomHav1tgdDZFgGwvHGTtssxza3SBrVLjdT3QG?=
 =?us-ascii?Q?FKKvOvzqBN38nhCvm2VpU97ZVaQGb71aLpujktuE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e86bfe-8955-4314-4391-08dbd92f0cde
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 10:00:30.8807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJh6Yd3KyEc8lkvHWpOPVpFPOjoTU6qmcvYYzvEMyANAzfjFNVdB7v8KyZqBqYsm3dhRZK+422JdRViFrd3mDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8482
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAINTAINERS: Added maintainer details for se-fw driver.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dd5de540ec0b..984751d7514a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13758,6 +13758,16 @@ F:	mm/
 F:	tools/mm/
 F:	tools/testing/selftests/mm/
 
+NXP EDGELOCK(SECURE) ENCLAVE FIRMWARE DRIVER
+M:	Pankaj Gupta <pankaj.gupta@nxp.com>
+R:	NXP Linux Team <linux-imx@nxp.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/arm/freescale/fsl,se-fw.yaml
+F:	drivers/firmware/imx/ele*.*
+F:	drivers/firmware/imx/se*.*
+F:	include/linux/firmware/imx/ele*.*
+
 MEMORY TECHNOLOGY DEVICES (MTD)
 M:	Miquel Raynal <miquel.raynal@bootlin.com>
 M:	Richard Weinberger <richard@nod.at>
-- 
2.34.1

