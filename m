Return-Path: <linux-kernel+bounces-2220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE55D8159C9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 15:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49F87B23C66
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 14:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB00930666;
	Sat, 16 Dec 2023 14:13:08 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC1D2D7A6;
	Sat, 16 Dec 2023 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id ECF4524DFCE;
	Sat, 16 Dec 2023 22:12:59 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 16 Dec
 2023 22:12:59 +0800
Received: from ubuntu.localdomain (161.142.156.108) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 16 Dec
 2023 22:12:54 +0800
From: Jia Jie Ho <jiajie.ho@starfivetech.com>
To: Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller"
	<davem@davemloft.net>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 2/5] crypto: starfive: Update hash dma usage
Date: Sat, 16 Dec 2023 22:12:31 +0800
Message-ID: <20231216141234.417498-3-jiajie.ho@starfivetech.com>
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

Current hash uses sw fallback for non-word aligned input scatterlists.
Add support for unaligned cases utilizing the data valid mask for dma.

Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
---
 drivers/crypto/starfive/jh7110-cryp.h |   1 +
 drivers/crypto/starfive/jh7110-hash.c | 257 ++++++++++----------------
 2 files changed, 100 insertions(+), 158 deletions(-)

diff --git a/drivers/crypto/starfive/jh7110-cryp.h b/drivers/crypto/starf=
ive/jh7110-cryp.h
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
diff --git a/drivers/crypto/starfive/jh7110-hash.c b/drivers/crypto/starf=
ive/jh7110-hash.c
index b6d1808012ca..74e151b5f875 100644
--- a/drivers/crypto/starfive/jh7110-hash.c
+++ b/drivers/crypto/starfive/jh7110-hash.c
@@ -86,62 +86,31 @@ static int starfive_hash_hmac_key(struct starfive_cry=
p_ctx *ctx)
=20
 static void starfive_hash_start(void *param)
 {
-	struct starfive_cryp_ctx *ctx =3D param;
-	struct starfive_cryp_request_ctx *rctx =3D ctx->rctx;
-	struct starfive_cryp_dev *cryp =3D ctx->cryp;
-	union starfive_alg_cr alg_cr;
+	struct starfive_cryp_dev *cryp =3D param;
 	union starfive_hash_csr csr;
-	u32 stat;
-
-	dma_unmap_sg(cryp->dev, rctx->in_sg, rctx->in_sg_len, DMA_TO_DEVICE);
-
-	alg_cr.v =3D 0;
-	alg_cr.clear =3D 1;
-
-	writel(alg_cr.v, cryp->base + STARFIVE_ALG_CR_OFFSET);
+	u32 mask;
=20
 	csr.v =3D readl(cryp->base + STARFIVE_HASH_SHACSR);
 	csr.firstb =3D 0;
 	csr.final =3D 1;
-
-	stat =3D readl(cryp->base + STARFIVE_IE_MASK_OFFSET);
-	stat &=3D ~STARFIVE_IE_MASK_HASH_DONE;
-	writel(stat, cryp->base + STARFIVE_IE_MASK_OFFSET);
+	csr.ie =3D 1;
 	writel(csr.v, cryp->base + STARFIVE_HASH_SHACSR);
+
+	mask =3D readl(cryp->base + STARFIVE_IE_MASK_OFFSET);
+	mask &=3D ~STARFIVE_IE_MASK_HASH_DONE;
+	writel(mask, cryp->base + STARFIVE_IE_MASK_OFFSET);
 }
