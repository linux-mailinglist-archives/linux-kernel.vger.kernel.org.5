Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375F879FFBD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 11:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237122AbjINJKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 05:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236571AbjINJJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 05:09:45 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782931FE8;
        Thu, 14 Sep 2023 02:09:12 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RmWcG1yL6ztSdc;
        Thu, 14 Sep 2023 17:05:02 +0800 (CST)
Received: from localhost.huawei.com (10.50.163.32) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 14 Sep 2023 17:09:09 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>
Subject: [PATCH 1/2] crypto: hisilicon/zip - support deflate algorithm
Date:   Thu, 14 Sep 2023 17:09:07 +0800
Message-ID: <20230914090908.3849318-2-shenyang39@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230914090908.3849318-1-shenyang39@huawei.com>
References: <20230914090908.3849318-1-shenyang39@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the deflate algorithm support for hisilicon zip hardware.

Signed-off-by: Yang Shen <shenyang39@huawei.com>
---
 drivers/crypto/hisilicon/zip/zip_crypto.c | 86 ++++++++++++++++++-----
 drivers/crypto/hisilicon/zip/zip_main.c   |  4 +-
 2 files changed, 72 insertions(+), 18 deletions(-)

diff --git a/drivers/crypto/hisilicon/zip/zip_crypto.c b/drivers/crypto/hisilicon/zip/zip_crypto.c
index 6608971d10cd..09f60f786779 100644
--- a/drivers/crypto/hisilicon/zip/zip_crypto.c
+++ b/drivers/crypto/hisilicon/zip/zip_crypto.c
@@ -16,6 +16,7 @@
 #define HZIP_OUT_SGE_DATA_OFFSET_M		GENMASK(23, 0)
 /* hisi_zip_sqe dw9 */
 #define HZIP_REQ_TYPE_M				GENMASK(7, 0)
+#define HZIP_ALG_TYPE_DEFLATE			0x01
 #define HZIP_ALG_TYPE_ZLIB			0x02
 #define HZIP_ALG_TYPE_GZIP			0x03
 #define HZIP_BUF_TYPE_M				GENMASK(11, 8)
@@ -41,6 +42,7 @@
 
 #define HZIP_ALG_ZLIB				GENMASK(1, 0)
 #define HZIP_ALG_GZIP				GENMASK(3, 2)
