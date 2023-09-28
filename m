Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030697B1EBE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 15:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbjI1NmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 09:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbjI1NmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:42:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53461193;
        Thu, 28 Sep 2023 06:42:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A42C433C8;
        Thu, 28 Sep 2023 13:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695908523;
        bh=7Y2PniOfB3kAjyIQoXZvNLWZUM33zoeeBRwcWGGreJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EdCBwGo9bet5FaWMwSzUMysVdQ1j2UDHxdKtNQQNmov93Gt1hWyFARuBLcAT4KTji
         GF3NtTvyR8v11b9egen8g+/6/5gS/7F1M3z7fqcsRQQR1na/P+bW1rvTo+GagHtls3
         B4sE3Wuf29K5Ml9/eCNrCTDn1o6xQMlHDu0WuuG05WsweybtEna+YLleDJ2y6Yl865
         ii6JEkd1sRhRT2k5HZjY7bpLrnoxw36rPq6vcRbeeFRVsUsvvg1oR9bvmKPSDcDI4C
         UZyMC7yPpqDbfYH7+fkoXSMPH1GiPCXHadDL2VVYs/RrkGe31FCY5RRSliOP7XQ7km
         SWTHDg4xHR8Wg==
Date:   Thu, 28 Sep 2023 14:41:59 +0100
From:   Lee Jones <lee@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Justin Stitt <justinstitt@google.com>, Pavel Machek <pavel@ucw.cz>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] leds: lp3952: replace deprecated strncpy with strscpy
Message-ID: <20230928134159.GJ9999@google.com>
References: <20230922-strncpy-drivers-leds-leds-lp3952-c-v1-1-4941d6f60ca4@google.com>
 <202309232039.979F3B4@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202309232039.979F3B4@keescook>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Sep 2023, Kees Cook wrote:

> On Fri, Sep 22, 2023 at 03:27:17PM +0000, Justin Stitt wrote:
> > `strncpy` is deprecated for use on NUL-terminated destination strings
> > [1] and as such we should prefer more robust and less ambiguous string
> > interfaces.
> > 
> > We expect `dest` to be NUL-terminated due to its use with dev_err.
> > 
> > lp3952_get_label()'s  dest argument is priv->leds[i].name:
> > |    acpi_ret = lp3952_get_label(&priv->client->dev, led_name_hdl[i],
> > |                                priv->leds[i].name);
> > ... which is then assigned to:
> > |    priv->leds[i].cdev.name = priv->leds[i].name;
> > ... which is used with a format string
> > |    dev_err(&priv->client->dev,
> > |            "couldn't register LED %s\n",
> > |            priv->leds[i].cdev.name);
> > 
> > There is no indication that NUL-padding is required but if it is let's
> > opt for strscpy_pad.
> > 
> > Considering the above, a suitable replacement is `strscpy` [2] due to
> > the fact that it guarantees NUL-termination on the destination buffer
> > without unnecessarily NUL-padding.
> > 
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> > Note: build-tested only.
> > ---
> >  drivers/leds/leds-lp3952.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/leds/leds-lp3952.c b/drivers/leds/leds-lp3952.c
> > index 3bd55652a706..62ade3f05a87 100644
> > --- a/drivers/leds/leds-lp3952.c
> > +++ b/drivers/leds/leds-lp3952.c
> > @@ -101,7 +101,7 @@ static int lp3952_get_label(struct device *dev, const char *label, char *dest)
> >  	if (ret)
> >  		return ret;
> >  
> > -	strncpy(dest, str, LP3952_LABEL_MAX_LEN);
> > +	strscpy(dest, str, LP3952_LABEL_MAX_LEN);
> 
> Given my desire to use sizeof(dest) for these things, I wonder if it'd
> be nicer to pass more context here for the compiler as the only user of
> this function is the immediately next function. Instead of passing in
> "char *dest", it could pass "struct lp3952_led_array *priv", and
> suddenly sizeof() would be possible.
> 
> But, since it's technically correct as-is:
> 
> struct lp3952_ctrl_hdl {
>         struct led_classdev cdev;
>         char name[LP3952_LABEL_MAX_LEN];
> 
> There's no pressing need to actually do the priv refactor. It's just a
> comment on the coding style of the original code. :)
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

I've applied this as-is, but please consider Kees' proposal.

-- 
Lee Jones [李琼斯]
