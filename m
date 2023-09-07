Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80FFB796ECE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 04:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238546AbjIGCIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 22:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbjIGCIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 22:08:05 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FAD122;
        Wed,  6 Sep 2023 19:08:01 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5298e43bb67so820529a12.1;
        Wed, 06 Sep 2023 19:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694052479; x=1694657279; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MVJzoqUt2EfIkX7hkmjvOoAUu9HchWRbrlDoFZ+hJoQ=;
        b=WPPi2TGPoOfqTfX+Lj/HaH45Y5sz8XBDYHq5kycTcRKs/uzQy1AVuME9uVlI+FROPJ
         1JEQ2iJi5hkBijX+gs27cNF6J1AN63+AirDfcsVa5Gqwk/iJPM9hEDbchOkrFd95TEPB
         b7mDu/Bbdr20nrt3QpIqtktcdtaLEecfO6fgJoNdGY536PqXcniOjLZtkID8+srKM6Ds
         iZqcuUAtz3jYmI6mucEBYbVFGvpx5BS5VYu4XEhE2IYd6LB6awcCuW/akjR5tCUbB/UY
         XqCp2+vs8IQvfsPOHLvLCQtMTyod266mr54iiJ4mg9FKIXkf8HUlUjyaGJUt+EubLnFp
         1QeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694052479; x=1694657279;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MVJzoqUt2EfIkX7hkmjvOoAUu9HchWRbrlDoFZ+hJoQ=;
        b=KMbEnjeoAMiLmawh7Lu/DFVU6rZd94eKRpQ31CzCAJAS4KN2SvOny4hvI+8bTZ6aAR
         rnMA3y4TRL8Fvik4SIxN1u18yrPB5rzdv94XlDLgMnJE29jR4s3/hjHt32LefSp1g8pi
         X5OgnD3A9SXDFo8138P+YYaMcqhy1Nfz4jgYhl8aIAEssqU/OhxIJmnOnY1LJq+TV/JW
         8GZQ8WBudlc+Xy76DleuOWS6vbQRanvQbuuDSEwhd6Jt7A2f4i3yFKej5EGNgoZqiYeJ
         a+sBBxQWPmeKEHp67qytYUsqpx2aK1D0MWT6u0vNz07Kdjajc+MJPW0CjdKwd3ZtVxB5
         DzSw==
X-Gm-Message-State: AOJu0YyiL5yuiVUuXj+1Rrl+wEs2e+Q9B/9kxDWqLV3avQPMWlbiFkm1
        DHMeCKIhtBT2kyRsMMURWdcXOoM4m7/T7xvpunJakbsg
X-Google-Smtp-Source: AGHT+IHnnPI+P0kZvfSUHFgUh+wqipi9ZGvxiJ3phfm7+y6/1l0K57YzyLh0dfS0t0Uh+vvCnZ8DEsjZ5ObNga7apz4=
X-Received: by 2002:a05:6402:2692:b0:529:d147:e9f3 with SMTP id
 w18-20020a056402269200b00529d147e9f3mr1576126edd.5.1694052479344; Wed, 06 Sep
 2023 19:07:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230904123320.93980-1-brgl@bgdev.pl>
In-Reply-To: <20230904123320.93980-1-brgl@bgdev.pl>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Thu, 7 Sep 2023 10:07:22 +0800
Message-ID: <CAAfSe-s41jd+REw-weWNZ+CX1MH5M2ukEA-dm--n3jQc1t1JJA@mail.gmail.com>
Subject: Re: [RFT PATCH] gpio: eic-sprd: use atomic notifiers to notify all
 chips about irqs
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Wenhua Lin <wenhua.lin@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

On Mon, 4 Sept 2023 at 20:33, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Calling gpiochip_find() from interrupt handler in this driver is an
> abuse of the GPIO API. It only happens to work because nobody added a
> might_sleep() to it and the lock used by GPIOLIB is a spinlock.

Thanks for the fix.

I back-ported this patch to an internal tree, and my colleague Wenhua
helped make a basic test, there's no problem found. So please feel
free to add:

Reviewed-by: Chunyan Zhang <zhang.lyra@gmail.com>
Tested-by: Wenhua Lin <wenhua.lin@unisoc.com>

Cheers,
Chunyan

