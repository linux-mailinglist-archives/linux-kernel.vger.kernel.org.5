Return-Path: <linux-kernel+bounces-103514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E6E87C076
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0CCF1F23846
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C172373539;
	Thu, 14 Mar 2024 15:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="keUc/O6R"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04olkn2103.outbound.protection.outlook.com [40.92.47.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B8A7350F;
	Thu, 14 Mar 2024 15:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.47.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710430649; cv=fail; b=ACAiPhZiFpAHVHISPrcq9vuLOiUsSemLBN03Z8A4b2VUtQ38zO3q+KfylmhJXxic5I5+jLHZihKC+QV5bTJUukbBA8+RVy+HhVpJMTbOWCunZxskuhoSwAhFlTzNDkGdyQSplBQ/QZceUZEGvzcWaSaUfMizOD2PVjD28fZTgEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710430649; c=relaxed/simple;
	bh=cHB5Bd3AQvD4qN37/en3h/15oj4vABf1xasMvTLVjTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qFA0Ag02Z0HKLuSyXrv9gaUXDqWlJAs8VnF8/z9nrbtpP9pFG3hdjQXXiDdCCUcpe2+Mqq88E61eJ3Vuut9yNgtXMciFRPV+gljGLLX2sbO8xJFMX/QQl1xyC+QOSJ1o7u6Eo+SRdF/yvTz6OeljHifB6LAbyxb47TeYnCWE86g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=keUc/O6R; arc=fail smtp.client-ip=40.92.47.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8gPKnIr8mZBXkmS5KSF056+hBvwB97DRnk/LUNY919gKf0oXyumMPlXY7W0ObxIMDrY4tSS+5jWOnmOwiSKtxlhN94hN75ZqFcn/NcMEXIOQ9fXu91YsYofayT0jANysVy2lo2R9KGRGCTR7c+UErBl1EvfruhXqDKbeH2DVRNGP4QuOv69y6zlBZt5M9USvXuJ6xdDy8rsnhltLuOZUHA/BTr0f8HKsEwZQjT3eO+DqZRg3YNm4gzhD9f1hI+JLLfPMndt/KBoF6VtmbaJVpDzfBvhBdbvus3ue+P053+bZXND6pRrmN8ILNKeiULG24DmjZeH3pQp7EC+jX3FwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTWLBrb4fL4nzNjk3Tbhv6WCgSXloJeYw3KGYpXWzDY=;
 b=LrcWuHEQBCMvBxzsIoNkcFF5Lz7FqWnvMJcyvTlgSNRZCTKdwROOtgc0ehUc2jKdOYbvYqkgJq2we1EWRYGym9YTaOwtk6dN+D9+W9uOqWZo+JLBU/NmjIAe60/W+uembFOhpYswZF6j1fSPui6sUyjhMxpwH8n24dmBgI2e4A1ATq6aeK85U//zlajLwGdb7fK44ywem42uvCLczdfDSrhtO/CfiqIXAWpMii4zn1qAvdciMR5jTzbqx2g5iii/0qwwzoY/L1GM+YCEliN9yX92y8Ew09A3ld69dam0wmuOSVs2kmG2DtUZLmI9iAbmwTN4MynXVD2z9fRRaLYcCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTWLBrb4fL4nzNjk3Tbhv6WCgSXloJeYw3KGYpXWzDY=;
 b=keUc/O6Rt0+FSiB2wuC4YT/uGqmqwdENDaTrR9tUZd23w52RPaNaaZBiM6oa1wXIvTPm++C5bORwSjxGRDsyBJEnf8swwuNAsbO6CbM41PzeyIhG9NHLPuCJkPtnK+sL8CmdO2PfbXInKKDVNtXknEcnk+dnu/HyHvm8R3z+uqkVGbq0t1PSM5jFPsoW3s5ICBI0CqnWnUkxwsAI2LKrTAJxuCXAGCM9BcKb5KD7kATL+GIw14609/+bbF9GFaTSTfP6Nd/1m9GiIRy0VSXmGffqLsZU/kIZGvopeWVouD3PVVAcHXqo0b5aS5ipVanZoh7eDRBmCDBb533c6B7F+Q==
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1ac::6)
 by PH7P220MB1063.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:31f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 14 Mar
 2024 15:37:24 +0000
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::57aa:102b:db4b:e05]) by LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::57aa:102b:db4b:e05%7]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 15:37:24 +0000
From: Min Li <lnimi@hotmail.com>
To: richardcochran@gmail.com,
	lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: [PATCH net-next v7 3/5] ptp: clockmatrix: dco input-to-output delay is 20 FOD cycles + 8ns
