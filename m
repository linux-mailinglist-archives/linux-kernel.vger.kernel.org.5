Return-Path: <linux-kernel+bounces-2221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 467BC8159CC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 15:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A9271C2188B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 14:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE5630F91;
	Sat, 16 Dec 2023 14:13:15 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F9530F88;
	Sat, 16 Dec 2023 14:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id 3287D24E083;
	Sat, 16 Dec 2023 22:13:08 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 16 Dec
 2023 22:13:08 +0800
Received: from ubuntu.localdomain (161.142.156.108) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 16 Dec
 2023 22:12:59 +0800
From: Jia Jie Ho <jiajie.ho@starfivetech.com>
To: Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller"
	<davem@davemloft.net>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 3/5] crypto: starfive: Use dma for aes requests
Date: Sat, 16 Dec 2023 22:12:32 +0800
Message-ID: <20231216141234.417498-4-jiajie.ho@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231216141234.417498-1-jiajie.ho@starfivetech.com>
References: <20231216141234.417498-1-jiajie.ho@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable

Convert AES module to use dma for data transfers to reduce cpu load and
compatible with future variants.

Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
---
 drivers/crypto/starfive/Kconfig       |   4 +
 drivers/crypto/starfive/jh7110-aes.c  | 583 +++++++++++++++++---------
 drivers/crypto/starfive/jh7110-cryp.c |   9 -
 drivers/crypto/starfive/jh7110-cryp.h |   3 +-
 4 files changed, 392 insertions(+), 207 deletions(-)

diff --git a/drivers/crypto/starfive/Kconfig b/drivers/crypto/starfive/Kc=
onfig
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
diff --git a/drivers/crypto/starfive/jh7110-aes.c b/drivers/crypto/starfi=
ve/jh7110-aes.c
index 1ac15cc4ef3c..151d161459ff 100644
--- a/drivers/crypto/starfive/jh7110-aes.c
+++ b/drivers/crypto/starfive/jh7110-aes.c
@@ -78,7 +78,7 @@ static inline int is_gcm(struct starfive_cryp_dev *cryp=
)
 	return (cryp->flags & FLG_MODE_MASK) =3D=3D STARFIVE_AES_MODE_GCM;
 }
=20
-static inline int is_encrypt(struct starfive_cryp_dev *cryp)
+static inline bool is_encrypt(struct starfive_cryp_dev *cryp)
 {
 	return cryp->flags & FLG_ENCRYPT;
 }
@@ -103,16 +103,6 @@ static void starfive_aes_aead_hw_start(struct starfi=
ve_cryp_ctx *ctx, u32 hw_mod
 	}
 }
=20
-static inline void starfive_aes_set_ivlen(struct starfive_cryp_ctx *ctx)
-{
-	struct starfive_cryp_dev *cryp =3D ctx->cryp;
-
-	if (is_gcm(cryp))
-		writel(GCM_AES_IV_SIZE, cryp->base + STARFIVE_AES_IVLEN);
-	else
-		writel(AES_BLOCK_SIZE, cryp->base + STARFIVE_AES_IVLEN);
-}
-
 static inline void starfive_aes_set_alen(struct starfive_cryp_ctx *ctx)
 {
 	struct starfive_cryp_dev *cryp =3D ctx->cryp;
@@ -261,7 +251,6 @@ static int starfive_aes_hw_init(struct starfive_cryp_=
ctx *ctx)
=20
 	rctx->csr.aes.mode  =3D hw_mode;
 	rctx->csr.aes.cmode =3D !is_encrypt(cryp);
-	rctx->csr.aes.ie =3D 1;
 	rctx->csr.aes.stmode =3D STARFIVE_AES_MODE_XFB_1;
=20
 	if (cryp->side_chan) {
@@ -279,7 +268,7 @@ static int starfive_aes_hw_init(struct starfive_cryp_=
ctx *ctx)
 	case STARFIVE_AES_MODE_GCM:
 		starfive_aes_set_alen(ctx);
 		starfive_aes_set_mlen(ctx);
-		starfive_aes_set_ivlen(ctx);
+		writel(GCM_AES_IV_SIZE, cryp->base + STARFIVE_AES_IVLEN);
 		starfive_aes_aead_hw_start(ctx, hw_mode);
 		starfive_aes_write_iv(ctx, (void *)cryp->req.areq->iv);
 		break;
@@ -300,28 +289,30 @@ static int starfive_aes_hw_init(struct starfive_cry=
p_ctx *ctx)
 	return cryp->err;
 }
=20
-static int starfive_aes_read_authtag(struct starfive_cryp_dev *cryp)
+static int starfive_aes_read_authtag(struct starfive_cryp_ctx *ctx)
 {
-	int i, start_addr;
+	struct starfive_cryp_dev *cryp =3D ctx->cryp;
+	struct starfive_cryp_request_ctx *rctx =3D ctx->rctx;
+	int i;
=20
 	if (starfive_aes_wait_busy(cryp))
 		return dev_err_probe(cryp->dev, -ETIMEDOUT,
 				     "Timeout waiting for tag generation.");
=20
-	start_addr =3D STARFIVE_AES_NONCE0;
-
-	if (is_gcm(cryp))
-		for (i =3D 0; i < AES_BLOCK_32; i++, start_addr +=3D 4)
-			cryp->tag_out[i] =3D readl(cryp->base + start_addr);
-	else
+	if ((cryp->flags & FLG_MODE_MASK) =3D=3D STARFIVE_AES_MODE_GCM) {
+		cryp->tag_out[0] =3D readl(cryp->base + STARFIVE_AES_NONCE0);
+		cryp->tag_out[1] =3D readl(cryp->base + STARFIVE_AES_NONCE1);
+		cryp->tag_out[2] =3D readl(cryp->base + STARFIVE_AES_NONCE2);
+		cryp->tag_out[3] =3D readl(cryp->base + STARFIVE_AES_NONCE3);
+	} else {
 		for (i =3D 0; i < AES_BLOCK_32; i++)
 			cryp->tag_out[i] =3D readl(cryp->base + STARFIVE_AES_AESDIO0R);
+	}
=20
 	if (is_encrypt(cryp)) {
-		scatterwalk_copychunks(cryp->tag_out, &cryp->out_walk, cryp->authsize,=
 1);
+		scatterwalk_map_and_copy(cryp->tag_out, rctx->out_sg,
+					 cryp->total_in, cryp->authsize, 1);
 	} else {
-		scatterwalk_copychunks(cryp->tag_in, &cryp->in_walk, cryp->authsize, 0=
);
-
 		if (crypto_memneq(cryp->tag_in, cryp->tag_out, cryp->authsize))
 			return dev_err_probe(cryp->dev, -EBADMSG, "Failed tag verification\n"=
);
 	}
@@ -329,23 +320,18 @@ static int starfive_aes_read_authtag(struct starfiv=
e_cryp_dev *cryp)
 	return 0;
 }
=20
-static void starfive_aes_finish_req(struct starfive_cryp_dev *cryp)
+static void starfive_aes_finish_req(struct starfive_cryp_ctx *ctx)
 {
-	union starfive_aes_csr csr;
+	struct starfive_cryp_dev *cryp =3D ctx->cryp;
 	int err =3D cryp->err;
=20
 	if (!err && cryp->authsize)
-		err =3D starfive_aes_read_authtag(cryp);
+		err =3D starfive_aes_read_authtag(ctx);
=20
 	if (!err && ((cryp->flags & FLG_MODE_MASK) =3D=3D STARFIVE_AES_MODE_CBC=
 ||
 		     (cryp->flags & FLG_MODE_MASK) =3D=3D STARFIVE_AES_MODE_CTR))
 		starfive_aes_get_iv(cryp, (void *)cryp->req.sreq->iv);
=20
-	/* reset irq flags*/
-	csr.v =3D 0;
-	csr.aesrst =3D 1;
-	writel(csr.v, cryp->base + STARFIVE_AES_CSR);
-
 	if (cryp->authsize)
 		crypto_finalize_aead_request(cryp->engine, cryp->req.areq, err);
 	else
@@ -353,39 +339,6 @@ static void starfive_aes_finish_req(struct starfive_=
cryp_dev *cryp)
 						 err);
 }
