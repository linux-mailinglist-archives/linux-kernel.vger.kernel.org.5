Return-Path: <linux-kernel+bounces-161701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DCA8B4FE0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 05:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABA64B212BF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 03:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479DAD515;
	Mon, 29 Apr 2024 03:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="H2Sqj924"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2051.outbound.protection.outlook.com [40.107.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE30D502
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 03:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714361930; cv=fail; b=DjBkwDrlOOwSWuEjRraA1qSpvsYRQF5mYqDauy1sOyvvdTjaVWLlESuakoI+11DH+zuLmXJ1Btb2BmgnkXvjQcIxN6YD0oVJpxMLDv0mCqe4mgcOsSBZo2s9uBXZ+hZNpkAa6l6ymGtCb8j7frL7CVzQRNnd9boJ66w+hxwUhCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714361930; c=relaxed/simple;
	bh=nczn/bn3MxIioEDZQSqiKQwhSCoZra468qkMsCeSoXw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Uu+Csaa8NOJcxAkdZe3BlG5ij4fW49L3pP3CPoogwBVw7wyF83N3mSusRnVDYkh5cMAxHx95nLaihfS9NrFLNn487lzPBkIxNs5tAS6MKarOl4Nmh8tGxBVKLyODqfqtDzcVDBORipyR5fjj5a7FLd3dUQ9kbLlTfIuXhBV/HRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=H2Sqj924; arc=fail smtp.client-ip=40.107.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNteqcj6aapmRml7jR25eioCeZ7NFzFFuJkLM920qvoJ7mUYzQvsgIXEmgRZRlyhiVrD8jVbYBXJZ0f1QaMEydTKq1RMkWSQyKZKIls/PtfJG8NeCqgg40yWYuXc6FMdmMsWDEEg4ca2k5u5W58VG9fg3QmmecFalPkC805Pf+J1NgE2e8dyuj0h1W6igul12mQVjysauvKIv+CLTkTZHOX0K+eLFxzk1J4w7w9Eteuje9MXRAT5dGBDJODczdYoGTuI+vZcaE5fgvjktqV7c81SMDkxEHtR4G9ZDcufpafMigltRJzTZaBLDvR/qLrXhn4Tf1jMnDLX4jlXZoOZ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UA6GbvdGWwzQBd2O7IaYVnPbL4rbwkSkUTzujbKwIWs=;
 b=Xmblv7os79Sv7d9NBMVjP141Ri1JRO7OVrFf6bfkxArGGPC9ZxuP7+UVw1+/qZcBiYydsGkEZyqiGLe6DqS+rKeKOLRfZIfbGwc8BdzkPlQvxufZKTYsox7t0VLdWw1T+sAYczNhpHesxGpDecg1kACE/tHbsV6SmzdBomvuGfIqiVq0Pv/GIxorUszrFcXW+d4x2mTaSl3kcUtaAoGIo2704qgSHCVLa14URGHV7THUqGgVf2qEwLLzjg9PVEY9JqTQ/322j3O5rbnQVr3cEmWd7uGlGYB2CzZp+2SZNBVoyEW9YWqnjWWfDLzhtiociIXqHULaA9Yp82uzVlZYaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UA6GbvdGWwzQBd2O7IaYVnPbL4rbwkSkUTzujbKwIWs=;
 b=H2Sqj924TMABmd9d2zZkEDPQKT6AGxLcb+PgJKbGJBgMOoQXBeWBldOLuVrt+thhI6SpXsKDt5F9KBlhBTxX9G+7swVbt51vC6/mQ17iSxefjqamyuriCoxkOKqTPMbJT/qf7JYLbl2ICHkLamUD/Q2BwVDDevclNy/nTGfl9RUxs//aNGYGUhgi6k693osP4KQZ0lMF1SRekBY+w+vNh9MwIXXPal1Tam6f7EWxHWYkVr8EGnwnjQZk2UPYmZQNZo/4OTQFt659chwak/E9flNXuIk6F3lbq7BfUvOMiMcoQ6rc/PWOVVLydnRUHEOd6zG7a91ZHjFSm6bREO2FfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com (2603:1096:301:89::11)
 by TYUPR06MB6194.apcprd06.prod.outlook.com (2603:1096:400:346::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 03:38:44 +0000
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5]) by PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5%5]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 03:38:44 +0000
From: Wu Bo <bo.wu@vivo.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Wu Bo <wubo.oduw@gmail.com>,
	Wu Bo <bo.wu@vivo.com>,
	Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH v2] f2fs: fix block migration when section is not aligned to pow2
