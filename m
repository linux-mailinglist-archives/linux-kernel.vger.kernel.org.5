Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502B975B240
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjGTPRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjGTPRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:17:43 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2CB1B9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:17:41 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b96789d574so9981681fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1689866260; x=1690471060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGJbFmy2Z+/kC4N0jPlXv0cAGkNm61uDIvplAYqC9dU=;
        b=F9zASoBOUF5oxIlcLW9zXQHh52nuJLZ5qw5IZL7i4SM9WHz2dPV1vUZRuz3q3Y+Hhx
         v2HTdCNspqien4sjD8VHWqRUVQ4fQqOr7zK9fJfTTNwzvq/AKJITq7SiR8bEyilZH9BB
         B94GJik8/ZG9w1AsqXKrBH9Ktmoh/WfeauO4/IMRFFvQFqGJKHLKZKfDFDeq1z0c3uX6
         6cnpukWhLSssrN5a6HDRwxOhN/6YRhBZhmnIMBjsu96RdHKCBcYTdJZAngbaV8NlEDXH
         ySDlr8sVJXjjH4hIifTW78aJgX+2ItLUSXJbzz1uUeBa/UEBbl4snu4+SP9TFacqclNu
         3ptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689866260; x=1690471060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KGJbFmy2Z+/kC4N0jPlXv0cAGkNm61uDIvplAYqC9dU=;
        b=Z0JkFxa9nbnlasIfqAZo5xbeSDF6g04/VKeNyMOoGasUIrgh3M4lhwSRMzJ6/Qv1iZ
         LzuhY7OaymBAV90dD3/Mr1paifn7dyXi+GYEGXhU9M/Q0cGfIyJ51PhPe+6JaWWRAYEt
         S1ycWmhk7FJkjj1JF3zzscrYXwO0zaORbIqqmc1/O0YddWWahnRM/iQ+nq51Yyg9EvRV
         ZMw/Jiec4B/0QgCNE0/3XugRzkqv+E0qoIzIGxX5kjUk9rM7ZxjujPCZ0SiEqfdSoJwu
         bwX37wV+VhAvur0goP3Oitqfo5HJihJ+rdFkbeQbG018zversi3ArVuSwq3UZKxV8y0U
         +xsg==
X-Gm-Message-State: ABy/qLaHppnr/mB8lobDatuN+N9CyybLAWCCiuff8Js8rdILAkObkwuZ
        d7ERFaK1FC1MGhWHVpDRvsWCSJlQKmoXA41jdhyLOg==
X-Google-Smtp-Source: APBJJlEBe0CQjbSUBll9Vo/Jw2UbPo3HnZ0E3uk9dGhUVXSvidXk7j9k9ouvSgXbOrsL8VgxM3eBF7KwOsBNujkwy58=
X-Received: by 2002:a2e:9b89:0:b0:2b6:e7d6:714d with SMTP id
 z9-20020a2e9b89000000b002b6e7d6714dmr2973856lji.22.1689866259750; Thu, 20 Jul
 2023 08:17:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230711072053.2837327-1-geert+renesas@glider.be>
In-Reply-To: <20230711072053.2837327-1-geert+renesas@glider.be>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 20 Jul 2023 17:17:27 +0200
Message-ID: <CAMRc=Mef-J-WinQxphm+CU8u-PoBan1hPT2yLih4i-RFUDePBQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: mxc: Improve PM configuration
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 9:20=E2=80=AFAM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> If CONFIG_PM=3Dn (e.g. m68k/allmodconfig):
>
>     drivers/gpio/gpio-mxc.c:612:12: error: =E2=80=98mxc_gpio_runtime_resu=
me=E2=80=99 defined but not used [-Werror=3Dunused-function]
>       612 | static int mxc_gpio_runtime_resume(struct device *dev)
>           |            ^~~~~~~~~~~~~~~~~~~~~~~
>     drivers/gpio/gpio-mxc.c:602:12: error: =E2=80=98mxc_gpio_runtime_susp=
end=E2=80=99 defined but not used [-Werror=3Dunused-function]
>       602 | static int mxc_gpio_runtime_suspend(struct device *dev)
>           |            ^~~~~~~~~~~~~~~~~~~~~~~~
>
> Fix this by using the non-SET *_PM_OPS to configure the dev_pm_ops
> callbacks, and by wrapping the driver.pm initializer insider pm_ptr().
>
> As NOIRQ_SYSTEM_SLEEP_PM_OPS() uses pm_sleep_ptr() internally, the
> __maybe_unused annotations for the noirq callbacks are no longer needed,
> and can be removed.
>
> Fixes: 3283d820dce649ad ("gpio: mxc: add runtime pm support")
> Reported-by: noreply@ellerman.id.au
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/gpio/gpio-mxc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
> index a9fb6bd9aa6f9645..a43df5d5006e62d3 100644
> --- a/drivers/gpio/gpio-mxc.c
> +++ b/drivers/gpio/gpio-mxc.c
> @@ -623,7 +623,7 @@ static int mxc_gpio_runtime_resume(struct device *dev=
)
>         return 0;
>  }
>
> -static int __maybe_unused mxc_gpio_noirq_suspend(struct device *dev)
> +static int mxc_gpio_noirq_suspend(struct device *dev)
>  {
>         struct platform_device *pdev =3D to_platform_device(dev);
>         struct mxc_gpio_port *port =3D platform_get_drvdata(pdev);
> @@ -634,7 +634,7 @@ static int __maybe_unused mxc_gpio_noirq_suspend(stru=
ct device *dev)
>         return 0;
>  }
>
> -static int __maybe_unused mxc_gpio_noirq_resume(struct device *dev)
> +static int mxc_gpio_noirq_resume(struct device *dev)
>  {
>         struct platform_device *pdev =3D to_platform_device(dev);
>         struct mxc_gpio_port *port =3D platform_get_drvdata(pdev);
> @@ -647,8 +647,8 @@ static int __maybe_unused mxc_gpio_noirq_resume(struc=
t device *dev)
>  }
>
>  static const struct dev_pm_ops mxc_gpio_dev_pm_ops =3D {
> -       SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mxc_gpio_noirq_suspend, mxc_gpio_no=
irq_resume)
> -       SET_RUNTIME_PM_OPS(mxc_gpio_runtime_suspend, mxc_gpio_runtime_res=
ume, NULL)
> +       NOIRQ_SYSTEM_SLEEP_PM_OPS(mxc_gpio_noirq_suspend, mxc_gpio_noirq_=
resume)
> +       RUNTIME_PM_OPS(mxc_gpio_runtime_suspend, mxc_gpio_runtime_resume,=
 NULL)
>  };
>
>  static int mxc_gpio_syscore_suspend(void)
> @@ -695,7 +695,7 @@ static struct platform_driver mxc_gpio_driver =3D {
>                 .name   =3D "gpio-mxc",
>                 .of_match_table =3D mxc_gpio_dt_ids,
>                 .suppress_bind_attrs =3D true,
> -               .pm =3D &mxc_gpio_dev_pm_ops,
> +               .pm =3D pm_ptr(&mxc_gpio_dev_pm_ops),
>         },
>         .probe          =3D mxc_gpio_probe,
>  };
> --
> 2.34.1
>

Applied, thanks!

Bart
