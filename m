Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCAED79DF35
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 06:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238252AbjIMEiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 00:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjIMEiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 00:38:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A33AC;
        Tue, 12 Sep 2023 21:38:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36AFBC433CB;
        Wed, 13 Sep 2023 04:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694579886;
        bh=lp1MfUDV1g5Db572Za7bIvo8jM3vLxZyUZnYTdWhwtw=;
        h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
        b=QYwCBDN4oiNezN7X46bFAZgwxK+O7bHbdML2QKihGct6zH4ereU/NEPD8WszkWgcq
         crtTUJRQYKGYgyU6HtKvqyIltfG7olQA6lN28xrHeSB4tqfeCbLybYTqk9LoMp5UA2
         tSP2jaxp2DXcPAj6wYNVam2TuWPLW2zIKMNrA8dfdfwyhGoOt+m9GionmYRCFJrdnr
         4VE26BkF0ADn6vLrYZnQE81SRG0CJMYKy2TC6eqf6G0IRY+NRubwLnlCbEMGWkYVbi
         EbOKNQgKT0SxXHAK1AJmkz/MiLwsrAG810kkZrau4nmutZBxKLwcnV95Ebbu8x4jKU
         lnMuaGS3CQyuQ==
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-268bc714ce0so415223a91.0;
        Tue, 12 Sep 2023 21:38:06 -0700 (PDT)
X-Gm-Message-State: AOJu0YwpE55b+wmMKNgDUzS0GbWnuO2Mv61aAwplTnSdCYRkSwr8N5Ob
        wtEQfVEV9V43urO4odx465EK3YvCOuwN9iTvT6Y=
X-Google-Smtp-Source: AGHT+IHkG8uOVBdwHQFTiYt9mtj7jeRHEsRYgJYW395zwn/qeD/dSBwWFpBtcpQj/RHGYpiuJLYpCr5Pxy3YZMv2uB8=
X-Received: by 2002:a17:90a:6f27:b0:269:a96:981a with SMTP id
 d36-20020a17090a6f2700b002690a96981amr2350959pjk.5.1694579885687; Tue, 12 Sep
 2023 21:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230904115816.1237684-1-s.hauer@pengutronix.de>
 <20230904115816.1237684-2-s.hauer@pengutronix.de> <CACRpkdYxRdToUM3JcEeNK_K87D5WDzzSLvVEbtqqdQEhz3k_Ow@mail.gmail.com>
In-Reply-To: <CACRpkdYxRdToUM3JcEeNK_K87D5WDzzSLvVEbtqqdQEhz3k_Ow@mail.gmail.com>
Reply-To: wens@kernel.org
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Wed, 13 Sep 2023 12:37:54 +0800
X-Gmail-Original-Message-ID: <CAGb2v65G-8EECNjqnpKCxqAD5nATAb0S7AA_WMiGXYOR1avrvg@mail.gmail.com>
Message-ID: <CAGb2v65G-8EECNjqnpKCxqAD5nATAb0S7AA_WMiGXYOR1avrvg@mail.gmail.com>
Subject: Re: [PATCH 1/3] pinctrl: rockchip: add support for io-domain dependency
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Saravana Kannan <saravanak@google.com>,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        kernel@pengutronix.de,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 4:07=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> Top posting to bring Saravana Kannan into this discussion.
>
> This looks like a big hack to me, Saravana has been working
> tirelessly to make the device tree probe order "sort itself out"
> and I am pretty sure this issue needs to be fixed at the DT
> core level and not in a driver.

We could merge all the IO domain stuff into the pinctrl node/driver,
like is done for Allwinner? Maybe that would simplify things a bit?

IIRC on Allwinner SoCs the PMIC pins don't have a separate power rail,
or if they do they almost certainly use the default I/O rail that is
always on, and so we omit it to work around the dependency cycle.

ChenYu



