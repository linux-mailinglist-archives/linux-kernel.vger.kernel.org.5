Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E130755F2A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjGQJYm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Jul 2023 05:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjGQJYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:24:38 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DC9C7;
        Mon, 17 Jul 2023 02:24:36 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-57688a146ecso43525967b3.2;
        Mon, 17 Jul 2023 02:24:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689585876; x=1692177876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eKRqH2OkDw6Jod0qdSXGarONO0gHOT2T7xxDEeb7y9Q=;
        b=TjFLFo/14lFiNfWGkk4YYkgv3l7jVvCufLAf8PFJo4EaMbJve58cKJ5YaxkVBGPkIn
         sP13VRz9JDO7CqiBNB7TGQW+gr/5e80lsx3L//wB83WR+owElZXQffPXUgE7txCs/Lk4
         FXTgiILhFxD8qLoau7aQqNwuq4YnTqzt0uqluMtNsmN/H8uaLZKh/I5F/YF38TdDU3mX
         jkn9l9rjKat48Wj3f+Xc4GuGEy7BVIDOnXpQt+0Q/aCrQlIDoExA+CU2lYVSGjiCSm/3
         bagq4q7bcHrcR4XHmPvNgJWegk9v69S4RMmTKPozAy/VtF41YS2u+3ewjGN6MYTuLHcw
         A/vQ==
X-Gm-Message-State: ABy/qLbcsWzxwCt9hp0nVxe04r/g28eizbkr9aHOCDVrZYumMmS/vWVv
        RTR/Q+Bm0vFZT1sOCk5I58hBif/kMaG8gQ==
X-Google-Smtp-Source: APBJJlGKhRREb8yhNmt26xj3HZS6x+FXMrYijob60gEGnGdOq3H7yO+1vsJ/XnEATtYQtN5DF8qozA==
X-Received: by 2002:a0d:d6cd:0:b0:583:4304:75a4 with SMTP id y196-20020a0dd6cd000000b00583430475a4mr1269564ywd.29.1689585875801;
        Mon, 17 Jul 2023 02:24:35 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id q6-20020a0dce06000000b0055a881abfc3sm3755897ywd.135.2023.07.17.02.24.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 02:24:35 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-57688a146ecso43525837b3.2;
        Mon, 17 Jul 2023 02:24:35 -0700 (PDT)
X-Received: by 2002:a25:8507:0:b0:c65:9103:4a54 with SMTP id
 w7-20020a258507000000b00c6591034a54mr10165096ybk.65.1689585875165; Mon, 17
 Jul 2023 02:24:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230715010407.1751715-1-fabrizio.castro.jz@renesas.com> <20230715010407.1751715-3-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20230715010407.1751715-3-fabrizio.castro.jz@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 Jul 2023 11:24:24 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX+ecqgmAYAYT5TaYfTjp2mTogp5_BEHQPNNLNMzYPd6w@mail.gmail.com>
Message-ID: <CAMuHMdX+ecqgmAYAYT5TaYfTjp2mTogp5_BEHQPNNLNMzYPd6w@mail.gmail.com>
Subject: Re: [PATCH 02/10] spi: rzv2m-csi: Adopt HZ_PER_MHZ for max spi clock
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
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

On Sat, Jul 15, 2023 at 3:04 AM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> Make use of HZ_PER_MHZ for CSI_MAX_SPI_SCKO to make it clear
> what its value means.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
