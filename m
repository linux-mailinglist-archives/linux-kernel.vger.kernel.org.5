Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3897EF059
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 11:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345881AbjKQK3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 05:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbjKQK3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 05:29:06 -0500
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E73131;
        Fri, 17 Nov 2023 02:29:02 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1r3w5k-000bqL-KA; Fri, 17 Nov 2023 18:28:53 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 17 Nov 2023 18:29:00 +0800
Date:   Fri, 17 Nov 2023 18:29:00 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Chen Ni <nichen@iscas.ac.cn>
Cc:     davem@davemloft.net, t-kristo@ti.com, j-keerthy@ti.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        nichen@iscas.ac.cn
Subject: Re: [PATCH] crypto: sa2ul - Add check for crypto_aead_setkey
Message-ID: <ZVdAbHSItfzhl++h@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107063152.529830-1-nichen@iscas.ac.cn>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chen Ni <nichen@iscas.ac.cn> wrote:
> Add check for crypto_aead_setkey() and return the error if it fails
> in order to transfer the error.
> 
> Fixes: d2c8ac187fc9 ("crypto: sa2ul - Add AEAD algorithm support")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
> drivers/crypto/sa2ul.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/sa2ul.c b/drivers/crypto/sa2ul.c
> index 6846a8429574..6bac2382e261 100644
> --- a/drivers/crypto/sa2ul.c
> +++ b/drivers/crypto/sa2ul.c
> @@ -1806,6 +1806,7 @@ static int sa_aead_setkey(struct crypto_aead *authenc,
>        int cmdl_len;
>        struct sa_cmdl_cfg cfg;
>        int key_idx;
> +       int error;
> 
>        if (crypto_authenc_extractkeys(&keys, key, keylen) != 0)
>                return -EINVAL;
> @@ -1869,7 +1870,9 @@ static int sa_aead_setkey(struct crypto_aead *authenc,
>        crypto_aead_set_flags(ctx->fallback.aead,
>                              crypto_aead_get_flags(authenc) &
>                              CRYPTO_TFM_REQ_MASK);
> -       crypto_aead_setkey(ctx->fallback.aead, key, keylen);
> +       error = crypto_aead_setkey(ctx->fallback.aead, key, keylen);
> +       if (error)
> +               return error;

This should be

	return crypto_aead_setkey(ctx->fallback.aead, key, keylen);

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
