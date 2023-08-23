Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633547863DB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 01:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238488AbjHWXHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 19:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238462AbjHWXHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 19:07:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1520E51;
        Wed, 23 Aug 2023 16:07:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7ADB0611CF;
        Wed, 23 Aug 2023 23:07:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06946C433C7;
        Wed, 23 Aug 2023 23:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692832046;
        bh=ZvPiminCOsELeBtIIeJltI5yvcvIv6w3DE0K33apG3Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pRzIDz5ocvFqDnTfxPJYp8Ib9jodQxSmtwvXuYdbXUDEpFURAxUwOle3uYJigkAr4
         jW+YzuWLoIpioAYArPIxYow+Rhk/Gbk9ANx5efk8708HwREGiu9EmUwnHuHIB4SbFk
         sBeQOhlA5gdMjBsfeXMvfBKtFg/Pd+vyPkiHkYDCJxQUnlMulCZrWlc+7szZqoNRmv
         iDrNGDtc6EUwimR4Gg6JdPwXs9OEQa2Oau/3CoIRC9qTNh3AhE8R3v4Ga3QFQ794cu
         739gjVACrsgd9CLusxQvcJeSb6OlT5MXn/BE6ewu1IhTdGNmw04caNwydNu9iP8Gio
         RvCnl2FTVJrlw==
Message-ID: <00462bc7-43ee-784a-3296-8051d69575df@kernel.org>
Date:   Thu, 24 Aug 2023 08:07:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] ata: pata_ep93xx: fix error return code in probe
Content-Language: en-US
To:     nikita.shubin@maquefel.me, Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230823-ep93xx_pata_fixes-v1-0-d7e7229be148@maquefel.me>
 <20230823-ep93xx_pata_fixes-v1-1-d7e7229be148@maquefel.me>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230823-ep93xx_pata_fixes-v1-1-d7e7229be148@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/23 18:47, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> Return -ENOMEM from ep93xx_pata_probe() if devm_kzalloc() or
> ata_host_alloc() fails.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>

Doesn't this need a Fixes tag and Cc: stable ?

This is not really a bug fix, but might as well be complete with the fix :)

> ---
>  drivers/ata/pata_ep93xx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
> index c6e043e05d43..4ce0f37c7a89 100644
> --- a/drivers/ata/pata_ep93xx.c
> +++ b/drivers/ata/pata_ep93xx.c
> @@ -939,7 +939,7 @@ static int ep93xx_pata_probe(struct platform_device *pdev)
>  
>  	drv_data = devm_kzalloc(&pdev->dev, sizeof(*drv_data), GFP_KERNEL);
>  	if (!drv_data) {
> -		err = -ENXIO;
> +		err = -ENOMEM;
>  		goto err_rel_gpio;
>  	}
>  
> @@ -952,7 +952,7 @@ static int ep93xx_pata_probe(struct platform_device *pdev)
>  	/* allocate host */
>  	host = ata_host_alloc(&pdev->dev, 1);
>  	if (!host) {
> -		err = -ENXIO;
> +		err = -ENOMEM;
>  		goto err_rel_dma;
>  	}
>  
> 

-- 
Damien Le Moal
Western Digital Research

