Return-Path: <linux-kernel+bounces-154959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA95F8AE3A4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EBAA1F23ABC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC477CF25;
	Tue, 23 Apr 2024 11:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="cm4aL/Cl"
Received: from SINPR02CU002.outbound.protection.outlook.com (mail-southeastasiaazon11011004.outbound.protection.outlook.com [52.101.133.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B3D20B33
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.133.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713870915; cv=fail; b=OLvhv7bXQrPC2MqYlQigKLc8GTmHvpM6+VaBEWQDBjiKPJ/ueB4lZEBXdn+vEQUnGd4p/2fzul/0zsDsS8rMPs647cn/WdLHKQ6XjDVlYOrLuNrVP1Rn03f1u4BBf+ViWteufDCdKcumSDRgo99nhxuc8azV+oEfRabqlK1N+Ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713870915; c=relaxed/simple;
	bh=u1c/AjE/8rglRPmsRbzS/DVveo3PprG4HmQYsyU79K4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PBLz8OYM0hyfnKXp1qr5dF9z/E+y67UJ/SxJOrSTwtTWWQhYGBnzbF4DawFWvOAUHZYmEVxZzS1I1Hs/oRrJfrbRw39HknYTNQzRbr+X3m552aQ7Vpjfg8EmJEk5UMM3eSS8Hhd9mtMC98+BXD1Iuo9F8VjYlNR02Zj8dk60DeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=cm4aL/Cl; arc=fail smtp.client-ip=52.101.133.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVVm5l5S2zr1+N/Lhm+6u3tvCkwJXysWi5m0cP0jNdUysAe9yaOtohok95KgzQ+LFIAQr6QKAhK2mr0tYSgm9jb9LIwTNNq3m3P90vRwdTN+LYNSVSlo45JXYY2pkX6sn4/x6qLFJhihR6RNG5VJ4wRHjygGtWygVAkBbrviDxerhn2lz7lCYf9g5W6aYY0MBl6aRrk5MYOBojpuB880CcjL8Pr72zPUp1UVqO41pM464Dv8Osi8fgsmS2N0issoSqoxqzfJimM+t93aghnSHmzi3zZYzO4AWCyusXRfyS/5FFNMR2NFM+esT4qURGB1JafvEOJTLsMFwUh286Kw4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmCTpefieJRDInI6xnSs5CW3ict/+l2b5AU16ablbDI=;
 b=PZNuvbsABIS4XEZnIxtJmATF9+uUe2tl65Ny699Ex6UC0uJdhmXPe+z14ALfGH9eIk5XEwpstKWuFNdCLGX612OvT+ID64Nox2yn5bZYMVkF5zcKmV29oCme43uIJmageiXa8w6/Pv/gpTkO/GqzeasSJpXR9fkESlF1g8g7ERnFFtpaZotL0IOexN6SCbnQtfrgYJd6vY6L0C2we7C4KA4QOXl1bk2e2Nb2lGow3nldgF53B58gvn+9tqepK7EoV3KIw7rtVKz01OXao3TtH3i/WYXn8heg8Wj6/vXMk6/1o6XG636I6VWfKnk2DSwtsHAy2wEpSXnQ6exkNeKrUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmCTpefieJRDInI6xnSs5CW3ict/+l2b5AU16ablbDI=;
 b=cm4aL/Cl1EKeRXHjjtgj8cA663KvpDQiiLzP2ldHk2aRLrqlD0ZD1T5KT2o1j6h0Wn8eRMxTqMP9m/aH1eOlfCbq1GjzNtjmFMfFpgAlPtS0+lUprsIG+9sLumNI4Cg3RgVj/bLQ5kbVku3DKzFPuaknFeMHp4EIbYZQcuGgYtE1jpEDgA9XP8SBUz4psI1A8yqqV+g0Ug/ZWNjPQDKl+BskDlF4nF1TBSBkzWMPNVuZUGTP4uMxTnP50lN4IbmPGWwGtg/VsZ+hWlO00V7cVel4UWHEDq4EcxFT4Vm3t0KP0c6qaDADL5h3uE8xIh88UuogIJPNxsqi36uA5TtDDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com (2603:1096:301:89::11)
 by SI2PR06MB5388.apcprd06.prod.outlook.com (2603:1096:4:1ef::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 11:15:08 +0000
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5]) by PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5%5]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 11:15:08 +0000
From: Wu Bo <bo.wu@vivo.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Wu Bo <wubo.oduw@gmail.com>,
	Wu Bo <bo.wu@vivo.com>
