Return-Path: <linux-kernel+bounces-124204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA19E8913DE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58BA6288B2F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360B238FA7;
	Fri, 29 Mar 2024 06:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="dlsUyKhp"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2114.outbound.protection.outlook.com [40.107.117.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA13120319
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 06:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711694579; cv=fail; b=cEBowPLJeLLprHYWSHXiTYZRN4Yuvs82JnMchTEZdTgQkcw/5MS8+0LGuvXnRQT/XlI2vikHFqRyg0i67yiKegjXiSFpL66SBCLpQAyu56xLGcWNXcMxLdjpKxhZgq3Gx/y1VHesEsqGFW6aJSLfFMy8fZXeW1oPPWDGNmPrX5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711694579; c=relaxed/simple;
	bh=+699KWO2r30Jp7z9BnB3mHfFT7G1vVENTubVktTWVUE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=UCPi6v4k652fejyiWcLixYwy9WL+3/EKh4dogAqAykn+ziU+ZA+IL0solSM9ZEaMFOq2aqzBa8oJlyDXqk7K1+LVAX2WnYOfm+A4oOTMQJJ3yb7oIsOIBt9LbYouIhMiXAgjn0fjTkrQ2VYNeUY3vHADFZ1zFP/pkMBKjKgS+Qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=dlsUyKhp; arc=fail smtp.client-ip=40.107.117.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JM6UIzVGVAvMnEQOmOHal11VlNwnWclrPczZ2qa8ckd1b55guLro6o4Xzw/qNNeXlO+Q8mm3464Wh25xPcHGecfchuX1yfHkfBbpvquPGjVWu3LmQgQfXBV5OWDF7QCtB2G+Dx/qpICTjoJlhIgEIC+5+EZpHMItZUbnfmoUzaeU3Jv8M+TaC5XaTDQUb1eepA9Ro27pYwnYZK4alVnasfkC1FFjFqn4jT8LDPigIrR7gVZ7qb5WEI0fsJ3er3pPWufcRd/8WwuJ07R8n9Ug5B8DAHlmXdVBnoykRSZwIWl7uIOL3jvAwmL79fBqKeGgCvXHQvNKlRfsdnj0FsP70A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKyXRhn60POlCyZ0o3zdTcg55ZMiH0OAcfx133JR1T4=;
 b=We9TWUWmRoxQgADIDtv39oYg1gRU4ocizlSqoPKt6ZunIkvVC3wa9CPDni7DSs+r8OSVSNV9S7qJIqDup4j5TbSoDGLf7rS5L3X3jZy8lp9lxzBnAWQ6APlvVtK635K64DJtnl0JzrUsWsUWgY+RoGVm79AjlatGF7TwsfObhmiZZKm5xDQjSi+bvoLr2fNBVnWfuEcFqtaICpRucO3AVcLsUcMUR30icJji1POhZAIx2csUPbbsdmCCnRMDMm4ddPYRt+lY59iCMc6PsnLf/c5+jkZCX981ojKUEQz+XclktCyhYoSn76R6i6waTYpNH/DFMNTLl3UWbhXKe0GXhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKyXRhn60POlCyZ0o3zdTcg55ZMiH0OAcfx133JR1T4=;
 b=dlsUyKhpYZu6IIXWATsOLU0M688us72orek3sminInRZqWsDqGYDl9da52AzB4C4LAVr8ksL7ij0ynukef9iBNEiJdKU6OVq3kyr9NbB8a9v2J5UHDqW8pY9r3dCyCOQCrkAxKFA+AVG31IxQiUqxnR2DKVN0+IP/P93FkBQwmDAa8djKCsTe2+vQPJycFHC6iP/LJTZV/x+Fp7oDRfGAFf6tyObahiWq6Mk4rxTEsqdQDnmf6apxxsSmg4krtPVaC8p0uyg0EMJ6a5dBAbqbN/tXzeRBxnSFiU8TyHii0S6v/nxoCgMXkpa0VdkoRf1+sAOBiGSOlOidUHFraNJfA==
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com (2603:1096:301:89::11)
 by OS8PR06MB7466.apcprd06.prod.outlook.com (2603:1096:604:288::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Fri, 29 Mar
 2024 06:42:52 +0000
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::45e1:65db:1bb:70d4]) by PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::45e1:65db:1bb:70d4%6]) with mapi id 15.20.7409.031; Fri, 29 Mar 2024
 06:42:51 +0000
