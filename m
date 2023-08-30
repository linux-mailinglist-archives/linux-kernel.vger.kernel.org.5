Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B3D78D84B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbjH3SaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243047AbjH3KJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:09:13 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5C61B3;
        Wed, 30 Aug 2023 03:09:10 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qbI7x-009Bvo-IM; Wed, 30 Aug 2023 18:08:46 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 30 Aug 2023 18:08:47 +0800
From:   "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Wed, 30 Aug 2023 18:08:47 +0800
Subject: [PATCH 2/4] crypto: qat - Remove zlib-deflate
References: <ZO8ULhlJSrJ0Mcsx@gondor.apana.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>, ardb@kernel.org,
        kees@kernel.org, linux-kernel@vger.kernel.org, enlin.mu@unisoc.com,
        ebiggers@google.com, gpiccoli@igalia.com, willy@infradead.org,
        yunlong.xing@unisoc.com, yuxiaozhang@google.com,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        qat-linux@intel.com,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Yang Shen <shenyang39@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>
Message-Id: <E1qbI7x-009Bvo-IM@formenos.hmeau.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,TVD_RCVD_IP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the implementation of zlib-deflate because it is completely
unused in the kernel.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 drivers/crypto/intel/qat/qat_common/qat_comp_algs.c |  129 --------------------
 1 file changed, 1 insertion(+), 128 deletions(-)

diff --git a/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c b/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c
index b533984906ec..bf8c0ee62917 100644
--- a/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c
+++ b/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c
@@ -109,69 +109,6 @@ static void qat_comp_resubmit(struct work_struct *work)
 	acomp_request_complete(areq, ret);
 }
 
-static int parse_zlib_header(u16 zlib_h)
-{
-	int ret = -EINVAL;
-	__be16 header;
-	u8 *header_p;
-	u8 cmf, flg;
-
-	header = cpu_to_be16(zlib_h);
-	header_p = (u8 *)&header;
-
-	flg = header_p[0];
-	cmf = header_p[1];
-
-	if (cmf >> QAT_RFC_1950_CM_OFFSET > QAT_RFC_1950_CM_DEFLATE_CINFO_32K)
-		return ret;
-
-	if ((cmf & QAT_RFC_1950_CM_MASK) != QAT_RFC_1950_CM_DEFLATE)
-		return ret;
-
-	if (flg & QAT_RFC_1950_DICT_MASK)
-		return ret;
-
-	return 0;
-}
-
-static int qat_comp_rfc1950_callback(struct qat_compression_req *qat_req,
-				     void *resp)
-{
-	struct acomp_req *areq = qat_req->acompress_req;
-	enum direction dir = qat_req->dir;
-	__be32 qat_produced_adler;
-
-	qat_produced_adler = cpu_to_be32(qat_comp_get_produced_adler32(resp));
-
-	if (dir == COMPRESSION) {
-		__be16 zlib_header;
-
-		zlib_header = cpu_to_be16(QAT_RFC_1950_COMP_HDR);
-		scatterwalk_map_and_copy(&zlib_header, areq->dst, 0, QAT_RFC_1950_HDR_SIZE, 1);
-		areq->dlen += QAT_RFC_1950_HDR_SIZE;
-
-		scatterwalk_map_and_copy(&qat_produced_adler, areq->dst, areq->dlen,
-					 QAT_RFC_1950_FOOTER_SIZE, 1);
-		areq->dlen += QAT_RFC_1950_FOOTER_SIZE;
-	} else {
-		__be32 decomp_adler;
-		int footer_offset;
-		int consumed;
-
-		consumed = qat_comp_get_consumed_ctr(resp);
-		footer_offset = consumed + QAT_RFC_1950_HDR_SIZE;
-		if (footer_offset + QAT_RFC_1950_FOOTER_SIZE > areq->slen)
-			return -EBADMSG;
-
-		scatterwalk_map_and_copy(&decomp_adler, areq->src, footer_offset,
-					 QAT_RFC_1950_FOOTER_SIZE, 0);
-
-		if (qat_produced_adler != decomp_adler)
-			return -EBADMSG;
-	}
-	return 0;
-}
-
 static void qat_comp_generic_callback(struct qat_compression_req *qat_req,
 				      void *resp)
 {
@@ -293,18 +230,6 @@ static void qat_comp_alg_exit_tfm(struct crypto_acomp *acomp_tfm)
 	memset(ctx, 0, sizeof(*ctx));
 }
 
