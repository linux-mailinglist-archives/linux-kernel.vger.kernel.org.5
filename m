Return-Path: <linux-kernel+bounces-129157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D105B896622
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15FB028660A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E0D5C90F;
	Wed,  3 Apr 2024 07:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="sCcAvxOv"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EF258ACE
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 07:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712128905; cv=none; b=Gzrrur5pTSBcMTuleIVR6hZ3Vj1/nyU0odyiJNEenQ1kCMwz/Lbz9XNnvQx/ElOB6Tc0S52jekHy/tq0vPI93rUBelKsV/U3wY/YEXiDQV+lK2FpIzVR+KCx3I250UHbfsz2LCKVGXj6rzNvsbbJamV1LQ1r3ZD3t1cTM1/vcyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712128905; c=relaxed/simple;
	bh=Pp+PWMknLeoCPLleVQShgDB1lm2/5LNqx4wH8PavKg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bkh1YwRibLq+fnQg+cj4VcbEyblHqglrkQpN12VidfBfQy8gokalXt5xIcUKbKXIvCX1ulkQJf2lRxn9FOcS7DmyifaKWGhNDKvbKsk9FWNpjDy0thWJsSoIsNa0BuPA9B6fAGHRUZ0CiQDQtwW6TDf77qsD9C0n0jkb8sB21Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=sCcAvxOv; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-415584360c0so25350535e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 00:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1712128901; x=1712733701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIG2sL6TE413lQBd5tWYvh6NYan1WxgVQ6EtXfg8N2A=;
        b=sCcAvxOvg9KNTVfVMh5kIeaKPSuA8BB3CmPeXQwZCp+H9XyFuYu2eJRftVfpjEAcL4
         1tfYomI0kZ6SbLf05rUcWtWDVAN8u8099k3JKnO7mwfpwoAatDz7kSgAoM4K1NsFhOw4
         xI2AEPY5UM7AaUzLYXoB4AIxkr15o7eatA7XY3/nBnk1ZkXTb11STY4y/v4t0tzoTQSr
         jF+pj8Pdj3jfmfAo0UEVqP9bkVzU+jm0wXF8KHKAJCR5mBnVZiVngfSjNOTuX/JEUyIH
         HSLAjWaQY6WDecIJCBx5x+u9uvPGQkA6GmfDIio6Hht14TgANT/kj4/VuX1+HbKOn5Qh
         F1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712128901; x=1712733701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zIG2sL6TE413lQBd5tWYvh6NYan1WxgVQ6EtXfg8N2A=;
        b=LYjgX0e9Qy4vFnIgNfGHRQwLntHCv/C5iMmcSA3hlWhChpTRf7BWZhUcISoNa1uQvI
         VaidqOh2E5EBe/3v5xU7INxC/25x2dC5Oe5dDXAU6jSyJDgZ7V2+qzs5hezawqqvlnoR
         3CVjvnQis9edEn4ikGV2O8Hn+Pp+eGkfJAoDblVAOmsZpUbOtX7GR3CGaDbI/T3AbVOD
         t/hYq6mWAp/689/PiibUVIkHha/yMdvacsmR0EcDuesjP8kGxkaYzkHCnxdKX3Jqs0HH
         IgLuLVjqretC7hXdWcOtFCm2zOkv4R2s8NbQzhIDhzxn4/GJeN65ckYIHM42faaySySF
         Ewag==
X-Forwarded-Encrypted: i=1; AJvYcCW9KsnU2JdJiKG9OivNKYtVZ92WWDMbzh7DWtXVDWigBEJnUkS/9BiRMcT0MGvjgZw2TJlKfpcugyz0TfedgUw4aSDdkmE+k4qnH02F
X-Gm-Message-State: AOJu0YzMIk/nMMbTCitEtGIW2oFclj3k79LW0Ku+RvI6oeT9tliC9bxP
	cEYVWhnUWE/1u2rD1NrUgq+yQa9sz64AC33U785p9rPfHEN12XZ+L9SzkISO8bw=
X-Google-Smtp-Source: AGHT+IE6fW/b0t2rFZINf3SmPKl+jCvzTvvCuzRr3g2sQB28tzY33JNdQDd4Xhbo6brzGrpqdyc/Bg==
X-Received: by 2002:a05:600c:4586:b0:416:244d:4871 with SMTP id r6-20020a05600c458600b00416244d4871mr375123wmo.17.1712128901574;
        Wed, 03 Apr 2024 00:21:41 -0700 (PDT)
