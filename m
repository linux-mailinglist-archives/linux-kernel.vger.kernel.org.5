Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E7E7B00FF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjI0JwA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 27 Sep 2023 05:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjI0Jvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:51:55 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B309192;
        Wed, 27 Sep 2023 02:51:54 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-59bf1dde73fso137594607b3.3;
        Wed, 27 Sep 2023 02:51:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695808313; x=1696413113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=URclzgkzbuk7qvKcvbCEsThVgg1SGyUhQn8jsEUe6I8=;
        b=vIwRBc8KvYuEaOpeSGs0o+GTItWh3z2aA8GAf+ttcK6I1lJZQwlxzn2aUIDsPlomoW
         +zGYzYKIDU7KwmpC3O7Iq1Vi8tQQUU6zHM2UQvcQC2jpsN7OCcyHntM97FPhUjNjg41v
         Vs6JNYTXNScqyv9bP70pv0fABkAZQf09KGjWROeumFCdALd4nu2CLluuHZ4NaZgoJxfh
         WQCiBEu2zZW1rpmrZiYmOrAHDMCianvn4+k79OKWOuN7JDOg8xKe8T910wG8+8iwIMzF
         c8LTxRRS9QQeUZlce4kqmq4/HC4lIfDzcBXi7DZXRRiTRTDNV7/wS0hEZDJXj5tbgf+o
         skaQ==
X-Gm-Message-State: AOJu0Yxc6lfHo32zb9hNrbPUGpbqROEDEN+YB99jz2qBERwBv9W3UQ/Q
        54JrU+hlkBRqRG0nV6tkdvnyxneq8WFFxw==
X-Google-Smtp-Source: AGHT+IF9/r9TS5kRAsvJuDXgjlhfF24839TybiQhQtCHEfzfKOgb0YNGyIs52AP9MStUJrIEuvE2gQ==
X-Received: by 2002:a0d:c5c5:0:b0:59c:aea:d877 with SMTP id h188-20020a0dc5c5000000b0059c0aead877mr1456390ywd.40.1695808313246;
        Wed, 27 Sep 2023 02:51:53 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id p72-20020a0de64b000000b0059beb468cb3sm3627784ywe.32.2023.09.27.02.51.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 02:51:52 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-59c215f2f4aso137550557b3.1;
        Wed, 27 Sep 2023 02:51:52 -0700 (PDT)
X-Received: by 2002:a0d:d808:0:b0:59b:ec40:a121 with SMTP id
 a8-20020a0dd808000000b0059bec40a121mr1841815ywe.3.1695808312511; Wed, 27 Sep
 2023 02:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230926210818.197356-1-fabrizio.castro.jz@renesas.com> <20230926210818.197356-3-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20230926210818.197356-3-fabrizio.castro.jz@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 27 Sep 2023 11:51:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWUr5ReouCWV3WsOJE=2faBO-y70aDC8W8qBGVBhaMTAg@mail.gmail.com>
Message-ID: <CAMuHMdWUr5ReouCWV3WsOJE=2faBO-y70aDC8W8qBGVBhaMTAg@mail.gmail.com>
Subject: Re: [PATCH 2/2] spi: rzv2m-csi: Add Slave mode support
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Fabrizio,

On Tue, Sep 26, 2023 at 11:08 PM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> The CSI IP found inside the Renesas RZ/V2M SoC supports
> both SPI Master and SPI Slave roles.
>
> When working in slave mode, the CSI IP has the option
> of using its Slave Select (SS) pin to enable TX and RX
> operations. Since the SPI slave cannot control the clock,
> when working as slave it's best not to stop operations
> during a transfer, as by doing so the IP will not send or
> receive data, regardless of clock and active level on pin SS.
> A side effect from not stopping operations is that the RX
> FIFO needs to be flushed, word by word, when RX data needs
> to be discarded.
>
> Finally, when in slave mode timings are tighter, as missing a
> deadline translates to errors being thrown, resulting in
> aborting the transfer. In order to speed things up, we can
> avoid waiting for the TX FIFO to be empty, we can just wait
> for the RX FIFO to contain at least the number of words that
> we expect.
>
> Add slave support to the currently existing CSI driver.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

Thanks for your patch!

> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -861,8 +861,10 @@ config SPI_RSPI
>  config SPI_RZV2M_CSI
>         tristate "Renesas RZ/V2M CSI controller"
>         depends on ARCH_RENESAS || COMPILE_TEST
> +       depends on SPI_SLAVE

Isn't that a bit too strict?
The driver can/should be used/usable in host mode when SPI_SLAVE
is not enabled.

>         help
> -         SPI driver for Renesas RZ/V2M Clocked Serial Interface (CSI)
> +         SPI driver for Renesas RZ/V2M Clocked Serial Interface (CSI).
> +         CSI supports master and slave roles.
>
>  config SPI_QCOM_QSPI
>         tristate "QTI QSPI controller"

> --- a/drivers/spi/spi-rzv2m-csi.c
> +++ b/drivers/spi/spi-rzv2m-csi.c

> @@ -99,6 +112,9 @@ struct rzv2m_csi_priv {
>         wait_queue_head_t wait;
>         u32 errors;
>         u32 status;
> +       int mode;

Do you need this flag?
You can use spi_controller_is_target() instead.

> +       int slave_select;
> +       bool slave_aborted;
>  };
>
>  static void rzv2m_csi_reg_write_bit(const struct rzv2m_csi_priv *csi,

> @@ -279,32 +303,23 @@ static int rzv2m_csi_wait_for_interrupt(struct rzv2m_csi_priv *csi,
>
>         rzv2m_csi_enable_irqs(csi, enable_bits);
>
> -       ret = wait_event_timeout(csi->wait,
> -                                ((csi->status & wait_mask) == wait_mask) ||
> -                                csi->errors, HZ);
> +       if (csi->mode == RZV2M_CSI_SPI_SLAVE) {

spi_controller_is_target()

> +               ret = wait_event_interruptible(csi->wait,
> +                               ((csi->status & wait_mask) == wait_mask) ||
> +                               csi->errors || csi->slave_aborted);

target_aborted (everywhere)

> +               if (ret || csi->slave_aborted)
> +                       ret = -EINTR;
> +       } else {
> +               ret = wait_event_timeout(csi->wait,
> +                               ((csi->status & wait_mask) == wait_mask) ||
> +                               csi->errors, HZ) == 0 ? -ETIMEDOUT : 0;
> +       }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
