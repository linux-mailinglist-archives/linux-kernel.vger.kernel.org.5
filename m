Return-Path: <linux-kernel+bounces-22699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4604182A1D0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD98E1F25529
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256224F886;
	Wed, 10 Jan 2024 20:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="dGl70YAu"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D8F4EB51;
	Wed, 10 Jan 2024 20:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 8A864100022;
	Wed, 10 Jan 2024 23:12:34 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 8A864100022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1704917554;
	bh=55Pe3iz3+N7osR0qi/8KBcLJYwhPhDWBhQbLG+UeCLM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=dGl70YAuTLbj4i2OhdD1wA80K3811a7AL0bg0aKteGM5pHn3GLk5lX+tNlKswR4om
	 lx27942frAwbVUwszYtcSbW4s0Ya5oN5XNAz88VEgo53lmXfRi3rkEmucTLEHBDcDa
	 qIh8pB6CgTE8V5ibAJChM++ZTVYDMi+0Rn2mzBG59u4tB2DVDpcbOx9ucN0Zr2RRCc
	 13C4lVDM0gzr//UZL3CI/eGKUlPmeMevbqDf/eFwYqMDMfkLSCvv6TIZ4obLE53ioN
	 ZKxIJ3madykb2qt8Xowga6CiEhz6MRmSgBZoUCUwEqJ3uZQa1EF/l+c8SgQr5yCvGw
	 q8vljAOuVXq0Q==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 10 Jan 2024 23:12:34 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 23:12:33 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <narmstrong@baylibre.com>, <neil.armstrong@linaro.org>,
	<clabbe@baylibre.com>, <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <khilman@baylibre.com>, <jbrunet@baylibre.com>,
	<artin.blumenstingl@googlemail.com>
CC: <linux-crypto@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kernel@salutedevices.com>, Jan
 Dakinevich <yvdakinevich@salutedevices.com>, Alexey Romanov
	<avromanov@salutedevices.com>
Subject: [PATCH v1 09/24] drivers: crypto: meson: process more than MAXDESCS descriptors
Date: Wed, 10 Jan 2024 23:11:25 +0300
Message-ID: <20240110201216.18016-10-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240110201216.18016-1-avromanov@salutedevices.com>
References: <20240110201216.18016-1-avromanov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 182544 [Jan 10 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;100.64.160.123:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/01/10 17:01:00 #23071477
X-KSMG-AntiVirus-Status: Clean, skipped

From: Jan Dakinevich <yvdakinevich@salutedevices.com>

1. The old alhorithm was not designed to process a large
amount of memory, and therefore gave incorrect results.

2. Not all Amlogic SoC's use 3 KEY/IV descriptors.
Add keyiv descriptors count parameter to platform data.

Signed-off-by: Jan Dakinevich <yvdakinevich@salutedevices.com>
Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 drivers/crypto/amlogic/amlogic-gxl-cipher.c | 443 ++++++++++++--------
 drivers/crypto/amlogic/amlogic-gxl-core.c   |   1 +
 drivers/crypto/amlogic/amlogic-gxl.h        |   2 +
 3 files changed, 281 insertions(+), 165 deletions(-)

diff --git a/drivers/crypto/amlogic/amlogic-gxl-cipher.c b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
index 389f6aea7c25..59b1c754d326 100644
--- a/drivers/crypto/amlogic/amlogic-gxl-cipher.c
+++ b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
@@ -17,35 +17,41 @@
 #include <crypto/internal/skcipher.h>
 #include "amlogic-gxl.h"
 
-static bool meson_cipher_need_fallback(struct skcipher_request *areq)
+static bool meson_cipher_need_fallback_sg(struct skcipher_request *areq,
+					  struct scatterlist *sg)
 {
-	struct scatterlist *src_sg = areq->src;
-	struct scatterlist *dst_sg = areq->dst;
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(areq);
+	unsigned int blocksize = crypto_skcipher_blocksize(tfm);
+	unsigned int cryptlen = areq->cryptlen;
+
+	while (cryptlen) {
+		unsigned int len = min(cryptlen, sg->length);
+
+		if (!IS_ALIGNED(sg->offset, sizeof(u32)))
+			return true;
+		if (len % blocksize != 0)
+			return true;
+
+		cryptlen -= len;
+		sg = sg_next(sg);
+	}
+
+	return false;
+}
 
+static bool meson_cipher_need_fallback(struct skcipher_request *areq)
+{
 	if (areq->cryptlen == 0)
 		return true;
 
-	if (sg_nents(src_sg) != sg_nents(dst_sg))
+	if (meson_cipher_need_fallback_sg(areq, areq->src))
 		return true;
 
-	/* KEY/IV descriptors use 3 desc */
-	if (sg_nents(src_sg) > MAXDESC - 3 || sg_nents(dst_sg) > MAXDESC - 3)
-		return true;
+	if (areq->dst == areq->src)
+		return false;
 
-	while (src_sg && dst_sg) {
-		if ((src_sg->length % 16) != 0)
-			return true;
-		if ((dst_sg->length % 16) != 0)
-			return true;
-		if (src_sg->length != dst_sg->length)
-			return true;
-		if (!IS_ALIGNED(src_sg->offset, sizeof(u32)))
-			return true;
-		if (!IS_ALIGNED(dst_sg->offset, sizeof(u32)))
-			return true;
-		src_sg = sg_next(src_sg);
-		dst_sg = sg_next(dst_sg);
-	}
+	if (meson_cipher_need_fallback_sg(areq, areq->dst))
+		return true;
 
 	return false;
 }
@@ -76,6 +82,211 @@ static int meson_cipher_do_fallback(struct skcipher_request *areq)
 	return err;
 }
 