From: Wu Bo <bo.wu@vivo.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Wu Bo <wubo.oduw@gmail.com>,
	Wu Bo <bo.wu@vivo.com>
Subject: [PATCH] f2fs: fix 0 addr of multi devices when dio mapping
Date: Fri, 29 Mar 2024 00:55:08 -0600
Message-Id: <20240329065508.2398202-1-bo.wu@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0121.apcprd02.prod.outlook.com
 (2603:1096:4:188::21) To PSAPR06MB4486.apcprd06.prod.outlook.com
 (2603:1096:301:89::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4486:EE_|OS8PR06MB7466:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	M3X1slR6IDaekK6e0oNbGBL6g+BMRhH+5jYYYTJj2O8TkcaJxiBO8IYsSp7Cok6aiB7KfmuBrcfyESt80PkLE2VT+3hWbKGFpjHxO5QBPOvPq/5b5whYcdWsVc9URLK3Rk0uXfJ2y4CpFBs0qLYg1e/hUcGXOpRyRi5zWQZj/TAW+qleE7SEC9PBlszdZjsjQwdVGD2TnUL+ZxQMKR+O5lCFaAkb9yBNaFTde549Cm5vasDlFJ7q2lkugV/sbiHmGJ1bbvT4kVZ/P/m+sGDFEQLjVh24cuXeL0Xcu0M31qx+qgsSMJ39gcRhPz7r9u/x85GzSQRUvRvYZcO4IINYCjE31Oet3c5qAgmR+guukc04fCLl69tkUcI7PlkIGoWQ7f2P/VEg/KCq3J+bJkJlTxX+S6bWsRFdtstfMn3409Ok4xKy/ipdPrGHpfjZYmI4LUeVZKAyImM9gMN279jAdHAoyU8EL3g9COlAI1dl5aff7fOzVqF3KQNvQxmCIewJe3iUw3LOP1hypm/BIH862zw3RgVoIIzd/2A+kBlnw00h5t9dZvaB+rPeCP1vDVmCmKcO85vQmqbVHxbR1pu4jzLYWiWPgp0T4fb7KWxY1/fmJ6RSASo3epAPg4PH67ug1lcl0msOWXGJ5Xgop1XBoiUhV4mgz8rStwDQnA+S2eDkhRyt6DwvLmLYQ8jw5AP26s1Xs5bZqnTUvgsXvA5UzdeEGlRtRGCaIk22b99dHQk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4486.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FnHEEaAoa7+SqxWpEDZQiX1pQK7abpNOly3MySgj/gQWxQ7TuVqSq1AVrXKw?=
 =?us-ascii?Q?guEuBO4StMuOWTOmGLM+HK5yorc3ZpLicaIssOpSrgeiALq9r/8bZYgtmOGh?=
 =?us-ascii?Q?zgVnAvg6N1GLKvXWYlE8wQq48qSYiJhC/1DdAilSMGgbb11kKi9qJ5oTlXCv?=
 =?us-ascii?Q?ycCp1zV9XHYSTltkMnjHM0kYLnOn/0F7LCl3gkZQtlbuB6JgZmW67jbwI+en?=
 =?us-ascii?Q?3JfhSAAhx4cbYYQ+BuS8kaS3uinIeDb9v3Qzb3b43+oyQ2NjfzUzTt/xaCG7?=
 =?us-ascii?Q?ptf3ycJFblQU69CqloFx7Xsngx9b6tZcdLQt3SeiFgLXxDyv2Rm7Z+5Wf2Cg?=
 =?us-ascii?Q?pj2xiz/QDYNRjnIKYudfhTMO3fdaBi0MyvfbR7c1jW94WqwIQwtj9wlBZ31A?=
 =?us-ascii?Q?UfDic42H0gW2D58/okVlNOYK//utbgLwNzpcKumWquDSOR4PGK584/dNnDLF?=
 =?us-ascii?Q?cOpTPMoXb7NcW05qv837BFWQvCXUfCUF5gKrHJ/DuUTEx8pdDoZuMeSeWoHX?=
 =?us-ascii?Q?9AkzcQVLUVNDig/ydaMCWXawxKzbpS70eVjZ0k+VDHeRP4I6OjRbLiUZXDvv?=
 =?us-ascii?Q?KzWLVwMUjuV46lNULkxBHolCIL9wIW0Gjl+F0LmeZhiLF8QH4NvJTNykg6RM?=
 =?us-ascii?Q?kOLd80kbJHo8P7VB/29z4hh+PGGpa6ilWrXqCWiS7EAbAXkrsOteDY8P2T3G?=
 =?us-ascii?Q?qtGQZQf/hRfuR/OwQ0RHAGio7iDMmxA3sGGa+6O6FsUlFxc7S/T3Cf2M2HAx?=
 =?us-ascii?Q?PrDektI5HazZMwGqLrl6u5PQM7JfBJ4MI7OJ9FeHAMIIyKjLjCkg9LCgNObx?=
 =?us-ascii?Q?hUxbTSXaQwmipHqIpePIcXuPBRjWHeidDVHaYpaL2OKFE09K4xMNX0SN14rr?=
 =?us-ascii?Q?pSpNY03HZw3W0NmCLTgzudyFsbPgaNBQ8nQNM66qDNGR5IO4FzxjiWZtwaKE?=
 =?us-ascii?Q?kahfV3NaX82u1G29tpskXQjyaEs1xUNQANqoFWh/TjRdtpY/0GVt49P1bXCq?=
 =?us-ascii?Q?wvbbCMlziCgjCzIowaFQrqAwLxoApymGxQaP197t6m9SnJ9sSAgH6CTj8qqD?=
 =?us-ascii?Q?qAyLtTZWG8VeLG69Kr+9dvfWZx/8JOPxC5aGXn+NQAdk/QJ/vFIpM0pQcGI1?=
 =?us-ascii?Q?lI8IBNe4UKhWa3uzUwYLPdoZi9w/ZDEDu57IJL2cPrrIORAiKXAL3ISitec9?=
 =?us-ascii?Q?Zg28E30hpNyaKbAKoG18/I2aIcRMeyvi9iL3WXY59csJClPapjVMuHBwmny2?=
 =?us-ascii?Q?r8mx2EbnuBpz3M/8sCw8NghfpFTAV1BVDgkwmZQb4uHvIvSbAJkCyYLkPuyO?=
 =?us-ascii?Q?kgJAUygA1zBJQzeIa4+9V6TzTGTFzSyNWE33j6xKF0L96bO+wgwGlYmAaYu3?=
 =?us-ascii?Q?d2YwLbxwZXRwRNoRLZEEAg52BVD/yGvhILwsMQfgem25J8fUeu7msO3SOlO4?=
 =?us-ascii?Q?9IrjDvSgORemPPBKcdn8B6dH0aDu1g3vh2C4We9CRB4FZ6vdZfel4h2Vig7d?=
 =?us-ascii?Q?0xDsS0IHGDr+ItES+eP5KZeDo8WHrH6WUrtek9i1nRWR7tjgr1gLakXotVsk?=
 =?us-ascii?Q?Q9wIDooAw85/l66SlCVgPmUzydv03luyToDErDjf?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3afa1f57-006f-4476-babf-08dc4fbb743a
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4486.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 06:42:51.0069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mDXRMn2f7Kvh4HGPA9YAymmX4p1C2LHckevlHvZCsDIofJ9hdei+duFR87fOC4P+ojFCbDDGux/wXMT9FtYT1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS8PR06MB7466

Consider of a f2fs system with 2 devices:
Info: Device[0] : /dev/block/dm-46 blkaddr = 0--3fffff
Info: Device[1] : /dev/block/dm-47 blkaddr = 400000--67fffff

f2fs_map_blocks will return logical addr of fs when doing buffered io:
f2fs_map_blocks: dev = (254,46), ino = 40020, file offset = 462865, start blkaddr = 0x400000

While dio mapping will return the addr of device:
f2fs_map_blocks: dev = (254,47), ino = 40020, file offset = 462865, start blkaddr = 0x0

So the addr=0 is valid when the map.m_bdev is not s_bdev.

Fixes: 8d3c1fa3fa5e ("f2fs: don't rely on F2FS_MAP_* in f2fs_iomap_begin")
Signed-off-by: Wu Bo <bo.wu@vivo.com>
---
 fs/f2fs/data.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d9494b5fc7c1..dca3628932c7 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4185,7 +4185,8 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	if (WARN_ON_ONCE(map.m_pblk == COMPRESS_ADDR))
 		return -EINVAL;
 
-	if (map.m_pblk != NULL_ADDR) {
+	if (map.m_pblk != NULL_ADDR ||
+		(map.m_multidev_dio && map.m_bdev != inode->i_sb->s_bdev)) {
 		iomap->length = blks_to_bytes(inode, map.m_len);
 		iomap->type = IOMAP_MAPPED;
 		iomap->flags |= IOMAP_F_MERGED;
-- 
2.25.1


