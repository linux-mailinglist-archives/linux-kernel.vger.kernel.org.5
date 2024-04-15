Return-Path: <linux-kernel+bounces-144822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A491D8A4B3E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 319911F2278B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA803D0D9;
	Mon, 15 Apr 2024 09:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="oT4PFcvH"
Received: from SINPR02CU002.outbound.protection.outlook.com (mail-southeastasiaazon11011005.outbound.protection.outlook.com [52.101.133.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3785C2C848
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 09:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.133.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713172693; cv=fail; b=jfFyrNQDjV9XtNwyG9MrgJglIWrnY3z9Jo7AL+LOAE1TtoDqRx/1Jf5S1wKg4FSIKzzJXn9VqCIjDkAW2RzotRmQftX73u3DdIozwLtWoPSyahbWinkthngTOQh+CFE1bOi2VXm8bKc4tBj4o9M3wy3vnRrPu9Nkpo5u52yDqtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713172693; c=relaxed/simple;
	bh=1MQpVGnF1dAXesADByMhRl6X2P3/8mHxf2XXfdzrFPU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kjpw1va3sxjVNAHOVQ/rnBo8veC0vD6B/oHmXx9qPqZp1ONjcQbOTs7No6GEgwIuOzZTNDkqw1gHfz+4/DAOqRfoZuGjmxSECV6k2iedWkSWhyVnb6k5CTftX1AOcHk1WATYkLp7JF4CbdkO9xD7f682aU7gMtqEA3Nd2KH1Y+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=oT4PFcvH; arc=fail smtp.client-ip=52.101.133.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDfKo123x6ZaLuRDP6r/huIPOzr+h3pbEDRIlFZ/HYPHNEL+K/Kz8Vi6hQGSiznYuR1Owku7xgnWBjV3cYkozlAAcmAQ1XrKxNwGdlfq5WqBhdWtQX1xLHeQ16oNMMsoGDjMyOf3fCv6uvGkbL4JhCd1DKuwYxdqNuoXu3AT3IEoSvTOjt4ffAypeL7hcBmVyqXQWoaDMO/IB/gf9m1lcuieS5WO8vSmkNDA9gdy13gECC2lLJhPWKu6a/eJFQmNOW0pmza7EJzEjEIGq4MbDxTPe0hypOT0cqTX6vg/BKRSIvZEjtOgGRi3kVTYe16ExLO3dYup63EP0Zx2KLaW3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtrvIXJQTY6uy93VYTN6DHmrTy0GI80qNlzDYsP0aWk=;
 b=d4FXG4EhJ3hzUUAnrcTd1NhznEMMGErzIPR3ML9keNJLMFJqZSQLx6VBI7A1qaT+TLAcOYkBShSU3VQBajIW2iypxBBzVxdVo2jctBJCnl02NnjDGi4EmD6Cm01OlmfIfv3znJ6DRzd1auv/JEgPReq++Huone7Fuyo/OMn6g/AW/xiB5jjLwqi+A+eSoRPwc7Dmd3ZcTs+WaPP3kjn6b2o2mkuwRaLmZ/XYIhfgSDiuGteSNnHQL5EwMK46iYhQ3cSjYYYxc1BsQ2aSAi+ER53SuJXVYxPFjIbDaveat+bj3IVWBfh0Zd1uo1gPuAW2eXOlEH7puNAdXO3cVaxm0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtrvIXJQTY6uy93VYTN6DHmrTy0GI80qNlzDYsP0aWk=;
 b=oT4PFcvH71+clIi8Tm72yjXJyN5GnGbMx5OGBz/oDUablRpBvLBHVOnLofRAOmfBjH3xl+31oEB8n3nE+muvKY4j3eyzt2lowVATIW+7UFvHZH9uBeuh091Nl3pt5wBeQR7nGh3pZZu5CGUbATR/9WZlXDyleBnt3Oi+WmupJf3+vdbuZ5S6AXHS2IEqn1aWkDdEmbzxAV+q+1eT/FIQW7c++lhLTQSidnOM2xinr6U7RCoDDoNuppcQ4wcXmI4M5IzGAiKDXbIv4oG1s6t+YDY3i6dTgGaVoXaWvgAnNKfJ/1xzCbSH7xHXZ2YnKpqAHWX9pCbtIO6qg/K0+23T+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by SEZPR06MB5048.apcprd06.prod.outlook.com (2603:1096:101:3b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 09:18:05 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%5]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 09:18:05 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [f2fs-dev] [PATCH] f2fs:add zone device priority option to the mount options
Date: Mon, 15 Apr 2024 17:16:50 +0800
Message-Id: <20240415091650.27825-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:54::20) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|SEZPR06MB5048:EE_
X-MS-Office365-Filtering-Correlation-Id: 54f99a9f-ce65-40c3-26ed-08dc5d2cf4ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0rx93IB5JBzOD+YFbdk0WHs2gvEQy51XM6S1Pd4sKw2m70pwQO+PZRj/0kRasaaP6dqmBmkcdE7FojFhISqwDcA/lTU5oIJHjCDj6F/VkyqAUTBDFo+n/v6ewYyqxm+jAxavimy2O2isXOULTjOhiF8ZUrkgnjFi3VKwkDAD3HbtrvdGqL+fng2mOqtu8AbvnpB1fOXOUjfPy9qK11GTj249T7TLyVhehZUsRFeQ5cjZ2heD6/ewv/xYakloraf2enZ9IJns71iEaK341OPOwAGqZGmRykgOMn90NteBJ1zwS1pLmO/L5GGeCELxl/W5gifXBFW0C9T2XN1dom5XhYWQg4ezaX2VkVn5uQ2nwBKTU3/tk0GUHzVc3KK/peH0Y3sPIHIc/9V5up4HcB/W0pOf2MrNJt08RVknZomixzDQlSl0b+/VXKgY8HhuX0uS/TH5ivfbBSP1/y4Nd65b2Spov5YGPahB7ug7/RopZ/dbN6OayD1A+9MFvmorysfaS8BdHMnY4SE6ruyZn5Hc9n1r6Qjf08MJzLnLyXdY9DPenwW6IhCgzJsOPFRkb0Piztorq2/pF/EDIwyABkq29eF9ftHRF1a7Dt1HwnyHcgzFA7rbqCiHB7i8jrVxIWHxFbpp+vUTGc/spakeWhjA+TYO8rgtfCSrQVPrGoQmuzxobnt6H65RlfM/t1fP4wqLuYErYAOvD9hR8y6EDr7d4EFqWh/nGRGwO8f6CI5hlrE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yjHScvGjY1JSBG8l+Dew605+fncGGLmhUYjtuZOCZ/UhxwCD0NJgTTUomsYS?=
 =?us-ascii?Q?YLQK7/gzT7tAuiwp1RJSQwH9cudx1mQZVXQxiwcBsuCIIiDXfRmDC9YGgExZ?=
 =?us-ascii?Q?i6Z7qLbKssnvPpfSbed58Aw5k6Eo+78pg7oqJxhrAmJU22BFtxM8eDwIPWKp?=
 =?us-ascii?Q?gKu0l+iko+wD7KB1W8w0h7foloEg8ZT5euHBValY0245j4EtyzUJtEvLKPY/?=
 =?us-ascii?Q?9o2sFTC3v081fPxJJEc4GI3TJJbrt5u+hxrrpcuPqpz1m0FbAZK9LofFl+pR?=
 =?us-ascii?Q?qdGHpFvDxeS9Wf7+x9uJjXkg2IdDerrYResiwaR8YL1xxMztbDpjdN5ZW2mg?=
 =?us-ascii?Q?tG1VKleAhxKh4DN6JqNjHJQVnQmtnSzDfEC2E+LdBLiNW355lqTMydSqpn5P?=
 =?us-ascii?Q?kAEPC6YLS4tIKk0DMt7DUlF8zhBDvy89zabGm700VGL8U3rbGyfr3tMDkK0Y?=
 =?us-ascii?Q?qUAUlMe71Wr8r5kKoP5q4oMOutkf7u9WDpWJLa9M5O1sohL+hLp8fldyZnf7?=
 =?us-ascii?Q?jIOQkDe2WU/va853zg52BeD6Ipjoam9Wc4q9fzc9v0XWGFp4r/PBVugFfZ/r?=
 =?us-ascii?Q?jU+rg1/ljoHFP8RuEUfPXX5m6p5orbmhDxAbdh0wKQSbjZPWVcJ86P1A1680?=
 =?us-ascii?Q?Ox/D7Z+zGvG/HzHdrcVzaw3mu47a7x6adSi2f6A1EoHX1iGG9Yn5fF63WPtd?=
 =?us-ascii?Q?wZg7qEYHQGNU3lcBN3/UFItWl+7+olh0olvKabDQTVnNYoSQKfVVw5Flz/z0?=
 =?us-ascii?Q?B1Kl3lnZD7+BbA9FlH3f7OsJAZe8pBztXaehsuGQJKQqn46fn/wAJcuLeuwW?=
 =?us-ascii?Q?SGAdwN/ZP9VS6XdsxE/PH0iv/EXPG7rsPNlx8kZr1mG4MVKrYsWnwpY1p00D?=
 =?us-ascii?Q?tqKPwbb8hgq5SvPuh8obR7yq7kuwe1VizLHhX6FavN1qtSCb7EkVuTf65I0V?=
 =?us-ascii?Q?NxnQDjR5NzbO7dr8Y2aZY1ScunXF+MH2AODW9PxxvfckdCxscz4iyGNdY+WD?=
 =?us-ascii?Q?wDXGi3iYt7/4hJxXnOh0qXhyuFD2HkI98SeyMW9J/iRwWnuJziKa2DjK2r2g?=
 =?us-ascii?Q?KgKe7Nu745dO96jQYX5I8yiHDOjZgWIpydK/9GqU8Mxmthe3j/vg3Xi75wKe?=
 =?us-ascii?Q?Ns5UNAbVcOGRa4zetVdsqJL5YfzXApoCoPLFY9WkT4nlyJ+nzqjRCuuMrZZu?=
 =?us-ascii?Q?n40O5v7YCouS4UPHbzBnv04BcEh69qKg5+Ok/uWJw9NKkULWV59EAFpsBkr3?=
 =?us-ascii?Q?DBl+NV4sIg+6BUrBI+ves/hRWAbYvPqlrM5LO4wdwY0G8nAOFWhcFairo3vN?=
 =?us-ascii?Q?x1BVrtNINVPWJg6Bx++LXy2FCdPcl4cemZoiKRVg4hUZOSVawU3MfQ8c+lNP?=
 =?us-ascii?Q?3jIk6ZK0Jy47lMEWcyCJsiB0w8UJz11m5vOaG4kQ46EyOuBXX6AcARvimJQJ?=
 =?us-ascii?Q?FtbpkoVz+VIKhWf/79x0Ji/UWLP9ymHtCQTvg9Hh9HIOY9LFG3TLAZ1qxFm3?=
 =?us-ascii?Q?SDN9gDG5Iu28G6QzwG2AFhbWbx8cPngS/jpVtT2mqPhzNBwzSGu6r6OAIdNO?=
 =?us-ascii?Q?mvKavj+0lrisKGzY+3ScWJHklWnt9erdlO6OdxpY?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f99a9f-ce65-40c3-26ed-08dc5d2cf4ea
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 09:18:05.0337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CWYHrW0KpE1PDse9hk7M0AOffxqLPkLTzrdxlTlU/TqGJfPxgrfCAI8iMqHrFLTGhqobpjx/y/X6euOiLdeODA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5048

Add a zone device priority option in the mount options. When enabled, the 
file system will prioritize using zone devices free space instead of 
conventional devices when writing to the end of the storage space.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 fs/f2fs/f2fs.h    |  1 +
 fs/f2fs/segment.c | 13 ++++++++++++-
 fs/f2fs/super.c   | 20 ++++++++++++++++++++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index fced2b7652f4..e2438f7d2e13 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -116,6 +116,7 @@ extern const char *f2fs_fault_name[FAULT_MAX];
 #define	F2FS_MOUNT_GC_MERGE		0x02000000
 #define F2FS_MOUNT_COMPRESS_CACHE	0x04000000
 #define F2FS_MOUNT_AGE_EXTENT_CACHE	0x08000000
+#define F2FS_MOUNT_PRIORITY_ZONED	0x10000000
 
 #define F2FS_OPTION(sbi)	((sbi)->mount_opt)
 #define clear_opt(sbi, option)	(F2FS_OPTION(sbi).opt &= ~F2FS_MOUNT_##option)
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 4fd76e867e0a..adbe68a11fa5 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2697,7 +2697,18 @@ static int get_new_segment(struct f2fs_sb_info *sbi,
 find_other_zone:
 	secno = find_next_zero_bit(free_i->free_secmap, MAIN_SECS(sbi), hint);
 	if (secno >= MAIN_SECS(sbi)) {
-		secno = find_first_zero_bit(free_i->free_secmap,
+		/* set hint to get section from zone device first */
+		if (test_opt(sbi, PRIORITY_ZONED)) {
+			hint = GET_SEC_FROM_SEG(sbi, first_zoned_segno(sbi));
+			secno = find_next_zero_bit(free_i->free_secmap,
+						MAIN_SECS(sbi), hint);
+
+			/* get section from clu if exceeding the size limit */
+			if (secno >= MAIN_SECS(sbi))
+				secno = find_first_zero_bit(free_i->free_secmap,
+							MAIN_SECS(sbi));
+		} else
+			secno = find_first_zero_bit(free_i->free_secmap,
 							MAIN_SECS(sbi));
 		if (secno >= MAIN_SECS(sbi)) {
 			ret = -ENOSPC;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a4bc26dfdb1a..2742978a100a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -126,6 +126,8 @@ enum {
 	Opt_inline_data,
 	Opt_inline_dentry,
 	Opt_noinline_dentry,
+	Opt_priority_zoned,
+	Opt_nopriority_zoned,
 	Opt_flush_merge,
 	Opt_noflush_merge,
 	Opt_barrier,
@@ -204,6 +206,8 @@ static match_table_t f2fs_tokens = {
 	{Opt_inline_data, "inline_data"},
 	{Opt_inline_dentry, "inline_dentry"},
 	{Opt_noinline_dentry, "noinline_dentry"},
+	{Opt_priority_zoned, "priority_zoned"},
+	{Opt_nopriority_zoned, "nopriority_zoned"},
 	{Opt_flush_merge, "flush_merge"},
 	{Opt_noflush_merge, "noflush_merge"},
 	{Opt_barrier, "barrier"},
@@ -805,6 +809,16 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 		case Opt_noinline_dentry:
 			clear_opt(sbi, INLINE_DENTRY);
 			break;
+#ifdef CONFIG_BLK_DEV_ZONED
+		case Opt_priority_zoned:
+			if (f2fs_sb_has_blkzoned(sbi))
+				set_opt(sbi, PRIORITY_ZONED);
+			break;
+		case Opt_nopriority_zoned:
+			if (f2fs_sb_has_blkzoned(sbi))
+				clear_opt(sbi, PRIORITY_ZONED);
+			break;
+#endif
 		case Opt_flush_merge:
 			set_opt(sbi, FLUSH_MERGE);
 			break;
@@ -1990,6 +2004,12 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_puts(seq, ",inline_dentry");
 	else
 		seq_puts(seq, ",noinline_dentry");
+#ifdef CONFIG_BLK_DEV_ZONED
+	if (test_opt(sbi, PRIORITY_ZONED))
+		seq_puts(seq, ",priority_zoned");
+	else
+		seq_puts(seq, ",nopriority_zoned");
+#endif
 	if (test_opt(sbi, FLUSH_MERGE))
 		seq_puts(seq, ",flush_merge");
 	else
-- 
2.25.1