=20
-static int starfive_hash_xmit_dma(struct starfive_cryp_ctx *ctx)
+static void starfive_hash_dma_callback(void *param)
 {
-	struct starfive_cryp_request_ctx *rctx =3D ctx->rctx;
-	struct starfive_cryp_dev *cryp =3D ctx->cryp;
-	struct dma_async_tx_descriptor	*in_desc;
-	union  starfive_alg_cr alg_cr;
-	int total_len;
-	int ret;
-
-	if (!rctx->total) {
-		starfive_hash_start(ctx);
-		return 0;
-	}
+	struct starfive_cryp_dev *cryp =3D param;
=20
-	writel(rctx->total, cryp->base + STARFIVE_DMA_IN_LEN_OFFSET);
-
-	total_len =3D rctx->total;
-	total_len =3D (total_len & 0x3) ? (((total_len >> 2) + 1) << 2) : total=
_len;
-	sg_dma_len(rctx->in_sg) =3D total_len;
-
-	alg_cr.v =3D 0;
-	alg_cr.start =3D 1;
-	alg_cr.hash_dma_en =3D 1;
-
-	writel(alg_cr.v, cryp->base + STARFIVE_ALG_CR_OFFSET);
-
-	ret =3D dma_map_sg(cryp->dev, rctx->in_sg, rctx->in_sg_len, DMA_TO_DEVI=
CE);
-	if (!ret)
-		return dev_err_probe(cryp->dev, -EINVAL, "dma_map_sg() error\n");
+	complete(&cryp->dma_done);
+}
=20
-	cryp->cfg_in.direction =3D DMA_MEM_TO_DEV;
-	cryp->cfg_in.src_addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
+static void starfive_hash_dma_init(struct starfive_cryp_dev *cryp)
+{
+	cryp->cfg_in.src_addr_width =3D DMA_SLAVE_BUSWIDTH_16_BYTES;
 	cryp->cfg_in.dst_addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
 	cryp->cfg_in.src_maxburst =3D cryp->dma_maxburst;
 	cryp->cfg_in.dst_maxburst =3D cryp->dma_maxburst;
@@ -149,50 +118,48 @@ static int starfive_hash_xmit_dma(struct starfive_c=
ryp_ctx *ctx)
=20
 	dmaengine_slave_config(cryp->tx, &cryp->cfg_in);
=20
-	in_desc =3D dmaengine_prep_slave_sg(cryp->tx, rctx->in_sg,
-					  ret, DMA_MEM_TO_DEV,
-					  DMA_PREP_INTERRUPT  |  DMA_CTRL_ACK);
-
-	if (!in_desc)
-		return -EINVAL;
-
-	in_desc->callback =3D starfive_hash_start;
-	in_desc->callback_param =3D ctx;
-
-	dmaengine_submit(in_desc);
-	dma_async_issue_pending(cryp->tx);
-
-	return 0;
+	init_completion(&cryp->dma_done);
 }
