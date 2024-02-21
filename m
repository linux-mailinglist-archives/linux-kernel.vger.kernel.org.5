Return-Path: <linux-kernel+bounces-74662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7100285D767
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 952431C22DE3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8591E46424;
	Wed, 21 Feb 2024 11:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Lj142i8s"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2082.outbound.protection.outlook.com [40.107.255.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23A93F8C2
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 11:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708516163; cv=fail; b=U2Ks0mztHq8UuPe0zkWKTCoiktK8KTwgBtrGqsP7/Vp8ilD6sqvr72TpSnK7BUgkcxuEyCuEu9rlbAHGEy0MpQTpBJ/fXsApxKVsGa9X8lpqLonyp+wVS9U9vEzfHMHk0YMgtjz6QQzIVRDfb1qybM9i1IxA3eE76s6vhhaULyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708516163; c=relaxed/simple;
	bh=OxyyS/kPbqcZeB96z1CwsSlp5Hc4YeBrv9SZJf4ZURs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=U1X9igatRVt1g8UhERdCUsrGNTIDKay+fuvgPS1KCQHmgSKQ3avnN6VKwiNf6bEMY7qgVoIu7ikirORYJJQEvnKF4Ur8WIXd4JRIDsNZCc2eE4X79dLP2p/ap8+O9n7FQsr/tPHNhpEXVdd+bwL5NXDHIa5rl720pap238/CFpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Lj142i8s; arc=fail smtp.client-ip=40.107.255.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RkCf8RARbHv8565CgWdR6cKSqXznu+lnz9WQTp4eTyFezIBaJ+895HYICDG2SDJuzkaiOSG/bAbCrk80aNmVipEzH5kQDfIEaj4IX4vi7dTYwD3YJ12xsT0r+EgkTX00yeyFJZ90JlyZd8eaAaZp8J1MCbdCWHBKJzlzpkufqLXpFPNmVqCQjorEF3Nn+vH3w55U8A8babCPLQxMepqHJE/Z9k0cbarK5o3A28pZssH1glihezlru0NKt1ntEhLpGmsYjYZObuAFP37A4DnV2nQByZLgH/gS6xIFrqDPXmSWvJosVXxHY+PkMbf/Tv+hO27IEMcxE7i3zWeG7nqyyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/KJ03FaJ/3uEXK47Hm5p2n7vmyqiFkW4NlaTtjJn3Nw=;
 b=HF8DoQ0KPBLpIcqlKcw6ajqut7lzLkksTqShRMXRpm4opbWVPDNoS3Zswxad4z+d9F+Mvmn+pMsTUKYUmPNAy8Z/+D6U28Lddv15E69wils93hHH2rFkRfzPl263tfPvlv/QahxoCBnnPiqpwjuxNooizufq9JBXoYjGlbd0TsVQR2fHFeix2hqsNRsYeO1tMglNBsqjN2QNPem+ES3DQxF4IysrAM/bQ6GhVdkfPArOkw/sM7wnm9hgTh/734I8N6HbYF+Dhqd9DpPZIQOGp3o++N0H8W8XSCN0wojh+Pot4rXJ8N2KFhVpW80icH/lxYN2D56ORqqy20a/0vROBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KJ03FaJ/3uEXK47Hm5p2n7vmyqiFkW4NlaTtjJn3Nw=;
 b=Lj142i8sZSi7ORLiWQcewdaigoQOQxiSXwD+0GRjJHrSSYcNu1102ckRdGhPP5B8WwSkYuxJMnbBVNt3ApkiT9OwDqRNDyihPr6tkWgmYwfw8EQDWo0wLcurCIT1muNuVOQs+wxzH+f5Evp/nmNYQdkL2COfklP041DcFkK/DBMEz1j6ToJlZ9n7xCpcy5RFTQKO+yTZFKGvBHOFuf53jkHUaadhSOb5xw+WxzUsHlggr3JoPmku5oL6Lp4wlCwljjDCAPNXWgAWgAg2qb6wRkY4leJmDBt8V3fA7Dgo/aUq9yWILS99u1JOoZGKJaaKiohTSAFOnqql02oVBPAGOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SEZPR06MB7523.apcprd06.prod.outlook.com (2603:1096:101:244::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 11:49:16 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::462c:f70b:5282:9037]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::462c:f70b:5282:9037%7]) with mapi id 15.20.7292.033; Wed, 21 Feb 2024
 11:49:16 +0000
