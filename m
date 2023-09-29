Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89BE7B322F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 14:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbjI2MPE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 29 Sep 2023 08:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbjI2MO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 08:14:57 -0400
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2550519F;
        Fri, 29 Sep 2023 05:14:55 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-57b68556d6dso6524895eaf.1;
        Fri, 29 Sep 2023 05:14:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695989694; x=1696594494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RuoH4Um95jPah+EhYg0BBr891Wv4izigjaMEWeAZDlE=;
        b=wQRcmkjHrUfYn4EIqibb9B+ADh0HqBABsRdMGCsX+2tAhiq0cwrmOUEQULMYIa2yU/
         vKkdSwnI+vPXeBewXlq1Y3J+bcHLf9ivPmzh5a5/Vmg0qJEgYjiS98ZTjroy12emptrE
         4Da+7mXOepkvBwO4DueT7ifBlw7qA19fnCb9p4ARcQR/Pyg9NvzNzVUZCScvlUWzK/mI
         zty88Gxnv98HIQC6UQ4Sn8O9SmYelpyVIVV9c4XfPAEgh4X5dMbs/XWvSEaWFVg3hD1c
         2GywS7582+aB4rul6F7pph3F0ib9TKgALRIISHe9jLMmcR3rw8TrIwhhaoeyOwSnQW2S
         sOXg==
X-Gm-Message-State: AOJu0YxSIXwgD10YXZ6UIZFDbIK4uIgGcwcWPpAZj/yEqr9jHp7wqhgk
        hYRgkPUs/+x+rc7SXJblabguwik4jGWLPFAr
X-Google-Smtp-Source: AGHT+IFRj61fbWgq7CLJNKA93/V+zVCyq3LNqFBOZOAYeOf0HZJG+N7nBmPWn78HcLfzQFArbEO9Rg==
X-Received: by 2002:a05:6358:7252:b0:135:a10e:1ed0 with SMTP id i18-20020a056358725200b00135a10e1ed0mr4127927rwa.23.1695989693864;
        Fri, 29 Sep 2023 05:14:53 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id o79-20020a254152000000b00d749a394c87sm4997381yba.16.2023.09.29.05.14.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 05:14:53 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-d8afe543712so1356386276.0;
        Fri, 29 Sep 2023 05:14:53 -0700 (PDT)
X-Received: by 2002:a25:d4c5:0:b0:d4e:4103:7807 with SMTP id
 m188-20020a25d4c5000000b00d4e41037807mr4110545ybf.60.1695989693529; Fri, 29
 Sep 2023 05:14:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230925154548.27048-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230925154548.27048-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 29 Sep 2023 14:14:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU690+e1SNVFsjMJHHdqQymwKMjGwuCe02Q2wYzMSNGEA@mail.gmail.com>
Message-ID: <CAMuHMdU690+e1SNVFsjMJHHdqQymwKMjGwuCe02Q2wYzMSNGEA@mail.gmail.com>
Subject: Re: [PATCH v3] pinctrl: renesas: pinctrl-rzg2l: Add validation of
 GPIO pin in rzg2l_gpio_request()
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 5:46 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Validate the GPIO pin request in rzg2l_gpio_request() callback using
> rzg2l_validate_gpio_pin() function. This stops any accidental usage
> of GPIO pins which are not supported by the SoCs.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
> v2->v3
> * Updated pin_data variable to be u32 instead of u64.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-pinctrl-for-v6.7.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
