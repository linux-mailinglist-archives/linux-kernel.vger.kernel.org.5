Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BDA75F8A5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjGXNmK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 24 Jul 2023 09:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbjGXNly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:41:54 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF5D524B;
        Mon, 24 Jul 2023 06:39:57 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-577ddda6ab1so64822357b3.0;
        Mon, 24 Jul 2023 06:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690205942; x=1690810742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qiJUEifq/ocqszuQ6vkzllY049w/jFWshfCCKwI67O0=;
        b=lHpbIwCh2UotmPi2/5dGxne+6G94biVe+7AK+fInCqSEHAzvpYGqXtYLNnarxXh/ns
         RooSbfwU4HZWIcmReegVsNSFif0ThXBz6kn+1+OnWBn3h8/1Nzf5Y2T7H/KFDSc2uJP+
         vpRxyUSf0vPUdZ0I0AGFRQJ1UwZNYkxP7/13wFuryJPBtSqFOw/yEEb0e3uI91m6k2qN
         AppPOPeQ/y444iWSNU3gteoXco738CzIsPLA19l7uiOK/OJPUsSyd8QT07Wb4xIQrk6O
         Ys/xAGceH1J0hL8TI2vH2lZ5cdkjak1BGzcR48++Mr4o4upWkulLs8EMm06l8lA6bzun
         25Vw==
X-Gm-Message-State: ABy/qLYQ1xrBz6e9tqOM52J811wwJGQFrrPYPl772pefdWJ3ErJMHSPh
        mpOiaWk7PCxlQWnfNDwhnwecGPxqHtOCAQ==
X-Google-Smtp-Source: APBJJlEHbIAvW508Hk0Rl5zBp/Q6LXMymigC4n1qp9xbzQSqZ5S0545WYTBkTt5LzlXyfC7yCRLJAQ==
X-Received: by 2002:a81:a1c3:0:b0:56c:e371:aad with SMTP id y186-20020a81a1c3000000b0056ce3710aadmr5098401ywg.14.1690205942346;
        Mon, 24 Jul 2023 06:39:02 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id g197-20020a8152ce000000b0057a67df3308sm2733515ywb.101.2023.07.24.06.39.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 06:39:01 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5768a7e3adbso79866927b3.0;
        Mon, 24 Jul 2023 06:39:01 -0700 (PDT)
X-Received: by 2002:a25:1402:0:b0:cac:f162:fd with SMTP id 2-20020a251402000000b00cacf16200fdmr6977924ybu.30.1690205941624;
 Mon, 24 Jul 2023 06:39:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230612033904.34921-1-zhanglibing@cdjrlc.com>
 <0dc9409b662180ed29cbc281f0f076b7@208suo.com> <fcd37e67fba625da304fdaf07e0ab0db@208suo.com>
 <CAMuHMdX0xP5Gugo7uF5Wqk9_ny6-4fOWYRm41KicOo26kC6m+g@mail.gmail.com> <nt6kbounehvfqo4hpfj3wbr7baukuhr22dafvoykgyehs4imsp@pc6bajyo6ugn>
In-Reply-To: <nt6kbounehvfqo4hpfj3wbr7baukuhr22dafvoykgyehs4imsp@pc6bajyo6ugn>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Jul 2023 15:38:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUHDK9CCJPoMgLQBrXjk9VWszYF17dUU=9JtQ8XX=QAPA@mail.gmail.com>
Message-ID: <CAMuHMdUHDK9CCJPoMgLQBrXjk9VWszYF17dUU=9JtQ8XX=QAPA@mail.gmail.com>
Subject: Re: [PATCH] clk: baikal-t1: Using div64_ Ul replaces do_ Div() function
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     wuyonggang001@208suo.com, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Hi Serge,

