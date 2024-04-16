Return-Path: <linux-kernel+bounces-146270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 391CF8A630C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7FD41F2414E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3993C08F;
	Tue, 16 Apr 2024 05:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UCT7KK+P"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2086.outbound.protection.outlook.com [40.107.105.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DA23B2A1;
	Tue, 16 Apr 2024 05:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713245731; cv=fail; b=tuWQgyPgxS7KuVZdCjR4BBSNfD1Z+dEkx7q35HHnyfecyAJTJ4WoFgCO0LK0Y8DZGQlGtfR8cZRTSXbX6tHh86WJMjjSBXMewCpHMhNx/3bqngZ3oOy4ra9vklI9zLGTeu3ahIjWz23mFVsFrCcwbQYGl/dmNTOmWH5TUDE/DnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713245731; c=relaxed/simple;
	bh=LSOodaygwSW3sRD6LzwAg9nS6k7thOyc7l72qs3NfEo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nVKdFrPEsPCQkiQl6iVN4PODaKFsBZY7Ph8qYSUjJsyH9iiYT48RJ/HH/eXevaXNUL3ji6eKJvBIp6/4aAl5hWgERgnExcKr1lH12Xgcymv4E8pyUoSgsxHL0dFXfXsV7BcST01K4qxW8P52DA4ewBqRbRR+4hLd2Z2AlADq31U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=UCT7KK+P; arc=fail smtp.client-ip=40.107.105.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oC4ekjR7WwAWzAHJpqoHfVlSnXGldLMDS34bh5knsLEmoMOwYCt7xj5C9HRRTxIYH+q1D0B+kQSlCW8IlsyRYaRFJws76RuypqnsTU6JZugbfGwuqxv3tXRqfZdwYZvwT+fgpvMI0UANs2E6oxax1yLeGR5ApuvXoCmIjgBGgmehxKee/w28HjNt8VtrfaPLSyCWhIPnR1ScJlRQicMseF3ykh1Y3+pn//aXJh9NK8g4XflLRzCLlustuMdZbutI0arm1wo70cTSIn/lD0QdFQxEPc/SlgYCcUDAvOuGgHvrqfhR0Cbc6NNE89QvBzpdiSpVBrALeNwtmOMT9Fplsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9dHbqlb6WS0vAMXVT+URprFFq6pry1DF7oUCydrVcmY=;
 b=LpFpxf2kqtzhJytqt5Wl64yVIRSm8F9NV5O5aFo3Z6npoRTREH86DHo13Tb8zSE1v5raYtQG/2Ah18wy5eH5CZyR/tyUL95p15K9/VhgcUVQcts4K8OkVlJxT3Sauvby3XRFfPOAsbFndWQXEKgEeGlhtiTRkyttU/o1t1jYKC2svMhYOsEtdZeSnHj6nFtnT9uuhpDofTcY8JD9BjROi0PwL2Oa13JOuPppiolnnyAxrzDdRj9Z1TSE/sQm23P3Wcf2PDRkTKeQxFqoFpo3A4VR6lPdFjeCi286YTAfeF/RPSL0SfSO3n4EUN27cNO1/V3woybTgO1o/mWJUQxFKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dHbqlb6WS0vAMXVT+URprFFq6pry1DF7oUCydrVcmY=;
 b=UCT7KK+P7Z5xR8YPjzyXiJCWf0blDqc0N3fj/GFqgWdzFz6I8DkFlwar3me8X40DveLrOVSlJZLf0XUjwKTzYoWcRJkE7hIV8tOU2mpaRb5nS4Ow+zKKmwweUrr/ib+bo2JTd1E77oFiyWH+ouTWwGQSIx+LACZhOQtSWM+cAng=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by DB9PR04MB8122.eurprd04.prod.outlook.com (2603:10a6:10:25d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 05:35:27 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::33cc:db75:c850:63a4]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::33cc:db75:c850:63a4%2]) with mapi id 15.20.7409.042; Tue, 16 Apr 2024
 05:35:27 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: gaurav.jain@nxp.com,
	horia.geanta@nxp.com,
	V.Sethi@nxp.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	iuliana.prodan@nxp.com,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-imx@nxp.com
