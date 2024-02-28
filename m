Return-Path: <linux-kernel+bounces-84659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B92E86A9B1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B40E1C2327F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4162C848;
	Wed, 28 Feb 2024 08:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dLJvWI8z"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2052.outbound.protection.outlook.com [40.107.104.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4AE2C6A7;
	Wed, 28 Feb 2024 08:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709108333; cv=fail; b=qGuysjt1521a6EU1sW34V0MyxlTiYexflLT2no3PYzBO0oOr1tuG/gezZjrZ18g1OkgYZzkIpopsboZTw+1KFLV2uMfpeYaqhgxCo6cNfPCBpE4kgTQxAukSuJ5HeRszJ5bN2k/rmrgkgg/tyvzC8iZrpC0SDkyUUe0U6g8Mqeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709108333; c=relaxed/simple;
	bh=KvoII+sSGZLYMnYfVI4vFISKHgwk67iljQGmgFWjXt8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=TkG9lcNsBchjq+zjRtL9mWdFNMQNg3hbZ8qWHAiClbZM9FSUiRtNUM+U7KkwpVTI0MHjywXfQMelGGFvxuOxaIqGNTWTsrVvmbIiYq12hWdvMV/CkIdAZal0CGsJVTQsPmNbJFVbLc2c/6xlOQJ7c/xsP1Un9ZekSgQr9gs4huI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=dLJvWI8z; arc=fail smtp.client-ip=40.107.104.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErnCyGd7lYUUtaaAzlo0J4QIdGA7Vqgj6U8KrFwM5wOGBwhjNVLkRT9eFvc0l1t2hwgFG9lDvCsp8nonsW9JQFPghoNwfNZ/D0pWwnslw6x86sF7ADaID+j+JE98RKeUwKz8ZLN1R1+vyz2Q3xxd+wpguFcJbO3H94Sp6r3z79qZm3T4U+1NvTgH5eHuKd0IUsKyG6GbhvKxYiog5x1Csrgvu2yKk71g8MPF+lQ+OXO/GEdiHvoPKrb5SROwQby52Kz5PQJKEGxGn3hAJq17xt9R7us7hEDwTfnaKtnTGWNUvscOa7FriBD/vGvPLNUKgfepwTTS8QD3tyGarpbTIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oND9I13vQzhBfHaQUU1UiuQC5qfvcfInACe2j0/Jxm0=;
 b=ALdz3BfFSh9pY2wOO7KAd3tEZb8K4uRi9njL/mKWFMQi8Ruqkkr9VPo8cFQerL4Q4yfcC9gSdHt4e5CLagMsuh5y1eCCI6aAJPeMO0FvKCAB4TyZCJYd0MgLqfs6PCBaK2l5lriE4P3eHLx9yhcy9Qelv9A9mEq4wBIcHOwe69U6lXR5c9P7amAXFSzqUktkh0M49SdhI0eUZYaUK9FhLiogMZVeawldotrGBu1e2Wpeos3mvUNYKXntPbHC7Y+fIgPjqY7jpQAMkVw6Yo0aDUhbbRyk+PBQvWvRev+wopVFlyxQouJL/GPyDUogKGnVcrIKUwtTxKiu1h1wKKyMtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oND9I13vQzhBfHaQUU1UiuQC5qfvcfInACe2j0/Jxm0=;
 b=dLJvWI8zlwNZBZjHVBC9J291vrAFoTdUI0lGEkycrIHCjbhzQGhbhBCj6Zosjy0SwzgZ2NnrHkoc45FOgKHamTTM27qjdWKQssrcBszKduEDtQ8TS9MlNiYTkvCxrVutjQqytnNdwWXzfY9TIcKnVH3BK+ciFpiMhwDSddjd+Bc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 08:18:46 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd%4]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 08:18:46 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: abelvesa@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] clk: imx: lpcg-scu: SW workaround for errata (e10858)
