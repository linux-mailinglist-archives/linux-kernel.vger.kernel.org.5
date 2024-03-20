Return-Path: <linux-kernel+bounces-108350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 169E088097A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 03:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2E171F2312F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5339879F6;
	Wed, 20 Mar 2024 02:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfS7L1tV"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B787D7464;
	Wed, 20 Mar 2024 02:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710900702; cv=none; b=tEkMJQGBzVGPu8QZE8qikIKl1CNn+pEpD1D6V8sdfTy3L1ZEDIjKMIly4lH4TMmllHlragWRCmwvyCX7VWTiLzu6RpcPcWmTDiT/JMAm6wcntnt7KxRftmuzkBi9tULvreQlI30JkC4hR7lDITe1eoUopf0d+VOteOqjX5WHz7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710900702; c=relaxed/simple;
	bh=lzxLsMVdwcPAMXkHC3RNt0usmP7tGhKFAczR2Lqss+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RH1yranWQR49ZkaHa31GM0LBK48iarAkJGN/WCJbaGMan2+MxJrXVFdKDR9qHJl0HOJ+07UzNu8FkzNHHqm+sYpo0CMTsKCsoeFBIwN1qOKi3QU3rhfGdIFPF3zJG6ZcF431eaHs/scgmTFZ82BA6AIkV8zblGbvCDqgiO1vzTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfS7L1tV; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7cd06b9682aso76281839f.3;
        Tue, 19 Mar 2024 19:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710900700; x=1711505500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E68i2axyuKVX+pAKCm1Dr5BpFi26SQMx7ONiMhlC3wI=;
        b=jfS7L1tVrpbMKmvekv/LFGAiov7wTYrr2WOEf1EK+60uviGY/plVruko8naitXUHFX
         Yoq8YO5B8wSt/CNwUsb1qS0qusf/0RqLBXiE5UzqrYaPVQ8IuPL5rHCqLDYuFfTKOuVq
         brjlfeEdRNemCUr+ysIOoP4PJRAXqOrgtC79dvhi/lE7iKiEww4ApvMITj/MiI4ndk6r
         9ELj+Azb73++UXkWFXCuY0wrF9nA90Olrv49m9P8pnojHWwPwplOXEV+Rf3bKfBeZgq4
         bqR2Gv1DEtRJrA/YkDhFhCGnl6U1nxPNDjxpf2gHs7TY+0K3neCeHvEIrZACe0DX1fw5
         Kw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710900700; x=1711505500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E68i2axyuKVX+pAKCm1Dr5BpFi26SQMx7ONiMhlC3wI=;
        b=TsI3SIO+oIn5YgC98UY8VxUVqAwp3SWqs/FgkzFbrE6CmNLrEGh5+Jf7FZq46F+buM
         kelLl1jZQL+ZoBCl+vjXq8Ola5pwoLPwv5i4iyf0u9W8EPF4iGeQNtDE4vHdBWNSr6Y2
         Xvxyio2vtqgZdkQGN8OOR0dGq+gwZlFG0iJHmcLl17bJnI27zq/CxxqKeO82d9e6bO2N
         awRG4YVKPv/VwhuLR8WxRL+aj2Prt7KT8HIDuz5DuNVl4CMXAt6Kls0mYxNSPLFKBgnW
         X7PbNuR1jbmy4ZovdaGPEbP7Kk5/lq2KZPDAdnNCJ4QY1l6kcPTk1b87UiJNZKd4x4Vg
         hITQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEElFPENevxdRRSGnE6Pcx9Gl6v/cd4LoE9Whqn8l9foyCvKUYwzB/c4VjseSHOfLTKcecRho7lyxvvQo1v3oEP6mGasEnOIBBGvt3YRex7CiVdteOgrJ4LBhsksp9gihjU9SVnNBn
X-Gm-Message-State: AOJu0YxP79TG3PPF6f8Qjc48t7d0QEUqgiS7AWM6IzOj6QnlxKpue+w7
	STw4bNt8OgeZg2E7jebFGFaFDnlodgRkMrfgCrz3v6YnShknD5vHUkwCN9V3L01yPt+BgAKWLVt
	GDc0yN2KxqAl4x7+dblrbGahS249xf9ymTmeKCg==
X-Google-Smtp-Source: AGHT+IHhJev0TqCHoeBZ/G8P415iS43EsvpMRA02NklfIYZ/S018w7Eo+6OHjyyDm1Db/bDl/DI++n43myZ6cNddat8=
X-Received: by 2002:a92:cbc2:0:b0:366:2f7d:d292 with SMTP id
 s2-20020a92cbc2000000b003662f7dd292mr16561775ilq.6.1710900699697; Tue, 19 Mar
 2024 19:11:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1710743811-1698-1-git-send-email-shengjiu.wang@nxp.com>
 <DU0PR04MB941745611C0FE10E847C4B25882D2@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20240319073540.2zvwq7fvft3h6mbr@pengutronix.de>
