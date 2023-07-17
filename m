Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A77A756967
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbjGQQn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbjGQQnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:43:25 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3504110CA
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:43:24 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-7835971026fso194764739f.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689612203; x=1692204203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PwGEUobmIzeE1ynGMso5nTP6k9hi1vsEiD4nWtMLViY=;
        b=6DpZqQr9ke7EKxJI3674MmPEyqAWR1ZGmXF0kaxH4hF35QYaEr2md5FJ4KlrvXEZYN
         fe/NAM9KXMCDgSfIOElTUtmVqFequ+1OtAd4p73ukn4rnGNot/Rcex9f71M1LUu7ePM+
         q3FZGpbNTVn2XvkcJNr2SIhNnPQ/4fNvFKJAM4LMgKNyMYGeWpDVrhfWfb23barRVjgr
         HjHuX84c6TjaMoCYAEzbm+8JtP0bV1dLhxDPB6d25rBseLctiEAWujG0vmbkiRD0sXIx
         oIhypkNFXWgCynpwWEc7BJFNeK0j0zMR3XQkOSq0OSnjJ8iooJly+79Qy5ymkDeR9370
         C3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689612203; x=1692204203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PwGEUobmIzeE1ynGMso5nTP6k9hi1vsEiD4nWtMLViY=;
        b=a+sPhJPZKv9DbEEy9m3yNdm88XqhPeODTq7L7YtgHjFiLflnqkqVOD3r7WveBs6eh+
         a95E4v8adoKeX2QCE8Kx1d7viWnX4IWzprRixtV/OuDm/+ZcvQZYZIyIaPv0ar9WYkBG
         16+1hd4YoTnnBKkWA9g+1oKHhIyb8+E8/AOcPSLMDwWOvEg4ZkhJzIaZnqLMWpnRjgWm
         SvIT9OmNopTOfztilSHsJbIlmsZtB/ztxxp5FFnVphUVZxdACOLFmW/4kDJbzYwo3plj
         5TsDJU2p2h9fsLbrekg5961mYmeOXrl/JmwxPp/2m8SqTGtUWyLWGeJtQDFHQSM9Zv/5
         bMyw==
X-Gm-Message-State: ABy/qLbeGg1f1ogM+QHze3YYwW+sLMzQ5zfTR6lea9QjZ6QodApMVC0Q
        UEXaz9X8uDMIFz5SehvHIZuO5X1XJ+oMRdGe2QAmUw==
X-Google-Smtp-Source: APBJJlGlDcDxNjjfSUXnqu2cf+CO9UT0tzSJggdkprgzhwYpNy+OtRaF6sckIjU4p49dGVWRbEHxhL6Nriiz//Rbqio=
X-Received: by 2002:a05:6602:24da:b0:783:5452:e343 with SMTP id
 h26-20020a05660224da00b007835452e343mr281082ioe.14.1689612203449; Mon, 17 Jul
 2023 09:43:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230717113709.328671-1-glider@google.com> <20230717113709.328671-3-glider@google.com>
 <ZLVoRkmy5IZYbjUV@yury-ThinkPad>
In-Reply-To: <ZLVoRkmy5IZYbjUV@yury-ThinkPad>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 17 Jul 2023 18:42:47 +0200
Message-ID: <CAG_fn=XnyrYwMdM5i-KqpaxW0xG+vFs3h3nipKePe8yTo23Eug@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] lib/test_bitmap: add tests for bitmap_{set,get}_value()
To:     Yury Norov <yury.norov@gmail.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 6:11=E2=80=AFPM Yury Norov <yury.norov@gmail.com> w=
rote:
>
> On Mon, Jul 17, 2023 at 01:37:05PM +0200, Alexander Potapenko wrote:
> > Add basic tests ensuring that values can be added at arbitrary position=
s
> > of the bitmap, including those spanning into the adjacent unsigned
> > longs.
> >
> > Signed-off-by: Alexander Potapenko <glider@google.com>
>
> Thanks for the test!
>
> > ---
> > This patch was previously called
> > "lib/test_bitmap: add tests for bitmap_{set,get}_value_unaligned"
> >
> > v3:
> >  - switch to using bitmap_{set,get}_value()
> >  - change the expected bit pattern in test_set_get_value(),
> >    as the test was incorrectly assuming 0 is the LSB.
> > ---
> >  lib/test_bitmap.c | 33 +++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >
> > diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
> > index 187f5b2db4cf1..c2ab54040c249 100644
> > --- a/lib/test_bitmap.c
> > +++ b/lib/test_bitmap.c
> > @@ -71,6 +71,17 @@ __check_eq_uint(const char *srcfile, unsigned int li=
ne,
> >       return true;
> >  }
> >
> > +static bool __init
> > +__check_eq_ulong(const char *srcfile, unsigned int line,
> > +              const unsigned long exp_ulong, unsigned long x)
> > +{
> > +     if (exp_ulong !=3D x) {
> > +             pr_err("[%s:%u] expected %lu, got %lu\n",
> > +                     srcfile, line, exp_ulong, x);
> > +             return false;
> > +     }
> > +     return true;
> > +}
> >
> >  static bool __init
> >  __check_eq_bitmap(const char *srcfile, unsigned int line,
> > @@ -186,6 +197,7 @@ __check_eq_str(const char *srcfile, unsigned int li=
ne,
> >       })
> >
> >  #define expect_eq_uint(...)          __expect_eq(uint, ##__VA_ARGS__)
> > +#define expect_eq_ulong(...)         __expect_eq(ulong, ##__VA_ARGS__)
> >  #define expect_eq_bitmap(...)                __expect_eq(bitmap, ##__V=
A_ARGS__)
> >  #define expect_eq_pbl(...)           __expect_eq(pbl, ##__VA_ARGS__)
> >  #define expect_eq_u32_array(...)     __expect_eq(u32_array, ##__VA_ARG=
S__)
> > @@ -1222,6 +1234,25 @@ static void __init test_bitmap_const_eval(void)
> >       BUILD_BUG_ON(~var !=3D ~BIT(25));
> >  }
> >
> > +static void __init test_set_get_value(void)
> > +{
> > +     DECLARE_BITMAP(bitmap, BITS_PER_LONG * 2);
>
> It's too short. Can you make it long enough to ensure it works as
> expected when start is not in the 1st word, and start+nbits is in
> the following word.
>
> > +     unsigned long val;
> > +     int i;
> > +
> > +     for (i =3D 0; i < BITS_PER_LONG * 2 - 7; i++) {
> > +             bitmap_zero(bitmap, BITS_PER_LONG * 2);
> > +             bitmap_set_value(bitmap, 0b10101UL, i, 5);
> > +             val =3D bitmap_get_value(bitmap, i, 5);
> > +             expect_eq_ulong(0b10101UL, val);
>
> Can you also check that the rest of bitmap is untouched?
> Something like:
>
>         DECLARE_BITMAP(bitmap, ...);
>         DECLARE_BITMAP(orig, ...);
>
>         memset(orig, 0x5a, ...);
>         memset(bitmap, 0x5a, ...);
>
>         for (j =3D start; j < start + nbits; j++)
>                 if (val & BIT(j - start))
>                         __set_bit(j, orig);
>                 else
>                         __clear_bit(j, orig);
>
>         bitmap_set_value(bitmap, val, start, nbits);
>         expect_eq_bitmap(orig, bitmap, ...);
>
> I like this kind of testing because it gives people a better
> understanding of what happens behind all that optimization tricks.

Will do. In fact the difference between GENMASK(n, 0) and GENMASK(n-1,
0) discussed in the other patch requires exactly this kind of testing.
