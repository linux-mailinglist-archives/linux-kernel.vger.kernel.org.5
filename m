Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46317C6642
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 09:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347087AbjJLHIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 03:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347095AbjJLHIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 03:08:15 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9BFD3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 00:08:13 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a7c08b7744so8019267b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 00:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697094492; x=1697699292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6LTG7rNkCjAldArlcZN368ICgAdW72qceKrtpj1A5s4=;
        b=avfRZJQyUwTV9M23oMiRV366w+lCVnMYuxJnG7CKdORhxbsdYAhZ4CIyCS0IozPRTm
         tZwDVuZ3TuREv0/qW4ylOUjK3KvcVbCVGtSkfyogvkfsaOZPMdkfP2jikuw2GuaJuuM5
         DhLkBhdSe9lNOtrhN1wFCUDDOLftVM/gZ2Gvc/AykX7B8jlO0zTuxH5QsDTtFViaqcwq
         WCAsAq5YD2rjKn5+Rc6dOSxb+p0MdtX4wT+/Xs8FeKLF38Xlvdl3oDS6Z+28ybM0XvXP
         bsJadwXedeeGFI1DyX0Q/OF+260PlRwSIckuS0bfiIUA9N8qLjgC9Gm/4YSUubz+nu2w
         xJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697094492; x=1697699292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6LTG7rNkCjAldArlcZN368ICgAdW72qceKrtpj1A5s4=;
        b=uYlOa0n8lNdcNVyKHfoUyPFDOVyzN29uhA4Ebgndz8hQZnzhdVOEudreIb/NeVnz0V
         nuSD89Qc7Y20Y9a+f9i0VGhXewuH7TUY5V+Wy/iutjgsRSAEQRe9GskBJGc8WDueCBLu
         RCzFkrzn0LPVP8usck5A47Jy1ItIxck1Cys3WBoJezeXZfTcVDVlSCCV7c81aQR5zop+
         RLfDsvoXUjMM1QUgSZ60nvfnM3PGAjpX1oCygavYcb1Sv/1PzrL9TsoYPtr0wdNTIt/v
         TUGa4HaR4tAw++3LKQ3aBP/6sVg74bt/nfOJSewfN1bFMYGtU2BK8crLIYFyIPddB9qp
         C2rg==
X-Gm-Message-State: AOJu0YzY0jIYoFQGeO7JW7IJpqyv9hZ+fMxUMeJjvEGi7DkqdM6oyAXz
        VMyHuYqzUZiPCRYxOV0VSl/ReiZNp/rI7MiHvXmHlQ==
X-Google-Smtp-Source: AGHT+IGLGESA45NhXOxokN7L7YpSELFYWRuedqO8ITMykZOb8pCOQ235Yi2CIMgTBCuVXdT1djLY5B0V1M8k3cqm5u0=
X-Received: by 2002:a81:8647:0:b0:595:89b0:6b56 with SMTP id
 w68-20020a818647000000b0059589b06b56mr25953031ywf.28.1697094492613; Thu, 12
 Oct 2023 00:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231011120830.49324-1-brgl@bgdev.pl>
In-Reply-To: <20231011120830.49324-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Oct 2023 09:08:01 +0200
Message-ID: <CACRpkdYe+U0vs+xB-H8pjR_f4xt_7sQpZQvHCTLGH_tG=UiUwQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/62] pinctrl: don't use GPIOLIB global numberspace in helpers
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 2:09=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:


> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> We have a set of pinctrl helpers for GPIOLIB drivers that take a number
> from the global GPIO numberspace as argument. We are trying to get rid
> of this global numbering. Let's rework these helpers to use the
> recommended gpio_chip + controller-relative offset instead.
>
> This work is split into phases: first let's introduce the new variants
> of the helpers. Next: let's convert all users one-by-one for easier
> review. After that let's remove the old helpers and rename the new
> variants to take the place of the old ones. Finally convert static
> functions in pinctrl/core.c to using the same signature and to top it
> off, let's remove now redundant wrappers around the pinctrl_helpers.
>
> This series introduces no functional changes in drivers so I decided to
> not spam every single driver maintainer anymore.
>
> v1 -> v2:
> - drop the conversion to using cleanup.h helpers as this is not the
>   subject of this series
> - split the patch renaming the new variants to the old names into
>   several patches that perform the operation step by step for easier
>   review
> - collect review tags and acks
> - add follow-up patches that drop the wrappers around pinctrl helpers
>   where applicable (where all the wrappers do is call the helper)
> - fix build error with PINCTRL disabled

I tried to apply the series for a test, with the intent to queue this for
v6.7, but there are conflicts toward both v6.6-rc1 and my pin control
devel branch, so I can't.

Since we are at -rc5 and the kernel looks better after the patches
than before I think they should just be applied and not held back
by minor review nits or process. But i couldn't.

I'm fine with the series as they are, but it looks like we need to queue
it at v6.7-rc1 for v6.8 or you need to send it to Torvalds after he
merged GPIO and pin control for v6.7, either works for me!

Yours,
Linus Walleij
