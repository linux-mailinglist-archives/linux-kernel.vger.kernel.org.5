Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDA87978F6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238440AbjIGQ7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242975AbjIGQhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:37:53 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF3183F0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:13:33 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-450711d9bf1so458393137.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 09:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694103149; x=1694707949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwy6uKOVyjPH/vJMAsaPCoM0fNwaGdU7NPhSy+lwVBs=;
        b=CwuSUveljwfoviue40+Yz3DBBOto7LBso8264CDPMzAjQAbnMvZnbYINxeKyWFxGkk
         vMA/I+Yi9k50Crl6YPVkSRtoiPQhgxnBSRPf2YlvhL4SSlN4Igm6AAdNxKC2oALZLvAB
         RsPPvRg0BdrmE0u44BUDDwJ1RT9E/kAvn6IYPo76xNOFFVu6JCACUZ7UIyvHDfcrqged
         G7+zslaCuiSp2Zh2HNLdaSfz/QZuKQm5AJeRYoi3Es9e2RTLm2J/dw49FoTUgOk5HmnM
         6zPAF8h4O27KbQJn+gs0PCnh8XTm0AFoDpj59pN+oyZJ1sV1wRMfSnNdWcSM4xRp63nM
         Qlxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694103149; x=1694707949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pwy6uKOVyjPH/vJMAsaPCoM0fNwaGdU7NPhSy+lwVBs=;
        b=W5PNhdqc6z3dDxmVaeRmoGHe1PMAcVHTSKA4nQkWsQlCOTM8iyTbv0ev0stmc95xR9
         megfqvQUTTuQZItD3RoZyGH2cpuggx5PevmYmuVwBWePllBu7l63fx2iKlSAsAmXM5nt
         58/+DnDKX38uc/hvER9leY/EV2fyABaAzIFNJR4q68m4JrlXOqiFoGFobgAGnAevp0Zr
         N6VV0ttDTOoLGRF35gO/UI5Wb28pjrhhKM/7T22PlxHjZv5XedvUHCuTU2mG2RiBVCCE
         bWxBFBLuhBkP5krX68XQSYjel/oICq08pv5rs5DBrgd2tOjaYGVm6tQyK5uL/pTitRis
         gIbQ==
X-Gm-Message-State: AOJu0Yxh9JL/NRj61ktxSK7SB3tizOjF65jPqITCm0lYNFZfWd85HoNT
        +zKFe9KYJRmuh8axLLJmRy5KZ/qdhsN+v5CbnPuIYOP4M0ztr7bgqKo=
X-Google-Smtp-Source: AGHT+IFDrgWVURx3JNju7kZZF1wu9Y/TadMJ5yuRpzoXN8X2bh2xdWz8hzInBvmi+tzixNC0aGXs9GN4uotRGCxcdwY=
X-Received: by 2002:a25:dc54:0:b0:d44:a90b:ba50 with SMTP id
 y81-20020a25dc54000000b00d44a90bba50mr19457872ybe.5.1694071251891; Thu, 07
 Sep 2023 00:20:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230905185309.131295-1-brgl@bgdev.pl> <20230905185309.131295-11-brgl@bgdev.pl>
In-Reply-To: <20230905185309.131295-11-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Sep 2023 09:20:40 +0200
Message-ID: <CACRpkdZdaBELiyR8da2GHxj+=FFzsvL+5POX5139+OTA8rKUeg@mail.gmail.com>
Subject: Re: [PATCH 10/21] gpiolib: replace find_chip_by_name() with gpio_device_find_by_label()
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
> Remove all remaining uses of find_chip_by_name() (and subsequently:
> gpiochip_find()) from gpiolib.c and use the new
> gpio_device_find_by_label() instead.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

With Andy's comment addressed:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