>
> Both will soon be changed as we're limiting both the number of
> interfaces allowed to be called from atomic context as well as making
> struct gpio_chip private to the GPIO code that owns it. We'll also
> switch to protecting the global GPIO device list with a mutex as there
> is no reason to allow changes to it from interrupt handlers.
>
> Instead of iterating over all SPRD chips and looking up each
> corresponding GPIO chip, let's make each SPRD GPIO controller register
> with a notifier chain. The chain will be called at interrupt so that
> every chip that already probed will be notified. The rest of the
> interrupt handling remains the same. This should result in faster code as
> we're avoiding iterating over the list of all GPIO devices.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
> I only build-tested it. Please take it for a ride, I hope this works.
>
>  drivers/gpio/gpio-eic-sprd.c | 44 ++++++++++++++++++++----------------
>  1 file changed, 25 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
> index 5320cf1de89c..21a1afe358d6 100644
> --- a/drivers/gpio/gpio-eic-sprd.c
> +++ b/drivers/gpio/gpio-eic-sprd.c
> @@ -9,6 +9,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/notifier.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/spinlock.h>
> @@ -91,12 +92,20 @@ enum sprd_eic_type {
>
>  struct sprd_eic {
>         struct gpio_chip chip;
> +       struct notifier_block irq_nb;
>         void __iomem *base[SPRD_EIC_MAX_BANK];
>         enum sprd_eic_type type;
>         spinlock_t lock;
>         int irq;
>  };
>
> +static ATOMIC_NOTIFIER_HEAD(sprd_eic_irq_notifier);
> +
> +static struct sprd_eic *to_sprd_eic(struct notifier_block *nb)
> +{
> +       return container_of(nb, struct sprd_eic, irq_nb);
> +}
> +
>  struct sprd_eic_variant_data {
>         enum sprd_eic_type type;
>         u32 num_eics;
> @@ -494,13 +503,6 @@ static void sprd_eic_toggle_trigger(struct gpio_chip *chip, unsigned int irq,
>         sprd_eic_irq_unmask(data);
>  }
>
> -static int sprd_eic_match_chip_by_type(struct gpio_chip *chip, void *data)
> -{
> -       enum sprd_eic_type type = *(enum sprd_eic_type *)data;
> -
> -       return !strcmp(chip->label, sprd_eic_label_name[type]);
> -}
> -
>  static void sprd_eic_handle_one_type(struct gpio_chip *chip)
>  {
>         struct sprd_eic *sprd_eic = gpiochip_get_data(chip);
> @@ -546,27 +548,29 @@ static void sprd_eic_handle_one_type(struct gpio_chip *chip)
>  static void sprd_eic_irq_handler(struct irq_desc *desc)
>  {
>         struct irq_chip *ic = irq_desc_get_chip(desc);
> -       struct gpio_chip *chip;
> -       enum sprd_eic_type type;
>
>         chained_irq_enter(ic, desc);
>
>         /*
>          * Since the digital-chip EIC 4 sub-modules (debounce, latch, async
> -        * and sync) share one same interrupt line, we should iterate each
> -        * EIC module to check if there are EIC interrupts were triggered.
> +        * and sync) share one same interrupt line, we should notify all of
> +        * them to let them check if there are EIC interrupts were triggered.
>          */
> -       for (type = SPRD_EIC_DEBOUNCE; type < SPRD_EIC_MAX; type++) {
> -               chip = gpiochip_find(&type, sprd_eic_match_chip_by_type);
> -               if (!chip)
> -                       continue;
> -
> -               sprd_eic_handle_one_type(chip);
> -       }
> +       atomic_notifier_call_chain(&sprd_eic_irq_notifier, 0, NULL);
>
>         chained_irq_exit(ic, desc);
>  }
>
> +static int sprd_eic_irq_notify(struct notifier_block *nb, unsigned long action,
> +                              void *data)
> +{
> +       struct sprd_eic *sprd_eic = to_sprd_eic(nb);
> +
> +       sprd_eic_handle_one_type(&sprd_eic->chip);
> +
> +       return NOTIFY_OK;
> +}
> +
>  static const struct irq_chip sprd_eic_irq = {
>         .name           = "sprd-eic",
>         .irq_ack        = sprd_eic_irq_ack,
> @@ -653,7 +657,9 @@ static int sprd_eic_probe(struct platform_device *pdev)
>                 return ret;
>         }
>
> -       return 0;
> +       sprd_eic->irq_nb.notifier_call = sprd_eic_irq_notify;
> +       return atomic_notifier_chain_register(&sprd_eic_irq_notifier,
> +                                             &sprd_eic->irq_nb);
>  }
>
>  static const struct of_device_id sprd_eic_of_match[] = {
> --
> 2.39.2
>
