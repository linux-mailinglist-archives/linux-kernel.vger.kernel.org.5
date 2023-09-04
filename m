Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17250791284
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240279AbjIDHqo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Sep 2023 03:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348138AbjIDHql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:46:41 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80272F0;
        Mon,  4 Sep 2023 00:46:37 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-d7e6d9665bcso1021252276.1;
        Mon, 04 Sep 2023 00:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693813596; x=1694418396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9C+8Z665O4fvCEaAa7Pbx2XZtf5Iax3NtZdPGFPP7KY=;
        b=lFEa/m5s4MQghmXDcQKYzaI0xjMngVW4oJtR+dvosIOBFHA2CkcyYNZao7VZa+kXzj
         /it8TuIBl1GwMaGTNkt1cID5zj9VobsZWucEXEW6xN2o/vlsQx638HzjoaonVW80Y3Nl
         NxRYCDbDaE+GyG/TFfoA5qLQO+fitVrTmzvMzw78AMKFQwhAxCRw8O//GYhWzz7ClZSm
         JJfs9u7geQQYOGSlwwT9rVFdWI6Jr308v3VWUL8FHdJSjdAzCXz2xChx6vlJo9x8aJVJ
         fYRU6ObCwDhoNvjxJGr+sGs+sA8JzIlUEpIDVxOU7an5CWEU43DtRgwevS0iMiHIqlVB
         fb4w==
X-Gm-Message-State: AOJu0YxsVTiBT05UN1ir1jr14rOL+OSJN74X51AxwHZyxWw4E3ImeVwL
        hpxlVI7C7eHypt9anriU2Q03p94TwbA4Fw==
X-Google-Smtp-Source: AGHT+IE+ZLx+8RIWWK4oxbp5N6Vc4rXHG/Oy1WybUloYxCpNFsXhbH17f0eP7RjmUX0Jo6+v1mMdeQ==
X-Received: by 2002:a25:d04b:0:b0:d15:454e:8ecd with SMTP id h72-20020a25d04b000000b00d15454e8ecdmr9898334ybg.13.1693813596562;
        Mon, 04 Sep 2023 00:46:36 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id c198-20020a25c0cf000000b00d71855984b5sm2226168ybf.18.2023.09.04.00.46.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 00:46:36 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-d77a4e30e97so1021193276.2;
        Mon, 04 Sep 2023 00:46:36 -0700 (PDT)
X-Received: by 2002:a25:b191:0:b0:d7e:44de:1c1 with SMTP id
 h17-20020a25b191000000b00d7e44de01c1mr9569214ybj.14.1693813595936; Mon, 04
 Sep 2023 00:46:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230903160349.3919-1-sensor1010@163.com>
In-Reply-To: <20230903160349.3919-1-sensor1010@163.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Sep 2023 09:46:24 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWdxveto0Vfv5jswk+PrkcvFgh2tA1xjDpd7i3Cds_FhQ@mail.gmail.com>
Message-ID: <CAMuHMdWdxveto0Vfv5jswk+PrkcvFgh2tA1xjDpd7i3Cds_FhQ@mail.gmail.com>
Subject: Re: [PATCH] input: gpio-keys - use spin_lock()
To:     Lizhe <sensor1010@163.com>
Cc:     dmitry.torokhov@gmail.com, Jonathan.Cameron@huawei.com,
        soyer@irl.hu, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lizhe,

Thanks for your patch!

On Sun, Sep 3, 2023 at 6:04 PM Lizhe <sensor1010@163.com> wrote:
> Use the spin_lock() and spin_unlock() instead of spin_lock_irqsave()
> and spin_unlock_restore()

Please explain why...

> Signed-off-by: Lizhe <sensor1010@163.com>

> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -468,11 +468,10 @@ static irqreturn_t gpio_keys_irq_isr(int irq, void *dev_id)
>  {
>         struct gpio_button_data *bdata = dev_id;
>         struct input_dev *input = bdata->input;
> -       unsigned long flags;
>
>         BUG_ON(irq != bdata->irq);
>
> -       spin_lock_irqsave(&bdata->lock, flags);
> +       spin_lock(&bdata->lock);
>
>         if (!bdata->key_pressed) {
>                 if (bdata->button->wakeup)
> @@ -495,7 +494,7 @@ static irqreturn_t gpio_keys_irq_isr(int irq, void *dev_id)
>                               ms_to_ktime(bdata->release_delay),
>                               HRTIMER_MODE_REL_HARD);
>  out:
> -       spin_unlock_irqrestore(&bdata->lock, flags);
> +       spin_unlock(&bdata->lock);
>         return IRQ_HANDLED;
>  }

Are you sure this is safe, given the interrupt is requested with
devm_request_any_context_irq(), and thus the handler may be registered
using either request_irq() or request_threaded_irq()?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
