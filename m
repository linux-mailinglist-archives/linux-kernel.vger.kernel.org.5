Return-Path: <linux-kernel+bounces-41024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D2A83EA32
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 03:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 862B91C21EF3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 02:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63D9BA2B;
	Sat, 27 Jan 2024 02:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkdfDy4e"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3A533EA;
	Sat, 27 Jan 2024 02:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706324221; cv=none; b=G05Afz5cl0Lo4Rakh6vSAUbEv9w/JBAKZYvAUTaJOdUzqsdG5QVjykmGluccp7TP/Hsavachpx72Jzzc7iMRibwwM0eQHp0Tcj/JqRBEo4c4ekNDUnHunXMpcyRFN9ojge1e7PjHEzTe33VLotCnotChDHkQs3uw8TmgnnwEzrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706324221; c=relaxed/simple;
	bh=nv4jbf87zShxyCZ68qQ++LPvHiIlHAI2ut+lzPqW47Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EwqWHovANZVzoF9Fa96E0u5LboJKL6Bm4FfjkEgwZ9UDCpE6iSP2I7Bxz7NBM5RKvfwtFuFrBuL8qsT4AAUBmQvbqtgK3XHAtuAiDnETupwkmdhQhaJp481xFK2xuiED8+n473J3U/VLmKa/k7+ZFqW+2QxqsS0YQKvcEL9UvJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bkdfDy4e; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ddc1b30458so1284752b3a.1;
        Fri, 26 Jan 2024 18:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706324219; x=1706929019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AL25Cgmp65Z4nugzUiRaGUI1/k9OMV61U5cI0oX2Yhc=;
        b=bkdfDy4eMGJR/rQvF7BTXJhJi9inMuYGBtTMbVoLIGMf13xgwLW5TvznoQ9MiHZDSg
         h9Cbg4Kc+HRSrHIqZU2kFf2KuzkI2S28QsUS7dnPL4B9WQ6pVmjRMQjwp4UV2FqJilR6
         8s9lsrr1Ljfx+s72xlFeG/Z/EwAM0TmXLOKPpmARVEHIz1sZMbjKnPNmsucyGKZ5CK70
         nX6a1fwGW7EAxZopGi04bEdT3E4S3qNTULN52578Gd5cCiBWRKpvS4rDIF+spSVBO2X3
         Twn9jEw8dib0HZKHezmg7ckuEaPrAEem6gqsWixsLEMaf/DpG4JfvZaiYAXy33fsacR7
         tXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706324219; x=1706929019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AL25Cgmp65Z4nugzUiRaGUI1/k9OMV61U5cI0oX2Yhc=;
        b=GvLGO6M81REqlbkxOQ8gd2wXv6FxGvNB4VXaeYMygaZqD4mR1IozvlFLBI/k3wQKwQ
         Tw6NuPy74W4wthY6d00HUTWUoKfAyrizpkml6w+gUDBoh3W7xdJBNlglwLbd+v9hyn27
         P9nW8i5pmduXPhgtjNz6mOUvglGLQOCAqOdi6pMDIgY4sInmuPaf73qyRQNcVAf+dTcu
         /iAbPGt4pXI/sr3UmtzFmSDQZm+fZnl4ojGEV0Cw7zA04n0nNzjn7frhRo8rptCWOXPi
         OnHRynYXxqvVwwRGwqfrZI1nIXZ/QqpsWc51d64f6XViY4ZhRTRMbYdps1wvpSMG3Gtb
         I/aA==
X-Gm-Message-State: AOJu0YzfsjIPSLYV/Q9J6oHvzOKNzVuQN3JXFk0bs+M9EQy4DCoiHm87
	LsAdBdIaWRqaXpTg6SU1kfnjendCYZvNyi9bhxzXGSqgw895kCEvbL8mRWBCU8oALly+3lisdob
	THWBDCphZuT2NfzOoqgM+Lu7IIuH/Qpbskmo=
X-Google-Smtp-Source: AGHT+IEF1Zw4IcNrJv2meCpYlZEjakZVYWQiEvWlydUinf+M6VOyFuJ4RxjJJUPz5t8zNR7LHtVIVj8g/ogXTl9F+Ag=
X-Received: by 2002:a05:6a20:7f92:b0:19c:6ec0:33d0 with SMTP id
 d18-20020a056a207f9200b0019c6ec033d0mr972394pzj.37.1706324218699; Fri, 26 Jan
 2024 18:56:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240106221907.325127-1-aford173@gmail.com> <20240106221907.325127-2-aford173@gmail.com>
 <13783659.uLZWGnKmhe@steina-w>
