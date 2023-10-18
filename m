Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3B27CE1A2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjJRPsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjJRPsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:48:33 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2089.outbound.protection.outlook.com [40.107.6.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998EF116
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 08:48:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VeVPXoPmzEKqhb1UD1I6O1BpPbUmY60nIiXpoi1T+kMu9rMSacmW75LaqJk7Pxan+p/2kk3nkCBA280/GwOKt6Cpemq+gnbkqq/9jjjg/wsVX6NYMIED0x6PWGjBwwd8sJ1HzxlaJhYBP17XB9lE7xY6ToHVc+bK7FwJWnZFNZhDwJ/XrOE7mKmN90i3GI55JAbGZCK8P9EGbGEkrg5q9c5mQaN+Xy9C5KvIP/chJRYkxJoY7Xzqo4C5nNST69JZzQUcRnigCIVvwTbo4CDJBIsAtcRMiwz7bD7knlkZhX8HJeG9qn38vCr8bw7ELlbF08TpjwTwR8rBZfY/YqlnRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxJI3Q1/N120E1UZrO8OotkdCQQ9CDow6ekaDNU32Hk=;
 b=GmmsaLbhFTkvb4RmI9wEpdqsOazmyfFK5HbZc5iFD9IzXPh+gdTreEGtjFfbQg2o7Ce8UhswfsDkqUk5oxyFV9paRaGhcmxJX22XYr4Iw+0/daUMWnU1p/m17IM0DDkS+vTxja59dOz8ESOp9VDkXU11jSRzjV0prC9EUJF2Vyk20P+/4wl4HWVJ5J+x+XpGOgYJVtFvVNQF68wiM7db2aT3Vp/LIbkmP9iZxztQDk4UgrjgHgsvM1Z7ekFh8Gn3GROQyZxLVfuO4dpIfPyNDCLOM2TIVXHttR2lgpUlGxbbT9/VO6n0Kalbkzf1k3wCoX3wJrwG8IPZ+qIvSytEsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxJI3Q1/N120E1UZrO8OotkdCQQ9CDow6ekaDNU32Hk=;
 b=Jg7E+gzUMtn9lOTW/Txv20o63KVwAzPrGp5Y8G7L9hr65vjuUFfgHUUlV4SRXpp9wdmQUtZPQZgqKimjeZ4vuY8mioMWvWwXJdUIH4NugbmUxa6XZPmMl6pfxYc9TsD5Cgrpz3xRutzDO8fpHhvYZtD4wK4yB91CpKBoJiCzAqs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by GVXPR04MB9777.eurprd04.prod.outlook.com (2603:10a6:150:115::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 15:48:30 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 15:48:30 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.Li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] master reduce clock
Date:   Wed, 18 Oct 2023 11:48:04 -0400
Message-Id: <20231018154809.3304558-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018154809.3304558-1-Frank.Li@nxp.com>
References: <20231018154809.3304558-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0087.namprd03.prod.outlook.com
 (2603:10b6:a03:331::32) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|GVXPR04MB9777:EE_
X-MS-Office365-Filtering-Correlation-Id: 1df620a8-decb-426b-4e5d-08dbcff1accd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jh8fCvz3YuNDbuzIcsSuT1HBiXw3B/sigeNH2bk6SioXZJ1JXI6Lskqa4p4QWhl4Mz1Aw/YIDwEgLpV1ytRC2+Grg+bnmJV89IFtgRnJ+iSnrqacbR7QskDEGfkRhn44ZfX82sCQyDwydD7xz8FW48TuYuZF3pRRh9u9G/sPcmhd/KH1u24fPdDe1zQMqikszBJSA9IANKgNK4ZQNrJZN2rjqxvPKEBH1hBn3Ip+BMP7/2VCBB/tkR29XhVLNRs73RS6WTqg36e6HodPBrNEj99zB0uFPRRtGyRFHgR5L98yqyf5+I9nSc6Miwb6ny7i4TZU82d5czT0aAso8IiVJlmAJ7u06sOObQm1M0RyMRKCSPNPfvCV7ui7xC7XGJtmPOBTcaGo74iWuwscCg4U0kM2BRJjxCya0Mxufo1LAU/stOQ4+d1sxO/OyN42iP7CrDEfCqba6Kuf5Zo41nRCGSoZbdKAd9ZYWsZ8jzquJOM6iUs5felaNkF4Wgp0+JP1Zl35Vu+L/8WhlWFawIofWQr6MLjRSxL2yERp6eFVNu4BpxdlvbmPmVfaXkuEheWLQpLCi6ieOG7PK1cvRiXnMnMSKeSVIN97O+oFnRdDtnYjyF35BxvuFbIZ36GIxjyJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(38350700005)(52116002)(6666004)(6486002)(6506007)(6512007)(478600001)(66556008)(6916009)(66476007)(316002)(66946007)(36756003)(2616005)(1076003)(83380400001)(26005)(41300700001)(38100700002)(5660300002)(4744005)(8936002)(4326008)(8676002)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MGWecXSVnYbtX+HD9vWj9hJAve/wIzvyRBPe09T5163aP8wPuxwl4SsXpErm?=
 =?us-ascii?Q?PdtDEQiAakvMzipc0DcYLEYLuC7Wxnv+xR8reRItQHdkxPqqStDDtgQjki+Z?=
 =?us-ascii?Q?KWpXX2QP93NRVKhfcdMdwp/e7SETMietj00wsCcfQ2Av46VPBZAzYMe853Ql?=
 =?us-ascii?Q?g/iYEV6RGEqpAlcX0kiPcz4iud8zwjybeaxcvy6A+6O+yHQ62fm/HJI5dSWW?=
 =?us-ascii?Q?OrJPQvGYHNkwtgRzi3xoVlBgBJq+s+3oOv6jIE21nCLlhfuV20v6JP55IDTN?=
 =?us-ascii?Q?edEanlQpPwseDZRKt9QY1S4OcbHCOChg66KBGrZNb8KClW/drZfAhx4ab0WJ?=
 =?us-ascii?Q?KiuIwoxN4zZvbPqg/CLmdkHoUXBOd7hhK7Qz2cFtU3mLttJlOHxslC5DVvBG?=
 =?us-ascii?Q?bas5a581PsxfVRgc5eK4aJ5njJ0AFPTnXChoqFWwpGOOnHdSxWadxW+5Jg/z?=
 =?us-ascii?Q?HUnQvCBDBr9bNQG+uo266lZ/9U635DvYeNInwKEboetMOIDI73AfQ3RHhc5A?=
 =?us-ascii?Q?hh8gBDVTwtjJsYMCrhCibxKP6uhh1a71VhJSNgQz5Wny9h0+/bib1HnXNJiN?=
 =?us-ascii?Q?8NBOPzJMwdT4z5EA+hmk3BNWG94VmL5/1TE9FgILL6GpVWg53YaCe9P6dC+5?=
 =?us-ascii?Q?GXl4nP8GNMZ9kMiG64eRV9DsfBjlmw6t4ZqSphCv5zbIyvluhQ5sMtO7kg99?=
 =?us-ascii?Q?6Rt3AgDi8VGhot1PhNN8e8f+kT068nPrryokAK2PJxpO4+RiXFWACksY+Cpy?=
 =?us-ascii?Q?zIx0WaKSIMZVl+VlpN0aU4md3oLN/NBjZdlGrZcbxhYqH1pkm6ltdmdkUd01?=
 =?us-ascii?Q?N/CNwqxPRfum9jZi49ipjj5F8sOdvb/VJ5VJSbqYb4Hh264pUjYOrxpLeyrC?=
 =?us-ascii?Q?ZiQIcHE8jPclyXFJURq/sCfFIBGO20sMXYLTzfrn1NhgTkK57hLS79KrMapH?=
 =?us-ascii?Q?M+nMB/7gzIzBhv7uZlHLR1+wT27Wd/Cabk7F8rtW9XleyVVQw6v60rk59laj?=
 =?us-ascii?Q?TKBNitaTlC06z+HXZTsbC5qBDJi/BnnKUl/B6gyjeVv46qvFLiKNCKKlRUJR?=
 =?us-ascii?Q?Iv6/2Lc7hL81xPRjMh1eEbPZnHL2QAJWCdnhG/haRiXkz1mgxeZAdDWmdXTo?=
 =?us-ascii?Q?WLAY2IrXV0//8TiIwNJZrdxH3b3rlQ6sBh1bfIekLukETKI4iVC5UJGeMAkW?=
 =?us-ascii?Q?KwV1knyRzrxFQjV/Uj5x6ZHlLqc41GNlYX1A7uPBfrthFtw3a38YZnEE757N?=
 =?us-ascii?Q?IaSEkGghNQR0FLjeOtTH2YYDE2PiQfW2w+hoTJ58NBVsJ24bB4oe/6Pgv684?=
 =?us-ascii?Q?8ertI1xgjM6Kv3XAh8AQU48er8gYINZ6x5yjdpUiliwnUW/fL2Y/ne4FtGIL?=
 =?us-ascii?Q?7mUBfL7rHoS4dDDqyBZ7ZrHT2VPasG2dTR55jRwY0d3eZ1Vn85z4NkksRWqz?=
 =?us-ascii?Q?EywBKxnq3cH9590283YxfoJjJnC/STTpZ8/UC/k4NFhFMXM6zZviGZoa4gy9?=
 =?us-ascii?Q?cP4NwsxjKq9zTrFW5EWk1IQ0THuCtMBrxd/kIq3dEhQZqPW30DG/ExvGRlwT?=
 =?us-ascii?Q?1qbC1DSIL18ZW08aEHhsj8s38gMcakqkFvIjvUXD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df620a8-decb-426b-4e5d-08dbcff1accd
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 15:48:30.4182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xibRjJmgC29NjHX7sScLMVC4j53lD2TTf5XEpTpQhg05xdFJGO+qZTc0QwJwIsI4TluiSGRRcpvb2twirTmghQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9777
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 drivers/i3c/master/svc-i3c-master.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index e307ba2b965e6..d29de5fe533e6 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -511,7 +511,7 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 	 * Using I3C Push-Pull mode, target is 12.5MHz/80ns period.
 	 * Simplest configuration is using a 50% duty-cycle of 40ns.
 	 */
-	ppbaud = DIV_ROUND_UP(40, fclk_period_ns) - 1;
+	ppbaud = DIV_ROUND_UP(500, fclk_period_ns) - 1;
 	pplow = 0;
 
 	/*
@@ -521,7 +521,7 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 	 */
 	odhpp = 1;
 	high_period_ns = (ppbaud + 1) * fclk_period_ns;
-	odbaud = DIV_ROUND_UP(240 - high_period_ns, high_period_ns) - 1;
+	odbaud = DIV_ROUND_UP(540 - high_period_ns, high_period_ns) - 1;
 	od_low_period_ns = (odbaud + 1) * high_period_ns;
 
 	switch (bus->mode) {
-- 
2.34.1