Received: from localhost ([82.150.214.1])
        by smtp.gmail.com with UTF8SMTPSA id bt30-20020a056000081e00b0034183537986sm16693476wrb.23.2024.04.03.00.21.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 00:21:41 -0700 (PDT)
From: David Gstir <david@sigma-star.at>
To: Mimi Zohar <zohar@linux.ibm.com>,
	James Bottomley <jejb@linux.ibm.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: David Gstir <david@sigma-star.at>,
	Shawn Guo <shawnguo@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	sigma star Kernel Team <upstream+dcp@sigma-star.at>,
	David Howells <dhowells@redhat.com>,
	Li Yang <leoyang.li@nxp.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Tejun Heo <tj@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-security-module@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: [PATCH v8 1/6] crypto: mxs-dcp: Add support for hardware-bound keys
Date: Wed,  3 Apr 2024 09:21:17 +0200
Message-ID: <20240403072131.54935-2-david@sigma-star.at>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403072131.54935-1-david@sigma-star.at>
References: <20240403072131.54935-1-david@sigma-star.at>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DCP (Data Co-Processor) is able to derive private keys for a fused
random seed, which can be referenced by handle but not accessed by
the CPU. Similarly, DCP is able to store arbitrary keys in four
dedicated key slots located in its secure memory area (internal SRAM).
These keys can be used to perform AES encryption.

Expose these derived keys and key slots through the crypto API via their
handle. The main purpose is to add DCP-backed trusted keys. Other
use cases are possible too (see similar existing paes implementations),
but these should carefully be evaluated as e.g. enabling AF_ALG will
give userspace full access to use keys. In scenarios with untrustworthy
userspace, this will enable en-/decryption oracles.

Co-developed-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Richard Weinberger <richard@nod.at>
Co-developed-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Signed-off-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Signed-off-by: David Gstir <david@sigma-star.at>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/crypto/mxs-dcp.c | 104 ++++++++++++++++++++++++++++++++++-----
 include/soc/fsl/dcp.h    |  20 ++++++++
 2 files changed, 113 insertions(+), 11 deletions(-)
 create mode 100644 include/soc/fsl/dcp.h

diff --git a/drivers/crypto/mxs-dcp.c b/drivers/crypto/mxs-dcp.c
index 2b3ebe0db3a6..057d73c370b7 100644
--- a/drivers/crypto/mxs-dcp.c
+++ b/drivers/crypto/mxs-dcp.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/stmp_device.h>
 #include <linux/clk.h>
+#include <soc/fsl/dcp.h>
 
 #include <crypto/aes.h>
 #include <crypto/sha1.h>