In-Reply-To: <20240319073540.2zvwq7fvft3h6mbr@pengutronix.de>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Wed, 20 Mar 2024 10:11:28 +0800
Message-ID: <CAA+D8APofupb5UdnKuzwkvRhj544kQ8yKBU_84esTQDN=MKzBQ@mail.gmail.com>
Subject: Re: [PATCH] clk: imx: imx8mp: Add pm_runtime support for power saving
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Peng Fan <peng.fan@nxp.com>, "S.J. Wang" <shengjiu.wang@nxp.com>, 
	"abelvesa@kernel.org" <abelvesa@kernel.org>, "mturquette@baylibre.com" <mturquette@baylibre.com>, 
	"sboyd@kernel.org" <sboyd@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>, 
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, 
	"festevam@gmail.com" <festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, 
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 3:35=E2=80=AFPM Marco Felsch <m.felsch@pengutronix.=
de> wrote:
>
> On 24-03-18, Peng Fan wrote:
> > > Subject: [PATCH] clk: imx: imx8mp: Add pm_runtime support for power
> > > saving
> > >
> > > Add pm_runtime support for power saving. In pm runtime suspend state =
the
> > > registers will be reseted, so add registers save in pm runtime suspen=
d and
> > > restore them in pm runtime resume.
>
> We had similar patches in our downstream repo but didn't upstream yet
> since there was an clk-handing issue. IIRC the issue was regarding the
> global clock-prepare lock and a circular dependency on it. Is this
> resolved now?

Seems I didn't meet the issue you mentioned.

But I found another issue with my implementation that the pm_runtime_enable
need to move before the clk registered, Otherwise the core->rpm_enabled
is not ture at clk registering.

I will update in next version.

Best regards
Shengjiu Wang
>
> Regards,
>   Marco
>
> > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> >
> > Reviewed-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  drivers/clk/imx/clk-imx8mp-audiomix.c | 99 +++++++++++++++++++++++++=
+-
> > >  1 file changed, 96 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/=
clk-
> > > imx8mp-audiomix.c
> > > index 55ed211a5e0b..d2bf53e2aacf 100644
> > > --- a/drivers/clk/imx/clk-imx8mp-audiomix.c
> > > +++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
> > > @@ -7,10 +7,12 @@
> > >
> > >  #include <linux/clk-provider.h>
> > >  #include <linux/device.h>
> > > +#include <linux/io.h>
> > >  #include <linux/mod_devicetable.h>
> > >  #include <linux/module.h>
> > >  #include <linux/of.h>
> > >  #include <linux/platform_device.h>
> > > +#include <linux/pm_runtime.h>
> > >
> > >  #include <dt-bindings/clock/imx8mp-clock.h>
> > >
> > > @@ -18,6 +20,7 @@
> > >
> > >  #define CLKEN0                     0x000
> > >  #define CLKEN1                     0x004
> > > +#define EARC                       0x200
> > >  #define SAI1_MCLK_SEL              0x300
> > >  #define SAI2_MCLK_SEL              0x304
> > >  #define SAI3_MCLK_SEL              0x308
> > > @@ -26,6 +29,12 @@
> > >  #define SAI7_MCLK_SEL              0x314
> > >  #define PDM_SEL                    0x318
> > >  #define SAI_PLL_GNRL_CTL   0x400
> > > +#define SAI_PLL_FDIVL_CTL0 0x404
> > > +#define SAI_PLL_FDIVL_CTL1 0x408
> > > +#define SAI_PLL_SSCG_CTL   0x40C
> > > +#define SAI_PLL_MNIT_CTL   0x410
> > > +#define IPG_LP_CTRL                0x504
> > > +#define REGS_NUM           16
> > >
> > >  #define SAIn_MCLK1_PARENT(n)                                        =
       \
> > >  static const struct clk_parent_data                                 =
       \
