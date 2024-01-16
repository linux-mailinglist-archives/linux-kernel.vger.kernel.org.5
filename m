Return-Path: <linux-kernel+bounces-27163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 237C482EB63
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D0DA1F24119
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CF5134CB;
	Tue, 16 Jan 2024 09:18:13 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2048.outbound.protection.partner.outlook.cn [139.219.17.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B45612B9A;
	Tue, 16 Jan 2024 09:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hhd6zL8N6Sr6+vzuhUIJmY7nyjZmj5/j0DNltllZq50o+Sa1HAFlEF55gdaRG83iJ3zonmzdzLdTubzlw3BmUMwzoSkN8jA2F0cowlMcivump0HMhw/CI3lBAolyw5TRkTRZ+TkZZDLbfe+Kf6/DLFD6RC6t052XlNhW37kO8dD/Vz1dNugFVopb8kwCMe41/AhVJKsRBaP7QXl8KT09DADHnzPV6UzZCHChoIiQqkAVynXxCvWYkXBgsQeDn+figFx9Rkmlo9SPPKg0MJOPIK3+I8kECSNc660fuJjwvm0xO0o1mB4TmJRett18N6OJZBHMmPYK9qSQ8+FlAQXxjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2qoOEONSJjVXmGMTYO1hjr/rf4PQSzMwOCqVjfRlCs=;
 b=a4N8dk99pjtgNans8GYZuwLKEUEClISo11bj0a/YVuK88Q/A6zGCxW4cLOheLTSZHsxj5H7WXj/YOSHzXT6sRRRTwPGwusB4fSsW6alPT8NARwaWDfSS9jUUKAZfJHCycbpzJMOJJgJjnpnVu2QsmtTyoEmM/dTfaIefcM0U+cP1wcQjvlc2Z+cf3nkxVkULc1J70w83oZ81wcKXvZqlnE76aIcxZZxcG5F/85TUp1EEEV7UpT0H2n99sB01e0B6WGMaTmiu3r1gawRrEPTamGxFmPTkh4xyaU2RLozb2twR2dpKYnJqQrGvJ9xym0DzhukzN2gRIglADUdPXIRsxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::16) by SHXPR01MB0640.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Tue, 16 Jan
 2024 09:01:51 +0000
Received: from SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 ([fe80::cf5e:3b9:7295:1ff6]) by SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 ([fe80::cf5e:3b9:7295:1ff6%7]) with mapi id 15.20.7135.032; Tue, 16 Jan 2024
 09:01:51 +0000
