Return-Path: <linux-kernel+bounces-134520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A3D89B273
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 16:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5A0A2815B4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 14:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30781383AC;
	Sun,  7 Apr 2024 14:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ZecyKY6U"
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19010001.outbound.protection.outlook.com [52.103.43.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA993771E
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 14:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712499740; cv=fail; b=YP7O8BbXyuUMkwsz3hE5/wRI/gkaAirnuidiz1qBZ2tCpEHfYAwig8qjJhoqq48XSMpAR1Uc/nLMt+dmob6CxbHRWvVmpMM78BHvQiZagZ96npOdOLgLcX9PVLlFkh3n/rstYOgisebudX1kYJFowgwuez/QV9mDitahA2L9oRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712499740; c=relaxed/simple;
	bh=jNMNreVRVpGjqeJy1+txDIH+KX3J5UzfIP+/VXgT9kk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FUe61BBmKMLq3xDkrSkJeJjrRinUvElL1TWsDEc0pS5/agPHqXlctNy3VPZ3s+9gHt7BQxCXW+ejwPp2MlXbP6rREGTp6GT03p/s97G4kjVONsslYXzZgHWd0aNVnyBVShajqEBeGBIV+IU9rkQnyjK8k6t32M4CpMLlyTA+qv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ZecyKY6U; arc=fail smtp.client-ip=52.103.43.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FaZjB93hSBGyxoB3CprOFd7YDKfUamtNezAcimx4hpWrxqoQT8Sv/uv6rYGFlrkx11QkOqBCF4U42RUeZd1UuVFmIU/P4WcS1cNVtfoIJdBEKUhPj4rA82fisFQyDvgmyDZ4zpQUfFYNOKY4Kq0VOZ3D7InowZijGcoykYfv6gUD2B4Y0HdARN8IHpMYvPSiuJE6Og43MDoAiYupHX6qLT483D9fvmLuwfUn3AR7zJ5t3+CPWIEu2st1V5awbuRa6FeiSP1oE097cUvSou4XWfoTSpQX0We15OS8Bmm2obUz6kuOju+HsHhX5i1W8z1yv7GLjc3g7QIf0w7Fb9+zkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAgLMadl1SEcIoWdWcyszlJ3H4oT11pupaSsn42w0Lc=;
 b=LGuTIK9kHP8mKBJRLAGH+HeLEIH7kRLnYNQhopZB+aOznXr1gQonrnQtanSq9qtIaFV1TI/c8G7nIa3pVW1Qky6/8WGGKNR1CzfkbJycYJSYc83oMIh/Ylmlw/IlaR8honM1YdNU0B4qOIgRNYFabcJou0EzyntWDd6ZtuKLqDh5AVq3bx2llOl415463lUTakFcsxwiDF2M9Jh6HvtgP0Hx7yYqtvkVCdKqr9Uf/sXSEAYFOki/a5Re0jpfX0t1D88405MY80bRg0jrKh6mYxC34V4GXk4bSrPpN2gdimUn0ct+xhPUmwaiPEhDR+G5v3QtOSU83B7GP9ns9b50jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAgLMadl1SEcIoWdWcyszlJ3H4oT11pupaSsn42w0Lc=;
 b=ZecyKY6UjthtFDEYl23O+b6GqlfuADDh4AUVnSByTv2vtN7hed8Rtul9As8T1wSiFm10G0IsvrZ0AqgBBHy6q/hKgA0pWZR2iWwlqYEXiRMtH8HpxVRw3SExqHXLVlB1i+1/YUImkkY/XugqlOj4gAHYsqFQjGUg+FCG/7LjaIW9P+6l8rTRbjGBxMGECeEVYjZFwTsrPF08iS7ShTOtobqlt1eeMvGJBj5Avgyn49kUrMwTicBABQsRiwFtbQvzndb/+5zwpaMgGNOSTtls6mv2UGEc6V+6Q15CwSk4aJCLt83teS7jWW3cnBbjwzB3ljRp3tg6G/hwuyp3Lvp4rA==
Received: from TYBP286MB0365.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8022::15)
 by TYCP286MB3681.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Sun, 7 Apr
 2024 14:22:16 +0000
