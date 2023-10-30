Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3797DC20C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 22:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjJ3Vot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 17:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbjJ3Vor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 17:44:47 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF11FC
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 14:44:44 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c509f2c46cso69782521fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 14:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698702283; x=1699307083; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vV6LUALjEgXum7J0cVqVp/nxnO2QeGajqSPsDE93otM=;
        b=b8L1xxz+GnVFQNWNj7UYmBrXLMk0m8IHfDRdJO+WReo0znAtSD2f3BfZ2mIq1/qnls
         cP553R5uoDYDDYznRvgZ9PAXiVsXlnCZEWzqexf+O5yrfuWlkymCVBRcFFx84IwdgEhw
         YM6XvvlO4WWuDHo7uTxzMvH5zsuU4HVQJqAKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698702283; x=1699307083;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vV6LUALjEgXum7J0cVqVp/nxnO2QeGajqSPsDE93otM=;
        b=h+2/ZdgS6qTDC6tdadWV7atmPMVmEJvOdTNYwpDY+WocrKj/lR4ZFE6UuMrtDjCKo3
         IkVzfDpDuMQhCr5Q0+TEgHRweC+enwQusjqMtlI1EkGeWg5Fc8v5EUtL5CYtPwGvjy7Y
         wxedrz24VpoYuKePCgvtk4tUbOPStaCJuwllYA4xqQ0LEPufL0mrU5BYZt0zGTZAifxS
         tqTgyALXd7WbgYfovohznL93YBCG66Bqs8Cktq6+HrKt6pBXwXEItr5ch5sYXHE2Un6W
         XHhybIq+feGHhNI4Ls+b4C1JjDJ8+a84kOeE3+I1zZXnwNH8PEvVkxYxEAOTd9cZF2Cf
         E2aw==
X-Gm-Message-State: AOJu0Yy98JH1QwMg0jKa0oC32aqxhIudecf8XB28xIbXycPqlPrm39+y
        5Bx8wpY7cEzUktoHTVVilyVXYhKYdoy9+SbNqDb6GJH+uZ3bNOcf
X-Google-Smtp-Source: AGHT+IHqSIzjgZOzASsrpcTN+znEYKknuoJ5PzARcbqh9kTTYG2hb257Ok/CF0rJYa5zdY6TUg1dKd9LH/gRHKUI/po=
X-Received: by 2002:a2e:9812:0:b0:2c5:844:9e75 with SMTP id
 a18-20020a2e9812000000b002c508449e75mr8625502ljj.8.1698702282875; Mon, 30 Oct
 2023 14:44:42 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 30 Oct 2023 14:44:42 -0700
MIME-Version: 1.0
In-Reply-To: <20231028162638.5b477ded@jic23-huawei>
References: <20231026-strncpy-drivers-iio-proximity-sx9324-c-v2-1-cee6e5db700c@google.com>
 <20231028162638.5b477ded@jic23-huawei>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 30 Oct 2023 14:44:42 -0700
Message-ID: <CAE-0n51eAH1tcqXVeReavq0US-Th2qwC_s_uAzRKTpSG-kXuwA@mail.gmail.com>
Subject: Re: [PATCH v2] iio: sx9324: avoid copying property strings
To:     Jonathan Cameron <jic23@kernel.org>,
        Justin Stitt <justinstitt@google.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jonathan Cameron (2023-10-28 08:26:38)
> On Thu, 26 Oct 2023 23:53:28 +0000
> Justin Stitt <justinstitt@google.com> wrote:
>
> > We're doing some needless string copies when trying to assign the proper
> > `prop` string. We can make `prop` a const char* and simply assign to
> > string literals.
> >
> > For the case where a format string is used, let's allocate some memory
> > via kasprintf() and point prop to it.
> >
> > This also cleans up some deprecated strncpy() uses [1].
> >
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
>
> Seems reasonable to me.
>
> +CC Gwendal (+ Stephen) as it's Gwendal's driver and I think they are still actively
> maintaining it.

Thanks! I have some review comments.

> > diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
> > index 438f9c9aba6e..c8547035cb47 100644
> > --- a/drivers/iio/proximity/sx9324.c
> > +++ b/drivers/iio/proximity/sx9324.c
> > @@ -885,7 +885,7 @@ sx9324_get_default_reg(struct device *dev, int idx,
> >  #define SX9324_RESOLUTION_DEF "semtech,ph01-resolution"
> >  #define SX9324_PROXRAW_DEF "semtech,ph01-proxraw-strength"
> >       unsigned int pin_defs[SX9324_NUM_PINS];
> > -     char prop[] = SX9324_PROXRAW_DEF;
> > +     const char *prop = SX9324_PROXRAW_DEF;

Do we need this define anymore, or the initialization?

> >       u32 start = 0, raw = 0, pos = 0;
> >       int ret, count, ph, pin;
> >       const char *res;
> > @@ -899,7 +899,7 @@ sx9324_get_default_reg(struct device *dev, int idx,
> >       case SX9324_REG_AFE_PH2:
> >       case SX9324_REG_AFE_PH3:
> >               ph = reg_def->reg - SX9324_REG_AFE_PH0;
> > -             snprintf(prop, ARRAY_SIZE(prop), "semtech,ph%d-pin", ph);
> > +             prop = kasprintf(GFP_KERNEL, "semtech,ph%d-pin", ph);

Do we not care if the allocation fails? We just use the default?

> >
> >               count = device_property_count_u32(dev, prop);
> >               if (count != ARRAY_SIZE(pin_defs))
> > @@ -913,6 +913,7 @@ sx9324_get_default_reg(struct device *dev, int idx,
> >                       raw |= (pin_defs[pin] << (2 * pin)) &
> >                              SX9324_REG_AFE_PH0_PIN_MASK(pin);
> >               reg_def->def = raw;
> > +             kfree(prop);

We need to free it in other places too, like if the count doesn't match.
It may be easier to extract this section and just have 4 string
literals.

	switch (reg_def->reg) {
        case SX9324_REG_AFE_PH0:
		reg_def = sx9324_parse_phase_prop(dev, reg_def, "semtech,ph0-pin");
		break;
        case SX9324_REG_AFE_PH1:
		reg_def = sx9324_parse_phase_prop(dev, reg_def, "semtech,ph1-pin");
		break;
        case SX9324_REG_AFE_PH2:
		reg_def = sx9324_parse_phase_prop(dev, reg_def, "semtech,ph2-pin");
		break;
        case SX9324_REG_AFE_PH3:
		reg_def = sx9324_parse_phase_prop(dev, reg_def, "semtech,ph3-pin");
		break;

> >       case SX9324_REG_AFE_CTRL0:
> >               ret = device_property_read_string(dev,