=20
-void starfive_aes_done_task(unsigned long param)
-{
-	struct starfive_cryp_dev *cryp =3D (struct starfive_cryp_dev *)param;
-	u32 block[AES_BLOCK_32];
-	u32 stat;
-	int i;
-
-	for (i =3D 0; i < AES_BLOCK_32; i++)
-		block[i] =3D readl(cryp->base + STARFIVE_AES_AESDIO0R);
-
-	scatterwalk_copychunks(block, &cryp->out_walk, min_t(size_t, AES_BLOCK_=
SIZE,
-							     cryp->total_out), 1);
-
-	cryp->total_out -=3D min_t(size_t, AES_BLOCK_SIZE, cryp->total_out);
-
-	if (!cryp->total_out) {
-		starfive_aes_finish_req(cryp);
-		return;
-	}
-
-	memset(block, 0, AES_BLOCK_SIZE);
-	scatterwalk_copychunks(block, &cryp->in_walk, min_t(size_t, AES_BLOCK_S=
IZE,
-							    cryp->total_in), 0);
-	cryp->total_in -=3D min_t(size_t, AES_BLOCK_SIZE, cryp->total_in);
-
-	for (i =3D 0; i < AES_BLOCK_32; i++)
-		writel(block[i], cryp->base + STARFIVE_AES_AESDIO0R);
-
-	stat =3D readl(cryp->base + STARFIVE_IE_MASK_OFFSET);
-	stat &=3D ~STARFIVE_IE_MASK_AES_DONE;
-	writel(stat, cryp->base + STARFIVE_IE_MASK_OFFSET);
-}
-
 static int starfive_aes_gcm_write_adata(struct starfive_cryp_ctx *ctx)
 {
 	struct starfive_cryp_dev *cryp =3D ctx->cryp;
@@ -451,60 +404,165 @@ static int starfive_aes_ccm_write_adata(struct sta=
rfive_cryp_ctx *ctx)
 	return 0;
 }
