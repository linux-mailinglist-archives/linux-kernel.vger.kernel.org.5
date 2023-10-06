Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FA87BC2B0
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 00:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbjJFW6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 18:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbjJFW6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 18:58:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA24FAD;
        Fri,  6 Oct 2023 15:58:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8007AC433CB;
        Fri,  6 Oct 2023 22:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696633127;
        bh=VfpPsL7bm6HmerXk75YQFSWmkvZ5EqPcTozDyLPJ7ZE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rcV3x9OFyzgcq5JnKP7XyajjlUizbG7zv6TwJX1iaKrCN8FqIuecH1Zs6kZmhQOEZ
         P5swnL8g91dfdtAH5uD7CUPfp58B/0YpSIN3ixWWJxQCviyKPUkQq+hsY1llVzxYks
         n7hsv2wXXYKbSOT/lGjFXr+QCVT1bYxu2KJgb8h/w4I/W4nHsezboD2QmBMGg+JS+c
         fddknGRh0stdSH0IZPgrnL/3usGUh990pEG/HYNmtGfKnUEX0brB5XNw5LeEfdwL77
         yiA6xNpKXtTYNHFZcFfGboeB8buBhEtSzb/U6IMxeUW700lfF9/6Pry8ADjWXuuya7
         fqO4GAuHBxKnQ==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5046bf37daeso3418245e87.1;
        Fri, 06 Oct 2023 15:58:47 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw9hyN/C7Rv7isqw8Eo8yOD44kYSejPdkCsbeZBGE3mti2mTbMY
        9v4VE93KEOKvJaxutYldXTzHdTgu2LQOY4KHhQ==
X-Google-Smtp-Source: AGHT+IGLN4usMWBOz3e69x4mdRwL549LapQyzyV9YwhpOdQ+Wbn8qFwQJDLpXo6dG/GqnWIxylZDOOe8h7XSov2Ays4=
X-Received: by 2002:a19:6414:0:b0:4fb:8435:3efc with SMTP id
 y20-20020a196414000000b004fb84353efcmr7215825lfb.16.1696633125695; Fri, 06
 Oct 2023 15:58:45 -0700 (PDT)
MIME-Version: 1.0
References: <20231006213959.334439-1-robh@kernel.org> <CAA8EJpp7yKZP3SAHdZAJg57vbyRjYAS=vDEV-353mc9yzHe4vw@mail.gmail.com>
In-Reply-To: <CAA8EJpp7yKZP3SAHdZAJg57vbyRjYAS=vDEV-353mc9yzHe4vw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 6 Oct 2023 17:58:33 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ0O=-vNqSUjgr_Po=Xy1G+7Zdz7Dz+euUDjcpBAqtGqA@mail.gmail.com>
Message-ID: <CAL_JsqJ0O=-vNqSUjgr_Po=Xy1G+7Zdz7Dz+euUDjcpBAqtGqA@mail.gmail.com>
Subject: Re: [PATCH] clk: Use device_get_match_data()
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        David Lechner <david@lechnology.com>,
        Sekhar Nori <nsekhar@ti.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Tero Kristo <kristo@kernel.org>, patches@opensource.cirrus.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 6, 2023 at 5:10=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Sat, 7 Oct 2023 at 00:41, Rob Herring <robh@kernel.org> wrote:
> >
> > Use preferred device_get_match_data() instead of of_match_device() to
> > get the driver match data. With this, adjust the includes to explicitly
> > include the correct headers.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/clk/clk-lochnagar.c             |  9 ++-------
> >  drivers/clk/davinci/da8xx-cfgchip.c     |  8 +++-----
> >  drivers/clk/davinci/pll.c               | 10 +++-------
> >  drivers/clk/davinci/psc.c               | 10 +++-------
> >  drivers/clk/qcom/gcc-msm8960.c          | 13 +++++--------
> >  drivers/clk/qcom/gcc-msm8974.c          | 10 +++-------
> >  drivers/clk/qcom/kpss-xcc.c             |  9 ++-------
> >  drivers/clk/qcom/krait-cc.c             | 14 +++++---------
> >  drivers/clk/qcom/mmcc-msm8960.c         | 16 +++++-----------
> >  drivers/clk/qcom/mmcc-sdm660.c          |  8 ++------
> >  drivers/clk/rockchip/clk-rk3399.c       |  9 ++-------
> >  drivers/clk/samsung/clk-exynos-clkout.c |  8 +++-----
> >  drivers/clk/ti/adpll.c                  | 14 ++++----------
> >  13 files changed, 42 insertions(+), 96 deletions(-)
> >

> > diff --git a/drivers/clk/qcom/mmcc-msm8960.c b/drivers/clk/qcom/mmcc-ms=
m8960.c
> > index 6bf908a51f53..50638ab341ec 100644
> > --- a/drivers/clk/qcom/mmcc-msm8960.c
> > +++ b/drivers/clk/qcom/mmcc-msm8960.c
> > @@ -8,9 +8,9 @@
> >  #include <linux/err.h>
> >  #include <linux/delay.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/property.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> > -#include <linux/of_device.h>
> >  #include <linux/clk.h>
> >  #include <linux/clk-provider.h>
> >  #include <linux/regmap.h>
> > @@ -3105,30 +3105,24 @@ MODULE_DEVICE_TABLE(of, mmcc_msm8960_match_tabl=
e);
> >
> >  static int mmcc_msm8960_probe(struct platform_device *pdev)
> >  {
> > -       const struct of_device_id *match;
> >         struct regmap *regmap;
> > -       bool is_8064;
> >         struct device *dev =3D &pdev->dev;
> > +       const struct qcom_cc_desc *desc =3D device_get_match_data(dev);
> >
> > -       match =3D of_match_device(mmcc_msm8960_match_table, dev);
> > -       if (!match)
> > -               return -EINVAL;
> > -
> > -       is_8064 =3D of_device_is_compatible(dev->of_node, "qcom,mmcc-ap=
q8064");
>
> Can we please keep of_device_is_compatible here? It is more explicit
> and self-documenting.

Why do we need to match 3 times (match, device_get_match_data,
of_device_is_compatible)?

Perhaps put it in the match data? Or make a helper function is_8064()
that does the comparison to the match data?

> Also, it would be really nice to have per-platform patches, so that
> our maintainers can pick them, otherwise the risk of conflicts is
> pretty high.

No.

I'm doing this treewide. It's already pretty unmanageable. But feel
free to submit a separate patch if you prefer to this for QCom. When I
split things up by sub-arch, then I also have to spend time chasing
down non-responsive maintainers.

Rob