Subject: [PATCH] f2fs: use helper to print zone condition
Date: Tue, 23 Apr 2024 05:27:59 -0600
Message-Id: <20240423112759.4081008-1-bo.wu@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::13)
 To PSAPR06MB4486.apcprd06.prod.outlook.com (2603:1096:301:89::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4486:EE_|SI2PR06MB5388:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bc88a35-c1aa-4f1a-2dfa-08dc6386a28a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+vYvIv0Z2JGOb2inXli/xRottIH2PYgC4gXpbcwltoc9qEVtyEPF/HC0N3Ks?=
 =?us-ascii?Q?kY7wYhX36ZPlPv5lCVS4dNyDS0y7g3fJ9lCH4c/e79J7zL6f27Ff4w+gjK1y?=
 =?us-ascii?Q?6ZXPyWFs+SJSpqrejHvMuFhWTkRR3FhiR6JdYAePTu8FQF4ZLTrWTB1aK0kW?=
 =?us-ascii?Q?CeoJiZGfgJU4fuyDgJxq8RauGZn/kAHshDklIO7nScBHtEN8vFPVhofMx5tw?=
 =?us-ascii?Q?/prbsm7o2jhqxp6U9Ud9v5UnDGEUg3bWEiWIBJ4YmYaUp8hWCM+LlpNn8zlY?=
 =?us-ascii?Q?F9EMj+NszTyacGPrC4km9wzFUuadmo/b/G6MKqucOhZEs8SeXFEvMMbKO6fA?=
 =?us-ascii?Q?zm+LjnStJ8QVNqqc25+b9CT8qQJxG4JS+ZfNiIdI/rIFKUOWf2gF+/oqzbYA?=
 =?us-ascii?Q?6G84bkTn8rSsTa4HC4W7oyZWc8aDt3rxCKU6vWGVFth5JnlEnr2pnmCSQk+3?=
 =?us-ascii?Q?IaixFnaup0IN84TBE1+83rE9Mje5NT2E4LOEWmyMqhklyCqoO9SDynXKjhiD?=
 =?us-ascii?Q?fJZSzaYoliDCUEkzWHn1CJeypFaZylAu/aQ1d5S32Biu8wAOV5GGXE3rt0qG?=
 =?us-ascii?Q?peIWB37krfzu3ipE9eABYdmjZqCGh3DJ/Nfw8ltVKbwTPzigl+kUMARft5R4?=
 =?us-ascii?Q?UwTzIaHb78yPR0Ef0ZBVlX1cISbVnzXrM2YsAJmJde1Y/+1jOlcWu856ovPo?=
 =?us-ascii?Q?/d2XJJ/DqlQUGI1gNVEnW0MhFHPZupWY+niiinCvF1n+d6Y+H8h7jbU66k8r?=
 =?us-ascii?Q?nKCWVgYKWmPKpD259T39rzto13mSFVuf76pz86tFEgevBl7ar8J6jDxQNpza?=
 =?us-ascii?Q?7wmsZOSZSZORPZ+24Pr7ucCD/zbfC5RB37A1YCynorxBW8w8Uf6Zzv57cWHW?=
 =?us-ascii?Q?L8KZzPahvPQKZklbk7w8KOW9ayYiRQIbj/nQa+l4o/wnKs7Ver3IVabStQm1?=
 =?us-ascii?Q?DRdzaDr78D21FqZR7IauZRFc/QYVhR5ZTlAskUVA3yPh1J6ZO9uSmkeLaXlF?=
 =?us-ascii?Q?IUOhgX/m4JvVTCwlvhr1+7kG9aQR7PT91qsP4pQ9SGQoEPS7iln2T33RBR/s?=
 =?us-ascii?Q?gwkkuJ9QA9c3tp+lkkwRHZ1KMJ3SVZ4F3AfiYjKElTzK4ab5d5mKinZX9ZrY?=
 =?us-ascii?Q?KQ9nAn7OKxwjdJmF2yWLaNsfJl/zL7g9GE8whB86AvaCoBwxSxmZTWs/SJ+Z?=
 =?us-ascii?Q?nlHj0dPTPGv7kDK80L0AKBamA84ORYAizmRD+xmy8NLpyYWTnHPj2koKsNl7?=
 =?us-ascii?Q?M/qfsHeWcAlUYF3OwvWMMA8IspCgugoyHLaOIIwrIfrJhZvC1poFy3hGimt6?=
 =?us-ascii?Q?KpbThfTSx855vHaQbcSS2EIjC0oa3hPQjFsYKAyMtjHfxw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4486.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Btd750/jtY53OIUXNijD+zZ0TLEZ7GQ7r9iNLGgx9toz3Qb9aBwbSoNDVAAl?=
 =?us-ascii?Q?k+FVCKQ5OI/Ys176Z7uBF+aS9eQK5Sd9BWSw5JymrhaqNuuI89d3PnD/U9cw?=
 =?us-ascii?Q?NOvbDiOAq7cU2Q3P54PdGxURMZgELqWQV+HMBmJV9+OZ2Lq7JOkp0euXKKZT?=
 =?us-ascii?Q?Z9TysgQFAPAOq+jKWgmXB6aDc3H6iDHez+sU5nPZhoyZ44c5PInf4bNBOAzS?=
 =?us-ascii?Q?0Y9XDXkNlVDSy6e3YURZGKaba9lJkijj0F9Zu1CaENluDUJUuidt6QWbdkxW?=
 =?us-ascii?Q?VN401Oopd1zlCcJgrbDQENvruOr9jXGYpbAZqcc0B6Nudrl8o+kVJlj4l60n?=
 =?us-ascii?Q?YMyJgT719lGiYfQ1ueKQ9pOPGINcCQgL7GSVwrqpXpgMxcuU6L23hyqN01jB?=
 =?us-ascii?Q?5/xoMjqa8NTjjHqGf3XadI4HEynzyqsEfFEmNnodjpWMzVGqrMcYURFle3Ly?=
 =?us-ascii?Q?GXzSpG8n7mIJeV8YFb2izSjjNJaX7iBwVruiyKKC4QdtZG/nunxGC5NHgfsG?=
 =?us-ascii?Q?+SH2o2p33Vo30gvYHu1nKqI6tgCrw4Dg+KfgZWgXOE90tULhVBNPK0jq+gkm?=
 =?us-ascii?Q?NSe5u/1uwUIWR+clssB3xZY2dyjv3c5jE1+GfJoXUH/3W308ZF93tr+GfGIW?=
 =?us-ascii?Q?amw5C4Z1LTvObN3adk1DjCimVFnGoVIAQYDkzuqL+ninxQUqZj1qh+UDYPV6?=
 =?us-ascii?Q?Vd2sGN2pg39MEFjULgbX4AYJhUQ+c0R2/r7kRGPfzcWDMMlSPpTMDESLFkOq?=
 =?us-ascii?Q?xTVLmIRaD0njXLDritDHU01foCFU1Exw0HSC3sgJz52GuOSjZyZii9/5i2f8?=
 =?us-ascii?Q?lkGNwYT2w8DgeG9DukJ9w9vIX1UiIXjAzVpmv2FcSoeMyadv1EMboiWG6WS3?=
 =?us-ascii?Q?JOfS2Mxrh5PcrE7qa5wn9aMMk3mx7UqVKj5sb/qF+nA0Z/1ELwaf6PQmKSWh?=
 =?us-ascii?Q?9JjuKhpfgWWY0uheQSpFPJBmD1qfD2qZ/4yZl3JGjlyBN8ksVdmrtPLP5wDU?=
 =?us-ascii?Q?Cy/eEYAn9S7F9gmIHR/gAghcKATpd6ACGeesqdxFlY+sL4SaaFD65VexFUYd?=
 =?us-ascii?Q?yPTq4LCqx91ZoYw/sqkDeYGb4AWY0yiiH7d0nEu5IyYn1few4i2ZP50UYRns?=
 =?us-ascii?Q?7AMBg+890SmFw86r0iGTeUDsq4JiVe0B18+WE1GUI1RFM7Gs5Cn2wo2Q3Iwg?=
 =?us-ascii?Q?wGLqy+1OEZVMZO2gEAorMWnzoIIKAbl4gRuw80sTg2idDo5lr24rJzrPxdEY?=
 =?us-ascii?Q?afLRvDogSA6GcHCiYgvUmPFZMj+fuAHLiRm7utmrWYLSwMurSFRUYQX/JJsu?=
 =?us-ascii?Q?HkDce8Q6Yaumpmsc8KL3xEwPih8OnjCx/QHN8S/chzZdp5eh5687ZwV+Kw5c?=
 =?us-ascii?Q?4UITJvJ3Wa0RPPB6L4o4ftxNOfWeebz+k5v4PRR645eWEH2VGSXRMXBHWGfS?=
 =?us-ascii?Q?9SK0fH3KkS3vrEpVJ2uA2uUg/FE66lxX3vua1Y/2enPtH4bKCtPs5BAT0YY5?=
 =?us-ascii?Q?KGlkouPuOdQSf8DyjtPd0KBTCLx8TNUfgNOa6oJb7jD3EIvF0uMMbbpzcIdR?=
 =?us-ascii?Q?eqvKbNiWAMuMcke2yVaBAFviHzNWohhcCimq5jX4?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc88a35-c1aa-4f1a-2dfa-08dc6386a28a
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4486.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 11:15:08.5640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZNSQdxMrzB7XoXxpKVAPFo4zzD6ugAh4CXXrDRLL2WuZ8ObQC6/YOdWgFJxHU+5FvS9gfKc1KXd2BvT6b/pKqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5388

To make code clean, use blk_zone_cond_str() to print debug information.

Signed-off-by: Wu Bo <bo.wu@vivo.com>
---
 fs/f2fs/segment.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index f0da516ba8dc..22d56b99f930 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4961,17 +4961,6 @@ static int sanity_check_curseg(struct f2fs_sb_info *sbi)
 }
 
 #ifdef CONFIG_BLK_DEV_ZONED
