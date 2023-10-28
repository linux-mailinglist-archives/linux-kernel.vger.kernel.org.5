Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F117DA7C7
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 17:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjJ1P1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 11:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1P1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 11:27:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E0C93;
        Sat, 28 Oct 2023 08:27:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770ADC433C8;
        Sat, 28 Oct 2023 15:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698506833;
        bh=uLv5WbdZZqD76wzTbqeJg/qmp0G1/IL7KepBHWNLTB8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DmL++fSy0y+u1Rl27tnahInvKR3esiJmVd5ydYL6v8N6yex88qr1B5xsP6HpqhFfJ
         bJd+PT2xDa36nz4RxOGvm3Gn15jzbCHLC+4EYamFbr/At8kk78D9J+V96aXHiSCM7x
         M+GLiWJiI0eWrCWiDuFDIIPsiS6YZh95QcB4lbFRhjU/9od06Hb0pVbyPZDhMYeX3g
         NIibfeWVM/pXSeMozlDUGKcjHGtqfYWU7RL0X1izl7cS/Zb2vr/Z1NjwYvsKqwiXCM
         xoGkGMBk+ExLRy6pfsQuMWYFyO8xSNSp/+OekcqYYWFSmLJSmUGTLWb5SW19JS07Yi
         0JdrpwU0fbkwQ==
Date:   Sat, 28 Oct 2023 16:26:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v2] iio: sx9324: avoid copying property strings
Message-ID: <20231028162638.5b477ded@jic23-huawei>
In-Reply-To: <20231026-strncpy-drivers-iio-proximity-sx9324-c-v2-1-cee6e5db700c@google.com>
References: <20231026-strncpy-drivers-iio-proximity-sx9324-c-v2-1-cee6e5db700c@google.com>
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

On Thu, 26 Oct 2023 23:53:28 +0000
Justin Stitt <justinstitt@google.com> wrote:

> We're doing some needless string copies when trying to assign the proper
> `prop` string. We can make `prop` a const char* and simply assign to
> string literals.
> 
> For the case where a format string is used, let's allocate some memory
> via kasprintf() and point prop to it.
> 
> This also cleans up some deprecated strncpy() uses [1].
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Seems reasonable to me.

+CC Gwendal (+ Stephen) as it's Gwendal's driver and I think they are still actively
maintaining it.

> ---
> Changes in v2:
> - make prop a const char* and do simple assignments (thanks Jonathan)
> - rebase onto 3a568e3a961ba330
> - Link to v1: https://lore.kernel.org/r/20230921-strncpy-drivers-iio-proximity-sx9324-c-v1-1-4e8d28fd1e7c@google.com
> ---
> Note: build-tested
> ---
>  drivers/iio/proximity/sx9324.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
> index 438f9c9aba6e..c8547035cb47 100644
> --- a/drivers/iio/proximity/sx9324.c
> +++ b/drivers/iio/proximity/sx9324.c
> @@ -885,7 +885,7 @@ sx9324_get_default_reg(struct device *dev, int idx,
>  #define SX9324_RESOLUTION_DEF "semtech,ph01-resolution"
>  #define SX9324_PROXRAW_DEF "semtech,ph01-proxraw-strength"
>  	unsigned int pin_defs[SX9324_NUM_PINS];
> -	char prop[] = SX9324_PROXRAW_DEF;
> +	const char *prop = SX9324_PROXRAW_DEF;
>  	u32 start = 0, raw = 0, pos = 0;
>  	int ret, count, ph, pin;
>  	const char *res;
> @@ -899,7 +899,7 @@ sx9324_get_default_reg(struct device *dev, int idx,
>  	case SX9324_REG_AFE_PH2:
>  	case SX9324_REG_AFE_PH3:
>  		ph = reg_def->reg - SX9324_REG_AFE_PH0;
> -		snprintf(prop, ARRAY_SIZE(prop), "semtech,ph%d-pin", ph);
> +		prop = kasprintf(GFP_KERNEL, "semtech,ph%d-pin", ph);
>  
>  		count = device_property_count_u32(dev, prop);
>  		if (count != ARRAY_SIZE(pin_defs))
> @@ -913,6 +913,7 @@ sx9324_get_default_reg(struct device *dev, int idx,
>  			raw |= (pin_defs[pin] << (2 * pin)) &
>  			       SX9324_REG_AFE_PH0_PIN_MASK(pin);
>  		reg_def->def = raw;
> +		kfree(prop);
>  		break;
>  	case SX9324_REG_AFE_CTRL0:
>  		ret = device_property_read_string(dev,
> @@ -937,11 +938,9 @@ sx9324_get_default_reg(struct device *dev, int idx,
>  	case SX9324_REG_AFE_CTRL4:
>  	case SX9324_REG_AFE_CTRL7:
>  		if (reg_def->reg == SX9324_REG_AFE_CTRL4)
> -			strncpy(prop, "semtech,ph01-resolution",
> -				ARRAY_SIZE(prop));
> +			prop = "semtech,ph01-resolution";
>  		else
> -			strncpy(prop, "semtech,ph23-resolution",
> -				ARRAY_SIZE(prop));
> +			prop = "semtech,ph23-resolution";
>  
>  		ret = device_property_read_u32(dev, prop, &raw);
>  		if (ret)
> @@ -1012,11 +1011,9 @@ sx9324_get_default_reg(struct device *dev, int idx,
>  	case SX9324_REG_PROX_CTRL0:
>  	case SX9324_REG_PROX_CTRL1:
>  		if (reg_def->reg == SX9324_REG_PROX_CTRL0)
> -			strncpy(prop, "semtech,ph01-proxraw-strength",
> -				ARRAY_SIZE(prop));
> +			prop = "semtech,ph01-proxraw-strength";
>  		else
> -			strncpy(prop, "semtech,ph23-proxraw-strength",
> -				ARRAY_SIZE(prop));
> +			prop = "semtech,ph23-proxraw-strength";
>  		ret = device_property_read_u32(dev, prop, &raw);
>  		if (ret)
>  			break;
> 
> ---
> base-commit: 3a568e3a961ba330091cd031647e4c303fa0badb
> change-id: 20230921-strncpy-drivers-iio-proximity-sx9324-c-8c3437676039
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