From: Zhiguo Jiang <justinjiang@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH] mm: shrink skip folio mapped by an exiting task
Date: Wed, 21 Feb 2024 19:49:04 +0800
Message-ID: <20240221114904.1849-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0251.apcprd06.prod.outlook.com
 (2603:1096:4:ac::35) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SEZPR06MB7523:EE_
X-MS-Office365-Filtering-Correlation-Id: c7203eb6-45e9-4325-48ac-08dc32d32167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	InSJ3XhaB02/GjorA744Vc5AR6fsGQMkS1FUKl7cIrhS5fZ7asekW4fMC8dFYv8XNmwZn+TGCkiYA2qHZZjK/UD+sKcDTQi8cLgQ64xzV3Psehfx79X8gbP8WVdwNIt/9/XSRiMkdoCYdYiW1F7OAUO+HcJEHrp5kJ3Y1df96fBHya+pLkdNGLc5+veoZYEo/g1OJOUxiiSNsNm1aWSWpk/4PXhJpkJl2wn578VK+RbHfnypA8U4DdKSJ3ZYnWLfZU3GLQTkx+YDZsRBshQbtYgoTMOPzWuSL83bRupjTpf57NRvKXDfbga4+zCwUsNTBNmKUKl1IYVzHvJJlB3kBTLrnZtrzcwR7IP8ACXt+VndGWOoIeRiIpykf49FkpwqfA5GG7Q7TXvcAGlt94xB/80oTwXfYzAQKiBmCGXlm3tCD6lLSXMp74MXLZ3R2bioDhntBF7TEiCqVzUyVL4hxBS+xpIMuGA8VlGxcZowcPkP1AK6z/rutWv41Qn9+zXntBDlU3uGXkQgNAq5OdsuffP6h+W4YcRS21uyxiiNm97k945JP+vwRhbLIYUVQH9hvPaVpRlrHYNcZiQq+fpQjGsSeGeo0oE9LkQQtjNMLXRNZwOgNaaFcbyKCIdgCwZK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?buXcU6hcuiH2ux83hEi55PKdYlrly23dHJ0tO7Kzg+xx6boPThpp1yh8y/8Q?=
 =?us-ascii?Q?15IK6ZGtUoJ+TAn8TZs8GpKZUDgRT7Rhk4kR7WiqDUQ3fkRtYIzb/W6YyDlW?=
 =?us-ascii?Q?qPa1QdbW7TDXmPohAGGwUgu45mabzdg5Le5ZSXz9F7tRynGXMjpSDRS4LKBY?=
 =?us-ascii?Q?Nc4nOwDzWqlO6FBoNeQp4BWZdWHG7FtKFc8WhcS21s7wFn33qaav+ABn/pvW?=
 =?us-ascii?Q?cVQRdXET3ds3LJvwDfYSfeHxr4fUnnkqEjymshfUB16ya4rWZDDl/45ytYNq?=
 =?us-ascii?Q?CeXLWi8z9W5u8xW+NbPGEbdpXFtHcg2NlbrN7qddWkyyHH4w3g5ITI8FvLaC?=
 =?us-ascii?Q?Fgy3ErIkIgyGr+VeQ+pSE77GGgabJSING5GXklc1nNKMrjRyMzx6RGqLLF3q?=
 =?us-ascii?Q?BdKY+DHVYQGScV2gA2lPa27PkOjGnafkUJ564Z20Qwc0O8bwAWACbXIgqXb7?=
 =?us-ascii?Q?zkatbypZRDMJT0yae2CXHCNZQcf2dYeR58Vi/Qb9QiPQqj2yaUgpsZbKqH2k?=
 =?us-ascii?Q?/MPIWZg0s0Emgvzo1IChhQY5NZyLo2NmVeYNTXACzM4ZIDijPuvL2w1Ey4Ix?=
 =?us-ascii?Q?FN8TCEzioLqsAGOuyPSbZdOzvtd4Dj9l5fhYkbM6qUiVjM6HSfYj7W26acQV?=
 =?us-ascii?Q?xAQqlp2Z9j55xtv2PoeFIclQnSDIkb8yE178koHmrHOdC7Lk07in09CstTFY?=
 =?us-ascii?Q?LknNPTNifMl1DZPG0/6Znz2sT7lEVfwRuDE0se0z2SuVzZ/DLoZa4vqsRQvx?=
 =?us-ascii?Q?x8fN/8FHCE2tvEfEF0M08jd+MfD5/EPh0JJ+kFADqHSetKDwN3bi5NEtRxDg?=
 =?us-ascii?Q?oBrEwWmPAQNBnIVD3ZEh+ZSoIjCkD+Kf+e64WwulV2fxr2KAGhvBOsJlYeuq?=
 =?us-ascii?Q?jVYL7ni7sXleih9UXzae6mqyb3eoPSQf8I65Ejkd4CrDT2L4T/SUCrv29EMy?=
 =?us-ascii?Q?3rjuimC/vnX3fKefrV1sM7nuHhfUJ7oUGJ167+rXHAPw9gBaGrr1ZUNS2jdA?=
 =?us-ascii?Q?Zojgl+axGK9petfrsxapGZ7MA7wwsUJt6EwuIp1iKNV+rDGAbbeftj/Uf4sh?=
 =?us-ascii?Q?i8BgwvS88Jkg9j+acywRyij/GdELUDqGIV52dLY7HEwCrgGSHbjHfaHLdy4A?=
 =?us-ascii?Q?hHxt2BOez/tR10TFc/jLykeFFRlkj8aP1IZhgvwlt8YOZ9zsMQAHfcKbO56v?=
 =?us-ascii?Q?Lm3kuWhIzpJZ5p+SwZRBYfjEZc2kW0NowWvb1g53AUb4392RG3g1AE4DkIUa?=
 =?us-ascii?Q?YKSv7pxe+sTA0OJbg77wbkceggNxb+XaOwluIeOAXGB5oOhfSAmUr0HOpSud?=
 =?us-ascii?Q?kJp9GX+ukbgEmdAFrwXVqiy6lhjOE5QtViIzQibb7TpLYZO3in3BJ/1H6p5l?=
 =?us-ascii?Q?jnOleLjdgLaT9750TvlMXPRCb7shY/0+bZ97A18r7QbMgqPLwJAlc8D8WMxw?=
 =?us-ascii?Q?wEQqSy76EoGTs6iIQ/AtlYMK50BSrJbY7T/ID2zj1cAQwRa88zxZSlNry6id?=
 =?us-ascii?Q?hmPpHgBTyCREoGlWMkSThJxuhtS/57pEQfzZn7R0SPqVZmhjcR13W9mzmoTY?=
 =?us-ascii?Q?CgAJG2TbDiKeeicjCe7GfaAn+0d8a1knKXG/Z3JN?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7203eb6-45e9-4325-48ac-08dc32d32167
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 11:49:16.0993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HrSEpTS+7aWCWV8UrtTxGD/qd9siPrjr2Ur9AVwpGU+fLr8cSyO722Tdu/p8bJHOY3+OoIVgCxwXCB4be4Ex7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7523