Date: Thu, 14 Mar 2024 11:37:05 -0400
Message-ID:
 <LV3P220MB12024218A95DD4D17DCAAF59A0292@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240314153707.31551-1-lnimi@hotmail.com>
References: <20240314153707.31551-1-lnimi@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [4pGlyp3N7cOO278St41PqinubMPgCecZ]
X-ClientProxiedBy: YQBPR0101CA0208.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::31) To LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:1ac::6)
X-Microsoft-Original-Message-ID: <20240314153707.31551-3-lnimi@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3P220MB1202:EE_|PH7P220MB1063:EE_
X-MS-Office365-Filtering-Correlation-Id: 866e1b6f-5007-4e1a-b628-08dc443ca580
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BCgt5mQEkcxiucpyKK8aBGfXp2ZjpOkfDUPhS1TybMPGMecVtHaSbXloMbp7/i8XiOM/oONdJguV5tfuhXh5eYAQXCc4Td8sCIYL1vwDtVrdZXOD9wp0J01h2cRB28mQhGGvuW7Rrn8Y7b5cMby2jkSp7B5x687GzfOgYPEvnHF0e86JkfWT6+hDpWsAI1sUUz7/0Df0/pWcRyAJa/xun9S9zTIjCYvq3Yp4we2awAsgyGkmi3D1u0DrXwLVf/9JEHLnaTKu8LJm++hbK+TghX4EdXuDYTDg9RefV8GIVyhiUWX1487d4/BqCk/iKAkTI+YS6CN0B9xChPzogiBqy6c/97W85wbIXrjFdrj0duxDlDNIx3bdP4RSa/n58lr95fHW5sn4tKjwRFYoGgkQJvlqDg2l4bTZ4ZT/TQc9phi70GU6gle1bXTpO9FWfVuTtUHtNJyv+QTjKKyOFj2zQV062yqPWGZP2yJ+4DHKU4gSEuz/7/SrqqIpvhzJo94SJVCf45b56Xs/SybsVU6GsRVD4JL7sbpcD5xSGeGcj89LbuEzrdWP9pXZI9MibRQn
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2RUJkGyFdzhQaXZ3GKVbAU/NkyP3wvNdpeGVeHgM0JwGe5bFkM3BkGDXjSyg?=
 =?us-ascii?Q?pfQbCPMMyX+tP9aZ4em7BsbBANg1/xV4re4eGtUuPFNupObuJqxlKJOQmROV?=
 =?us-ascii?Q?EI5/vDvydPgrOxu+kSrOnR/ZLj+p6Z5J9P51ahw3hpchip2K4PLdyThlSrtr?=
 =?us-ascii?Q?tICMhl6Bx1Es3oXSH54K7AlKS2fw74RO3DZStmIm9vntA0zN4kSWYG4qo25J?=
 =?us-ascii?Q?FHL6cCKVB3e1qg4aKutgZucYYLtTuTiTInnQF75Tg7e3pzNlbf7uMXPzz0f2?=
 =?us-ascii?Q?jI79aTzw4tONX76pMhOgGygLISTTnIWd3+4vFvQEdf6L5p+hc4feR8yKG/MS?=
 =?us-ascii?Q?+7F41gBkmRUuvsNKFZ2MkChB8WZK0k97ytAd0jXyV+0VOGwqXcK3h0LQALnQ?=
 =?us-ascii?Q?t8miUi51wl5nJjWRwY6OgmwmdSuFrLTUSZpJDeR9ZnWirDINw+oRB1cXfv7E?=
 =?us-ascii?Q?S77DRCGH/6z+riQXdLpzZ9fYzk6ijljsN4iVOR8RItqLbo/3T4vyCgyrVGwi?=
 =?us-ascii?Q?GrEIrPZIR9UZcxdXiCBjFi1OqG12lsOC9AnJBHhCSjmOF/sqflr1h86EZiN0?=
 =?us-ascii?Q?CeHR2EEMtDxo+sjsDhNgB+g/mwMy1nToG+cTIyahZ/XOC+4C2ax2a324e/BC?=
 =?us-ascii?Q?10FC9lId7wTEzUr7NVWPWu0vH09JBJVgUnUpolav+X1FEDFTFO/6uFil16zC?=
 =?us-ascii?Q?SgP8E2TBsCD06ZFgsCvj0IJ1hCypEUlreyqL8heGm4WWCtRc59/aSeQVcb6T?=
 =?us-ascii?Q?A6g9ez//Uheu5ouluLp4kXvNdLHMG2uO7Hn8aF6BaOGJLyxSNEJUYBXVwT7i?=
 =?us-ascii?Q?3stULtN9hi7aa41GvOCJbCk4ZmRSuztEJgZ3N2y3su1SD1RAWhajNgy1EdVc?=
 =?us-ascii?Q?LRHKLSPtg7nL2pTrJvlgaXfn5+5qXTKGnIkyFhy8Tzwy+UVmLme+e6LBwusi?=
 =?us-ascii?Q?erSLe3uV10xOcZoz0abNS/KTkcZtRpYx9LelFf4yIT09dpQ6gh+6I6VTY9YN?=
 =?us-ascii?Q?uXaiGUD/qFfX8tHybErejKzP+jCKS4iyNluKyKDLqqF+NKZl5pD6lM8f1def?=
 =?us-ascii?Q?I24doo+rjPSdGsWO3VEQ0rchVSqD95IsJyacILA52nLlFr8MBLmpUxbEOc8Q?=
 =?us-ascii?Q?xaHP+L1Joej2esMgttBvfzNJcDylx4RMytRb5IHJoUliAtwJ8pv/MfhcZGip?=
 =?us-ascii?Q?Pa8IymAvpcgcPmgxUhsJXODkDXLoll8rlcDmfBqtIgx40UR1kLzkQpNgKNU?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3458f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 866e1b6f-5007-4e1a-b628-08dc443ca580
