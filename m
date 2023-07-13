Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0D0752684
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjGMPQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbjGMPQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:16:47 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F35271E;
        Thu, 13 Jul 2023 08:16:30 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36DDTdNU025010;
        Thu, 13 Jul 2023 17:16:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=tgrSKzLt3ZzpWa5/PAThbKU6QRbVcrH0F3Yej1A6ZBo=;
 b=sp67iAYKtshPAjMhwrX/b8WWkjmRRdw6oHvCt+WvwR+KR0yNj47/LJsvJl0qzbQdTCZX
 NtcDqb6gI+bmoiWmVyiWV+I2i3a/NCf6LdewbPLq0nxprr2IMpfVQV/ZrQHkF4Bp3Gky
 oLNU5ObUE0UL0eWfdFxDz8R91PHTMYAO6ivGDrI2JPp/dD8y50wihzIg9nAy3/Ny2+a/
 oW9UzLC+JTMlGFWdc/fVSsaOvmUKvOCIaXcCs1F3X8Hmo5EI5SRdKQNgLN/FvncDist8
 v76uj14A4EkTToTGr9L48ufNLdimCVlT6AEeueL/N/eFeUQboRt8lQ36EAR2JmxdDD3B EA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rtejytdch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 17:16:11 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 56062100056;
        Thu, 13 Jul 2023 17:16:11 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4C7DE22A6D7;
        Thu, 13 Jul 2023 17:16:11 +0200 (CEST)
Received: from localhost (10.201.22.9) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 13 Jul
 2023 17:16:13 +0200
From:   Thomas BOURGOIN <thomas.bourgoin@foss.st.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Lionel Debieve <lionel.debieve@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Thomas Bourgoin <thomas.bourgoin@foss.st.com>
Subject: [PATCH v2 2/7] crypto: stm32 - add new algorithms support
Date:   Thu, 13 Jul 2023 17:15:13 +0200
Message-ID: <20230713151518.1513949-3-thomas.bourgoin@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230713151518.1513949-1-thomas.bourgoin@foss.st.com>
References: <20230713151518.1513949-1-thomas.bourgoin@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.22.9]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_05,2023-07-13_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Bourgoin <thomas.bourgoin@foss.st.com>

Add the all SHA-2 (up to 512) and SHA-3 algorithm support.
Update compatible table to add stm32mp13.

Signed-off-by: Thomas Bourgoin <thomas.bourgoin@foss.st.com>

---
Changes in v2:
 - Macro HASH_CSR_NB_SHA256 value is 38 instead of 22

 drivers/crypto/stm32/Kconfig      |   2 +
 drivers/crypto/stm32/stm32-hash.c | 666 ++++++++++++++++++++++++------
 2 files changed, 543 insertions(+), 125 deletions(-)

diff --git a/drivers/crypto/stm32/Kconfig b/drivers/crypto/stm32/Kconfig
index 4fc581e9e595..49dfd161e9b9 100644
--- a/drivers/crypto/stm32/Kconfig
+++ b/drivers/crypto/stm32/Kconfig
@@ -16,6 +16,8 @@ config CRYPTO_DEV_STM32_HASH
 	select CRYPTO_MD5
 	select CRYPTO_SHA1
 	select CRYPTO_SHA256
+	select CRYPTO_SHA512
+	select CRYPTO_SHA3
 	select CRYPTO_ENGINE
 	help
 	  This enables support for the HASH hw accelerator which can be found
diff --git a/drivers/crypto/stm32/stm32-hash.c b/drivers/crypto/stm32/stm32-hash.c
index f0df32382719..30e42a402aa7 100644
--- a/drivers/crypto/stm32/stm32-hash.c
+++ b/drivers/crypto/stm32/stm32-hash.c
@@ -26,6 +26,7 @@
 #include <crypto/scatterwalk.h>
 #include <crypto/sha1.h>
 #include <crypto/sha2.h>
+#include <crypto/sha3.h>
 #include <crypto/internal/hash.h>
 
 #define HASH_CR				0x00
@@ -45,19 +46,11 @@
 #define HASH_CR_DMAE			BIT(3)
 #define HASH_CR_DATATYPE_POS		4
 #define HASH_CR_MODE			BIT(6)
+#define HASH_CR_ALGO_POS		7
 #define HASH_CR_MDMAT			BIT(13)
 #define HASH_CR_DMAA			BIT(14)
 #define HASH_CR_LKEY			BIT(16)
 
-#define HASH_CR_ALGO_SHA1		0x0
-#define HASH_CR_ALGO_MD5		0x80
-#define HASH_CR_ALGO_SHA224		0x40000
-#define HASH_CR_ALGO_SHA256		0x40080
-
-#define HASH_CR_UX500_EMPTYMSG		BIT(20)
-#define HASH_CR_UX500_ALGO_SHA1		BIT(7)
-#define HASH_CR_UX500_ALGO_SHA256	0x0
-
 /* Interrupt */
 #define HASH_DINIE			BIT(0)
 #define HASH_DCIE			BIT(1)
@@ -66,9 +59,6 @@
 #define HASH_MASK_CALC_COMPLETION	BIT(0)
 #define HASH_MASK_DATA_INPUT		BIT(1)
 
-/* Context swap register */
-#define HASH_CSR_REGISTER_NUMBER	54
-
 /* Status Flags */
 #define HASH_SR_DATA_INPUT_READY	BIT(0)
 #define HASH_SR_OUTPUT_READY		BIT(1)
@@ -79,6 +69,18 @@
 #define HASH_STR_NBLW_MASK		GENMASK(4, 0)
 #define HASH_STR_DCAL			BIT(8)
 
+/* HWCFGR Register */
+#define HASH_HWCFG_DMA_MASK		GENMASK(3, 0)
+
+/* Context swap register */
+#define HASH_CSR_NB_SHA256_HMAC		54
+#define HASH_CSR_NB_SHA256		38
+#define HASH_CSR_NB_SHA512_HMAC		103
+#define HASH_CSR_NB_SHA512		91
+#define HASH_CSR_NB_SHA3_HMAC		88
+#define HASH_CSR_NB_SHA3		72
+#define HASH_CSR_NB_MAX			HASH_CSR_NB_SHA512_HMAC
+
 #define HASH_FLAGS_INIT			BIT(0)
 #define HASH_FLAGS_OUTPUT_READY		BIT(1)
 #define HASH_FLAGS_CPU			BIT(2)
