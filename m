Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371627AC42B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 19:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjIWRsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 13:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbjIWRsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 13:48:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E5D136;
        Sat, 23 Sep 2023 10:47:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00BBAC433C8;
        Sat, 23 Sep 2023 17:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695491277;
        bh=pXFjjIo52VpqBLzSpVTwm0qtUeJqbtXcgnQcpU2K5IA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZX5Ich2bTnSu/1xEz5odYS2wZwmVvI2ndgOvJE1acPw9E1Z/833ffAZPllAAc4mFe
         ouFvlaCb1KiMHtm8KWQre/4pp1EUcX7//rCaRsliU7IUBlHcE5Pttk90WC832htNzp
         q6lMTC9mIoYOfbOywin5hvW81Ko+89JlICCw+MQ2lc8mp2W5/ittxBamp5LEWpvxov
         EidfP5f9al4JVXhjuaN+p8Urhm8cDIWES7F/u89B812RBC+PlZGuXSk95fxTVZNIfJ
         ow3vfmHpMViWU7hbk5SIyXuW9iWQNeTWP/BRfdQgMtd4BqjPufSpt9w+imZOLGJKr6
         Zcb/mG+qF0W6w==
Date:   Sat, 23 Sep 2023 18:47:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] iio: sx9324: replace deprecated strncpy
Message-ID: <20230923184751.41d52b9d@jic23-huawei>
In-Reply-To: <20230921-strncpy-drivers-iio-proximity-sx9324-c-v1-1-4e8d28fd1e7c@google.com>
References: <20230921-strncpy-drivers-iio-proximity-sx9324-c-v1-1-4e8d28fd1e7c@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2023 07:01:01 +0000
Justin Stitt <justinstitt@google.com> wrote:

> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> `prop` is defined as this string literal with size 30 (including null):
> |       #define SX9324_PROXRAW_DEF "semtech,ph01-proxraw-strength"
> |      	char prop[] = SX9324_PROXRAW_DEF;
> 
> Each of the strncpy->strscpy replacements involve string literals with a
> size less than 30 which means there are no current problems with how
> strncpy is used. However, let's move away from using strncpy entirely.
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on the destination buffer without
> unnecessarily NUL-padding.
> 
> Moreover, let's opt for the more conventional `sizeof()` as opposed to
> `ARRAY_SIZE` for these simple strings.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> FWIW: It seems fragile to base future `prop` stores on the
> size of it's default string.

Agreed - can we just get rid of the copying?  Just set a const char *
to point to appropriate string instead and use that?

The dance is just about reasonable for the case where there is
a string format being used to fill in the numbers, here I can't see any
advantage at all. (for the other case, a kasprintf() or similar is probably
more appropriate anyway) given this isn't a particular hot path.

Jonathan
> 
> Note: build-tested
> ---
>  drivers/iio/proximity/sx9324.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
> index 438f9c9aba6e..25ac2733bcef 100644
> --- a/drivers/iio/proximity/sx9324.c
> +++ b/drivers/iio/proximity/sx9324.c
> @@ -937,11 +937,9 @@ sx9324_get_default_reg(struct device *dev, int idx,
>  	case SX9324_REG_AFE_CTRL4:
>  	case SX9324_REG_AFE_CTRL7:
>  		if (reg_def->reg == SX9324_REG_AFE_CTRL4)
> -			strncpy(prop, "semtech,ph01-resolution",
> -				ARRAY_SIZE(prop));
> +			strscpy(prop, "semtech,ph01-resolution", sizeof(prop));
>  		else
> -			strncpy(prop, "semtech,ph23-resolution",
> -				ARRAY_SIZE(prop));
> +			strscpy(prop, "semtech,ph23-resolution", sizeof(prop));
>  
>  		ret = device_property_read_u32(dev, prop, &raw);
>  		if (ret)
> @@ -1012,11 +1010,9 @@ sx9324_get_default_reg(struct device *dev, int idx,
>  	case SX9324_REG_PROX_CTRL0:
>  	case SX9324_REG_PROX_CTRL1:
>  		if (reg_def->reg == SX9324_REG_PROX_CTRL0)
> -			strncpy(prop, "semtech,ph01-proxraw-strength",
> -				ARRAY_SIZE(prop));
> +			strscpy(prop, "semtech,ph01-proxraw-strength", sizeof(prop));
>  		else
> -			strncpy(prop, "semtech,ph23-proxraw-strength",
> -				ARRAY_SIZE(prop));
> +			strscpy(prop, "semtech,ph23-proxraw-strength", sizeof(prop));
>  		ret = device_property_read_u32(dev, prop, &raw);
>  		if (ret)
>  			break;
> 
> ---
> base-commit: 2cf0f715623872823a72e451243bbf555d10d032
> change-id: 20230921-strncpy-drivers-iio-proximity-sx9324-c-8c3437676039
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