Cc: Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v3 1/2] caam: init-clk based on caam-page0-access
Date: Tue, 16 Apr 2024 11:03:02 +0530
Message-Id: <20240416053303.421259-2-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416053303.421259-1-pankaj.gupta@nxp.com>
References: <20240416053303.421259-1-pankaj.gupta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0077.apcprd02.prod.outlook.com
 (2603:1096:4:90::17) To AM9PR04MB8604.eurprd04.prod.outlook.com
 (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|DB9PR04MB8122:EE_
X-MS-Office365-Filtering-Correlation-Id: 19ecc1e0-33da-4522-8d77-08dc5dd705b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lwWzHzPl2lbfzIyAg6DyZuhDZFDugVcUBh+ScEkbxr8XGHQfdtjsHhD/57GVmdO/+NQmvGwYMgwF+V5knm1HUH/Rh3gdrTMRGfkXgPtCrZdCD9/aXj5zfq4Bes/eRjcHnU1oUqS3o1iJOq4yjXG0q9XudYtHk0VxWfySwfH75h4Vm3PVYkmSydumOfVuUnDxJWIzIeSQuIPf3WsGhRhgdBKIkzuBLQWNn7/l0XagmOGwvYWmYHhaCAeIeBPlPeVtJdM7efX16yeUd8pDHf4EiD97h6Odfzi3Z7UjDh7oxZXSSw0aU+4r8rU9E6iW1GzX5DTS7XqQTc7cVRmqEvgACwGrt1ZL5C+kVFt0nVeJJKfDdBn7c1OVFEWPL26YjMBB/au9zFjggBfdn0x4NwtUpdAE7ITKvqBFG0NgX6lvsqFAb8r1qOktHI0x1L5GJpNxr8ki0V+B/TYsx5r1WAheAd53taxgsi+ghRGdCzSpqfH1rQuHYg6sCWLttKrDOSAUhbG1XOGtn2bVzxG7W5Waj78bpclD9T6oBasNbVZeUWnN78UVPrULRJgCehkvgo62T/JU16Y+9CEFMM9M6bHQMiwtBvPiUE1J4LYjmjLNa6J5mZiD+kA7h3d7Ij+Qb3JVVYQLSV7QnifcaXA0WZ0zyaScV1XXFZyndf/olNG+eZj5fmneBaEsiVrjQ8epNI+TnMaJXPns5fOR7PuqVTQVO1mg/WFMPlEFXEUog3TmQgY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ARcxOr+3Qwaxinvq0Q5bogaafTsVnZm/HsEgLwnt0GSDsJrGTM9GJVOxh5SG?=
 =?us-ascii?Q?MVxxvUan/uafm8An1DtsVtV1Bo9f2lDg5/lxElo1S+CkwDj6w0etiF3AdI3D?=
 =?us-ascii?Q?Fej0rjBYdZ848aPPzcPARCc9Ndik32rokgYG3lgQc/4zr/1oTNO31E7xqhJW?=
 =?us-ascii?Q?5E6DHu6xTV7TXdrMJX+Ki0nZfmtismyXOxMp+HNXo3i8bjMLLx70NxdYU95q?=
 =?us-ascii?Q?IZOkW+ILuUQ15orIRn+pYpRBnzeFuop1mTyyzroGOfkdEhgNEzEzTTDnOhGv?=
 =?us-ascii?Q?NCoxh/EkhVA5iIFVBKChWbvhlCV5eydc5PwDK5pYZ8zauL2cRgqfPy3Rhc9+?=
 =?us-ascii?Q?izrOk4rtBglBMJROkzfpGrNBx2SC5GlzG4NSOdyud5hitz38CuW1ohN0IV4W?=
 =?us-ascii?Q?qKHZebWQ7i412a2nIThfN4earVF/IDBAqV8onct6F0XYBN1/RA87Fd12kcsA?=
 =?us-ascii?Q?1hooPwPopOnfyNkjTckiXXte6KUanSNGeWo+t0WE6N9MZEXdAVO9T+NXqNnD?=
 =?us-ascii?Q?R0WsnGyH/lidD/51+KMtWaRYzxqaEMTDuFANo41K38M03EpMCcc9pl8/lNLU?=
 =?us-ascii?Q?KqAEX6lg7KFN3U8kFOFJXmvwhnP3MvmXCaiH+fo66ypUIlvFgaDH5CayGjyq?=
 =?us-ascii?Q?5f0q8XZlconQS0YofVwaFjeX3R1zqpcOKxM7LQbbRbfGZJawhluSscaDM5me?=
 =?us-ascii?Q?C+GxsSrnZbUyRG0sq7g7ZZt0RxYKzGdTVj9e2vrPkx4y0XiORiC9hXqs1V1I?=
 =?us-ascii?Q?JlcPylQeMmrFh17q9xVERte/d50PH3TjG1xMFA80RLH9up+h1QKDTMYnlcvo?=
 =?us-ascii?Q?MJIH7679hTuWB6HaFBXQJkx6otps31D/BpFTxlZnjv5kkf5U+zAI7WtxkJWl?=
 =?us-ascii?Q?RzbU1zQOUsTWcE6x0OfJqa17ErjyPhdV0hh9F+y7pKwBX7RnrfD+yNEvZpXQ?=
 =?us-ascii?Q?tbQZTFL1VJpIHGdgqOIiDF0d8HjFJIfp1CVjyKnYMtnHqQrpr0PGY6ANcaqS?=
 =?us-ascii?Q?xOZaYVncIy4tfunGFMoBaoxI4g/d1gcWEUgW0kl4IUBY/1b+ZDlWvACkmmNQ?=
 =?us-ascii?Q?6EzZhqdD2eP+vSBRDjNzD9ovoNsNlhVspwRRfyEh2OctWGepXFZp8J4aWBzi?=
 =?us-ascii?Q?iZCk4m3Q2NZe5Dj/HDxpSTvavI2hW5dcm2DJgQu5WK7M+y1DRZgN/sCAqzIi?=
 =?us-ascii?Q?Hw7JQote7ZN/NMm//CBVDPpASY9LVDvApudcJ4xokiOtzMI1pAcMC7lU4Yee?=
 =?us-ascii?Q?gKTHMVQNK+DKDSTVHTC34btqia/igawCBScgPY8OUQaMjjuHefmo+0M5aFct?=
 =?us-ascii?Q?cpqP/hJ6rQOq5ejicVLFS3C/NsG7LB1IfjyZN0ixRSxK+R3M/tVvRenr/+I4?=
 =?us-ascii?Q?EpJK7tF40F9A6/y6tqmhoOyCKg2V7rbY0pDeZrvIrmH+BWghtWlagDSbrfw3?=
 =?us-ascii?Q?d8I7PIVdlcE1GblKtwBBZLmnOPmbbNG7AUpdAYM+clRlzoyI9uId2c4NIIgK?=
 =?us-ascii?Q?S/MPyYIg3At2zgxasc0gO12avi2Z/LDVyAGU5LNYdKRYCyr5zyPl93rQ41UN?=
 =?us-ascii?Q?SDf4/zUGZMO2igu9jYKxlg29vhbpqb5wYRcX/Xe4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ecc1e0-33da-4522-8d77-08dc5dd705b4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 05:35:27.7269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k1mcXqH8oJqxebCCv9cmE+gpWc6pg32liSx31kcu//2F23q77RkSbBH8klD4UGXSmTLrSV5jRSgzbJ2x/g+2bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8122

CAAM clock initializat is done based on the basis of soc specific
info stored in struct caam_imx_data:
- caam-page0-access flag
- num_clks

CAAM driver needs to be aware of access rights to CAAM control page
i.e., page0, to do things differently.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 drivers/crypto/caam/ctrl.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index bdf367f3f679..247d42aa32df 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -512,6 +512,7 @@ static const struct of_device_id caam_match[] = {
 MODULE_DEVICE_TABLE(of, caam_match);
 
 struct caam_imx_data {
+	bool page0_access;
 	const struct clk_bulk_data *clks;
 	int num_clks;
 };
@@ -524,6 +525,7 @@ static const struct clk_bulk_data caam_imx6_clks[] = {
 };
 
 static const struct caam_imx_data caam_imx6_data = {
+	.page0_access = true,
 	.clks = caam_imx6_clks,
 	.num_clks = ARRAY_SIZE(caam_imx6_clks),
 };
@@ -534,6 +536,7 @@ static const struct clk_bulk_data caam_imx7_clks[] = {
 };
 
 static const struct caam_imx_data caam_imx7_data = {
+	.page0_access = true,
 	.clks = caam_imx7_clks,
 	.num_clks = ARRAY_SIZE(caam_imx7_clks),
 };
@@ -545,6 +548,7 @@ static const struct clk_bulk_data caam_imx6ul_clks[] = {
 };
 
 static const struct caam_imx_data caam_imx6ul_data = {
+	.page0_access = true,
 	.clks = caam_imx6ul_clks,
 	.num_clks = ARRAY_SIZE(caam_imx6ul_clks),
 };
@@ -554,6 +558,7 @@ static const struct clk_bulk_data caam_vf610_clks[] = {
 };
 
 static const struct caam_imx_data caam_vf610_data = {
+	.page0_access = true,
 	.clks = caam_vf610_clks,
 	.num_clks = ARRAY_SIZE(caam_vf610_clks),
 };
@@ -860,6 +865,7 @@ static int caam_probe(struct platform_device *pdev)
 	int pg_size;
 	int BLOCK_OFFSET = 0;
 	bool reg_access = true;
+	const struct caam_imx_data *imx_soc_data;
 
 	ctrlpriv = devm_kzalloc(&pdev->dev, sizeof(*ctrlpriv), GFP_KERNEL);
 	if (!ctrlpriv)
@@ -889,17 +895,25 @@ static int caam_probe(struct platform_device *pdev)
 
 		reg_access = !ctrlpriv->optee_en;
 
-		if (!imx_soc_match->data) {
+		if (imx_soc_match->data) {
 			dev_err(dev, "No clock data provided for i.MX SoC");
 			return -EINVAL;
 		}
 
+		imx_soc_data = imx_soc_match->data;
+		reg_access = reg_access && imx_soc_data->page0_access;
+		/*
+		 * CAAM clocks cannot be controlled from kernel.
+		 */
+		if (!imx_soc_data->num_clks)
+			goto iomap_ctrl;
+
 		ret = init_clocks(dev, imx_soc_match->data);
 		if (ret)
 			return ret;
 	}
 
-
+iomap_ctrl:
 	/* Get configuration properties from device tree */
 	/* First, get register page */
 	ctrl = devm_of_iomap(dev, nprop, 0, NULL);
-- 
2.34.1


