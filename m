Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416257B42CA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 19:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbjI3RlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 13:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234674AbjI3RlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 13:41:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E84AF1;
        Sat, 30 Sep 2023 10:41:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958E0C433C8;
        Sat, 30 Sep 2023 17:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696095679;
        bh=+etRTCZPNPJTHh+N1MKyjYR8NQe0gI1JFDlR+ExjRJM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mBeARBSn8fmfsR2i08eGBTauyugnNT7jKXny6cHo6Y6UuKmLBwA7OE1hzwLzty89c
         m3TMncW+2/Y+MrwZQ7ZPMSQDMs771zemoTlLVNF0ky0hbF1ZuKXbHW0Mp7RyWLypGt
         fUnA3jvf6gMkX2ySekmdZrxt2ghgjJkTbbl7RbZARkYQlhazUWdBJOQG8bA/FuZEaS
         ydjyOYcA4ifQOqIRtf75va8Sko3Vu8tsOD/68syYDf3eN5hxqiwY3JIBfD5vVF9Qkg
         5iEwRZPV2DNNyDWEYHAtd8KAt6sowjLeULvNm20d/f1Z/J2NfDolaPvIt3T7pLNPLJ
         Lf2vIDHQ3qHBA==
Date:   Sat, 30 Sep 2023 18:41:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Justin Stitt <justinstitt@google.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] iio: adc: stm32-adc: replace deprecated strncpy
Message-ID: <20230930184118.73d7465a@jic23-huawei>
In-Reply-To: <202309232006.690F89A@keescook>
References: <20230921-strncpy-drivers-iio-adc-stm32-adc-c-v1-1-c50eca098597@google.com>
        <202309232006.690F89A@keescook>
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

On Sat, 23 Sep 2023 20:15:09 -0700
Kees Cook <keescook@chromium.org> wrote:

> On Thu, Sep 21, 2023 at 04:54:00AM +0000, Justin Stitt wrote:
> > `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> > 
> > We should prefer more robust and less ambiguous string interfaces.
> > 
> > We expect adc->chan_name[val] to be NUL-terminated based on ch_name's
> > use within functions that expect NUL-terminated strings like strncmp and
> > printf-likes:
> > | 	if (!strncmp(stm32_adc_ic[i].name, ch_name, STM32_ADC_CH_SZ)) {
> > | 		/* Check internal channel availability */
> > | 		switch (i) {
> > | 		case STM32_ADC_INT_CH_VDDCORE:
> > | 			if (!adc->cfg->regs->or_vddcore.reg)
> > | 				dev_warn(&indio_dev->dev,
> > | 					 "%s channel not available\n", ch_name);
> > ...
> > 
> > There is no evidence that NUL-padding is needed either.  
> 
> Agreed -- it's used as a C string everywhere I can see.
> 
> > 
> > Considering the above, a suitable replacement is `strscpy` [2] due to
> > the fact that it guarantees NUL-termination on the destination buffer
> > without unnecessarily NUL-padding. If, for any reason, NUL-padding _is_
> > required we should go for `strscpy_pad`.
> > 
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> > Note: build-tested
> > ---
> >  drivers/iio/adc/stm32-adc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> > index f7613efb870d..9cdcf396d901 100644
> > --- a/drivers/iio/adc/stm32-adc.c
> > +++ b/drivers/iio/adc/stm32-adc.c
> > @@ -2209,7 +2209,7 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
> >  				ret = -EINVAL;
> >  				goto err;
> >  			}
> > -			strncpy(adc->chan_name[val], name, STM32_ADC_CH_SZ);
> > +			strscpy(adc->chan_name[val], name, STM32_ADC_CH_SZ);  
> 
> I still prefer sizeof($dst), but yes, these are the same:
> 
>         char chan_name[STM32_ADC_CH_MAX][STM32_ADC_CH_SZ];
> 
> If this needs a v2, please improve the Subject, but it is technically
> correct, so:

Hi Kees,

I can tweak the subject whilst applying.  What did you have in mind
as a better one?

Jonathan

> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> :)
> 
> -Kees
> 

