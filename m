Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49A681242C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 01:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442902AbjLNA7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 19:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234117AbjLNA7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 19:59:00 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4BF100
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 16:59:06 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c9ea37ac87so105003481fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 16:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702515544; x=1703120344; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TLPQRFERPZKZe4sP96FP5UOkMogbBRWOBLXtIS+wgKA=;
        b=H+HCa4Dum7Yqt6M+Vya5PNZ9+zhC6v6nSGCkjXiZNSJL8vobmRR9jQwjxW9HeiWm6H
         SeWzH4GxlydbCrGFArGv7H1LSq0cu1QFXCQsoQ8RV8qH00V/rvt2NhGll4r2mMlY8KJV
         khPbSsqL01hzPqoON5GpJEB1bXDyXt7eVLVB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702515544; x=1703120344;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLPQRFERPZKZe4sP96FP5UOkMogbBRWOBLXtIS+wgKA=;
        b=g++teJ0UMPvGKL/jDfnZuRna69eKwh5RHHkOA/DBu2PeD4/ENbDz4eI/FWJxXsNyDA
         4o8/8LBOIZjVjmoW9YJ6g6ADTSZUgvoapBZu+VZftUkZeMizOyMpr0QvGF2D0QyZbg/d
         m2MjUYgoeeK3HDyOY+n9Kb3Fq426cjMD/xQhwvAbfIErmlddY87gNkY5Ga0r0r6a7OG3
         3CPthAxuRmOi2jkbN/o08v1QrjnBhE50e1xLQcRcPn/yuks+o8PTSz409ju00zPgfOqm
         vne8fD2qBu/bppzmlrdqi3LFQhym2k/qst1ddQ+JpsbkXqN5jd352XviarYXoCtRVum3
         Y81g==
X-Gm-Message-State: AOJu0YwiYrx8Uwmy0n/9oVVTOf4UN98g6Jx3WE72St3J3/w02SWF6nZU
        cRjM/uFcfyV1Yj6EGFCV7EG9qarAVIgaZRJ/TY0uaw==
X-Google-Smtp-Source: AGHT+IEunZGd9tNek4p895u1vSnibbU895Lddmz8b+pc8eZ7RAYfA5ccHN3CMRjZTHj2uRjOAKt0XYWsogRcyShRfeY=
X-Received: by 2002:a2e:a4b8:0:b0:2cc:1d91:83fc with SMTP id
 g24-20020a2ea4b8000000b002cc1d9183fcmr2754449ljm.30.1702515544589; Wed, 13
 Dec 2023 16:59:04 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Dec 2023 16:59:04 -0800
MIME-Version: 1.0
In-Reply-To: <20231212-strncpy-drivers-iio-proximity-sx9324-c-v3-1-b8ae12fc8a5d@google.com>
References: <20231212-strncpy-drivers-iio-proximity-sx9324-c-v3-1-b8ae12fc8a5d@google.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 13 Dec 2023 16:59:04 -0800
Message-ID: <CAE-0n50U47OKs50bOf91HoOayVJEj=H6P-cpyZ_46pX8CVZ4BQ@mail.gmail.com>
Subject: Re: [PATCH v3] iio: sx9324: avoid copying property strings
To:     Jonathan Cameron <jic23@kernel.org>,
        Justin Stitt <justinstitt@google.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Justin Stitt (2023-12-11 16:42:52)
> diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
> index 438f9c9aba6e..e3bc30b57b19 100644
> --- a/drivers/iio/proximity/sx9324.c
> +++ b/drivers/iio/proximity/sx9324.c
> @@ -873,6 +873,32 @@ static int sx9324_init_compensation(struct iio_dev *indio_dev)
>                                         20000, 2000000);
>  }
>
> +static u32 sx9324_parse_phase_prop(struct device *dev,

return u8? because that's the type of struct sx_common_reg_default::def.

> +                                  struct sx_common_reg_default *reg_def,
> +                                  int idx, const char *prop)
> +{
> +       unsigned int pin_defs[SX9324_NUM_PINS];
> +       int count, ret, pin;
> +       u8 default_def;
> +       u32 raw = 0;
> +
> +       default_def = sx9324_default_regs[idx].def;

Do we need to do this? Isn't this reg_def->def?

> +
> +       count = device_property_count_u32(dev, prop);
> +       if (count != ARRAY_SIZE(pin_defs))
> +               return default_def;

return reg_def->def?

> +       ret = device_property_read_u32_array(dev, prop, pin_defs,
> +                                            ARRAY_SIZE(pin_defs));
> +       if (ret)
> +               return default_def;

return reg_def->def?

> +
> +       for (pin = 0; pin < SX9324_NUM_PINS; pin++)
> +               raw |= (pin_defs[pin] << (2 * pin)) &
> +                      SX9324_REG_AFE_PH0_PIN_MASK(pin);
> +
> +       return raw;
> +}
> +
>  static const struct sx_common_reg_default *
>  sx9324_get_default_reg(struct device *dev, int idx,
>                        struct sx_common_reg_default *reg_def)
> @@ -884,35 +910,30 @@ sx9324_get_default_reg(struct device *dev, int idx,
>  #define SX9324_PIN_DEF "semtech,ph0-pin"
>  #define SX9324_RESOLUTION_DEF "semtech,ph01-resolution"
>  #define SX9324_PROXRAW_DEF "semtech,ph01-proxraw-strength"

Can you send a followup to remove these defines?

> -       unsigned int pin_defs[SX9324_NUM_PINS];
> -       char prop[] = SX9324_PROXRAW_DEF;
> +       const char *prop = SX9324_PROXRAW_DEF;

This can be left unassigned now, right?

>         u32 start = 0, raw = 0, pos = 0;
> -       int ret, count, ph, pin;
>         const char *res;
> +       int ret;
