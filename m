Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AEB7EB418
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 16:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbjKNPtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 10:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbjKNPtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 10:49:03 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2067.outbound.protection.outlook.com [40.107.6.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29CB18C;
        Tue, 14 Nov 2023 07:48:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBQjiF/7Fo2yOZGj29dVs1dCw4MNHzoy+yMuIkgeLTcE6iEAcTd+BWk7V19M1Jv/OH6kKFjp4jv0X7aHoMJxZWKGAVdDxHm7sF+OK1g/ODaNaLQK66Pz6m+yZqwpvTRgU6b8XHNc2SMy8m116NYOy0GFxasLiGR6nKDoKPK735GszyHAwfezYj1xVlWAA3pZn0s0FQWbgpWFxUNnEc5tvllCOPL5NkVc93h3PyA/Ujd9Z9kRJUrANXM2tjYvsdK++VubLS0teJbuIJDMfpRSCTWFN+gQZxNmoNoKC3CxidE1aqPgVs0d7wE64bOCDnCkHpU/dR95MVU0RSIlqG4QTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TfTouRTOdsJTlPyf4LsZsKYwV8Prm8sfu/+ZSbGbtEI=;
 b=b6f5xjiX9/9tYck3lANOVH2ahWKrX1viccChU5EO+jyg6Abhv1ytg/BkknOdpyefBrLS0nDzcD6C79c9sKFSelNxYTSHPAI3F6mc6C3IH1P/a7AHgsAtSsmrzyAlcSjTmO+J1wZ2AWeYuOFtOtcYTbKNa6LJaTdB90L4Ad2m5t2NzhHDpF3v52ybSUN9O/0pA11DHu7WidljxU2Ldd7XQesZyGuev8HXEZBwTRGXTpUluvczqMTsxYlNN84E8BdlROFW1r75CbdtpmW92DGnLc08aXET/lVwDom/XBYqYSgYqheYNeP3TkS9BfxEStd2aH3SSsNhXgkIGNS6FJ9g0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfTouRTOdsJTlPyf4LsZsKYwV8Prm8sfu/+ZSbGbtEI=;
 b=Nk+v+sKTC7BRDSdfoY247coNiwkGiKZT1ll3oBthTcmKv3+RbBLyYIVm0WDWkULx53i/2tzbmndlY84j/Mi/H6KuR8SvYwFg25BEXt0xmh421I6lt6bWDX+iBSxovpyUx6nzjdALCedHqBZG8VzBiH7IAiDsml6s83WXzD/fzVo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB8113.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 15:48:55 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::bc7:1dcd:684d:4494]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::bc7:1dcd:684d:4494%4]) with mapi id 15.20.7002.015; Tue, 14 Nov 2023
 15:48:55 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     krzysztof.kozlowski@linaro.org, shawnguo@kernel.org,
        festevam@denx.de
Cc:     Frank.li@nxp.com, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, imx@lists.linux.dev, joy.zou@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, robh+dt@kernel.org, shenwei.wang@nxp.com,
        vkoul@kernel.org