@@ -87,20 +89,20 @@
 #define HASH_FLAGS_HMAC_INIT		BIT(5)
 #define HASH_FLAGS_HMAC_FINAL		BIT(6)
 #define HASH_FLAGS_HMAC_KEY		BIT(7)
-
+#define HASH_FLAGS_SHA3_MODE		BIT(8)
 #define HASH_FLAGS_FINAL		BIT(15)
 #define HASH_FLAGS_FINUP		BIT(16)
-#define HASH_FLAGS_ALGO_MASK		GENMASK(21, 18)
-#define HASH_FLAGS_MD5			BIT(18)
-#define HASH_FLAGS_SHA1			BIT(19)
-#define HASH_FLAGS_SHA224		BIT(20)
-#define HASH_FLAGS_SHA256		BIT(21)
+#define HASH_FLAGS_ALGO_MASK		GENMASK(20, 17)
+#define HASH_FLAGS_ALGO_SHIFT		17
+#define HASH_FLAGS_ERRORS		BIT(21)
 #define HASH_FLAGS_EMPTY		BIT(22)
 #define HASH_FLAGS_HMAC			BIT(23)
 
 #define HASH_OP_UPDATE			1
 #define HASH_OP_FINAL			2
 
+#define HASH_BURST_LEVEL		4
+
 enum stm32_hash_data_format {
 	HASH_DATA_32_BITS		= 0x0,
 	HASH_DATA_16_BITS		= 0x1,
@@ -108,11 +110,26 @@ enum stm32_hash_data_format {
 	HASH_DATA_1_BIT			= 0x3
 };
 
-#define HASH_BUFLEN			256
-#define HASH_LONG_KEY			64
-#define HASH_MAX_KEY_SIZE		(SHA256_BLOCK_SIZE * 8)
-#define HASH_QUEUE_LENGTH		16
-#define HASH_DMA_THRESHOLD		50
+#define HASH_BUFLEN			(SHA3_224_BLOCK_SIZE + 4)
+#define HASH_MAX_KEY_SIZE		(SHA512_BLOCK_SIZE * 8)
+
+enum stm32_hash_algo {
+	HASH_SHA1			= 0,
+	HASH_MD5			= 1,
+	HASH_SHA224			= 2,
+	HASH_SHA256			= 3,
+	HASH_SHA3_224			= 4,
+	HASH_SHA3_256			= 5,
+	HASH_SHA3_384			= 6,
+	HASH_SHA3_512			= 7,
+	HASH_SHA384			= 12,
+	HASH_SHA512			= 15,
+};
+
+enum ux500_hash_algo {
+	HASH_SHA256_UX500		= 0,
+	HASH_SHA1_UX500			= 1,
+};
 
 #define HASH_AUTOSUSPEND_DELAY		50
 
@@ -130,19 +147,19 @@ struct stm32_hash_state {
 	u32			flags;
 
 	u16			bufcnt;
-	u16			buflen;
+	u16			blocklen;
 
 	u8 buffer[HASH_BUFLEN] __aligned(4);
 
 	/* hash state */
-	u32			hw_context[3 + HASH_CSR_REGISTER_NUMBER];
+	u32			hw_context[3 + HASH_CSR_NB_MAX];
 };
 
 struct stm32_hash_request_ctx {
 	struct stm32_hash_dev	*hdev;
 	unsigned long		op;
 
-	u8 digest[SHA256_DIGEST_SIZE] __aligned(sizeof(u32));
+	u8 digest[SHA512_DIGEST_SIZE] __aligned(sizeof(u32));
 	size_t			digcnt;
 
 	/* DMA */
@@ -166,12 +183,13 @@ struct stm32_hash_algs_info {
 };
 
 struct stm32_hash_pdata {
-	struct stm32_hash_algs_info	*algs_info;
-	size_t				algs_info_size;
-	bool				has_sr;
-	bool				has_mdmat;
-	bool				broken_emptymsg;
-	bool				ux500;
+	const int				alg_shift;
+	const struct stm32_hash_algs_info	*algs_info;
+	size_t					algs_info_size;
+	bool					has_sr;
+	bool					has_mdmat;
+	bool					broken_emptymsg;
+	bool					ux500;
 };
 
 struct stm32_hash_dev {
@@ -182,7 +200,6 @@ struct stm32_hash_dev {
 	void __iomem		*io_base;
 	phys_addr_t		phys_base;
 	u32			dma_mode;
-	u32			dma_maxburst;
 	bool			polled;
 
 	struct ahash_request	*req;
@@ -275,31 +292,19 @@ static void stm32_hash_write_ctrl(struct stm32_hash_dev *hdev, int bufcnt)
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(hdev->req);
 	struct stm32_hash_ctx *ctx = crypto_ahash_ctx(tfm);
 	struct stm32_hash_state *state = &rctx->state;
+	u32 alg = (state->flags & HASH_FLAGS_ALGO_MASK) >> HASH_FLAGS_ALGO_SHIFT;
 
 	u32 reg = HASH_CR_INIT;
 
 	if (!(hdev->flags & HASH_FLAGS_INIT)) {
-		switch (state->flags & HASH_FLAGS_ALGO_MASK) {
-		case HASH_FLAGS_MD5:
-			reg |= HASH_CR_ALGO_MD5;
-			break;
-		case HASH_FLAGS_SHA1:
-			if (hdev->pdata->ux500)
-				reg |= HASH_CR_UX500_ALGO_SHA1;
-			else
-				reg |= HASH_CR_ALGO_SHA1;
-			break;
-		case HASH_FLAGS_SHA224:
-			reg |= HASH_CR_ALGO_SHA224;
-			break;
-		case HASH_FLAGS_SHA256:
-			if (hdev->pdata->ux500)
-				reg |= HASH_CR_UX500_ALGO_SHA256;
+		if (hdev->pdata->ux500) {
+			reg |= ((alg & BIT(0)) << HASH_CR_ALGO_POS);
+		} else {
+			if (hdev->pdata->alg_shift == HASH_CR_ALGO_POS)
+				reg |= ((alg & BIT(1)) << 17) |
+				       ((alg & BIT(0)) << HASH_CR_ALGO_POS);
 			else
-				reg |= HASH_CR_ALGO_SHA256;
-			break;
-		default:
-			reg |= HASH_CR_ALGO_MD5;
+				reg |= alg << hdev->pdata->alg_shift;
 		}
 
 		reg |= (rctx->data_type << HASH_CR_DATATYPE_POS);
@@ -307,7 +312,7 @@ static void stm32_hash_write_ctrl(struct stm32_hash_dev *hdev, int bufcnt)
 		if (state->flags & HASH_FLAGS_HMAC) {
 			hdev->flags |= HASH_FLAGS_HMAC;
 			reg |= HASH_CR_MODE;
-			if (ctx->keylen > HASH_LONG_KEY)
+			if (ctx->keylen > crypto_ahash_blocksize(tfm))
 				reg |= HASH_CR_LKEY;
 		}
 
@@ -318,6 +323,12 @@ static void stm32_hash_write_ctrl(struct stm32_hash_dev *hdev, int bufcnt)
 
 		hdev->flags |= HASH_FLAGS_INIT;
 
+		/*
+		 * After first block + 1 words are fill up,
+		 * we only need to fill 1 block to start partial computation
+		 */
+		rctx->state.blocklen -= sizeof(u32);
+
 		dev_dbg(hdev->dev, "Write Control %x\n", reg);
 	}
 }
@@ -327,9 +338,9 @@ static void stm32_hash_append_sg(struct stm32_hash_request_ctx *rctx)
 	struct stm32_hash_state *state = &rctx->state;
 	size_t count;
 
-	while ((state->bufcnt < state->buflen) && rctx->total) {
+	while ((state->bufcnt < state->blocklen) && rctx->total) {
 		count = min(rctx->sg->length - rctx->offset, rctx->total);
-		count = min_t(size_t, count, state->buflen - state->bufcnt);
+		count = min_t(size_t, count, state->blocklen - state->bufcnt);
 
 		if (count <= 0) {
 			if ((rctx->sg->length == 0) && !sg_is_last(rctx->sg)) {
@@ -419,20 +430,59 @@ static int stm32_hash_xmit_cpu(struct stm32_hash_dev *hdev,
 	return 0;
 }
 
+static int hash_swap_reg(struct stm32_hash_request_ctx *rctx)
+{
+	struct stm32_hash_state *state = &rctx->state;
+
+	switch ((state->flags & HASH_FLAGS_ALGO_MASK) >>
+		HASH_FLAGS_ALGO_SHIFT) {
+	case HASH_MD5:
+	case HASH_SHA1:
+	case HASH_SHA224:
+	case HASH_SHA256:
+		if (state->flags & HASH_FLAGS_HMAC)
+			return HASH_CSR_NB_SHA256_HMAC;
+		else
+			return HASH_CSR_NB_SHA256;
+		break;
+
+	case HASH_SHA384:
+	case HASH_SHA512:
+		if (state->flags & HASH_FLAGS_HMAC)
+			return HASH_CSR_NB_SHA512_HMAC;
+		else
+			return HASH_CSR_NB_SHA512;
+		break;
+
+	case HASH_SHA3_224:
+	case HASH_SHA3_256:
+	case HASH_SHA3_384:
+	case HASH_SHA3_512:
+		if (state->flags & HASH_FLAGS_HMAC)
+			return HASH_CSR_NB_SHA3_HMAC;
+		else
+			return HASH_CSR_NB_SHA3;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+}
+
 static int stm32_hash_update_cpu(struct stm32_hash_dev *hdev)
 {
 	struct stm32_hash_request_ctx *rctx = ahash_request_ctx(hdev->req);
 	struct stm32_hash_state *state = &rctx->state;
 	u32 *preg = state->hw_context;
 	int bufcnt, err = 0, final;
-	int i;
+	int i, swap_reg;
 
 	dev_dbg(hdev->dev, "%s flags %x\n", __func__, state->flags);
 
 	final = state->flags & HASH_FLAGS_FINAL;
 
-	while ((rctx->total >= state->buflen) ||
-	       (state->bufcnt + rctx->total >= state->buflen)) {
+	while ((rctx->total >= state->blocklen) ||
+	       (state->bufcnt + rctx->total >= state->blocklen)) {
 		stm32_hash_append_sg(rctx);
 		bufcnt = state->bufcnt;
 		state->bufcnt = 0;
@@ -455,11 +505,13 @@ static int stm32_hash_update_cpu(struct stm32_hash_dev *hdev)
 	if (stm32_hash_wait_busy(hdev))
 		return -ETIMEDOUT;
 
+	swap_reg = hash_swap_reg(rctx);
+
 	if (!hdev->pdata->ux500)
 		*preg++ = stm32_hash_read(hdev, HASH_IMR);
 	*preg++ = stm32_hash_read(hdev, HASH_STR);
 	*preg++ = stm32_hash_read(hdev, HASH_CR);
-	for (i = 0; i < HASH_CSR_REGISTER_NUMBER; i++)
+	for (i = 0; i < swap_reg; i++)
 		*preg++ = stm32_hash_read(hdev, HASH_CSR(i));
 
 	state->flags |= HASH_FLAGS_INIT;
@@ -544,7 +596,7 @@ static int stm32_hash_hmac_dma_send(struct stm32_hash_dev *hdev)
 	struct stm32_hash_ctx *ctx = crypto_ahash_ctx(tfm);
 	int err;
 
-	if (ctx->keylen < HASH_DMA_THRESHOLD || (hdev->dma_mode == 1)) {
+	if (ctx->keylen < rctx->state.blocklen || hdev->dma_mode == 1) {
 		err = stm32_hash_write_key(hdev);
 		if (stm32_hash_wait_busy(hdev))
 			return -ETIMEDOUT;
@@ -579,8 +631,8 @@ static int stm32_hash_dma_init(struct stm32_hash_dev *hdev)
 	dma_conf.direction = DMA_MEM_TO_DEV;
 	dma_conf.dst_addr = hdev->phys_base + HASH_DIN;
 	dma_conf.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-	dma_conf.src_maxburst = hdev->dma_maxburst;
-	dma_conf.dst_maxburst = hdev->dma_maxburst;
+	dma_conf.src_maxburst = HASH_BURST_LEVEL;
+	dma_conf.dst_maxburst = HASH_BURST_LEVEL;
 	dma_conf.device_fc = false;
 
 	chan = dma_request_chan(hdev->dev, "in");
@@ -614,7 +666,6 @@ static int stm32_hash_dma_send(struct stm32_hash_dev *hdev)
 	rctx->total = hdev->req->nbytes;
 
 	rctx->nents = sg_nents(rctx->sg);
-
 	if (rctx->nents < 0)
 		return -EINVAL;
 
@@ -718,11 +769,12 @@ static struct stm32_hash_dev *stm32_hash_find_dev(struct stm32_hash_ctx *ctx)
 static bool stm32_hash_dma_aligned_data(struct ahash_request *req)
 {
 	struct scatterlist *sg;
+	struct stm32_hash_request_ctx *rctx = ahash_request_ctx(req);
 	struct stm32_hash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(req));
 	struct stm32_hash_dev *hdev = stm32_hash_find_dev(ctx);
 	int i;
 
-	if (req->nbytes <= HASH_DMA_THRESHOLD)
+	if (!hdev->dma_lch || req->nbytes <= rctx->state.blocklen)
 		return false;
 
 	if (sg_nents(req->src) > 1) {
@@ -748,31 +800,64 @@ static int stm32_hash_init(struct ahash_request *req)
 	struct stm32_hash_request_ctx *rctx = ahash_request_ctx(req);
 	struct stm32_hash_dev *hdev = stm32_hash_find_dev(ctx);
 	struct stm32_hash_state *state = &rctx->state;
+	bool sha3_mode = ctx->flags & HASH_FLAGS_SHA3_MODE;
 
 	rctx->hdev = hdev;
 
 	state->flags = HASH_FLAGS_CPU;
 
+	if (sha3_mode)
+		state->flags |= HASH_FLAGS_SHA3_MODE;
+
 	rctx->digcnt = crypto_ahash_digestsize(tfm);
 	switch (rctx->digcnt) {
 	case MD5_DIGEST_SIZE:
-		state->flags |= HASH_FLAGS_MD5;
+		state->flags |= HASH_MD5 << HASH_FLAGS_ALGO_SHIFT;
 		break;
 	case SHA1_DIGEST_SIZE:
-		state->flags |= HASH_FLAGS_SHA1;
+		if (hdev->pdata->ux500)
+			state->flags |= HASH_SHA1_UX500 << HASH_FLAGS_ALGO_SHIFT;
+		else
+			state->flags |= HASH_SHA1 << HASH_FLAGS_ALGO_SHIFT;
 		break;
 	case SHA224_DIGEST_SIZE:
-		state->flags |= HASH_FLAGS_SHA224;
+		if (sha3_mode)
+			state->flags |= HASH_SHA3_224 << HASH_FLAGS_ALGO_SHIFT;
+		else
+			state->flags |= HASH_SHA224 << HASH_FLAGS_ALGO_SHIFT;
 		break;
 	case SHA256_DIGEST_SIZE:
-		state->flags |= HASH_FLAGS_SHA256;
+		if (sha3_mode) {
+			state->flags |= HASH_SHA3_256 << HASH_FLAGS_ALGO_SHIFT;
+		} else {
+			if (hdev->pdata->ux500)
+				state->flags |= HASH_SHA256_UX500 << HASH_FLAGS_ALGO_SHIFT;
+			else
+				state->flags |= HASH_SHA256 << HASH_FLAGS_ALGO_SHIFT;
+		}
+		break;
+	case SHA384_DIGEST_SIZE:
+		if (sha3_mode)
+			state->flags |= HASH_SHA3_384 << HASH_FLAGS_ALGO_SHIFT;
+		else
+			state->flags |= HASH_SHA384 << HASH_FLAGS_ALGO_SHIFT;
+		break;
+	case SHA512_DIGEST_SIZE:
+		if (sha3_mode)
+			state->flags |= HASH_SHA3_512 << HASH_FLAGS_ALGO_SHIFT;
+		else
+			state->flags |= HASH_SHA512 << HASH_FLAGS_ALGO_SHIFT;
 		break;
 	default:
 		return -EINVAL;
 	}
 
 	rctx->state.bufcnt = 0;
-	rctx->state.buflen = HASH_BUFLEN;
+	rctx->state.blocklen = crypto_ahash_blocksize(tfm) + sizeof(u32);
+	if (rctx->state.blocklen > HASH_BUFLEN) {
+		dev_err(hdev->dev, "Error, block too large");
+		return -EINVAL;
+	}
 	rctx->total = 0;
 	rctx->offset = 0;
 	rctx->data_type = HASH_DATA_8_BITS;
@@ -842,6 +927,7 @@ static void stm32_hash_emptymsg_fallback(struct ahash_request *req)
 
 static void stm32_hash_copy_hash(struct ahash_request *req)
 {
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
 	struct stm32_hash_request_ctx *rctx = ahash_request_ctx(req);
 	struct stm32_hash_state *state = &rctx->state;
 	struct stm32_hash_dev *hdev = rctx->hdev;
@@ -851,22 +937,7 @@ static void stm32_hash_copy_hash(struct ahash_request *req)
 	if (hdev->pdata->broken_emptymsg && (state->flags & HASH_FLAGS_EMPTY))
 		return stm32_hash_emptymsg_fallback(req);
 
-	switch (state->flags & HASH_FLAGS_ALGO_MASK) {
-	case HASH_FLAGS_MD5:
-		hashsize = MD5_DIGEST_SIZE;
-		break;
-	case HASH_FLAGS_SHA1:
-		hashsize = SHA1_DIGEST_SIZE;
-		break;
-	case HASH_FLAGS_SHA224:
-		hashsize = SHA224_DIGEST_SIZE;
-		break;
-	case HASH_FLAGS_SHA256:
-		hashsize = SHA256_DIGEST_SIZE;
-		break;
-	default:
-		return;
-	}
+	hashsize = crypto_ahash_digestsize(tfm);
 
 	for (i = 0; i < hashsize / sizeof(u32); i++) {
 		if (hdev->pdata->ux500)
@@ -881,6 +952,11 @@ static void stm32_hash_copy_hash(struct ahash_request *req)
 static int stm32_hash_finish(struct ahash_request *req)
 {
 	struct stm32_hash_request_ctx *rctx = ahash_request_ctx(req);
+	u32 reg;
+
+	reg = stm32_hash_read(rctx->hdev, HASH_SR);
+	reg &= ~HASH_SR_OUTPUT_READY;
+	stm32_hash_write(rctx->hdev, HASH_SR, reg);
 
 	if (!req->result)
 		return -EINVAL;
@@ -920,6 +996,7 @@ static int stm32_hash_one_request(struct crypto_engine *engine, void *areq)
 	struct stm32_hash_request_ctx *rctx = ahash_request_ctx(req);
 	struct stm32_hash_dev *hdev = stm32_hash_find_dev(ctx);
 	struct stm32_hash_state *state = &rctx->state;
+	int swap_reg;
 	int err = 0;
 
 	if (!hdev)
@@ -932,6 +1009,7 @@ static int stm32_hash_one_request(struct crypto_engine *engine, void *areq)
 
 	hdev->req = req;
 	hdev->flags = 0;
+	swap_reg = hash_swap_reg(rctx);
 
 	if (state->flags & HASH_FLAGS_INIT) {
 		u32 *preg = rctx->state.hw_context;
@@ -945,7 +1023,7 @@ static int stm32_hash_one_request(struct crypto_engine *engine, void *areq)
 		reg = *preg++ | HASH_CR_INIT;
 		stm32_hash_write(hdev, HASH_CR, reg);
 
-		for (i = 0; i < HASH_CSR_REGISTER_NUMBER; i++)
+		for (i = 0; i < swap_reg; i++)
 			stm32_hash_write(hdev, HASH_CSR(i), *preg++);
 
 		hdev->flags |= HASH_FLAGS_INIT;
@@ -1000,7 +1078,7 @@ static int stm32_hash_update(struct ahash_request *req)
 	rctx->sg = req->src;
 	rctx->offset = 0;
 
-	if ((state->bufcnt + rctx->total < state->buflen)) {
+	if ((state->bufcnt + rctx->total < state->blocklen)) {
 		stm32_hash_append_sg(rctx);
 		return 0;
 	}
@@ -1102,8 +1180,7 @@ static int stm32_hash_init_fallback(struct crypto_tfm *tfm)
 	return 0;
 }
 
-static int stm32_hash_cra_init_algs(struct crypto_tfm *tfm,
-				    const char *algs_hmac_name)
+static int stm32_hash_cra_init_algs(struct crypto_tfm *tfm, u32 algs_flags)
 {
 	struct stm32_hash_ctx *ctx = crypto_tfm_ctx(tfm);
 
@@ -1112,8 +1189,8 @@ static int stm32_hash_cra_init_algs(struct crypto_tfm *tfm,
 
 	ctx->keylen = 0;
 
-	if (algs_hmac_name)
-		ctx->flags |= HASH_FLAGS_HMAC;
+	if (algs_flags)
+		ctx->flags |= algs_flags;
 
 	ctx->enginectx.op.do_one_request = stm32_hash_one_request;
 
@@ -1122,28 +1199,25 @@ static int stm32_hash_cra_init_algs(struct crypto_tfm *tfm,
 
 static int stm32_hash_cra_init(struct crypto_tfm *tfm)
 {
-	return stm32_hash_cra_init_algs(tfm, NULL);
+	return stm32_hash_cra_init_algs(tfm, 0);
 }
 
-static int stm32_hash_cra_md5_init(struct crypto_tfm *tfm)
+static int stm32_hash_cra_hmac_init(struct crypto_tfm *tfm)
 {
-	return stm32_hash_cra_init_algs(tfm, "md5");
+	return stm32_hash_cra_init_algs(tfm, HASH_FLAGS_HMAC);
 }
 
-static int stm32_hash_cra_sha1_init(struct crypto_tfm *tfm)
+static int stm32_hash_cra_sha3_init(struct crypto_tfm *tfm)
 {
-	return stm32_hash_cra_init_algs(tfm, "sha1");
+	return stm32_hash_cra_init_algs(tfm, HASH_FLAGS_SHA3_MODE);
 }
 
-static int stm32_hash_cra_sha224_init(struct crypto_tfm *tfm)
+static int stm32_hash_cra_sha3_hmac_init(struct crypto_tfm *tfm)
 {
-	return stm32_hash_cra_init_algs(tfm, "sha224");
+	return stm32_hash_cra_init_algs(tfm, HASH_FLAGS_SHA3_MODE |
+					HASH_FLAGS_HMAC);
 }
 
-static int stm32_hash_cra_sha256_init(struct crypto_tfm *tfm)
-{
-	return stm32_hash_cra_init_algs(tfm, "sha256");
-}
 
 static void stm32_hash_cra_exit(struct crypto_tfm *tfm)
 {
@@ -1185,8 +1259,6 @@ static irqreturn_t stm32_hash_irq_handler(int irq, void *dev_id)
 
 	reg = stm32_hash_read(hdev, HASH_SR);
 	if (reg & HASH_SR_OUTPUT_READY) {
-		reg &= ~HASH_SR_OUTPUT_READY;
-		stm32_hash_write(hdev, HASH_SR, reg);
 		hdev->flags |= HASH_FLAGS_OUTPUT_READY;
 		/* Disable IT*/
 		stm32_hash_write(hdev, HASH_IMR, 0);
@@ -1244,12 +1316,12 @@ static struct ahash_alg algs_md5[] = {
 				.cra_blocksize = MD5_HMAC_BLOCK_SIZE,
 				.cra_ctxsize = sizeof(struct stm32_hash_ctx),
 				.cra_alignmask = 3,
-				.cra_init = stm32_hash_cra_md5_init,
+				.cra_init = stm32_hash_cra_hmac_init,
 				.cra_exit = stm32_hash_cra_exit,
 				.cra_module = THIS_MODULE,
 			}
 		}
-	},
+	}
 };
 
 static struct ahash_alg algs_sha1[] = {
@@ -1300,7 +1372,7 @@ static struct ahash_alg algs_sha1[] = {
 				.cra_blocksize = SHA1_BLOCK_SIZE,
 				.cra_ctxsize = sizeof(struct stm32_hash_ctx),
 				.cra_alignmask = 3,
-				.cra_init = stm32_hash_cra_sha1_init,
+				.cra_init = stm32_hash_cra_hmac_init,
 				.cra_exit = stm32_hash_cra_exit,
 				.cra_module = THIS_MODULE,
 			}
@@ -1356,7 +1428,7 @@ static struct ahash_alg algs_sha224[] = {
 				.cra_blocksize = SHA224_BLOCK_SIZE,
 				.cra_ctxsize = sizeof(struct stm32_hash_ctx),
 				.cra_alignmask = 3,
-				.cra_init = stm32_hash_cra_sha224_init,
+				.cra_init = stm32_hash_cra_hmac_init,
 				.cra_exit = stm32_hash_cra_exit,
 				.cra_module = THIS_MODULE,
 			}
@@ -1412,12 +1484,336 @@ static struct ahash_alg algs_sha256[] = {
 				.cra_blocksize = SHA256_BLOCK_SIZE,
 				.cra_ctxsize = sizeof(struct stm32_hash_ctx),
 				.cra_alignmask = 3,
-				.cra_init = stm32_hash_cra_sha256_init,
+				.cra_init = stm32_hash_cra_hmac_init,
+				.cra_exit = stm32_hash_cra_exit,
+				.cra_module = THIS_MODULE,
+			}
+		}
+	},
+};
+
+static struct ahash_alg algs_sha384_sha512[] = {
+	{
+		.init = stm32_hash_init,
+		.update = stm32_hash_update,
+		.final = stm32_hash_final,
+		.finup = stm32_hash_finup,
+		.digest = stm32_hash_digest,
+		.export = stm32_hash_export,
+		.import = stm32_hash_import,
+		.halg = {
+			.digestsize = SHA384_DIGEST_SIZE,
+			.statesize = sizeof(struct stm32_hash_state),
+			.base = {
+				.cra_name = "sha384",
+				.cra_driver_name = "stm32-sha384",
+				.cra_priority = 200,
+				.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY,
+				.cra_blocksize = SHA384_BLOCK_SIZE,
+				.cra_ctxsize = sizeof(struct stm32_hash_ctx),
+				.cra_alignmask = 3,
+				.cra_init = stm32_hash_cra_init,
+				.cra_exit = stm32_hash_cra_exit,
+				.cra_module = THIS_MODULE,
+			}
+		}
+	},
+	{
+		.init = stm32_hash_init,
+		.update = stm32_hash_update,
+		.final = stm32_hash_final,
+		.finup = stm32_hash_finup,
+		.digest = stm32_hash_digest,
+		.setkey = stm32_hash_setkey,
+		.export = stm32_hash_export,
+		.import = stm32_hash_import,
+		.halg = {
+			.digestsize = SHA384_DIGEST_SIZE,
+			.statesize = sizeof(struct stm32_hash_state),
+			.base = {
+				.cra_name = "hmac(sha384)",
+				.cra_driver_name = "stm32-hmac-sha384",
+				.cra_priority = 200,
+				.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY,
+				.cra_blocksize = SHA384_BLOCK_SIZE,
+				.cra_ctxsize = sizeof(struct stm32_hash_ctx),
+				.cra_alignmask = 3,
+				.cra_init = stm32_hash_cra_hmac_init,
+				.cra_exit = stm32_hash_cra_exit,
+				.cra_module = THIS_MODULE,
+			}
+		}
+	},
+	{
+		.init = stm32_hash_init,
+		.update = stm32_hash_update,
+		.final = stm32_hash_final,
+		.finup = stm32_hash_finup,
+		.digest = stm32_hash_digest,
+		.export = stm32_hash_export,
+		.import = stm32_hash_import,
+		.halg = {
+			.digestsize = SHA512_DIGEST_SIZE,
+			.statesize = sizeof(struct stm32_hash_state),
+			.base = {
+				.cra_name = "sha512",
+				.cra_driver_name = "stm32-sha512",
+				.cra_priority = 200,
+				.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY,
+				.cra_blocksize = SHA512_BLOCK_SIZE,
+				.cra_ctxsize = sizeof(struct stm32_hash_ctx),
+				.cra_alignmask = 3,
+				.cra_init = stm32_hash_cra_init,
+				.cra_exit = stm32_hash_cra_exit,
+				.cra_module = THIS_MODULE,
+			}
+		}
+	},
+	{
+		.init = stm32_hash_init,
+		.update = stm32_hash_update,
+		.final = stm32_hash_final,
+		.finup = stm32_hash_finup,
+		.digest = stm32_hash_digest,
+		.export = stm32_hash_export,
+		.import = stm32_hash_import,
+		.setkey = stm32_hash_setkey,
+		.halg = {
+			.digestsize = SHA512_DIGEST_SIZE,
+			.statesize = sizeof(struct stm32_hash_state),
+			.base = {
+				.cra_name = "hmac(sha512)",
+				.cra_driver_name = "stm32-hmac-sha512",
+				.cra_priority = 200,
+				.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY,
+				.cra_blocksize = SHA512_BLOCK_SIZE,
+				.cra_ctxsize = sizeof(struct stm32_hash_ctx),
+				.cra_alignmask = 3,
+				.cra_init = stm32_hash_cra_hmac_init,
+				.cra_exit = stm32_hash_cra_exit,
+				.cra_module = THIS_MODULE,
+			}
+		}
+	},
+};
+
+static struct ahash_alg algs_sha3[] = {
+	{
+		.init = stm32_hash_init,
+		.update = stm32_hash_update,
+		.final = stm32_hash_final,
+		.finup = stm32_hash_finup,
+		.digest = stm32_hash_digest,
+		.export = stm32_hash_export,
+		.import = stm32_hash_import,
+		.halg = {
+			.digestsize = SHA3_224_DIGEST_SIZE,
+			.statesize = sizeof(struct stm32_hash_state),
+			.base = {
+				.cra_name = "sha3-224",
+				.cra_driver_name = "stm32-sha3-224",
+				.cra_priority = 200,
+				.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY,
+				.cra_blocksize = SHA3_224_BLOCK_SIZE,
+				.cra_ctxsize = sizeof(struct stm32_hash_ctx),
+				.cra_alignmask = 3,
+				.cra_init = stm32_hash_cra_sha3_init,
 				.cra_exit = stm32_hash_cra_exit,
 				.cra_module = THIS_MODULE,
 			}
 		}
 	},
+	{
+		.init = stm32_hash_init,
+		.update = stm32_hash_update,
+		.final = stm32_hash_final,
+		.finup = stm32_hash_finup,
+		.digest = stm32_hash_digest,
+		.export = stm32_hash_export,
+		.import = stm32_hash_import,
+		.setkey = stm32_hash_setkey,
+		.halg = {
+			.digestsize = SHA3_224_DIGEST_SIZE,
+			.statesize = sizeof(struct stm32_hash_state),
+			.base = {
+				.cra_name = "hmac(sha3-224)",
+				.cra_driver_name = "stm32-hmac-sha3-224",
+				.cra_priority = 200,
+				.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY,
+				.cra_blocksize = SHA3_224_BLOCK_SIZE,
+				.cra_ctxsize = sizeof(struct stm32_hash_ctx),
+				.cra_alignmask = 3,
+				.cra_init = stm32_hash_cra_sha3_hmac_init,
+				.cra_exit = stm32_hash_cra_exit,
+				.cra_module = THIS_MODULE,
+			}
+		}
+	},
+		{
+		.init = stm32_hash_init,
+		.update = stm32_hash_update,
+		.final = stm32_hash_final,
+		.finup = stm32_hash_finup,
+		.digest = stm32_hash_digest,
+		.export = stm32_hash_export,
+		.import = stm32_hash_import,
+		.halg = {
+			.digestsize = SHA3_256_DIGEST_SIZE,
+			.statesize = sizeof(struct stm32_hash_state),
+			.base = {
+				.cra_name = "sha3-256",
+				.cra_driver_name = "stm32-sha3-256",
+				.cra_priority = 200,
+				.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY,
+				.cra_blocksize = SHA3_256_BLOCK_SIZE,
+				.cra_ctxsize = sizeof(struct stm32_hash_ctx),
+				.cra_alignmask = 3,
+				.cra_init = stm32_hash_cra_sha3_init,
+				.cra_exit = stm32_hash_cra_exit,
+				.cra_module = THIS_MODULE,
+			}
+		}
+	},
+	{
+		.init = stm32_hash_init,
+		.update = stm32_hash_update,
+		.final = stm32_hash_final,
+		.finup = stm32_hash_finup,
+		.digest = stm32_hash_digest,
+		.export = stm32_hash_export,
+		.import = stm32_hash_import,
+		.setkey = stm32_hash_setkey,
+		.halg = {
+			.digestsize = SHA3_256_DIGEST_SIZE,
+			.statesize = sizeof(struct stm32_hash_state),
+			.base = {
+				.cra_name = "hmac(sha3-256)",
+				.cra_driver_name = "stm32-hmac-sha3-256",
+				.cra_priority = 200,
+				.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY,
+				.cra_blocksize = SHA3_256_BLOCK_SIZE,
+				.cra_ctxsize = sizeof(struct stm32_hash_ctx),
+				.cra_alignmask = 3,
+				.cra_init = stm32_hash_cra_sha3_hmac_init,
+				.cra_exit = stm32_hash_cra_exit,
+				.cra_module = THIS_MODULE,
+			}
+		}
+	},
+	{
+		.init = stm32_hash_init,
+		.update = stm32_hash_update,
+		.final = stm32_hash_final,
+		.finup = stm32_hash_finup,
+		.digest = stm32_hash_digest,
+		.export = stm32_hash_export,
+		.import = stm32_hash_import,
+		.halg = {
+			.digestsize = SHA3_384_DIGEST_SIZE,
+			.statesize = sizeof(struct stm32_hash_state),
+			.base = {
+				.cra_name = "sha3-384",
+				.cra_driver_name = "stm32-sha3-384",
+				.cra_priority = 200,
+				.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY,
+				.cra_blocksize = SHA3_384_BLOCK_SIZE,
+				.cra_ctxsize = sizeof(struct stm32_hash_ctx),
+				.cra_alignmask = 3,
+				.cra_init = stm32_hash_cra_sha3_init,
+				.cra_exit = stm32_hash_cra_exit,
+				.cra_module = THIS_MODULE,
+			}
+		}
+	},
+	{
+		.init = stm32_hash_init,
+		.update = stm32_hash_update,
+		.final = stm32_hash_final,
+		.finup = stm32_hash_finup,
+		.digest = stm32_hash_digest,
+		.export = stm32_hash_export,
+		.import = stm32_hash_import,
+		.setkey = stm32_hash_setkey,
+		.halg = {
+			.digestsize = SHA3_384_DIGEST_SIZE,
+			.statesize = sizeof(struct stm32_hash_state),
+			.base = {
+				.cra_name = "hmac(sha3-384)",
+				.cra_driver_name = "stm32-hmac-sha3-384",
+				.cra_priority = 200,
+				.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY,
+				.cra_blocksize = SHA3_384_BLOCK_SIZE,
+				.cra_ctxsize = sizeof(struct stm32_hash_ctx),
+				.cra_alignmask = 3,
+				.cra_init = stm32_hash_cra_sha3_hmac_init,
+				.cra_exit = stm32_hash_cra_exit,
+				.cra_module = THIS_MODULE,
+			}
+		}
+	},
+	{
+		.init = stm32_hash_init,
+		.update = stm32_hash_update,
+		.final = stm32_hash_final,
+		.finup = stm32_hash_finup,
+		.digest = stm32_hash_digest,
+		.export = stm32_hash_export,
+		.import = stm32_hash_import,
+		.halg = {
+			.digestsize = SHA3_512_DIGEST_SIZE,
+			.statesize = sizeof(struct stm32_hash_state),
+			.base = {
+				.cra_name = "sha3-512",
+				.cra_driver_name = "stm32-sha3-512",
+				.cra_priority = 200,
+				.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY,
+				.cra_blocksize = SHA3_512_BLOCK_SIZE,
+				.cra_ctxsize = sizeof(struct stm32_hash_ctx),
+				.cra_alignmask = 3,
+				.cra_init = stm32_hash_cra_sha3_init,
+				.cra_exit = stm32_hash_cra_exit,
+				.cra_module = THIS_MODULE,
+			}
+		}
+	},
+	{
+		.init = stm32_hash_init,
+		.update = stm32_hash_update,
+		.final = stm32_hash_final,
+		.finup = stm32_hash_finup,
+		.digest = stm32_hash_digest,
+		.export = stm32_hash_export,
+		.import = stm32_hash_import,
+		.setkey = stm32_hash_setkey,
+		.halg = {
+			.digestsize = SHA3_512_DIGEST_SIZE,
+			.statesize = sizeof(struct stm32_hash_state),
+			.base = {
+				.cra_name = "hmac(sha3-512)",
+				.cra_driver_name = "stm32-hmac-sha3-512",
+				.cra_priority = 200,
+				.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY,
+				.cra_blocksize = SHA3_512_BLOCK_SIZE,
+				.cra_ctxsize = sizeof(struct stm32_hash_ctx),
+				.cra_alignmask = 3,
+				.cra_init = stm32_hash_cra_sha3_hmac_init,
+				.cra_exit = stm32_hash_cra_exit,
+				.cra_module = THIS_MODULE,
+			}
+		}
+	}
 };
 
 static int stm32_hash_register_algs(struct stm32_hash_dev *hdev)
@@ -1471,6 +1867,7 @@ static struct stm32_hash_algs_info stm32_hash_algs_info_ux500[] = {
 };
 
 static const struct stm32_hash_pdata stm32_hash_pdata_ux500 = {
+	.alg_shift	= 7,
 	.algs_info	= stm32_hash_algs_info_ux500,
 	.algs_info_size	= ARRAY_SIZE(stm32_hash_algs_info_ux500),
 	.broken_emptymsg = true,
@@ -1489,6 +1886,7 @@ static struct stm32_hash_algs_info stm32_hash_algs_info_stm32f4[] = {
 };
 
 static const struct stm32_hash_pdata stm32_hash_pdata_stm32f4 = {
+	.alg_shift	= 7,
 	.algs_info	= stm32_hash_algs_info_stm32f4,
 	.algs_info_size	= ARRAY_SIZE(stm32_hash_algs_info_stm32f4),
 	.has_sr		= true,
@@ -1515,25 +1913,49 @@ static struct stm32_hash_algs_info stm32_hash_algs_info_stm32f7[] = {
 };
 
 static const struct stm32_hash_pdata stm32_hash_pdata_stm32f7 = {
+	.alg_shift	= 7,
 	.algs_info	= stm32_hash_algs_info_stm32f7,
 	.algs_info_size	= ARRAY_SIZE(stm32_hash_algs_info_stm32f7),
 	.has_sr		= true,
 	.has_mdmat	= true,
 };
 
-static const struct of_device_id stm32_hash_of_match[] = {
+static struct stm32_hash_algs_info stm32_hash_algs_info_stm32mp13[] = {
+	{
+		.algs_list	= algs_sha1,
+		.size		= ARRAY_SIZE(algs_sha1),
+	},
+	{
+		.algs_list	= algs_sha224,
+		.size		= ARRAY_SIZE(algs_sha224),
+	},
 	{
-		.compatible = "stericsson,ux500-hash",
-		.data = &stm32_hash_pdata_ux500,
+		.algs_list	= algs_sha256,
+		.size		= ARRAY_SIZE(algs_sha256),
 	},
 	{
-		.compatible = "st,stm32f456-hash",
-		.data = &stm32_hash_pdata_stm32f4,
+		.algs_list	= algs_sha384_sha512,
+		.size		= ARRAY_SIZE(algs_sha384_sha512),
 	},
 	{
-		.compatible = "st,stm32f756-hash",
-		.data = &stm32_hash_pdata_stm32f7,
+		.algs_list	= algs_sha3,
+		.size		= ARRAY_SIZE(algs_sha3),
 	},
+};
+
+static const struct stm32_hash_pdata stm32_hash_pdata_stm32mp13 = {
+	.alg_shift	= 17,
+	.algs_info	= stm32_hash_algs_info_stm32mp13,
+	.algs_info_size	= ARRAY_SIZE(stm32_hash_algs_info_stm32mp13),
+	.has_sr		= true,
+	.has_mdmat	= true,
+};
+
+static const struct of_device_id stm32_hash_of_match[] = {
+	{ .compatible = "stericsson,ux500-hash", .data = &stm32_hash_pdata_ux500 },
+	{ .compatible = "st,stm32f456-hash", .data = &stm32_hash_pdata_stm32f4 },
+	{ .compatible = "st,stm32f756-hash", .data = &stm32_hash_pdata_stm32f7 },
+	{ .compatible = "st,stm32mp13-hash", .data = &stm32_hash_pdata_stm32mp13 },
 	{},
 };
 
@@ -1548,12 +1970,6 @@ static int stm32_hash_get_of_match(struct stm32_hash_dev *hdev,
 		return -EINVAL;
 	}
 
-	if (of_property_read_u32(dev->of_node, "dma-maxburst",
-				 &hdev->dma_maxburst)) {
-		dev_info(dev, "dma-maxburst not specified, using 0\n");
-		hdev->dma_maxburst = 0;
-	}
-
 	return 0;
 }
 
@@ -1663,7 +2079,7 @@ static int stm32_hash_probe(struct platform_device *pdev)
 		/* FIXME: implement DMA mode for Ux500 */
 		hdev->dma_mode = 0;
 	else
-		hdev->dma_mode = stm32_hash_read(hdev, HASH_HWCFGR);
+		hdev->dma_mode = stm32_hash_read(hdev, HASH_HWCFGR) & HASH_HWCFG_DMA_MASK;
 
 	/* Register algos */
 	ret = stm32_hash_register_algs(hdev);
@@ -1772,6 +2188,6 @@ static struct platform_driver stm32_hash_driver = {
 
 module_platform_driver(stm32_hash_driver);
 
-MODULE_DESCRIPTION("STM32 SHA1/224/256 & MD5 (HMAC) hw accelerator driver");
+MODULE_DESCRIPTION("STM32 SHA1/SHA2/SHA3 & MD5 (HMAC) hw accelerator driver");
 MODULE_AUTHOR("Lionel Debieve <lionel.debieve@st.com>");
 MODULE_LICENSE("GPL v2");
-- 
2.25.1

