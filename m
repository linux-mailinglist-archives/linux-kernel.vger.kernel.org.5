Return-Path: <linux-kernel+bounces-22703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B810482A1D7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31A121F286F9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D7851032;
	Wed, 10 Jan 2024 20:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="SAnJ/8Hb"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B204EB40;
	Wed, 10 Jan 2024 20:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 37C3A120023;
	Wed, 10 Jan 2024 23:12:37 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 37C3A120023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1704917557;
	bh=PxOB1xz4AtKd1HVn7oKdXSIAL+4hmtGwlR+pbxMpkQQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=SAnJ/8HbNGE1ZssjQZ2+8os2WuyNv7WaAoXwngiMiCrCdMZuRAtaIhDqcXYuo3Pgx
	 oy/mHmBnGefpmz+KdO9+lvl3vzF2lOWwH2qOmAO7/NW52gA+DSv+2KGm+vQf2bxW0W
	 39pVnfBvTQJkqEvM5cckpsQIefyonBIs8DIloq8ecAqEoPwEAd1CPwnI1CR9hfAFBV
	 t1Ha+aa4ZX/j/S/8iBw2ba49QONj1dr+z0B1ObNl5FxXZvaxsxqZ5qq3vd47i0Ri9Q
	 9wPjZr17MjNIzdrKVFGsx2xVZGQR3AfS9ub+I4AwVJIcyZfRP2ftdR/Am/8ni4HpEY
	 v5RhnLBhR0wMg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 10 Jan 2024 23:12:37 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 23:12:36 +0300
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
Subject: [PATCH v1 12/24] drivers: crypto: meson: add support for AES-CTR
Date: Wed, 10 Jan 2024 23:11:28 +0300
Message-ID: <20240110201216.18016-13-avromanov@salutedevices.com>
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
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/01/10 17:01:00 #23071477
X-KSMG-AntiVirus-Status: Clean, skipped

From: Jan Dakinevich <yvdakinevich@salutedevices.com>

This patch adds support for AES-CTR algorithm.
Tested via tcrypt and custom tests.

Signed-off-by: Jan Dakinevich <yvdakinevich@salutedevices.com>
Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 drivers/crypto/amlogic/amlogic-gxl-cipher.c | 41 +++++++++++++++++++--
 drivers/crypto/amlogic/amlogic-gxl.h        |  1 +
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/amlogic/amlogic-gxl-cipher.c b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
index 6ff0e088939f..b60b65034b6e 100644
--- a/drivers/crypto/amlogic/amlogic-gxl-cipher.c
+++ b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
@@ -154,7 +154,7 @@ static void meson_setup_keyiv_descs(struct cipher_ctx *ctx)
 	if (ctx->tloffset)
 		return;
 
-	if (blockmode == DESC_OPMODE_CBC) {
+	if (blockmode == DESC_OPMODE_CBC || blockmode == DESC_OPMODE_CTR) {
 		memcpy(op->keyiv + AES_MAX_KEY_SIZE, ctx->areq->iv, ivsize);
 		dma_sync_single_for_device(mc->dev, ctx->keyiv.addr,
 					   ctx->keyiv.len, DMA_TO_DEVICE);
@@ -186,6 +186,7 @@ static bool meson_setup_data_descs(struct cipher_ctx *ctx)
 	struct meson_desc *desc = &mc->chanlist[rctx->flow].tl[ctx->tloffset];
 	unsigned int blocksize = crypto_skcipher_blocksize(tfm);
 	unsigned int blockmode = algt->blockmode;
+	unsigned int ivsize = crypto_skcipher_ivsize(tfm);
 	unsigned int maxlen = rounddown(DESC_MAXLEN, blocksize);
 	unsigned int todo;
 	u32 v;
@@ -204,8 +205,15 @@ static bool meson_setup_data_descs(struct cipher_ctx *ctx)
 	ctx->src_offset += todo;
 	ctx->dst_offset += todo;
 
+	if (blockmode == DESC_OPMODE_CTR) {
+		unsigned int nblocks = todo / blocksize;
+
+		while (nblocks--)
+			crypto_inc(ctx->areq->iv, ivsize);
+	}
+
 	v = DESC_OWN | blockmode | op->keymode | todo;
-	if (rctx->op_dir == MESON_ENCRYPT)
+	if (rctx->op_dir == MESON_ENCRYPT || blockmode == DESC_OPMODE_CTR)
 		v |= DESC_ENCRYPTION;
 
 	if (!ctx->cryptlen || ctx->tloffset == MAXDESC)
@@ -322,7 +330,8 @@ static int meson_cipher(struct skcipher_request *areq)
 	if (ctx.keyiv.len == AES_KEYSIZE_192)
 		ctx.keyiv.len = AES_MAX_KEY_SIZE;
 
-	if (algt->blockmode == DESC_OPMODE_CBC) {
+	if (algt->blockmode == DESC_OPMODE_CBC ||
+		algt->blockmode == DESC_OPMODE_CTR) {
 		memcpy(op->keyiv + AES_MAX_KEY_SIZE, areq->iv, ivsize);
 		ctx.keyiv.len = AES_MAX_KEY_SIZE + ivsize;
 	}
@@ -534,6 +543,32 @@ static struct meson_alg_template algs[] = {
 		.decrypt	= meson_skdecrypt,
 	}
 },
+{
+	.type = CRYPTO_ALG_TYPE_SKCIPHER,
+	.blockmode = DESC_OPMODE_CTR,
+	.alg.skcipher = {
+		.base = {
+			.cra_name = "ctr(aes)",
+			.cra_driver_name = "ctr-aes-gxl",
+			.cra_priority = 400,
+			.cra_blocksize = AES_BLOCK_SIZE,
+			.cra_flags = CRYPTO_ALG_TYPE_SKCIPHER |
+				CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY |
+				CRYPTO_ALG_NEED_FALLBACK,
+			.cra_ctxsize = sizeof(struct meson_cipher_tfm_ctx),
+			.cra_module = THIS_MODULE,
+			.cra_alignmask = 0xf,
+			.cra_init = meson_cipher_init,
+			.cra_exit = meson_cipher_exit,
+		},
+		.min_keysize	= AES_MIN_KEY_SIZE,
+		.max_keysize	= AES_MAX_KEY_SIZE,
+		.ivsize		= AES_BLOCK_SIZE,
+		.setkey		= meson_aes_setkey,
+		.encrypt	= meson_skencrypt,
+		.decrypt	= meson_skdecrypt,
+	}
+},
 };
 
 int meson_cipher_register(struct meson_dev *mc)
diff --git a/drivers/crypto/amlogic/amlogic-gxl.h b/drivers/crypto/amlogic/amlogic-gxl.h
index 5d80471f6a6a..d9336718d813 100644
--- a/drivers/crypto/amlogic/amlogic-gxl.h
+++ b/drivers/crypto/amlogic/amlogic-gxl.h
@@ -24,6 +24,7 @@
 
 #define DESC_OPMODE_ECB (0 << 26)
 #define DESC_OPMODE_CBC (1 << 26)
+#define DESC_OPMODE_CTR (2 << 26)
 #define DESC_OPMODE_SHA (0 << 26)
 
 #define DESC_MAXLEN ((1 << 17) - 1)
-- 
2.30.1


