Return-Path: <linux-kernel+bounces-22705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3806582A1E0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D027B25CC8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7583D52F9F;
	Wed, 10 Jan 2024 20:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="OuZ3jFUc"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239014F884;
	Wed, 10 Jan 2024 20:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 677DD100023;
	Wed, 10 Jan 2024 23:12:36 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 677DD100023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1704917556;
	bh=UD+WX+laIpvfPsUGwAMdXF+OKgJsBBcY7eeTcPm3FKI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=OuZ3jFUcT0WY5jFxJ6ldvNSjXahUpkpiRFxObz1lYZi/lG3t6XV76j9KbqDAWILqP
	 UTSA2PI0bzYIKZe1nEQl6ri9gNuM0/UO3rdBxiEbSnN4OvXbyzou4BFYsV9M14tMoT
	 osyRD4WOSyi4tkgK6TWWI0SaUDgvOXJGrjDkSHlk/BbiqwoPB9t1AlZFr6YsQE0Z+W
	 Mpv+OjBj7/E00xuLAX6xiEHmqCaWYrvZfSOvlKKwuHOEiwpRR98c+6l2Gm16QI7XgT
	 F54Qi/+fnsQIAtFQLoutcWeOBsMBiiJZ3L4qASZ09sMGk+stv3T1VVsaz64IdvO4+J
	 IppYIPbXu+j8w==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 10 Jan 2024 23:12:36 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 23:12:35 +0300
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
Subject: [PATCH v1 11/24] drivers: crypto: meson: introduce hasher
Date: Wed, 10 Jan 2024 23:11:27 +0300
Message-ID: <20240110201216.18016-12-avromanov@salutedevices.com>
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

Introduce support for SHA1/SHA224/SHA256 hash algos.
Tested via tcrypt and custom tests.

Signed-off-by: Jan Dakinevich <yvdakinevich@salutedevices.com>
Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 drivers/crypto/amlogic/Makefile             |   2 +-
 drivers/crypto/amlogic/amlogic-gxl-core.c   |  21 +
 drivers/crypto/amlogic/amlogic-gxl-hasher.c | 448 ++++++++++++++++++++
 drivers/crypto/amlogic/amlogic-gxl.h        |  50 +++
 4 files changed, 520 insertions(+), 1 deletion(-)
 create mode 100644 drivers/crypto/amlogic/amlogic-gxl-hasher.c

diff --git a/drivers/crypto/amlogic/Makefile b/drivers/crypto/amlogic/Makefile
index 39057e62c13e..4b6b388b7880 100644
--- a/drivers/crypto/amlogic/Makefile
+++ b/drivers/crypto/amlogic/Makefile
@@ -1,2 +1,2 @@
 obj-$(CONFIG_CRYPTO_DEV_AMLOGIC_GXL) += amlogic-gxl-crypto.o
-amlogic-gxl-crypto-y := amlogic-gxl-core.o amlogic-gxl-cipher.o
+amlogic-gxl-crypto-y := amlogic-gxl-core.o amlogic-gxl-cipher.o amlogic-gxl-hasher.o
diff --git a/drivers/crypto/amlogic/amlogic-gxl-core.c b/drivers/crypto/amlogic/amlogic-gxl-core.c
index fe10292b3111..a2bc9299214a 100644
--- a/drivers/crypto/amlogic/amlogic-gxl-core.c
+++ b/drivers/crypto/amlogic/amlogic-gxl-core.c
@@ -16,6 +16,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <crypto/internal/skcipher.h>
+#include <crypto/internal/hash.h>
 #include <linux/dma-mapping.h>
 
 #include "amlogic-gxl.h"
@@ -166,6 +167,15 @@ int meson_register_algs(struct meson_dev *mc, struct meson_alg_template *algs,
 				return err;
 			}
 			break;
+		case CRYPTO_ALG_TYPE_AHASH:
+			err = crypto_register_ahash(&algs[i].alg.ahash);
+			if (err) {
+				dev_err(mc->dev, "Fail to register %s\n",
+					algs[i].alg.ahash.halg.base.cra_name);
+				meson_unregister_algs(mc, algs, count);
+				return err;
+			}
+			break;
 		}
 		algs[i].mc = mc;
 	}
@@ -185,6 +195,9 @@ void meson_unregister_algs(struct meson_dev *mc, struct meson_alg_template *algs
 		case CRYPTO_ALG_TYPE_SKCIPHER:
 			crypto_unregister_skcipher(&algs[i].alg.skcipher);
 			break;
+		case CRYPTO_ALG_TYPE_AHASH:
+			crypto_unregister_ahash(&algs[i].alg.ahash);
+			break;
 		}
 	}
 }