Date: Wed, 28 Feb 2024 16:26:49 +0800
Message-Id: <20240228082649.1633083-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8404:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b607ded-b0c9-46da-e3f7-08dc3835e23f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2De6cvvFzKFJktZfL05SGYYJR8txLmW+djvTkqL7mS2pZDhj8u50VKKOlQVG7askkqiMmfvRgiQYWl9hdI48QyhLWZZjVVYdbtpAVNYvSNeTyZx7Lb5FXgByoLjxjQC0F4N+iR/dhZ7gUquyYB+4tuxn2/w6T10bJd73Nxu2kwrQobAesU4Q7sFMt0lBHrnI7xzGIQnMiZmXlihRbrIC/bc/6D/RYQsJekcd3TouIG1FQNMEYQk4t2apMlrGHo3dwxIEkr+r1xYghWi25F9a5nG5wr7GLK93DWfezE5oBboP4sJGu9FVBu+Bt8AUCVHYgCvtQzDQKbUs69IrWn+RfbHYYQQM4S0znUCkWwG2qNItJRGFfkmgR0YQXEceOXM5ET9haTX4MKqXRfbRi8ghgOE4ixaty9cNw0U9g9Tv6gliMqSzUXgXijjIMn6DjnbdPAEWRvHF/RwCF+k6o8lRFBAiv44D7tfgrpE/aBjJKPOhmQihiRQIt7zWveNGsfbr+WF0KhsLIQzVVHd69PPrPx1CXNg2bDHecuUTit+pguQenO9JhrRzvy6iTohTfRr6j7cPBEnW8739t8gVrYWRl99Nye/z7PjLu0IlNqskjkKk0qVVORMbN0NjuGFyREAkd3L4GqPqae8UeCkgQJyGNkrSs7B5Pc9jxrT1rU5RBiLIDSdVgI3CAEJ1DgRSoCQKzfOcyScBMxj6XVI44DHME0OTYNmMXDruqOanbu/+Lqw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8isLEZpi6VpgKakzCojIHQwe+yQH/ccuV0YhIgdL3k06Dn72GeWdaJ0WVnMw?=
 =?us-ascii?Q?fI/goWtVevqqzCAxrvE3I1B5WyhqVexjQpi7EvuVeaNfJHeBsOjNE1ZbcpyC?=
 =?us-ascii?Q?7jM2WvAoGQOCYnaGMInpWYFrNShezWqeupdAqIm/iEEoa3qt4WEHlxnosMPU?=
 =?us-ascii?Q?o/Ov+LLqwebXzsquC4t+pcgK5dui8XoocGUpiS9z6bHELLB+8pq/vK9xuQuc?=
 =?us-ascii?Q?+cOOME310TlLV6zECwiPzT7dJNTBvjNVL2DO4y/4EEsFKyzV84oyd+Twq5ZJ?=
 =?us-ascii?Q?maNnGymToy8oy3d6KTkTpiohow5dMepyTRfHo1qnGn6fhH1WpSeSoQD7IjPk?=
 =?us-ascii?Q?cihcprhCGOqr53D3uAkOJ1HFd62lnKY8UR58N+IELXJKAtUjPaAedFlsLy/m?=
 =?us-ascii?Q?m9soTXbDulxFINuPsz7wg0MZE45mNPedVCNx1ljlFwW9iPWf3H6aZVyuw9rx?=
 =?us-ascii?Q?isxrZ1XFrmOuVbzdzqZ2p4K1I7jVeZM771y7k0fIlOK4u4HhuFr2qH+5ctRj?=
 =?us-ascii?Q?YiJ8PLgmDM5UpdQXLh8qMNGjn5eCnqPSXmSRewIr7hCDFlVdv/UlaC1XUH/m?=
 =?us-ascii?Q?Jifu2mC523TIryPwUsn8I/7k+CmTkWM7ULyVb7oiAPJC7H7YWBwOIvirrGlA?=
 =?us-ascii?Q?q7mh89ipT1lrtO7pjGSo4SUWyAx22hDpTvmxNEtv5sNnt7/oJWjh2xaqO4GB?=
 =?us-ascii?Q?6zQZdEhUMlicuGipyFs2iGRA5Fg2t/35wcrm/6MRMAgjp+MrwxzJjPMs/V9+?=
 =?us-ascii?Q?G3DGIkFbpgElpaHkBY0yYCehjtZVGAf+W9d2jYoc57mjw3uCAi9g9Va/G/FU?=
 =?us-ascii?Q?4Zp1ZBUuyEq8qdaHFbTVqdzpyZV/Egy0gfiHyKuzKgG97n2EKQWfEObVJRQv?=
 =?us-ascii?Q?Jwhc51hEqWmoavay5DmCCgHNqLhnn4wKe2gHxfDcXxGQZv4LQH2mLK4KSQem?=
 =?us-ascii?Q?8SNoeFbn96yqqyP+iCPrnBwioC4a8HA5AsYfJ70WFe2OIZ8YyM6JhQ1+zgth?=
 =?us-ascii?Q?uu2uGKEMCEUTr1BysEF/4NSnqI///c/ZvxaOiRuKRAK9e4xashHOECfl2vfZ?=
 =?us-ascii?Q?goJxCY7zOz9wy7wMdCuTdXQ5ViauNAZki3gl5aRE9XztuDKO+hszUVEu1KzD?=
 =?us-ascii?Q?yPLkQ78tU5U7zNI4TAU8D7fVZy2WsaHFmU6XEonE0TitfTExDuzmmYGpmude?=
 =?us-ascii?Q?FVql0/A8H7ebN6hL5+xoTVXzjsv9PPvUge3AWyh4EZKaVDiJwYEWqe02RHEw?=
 =?us-ascii?Q?Tm45tlhdFW6y/dcDgTx6JwjrH+1gj7782Dj9xifBgDne0fgdQ21Ff+9eKM7J?=
 =?us-ascii?Q?D5AFrnbgp7meTbkDVgtQW9JnHHdk5PllXALshLgp6jP3UQBJFpgKiRAPJ2CQ?=
 =?us-ascii?Q?OCtLfY7zeSIe9u0iBfDQjv91vzZjF/hCUYQGhS7IIrwapG0cNJYIJjzrEJEP?=
 =?us-ascii?Q?jhg1BGatKv9SM+oroDIhONfCGkWtGlHxveG+HTGYZyiClFHE/6NFMPcY+X/y?=
 =?us-ascii?Q?MtBoBOzc2jCsHg3Hu6/cJxs6CG55KFp4rpHb7DlF9FoCOVtJ7WfZ7f5QO998?=
 =?us-ascii?Q?y69bBCbmD5W+6MO9BXwjuoRkQsTYnj9JbrinhM/w?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b607ded-b0c9-46da-e3f7-08dc3835e23f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 08:18:46.2855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UKY3A/lotOqWc1bQSspYJkTKo64f9zF0huiTV0H7DgghPfH70F1b+bSR7WY+T3mZd8jDlbJsz/+o7JdGBCdRmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8404

