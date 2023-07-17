Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5914B755F82
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjGQJkQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Jul 2023 05:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjGQJjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:39:55 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47782171F;
        Mon, 17 Jul 2023 02:37:48 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5703cb4bcb4so38432197b3.3;
        Mon, 17 Jul 2023 02:37:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689586664; x=1692178664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RtQgiflbn9OLbHKvv9YuHhcm+jP+EsS00zgjRm84CX0=;
        b=PE6vjWM18QjNU+9S1PdKm3iSm+e8AI8QLDZH5PSRW/jDAYZLIxj9F+bq8Q1PePaM+x
         sr5zMkHZXF3PLMLY1SqzfbG1GyleiTHztbv/aReTxiTiE6mIGYtc+FiKihzRNpjVpPW1
         k0apYHZJ5uhfxhpFMlBBII+oghLZdWu1Odk/gou9XwAzGObKRsPe020CqWAc+hrPlpww
         OHYDS/ATe+x+pkNkS2RYDUnJDF1apOfQzhgRrPI8LSxRo1VE4wKY7CL9wNOzFa50mBHl
         6ZKZ/cvbyXVQlHLmGZbSZ0mK+Mt3ySyXMxzNQYtqv9Uig8RWl5ystd1GkBimFcm+MQWE
         HGNA==
X-Gm-Message-State: ABy/qLYpkkASIyfvOSj9lDwBmNt3LSP+0A0bSRy0GsmBsAEaxVXAN2Yu
        iYUNXnOMB/SCLpr0qH+BnxSjmRyYtWYn2w==
X-Google-Smtp-Source: APBJJlGIulwPacv9ryVLdaVzWb9iBfGfrNqY0gldL/9oUQUDPHjaa0blF0RFr4VKxqLUupUOBIKFGw==
X-Received: by 2002:a81:4757:0:b0:54f:9cd0:990 with SMTP id u84-20020a814757000000b0054f9cd00990mr10341589ywa.18.1689586664291;
        Mon, 17 Jul 2023 02:37:44 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id w18-20020a814912000000b0057a92cd7f95sm3692975ywa.100.2023.07.17.02.37.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 02:37:43 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-c5cf26e9669so2912523276.0;
        Mon, 17 Jul 2023 02:37:43 -0700 (PDT)
X-Received: by 2002:a25:adc6:0:b0:c6b:73fe:37d8 with SMTP id
 d6-20020a25adc6000000b00c6b73fe37d8mr9880481ybe.12.1689586663781; Mon, 17 Jul
 2023 02:37:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230715010407.1751715-1-fabrizio.castro.jz@renesas.com> <20230715010407.1751715-8-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20230715010407.1751715-8-fabrizio.castro.jz@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 Jul 2023 11:37:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUzxQfi2w8dyF8gCitkSKkw_fRE074EUuB+tHKn8WM3=w@mail.gmail.com>
Message-ID: <CAMuHMdUzxQfi2w8dyF8gCitkSKkw_fRE074EUuB+tHKn8WM3=w@mail.gmail.com>
Subject: Re: [PATCH 07/10] spi: rzv2m-csi: Switch to using {read,write}s{b,w}
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Mark Brown <broonie@kernel.org>,
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

Hi Fabrizio,

On Sat, Jul 15, 2023 at 3:04 AM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> The RX/TX FIFOs implemented by the CSI IP are accessed by
> repeatedly reading/writing the same memory address, and
> therefore they are the ideal candidate for {read,write}s{b,w}.
> The RZ/V2M CSI driver currently implements loops to fill up
> the TX FIFO and empty the RX FIFO, differentiating between
> 8-bit and 16-bit word size.
> Switch to using {read,write}s{b,w} to get rid of the bespoke
> loops.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

Thanks for your patch!

> --- a/drivers/spi/spi-rzv2m-csi.c
> +++ b/drivers/spi/spi-rzv2m-csi.c

> @@ -157,22 +157,15 @@ static int rzv2m_csi_start_stop_operation(const struct rzv2m_csi_priv *csi,
>
>  static int rzv2m_csi_fill_txfifo(struct rzv2m_csi_priv *csi)
>  {
> -       int i;
> -
>         if (readl(csi->base + CSI_OFIFOL))
>                 return -EIO;
>
> -       if (csi->bytes_per_word == 2) {
> -               u16 *buf = (u16 *)csi->txbuf;
> -
> -               for (i = 0; i < csi->words_to_transfer; i++)
> -                       writel(buf[i], csi->base + CSI_OFIFO);
> -       } else {
> -               u8 *buf = (u8 *)csi->txbuf;
> -
> -               for (i = 0; i < csi->words_to_transfer; i++)
> -                       writel(buf[i], csi->base + CSI_OFIFO);
> -       }
> +       if (csi->bytes_per_word == 2)
> +               writesw(csi->base + CSI_OFIFO, csi->txbuf,
> +                       csi->words_to_transfer);
> +       else
> +               writesb(csi->base + CSI_OFIFO, csi->txbuf,
> +                       csi->words_to_transfer);

According to the hardware documentation[1], the access size for both the
CSI_OFIFO and CSI_IFIFO registers is 32 bits, so you must use writel()
resp. readl().  So please check with the hardware people first.

[1] RZ/V2M User's Manual Hardware, Rev. 1.30.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