+struct cipher_ctx {
+	struct {
+		dma_addr_t addr;
+		unsigned int len;
+	} keyiv;
+
+	struct skcipher_request *areq;
+	struct scatterlist *src_sg;
+	struct scatterlist *dst_sg;
+
+	unsigned int src_offset;
+	unsigned int dst_offset;
+	unsigned int cryptlen;
+	unsigned int tloffset;
+};
+
+static int meson_map_scatterlist(struct skcipher_request *areq, struct meson_dev *mc)
+{
+	int nr_sgs, nr_sgd;
+
+	if (areq->src == areq->dst) {
+		nr_sgs = dma_map_sg(mc->dev, areq->src, sg_nents(areq->src),
+							DMA_BIDIRECTIONAL);
+		if (!nr_sgs) {
+			dev_err(mc->dev, "Invalid SG count %d\n", nr_sgs);
+			return -EINVAL;
+		}
+	} else {
+		nr_sgs = dma_map_sg(mc->dev, areq->src, sg_nents(areq->src),
+							DMA_TO_DEVICE);
+		if (!nr_sgs) {
+			dev_err(mc->dev, "Invalid SG count %d\n", nr_sgs);
+			return -EINVAL;
+		}
+
+		nr_sgd = dma_map_sg(mc->dev, areq->dst, sg_nents(areq->dst),
+							DMA_FROM_DEVICE);
+		if (!nr_sgd) {
+			dev_err(mc->dev, "Invalid SG count %d\n", nr_sgd);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static void meson_unmap_scatterlist(struct skcipher_request *areq, struct meson_dev *mc)
+{
+	if (areq->src == areq->dst) {
+		dma_unmap_sg(mc->dev, areq->src, sg_nents(areq->src), DMA_BIDIRECTIONAL);
+	} else {
+		dma_unmap_sg(mc->dev, areq->src, sg_nents(areq->src), DMA_TO_DEVICE);
+		dma_unmap_sg(mc->dev, areq->dst, sg_nents(areq->dst), DMA_FROM_DEVICE);
+	}
+}
+
+static void meson_setup_keyiv_descs(struct cipher_ctx *ctx)
+{
+	struct meson_cipher_req_ctx *rctx = skcipher_request_ctx(ctx->areq);
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(ctx->areq);
+	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
+	struct meson_alg_template *algt = container_of(alg,
+		struct meson_alg_template, alg.skcipher);
+	struct meson_cipher_tfm_ctx *op = crypto_skcipher_ctx(tfm);
+	struct meson_dev *mc = op->mc;
+	unsigned int ivsize = crypto_skcipher_ivsize(tfm);
+	unsigned int blockmode = algt->blockmode;
+	int i;
+
+	if (ctx->tloffset)
+		return;
+
+	if (blockmode == DESC_OPMODE_CBC) {
+		memcpy(op->key + AES_MAX_KEY_SIZE, ctx->areq->iv, ivsize);
+		ctx->keyiv.len = AES_MAX_KEY_SIZE + ivsize;
+		dma_sync_single_for_device(mc->dev, ctx->keyiv.addr,
+					   ctx->keyiv.len, DMA_TO_DEVICE);
+	}
+
+	for (i = 0; i < mc->pdata->setup_desc_cnt; i++) {
+		struct meson_desc *desc =
+			&mc->chanlist[rctx->flow].tl[ctx->tloffset];
+		int offset = i * 16;
+
+		desc->t_src = cpu_to_le32(ctx->keyiv.addr + offset);
+		desc->t_dst = cpu_to_le32(offset);
+		desc->t_status = cpu_to_le32(DESC_OWN | DESC_MODE_KEY | ctx->keyiv.len);
+
+		ctx->tloffset++;
+	}
+}
+
+static bool meson_setup_data_descs(struct cipher_ctx *ctx)
+{
+	struct meson_cipher_req_ctx *rctx = skcipher_request_ctx(ctx->areq);
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(ctx->areq);
+	struct meson_cipher_tfm_ctx *op = crypto_skcipher_ctx(tfm);
+	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
+	struct meson_alg_template *algt = container_of(alg,
+						       struct meson_alg_template,
+						       alg.skcipher);
+	struct meson_dev *mc = op->mc;
+	struct meson_desc *desc = &mc->chanlist[rctx->flow].tl[ctx->tloffset];
+	unsigned int blocksize = crypto_skcipher_blocksize(tfm);
+	unsigned int blockmode = algt->blockmode;
+	unsigned int maxlen = rounddown(DESC_MAXLEN, blocksize);
+	unsigned int todo;
+	u32 v;
+
+	ctx->tloffset++;
+
+	todo = min(ctx->cryptlen, maxlen);
+	todo = min(todo, ctx->cryptlen);
+	todo = min(todo, sg_dma_len(ctx->src_sg) - ctx->src_offset);
+	todo = min(todo, sg_dma_len(ctx->dst_sg) - ctx->dst_offset);
+
+	desc->t_src = cpu_to_le32(sg_dma_address(ctx->src_sg) + ctx->src_offset);
+	desc->t_dst = cpu_to_le32(sg_dma_address(ctx->dst_sg) + ctx->dst_offset);
+
+	ctx->cryptlen -= todo;
+	ctx->src_offset += todo;
+	ctx->dst_offset += todo;
+
+	v = DESC_OWN | blockmode | op->keymode | todo;
+	if (rctx->op_dir == MESON_ENCRYPT)
+		v |= DESC_ENCRYPTION;
+
+	if (!ctx->cryptlen || ctx->tloffset == MAXDESC)
+		v |= DESC_LAST;
+
+	desc->t_status = cpu_to_le32(v);
+
+	return v & DESC_LAST;
+}
+
+static int meson_kick_hardware(struct cipher_ctx *ctx)
+{
+	struct meson_cipher_req_ctx *rctx = skcipher_request_ctx(ctx->areq);
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(ctx->areq);
+	struct meson_cipher_tfm_ctx *op = crypto_skcipher_ctx(tfm);
+	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
+	struct meson_alg_template *algt = container_of(alg,
+						       struct meson_alg_template,
+						       alg.skcipher);
+	struct meson_dev *mc = op->mc;
+	unsigned int ivsize = crypto_skcipher_ivsize(tfm);
+	unsigned int blockmode = algt->blockmode;
+	enum dma_data_direction new_iv_dir;
+	dma_addr_t new_iv_phys;
+	void *new_iv;
+	int err;
+
+	if (blockmode == DESC_OPMODE_CBC) {
+		struct scatterlist *sg;
+		unsigned int offset;
+
+		if (rctx->op_dir == MESON_ENCRYPT) {
+			sg = ctx->dst_sg;
+			offset = ctx->dst_offset;
+			new_iv_dir = DMA_FROM_DEVICE;
+		} else {
+			sg = ctx->src_sg;
+			offset = ctx->src_offset;
+			new_iv_dir = DMA_TO_DEVICE;
+		}
+
+		if (ctx->areq->src == ctx->areq->dst)
+			new_iv_dir = DMA_BIDIRECTIONAL;
+
+		offset -= ivsize;
+		new_iv = sg_virt(sg) + offset;
+		new_iv_phys = sg_dma_address(sg) + offset;
+	}
+
+	if (blockmode == DESC_OPMODE_CBC &&
+		rctx->op_dir == MESON_DECRYPT) {
+		dma_sync_single_for_cpu(mc->dev, new_iv_phys,
+					ivsize, new_iv_dir);
+		memcpy(ctx->areq->iv, new_iv, ivsize);
+	}
+
+	reinit_completion(&mc->chanlist[rctx->flow].complete);
+	meson_dma_start(mc, rctx->flow);
+	err = wait_for_completion_interruptible_timeout(
+			&mc->chanlist[rctx->flow].complete, msecs_to_jiffies(500));
+	if (err == 0) {
+		dev_err(mc->dev, "DMA timeout for flow %d\n", rctx->flow);
+		return -EINVAL;
+	} else if (err < 0) {
+		dev_err(mc->dev, "Waiting for DMA completion is failed (%d)\n", err);
+		return err;
+	}
+
+	if (blockmode == DESC_OPMODE_CBC &&
+		rctx->op_dir == MESON_ENCRYPT) {
+		dma_sync_single_for_cpu(mc->dev, new_iv_phys,
+					ivsize, new_iv_dir);
+		memcpy(ctx->areq->iv, new_iv, ivsize);
+	}
+
+	ctx->tloffset = 0;
+
+	return 0;
+}
+
 static int meson_cipher(struct skcipher_request *areq)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(areq);
@@ -84,176 +295,78 @@ static int meson_cipher(struct skcipher_request *areq)
 	struct meson_dev *mc = op->mc;
 	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
 	struct meson_alg_template *algt;
-	int flow = rctx->flow;
-	unsigned int todo, eat, len;
-	struct scatterlist *src_sg = areq->src;
-	struct scatterlist *dst_sg = areq->dst;
-	struct meson_desc *desc;
-	int nr_sgs, nr_sgd;
-	int i, err = 0;
-	unsigned int keyivlen, ivsize, offset, tloffset;
-	dma_addr_t phykeyiv;
-	void *backup_iv = NULL, *bkeyiv;
-	u32 v;
-
-	algt = container_of(alg, struct meson_alg_template, alg.skcipher);
+	struct cipher_ctx ctx = {
+		.areq = areq,
+		.src_offset = 0,
+		.dst_offset = 0,
+		.src_sg = areq->src,
+		.dst_sg = areq->dst,
+		.cryptlen = areq->cryptlen,
+	};
+	unsigned int ivsize = crypto_skcipher_ivsize(tfm);
+	int err;
 
-	dev_dbg(mc->dev, "%s %s %u %x IV(%u) key=%u flow=%d\n", __func__,
+	dev_dbg(mc->dev, "%s %s %u %x IV(%u) key=%u ctx.flow=%d\n", __func__,
 		crypto_tfm_alg_name(areq->base.tfm),
 		areq->cryptlen,
 		rctx->op_dir, crypto_skcipher_ivsize(tfm),
-		op->keylen, flow);
+		op->keylen, rctx->flow);
+
+	algt = container_of(alg, struct meson_alg_template, alg.skcipher);
 
 #ifdef CONFIG_CRYPTO_DEV_AMLOGIC_GXL_DEBUG
 	algt->stat_req++;
-	mc->chanlist[flow].stat_req++;
+	mc->chanlist[rctx->flow].stat_req++;
 #endif
 
-	/*
-	 * The hardware expect a list of meson_desc structures.
-	 * The 2 first structures store key
-	 * The third stores IV
-	 */
-	bkeyiv = kzalloc(48, GFP_KERNEL | GFP_DMA);
-	if (!bkeyiv)
+	op->key = kzalloc(48, GFP_KERNEL | GFP_DMA);
+	if (!op.key)
 		return -ENOMEM;
 
-	memcpy(bkeyiv, op->key, op->keylen);
-	keyivlen = op->keylen;
+	memcpy(op->key, op->key, op->keylen);
+	ctx.keyiv.len = op->keylen;
+	if (ctx.keyiv.len == AES_KEYSIZE_192)
+		ctx.keyiv.len = AES_MAX_KEY_SIZE;
 
-	ivsize = crypto_skcipher_ivsize(tfm);
-	if (areq->iv && ivsize > 0) {
-		if (ivsize > areq->cryptlen) {
-			dev_err(mc->dev, "invalid ivsize=%d vs len=%d\n", ivsize, areq->cryptlen);
-			err = -EINVAL;
-			goto theend;
-		}
-		memcpy(bkeyiv + 32, areq->iv, ivsize);
-		keyivlen = 48;
-		if (rctx->op_dir == MESON_DECRYPT) {
-			backup_iv = kzalloc(ivsize, GFP_KERNEL);
-			if (!backup_iv) {
-				err = -ENOMEM;
-				goto theend;
-			}
-			offset = areq->cryptlen - ivsize;
-			scatterwalk_map_and_copy(backup_iv, areq->src, offset,
-						 ivsize, 0);
-		}
-	}
-	if (keyivlen == AES_KEYSIZE_192)
-		keyivlen = AES_MAX_KEY_SIZE;
-
-	phykeyiv = dma_map_single(mc->dev, bkeyiv, keyivlen,
+	ctx.keyiv.addr = dma_map_single(mc->dev, op->key, ctx.keyiv.len,
 				  DMA_TO_DEVICE);
-	err = dma_mapping_error(mc->dev, phykeyiv);
+	err = dma_mapping_error(mc->dev, ctx.keyiv.addr);
 	if (err) {
 		dev_err(mc->dev, "Cannot DMA MAP KEY IV\n");
 		goto theend;
 	}
 
-	tloffset = 0;
-	eat = 0;
-	i = 0;
-	while (keyivlen > eat) {
-		desc = &mc->chanlist[flow].tl[tloffset];
-		memset(desc, 0, sizeof(struct meson_desc));
-		todo = min(keyivlen - eat, 16u);
-		desc->t_src = cpu_to_le32(phykeyiv + i * 16);
-		desc->t_dst = cpu_to_le32(i * 16);
-		v = DESC_MODE_KEY | DESC_OWN | 16;
-		desc->t_status = cpu_to_le32(v);
-
-		eat += todo;
-		i++;
-		tloffset++;
-	}
-
-	if (areq->src == areq->dst) {
-		nr_sgs = dma_map_sg(mc->dev, areq->src, sg_nents(areq->src),
-				    DMA_BIDIRECTIONAL);
-		if (!nr_sgs) {
-			dev_err(mc->dev, "Invalid SG count %d\n", nr_sgs);
-			err = -EINVAL;
-			goto theend;
-		}
-		nr_sgd = nr_sgs;
-	} else {
-		nr_sgs = dma_map_sg(mc->dev, areq->src, sg_nents(areq->src),
-				    DMA_TO_DEVICE);
-		if (!nr_sgs || nr_sgs > MAXDESC - 3) {
-			dev_err(mc->dev, "Invalid SG count %d\n", nr_sgs);
-			err = -EINVAL;
-			goto theend;
-		}
-		nr_sgd = dma_map_sg(mc->dev, areq->dst, sg_nents(areq->dst),
-				    DMA_FROM_DEVICE);
-		if (!nr_sgd || nr_sgd > MAXDESC - 3) {
-			dev_err(mc->dev, "Invalid SG count %d\n", nr_sgd);
-			err = -EINVAL;
-			goto theend;
-		}
-	}
-
-	src_sg = areq->src;
-	dst_sg = areq->dst;
-	len = areq->cryptlen;
-	while (src_sg) {
-		desc = &mc->chanlist[flow].tl[tloffset];
-		memset(desc, 0, sizeof(struct meson_desc));
-
-		desc->t_src = cpu_to_le32(sg_dma_address(src_sg));
-		desc->t_dst = cpu_to_le32(sg_dma_address(dst_sg));
-		todo = min(len, sg_dma_len(src_sg));
-		v = op->keymode | DESC_OWN | todo | algt->blockmode;
-		if (rctx->op_dir)
-			v |= DESC_ENCRYPTION;
-		len -= todo;
-
-		if (!sg_next(src_sg))
-			v |= DESC_LAST;
-		desc->t_status = cpu_to_le32(v);
-		tloffset++;
-		src_sg = sg_next(src_sg);
-		dst_sg = sg_next(dst_sg);
-	}
+	err = meson_map_scatterlist(areq, mc);
+	if (err)
+		goto theend;
 
-	reinit_completion(&mc->chanlist[flow].complete);
-	meson_dma_start(mc, flow);
+	ctx.tloffset = 0;
 
-	err = wait_for_completion_interruptible_timeout(&mc->chanlist[flow].complete,
-							msecs_to_jiffies(500));
-	if (err == 0) {
-		dev_err(mc->dev, "DMA timeout for flow %d\n", flow);
-		err = -EINVAL;
-	} else if (err < 0) {
-		dev_err(mc->dev, "Waiting for DMA completion is failed (%d)\n", err);
-	} else {
-		/* No error */
-		err = 0;
-	}
+	while (ctx.cryptlen) {
+		meson_setup_keyiv_descs(&ctx);
 
-	dma_unmap_single(mc->dev, phykeyiv, keyivlen, DMA_TO_DEVICE);
+		if (meson_setup_data_descs(&ctx)) {
+			err = meson_kick_hardware(&ctx);
+			if (err)
+				break;
+		}
 
-	if (areq->src == areq->dst) {
-		dma_unmap_sg(mc->dev, areq->src, sg_nents(areq->src), DMA_BIDIRECTIONAL);
-	} else {
-		dma_unmap_sg(mc->dev, areq->src, sg_nents(areq->src), DMA_TO_DEVICE);
-		dma_unmap_sg(mc->dev, areq->dst, sg_nents(areq->dst), DMA_FROM_DEVICE);
-	}
+		if (ctx.src_offset == sg_dma_len(ctx.src_sg)) {
+			ctx.src_offset = 0;
+			ctx.src_sg = sg_next(ctx.src_sg);
+		}
 
-	if (areq->iv && ivsize > 0) {
-		if (rctx->op_dir == MESON_DECRYPT) {
-			memcpy(areq->iv, backup_iv, ivsize);
-		} else {
-			scatterwalk_map_and_copy(areq->iv, areq->dst,
-						 areq->cryptlen - ivsize,
-						 ivsize, 0);
+		if (ctx.dst_offset == sg_dma_len(ctx.dst_sg)) {
+			ctx.dst_offset = 0;
+			ctx.dst_sg = sg_next(ctx.dst_sg);
 		}
 	}
+
+	dma_unmap_single(mc->dev, ctx.keyiv.addr, ctx.keyiv.len, DMA_TO_DEVICE);
+	meson_unmap_scatterlist(areq, mc);
+
 theend:
-	kfree_sensitive(bkeyiv);
-	kfree_sensitive(backup_iv);
+	kfree_sensitive(op->key);
 
 	return err;
 }
diff --git a/drivers/crypto/amlogic/amlogic-gxl-core.c b/drivers/crypto/amlogic/amlogic-gxl-core.c
index 5948c6e90c8e..fe10292b3111 100644
--- a/drivers/crypto/amlogic/amlogic-gxl-core.c
+++ b/drivers/crypto/amlogic/amlogic-gxl-core.c
@@ -192,6 +192,7 @@ void meson_unregister_algs(struct meson_dev *mc, struct meson_alg_template *algs
 static const struct meson_pdata meson_gxl_pdata = {
 	.descs_reg = 0x0,
 	.status_reg = 0x4,
+	.setup_desc_cnt = 3,
 };
 
 static const struct of_device_id meson_crypto_of_match_table[] = {
diff --git a/drivers/crypto/amlogic/amlogic-gxl.h b/drivers/crypto/amlogic/amlogic-gxl.h
index 8e28adc57d39..36628a7a4cf3 100644
--- a/drivers/crypto/amlogic/amlogic-gxl.h
+++ b/drivers/crypto/amlogic/amlogic-gxl.h
@@ -82,10 +82,12 @@ struct meson_flow {
  * struct meson_pdata - SoC series dependent data.
  * @reg_descs:	offset to descriptors register
  * @reg_status:	offset to status register
+ * @setup_desc_cnt:	number of setup descriptor to configure.
  */
 struct meson_pdata {
 	u32 descs_reg;
 	u32 status_reg;
+	u32 setup_desc_cnt;
 };
 
 /*
-- 
2.30.1


