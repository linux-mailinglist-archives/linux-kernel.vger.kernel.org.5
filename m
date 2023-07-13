Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D937751EC1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 12:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbjGMKXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 06:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbjGMKWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 06:22:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDA5E77;
        Thu, 13 Jul 2023 03:22:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10266603F7;
        Thu, 13 Jul 2023 10:22:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC5EC433C8;
        Thu, 13 Jul 2023 10:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689243769;
        bh=Cg2keuFk6p8PnspTfUCYYerlshJ8rbjyC1r1qcvvO0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oSX4B+DUGmO4prC4zo4wO6BBcgxZkEGUPYzuhqFLrw+8O+cX3gO2ujlsV092pghrd
         xa6RlSzI90H9gp73fH8XPl40zuRmTDk4/n1/CE1G8SnQPoOhqrhA7twjamJX/EvBG1
         0UceA8Zu3LWQZ9oZB2lmU3i/y1tEerUvTdxFDTFbkbtg1SoX8YwOZ1OE+732RxThOR
         D/BZktyPyIQcPgoQt9aC/vVUNie6QTeJBdK2R/5Eywhb0V9BY8l/O/CdnrsU4S4T6s
         OQbJU2ll0XEaRm/Ehdcm9KGasNmwkTgCcCWQx+ZyMbPgcFpK/Atpn5wmx1g3roNVNr
         e7Uom8scl3AJA==
Date:   Thu, 13 Jul 2023 11:22:44 +0100
From:   Lee Jones <lee@kernel.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: ip30: Convert to devm_platform_ioremap_resource()
Message-ID: <20230713102244.GO10768@google.com>
References: <20230704094745.25665-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230704094745.25665-1-frank.li@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Jul 2023, Yangtao Li wrote:

> Use devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  drivers/leds/leds-ip30.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/leds/leds-ip30.c b/drivers/leds/leds-ip30.c
> index 1f952bad0fe8..2df24c303366 100644
> --- a/drivers/leds/leds-ip30.c
> +++ b/drivers/leds/leds-ip30.c
> @@ -27,22 +27,16 @@ static void ip30led_set(struct led_classdev *led_cdev,
>  
>  static int ip30led_create(struct platform_device *pdev, int num)
>  {
> -	struct resource *res;
>  	struct ip30_led *data;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, num);
> -	if (!res)
> -		return -EBUSY;
> -
>  	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
>  	if (!data)
>  		return -ENOMEM;
>  
> -	data->reg = devm_ioremap_resource(&pdev->dev, res);
> +	data->reg = devm_platform_ioremap_resource(pdev, num);
>  	if (IS_ERR(data->reg))
>  		return PTR_ERR(data->reg);
>  
> -

You're not supposed to do that.  Separate patch in future please.

But I cannot review what I do not see!

Applied, thanks

-- 
Lee Jones [李琼斯]