X-MS-Exchange-CrossTenant-AuthSource: LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 15:37:24.8125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7P220MB1063

From: Min Li <min.li.xe@renesas.com>

Set dco input-to-output delay is 20 FOD cycles + 8ns

Signed-off-by: Min Li <min.li.xe@renesas.com>
---
 drivers/ptp/ptp_clockmatrix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ptp/ptp_clockmatrix.c b/drivers/ptp/ptp_clockmatrix.c
index d069b6e451ef..21f3a2c179f5 100644
--- a/drivers/ptp/ptp_clockmatrix.c
+++ b/drivers/ptp/ptp_clockmatrix.c
@@ -2165,7 +2165,7 @@ static int configure_channel_pll(struct idtcm_channel *channel)
 
 /*
  * Compensate for the PTP DCO input-to-output delay.
- * This delay is 18 FOD cycles.
+ * This delay is 20 FOD cycles + 8ns.
  */
 static u32 idtcm_get_dco_delay(struct idtcm_channel *channel)
 {
@@ -2196,7 +2196,7 @@ static u32 idtcm_get_dco_delay(struct idtcm_channel *channel)
 	fodFreq = (u32)div_u64(m, n);
 
 	if (fodFreq >= 500000000)
-		return (u32)div_u64(18 * (u64)NSEC_PER_SEC, fodFreq);
+		return (u32)div_u64(20 * (u64)NSEC_PER_SEC, fodFreq) + 8;
 
 	return 0;
 }
-- 
2.39.2


