Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DC6779100
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbjHKNrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjHKNrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:47:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD356ED;
        Fri, 11 Aug 2023 06:47:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59C6B652B4;
        Fri, 11 Aug 2023 13:47:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA38C433C7;
        Fri, 11 Aug 2023 13:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691761631;
        bh=m+dHKeCOyfldrelbfFz9R7hBuqKctkP1BqoAT6/0PyY=;
        h=From:To:Cc:Subject:Date:From;
        b=nYa2mNHPKNfSnuFKw7NHYN4XlDi7Uqas9nWnWhLr/zgt2Pu3Y/16KP7UmQRI5NTxK
         5kYddeJK7hdxuBwRThnoSxPwFMubH4JNotpfdWYFfNd5Bq1lMeNvhICFrPDwY5dTIn
         TFDljzE+TWGO4sb9yDQ/tSIjPkIt8ibFcDbQ3ydcQdquwUQgk6Sm9AERkAwiPGq11I
         mttZq7B93LgneVZUWHLKSxOuN4UsIzJc8INzqaDl1O9O/+mzg0+YM+NUuZPtp4z6b2
         drNUXzgq1fBZb0zZ+J4nw3nPKcAZmX/debxlw+w/lTdPc/AIJWqGx7dq+XQmuHGUv4
         DxjMBuomkFoOA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Ayush Sawal <ayush.sawal@chelsio.com>,
        Ryan Wanner <Ryan.Wanner@microchip.com>,
        Yangtao Li <frank.li@vivo.com>, Wang Ming <machel@vivo.com>,
        Sergiu Moga <sergiu.moga@microchip.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] crypto: drivers - avoid memcpy size warning
Date:   Fri, 11 Aug 2023 15:46:33 +0200
Message-Id: <20230811134704.3252535-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Some configurations with gcc-12 or gcc-13 produce a warning for the source
and destination of a memcpy() in atmel_sha_hmac_compute_ipad_hash() potentially
overlapping:

In file included from include/linux/string.h:254,
                 from drivers/crypto/atmel-sha.c:15:
drivers/crypto/atmel-sha.c: In function 'atmel_sha_hmac_compute_ipad_hash':
include/linux/fortify-string.h:57:33: error: '__builtin_memcpy' accessing 129 or more bytes at offsets 408 and 280 overlaps 1 or more bytes at offset 408 [-Werror=restrict]
   57 | #define __underlying_memcpy     __builtin_memcpy
      |                                 ^
include/linux/fortify-string.h:648:9: note: in expansion of macro '__underlying_memcpy'
  648 |         __underlying_##op(p, q, __fortify_size);                        \
      |         ^~~~~~~~~~~~~
include/linux/fortify-string.h:693:26: note: in expansion of macro '__fortify_memcpy_chk'
  693 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
      |                          ^~~~~~~~~~~~~~~~~~~~
drivers/crypto/atmel-sha.c:1773:9: note: in expansion of macro 'memcpy'
 1773 |         memcpy(hmac->opad, hmac->ipad, bs);
      |         ^~~~~~

The same thing happens in two more drivers that have the same logic:

drivers/crypto/chelsio/chcr_algo.c: In function 'chcr_ahash_setkey':
include/linux/fortify-string.h:57:33: error: '__builtin_memcpy' accessing 129 or more bytes at offsets 260 and 132 overlaps 1 or more bytes at offset 260 [-Werror=restrict]
drivers/crypto/bcm/cipher.c: In function 'ahash_hmac_setkey':
include/linux/fortify-string.h:57:33: error: '__builtin_memcpy' accessing between 129 and 4294967295 bytes at offsets 840 and 712 overlaps between 1 and 4294967167 bytes at offset 840 [-Werror=restrict]

I don't think it can actually happen because the size is strictly bounded
to the available block sizes, at most 128 bytes, though inlining decisions
could lead gcc to not see that.

Use the unsafe_memcpy() helper instead of memcpy(), with the only difference
being that this skips the hardening checks that produce the warning.

Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/crypto/atmel-sha.c         | 3 ++-
 drivers/crypto/bcm/cipher.c        | 3 ++-
 drivers/crypto/chelsio/chcr_algo.c | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/atmel-sha.c b/drivers/crypto/atmel-sha.c
index 54fec72dfba27..99a9ff8e743f2 100644
--- a/drivers/crypto/atmel-sha.c
+++ b/drivers/crypto/atmel-sha.c
@@ -1770,7 +1770,8 @@ static int atmel_sha_hmac_compute_ipad_hash(struct atmel_sha_dev *dd)
 	size_t bs = ctx->block_size;
 	size_t i, num_words = bs / sizeof(u32);
 
-	memcpy(hmac->opad, hmac->ipad, bs);
+	unsafe_memcpy(hmac->opad, hmac->ipad, bs,
+		      "fortified memcpy causes -Wrestrict warning");
 	for (i = 0; i < num_words; ++i) {
 		hmac->ipad[i] ^= 0x36363636;
 		hmac->opad[i] ^= 0x5c5c5c5c;
diff --git a/drivers/crypto/bcm/cipher.c b/drivers/crypto/bcm/cipher.c
index 70b911baab26d..4c46357e2570e 100644
--- a/drivers/crypto/bcm/cipher.c
+++ b/drivers/crypto/bcm/cipher.c
@@ -2397,7 +2397,8 @@ static int ahash_hmac_setkey(struct crypto_ahash *ahash, const u8 *key,
 		memset(ctx->ipad + ctx->authkeylen, 0,
 		       blocksize - ctx->authkeylen);
 		ctx->authkeylen = 0;
-		memcpy(ctx->opad, ctx->ipad, blocksize);
+		unsafe_memcpy(ctx->opad, ctx->ipad, blocksize,
+			      "fortified memcpy causes -Wrestrict warning");
 
 		for (index = 0; index < blocksize; index++) {
 			ctx->ipad[index] ^= HMAC_IPAD_VALUE;
diff --git a/drivers/crypto/chelsio/chcr_algo.c b/drivers/crypto/chelsio/chcr_algo.c
index 0eade4fa6695b..16298ae4a00bf 100644
--- a/drivers/crypto/chelsio/chcr_algo.c
+++ b/drivers/crypto/chelsio/chcr_algo.c
@@ -2216,7 +2216,8 @@ static int chcr_ahash_setkey(struct crypto_ahash *tfm, const u8 *key,
 		memcpy(hmacctx->ipad, key, keylen);
 	}
 	memset(hmacctx->ipad + keylen, 0, bs - keylen);
-	memcpy(hmacctx->opad, hmacctx->ipad, bs);
+	unsafe_memcpy(hmacctx->opad, hmacctx->ipad, bs,
+		      "fortified memcpy causes -Wrestrict warning");
 
 	for (i = 0; i < bs / sizeof(int); i++) {
 		*((unsigned int *)(&hmacctx->ipad) + i) ^= IPAD_DATA;
-- 
2.39.2