=20
-static int starfive_aes_prepare_req(struct skcipher_request *req,
-				    struct aead_request *areq)
+static void starfive_aes_dma_done(void *param)
 {
-	struct starfive_cryp_ctx *ctx;
-	struct starfive_cryp_request_ctx *rctx;
-	struct starfive_cryp_dev *cryp;
+	struct starfive_cryp_dev *cryp =3D param;
=20
-	if (!req && !areq)
-		return -EINVAL;
+	complete(&cryp->dma_done);
+}
=20
-	ctx =3D req ? crypto_skcipher_ctx(crypto_skcipher_reqtfm(req)) :
-		    crypto_aead_ctx(crypto_aead_reqtfm(areq));
+static void starfive_aes_dma_init(struct starfive_cryp_dev *cryp)
+{
+	cryp->cfg_in.direction =3D DMA_MEM_TO_DEV;
+	cryp->cfg_in.src_addr_width =3D DMA_SLAVE_BUSWIDTH_16_BYTES;
+	cryp->cfg_in.dst_addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
+	cryp->cfg_in.src_maxburst =3D cryp->dma_maxburst;
+	cryp->cfg_in.dst_maxburst =3D cryp->dma_maxburst;
+	cryp->cfg_in.dst_addr =3D cryp->phys_base + STARFIVE_ALG_FIFO_OFFSET;
=20
-	cryp =3D ctx->cryp;
-	rctx =3D req ? skcipher_request_ctx(req) : aead_request_ctx(areq);
+	dmaengine_slave_config(cryp->tx, &cryp->cfg_in);
=20
-	if (req) {
-		cryp->req.sreq =3D req;
-		cryp->total_in =3D req->cryptlen;
-		cryp->total_out =3D req->cryptlen;
-		cryp->assoclen =3D 0;
-		cryp->authsize =3D 0;
-	} else {
-		cryp->req.areq =3D areq;
-		cryp->assoclen =3D areq->assoclen;
-		cryp->authsize =3D crypto_aead_authsize(crypto_aead_reqtfm(areq));
-		if (is_encrypt(cryp)) {
-			cryp->total_in =3D areq->cryptlen;
-			cryp->total_out =3D areq->cryptlen;
-		} else {
-			cryp->total_in =3D areq->cryptlen - cryp->authsize;
-			cryp->total_out =3D cryp->total_in;
-		}
-	}
+	cryp->cfg_out.direction =3D DMA_DEV_TO_MEM;
+	cryp->cfg_out.src_addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
+	cryp->cfg_out.dst_addr_width =3D DMA_SLAVE_BUSWIDTH_16_BYTES;
+	cryp->cfg_out.src_maxburst =3D 4;
+	cryp->cfg_out.dst_maxburst =3D 4;
+	cryp->cfg_out.src_addr =3D cryp->phys_base + STARFIVE_ALG_FIFO_OFFSET;
=20
-	rctx->in_sg =3D req ? req->src : areq->src;
-	scatterwalk_start(&cryp->in_walk, rctx->in_sg);
+	dmaengine_slave_config(cryp->rx, &cryp->cfg_out);
=20
-	rctx->out_sg =3D req ? req->dst : areq->dst;
-	scatterwalk_start(&cryp->out_walk, rctx->out_sg);
+	init_completion(&cryp->dma_done);
+}
=20
-	if (cryp->assoclen) {
-		rctx->adata =3D kzalloc(cryp->assoclen + AES_BLOCK_SIZE, GFP_KERNEL);
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
+	int ret =3D 0, in_save, out_save;
+
+	alg_cr.v =3D 0;
+	alg_cr.start =3D 1;
+	alg_cr.aes_dma_en =3D 1;
+	writel(alg_cr.v, cryp->base + STARFIVE_ALG_CR_OFFSET);
=20
-		scatterwalk_copychunks(rctx->adata, &cryp->in_walk, cryp->assoclen, 0)=
;
-		scatterwalk_copychunks(NULL, &cryp->out_walk, cryp->assoclen, 2);
+	in_save =3D sg_dma_len(src);
+	out_save =3D sg_dma_len(dst);
+
+	writel(ALIGN(len, AES_BLOCK_SIZE), cryp->base + STARFIVE_DMA_IN_LEN_OFF=
SET);
+	writel(ALIGN(len, AES_BLOCK_SIZE), cryp->base + STARFIVE_DMA_OUT_LEN_OF=
FSET);
+
+	sg_dma_len(src) =3D ALIGN(len, AES_BLOCK_SIZE);
+	sg_dma_len(dst) =3D ALIGN(len, AES_BLOCK_SIZE);
+
+	out_desc =3D dmaengine_prep_slave_sg(cryp->rx, dst, 1, DMA_DEV_TO_MEM,
+					   DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!out_desc) {
+		ret =3D -EINVAL;
+		goto dma_err;
 	}
=20
-	ctx->rctx =3D rctx;
+	out_desc->callback =3D starfive_aes_dma_done;
+	out_desc->callback_param =3D cryp;
+
+	reinit_completion(&cryp->dma_done);
+	dmaengine_submit(out_desc);
+	dma_async_issue_pending(cryp->rx);
+
+	in_desc =3D dmaengine_prep_slave_sg(cryp->tx, src, 1, DMA_MEM_TO_DEV,
+					  DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!in_desc) {
+		ret =3D -EINVAL;
+		goto dma_err;
+	}
+
+	dmaengine_submit(in_desc);
+	dma_async_issue_pending(cryp->tx);
+
+	if (!wait_for_completion_timeout(&cryp->dma_done,
+					 msecs_to_jiffies(1000)))
+		ret =3D -ETIMEDOUT;
=20
-	return starfive_aes_hw_init(ctx);
+dma_err:
+	sg_dma_len(src) =3D in_save;
+	sg_dma_len(dst) =3D out_save;
+
+	alg_cr.v =3D 0;
+	alg_cr.clear =3D 1;
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
+	unsigned int remain =3D cryp->total_in;
+	unsigned int len, src_nents, dst_nents;
+	int ret;
+
+	if (src =3D=3D dst) {
+		for (stsg =3D src, dtsg =3D dst; remain > 0;
+		     stsg =3D sg_next(stsg), dtsg =3D sg_next(dtsg)) {
+			src_nents =3D dma_map_sg(cryp->dev, stsg, 1, DMA_BIDIRECTIONAL);
+			if (src_nents =3D=3D 0)
+				return dev_err_probe(cryp->dev, -ENOMEM,
+						     "dma_map_sg error\n");
+
+			dst_nents =3D src_nents;
+			len =3D min(sg_dma_len(stsg), remain);
+
+			ret =3D starfive_aes_dma_xfer(cryp, stsg, dtsg, len);
+			dma_unmap_sg(cryp->dev, stsg, 1, DMA_BIDIRECTIONAL);
+			if (ret)
+				return ret;
+
+			remain -=3D len;
+		}
+	} else {
+		for (stsg =3D src, dtsg =3D dst;;) {
+			src_nents =3D dma_map_sg(cryp->dev, stsg, 1, DMA_TO_DEVICE);
+			if (src_nents =3D=3D 0)
+				return dev_err_probe(cryp->dev, -ENOMEM,
+						     "dma_map_sg src error\n");
+
+			dst_nents =3D dma_map_sg(cryp->dev, dtsg, 1, DMA_FROM_DEVICE);
+			if (dst_nents =3D=3D 0)
+				return dev_err_probe(cryp->dev, -ENOMEM,
+						     "dma_map_sg dst error\n");
+
+			len =3D min(sg_dma_len(stsg), sg_dma_len(dtsg));
+			len =3D min(len, remain);
+
+			ret =3D starfive_aes_dma_xfer(cryp, stsg, dtsg, len);
+			dma_unmap_sg(cryp->dev, stsg, 1, DMA_TO_DEVICE);
+			dma_unmap_sg(cryp->dev, dtsg, 1, DMA_FROM_DEVICE);
+			if (ret)
+				return ret;
+
+			remain -=3D len;
+			if (remain =3D=3D 0)
+				break;
+
+			if (sg_dma_len(stsg) - len) {
+				stsg =3D scatterwalk_ffwd(_src, stsg, len);
+				dtsg =3D sg_next(dtsg);
+			} else if (sg_dma_len(dtsg) - len) {
+				dtsg =3D scatterwalk_ffwd(_dst, dtsg, len);
+				stsg =3D sg_next(stsg);
+			} else {
+				stsg =3D sg_next(stsg);
+				dtsg =3D sg_next(dtsg);
+			}
+		}
+	}
+
+	return 0;
 }
