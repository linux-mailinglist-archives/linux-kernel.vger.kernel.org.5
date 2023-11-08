Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81AF37E59AC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 16:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbjKHPHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 10:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjKHPH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:07:28 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2057.outbound.protection.outlook.com [40.107.22.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EFC1BE4
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 07:07:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dH7k+bWyzjMWBNWWlLaCkh1Htd/XSfgrt1Sk8xJBAWT7tStBkFI6++MpMttWIV4stxWG1LcRs+a3RqB2ca2yfSXzlmpvjpvK3Fs2+P6Q6cAHGxxUWKuLcSyrxEnifizwJCK4k2vqjc7M8mu+b0ZFc/u9R9jHD8fryT8pOHq9DfHe5EJrO2tpsBDeyTnPQV+8krHLCpNdJRU5zyUHYRPBYpvlXrJ2S73uUN4To9o00vM4Zt/3EuXCCc/xBMzmRzvSPCU6fedHDSNfzVNEBhrJDzjEhteAFzbzhb5FGFMxKK+MFK6rL6mU9Drg0SdPLch7r8bXmpIeM1GpEgMYqNJ6Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RnFIeWFVjD9MzIxm4tk5N/GodF6qN4x9pPgXueCfqJQ=;
 b=iTH702YgRJ/xVOLrDaft2gk4axD91kTWFTlKFky50zasByhLZEbq21UcIA73ZVn+tsWaWDHKWUy4qj9f5KIh1WeVnUO3QjqYfqRoobtzfDOkgOZDEyQ6+lFNxLyHytu45iLn8Si1iJaHOdPc8xzpUHfGhGbaWPgfikgDA2tHoPGtuyEzt7uVgDvqidVmMpm3Y+kDgemYPzBlfIReOvk1w6smZ72Oq5gKp1tqg/h12e8/PbGgXJKyxCOQX2m7EoTeR4pmqUd9k88WHd+4Ij4H8zPDbKzKo15Bu70eLQ+sN1s4PK2M9UvfQksRnF/NzUojDzsaSpiJLUbeYOhKw8Skgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RnFIeWFVjD9MzIxm4tk5N/GodF6qN4x9pPgXueCfqJQ=;
 b=dX5znQqDWK5ROmBC1cyr+Rbi86iK1kPkRAqLsN4rEU/APbCeK16hwRuMBGACZs3RAnigyOj0O/Q9TPoUGzVoiWtAHFWY/4preNcPcyHR68aBamGrwbaJo2uDmzKP45YxsF1EQuTP1mlNtMyuE/H04zF2whclV1LDGfOLn4RhQSY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11)
 by VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Wed, 8 Nov
 2023 15:07:23 +0000
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::f582:d694:c655:89bf]) by GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::f582:d694:c655:89bf%3]) with mapi id 15.20.6977.018; Wed, 8 Nov 2023
 15:07:22 +0000
From:   Han Xu <han.xu@nxp.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Stefan Roese <sr@denx.de>,
        Boris Brezillon <bbrezillon@kernel.org>
