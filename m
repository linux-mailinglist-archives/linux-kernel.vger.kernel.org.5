Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F5B7A4A37
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241573AbjIRMyr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 18 Sep 2023 08:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241538AbjIRMyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:54:21 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DEBAA;
        Mon, 18 Sep 2023 05:54:15 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-59b5484fbe6so48072647b3.1;
        Mon, 18 Sep 2023 05:54:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695041654; x=1695646454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fFPC3PRlhZ/bS7lNjw3IfmrFe/tXeE+CeMKF6KweCV8=;
        b=ADoeGMnbj+TgSgWpFQ+iQlT5AV16iF/FUhoXOkOu2ifmHL2dfjzAZi/uWBeXwMVt3q
         z12C+b1KuFnATkKNjw0xXrEEWipuDWWJa/P9HNTzS3RurNGcmofWqV9TArSRKG7GLpsO
         pccoUtq7JVci8+I6Fm5AWnXQB1vtgrtO43clYkwd784wK5Hbig2rSqAJWPJ2I/huCVjp
         EjSJuGfp9qkbWDb3XX+LqRuy91ICoN0XY5OtPcQZolMapW4nn+df5dBHuLIZQfJ5XFIG
         EjaJHiSy3RAn/S1QfRE4sXIgnx4cJ/XLm2/hSJOnRb2kVr/G+Ha0rl0vK8QqRXpW3hrw
         btfA==
X-Gm-Message-State: AOJu0Yywxe19u02LR7zI8Uvy/+MThyWe2lNWfpTo+drbvwZdWCQTN1ow
        iXeCtnF3fVg7Z/H34eIXvXKqMgRJSXLVbg==
X-Google-Smtp-Source: AGHT+IF1Kg7+bEcU1IDXCJj3WI+Ww1xGVHCROiID4VfxNvzT/LFDit4w+i1QxcNI6GgHirFt52ziUQ==
X-Received: by 2002:a81:6cc1:0:b0:59b:eab8:7ac6 with SMTP id h184-20020a816cc1000000b0059beab87ac6mr9706450ywc.42.1695041654160;
        Mon, 18 Sep 2023 05:54:14 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id m17-20020a819c11000000b005707fb5110bsm2519305ywa.58.2023.09.18.05.54.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 05:54:14 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-59b5484fbe6so48072377b3.1;
        Mon, 18 Sep 2023 05:54:13 -0700 (PDT)
X-Received: by 2002:a81:a14a:0:b0:586:9c4e:a9a4 with SMTP id
 y71-20020a81a14a000000b005869c4ea9a4mr8927102ywg.5.1695041653615; Mon, 18 Sep
 2023 05:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230918123355.262115-1-biju.das.jz@bp.renesas.com> <20230918123355.262115-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230918123355.262115-2-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 18 Sep 2023 14:54:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV_eyPSJ26S5KZoHsLdr92h0xmkPjWbUpwpevS0oeMUXQ@mail.gmail.com>
Message-ID: <CAMuHMdV_eyPSJ26S5KZoHsLdr92h0xmkPjWbUpwpevS0oeMUXQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: renesas: rzg2l: Make reverse order of
 enable() for disable()
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>
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

On Mon, Sep 18, 2023 at 2:34 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> We usually do reverse order of enable() for disable(). Currently, the
> ordering of irq_chip_disable_parent() is not correct in
> rzg2l_gpio_irq_disable(). Fix the incorrect order.
>
> Fixes: db2e5f21a48e ("pinctrl: renesas: pinctrl-rzg2l: Add IRQ domain to handle GPIO interrupt")
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-pinctrl-for-v6.7.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