From: Peng Fan <peng.fan@nxp.com>

Back-to-back LPCG writes can be ignored by the LPCG register due to
a HW bug. The writes need to be separated by at least 4 cycles of
the gated clock.

The workaround is implemented as follows:
1. For clocks running greater than or equal to 24MHz, a read
followed by the write will provide sufficient delay.
2. For clocks running below 24MHz, add a delay of 4 clock cylces
after the write to the LPCG register.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

 This is to upstream a downstream patch that goes through many releases
 in several years. It maybe hard to trigger, but to address potential
 issues, let's add this workaround.

 drivers/clk/imx/clk-lpcg-scu.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/imx/clk-lpcg-scu.c b/drivers/clk/imx/clk-lpcg-scu.c
index dd5abd09f3e2..b30d0f8b5bca 100644
--- a/drivers/clk/imx/clk-lpcg-scu.c
+++ b/drivers/clk/imx/clk-lpcg-scu.c
@@ -6,6 +6,7 @@
 
 #include <linux/bits.h>
 #include <linux/clk-provider.h>
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/slab.h>
@@ -41,6 +42,31 @@ struct clk_lpcg_scu {
 
 #define to_clk_lpcg_scu(_hw) container_of(_hw, struct clk_lpcg_scu, hw)
 
+/* e10858 -LPCG clock gating register synchronization errata */
+static void do_lpcg_workaround(u32 rate, void __iomem *reg, u32 val)
+{
+	writel(val, reg);
+
+	if (rate >= 24000000 || rate == 0) {
+		u32 reg1;
+
+		/*
+		 * The time taken to access the LPCG registers from the AP core
+		 * through the interconnect is longer than the minimum delay
+		 * of 4 clock cycles required by the errata.
+		 * Adding a readl will provide sufficient delay to prevent
+		 * back-to-back writes.
+		 */
+		reg1 = readl(reg);
+	} else {
+		/*
+		 * For clocks running below 24MHz, wait a minimum of
+		 * 4 clock cycles.
+		 */
+		ndelay(4 * (DIV_ROUND_UP(1000000000, rate)));
+	}
+}
+
 static int clk_lpcg_scu_enable(struct clk_hw *hw)
 {
 	struct clk_lpcg_scu *clk = to_clk_lpcg_scu(hw);
@@ -57,7 +83,8 @@ static int clk_lpcg_scu_enable(struct clk_hw *hw)
 		val |= CLK_GATE_SCU_LPCG_HW_SEL;
 
 	reg |= val << clk->bit_idx;
-	writel(reg, clk->reg);
+
+	do_lpcg_workaround(clk_hw_get_rate(hw), clk->reg, reg);
 
 	spin_unlock_irqrestore(&imx_lpcg_scu_lock, flags);
 
@@ -74,7 +101,7 @@ static void clk_lpcg_scu_disable(struct clk_hw *hw)
 
 	reg = readl_relaxed(clk->reg);
 	reg &= ~(CLK_GATE_SCU_LPCG_MASK << clk->bit_idx);
-	writel(reg, clk->reg);
+	do_lpcg_workaround(clk_hw_get_rate(hw), clk->reg, reg);
 
 	spin_unlock_irqrestore(&imx_lpcg_scu_lock, flags);
 }
@@ -151,7 +178,7 @@ static int __maybe_unused imx_clk_lpcg_scu_resume(struct device *dev)
 	 */
 
 	writel(clk->state, clk->reg);
-	writel(clk->state, clk->reg);
+	do_lpcg_workaround(0, clk->reg, clk->state);
 	dev_dbg(dev, "restore lpcg state 0x%x\n", clk->state);
 
 	return 0;
-- 
2.37.1