=20
-static int starfive_hash_xmit(struct starfive_cryp_ctx *ctx)
+static int starfive_hash_dma_xfer(struct starfive_cryp_dev *cryp,
+				  struct scatterlist *sg)
 {
-	struct starfive_cryp_request_ctx *rctx =3D ctx->rctx;
-	struct starfive_cryp_dev *cryp =3D ctx->cryp;
+	struct dma_async_tx_descriptor *in_desc;
+	union starfive_alg_cr alg_cr;
 	int ret =3D 0;
=20
-	rctx->csr.hash.v =3D 0;
-	rctx->csr.hash.reset =3D 1;
-	writel(rctx->csr.hash.v, cryp->base + STARFIVE_HASH_SHACSR);
-
-	if (starfive_hash_wait_busy(ctx))
-		return dev_err_probe(cryp->dev, -ETIMEDOUT, "Error resetting engine.\n=
");
+	alg_cr.v =3D 0;
+	alg_cr.start =3D 1;
+	alg_cr.hash_dma_en =3D 1;
+	writel(alg_cr.v, cryp->base + STARFIVE_ALG_CR_OFFSET);
=20
-	rctx->csr.hash.v =3D 0;
-	rctx->csr.hash.mode =3D ctx->hash_mode;
-	rctx->csr.hash.ie =3D 1;
+	writel(sg_dma_len(sg), cryp->base + STARFIVE_DMA_IN_LEN_OFFSET);
+	sg_dma_len(sg) =3D ALIGN(sg_dma_len(sg), sizeof(u32));
=20
-	if (ctx->is_hmac) {
-		ret =3D starfive_hash_hmac_key(ctx);
-		if (ret)
-			return ret;
-	} else {
-		rctx->csr.hash.start =3D 1;
-		rctx->csr.hash.firstb =3D 1;
-		writel(rctx->csr.hash.v, cryp->base + STARFIVE_HASH_SHACSR);
+	in_desc =3D dmaengine_prep_slave_sg(cryp->tx, sg, 1, DMA_MEM_TO_DEV,
+					  DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!in_desc) {
+		ret =3D -EINVAL;
+		goto end;
 	}
=20
-	return starfive_hash_xmit_dma(ctx);
+	reinit_completion(&cryp->dma_done);
+	in_desc->callback =3D starfive_hash_dma_callback;
+	in_desc->callback_param =3D cryp;
+
+	dmaengine_submit(in_desc);
+	dma_async_issue_pending(cryp->tx);
+
+	if (!wait_for_completion_timeout(&cryp->dma_done,
+					 msecs_to_jiffies(1000)))
+		ret =3D -ETIMEDOUT;
+
+end:
+	alg_cr.v =3D 0;
+	alg_cr.clear =3D 1;
+	writel(alg_cr.v, cryp->base + STARFIVE_ALG_CR_OFFSET);
+
+	return ret;
 }
=20
 static int starfive_hash_copy_hash(struct ahash_request *req)
@@ -229,44 +196,56 @@ void starfive_hash_done_task(unsigned long param)
 	crypto_finalize_hash_request(cryp->engine, cryp->req.hreq, err);
 }
=20
-static int starfive_hash_check_aligned(struct scatterlist *sg, size_t to=
tal, size_t align)
+static int starfive_hash_one_request(struct crypto_engine *engine, void =
*areq)
 {
-	int len =3D 0;
-
-	if (!total)
-		return 0;
+	struct ahash_request *req =3D container_of(areq, struct ahash_request,
+						 base);
+	struct starfive_cryp_ctx *ctx =3D crypto_ahash_ctx(crypto_ahash_reqtfm(=
req));
+	struct starfive_cryp_request_ctx *rctx =3D ctx->rctx;
+	struct starfive_cryp_dev *cryp =3D ctx->cryp;
+	struct scatterlist *tsg;
+	int ret, src_nents, i;
=20
-	if (!IS_ALIGNED(total, align))
-		return -EINVAL;
+	writel(STARFIVE_HASH_RESET, cryp->base + STARFIVE_HASH_SHACSR);
=20
-	while (sg) {
-		if (!IS_ALIGNED(sg->offset, sizeof(u32)))
-			return -EINVAL;
+	if (starfive_hash_wait_busy(ctx))
+		return dev_err_probe(cryp->dev, -ETIMEDOUT, "Error resetting hardware.=
\n");
=20
-		if (!IS_ALIGNED(sg->length, align))
-			return -EINVAL;
+	rctx->csr.hash.v =3D 0;
+	rctx->csr.hash.mode =3D ctx->hash_mode;
=20
-		len +=3D sg->length;
-		sg =3D sg_next(sg);
+	if (ctx->is_hmac) {
+		ret =3D starfive_hash_hmac_key(ctx);
+		if (ret)
+			return ret;
+	} else {
+		rctx->csr.hash.start =3D 1;
+		rctx->csr.hash.firstb =3D 1;
+		writel(rctx->csr.hash.v, cryp->base + STARFIVE_HASH_SHACSR);
 	}
=20
-	if (len !=3D total)
-		return -EINVAL;
+	/* No input message, get digest and end. */
+	if (!rctx->total)
+		goto hash_start;
=20
-	return 0;
-}
+	starfive_hash_dma_init(cryp);
=20
-static int starfive_hash_one_request(struct crypto_engine *engine, void =
*areq)
-{
-	struct ahash_request *req =3D container_of(areq, struct ahash_request,
-						 base);
-	struct starfive_cryp_ctx *ctx =3D crypto_ahash_ctx(crypto_ahash_reqtfm(=
req));
-	struct starfive_cryp_dev *cryp =3D ctx->cryp;
+	for_each_sg(rctx->in_sg, tsg, rctx->in_sg_len, i) {
+		src_nents =3D dma_map_sg(cryp->dev, tsg, 1, DMA_TO_DEVICE);
+		if (src_nents =3D=3D 0)
+			return dev_err_probe(cryp->dev, -ENOMEM,
+					     "dma_map_sg error\n");
=20
-	if (!cryp)
-		return -ENODEV;
+		ret =3D starfive_hash_dma_xfer(cryp, tsg);
+		dma_unmap_sg(cryp->dev, tsg, 1, DMA_TO_DEVICE);
+		if (ret)
+			return ret;
+	}
+
+hash_start:
+	starfive_hash_start(cryp);
=20
-	return starfive_hash_xmit(ctx);
+	return 0;
 }
=20
 static int starfive_hash_init(struct ahash_request *req)
@@ -337,22 +316,6 @@ static int starfive_hash_finup(struct ahash_request =
*req)
 	return crypto_ahash_finup(&rctx->ahash_fbk_req);
 }
=20
-static int starfive_hash_digest_fb(struct ahash_request *req)
-{
-	struct starfive_cryp_request_ctx *rctx =3D ahash_request_ctx(req);
-	struct crypto_ahash *tfm =3D crypto_ahash_reqtfm(req);
-	struct starfive_cryp_ctx *ctx =3D crypto_ahash_ctx(tfm);
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
 	struct crypto_ahash *tfm =3D crypto_ahash_reqtfm(req);
@@ -370,9 +333,6 @@ static int starfive_hash_digest(struct ahash_request =
*req)
 	rctx->in_sg_len =3D sg_nents_for_len(rctx->in_sg, rctx->total);
 	ctx->rctx =3D rctx;
=20
-	if (starfive_hash_check_aligned(rctx->in_sg, rctx->total, rctx->blksize=
))
-		return starfive_hash_digest_fb(req);
-
 	return crypto_transfer_hash_request_to_engine(cryp->engine, req);
 }
=20
@@ -406,7 +366,8 @@ static int starfive_hash_import(struct ahash_request =
*req, const void *in)
=20
 static int starfive_hash_init_tfm(struct crypto_ahash *hash,
 				  const char *alg_name,
-				  unsigned int mode)
+				  unsigned int mode,
+				  bool is_hmac)
 {
 	struct starfive_cryp_ctx *ctx =3D crypto_ahash_ctx(hash);
=20
@@ -426,7 +387,7 @@ static int starfive_hash_init_tfm(struct crypto_ahash=
 *hash,
 	crypto_ahash_set_reqsize(hash, sizeof(struct starfive_cryp_request_ctx)=
 +
 				 crypto_ahash_reqsize(ctx->ahash_fbk));
=20
-	ctx->keylen =3D 0;
+	ctx->is_hmac =3D is_hmac;
 	ctx->hash_mode =3D mode;
=20
 	return 0;
@@ -529,81 +490,61 @@ static int starfive_hash_setkey(struct crypto_ahash=
 *hash,
 static int starfive_sha224_init_tfm(struct crypto_ahash *hash)
 {
 	return starfive_hash_init_tfm(hash, "sha224-generic",
-				      STARFIVE_HASH_SHA224);
+				      STARFIVE_HASH_SHA224, 0);
 }
=20
 static int starfive_sha256_init_tfm(struct crypto_ahash *hash)
 {
 	return starfive_hash_init_tfm(hash, "sha256-generic",
-				      STARFIVE_HASH_SHA256);
+				      STARFIVE_HASH_SHA256, 0);
 }
=20
 static int starfive_sha384_init_tfm(struct crypto_ahash *hash)
 {
 	return starfive_hash_init_tfm(hash, "sha384-generic",
-				      STARFIVE_HASH_SHA384);
+				      STARFIVE_HASH_SHA384, 0);
 }
=20
 static int starfive_sha512_init_tfm(struct crypto_ahash *hash)
 {
 	return starfive_hash_init_tfm(hash, "sha512-generic",
-				      STARFIVE_HASH_SHA512);
+				      STARFIVE_HASH_SHA512, 0);
 }
