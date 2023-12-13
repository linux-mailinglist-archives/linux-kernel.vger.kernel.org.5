Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF38812152
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 23:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442780AbjLMWT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 17:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjLMWTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 17:19:55 -0500
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434F39C;
        Wed, 13 Dec 2023 14:20:02 -0800 (PST)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-591553d3835so702236eaf.3;
        Wed, 13 Dec 2023 14:20:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702506001; x=1703110801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWWDY9W1m0Ti8Ki53nf0U1ywjlmu1b5RWqKGlHg5nZs=;
        b=sXmLPi4er833zan94EXvafgD6/LJsyPQRVkt0ZugiWx3kSSKQfBlhVZ1Yawmx9+oEg
         pUEOcsbU0gp6r4G5zjgB7UfQa0ayOOw47e6q4/yrsyWwoEEjD4Up3VayNVIHg0JdH6p4
         Jnkz/vKBY2XMVeIWEQoAEoiVuVrdwBgtQ4ePMVbB925Bqcwv4EWhurFibI4XfuNLEDev
         3uE0buAmg7K1RF30sfYBVzZOssXQNWJyYA9Mk7I8c8ohGpRlfJjRZgIf5PrOevH4z/bH
         /HwD+yp8MBitp10BlX42MpRnB1+QS7Wl/TcjhnhvtWnqsvyFyRk5OCis08AQz59LEOIq
         uq0A==
X-Gm-Message-State: AOJu0YwCAx4x8j3pf1Id12qa9CgRt494O+JHHCGXanj5SJSqqO4h2mdA
        AUBxdSaL/BX4j2mQecl17w==
X-Google-Smtp-Source: AGHT+IGNCeS8qGqgRy7CByZh4jSuOunk+kuhCMt9l01iEQDu99NfcZqlP8grqh7EMyBg98MVYFfQxg==
X-Received: by 2002:a05:6820:168b:b0:58e:29db:b963 with SMTP id bc11-20020a056820168b00b0058e29dbb963mr6417993oob.4.1702506001502;
        Wed, 13 Dec 2023 14:20:01 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bx23-20020a056830601700b006da30d1646fsm722414otb.59.2023.12.13.14.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 14:20:00 -0800 (PST)
Received: (nullmailer pid 2165620 invoked by uid 1000);
        Wed, 13 Dec 2023 22:19:59 -0000
Date:   Wed, 13 Dec 2023 16:19:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mark Hasemeyer <markhas@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Raul Rangel <rrangel@chromium.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 3/6] of: irq: add wake capable bit to of_irq_resource()
Message-ID: <20231213221959.GC2115075-robh@kernel.org>
References: <20231213110009.v1.1.Ifd0903f1c351e84376d71dbdadbd43931197f5ea@changeid>
 <20231213110009.v1.3.I29b26a7f3b80fac0a618707446a10b6cc974fdaf@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213110009.v1.3.I29b26a7f3b80fac0a618707446a10b6cc974fdaf@changeid>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 11:00:21AM -0700, Mark Hasemeyer wrote:
> Add wake capability information to the irq resource. Wake capability is
> assumed based on conventions provided in the devicetree wakeup-source
> binding documentation. An interrupt is considered wake capable if the
> following are true:
> 1. a wakeup-source property exits in the same device node as the
>    interrupt.
> 2. No dedicated irq is defined, or the irq is marked as dedicated by
>    setting its interrupt-name to "wakeup".
> 
> The wakeup-source documentation states that dedicated interrupts can use
> device specific interrupt names and device drivers are still welcome to
> use their own naming schemes. This api is provided as a helper if one is
> willing to conform to the above conventions.
> 
> The ACPI subsystems already provides similar apis that allow one to
> query the wake capability of an irq. This brings feature parity to the
> devicetree.
> 
> Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
> ---
> 
>  drivers/of/irq.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index 174900072c18c..633711bc32953 100644
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -383,11 +383,39 @@ int of_irq_parse_one(struct device_node *device, int index, struct of_phandle_ar
>  }
>  EXPORT_SYMBOL_GPL(of_irq_parse_one);
>  
> +/**
> + * __of_irq_wake_capable - Determine whether a given irq index is wake capable
> + *
> + * The irq is considered wake capable if the following are true:
> + * 1. wakeup-source property exists
> + * 2. no dedicated wakeirq exists OR provided irq index is a dedicated wakeirq
> + *
> + * This logic assumes the provided irq index is valid.
> + *
> + * @dev: pointer to device tree node
> + * @index: zero-based index of the irq
> + * Return: True if provided irq index for #dev is wake capable. False otherwise.
> + */
> +static bool __of_irq_wake_capable(const struct device_node *dev, int index)
> +{
> +	int wakeindex;
> +
> +	if (!of_property_read_bool(dev, "wakeup-source"))
> +		return false;
> +
> +	wakeindex = of_property_match_string(dev, "interrupt-names", "wakeup");
> +	return wakeindex < 0 || wakeindex == index;

If a device has multiple interrupts, but none named "wakeup" you are 
saying all the interrupts are wakeup capable. That's not right though. 
Only the device knows which interrupts are wakeup capable. You need:

return wakeindex >= 0 && wakeindex == index;

Rob
