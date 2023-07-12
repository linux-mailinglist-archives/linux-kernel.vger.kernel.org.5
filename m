Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55AE2751283
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 23:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbjGLVSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 17:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjGLVS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 17:18:27 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2079.outbound.protection.outlook.com [40.107.20.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3198CE;
        Wed, 12 Jul 2023 14:18:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S84QeHkMuy4K31GcuQyv/siZOcIDr4zO2/9mXtwmkILYxTRUewtIFpr60QJDdLlGxTKGw8pfPQnDOIC8uLN1NaL5N/KqhfR2Qf2TGro2t965e63SR8FEDDuPSljaqNq4job1gKJtjO6U32DBjo2hUMuLcURWoJHpLPfWZaA/MgRgIkhTfBIEciXzH2gsWedEOFWJNDZkAyJ079R4aUYy4/BcmkK7fCwSXNfIFLMVedMnpurK0jp6hQBsUqRi40a1PMZc0k9bPCFfw5n+f9jlObyFqutaT62mEQLntAnAchEs0EVhuVAhM1Y7jzm3mdZxy75RVpJQ2ekJwPbmhErY6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pq0bdPQM8FnvrjncsPWSEqQtZGyo/fRoC9l0tyo4FwE=;
 b=BVAEh+zBgNkUlUrigdcCemkZ8Ht8XKXomSWIk2rhUN0oXphHPuyZ8aRvg7fWP7l8EGXg7PiwvwiYSP+XubUbotHqKKcr1BLj2xEucZ+Slgw9RhZaEMD+Z0HOyRF2LL77EA+JiMf4UbJOxVWdrCqt9aGYCEshDj0DshNYmw/S8RYJgvVlAUS0vK8Ma6voBGBlzz9HQiAY0ZnkMimoCyOm1C7UPlWd12euPI1HeBV5QhYpwcS59fwwrnKHg4z27TAeFfZpXrzPZy36CLAD5bQcxL4zIlmHbCthhFwWD/a0o4TZ2oykzJIZI49MBgwMWwuIpphGtnMQSLMutW6iZuCEIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pq0bdPQM8FnvrjncsPWSEqQtZGyo/fRoC9l0tyo4FwE=;
 b=Ig2LNHYTMSIlZs5CtqRXu9PHsJloBUljrU3HedBmgrDpQMM48axCaRSG96jyKp/FJ+meWZuJA84DbWw26fCQmGcs1AJhk7PPtblnBj+2Xl0vgAkly1lB2FvHfQ1WVEXpklEWnL7pI1JSZUFyR1wFTTJMYi6oLIAuEZU8g/pJ0hE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB9187.eurprd04.prod.outlook.com (2603:10a6:102:221::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 21:18:24 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::c479:12c5:ce68:5e45]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::c479:12c5:ce68:5e45%3]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 21:18:24 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Cc:     imx@lists.linux.dev
