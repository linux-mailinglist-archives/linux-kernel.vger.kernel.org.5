Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973F078AF49
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 13:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjH1Ls3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 07:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbjH1LsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 07:48:25 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E2E10C;
        Mon, 28 Aug 2023 04:48:14 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1qaaj0-0002OB-5Q; Mon, 28 Aug 2023 13:48:06 +0200
Date:   Mon, 28 Aug 2023 13:48:06 +0200
From:   Martin Kaiser <lists@kaiser.cx>
To:     Andrei Coardos <aboutphysycs@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        yuzhe@nfschina.com, u.kleine-koenig@pengutronix.de,
        herbert@gondor.apana.org.au, olivia@selenic.com, alex@shruggie.ro
Subject: Re: [PATCH] char: hw_random: xgene-rng: removed unneeded call to
 platform_set_drvdata()
Message-ID: <20230828114806.cjshfg7tpxiwyy6i@viti.kaiser.cx>
References: <20230828102329.20867-1-aboutphysycs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828102329.20867-1-aboutphysycs@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrei Coardos (aboutphysycs@gmail.com) wrote:

> This function call was found to be unnecessary as there is no equivalent
> platform_get_drvdata() call to access the private data of the driver. Also,
> the private data is defined in this driver, so there is no risk of it being
> accessed outside of this driver file.

> Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
> ---
>  drivers/char/hw_random/xgene-rng.c | 1 -
>  1 file changed, 1 deletion(-)

> diff --git a/drivers/char/hw_random/xgene-rng.c b/drivers/char/hw_random/xgene-rng.c
> index 7c8f3cb7c6af..9d64b5931a27 100644
> --- a/drivers/char/hw_random/xgene-rng.c
> +++ b/drivers/char/hw_random/xgene-rng.c
> @@ -321,7 +321,6 @@ static int xgene_rng_probe(struct platform_device *pdev)
>  		return -ENOMEM;

>  	ctx->dev = &pdev->dev;
> -	platform_set_drvdata(pdev, ctx);

>  	ctx->csr_base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(ctx->csr_base))
> -- 
> 2.34.1

This one's ok, too. 67fb1e295839 ("hwrng: xgene - Simplify using
devm_clk_get_optional_enabled()") removed the platform_get_drvdata call.

Reviewed-by: Martin Kaiser <martin@kaiser.cx>