From: Jia Jie Ho <jiajie.ho@starfivetech.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] crypto: starfive: Use dma for aes requests
Date: Tue, 16 Jan 2024 17:01:33 +0800
Message-Id: <20240116090135.75737-4-jiajie.ho@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240116090135.75737-1-jiajie.ho@starfivetech.com>
References: <20240116090135.75737-1-jiajie.ho@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0054.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::21) To SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0670:EE_|SHXPR01MB0640:EE_
X-MS-Office365-Filtering-Correlation-Id: cb6e1717-f4f8-4972-9800-08dc1671c769
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iFLP6oQvZIWbIqvYJtQ/T45SPS98DMY5YSVXb2fbUOF0xKUKT2EAtuyh1JFeyMeFtqHdba45dsfAsceWLA9YyMwSkubS0pUvO1w5Im0/mecbxk4RvE4MywghKQfaD2Xh9mbSx2jA/Zjuiug1gZRw46tUNVZeZc/bIzRn8ttO/uQfWEa+aZd50BsjHswXZCdowDanPbVbDw9zonv2uygQaY9rCM3GBiR0RF0FX9zdPAmtzVErEfPHd7VjEMPfpTIZyXNzaxA88G4c3Vo41+I889YhEcawgyT3JcQ0PZW2EloqJRH4+gtv8TIOBAArUInhBBwIh4h4wJDlDMvF8qoRtHFR7Kg1djuNT2BoMzva9ljlqAz3o40XHQ6clmFMRkuBBEwkZGb9N/rcbSr3RPzKQpuEvjKeICHOLxKKh2UCAGYXq34ryMBxSPEHxUkH3uM4PEZHblw8uPrVCZorvHpKdvZidlvmwoCVsnP2wBNZDgjVlZmf0LQVyjD3RUW7iKR/mBVcjmEfEgBRuqi78yUA+sPxHyp6jGeHIAxzYzUsUX8eOqvqg+1utb6G1wY8M8Rj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(39830400003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(38100700002)(41320700001)(2906002)(30864003)(5660300002)(36756003)(40180700001)(8936002)(8676002)(86362001)(41300700001)(38350700005)(83380400001)(26005)(40160700002)(508600001)(66476007)(110136005)(66946007)(66556008)(1076003)(2616005)(6666004)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zs+1lwRE5Swr4xmbdjsTuOFb9mowOThMcNdjXfgrf4YmrHjOli3J+GzVz6Hf?=
 =?us-ascii?Q?xMFcToYYPzZdXHu2QfNgXdWE+gerL2/LV+5nfz7UJrghU16HPxNt4gozm6Hk?=
 =?us-ascii?Q?GcckGzgvG401jqFaMa3VPvCvhYjW/5FoZhCysyT/eYbh9e+KbKjJk42yrKFY?=
 =?us-ascii?Q?X1RFRlVc/40YTKbXC3yXeaTfBn8ZMK3UQix3tmWHwSAIZlB4N8GkADbiA0Wf?=
 =?us-ascii?Q?vKcSSiriqd/JX7CesMnxQgHFaWoimxQ01ki4KDVTeo8a3KRhMRp2XpdbGP8h?=
 =?us-ascii?Q?gPSQ5ZFBn9vU9n8MSAP+NohbVXsfBmFQJjXBbhkX/kMIFx45cdiygFmNo+YA?=
 =?us-ascii?Q?Mz/2y0bsb2pgCVQYpAT6GYQ7MRpCIs0pkukwus9NZQYeV0HXpy3T6afBo2DA?=
 =?us-ascii?Q?Py/W9u2Mj7aFk6NYbfOMFm1Z4dU9XoOr/z/tb1DC2Xknk2XDO4lTTC8VUzpn?=
 =?us-ascii?Q?NOsr0X2mwFnAZf79ZtllKff53/w0St8UvMIMO665rxrrElxrL2r29fQjiZ9E?=
 =?us-ascii?Q?G9G/cyeKeFbTGcxYyEQqXka0ZMpbSbNikWzazEV7IvdcVxdlus5doAJWBps4?=
 =?us-ascii?Q?GCl2sNKEb2E10QU8u7O7vS0FQrMxSPy2W8+0nVt5LNbYtdbk8QxUuzZEMjwh?=
 =?us-ascii?Q?YwLhD3k624loTZD1gkBh3nDmB3SXTJwAcC448zUBdfWF2AqiAHeK9uCYMNZ+?=
 =?us-ascii?Q?dZJfraawDmsksaNAqvLBFUQn8A2m+XTps3lZtBURvBtXDOcDsAYklODB8OcT?=
 =?us-ascii?Q?7o11pIqh9UH4hlH/2AvPYb/+sZLOM8FN0rsD//dsqwlL+ySW5WM1iNYS+Nl6?=
 =?us-ascii?Q?7IYOJSXb5Wp7z0T0GW0xDMa91Tmj8gQ0jE1AmCtFXjI5xj6QW5xZh8SVhL7i?=
 =?us-ascii?Q?CV2gKQETrY+ZOUJ8qFAkvAp6m075MBmGMItZKP4RF4mts9xzjElK9YfX8hiC?=
 =?us-ascii?Q?knV4+yFKAD7ESINMEbvudMdca7RUBqhpOAS/HtAyUc/b2WAcdjaZCuipzC5E?=
 =?us-ascii?Q?PYC+1vn5G9Y/N/ZRrsFiL2xPWpxKxwqzf4HXgoWveT3FwKbuNb4nwZTNvc8C?=
 =?us-ascii?Q?QoRccFaLGJ/iS+P+G/bYv2a52r83urKzXrU9NfyEBRau7nC3daferk8kTZOW?=
 =?us-ascii?Q?YCUVclaQfEprgYXxBKsp7b1Tj7uUxL7tjvyBibs0eC3YXHmuC9p/sx3uxlYU?=
 =?us-ascii?Q?owif/mvRFXrSGrLSMlyvFQmTbvmQAmCaaNoCe2paRuK+5E/6d4Bz7j9JohMC?=
 =?us-ascii?Q?s4+MGl6luCMPXHj/q3Ovo9yhSdbUN168IhFNUsgkzb+aa+ui+g7WpbuLqzI/?=
 =?us-ascii?Q?nhqBXOSvJJbToIaQbtIxaOAZ8MH2DQ7yDF8sw5crm3ugfcUZMwqBF/XB3K7C?=
 =?us-ascii?Q?9+Wazy1xLiUi2/3z4yJv3dT0j9yV4MTF1YE2G7E48wLwSikaXjQqn2C7Lyjp?=
 =?us-ascii?Q?c2qbzJ75RrXBM8Si5dMEg7Bvy/V2ILlyRp00rrzIVBxVhYqqXx26GXRIVqOd?=
 =?us-ascii?Q?1tn0BFC6J3VKhlLX1654uR5ExN9qcIkbAxGv5QbZG/1dYxSHl6MePebXd+rl?=
 =?us-ascii?Q?l27Jix8uJ2F+la/yAVWY33bnOCw/+GSqngxeKu7y1I6CoHl3baUv02Ish0jb?=
 =?us-ascii?Q?Fg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb6e1717-f4f8-4972-9800-08dc1671c769
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 09:01:51.4713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C16pLoIgmT2QBgrZb/RrQTH0as7L2lK6pc9a13JrYgCO8TBWjh40tSa0Fd31KULoaOmSAw3HimlTImGBKDXSw7uyTKa5UdgsGHaqoXJXm38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0640

Convert AES module to use dma for data transfers to reduce cpu load and
compatible with future variants. The reqsize is increased to allocate
memory for the skcipher fallback algo.

Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
---
 drivers/crypto/starfive/Kconfig       |   4 +
 drivers/crypto/starfive/jh7110-aes.c  | 585 +++++++++++++++++---------
 drivers/crypto/starfive/jh7110-cryp.c |   9 -
 drivers/crypto/starfive/jh7110-cryp.h |   5 +-
 4 files changed, 393 insertions(+), 210 deletions(-)

diff --git a/drivers/crypto/starfive/Kconfig b/drivers/crypto/starfive/Kconfig
index cb59357b58b2..0fe389e9f932 100644
--- a/drivers/crypto/starfive/Kconfig
+++ b/drivers/crypto/starfive/Kconfig
@@ -14,6 +14,10 @@ config CRYPTO_DEV_JH7110
 	select CRYPTO_RSA
 	select CRYPTO_AES
 	select CRYPTO_CCM
+	select CRYPTO_GCM
+	select CRYPTO_ECB
+	select CRYPTO_CBC
+	select CRYPTO_CTR
 	help
 	  Support for StarFive JH7110 crypto hardware acceleration engine.
 	  This module provides acceleration for public key algo,
diff --git a/drivers/crypto/starfive/jh7110-aes.c b/drivers/crypto/starfive/jh7110-aes.c
index 1ac15cc4ef3c..a6e30e1a2b5d 100644
--- a/drivers/crypto/starfive/jh7110-aes.c
+++ b/drivers/crypto/starfive/jh7110-aes.c
@@ -78,7 +78,7 @@ static inline int is_gcm(struct starfive_cryp_dev *cryp)
 	return (cryp->flags & FLG_MODE_MASK) == STARFIVE_AES_MODE_GCM;
 }
 
-static inline int is_encrypt(struct starfive_cryp_dev *cryp)
+static inline bool is_encrypt(struct starfive_cryp_dev *cryp)
 {
 	return cryp->flags & FLG_ENCRYPT;
 }
@@ -103,16 +103,6 @@ static void starfive_aes_aead_hw_start(struct starfive_cryp_ctx *ctx, u32 hw_mod
 	}
 }
 
