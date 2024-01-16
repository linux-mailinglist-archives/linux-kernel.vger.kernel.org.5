Return-Path: <linux-kernel+bounces-27180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 458AF82EBA5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32C4D1C2169A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54B412E40;
	Tue, 16 Jan 2024 09:34:45 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2084.outbound.protection.partner.outlook.cn [139.219.17.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7733112B72;
	Tue, 16 Jan 2024 09:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/0JKeXGzE9P0h+q2P2fEzKtXNuYFtjxFU9SxTRLv5fvPi3x22BDoeJv6fPkOrxZOL5sksRidEDXyt1zWJOBR1dNbQQiK+vtG7ngNFjWDuasvcUq20VCXg1zW6WAaDvJjo3g/dh8pO+ypHy/WyOcATq0iKpln0PpMX2LFlv2DXkWStZb2KMLNkRDpsqLOU5+Frh3zeJ8t+Ryic0ujFhw3rXFmhEAb/EGAYAygthj8NJVbcbSWlxExYv7y65uDAuPc3LrklLj0IIGmxuDWpY1IsX+ADM3YHsCelyz2lqpld46F95E/rzpDR1s8bsRs4ujbeYhocxlQR0c1ccZpCY7zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sU+GYgBBPn83RX//TBJEQX/YvJND9DjfWZC9fHvCczM=;
 b=RilcQ5Tse+d045igScadjDbDgBb11auj3+c23/MPbFrE5dxLl0Mtqc50o5MAH8scLbLMNbY0iI5Nh4Wj/4Bx0Usqxk/UcKYfmEfdJCkcqi0GXd/BdynxfrOqBCbQYOhRb2Ik05Hj+cMJOxlZiZ51YBa+G9U50ikR34Xchc3nfwcc3BaJqFlBAt+5/6g0E8H3CQKCi+o0pdNRMA/GvOy/O9d0lL2HDz+JXvZa8oXKjAN9XQRyd1G9uue0AfJrGkcOXjvj//KLpV/QTq9qRJadANksrU25BIasp5iVItZ4Qw9uA9imBlOGUwW/OCQiWx0aSrpQFyZ8cksmTB/pVHu/fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::16) by SHXPR01MB0640.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Tue, 16 Jan
 2024 09:01:49 +0000
Received: from SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 ([fe80::cf5e:3b9:7295:1ff6]) by SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 ([fe80::cf5e:3b9:7295:1ff6%7]) with mapi id 15.20.7135.032; Tue, 16 Jan 2024
 09:01:49 +0000
From: Jia Jie Ho <jiajie.ho@starfivetech.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] crypto: starfive: Update hash dma usage
Date: Tue, 16 Jan 2024 17:01:32 +0800
Message-Id: <20240116090135.75737-3-jiajie.ho@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 95e27ee0-7403-4b1f-a7da-08dc1671c671
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IZig2DcspZK3DHYiSpLfQlR34MdGRBkun0x6UC6uaUkxA0tPiMiXrxOMFNTuX5Mh+Mg8HUDaDlrkO2Ud29ZhQGYu1lZmIAP8eGgY9zg8Bq5DsIVhDhhRLSsiHcv+tFIC4O8fEHQgzlNrmV7uKXzdXG/8FeqRh48ROnau/HzJ9vRA8m/d52AnOUc1irSdVnNicdD44aAejaKGztu1VUuQg83Yc1TfJ1DDzfAYooIenNXKatv9NAu2dHSl8tRrzb8DpM5di3jfFLV0kpSTDdqUTlFh9vqWZvEff1eGxTwfoVcm4dAdwALG+AYVjlYognMouhgABf4ivTTr43KLh9FJ07mWv6AJDRFiXlJ7oUtwZYtFTOO7OISUFrgF6407y6w7Ff8xeA4RsfhGhXtutmOWgbJ5ydEYjrccIVstJ6LamnuKZpBKmZ5qYx6tqXBntQVxalVXCbo2WC879LvDd5Y+R5g7xRtb2Ac3MoTMUXPGKwUrFM6o79ksKsuhACoKOUsTYuMMrd00HLnTpGs2VyYP46qWmv/AiveY7w5sDUAJBjEvGBozdKmKiDDKSLVGkXfa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(39830400003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(38100700002)(41320700001)(2906002)(30864003)(5660300002)(15650500001)(36756003)(40180700001)(8936002)(8676002)(86362001)(41300700001)(38350700005)(83380400001)(26005)(40160700002)(508600001)(66476007)(110136005)(66946007)(66556008)(1076003)(2616005)(6666004)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YHW9Qnjn20oIZTwfnoxAKyfPj3fPPaT9jrdsmbghvQ45NNuzoJZkMyoKS0dS?=
 =?us-ascii?Q?2Hg/9W4LgbbgPEkyvA3+NULusuIsF/B0ksVNCJZt9gQM8bAo78GPA22v6o6T?=
 =?us-ascii?Q?A0M5D0tz/vXf3jr8hn/YVNxpXQReS8+GK/7ytap82kQBWRSzfPQIPio9OsLX?=
 =?us-ascii?Q?z5glQGhlKaKaQKKFSNtgJ9zjhO3kPDYaZu0QkzeWg1+ffU2vF9LcTh3NJKvG?=
 =?us-ascii?Q?jzZYTJKcsQJhFNlPFrc9pTg0JrCZSU+kZcjZY1Z00E878y44k544/IhaXph9?=
 =?us-ascii?Q?vYhblWAS82H14L4QvTfTWblFbhvAPn+0NKdcrt+5f0LDO6BgCs7Dlw8Pf/pt?=
 =?us-ascii?Q?Npy5YNwR6LrMOTyT/hjyeJFAnVuia3B0LG65UAFO4nqnsPJlS4YKCNss/F7K?=
 =?us-ascii?Q?74qLj0/CjbXRwjC1iutHiLucBTRuMjn6LArrr4tbX67cyFz0jvynlbSR1j4i?=
 =?us-ascii?Q?1WtsFMj48nyStjiCaPC8QZYRDYIW6Z3/zK4lXC1/VlagokmJW88bmwwniEk/?=
 =?us-ascii?Q?o0R5z21sxnmNXcWnaxfrn1uvzNuSio7xZktuCO10P2rLyrfh2zM1932DxCMf?=
 =?us-ascii?Q?/Zn7796WbQ9Ur0rFzXiEidsT1Jdx+Ug5IRMAhBoMuw8pL4yLsr0LAeaMA/W+?=
 =?us-ascii?Q?sL+Qh1e1xJbkRKHNBTQxQz1hIQYqwnnwFynQU+NGYd6lGOpkhms7jWWoQ4OC?=
 =?us-ascii?Q?HSDMfAtrLWaTNIv1uE/UiF1g3wPKk6xz+TGO0onoMBhOVerQmlD/yGBcAdw8?=
 =?us-ascii?Q?7LKUo6ItyJPFvvlWVBHt6r84RKicLsHPQ0xf5rR2cszdJBkSGVm2vc8MyuqD?=
 =?us-ascii?Q?3boZc3naWsSG1Y/oJjkE1M5wIfBkr5osfRsOw4hHrpLa1G1HQY9yE3gRwsDZ?=
 =?us-ascii?Q?Q4oQ+Ra52yiCzi7gIRxBjCIzLsZLt9atDStU3S0TIZ+ie2ML2U6Xt0n/rem/?=
 =?us-ascii?Q?JfpV1rVo5pDwnCMrIEwSYPQ8RaWrrnLCbrdMvlHlxPa2fNAJ99HbmlQ0DHV7?=
 =?us-ascii?Q?OOuI7ZoobJu6wjzMJXiwMUdh7rPppKF/487WHiqdRqMmj8MbTglzUdWt4IUA?=
 =?us-ascii?Q?7mM9SAhrzAlIdvkshhmvBtMsYk14C/Kjec+KVU8YdwEG6ag8ZNNmnR3PuwYQ?=
 =?us-ascii?Q?qDMEe8LF/NyzI1mnstwqEZ4xSMFLJjseBxIe8HLqD55uOZDyJcR/lVpUYFOr?=
 =?us-ascii?Q?uol+0OAf3kcrzd0X/IXEfwoTkKsgBTKCwVAc36QTQQmnfK3Rt524pWFMPVPE?=
 =?us-ascii?Q?HUi+fwc2FsDhkZRggJ9cCJv9BpsdymAuAYQy9mzWVd2FQxU9l7wqEzcKVAkC?=
 =?us-ascii?Q?o0YWpSxNfyzpEoYEjErBnNaZCxHRHrAPLVcD82WKWKdfeKI84B+6IOUUrOi6?=
 =?us-ascii?Q?hxXVnVrQ0bP2v+jIok1Qc6thR9PhLmdSvCmW+82T2paMZkqWbqLnCB10izG/?=
 =?us-ascii?Q?XmBtRd6VFpuFNSAgl3aD0HZ4helS9A9WGiQaFPfAbhsikGl8GLWwduNH8YZE?=
 =?us-ascii?Q?CwrjDLCcmeF3r0ZONuB0+6lNUdtuHhAiUNTlxyBq1LV3IpaNYdof6V9wARqk?=
 =?us-ascii?Q?4d8u+hg/TjeSMM61CUGMzM/BNe5OnTKNGw8Wf31kbb+vIYC+w245UbvH3FJF?=
 =?us-ascii?Q?vw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e27ee0-7403-4b1f-a7da-08dc1671c671
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 09:01:49.8064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kJ7Oc9YPbfFgujxjd7qvhAsHLbfJEpX8BTuqww+2v20Lzaaxvdyl0aYMsjw7D0ipefD8EUcbFrJFCjdYf8jS2Eh7lrH00kwn25WMTb00RyM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0640

Current hash uses sw fallback for non-word aligned input scatterlists.
Add support for unaligned cases utilizing the data valid mask for dma.

Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
---
 drivers/crypto/starfive/jh7110-cryp.h |   1 +
 drivers/crypto/starfive/jh7110-hash.c | 257 ++++++++++----------------
 2 files changed, 100 insertions(+), 158 deletions(-)

diff --git a/drivers/crypto/starfive/jh7110-cryp.h b/drivers/crypto/starfive/jh7110-cryp.h
index 6cdf6db5d904..4940cd1a3fbb 100644
--- a/drivers/crypto/starfive/jh7110-cryp.h
+++ b/drivers/crypto/starfive/jh7110-cryp.h
@@ -190,6 +190,7 @@ struct starfive_cryp_dev {
 	struct crypto_engine			*engine;
 	struct tasklet_struct			aes_done;
 	struct tasklet_struct			hash_done;
+	struct completion			dma_done;
 	size_t					assoclen;
 	size_t					total_in;
 	size_t					total_out;
diff --git a/drivers/crypto/starfive/jh7110-hash.c b/drivers/crypto/starfive/jh7110-hash.c
index b6d1808012ca..74e151b5f875 100644
--- a/drivers/crypto/starfive/jh7110-hash.c
+++ b/drivers/crypto/starfive/jh7110-hash.c
@@ -86,62 +86,31 @@ static int starfive_hash_hmac_key(struct starfive_cryp_ctx *ctx)
 
 static void starfive_hash_start(void *param)
 {
-	struct starfive_cryp_ctx *ctx = param;
-	struct starfive_cryp_request_ctx *rctx = ctx->rctx;
-	struct starfive_cryp_dev *cryp = ctx->cryp;
-	union starfive_alg_cr alg_cr;
+	struct starfive_cryp_dev *cryp = param;
 	union starfive_hash_csr csr;
-	u32 stat;
-
-	dma_unmap_sg(cryp->dev, rctx->in_sg, rctx->in_sg_len, DMA_TO_DEVICE);
-
-	alg_cr.v = 0;
-	alg_cr.clear = 1;
-
-	writel(alg_cr.v, cryp->base + STARFIVE_ALG_CR_OFFSET);
+	u32 mask;
 
 	csr.v = readl(cryp->base + STARFIVE_HASH_SHACSR);
 	csr.firstb = 0;
 	csr.final = 1;
-
-	stat = readl(cryp->base + STARFIVE_IE_MASK_OFFSET);
-	stat &= ~STARFIVE_IE_MASK_HASH_DONE;
-	writel(stat, cryp->base + STARFIVE_IE_MASK_OFFSET);
+	csr.ie = 1;
 	writel(csr.v, cryp->base + STARFIVE_HASH_SHACSR);
+
+	mask = readl(cryp->base + STARFIVE_IE_MASK_OFFSET);
+	mask &= ~STARFIVE_IE_MASK_HASH_DONE;
+	writel(mask, cryp->base + STARFIVE_IE_MASK_OFFSET);
 }
 
-static int starfive_hash_xmit_dma(struct starfive_cryp_ctx *ctx)
+static void starfive_hash_dma_callback(void *param)
 {
-	struct starfive_cryp_request_ctx *rctx = ctx->rctx;
-	struct starfive_cryp_dev *cryp = ctx->cryp;
-	struct dma_async_tx_descriptor	*in_desc;
-	union  starfive_alg_cr alg_cr;
-	int total_len;
-	int ret;
-
-	if (!rctx->total) {
-		starfive_hash_start(ctx);
-		return 0;
-	}
+	struct starfive_cryp_dev *cryp = param;
 
-	writel(rctx->total, cryp->base + STARFIVE_DMA_IN_LEN_OFFSET);
-
-	total_len = rctx->total;
-	total_len = (total_len & 0x3) ? (((total_len >> 2) + 1) << 2) : total_len;
-	sg_dma_len(rctx->in_sg) = total_len;
-
-	alg_cr.v = 0;
-	alg_cr.start = 1;
-	alg_cr.hash_dma_en = 1;
-
-	writel(alg_cr.v, cryp->base + STARFIVE_ALG_CR_OFFSET);
-
-	ret = dma_map_sg(cryp->dev, rctx->in_sg, rctx->in_sg_len, DMA_TO_DEVICE);
-	if (!ret)
-		return dev_err_probe(cryp->dev, -EINVAL, "dma_map_sg() error\n");
+	complete(&cryp->dma_done);
+}
 
-	cryp->cfg_in.direction = DMA_MEM_TO_DEV;
-	cryp->cfg_in.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+static void starfive_hash_dma_init(struct starfive_cryp_dev *cryp)
+{
+	cryp->cfg_in.src_addr_width = DMA_SLAVE_BUSWIDTH_16_BYTES;
 	cryp->cfg_in.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	cryp->cfg_in.src_maxburst = cryp->dma_maxburst;
 	cryp->cfg_in.dst_maxburst = cryp->dma_maxburst;
@@ -149,50 +118,48 @@ static int starfive_hash_xmit_dma(struct starfive_cryp_ctx *ctx)
 
 	dmaengine_slave_config(cryp->tx, &cryp->cfg_in);
 
-	in_desc = dmaengine_prep_slave_sg(cryp->tx, rctx->in_sg,
-					  ret, DMA_MEM_TO_DEV,
-					  DMA_PREP_INTERRUPT  |  DMA_CTRL_ACK);
-
-	if (!in_desc)
-		return -EINVAL;
-
-	in_desc->callback = starfive_hash_start;
-	in_desc->callback_param = ctx;
-
-	dmaengine_submit(in_desc);
-	dma_async_issue_pending(cryp->tx);
-
-	return 0;
+	init_completion(&cryp->dma_done);
 }
 
-static int starfive_hash_xmit(struct starfive_cryp_ctx *ctx)
+static int starfive_hash_dma_xfer(struct starfive_cryp_dev *cryp,
+				  struct scatterlist *sg)
 {
-	struct starfive_cryp_request_ctx *rctx = ctx->rctx;
-	struct starfive_cryp_dev *cryp = ctx->cryp;
+	struct dma_async_tx_descriptor *in_desc;
+	union starfive_alg_cr alg_cr;
 	int ret = 0;
 
-	rctx->csr.hash.v = 0;
-	rctx->csr.hash.reset = 1;
-	writel(rctx->csr.hash.v, cryp->base + STARFIVE_HASH_SHACSR);
-
-	if (starfive_hash_wait_busy(ctx))
-		return dev_err_probe(cryp->dev, -ETIMEDOUT, "Error resetting engine.\n");
+	alg_cr.v = 0;
+	alg_cr.start = 1;
+	alg_cr.hash_dma_en = 1;
+	writel(alg_cr.v, cryp->base + STARFIVE_ALG_CR_OFFSET);
 
-	rctx->csr.hash.v = 0;
-	rctx->csr.hash.mode = ctx->hash_mode;
-	rctx->csr.hash.ie = 1;
+	writel(sg_dma_len(sg), cryp->base + STARFIVE_DMA_IN_LEN_OFFSET);
+	sg_dma_len(sg) = ALIGN(sg_dma_len(sg), sizeof(u32));
 
-	if (ctx->is_hmac) {
-		ret = starfive_hash_hmac_key(ctx);
-		if (ret)
-			return ret;
-	} else {
-		rctx->csr.hash.start = 1;
-		rctx->csr.hash.firstb = 1;
-		writel(rctx->csr.hash.v, cryp->base + STARFIVE_HASH_SHACSR);
+	in_desc = dmaengine_prep_slave_sg(cryp->tx, sg, 1, DMA_MEM_TO_DEV,
+					  DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!in_desc) {
+		ret = -EINVAL;
+		goto end;
 	}
 
-	return starfive_hash_xmit_dma(ctx);
+	reinit_completion(&cryp->dma_done);
+	in_desc->callback = starfive_hash_dma_callback;
+	in_desc->callback_param = cryp;
+
+	dmaengine_submit(in_desc);
+	dma_async_issue_pending(cryp->tx);
+
+	if (!wait_for_completion_timeout(&cryp->dma_done,
+					 msecs_to_jiffies(1000)))
+		ret = -ETIMEDOUT;
+
+end:
+	alg_cr.v = 0;
+	alg_cr.clear = 1;
+	writel(alg_cr.v, cryp->base + STARFIVE_ALG_CR_OFFSET);
+
+	return ret;
 }
 
 static int starfive_hash_copy_hash(struct ahash_request *req)
@@ -229,44 +196,56 @@ void starfive_hash_done_task(unsigned long param)
 	crypto_finalize_hash_request(cryp->engine, cryp->req.hreq, err);
 }
 
-static int starfive_hash_check_aligned(struct scatterlist *sg, size_t total, size_t align)
+static int starfive_hash_one_request(struct crypto_engine *engine, void *areq)
 {
-	int len = 0;
-
-	if (!total)
-		return 0;
+	struct ahash_request *req = container_of(areq, struct ahash_request,
+						 base);
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(req));
+	struct starfive_cryp_request_ctx *rctx = ctx->rctx;
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+	struct scatterlist *tsg;
+	int ret, src_nents, i;
 
-	if (!IS_ALIGNED(total, align))
-		return -EINVAL;
+	writel(STARFIVE_HASH_RESET, cryp->base + STARFIVE_HASH_SHACSR);
 
-	while (sg) {
-		if (!IS_ALIGNED(sg->offset, sizeof(u32)))
-			return -EINVAL;
+	if (starfive_hash_wait_busy(ctx))
+		return dev_err_probe(cryp->dev, -ETIMEDOUT, "Error resetting hardware.\n");
 
-		if (!IS_ALIGNED(sg->length, align))
-			return -EINVAL;
+	rctx->csr.hash.v = 0;
+	rctx->csr.hash.mode = ctx->hash_mode;
 
-		len += sg->length;
-		sg = sg_next(sg);
+	if (ctx->is_hmac) {
+		ret = starfive_hash_hmac_key(ctx);
+		if (ret)
+			return ret;
+	} else {
+		rctx->csr.hash.start = 1;
+		rctx->csr.hash.firstb = 1;
+		writel(rctx->csr.hash.v, cryp->base + STARFIVE_HASH_SHACSR);
 	}
 
-	if (len != total)
-		return -EINVAL;
+	/* No input message, get digest and end. */
+	if (!rctx->total)
+		goto hash_start;
 
-	return 0;
-}
+	starfive_hash_dma_init(cryp);
 
-static int starfive_hash_one_request(struct crypto_engine *engine, void *areq)
-{
-	struct ahash_request *req = container_of(areq, struct ahash_request,
-						 base);
-	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(req));
-	struct starfive_cryp_dev *cryp = ctx->cryp;
+	for_each_sg(rctx->in_sg, tsg, rctx->in_sg_len, i) {
+		src_nents = dma_map_sg(cryp->dev, tsg, 1, DMA_TO_DEVICE);
+		if (src_nents == 0)
+			return dev_err_probe(cryp->dev, -ENOMEM,
+					     "dma_map_sg error\n");
 
-	if (!cryp)
-		return -ENODEV;
+		ret = starfive_hash_dma_xfer(cryp, tsg);
+		dma_unmap_sg(cryp->dev, tsg, 1, DMA_TO_DEVICE);
+		if (ret)
+			return ret;
+	}
+
+hash_start:
+	starfive_hash_start(cryp);
 
-	return starfive_hash_xmit(ctx);
+	return 0;
 }
 
 static int starfive_hash_init(struct ahash_request *req)
@@ -337,22 +316,6 @@ static int starfive_hash_finup(struct ahash_request *req)
 	return crypto_ahash_finup(&rctx->ahash_fbk_req);
 }
 