> Saravana, can you advice how we should handle this properly?
>
> Yours,
> Linus Walleij
>
> On Mon, Sep 4, 2023 at 1:58=E2=80=AFPM Sascha Hauer <s.hauer@pengutronix.=
de> wrote:
> >
> > On some Rockchip SoCs, some SoC pins are split in what are called IO
> > domains.
> >
> > An IO domain is supplied power externally, by regulators from a PMIC fo=
r
> > example. This external power supply is then used by the IO domain as
> > "supply" for the IO pins if they are outputs.
> >
> > Each IO domain can configure which voltage the IO pins will be operatin=
g
> > on (1.8V or 3.3V).
> >
> > There already exists an IO domain driver for Rockchip SoCs[1]. This
> > driver allows to explicit the relationship between the external power
> > supplies and IO domains[2]. This makes sure the regulators are enabled
> > by the Linux kernel so the IO domains are supplied with power and
> > correctly configured as per the supplied voltage.
> > This driver is a regulator consumer and does not offer any other
> > interface for device dependency.
> >
> > However, IO pins belonging to an IO domain need to have this IO domain
> > configured correctly before they are being used otherwise they do not
> > operate correctly.
> >
> > We currently do not have any knowledge about which pin is on which IO
> > domain, so we assume that all pins are on some IO domain and defer
> > probing of the pin consumers until the IO domain driver has been probed=
.
> > Some pins however are needed to access the regulators driving an IO
> > domain. Deferring probe for them as well would introduce a cyclic
> > dependency. To break out of this dependency a pin group can be supplied
> > a rockchip,io-domain-boot-on property. Probe won't be deferred for pin
> > groups with this property. rockchip,io-domain-boot-on should be added
> > to all pin groups needed to access the PMIC driving the IO domains.
> >
> > [1] drivers/soc/rockchip/io-domain.c
> > [2] Documentation/devicetree/bindings/power/rockchip-io-domain.yaml
> >
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  drivers/pinctrl/pinctrl-rockchip.c | 64 ++++++++++++++++++++++++++++++
> >  drivers/pinctrl/pinctrl-rockchip.h |  3 ++
> >  2 files changed, 67 insertions(+)
> >
> > diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinct=
rl-rockchip.c
> > index 0276b52f37168..663bd9d6840a5 100644
> > --- a/drivers/pinctrl/pinctrl-rockchip.c
> > +++ b/drivers/pinctrl/pinctrl-rockchip.c
> > @@ -24,6 +24,8 @@
> >  #include <linux/of_address.h>
> >  #include <linux/of_device.h>
> >  #include <linux/of_irq.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/platform_device.h>
> >  #include <linux/pinctrl/machine.h>
> >  #include <linux/pinctrl/pinconf.h>
> >  #include <linux/pinctrl/pinctrl.h>
> > @@ -2678,6 +2680,43 @@ static int rockchip_pmx_get_groups(struct pinctr=
l_dev *pctldev,
> >         return 0;
> >  }
> >
> > +static int rockchip_pmx_check_io_domain(struct rockchip_pinctrl *info,=
 unsigned group)
