Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D360A811542
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441947AbjLMOvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441935AbjLMOvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:51:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DE1FE
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 06:51:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CCACC433C9;
        Wed, 13 Dec 2023 14:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702479085;
        bh=YN2Pi9j4nXI2YgjQFpbxAPwojU9mF9Ce9D2uzS7p5oI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u0xvyQQG/8zoQ+DyU7J67Rt7Z66v47wiT7TsBD7R/RwnJ6uDkrLjvsK1R+eZUsF+o
         Gcd9xiu0nZ+1asUa+demSVp6obViBF4R1Wte7jQ9+nmHnhr98WlNOec922nFmN4INg
         tz03SIlIQXkRak830Sd7GIWIgj9BgvBt5NdKIHPn2gPu9+avudg1KQWDqwaPvBowvR
         DN0wnbLsKyP8hhC3Ij2N1M/cgvCWCGM4E2eCdnQJEiNxwfFdHZDrpz9y3ZvdM3kJI9
         FYlgVBO0+jOAccPxzZKbRDIk2X4pnNm2jooR55DWZZpptO0cg7zd0QzzivSLB3BHPl
         KvNpHBCnCVGSg==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a1e2f34467aso647839866b.2;
        Wed, 13 Dec 2023 06:51:25 -0800 (PST)
X-Gm-Message-State: AOJu0YxTZKEyDlJX1RibBXZGSMp4hxrGSO/3C361KVCajFrY395dytNe
        LoP25v1g/ZujxdozJzPF3fqIPADkYG7QfTgb4bI=
X-Google-Smtp-Source: AGHT+IHHbxlb+2p+oWmwWz9N1M5MlIVMBv6ta1Pihyc/8OevnH+Tc4BVUehL8EHk1fQgb58btAbkNyf7aPZDLhSrTtM=
X-Received: by 2002:a17:907:2d26:b0:a18:615c:66ff with SMTP id
 gs38-20020a1709072d2600b00a18615c66ffmr6081043ejc.49.1702479084073; Wed, 13
 Dec 2023 06:51:24 -0800 (PST)
MIME-Version: 1.0
References: <20231212214536.175327-1-arnd@kernel.org> <CAJF2gTQckdn=uDfeLKu7wceOq7LT1KGJUT0vARMr9zUy3xc4xw@mail.gmail.com>
 <42f522b5-6406-4bef-8180-3a431ee884a5@app.fastmail.com>
In-Reply-To: <42f522b5-6406-4bef-8180-3a431ee884a5@app.fastmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 13 Dec 2023 22:51:12 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ2jCKO4my9pNvEDyf0R+Cro8ZE_RgvWi-ts8pD6vJ=Nw@mail.gmail.com>
Message-ID: <CAJF2gTQ2jCKO4my9pNvEDyf0R+Cro8ZE_RgvWi-ts8pD6vJ=Nw@mail.gmail.com>
Subject: Re: [PATCH] leds: sun50i-a100: avoid division-by-zero warning
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 2:32=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Wed, Dec 13, 2023, at 02:26, Guo Ren wrote:
> > On Wed, Dec 13, 2023 at 5:45=E2=80=AFAM Arnd Bergmann <arnd@kernel.org>=
 wrote:
> >>  {
> >>         const struct sun50i_a100_ledc_timing *timing =3D &priv->timing=
;
> >>         unsigned long mod_freq =3D clk_get_rate(priv->mod_clk);
> >> -       u32 cycle_ns =3D NSEC_PER_SEC / mod_freq;
> >> +       u32 cycle_ns;
> >>         u32 control;
> >>
> >> +       if (!mod_freq)
> >> +               return;
> >> +
> > Shall we need err_disable_bus_clk?
> >
> > + static int sun50i_a100_ledc_set_timing(struct sun50i_a100_ledc *priv)
> > - static void sun50i_a100_ledc_set_timing(struct sun50i_a100_ledc *priv=
)
>
> I'm not worried about it too much, as there is already an error check
> on priv->mod_clk being unavailable during initialization. The case that
> the warning is about is just for build-testing on architectures that
> don't even use COMMON_CLK.
Okay

Reviewed-by: Guo Ren <guoren@kernel.org>

>
>      Arnd



--=20
Best Regards
 Guo Ren
