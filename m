Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5BDC76FCF0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjHDJL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjHDJL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:11:27 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6177C5FCF;
        Fri,  4 Aug 2023 02:08:20 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qRqn9-003avV-3q; Fri, 04 Aug 2023 17:08:16 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 04 Aug 2023 17:08:15 +0800
Date:   Fri, 4 Aug 2023 17:08:15 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Wang Ming <machel@vivo.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Subject: Re: [PATCH v2] crypto: Use dev_err_probe instead of dev_err
Message-ID: <ZMy//0bP/JTBJfGn@gondor.apana.org.au>
References: <20230726120314.5982-1-machel@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726120314.5982-1-machel@vivo.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 08:03:04PM +0800, Wang Ming wrote:
> It is possible that dma_request_chan will return EPROBE_DEFER,
> which means that dd->dev is not ready yet. In this case,
> dev_err(dd->dev), there will be no output. This patch fixes the bug.
> 
> Signed-off-by: Wang Ming <machel@vivo.com>
> ---
>  drivers/crypto/omap-aes.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/crypto/omap-aes.c b/drivers/crypto/omap-aes.c
> index 67a99c760bc4..de7f1eeb675a 100644
> --- a/drivers/crypto/omap-aes.c
> +++ b/drivers/crypto/omap-aes.c
> @@ -236,14 +236,14 @@ static int omap_aes_dma_init(struct omap_aes_dev *dd)
>  
>  	dd->dma_lch_in = dma_request_chan(dd->dev, "rx");
>  	if (IS_ERR(dd->dma_lch_in)) {
> -		dev_err(dd->dev, "Unable to request in DMA channel\n");
> -		return PTR_ERR(dd->dma_lch_in);
> +		return dev_err_probe(dd->dev, PTR_ERR(dd->dma_lch_in),
> +			Unable to request in DMA channel\n");
>  	}
>  
>  	dd->dma_lch_out = dma_request_chan(dd->dev, "tx");
>  	if (IS_ERR(dd->dma_lch_out)) {
> -		dev_err(dd->dev, "Unable to request out DMA channel\n");
> -		err = PTR_ERR(dd->dma_lch_out);
> +		err = dev_err_probe(dd->dev, PTR_ERR(dd->dma_lch_out),
> +			"Unable to request out DMA channel\n");
>  		goto err_dma_out;
>  	}

This doesn't even compile.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
