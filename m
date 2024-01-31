Return-Path: <linux-kernel+bounces-46184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 574AE843BEF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C56B21F27033
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DD869975;
	Wed, 31 Jan 2024 10:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qwWv9Yky"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2085.outbound.protection.outlook.com [40.107.7.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA966996D;
	Wed, 31 Jan 2024 10:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706695975; cv=fail; b=A8TIbtyvRcG+Bkrn9sPFELIaNn+PT2ZvAq3r4wNYlDzouMXCSXQwY7l3kj6jorA0GDcGIZscrdaAj6ECf2QEUHcLGdY++uBazxpS6ONegT0khKerxANSn3BpUGubTXEmamfg4sExdhSb/MdvWmL96giPZEKgdOyDimILVFFnAx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706695975; c=relaxed/simple;
	bh=aKI+GPaYPnim6o4b9fV+M9Eqseb/Hh6g7UzOuOVGXb8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=UjB7xCQ5cuxfIgWQ7NKQzNObaT1zt+3Ri5yq4TIfoLe/PVwNaoOkDWsanug9tpdkGLPigzdL+7zsCtpFwP8Ad3h/yPJ8zXvExrSj5LJoayqrdVbSz4Ezb9zo35byFIHhMvh+7VXhJ5c5A9srDWz65vpeAm2f9ZTbwGUld/qGLX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=qwWv9Yky; arc=fail smtp.client-ip=40.107.7.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EN6uaGlDkeXS8BEkTybReoU8V7XoAYQMa12vcOz2DDPLzWiWy5jWmJ+h7v5agU6mo5EyjXvsDX6x9j5HPq/jH88Ie6L+sbVzmvscQ/NGeN8uBDVl+iVrq7iE/anuL5hS9ZOqGpWKJpVl13GY1NidL4pD62TSKDfetRlPjDrr0J702VbfCYiArxQH3UMcySQQ2Wg/JbMilM7vmU1fM6UbACe5BLfeWt0Xq2b2iHxJtBgWaZjOv3bBFxTqslQurZCz7rzIVqvhx1m8moEWVNf+TxpF/rHkbv6vM+6IKlhfX2IB6ulIEeqaYE4noCkQxViDxwvMJeXdHfPVTcKpWnXFfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsAO9iZkaru9xO9cSmxDKk7XXiCZ/r+YpwTf6kwlgOw=;
 b=bJWLCbjFz8kma2g2FNW0QyWQYoIGFSoMvZLscCibR7Y+Zcf087dzS2S0+Q1UZe5Ok19aPMNVOHRJL2nfsxT/bo1E2JOaRB1+24cN0W9mY8dv20HtRV9vb0vXL+W3H4vGgdCm2ZuWUvcN2PiG95NpU1Hf7O62s4Hwml8PcXXf3JXaobz2TP2yteXNWsbKzn3pxHNUikdpKXUvLY0MMuxpWF52lX51CFIG4OUKnuNL0Xk8A7EZwzinxHhgUbJkoPVV+BlZQJ4V3FwSUfXh4fHQNv/28Uq5RyknwAh8THYHhj0kKhKf9r0w1ws+HYooGdmimVYYLuL0VK2dwDXHVVYe3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsAO9iZkaru9xO9cSmxDKk7XXiCZ/r+YpwTf6kwlgOw=;
 b=qwWv9YkyZlSutfWA/C3AxuBo3rDVQdn4C68ADWr7V49h2Tx+rmUZ3NDP4WH9aHGw7Ik//X4nei0EJAsHUdZQsvlHCMfouyTrfPagXm6Wu/B6KvFhgakvoapKYZhEf9yvQbZRLPXefisxRTRTyNzN3k8c53NxW6RKIdPB9OMWpq8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB5003.eurprd04.prod.outlook.com (2603:10a6:10:1a::19)
 by DB8PR04MB7002.eurprd04.prod.outlook.com (2603:10a6:10:119::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 10:12:50 +0000
Received: from DB7PR04MB5003.eurprd04.prod.outlook.com
 ([fe80::6bca:3978:83bb:8a8a]) by DB7PR04MB5003.eurprd04.prod.outlook.com
 ([fe80::6bca:3978:83bb:8a8a%7]) with mapi id 15.20.7228.026; Wed, 31 Jan 2024
 10:12:50 +0000
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
Subject: [PATCH v2] spi: imx: fix the burst length at DMA mode and CPU mode
Date: Wed, 31 Jan 2024 18:19:16 +0800
Message-Id: <20240131101916.437398-1-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0040.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::20) To DB7PR04MB5003.eurprd04.prod.outlook.com
 (2603:10a6:10:1a::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB5003:EE_|DB8PR04MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: b11994db-ae39-4cba-7be5-08dc22452e31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yI/DPdInpD4P2MBeMmelp0uHxuPXX91YnWx+hTbOALSPp4jfyR4arU05WKnfCYowxIA03PnPRQdhijtkCOTr8E5ONH9o6XJPanOr3kM7WymkGiUZkXcx6XsB4Wt0lx9Bw0GeuGyqqPiN8VPbcxIj/VZmIkQybSHhJSM7gXg1FqtHNi879vRNtncJ7fzuE42U7GpQJthDBTtFzSxgJ5saIERssniqQmOABhDkS7+yB5xBNacTrRcyJE7+5cuHi/07mlJLjax5wbeXvGrczTnuTvBWyk+UWvrCFu01zwmv8Uxf587LA2V4Nm4JN7p838uHoksLETdBS4kcuaZ9N2TLu9KdIk216cL3IgRdNB64kgYIiw24YhwH6MODLw2JTgncsx0S+2225DdJXdKC6nt2uzJmPMes7NFrkGA6sxYLsN4M3PYURo2mi/ufdBs01cHFRhtV0nUT1MXzfFDkaGbPGVeXKUJz+W8YtUe2yLh2p0PbdlObd0yDqg81ReGaGto0Y8GOrB4LGem+PXQv4FSvXkR0F1Pb2e0mXVR2gMebwe6SZDi0HhhU/se901yibrxc/g9MTBTHI5ghcIL+rnKVbe4POzNGa/lTffuZbP8davinmMcUhTgJJu2M49lYjwE3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5003.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(396003)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(6486002)(86362001)(478600001)(38350700005)(36756003)(26005)(66946007)(316002)(66476007)(66556008)(1076003)(83380400001)(6506007)(52116002)(38100700002)(41300700001)(2616005)(6512007)(9686003)(6666004)(4326008)(8936002)(8676002)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Di6kHF4bqUCiSd6y3/NSWuOF7yYYa3WIScYm84FGIfPlgKbK7/vYzUH0Kob9?=
 =?us-ascii?Q?+lzA3Ytgsi68uiCwVcJBS7qiGxH3ezu9TovbSJaMTivzWtEyS0InOXpmHdK/?=
 =?us-ascii?Q?4/I2NYArZXgDb4Igb3NrebgW2aXJepDOReItu0i4lw7Zc/RX+RSQ/M/NEjSP?=
 =?us-ascii?Q?qHPbTtIV/GjXijNcIz+YHPjYBffnG7nILCvbH2LVaVv/+mU4GIjIqnlO6D11?=
 =?us-ascii?Q?OcNh3zrv2P7nKY0+kN7u0OhQq/mJXEe0aleBO/hhHfcYa459bAgayWYVODBt?=
 =?us-ascii?Q?CpATa20Henf7FppJ/lTTdMMf+tIw0Qx5AVlb5YDNYUCQoLWjCg0CMWV/06OI?=
 =?us-ascii?Q?KiggokJwY+E2JkucAuTZFoh/wp7R+/5Wroz24TY/ZbnPb87bRHiRhD16ZzGy?=
 =?us-ascii?Q?IyTgmToMyMTRb82G6qN0whoLlEwSSmHEUzZz5YuyZmenhtPiy5BIbFkF/jTd?=
 =?us-ascii?Q?RnYPAUenlhs6+yQrgMRo/dIKoobHHt2ZOuRpKb+gjgTnazx4X3GqK3+QOYy/?=
 =?us-ascii?Q?6dqX79p5jnLb6++kdAln9PUZ0nj+Ta7OuxFLh4lt4bMObBxfc5A6SKpiwOEp?=
 =?us-ascii?Q?grgZLdJbpJuUwiGeyWDo994XsYDzVbArGfY0Hf0VZv/gjRPxKTvO1dPl2XNb?=
 =?us-ascii?Q?+4WrBEjMIopl8oexG0iRQ3eF2eNpmMj9o4wgw0ezvucwexu4XKn8n0spBTcX?=
 =?us-ascii?Q?tvz7OC7cDL4PM4yh6pVVeHFdDKsjuq2BKL+CsMwHcLJXseQs5DFi2ZQa/V0C?=
 =?us-ascii?Q?jqBPIi4TlEmkJWmZPXzZ9bSMYfimI5jmhjvKGn8aNgHtlTVTmtvitxS7tBVn?=
 =?us-ascii?Q?6otOEUpmRbal0Wrzq0il3JuEjOpNMAVbS3mDuyzkDDY0FsI35Ny7JEsJKjXv?=
 =?us-ascii?Q?b+KogeV+POBXMznZAVYn1Cxx+v/7Zmxzfm2V4MucIYQr7cSi4LSJJUwFpRLm?=
 =?us-ascii?Q?ByR1xhuXk/x/iVHHhzUcc3fmhp85aRtW0IPTQVbPB8nqnxqvxLwoDmQn1ghL?=
 =?us-ascii?Q?4yCb4a5QWup7OscIUmTSduJc4HlUtogvk3ynbXPBhhQHuom2qKd5APnBMgMh?=
 =?us-ascii?Q?3mPAaGEfOeyqO0oDad2QCoXimFtE+AWXAqWb9JmzqnqGhzVzeacKYuryEUm5?=
 =?us-ascii?Q?xkhGE47cij06JqvmfgP29+iBZwxg66/9nH+HaqTNDQBy15gdg5XvTqkG5Tgi?=
 =?us-ascii?Q?taQxEl4PGhxX3FeE5g56hxPabPern1vvG5kENk1Ak996nEGxYQyDZJPN3Oz8?=
 =?us-ascii?Q?Q3QuNAyEMtOnMRNS2iaq0jmrPMOQlZLGjpuBbGtzpj8x6PcgLhGStpZJQtDi?=
 =?us-ascii?Q?RkrvFcSHI9xuvTHw+XZeKwB6j29PwNOkDZYnvKHw3UcV5526RMoA9aS1WevG?=
 =?us-ascii?Q?Adadit/czkuyCJZScBMe1Q08K0W2uVt1Qmfo25teGPKuTU/Z+NkUT8E4g0Bm?=
 =?us-ascii?Q?zQQEG0qZe6iy4CAyNkR0QYRsNuVcCuf6jj7WttDLsy/DADGPwTe2yeq1DBwJ?=
 =?us-ascii?Q?UYhMlcH5z9vzXRAzBE0f9ahJ6YB5v89w3gL7tHB/kskPoBcB8UuhyaQiEE8O?=
 =?us-ascii?Q?celvuPrOujv3J0AWWbc/My+iV4LsW4Dl+7Obd9/e?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b11994db-ae39-4cba-7be5-08dc22452e31
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5003.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 10:12:50.6071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/jnxB2FsdpPsepSh1e/4QeZ3ok9SoPEoHNQEpiyWXnph9qS82usc2/5YZ0dNPzm/pX6PkadUM7VeO42BYk+tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7002

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
Changes for V2:
- Removed BITS_PER_BYTE defination
---
 drivers/spi/spi-imx.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 546cdce525fc..0436e7a161ef 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -660,15 +660,14 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
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