Date: Sun, 28 Apr 2024 21:51:42 -0600
Message-Id: <20240429035142.706356-1-bo.wu@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0125.apcprd02.prod.outlook.com
 (2603:1096:4:188::13) To PSAPR06MB4486.apcprd06.prod.outlook.com
 (2603:1096:301:89::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4486:EE_|TYUPR06MB6194:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b34974c-5086-4e6b-b760-08dc67fdde94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|52116005|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EI3fG8ry2q02F+AdUDJndXNwKCKqE3swjIgYSR2THAOh/fJ53t4v2X4AZFsM?=
 =?us-ascii?Q?1Ggvvo+JRgRepjY+xxWR+1lPdUObEkT0WBOX08sxqa9CeJ5PFgVDAjgmCe+G?=
 =?us-ascii?Q?Jx5VSX0EIHHNL5PcPfuxydNBwdEBsOlAprw3cMEBGpxzSxp82Ech6z3oVjlD?=
 =?us-ascii?Q?JXhEO9m+bjhZUHYLZZAqNLmDkVk4L8pEoXEkjJ5l0gUhIV/bK/AcVPMsERhl?=
 =?us-ascii?Q?DoJA6wcBy9orInBQG/GvBsBO6T+S9SWa72tZ8I5HKwJQ1W8u4vE6i4bjtIOt?=
 =?us-ascii?Q?s8LpCahhkvg8DMc4JWm0ADUVI0d8Ic3NofS36OVY4RJwiXZwdQSp5RxdVi1I?=
 =?us-ascii?Q?YBPuOQYyQcHdVo2zoQtsaVpN+2Z5zJE+ulyRbiaXurOv3g1+nWHp/rLkHuy6?=
 =?us-ascii?Q?bs2xxGlrYOLkglsa+VAweSVETc/cghb3xdSh9OwiwRUr1poBn5xQu7tRabXM?=
 =?us-ascii?Q?ctM3Ed1s0LHIIsYVzTF82Jb1hqr9GgWctfF4/IfHfnpyHtyEfxL0UTSflQF0?=
 =?us-ascii?Q?OQT6u0gUaUJRi/j2NcgRJySAhdh+IgkLO5yCBbs6dOz+pugho76CnESPDbtM?=
 =?us-ascii?Q?AjU1mSXfmVl/dgHDZUSLMmFDjcQlMafI4Nk8Az0EyyPfMIw28V76xUMRtQ5b?=
 =?us-ascii?Q?QNpjJ5IO8QXfHRcps4QMdLwtR4Y7G3TyBnQguS4sSO69E0m5JM0sXRYRSMXK?=
 =?us-ascii?Q?cMuZn5tYvm6IZkEW3UD0G+W7vTk8DTLT6j769fb2Jg0XnCJk8TJCYJ0MkC/l?=
 =?us-ascii?Q?Dlux9KjKNunegVs9UJk35W0Jo3iTJV7a2ExvFOdz1ZU5JQ/V1Sm/N47LIgZn?=
 =?us-ascii?Q?eFkCBREMFnbskw0/aKIjh6zcmgC6JEuVHuJzDxDQfBkDe0Lmobph5/vYueJe?=
 =?us-ascii?Q?gwJFGArU2e8JhtRoJQDzv2eJrFH/GMSrndW5hQZrZJLLWzLq1vRTgkucwRwZ?=
 =?us-ascii?Q?q6kVM8GhjpjN+7pOajUnklPmGyrckrILv5CG/FMLjVYSc+OfaehoeU9v6qZp?=
 =?us-ascii?Q?t9H0io4QIlTBb/nJNx6TdYznUE8Ky6wR9aW+EnwjNN4Aa2FAwyD+r7IgbryQ?=
 =?us-ascii?Q?+AArbOTnzlw/NlInGqMgZRrXIZpttb081zhLLRBoJyT8O6iQckQaSw5moAow?=
 =?us-ascii?Q?oPiqNUkkTYQrsmItzS9JjilX+0yDcq/rnN0tTkL7bp/CbSqrlS+lWb9/oZ6I?=
 =?us-ascii?Q?NBBSX3v4t8OWKRE06qrDVy6gwjgihwb7kKl0yjeXOxdl1YjYBcHpa3wDNhzY?=
 =?us-ascii?Q?li//6JlIvkfFliCVBvU2uj6kE1bhe9LX0gyZ5EJCX9Wco177PGsUHHWa4zU2?=
 =?us-ascii?Q?yEFGVeEHkJ+efjpEwg77iejSFAo0KJ8oQtKrURrERiKwnA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4486.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2b+WxJhnAIw2+7vMhujuH7mfNqswX18wLGSswyiELszv3aO6GGVdlzmy/hYh?=
 =?us-ascii?Q?elkCnE4gtbqmgqhIwuLGlfiZTyhVzHSP60GhJWdONnjB4s++BJimdieDp1q9?=
 =?us-ascii?Q?PtLi5WGBd6juK5HPq2lSuTg2pyO2CnixmRWCqeVqipLLdz8UPm/MEV4agMES?=
 =?us-ascii?Q?D70r6+gqLW0yCKzr9HLP7h8PDmwWkDg/qsG/tCCE35eoFeh4zoxoPsAhVizz?=
 =?us-ascii?Q?0p4yDKvrTpVAfXJf/FDaVRGhAarNySF8/fCJG6oTP7Y733LRh0YFvIkCBowp?=
 =?us-ascii?Q?pt17fkI/X7mllrB93VKW2sgzwBCNagQLq5m7Etae64VxSQo/XYo3+nBVJ4S9?=
 =?us-ascii?Q?YWfNZJwL9NiCPOf1avkUU+PgQq0tio0Z+gtKiWMcmoFiAAhJy+5q/VEorHQC?=
 =?us-ascii?Q?OV/UpCt1bIj2SgwzXfzqkwB5ZnQdmPnsS0OQV7ZcM0k11NTs7+M/Kf7n9KD8?=
 =?us-ascii?Q?wa6bx9vBHhsBZ4dws4qGtFL2BLoD2OuFp6jKDYlUmLTN0Wsmo647KMGuVQZh?=
 =?us-ascii?Q?KSDGnJpd5ugjkMbJfz6nn71lrvQ/90Y/83zXGm3290Ad39xD+HojP54xTba2?=
 =?us-ascii?Q?6lFkhxMYJTtvP0tayC82iepmsdxpQPksT06AGjVdCVZfeH8UAAQDgIeseNaL?=
 =?us-ascii?Q?P825Jc50PULcbcfbdOpEtA21+bIti32jkw/x6KW5vmUIJBoYoDZDFXqAWbvS?=
 =?us-ascii?Q?KaXvs2MC7xt/BkG8ZgJWgU38HORk7gyq/z67eNoEwHVwuo8B00/b+C1ei/Ki?=
 =?us-ascii?Q?5mdet5xjA9RShk4ZX/pLIoPsjDCibB4maATPfArSfWACT5AEk6ZbvfAkmar9?=
 =?us-ascii?Q?imobb1jBoHpqTj3Sqh0149UfDxOusTIv9XPFtS3zIqCOMwg9FHY2DmOOy+Xd?=
 =?us-ascii?Q?7H3hKCexkCJ+2DZhmEvG7/UFdKjwbnFJZA8cyyFs+OA+87DTbKXP9fi1qjrA?=
 =?us-ascii?Q?aLo3tFez8d5gz28V077FnNZCYWIIpPAXAuidIv/zdbIQDt8cZ4UcrvjGZDmY?=
 =?us-ascii?Q?Iu+V83wy6nqn0alns3JJemJ1EQArOJ6t4OyEPokLX7/fI0ZVfLev2jYMYhfe?=
 =?us-ascii?Q?b6Ke7VoEXc5rA7Y3G2chcjCAK+g1wD5UUP4vymCHojg8vwDYBHyGKHqEHRhL?=
 =?us-ascii?Q?8L1wcjykrJy9VwY2xnESQd8VCc+HKbWvuMunDK+LqGCbhgi+PkmcnJoc3PAC?=
 =?us-ascii?Q?A5CijzJIkKvWmoIHuRO0zpHgm425RwhGlMWoyMWcxRpeKtxi9CW6J2iQpFSD?=
 =?us-ascii?Q?XwvFAFwuf/PL6fSnG5Cw+5uTuiL68vus4QNZoESyHozWSdq+N6IUsx4Hp+Mi?=
 =?us-ascii?Q?lvfV94h3mg6Qnxuht+/t93UMEAea7QqU8UTBadISO7viI1HbjhqDpe7w2VzM?=
 =?us-ascii?Q?Ga3WMtPIh2wBCIUQ3Fo/p3szkusfrEn65XoKfwCwe77zpiSLy18yoFyVoLgS?=
 =?us-ascii?Q?8wRv+SQQiBi/kD3GvgtQFtk/m9SqhqiUdhW1aWPgQnmTq+Ckm+PokBeybxeu?=
 =?us-ascii?Q?DZu5nWJOMUWj3oHRnIKDj2Z9rBssUbrbUp3/iVkGZ1GtbwSOAoSojjPC0KiV?=
 =?us-ascii?Q?4NFbl2uktnN6J3qydNiO7fVBlOn1JJHEE7ZASudQ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b34974c-5086-4e6b-b760-08dc67fdde94
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4486.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 03:38:44.0175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +qDf0Vvq/CKIN9dKR/6VN/brz+0c267Ej70ozOE6pqZWGH/a2whxdDQhC2GWJq6XllMYkI5C1G2BH/DoSz9RtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6194

As for zoned-UFS, f2fs section size is forced to zone size. And zone
size may not aligned to pow2.

Fixes: 859fca6b706e ("f2fs: swap: support migrating swapfile in aligned write mode")
Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
Signed-off-by: Wu Bo <bo.wu@vivo.com>
---
v2:
Fix arch-i386 build error.
https://lore.kernel.org/oe-kbuild-all/202404290041.jfIs3zkw-lkp@intel.com/
---
 fs/f2fs/data.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index bee1e45f76b8..6fd877c69c03 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3916,15 +3916,14 @@ static int check_swap_activate(struct swap_info_struct *sis,
 	struct address_space *mapping = swap_file->f_mapping;
 	struct inode *inode = mapping->host;
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	sector_t cur_lblock;
-	sector_t last_lblock;
-	sector_t pblock;
-	sector_t lowest_pblock = -1;
-	sector_t highest_pblock = 0;
+	block_t cur_lblock;
+	block_t last_lblock;
+	block_t pblock;
+	block_t lowest_pblock = -1;
+	block_t highest_pblock = 0;
 	int nr_extents = 0;
-	unsigned long nr_pblocks;
+	unsigned int nr_pblocks;
 	unsigned int blks_per_sec = BLKS_PER_SEC(sbi);
-	unsigned int sec_blks_mask = BLKS_PER_SEC(sbi) - 1;
 	unsigned int not_aligned = 0;
 	int ret = 0;
 
@@ -3962,8 +3961,8 @@ static int check_swap_activate(struct swap_info_struct *sis,
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