-static inline void starfive_aes_set_ivlen(struct starfive_cryp_ctx *ctx)
-{
-	struct starfive_cryp_dev *cryp = ctx->cryp;
-
-	if (is_gcm(cryp))
-		writel(GCM_AES_IV_SIZE, cryp->base + STARFIVE_AES_IVLEN);
-	else
-		writel(AES_BLOCK_SIZE, cryp->base + STARFIVE_AES_IVLEN);
-}
-
 static inline void starfive_aes_set_alen(struct starfive_cryp_ctx *ctx)
 {
 	struct starfive_cryp_dev *cryp = ctx->cryp;
@@ -261,7 +251,6 @@ static int starfive_aes_hw_init(struct starfive_cryp_ctx *ctx)
 
 	rctx->csr.aes.mode  = hw_mode;
 	rctx->csr.aes.cmode = !is_encrypt(cryp);
-	rctx->csr.aes.ie = 1;
 	rctx->csr.aes.stmode = STARFIVE_AES_MODE_XFB_1;
 
 	if (cryp->side_chan) {
@@ -279,7 +268,7 @@ static int starfive_aes_hw_init(struct starfive_cryp_ctx *ctx)
 	case STARFIVE_AES_MODE_GCM:
 		starfive_aes_set_alen(ctx);
 		starfive_aes_set_mlen(ctx);
-		starfive_aes_set_ivlen(ctx);
+		writel(GCM_AES_IV_SIZE, cryp->base + STARFIVE_AES_IVLEN);
 		starfive_aes_aead_hw_start(ctx, hw_mode);
 		starfive_aes_write_iv(ctx, (void *)cryp->req.areq->iv);
 		break;
@@ -300,28 +289,30 @@ static int starfive_aes_hw_init(struct starfive_cryp_ctx *ctx)
 	return cryp->err;
 }
 
-static int starfive_aes_read_authtag(struct starfive_cryp_dev *cryp)
+static int starfive_aes_read_authtag(struct starfive_cryp_ctx *ctx)
 {
-	int i, start_addr;
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+	struct starfive_cryp_request_ctx *rctx = ctx->rctx;
+	int i;
 
 	if (starfive_aes_wait_busy(cryp))
 		return dev_err_probe(cryp->dev, -ETIMEDOUT,
 				     "Timeout waiting for tag generation.");
 
-	start_addr = STARFIVE_AES_NONCE0;
-
-	if (is_gcm(cryp))
-		for (i = 0; i < AES_BLOCK_32; i++, start_addr += 4)
-			cryp->tag_out[i] = readl(cryp->base + start_addr);
-	else
+	if ((cryp->flags & FLG_MODE_MASK) == STARFIVE_AES_MODE_GCM) {
+		cryp->tag_out[0] = readl(cryp->base + STARFIVE_AES_NONCE0);
+		cryp->tag_out[1] = readl(cryp->base + STARFIVE_AES_NONCE1);
+		cryp->tag_out[2] = readl(cryp->base + STARFIVE_AES_NONCE2);
+		cryp->tag_out[3] = readl(cryp->base + STARFIVE_AES_NONCE3);
+	} else {
 		for (i = 0; i < AES_BLOCK_32; i++)
 			cryp->tag_out[i] = readl(cryp->base + STARFIVE_AES_AESDIO0R);
+	}
 
 	if (is_encrypt(cryp)) {
-		scatterwalk_copychunks(cryp->tag_out, &cryp->out_walk, cryp->authsize, 1);
+		scatterwalk_map_and_copy(cryp->tag_out, rctx->out_sg,
+					 cryp->total_in, cryp->authsize, 1);
 	} else {
-		scatterwalk_copychunks(cryp->tag_in, &cryp->in_walk, cryp->authsize, 0);
-
 		if (crypto_memneq(cryp->tag_in, cryp->tag_out, cryp->authsize))
 			return dev_err_probe(cryp->dev, -EBADMSG, "Failed tag verification\n");
 	}
@@ -329,23 +320,18 @@ static int starfive_aes_read_authtag(struct starfive_cryp_dev *cryp)
 	return 0;
 }
 
-static void starfive_aes_finish_req(struct starfive_cryp_dev *cryp)
+static void starfive_aes_finish_req(struct starfive_cryp_ctx *ctx)
 {
-	union starfive_aes_csr csr;
+	struct starfive_cryp_dev *cryp = ctx->cryp;
 	int err = cryp->err;
 
 	if (!err && cryp->authsize)
-		err = starfive_aes_read_authtag(cryp);
+		err = starfive_aes_read_authtag(ctx);
 
 	if (!err && ((cryp->flags & FLG_MODE_MASK) == STARFIVE_AES_MODE_CBC ||
 		     (cryp->flags & FLG_MODE_MASK) == STARFIVE_AES_MODE_CTR))
 		starfive_aes_get_iv(cryp, (void *)cryp->req.sreq->iv);
 
-	/* reset irq flags*/
-	csr.v = 0;
-	csr.aesrst = 1;
-	writel(csr.v, cryp->base + STARFIVE_AES_CSR);
-
 	if (cryp->authsize)
 		crypto_finalize_aead_request(cryp->engine, cryp->req.areq, err);
 	else
@@ -353,39 +339,6 @@ static void starfive_aes_finish_req(struct starfive_cryp_dev *cryp)
 						 err);
 }
 
-void starfive_aes_done_task(unsigned long param)
-{
-	struct starfive_cryp_dev *cryp = (struct starfive_cryp_dev *)param;
-	u32 block[AES_BLOCK_32];
-	u32 stat;
-	int i;
-
-	for (i = 0; i < AES_BLOCK_32; i++)
-		block[i] = readl(cryp->base + STARFIVE_AES_AESDIO0R);
-
-	scatterwalk_copychunks(block, &cryp->out_walk, min_t(size_t, AES_BLOCK_SIZE,
-							     cryp->total_out), 1);
-
-	cryp->total_out -= min_t(size_t, AES_BLOCK_SIZE, cryp->total_out);
-
-	if (!cryp->total_out) {
-		starfive_aes_finish_req(cryp);
-		return;
-	}
-
-	memset(block, 0, AES_BLOCK_SIZE);
-	scatterwalk_copychunks(block, &cryp->in_walk, min_t(size_t, AES_BLOCK_SIZE,
-							    cryp->total_in), 0);
-	cryp->total_in -= min_t(size_t, AES_BLOCK_SIZE, cryp->total_in);
-
-	for (i = 0; i < AES_BLOCK_32; i++)
-		writel(block[i], cryp->base + STARFIVE_AES_AESDIO0R);
-
-	stat = readl(cryp->base + STARFIVE_IE_MASK_OFFSET);
-	stat &= ~STARFIVE_IE_MASK_AES_DONE;
-	writel(stat, cryp->base + STARFIVE_IE_MASK_OFFSET);
-}
-
 static int starfive_aes_gcm_write_adata(struct starfive_cryp_ctx *ctx)
 {
 	struct starfive_cryp_dev *cryp = ctx->cryp;
@@ -451,60 +404,165 @@ static int starfive_aes_ccm_write_adata(struct starfive_cryp_ctx *ctx)
 	return 0;
 }
 
-static int starfive_aes_prepare_req(struct skcipher_request *req,
-				    struct aead_request *areq)
+static void starfive_aes_dma_done(void *param)
 {
-	struct starfive_cryp_ctx *ctx;
-	struct starfive_cryp_request_ctx *rctx;
-	struct starfive_cryp_dev *cryp;
+	struct starfive_cryp_dev *cryp = param;
 
-	if (!req && !areq)
-		return -EINVAL;
+	complete(&cryp->dma_done);
+}
 