> > > @@ -182,13 +191,65 @@ static struct clk_imx8mp_audiomix_sel sels[] =
=3D {
> > >     CLK_SAIn(7)
> > >  };
> > >
> > > +struct clk_imx8mp_audiomix_regs {
> > > +   u32 regs_num;
> > > +   u32 regs_off[];
> > > +};
> > > +
> > > +static const struct clk_imx8mp_audiomix_regs audiomix_regs =3D {
> > > +   .regs_num =3D REGS_NUM,
> > > +   .regs_off =3D {
> > > +           CLKEN0,
> > > +           CLKEN1,
> > > +           EARC,
> > > +           SAI1_MCLK_SEL,
> > > +           SAI2_MCLK_SEL,
> > > +           SAI3_MCLK_SEL,
> > > +           SAI5_MCLK_SEL,
> > > +           SAI6_MCLK_SEL,
> > > +           SAI7_MCLK_SEL,
> > > +           PDM_SEL,
> > > +           SAI_PLL_GNRL_CTL,
> > > +           SAI_PLL_FDIVL_CTL0,
> > > +           SAI_PLL_FDIVL_CTL1,
> > > +           SAI_PLL_SSCG_CTL,
> > > +           SAI_PLL_MNIT_CTL,
> > > +           IPG_LP_CTRL
> > > +   },
> > > +};
> > > +
> > > +struct clk_imx8mp_audiomix_drvdata {
> > > +   void __iomem *base;
> > > +   u32 regs_save[REGS_NUM];
> > > +};
> > > +
> > > +static void clk_imx8mp_audiomix_save_restore(struct device *dev, boo=
l
> > > +save) {
> > > +   struct clk_imx8mp_audiomix_drvdata *drvdata =3D
> > > dev_get_drvdata(dev);
> > > +   void __iomem *base =3D drvdata->base;
> > > +   int i;
> > > +
> > > +   if (save) {
> > > +           for (i =3D 0; i < audiomix_regs.regs_num; i++)
> > > +                   drvdata->regs_save[i] =3D readl(base +
> > > audiomix_regs.regs_off[i]);
> > > +   } else {
> > > +           for (i =3D 0; i < audiomix_regs.regs_num; i++)
> > > +                   writel(drvdata->regs_save[i], base +
> > > audiomix_regs.regs_off[i]);
> > > +   }
> > > +}
> > > +
> > >  static int clk_imx8mp_audiomix_probe(struct platform_device *pdev)  =
{
> > > +   struct clk_imx8mp_audiomix_drvdata *drvdata;
> > >     struct clk_hw_onecell_data *priv;
> > >     struct device *dev =3D &pdev->dev;
> > >     void __iomem *base;
> > >     struct clk_hw *hw;
> > > -   int i;
> > > +   int i, ret;
> > > +
> > > +   drvdata =3D devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> > > +   if (!drvdata)
> > > +           return -ENOMEM;
> > >
> > >     priv =3D devm_kzalloc(dev,
> > >                         struct_size(priv, hws,
> > > IMX8MP_CLK_AUDIOMIX_END), @@ -202,6 +263,9 @@ static int
> > > clk_imx8mp_audiomix_probe(struct platform_device *pdev)
> > >     if (IS_ERR(base))
> > >             return PTR_ERR(base);
> > >
> > > +   drvdata->base =3D base;
> > > +   dev_set_drvdata(dev, drvdata);
> > > +
> > >     for (i =3D 0; i < ARRAY_SIZE(sels); i++) {
> > >             if (sels[i].num_parents =3D=3D 1) {
> > >                     hw =3D devm_clk_hw_register_gate_parent_data(dev,
> > > @@ -257,10 +321,38 @@ static int clk_imx8mp_audiomix_probe(struct
> > > platform_device *pdev)
> > >     if (IS_ERR(hw))
> > >             return PTR_ERR(hw);
> > >
> > > -   return devm_of_clk_add_hw_provider(&pdev->dev,
> > > of_clk_hw_onecell_get,
> > > -                                      priv);
> > > +   ret =3D devm_of_clk_add_hw_provider(&pdev->dev,
> > > of_clk_hw_onecell_get,
> > > +                                     priv);
> > > +   if (ret)
> > > +           return ret;
> > > +
> > > +   pm_runtime_enable(&pdev->dev);
> > > +   clk_imx8mp_audiomix_save_restore(&pdev->dev, true);
> > > +
> > > +   return 0;
> > >  }
> > >
> > > +static int clk_imx8mp_audiomix_runtime_suspend(struct device *dev) {
> > > +   clk_imx8mp_audiomix_save_restore(dev, true);
> > > +
> > > +   return 0;
> > > +}
> > > +
> > > +static int clk_imx8mp_audiomix_runtime_resume(struct device *dev) {
> > > +   clk_imx8mp_audiomix_save_restore(dev, false);
> > > +
> > > +   return 0;
> > > +}
> > > +
> > > +static const struct dev_pm_ops clk_imx8mp_audiomix_pm_ops =3D {
> > > +   SET_RUNTIME_PM_OPS(clk_imx8mp_audiomix_runtime_suspend,
> > > +                      clk_imx8mp_audiomix_runtime_resume, NULL)
> > > +   SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> > > +                                 pm_runtime_force_resume)
> > > +};
> > > +
> > >  static const struct of_device_id clk_imx8mp_audiomix_of_match[] =3D =
{
> > >     { .compatible =3D "fsl,imx8mp-audio-blk-ctrl" },
> > >     { /* sentinel */ }
> > > @@ -272,6 +364,7 @@ static struct platform_driver
> > > clk_imx8mp_audiomix_driver =3D {
> > >     .driver =3D {
> > >             .name =3D "imx8mp-audio-blk-ctrl",
> > >             .of_match_table =3D clk_imx8mp_audiomix_of_match,
> > > +           .pm =3D &clk_imx8mp_audiomix_pm_ops,
> > >     },
> > >  };
> > >
> > > --
> > > 2.34.1
> >
> >
> >