On Mon, Jul 24, 2023 at 3:13 PM Serge Semin <fancer.lancer@gmail.com> wrote:
> On Mon, Jul 24, 2023 at 12:04:19PM +0200, Geert Uytterhoeven wrote:
> > On Wed, Jun 14, 2023 at 8:07 AM <wuyonggang001@208suo.com> wrote:
> > > Fix the following coccicheck warning:
> > >
> > > drivers/clk/baikal-t1/ccu-pll.c:81:1-7: WARNING: do_div() does a
> > > 64-by-32 division, please consider using div64_ul instead.
> > >
> > > Signed-off-by: Yonggang Wu <wuyonggang001@208suo.com>
> >
> > Thanks for your patch, which is now commit b93d1331ea266dea
> > ("clk: baikal-t1: Using div64_ Ul replaces do_ Div() function")
> > in clk/clk-next.
> >
> > > b/drivers/clk/baikal-t1/ccu-pll.c
> > > index 13ef28001439..d41735c6956a 100644
> > > --- a/drivers/clk/baikal-t1/ccu-pll.c
> > > +++ b/drivers/clk/baikal-t1/ccu-pll.c

> > > @@ -78,9 +78,9 @@ static inline unsigned long ccu_pll_calc_freq(unsigned
> > > long ref_clk,
> > >   {
> > >       u64 tmp = ref_clk;
> > >
>
> > > -    do_div(tmp, nr);
> > > +    div64_ul(tmp, nr);
> > >       tmp *= nf;
> > > -    do_div(tmp, od);
> > > +    div64_ul(tmp, od);
> > >
> > >       return tmp;
> >
> > Likewise.
>
> Right. This will also break the driver.
>
> > But as ref_clk is unsigned long, there is no need to use div64_ul()
> > for the first division, and this can be simplified to:
> >
> >     u64 tmp = (u64)(ref_clk / nr) * nf;
> >     return div64_ul(tmp, od);
>
> Absolutely right. My intention of using the do_div() anyway was for
> the sake of the code unification.
>
> >
> > To avoid loss of precision, it might be better to reverse the order
> > of the division and multiplication:
> >
>
> >     u64 tmp = (u64)ref_clk * nf / nr;
>
> Alas exactly this code will cause the compilation error on the 32-bit
> platform:
> ccu-pll.c:(.text+0x458): undefined reference to `__udivdi3'
>
> That's why I am using the do_div() here. I would have rather used the
> div64_ul() instead as this patch suggests, but I haven't known about its
> existence up to this moment.

Bummer, that was a silly mistake on my side...
(Initially, I didn't write the cast to u64 there, as all of ref_clk, nf, and nr
 are unsigned long.  Then I realized "ref_clk * nf" might overflow on
 32-bit, thus requiring a 64-bit result. And I added the cast...)

> Anyway my intention of dividing before multiplying had twofold
> justification. Firstly I didn't want to use the "/" operator and
> do_div() macro in the statements used to implement the same formulae.
> Since I couldn't use the operator I decided to use the macro only for
> the code unification. Secondly the PLL is designed in a way so the
> signal is first divided by NR, then multiplied by NF and then divided
> by OD. That's why I decided to preserve the same order in the
> calculations here. I assumed back then that the NR-divider performs
> the integer division in the analog circuitry. I have doubts now that
> my assumption was correct since it's analog device and most likely
> divides the source signal with no integer rounding-up. So using the
> order suggested by you would have likely given a more exact result.
>
> >
> > But doing that requires intimate knowledge about the range of nf to
> > avoid overflow, so I leave that to Serge.
>
> nr: 1 - 2^6
> nf: 1 - 2^13
> ref_clk: normally 25'000'000 Hz.
> Using "unsigned long"/u32 multiplication will give the integer
> overflow. Meanwhile the u64 arithmetics will be more than enough here.
>
> So to speak the next alteration seems more correct here:
> +return div64_ul(div64_ul((u64)ref_clk * nf, nr), od);
>
> What do you think?

Given the ranges above, nr and nf can be u32 instead of unsigned long.
So perhaps it makes sense to use the mul_u64_u32_div() helper?

    return div64_ul(mul_u64_u32_div(ref_clk, nf, nr), of);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