@@ -242,12 +255,20 @@ static int meson_crypto_probe(struct platform_device *pdev)
 	if (err)
 		goto error_flow;
 
+	err = meson_hasher_register(mc);
+	if (err)
+		goto error_hasher;
+
 #ifdef CONFIG_CRYPTO_DEV_AMLOGIC_GXL_DEBUG
 	mc->dbgfs_dir = debugfs_create_dir("gxl-crypto", NULL);
 	debugfs_create_file("stats", 0444, mc->dbgfs_dir, mc, &meson_debugfs_fops);
 #endif
 
 	return 0;
+
+error_hasher:
+	meson_cipher_unregister(mc);
+
 error_flow:
 	meson_free_chanlist(mc, mc->flow_cnt - 1);
 	return err;
diff --git a/drivers/crypto/amlogic/amlogic-gxl-hasher.c b/drivers/crypto/amlogic/amlogic-gxl-hasher.c
new file mode 100644
index 000000000000..2517fa97af89
--- /dev/null
+++ b/drivers/crypto/amlogic/amlogic-gxl-hasher.c
@@ -0,0 +1,448 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Hardware asynchronous hasher for Amlogic SoC's.
+ *
+ * Copyright (c) 2023, SaluteDevices. All Rights Reserved.
+ *
+ * Author: Jan Dakinevich <yvdakinevich@salutedevices.com>
+ * Author: Alexey Romanov <avromanov@salutedevices.com>
+ */
+
+#include <linux/crypto.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/err.h>
+#include <crypto/internal/hash.h>
+#include <crypto/sha1.h>
+#include <crypto/sha2.h>
+
+#include "amlogic-gxl.h"
+
+static int meson_sha_init(struct ahash_request *req)
+{
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct meson_hasher_tfm_ctx *tctx = crypto_ahash_ctx(tfm);
+	struct meson_hasher_req_ctx *rctx = ahash_request_ctx(req);
+
+	memset(rctx, 0, sizeof(struct meson_hasher_req_ctx));
+
+	rctx->flow = meson_get_engine_number(tctx->mc);
+	rctx->begin_req = true;
+
+	return 0;
+}
+
+static int meson_sha_update(struct ahash_request *req)
+{
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct meson_hasher_tfm_ctx *tctx = crypto_ahash_ctx(tfm);
+	struct meson_hasher_req_ctx *rctx = ahash_request_ctx(req);
+	struct crypto_engine *engine = tctx->mc->chanlist[rctx->flow].engine;
+
+	return crypto_transfer_hash_request_to_engine(engine, req);
+}
+
+static int meson_sha_final(struct ahash_request *req)
+{
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct meson_hasher_tfm_ctx *tctx = crypto_ahash_ctx(tfm);
+	struct meson_hasher_req_ctx *rctx = ahash_request_ctx(req);
+	struct crypto_engine *engine = tctx->mc->chanlist[rctx->flow].engine;
+
+	rctx->final_req = true;
+
+	return crypto_transfer_hash_request_to_engine(engine, req);
+}
+
+static int meson_hasher_req_map(struct ahash_request *req)
+{
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct meson_hasher_tfm_ctx *tctx = crypto_ahash_ctx(tfm);
+	struct meson_dev *mc = tctx->mc;
+	int ret;
+
+	if (!req->nbytes)
+		return 0;
+
+	ret = dma_map_sg(mc->dev, req->src, sg_nents(req->src), DMA_TO_DEVICE);
+	if (!ret) {
+		dev_err(mc->dev, "Cannot DMA MAP request data\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void meson_hasher_req_unmap(struct ahash_request *req)
+{
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct meson_hasher_tfm_ctx *tctx = crypto_ahash_ctx(tfm);
+	struct meson_dev *mc = tctx->mc;
+
+	if (!req->nbytes)
+		return;
+
+	dma_unmap_sg(mc->dev, req->src, sg_nents(req->src), DMA_TO_DEVICE);
+}
+
+struct hasher_ctx {
+	struct crypto_async_request *areq;
+
+	unsigned int tloffset;
+	unsigned int nbytes;
+	unsigned int todo;
+
+	dma_addr_t state_addr;
+	dma_addr_t src_addr;
+	unsigned int src_offset;
+	struct scatterlist *src_sg;
+};
+
+static bool meson_final(struct hasher_ctx *ctx)
+{
+	struct ahash_request *req = ahash_request_cast(ctx->areq);
+	struct meson_hasher_req_ctx *rctx = ahash_request_ctx(req);
+
+	return !ctx->nbytes && rctx->final_req;
+}
+
+static int meson_fill_partial_buffer(struct hasher_ctx *ctx, unsigned int len)
+{
+	struct ahash_request *req = ahash_request_cast(ctx->areq);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct meson_hasher_tfm_ctx *tctx = crypto_ahash_ctx(tfm);
+	struct meson_hasher_req_ctx *rctx = ahash_request_ctx(req);
+	struct meson_dev *mc = tctx->mc;
+	unsigned int blocksize = crypto_ahash_blocksize(tfm);
+	unsigned int copy;
+
+	if (len) {
+		copy = min(blocksize - rctx->partial_size, len);
+		memcpy(rctx->partial + rctx->partial_size,
+				sg_virt(ctx->src_sg) + ctx->src_offset, copy);
+
+		rctx->partial_size += copy;
+		ctx->nbytes -= copy;
+		ctx->src_offset += copy;
+	}
+
+	if (rctx->partial_size == blocksize || meson_final(ctx)) {
+		rctx->partial_addr = dma_map_single(mc->dev,
+						   rctx->partial,
+						   rctx->partial_size,
+						   DMA_TO_DEVICE);
+		if (dma_mapping_error(mc->dev, rctx->partial_addr)) {
+			dev_err(mc->dev, "Cannot DMA MAP SHA partial buffer\n");
+			return -ENOMEM;
+		}
+
+		rctx->partial_mapped = true;
+		ctx->todo = rctx->partial_size;
+		ctx->src_addr = rctx->partial_addr;
+	}
+
+	return 0;
+}
+
+static unsigned int meson_setup_data_descs(struct hasher_ctx *ctx)
+{
+	struct ahash_request *req = ahash_request_cast(ctx->areq);
+	struct meson_hasher_req_ctx *rctx = ahash_request_ctx(req);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct meson_hasher_tfm_ctx *tctx = crypto_ahash_ctx(tfm);
+	struct meson_dev *mc = tctx->mc;
+	struct meson_flow *flow = &mc->chanlist[rctx->flow];
+	struct hash_alg_common *alg = crypto_hash_alg_common(tfm);
+	struct meson_alg_template *algt = container_of(alg,
+		struct meson_alg_template, alg.ahash.halg);
+	struct meson_desc *desc = &flow->tl[ctx->tloffset];
+	u32 v;
+
+	ctx->tloffset++;
+
+	v = DESC_OWN | DESC_ENCRYPTION | DESC_OPMODE_SHA |
+	    ctx->todo | algt->blockmode;
+	if (rctx->begin_req) {
+		rctx->begin_req = false;
+		v |= DESC_BEGIN;
+	}
+
+	if (!ctx->nbytes && rctx->final_req) {
+		rctx->final_req = false;
+		v |= DESC_END;
+	}
+
+	if (!ctx->nbytes || ctx->tloffset == MAXDESC || rctx->partial_mapped)
+		v |= DESC_LAST;
+
+	desc->t_src = cpu_to_le32(ctx->src_addr);
+	desc->t_dst = cpu_to_le32(ctx->state_addr);
+	desc->t_status = cpu_to_le32(v);
+
+	return v & DESC_LAST;
+}
+
+static int meson_kick_hardware(struct hasher_ctx *ctx)
+{
+	struct ahash_request *req = ahash_request_cast(ctx->areq);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct meson_hasher_req_ctx *rctx = ahash_request_ctx(req);
+	struct meson_hasher_tfm_ctx *tctx = crypto_ahash_ctx(tfm);
+	struct meson_dev *mc = tctx->mc;
+	struct meson_flow *flow = &mc->chanlist[rctx->flow];
+	int ret;
+
+	reinit_completion(&flow->complete);
+	meson_dma_start(mc, rctx->flow);
+
+	ret = wait_for_completion_timeout(&flow->complete,
+					  msecs_to_jiffies(500));
+	if (ret == 0) {
+		dev_err(mc->dev, "DMA timeout for flow %d\n", rctx->flow);
+		return -EINVAL;
+	} else if (ret < 0) {
+		dev_err(mc->dev, "Waiting for DMA completion is failed (%d)\n", ret);
+		return ret;
+	}
+
+	if (rctx->partial_mapped) {
+		dma_unmap_single(mc->dev, rctx->partial_addr,
+				 rctx->partial_size,
+				 DMA_TO_DEVICE);
+		rctx->partial_size = 0;
+		rctx->partial_mapped = false;
+	}
+
+	ctx->tloffset = 0;
+
+	return 0;
+}
+
+static void meson_setup_state_descs(struct hasher_ctx *ctx)
+{
+	struct ahash_request *req = ahash_request_cast(ctx->areq);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct meson_hasher_req_ctx *rctx = ahash_request_ctx(req);
+	struct meson_hasher_tfm_ctx *tctx = crypto_ahash_ctx(tfm);
+	struct meson_dev *mc = tctx->mc;
+	struct meson_desc *desc;
+	int i;
+
+	if (ctx->tloffset || rctx->begin_req)
+		return;
+
+	for (i = 0; i < mc->pdata->setup_desc_cnt; i++) {
+		int offset = i * 16;
+
+		desc = &mc->chanlist[rctx->flow].tl[ctx->tloffset];
+		desc->t_src = cpu_to_le32(ctx->state_addr + offset);
+		desc->t_dst = cpu_to_le32(offset);
+		desc->t_status = cpu_to_le32(MESON_SHA_BUFFER_SIZE |
+					     DESC_MODE_KEY | DESC_OWN);
+
+		ctx->tloffset++;
+	}
+}
+
+static int meson_hasher_do_one_request(struct crypto_engine *engine, void *areq)
+{
+	struct ahash_request *req = ahash_request_cast(areq);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct meson_hasher_tfm_ctx *tctx = crypto_ahash_ctx(tfm);
+	struct meson_hasher_req_ctx *rctx = ahash_request_ctx(req);
+	struct meson_dev *mc = tctx->mc;
+	struct hasher_ctx ctx = {
+		.tloffset = 0,
+		.src_offset = 0,
+		.nbytes = req->nbytes,
+		.src_sg = req->src,
+		.areq = areq,
+	};
+	unsigned int blocksize = crypto_ahash_blocksize(tfm);
+	unsigned int digest_size = crypto_ahash_digestsize(tfm);
+	bool final_req = rctx->final_req;
+	int ret;
+
+	ctx.state_addr = dma_map_single(mc->dev, rctx->state,
+			   sizeof(rctx->state), DMA_BIDIRECTIONAL);
+	ret = dma_mapping_error(mc->dev, ctx.state_addr);
+	if (ret) {
+		dev_err(mc->dev, "Cannot DMA MAP SHA state buffer");
+		goto fail_map_single;
+	}
+
+	ret = meson_hasher_req_map(req);
+	if (ret)
+		goto fail_map_req;
+
+	for (;;) {
+		unsigned int len = ctx.src_sg ?
+			min(sg_dma_len(ctx.src_sg) - ctx.src_offset, ctx.nbytes) : 0;
+
+		ctx.src_addr = 0;
+		ctx.todo = 0;
+
+		if (!rctx->final_req && !ctx.nbytes)
+			break;
+
+		meson_setup_state_descs(&ctx);
+
+		if (rctx->partial_size && rctx->partial_size < blocksize) {
+			ret = meson_fill_partial_buffer(&ctx, len);
+			if (ret)
+				goto fail;
+		} else if (len && len < blocksize) {
+			memcpy(rctx->partial, sg_virt(ctx.src_sg) + ctx.src_offset, len);
+
+			rctx->partial_size = len;
+			ctx.nbytes -= len;
+			ctx.src_offset += len;
+		} else if (len) {
+			ctx.src_addr = sg_dma_address(ctx.src_sg) + ctx.src_offset;
+			ctx.todo = min(rounddown(DESC_MAXLEN, blocksize),
+					rounddown(len, blocksize));
+			ctx.nbytes -= ctx.todo;
+			ctx.src_offset += ctx.todo;
+		}
+
+		if (ctx.src_sg && ctx.src_offset == sg_dma_len(ctx.src_sg)) {
+			ctx.src_offset = 0;
+			ctx.src_sg = sg_next(ctx.src_sg);
+		}
+
+		if (!ctx.todo && ctx.nbytes)
+			continue;
+
+		if (!ctx.todo && !rctx->final_req && !ctx.tloffset)
+			continue;
+
+		if (meson_setup_data_descs(&ctx)) {
+			ret = meson_kick_hardware(&ctx);
+			if (ret)
+				goto fail;
+		}
+	}
+
+fail:
+	meson_hasher_req_unmap(req);
+
+fail_map_req:
+	dma_unmap_single(mc->dev, ctx.state_addr, sizeof(rctx->state),
+			 DMA_BIDIRECTIONAL);
+
+fail_map_single:
+	if (final_req && ret == 0)
+		memcpy(req->result, rctx->state, digest_size);
+
+	local_bh_disable();
+	crypto_finalize_hash_request(engine, req, ret);
+	local_bh_enable();
+
+	return ret;
+}
+
+static int meson_hasher_init(struct crypto_tfm *tfm)
+{
+	struct meson_hasher_tfm_ctx *tctx = crypto_tfm_ctx(tfm);
+	struct crypto_ahash *atfm = __crypto_ahash_cast(tfm);
+	struct hash_alg_common *alg = crypto_hash_alg_common(atfm);
+	struct meson_alg_template *algt = container_of(alg,
+		struct meson_alg_template, alg.ahash.halg);
+
+	crypto_ahash_set_reqsize(atfm, crypto_ahash_statesize(atfm));
+
+	memset(tctx, 0, sizeof(struct meson_hasher_tfm_ctx));
+
+	tctx->mc = algt->mc;
+
+	tctx->enginectx.op.do_one_request = meson_hasher_do_one_request;
+	tctx->enginectx.op.prepare_request = NULL;
+	tctx->enginectx.op.unprepare_request = NULL;
+
+	return 0;
+}
+
+static struct meson_alg_template mc_algs[] = {
+{
+	.type = CRYPTO_ALG_TYPE_AHASH,
+	.blockmode = DESC_MODE_SHA1,
+	.alg.ahash = {
+		.halg = {
+			.base = {
+				.cra_name = "sha1",
+				.cra_driver_name = "sha1-gxl",
+				.cra_priority = 400,
+				.cra_blocksize = SHA1_BLOCK_SIZE,
+				.cra_flags = CRYPTO_ALG_ASYNC,
+				.cra_ctxsize = sizeof(struct meson_hasher_tfm_ctx),
+				.cra_module = THIS_MODULE,
+				.cra_alignmask = 0,
+				.cra_init = meson_hasher_init,
+			},
+			.digestsize = SHA1_DIGEST_SIZE,
+			.statesize = sizeof(struct meson_hasher_req_ctx),
+		},
+		.init = meson_sha_init,
+		.update = meson_sha_update,
+		.final = meson_sha_final,
+	},
+},
+{
+	.type = CRYPTO_ALG_TYPE_AHASH,
+	.blockmode = DESC_MODE_SHA224,
+	.alg.ahash = {
+		.halg = {
+			.base = {
+				.cra_name = "sha224",
+				.cra_driver_name = "sha224-gxl",
+				.cra_priority = 400,
+				.cra_blocksize = SHA224_BLOCK_SIZE,
+				.cra_flags = CRYPTO_ALG_ASYNC,
+				.cra_ctxsize = sizeof(struct meson_hasher_tfm_ctx),
+				.cra_module = THIS_MODULE,
+				.cra_alignmask = 0,
+				.cra_init = meson_hasher_init,
+			},
+			.digestsize = SHA224_DIGEST_SIZE,
+			.statesize = sizeof(struct meson_hasher_req_ctx),
+		},
+		.init = meson_sha_init,
+		.update = meson_sha_update,
+		.final = meson_sha_final,
+	},
+},
+{
+	.type = CRYPTO_ALG_TYPE_AHASH,
+	.blockmode = DESC_MODE_SHA256,
+	.alg.ahash = {
+		.halg = {
+			.base = {
+				.cra_name = "sha256",
+				.cra_driver_name = "sha256-gxl",
+				.cra_priority = 400,
+				.cra_blocksize = SHA256_BLOCK_SIZE,
+				.cra_flags = CRYPTO_ALG_ASYNC,
+				.cra_ctxsize = sizeof(struct meson_hasher_tfm_ctx),
+				.cra_module = THIS_MODULE,
+				.cra_alignmask = 0,
+				.cra_init = meson_hasher_init,
+			},
+			.digestsize = SHA256_DIGEST_SIZE,
+			.statesize = sizeof(struct meson_hasher_req_ctx),
+		},
+		.init = meson_sha_init,
+		.update = meson_sha_update,
+		.final = meson_sha_final,
+	},
+},
+};
+
+int meson_hasher_register(struct meson_dev *mc)
+{
+	return meson_register_algs(mc, mc_algs, ARRAY_SIZE(mc_algs));
+}
+
+void meson_hasher_unregister(struct meson_dev *mc)
+{
+	meson_unregister_algs(mc, mc_algs, ARRAY_SIZE(mc_algs));
+}
diff --git a/drivers/crypto/amlogic/amlogic-gxl.h b/drivers/crypto/amlogic/amlogic-gxl.h
index 2eeafdca1669..5d80471f6a6a 100644
--- a/drivers/crypto/amlogic/amlogic-gxl.h
+++ b/drivers/crypto/amlogic/amlogic-gxl.h
@@ -5,6 +5,7 @@
  * Copyright (C) 2018-2019 Corentin LABBE <clabbe@baylibre.com>
  */
 #include <crypto/aes.h>
+#include <crypto/sha2.h>
 #include <crypto/engine.h>
 #include <crypto/skcipher.h>
 #include <linux/debugfs.h>
@@ -23,13 +24,25 @@
 
 #define DESC_OPMODE_ECB (0 << 26)
 #define DESC_OPMODE_CBC (1 << 26)
+#define DESC_OPMODE_SHA (0 << 26)
 
 #define DESC_MAXLEN ((1 << 17) - 1)
 
+#define DESC_MODE_SHA1   (0x5 << 20)
+#define DESC_MODE_SHA224 (0x7 << 20)
+#define DESC_MODE_SHA256 (0x6 << 20)
+
 #define DESC_LAST BIT(18)
+#define DESC_BEGIN BIT(24)
+#define DESC_END BIT(25)
 #define DESC_ENCRYPTION BIT(28)
 #define DESC_OWN BIT(31)
 
+#define MESON_SHA_BUFFER_SIZE (SHA256_DIGEST_SIZE + 16)
+
+#define MESON_SHA_BEGIN BIT(1)
+#define MESON_SHA_FINAL BIT(2)
+
 /*
  * struct meson_desc - Descriptor for DMA operations
  * Note that without datasheet, some are unknown
@@ -143,6 +156,39 @@ struct meson_cipher_tfm_ctx {
 	struct crypto_skcipher *fallback_tfm;
 };
 
+/*
+ * struct meson_hasher_req_ctx - context for a hasher request
+ * @state:		state data
+ * @partial:		partial buffer data. Contains sent data which
+ *			size < blocksize
+ * @partial_size:	size of the partial buffer
+ * @partial_addr:	physical address of partial buffer
+ * @partial_mapped:	indicates is partial buffer currently mapped or not
+ * @flags:		request flags (for example, is this final req or not)
+ * @flow:		the flow to use for this request
+ */
+struct meson_hasher_req_ctx {
+	u8 state[SHA256_DIGEST_SIZE + 16] ____cacheline_aligned;
+	u8 partial[SHA256_BLOCK_SIZE] ____cacheline_aligned;
+	unsigned int partial_size ____cacheline_aligned;
+	dma_addr_t partial_addr;
+	bool partial_mapped;
+
+	bool begin_req;
+	bool final_req;
+	int flow;
+};
+
+/*
+ * struct meson_hasher_tfm_ctx - context for a hasher TFM
+ * @enginectx:		crypto_engine used by this TFM
+ * @mc:			pointer to the private data of driver handling this TFM
+ */
+struct meson_hasher_tfm_ctx {
+	struct crypto_engine_ctx enginectx;
+	struct meson_dev *mc;
+};
+
 /*
  * struct meson_alg_template - crypto_alg template
  * @type:		the CRYPTO_ALG_TYPE for this template
@@ -157,6 +203,7 @@ struct meson_alg_template {
 	u32 blockmode;
 	union {
 		struct skcipher_alg skcipher;
+		struct ahash_alg ahash;
 	} alg;
 	struct meson_dev *mc;
 #ifdef CONFIG_CRYPTO_DEV_AMLOGIC_GXL_DEBUG
@@ -179,3 +226,6 @@ void meson_unregister_algs(struct meson_dev *mc, struct meson_alg_template *algs
 int meson_cipher_register(struct meson_dev *mc);
 void meson_cipher_unregister(struct meson_dev *mc);
 void meson_cipher_debugfs_show(struct seq_file *seq, void *v);
+
+int meson_hasher_register(struct meson_dev *mc);
+void meson_hasher_unregister(struct meson_dev *mc);
-- 
2.30.1