-static const char *f2fs_zone_status[BLK_ZONE_COND_OFFLINE + 1] = {
-	[BLK_ZONE_COND_NOT_WP]		= "NOT_WP",
-	[BLK_ZONE_COND_EMPTY]		= "EMPTY",
-	[BLK_ZONE_COND_IMP_OPEN]	= "IMPLICIT_OPEN",
-	[BLK_ZONE_COND_EXP_OPEN]	= "EXPLICIT_OPEN",
-	[BLK_ZONE_COND_CLOSED]		= "CLOSED",
-	[BLK_ZONE_COND_READONLY]	= "READONLY",
-	[BLK_ZONE_COND_FULL]		= "FULL",
-	[BLK_ZONE_COND_OFFLINE]		= "OFFLINE",
-};
-
 static int check_zone_write_pointer(struct f2fs_sb_info *sbi,
 				    struct f2fs_dev_info *fdev,
 				    struct blk_zone *zone)
@@ -5002,7 +4991,7 @@ static int check_zone_write_pointer(struct f2fs_sb_info *sbi,
 	if (IS_CURSEC(sbi, GET_SEC_FROM_SEG(sbi, zone_segno))) {
 		f2fs_notice(sbi, "Open zones: valid block[0x%x,0x%x] cond[%s]",
 				zone_segno, valid_block_cnt,
-				f2fs_zone_status[zone->cond]);
+				blk_zone_cond_str(zone->cond));
 		return 0;
 	}
 
@@ -5013,7 +5002,7 @@ static int check_zone_write_pointer(struct f2fs_sb_info *sbi,
 	if (!valid_block_cnt) {
 		f2fs_notice(sbi, "Zone without valid block has non-zero write "
 			    "pointer. Reset the write pointer: cond[%s]",
-			    f2fs_zone_status[zone->cond]);
+			    blk_zone_cond_str(zone->cond));
 		ret = __f2fs_issue_discard_zone(sbi, fdev->bdev, zone_block,
 					zone->len >> log_sectors_per_block);
 		if (ret)
@@ -5031,7 +5020,7 @@ static int check_zone_write_pointer(struct f2fs_sb_info *sbi,
 	 */
 	f2fs_notice(sbi, "Valid blocks are not aligned with write "
 		    "pointer: valid block[0x%x,0x%x] cond[%s]",
-		    zone_segno, valid_block_cnt, f2fs_zone_status[zone->cond]);
+		    zone_segno, valid_block_cnt, blk_zone_cond_str(zone->cond));
 
 	nofs_flags = memalloc_nofs_save();
 	ret = blkdev_zone_mgmt(fdev->bdev, REQ_OP_ZONE_FINISH,
-- 
2.35.3


