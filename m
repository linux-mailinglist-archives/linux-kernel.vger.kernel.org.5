Return-Path: <linux-kernel+bounces-47919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 031C88454A9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A6B2B2577D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59B815A4A1;
	Thu,  1 Feb 2024 09:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nC1GRuY5"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2053.outbound.protection.outlook.com [40.107.20.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165074DA1D;
	Thu,  1 Feb 2024 09:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706781543; cv=fail; b=EpEqRM5cPAYLS0mR9zj7laKAq7Mon1pvVIu2By1dUxBGBq6Ck9JPNjzKWAlmpKKcEBLFf0OLasI3FqbWm/lohejcwAkDqDuajToLie7Mo3mEmdS0F3ls0hX9ZfwgKzPryfkJvaZxW7eqGrIJiyx0oy7MNJcZTxWJrkR6rF2z3DY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706781543; c=relaxed/simple;
	bh=wrZ7M7oH+CP2btmXx6OY4MU2eDkZxP9GSDXaMnT2MH0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=C/mzH6OAV487//vAyfZErde2+fjTF8iYN8fxR/q9XRo7JuJX+XxbrAd55Sl1XVdHxDzuV39ZRWrhvGU3UfVDQ4EPjhK9DxvWDylh7qNoeWcOKThPt1r2zWIpMbzy7WzEF7EZaXFOyCQ9E6ZXhN5I7nPpEYPzfeFHb0BsqkPBD9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=nC1GRuY5; arc=fail smtp.client-ip=40.107.20.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQ5PrEw+IyS/Q5lzNyPEHED/xIxq89JvqkBFSNtHGLMS7+R8+/fwEb2gpoY1nIVE1f8MMPrGuaH8ri4kGXoHJf3cG40OAeyCPnK6OUqSDLguTlQiWIigA1art7upTv/J4NZI2NaQnAxsyskKEMkXbcJitdZ9+kYUELU3aAzAxW78raIuV4/f73W+gwEhSO1kIloqX2jeYTJokgSIOgyrJ9Ti4m/Jst7gBce43QGxLH8uksmWKVOc0CnvV52wY1UZMhA0D6C9NxxxlC0ZfP/QWgOKoaFnWH1zLbnikdWqIx5pMnBSK0nrzFbPPXX4sOPAseXq8LK8Pl3fZImtdcXG4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPAuamCtRGYmEZ2/ApaqNW3BZNP83NLc1CjOwQbcFhA=;
 b=mvVNLdL5j3tf3GOdkDQ99A4nH6bKhQmeSlmCCfTAU1F59NB2qSNbK6likQNLBu+DEYrF7SdSGm8bSm7KqUZudIOpOSPW35cyg7PPaDaDecB1sgqfqDETclp5PqpgSO3HJnbph3VzcEE4wCi+eutz4y/GVjjsnhuCrk7P1zUTdMyaPG206OzvodThwGIZZWESo88uVNzJpe6TB8c5Yq3ozqz4/f/PNCu0+rgA8nVtbyIbU7D4IN5gijgHOl6MuSVdyU1sImFHYatx2CfWcMqULQd+lh5LN/tPUpT0RuO2Y07v0y79fmchG+QQBRbbjJcesEdsIR0M2X5tlSXUZXH0PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPAuamCtRGYmEZ2/ApaqNW3BZNP83NLc1CjOwQbcFhA=;
 b=nC1GRuY51qtZTTDKFGK7FyLdZdF9BrnPdHdCknsKaZiLHWef5SWjGdowKQmA7P1hP3W9YQ7M6bokftUxskWJ8/zcbtmAhXNwRJIcV5IcD8u1HkmxEnvjmn6QzvB13v6Un41WWqydFfyZa+IiX0b93mDiYD5yvmzzyX4qE0GG4nI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM9PR04MB8178.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Thu, 1 Feb
 2024 09:58:59 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::f363:2b4f:4f8b:8af5]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::f363:2b4f:4f8b:8af5%6]) with mapi id 15.20.7249.024; Thu, 1 Feb 2024
 09:58:59 +0000
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
Subject: [PATCH v3] spi: imx: fix the burst length at DMA mode and CPU mode
Date: Thu,  1 Feb 2024 18:01:15 +0800
Message-Id: <20240201100115.503296-1-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0015.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::14) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|AM9PR04MB8178:EE_
X-MS-Office365-Filtering-Correlation-Id: c71026de-7e0d-4fa2-6f1a-08dc230c68fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BpfpLvedg827/FHjQUl+hZKbvxSdMpXHimGF5yeRQJ//M/KPzKDyjQnUazCuRtKs/cI50ggo7Dhz3bcdyNb/L7YK9+wbVEDzwNMCk140h1awDl8SGVFTyHVQksYBi9bhQ+ytxKCoR4J/EueuBfjoDiCABVOUU9hycgNRGnivG+YjhTzHTP0y/cuzSYW5LT5AQnSuSl6wfGx7a7oy6mKnNKz9TKWK3FXktmxNCmQzWyegDJKzg8u660wCxZyF4o2tdL6JDVtprczdiSn3nVdi4QP86vp1/RLvN0DlGqtjUGbClfdqQqjh6t01vXLEU5S7D19fv0RLKmzKC6sffpbCef5o0h/a8yCrhI8slnp10K/FpcPK0/WxcXiNsX9VOrIBaGdwtHGNye4Fp2xDzEnuFdMjnScurHRGw0Y90CdLbROMWCMYU2JdYcU/7ckR+vUPC605qGBffgAThXqUhFEIKAsQgoBrEukoe4s0ZpgiAiYm4xdtpHRVkFdYNd5dEgY24vp+cxncuymmFl5GjsaaE8N0YLLvvtdckMe0u5bVvH2V6B8HACrWLHYaSNBIP6LydHDo4vy7jocnoaLwycoP6sBlfPvSK/wve91vOVHELH753dNw8hX1ap+jLTQiGS8p
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(366004)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(41300700001)(83380400001)(1076003)(26005)(9686003)(38100700002)(2616005)(6512007)(8676002)(8936002)(4326008)(478600001)(5660300002)(66556008)(6506007)(6486002)(66946007)(2906002)(6666004)(66476007)(316002)(52116002)(38350700005)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qg+Da+ny1DHpN2STDpLFq4Sh/GvOqobMuMZOC14TMPH8ffnv5j9VfCD8n6D4?=
 =?us-ascii?Q?M3NCD4kRe2kx4KPNx+w0UZGR0Gl2c4BPCFREVl7sRwjZ/NqkkrUIKDpDL92E?=
 =?us-ascii?Q?muB08AJjCwft4el2i7xwoeBIkgj5OQls/4w1azmlEoMIMLl61Xfenlv0KBQm?=
 =?us-ascii?Q?HpIXASg0melcaB1CYW9w9j8Gacm+Sw85FVaqcJ/Oc+vkgJLTjyi2HgBDZASt?=
 =?us-ascii?Q?4CN69LU7QkGdkULjaSVGLWKW4wpp0VqePfWlWc3IqiXkzNOo/H6fe8/pNRiB?=
 =?us-ascii?Q?vEVu5QhHIVR3w8eJT3MYidu7Zb2YUCPq4WRktZi9K2EZq5yAV8ZU8u4yXfho?=
 =?us-ascii?Q?HvHl+304cZ0Vzl7d9ZTAmbz0I+9nti1iUY/DWV4cUX5BIvpj5Y7e90bzyN32?=
 =?us-ascii?Q?JkK80uEVW6hcuWJcpMHRxI+mfAfVDrRfPFpq0xukAnVO9Zf14AQVlCv9yRoP?=
 =?us-ascii?Q?uvgzWudjBnxf1uunYXl6m8dSyp4gnBs0Wyeem6Y6+U1LF6o0bRLJlrtfuZnG?=
 =?us-ascii?Q?HH8uu5kpTSvgUt1dm0gqRWAEzVgO0E4rhAeW+VQ1NAQ8gKHfiBUpSslHl3LM?=
 =?us-ascii?Q?lhaMOnz2M0qcM4/kcUyZ1BKHlEplheAydmL6ZOk7RJx204S0HaSlntaRZ8If?=
 =?us-ascii?Q?L92/zcCVNuHHfGfcCyuxsvyVe60Y35so7zZiFLYRd4VC+E+ckjV29VBkvLNG?=
 =?us-ascii?Q?FvG8qU02hR49on2iqQAihV6jowOymPAhCVb0WUagpmWrR0YfMgsz39Kx2Fz7?=
 =?us-ascii?Q?WA3IDLGyH9zeOjOSpnAh0pltn1CX95gSBplUzpmxePwvhFbyhMJU1tjSSrhT?=
 =?us-ascii?Q?IJHQBWR6cDorUxo/Rzil+PvoIAi7OdmiUyq6PyfY8vZ2gq4nBY/13vfel4Nt?=
 =?us-ascii?Q?j2DgniplOztReLPLWDgHo336rwYbGed/HlvjgEYN3Bn/mbkT+boD4FtWt4vS?=
 =?us-ascii?Q?1n0Gsp0/Ryp1W4e36aYNW+PsriGscBU+y0uLo5mB6gL+pSbX73ovoEvsb9zf?=
 =?us-ascii?Q?orppZYXqFPAgZvrJmWyJ0GvSJHr/tj8DWB7h21KLyJ76aNV06lbuHzGYaNXE?=
 =?us-ascii?Q?vbKxgAwRQrxqEwFGRICnlr9kTx3VklUFJ8a3BIiGNtFHk5OPdEwOkIsAa8D4?=
 =?us-ascii?Q?lBHjukkMB+3uo1FxZ6GVh4MaQpR6G4bp5FPcuShYfXbUd8kltW359XNF8/Oc?=
 =?us-ascii?Q?4AJCvKiSYGION3hcLOEQzVVpqFgSKixG1oSnKgvL7oDI9rFg/uZXZJ5i2WGZ?=
 =?us-ascii?Q?/zLZZ0iyCu1Z0HWXaFhN8mgve4uapO6hlyQjNxFguQa35SBLmpoA1OtK2Lsc?=
 =?us-ascii?Q?sjmuvKABZ8y/feE2R3yfNjKKswovr0LrgOhcr9QX77B19GCvrYJuNVChS+cm?=
 =?us-ascii?Q?696fdHApuT3bLelG05zMpeTK+mBUBAb33PzmbhnDDCe2af98VMJtoozPYsqp?=
 =?us-ascii?Q?LnfGhGV/Q1S29uIrlGmKG19BkvBAc5svtaiDihaOpQS2SesT9o151PtR6DGY?=
 =?us-ascii?Q?1lHhfS2a96de/wc3851D+r9c9h82aMT6dMrBvrHYieH+Cf43xIZLdJYhnSLQ?=
 =?us-ascii?Q?3mD6BUwm3TFkVrECmyQoAbBIXaHz3ZgbgWep4S/1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c71026de-7e0d-4fa2-6f1a-08dc230c68fe
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 09:58:59.2469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bhfWWLIRJf8FLIbfESiv7TT/6ICO+aLhXKCiuaZmc6KY8mveGa8kORdbpmEAFgxUzD4U+sIa8+DXRkvKaMG+Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8178

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
---
 drivers/spi/spi-imx.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 546cdce525fc..2a1ae7b00760 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -21,7 +21,7 @@
 #include <linux/types.h>
 #include <linux/of.h>
 #include <linux/property.h>
-
+#include <linux/bits.h>
 #include <linux/dma/imx-dma.h>
 
 #define DRIVER_NAME "spi_imx"
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


