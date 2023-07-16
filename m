Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AF2754F95
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 18:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjGPQIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 12:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjGPQIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 12:08:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCBE1B6;
        Sun, 16 Jul 2023 09:08:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8376A60D3E;
        Sun, 16 Jul 2023 16:08:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1D0C433C7;
        Sun, 16 Jul 2023 16:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689523709;
        bh=2D3MFmPbQXBQT41enlYNrNF+ZPXvLktf687yt9uncyA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LDXU4dAp0cr9/tMTOwGgnlSomzaWNGtcPd1/jX7xlb3TkuPTqPzvasiH6RhWKOLmH
         BsJfE41+wqCb95BBcUB7ITyqKn2Ku/QwXS70bmkBvb3o71t4RxDTJgx2Rl8OGdPgCF
         qBoLtxTkoxYh78SkWSbtoJxhTg8MrCTbbMlMzQVH15mmKSV+CG922OKTLrLRLFsxaH
         BnUhAbNZUi2rSQva8i6ko/Rj0ynhD07/1xR711yilCEKtmJ7/D3Jhwm8/zDeLnTRtv
         V4DecYgHIkJ/aWd8KlMkBav7Y5uePDi9+AptR6OVCSIqiyRN8bRkqTqF5UK2F2z+nC
         sYpjnHi9YyfaA==
Date:   Sun, 16 Jul 2023 17:08:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Zhang Shurong <zhang_shurong@foxmail.com>
Cc:     lars@metafoo.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, lgirdwood@gmail.com,
        broonie@kernel.org, linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] io: adc: stm32-adc: fix potential NULL pointer
 dereference in stm32_adc_probe()
Message-ID: <20230716170821.3305e3fa@jic23-huawei>
In-Reply-To: <tencent_994DA85912C937E3B5405BA960B31ED90A08@qq.com>
References: <tencent_994DA85912C937E3B5405BA960B31ED90A08@qq.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jul 2023 23:55:50 +0800
Zhang Shurong <zhang_shurong@foxmail.com> wrote:

> of_match_device() may fail and returns a NULL pointer.
> 
> Fix this by checking the return value of of_match_device().
> 
> Fixes: 64ad7f6438f3 ("iio: adc: stm32: introduce compatible data cfg")
> Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
Hi Zhang,

I'm not sure we can actually make this bug happen. Do you have
a way of triggering it?  The driver is only probed on devices where
that match will work.

Also, assuming the match table is the same one associated with this probe
function, then us priv->cfg = of_device_get_match_data() and check the output
of that which is what we really care about.

Jonathan

> ---
>  drivers/iio/adc/stm32-adc-core.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
> index 48f02dcc81c1..70011fdbf5f6 100644
> --- a/drivers/iio/adc/stm32-adc-core.c
> +++ b/drivers/iio/adc/stm32-adc-core.c
> @@ -706,6 +706,8 @@ static int stm32_adc_probe(struct platform_device *pdev)
>  	struct stm32_adc_priv *priv;
>  	struct device *dev = &pdev->dev;
>  	struct device_node *np = pdev->dev.of_node;
> +	const struct of_device_id *of_id;
> +
>  	struct resource *res;
>  	u32 max_rate;
>  	int ret;
> @@ -718,8 +720,11 @@ static int stm32_adc_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	platform_set_drvdata(pdev, &priv->common);
>  
> -	priv->cfg = (const struct stm32_adc_priv_cfg *)
> -		of_match_device(dev->driver->of_match_table, dev)->data;
> +	of_id = of_match_device(dev->driver->of_match_table, dev);
> +	if (!of_id)
> +		return -ENODEV;
> +
> +	priv->cfg = (const struct stm32_adc_priv_cfg *)of_id->data;
>  	priv->nb_adc_max = priv->cfg->num_adcs;
>  	spin_lock_init(&priv->common.lock);
>  

