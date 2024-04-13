Return-Path: <linux-kernel+bounces-143461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD3D8A3974
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 02:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9401828425B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 00:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749FA4A31;
	Sat, 13 Apr 2024 00:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="GmaFj0Ov"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2069.outbound.protection.outlook.com [40.92.42.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD89A2F37;
	Sat, 13 Apr 2024 00:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712969603; cv=fail; b=H8ccWSPzY+g9Ib+/J5YmWibPlYcUuksr7cTz8lcXBoBG1dQpbFk+nVtgyyQLOKOP6S74n9hOI5zLIJctWXZzgntLQvhx1tfMH5xXXXtnpcHiBCohemPP5pvBYIoK1YCEPgLcuYWv4btTKxx3Zhj9JxD8jc77Y6mT0kU8+LrBeXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712969603; c=relaxed/simple;
	bh=1KiTboskeQQnHKXL4/Rrf8iEz99jEOgN550S8XePDN4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bNZeshO0TWAu4CuLnLOZ3I1xtr6YOg19LVUFZIAK3K6bt29OrT+fSOkD8rVAI7+N1vaZWOTRsS3n2BmMlp+j2GlKAW4U/N8Ko0xexlw/3ISIpRs3rdSlsKuVV1UJaO4AneleYIDEU+TCqqLCpwdGBFRYfhhSkZnEn3P4bc/ajSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=GmaFj0Ov; arc=fail smtp.client-ip=40.92.42.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCYYFkaxbx8Qi7lvWJ4X968FAj/s3j1PVLKRH3torST/A3GDBBj61Aa0FZSOwgpwyBDENNbnkSg8PhPyIpoDs0UxOkhOLjRhoSd3llNYAflXbaV1NXyTmdkAJ2TSHvrnr0FroCB4HFIl9NdwjYrlpSTpjlf56EMdNzqgrMHCL78C+NMFJGVJ9+6Hvynzm8lU1YMOQUiP/xcNUw3h1OSMUXSaWax5LMXEb/Th3Xgq+WCLkHuVXY2gVlXYv6RevcCs8Xkdtmv9VxIwFnBLwrXTV0Z83b5rB4MPgHGXzETGzXY8SqyqnHLFMRHyO/4A7Xnpq05qev+BSL2+8cmAOLIW9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+QIa4z+QixFOXxymWv++tDBcIByVapjSO8dHHx7Uek=;
 b=Zk8W1pxfYBscX7+XCDsrDQD0MO56xNyWLDco/3u9Moog8nUH5cLJJJnH4rCiFf7qsNUZG6itJmmuv1FkicABg/hrV2EXD7R+hV39fPN0NUN8ep+xC/bidvSj18JjKPTZInO/VnwIB6JjCM+JEBDqLVTnvw/Soo7Y6d98CI9LyOkMV0p1nzzOE6x4wyU0PykLnyXBfOfaCNQwubPO9UjywZ0pxtM43CZ2E1oA3AMD1YZX7H3jetdiAScF+N0qtSWWrApAyJonUrSlnXw/fZSXjH5M3UwwvQBZVNRFg4PwbMyZrZKd0MaX2ca8nh5aIyuCac4c0boVpELLSpaFgrTW1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+QIa4z+QixFOXxymWv++tDBcIByVapjSO8dHHx7Uek=;
 b=GmaFj0OvX72MYVjckoN95nwWzEKK8tKIv6RDx3Q4iaT+Riqbddp6cKhNenYOiPM5HLEz3vl8ZWaePjSnVGqYCbYFrRp9tyZewB+XWFiijerwtHafrDZbSymUwLNDtmfVgYyzCfNf9f/mzn3Y7LRT1urGBy7EZFacUZXcp14D9u4qP1km7D85ZPp651QC3SEaTb1ujHAwbSX+pNkVRyvtZc4cu+nR02659TlXDpfpb469Rco+RlyigjlJgMyatW3GTjd8VDQbCKYKHwonBaN4pPa8LJ8z1ajLwKR35MOZW0GjOPUipC9GuXPYq1OGJ9kjhRy5QJll7VAekSTUTrifbA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SJ2PR20MB6159.namprd20.prod.outlook.com (2603:10b6:a03:504::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sat, 13 Apr
 2024 00:53:19 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7409.042; Sat, 13 Apr 2024
 00:53:19 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] clk: sophgo: Use div64 for fpll rate calculation
Date: Sat, 13 Apr 2024 08:53:33 +0800
Message-ID:
 <IA1PR20MB4953CB4FCCDE82AB25F6880EBB0B2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [oo3N9baJdD8PNfwAo2QnXXdhJXed/pA/10Bs76E1tZA=]
X-ClientProxiedBy: TYCPR01CA0157.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::10) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240413005334.372444-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SJ2PR20MB6159:EE_
X-MS-Office365-Filtering-Correlation-Id: fc8c2648-43b6-4743-5e31-08dc5b541c51
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	E4FLxoyDAwHTAxLTXdCBHxmE8ItMfwqMgIcjjawm9p+O/DYzeaQMOc4MsBNczU81IBTUYDX+4x3K6QUF5HoYrbblPjSjVWm8Qig046bFWL0ObYnXaBGSiWYl3LdMA0PTNYqgK3I6p1Sm4MUakWin0s1LnBcaoSqwD/hR/YvLXS2EWWFb/aEf+vtVWgJ4z2FRYhJQTp1UN56bzCkxgmYbo5AxputjHqyzXbbekHo2k2fnVFHbwY3QxNZOvgPFSUodvQODNh+uVZMsAGGGVppNh4rWiESDrws5Jd3EilVap8tCFtkqtS7GLrLBG2XWnIjnZgxuWMG/SYZIUj2awZ4TLryMjd/rsu4uyd3Y6ETZxofiNZ9NoahE+nRubDUIgm5u0jWNSegKX6lWW/Jh2101qXj87XWryy4lcxjfPNHlqJRNwLX0+spqTLB6uSmx9H0fucBDUEFaCnxJ/VUFpuHjGCLar53UipefXbbRjfD7SSnNLGdTDNfO/nrCvY7xhp5heMPvBznoU2aNYAuSRayM8UJagZaNA17EjPwJPV++UYhrt3vIdFq0wmG5E5jzGUc6OPD0zhHYnqtRIA3BO9vvmOUtFHxG/ev08P3u+Kg7HgNzmNju+dtA9gUsQ2G8IT4op+T/Oa3TlS4jgOCNWPpe/tYk5nWsUDU5SNY5ks+1S5zbh2UBqY5LV6rSd2fjuLkNP5Kv9vCfETKfyE/Zm19PwQ63w0+2Zqecl0ayD6sFslNQZX6sxIgXori8iCW/jNuX
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qheEYyZutnUBz96xA4eKDCXd6Cl92E2zRCfIK8Btof0OE6mjWr3wfiHA3sNF?=
 =?us-ascii?Q?8+FgX2qM7sztnxVzNNSXSrtqHyqOvn7hpUsXRbfJ25Shhi7e3JMqqlRK6Xkj?=
 =?us-ascii?Q?ceTD8/055BBz3bTcZM3u9d5HHb3IeYD9jxgRym7TQ45xhvxtl0VltaUMURIz?=
 =?us-ascii?Q?gH0S6z4zSoURJwPtHx5IlYA8PZBYGAo9ddznhkpfC1xmHfcgtWbtIJelKfrj?=
 =?us-ascii?Q?Myp03DX9AQG6Od2HFPCb3AgwYWDwOpihcbHxCi/jT/Buh6sYP65JBo+QT2Sr?=
 =?us-ascii?Q?ifVQQLIb7iPycYr5jDKv4MYOhJaIbY2vTCIxBj66o7i2qV2dTBdg8VKl+Qgu?=
 =?us-ascii?Q?buHlZwa3568e0PUBfvKwOMykT9mv8Bwx9Ch0mbW4Ui3JEchvZbEy9TcUYl2m?=
 =?us-ascii?Q?6DYLC6ZowOBtvcO86I20EjBETqUJKouLr5BOkIft05ChFVk/gZa7l6rQtCkx?=
 =?us-ascii?Q?xYU31y2otp/mFCjx2WGcLQ8dHFdwGbDbh2DxlcmlDp82BKwiohVx8FQTwOuU?=
 =?us-ascii?Q?hCQrhDwEdnyRcIkaE8O1SKAX0tYc+kCBD1ecZlXQh49lWD5zEJ+mUxGhI4W0?=
 =?us-ascii?Q?P3w98ymr6vAfhRGyaxXeolsNWxXsp5As4vMJhSesMEMiIaYCnB3hC1exk+Wh?=
 =?us-ascii?Q?sP772VwFj6pxZ3XDaHySVX2U7SHpBN9fPVAjrBGzGoQHt+0YKZNUpTiyH5PU?=
 =?us-ascii?Q?0vp6ScuCQ25qylLbNSswljyXc9dahO5Haf65ey5YvPRG/9TxIb4avTRyvHcy?=
 =?us-ascii?Q?tyy/bGpsORomXPvmz3YdDx2D6g8RUWqlU/f2XVxGbOadZc8ZZujRZ4gJ2q9l?=
 =?us-ascii?Q?miOPitnGonhlHPBJ1hhVgRKl0ovlb8AdNSYSJG118zGEYWEvP+sWzqTJL3fr?=
 =?us-ascii?Q?MQDPpXb7aJOdbpdNyyJv41NYfcKz4JcbKnqH/Zhng3dTYqsBLEOrx6ON2rwd?=
 =?us-ascii?Q?aa9OhWmEyVGH8l9Je5gU3MWPyBTRrQ+kDiav6dCTFF57cLIDPR//hmS4MfE4?=
 =?us-ascii?Q?mHLTUeGMCNrPLNClPdRnJ0S7H+9A3Pcg13dB/GvaziH6Jb07mNVur+RajAaL?=
 =?us-ascii?Q?f1Cacb4uVP1qD/GhvNd9tsC+VWkP2qeW8Gf0tJrZavO0d3E6EdNL1h613atd?=
 =?us-ascii?Q?WGC5Vt7jet0CIpSX7EIqX/P+eBxzNvRt373PGvVOcL8sv+84vGlyRitc37ED?=
 =?us-ascii?Q?5ACDfwnQe0ViUXRCnlQV87SCndQrDjb9Vvf+nolW4FjTfKwfwa03Xj/FLfBT?=
 =?us-ascii?Q?yaO/PxYi946/IDmhOifu?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc8c2648-43b6-4743-5e31-08dc5b541c51
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2024 00:53:19.8144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR20MB6159

