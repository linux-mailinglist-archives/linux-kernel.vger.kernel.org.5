Return-Path: <linux-kernel+bounces-4947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FBB818439
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DA921F24E87
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2997A12E44;
	Tue, 19 Dec 2023 09:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvKwqTxu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E262B14267;
	Tue, 19 Dec 2023 09:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ca0715f0faso51522641fa.0;
        Tue, 19 Dec 2023 01:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702977281; x=1703582081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O6OiXOUZXhtGYW35OzGLCeQh5EJuMC/9rPiUUV6bTLU=;
        b=XvKwqTxuOwo2nL4QsdhctoGby4p4d4IKqmoc+LL+Hol0bZx/O0XBbFGIudV1maptEm
         f6wMzjUV67yMi7cDyk9E6pewvJVmb38AgKeimx0aHk8OrXcO8xLL28G4m6+jxqgfngO/
         qB9gKUif6ycE9DqEuvwHYfyOl9tt/PFue0P7qsVafbhe05G1Sjs+8MmzBOtiOgyswBV2
         ZLPIfIlGtci+YOO8PqQFy3zsh3XTshgF/b+Zwf0Y6UhqBI6FlBnrISkDiuwIHz4DtC4V
         uz72DTR+Eh24/aukeNhTJ4v4495psoVNLlsEDXrA6cc3OTXGLAE5z602EpV24a+EAA5K
         5Bug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702977281; x=1703582081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6OiXOUZXhtGYW35OzGLCeQh5EJuMC/9rPiUUV6bTLU=;
        b=FPvFDsIXI9nOGAYNrAin0hWDyr0WfEXTJiww7RBLauctegxlaNSkmwIa5ZGe3HOPpZ
         0+3Kvu4UmQDDIt90NqLAiLPyCqQ2RYJt9+DsjuKNVka9S+HDDocM02TYwmUBO4kMqwNn
         DU+byNFU2KKHr/XRns9Ki6k3cvBwtvqkVK0wkW+sXidEzLjIg8cCIMZAN7pnhhJqjzZg
         wecrtC7Za+LkyaFxpRR3p474TZ+9HQs/rqL2BLKgCzYZQPHDGlWRGd2Yi/8jCaG+EJ3T
         oyrJTV4iwWoehsf62G/2nTW3k+LixAqb7juQCrSbhLzwLF1Y23QtErj4rwuebKHVy5d5
         xUBw==
X-Gm-Message-State: AOJu0YwN93y+Tt6Ph3nsWImGjxPHGPvoDOUjlRb+8yonUoLXqLFKxdEb
	jCgtoFScqKkR3w5WKAUght4=
X-Google-Smtp-Source: AGHT+IFLYicXBKgraStbWTfJgP9ikiib+mUE28mqICzkCLHxENu1CfDsQci/VgLWHHE8o+ROJGWSUw==
X-Received: by 2002:a2e:860b:0:b0:2cc:6e37:f0df with SMTP id a11-20020a2e860b000000b002cc6e37f0dfmr1667287lji.34.1702977280441;
        Tue, 19 Dec 2023 01:14:40 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id y12-20020a05651c154c00b002cc701caf7asm746882ljp.21.2023.12.19.01.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 01:14:39 -0800 (PST)
Date: Tue, 19 Dec 2023 12:14:38 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: xiongxin <xiongxin@kylinos.cn>, Andy Shevchenko <andy@kernel.org>
Cc: hoan@os.amperecomputing.com, linus.walleij@linaro.org, brgl@bgdev.pl, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, stable@kernel.org, 
	Riwen Lu <luriwen@kylinos.cn>
Subject: Re: [PATCH v3] gpio: dwapb: mask/unmask IRQ when disable/enale it
Message-ID: <7zdg5ujizncarxvdyahnusojiq44rzxx2zybqj4kzsonzr27gq@fm5wj7npqsk3>
References: <20231219013751.20386-1-xiongxin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219013751.20386-1-xiongxin@kylinos.cn>

On Tue, Dec 19, 2023 at 09:37:51AM +0800, xiongxin wrote:
> In the hardware implementation of the i2c hid driver based on dwapb gpio
> irq, when the user continues to use the i2c hid device in the suspend
> process, the i2c hid interrupt will be masked after the resume process
> is finished.
> 
> This is because the disable_irq()/enable_irq() of the dwapb gpio driver
> does not synchronize the irq mask register state. In normal use of the
> i2c hid procedure, the gpio irq irq_mask()/irq_unmask() functions are
> called in pairs. In case of an exception, i2c_hid_core_suspend() calls
> disable_irq() to disable the gpio irq. With low probability, this causes
> irq_unmask() to not be called, which causes the gpio irq to be masked
> and not unmasked in enable_irq(), raising an exception.
> 
> Add synchronization to the masked register state in the
> dwapb_irq_enable()/dwapb_irq_disable() function. mask the gpio irq
> before disabling it. After enabling the gpio irq, unmask the irq.
> 

> v3:
> 	* Modify the submitter's information
> v2:
> 	* Resubmit the patch to fix this exception from the dwapb gpio
> 	  driver side.
> v1:
> 	* Resolve the exception from the IRQ core layer. (key point not
> 	  found correctly)

This should have been placed below the '---' marker:
Documentation/process/submitting-patches.rst

> 
> Fixes: 7779b3455697 ("gpio: add a driver for the Synopsys DesignWare APB GPIO block")
> Cc: stable@kernel.org
> Co-developed-by: Riwen Lu <luriwen@kylinos.cn>
> Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
> Signed-off-by: xiongxin <xiongxin@kylinos.cn>

Also note all the tags you've already got must be preserved on the
next patch revisions. One more time:

Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
>  drivers/gpio/gpio-dwapb.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
> index 4a4f61bf6c58..8c59332429c2 100644
> --- a/drivers/gpio/gpio-dwapb.c
> +++ b/drivers/gpio/gpio-dwapb.c
> @@ -282,13 +282,15 @@ static void dwapb_irq_enable(struct irq_data *d)
>  {
>  	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
>  	struct dwapb_gpio *gpio = to_dwapb_gpio(gc);
> +	irq_hw_number_t hwirq = irqd_to_hwirq(d);
>  	unsigned long flags;
>  	u32 val;
>  
>  	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
> -	val = dwapb_read(gpio, GPIO_INTEN);
> -	val |= BIT(irqd_to_hwirq(d));
> +	val = dwapb_read(gpio, GPIO_INTEN) | BIT(hwirq);
>  	dwapb_write(gpio, GPIO_INTEN, val);
> +	val = dwapb_read(gpio, GPIO_INTMASK) & ~BIT(hwirq);
> +	dwapb_write(gpio, GPIO_INTMASK, val);
>  	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
>  }
>  
> @@ -296,12 +298,14 @@ static void dwapb_irq_disable(struct irq_data *d)
>  {
>  	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
>  	struct dwapb_gpio *gpio = to_dwapb_gpio(gc);
> +	irq_hw_number_t hwirq = irqd_to_hwirq(d);
>  	unsigned long flags;
>  	u32 val;
>  
>  	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
> -	val = dwapb_read(gpio, GPIO_INTEN);
> -	val &= ~BIT(irqd_to_hwirq(d));
> +	val = dwapb_read(gpio, GPIO_INTMASK) | BIT(hwirq);
> +	dwapb_write(gpio, GPIO_INTMASK, val);
> +	val = dwapb_read(gpio, GPIO_INTEN) & ~BIT(hwirq);
>  	dwapb_write(gpio, GPIO_INTEN, val);
>  	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
>  }
> -- 
> 2.34.1
> 