-	ctx = req ? crypto_skcipher_ctx(crypto_skcipher_reqtfm(req)) :
-		    crypto_aead_ctx(crypto_aead_reqtfm(areq));
+static void starfive_aes_dma_init(struct starfive_cryp_dev *cryp)
+{
+	cryp->cfg_in.direction = DMA_MEM_TO_DEV;
+	cryp->cfg_in.src_addr_width = DMA_SLAVE_BUSWIDTH_16_BYTES;
+	cryp->cfg_in.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	cryp->cfg_in.src_maxburst = cryp->dma_maxburst;
+	cryp->cfg_in.dst_maxburst = cryp->dma_maxburst;
+	cryp->cfg_in.dst_addr = cryp->phys_base + STARFIVE_ALG_FIFO_OFFSET;
 
-	cryp = ctx->cryp;
-	rctx = req ? skcipher_request_ctx(req) : aead_request_ctx(areq);
+	dmaengine_slave_config(cryp->tx, &cryp->cfg_in);
 
-	if (req) {
-		cryp->req.sreq = req;
-		cryp->total_in = req->cryptlen;
-		cryp->total_out = req->cryptlen;
-		cryp->assoclen = 0;
-		cryp->authsize = 0;
-	} else {
-		cryp->req.areq = areq;
-		cryp->assoclen = areq->assoclen;
-		cryp->authsize = crypto_aead_authsize(crypto_aead_reqtfm(areq));
-		if (is_encrypt(cryp)) {
-			cryp->total_in = areq->cryptlen;
-			cryp->total_out = areq->cryptlen;
-		} else {
-			cryp->total_in = areq->cryptlen - cryp->authsize;
-			cryp->total_out = cryp->total_in;
-		}
-	}
+	cryp->cfg_out.direction = DMA_DEV_TO_MEM;
+	cryp->cfg_out.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	cryp->cfg_out.dst_addr_width = DMA_SLAVE_BUSWIDTH_16_BYTES;
+	cryp->cfg_out.src_maxburst = 4;
+	cryp->cfg_out.dst_maxburst = 4;
+	cryp->cfg_out.src_addr = cryp->phys_base + STARFIVE_ALG_FIFO_OFFSET;
 
-	rctx->in_sg = req ? req->src : areq->src;
-	scatterwalk_start(&cryp->in_walk, rctx->in_sg);
+	dmaengine_slave_config(cryp->rx, &cryp->cfg_out);
 
-	rctx->out_sg = req ? req->dst : areq->dst;
-	scatterwalk_start(&cryp->out_walk, rctx->out_sg);
+	init_completion(&cryp->dma_done);
+}
 
-	if (cryp->assoclen) {
-		rctx->adata = kzalloc(cryp->assoclen + AES_BLOCK_SIZE, GFP_KERNEL);
-		if (!rctx->adata)
-			return dev_err_probe(cryp->dev, -ENOMEM,
-					     "Failed to alloc memory for adata");
+static int starfive_aes_dma_xfer(struct starfive_cryp_dev *cryp,
+				 struct scatterlist *src,
+				 struct scatterlist *dst,
+				 int len)
+{
+	struct dma_async_tx_descriptor *in_desc, *out_desc;
+	union starfive_alg_cr alg_cr;
+	int ret = 0, in_save, out_save;
+
+	alg_cr.v = 0;
+	alg_cr.start = 1;
+	alg_cr.aes_dma_en = 1;
+	writel(alg_cr.v, cryp->base + STARFIVE_ALG_CR_OFFSET);
 
-		scatterwalk_copychunks(rctx->adata, &cryp->in_walk, cryp->assoclen, 0);
-		scatterwalk_copychunks(NULL, &cryp->out_walk, cryp->assoclen, 2);
+	in_save = sg_dma_len(src);
+	out_save = sg_dma_len(dst);
+
+	writel(ALIGN(len, AES_BLOCK_SIZE), cryp->base + STARFIVE_DMA_IN_LEN_OFFSET);
+	writel(ALIGN(len, AES_BLOCK_SIZE), cryp->base + STARFIVE_DMA_OUT_LEN_OFFSET);
+
+	sg_dma_len(src) = ALIGN(len, AES_BLOCK_SIZE);
+	sg_dma_len(dst) = ALIGN(len, AES_BLOCK_SIZE);
+
+	out_desc = dmaengine_prep_slave_sg(cryp->rx, dst, 1, DMA_DEV_TO_MEM,
+					   DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!out_desc) {
+		ret = -EINVAL;
+		goto dma_err;
 	}
 
-	ctx->rctx = rctx;
+	out_desc->callback = starfive_aes_dma_done;
+	out_desc->callback_param = cryp;
+
+	reinit_completion(&cryp->dma_done);
+	dmaengine_submit(out_desc);
+	dma_async_issue_pending(cryp->rx);
+
+	in_desc = dmaengine_prep_slave_sg(cryp->tx, src, 1, DMA_MEM_TO_DEV,
+					  DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!in_desc) {
+		ret = -EINVAL;
+		goto dma_err;
+	}
+
+	dmaengine_submit(in_desc);
+	dma_async_issue_pending(cryp->tx);
+
+	if (!wait_for_completion_timeout(&cryp->dma_done,
+					 msecs_to_jiffies(1000)))
+		ret = -ETIMEDOUT;
 
-	return starfive_aes_hw_init(ctx);
+dma_err:
+	sg_dma_len(src) = in_save;
+	sg_dma_len(dst) = out_save;
+
+	alg_cr.v = 0;
+	alg_cr.clear = 1;
+	writel(alg_cr.v, cryp->base + STARFIVE_ALG_CR_OFFSET);
+
+	return ret;
+}
+
+static int starfive_aes_map_sg(struct starfive_cryp_dev *cryp,
+			       struct scatterlist *src,
+			       struct scatterlist *dst)
+{
+	struct scatterlist *stsg, *dtsg;
+	struct scatterlist _src[2], _dst[2];
+	unsigned int remain = cryp->total_in;
+	unsigned int len, src_nents, dst_nents;
+	int ret;
+
+	if (src == dst) {
+		for (stsg = src, dtsg = dst; remain > 0;
+		     stsg = sg_next(stsg), dtsg = sg_next(dtsg)) {
+			src_nents = dma_map_sg(cryp->dev, stsg, 1, DMA_BIDIRECTIONAL);
+			if (src_nents == 0)
+				return dev_err_probe(cryp->dev, -ENOMEM,
+						     "dma_map_sg error\n");
+
+			dst_nents = src_nents;
+			len = min(sg_dma_len(stsg), remain);
+
+			ret = starfive_aes_dma_xfer(cryp, stsg, dtsg, len);
+			dma_unmap_sg(cryp->dev, stsg, 1, DMA_BIDIRECTIONAL);
+			if (ret)
+				return ret;
+
+			remain -= len;
+		}
+	} else {
+		for (stsg = src, dtsg = dst;;) {
+			src_nents = dma_map_sg(cryp->dev, stsg, 1, DMA_TO_DEVICE);
+			if (src_nents == 0)
+				return dev_err_probe(cryp->dev, -ENOMEM,
+						     "dma_map_sg src error\n");
+
+			dst_nents = dma_map_sg(cryp->dev, dtsg, 1, DMA_FROM_DEVICE);
+			if (dst_nents == 0)
+				return dev_err_probe(cryp->dev, -ENOMEM,
+						     "dma_map_sg dst error\n");
+
+			len = min(sg_dma_len(stsg), sg_dma_len(dtsg));
+			len = min(len, remain);
+
+			ret = starfive_aes_dma_xfer(cryp, stsg, dtsg, len);
+			dma_unmap_sg(cryp->dev, stsg, 1, DMA_TO_DEVICE);
+			dma_unmap_sg(cryp->dev, dtsg, 1, DMA_FROM_DEVICE);
+			if (ret)
+				return ret;
+
+			remain -= len;
+			if (remain == 0)
+				break;
+
+			if (sg_dma_len(stsg) - len) {
+				stsg = scatterwalk_ffwd(_src, stsg, len);
+				dtsg = sg_next(dtsg);
+			} else if (sg_dma_len(dtsg) - len) {
+				dtsg = scatterwalk_ffwd(_dst, dtsg, len);
+				stsg = sg_next(stsg);
+			} else {
+				stsg = sg_next(stsg);
+				dtsg = sg_next(dtsg);
+			}
+		}
+	}
+
+	return 0;
 }
 
 static int starfive_aes_do_one_req(struct crypto_engine *engine, void *areq)
@@ -513,35 +571,38 @@ static int starfive_aes_do_one_req(struct crypto_engine *engine, void *areq)
 		container_of(areq, struct skcipher_request, base);
 	struct starfive_cryp_ctx *ctx =
 		crypto_skcipher_ctx(crypto_skcipher_reqtfm(req));
+	struct starfive_cryp_request_ctx *rctx = skcipher_request_ctx(req);
 	struct starfive_cryp_dev *cryp = ctx->cryp;
-	u32 block[AES_BLOCK_32];
-	u32 stat;
-	int err;
-	int i;
+	int ret;
 
-	err = starfive_aes_prepare_req(req, NULL);
-	if (err)
-		return err;
+	cryp->req.sreq = req;
+	cryp->total_in = req->cryptlen;
+	cryp->total_out = req->cryptlen;
+	cryp->assoclen = 0;
+	cryp->authsize = 0;
 
-	/*
-	 * Write first plain/ciphertext block to start the module
-	 * then let irq tasklet handle the rest of the data blocks.
-	 */
-	scatterwalk_copychunks(block, &cryp->in_walk, min_t(size_t, AES_BLOCK_SIZE,
-							    cryp->total_in), 0);
-	cryp->total_in -= min_t(size_t, AES_BLOCK_SIZE, cryp->total_in);
+	rctx->in_sg = req->src;
+	rctx->out_sg = req->dst;
+
+	ctx->rctx = rctx;
+
+	ret = starfive_aes_hw_init(ctx);
+	if (ret)
+		return ret;
 
-	for (i = 0; i < AES_BLOCK_32; i++)
-		writel(block[i], cryp->base + STARFIVE_AES_AESDIO0R);
+	starfive_aes_dma_init(cryp);
 
-	stat = readl(cryp->base + STARFIVE_IE_MASK_OFFSET);
-	stat &= ~STARFIVE_IE_MASK_AES_DONE;
-	writel(stat, cryp->base + STARFIVE_IE_MASK_OFFSET);
+	ret = starfive_aes_map_sg(cryp, rctx->in_sg, rctx->out_sg);
+	if (ret)
+		return ret;
+
+	starfive_aes_finish_req(ctx);
 
 	return 0;
 }
 