If an anon folio reclaimed by shrink_inactive_list is mapped by an
exiting task, this anon folio will be firstly swaped-out into
swapspace in shrink flow and then this swap folio is freed in task
exit flow. But if this folio mapped by an exiting task can skip
shrink and be freed directly in task exiting flow, which will save
swap-out time and alleviate the load of the tasks exiting process.
The file folio is also similar.

And when system is low memory, it more likely to occur, because more
backend applidatuions will be killed.

This patch can alleviate the load of the tasks exiting process.

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---
 mm/rmap.c | 7 +++++++
 1 file changed, 7 insertions(+)
 mode change 100644 => 100755 mm/rmap.c

diff --git a/mm/rmap.c b/mm/rmap.c
index 3746a5531018..146e5f4ec069
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -840,6 +840,13 @@ static bool folio_referenced_one(struct folio *folio,
 	int referenced = 0;
 	unsigned long start = address, ptes = 0;
 
+	/* Skip this folio if it's mapped by an exiting task */
+	if (unlikely(!atomic_read(&vma->vm_mm->mm_users)) ||
+		unlikely(test_bit(MMF_OOM_SKIP, &vma->vm_mm->flags))) {
+		pra->referenced = -1;
+		return false;
+	}
+
 	while (page_vma_mapped_walk(&pvmw)) {
 		address = pvmw.address;
 
-- 
2.39.0