Cc:     Han Xu <han.xu@nxp.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: spinand: gigadevice: Fix the get ecc status issue
Date:   Wed,  8 Nov 2023 09:07:01 -0600
Message-Id: <20231108150701.593912-1-han.xu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0048.namprd08.prod.outlook.com
 (2603:10b6:a03:117::25) To GV1PR04MB9071.eurprd04.prod.outlook.com
 (2603:10a6:150:22::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9071:EE_|VI1PR04MB6797:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b92f437-4615-47a7-9e32-08dbe06c68f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OUzimJ9GauYAFO3zx/k0pe/zBRPa8s7786E08oMHjRaxFFr6wo9k8dgoFYMy7AYKbjIHWarzeGPOgLf4ADbZX7RyrQWa5shmW1UXZP/aL1NZoMRcUvIhysdoqhjFrK4ySN7cxu92CbKb0B1l57H08KerDSvdBHJsex8N89HlBWYs8lTEgFhcyk3Fo3yBdIIu2UCl96NMvJfbXw35CBGuBwX9T1u+BQvCJes2keuu6ULd0xqoTWyDLPiboeau6sNexSJmOxpslur6S7hHvnaLG8wLoR4F5Jz8SjyoBTX0qi0c65+Dil6rnwofINy51Gc8TF2cDBDj/bRKyDC89dqarC6AncdeBuUYVK1NUoWNuF0Mnsl5N/uhtvjv7UVzOPJjtIBXf15ylgMn4qS8wcVfdB83WrKe7gHktr6BWH2WM4mUrIFPDxmofyUNRQNHXVmt2v5k1s7oDn0pinxRQWEpSWaPcvB53MBcUN465r3itlmP3TFXAxpTQVpQiB8FRLxd29NJPTPviP8R7zIRkiGBfDkCAi3SJbNuZirIFWMZpHqHmABiAp0YaBTTGHfUHZQQBM6PYcOPRKgPzxFAqLV8kFhNYdsR/UZzten/Pgw+5hAwVBGguM3USLohFCgsjWaO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9071.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(346002)(39860400002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(6506007)(6512007)(478600001)(2616005)(52116002)(6486002)(6666004)(36756003)(38100700002)(86362001)(44832011)(66946007)(66476007)(66556008)(41300700001)(83380400001)(2906002)(1076003)(26005)(316002)(5660300002)(38350700005)(8676002)(4326008)(8936002)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9p1c22B0W4Kpo5NKzbhIRA/ZJE05kplvHFkiDTjeqbGQAolcc7xWajPapfHg?=
 =?us-ascii?Q?7Yzza6h/SSIeGAwcvezvPJyicHPZRqI2WfvjxzESlSrvtNczo7dxqtQarI/a?=
 =?us-ascii?Q?ElETxdwz5L/Ao5IBngc85JxOt4jx9t3VwAlTNZhnAO7r3tuEZ/WsThoAoJRd?=
 =?us-ascii?Q?/pNJfdhs2jZ36H6o0ANfQ4zFZUd2Re1KlxOAH9RR6mySQux55k7gbKxtQUEF?=
 =?us-ascii?Q?arPkKbgVL2SK+CpjdM/+TgbLZXw/q18hib3j2okP/w9K4J8SZEeaWQDHBRPF?=
 =?us-ascii?Q?VnvuiR+CbpunroQ9MhNMVCOL50esIOmdfJh+FH6siJQ1kfmKdV/L65fH7iYE?=
 =?us-ascii?Q?3S73DTzDWdYarFEv+6teupPpLHDPN5DMAOx2hEt3ozWV6rrghpfC5No+pUqn?=
 =?us-ascii?Q?OLXL7+tfypOmzF3OSD1Dq0wmu//1pwFSLm0KlmqekXGxEJ2VqGfjwAi2B6ko?=
 =?us-ascii?Q?VFGJpu80ASEN5innwXbsCqaW+IhwZ76lUi2vc5hj7o2Lxrm6JO2Za7HCIMaM?=
 =?us-ascii?Q?fFRfm0mYOnFQTTQ+YqPSbavKnjax3SGecxif7+MVJfI7KXiK13BNkyJSSHD1?=
 =?us-ascii?Q?V5PBTIzEcrVcebm+Q9NfUePzoMe3iM+xQDbsg2etTSMmYBkIvb52y6qnHgU/?=
 =?us-ascii?Q?+isj7zC7Dic+MIV4XV8p9T5j/yM5rAuTNO6dKOd0JZlBMpKpjzUzQqt3NfAP?=
 =?us-ascii?Q?sxnFyqc/8EuqaU+iCCv4vNV/r0Y/YtCT/eUtW+wXbu25y+goTInd+VsLhli0?=
 =?us-ascii?Q?9qqoAMrpBC06WAl9vceiqMxHq9flqv1qCN6iz28x7KMXDecGPzeCyH8wqmTF?=
 =?us-ascii?Q?btdeFvJBQCKQLdi0srro+vQUxAbOCXkf2jEFhvR8BrHs49Mr/fn6e6z7qJ60?=
 =?us-ascii?Q?DX93ecZiAOFbRd3My7vxrrwsXpKIroYzPch07YLZjOVqmjGKdiAd60cAOzd/?=
 =?us-ascii?Q?hcM6qV0JItHWab8Y2NTdUOwGpne5UkQBObR8g8Q+YnBXD9leqqWPoxi4OntI?=
 =?us-ascii?Q?HZKtlLFUDAPmryJF7ELLp5q8VqDHxdm6dTlHKbqvVx4SBsucovu7nfvilzo1?=
 =?us-ascii?Q?Uf3MOufR9SuNXwcpxlbAud2HoZX/GTvTK/RvO03/jEWInR3lnmRjpoHZ77fs?=
 =?us-ascii?Q?oLWAOBuSS74aJF5lZBv4j9HKJA6LXz8Z12jm1zCVq4OA1cUm5Qq5nvyNBECC?=
 =?us-ascii?Q?2QrXpUmGOMTq/oGmGQLAe7C7jtOHVQsvymACqZm8QBs+9iXh2rZg7o+Oh5oH?=
 =?us-ascii?Q?8g5GA6nvYruCmUOWR/L4JpN5r3PEOHemnwbJ2m8ysq2e4o4m1uYxsWtdwJ7Z?=
 =?us-ascii?Q?gBivbfHG7vx9+9jAKdfS3ePnK4403KiAqzcS52unDN+VJ6L0qc/f6GNpiIWj?=
 =?us-ascii?Q?7o7cKCez4jVn6npwjRgNH3QzTiuyq6fF5PP1vV0OvfrQN7O/dQiI93UowBaT?=
 =?us-ascii?Q?cWAz63Ju0gnC+c9lGg+slKN40LlBHGlbaSJnH11zGnRlRXK4JxiR1KYmp++H?=
 =?us-ascii?Q?TGNbR86uFan/9aaysSJOdZg/2HXr9h0x5M2oel1SuF571ESbhcnrtg/nO+nn?=
 =?us-ascii?Q?oRPOkNGq19cqRYvskR8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b92f437-4615-47a7-9e32-08dbe06c68f6
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 15:07:22.7625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H8T0SQC0mUEgarT49EFbMzj2CIUHu/N0zi2KdFm0gykvTGWvtJKKzjnHumihZ31+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6797
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some GigaDevice ecc_get_status functions use on-stack buffer for
spi_mem_op causes spi_mem_check_op failing, fix the issue by using
spinand scratchbuf.

Fixes: c40c7a990a46 ("mtd: spinand: Add support for GigaDevice GD5F1GQ4UExxG")
Signed-off-by: Han Xu <han.xu@nxp.com>
---
 drivers/mtd/nand/spi/gigadevice.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/gigadevice.c b/drivers/mtd/nand/spi/gigadevice.c
index 987710e09441..6023cba748bb 100644
--- a/drivers/mtd/nand/spi/gigadevice.c
+++ b/drivers/mtd/nand/spi/gigadevice.c
@@ -186,7 +186,7 @@ static int gd5fxgq4uexxg_ecc_get_status(struct spinand_device *spinand,
 {
 	u8 status2;
 	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(GD5FXGQXXEXXG_REG_STATUS2,
-						      &status2);
+						      spinand->scratchbuf);
 	int ret;
 
 	switch (status & STATUS_ECC_MASK) {
@@ -207,6 +207,7 @@ static int gd5fxgq4uexxg_ecc_get_status(struct spinand_device *spinand,
 		 * report the maximum of 4 in this case
 		 */
 		/* bits sorted this way (3...0): ECCS1,ECCS0,ECCSE1,ECCSE0 */
+		status2 = *(spinand->scratchbuf);
 		return ((status & STATUS_ECC_MASK) >> 2) |
 			((status2 & STATUS_ECC_MASK) >> 4);
 
@@ -228,7 +229,7 @@ static int gd5fxgq5xexxg_ecc_get_status(struct spinand_device *spinand,
 {
 	u8 status2;
 	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(GD5FXGQXXEXXG_REG_STATUS2,
-						      &status2);
+						      spinand->scratchbuf);
 	int ret;
 
 	switch (status & STATUS_ECC_MASK) {
@@ -248,6 +249,7 @@ static int gd5fxgq5xexxg_ecc_get_status(struct spinand_device *spinand,
 		 * 1 ... 4 bits are flipped (and corrected)
 		 */
 		/* bits sorted this way (1...0): ECCSE1, ECCSE0 */
+		status2 = *(spinand->scratchbuf);
 		return ((status2 & STATUS_ECC_MASK) >> 4) + 1;
 
 	case STATUS_ECC_UNCOR_ERROR:
-- 
2.34.1