The CV1800 SoC needs to use 64-bit division for fpll rate
calculation, which will cause problem on 32-bit system.
Use div64 series function to avoid this problem.

Fixes: 80fd61ec4612 ("clk: sophgo: Add clock support for CV1800 SoC")
Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404122344.d5pb2N1I-lkp@intel.com/
---
 drivers/clk/sophgo/clk-cv18xx-pll.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/sophgo/clk-cv18xx-pll.c b/drivers/clk/sophgo/clk-cv18xx-pll.c
index c546dad1791c..65aba3b95cf7 100644
--- a/drivers/clk/sophgo/clk-cv18xx-pll.c
+++ b/drivers/clk/sophgo/clk-cv18xx-pll.c
@@ -6,6 +6,7 @@
 #include <linux/clk-provider.h>
 #include <linux/io.h>
 #include <linux/limits.h>
+#include <linux/math64.h>
 #include <linux/spinlock.h>

 #include "clk-cv18xx-pll.h"
@@ -202,18 +203,18 @@ static unsigned long fpll_calc_rate(unsigned long parent_rate,
 {
 	u64 dividend = parent_rate * div_sel;
 	u64 factor = ssc_syn_set * pre_div_sel * post_div_sel;
+	u64 remainder;
 	unsigned long rate;

 	dividend <<= PLL_SYN_FACTOR_DOT_POS - 1;
-	rate = dividend / factor;
-	dividend %= factor;
+	rate = div64_u64_rem(dividend, factor, &remainder);

 	if (is_full_parent) {
-		dividend <<= 1;
+		remainder <<= 1;
 		rate <<= 1;
 	}

-	rate += DIV64_U64_ROUND_CLOSEST(dividend, factor);
+	rate += DIV64_U64_ROUND_CLOSEST(remainder, factor);

 	return rate;
 }
--
2.44.0