In-Reply-To: <13783659.uLZWGnKmhe@steina-w>
From: Adam Ford <aford173@gmail.com>
Date: Fri, 26 Jan 2024 20:56:47 -0600
Message-ID: <CAHCN7xLJ7fXePrjuXOo4WJovAG1vZm1LjJGJP29aEfPO8oJL+g@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] phy: freescale: add Samsung HDMI PHY
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: dri-devel@lists.freedesktop.org, 
	Kishon Vijay Abraham I <kishon@kernel.org>, devicetree@vger.kernel.org, 
	Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org, 
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	NXP Linux Team <linux-imx@nxp.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 9:03=E2=80=AFAM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Hi Adam,
>
> thanks for pushing this forward.
>
> Am Samstag, 6. Januar 2024, 23:19:05 CET schrieb Adam Ford:
> > From: Lucas Stach <l.stach@pengutronix.de>
> >
> > This adds the driver for the Samsung HDMI PHY found on the
> > i.MX8MP SoC.
> >
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > ---
> > V2:  Fixed some whitespace found from checkpatch
> >      Change error handling when enabling apbclk to use dev_err_probe
> >      Rebase on Linux-Next
> >
> >      I (Adam) tried to help move this along, so I took Lucas' patch and
> >      attempted to apply fixes based on feedback.  I don't have
> >      all the history, so apologies for that.
> >
> > diff --git a/drivers/phy/freescale/Kconfig b/drivers/phy/freescale/Kcon=
fig
> > index 853958fb2c06..5c2b73042dfc 100644
> > --- a/drivers/phy/freescale/Kconfig
> > +++ b/drivers/phy/freescale/Kconfig
> > @@ -35,6 +35,12 @@ config PHY_FSL_IMX8M_PCIE
> >         Enable this to add support for the PCIE PHY as found on
> >         i.MX8M family of SOCs.
> >
> > +config PHY_FSL_SAMSUNG_HDMI_PHY
> > +     tristate "Samsung HDMI PHY support"
> > +     depends on OF && HAS_IOMEM
> > +     help
> > +       Enable this to add support for the Samsung HDMI PHY in i.MX8MP.
> > +
> >  endif
> >
> >  config PHY_FSL_LYNX_28G
> > diff --git a/drivers/phy/freescale/Makefile b/drivers/phy/freescale/Mak=
efile
> > index cedb328bc4d2..dbcafdcc8751 100644
> > --- a/drivers/phy/freescale/Makefile
> > +++ b/drivers/phy/freescale/Makefile
> > @@ -3,4 +3,5 @@ obj-$(CONFIG_PHY_FSL_IMX8MQ_USB)      +=3D phy-fsl-imx8=
mq-usb.o
> >  obj-$(CONFIG_PHY_MIXEL_LVDS_PHY)     +=3D phy-fsl-imx8qm-lvds-phy.o
> >  obj-$(CONFIG_PHY_MIXEL_MIPI_DPHY)    +=3D phy-fsl-imx8-mipi-dphy.o
> >  obj-$(CONFIG_PHY_FSL_IMX8M_PCIE)     +=3D phy-fsl-imx8m-pcie.o
> > +obj-$(CONFIG_PHY_FSL_SAMSUNG_HDMI_PHY)  +=3D phy-fsl-samsung-hdmi.o
> >  obj-$(CONFIG_PHY_FSL_LYNX_28G)               +=3D phy-fsl-lynx-28g.o
>
> I don't know if there was different feedback already. But I would have ad=
ded
> the entry sorted alphabetically, thus after CONFIG_PHY_FSL_LYNX_28G. Same=
 goes,
> for Kconfig as well.

The Makefile is easy to rearrange, but Kconfig is already out of
alphabetical order, and PHY_FSL_SAMSUNG_HDMI_PHY is encapsulated in an
if statement, so it cannot go after PHY_FSL_LYNX_28G.  It is
alphabetical after PHY_FSL_IMX8M.

>
> > diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> > b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c new file mode 100644
> > index 000000000000..54e93ea898f7
> > --- /dev/null
> > +++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> > @@ -0,0 +1,1078 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright 2020 NXP
> > + * Copyright 2022 Pengutronix, Lucas Stach <kernel@pengutronix.de>
> > + */
> > +
> > +#include <linux/clk-provider.h>
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/io.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> > +
> > +#define HDMI_TX_CONTROL0             0x200
> > +#define  HDMI_TX_CONTROL_PHY_PWRDWN  BIT(3)
>
> These defines are unused here.

I can drop these.
>
> > +
> > +#define PHY_REG_33           0x84
> > +#define  REG33_MODE_SET_DONE BIT(7)
> > +#define  REG33_FIX_DA                BIT(1)
> > +
> > +#define PHY_REG_34           0x88
> > +#define  REG34_PHY_READY     BIT(7)
> > +#define  REG34_PLL_LOCK              BIT(6)
> > +#define  REG34_PHY_CLK_READY BIT(5)
> > +
> > +
> > +#define PHY_PLL_REGS_NUM 48
> > +
> > +struct phy_config {
> > +     u32     clk_rate;
> > +     u8 regs[PHY_PLL_REGS_NUM];
>
> Shouldn't reg be aligned along clk_rate?

Why so?  They appear to just be structures where individual parts are
read/written individually.  Looking at another HDMI phy driver, it's
not really any different.

>
> Despite that. Tested on TQMa8MPQL/MBa8MPxL + Full-HD HDMI monitor.
>
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
>

Thanks for testing.

adam
> Best regards,
> Alexander
>
<snip>

>
>
> --
> TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Ge=
rmany
> Amtsgericht M=C3=BCnchen, HRB 105018
> Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan S=
chneider
> http://www.tq-group.com/
>
>

