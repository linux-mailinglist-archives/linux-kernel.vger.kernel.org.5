Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B406C7809FE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 12:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359270AbjHRK1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 06:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359419AbjHRK0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:26:49 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E3935B6;
        Fri, 18 Aug 2023 03:26:31 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qWwfv-005Gi5-3n; Fri, 18 Aug 2023 18:25:52 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 18 Aug 2023 18:25:51 +0800
Date:   Fri, 18 Aug 2023 18:25:51 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Arnd Bergmann <arnd@kernel.org>
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
Subject: Re: [PATCH] [v2] crypto: drivers - avoid memcpy size warning
Message-ID: <ZN9HL5qI5yt/hFnc@gondor.apana.org.au>
References: <20230811134704.3252535-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811134704.3252535-1-arnd@kernel.org>
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

On Fri, Aug 11, 2023 at 03:46:33PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Some configurations with gcc-12 or gcc-13 produce a warning for the source
> and destination of a memcpy() in atmel_sha_hmac_compute_ipad_hash() potentially
> overlapping:
> 
> In file included from include/linux/string.h:254,
>                  from drivers/crypto/atmel-sha.c:15:
> drivers/crypto/atmel-sha.c: In function 'atmel_sha_hmac_compute_ipad_hash':
> include/linux/fortify-string.h:57:33: error: '__builtin_memcpy' accessing 129 or more bytes at offsets 408 and 280 overlaps 1 or more bytes at offset 408 [-Werror=restrict]
>    57 | #define __underlying_memcpy     __builtin_memcpy
>       |                                 ^
> include/linux/fortify-string.h:648:9: note: in expansion of macro '__underlying_memcpy'
>   648 |         __underlying_##op(p, q, __fortify_size);                        \
>       |         ^~~~~~~~~~~~~
> include/linux/fortify-string.h:693:26: note: in expansion of macro '__fortify_memcpy_chk'
>   693 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
>       |                          ^~~~~~~~~~~~~~~~~~~~
> drivers/crypto/atmel-sha.c:1773:9: note: in expansion of macro 'memcpy'
>  1773 |         memcpy(hmac->opad, hmac->ipad, bs);
>       |         ^~~~~~
> 
> The same thing happens in two more drivers that have the same logic:
> 
> drivers/crypto/chelsio/chcr_algo.c: In function 'chcr_ahash_setkey':
> include/linux/fortify-string.h:57:33: error: '__builtin_memcpy' accessing 129 or more bytes at offsets 260 and 132 overlaps 1 or more bytes at offset 260 [-Werror=restrict]
> drivers/crypto/bcm/cipher.c: In function 'ahash_hmac_setkey':
> include/linux/fortify-string.h:57:33: error: '__builtin_memcpy' accessing between 129 and 4294967295 bytes at offsets 840 and 712 overlaps between 1 and 4294967167 bytes at offset 840 [-Werror=restrict]
> 
> I don't think it can actually happen because the size is strictly bounded
> to the available block sizes, at most 128 bytes, though inlining decisions
> could lead gcc to not see that.
> 
> Use the unsafe_memcpy() helper instead of memcpy(), with the only difference
> being that this skips the hardening checks that produce the warning.
> 
> Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/crypto/atmel-sha.c         | 3 ++-
>  drivers/crypto/bcm/cipher.c        | 3 ++-
>  drivers/crypto/chelsio/chcr_algo.c | 3 ++-
>  3 files changed, 6 insertions(+), 3 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
