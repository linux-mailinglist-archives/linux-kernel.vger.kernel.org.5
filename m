Return-Path: <linux-kernel+bounces-54267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5246784AD07
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76A751C225B9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F505745EF;
	Tue,  6 Feb 2024 03:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LshS8m0M"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53031EB3A;
	Tue,  6 Feb 2024 03:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707190758; cv=none; b=Vc40o8tzzewyrRAd0irqPBy9UlfM9XRvkpCkBDgj+jjmdU5uZ6NdmEtY1t4saXJ56rDvzdleQm0LK5KEPMi7N7AYutmWilH/LlyjL94ULVMtGgVQa7bATd9V2dhUk27AJrQjO3vs+DTFJOFNzEJTI+7e6IQrAcii8J9lCRssEtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707190758; c=relaxed/simple;
	bh=Eg9z6jEW9p/PugjKdtuVlFec6GWtC4u5Fc10RoOmES4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qc/zmvuSsbFHTWw1bEnZ/qsU/pDlugeOvuRXlJp2qfBjAcN3svWe2l7b2jRf4U+JdohV67wflWMqiRk5mXfVN+Z1blevr/ZmutmC1HjSRiO0ixCcXnJKBTPFunF9KdIjmreU+uJLc/mDXPBJ0kwnBScfs6Ggj288Q08uTjABxUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LshS8m0M; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2906bcae4feso3950234a91.3;
        Mon, 05 Feb 2024 19:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707190756; x=1707795556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYjlWLoy2riopH+zlSIcKPkCBJ5S6WcdaC4eCMXtR5k=;
        b=LshS8m0MHIN/u/1fY2ptq+nTKztGCyRotMOeGwlTbjqwlLBYxRbXfc8/dY5pr+Z7FO
         F16RFXi3hs6OldQd/ZSlANxPgTh4sMeU+ALAJJHTvKCoKXP3uYeyOhbhOESA4X45kHAx
         4F6Efm112KxwP4QZHiNfMsR4MtTmb5w+Dyr035c8DVOuHbEvi2g5yUzTFgrHRQPWbyLb
         09THTKa3be9P6MPgrD/3QFmUjLdB+ZYHDPjHES3KRCKatHVQBZt3mUd0+JpVoEbRHapO
         JRjaq8us3kGdbcyQDMiD0NaWDrHTQEqvQV09iLmJPUZOrf1rt6tLEhirfRMI9xV1454n
         H30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707190756; x=1707795556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EYjlWLoy2riopH+zlSIcKPkCBJ5S6WcdaC4eCMXtR5k=;
        b=veXXWeeqxW5SzW9OJnV1K4VDTVQHBtnNqiktDlwuwPw+PvF7A1BvR3Qb4WdGrRnoyw
         h9HUA730pyY0MRZFwwz7hnwr/b3tpODiCyLObUgoClSJ3XdF6KmyJJ6bfIPHWkM9xE6i
         kvk7Y1ZHhWIu51y1vyMcujBOMy/3nEeaWjcuif2nxO5pVInP+kr+e1zjtvBCvef2nPf3
         WwxxmJYnR3g0dhPl7q8DzNB/VUNadvUO0wjMwYXby80sp+5GLodI9qGyIaDXNsT7IO6B
         14st3bhANe+WMERhkvgP4c7RZF0FEgCu6/0Q7suHlz7qqp1gm+zM6jAE6utrHckWiWhI
         EEOA==
X-Gm-Message-State: AOJu0YyMIzLW8Hy3As6yS1vKhRK6vwrUZ7W6xBmUY5ZN//e2tDTYNjU/
	07ixyizRaTnDnGCjDEhp4rlHGjdH8WSsyBLVaCWQ/5U724qqlKT2Mi7Us1roVxlhoeb88mBsyxQ
	c5NtyeGTFNoD6csUHQ+b1vMOHnkc=
X-Google-Smtp-Source: AGHT+IEi3Qu7s8A5yqq9dadRqq+/DNxO2AVwQ1u94+npiHZDRfNlXaJVAhLSodnyi3Tw6RgQjNl4siYPcAtd7AmA2jQ=
X-Received: by 2002:a17:90a:f195:b0:296:379b:6739 with SMTP id
 bv21-20020a17090af19500b00296379b6739mr1208689pjb.48.1707190755465; Mon, 05
 Feb 2024 19:39:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203165307.7806-1-aford173@gmail.com> <20240203165307.7806-3-aford173@gmail.com>
 <CAA8EJpo4omXogg48urEMzxQ+CA7DNTSf66pA6hoO8wpmtn_-MQ@mail.gmail.com> <20240205081719.z2uqa4dwn5ucsymv@pengutronix.de>