=20
 static int starfive_aes_do_one_req(struct crypto_engine *engine, void *a=
req)
@@ -513,35 +571,38 @@ static int starfive_aes_do_one_req(struct crypto_en=
gine *engine, void *areq)
 		container_of(areq, struct skcipher_request, base);
 	struct starfive_cryp_ctx *ctx =3D
 		crypto_skcipher_ctx(crypto_skcipher_reqtfm(req));
+	struct starfive_cryp_request_ctx *rctx =3D skcipher_request_ctx(req);
 	struct starfive_cryp_dev *cryp =3D ctx->cryp;
-	u32 block[AES_BLOCK_32];
-	u32 stat;
-	int err;
-	int i;
+	int ret;
=20
-	err =3D starfive_aes_prepare_req(req, NULL);
-	if (err)
-		return err;
+	cryp->req.sreq =3D req;
+	cryp->total_in =3D req->cryptlen;
+	cryp->total_out =3D req->cryptlen;
+	cryp->assoclen =3D 0;
+	cryp->authsize =3D 0;
=20
-	/*
-	 * Write first plain/ciphertext block to start the module
-	 * then let irq tasklet handle the rest of the data blocks.
-	 */
-	scatterwalk_copychunks(block, &cryp->in_walk, min_t(size_t, AES_BLOCK_S=
IZE,
-							    cryp->total_in), 0);
-	cryp->total_in -=3D min_t(size_t, AES_BLOCK_SIZE, cryp->total_in);
+	rctx->in_sg =3D req->src;
+	rctx->out_sg =3D req->dst;
+
+	ctx->rctx =3D rctx;
+
+	ret =3D starfive_aes_hw_init(ctx);
+	if (ret)
+		return ret;
=20
-	for (i =3D 0; i < AES_BLOCK_32; i++)
-		writel(block[i], cryp->base + STARFIVE_AES_AESDIO0R);
+	starfive_aes_dma_init(cryp);
=20
-	stat =3D readl(cryp->base + STARFIVE_IE_MASK_OFFSET);
-	stat &=3D ~STARFIVE_IE_MASK_AES_DONE;
-	writel(stat, cryp->base + STARFIVE_IE_MASK_OFFSET);
+	ret =3D starfive_aes_map_sg(cryp, rctx->in_sg, rctx->out_sg);
+	if (ret)
+		return ret;
+
+	starfive_aes_finish_req(ctx);
=20
 	return 0;
 }
=20
-static int starfive_aes_init_tfm(struct crypto_skcipher *tfm)
+static int starfive_aes_init_tfm(struct crypto_skcipher *tfm,
+				 const char *alg_name)
 {
 	struct starfive_cryp_ctx *ctx =3D crypto_skcipher_ctx(tfm);
=20
@@ -549,12 +610,26 @@ static int starfive_aes_init_tfm(struct crypto_skci=
pher *tfm)
 	if (!ctx->cryp)
 		return -ENODEV;
=20
+	ctx->skcipher_fbk =3D crypto_alloc_skcipher(alg_name, 0,
+						  CRYPTO_ALG_NEED_FALLBACK);
+	if (IS_ERR(ctx->skcipher_fbk))
+		return dev_err_probe(ctx->cryp->dev, PTR_ERR(ctx->skcipher_fbk),
+				     "%s() failed to allocate fallback for %s\n",
+				     __func__, alg_name);
+
 	crypto_skcipher_set_reqsize(tfm, sizeof(struct starfive_cryp_request_ct=
x) +
 				    sizeof(struct skcipher_request));
=20
 	return 0;
 }
