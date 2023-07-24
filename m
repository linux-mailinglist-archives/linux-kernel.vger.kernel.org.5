Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9806475F7BB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbjGXNDe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 24 Jul 2023 09:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbjGXNDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:03:11 -0400
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A097E4203;
        Mon, 24 Jul 2023 06:02:06 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-d0b597e7ac1so1932382276.1;
        Mon, 24 Jul 2023 06:02:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690203725; x=1690808525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c8ZRRgNrzhuaT2MvQ4fQw/uUCe9amj8CicD9xhbrskQ=;
        b=eCFbcDYGx79ynNxtT0fUBEUh1m/xOfoMeX30iUtha1L5JBjT9dvDs0yt3eQiEPjhrz
         F2NX6D3fRy5GGB6vVAnThT8LhVFsvJEzEnwZoGnnjKzaVSjbEHwi8ZqNF+q9TY5zscKE
         4CWpUttL2ltRAkUNzdHU3CFDUDtsdxuIDF7j1llpODaLr6lAxSZLxsUHhh0HFu02ADyI
         r/7h8SkAfuuk3ptB88VtDF1bPV/B1fnUEkotoBQdqzul5tXoZgtzncKdflqCc7ZX7RnK
         stKTBkKNJxXDR8my+rqCwv8IOEyNf23KA2wMp9o2/0tU1ZksrMTaVFNi/6eDGErbHXoY
         Qeiw==
X-Gm-Message-State: ABy/qLZPBfTn+2IzQ46SE3y9u0WQuzT3iLm1izK7YukqXzSGZakzRzUP
        vIxo1p+TI4p51n3tEAnhppNjD91kZP1AHQ==
X-Google-Smtp-Source: APBJJlETwHmbD47elSe2cZ/ZZIZlIQwWXp4dSsn1EQit5qTOzA1n9EKbFp8SHdRS9Z3nwNowbGtFjA==
X-Received: by 2002:a25:780e:0:b0:cec:e155:2879 with SMTP id t14-20020a25780e000000b00cece1552879mr7186473ybc.59.1690203725535;
        Mon, 24 Jul 2023 06:02:05 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id x13-20020a5b028d000000b00c389676f3a2sm2225412ybl.40.2023.07.24.06.02.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 06:02:02 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-58411e24eefso4363567b3.1;
        Mon, 24 Jul 2023 06:02:01 -0700 (PDT)
X-Received: by 2002:a25:15c9:0:b0:c5d:953b:db6 with SMTP id
 192-20020a2515c9000000b00c5d953b0db6mr6548392ybv.41.1690203721676; Mon, 24
 Jul 2023 06:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230724120742.2187-1-petrtesarik@huaweicloud.com>
In-Reply-To: <20230724120742.2187-1-petrtesarik@huaweicloud.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Jul 2023 15:01:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXwU2gku+fXKnnUaCPZAE4JUaPw5cPaqpQ=+Augynn6ng@mail.gmail.com>
Message-ID: <CAMuHMdXwU2gku+fXKnnUaCPZAE4JUaPw5cPaqpQ=+Augynn6ng@mail.gmail.com>
Subject: Re: [PATCH v1] sh: boards: fix CEU buffer size passed to dma_declare_coherent_memory()
To:     Petr Tesarik <petrtesarik@huaweicloud.com>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "open list:SUPERH" <linux-sh@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>, petr@tesarici.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 2:15 PM Petr Tesarik
<petrtesarik@huaweicloud.com> wrote:
> From: Petr Tesarik <petr.tesarik.ext@huawei.com>
>
> In all these cases, the last argument to dma_declare_coherent_memory() is
> the buffer end address, but the expected value should be the size of the
> reserved region.
>
> Fixes: 39fb993038e1 ("media: arch: sh: ap325rxa: Use new renesas-ceu camera driver")
> Fixes: c2f9b05fd5c1 ("media: arch: sh: ecovec: Use new renesas-ceu camera driver")
> Fixes: f3590dc32974 ("media: arch: sh: kfr2r09: Use new renesas-ceu camera driver")
> Fixes: 186c446f4b84 ("media: arch: sh: migor: Use new renesas-ceu camera driver")
> Fixes: 1a3c230b4151 ("media: arch: sh: ms7724se: Use new renesas-ceu camera driver")
> Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