> > +{
> > +       struct platform_device *pdev;
> > +       int i;
> > +
> > +       if (!info->io_domains)
> > +               return 0;
> > +
> > +       if (info->groups[group].io_domain_skip)
> > +               return 0;
> > +
> > +       for (i =3D 0; i < info->num_io_domains; i++) {
> > +               if (!info->io_domains[i])
> > +                       continue;
> > +
> > +               pdev =3D of_find_device_by_node(info->io_domains[i]);
> > +               if (!pdev) {
> > +                       dev_err(info->dev, "couldn't find IO domain dev=
ice\n");
> > +                       return -ENODEV;
> > +               }
> > +
> > +               if (!platform_get_drvdata(pdev)) {
> > +                       dev_err(info->dev, "IO domain device is not pro=
bed yet, deferring...(%s)",
> > +                               info->groups[group].name);
> > +                       return -EPROBE_DEFER;
> > +               }
> > +
> > +               of_node_put(info->io_domains[i]);
> > +               info->io_domains[i] =3D NULL;
> > +       }
> > +
> > +       devm_kfree(info->dev, info->io_domains);
> > +       info->io_domains =3D NULL;
> > +
> > +       return 0;
> > +}
> > +
> >  static int rockchip_pmx_set(struct pinctrl_dev *pctldev, unsigned sele=
ctor,
> >                             unsigned group)
> >  {
> > @@ -2691,6 +2730,10 @@ static int rockchip_pmx_set(struct pinctrl_dev *=
pctldev, unsigned selector,
> >         dev_dbg(dev, "enable function %s group %s\n",
> >                 info->functions[selector].name, info->groups[group].nam=
e);
> >
> > +       ret =3D rockchip_pmx_check_io_domain(info, group);
> > +       if (ret)
> > +               return ret;
> > +
> >         /*
> >          * for each pin in the pin group selected, program the correspo=
nding
> >          * pin function number in the config register.
> > @@ -3019,6 +3062,8 @@ static int rockchip_pinctrl_parse_groups(struct d=
evice_node *np,
> >         if (!size || size % 4)
> >                 return dev_err_probe(dev, -EINVAL, "wrong pins number o=
r pins and configs should be by 4\n");
> >
> > +       grp->io_domain_skip =3D of_property_read_bool(np, "rockchip,io-=
domain-boot-on");
> > +
> >         grp->npins =3D size / 4;
> >
> >         grp->pins =3D devm_kcalloc(dev, grp->npins, sizeof(*grp->pins),=
 GFP_KERNEL);
> > @@ -3417,6 +3462,22 @@ static int rockchip_pinctrl_probe(struct platfor=
m_device *pdev)
> >                         return PTR_ERR(info->regmap_pmu);
> >         }
> >
> > +       info->num_io_domains =3D of_property_count_u32_elems(np, "rockc=
hip,io-domains");
> > +       if (info->num_io_domains) {
> > +               int i;
> > +
> > +               info->io_domains =3D devm_kmalloc_array(dev, info->num_=
io_domains,
> > +                                                     sizeof(*info->io_=
domains), GFP_KERNEL);
> > +               if (!info->io_domains)
> > +                       return -ENOMEM;
> > +
> > +               for (i =3D 0; i < info->num_io_domains; i++) {
> > +                       info->io_domains[i] =3D of_parse_phandle(np, "r=
ockchip,io-domains", 0);
> > +                       if (!info->io_domains[i])
> > +                               return -EINVAL;
> > +               }
> > +       }
> > +
> >         ret =3D rockchip_pinctrl_register(pdev, info);
> >         if (ret)
> >                 return ret;
> > @@ -3439,6 +3500,9 @@ static int rockchip_pinctrl_remove(struct platfor=
m_device *pdev)
> >
> >         of_platform_depopulate(&pdev->dev);
> >
> > +       for (i =3D 0; i < info->num_io_domains; i++)
> > +               of_node_put(info->io_domains[i]);
> > +
> >         for (i =3D 0; i < info->ctrl->nr_banks; i++) {
> >                 bank =3D &info->ctrl->pin_banks[i];
> >
> > diff --git a/drivers/pinctrl/pinctrl-rockchip.h b/drivers/pinctrl/pinct=
rl-rockchip.h
> > index 4759f336941ef..d2ac79b0a7bc4 100644
> > --- a/drivers/pinctrl/pinctrl-rockchip.h
> > +++ b/drivers/pinctrl/pinctrl-rockchip.h
> > @@ -435,6 +435,7 @@ struct rockchip_pin_group {
> >         unsigned int                    npins;
> >         unsigned int                    *pins;
> >         struct rockchip_pin_config      *data;
> > +       bool                            io_domain_skip;
> >  };
> >
> >  /**
> > @@ -462,6 +463,8 @@ struct rockchip_pinctrl {
> >         unsigned int                    ngroups;
> >         struct rockchip_pmx_func        *functions;
> >         unsigned int                    nfunctions;
> > +       struct device_node              **io_domains;
> > +       int                             num_io_domains;
> >  };
> >
> >  #endif
> > --
> > 2.39.2
> >
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
