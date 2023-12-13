Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C03E8107A2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 02:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378175AbjLMB0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 20:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378140AbjLMB0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 20:26:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65ACFCE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 17:26:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA820C433CB;
        Wed, 13 Dec 2023 01:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702430775;
        bh=aBtyNCLkIf7Ad5Olk8xczx4s4Yqgo4qr9dFI3TcxzyM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CkVrkBzEMvpbUGYUdq2/UwEscpojSiDLjROWFdtsV5xt1nY9jKGWuQ7sF9weDWgC+
         dvyCkZsC/eMtG7i8i8i+LrgV+6moF2KcqXgfL5ZVKHIMrxJ4wmEpOx+KZOlQJr0EU4
         rId+Repyn5HjWiWQFOJAuTLQqeTj0V/RgrVM8guS4vFsgD55G1wPqSr3nAsuXW/VOH
         2dQi86AbnlK8nwSc6bmrx7CVEzvmbNC9Ur0cGEI6Gu/swXt8QPDbbFRHKfEruPY29G
         87rYoEWyHzllGwzl1hRlzebibjR5LNF0tecXrC1pX5AQZs9fEBkqpZ196JJ7fFp2UU
         fa1g5U/RhW6xQ==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a1f0616a15bso713509866b.2;
        Tue, 12 Dec 2023 17:26:14 -0800 (PST)
X-Gm-Message-State: AOJu0Yzn+kR8Xl6GdUwJtw0AIOvhGw8ME+uITVGhm7SV8sBUdeKTeLCI
        Luefg/KseyJCiIvnxB1MT/b1OghW0/XGoV2XyBI=
X-Google-Smtp-Source: AGHT+IH8PdDOxcCr9RSiZtI+mlYPHV7O/ApH14MiLTasE5jBX9Q961CNJEvIUs0gXicS4t/RLvDUEbC4CWdT0SIrOgM=
X-Received: by 2002:a17:906:26c6:b0:a1f:7298:aa25 with SMTP id
 u6-20020a17090626c600b00a1f7298aa25mr4164250ejc.45.1702430773295; Tue, 12 Dec
 2023 17:26:13 -0800 (PST)
MIME-Version: 1.0
References: <20231212214536.175327-1-arnd@kernel.org>
In-Reply-To: <20231212214536.175327-1-arnd@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 13 Dec 2023 09:26:01 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQckdn=uDfeLKu7wceOq7LT1KGJUT0vARMr9zUy3xc4xw@mail.gmail.com>
Message-ID: <CAJF2gTQckdn=uDfeLKu7wceOq7LT1KGJUT0vARMr9zUy3xc4xw@mail.gmail.com>
Subject: Re: [PATCH] leds: sun50i-a100: avoid division-by-zero warning
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 5:45=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> When CONFIG_COMMON_CLK is disabled, e.g. on an x86 randconfig compile tes=
t,
> clang reports a field overflow from propagating the result of a division =
by
> zero:
>
> drivers/leds/leds-sun50i-a100.c:309:12: error: call to '__compiletime_ass=
ert_265' declared with 'error' attribute: FIELD_PREP: value too large for t=
he field
>         control =3D FIELD_PREP(LEDC_T01_TIMING_CTRL_REG_T1H, timing->t1h_=
ns / cycle_ns) |
>
> Avoid the problem by adding an explicit check for the zero value here. Al=
ternatively
> the assertion could be avoided with a Kconfig dependency on COMMON_CLK.
>
> Fixes: 090a25ad9798 ("leds: sun50i-a100: New driver for the A100 LED cont=
roller")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/leds/leds-sun50i-a100.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/leds/leds-sun50i-a100.c b/drivers/leds/leds-sun50i-a=
100.c
> index e4a7e692a908..171cefd1ea0d 100644
> --- a/drivers/leds/leds-sun50i-a100.c
> +++ b/drivers/leds/leds-sun50i-a100.c
> @@ -303,9 +303,13 @@ static void sun50i_a100_ledc_set_timing(struct sun50=
i_a100_ledc *priv)
>  {
>         const struct sun50i_a100_ledc_timing *timing =3D &priv->timing;
>         unsigned long mod_freq =3D clk_get_rate(priv->mod_clk);
> -       u32 cycle_ns =3D NSEC_PER_SEC / mod_freq;
> +       u32 cycle_ns;
>         u32 control;
>
> +       if (!mod_freq)
> +               return;
> +
Shall we need err_disable_bus_clk?

+ static int sun50i_a100_ledc_set_timing(struct sun50i_a100_ledc *priv)
- static void sun50i_a100_ledc_set_timing(struct sun50i_a100_ledc *priv)
 {
         const struct sun50i_a100_ledc_timing *timing =3D &priv->timing;
         unsigned long mod_freq =3D clk_get_rate(priv->mod_clk);
 -       u32 cycle_ns =3D NSEC_PER_SEC / mod_freq;
 +       u32 cycle_ns;
         u32 control;

+       if (!mod_freq)
+               return -EINVAL;

 +       cycle_ns =3D NSEC_PER_SEC / mod_freq;
         control =3D FIELD_PREP(LEDC_T01_TIMING_CTRL_REG_T1H,
timing->t1h_ns / cycle_ns) |
                   FIELD_PREP(LEDC_T01_TIMING_CTRL_REG_T1L,
timing->t1l_ns / cycle_ns) |
                   FIELD_PREP(LEDC_T01_TIMING_CTRL_REG_T0H,
timing->t0h_ns / cycle_ns) |
...
       return 0;

----------

+ ret =3D sun50i_a100_ledc_set_timing(priv);
+ if (ret)
+         goto err_disable_bus_clk;



> --
> 2.39.2
>


--=20
Best Regards
 Guo Ren