-static int starfive_aes_init_tfm(struct crypto_skcipher *tfm)
+static int starfive_aes_init_tfm(struct crypto_skcipher *tfm,
+				 const char *alg_name)
 {
 	struct starfive_cryp_ctx *ctx = crypto_skcipher_ctx(tfm);
 
@@ -549,12 +610,26 @@ static int starfive_aes_init_tfm(struct crypto_skcipher *tfm)
 	if (!ctx->cryp)
 		return -ENODEV;
 
-	crypto_skcipher_set_reqsize(tfm, sizeof(struct starfive_cryp_request_ctx) +
+	ctx->skcipher_fbk = crypto_alloc_skcipher(alg_name, 0,
+						  CRYPTO_ALG_NEED_FALLBACK);
+	if (IS_ERR(ctx->skcipher_fbk))
+		return dev_err_probe(ctx->cryp->dev, PTR_ERR(ctx->skcipher_fbk),
+				     "%s() failed to allocate fallback for %s\n",
+				     __func__, alg_name);
+
+	crypto_skcipher_set_reqsize(tfm, sizeof(struct starfive_cryp_ctx) +
 				    sizeof(struct skcipher_request));
 
 	return 0;
 }
 
+static void starfive_aes_exit_tfm(struct crypto_skcipher *tfm)
+{
+	struct starfive_cryp_ctx *ctx = crypto_skcipher_ctx(tfm);
+
+	crypto_free_skcipher(ctx->skcipher_fbk);
+}
+
 static int starfive_aes_aead_do_one_req(struct crypto_engine *engine, void *areq)
 {
 	struct aead_request *req =
@@ -562,76 +637,96 @@ static int starfive_aes_aead_do_one_req(struct crypto_engine *engine, void *areq
 	struct starfive_cryp_ctx *ctx =
 		crypto_aead_ctx(crypto_aead_reqtfm(req));
 	struct starfive_cryp_dev *cryp = ctx->cryp;
-	struct starfive_cryp_request_ctx *rctx;
-	u32 block[AES_BLOCK_32];
-	u32 stat;
-	int err;
-	int i;
+	struct starfive_cryp_request_ctx *rctx = aead_request_ctx(req);
+	struct scatterlist _src[2], _dst[2];
+	int ret;
+
+	cryp->req.areq = req;
+	cryp->assoclen = req->assoclen;
+	cryp->authsize = crypto_aead_authsize(crypto_aead_reqtfm(req));
+
+	rctx->in_sg = scatterwalk_ffwd(_src, req->src, cryp->assoclen);
+	if (req->src == req->dst)
+		rctx->out_sg = rctx->in_sg;
+	else
+		rctx->out_sg = scatterwalk_ffwd(_dst, req->dst, cryp->assoclen);
 
-	err = starfive_aes_prepare_req(NULL, req);
-	if (err)
-		return err;
+	if (is_encrypt(cryp)) {
+		cryp->total_in = req->cryptlen;
+		cryp->total_out = req->cryptlen;
+	} else {
+		cryp->total_in = req->cryptlen - cryp->authsize;
+		cryp->total_out = cryp->total_in;
+		scatterwalk_map_and_copy(cryp->tag_in, req->src,
+					 cryp->total_in + cryp->assoclen,
+					 cryp->authsize, 0);
+	}
 
-	rctx = ctx->rctx;
+	if (cryp->assoclen) {
+		rctx->adata = kzalloc(cryp->assoclen + AES_BLOCK_SIZE, GFP_KERNEL);
+		if (!rctx->adata)
+			return dev_err_probe(cryp->dev, -ENOMEM,
+					     "Failed to alloc memory for adata");
+
+		if (sg_copy_to_buffer(req->src, sg_nents_for_len(req->src, cryp->assoclen),
+				      rctx->adata, cryp->assoclen) != cryp->assoclen)
+			return -EINVAL;
+	}
+
+	if (cryp->total_in)
+		sg_zero_buffer(rctx->in_sg, sg_nents(rctx->in_sg),
+			       sg_dma_len(rctx->in_sg) - cryp->total_in,
+			       cryp->total_in);
+
+	ctx->rctx = rctx;
+
+	ret = starfive_aes_hw_init(ctx);
+	if (ret)
+		return ret;
 
 	if (!cryp->assoclen)
 		goto write_text;
 
 	if ((cryp->flags & FLG_MODE_MASK) == STARFIVE_AES_MODE_CCM)
-		cryp->err = starfive_aes_ccm_write_adata(ctx);
+		ret = starfive_aes_ccm_write_adata(ctx);
 	else
-		cryp->err = starfive_aes_gcm_write_adata(ctx);
+		ret = starfive_aes_gcm_write_adata(ctx);
 
 	kfree(rctx->adata);
 
-	if (cryp->err)
-		return cryp->err;
+	if (ret)
+		return ret;
 
 write_text:
 	if (!cryp->total_in)
 		goto finish_req;
 
-	/*
-	 * Write first plain/ciphertext block to start the module
-	 * then let irq tasklet handle the rest of the data blocks.
-	 */
-	scatterwalk_copychunks(block, &cryp->in_walk, min_t(size_t, AES_BLOCK_SIZE,
-							    cryp->total_in), 0);
-	cryp->total_in -= min_t(size_t, AES_BLOCK_SIZE, cryp->total_in);
-
-	for (i = 0; i < AES_BLOCK_32; i++)
-		writel(block[i], cryp->base + STARFIVE_AES_AESDIO0R);
+	starfive_aes_dma_init(cryp);
 
-	stat = readl(cryp->base + STARFIVE_IE_MASK_OFFSET);
-	stat &= ~STARFIVE_IE_MASK_AES_DONE;
-	writel(stat, cryp->base + STARFIVE_IE_MASK_OFFSET);
-
-	return 0;
+	ret = starfive_aes_map_sg(cryp, rctx->in_sg, rctx->out_sg);
+	if (ret)
+		return ret;
 
 finish_req:
-	starfive_aes_finish_req(cryp);
+	starfive_aes_finish_req(ctx);
 	return 0;
 }
 
-static int starfive_aes_aead_init_tfm(struct crypto_aead *tfm)
+static int starfive_aes_aead_init_tfm(struct crypto_aead *tfm,
+				      const char *alg_name)
 {
 	struct starfive_cryp_ctx *ctx = crypto_aead_ctx(tfm);
-	struct starfive_cryp_dev *cryp = ctx->cryp;
-	struct crypto_tfm *aead = crypto_aead_tfm(tfm);
-	struct crypto_alg *alg = aead->__crt_alg;
 
 	ctx->cryp = starfive_cryp_find_dev(ctx);
 	if (!ctx->cryp)
 		return -ENODEV;
 
-	if (alg->cra_flags & CRYPTO_ALG_NEED_FALLBACK) {
-		ctx->aead_fbk = crypto_alloc_aead(alg->cra_name, 0,
-						  CRYPTO_ALG_NEED_FALLBACK);
-		if (IS_ERR(ctx->aead_fbk))
-			return dev_err_probe(cryp->dev, PTR_ERR(ctx->aead_fbk),
-					     "%s() failed to allocate fallback for %s\n",
-					     __func__, alg->cra_name);
-	}
+	ctx->aead_fbk = crypto_alloc_aead(alg_name, 0,
+					  CRYPTO_ALG_NEED_FALLBACK);
+	if (IS_ERR(ctx->aead_fbk))
+		return dev_err_probe(ctx->cryp->dev, PTR_ERR(ctx->aead_fbk),
+				     "%s() failed to allocate fallback for %s\n",
+				     __func__, alg_name);
 
 	crypto_aead_set_reqsize(tfm, sizeof(struct starfive_cryp_ctx) +
 				sizeof(struct aead_request));
@@ -646,6 +741,44 @@ static void starfive_aes_aead_exit_tfm(struct crypto_aead *tfm)
 	crypto_free_aead(ctx->aead_fbk);
 }
 
+static bool starfive_aes_check_unaligned(struct starfive_cryp_dev *cryp,
+					 struct scatterlist *src,
+					 struct scatterlist *dst)
+{
+	struct scatterlist *tsg;
+	int i;
+
+	for_each_sg(src, tsg, sg_nents(src), i)
+		if (!IS_ALIGNED(tsg->length, AES_BLOCK_SIZE) &&
+		    !sg_is_last(tsg))
+			return true;
+
+	if (src != dst)
+		for_each_sg(dst, tsg, sg_nents(dst), i)
+			if (!IS_ALIGNED(tsg->length, AES_BLOCK_SIZE) &&
+			    !sg_is_last(tsg))
+				return true;
+
+	return false;
+}
+
+static int starfive_aes_do_fallback(struct skcipher_request *req, bool enc)
+{
+	struct starfive_cryp_ctx *ctx =
+		crypto_skcipher_ctx(crypto_skcipher_reqtfm(req));
+	struct skcipher_request *subreq = skcipher_request_ctx(req);
+
+	skcipher_request_set_tfm(subreq, ctx->skcipher_fbk);
+	skcipher_request_set_callback(subreq, req->base.flags,
+				      req->base.complete,
+				      req->base.data);
+	skcipher_request_set_crypt(subreq, req->src, req->dst,
+				   req->cryptlen, req->iv);
+
+	return enc ? crypto_skcipher_encrypt(subreq) :
+		     crypto_skcipher_decrypt(subreq);
+}
+
 static int starfive_aes_crypt(struct skcipher_request *req, unsigned long flags)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
@@ -660,32 +793,54 @@ static int starfive_aes_crypt(struct skcipher_request *req, unsigned long flags)
 		if (req->cryptlen & blocksize_align)
 			return -EINVAL;
 
+	if (starfive_aes_check_unaligned(cryp, req->src, req->dst))
+		return starfive_aes_do_fallback(req, is_encrypt(cryp));
+
 	return crypto_transfer_skcipher_request_to_engine(cryp->engine, req);
 }
 
+static int starfive_aes_aead_do_fallback(struct aead_request *req, bool enc)
+{
+	struct starfive_cryp_ctx *ctx =
+		crypto_aead_ctx(crypto_aead_reqtfm(req));
+	struct aead_request *subreq = aead_request_ctx(req);
+
+	aead_request_set_tfm(subreq, ctx->aead_fbk);
+	aead_request_set_callback(subreq, req->base.flags,
+				  req->base.complete,
+				  req->base.data);
+	aead_request_set_crypt(subreq, req->src, req->dst,
+			       req->cryptlen, req->iv);
+	aead_request_set_ad(subreq, req->assoclen);
+
+	return enc ? crypto_aead_encrypt(subreq) :
+		     crypto_aead_decrypt(subreq);
+}
+
 static int starfive_aes_aead_crypt(struct aead_request *req, unsigned long flags)
 {
 	struct starfive_cryp_ctx *ctx = crypto_aead_ctx(crypto_aead_reqtfm(req));
 	struct starfive_cryp_dev *cryp = ctx->cryp;
+	struct scatterlist *src, *dst, _src[2], _dst[2];
 
 	cryp->flags = flags;
 
-	/*
-	 * HW engine could not perform CCM tag verification on
-	 * non-blocksize aligned text, use fallback algo instead
+	/* aes-ccm does not support tag verification for non-aligned text,
+	 * use fallback for ccm decryption instead.
 	 */
-	if (ctx->aead_fbk && !is_encrypt(cryp)) {
-		struct aead_request *subreq = aead_request_ctx(req);
+	if (((cryp->flags & FLG_MODE_MASK) == STARFIVE_AES_MODE_CCM) &&
+	    !is_encrypt(cryp))
+		return starfive_aes_aead_do_fallback(req, 0);
 
-		aead_request_set_tfm(subreq, ctx->aead_fbk);
-		aead_request_set_callback(subreq, req->base.flags,
-					  req->base.complete, req->base.data);
-		aead_request_set_crypt(subreq, req->src,
-				       req->dst, req->cryptlen, req->iv);
-		aead_request_set_ad(subreq, req->assoclen);
+	src = scatterwalk_ffwd(_src, req->src, req->assoclen);
 
-		return crypto_aead_decrypt(subreq);
-	}
+	if (req->src == req->dst)
+		dst = src;
+	else
+		dst = scatterwalk_ffwd(_dst, req->dst, req->assoclen);
+
+	if (starfive_aes_check_unaligned(cryp, src, dst))
+		return starfive_aes_aead_do_fallback(req, is_encrypt(cryp));
 
 	return crypto_transfer_aead_request_to_engine(cryp->engine, req);
 }
@@ -706,7 +861,7 @@ static int starfive_aes_setkey(struct crypto_skcipher *tfm, const u8 *key,
 	memcpy(ctx->key, key, keylen);
 	ctx->keylen = keylen;
 
-	return 0;
+	return crypto_skcipher_setkey(ctx->skcipher_fbk, key, keylen);
 }
 
 static int starfive_aes_aead_setkey(struct crypto_aead *tfm, const u8 *key,
@@ -725,16 +880,20 @@ static int starfive_aes_aead_setkey(struct crypto_aead *tfm, const u8 *key,
 	memcpy(ctx->key, key, keylen);
 	ctx->keylen = keylen;
 
-	if (ctx->aead_fbk)
-		return crypto_aead_setkey(ctx->aead_fbk, key, keylen);
-
-	return 0;
+	return crypto_aead_setkey(ctx->aead_fbk, key, keylen);
 }
 
 static int starfive_aes_gcm_setauthsize(struct crypto_aead *tfm,
 					unsigned int authsize)
 {
-	return crypto_gcm_check_authsize(authsize);
+	struct starfive_cryp_ctx *ctx = crypto_aead_ctx(tfm);
+	int ret;
+
+	ret = crypto_gcm_check_authsize(authsize);
+	if (ret)
+		return ret;
+
+	return crypto_aead_setauthsize(ctx->aead_fbk, authsize);
 }
 
 static int starfive_aes_ccm_setauthsize(struct crypto_aead *tfm,
@@ -820,9 +979,35 @@ static int starfive_aes_ccm_decrypt(struct aead_request *req)
 	return starfive_aes_aead_crypt(req, STARFIVE_AES_MODE_CCM);
 }
 
+static int starfive_aes_ecb_init_tfm(struct crypto_skcipher *tfm)
+{
+	return starfive_aes_init_tfm(tfm, "ecb(aes-generic)");
+}
+
+static int starfive_aes_cbc_init_tfm(struct crypto_skcipher *tfm)
+{
+	return starfive_aes_init_tfm(tfm, "cbc(aes-generic)");
+}
+
+static int starfive_aes_ctr_init_tfm(struct crypto_skcipher *tfm)
+{
+	return starfive_aes_init_tfm(tfm, "ctr(aes-generic)");
+}
+
+static int starfive_aes_ccm_init_tfm(struct crypto_aead *tfm)
+{
+	return starfive_aes_aead_init_tfm(tfm, "ccm_base(ctr(aes-generic),cbcmac(aes-generic))");
+}
+
+static int starfive_aes_gcm_init_tfm(struct crypto_aead *tfm)
+{
+	return starfive_aes_aead_init_tfm(tfm, "gcm_base(ctr(aes-generic),ghash-generic)");
+}
+
 static struct skcipher_engine_alg skcipher_algs[] = {
 {
-	.base.init			= starfive_aes_init_tfm,
+	.base.init			= starfive_aes_ecb_init_tfm,
+	.base.exit			= starfive_aes_exit_tfm,
 	.base.setkey			= starfive_aes_setkey,
 	.base.encrypt			= starfive_aes_ecb_encrypt,
 	.base.decrypt			= starfive_aes_ecb_decrypt,
@@ -832,7 +1017,8 @@ static struct skcipher_engine_alg skcipher_algs[] = {
 		.cra_name		= "ecb(aes)",
 		.cra_driver_name	= "starfive-ecb-aes",
 		.cra_priority		= 200,
-		.cra_flags		= CRYPTO_ALG_ASYNC,
+		.cra_flags		= CRYPTO_ALG_ASYNC |
+					  CRYPTO_ALG_NEED_FALLBACK,
 		.cra_blocksize		= AES_BLOCK_SIZE,
 		.cra_ctxsize		= sizeof(struct starfive_cryp_ctx),
 		.cra_alignmask		= 0xf,
@@ -842,7 +1028,8 @@ static struct skcipher_engine_alg skcipher_algs[] = {
 		.do_one_request = starfive_aes_do_one_req,
 	},
 }, {
-	.base.init			= starfive_aes_init_tfm,
+	.base.init			= starfive_aes_cbc_init_tfm,
+	.base.exit			= starfive_aes_exit_tfm,
 	.base.setkey			= starfive_aes_setkey,
 	.base.encrypt			= starfive_aes_cbc_encrypt,
 	.base.decrypt			= starfive_aes_cbc_decrypt,
@@ -853,7 +1040,8 @@ static struct skcipher_engine_alg skcipher_algs[] = {
 		.cra_name		= "cbc(aes)",
 		.cra_driver_name	= "starfive-cbc-aes",
 		.cra_priority		= 200,
-		.cra_flags		= CRYPTO_ALG_ASYNC,
+		.cra_flags		= CRYPTO_ALG_ASYNC |
+					  CRYPTO_ALG_NEED_FALLBACK,
 		.cra_blocksize		= AES_BLOCK_SIZE,
 		.cra_ctxsize		= sizeof(struct starfive_cryp_ctx),
 		.cra_alignmask		= 0xf,
@@ -863,7 +1051,8 @@ static struct skcipher_engine_alg skcipher_algs[] = {
 		.do_one_request = starfive_aes_do_one_req,
 	},
 }, {
-	.base.init			= starfive_aes_init_tfm,
+	.base.init			= starfive_aes_ctr_init_tfm,
+	.base.exit			= starfive_aes_exit_tfm,
 	.base.setkey			= starfive_aes_setkey,
 	.base.encrypt			= starfive_aes_ctr_encrypt,
 	.base.decrypt			= starfive_aes_ctr_decrypt,
@@ -874,7 +1063,8 @@ static struct skcipher_engine_alg skcipher_algs[] = {
 		.cra_name		= "ctr(aes)",
 		.cra_driver_name	= "starfive-ctr-aes",
 		.cra_priority		= 200,
-		.cra_flags		= CRYPTO_ALG_ASYNC,
+		.cra_flags		= CRYPTO_ALG_ASYNC |
+					  CRYPTO_ALG_NEED_FALLBACK,
 		.cra_blocksize		= 1,
 		.cra_ctxsize		= sizeof(struct starfive_cryp_ctx),
 		.cra_alignmask		= 0xf,
@@ -892,7 +1082,7 @@ static struct aead_engine_alg aead_algs[] = {
 	.base.setauthsize		= starfive_aes_gcm_setauthsize,
 	.base.encrypt			= starfive_aes_gcm_encrypt,
 	.base.decrypt			= starfive_aes_gcm_decrypt,
-	.base.init			= starfive_aes_aead_init_tfm,
+	.base.init			= starfive_aes_gcm_init_tfm,
 	.base.exit			= starfive_aes_aead_exit_tfm,
 	.base.ivsize			= GCM_AES_IV_SIZE,
 	.base.maxauthsize		= AES_BLOCK_SIZE,
@@ -900,7 +1090,8 @@ static struct aead_engine_alg aead_algs[] = {
 		.cra_name               = "gcm(aes)",
 		.cra_driver_name        = "starfive-gcm-aes",
 		.cra_priority           = 200,
-		.cra_flags              = CRYPTO_ALG_ASYNC,
+		.cra_flags              = CRYPTO_ALG_ASYNC |
+					  CRYPTO_ALG_NEED_FALLBACK,
 		.cra_blocksize          = 1,
 		.cra_ctxsize            = sizeof(struct starfive_cryp_ctx),
 		.cra_alignmask          = 0xf,
@@ -914,7 +1105,7 @@ static struct aead_engine_alg aead_algs[] = {
 	.base.setauthsize		= starfive_aes_ccm_setauthsize,
 	.base.encrypt			= starfive_aes_ccm_encrypt,
 	.base.decrypt			= starfive_aes_ccm_decrypt,
-	.base.init			= starfive_aes_aead_init_tfm,
+	.base.init			= starfive_aes_ccm_init_tfm,
 	.base.exit			= starfive_aes_aead_exit_tfm,
 	.base.ivsize			= AES_BLOCK_SIZE,
 	.base.maxauthsize		= AES_BLOCK_SIZE,
diff --git a/drivers/crypto/starfive/jh7110-cryp.c b/drivers/crypto/starfive/jh7110-cryp.c
index 425fddf3a8ab..fe33e87f25ab 100644
--- a/drivers/crypto/starfive/jh7110-cryp.c
+++ b/drivers/crypto/starfive/jh7110-cryp.c
@@ -97,12 +97,6 @@ static irqreturn_t starfive_cryp_irq(int irq, void *priv)
 
 	mask = readl(cryp->base + STARFIVE_IE_MASK_OFFSET);
 	status = readl(cryp->base + STARFIVE_IE_FLAG_OFFSET);
-	if (status & STARFIVE_IE_FLAG_AES_DONE) {
-		mask |= STARFIVE_IE_MASK_AES_DONE;
-		writel(mask, cryp->base + STARFIVE_IE_MASK_OFFSET);
-		tasklet_schedule(&cryp->aes_done);
-	}
-
 	if (status & STARFIVE_IE_FLAG_HASH_DONE) {
 		mask |= STARFIVE_IE_MASK_HASH_DONE;
 		writel(mask, cryp->base + STARFIVE_IE_MASK_OFFSET);
@@ -131,7 +125,6 @@ static int starfive_cryp_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(cryp->base),
 				     "Error remapping memory for platform device\n");
 
-	tasklet_init(&cryp->aes_done, starfive_aes_done_task, (unsigned long)cryp);
 	tasklet_init(&cryp->hash_done, starfive_hash_done_task, (unsigned long)cryp);
 
 	cryp->phys_base = res->start;
@@ -219,7 +212,6 @@ static int starfive_cryp_probe(struct platform_device *pdev)
 	clk_disable_unprepare(cryp->ahb);
 	reset_control_assert(cryp->rst);
 
-	tasklet_kill(&cryp->aes_done);
 	tasklet_kill(&cryp->hash_done);
 
 	return ret;
@@ -233,7 +225,6 @@ static void starfive_cryp_remove(struct platform_device *pdev)
 	starfive_hash_unregister_algs();
 	starfive_rsa_unregister_algs();
 
-	tasklet_kill(&cryp->aes_done);
 	tasklet_kill(&cryp->hash_done);
 
 	crypto_engine_stop(cryp->engine);
diff --git a/drivers/crypto/starfive/jh7110-cryp.h b/drivers/crypto/starfive/jh7110-cryp.h
index 4940cd1a3fbb..ade2da468bba 100644
--- a/drivers/crypto/starfive/jh7110-cryp.h
+++ b/drivers/crypto/starfive/jh7110-cryp.h
@@ -168,6 +168,7 @@ struct starfive_cryp_ctx {
 	struct crypto_akcipher			*akcipher_fbk;
 	struct crypto_ahash			*ahash_fbk;
 	struct crypto_aead			*aead_fbk;
+	struct crypto_skcipher			*skcipher_fbk;
 };
 
 struct starfive_cryp_dev {
@@ -185,10 +186,7 @@ struct starfive_cryp_dev {
 	struct dma_chan				*rx;
 	struct dma_slave_config			cfg_in;
 	struct dma_slave_config			cfg_out;
-	struct scatter_walk			in_walk;
-	struct scatter_walk			out_walk;
 	struct crypto_engine			*engine;
-	struct tasklet_struct			aes_done;
 	struct tasklet_struct			hash_done;
 	struct completion			dma_done;
 	size_t					assoclen;
@@ -239,5 +237,4 @@ int starfive_aes_register_algs(void);
 void starfive_aes_unregister_algs(void);
 
 void starfive_hash_done_task(unsigned long param);
-void starfive_aes_done_task(unsigned long param);
 #endif
-- 
2.34.1


