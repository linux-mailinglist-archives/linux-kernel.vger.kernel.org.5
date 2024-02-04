Return-Path: <linux-kernel+bounces-51548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE4B848C61
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 10:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62BC8B231DC
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 09:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBA915AE0;
	Sun,  4 Feb 2024 09:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ApAApiVt"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2073.outbound.protection.outlook.com [40.107.7.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3271D16429;
	Sun,  4 Feb 2024 09:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707037966; cv=fail; b=Q5/BZgvHMh37lDPlfAGsEYO84Pn/dA3gfPs0qfiVREWE40HEzPAZEGVG38CCt1daPVQlE15iI48vvsSEm7gPvBDGC698Xqq0xD/JXCMeyl0wy0gEud69V4RRenBcLsdswOBanuDPBVWOtrDpMAUgHJg/yaoTzxd0ffEPsPNh9rU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707037966; c=relaxed/simple;
	bh=xpsZUrBXASqGb4J22WBF/8vDsdJ3Qpn6Wau8hSLkZGE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=RPgWFXf59lvsibDaUyZzEUkWZ3sOoFPamI3T0q201UMdEVE+i8RUb8KA1aDOu7GaiwUfMOzQNTqvSCBVHAqnelKfqt8iOuHTDUNCEzY8nfpAWKFYjlnkcwPBfJMZYnPBGtA/+8HzMVMGXPdFejGZQMGHMDdTAaq6ZxdOGpyCtJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ApAApiVt; arc=fail smtp.client-ip=40.107.7.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3ftYj2xsT/ZQwuSVLEHTyzDg+nTsvPJRTcboHvGxc1EEcCpCqYsgrN9JlVlynujv3SLElqUVXZfz3KWxVbBD3kfVvoxjKoTAdHLLWWOsDabjMcoGklTh9iFbJ5RG8wCMzKw/sqVMdkNqUerHyNHBhLJc77l4BmX7KJ9nYrpK07+Gt11KJQ8W0cQx3uZyCx24ia2Pt2lfxTM1tFCoKl2eOvuH7zKNwWI7FrsY72oNczlDuGpoBkCph4Ovm8ZLr6wxZliNsRan2kIMUjKuFxrM+svPgVJpRQN+OkbDjhj32IJZw+EvWuGQsCj3MfeDILLfemzSmni0aInIEzdXbZj7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fv1NHMGHU3tkzFJw3595hRiIGM+Nw3hDHnY1ofg10qA=;
 b=bTSZffNbvW0V6k9S3jLrNRXDSXsprt5pFKV4p2boYKMPTupTVw7JRWi3G4qWXoEIm1576Esjf6FfobS7NGw37ifSRP8NiCJ+snstScjxWP0Iwi5CQN8VPE6KnKsfEVHSKgCa4mQJ2HSUCUaEQGA6MjZ00GjH3ColEoQzyXWFIBp38hCr7Kwqgh+tqr1gxggF3KIzTIGljSoAt/eMmRLP45VCpub915jdZbcylCPCSdrkNmTwXw8FUQEvfZBFA+Dmqanoy+7WOzIRCVQ2P1xj9vk6G+vUSnQEEcCZOcLytTa08Wdcoe4VnyGpetFC4FKgUpFlmly7Ybkvhy6syR78lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fv1NHMGHU3tkzFJw3595hRiIGM+Nw3hDHnY1ofg10qA=;
 b=ApAApiVtBj8xzu/c397D92L3UhUDdvgz9szUrw+6HVqBmD5oQUdoQz0Fk/iQJBt79wBsYI0sfibv6WYpjB9hiMI6UNbPQW1SBeXcDzQUAP5tk0QYwURQ+CULPjX6ph+fwusa99CmeKuo3iSIHe98fiyQVUx7lVuDtWxdl6s+cmI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB5003.eurprd04.prod.outlook.com (2603:10a6:10:1a::19)
 by AM9PR04MB8922.eurprd04.prod.outlook.com (2603:10a6:20b:409::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.33; Sun, 4 Feb
 2024 09:12:41 +0000
Received: from DB7PR04MB5003.eurprd04.prod.outlook.com
 ([fe80::6bca:3978:83bb:8a8a]) by DB7PR04MB5003.eurprd04.prod.outlook.com
 ([fe80::6bca:3978:83bb:8a8a%7]) with mapi id 15.20.7249.027; Sun, 4 Feb 2024
 09:12:41 +0000
From: carlos.song@nxp.com
To: broonie@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	linux-imx@nxp.com,
	benjamin@bigler.one,
	stefanmoring@gmail.com
Cc: linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5] spi: imx: fix the burst length at DMA mode and CPU mode
Date: Sun,  4 Feb 2024 17:19:12 +0800
Message-Id: <20240204091912.36488-1-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0010.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::23) To DB7PR04MB5003.eurprd04.prod.outlook.com
 (2603:10a6:10:1a::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB5003:EE_|AM9PR04MB8922:EE_
X-MS-Office365-Filtering-Correlation-Id: c34f20c3-3b5a-4e4c-4d51-08dc25617008
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yzSQoIahaX8NeRLfZ2Lu8HaIw0+nx55dZOWR7hZOSESOltNgBzO3p//GUSrY3JvSiJ8dhbvrmO9icHaFLUqktsb9WVJV8PGftwgtZ5Ep2W7ASMXv5Q34sqMY1b6SIbqsKnrnQA2P8EyDhw2Hq6oqxcmYA4bVH0l8KvWeJasRSztdnQvnS+K5xqfIKhhfMbwKyM3Dnd5rh3OkUCF2f+HerNURjWQ0Msanx+Bu3KAMgrN0FowvNrUS/t7Wuz8dOdEAarPBXiBCX+hYKy8L5bs0opgVjRFkPXEaCHSTcPMnVu0c2/72ILFeCirHpR3y3aaNqCz2nDtsYSkKx7BNcNRi27jk7ndEdW6XjZXL4i4ZUJvtD/j9UG6a+XRIU5m0bzTRabVirJ8uEtyY9cI0cMRzgT5C7Uc7b6ML49uTOr8dUCjj3rSlLxLjOoh2muvqdFHLpWV+vxMxvY+iflmZkhJwwvDcN+cAaxnFe0FNtLA4ILMLqfZy8KPoiTxDr6LggrYfxj/+ipOlBYE9rKz0ofCnEU6qED7wlJ4q8NXrgc0HaRuIrodt8JKS7svw+d5iLQ1l+wzoE7PMhKwx2EqqWlfg/dCe3FBFRuO2kAPqOLo0XI67NyOLSLWdfN3Dve0EXTQT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5003.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(366004)(346002)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(41300700001)(6512007)(52116002)(9686003)(6486002)(478600001)(38350700005)(86362001)(36756003)(2616005)(1076003)(26005)(83380400001)(2906002)(5660300002)(66556008)(66946007)(316002)(66476007)(6666004)(6506007)(38100700002)(8936002)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e3HaowfLCXihh2X6c5iCn7wTN7D6+gYZRmMI8/AqbGGMeUkhyaLC3/ddwcez?=
 =?us-ascii?Q?PHlSK68ww+0VSTTY6zxKUShMsKDT+nRSrfdkrceCIU83wsD9dQW04KpxS5tg?=
 =?us-ascii?Q?0r9rNDDKjBHvDC+vaeSaqoNZmGBNqkDC/pYFCvGqAg6mdoG+uxUGrP/OwC9i?=
 =?us-ascii?Q?IQ/TI2Aw5LFR5M7THZOFGhIDZsvhecsv1aK5oBH+RZWRmnDrxWFwF3Q5ei51?=
 =?us-ascii?Q?aYJkUfuEQTWm/OEr96yaNYE1Ti3VT1Y7nNc6y4e3SBGcm+Y/DMEpF90ZX6iC?=
 =?us-ascii?Q?Ul6PGW9U0Abc3H4t8BOJbQZIecuu8jtsr2Rj+hBTR8FjFfbPjRyBI1vuYdaR?=
 =?us-ascii?Q?1K5hEgob3/byRVaUxWn4+C84MLQIQY0i5FWLqwtwEZ0/VtYHw6az3WH9C4G5?=
 =?us-ascii?Q?sQl4yHngjYTirMlyHOV4325puI/asOyGXa/Xr+tDAh3jYIIOQI7Pqikc2fgI?=
 =?us-ascii?Q?Ae2k4dKah99Xcev7F/vckTgdAq+RRSXuZm8IVd+49oUA6w+BSvg2qAV6gBGq?=
 =?us-ascii?Q?+BTx3kJmir/2hR1TaKcu4bFlXw1pJ6EBMuIh9WELgWE2IHWRSYA/nvG93puJ?=
 =?us-ascii?Q?YnHeSIFw2vhZeD0KPtKIBxV+c2AtlMSB8hy2GVxNgbE1Konp8r4DfvSZZOsF?=
 =?us-ascii?Q?8K9Dvmt2baflKe3bN1FBLbR8JBEADc14loSnyq2ZG5O6L97nsS77AbgtrYzi?=
 =?us-ascii?Q?jTUkMmiqqHHmTODEvSOBGIGsU9MlttikJUnZEf62n7cY9UzFZLZBXxcXLIG7?=
 =?us-ascii?Q?p6M+1Hb3dsWEEhuLcDOiow6A4vcmpaQSMhK1cfNmxlbnPYBNsfgoGB4Yv9um?=
 =?us-ascii?Q?+06Z6WU+BslKqCWnwj9vNjqK9OI9ljgyk4LVA+6JFB6Twmp63C/XPomC1+6q?=
 =?us-ascii?Q?u64AkgTVNLySc+yEmMB7WkypCUjg8+D8P7+M8ltFH94OW1130rlAbdDt5/v5?=
 =?us-ascii?Q?cSSxbapnx9mhVPdmXqbwiePgPeYJtvqzXP9rJ7UmDFzTRqyrwJYJE2J7igOz?=
 =?us-ascii?Q?XEayisbfJEMyrZhFw2CB7K+P/JFJ2MVKYo98lvsYSxJyqJmSHqCy3oJTLhcS?=
 =?us-ascii?Q?F2VngtdMn3cdTi/Tizha/C0pBd9EPIhxY5JgF/RUf3jXG68sd5Nb2sgikY44?=
 =?us-ascii?Q?j5XFTPVvBsvUJSE6kuwPnixKOIFkx9XXmQHOM77eRMKD3ckR9SB5p+xqnvq3?=
 =?us-ascii?Q?aBT62iXkCyTC1NfX5fwD9vWrrd9C/BUazj4FAwOEljU7UOaRvYq20e+9swrU?=
 =?us-ascii?Q?A5ijYrqGPW2jtFM4okMmjWuVrcnGhh7V10A/vXj3r2CuYLN986Gj5APTFJlc?=
 =?us-ascii?Q?Kvr1DoUmuNrsHgnSlgF871XUVfbJejMP1dgSUyTQHKWYcOnv3u+NXa1GsGcH?=
 =?us-ascii?Q?xzbXbo4i8UiP7wzMOCBtxAdfshsbn5m0NoPg5dgZqdmjkCV50ghk9J/TMBoC?=
 =?us-ascii?Q?lAM0DwgRylT6P7WTLsO5VQtOmNpPG+kL1iMFnI4ZOs3s9JxDjqVWDjpav5MZ?=
 =?us-ascii?Q?3hBVDIDuyOosrB884qW6THhNqJ6oCge7Shlcag5gs+dTlN/ORo0sWdRTOUKQ?=
 =?us-ascii?Q?Y46g5ZP+YuxOcoTSS/drIJ0JTKMfjJs/LzOMQGjM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c34f20c3-3b5a-4e4c-4d51-08dc25617008
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5003.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2024 09:12:41.1975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 16wYZEUBvz11Z09iTMZXZd0uhUM29p+LMGbk0tIKO1ZfJdZxPY6HTX5zraHSuFCdJIEr+EsNAXImoO8nw6HIpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8922

From: Carlos Song <carlos.song@nxp.com>

For DMA mode, the bus width of the DMA is equal to the size of data
word, so burst length should be configured as bits per word.

For CPU mode, because of the spi transfer len is in byte, so calculate
the total number of words according to spi transfer len and bits per
word, burst length should be configured as total data bits.

Signed-off-by: Carlos Song <carlos.song@nxp.com>
Reviewed-by: Clark Wang <xiaoning.wang@nxp.com>
Fixes: e9b220aeacf1 ("spi: spi-imx: correctly configure burst length when using dma")
Fixes: 5f66db08cbd3 ("spi: imx: Take in account bits per word instead of assuming 8-bits")
---
Changes for V5:
- fix the the method of burst length calculation compatible with non-byte aligned wordsize.
---
 drivers/spi/spi-imx.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 546cdce525fc..833a1bb7a914 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -2,6 +2,7 @@
 // Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserved.
 // Copyright (C) 2008 Juergen Beisert
 
+#include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
@@ -660,15 +661,15 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
 			<< MX51_ECSPI_CTRL_BL_OFFSET;
 	else {
 		if (spi_imx->usedma) {
-			ctrl |= (spi_imx->bits_per_word *
-				spi_imx_bytes_per_word(spi_imx->bits_per_word) - 1)
+			ctrl |= (spi_imx->bits_per_word - 1)
 				<< MX51_ECSPI_CTRL_BL_OFFSET;
 		} else {
 			if (spi_imx->count >= MX51_ECSPI_CTRL_MAX_BURST)
-				ctrl |= (MX51_ECSPI_CTRL_MAX_BURST - 1)
+				ctrl |= (MX51_ECSPI_CTRL_MAX_BURST * BITS_PER_BYTE - 1)
 						<< MX51_ECSPI_CTRL_BL_OFFSET;
 			else
-				ctrl |= (spi_imx->count * spi_imx->bits_per_word - 1)
+				ctrl |= spi_imx->count / DIV_ROUND_UP(spi_imx->bits_per_word,
+						BITS_PER_BYTE) * spi_imx->bits_per_word
 						<< MX51_ECSPI_CTRL_BL_OFFSET;
 		}
 	}
-- 
2.34.1