@@ -101,6 +102,7 @@ struct dcp_async_ctx {
 	struct crypto_skcipher		*fallback;
 	unsigned int			key_len;
 	uint8_t				key[AES_KEYSIZE_128];
+	bool				key_referenced;
 };
 
 struct dcp_aes_req_ctx {
@@ -155,6 +157,7 @@ static struct dcp *global_sdcp;
 #define MXS_DCP_CONTROL0_HASH_TERM		(1 << 13)
 #define MXS_DCP_CONTROL0_HASH_INIT		(1 << 12)
 #define MXS_DCP_CONTROL0_PAYLOAD_KEY		(1 << 11)
+#define MXS_DCP_CONTROL0_OTP_KEY		(1 << 10)
 #define MXS_DCP_CONTROL0_CIPHER_ENCRYPT		(1 << 8)
 #define MXS_DCP_CONTROL0_CIPHER_INIT		(1 << 9)
 #define MXS_DCP_CONTROL0_ENABLE_HASH		(1 << 6)
@@ -168,6 +171,8 @@ static struct dcp *global_sdcp;
 #define MXS_DCP_CONTROL1_CIPHER_MODE_ECB	(0 << 4)
 #define MXS_DCP_CONTROL1_CIPHER_SELECT_AES128	(0 << 0)
 
+#define MXS_DCP_CONTROL1_KEY_SELECT_SHIFT	8
+
 static int mxs_dcp_start_dma(struct dcp_async_ctx *actx)
 {
 	int dma_err;
@@ -224,13 +229,16 @@ static int mxs_dcp_run_aes(struct dcp_async_ctx *actx,
 	struct dcp *sdcp = global_sdcp;
 	struct dcp_dma_desc *desc = &sdcp->coh->desc[actx->chan];
 	struct dcp_aes_req_ctx *rctx = skcipher_request_ctx(req);
+	bool key_referenced = actx->key_referenced;
 	int ret;
 
-	key_phys = dma_map_single(sdcp->dev, sdcp->coh->aes_key,
-				  2 * AES_KEYSIZE_128, DMA_TO_DEVICE);
-	ret = dma_mapping_error(sdcp->dev, key_phys);
-	if (ret)
-		return ret;
+	if (!key_referenced) {
+		key_phys = dma_map_single(sdcp->dev, sdcp->coh->aes_key,
+					  2 * AES_KEYSIZE_128, DMA_TO_DEVICE);
+		ret = dma_mapping_error(sdcp->dev, key_phys);
+		if (ret)
+			return ret;
+	}
 
 	src_phys = dma_map_single(sdcp->dev, sdcp->coh->aes_in_buf,
 				  DCP_BUF_SZ, DMA_TO_DEVICE);
@@ -255,8 +263,12 @@ static int mxs_dcp_run_aes(struct dcp_async_ctx *actx,
 		    MXS_DCP_CONTROL0_INTERRUPT |
 		    MXS_DCP_CONTROL0_ENABLE_CIPHER;
 
-	/* Payload contains the key. */
-	desc->control0 |= MXS_DCP_CONTROL0_PAYLOAD_KEY;
+	if (key_referenced)
+		/* Set OTP key bit to select the key via KEY_SELECT. */
+		desc->control0 |= MXS_DCP_CONTROL0_OTP_KEY;
+	else
+		/* Payload contains the key. */
+		desc->control0 |= MXS_DCP_CONTROL0_PAYLOAD_KEY;
 
 	if (rctx->enc)
 		desc->control0 |= MXS_DCP_CONTROL0_CIPHER_ENCRYPT;
@@ -270,6 +282,9 @@ static int mxs_dcp_run_aes(struct dcp_async_ctx *actx,
 	else
 		desc->control1 |= MXS_DCP_CONTROL1_CIPHER_MODE_CBC;
 
+	if (key_referenced)
+		desc->control1 |= sdcp->coh->aes_key[0] << MXS_DCP_CONTROL1_KEY_SELECT_SHIFT;
+
 	desc->next_cmd_addr = 0;
 	desc->source = src_phys;
 	desc->destination = dst_phys;
@@ -284,9 +299,9 @@ static int mxs_dcp_run_aes(struct dcp_async_ctx *actx,
 err_dst:
 	dma_unmap_single(sdcp->dev, src_phys, DCP_BUF_SZ, DMA_TO_DEVICE);
 err_src:
-	dma_unmap_single(sdcp->dev, key_phys, 2 * AES_KEYSIZE_128,
-			 DMA_TO_DEVICE);
-
+	if (!key_referenced)
+		dma_unmap_single(sdcp->dev, key_phys, 2 * AES_KEYSIZE_128,
+				 DMA_TO_DEVICE);
 	return ret;
 }
 
@@ -453,7 +468,7 @@ static int mxs_dcp_aes_enqueue(struct skcipher_request *req, int enc, int ecb)
 	struct dcp_aes_req_ctx *rctx = skcipher_request_ctx(req);
 	int ret;
 
-	if (unlikely(actx->key_len != AES_KEYSIZE_128))
+	if (unlikely(actx->key_len != AES_KEYSIZE_128 && !actx->key_referenced))
 		return mxs_dcp_block_fallback(req, enc);
 
 	rctx->enc = enc;
@@ -500,6 +515,7 @@ static int mxs_dcp_aes_setkey(struct crypto_skcipher *tfm, const u8 *key,
 	 * there can still be an operation in progress.
 	 */
 	actx->key_len = len;
+	actx->key_referenced = false;
 	if (len == AES_KEYSIZE_128) {
 		memcpy(actx->key, key, len);
 		return 0;
@@ -516,6 +532,32 @@ static int mxs_dcp_aes_setkey(struct crypto_skcipher *tfm, const u8 *key,
 	return crypto_skcipher_setkey(actx->fallback, key, len);
 }
 
+static int mxs_dcp_aes_setrefkey(struct crypto_skcipher *tfm, const u8 *key,
+				 unsigned int len)
+{
+	struct dcp_async_ctx *actx = crypto_skcipher_ctx(tfm);
+
+	if (len != DCP_PAES_KEYSIZE)
+		return -EINVAL;
+
+	switch (key[0]) {
+	case DCP_PAES_KEY_SLOT0:
+	case DCP_PAES_KEY_SLOT1:
+	case DCP_PAES_KEY_SLOT2:
+	case DCP_PAES_KEY_SLOT3:
+	case DCP_PAES_KEY_UNIQUE:
+	case DCP_PAES_KEY_OTP:
+		memcpy(actx->key, key, len);
+		actx->key_len = len;
+		actx->key_referenced = true;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int mxs_dcp_aes_fallback_init_tfm(struct crypto_skcipher *tfm)
 {
 	const char *name = crypto_tfm_alg_name(crypto_skcipher_tfm(tfm));
@@ -539,6 +581,13 @@ static void mxs_dcp_aes_fallback_exit_tfm(struct crypto_skcipher *tfm)
 	crypto_free_skcipher(actx->fallback);
 }
 
+static int mxs_dcp_paes_init_tfm(struct crypto_skcipher *tfm)
+{
+	crypto_skcipher_set_reqsize(tfm, sizeof(struct dcp_aes_req_ctx));
+
+	return 0;
+}
+
 /*
  * Hashing (SHA1/SHA256)
  */
@@ -889,6 +938,39 @@ static struct skcipher_alg dcp_aes_algs[] = {
 		.ivsize			= AES_BLOCK_SIZE,
 		.init			= mxs_dcp_aes_fallback_init_tfm,
 		.exit			= mxs_dcp_aes_fallback_exit_tfm,
+	}, {
+		.base.cra_name		= "ecb(paes)",
+		.base.cra_driver_name	= "ecb-paes-dcp",
+		.base.cra_priority	= 401,
+		.base.cra_alignmask	= 15,
+		.base.cra_flags		= CRYPTO_ALG_ASYNC | CRYPTO_ALG_INTERNAL,
+		.base.cra_blocksize	= AES_BLOCK_SIZE,
+		.base.cra_ctxsize	= sizeof(struct dcp_async_ctx),
+		.base.cra_module	= THIS_MODULE,
+
+		.min_keysize		= DCP_PAES_KEYSIZE,
+		.max_keysize		= DCP_PAES_KEYSIZE,
+		.setkey			= mxs_dcp_aes_setrefkey,
+		.encrypt		= mxs_dcp_aes_ecb_encrypt,
+		.decrypt		= mxs_dcp_aes_ecb_decrypt,
+		.init			= mxs_dcp_paes_init_tfm,
+	}, {
+		.base.cra_name		= "cbc(paes)",
+		.base.cra_driver_name	= "cbc-paes-dcp",
+		.base.cra_priority	= 401,
+		.base.cra_alignmask	= 15,
+		.base.cra_flags		= CRYPTO_ALG_ASYNC | CRYPTO_ALG_INTERNAL,
+		.base.cra_blocksize	= AES_BLOCK_SIZE,
+		.base.cra_ctxsize	= sizeof(struct dcp_async_ctx),
+		.base.cra_module	= THIS_MODULE,
+
+		.min_keysize		= DCP_PAES_KEYSIZE,
+		.max_keysize		= DCP_PAES_KEYSIZE,
+		.setkey			= mxs_dcp_aes_setrefkey,
+		.encrypt		= mxs_dcp_aes_cbc_encrypt,
+		.decrypt		= mxs_dcp_aes_cbc_decrypt,
+		.ivsize			= AES_BLOCK_SIZE,
+		.init			= mxs_dcp_paes_init_tfm,
 	},
 };
 
diff --git a/include/soc/fsl/dcp.h b/include/soc/fsl/dcp.h
new file mode 100644
index 000000000000..3ec335d8ca8b
--- /dev/null
+++ b/include/soc/fsl/dcp.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021 sigma star gmbh
+ *
+ * Specifies paes key slot handles for NXP's DCP (Data Co-Processor) to be used
+ * with the crypto_skcipher_setkey().
+ */
+
+#ifndef MXS_DCP_H
+#define MXS_DCP_H
+
+#define DCP_PAES_KEYSIZE 1
+#define DCP_PAES_KEY_SLOT0 0x00
+#define DCP_PAES_KEY_SLOT1 0x01
+#define DCP_PAES_KEY_SLOT2 0x02
+#define DCP_PAES_KEY_SLOT3 0x03
+#define DCP_PAES_KEY_UNIQUE 0xfe
+#define DCP_PAES_KEY_OTP 0xff
+
+#endif /* MXS_DCP_H */
-- 
2.35.3


