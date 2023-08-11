Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75371778C74
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjHKKwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235573AbjHKKvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:51:53 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555CEE5D;
        Fri, 11 Aug 2023 03:50:05 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qUPhM-0023FO-Tp; Fri, 11 Aug 2023 18:48:54 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 11 Aug 2023 18:48:53 +0800
Date:   Fri, 11 Aug 2023 18:48:53 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ryan Wanner <Ryan.Wanner@microchip.com>,
        Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Sergiu Moga <sergiu.moga@microchip.com>,
        Ayush Sawal <ayush.sawal@chelsio.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/2] crypto: drivers - avoid memcpy size warning
Message-ID: <ZNYSFWA3WNAdRqfg@gondor.apana.org.au>
References: <20230724135327.1173309-1-arnd@kernel.org>
 <ZMyz27awrVJ8QHzA@gondor.apana.org.au>
 <d9184ad7-7d34-45bf-81e3-db053bf7425c@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9184ad7-7d34-45bf-81e3-db053bf7425c@app.fastmail.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,TVD_RCVD_IP,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 02:04:05PM +0200, Arnd Bergmann wrote:
>
> See https://pastebin.com/raw/ip3tfpJF for a config that triggers this
> on x86 with the chelsio and atmel drivers. The bcm driver is only
> available on arm64, so you won't hit that one here. I also
> see this with allmodconfig, as well as defconfig after enabling
> CONFIG_FORTIFY_SOURCE and the three crypto drivers.

OK I can reproduce this now:

In file included from ../include/linux/string.h:254,
                 from ../arch/x86/include/asm/page_32.h:18,
                 from ../arch/x86/include/asm/page.h:14,
                 from ../arch/x86/include/asm/processor.h:20,
                 from ../arch/x86/include/asm/timex.h:5,
                 from ../include/linux/timex.h:67,
                 from ../include/linux/time32.h:13,
                 from ../include/linux/time.h:60,
                 from ../include/linux/stat.h:19,
                 from ../include/linux/module.h:13,
                 from ../drivers/crypto/atmel-sha.c:15:
../drivers/crypto/atmel-sha.c: In function ‘atmel_sha_hmac_compute_ipad_hash’:
../include/linux/fortify-string.h:57:33: error: ‘__builtin_memcpy’ accessing 129 or more bytes at offsets 304 and 176 overlaps 1 or more bytes at offset 304 [-Werror=restrict]
   57 | #define __underlying_memcpy     __builtin_memcpy
      |                                 ^
../include/linux/fortify-string.h:648:9: note: in expansion of macro ‘__underlying_memcpy’
  648 |         __underlying_##op(p, q, __fortify_size);                        \
      |         ^~~~~~~~~~~~~
../include/linux/fortify-string.h:693:26: note: in expansion of macro ‘__fortify_memcpy_chk’
  693 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
      |                          ^~~~~~~~~~~~~~~~~~~~
../drivers/crypto/atmel-sha.c:1773:9: note: in expansion of macro ‘memcpy’
 1773 |         memcpy(hmac->opad, hmac->ipad, bs);
      |         ^~~~~~
../include/linux/fortify-string.h:57:33: error: ‘__builtin_memcpy’ accessing 129 or more bytes at offsets 304 and 176 overlaps 1 or more bytes at offset 304 [-Werror=restrict]
   57 | #define __underlying_memcpy     __builtin_memcpy
      |                                 ^
../include/linux/fortify-string.h:648:9: note: in expansion of macro ‘__underlying_memcpy’
  648 |         __underlying_##op(p, q, __fortify_size);                        \
      |         ^~~~~~~~~~~~~
../include/linux/fortify-string.h:693:26: note: in expansion of macro ‘__fortify_memcpy_chk’
  693 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
      |                          ^~~~~~~~~~~~~~~~~~~~
../drivers/crypto/atmel-sha.c:1773:9: note: in expansion of macro ‘memcpy’
 1773 |         memcpy(hmac->opad, hmac->ipad, bs);
      |         ^~~~~~
cc1: all warnings being treated as errors

But why are we turning these warnings on if they're giving completely
bogus false positives like this?

	struct atmel_sha_hmac_ctx {
		struct atmel_sha_ctx	base;

		struct atmel_sha_hmac_key	hkey;
		u32			ipad[SHA512_BLOCK_SIZE / sizeof(u32)];
		u32			opad[SHA512_BLOCK_SIZE / sizeof(u32)];
		atmel_sha_fn_t		resume;
	};

	struct atmel_sha_hmac_ctx *hmac = crypto_ahash_ctx(tfm);
	size_t bs = ctx->block_size;

	memcpy(hmac->opad, hmac->ipad, bs);

The block_size is set by the algorithm, you can easily grep for
it in atmel-sha.c and the biggest one there is SHA512_BLOCK_SIZE,
which is how big hmac->ipad/hmac->opad are.

So logically this code is perfectly fine.

There is no way for the compiler to know how big ctx->block_size is.
So why do we expect it to make deductions on how big bs can be?

This warning looks broken to me.

It looks like there is already a solution to this though.  Just use
unsafe_memcpy and be done with it.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