-static int qat_comp_alg_rfc1950_init_tfm(struct crypto_acomp *acomp_tfm)
-{
-	struct crypto_tfm *tfm = crypto_acomp_tfm(acomp_tfm);
-	struct qat_compression_ctx *ctx = crypto_tfm_ctx(tfm);
-	int ret;
-
-	ret = qat_comp_alg_init_tfm(acomp_tfm);
-	ctx->qat_comp_callback = &qat_comp_rfc1950_callback;
-
-	return ret;
-}
-
 static int qat_comp_alg_compress_decompress(struct acomp_req *areq, enum direction dir,
 					    unsigned int shdr, unsigned int sftr,
 					    unsigned int dhdr, unsigned int dftr)
@@ -400,43 +325,6 @@ static int qat_comp_alg_decompress(struct acomp_req *req)
 	return qat_comp_alg_compress_decompress(req, DECOMPRESSION, 0, 0, 0, 0);
 }
 
-static int qat_comp_alg_rfc1950_compress(struct acomp_req *req)
-{
-	if (!req->dst && req->dlen != 0)
-		return -EINVAL;
-
-	if (req->dst && req->dlen <= QAT_RFC_1950_HDR_SIZE + QAT_RFC_1950_FOOTER_SIZE)
-		return -EINVAL;
-
-	return qat_comp_alg_compress_decompress(req, COMPRESSION, 0, 0,
-						QAT_RFC_1950_HDR_SIZE,
-						QAT_RFC_1950_FOOTER_SIZE);
-}
-
-static int qat_comp_alg_rfc1950_decompress(struct acomp_req *req)
-{
-	struct crypto_acomp *acomp_tfm = crypto_acomp_reqtfm(req);
-	struct crypto_tfm *tfm = crypto_acomp_tfm(acomp_tfm);
-	struct qat_compression_ctx *ctx = crypto_tfm_ctx(tfm);
-	struct adf_accel_dev *accel_dev = ctx->inst->accel_dev;
-	u16 zlib_header;
-	int ret;
-
-	if (req->slen <= QAT_RFC_1950_HDR_SIZE + QAT_RFC_1950_FOOTER_SIZE)
-		return -EBADMSG;
-
-	scatterwalk_map_and_copy(&zlib_header, req->src, 0, QAT_RFC_1950_HDR_SIZE, 0);
-
-	ret = parse_zlib_header(zlib_header);
-	if (ret) {
-		dev_dbg(&GET_DEV(accel_dev), "Error parsing zlib header\n");
-		return ret;
-	}
-
-	return qat_comp_alg_compress_decompress(req, DECOMPRESSION, QAT_RFC_1950_HDR_SIZE,
-						QAT_RFC_1950_FOOTER_SIZE, 0, 0);
-}
-
 static struct acomp_alg qat_acomp[] = { {
 	.base = {
 		.cra_name = "deflate",
@@ -452,22 +340,7 @@ static struct acomp_alg qat_acomp[] = { {
 	.decompress = qat_comp_alg_decompress,
 	.dst_free = sgl_free,
 	.reqsize = sizeof(struct qat_compression_req),
-}, {
-	.base = {
-		.cra_name = "zlib-deflate",
-		.cra_driver_name = "qat_zlib_deflate",
-		.cra_priority = 4001,
-		.cra_flags = CRYPTO_ALG_ASYNC,
-		.cra_ctxsize = sizeof(struct qat_compression_ctx),
-		.cra_module = THIS_MODULE,
-	},
-	.init = qat_comp_alg_rfc1950_init_tfm,
-	.exit = qat_comp_alg_exit_tfm,
-	.compress = qat_comp_alg_rfc1950_compress,
-	.decompress = qat_comp_alg_rfc1950_decompress,
-	.dst_free = sgl_free,
-	.reqsize = sizeof(struct qat_compression_req),
-} };
+}};
 
 int qat_comp_algs_register(void)
 {
