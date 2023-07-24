Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A98F75F8FE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjGXNzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjGXNzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:55:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277E510C1;
        Mon, 24 Jul 2023 06:53:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9501E611DE;
        Mon, 24 Jul 2023 13:53:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17424C433C8;
        Mon, 24 Jul 2023 13:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690206814;
        bh=GcqqK+LiddjQxr47IifyNeabGtVWcJ8dLE0tnOoG+mg=;
        h=From:To:Cc:Subject:Date:From;
        b=ot8DzcsZjDhAnNrPQUetSgHF6Mi5aFoqafosoAaRgvQlqcwmstkqlc3jCVTt8l7L9
         ePasp7Ma/20H837s6X9vI05N2rLCZtlfvUjPXfMZXHxQHqPXFRx521KCWHd0VVf6Rz
         4WKMdyWq934zbAqS95PeOl48EG4LWhLjwuEqv8Xuw1cAKZ5HOzpg22DmrUlp9lmqGc
         Ch81Ya0EHf6IZylS1IIo5GrzN0ubgdGn1b39/CqEtl1+VRPR41P2chM6jCPrcMx8v2
         Ith2Pyka/C+Igv93wBbHAyiIASCDCJREhF1bmJwHZThc7Vls7fEu6pJlyFLXYTYxpA
         0NwVUI6tgeDbA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Ayush Sawal <ayush.sawal@chelsio.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Yangtao Li <frank.li@vivo.com>,
        Sergiu Moga <sergiu.moga@microchip.com>,
        Ryan Wanner <Ryan.Wanner@microchip.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] crypto: drivers - avoid memcpy size warning
Date:   Mon, 24 Jul 2023 15:53:01 +0200
Message-Id: <20230724135327.1173309-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Add an explicit size check to make sure gcc also sees this function is safe
regardless of inlining.

Note that the -Wrestrict warning is currently disabled by default, but it
would be nice to finally enable it, and these are the only false
postives that I see at the moment. There are 9 other crypto drivers that
also use an identical memcpy() but don't show up in randconfig build
warnings for me, presumably because of different inlining decisions.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/crypto/atmel-sha.c         | 3 +++
 drivers/crypto/bcm/cipher.c        | 3 +++
 drivers/crypto/chelsio/chcr_algo.c | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/drivers/crypto/atmel-sha.c b/drivers/crypto/atmel-sha.c
index f2031f934be95..52a3c81b3a05a 100644
--- a/drivers/crypto/atmel-sha.c
+++ b/drivers/crypto/atmel-sha.c
@@ -1770,6 +1770,9 @@ static int atmel_sha_hmac_compute_ipad_hash(struct atmel_sha_dev *dd)
 	size_t bs = ctx->block_size;
 	size_t i, num_words = bs / sizeof(u32);
 
+	if (bs > sizeof(hmac->opad))
+		return -EINVAL;
+
 	memcpy(hmac->opad, hmac->ipad, bs);
 	for (i = 0; i < num_words; ++i) {
 		hmac->ipad[i] ^= 0x36363636;
diff --git a/drivers/crypto/bcm/cipher.c b/drivers/crypto/bcm/cipher.c
index 70b911baab26d..8633ca0286a10 100644
--- a/drivers/crypto/bcm/cipher.c
+++ b/drivers/crypto/bcm/cipher.c
@@ -2327,6 +2327,9 @@ static int ahash_hmac_setkey(struct crypto_ahash *ahash, const u8 *key,
 		 __func__, ahash, key, keylen, blocksize, digestsize);
 	flow_dump("  key: ", key, keylen);
 
+	if (blocksize > sizeof(ctx->opad))
+		return -EINVAL;
+
 	if (keylen > blocksize) {
 		switch (ctx->auth.alg) {
 		case HASH_ALG_MD5:
diff --git a/drivers/crypto/chelsio/chcr_algo.c b/drivers/crypto/chelsio/chcr_algo.c
index 0eade4fa6695b..5c8e10ee010ff 100644
--- a/drivers/crypto/chelsio/chcr_algo.c
+++ b/drivers/crypto/chelsio/chcr_algo.c
@@ -2201,6 +2201,9 @@ static int chcr_ahash_setkey(struct crypto_ahash *tfm, const u8 *key,
 
 	SHASH_DESC_ON_STACK(shash, hmacctx->base_hash);
 
+	if (bs > sizeof(hmacctx->opad))
+		return -EINVAL;
+
 	/* use the key to calculate the ipad and opad. ipad will sent with the
 	 * first request's data. opad will be sent with the final hash result
 	 * ipad in hmacctx->ipad and opad in hmacctx->opad location
-- 
2.39.2

