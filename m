Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D24C7FD10B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 09:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbjK2IKy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Nov 2023 03:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjK2IKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 03:10:50 -0500
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381FF19BA;
        Wed, 29 Nov 2023 00:10:55 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5d28f5bbd6cso1597817b3.1;
        Wed, 29 Nov 2023 00:10:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701245454; x=1701850254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i5ZLV3/lGWkTPqqCKMiKC0kF/REvnd+ju384kw/YGc8=;
        b=fLq8nWa8ilZOs7/AkxKRSE/qxC0qD0nb6hfh4qKIfjKYkPLlsuOOyB2tWFIrOuSEXe
         YcaITg3xM0VgdBu4HRobXIosDb0z2bZTBvKrpkcJvQwhcHj5Atb7s1JnT5cVD1WvGCIq
         XJjXWRCKOwTPx0i5zdla53C+F+L+BSAUR6cA9jia4H5Gj+VsusVYdWbvCr5S2xprdPMv
         XlaTHrlxjZdwXW735o6cQxFl4cXxH758CcCWfPiwgo8yKuhWIWyINRuZ9uXGzTRIHt7r
         TG2ftUZgs6NYQURHKQjdYY52WKlXBQQzLHFA3cueeWvBQwPYpB9vnW9GKOUPIAYcE+nm
         iEYg==
X-Gm-Message-State: AOJu0Ywv1VzXjn39cmvOg+MkfNCEqeQETkjkOgviVUweThornzgQhk+d
        gJDHmE9fNWA/kKY5kYWGjNlPiP19fQcNgw==
X-Google-Smtp-Source: AGHT+IGMYbVrTIlxa75g2TVGETubvmsLNN44F+a96invX5n8gNv1JzROcfp/1gpg/yyPV6bMUbWOCA==
X-Received: by 2002:a81:5f03:0:b0:5b3:3eb5:6624 with SMTP id t3-20020a815f03000000b005b33eb56624mr16210277ywb.46.1701245454188;
        Wed, 29 Nov 2023 00:10:54 -0800 (PST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id g184-20020a0dc4c1000000b0059b17647dcbsm4374185ywd.69.2023.11.29.00.10.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 00:10:53 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5cc86fcea4fso54302467b3.3;
        Wed, 29 Nov 2023 00:10:53 -0800 (PST)
X-Received: by 2002:a05:690c:4805:b0:5cf:806f:49fd with SMTP id
 hc5-20020a05690c480500b005cf806f49fdmr11825321ywb.44.1701245453396; Wed, 29
 Nov 2023 00:10:53 -0800 (PST)
MIME-Version: 1.0
References: <20231129063730.31184-1-liuhaoran14@163.com>
In-Reply-To: <20231129063730.31184-1-liuhaoran14@163.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 29 Nov 2023 09:10:41 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVw1oT7L7G5wQUtYK0qAdQ1VayL-DNi=jtGdQ1KER9Ygg@mail.gmail.com>
Message-ID: <CAMuHMdVw1oT7L7G5wQUtYK0qAdQ1VayL-DNi=jtGdQ1KER9Ygg@mail.gmail.com>
Subject: Re: [PATCH] [sh/highlander] psw: Add error handling in psw_irq_handler
To:     Haoran Liu <liuhaoran14@163.com>
Cc:     ysato@users.sourceforge.jp, dalias@libc.org,
        glaubitz@physik.fu-berlin.de, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Haoran,

On Wed, Nov 29, 2023 at 7:38 AM Haoran Liu <liuhaoran14@163.com> wrote:
> This patch adds error handling for the platform_get_drvdata call
> within the psw_irq_handler function in
> arch/sh/boards/mach-highlander/psw.c. Previously, the absence of
> error checking could lead to unexpected behavior if
> platform_get_drvdata returned a null pointer.
>
> Signed-off-by: Haoran Liu <liuhaoran14@163.com>

Thanks for your patch!

> --- a/arch/sh/boards/mach-highlander/psw.c
> +++ b/arch/sh/boards/mach-highlander/psw.c
> @@ -21,6 +21,12 @@ static irqreturn_t psw_irq_handler(int irq, void *arg)
>         unsigned int l, mask;
>         int ret = 0;
>
> +       if (!psw) {
> +               pr_err("psw_irq_handler: No push_switch data associated
> +                       with platform_device\n");
> +               return IRQ_NONE;
> +       }
> +
>         l = __raw_readw(PA_DBSW);
>
>         /* Nothing to do if there's no state change */

This means the button is pressed, and the interrupt fired, in
between the calls to request_irq() and platform_set_drvdata() in
arch/sh/drivers/push-switch.c:switch_drv_probe()?

The same issue can happen with arch/sh/boards/mach-landisk/psw.c.
I think the proper solution is to fix this inside the push switch
driver, by moving the call to request_irq() after the call to
platform_set_drvdata() (and doing the reverse in switch_drv_remove()).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