+#define HZIP_ALG_DEFLATE			GENMASK(5, 4)
 
 static const u8 zlib_head[HZIP_ZLIB_HEAD_SIZE] = {0x78, 0x9c};
 static const u8 gzip_head[HZIP_GZIP_HEAD_SIZE] = {
@@ -59,8 +61,9 @@ enum {
 };
 
 #define COMP_NAME_TO_TYPE(alg_name)					\
+	(!strcmp((alg_name), "deflate") ? HZIP_ALG_TYPE_DEFLATE :	\
 	(!strcmp((alg_name), "zlib-deflate") ? HZIP_ALG_TYPE_ZLIB :	\
-	 !strcmp((alg_name), "gzip") ? HZIP_ALG_TYPE_GZIP : 0)		\
+	 !strcmp((alg_name), "gzip") ? HZIP_ALG_TYPE_GZIP : 0))		\
 
 #define TO_HEAD_SIZE(req_type)						\
 	(((req_type) == HZIP_ALG_TYPE_ZLIB) ? sizeof(zlib_head) :	\
@@ -447,15 +450,17 @@ static int hisi_zip_acompress(struct acomp_req *acomp_req)
 	struct hisi_zip_qp_ctx *qp_ctx = &ctx->qp_ctx[HZIP_QPC_COMP];
 	struct device *dev = &qp_ctx->qp->qm->pdev->dev;
 	struct hisi_zip_req *req;
-	int head_size;
+	int head_size = 0;
 	int ret;
 
 	/* let's output compression head now */
-	head_size = add_comp_head(acomp_req->dst, qp_ctx->qp->req_type);
-	if (unlikely(head_size < 0)) {
-		dev_err_ratelimited(dev, "failed to add comp head (%d)!\n",
-				    head_size);
-		return head_size;
+	if (qp_ctx->qp->req_type != HZIP_ALG_TYPE_DEFLATE) {
+		head_size = add_comp_head(acomp_req->dst, qp_ctx->qp->req_type);
+		if (unlikely(head_size < 0)) {
+			dev_err_ratelimited(dev, "failed to add comp head (%d)!\n",
+					head_size);
+			return head_size;
+		}
 	}
 
 	req = hisi_zip_create_req(acomp_req, qp_ctx, head_size, true);
@@ -477,13 +482,15 @@ static int hisi_zip_adecompress(struct acomp_req *acomp_req)
 	struct hisi_zip_qp_ctx *qp_ctx = &ctx->qp_ctx[HZIP_QPC_DECOMP];
 	struct device *dev = &qp_ctx->qp->qm->pdev->dev;
 	struct hisi_zip_req *req;
-	int head_size, ret;
-
-	head_size = get_comp_head_size(acomp_req, qp_ctx->qp->req_type);
-	if (unlikely(head_size < 0)) {
-		dev_err_ratelimited(dev, "failed to get comp head size (%d)!\n",
-				    head_size);
-		return head_size;
+	int head_size = 0, ret;
+
+	if (qp_ctx->qp->req_type != HZIP_ALG_TYPE_DEFLATE) {
+		head_size = get_comp_head_size(acomp_req, qp_ctx->qp->req_type);
+		if (unlikely(head_size < 0)) {
+			dev_err_ratelimited(dev, "failed to get comp head size (%d)!\n",
+					head_size);
+			return head_size;
+		}
 	}
 
 	req = hisi_zip_create_req(acomp_req, qp_ctx, head_size, false);
@@ -745,6 +752,42 @@ static void hisi_zip_acomp_exit(struct crypto_acomp *tfm)
 	hisi_zip_ctx_exit(ctx);
 }
 
+static struct acomp_alg hisi_zip_acomp_deflate = {
+	.init			= hisi_zip_acomp_init,
+	.exit			= hisi_zip_acomp_exit,
+	.compress		= hisi_zip_acompress,
+	.decompress		= hisi_zip_adecompress,
+	.base			= {
+		.cra_name		= "deflate",
+		.cra_driver_name	= "hisi-deflate-acomp",
+		.cra_module		= THIS_MODULE,
+		.cra_priority		= HZIP_ALG_PRIORITY,
+		.cra_ctxsize		= sizeof(struct hisi_zip_ctx),
+	}
+};
+
+static int hisi_zip_register_deflate(struct hisi_qm *qm)
+{
+	int ret;
+
+	if (!hisi_zip_alg_support(qm, HZIP_ALG_DEFLATE))
+		return 0;
+
+	ret = crypto_register_acomp(&hisi_zip_acomp_deflate);
+	if (ret)
+		dev_err(&qm->pdev->dev, "failed to register to deflate (%d)!\n", ret);
+
+	return ret;
+}
+
+static void hisi_zip_unregister_deflate(struct hisi_qm *qm)
+{
+	if (!hisi_zip_alg_support(qm, HZIP_ALG_DEFLATE))
+		return;
+
+	crypto_unregister_acomp(&hisi_zip_acomp_deflate);
+}
+
 static struct acomp_alg hisi_zip_acomp_zlib = {
 	.init			= hisi_zip_acomp_init,
 	.exit			= hisi_zip_acomp_exit,
@@ -821,19 +864,30 @@ int hisi_zip_register_to_crypto(struct hisi_qm *qm)
 {
 	int ret = 0;
 
-	ret = hisi_zip_register_zlib(qm);
+	ret = hisi_zip_register_deflate(qm);
 	if (ret)
 		return ret;
 
+	ret = hisi_zip_register_zlib(qm);
+	if (ret)
+		goto err_unreg_deflate;
+
 	ret = hisi_zip_register_gzip(qm);
 	if (ret)
-		hisi_zip_unregister_zlib(qm);
+		goto err_unreg_zlib;
+
+	return 0;
 
+err_unreg_zlib:
+	hisi_zip_unregister_zlib(qm);
+err_unreg_deflate:
+	hisi_zip_unregister_deflate(qm);
 	return ret;
 }
 
 void hisi_zip_unregister_from_crypto(struct hisi_qm *qm)
 {
+	hisi_zip_unregister_deflate(qm);
 	hisi_zip_unregister_zlib(qm);
 	hisi_zip_unregister_gzip(qm);
 }
diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index f3ce34198775..da7a23c0e594 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -236,8 +236,8 @@ static struct hisi_qm_cap_info zip_basic_cap_info[] = {
 	{ZIP_CLUSTER_DECOMP_NUM_CAP, 0x313C, 0, GENMASK(7, 0), 0x6, 0x6, 0x3},
 	{ZIP_DECOMP_ENABLE_BITMAP, 0x3140, 16, GENMASK(15, 0), 0xFC, 0xFC, 0x1C},
 	{ZIP_COMP_ENABLE_BITMAP, 0x3140, 0, GENMASK(15, 0), 0x3, 0x3, 0x3},
-	{ZIP_DRV_ALG_BITMAP, 0x3144, 0, GENMASK(31, 0), 0xF, 0xF, 0xF},
-	{ZIP_DEV_ALG_BITMAP, 0x3148, 0, GENMASK(31, 0), 0xF, 0xF, 0xFF},
+	{ZIP_DRV_ALG_BITMAP, 0x3144, 0, GENMASK(31, 0), 0xF, 0xF, 0x3F},
+	{ZIP_DEV_ALG_BITMAP, 0x3148, 0, GENMASK(31, 0), 0xF, 0xF, 0x3F},
 	{ZIP_CORE1_ALG_BITMAP, 0x314C, 0, GENMASK(31, 0), 0x5, 0x5, 0xD5},
 	{ZIP_CORE2_ALG_BITMAP, 0x3150, 0, GENMASK(31, 0), 0x5, 0x5, 0xD5},
 	{ZIP_CORE3_ALG_BITMAP, 0x3154, 0, GENMASK(31, 0), 0xA, 0xA, 0x2A},
-- 
2.33.0