Received: from TYBP286MB0365.JPNP286.PROD.OUTLOOK.COM
 ([fe80::e5f6:e91a:96ef:907b]) by TYBP286MB0365.JPNP286.PROD.OUTLOOK.COM
 ([fe80::e5f6:e91a:96ef:907b%7]) with mapi id 15.20.7409.053; Sun, 7 Apr 2024
 14:22:16 +0000
From: Wenyu Huang <huangwenyuu@outlook.com>
To: robh@kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [drivers/virt] Eliminate uses of of_node_put
Date: Sun,  7 Apr 2024 10:22:12 -0400
Message-ID:
 <TYBP286MB0365B8427A685435695AB1FBAC012@TYBP286MB0365.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [SFHVpQSqwMYhcvjuD35kSPMI1KjMMHPG]
X-ClientProxiedBy: SG2PR02CA0097.apcprd02.prod.outlook.com
 (2603:1096:4:92::13) To TYBP286MB0365.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8022::15)
X-Microsoft-Original-Message-ID:
 <20240407142212.10603-1-huangwenyuu@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYBP286MB0365:EE_|TYCP286MB3681:EE_
X-MS-Office365-Filtering-Correlation-Id: ae5618af-e489-4b0c-3337-08dc570e1ff2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	b0TK1Q6+8Sq+8rkChUWoBatAHrXpqnW3wIZco/Vz+Mlj4PRM2c4QDnZjwmac4YYY6D4M+DxNMb+AGap132ynSKwWVi1o32zJDfnESdpVVb9wHODjOkRoCrxuKYBd0iMz0gYWj6E3UEyPdVncudywIHSW9OfNwHRCS4rK1WksNLV0kbgKHwt89vC4l9ujlMYhI+ufRVA0JM+vmE+3CX4U6Z9tUFmxNejogJVgK6YpDIm+PDwBH/8eg9usptJpldudR5HWfN0v5Sm4GjGv8NvvKWb58oGm0mtdYqVLm97FfNNV98tYv17VxGgMkAbpEPLl8Nht1yQRt2xNAopoKkpow6lHq8bBV1cDhxNKutc1FgrBFvHyXk8VTf8NeOUKBmhft+fIhkGGmYWs24oXw2k6knQMIJmg3hUeD99HOpW1arwycNJ8XtzKhHGaH0unvXHYnCWZv3y4c7ipYnB1rYfxcp7Hpp5CW2MFsgDMYVzjQUdu49A3PX/8cAzresfGOoqY/1IEoCKyad4QH2FOXtCC7vkNLwPISacbM3nKOvAkAsKwGqSLsml3szMszH8+1jpl
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NKdMI2x5eCfofOcsx8E0SG+xLfTwSGLkW/zZnUd1yDygx2o91h+6FOPoUtc+?=
 =?us-ascii?Q?tDsLeNofof7PmTsEdhxcfp5i3YRKtfjM70ynnvR6MaAXYBhk2V+4bf27icVh?=
 =?us-ascii?Q?8VVGZVPLb6hAchB/yBe2nHrSiH5pJZMe3QpF0AvnXBFHVuwskC7++dJtnwri?=
 =?us-ascii?Q?fH7qtHUI8BZMzAFhMcyhrVhec/+7oFzsJKJiLnAakwpfBN7DS6UsaQJ0T8K6?=
 =?us-ascii?Q?Hn2KFvn9QS19QTNtuaxd/DmwQrfBERAiX2F8lYyzOJ3B25AKwQjK9SZADy9u?=
 =?us-ascii?Q?kNLEn93ZtxGF4BA7ZYkZEn+Q2EIMzN2X70pEquHA8p9cz1nMELd74XDOoBN4?=
 =?us-ascii?Q?kvFjInqFXDdMDh3JPmJcVuAN/eVTLRpsMVEel/7+44vmGpb89yvH/DUdAS+3?=
 =?us-ascii?Q?svQcZSodb3UxS12CjFNx2xja+JFMoOhjbmqCiODeX7L31Cto9w11jphfGN2J?=
 =?us-ascii?Q?RW+o+9GMC8reUng/CGaRweZYupnBVWxQYzfHRlt/2QG2BpTTgRH9iq3K2HaG?=
 =?us-ascii?Q?f+J5Ub0ZLhkN8h0kl7lyJorMIvA0acuSOUqDcknz7zRinPVGgPSfNvxo8z5Q?=
 =?us-ascii?Q?gCYOXMjGkOgEphfqD74GNxH59Gk8KV7l8T3cpc4uoHGsOayskfmi95PTxHBq?=
 =?us-ascii?Q?hy6AlU7Dz61AjMS3q9uh+2iIkZ86t2HbHv26AVtSKubbjgkcr7xZYtBsePtK?=
 =?us-ascii?Q?7EYM/dYwlwBqVFrEHxw15e3oWg7BPd+tbXl9aKNyv9tX65VeYMUr1zTVU431?=
 =?us-ascii?Q?p1DtSoLkRZYdtXI2PvtA33+3kHr4FiXK08gKJFzGQtHTNec6XDryHkBmX7r7?=
 =?us-ascii?Q?/s1k7gjtKbFy9ki4nmiRNGol6a8sO50ICiej0NU+Jt5YC07JOvLp1LvDTsFN?=
 =?us-ascii?Q?AOUG6kqleI3nAMzhJq208Eby5A1VIJT+ohPhNF+mz7aaz+L0w9HVVkCCyxlz?=
 =?us-ascii?Q?4KDb7Cp3sK10VQ7VCryGxkCA5VTsM3JafcZIIy7VeHVigU+AHmhU0Q6xeHJI?=
 =?us-ascii?Q?orrT7itzZwa9Lnmyah/lKbSZUwIUq8sEWmbnwaZ97lv8yW8eiivhIVpAv359?=
 =?us-ascii?Q?9+epv/kK8TtjLhRY0mEMAHa3EIcIn8t7XW40jtzoc60OZLR2MZzOZTNcmF+K?=
 =?us-ascii?Q?BzpI3NSt8M9K++cXCdA7lnaTeozOpacxWKrgCYfSSIrl8Iz+bof4tTosxsfx?=
 =?us-ascii?Q?t/0h836qVKosKSJn3TdlN7SHVq5mUmFaXZc0ub8bBN1MrjpRQ86RvUv3Fek9?=
 =?us-ascii?Q?UhP+HbeWPbApOWH0wUta?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae5618af-e489-4b0c-3337-08dc570e1ff2