=20
+static void starfive_aes_exit_tfm(struct crypto_skcipher *tfm)
+{
+	struct starfive_cryp_ctx *ctx =3D crypto_skcipher_ctx(tfm);
+
+	crypto_free_skcipher(ctx->skcipher_fbk);
+}
+
 static int starfive_aes_aead_do_one_req(struct crypto_engine *engine, vo=
id *areq)
 {
 	struct aead_request *req =3D
@@ -562,76 +637,96 @@ static int starfive_aes_aead_do_one_req(struct cryp=
to_engine *engine, void *areq
 	struct starfive_cryp_ctx *ctx =3D
 		crypto_aead_ctx(crypto_aead_reqtfm(req));
 	struct starfive_cryp_dev *cryp =3D ctx->cryp;
-	struct starfive_cryp_request_ctx *rctx;
-	u32 block[AES_BLOCK_32];
-	u32 stat;
-	int err;
-	int i;
+	struct starfive_cryp_request_ctx *rctx =3D aead_request_ctx(req);
+	struct scatterlist _src[2], _dst[2];
+	int ret;
+
+	cryp->req.areq =3D req;
+	cryp->assoclen =3D req->assoclen;
+	cryp->authsize =3D crypto_aead_authsize(crypto_aead_reqtfm(req));
+
+	rctx->in_sg =3D scatterwalk_ffwd(_src, req->src, cryp->assoclen);
+	if (req->src =3D=3D req->dst)
+		rctx->out_sg =3D rctx->in_sg;
+	else
+		rctx->out_sg =3D scatterwalk_ffwd(_dst, req->dst, cryp->assoclen);
=20
-	err =3D starfive_aes_prepare_req(NULL, req);
-	if (err)
-		return err;
+	if (is_encrypt(cryp)) {
+		cryp->total_in =3D req->cryptlen;
+		cryp->total_out =3D req->cryptlen;
+	} else {
+		cryp->total_in =3D req->cryptlen - cryp->authsize;
+		cryp->total_out =3D cryp->total_in;
+		scatterwalk_map_and_copy(cryp->tag_in, req->src,
+					 cryp->total_in + cryp->assoclen,
+					 cryp->authsize, 0);
+	}
=20
-	rctx =3D ctx->rctx;
+	if (cryp->assoclen) {
+		rctx->adata =3D kzalloc(cryp->assoclen + AES_BLOCK_SIZE, GFP_KERNEL);
+		if (!rctx->adata)
+			return dev_err_probe(cryp->dev, -ENOMEM,
+					     "Failed to alloc memory for adata");
+
+		if (sg_copy_to_buffer(req->src, sg_nents_for_len(req->src, cryp->assoc=
len),
+				      rctx->adata, cryp->assoclen) !=3D cryp->assoclen)
+			return -EINVAL;
+	}
+
+	if (cryp->total_in)
+		sg_zero_buffer(rctx->in_sg, sg_nents(rctx->in_sg),
+			       sg_dma_len(rctx->in_sg) - cryp->total_in,
+			       cryp->total_in);
+
+	ctx->rctx =3D rctx;
+
+	ret =3D starfive_aes_hw_init(ctx);
+	if (ret)
+		return ret;
=20
 	if (!cryp->assoclen)
 		goto write_text;
=20
 	if ((cryp->flags & FLG_MODE_MASK) =3D=3D STARFIVE_AES_MODE_CCM)
-		cryp->err =3D starfive_aes_ccm_write_adata(ctx);
+		ret =3D starfive_aes_ccm_write_adata(ctx);
 	else
-		cryp->err =3D starfive_aes_gcm_write_adata(ctx);
+		ret =3D starfive_aes_gcm_write_adata(ctx);
=20
 	kfree(rctx->adata);
=20
-	if (cryp->err)
-		return cryp->err;
+	if (ret)
+		return ret;
=20
 write_text:
 	if (!cryp->total_in)
 		goto finish_req;
=20
-	/*
-	 * Write first plain/ciphertext block to start the module
-	 * then let irq tasklet handle the rest of the data blocks.
-	 */
-	scatterwalk_copychunks(block, &cryp->in_walk, min_t(size_t, AES_BLOCK_S=
IZE,
-							    cryp->total_in), 0);
-	cryp->total_in -=3D min_t(size_t, AES_BLOCK_SIZE, cryp->total_in);
-
-	for (i =3D 0; i < AES_BLOCK_32; i++)
-		writel(block[i], cryp->base + STARFIVE_AES_AESDIO0R);
+	starfive_aes_dma_init(cryp);
=20
-	stat =3D readl(cryp->base + STARFIVE_IE_MASK_OFFSET);
-	stat &=3D ~STARFIVE_IE_MASK_AES_DONE;
-	writel(stat, cryp->base + STARFIVE_IE_MASK_OFFSET);
-
-	return 0;
+	ret =3D starfive_aes_map_sg(cryp, rctx->in_sg, rctx->out_sg);
+	if (ret)
+		return ret;
=20
 finish_req:
-	starfive_aes_finish_req(cryp);
+	starfive_aes_finish_req(ctx);
 	return 0;
 }
=20
-static int starfive_aes_aead_init_tfm(struct crypto_aead *tfm)
+static int starfive_aes_aead_init_tfm(struct crypto_aead *tfm,
+				      const char *alg_name)
 {
 	struct starfive_cryp_ctx *ctx =3D crypto_aead_ctx(tfm);
-	struct starfive_cryp_dev *cryp =3D ctx->cryp;
-	struct crypto_tfm *aead =3D crypto_aead_tfm(tfm);
-	struct crypto_alg *alg =3D aead->__crt_alg;
=20
 	ctx->cryp =3D starfive_cryp_find_dev(ctx);
 	if (!ctx->cryp)
 		return -ENODEV;
=20
-	if (alg->cra_flags & CRYPTO_ALG_NEED_FALLBACK) {
-		ctx->aead_fbk =3D crypto_alloc_aead(alg->cra_name, 0,
-						  CRYPTO_ALG_NEED_FALLBACK);
-		if (IS_ERR(ctx->aead_fbk))
-			return dev_err_probe(cryp->dev, PTR_ERR(ctx->aead_fbk),
-					     "%s() failed to allocate fallback for %s\n",
-					     __func__, alg->cra_name);
-	}
+	ctx->aead_fbk =3D crypto_alloc_aead(alg_name, 0,
+					  CRYPTO_ALG_NEED_FALLBACK);
+	if (IS_ERR(ctx->aead_fbk))
+		return dev_err_probe(ctx->cryp->dev, PTR_ERR(ctx->aead_fbk),
+				     "%s() failed to allocate fallback for %s\n",
+				     __func__, alg_name);
=20
 	crypto_aead_set_reqsize(tfm, sizeof(struct starfive_cryp_ctx) +
 				sizeof(struct aead_request));
@@ -646,6 +741,44 @@ static void starfive_aes_aead_exit_tfm(struct crypto=
_aead *tfm)
 	crypto_free_aead(ctx->aead_fbk);
 }
=20
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
+	if (src !=3D dst)
+		for_each_sg(dst, tsg, sg_nents(dst), i)
+			if (!IS_ALIGNED(tsg->length, AES_BLOCK_SIZE) &&
+			    !sg_is_last(tsg))
+				return true;
+
+	return false;
+}
+
+static int starfive_aes_do_fallback(struct skcipher_request *req, bool e=
nc)
+{
+	struct starfive_cryp_ctx *ctx =3D
+		crypto_skcipher_ctx(crypto_skcipher_reqtfm(req));
+	struct skcipher_request *subreq =3D skcipher_request_ctx(req);
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
 static int starfive_aes_crypt(struct skcipher_request *req, unsigned lon=
g flags)
 {
 	struct crypto_skcipher *tfm =3D crypto_skcipher_reqtfm(req);
@@ -660,32 +793,54 @@ static int starfive_aes_crypt(struct skcipher_reque=
st *req, unsigned long flags)
 		if (req->cryptlen & blocksize_align)
 			return -EINVAL;
=20
+	if (starfive_aes_check_unaligned(cryp, req->src, req->dst))
+		return starfive_aes_do_fallback(req, is_encrypt(cryp));
+
 	return crypto_transfer_skcipher_request_to_engine(cryp->engine, req);
 }
=20
+static int starfive_aes_aead_do_fallback(struct aead_request *req, bool =
enc)
+{
+	struct starfive_cryp_ctx *ctx =3D
+		crypto_aead_ctx(crypto_aead_reqtfm(req));
+	struct aead_request *subreq =3D aead_request_ctx(req);
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
 static int starfive_aes_aead_crypt(struct aead_request *req, unsigned lo=
ng flags)
 {
 	struct starfive_cryp_ctx *ctx =3D crypto_aead_ctx(crypto_aead_reqtfm(re=
q));
 	struct starfive_cryp_dev *cryp =3D ctx->cryp;
+	struct scatterlist *src, *dst, _src[2], _dst[2];
=20
 	cryp->flags =3D flags;
=20
-	/*
-	 * HW engine could not perform CCM tag verification on
-	 * non-blocksize aligned text, use fallback algo instead
+	/* aes-ccm does not support tag verification for non-aligned text,
+	 * use fallback for ccm decryption instead.
 	 */
-	if (ctx->aead_fbk && !is_encrypt(cryp)) {
-		struct aead_request *subreq =3D aead_request_ctx(req);
+	if (((cryp->flags & FLG_MODE_MASK) =3D=3D STARFIVE_AES_MODE_CCM) &&
+	    !is_encrypt(cryp))
+		return starfive_aes_aead_do_fallback(req, 0);
=20
-		aead_request_set_tfm(subreq, ctx->aead_fbk);
-		aead_request_set_callback(subreq, req->base.flags,
-					  req->base.complete, req->base.data);
-		aead_request_set_crypt(subreq, req->src,
-				       req->dst, req->cryptlen, req->iv);
-		aead_request_set_ad(subreq, req->assoclen);
+	src =3D scatterwalk_ffwd(_src, req->src, req->assoclen);
=20
-		return crypto_aead_decrypt(subreq);
-	}
+	if (req->src =3D=3D req->dst)
+		dst =3D src;
+	else
+		dst =3D scatterwalk_ffwd(_dst, req->dst, req->assoclen);
+
+	if (starfive_aes_check_unaligned(cryp, src, dst))
+		return starfive_aes_aead_do_fallback(req, is_encrypt(cryp));
=20
 	return crypto_transfer_aead_request_to_engine(cryp->engine, req);
 }
@@ -706,7 +861,7 @@ static int starfive_aes_setkey(struct crypto_skcipher=
 *tfm, const u8 *key,
 	memcpy(ctx->key, key, keylen);
 	ctx->keylen =3D keylen;
=20
-	return 0;
+	return crypto_skcipher_setkey(ctx->skcipher_fbk, key, keylen);
 }
=20
 static int starfive_aes_aead_setkey(struct crypto_aead *tfm, const u8 *k=
ey,
@@ -725,16 +880,20 @@ static int starfive_aes_aead_setkey(struct crypto_a=
ead *tfm, const u8 *key,
 	memcpy(ctx->key, key, keylen);
 	ctx->keylen =3D keylen;
=20
-	if (ctx->aead_fbk)
-		return crypto_aead_setkey(ctx->aead_fbk, key, keylen);
-
-	return 0;
+	return crypto_aead_setkey(ctx->aead_fbk, key, keylen);
 }
=20
 static int starfive_aes_gcm_setauthsize(struct crypto_aead *tfm,
 					unsigned int authsize)
 {
-	return crypto_gcm_check_authsize(authsize);
+	struct starfive_cryp_ctx *ctx =3D crypto_aead_ctx(tfm);
+	int ret;
+
+	ret =3D crypto_gcm_check_authsize(authsize);
+	if (ret)
+		return ret;
+
+	return crypto_aead_setauthsize(ctx->aead_fbk, authsize);
 }
=20
 static int starfive_aes_ccm_setauthsize(struct crypto_aead *tfm,
@@ -820,9 +979,35 @@ static int starfive_aes_ccm_decrypt(struct aead_requ=
est *req)
 	return starfive_aes_aead_crypt(req, STARFIVE_AES_MODE_CCM);
 }
=20
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
+	return starfive_aes_aead_init_tfm(tfm, "ccm_base(ctr(aes-generic),cbcma=
c(aes-generic))");
+}
+
+static int starfive_aes_gcm_init_tfm(struct crypto_aead *tfm)
+{
+	return starfive_aes_aead_init_tfm(tfm, "gcm_base(ctr(aes-generic),ghash=
-generic)");
+}
+
 static struct skcipher_engine_alg skcipher_algs[] =3D {
 {
-	.base.init			=3D starfive_aes_init_tfm,
+	.base.init			=3D starfive_aes_ecb_init_tfm,
+	.base.exit			=3D starfive_aes_exit_tfm,
 	.base.setkey			=3D starfive_aes_setkey,
 	.base.encrypt			=3D starfive_aes_ecb_encrypt,
 	.base.decrypt			=3D starfive_aes_ecb_decrypt,
@@ -832,7 +1017,8 @@ static struct skcipher_engine_alg skcipher_algs[] =3D=
 {
 		.cra_name		=3D "ecb(aes)",
 		.cra_driver_name	=3D "starfive-ecb-aes",
 		.cra_priority		=3D 200,
-		.cra_flags		=3D CRYPTO_ALG_ASYNC,
+		.cra_flags		=3D CRYPTO_ALG_ASYNC |
+					  CRYPTO_ALG_NEED_FALLBACK,
 		.cra_blocksize		=3D AES_BLOCK_SIZE,
 		.cra_ctxsize		=3D sizeof(struct starfive_cryp_ctx),
 		.cra_alignmask		=3D 0xf,
@@ -842,7 +1028,8 @@ static struct skcipher_engine_alg skcipher_algs[] =3D=
 {
 		.do_one_request =3D starfive_aes_do_one_req,
 	},
 }, {
-	.base.init			=3D starfive_aes_init_tfm,
+	.base.init			=3D starfive_aes_cbc_init_tfm,
+	.base.exit			=3D starfive_aes_exit_tfm,
 	.base.setkey			=3D starfive_aes_setkey,
 	.base.encrypt			=3D starfive_aes_cbc_encrypt,
 	.base.decrypt			=3D starfive_aes_cbc_decrypt,
@@ -853,7 +1040,8 @@ static struct skcipher_engine_alg skcipher_algs[] =3D=
 {
 		.cra_name		=3D "cbc(aes)",
 		.cra_driver_name	=3D "starfive-cbc-aes",
 		.cra_priority		=3D 200,
-		.cra_flags		=3D CRYPTO_ALG_ASYNC,
+		.cra_flags		=3D CRYPTO_ALG_ASYNC |
+					  CRYPTO_ALG_NEED_FALLBACK,
 		.cra_blocksize		=3D AES_BLOCK_SIZE,
 		.cra_ctxsize		=3D sizeof(struct starfive_cryp_ctx),
 		.cra_alignmask		=3D 0xf,
@@ -863,7 +1051,8 @@ static struct skcipher_engine_alg skcipher_algs[] =3D=
 {
 		.do_one_request =3D starfive_aes_do_one_req,
 	},
 }, {
-	.base.init			=3D starfive_aes_init_tfm,
+	.base.init			=3D starfive_aes_ctr_init_tfm,
+	.base.exit			=3D starfive_aes_exit_tfm,
 	.base.setkey			=3D starfive_aes_setkey,
 	.base.encrypt			=3D starfive_aes_ctr_encrypt,
 	.base.decrypt			=3D starfive_aes_ctr_decrypt,
@@ -874,7 +1063,8 @@ static struct skcipher_engine_alg skcipher_algs[] =3D=
 {
 		.cra_name		=3D "ctr(aes)",
 		.cra_driver_name	=3D "starfive-ctr-aes",
 		.cra_priority		=3D 200,
-		.cra_flags		=3D CRYPTO_ALG_ASYNC,
+		.cra_flags		=3D CRYPTO_ALG_ASYNC |
+					  CRYPTO_ALG_NEED_FALLBACK,
 		.cra_blocksize		=3D 1,
 		.cra_ctxsize		=3D sizeof(struct starfive_cryp_ctx),
 		.cra_alignmask		=3D 0xf,
@@ -892,7 +1082,7 @@ static struct aead_engine_alg aead_algs[] =3D {
 	.base.setauthsize		=3D starfive_aes_gcm_setauthsize,
 	.base.encrypt			=3D starfive_aes_gcm_encrypt,
 	.base.decrypt			=3D starfive_aes_gcm_decrypt,
-	.base.init			=3D starfive_aes_aead_init_tfm,
+	.base.init			=3D starfive_aes_gcm_init_tfm,
 	.base.exit			=3D starfive_aes_aead_exit_tfm,
 	.base.ivsize			=3D GCM_AES_IV_SIZE,
 	.base.maxauthsize		=3D AES_BLOCK_SIZE,
@@ -900,7 +1090,8 @@ static struct aead_engine_alg aead_algs[] =3D {
 		.cra_name               =3D "gcm(aes)",
 		.cra_driver_name        =3D "starfive-gcm-aes",
 		.cra_priority           =3D 200,
-		.cra_flags              =3D CRYPTO_ALG_ASYNC,
+		.cra_flags              =3D CRYPTO_ALG_ASYNC |
+					  CRYPTO_ALG_NEED_FALLBACK,
 		.cra_blocksize          =3D 1,
 		.cra_ctxsize            =3D sizeof(struct starfive_cryp_ctx),
 		.cra_alignmask          =3D 0xf,
@@ -914,7 +1105,7 @@ static struct aead_engine_alg aead_algs[] =3D {
 	.base.setauthsize		=3D starfive_aes_ccm_setauthsize,
 	.base.encrypt			=3D starfive_aes_ccm_encrypt,
 	.base.decrypt			=3D starfive_aes_ccm_decrypt,
-	.base.init			=3D starfive_aes_aead_init_tfm,
+	.base.init			=3D starfive_aes_ccm_init_tfm,
 	.base.exit			=3D starfive_aes_aead_exit_tfm,
 	.base.ivsize			=3D AES_BLOCK_SIZE,
 	.base.maxauthsize		=3D AES_BLOCK_SIZE,
diff --git a/drivers/crypto/starfive/jh7110-cryp.c b/drivers/crypto/starf=
ive/jh7110-cryp.c
index 425fddf3a8ab..fe33e87f25ab 100644
--- a/drivers/crypto/starfive/jh7110-cryp.c
+++ b/drivers/crypto/starfive/jh7110-cryp.c
@@ -97,12 +97,6 @@ static irqreturn_t starfive_cryp_irq(int irq, void *pr=
iv)
=20
 	mask =3D readl(cryp->base + STARFIVE_IE_MASK_OFFSET);
 	status =3D readl(cryp->base + STARFIVE_IE_FLAG_OFFSET);
-	if (status & STARFIVE_IE_FLAG_AES_DONE) {
-		mask |=3D STARFIVE_IE_MASK_AES_DONE;
-		writel(mask, cryp->base + STARFIVE_IE_MASK_OFFSET);
-		tasklet_schedule(&cryp->aes_done);
-	}
-
 	if (status & STARFIVE_IE_FLAG_HASH_DONE) {
 		mask |=3D STARFIVE_IE_MASK_HASH_DONE;
 		writel(mask, cryp->base + STARFIVE_IE_MASK_OFFSET);
@@ -131,7 +125,6 @@ static int starfive_cryp_probe(struct platform_device=
 *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(cryp->base),
 				     "Error remapping memory for platform device\n");
=20
-	tasklet_init(&cryp->aes_done, starfive_aes_done_task, (unsigned long)cr=
yp);
 	tasklet_init(&cryp->hash_done, starfive_hash_done_task, (unsigned long)=
cryp);
=20
 	cryp->phys_base =3D res->start;
@@ -219,7 +212,6 @@ static int starfive_cryp_probe(struct platform_device=
 *pdev)
 	clk_disable_unprepare(cryp->ahb);
 	reset_control_assert(cryp->rst);
=20
-	tasklet_kill(&cryp->aes_done);
 	tasklet_kill(&cryp->hash_done);
=20
 	return ret;
@@ -233,7 +225,6 @@ static void starfive_cryp_remove(struct platform_devi=
ce *pdev)
 	starfive_hash_unregister_algs();
 	starfive_rsa_unregister_algs();
=20
-	tasklet_kill(&cryp->aes_done);
 	tasklet_kill(&cryp->hash_done);
=20
 	crypto_engine_stop(cryp->engine);
diff --git a/drivers/crypto/starfive/jh7110-cryp.h b/drivers/crypto/starf=
ive/jh7110-cryp.h
index 4940cd1a3fbb..3f8f0b001d41 100644
--- a/drivers/crypto/starfive/jh7110-cryp.h
+++ b/drivers/crypto/starfive/jh7110-cryp.h
@@ -168,6 +168,7 @@ struct starfive_cryp_ctx {
 	struct crypto_akcipher			*akcipher_fbk;
 	struct crypto_ahash			*ahash_fbk;
 	struct crypto_aead			*aead_fbk;
+	struct crypto_skcipher			*skcipher_fbk;
 };
=20
 struct starfive_cryp_dev {
@@ -188,7 +189,6 @@ struct starfive_cryp_dev {
 	struct scatter_walk			in_walk;
 	struct scatter_walk			out_walk;
 	struct crypto_engine			*engine;
-	struct tasklet_struct			aes_done;
 	struct tasklet_struct			hash_done;
 	struct completion			dma_done;
 	size_t					assoclen;
@@ -239,5 +239,4 @@ int starfive_aes_register_algs(void);
 void starfive_aes_unregister_algs(void);
=20
 void starfive_hash_done_task(unsigned long param);
-void starfive_aes_done_task(unsigned long param);
 #endif
--=20
2.34.1