In-Reply-To: <20240205081719.z2uqa4dwn5ucsymv@pengutronix.de>
From: Adam Ford <aford173@gmail.com>
Date: Mon, 5 Feb 2024 21:39:04 -0600
Message-ID: <CAHCN7x+9pLZZhypgVh8Q3jAxeM6UKJrPCOdjVoszK3XLTh=gBQ@mail.gmail.com>
Subject: Re: [PATCH V8 02/12] phy: freescale: add Samsung HDMI PHY
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, devicetree@vger.kernel.org, 
	alexander.stein@ew.tq-group.com, Catalin Marinas <catalin.marinas@arm.com>, 
	dri-devel@lists.freedesktop.org, frieder.schrempf@kontron.de, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, linux-phy@lists.infradead.org, 
	David Airlie <airlied@gmail.com>, marex@denx.de, Robert Foss <rfoss@kernel.org>, 
	Fabio Estevam <festevam@gmail.com>, linux-pm@vger.kernel.org, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Will Deacon <will@kernel.org>, 
	Jonas Karlman <jonas@kwiboo.se>, Liu Ying <victor.liu@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	linux-arm-kernel@lists.infradead.org, 
	Neil Armstrong <neil.armstrong@linaro.org>, linux-kernel@vger.kernel.org, 
	Vinod Koul <vkoul@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Lucas Stach <l.stach@pengutronix.de>, 
	Shawn Guo <shawnguo@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 2:17=E2=80=AFAM Marco Felsch <m.felsch@pengutronix.d=
