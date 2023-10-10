Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9537C006F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbjJJPdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbjJJPdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:33:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D40C6;
        Tue, 10 Oct 2023 08:33:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35732C433C9;
        Tue, 10 Oct 2023 15:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696952017;
        bh=uCeGXpQ2PhB2LhIPquLo56o19XqjK0xYL5TVnuMv/+U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EWSBW2fwN/2X5IF6uuWJ2T0Ug0fKHP0BR60rjiZ98D7b+0D5YH7OZoBJuYr8vewe3
         ej5UceVmEfNbjoRbsPD2wXrFdzIiEhd7KURWJmTKOXit+h8xneME7SgE90NNYHutU0
         tgNdNs3kql8u5m3FIhC7S0cb95i9y9iQdWSzEDhPFWg34b+QRpPheb++z6SNYEz/5K
         BySmRLyxiHMXfmf0XTvfacF/pgtoEEjv3qdT16w327kJ0h596RDI3hIPSk1cnahddC
         hBsp8bFDWLRrKZqqOaIe3F//7c/UKE96Q4LXyv19ozBaEJS1zLGXn/5NSpuHCYj0gb
         SJd/UewTRBMMA==
Date:   Tue, 10 Oct 2023 16:33:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     lars@metafoo.de, matthias.bgg@gmail.com, ruanjinjie@huawei.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org,
        kernel@collabora.com
Subject: Re: [PATCH] iio: adc: mt6577_auxadc: Fix kernel panic on suspend
Message-ID: <20231010163346.3e346536@jic23-huawei>
In-Reply-To: <20231010121940.159696-1-angelogioacchino.delregno@collabora.com>
References: <20231010121940.159696-1-angelogioacchino.delregno@collabora.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2023 14:19:40 +0200
AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:

> Commit a2d518fbe376 ("iio: adc: mt6577_auxadc: Simplify with device managed function")
> simplified the driver with devm hooks, but wrongly states that the
> platform_set_drvdata(), platform_get_drvdata() are unused after the
> simplification: the driver data is infact used in .suspend() and
> .resume() PM callbacks, currently producing a kernel panic.
> 
> Reintroduce the call to platform_set_drvdata() in the probe function
> 
> Fixes: a2d518fbe376 ("iio: adc: mt6577_auxadc: Simplify with device managed function")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Applied to the togreg branch of iio.git (as the patch it is fixing is only there for now)
Pushed out initially as testing for 0-day to take a look.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/mt6577_auxadc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
> index 370b84c2d0ba..3343b54e8e44 100644
> --- a/drivers/iio/adc/mt6577_auxadc.c
> +++ b/drivers/iio/adc/mt6577_auxadc.c
> @@ -293,6 +293,7 @@ static int mt6577_auxadc_probe(struct platform_device *pdev)
>  	mt6577_auxadc_mod_reg(adc_dev->reg_base + MT6577_AUXADC_MISC,
>  			      MT6577_AUXADC_PDN_EN, 0);
>  	mdelay(MT6577_AUXADC_POWER_READY_MS);
> +	platform_set_drvdata(pdev, indio_dev);
>  
>  	ret = devm_add_action_or_reset(&pdev->dev, mt6577_power_off, adc_dev);
>  	if (ret)

