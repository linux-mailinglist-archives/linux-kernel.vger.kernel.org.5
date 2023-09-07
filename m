Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74FB7975A7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241468AbjIGPx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236485AbjIGPsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:48:15 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70294687
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:39:33 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-7a512434bc9so1298801241.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 08:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694101132; x=1694705932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f20OVJZsVkvgr12m2GLQpGE6nkKLjOApm9F1D76ZYu4=;
        b=lvrvrDQi2t0Y1C2RTi8TBzPkrlUi8hfhyvuS6Z9TMUHO1QPlqF+xoOBNrLkvMECLIR
         276n+Hyt2vHi52IXB5jg3HTwQX7+LBUR0PAHDQbV7snRRIRAaenLiupYzeayDazwy3uG
         qZUcH9vUd6PKFZel5MA/FDNQs2x9TGrnNbNQGY545J2PobhBEMp5zRtRv0kQ7OA4iBaK
         G5Ya1gn/yN9JMrdaoUjhJRXTZtSuHNAuoN1cbCk9F3+7xv+/j7O6U4eXYPRsTd2Opa00
         FChWyRvE3ySue4iq/H7fEdq0AK578RcP5enrUFB/MrLprVNarrxgLxSJx/ROgh7n6oG7
         QKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694101132; x=1694705932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f20OVJZsVkvgr12m2GLQpGE6nkKLjOApm9F1D76ZYu4=;
        b=Zc2lus2/3X6G/+6htm4IoliPPuJheWEdo1JYSJkqm4SkiHLrxJVEdBCoBYoHYaW300
         T8AQUNS7Hgos/0tOvvqy54vb916sgMuLA89vB2+EBVtzd+mdGkEwLFw5qKNMQMTHyUkr
         Sb9eJlz3kfWkmXfocHDADExLqu5khRJGJ+9k6CTDCLJENyGbCUwVJRD+avkM77H46PUa
         nS0Ej9BjY7kSbgFbf0o4xkHVasxuubVQr+wg5kr70W9FvcbcEL+mU4pmy98YVKeDqbcP
         We6+erzYERueK+M0ip1BvYGeNWxEZJnZVoWJQdzeh44Yz0ar3FWnt9AnsLpqBfeSen20
         cO3A==
X-Gm-Message-State: AOJu0YyIKXLYcH7XY/VyxUV1Sex8+HgdvK3z8qdr2NCbuIHLz4ryVLnQ
        9JbFZ/ghLaQQYLkWTux5FeWy5zbqUxrHOU9O+KSobMlMybtbWsZ9+/w=
X-Google-Smtp-Source: AGHT+IHeVaENuEkywllarylsoaxFtkX8+wcxLmOt1RC5WvBdIS3BKktFFG9wSU0jnwmUX/wjU0B+ttekv3ZROcdPEGQ=
X-Received: by 2002:a25:f414:0:b0:d73:ed30:1162 with SMTP id
 q20-20020a25f414000000b00d73ed301162mr1939775ybd.28.1694072320536; Thu, 07
 Sep 2023 00:38:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230905185309.131295-1-brgl@bgdev.pl> <20230905185309.131295-18-brgl@bgdev.pl>
In-Reply-To: <20230905185309.131295-18-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Sep 2023 09:38:29 +0200
Message-ID: <CACRpkdZbCjFMytzsF6Sb-6V54J+owk+zJ3oB9ZGCzAdsGwcFOQ@mail.gmail.com>
Subject: Re: [PATCH 17/21] gpio: of: replace gpiochip_find_* with gpio_device_find_*
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dipen Patel <dipenp@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, timestamp@lists.linux.dev,
        linux-tegra@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Sorry for fatfinger reply)

On Tue, Sep 5, 2023 at 8:53=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> We're porting all users of gpiochip_find() to using gpio_device_find().
> Update the OF GPIO code.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Scoped guards, nice!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