=20
 static int starfive_sm3_init_tfm(struct crypto_ahash *hash)
 {
 	return starfive_hash_init_tfm(hash, "sm3-generic",
-				      STARFIVE_HASH_SM3);
+				      STARFIVE_HASH_SM3, 0);
 }
=20
 static int starfive_hmac_sha224_init_tfm(struct crypto_ahash *hash)
 {
-	struct starfive_cryp_ctx *ctx =3D crypto_ahash_ctx(hash);
-
-	ctx->is_hmac =3D true;
-
 	return starfive_hash_init_tfm(hash, "hmac(sha224-generic)",
-				      STARFIVE_HASH_SHA224);
+				      STARFIVE_HASH_SHA224, 1);
 }
=20
 static int starfive_hmac_sha256_init_tfm(struct crypto_ahash *hash)
 {
-	struct starfive_cryp_ctx *ctx =3D crypto_ahash_ctx(hash);
-
-	ctx->is_hmac =3D true;
-
 	return starfive_hash_init_tfm(hash, "hmac(sha256-generic)",
-				      STARFIVE_HASH_SHA256);
+				      STARFIVE_HASH_SHA256, 1);
 }
=20
 static int starfive_hmac_sha384_init_tfm(struct crypto_ahash *hash)
 {
-	struct starfive_cryp_ctx *ctx =3D crypto_ahash_ctx(hash);
-
-	ctx->is_hmac =3D true;
-
 	return starfive_hash_init_tfm(hash, "hmac(sha384-generic)",
-				      STARFIVE_HASH_SHA384);
+				      STARFIVE_HASH_SHA384, 1);
 }
=20
 static int starfive_hmac_sha512_init_tfm(struct crypto_ahash *hash)
 {
-	struct starfive_cryp_ctx *ctx =3D crypto_ahash_ctx(hash);
-
-	ctx->is_hmac =3D true;
-
 	return starfive_hash_init_tfm(hash, "hmac(sha512-generic)",
-				      STARFIVE_HASH_SHA512);
+				      STARFIVE_HASH_SHA512, 1);
 }
=20
 static int starfive_hmac_sm3_init_tfm(struct crypto_ahash *hash)
 {
-	struct starfive_cryp_ctx *ctx =3D crypto_ahash_ctx(hash);
-
-	ctx->is_hmac =3D true;
-
 	return starfive_hash_init_tfm(hash, "hmac(sm3-generic)",
-				      STARFIVE_HASH_SM3);
+				      STARFIVE_HASH_SM3, 1);
 }
=20
 static struct ahash_engine_alg algs_sha2_sm3[] =3D {
--=20
2.34.1