Subject: [PATCH 3/4] dmaengine: fsl-edma: utilize common dt-binding header file
Date:   Tue, 14 Nov 2023 10:48:23 -0500
Message-Id: <20231114154824.3617255-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114154824.3617255-1-Frank.Li@nxp.com>
References: <20231114154824.3617255-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:a03:180::23) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM9PR04MB8113:EE_
X-MS-Office365-Filtering-Correlation-Id: f1f10893-92a6-4a01-a6b5-08dbe5293514
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x+KPqdRbfdkxw6lY4kifDBGPrdMnDFadFQ+Mx0iTQR+Rm+O1w2pHi2If0Xze99KAgY92bb3aZlBiTaUFnxqOXwwNJEf7J9WiaISoyLSXPCrSJ0zW/jQC0yID+RKhmj4qF4/KvvNQWYW0WxjvlHLPXm+Hla0+XAO/Fh1MRrUHs88aB9pkSy0nVhhhhLuYsTXgd6mWOoutR4BZQiCja66/6QApv0/qJpzfXN6hnFdB/NfbnKUaa60wPvJen909Q1yGJyCTrQueSSV00BSJ581W9YVhpW4pDcZr8YBcilhJ1sPH+OY2nWTyXtvydt75f5JbfZAhIv9F6E88CT4FZ0Z0+LkhXyDRIOrH3eA8MItzzIo13stJSnp96yOuol3gUBjtMcxdYB3QCpvxcqjDQ6pQRnIzGxeuSNYJs08Zbpt6YSs3UXDpllf+WItMDLb8ajHmRizL5DeL7NctG6A4bO9dMrkJoEF9wN4nafxsmFx2dT6K6GuvhpLoWXQOlakDSsjkK0Qxjt3V8dXI4x8AVIFdsqvCvsEKT+76m6Fiwl0cn0yYmboVj2GDW+nSbA598jffNABEXEkdzTO6j4C9U5niWwXNAfy13wMJzGcvmJ+om0250G9ThFptkAUPVai0UunB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(396003)(39860400002)(376002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(1076003)(2616005)(83380400001)(38350700005)(26005)(478600001)(52116002)(6666004)(6506007)(6512007)(6486002)(2906002)(38100700002)(8676002)(8936002)(4326008)(36756003)(41300700001)(5660300002)(86362001)(7416002)(316002)(66556008)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H6BHTo+l4LSWn18hD1h9bBV4LCm0lwmop+46DdZ0eWgrhhmO7WEufnL9PSrE?=
 =?us-ascii?Q?Yugy6Vfya8BOd4M/A7BpxiyqRV2DfCKeRauycOa/i/UUl5Lm7N4vH/FnVzhC?=
 =?us-ascii?Q?xeuRE842UNP0qWujsyex+fznhZ2cZJAfSPzqbqgeaOgnNufFnk7WYkqd5QF9?=
 =?us-ascii?Q?ISnSt0hkbLgZ9+A9XfeVOx0b5bZrRZ0FMSPnyThWHZkGl5NM9eF05E+Biv37?=
 =?us-ascii?Q?aCJQzHGDUwOgtB0vZInC1FWNzil0LhJhaPgnJTE9NKrFpJmW6gYQeCdjkuOE?=
 =?us-ascii?Q?8ZrTE0SoI7ShDP/UCZ4httAFzYIacfMRjSbhbGVA7WboAwWxS6kHKRXhgVV2?=
 =?us-ascii?Q?2dA/H/WWEFzZXZPJxcywj+lv+XS1aB7RhEJnX0pzkLqqgpmn7zFe7bxwVp+X?=
 =?us-ascii?Q?d1wibWLWHZZoY5uNJMCa1K0bjvJrMeHrlkAoIdQBGvOi9UX6VoQ6k4iUE5k/?=
 =?us-ascii?Q?j+OtIJLCrHv8eU2M4zchfHQxxAwRSh0Tbe02LhF72vfEOnm5a5au9wDaqkXQ?=
 =?us-ascii?Q?XhgWWkw2ggWEGK+WlW6HoHqEGjuAGWrVLR/kg+ykeYmb9NItCaL2DZS13Fm9?=
 =?us-ascii?Q?2W16KDgsZsXXiv6qIMo/ZoXrZBC2UQDq1Hk3y/ziAmhgB5PgkDaUedmxoDCT?=
 =?us-ascii?Q?W0NqU4TDXQKNISRZEErSvK2Ta7/Xr4TOzBHnosl+bwvNtT6Zf3wSav5sowwr?=
 =?us-ascii?Q?GkfpqfnqcPwcglOznsAnyt4FkywAgG6xXLWDbKYnwWKs8RUJ0Ukdus4ZluDO?=
 =?us-ascii?Q?BEnOf3UKqfUmjLSY3F2eoVHjGz9v7sHLMUTnHdeGBl1RHtAueSB2UPN6dZrV?=
 =?us-ascii?Q?QzIU2CBNB8IXGMULe6C6Lh8wXtxP0yuUT4OBAqRMjb/e0PK1GvSbZetZ6COa?=
 =?us-ascii?Q?qk8gR5U8UwFs5ZRDB78rdPCHHUBKhKr1oMIrWHWZ7wmdzDiFhmCun2mH4xHP?=
 =?us-ascii?Q?FmkEK6PqEA6tzkWfsbRbmptyLIKpO1aIEyy+NwOu5seW3cgurU2sd+9No2ER?=
 =?us-ascii?Q?EBq6q1ZgWe9GYIK2/c6kU8TfofGUQEaF3z5nmw8eUMAFqYFCtSL3OoL7AM0N?=
 =?us-ascii?Q?YppLXqiuVMyq4mQdfHFIn9pHju6msHuGtBN1yrv2ICkt4nto5zBz6ezkrQVq?=
 =?us-ascii?Q?dSrUpRPLfD9O4SKmhlZBifBdQbRAF7gJDMNbA3SJRfK53patgWOnfWwFc17x?=
 =?us-ascii?Q?hlzng6Dp0739cawasLZT1p1C/Gj/vEF8M2JRMX8kfJSIyAEdCeMdpVWEFngl?=
 =?us-ascii?Q?SP77TG5dUQ/lZLygZt2hBs0U46iYNjiMBGgXbNTLeNjXYsPthlANEt41pIO9?=
 =?us-ascii?Q?NTAW01kghu+Q1z1id26B+bVHiLMzaKwjl3Bw+kTKgpYwvRSf/jNUd1VLvDh1?=
 =?us-ascii?Q?dCRUC4V6eqrOOAUxP6KS8THhzcrmUXoCM1Eh05bkx1iSMXIIp3oXO/Lwo5WN?=
 =?us-ascii?Q?mMeFQlikgvFrWz+BdgVluM5hxaoUHSK6cKauKCs1ZPGMPQWbo1LtK5R1vj2s?=
 =?us-ascii?Q?fQ7EB5fg555uDuFFlozateFx3rPwcNSRCp5bE3Fb2hl+RRNsP4AeCExlRfvD?=
 =?us-ascii?Q?1SYCSINdRemqhvCqfNE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f10893-92a6-4a01-a6b5-08dbe5293514
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 15:48:55.1937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GRqCMn9pK1218/E+RiJynl0SB6KOheUwIDO7XXJwPk2iXVE9sgb97RloJOPPXhqF7T2AGrO58+wSTjcR+L/Lww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8113
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the code to use the common dt-binding header file, fsl-edma.h.
Renaming ARGS* to FSL_EDMA*, ensuring no functional changes.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-main.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 3ee08f390f810..f53b0ec17bcbc 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -9,6 +9,7 @@
  * Vybrid and Layerscape SoCs.
  */
 
+#include <dt-bindings/dma/fsl-edma.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/clk.h>
@@ -21,12 +22,6 @@
 
 #include "fsl-edma-common.h"
 
-#define ARGS_RX                         BIT(0)
-#define ARGS_REMOTE                     BIT(1)
-#define ARGS_MULTI_FIFO                 BIT(2)
-#define ARGS_EVEN_CH                    BIT(3)
-#define ARGS_ODD_CH                     BIT(4)
-
 static void fsl_edma_synchronize(struct dma_chan *chan)
 {
 	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
@@ -155,14 +150,14 @@ static struct dma_chan *fsl_edma3_xlate(struct of_phandle_args *dma_spec,
 		i = fsl_chan - fsl_edma->chans;
 
 		fsl_chan->priority = dma_spec->args[1];
-		fsl_chan->is_rxchan = dma_spec->args[2] & ARGS_RX;
-		fsl_chan->is_remote = dma_spec->args[2] & ARGS_REMOTE;
-		fsl_chan->is_multi_fifo = dma_spec->args[2] & ARGS_MULTI_FIFO;
+		fsl_chan->is_rxchan = dma_spec->args[2] & FSL_EDMA_RX;
+		fsl_chan->is_remote = dma_spec->args[2] & FSL_EDMA_REMOTE;
+		fsl_chan->is_multi_fifo = dma_spec->args[2] & FSL_EDMA_MULTI_FIFO;
 
-		if ((dma_spec->args[2] & ARGS_EVEN_CH) && (i & 0x1))
+		if ((dma_spec->args[2] & FSL_EDMA_EVEN_CH) && (i & 0x1))
 			continue;
 
-		if ((dma_spec->args[2] & ARGS_ODD_CH) && !(i & 0x1))
+		if ((dma_spec->args[2] & FSL_EDMA_ODD_CH) && !(i & 0x1))
 			continue;
 
 		if (!b_chmux && i == dma_spec->args[0]) {
-- 
2.34.1

