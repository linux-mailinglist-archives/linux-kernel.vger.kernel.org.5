Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5947AA70C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 04:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjIVClL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 22:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjIVClJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 22:41:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3977B1A2;
        Thu, 21 Sep 2023 19:41:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D097C433C7;
        Fri, 22 Sep 2023 02:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695350462;
        bh=XhildR46aXcqKC9XbhSD2gq87OCF6FJdshNIl98rDAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l3PefqkGLuAaVdYgWFLjyomMX35Vmckz8mc3nwg4FRyBl3bSvU+v3xdVlnJ8APBW5
         A6Ziy46T33PNVCL5WJIPB1Sljs42W2ANni4sTi3kGlI3kbWPgZg5V2zGuwfTYPbbdr
         SVoWbgHjjMRKYO36he0yQI51w6Ygt9FpwpBbze4UMa4WZ5WZgQpaRegAq0IWps0G9S
         2EodQ22WUye6Z/VrcXw4RU6PGcOsY4nFT5GoGeS5t5mMhDxqNnePp6g+uTwBe0cqxs
         rQCGGb0UIO5akxq4l+/hfHRZbXGr/1uuklsjqTw+QXcFvmXknRKnP4KccbJZmIj5M6
         AKrwthOqZaf4A==
Date:   Thu, 21 Sep 2023 19:41:00 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gaurav Jain <gaurav.jain@nxp.com>
Cc:     Horia Geanta <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH] crypto: caam/jr - fix Chacha20 + Poly1305 self test
 failure
Message-ID: <20230922024100.GA935@sol.localdomain>
References: <20230921124237.2364827-1-gaurav.jain@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921124237.2364827-1-gaurav.jain@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 06:12:37PM +0530, Gaurav Jain wrote:
> key buffer is not copied in chachapoly_setkey function,
> results in wrong output for encryption/decryption operation.
> 
> fix this by memcpy the key in caam_ctx key arrary
> 
> Fixes: d6bbd4eea243 ("crypto: caam/jr - add support for Chacha20 + Poly1305")
> Signed-off-by: Gaurav Jain <gaurav.jain@nxp.com>
> ---
>  drivers/crypto/caam/caamalg.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/caam/caamalg.c b/drivers/crypto/caam/caamalg.c
> index eba2d750c3b0..066f08a3a040 100644
> --- a/drivers/crypto/caam/caamalg.c
> +++ b/drivers/crypto/caam/caamalg.c
> @@ -575,7 +575,8 @@ static int chachapoly_setkey(struct crypto_aead *aead, const u8 *key,
>  	if (keylen != CHACHA_KEY_SIZE + saltlen)
>  		return -EINVAL;
>  
> -	ctx->cdata.key_virt = key;
> +	memcpy(ctx->key, key, keylen);
> +	ctx->cdata.key_virt = ctx->key;
>  	ctx->cdata.keylen = keylen - saltlen;
>  

Huh, so this driver just ignored the key?  Is anyone using the ChaCha20Poly1305
support in this driver?  Based on this bug existing, that seems unlikely.  If
that's the case, wouldn't it be better just to remove the ChaCha20Poly1305
support from this driver so that the code doesn't need to be maintained?

- Eric