Subject: [PATCH 3/3] arm64: dts: imx8qm-mek: delete A72 thermal zone
Date:   Wed, 12 Jul 2023 17:17:54 -0400
Message-Id: <20230712211755.1538847-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712211755.1538847-1-Frank.Li@nxp.com>
References: <20230712211755.1538847-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:a03:74::19) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB9187:EE_
X-MS-Office365-Filtering-Correlation-Id: f43e87d9-a101-4480-a6be-08db831d86aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YuezZvDkLGhqYokM+XgZJ0PKlOHtbyE/Wrnsjl0sCAeT4clUca0ZBqws/C3htam1yf0fsTmnMNQTzgHUB+5Kcp7XVMAft3QvGpq3heO+uHy4+QFj1z1/rul7btFPrazjAq6c7/9iE0yc4CPubZDB9d4MxFpSaAnBULNcSw74z9asxLFspuCqHbrlzeIF+1NLq9Vb14Nqb6ly3qmc717Gdqnw2z3EwUu9EiH+aYPj/q29gNANhN6s7UvaD9/0/zdY3/HmhpU5odqu0oIUsHaYxJiVr1z39G3h3CDzttx3fdxXP9IL6WAeu5FPtjjDFsPZ49M/VR/TaoKT6xcre60JvrqXEOawhXhVwDgcv7883/ynIasQrP14GgTPccvZkDiLWSMrbsVFgsqbbirGoXqIIbItsQvosCSdN2phmAzwrk32sD9LZgA0zbZnHvR9PS2x+iJBh9Kp7Qrt6yTGOo7cszT2QcTR2qfHrHtdCkuvmzxAUYpvyspJYtobAOgJHMEM7GueXJFn9bVWj56shlHBIAbtmOCgsJzj+SDfnxVMAQD0L7fl0UoETzUSoTDS7tLu6iEgyBmWyKVCvWHgIWgPclDb6vDtF5KHPw6QEV/Y9QDgHfCmdCUz+hmp3m3mnja5Vn+HCIvMcZur7JYM7Z46ylR+rXohCS8lXTbY9OzzFlE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(451199021)(41300700001)(8936002)(8676002)(6486002)(6666004)(110136005)(4744005)(5660300002)(2906002)(7416002)(316002)(4326008)(66556008)(66476007)(66946007)(6512007)(52116002)(36756003)(478600001)(186003)(86362001)(38350700002)(38100700002)(921005)(83380400001)(6506007)(2616005)(26005)(1076003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rT7VPMAWRKoC5SBWGGP2bnqVSEF2GYD3BHy8v/wTiAyv2UbUvtzH9BZirBYu?=
 =?us-ascii?Q?HgI+UOaqcd85wWWgNAhwqFv3DFAXVX/M6zqs9BCiGJcgb1WYyf0F9IwZ653Y?=
 =?us-ascii?Q?J2is8dVw979MLGP5g49RYbuIBjMErF6RwiGJ0/Hg9+Dl8PDYTfb8ve0tQC3K?=
 =?us-ascii?Q?V5+LKfzyRjUF62GKIuXT9D6i3kvtAg5hQAPzhRQ7+Fpti8ew1nVKrFkS2jy7?=
 =?us-ascii?Q?/0HFYBYkfio6f/9gIIhPPR9R0o1zhQNXhi+8NxJkNUGIl4pDQEe0VAp/zxAZ?=
 =?us-ascii?Q?QDBehDzEySTLn5v00EdtFZB8d3vD4rrgymGr4Vogsk7er4AgCfJ/hTr2jW1G?=
 =?us-ascii?Q?SyBjWVSu77tYFTsC+H/OAukfVnhr3gm5iLXa+PToMIz8kMmbs3dpWbZPMCA9?=
 =?us-ascii?Q?3B4eqPrGhomPOprYSeFRqUtTEYROIEF6M+JjFkchydl8jDWYM1ZsxWbwVZbG?=
 =?us-ascii?Q?L+34IBaTSjYJLNcXaUpPzEkMlkg/3uFBDAFW6LhPNS85w05qCHXmwXwZ6wkS?=
 =?us-ascii?Q?90IKY1ICamN0/jgeu6sVpXS2MsRLV7TSUOQu1dGUDHwYoU5Dj741WAHhKBqg?=
 =?us-ascii?Q?kMtoDDpy62jtvNXRVcXdiLSBD9hxC3+YgKjMTohSLCiwlO9uyfzfeKYGkTJu?=
 =?us-ascii?Q?QTFnYuiAoeM2JRKlFXhghis50hl3xRwrHzcgfnxsxajudDqJw8pMR0tE7yVr?=
 =?us-ascii?Q?BEntinaWjmF7NMrrka0qWjiPDm2NsQUIn3MZ9LBT1dyH1Pwk1lgE/JbMlu0Q?=
 =?us-ascii?Q?/3DDq2zg1Bpak8/u0sZLuZZZz975yXlcbGTSSb00o7B7bt77bXML+U7jVtzV?=
 =?us-ascii?Q?kJ45mRLbPXrTJ+Ne1xZCI+cdflKQBR8gMol5hi0AEzhNossLTtTBfQTUoL3a?=
 =?us-ascii?Q?mX2L3mDo2n9BjOLalrE95bspoAtmh1+C061nTJA4CDIPfjFB7utteb9TH2Fh?=
 =?us-ascii?Q?T562Au1hO3clf3cAYE0LMRa50pbS3nLzj9cPTpeEVAQJUNV1mR1568j4Dv3u?=
 =?us-ascii?Q?VqVo0iYzusu/dEZoZXF38y9DRczV2ipMxTJ39XgBek5hMIBZ9S8NeR+Io33M?=
 =?us-ascii?Q?hS6PwLpgJCffds7S0BSxdfF0qFUiBndzHP9GVJKq/ediF+hgGPx/F2gNRSAO?=
 =?us-ascii?Q?64cQgsdFZ4K7OLOBj1IpmylaH80JCk/2vICYHX5hzlGsmunNKLtjIAh+ZPXJ?=
 =?us-ascii?Q?9PIle8uiqM2PTzxxRhN4myg/SloATCNaQzdZvqxftFLJOWt3a6iJXzGD0JIp?=
 =?us-ascii?Q?Ehp0rq1JNs8Ca+GjevvdQ5iZCRB8mXX1Ft6mvTvzwLPWI8uGh+9HOf+rgmWG?=
 =?us-ascii?Q?ahF0HGIs/Kr5EqcuhOFXJit+5lG0Ownn9G2gSkYe54BkZwxTIuHVdYauoiUa?=
 =?us-ascii?Q?nRaULHFjVwD6f4gaRD+HLXfoJlWRqTJC33W2zOMFdXciS9dZXf07ijQR7llH?=
 =?us-ascii?Q?RAeXSYBBKhz+R3lPHuE8G3gstBB2HLrSvtxT3XKbi0gGOvduv3kCOn/nJn2+?=
 =?us-ascii?Q?ANYN+u6S6OZeoUBwI0ZTr6kCGioGEvLbj6TvqmY78TABe0a3zI8ety3+jKTP?=
 =?us-ascii?Q?MJbnanRnvbV8LxxdBoCVfoDx0o+uUyLE/yQjMjP8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f43e87d9-a101-4480-a6be-08db831d86aa
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 21:18:24.4268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ChH3i5o3oUp1rAqzx8Bo6gAGZ4DhQBPC6J//4CQd9f3fBa3WbmQHVoXQczfE/dmLDdgSRXdbeBugPlNn/ROmYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9187
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The A72 nodes have been deleted in this DTB. Removes the corresponding
thermal zone to ensure a successful build.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 607cd6b4e972..b0116b219c7b 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -22,6 +22,10 @@ cpus {
 		/delete-node/ cpu@101;
 	};
 
+	thermal-zones {
+		/delete-node/ cpu-thermal1;
+	};
+
 	memory@80000000 {
 		device_type = "memory";
 		reg = <0x00000000 0x80000000 0 0x40000000>;
-- 
2.34.1

