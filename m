Return-Path: <linux-kernel+bounces-96110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A86087573C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD938B21362
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C109136666;
	Thu,  7 Mar 2024 19:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="N+fFXJ8h"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865C313698F
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 19:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709839904; cv=fail; b=i+RFl0/LEMKnnHlIXg/z8L1W2AGYLSqtj98Y9fcfo0LFdeK2FBN+CSTeG6o9myKzK3KuwdJ6oNj7hTxet8vTkCggCHavQk8XLnZRoujrCNl+RVIpQhWZJQcKSt75j4hZUvzHxOs26z1TiuTKZLzzw2ui9DA4TlDD93h6n0Xxfs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709839904; c=relaxed/simple;
	bh=FaWqwkM/Mv39zyl/Ye/sLbPJ2BUgWBEK1zYJDXdgRDs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ZbJKKbCbjM+1BeINlmzoOYba1IsBJ6IGeh+we7F4jv2kg60zrRkyyITAcjLVE6TlbX0Mqi6fi/6Y29skeBZco47hXmacYiJINhqqnFURDT8zSV1cV+RIOdj5CyWkzUbkGMym5lGZ5i1EMINj1sSSF/xBisjs8u3LieK2cZsHi08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=N+fFXJ8h; arc=fail smtp.client-ip=40.107.236.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bm6cdIwZN1jIHyCP2ofY8kBnUhLll8Y0N4YVerCVfxoMWYGyNrwzS4ORTVv1G7NTDL1TPHNX+zcWOTD2jxYgq9qWHkV7ez+ZgJzBcCytybIeDEGf3nIq2I1M14CwE/5Nq09+OaT46x1jxsYZaTZi3N0/fic52WrwXwckjnEJf12/pXOczq7iRa3TtaMoNTl1TqYDINorCea6iwtuZqQpHD6vKn5wPXk10J0345t9TeC8UOmEVy/q/XzsW35tVBhvqISbwVit9SWg03xtk4+fKC5Mz1kupO8Pj0A2iArdtfjo43zBRCcjRHZZFwVognVANET7nUoS42wWxzc6WNIbVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOcG1X+EwsyMmoKcrc3U9RdhztbNjKGI9ikft24P06E=;
 b=R3e4dtkqVIhPk6jpJV7oiYE0j5tjEEoS0jbihclSfyveEoP/UgskNzcKEKnWvD/dskD71M8srYieRsX7QiLeeVn08ZB/clU54bRBTV3L5qNbAJA7OEVRB4AKmRObXZj97CxEf8xTr2kq1weiv4ml/wkJXS7OAhSJcSOqYVhuY15hOVzNeosYgBjjxVlxL0TuZPVFqpfyQjI7UVblk58cYx0iSPyrt1YVhabpYJnlRHXlVJOxxr9OwRgkPgx3CRB+O4lzoAAuKgn6aR6ysy3qLPkO5j/g1f8TdCe1yfUH87OjLieLNrB/SeL7Dkk9z3lg6UdzLn/zkkVNGGEEm4dxuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOcG1X+EwsyMmoKcrc3U9RdhztbNjKGI9ikft24P06E=;
 b=N+fFXJ8hbEi1DFjg3khrwJ+RFV/nQ4KeKIVnZha9oocJfsh4Ep4vthQ+f6Rcubkee6x45ZhLOEEFMmImDbTTUeAnNokwFE6LgUf9lop97PEG5I3hF5LUz0LliDOty7Z9PC2GnkWTQQ6VM2lesCDBkYg0F6nGTGOO9aX5oD8dvtA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8257.prod.exchangelabs.com (2603:10b6:a03:53d::8) by
 CO6PR01MB7420.prod.exchangelabs.com (2603:10b6:303:137::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.27; Thu, 7 Mar 2024 19:31:36 +0000
Received: from SJ2PR01MB8257.prod.exchangelabs.com
 ([fe80::ecb2:1446:ac3:26b2]) by SJ2PR01MB8257.prod.exchangelabs.com
 ([fe80::ecb2:1446:ac3:26b2%4]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 19:31:35 +0000
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Besar Wicaksono <bwicaksono@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Raag Jadav <raag.jadav@intel.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf: arm_cspmu: Don't touch interrupt registers if no interrupt was assigned
Date: Thu,  7 Mar 2024 11:31:04 -0800
Message-Id: <20240307193104.58302-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0237.namprd03.prod.outlook.com
 (2603:10b6:610:e7::32) To SJ2PR01MB8257.prod.exchangelabs.com
 (2603:10b6:a03:53d::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8257:EE_|CO6PR01MB7420:EE_
X-MS-Office365-Filtering-Correlation-Id: 3de6f30a-5eee-47b7-defd-08dc3edd3388
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/xtbByf/tLq3v4tTF7gOeDpQJwwmCqDyhKgZOUIgqjBk3U8gLHnCdFjOPDW6aqBBo3DnBZJwdFx8/kk+e5ZDqLqnbNfp6PEUC24kGBbej85jtEFbWsOiWKEYn8o9erEoPCcdvLqV2UkdK2/sCusV/mbNnN5K3eKywHcP6rE2qxcqAyVS9PDNRrxlet/7V4JBWwa8h1zYYrtUwWXNi9jnv5yjV8SN/wS7CFJLuJgX27aBReiV3Yce1iobKrozhHNWteHHbcgbgOWIAXHEHhOil4vzUy4KWiNnBHjo4g0D1T5yKubrtKR6d13YuQ/9Ue0QEOiPR/I/CsN9yQ5p6GO4SSsoOEk06RbyafFazapayZoav11WAfHn0KI1TOComrhNEici/Wz2E4icbouYFoZC/Hy9ajhjqCRTVWXHpP3k4uWh058WzqbLc1ALtYHSu66kMC2LkSTff0zHdsQULJyOSruHMaYzEd2tQUann7PBPW+7vhDzprccPVDgr8C8HdbjUO0Ms5YW5bDqacHED/fzcng/Eqesh3WZM24CQlWYHgZ/CD/Dofz5Qt9NdlRvgvYpIHHWF9t9V64MuIAY52/Jf0qys2XHVdfCasgdwryqdNxrcojg5s1dQCFoztI64gtTMnkbtpDI3byS1WLQDu7aNqIOGjFuaqJMu8ejJdfSMea7Gq3txv+vp2NRrZNatFNhPBBYCkkm3oYocMFCIm0VKUJ/fxI/Zj1q5u4RjLyNRk8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8257.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K52syXeukmQR+HfydvAepGyRmw9fU/6hrWgieM7MP5pKzVf+h6w0EPvHAkEV?=
 =?us-ascii?Q?xXqm1PkbcwOZqg/i7M8pk3Vk9i24rp+k2sWDqS6MHmX2ropA6ZLga1DkFvX5?=
 =?us-ascii?Q?1w9eAuSkrPDu8fBxP3otyPxRQdazcUTkpxEBSZK9X5zHPidOSFB+8zbhTKpb?=
 =?us-ascii?Q?a0YBWJ36FElSldLwKcA8X9BeGznWrGNfAfzazskl4fKYlagaHuuqMqe+9mAM?=
 =?us-ascii?Q?HMfnKvB+QsDxVjyBTVOM8UIh8CZ1jK67RPQb9C3J57lAfG6ahE7DJSKzDc/V?=
 =?us-ascii?Q?qaWrYKT5KZrP5zwsoPaJRsC+oDisqaY8FN120Z8kyLPn3a4DrI05vH57oEn8?=
 =?us-ascii?Q?up0vuAVNCUl/nhs1V/Tu/d2Zah4GsqK4BvrZWHfJTLW2wjCU69534Dk1u6TF?=
 =?us-ascii?Q?gocvMcUMvZicrE3oQMscUykUyYglNSDUELG9C3mnaV522fHVImLyFbiWdk54?=
 =?us-ascii?Q?743Ut7oxpeSpal9Um2Wd14idFUvqZewLWsc12Ugh5Zg4SXkaYspXvRWqfyE1?=
 =?us-ascii?Q?LSj9UOYZylXDAs6yFgqAN4DWbfSS+muelU2G9aslezVx6/Bb1y2DGxt9YupH?=
 =?us-ascii?Q?MFGaE1O1Ez4omXPbKppq9T1kJMvjJ8ID4m6IQsdM5KFzGaT5KessyAwSg8/z?=
 =?us-ascii?Q?FL75Cg1jLvTgOaUoBjshAgCAR1QH2fH/3vHtXfUTVmVUrzqSavqq1RInevh3?=
 =?us-ascii?Q?8JX++U+fHQHY4si1jBoCX8g1ZOfpIKi7lKot+sxrvBBKwrT+bomOwC0h7NHz?=
 =?us-ascii?Q?Hxz/8f6WAY/Z6BjujgCdto/5NtLK6+sH+EbD+Y6rAY5+tIhz8Vgbm/42y2XA?=
 =?us-ascii?Q?8p8qQxJYlpoAuIqi1z89zVTeY9W/bAVsiRv/ijTsFfmcHNtrYPfe7yGnp7Gy?=
 =?us-ascii?Q?dXat45ouQ8nhUiqzSh0k874qyGPkoOMg/1zOWLucI/TkrhRpq/pHP+F3l9Pz?=
 =?us-ascii?Q?LC7LdVITNe5xRj192jf/w8Od0pBr37w+Bk30GfK0JorpkEnayDf7xblBwLI9?=
 =?us-ascii?Q?1PPpS9/FYTrifa4onx+3GlRYxbS6SHRNFP489G/fBH5VmYCgGaA2Eml52yWg?=
 =?us-ascii?Q?l/rjhcriR0ZhpaKcxPkuFy4tpstA87dpP02u5c5qBe4Rd2Flg/sSFYnNLfTd?=
 =?us-ascii?Q?mrZDAxxvhhbKd6XlH18vsoH3kJWo4QiWrIj+pdzxTUWXrzXAr59Rv1h8J6qK?=
 =?us-ascii?Q?BSCXPyFDA+luJjilAtz6i56R6s8MWyj3Za3ORmQDimpwcA9+V0T4TNrSwrnn?=
 =?us-ascii?Q?Qr0SDock8Xi19ceYojOpu5PDlGO6OtY5fnNRtBDnUYyiVRq0q+qm4+BZe8zc?=
 =?us-ascii?Q?mQFaoLEfcVudOrEY6tjRg2D9VKj1ZIAhBDGcsWMHAn/1LBWFmftbdNTy5Rfx?=
 =?us-ascii?Q?vAQ+uaVs+nReeuUp/MgLmUenZ1CEynTcwEV9zMqCnD23eNjmHQcGmSJFTwH3?=
 =?us-ascii?Q?CbRGV/mJQ90DzshE2kuuuBfArqaS5FeW1RdYIp6gM2yR64nC644PzsFAc2xQ?=
 =?us-ascii?Q?iHtdxuCOGiDltAe4DQOJRmwrGmCshwSm98Gt9xEZQ85gJUzGAhgYw9iBRsO/?=
 =?us-ascii?Q?0eMR2DtxbEnDwGx46xF6SCztpkoaTKwflnMvIovkAqR3McisbVfk9oomjJKy?=
 =?us-ascii?Q?Y/RxA2kTIK6fzTEbMguIAAg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de6f30a-5eee-47b7-defd-08dc3edd3388
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8257.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 19:31:35.5430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DazxsfMhxZZWp9Sy/Nartj6Y1QczRUdcT7254oHc0+3CE2xa/EAiwwtpAeWIBvyWdjRE7dkgzZfpYJ13ovRBSMbbeG34NTg5hCh/YioAXpeAj+MuLQoNVCc3d1t/YNHo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR01MB7420

The driver enabled and disabled interrupts even if no interrupt was
assigned to the device.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 drivers/perf/arm_cspmu/arm_cspmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index 50b89b989ce7..2cbdb5dcb6ff 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -795,7 +795,8 @@ static void arm_cspmu_enable_counter(struct arm_cspmu *cspmu, int idx)
 	inten_off = PMINTENSET + (4 * reg_id);
 	cnten_off = PMCNTENSET + (4 * reg_id);
 
-	writel(BIT(reg_bit), cspmu->base0 + inten_off);
+	if (cspmu->irq)
+		writel(BIT(reg_bit), cspmu->base0 + inten_off);
 	writel(BIT(reg_bit), cspmu->base0 + cnten_off);
 }
 
@@ -810,7 +811,8 @@ static void arm_cspmu_disable_counter(struct arm_cspmu *cspmu, int idx)
 	cnten_off = PMCNTENCLR + (4 * reg_id);
 
 	writel(BIT(reg_bit), cspmu->base0 + cnten_off);
-	writel(BIT(reg_bit), cspmu->base0 + inten_off);
+	if (cspmu->irq)
+		writel(BIT(reg_bit), cspmu->base0 + inten_off);
 }
 
 static void arm_cspmu_event_update(struct perf_event *event)
-- 
2.40.1


