Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B1376FBCD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbjHDIRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234489AbjHDIRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:17:40 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FA14693;
        Fri,  4 Aug 2023 01:17:34 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qRpz1-003Zha-4w; Fri, 04 Aug 2023 16:16:28 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 04 Aug 2023 16:16:27 +0800
Date:   Fri, 4 Aug 2023 16:16:27 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Ayush Sawal <ayush.sawal@chelsio.com>,
        Arnd Bergmann <arnd@arndb.de>, Yangtao Li <frank.li@vivo.com>,
        Sergiu Moga <sergiu.moga@microchip.com>,
        Ryan Wanner <Ryan.Wanner@microchip.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] crypto: drivers - avoid memcpy size warning
Message-ID: <ZMyz27awrVJ8QHzA@gondor.apana.org.au>
References: <20230724135327.1173309-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724135327.1173309-1-arnd@kernel.org>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 03:53:01PM +0200, Arnd Bergmann wrote:
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

Please send me the configurations which triggers these warnings.
As these are false positives, I'd like to enable them only on the
configurations where they actually cause a problem.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
