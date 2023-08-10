Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489DC777C84
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236204AbjHJPoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbjHJPoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:44:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5DF26A9;
        Thu, 10 Aug 2023 08:44:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A6C3660A8;
        Thu, 10 Aug 2023 15:44:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A15FC433C7;
        Thu, 10 Aug 2023 15:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691682259;
        bh=3aiCYQc8vHW8XUu8s7N6C4OIOvqzs2zbImVMJ42Rl2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I6GGNy1lAQq8UM/9FMHp3yUQBYexHFAaehY5mqxuF4mzQDQ3fek41kZAN6F/anp5w
         Fj+PM57rxo+Ezn89+EuZSnBuyj3w5g0dfQS2+pTNl6v8KBQ500P4qv9Qfu5hhqpcHQ
         twQ9zCoVzXSYSQuYV2XJQwX5NnHzXhJ3LxpVZasE=
Date:   Thu, 10 Aug 2023 17:44:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH] serial: mxs-uart: fix Wvoid-pointer-to-enum-cast warning
Message-ID: <2023081004-lapped-handbag-0324@gregkh>
References: <20230810085042.39252-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810085042.39252-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 10:50:42AM +0200, Krzysztof Kozlowski wrote:
> `devtype` is enum, thus cast of pointer on 64-bit compile test with W=1
> causes:
> 
>   mxs-auart.c:1598:15: error: cast to smaller integer type 'enum mxs_auart_type' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]
> 
> Cc: Andi Shyti <andi.shyti@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/tty/serial/mxs-auart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
> index 8eeecf8ad359..a9b32722b049 100644
> --- a/drivers/tty/serial/mxs-auart.c
> +++ b/drivers/tty/serial/mxs-auart.c
> @@ -1595,7 +1595,7 @@ static int mxs_auart_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	s->devtype = (enum mxs_auart_type)of_device_get_match_data(&pdev->dev);
> +	s->devtype = (uintptr_t)of_device_get_match_data(&pdev->dev);

This feels like a compiler issue as devtype is a enum mxs_auart_type
variable, so the cast shoudl be correct.

And if not, unitptr_t isn't a valid kernel type, so that's not a good
solution either.  Worst case, it's how big a pointer is, which is not
going to be what an enum is if you have a sane compiler :(

thanks,

greg k-h