e> wrote:
>
> On 24-02-04, Dmitry Baryshkov wrote:
> > On Sat, 3 Feb 2024 at 17:53, Adam Ford <aford173@gmail.com> wrote:
> > >
> > > From: Lucas Stach <l.stach@pengutronix.de>
> > >
> > > This adds the driver for the Samsung HDMI PHY found on the
> > > i.MX8MP SoC.
> > >
> > > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > > Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > > ---
> > > V4:  Make lookup table hex values lower case.
> > >
> > > V3:  Re-order the Makefile to keep it alphabetical
> > >      Remove unused defines
> > >
> > > V2:  Fixed some whitespace found from checkpatch
> > >      Change error handling when enabling apbclk to use dev_err_probe
> > >      Rebase on Linux-Next
> > >
> > >      I (Adam) tried to help move this along, so I took Lucas' patch a=
nd
> > >      attempted to apply fixes based on feedback.  I don't have
> > >      all the history, so apologies for that.
> > > ---
> > >  drivers/phy/freescale/Kconfig                |    6 +
> > >  drivers/phy/freescale/Makefile               |    1 +
> > >  drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 1075 ++++++++++++++++=
++
> > >  3 files changed, 1082 insertions(+)
> > >  create mode 100644 drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> > >
> > > diff --git a/drivers/phy/freescale/Kconfig b/drivers/phy/freescale/Kc=
onfig
> > > index 853958fb2c06..5c2b73042dfc 100644
> > > --- a/drivers/phy/freescale/Kconfig
> > > +++ b/drivers/phy/freescale/Kconfig
> > > @@ -35,6 +35,12 @@ config PHY_FSL_IMX8M_PCIE
> > >           Enable this to add support for the PCIE PHY as found on
> > >           i.MX8M family of SOCs.
> > >
> > > +config PHY_FSL_SAMSUNG_HDMI_PHY
> > > +       tristate "Samsung HDMI PHY support"
> > > +       depends on OF && HAS_IOMEM
> > > +       help
> > > +         Enable this to add support for the Samsung HDMI PHY in i.MX=
8MP.
> > > +
> > >  endif
> > >
> > >  config PHY_FSL_LYNX_28G
> > > diff --git a/drivers/phy/freescale/Makefile b/drivers/phy/freescale/M=
akefile
> > > index cedb328bc4d2..79e5f16d3ce8 100644
> > > --- a/drivers/phy/freescale/Makefile
> > > +++ b/drivers/phy/freescale/Makefile
> > > @@ -4,3 +4,4 @@ obj-$(CONFIG_PHY_MIXEL_LVDS_PHY)        +=3D phy-fsl-=
imx8qm-lvds-phy.o
> > >  obj-$(CONFIG_PHY_MIXEL_MIPI_DPHY)      +=3D phy-fsl-imx8-mipi-dphy.o
> > >  obj-$(CONFIG_PHY_FSL_IMX8M_PCIE)       +=3D phy-fsl-imx8m-pcie.o
> > >  obj-$(CONFIG_PHY_FSL_LYNX_28G)         +=3D phy-fsl-lynx-28g.o
> > > +obj-$(CONFIG_PHY_FSL_SAMSUNG_HDMI_PHY)  +=3D phy-fsl-samsung-hdmi.o
> > > diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/p=
hy/freescale/phy-fsl-samsung-hdmi.c
> > > new file mode 100644
> > > index 000000000000..bf0e2299d00f
> > > --- /dev/null
> > > +++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> > > @@ -0,0 +1,1075 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * Copyright 2020 NXP
> > > + * Copyright 2022 Pengutronix, Lucas Stach <kernel@pengutronix.de>
> > > + */
> > > +
> > > +#include <linux/clk-provider.h>
> > > +#include <linux/clk.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/io.h>
> > > +#include <linux/iopoll.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of_device.h>
> > > +#include <linux/of.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/pm_runtime.h>
> > > +
> > > +#define PHY_REG_33             0x84
> > > +#define  REG33_MODE_SET_DONE   BIT(7)
> > > +#define  REG33_FIX_DA          BIT(1)
> > > +
> > > +#define PHY_REG_34             0x88
> > > +#define  REG34_PHY_READY       BIT(7)
> > > +#define  REG34_PLL_LOCK                BIT(6)
> > > +#define  REG34_PHY_CLK_READY   BIT(5)
> > > +
> > > +
> > > +#define PHY_PLL_REGS_NUM 48
> > > +
> > > +struct phy_config {
> > > +       u32     clk_rate;
> > > +       u8 regs[PHY_PLL_REGS_NUM];
> > > +};
> > > +
> > > +const struct phy_config phy_pll_cfg[] =3D {
> > > +       {       22250000, {
> > > +                       0x00, 0xd1, 0x4b, 0xf1, 0x89, 0x88, 0x80, 0x4=
0,
> > > +                       0x4f, 0x30, 0x33, 0x65, 0x00, 0x15, 0x25, 0x8=
0,
> > > +                       0x6c, 0xf2, 0x67, 0x00, 0x10, 0x8f, 0x30, 0x3=
2,
> > > +                       0x60, 0x8f, 0x00, 0x00, 0x08, 0x00, 0x00, 0x0=
0,
> > > +                       0x00, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0=
0,
> > > +                       0x00, 0xe0, 0x83, 0x0f, 0x3e, 0xf8, 0x00, 0x0=
0,
> > > +               },
> > > +       }, {
> > > +               23750000, {
> > > +                       0x00, 0xd1, 0x50, 0xf1, 0x86, 0x85, 0x80, 0x4=
0,
> > > +                       0x4f, 0x30, 0x33, 0x65, 0x00, 0x03, 0x25, 0x8=
0,
> > > +                       0x6c, 0xf2, 0x67, 0x00, 0x10, 0x8f, 0x30, 0x3=
2,
> > > +                       0x60, 0x8f, 0x00, 0x00, 0x08, 0x00, 0x00, 0x0=
0,
> > > +                       0x00, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0=
0,
> > > +                       0x00, 0xe0, 0x83, 0x0f, 0x3e, 0xf8, 0x00, 0x0=
0,
> > > +               },
> >
> > Generally I see that these entries contain a high level of duplication.
> > Could you please extract the common part and a rate-dependent part.
> > Next, it would be best if instead of writing the register values via
> > the rate LUT, the driver could calculate those values.
> > This allows us to support other HDMI modes if the need arises at some p=
oint.
>
> Hi Adam,
>
> can you please have a look at: https://lore.kernel.org/all/4830698.GXAFRq=
VoOG@steina-w/
>
> there we have fixed this already. Not sure which version you picked for
> your work.

It must have been an earlier version.  I got the list from Fabio, but
I might have also gotten it mixed up.  I'll look at this version and
base my series on it and try to address comments others made.  It'll
likely take me a few days to catch up.

thanks for the pointer.

adam
>
> Regards,
>   Marco
>
> >
> > > +       }, {
> > > +               24000000, {
> > > +                       0x00, 0xd1, 0x50, 0xf0, 0x00, 0x00, 0x80, 0x0=
0,
> > > +                       0x4f, 0x30, 0x33, 0x65, 0x00, 0x01, 0x25, 0x8=
0,
> > > +                       0x6c, 0xf2, 0x67, 0x00, 0x10, 0x8f, 0x30, 0x3=
2,
> > > +                       0x60, 0x8f, 0x00, 0x00, 0x08, 0x00, 0x00, 0x0=
0,
> > > +                       0x00, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0=
0,
> > > +                       0x00, 0xe0, 0x83, 0x0f, 0x3e, 0xf8, 0x00, 0x0=
0,
> > > +               },
> >
> >
> > --
> > With best wishes
> > Dmitry
> >
> >