X-MS-Exchange-CrossTenant-AuthSource: TYBP286MB0365.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2024 14:22:16.2467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3681

Convert the DT code to use __free() based cleanups for
of_node_put(). Using __free() simplifies function exit
handling.

Signed-off-by: Wenyu Huang <huangwenyuu@outlook.com>
---
 drivers/virt/fsl_hypervisor.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/virt/fsl_hypervisor.c b/drivers/virt/fsl_hypervisor.c
index e92e2ceb12a4..5a5c7a767a98 100644
--- a/drivers/virt/fsl_hypervisor.c
+++ b/drivers/virt/fsl_hypervisor.c
@@ -725,12 +725,11 @@ static irqreturn_t fsl_hv_shutdown_isr(int irq, void *data)
  */
 static int get_parent_handle(struct device_node *np)
 {
-	struct device_node *parent;
+	struct device_node *parent __free(device_node) = of_get_parent(np);
 	const uint32_t *prop;
 	uint32_t handle;
 	int len;
 
-	parent = of_get_parent(np);
 	if (!parent)
 		/* It's not really possible for this to fail */
 		return -ENODEV;
@@ -745,12 +744,10 @@ static int get_parent_handle(struct device_node *np)
 
 	if (!prop || (len != sizeof(uint32_t))) {
 		/* This can happen only if the node is malformed */
-		of_node_put(parent);
 		return -ENODEV;
 	}
 
 	handle = be32_to_cpup(prop);
-	of_node_put(parent);
 
 	return handle;
 }
@@ -789,17 +786,14 @@ EXPORT_SYMBOL(fsl_hv_failover_unregister);
  */
 static int has_fsl_hypervisor(void)
 {
-	struct device_node *node;
+	struct device_node *node __free(device_node) = of_find_node_by_path("/hypervisor");
 	int ret;
 
-	node = of_find_node_by_path("/hypervisor");
 	if (!node)
 		return 0;
 
 	ret = of_property_present(node, "fsl,hv-version");
 
-	of_node_put(node);
-
 	return ret;
 }
 
-- 
2.34.1


