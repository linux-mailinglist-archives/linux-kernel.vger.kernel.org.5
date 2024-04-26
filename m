Return-Path: <linux-kernel+bounces-159868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2CA8B3546
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5226D1F2197A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0329143C53;
	Fri, 26 Apr 2024 10:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Ng0BlcXz"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2076.outbound.protection.outlook.com [40.107.255.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A562A13D299
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714127348; cv=fail; b=q/d3MjkHRB/reVhR7nYbR9EQKvukfKkhxRauE4VQfiyop1MQRSdRW0ZbRjBGwg1kAoQCXiuZDJ9TOcrbAcIJ/n7XDypzDSyxBbA4ybyn59MtjL9MboFD+gUqWIsYZOkMCngcAraEY2pONzA27sIxyb/egAB/YxnSb/hh7aFV14U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714127348; c=relaxed/simple;
	bh=mrobb/409msy4HFELkhl/GU2Cd/JuGq7DjxBYZGqV/E=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VS/Yiijv+CwHMBj4hIVTEPZs5LE1MuYbHpuy4PSUIRjeB80VMW2gpZC31yhCAZq/oU0Jh+JgGw4728VyvZ2aEO7GzYdCXTrNUki+yeSazz3hJEpPwCaPrGwvgchmWwOpPt0c/13L64ng7F4jiXA+XidWMp/Spsv6JbDCwV4RbmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Ng0BlcXz; arc=fail smtp.client-ip=40.107.255.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ed+XvsW/FFIYsTlrdYENa+WiYZDRyO+aWV76eubHa+CDyrfZVA6Ba6vVlj4LL2pEaxAqeRpAzt97qJLcYzTTD1u8BIuEiRhTM4EAgS5mmAneofqtgH4KTq9yB1kgvUfxUlV24VMaX8JI3iLqFKrBf3WJuywIcjykJyfWLenIbYkjP60AkH09IIHQs75SD8Gevz8JiN6/ZKCk3NQ4Nrs2CbnJf82/Fr9d8PBIJQoO6JuyG0kDb1DZvtEkngcH9uoLT71Uo5Ii8PODZqw4kYj+C2egXSpKzcT29kT4SLRd4IRaFSom69XZF5hrQ2shFMRgJXiu9mcZPRD8HK+9gZHPtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KeLJeX3O4Txo+vHM7p7PtpqCm/6M4TOvP4/GCeM0234=;
 b=j4D9XAHaTFAJ4RY+KARviMAjLI3iK6bRaXKSo5r6Vz36SnzfwinXd7Qt+GeiwhWYXufhNvl5/LtlpTNGBoRAp8E+e09jOHBH+jj4g52CDvOND66uzXKCmT4Rp861+eT74+x5eWGgwagTrV0Tp4/D2cbzrQsKWeyw7JQI7ySSh/WxQzqi+bBFsyLt1fHTLCGOoh0SlusV/luerUj6Mi/MPma3pCl93AKUlwOMq/ftUsxRyG4++qMvf2K771j+wHXtyJ8Qk/DDW6QxspYgbSaRWHJguOOlTygvumNGQTevw2LMRoOquwYteC+aMq64PtWAXmRf/5lqpBasSzp4xM0vcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KeLJeX3O4Txo+vHM7p7PtpqCm/6M4TOvP4/GCeM0234=;
 b=Ng0BlcXz6/Gf43gMRWi2CSY/GQaN4HgTWNXx3Ds5FWKo6Bbu1N6PUKLKht5lD30CaRzZSlqibOt22sO9WQIzcqLQPTYpkh/6KB+Eh65Igxv/loCkod75e4jKMgIfdUzpWxr2PHMM9HbXNUF/q/tI8T1JpE1vq250ErE9mry+I5AlCjxZY4xf1+nWjdGZwwBGLBpewxP56M+xOL18Q7rRQGI0BVbAFck6yan4+KBfE+S794KV2n+XBgaUuIkTHH05xJ7hVlysXQ7ftSS7doYt1vzYtArxUYz7cjZDkVN2l1bMy68ckjbMP0wZ/6yk7wNF08qKcY7nqw/Aa6Q8mjweAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com (2603:1096:301:89::11)
 by TYZPR06MB6213.apcprd06.prod.outlook.com (2603:1096:400:33f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.46; Fri, 26 Apr
 2024 10:29:02 +0000
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5]) by PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5%5]) with mapi id 15.20.7472.044; Fri, 26 Apr 2024
 10:29:02 +0000