-static int starfive_hash_digest_fb(struct ahash_request *req)
-{
-	struct starfive_cryp_request_ctx *rctx = ahash_request_ctx(req);
-	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
-	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(tfm);
-
-	ahash_request_set_tfm(&rctx->ahash_fbk_req, ctx->ahash_fbk);
-	ahash_request_set_callback(&rctx->ahash_fbk_req, req->base.flags,
-				   req->base.complete, req->base.data);
-
-	ahash_request_set_crypt(&rctx->ahash_fbk_req, req->src,
-				req->result, req->nbytes);
-
-	return crypto_ahash_digest(&rctx->ahash_fbk_req);
-}
-
 static int starfive_hash_digest(struct ahash_request *req)
 {
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
@@ -370,9 +333,6 @@ static int starfive_hash_digest(struct ahash_request *req)
 	rctx->in_sg_len = sg_nents_for_len(rctx->in_sg, rctx->total);
 	ctx->rctx = rctx;
 
-	if (starfive_hash_check_aligned(rctx->in_sg, rctx->total, rctx->blksize))
-		return starfive_hash_digest_fb(req);
-
 	return crypto_transfer_hash_request_to_engine(cryp->engine, req);
 }
 
@@ -406,7 +366,8 @@ static int starfive_hash_import(struct ahash_request *req, const void *in)
 
 static int starfive_hash_init_tfm(struct crypto_ahash *hash,
 				  const char *alg_name,
-				  unsigned int mode)
+				  unsigned int mode,
+				  bool is_hmac)
 {
 	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(hash);
 
@@ -426,7 +387,7 @@ static int starfive_hash_init_tfm(struct crypto_ahash *hash,
 	crypto_ahash_set_reqsize(hash, sizeof(struct starfive_cryp_request_ctx) +
 				 crypto_ahash_reqsize(ctx->ahash_fbk));
 
-	ctx->keylen = 0;
+	ctx->is_hmac = is_hmac;
 	ctx->hash_mode = mode;
 
 	return 0;
@@ -529,81 +490,61 @@ static int starfive_hash_setkey(struct crypto_ahash *hash,
 static int starfive_sha224_init_tfm(struct crypto_ahash *hash)
 {
 	return starfive_hash_init_tfm(hash, "sha224-generic",
-				      STARFIVE_HASH_SHA224);
+				      STARFIVE_HASH_SHA224, 0);
 }
 
 static int starfive_sha256_init_tfm(struct crypto_ahash *hash)
 {
 	return starfive_hash_init_tfm(hash, "sha256-generic",
-				      STARFIVE_HASH_SHA256);
+				      STARFIVE_HASH_SHA256, 0);
 }
 
 static int starfive_sha384_init_tfm(struct crypto_ahash *hash)
 {
 	return starfive_hash_init_tfm(hash, "sha384-generic",
-				      STARFIVE_HASH_SHA384);
+				      STARFIVE_HASH_SHA384, 0);
 }
 
 static int starfive_sha512_init_tfm(struct crypto_ahash *hash)
 {
 	return starfive_hash_init_tfm(hash, "sha512-generic",
-				      STARFIVE_HASH_SHA512);
+				      STARFIVE_HASH_SHA512, 0);
 }
 
 static int starfive_sm3_init_tfm(struct crypto_ahash *hash)
 {
 	return starfive_hash_init_tfm(hash, "sm3-generic",
-				      STARFIVE_HASH_SM3);
+				      STARFIVE_HASH_SM3, 0);
 }
 
 static int starfive_hmac_sha224_init_tfm(struct crypto_ahash *hash)
 {
-	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(hash);
-
-	ctx->is_hmac = true;
-
 	return starfive_hash_init_tfm(hash, "hmac(sha224-generic)",
-				      STARFIVE_HASH_SHA224);
+				      STARFIVE_HASH_SHA224, 1);
 }
 
 static int starfive_hmac_sha256_init_tfm(struct crypto_ahash *hash)
 {
-	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(hash);
-
-	ctx->is_hmac = true;
-
 	return starfive_hash_init_tfm(hash, "hmac(sha256-generic)",
-				      STARFIVE_HASH_SHA256);
+				      STARFIVE_HASH_SHA256, 1);
 }
 
 static int starfive_hmac_sha384_init_tfm(struct crypto_ahash *hash)
 {
-	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(hash);
-
-	ctx->is_hmac = true;
-
 	return starfive_hash_init_tfm(hash, "hmac(sha384-generic)",
-				      STARFIVE_HASH_SHA384);
+				      STARFIVE_HASH_SHA384, 1);
 }
 
 static int starfive_hmac_sha512_init_tfm(struct crypto_ahash *hash)
 {
-	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(hash);
-
-	ctx->is_hmac = true;
-
 	return starfive_hash_init_tfm(hash, "hmac(sha512-generic)",
-				      STARFIVE_HASH_SHA512);
+				      STARFIVE_HASH_SHA512, 1);
 }
 
 static int starfive_hmac_sm3_init_tfm(struct crypto_ahash *hash)
 {
-	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(hash);
-
-	ctx->is_hmac = true;
-
 	return starfive_hash_init_tfm(hash, "hmac(sm3-generic)",
-				      STARFIVE_HASH_SM3);
+				      STARFIVE_HASH_SM3, 1);
 }
 
 static struct ahash_engine_alg algs_sha2_sm3[] = {
-- 
2.34.1


