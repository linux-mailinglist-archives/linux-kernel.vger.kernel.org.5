Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9E975F26D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 12:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbjGXKNy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 24 Jul 2023 06:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbjGXKMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:12:39 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B927C7D95;
        Mon, 24 Jul 2023 03:05:21 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-583b47809beso18621987b3.0;
        Mon, 24 Jul 2023 03:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690193072; x=1690797872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kdime7qoPODmAiTa2PQFmD+bM1Qwuzb0rIVovoauwF0=;
        b=fOSxzlFxA8X1afGtT6G8mBinIkhtcXZ+ydmi/uDK1njapdH4XqDiQQUtdFb36fAxbn
         NUTVh6XaQTZ4x6sbP57YY4cj5m//mf4S4otpzAdP+Womumod5kKGZ/xL4XiA/kMIgGXb
         F8sKfHmdRshJp3m3kZo4hnS8naix4hjFYQRjlzgMWUpkAZN/CJ/HV1WYnJOofT0UX45/
         Jk7xqQOU/bYhGSc2VXbU1GpTd6QDuTTnargJsbsEh1fkE2LA8LOLsPGNAqmDZW1Zf5/f
         C6TBm2W2/Y4kpQm4iw3XUvZihLM9QadR1BpBewCqpZQxEhdTfuWZbRHXXh3Th5hkIvQ+
         t8Tg==
X-Gm-Message-State: ABy/qLa75hRE4JKil0dpOKlCLCGg86Rk4fR396ZYf/d1o6Jg1FmizJac
        vkhgcry9nqGsJ6jEo9ZX95lrrHP8JpEnEg==
X-Google-Smtp-Source: APBJJlEDnODc8wVRL3hvLfPLovhS+i/V1oKCqYM0moHLmJy2hhjU/yei1qvrmVVFUyupOpOUckr+Aw==
X-Received: by 2002:a81:4e82:0:b0:56d:502:43d4 with SMTP id c124-20020a814e82000000b0056d050243d4mr5491485ywb.11.1690193072404;
        Mon, 24 Jul 2023 03:04:32 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id v14-20020a81a54e000000b005773430a57csm2654030ywg.78.2023.07.24.03.04.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 03:04:32 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5703cb4bcb4so46818587b3.3;
        Mon, 24 Jul 2023 03:04:32 -0700 (PDT)
X-Received: by 2002:a5b:a8b:0:b0:cfd:1bb9:e356 with SMTP id
 h11-20020a5b0a8b000000b00cfd1bb9e356mr6248370ybq.32.1690193071935; Mon, 24
 Jul 2023 03:04:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230612033904.34921-1-zhanglibing@cdjrlc.com>
 <0dc9409b662180ed29cbc281f0f076b7@208suo.com> <fcd37e67fba625da304fdaf07e0ab0db@208suo.com>
In-Reply-To: <fcd37e67fba625da304fdaf07e0ab0db@208suo.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Jul 2023 12:04:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX0xP5Gugo7uF5Wqk9_ny6-4fOWYRm41KicOo26kC6m+g@mail.gmail.com>
Message-ID: <CAMuHMdX0xP5Gugo7uF5Wqk9_ny6-4fOWYRm41KicOo26kC6m+g@mail.gmail.com>
Subject: Re: [PATCH] clk: baikal-t1: Using div64_ Ul replaces do_ Div() function
To:     wuyonggang001@208suo.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>
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

Hi Yonggang,

CC Serge

On Wed, Jun 14, 2023 at 8:07 AM <wuyonggang001@208suo.com> wrote:
> Fix the following coccicheck warning:
>
> drivers/clk/baikal-t1/ccu-pll.c:81:1-7: WARNING: do_div() does a
> 64-by-32 division, please consider using div64_ul instead.
>
> Signed-off-by: Yonggang Wu <wuyonggang001@208suo.com>

Thanks for your patch, which is now commit b93d1331ea266dea
("clk: baikal-t1: Using div64_ Ul replaces do_ Div() function")
in clk/clk-next.

> b/drivers/clk/baikal-t1/ccu-pll.c
> index 13ef28001439..d41735c6956a 100644
> --- a/drivers/clk/baikal-t1/ccu-pll.c
> +++ b/drivers/clk/baikal-t1/ccu-pll.c
> @@ -66,7 +66,7 @@ static inline unsigned long
> ccu_pll_lock_delay_us(unsigned long ref_clk,
>   {
>       u64 us = 500ULL * nr * USEC_PER_SEC;
>
> -    do_div(us, ref_clk);
> +    div64_ul(us, ref_clk);

The above is not equivalent:
  - do_div() returned the quotient as an output parameter in us,
  - div64_ul() returns the quotient using the return value.

Have you tested your patch?

>
>       return us;

So this should become:

    return div64_ul(500ULL * nr * USEC_PER_SEC, ref_clk);

>   }
> @@ -78,9 +78,9 @@ static inline unsigned long ccu_pll_calc_freq(unsigned
> long ref_clk,
>   {
>       u64 tmp = ref_clk;
>
> -    do_div(tmp, nr);
> +    div64_ul(tmp, nr);
>       tmp *= nf;
> -    do_div(tmp, od);
> +    div64_ul(tmp, od);
>
>       return tmp;

Likewise.
But as ref_clk is unsigned long, there is no need to use div64_ul()
for the first division, and this can be simplified to:

    u64 tmp = (u64)(ref_clk / nr) * nf;
    return div64_ul(tmp, od);

To avoid loss of precision, it might be better to reverse the order
of the division and multiplication:

    u64 tmp = (u64)ref_clk * nf / nr;

But doing that requires intimate knowledge about the range of nf to
avoid overflow, so I leave that to Serge.

>   }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