From: Wu Bo <bo.wu@vivo.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Wu Bo <wubo.oduw@gmail.com>,
	Wu Bo <bo.wu@vivo.com>,
	Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] f2fs: fix block migration when section is not aligned to pow2
Date: Fri, 26 Apr 2024 04:41:56 -0600
Message-Id: <20240426104156.321701-1-bo.wu@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0120.apcprd02.prod.outlook.com
 (2603:1096:4:92::36) To PSAPR06MB4486.apcprd06.prod.outlook.com
 (2603:1096:301:89::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4486:EE_|TYZPR06MB6213:EE_
X-MS-Office365-Filtering-Correlation-Id: e488d09f-7383-4b12-30c1-08dc65dbb129
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jA8558ioamMzf0abNGEAJBkGUJeYPKlKIZRGWdTTchdmx0CfwFjB6s6f5vV7?=
 =?us-ascii?Q?EnvLHTHdxbdzZPmd3cVdR4uo7hCsqq5XFt7/RFtiUTk1OqeiW5z39XcpFvbm?=
 =?us-ascii?Q?U8eRD6isubw0qJgpGTMF5+hJKExBZvUlx/GW4Z99WIJhdExquKWNbe09LoDp?=
 =?us-ascii?Q?3i3hu7BaJPp6hpawV2s85U/CqZMfA5xxYyKYm+sWwtp9BrhUWsCMy8HBi1M/?=
 =?us-ascii?Q?Zg5psJUpP+Zm5KNLNcdWmkLcJ3YdCJR79rsN2zimydb0ULcVdlLR8Qq1cXy2?=
 =?us-ascii?Q?+JiV+0v6GL+P2O+rvaObsHblkT+83PCAiGXHCteV6i8ivR2WECXXiy65xDQT?=
 =?us-ascii?Q?fLXEi4phaPSDv9E+O7sS1nVjVBhDTwdDNMMlFVZBEkJAlMLkTZ7So1SZ/qUA?=
 =?us-ascii?Q?C3M/vFoQwttD8zL03H/xGxixvaEpPxI66Wgz7ywgydvom/9l1yEJW6gDB03x?=
 =?us-ascii?Q?gUTrcOfbB8ok0RR5+pByAvQ4A7t6TASABbO8WLjcj+2jskbXY7yBXtLmPY7y?=
 =?us-ascii?Q?EzElu1FxfafERHW+ro0mwsCCyjW1wbr/TbFslN674/4kyWivPppLh/g3CoBt?=
 =?us-ascii?Q?JlgU+WGBaAcccuofCSb6COX5gbg9VWtNRSggAHRuIeRK+iRMjw9i5tVR9bOh?=
 =?us-ascii?Q?TfRNwvn3sshuShH7K7K/PxbtN8vuLYRdqb0Yd9Q2xQi88+TvtPy5GguFV8rn?=
 =?us-ascii?Q?cWnb2+QgK/nl/TTSSqajLTJOCmV+Ntrta4lFGc1z3o683ZBKmBXyealP7SFv?=
 =?us-ascii?Q?30Hq7pyaFMeKNPgZ8Z3OMrLfMHhx/n5FDUBzGFUsyv8bKy08BVaM/sKTNjNz?=
 =?us-ascii?Q?+xnFnhEhHHjf0PeYcnX65dFVEHBbpCmJVMLravpsuzTCbSJ25MLVDRbGdlsb?=
 =?us-ascii?Q?L31Q1ENcTxtnd2+OXMOkW3qnwzGzo0cPRAzgXAkSik8O/ckM+7m/yf38QWzo?=
 =?us-ascii?Q?8fKBhAULyn9LsD5dH16k9Tlo4toYqXQ0on4gPPX7ps6ffTwUVA2izscJpFCT?=
 =?us-ascii?Q?kSPBK9+lsTIXsiw1waMNwXn6tWfayOXPy4rerDv0UqW+TYi96SltxtVwbY/C?=
 =?us-ascii?Q?pU1RDmNt94copXjOUTqF2Q9MKiVgTtOShkGlfyi4vr584LqCXp8T/ERxezBq?=
 =?us-ascii?Q?ere1PgwuHabAceoiKN4gj2YSFstn5Z8W1On1QAPehSwK3G3MsDQjZoVdvnyF?=
 =?us-ascii?Q?M8FaCm/lbBGxdSPh+ztO+9Zu09CLMszO2YcHzcwy3ueeg0fOaB5/3Eg5eZPM?=
 =?us-ascii?Q?EFvRDJA0iFGRnZNoOSwUxreiaFkpgNfDtHtNnUYiyhg70lmmbd2poVmc53zt?=
 =?us-ascii?Q?+my4J5Pg9RqtwOT/n83HR113VRvPlfB594ne1erDj3n12Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4486.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1DdmpUaanuFBF3l/+UB+XO0C3Krqrf83f+PePuFzvIXJpY46by5DPl/acwAB?=
 =?us-ascii?Q?VPGB+D/qEigywW/bvsvmUdLqrUWhmohhNfzzdcOAXNvrS+jkhk5WY74kiSkR?=
 =?us-ascii?Q?hIzB52SMxGv83pDcbznrLSj9oDnhXMSSN/q7duQ/X36vpPuHMnL8lgkwVWyN?=
 =?us-ascii?Q?CE+XqipVDafNof4oVoOFHdudElzGTB9VKlUNJQbfcvLe6FgWpwTx6+WnO7fV?=
 =?us-ascii?Q?u8i9tpM/lsUR32lCwwgBb4L/C8H+jY5APP3q6qVTywu6bdfuvaEtXy1ugr4V?=
 =?us-ascii?Q?GRtt4sMsWQm4Z2onRrIiQWrb8LarFyqZx4WmaEgfK4wHd+h/YptAdgZwQrze?=
 =?us-ascii?Q?2YxoBWLN3A5aEAXAwc1Y1NLopEoGi+wMWi/RIYqvpPHa9dekdukEe0IAFrpP?=
 =?us-ascii?Q?lRftfFOPOGVEUj573d5se9SJ8TndVIn1XfkB0qtLoWc5eX8baY3JMR4hQYfM?=
 =?us-ascii?Q?8KPn3U1MBpWySG2kVtJbkH1jGd87uTnRaWo3BhfbYBupCW8CaWtSAD0x/dwL?=
 =?us-ascii?Q?dPjnWnBya/kq/RonN3vhPDOenqAqegA/CJDkSo3mBTFSNVXRuaqi+F/TTz3i?=
 =?us-ascii?Q?uCg2vgosvP06d0WGDBIvzPvkAcYjJjG6G6ImSjPTskfMpjSSQgmUvije8K+g?=
 =?us-ascii?Q?9qfHT0JtEYx+g5AVJajEqhyMlOKwwORSxgdHydR5dHZEN73fUTWgQhLnSD6p?=
 =?us-ascii?Q?fFak9vIdq5rlTzoWLmVFCB3iwDwAgt3F6cOREBGZeTEX7hD4tD7ofcI7IToh?=
 =?us-ascii?Q?14tpG3LiBNgME5tjTEoj6si/YVBH82XakoSSXbJJ6lr8dz9Y0jynLgloJH2i?=
 =?us-ascii?Q?oXUwRiK+B1sOBpHf1H+9upAq6u7G8pB1ClByzh+QWLu5VD5Bpps0mhGYJIfb?=
 =?us-ascii?Q?TD5vkDqaiaBamNY4oFiCMSEnpiFSPmLMghuurtSW1dCWEJY5TFaQhaIINSl6?=
 =?us-ascii?Q?vKKpn/I5TD8i1HKglxCHFd6oBA+asuYDCz6aeyfV6s2Pi7cR6hFvVbSmbMa2?=
 =?us-ascii?Q?mAJ1K3wkOjQG2iK4yiADWnCT2mS3WGjdqFt7r65SVEFzsR1Cn4eBRiZWD0Bb?=
 =?us-ascii?Q?rPZbUGAvImci5ZZy4zS6nGVIIJGxZ24xdQYVCCBwp+fYJWQ2L+8WnSdDzBem?=
 =?us-ascii?Q?zrS4MLwNyLbkuoRIrGPOE4fUEFuQqJvcp0qbFH1o9EMSsOXpFYoCWQmmKGJy?=
 =?us-ascii?Q?gu88XffjxbCQ5iEBrK13OvR4h9IfCAhOXQRPcd3wJzp72PjlM1RuVrg80v1X?=
 =?us-ascii?Q?lnKd80yE63kZjvZwsiAR6sujLhPuIHu1ISaV0sDm/X/n9PhByWkSpJ49vlxG?=
 =?us-ascii?Q?cK9dHGc4zhHFZtt5G1nCvDzNb10Irm+Vvb2QX3ln3+/Wd17c9KGsqjZR+34O?=
 =?us-ascii?Q?BZOZY/Pkd4DEBWrUlYLQlOcpUHGiXPhBY3eFmcDGwzZgXScLtDVo8QzlrCxP?=
 =?us-ascii?Q?PExFjTOySc14tEF351c1i6Q+1XwTzOBddfn1XF8qjRLzYvF8J+BkAF/rlQkB?=
 =?us-ascii?Q?CXTZlIn0rmx3eol3/6iUoKXl/ejkeKdYOQdUOonBb4+/930Fb6fmlq0Z66wo?=
 =?us-ascii?Q?w3ymBkNeuiTO5x5n0tffHSALrAJSyoZWp5DsD7Gj?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e488d09f-7383-4b12-30c1-08dc65dbb129
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4486.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 10:29:02.6699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qdr76ncX8iBPG42aHtnxTz0b0iHpwfKHwwkJI+iHRqJPCNxF+HSN28QI/4kT2SSAxtZCLdG9/rMMc9EVP0wziQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6213

As for zoned-UFS, f2fs section size is forced to zone size. And zone
size may not aligned to pow2.

Fixes: 859fca6b706e ("f2fs: swap: support migrating swapfile in aligned write mode")
Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
Signed-off-by: Wu Bo <bo.wu@vivo.com>
---
 fs/f2fs/data.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d9494b5fc7c1..7ff5ad3fd5dc 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3904,7 +3904,6 @@ static int check_swap_activate(struct swap_info_struct *sis,
 	int nr_extents = 0;
 	unsigned long nr_pblocks;
 	unsigned int blks_per_sec = BLKS_PER_SEC(sbi);
-	unsigned int sec_blks_mask = BLKS_PER_SEC(sbi) - 1;
 	unsigned int not_aligned = 0;
 	int ret = 0;
 
@@ -3942,8 +3941,8 @@ static int check_swap_activate(struct swap_info_struct *sis,
 		pblock = map.m_pblk;
 		nr_pblocks = map.m_len;
 
-		if ((pblock - SM_I(sbi)->main_blkaddr) & sec_blks_mask ||
-				nr_pblocks & sec_blks_mask ||
+		if ((pblock - SM_I(sbi)->main_blkaddr) % blks_per_sec ||
+				nr_pblocks % blks_per_sec ||
 				!f2fs_valid_pinned_area(sbi, pblock)) {
 			bool last_extent = false;
 
-- 
2.25.1


