Return-Path: <linux-kernel+bounces-47990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 769C18455C5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4734EB21481
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E1C15B969;
	Thu,  1 Feb 2024 10:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="l/xtk1My"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2059.outbound.protection.outlook.com [40.107.104.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B648F51A;
	Thu,  1 Feb 2024 10:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706784512; cv=fail; b=Fzr3/Rg9OyaeTXSRxl1tJ3uXmJkh+e58kvcPJxUjDJK2uT7/d+oTPTHPaO1x+5GzLPzfXvSth4tpEmZexkFNI6Ewtrok6pK8ZNqd8AtYikmSNVww0dBnx9s+qyjNiH/U7KCEueSWVye3YQ5YU/ExitfqF8cx/mUmv7bJAJPD7fY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706784512; c=relaxed/simple;
	bh=5x1gBnH4tyC68IPGFZNGU0iErnP9fezJx81RHqr5z7s=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=SkQedS6NIKObQVzA9voN1J14fk5fSj8sjqOMJ1cJ3xrgvF4jrjkn3rNs5X7cSly/U70F8AKAAf+hkijNy+r5jp7qiP+vmvTGroIedgcCQBBmPhI1hHl3q1gaMALfI/9hLXpZlrYrLZLCXxAE1sIB9ZuvFrOYDhgvCzSeR53QOs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=l/xtk1My; arc=fail smtp.client-ip=40.107.104.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFY/i2yCXdtH+eKF0noV8QJaOD/QJ34+fFHd0m2jAGI7cGuhOIAf7fKbHCW/RmKR7aoF208/oxFzMKcYPumvJ9ikD9FbYJNqLamM9ALYty5MUpV6NgjeXdELl0rSK0huS24CWdRuSsH8T/nFX5OYB3pe6+U6v6A4t4lfoerVUaTXdXXAgXR7ccx1fHyQC2C2TIAwNaErIDKFy8etnnYJrrQ7TdbtdZ+dfEqnpo1BoUrQniTlFcRSk5p+oNy79biAorz2onaKDb017CBnIawD/GkjgyjQ31qVn20vC5OteHy7tUXTH4dNvdVCr7jLU8JXB/rBwIo4gBMumHnw4XbC0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pV+qVsRvUamYBtj70pE+AynikoIdU20JxKOi0xbYFK8=;
 b=GxYPpd6IwFj8lVlgcylgxvoF3Y/IT1ZyWZZV2khQyDfqBMl//wasF2EL/MAznLbcJPln+bU7nM7ySks/37gwP6SOElUeVL7VBZZJk9E0ITyMvSCppQAntcNlzzqlLv3hLr6cNK8T4UkHSMf1edJuOGMO4g4FGMxb5MQP2kHlxsW8/uJ4hgg07B2fA6xdFIBr7T3G3YMVCJJU/rDtxpPr/Oa1aAQojmvFMTQHLE4CO2qcjyK7bDSyLeGHbkE7slrz8qCD3wsQimU05dSPFwCnyedcX+5rCg12dX8h5WQdn6aMXvZbHMBCRMevlowCtuquQmSvsCo3MnJbFUhvMfy6sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pV+qVsRvUamYBtj70pE+AynikoIdU20JxKOi0xbYFK8=;
 b=l/xtk1My3I/cH33S11wtzcXpOsPcJ2auzLyfYVcVO2a7Ctagis9wI2IyNrzTHmI5niLZ2EmTaCfvwEfC1jeuhdBMayp5mKB5bei4Zv7aWURTAFeQNNs02Sn6Klp6dMCVraxABrmK88bq0UxjyA9jq7Pbe9Dd93ZhwvRhw70+feE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AS8PR04MB7718.eurprd04.prod.outlook.com (2603:10a6:20b:29b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Thu, 1 Feb
 2024 10:48:27 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::f363:2b4f:4f8b:8af5]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::f363:2b4f:4f8b:8af5%6]) with mapi id 15.20.7249.024; Thu, 1 Feb 2024
 10:48:27 +0000
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
Subject: [PATCH v4] spi: imx: fix the burst length at DMA mode and CPU mode
Date: Thu,  1 Feb 2024 18:54:51 +0800
Message-Id: <20240201105451.507005-1-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0049.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::20) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|AS8PR04MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: 26eddd88-094a-4121-41f0-08dc23135244
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZpOJrjff8lIRaFdJdYZBz9I3DMCjOs8O+46ZozclY6ll6dmdp1BllDnbfGKR4e9ahy37wVOlNw3GjJjLbCshPS2zXsfh3ZH8G1ApZJbFV9tuIjkAG/Fx3BU5dqsGbvgpkKxRojTygBbpfhDyfiAoZMudRXYKesUhSGZw/uKYCyyyA2ZYQgekWxMmC/2Y1b4VXNwdzwm/WCgiAigb9+X+N47sP1+ztXMu+KSPtZYagewcaHtGh/FLOVllpv3u6j01+wugN9N5Z4e6bwLuU7uyk+WcEqs2MKIc8KQ8rw59GjXBZrH+HMRkJMbO+ztg/2QCuJslR+bZKLg14LB+8RVUgPSApqqUF/BEZbI4YIpPVp562hno1ePgiaYfp1JSQo0A9ESs5SmNYp/2dhrD5NOrRVyVAzHWCBKrY4sO9xvOwkXGs/GVspkOGXP/sduUGY9T4KyKYgWASAQ2UNJovaAltu6emu8VVR3BVHrmGxtlihKUHUBJTEmVdyIxeeUq37ude2dwzfkSH3/rck7b8cVkmv7cgqdnwVLQEY08h9lyhiiYpeCLL4eLvImtVvvpV7ZtJ2zjm0l2xzQnnzp7yklEUnN7kQecZvcipQwsEgpDUEm8lLwLgwVWAJG5ogN4BEE3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(346002)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(41300700001)(2906002)(86362001)(4326008)(8676002)(8936002)(5660300002)(6512007)(316002)(66476007)(36756003)(38350700005)(6666004)(38100700002)(66556008)(52116002)(83380400001)(6506007)(66946007)(478600001)(9686003)(6486002)(1076003)(2616005)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3YZJRG9O7EnZXlAtiSfLwyU8eDUQlh42WWPflzsvc8sKfS7fyL9S00Hgqa8o?=
 =?us-ascii?Q?QS94FgA/5k631FupTzyew5Zy3kJJ7wTPUcLPFhw6aOvHvvIyWFLUaune6EaK?=
 =?us-ascii?Q?LUp4vmjTtcBiSADpqp+ZwYYPy+w7uEzgTag78nVAAp1i/bWe32ILIJyuXt07?=
 =?us-ascii?Q?Gw3rTExFbARE+NXY0TZnEzCbMmO5HpPZt5kzaDWffoMn717caXRf8pkPLLGf?=
 =?us-ascii?Q?aC6F1KIaLJ/RNN2lp8Z0IyqMPgR1PlwjPkAbpPMqkbVBBP3G/g8bEW935dvG?=
 =?us-ascii?Q?3pWvylFStjhNuN92SlvATGYknxDjGf5suA0bQ/3w8+PyUuNmLLSklE5ErSLV?=
 =?us-ascii?Q?QGKKHtEgUM6QtBJIvXCcG7VPHK1orzhCEiPMK87/bBsWxpwfUSau9LV6QvrW?=
 =?us-ascii?Q?LOegFqtRVDMXeVUn3J+ZOCQDv6jhenitd7Uj5VqCYBbuYcqyQgadzAH7MnN6?=
 =?us-ascii?Q?hhwYSOtMvsxy8YPdnA+6E04MQLP3i3LQFC8EP1A/cj0jyWadG4wcSk/LbEk4?=
 =?us-ascii?Q?GxIiriJOIbnYRK1redhh5VG0uEuFyXznNIG7lxo4SGaJMe9jb/Qrah3DeO1j?=
 =?us-ascii?Q?nFOH2dewojvg7+P+gjHsV5pbhGPY+x+DRqhICZf/m4IvbMVhqInIwLoqNio1?=
 =?us-ascii?Q?i49bCgmz0rls71DaHCewRNRifrWz9YXO5q/Jd8AHfN0h1cworjK1xjY1hnIb?=
 =?us-ascii?Q?t9Tzoo0mzZZF+oAqYFil41oF3ZMPSvKd2Pfs2y5Ycu6/nM/w+MscFKXe0Izr?=
 =?us-ascii?Q?06LNBqeX+6RQP+unDevvrUZQs/+3ncG2PcKvizVVJIiGB7ZLT7kamjZc6bIX?=
 =?us-ascii?Q?XBwlAZXlOJFMNGwgcI4nkO+K13ukKCRpQN4ywMEF0fMnzSp0bsXYfz9lXVYs?=
 =?us-ascii?Q?hHURZhByUZVWgNCYfHzrCDwlx9UJClT2rQyA9UPSw7nj3rS6nxuDVnWRyX7x?=
 =?us-ascii?Q?mZQi8071s5vFoeEz/SvgqIVGqccZDxdY/odnSfZqPa24ilu6VLS6aZK1vmOF?=
 =?us-ascii?Q?BVSX+wuGnvIjL7+kx5OaVjytR+7s1Z79QgXyWPIE1QlCp5xV+jsOd8F7ZNRe?=
 =?us-ascii?Q?FbsB6fgWm27nCcXH8qh9u8BLJvFGp+NfhsEX+jfz1S4r5HA9pDd0r6+B/G1u?=
 =?us-ascii?Q?mo4YiSxk99FFhEb2OZOB7akphTNlwopEQ/f45N3wvrC1L4GeGq4JZQA1h6W0?=
 =?us-ascii?Q?k9e0LrTM8sh2gEJx5pbCrliSKY+2EhpeUGeYCRRtBpJnY/WVi6+Mx7vEWEA7?=
 =?us-ascii?Q?dPvLrYUmWj/F+e3nUTxmnN6/ZaTrMVenhvNzYHp7LkSaw8xjLnr/viAMN41v?=
 =?us-ascii?Q?G0XhksXpynq+dZDjVBWYt1moHWZXbsF/t9kv1GRqVpUhspiAPJsLQDW6d7l6?=
 =?us-ascii?Q?/H5KfkEDdvMJx5T7H2l/Y747GtgtYZGr3WKgk1CQ6eLZF9QXbxT7qLE4VZu/?=
 =?us-ascii?Q?K6PeBJ0Niw06Y9R3x3BF9EPEqGzjsS+YVoM4cJ5AxHn03l+RXFeqPpPLnMxP?=
 =?us-ascii?Q?Bcsx9rwKfbc2ZaZ6Q8CTZI8eUJzsBO85cE1IFlBrOXD75eqbqASLfxnNM6h5?=
 =?us-ascii?Q?svlWf0O9F1u6hBb1qevE1SOpU/+eCNyw7cwH6QVv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26eddd88-094a-4121-41f0-08dc23135244
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 10:48:27.4921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6KjpV57rar2TwIwL7koHz9hUiXTnVfcUZfmBiPks2KLPYeRotGBrjM4jwnHiLwqUtkr1GQT/cd5xH9hl9ZKmBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7718

From: Carlos Song <carlos.song@nxp.com>

For DMA mode, the bus width of the DMA is equal to the size of data
word, so burst length should be configured as bits per word.

For CPU mode, because of the spi transfer len is in byte, so burst
length should be configured as bits per byte * spi_imx->count.

Signed-off-by: Carlos Song <carlos.song@nxp.com>
Reviewed-by: Clark Wang <xiaoning.wang@nxp.com>
Fixes: e9b220aeacf1 ("spi: spi-imx: correctly configure burst length when using dma")
Fixes: 5f66db08cbd3 ("spi: imx: Take in account bits per word instead of assuming 8-bits")
---
Changes for V3:
- include <linux/bits.h>
Changes for V4:
- keep the includes sorted alphabetically.
---
 drivers/spi/spi-imx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 546cdce525fc..f7990ac2c654 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -2,6 +2,7 @@
 // Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserved.
 // Copyright (C) 2008 Juergen Beisert
 
+#include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
@@ -660,15 +661,14 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
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
+				ctrl |= (spi_imx->count * BITS_PER_BYTE - 1)
 						<< MX51_ECSPI_CTRL_BL_OFFSET;
 		}
 	}
-- 
2.34.1


