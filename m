Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FA4797399
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236619AbjIGP1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245106AbjIGP0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:26:22 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6855C10F9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:25:56 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c22103bce7so8648405ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 08:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694100342; x=1694705142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I18DoVxRqFJaTqip4HKub/TPXgj9WnWp7a45EaJWvuM=;
        b=l8GDktJzN/OCcfahYXjB+1a7cuC1PEGzMtsuk6gKCUjbcwh3AW2HOa3lej4UNR7GJk
         vTkPrdKARYBimU5+iDtFm7HT139OvHOvURgxRoeZMu1WkFT/vlzwLyXvglNz+uUWbiZ+
         /zcIKot+YZfa9sVAsyvyGoNgJnRLJlN/GAzx+OKkndkWSnYweqgGWl4FApfj0NYbwNp2
         pqwb1fbnXcqNCdZfT+JDT6OxeLGSbmvhaKvBk75ltzq2FtvEWx2xdyw1xVbp1RmUQaJQ
         iLMTVWqDa+ZtXEfdfdsnyC7iOfrQLKPZfvXoJdtoFUdn6XW4U1sPjCIWkR/EojVCqGXd
         Zc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694100342; x=1694705142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I18DoVxRqFJaTqip4HKub/TPXgj9WnWp7a45EaJWvuM=;
        b=NSaQh4fIeTGUa2M1DXbsTUqCdkrN90h9g7L66QVLLyF7r3GAs4JT/iwvYSAgF7Fj+2
         KFL3u9YwFYk5NETwaR7iw7EDMy8u6vAsK+P2YWqbtvla6ox2Hzhxg5pbEQPnbQ/xP25Q
         ujdy87aAMUyWr6eqwW2eaIcEfPO17yuONhAIyG3k/Nor49+pNELP75lP4lHjAZZ7Kegb
         qGmCXno2e9cE2iSTWBXAK5RmI9yv8axWKI+rrceYWOKqe4HM7bBalDrwXLMLfnXmz3Sj
         e5BMcSbGQeSBoDU1HWxhYD3XH01cVjwgi7M8v0fG7H3I++wUORkme0yHSe1zXWApAJfg
         qHug==
X-Gm-Message-State: AOJu0Yw4VUbDP2N/bU4voOX57CsaEYJIthf+EUv1Epz6pkBcTq4ro0+Y
        /JQpFg8CX/ice442nt2SMuLFNUHmxuGNMkyn7LOo8TWwY558TXzU90g=
X-Google-Smtp-Source: AGHT+IH52ZmMDQle74d5+xBv94alRH/CYtL/TIhLKM9b7HFrce/j3cJJJRCz5BcoTZ3hxH+Wxp8LvqydUyq2rr0UgjU=
X-Received: by 2002:a25:5f0d:0:b0:d7b:90c6:683c with SMTP id
 t13-20020a255f0d000000b00d7b90c6683cmr17866183ybb.26.1694070426178; Thu, 07
 Sep 2023 00:07:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230905185309.131295-1-brgl@bgdev.pl> <20230905185309.131295-4-brgl@bgdev.pl>
In-Reply-To: <20230905185309.131295-4-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Sep 2023 09:06:55 +0200
Message-ID: <CACRpkdbE5AJHiGan_oj4_kBSOh7okfwM0u9qDcEyTBr+NCO=wA@mail.gmail.com>
Subject: Re: [PATCH 03/21] gpiolib: provide gpio_device_find_by_label()
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

On Tue, Sep 5, 2023 at 8:53=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> By far the most common way of looking up GPIO devices is using their
> label. Provide a helpers for that to avoid every user implementing their
> own matching function.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Yeah this is what everyone and their dog reimplements.
Good to centralize this.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
