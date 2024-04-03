Return-Path: <linux-kernel+bounces-128891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 419A389618B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 02:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD4DF1F2A8B8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315BFCA6B;
	Wed,  3 Apr 2024 00:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Js3M7E09"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B3017C8
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 00:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712104612; cv=none; b=FgPpKxmvsUHJ2RyVO6GR6rn0dEzuIshVhKAq0W3qJ+F1ehKgQzWMZFpQerd6/GHfm+glyFPTlXRHxt70qCVflEEAGB3nltdXbkLrZCvIdxMiHakUeZ0T5OcERpE9dzvJbsmwg/6yaMV7AIW+WtPqcRNizOZmSuTBZXpmdWu3Pb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712104612; c=relaxed/simple;
	bh=9o0SYy5CVgwzI8UVqOnxPd3o8m0wfqi4eghSlwDDHjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U/PQ7tjOEbcuds6Fm6byc8qa1evJzI2OLVZQOGTQMle+qzfNU8Mjm7SOkZFpAL0or4Cmw0+OcfryOD71nHq5bIRbt1Mmlvl/r3WmKBfrVPAVRsCbR7Xtrz9A9Y9d4TKc+AN6DyJPF2CZujnp7JOBg1JsjyT2HLUuK3lj2iDgcCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Js3M7E09; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so5422393276.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 17:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712104609; x=1712709409; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NNfAfOqwnizaLfnkW7XQbz4Wiw97ypK4zCmV2dzlDVQ=;
        b=Js3M7E09yzwXKPucP8K+4pGiF4ezNcaOYYS8vjjaM0Bu78LPZYS5DsQpwG904DGt8y
         g3OSBZurcRIE9FXY39bvd/ORFgUnrDfOXl2j/O5FGz13QW9d1qEw0fDGon88Z8wS+0No
         FJ1Cy2ZIvR5m1LsVOeNw5XdqPCFlo1jdhgHRCwjgIFb4Gn9UVSKNBCdwHFUA5OApCz9Q
         gMr9E8I5A5+Z+oYIXrmLLGGj4S1nt91zI8HpzyoGxNsUCltSha1FucjDiMhSo9RReWYB
         fsf1I8Zv5KZ2b8LJcfp/6by7StGt+vNKUp5SXaNTWuVVGXI8sXaOkHphecd2TXlK0L3n
         1ybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712104609; x=1712709409;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NNfAfOqwnizaLfnkW7XQbz4Wiw97ypK4zCmV2dzlDVQ=;
        b=CYX+wePtbjNmBd0lUA6MqESXizrL+Lf/YFMsGRnXYZvrk7PB6IdOQWbGCmQ4N1VYeQ
         gnA2hkv0geqqH7Pfw2NHvx7CNObHeS0qr2Nbz4anDeWIzgYSi3Y7A3r3J1TzsGWSSPgH
         WdgPmu632RT5KTQY6jJ9sCsLpSfiNhv0KDl7FqmVy/SolWig0c6XWtdXpWRIsKXBMHpe
         F4AICqZNtEdpJ7creUho5P0rzj45buyVNYj5BUDS30rfl7+wsdB7U0a0RwhJBnpjA727
         z2mvzr2/BlI/rXFU7xXOnfVe/6+LqnGbcectXpD9BiFauQr/nzDmksKlEuq8o/rScPW9
         /Prg==
X-Forwarded-Encrypted: i=1; AJvYcCVV+1yEUHLvnVh+K237pJc86rEgwW0IhEHlOqaPPIpT8Iz4JqWDMSAfD+TYmYBaaFrMCTDhsm9twOa0G1aMJ0LgkEKBxEhHniFgHcwb
X-Gm-Message-State: AOJu0YwHCJpkyqhqkU+F8wXOhyaLuKeOJuv+KhZYW5bMTgo3A8eu/zaq
	AAXnnPQHjFBXXJvfG25pa3nO0U9yw8Vdqp7aMYp7iyRxe2F8N01RTvr667acNGDCXqoqUCLyvXY
	GEPToOs0zkXZ5e4q8irlD+SdozgXRFvul+IRN8Q==
X-Google-Smtp-Source: AGHT+IHchjPKf5JP8I8RwISTBYNSBIBlEkA1lbeWOcex2zS0dL4ezb19JC5wl5pDL5F0VCZszKDF4RAepSsgurZwmQU=
X-Received: by 2002:a25:ae8a:0:b0:dc7:8c3a:4e42 with SMTP id
 b10-20020a25ae8a000000b00dc78c3a4e42mr12455333ybj.30.1712104608945; Tue, 02
 Apr 2024 17:36:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240330-lg-sw43408-panel-v1-0-f5580fc9f2da@linaro.org>
 <20240330-lg-sw43408-panel-v1-3-f5580fc9f2da@linaro.org> <554zkisebym7gbbom3657ws7kqvyidggfmcvetjm6vrnwts3gl@l53hejt72b5q>
 <CAA8EJpowdjcN8KzGRVLrGx8L8Fi5Drs-C62VZKd5VbmDHsCg+Q@mail.gmail.com>
 <fn3r4ykwxvgf4ujmpevpsrcwmwzpjl5bhcp6ekyebowgf4rpz3@fyxcwjgn6abg>
 <CAA8EJprRHg2KH7H6SPF3yfg8HCT2Fe2Hg-LXU19ak78TkKWwjA@mail.gmail.com> <rdvcvkofafpdovldlibvobsxlk7nt3cc4kysm4aiafux7bmai6@nsqs7ofgr3ol>
In-Reply-To: <rdvcvkofafpdovldlibvobsxlk7nt3cc4kysm4aiafux7bmai6@nsqs7ofgr3ol>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 3 Apr 2024 03:36:37 +0300
Message-ID: <CAA8EJpoV2XuaURyPgyqVu2EZwbUC7xdK5xiHi9aw+q1ktD3=-g@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm: panel: Add LG sw43408 panel driver
To: Marijn Suijten <marijn.suijten@somainline.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, Caleb Connolly <caleb.connolly@linaro.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Vinod Koul <vkoul@kernel.org>, Caleb Connolly <caleb@connolly.tech>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Apr 2024 at 23:57, Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> On 2024-04-01 22:11:48, Dmitry Baryshkov wrote:
> > On Mon, 1 Apr 2024 at 13:29, Marijn Suijten
> > <marijn.suijten@somainline.org> wrote:
> > >
> > > On 2024-03-30 16:37:08, Dmitry Baryshkov wrote:
> > > > On Sat, 30 Mar 2024 at 12:27, Marijn Suijten
> > > > <marijn.suijten@somainline.org> wrote:
> > > > >
> > > > > On 2024-03-30 05:59:30, Dmitry Baryshkov wrote:
> > > > > > From: Sumit Semwal <sumit.semwal@linaro.org>
> > > > > >
> > > > > > LG SW43408 is 1080x2160, 4-lane MIPI-DSI panel, used in some Pixel3
> > > > > > phones.
> > > > > >
> > > > > > Whatever init sequence we have for this panel isn't capable of
> > > > > > initialising it completely, toggling the reset gpio ever causes the
> > > > > > panel to die. Until this is resolved we avoid resetting the panel. The
> > > > >
> > > > > Are you sure it is avoided?  This patch seems to be toggling reset_gpio in
> > > > > sw43408_prepare()?
> > > > >
> > > > > > disable/unprepare functions only put the panel to sleep mode and
> > > > > > disable the backlight.
> > > > > >
> > > > > > Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
> > > > > > [vinod: Add DSC support]
> > > > > > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > > > > > [caleb: cleanup and support turning off the panel]
> > > > > > Signed-off-by: Caleb Connolly <caleb@connolly.tech>
> > > > > > [DB: partially rewrote the driver and fixed DSC programming]
> > > > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > > > ---
> > > > > >  MAINTAINERS                              |   8 +
> > > > > >  drivers/gpu/drm/panel/Kconfig            |  11 ++
> > > > > >  drivers/gpu/drm/panel/Makefile           |   1 +
> > > > > >  drivers/gpu/drm/panel/panel-lg-sw43408.c | 322 +++++++++++++++++++++++++++++++
> > > > > >  4 files changed, 342 insertions(+)
> > > > > >
> > > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > > index 4b511a55101c..f4cf7ee97376 100644
> > > > > > --- a/MAINTAINERS
> > > > > > +++ b/MAINTAINERS
> > > > > > @@ -6755,6 +6755,14 @@ S:     Maintained
> > > > > >  F:   Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml
> > > > > >  F:   drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> > > > > >
> > > > > > +DRM DRIVER FOR LG SW43408 PANELS
> > > > > > +M:   Sumit Semwal <sumit.semwal@linaro.org>
> > > > > > +M:   Caleb Connolly <caleb.connolly@linaro.org>
> > > > > > +S:   Maintained
> > > > > > +T:   git git://anongit.freedesktop.org/drm/drm-misc
> > > > > > +F:   Documentation/devicetree/bindings/display/panel/lg,sw43408.yaml
> > > > > > +F:   drivers/gpu/drm/panel/panel-lg-sw43408.c
> > > > > > +
> > > > > >  DRM DRIVER FOR LOGICVC DISPLAY CONTROLLER
> > > > > >  M:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > > >  S:   Supported
> > > > > > diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> > > > > > index d037b3b8b999..f94c702735cb 100644
> > > > > > --- a/drivers/gpu/drm/panel/Kconfig
> > > > > > +++ b/drivers/gpu/drm/panel/Kconfig
> > > > > > @@ -335,6 +335,17 @@ config DRM_PANEL_LG_LG4573
> > > > > >         Say Y here if you want to enable support for LG4573 RGB panel.
> > > > > >         To compile this driver as a module, choose M here.
> > > > > >
> > > > > > +config DRM_PANEL_LG_SW43408
> > > > > > +     tristate "LG SW43408 panel"
> > > > > > +     depends on OF
> > > > > > +     depends on DRM_MIPI_DSI
> > > > > > +     depends on BACKLIGHT_CLASS_DEVICE
> > > > > > +     help
> > > > > > +       Say Y here if you want to enable support for LG sw43408 panel.
> > > > > > +       The panel has a 1080x2160 resolution and uses
> > > > > > +       24 bit RGB per pixel. It provides a MIPI DSI interface to
> > > > > > +       the host and has a built-in LED backlight.
> > > > > > +
> > > > > >  config DRM_PANEL_MAGNACHIP_D53E6EA8966
> > > > > >       tristate "Magnachip D53E6EA8966 DSI panel"
> > > > > >       depends on OF && SPI
> > > > > > diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
> > > > > > index f156d7fa0bcc..a75687d13caf 100644
> > > > > > --- a/drivers/gpu/drm/panel/Makefile
> > > > > > +++ b/drivers/gpu/drm/panel/Makefile
> > > > > > @@ -34,6 +34,7 @@ obj-$(CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W) += panel-leadtek-ltk050h3146w.o
> > > > > >  obj-$(CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829) += panel-leadtek-ltk500hd1829.o
> > > > > >  obj-$(CONFIG_DRM_PANEL_LG_LB035Q02) += panel-lg-lb035q02.o
> > > > > >  obj-$(CONFIG_DRM_PANEL_LG_LG4573) += panel-lg-lg4573.o
> > > > > > +obj-$(CONFIG_DRM_PANEL_LG_SW43408) += panel-lg-sw43408.o
> > > > > >  obj-$(CONFIG_DRM_PANEL_MAGNACHIP_D53E6EA8966) += panel-magnachip-d53e6ea8966.o
> > > > > >  obj-$(CONFIG_DRM_PANEL_NEC_NL8048HL11) += panel-nec-nl8048hl11.o
> > > > > >  obj-$(CONFIG_DRM_PANEL_NEWVISION_NV3051D) += panel-newvision-nv3051d.o
> > > > > > diff --git a/drivers/gpu/drm/panel/panel-lg-sw43408.c b/drivers/gpu/drm/panel/panel-lg-sw43408.c
> > > > > > new file mode 100644
> > > > > > index 000000000000..365d25e14d54
> > > > > > --- /dev/null
> > > > > > +++ b/drivers/gpu/drm/panel/panel-lg-sw43408.c
> > > > > > @@ -0,0 +1,322 @@
> > > > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > > > +/*
> > > > > > + * Copyright (C) 2019-2024 Linaro Ltd
> > > > > > + * Author: Sumit Semwal <sumit.semwal@linaro.org>
> > > > > > + *    Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > > > + */
> > > > > > +
> > > > > > +#include <linux/backlight.h>
> > > > > > +#include <linux/delay.h>
> > > > > > +#include <linux/gpio/consumer.h>
> > > > > > +#include <linux/module.h>
> > > > > > +#include <linux/of.h>
> > > > > > +#include <linux/regulator/consumer.h>
> > > > > > +
> > > > > > +#include <video/mipi_display.h>
> > > > > > +
> > > > > > +#include <drm/drm_mipi_dsi.h>
> > > > > > +#include <drm/drm_panel.h>
> > > > > > +#include <drm/drm_probe_helper.h>
> > > > > > +#include <drm/display/drm_dsc.h>
> > > > > > +#include <drm/display/drm_dsc_helper.h>
> > > > > > +
> > > > > > +#define NUM_SUPPLIES 2
> > > > > > +
> > > > > > +struct sw43408_panel {
> > > > > > +     struct drm_panel base;
> > > > > > +     struct mipi_dsi_device *link;
> > > > > > +
> > > > > > +     const struct drm_display_mode *mode;
> > > > > > +
> > > > > > +     struct regulator_bulk_data supplies[NUM_SUPPLIES];
> > > > > > +
> > > > > > +     struct gpio_desc *reset_gpio;
> > > > > > +};
> > > > > > +
> > > > > > +static inline struct sw43408_panel *to_panel_info(struct drm_panel *panel)
> > > > > > +{
> > > > > > +     return container_of(panel, struct sw43408_panel, base);
> > > > > > +}
> > > > > > +
> > > > > > +static int sw43408_unprepare(struct drm_panel *panel)
> > > > > > +{
> > > > > > +     struct sw43408_panel *ctx = to_panel_info(panel);
> > > > > > +     int ret;
> > > > > > +
> > > > > > +     ret = mipi_dsi_dcs_set_display_off(ctx->link);
> > > > > > +     if (ret < 0)
> > > > > > +             dev_err(panel->dev, "set_display_off cmd failed ret = %d\n", ret);
> > > > > > +
> > > > > > +     ret = mipi_dsi_dcs_enter_sleep_mode(ctx->link);
> > > > > > +     if (ret < 0)
> > > > > > +             dev_err(panel->dev, "enter_sleep cmd failed ret = %d\n", ret);
> > > > > > +
> > > > > > +     msleep(100);
> > > > > > +
> > > > > > +     gpiod_set_value(ctx->reset_gpio, 1);
> > > > > > +
> > > > > > +     return regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
> > > > > > +}
> > > > > > +
> > > > > > +static int sw43408_program(struct drm_panel *panel)
> > > > > > +{
> > > > > > +     struct sw43408_panel *ctx = to_panel_info(panel);
> > > > > > +     struct drm_dsc_picture_parameter_set pps;
> > > > > > +     u8 dsc_en = 0x11;
> > > > >
> > > > > Yeah, this is completely strange. Bit 0, 0x1, is to enable DSC which is
> > > > > normal. 0x10 however, which is bit 4, selects PPS table 2.  Do you ever set
> > > > > pps_identifier in struct drm_dsc_picture_parameter_set to 2?  Or is the table
> > > > > that you send below bogus and/or not used?  Maybe the Driver IC on the other
> > > > > end of the DSI link has a default PPS table with identifier 2 that works out of
> > > > > the box?
> > > >
> > > > Note, MIPI standard also requires two bytes argument. I suspect that
> > > > LG didn't fully follow the standard here.
> > >
> > > Have you read this command from downstream DTS, or have you tried sending 2
> > > bytes and seen the panel breaking?  The second byte is marked as reserved and
> > > should be equal to 0; if the Driver IC is okay with sending either 1 or 2 bytes
> > > I'd strive to stick with the defined length of 2 bytes for this DCS.
> > >
> > > Have you played around with the PPS table?  What if you change
> > > drm_dsc_picture_paremeter_set::pps_identifier to the second table, will the
> > > panel stop working as expected again?  This could indicate that the PPS that is
> > > sent is incorrect (even though the information in the original DSC config was
> > > enough to set up the DPU and DSI correctly).
> > >
> > > According to the DSI spec it is allowed to have a pre-stored/pre-programmed
> > > PPS table, which could be used here making the current call to
> > > mipi_dsi_picture_parameter_set() useless and "confusing"?
> >
> > Ok, some short summary of my tests.
> >
> > Skipping PPS doesn't work at all, so there is no default.
> >
> > Adding a second zero byte doesn't seem to change anything. Dropping
> > the 0x1 bit ('enable') doesn't seem to change anything.
> >
> > If I send COMPRESSION_MODE before sending the PPS, various combinations work.
> > If I send COMPRESSION_MODE after sending the PPS, the follow combos work:
> >
> > pps_identifier = 0x0, COMPRESSION_MODE = 0x11
> > pps_identifier = 0x1, COMPRESSION_MODE = 0x21
>
> Thanks, this must really be an off-by-one table identifier.  I presume you've
> tested pps_identifier=0x2 with COMPRESSION_MODE=0x31, and that there are only 2
> tables and not 3 or 4?

I was not able to get either pps_identifier = 0x2 or
COMPRESSION_MODE=0x31 to work.

>
> From this we can also assume that sending a new PPS will automatically switch
> the compression mode to the pps_identifier in that PPS, COMPRESSION_MODE doesn't
> seem to affect it when sent too early.

No. Omitting COMPRESSION_MODE packet breaks the display. Actually,
this was one of the issues: we were sending an incorrect packet. So
both are required.

>
> > > > Basically that's the reason why I went for the _raw function instead
> > > > of adding PPS and codec arguments to the existing function.
> > > >
> > > > >
> > > > > > +     mipi_dsi_dcs_write_seq(ctx->link, MIPI_DCS_SET_GAMMA_CURVE, 0x02);
> > > > > > +
> > > > > > +     mipi_dsi_dcs_set_tear_on(ctx->link, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
> > > > > > +
> > > > > > +     mipi_dsi_dcs_write_seq(ctx->link, 0x53, 0x0c, 0x30);
> > > > > > +     mipi_dsi_dcs_write_seq(ctx->link, 0x55, 0x00, 0x70, 0xdf, 0x00, 0x70, 0xdf);
> > > > > > +     mipi_dsi_dcs_write_seq(ctx->link, 0xf7, 0x01, 0x49, 0x0c);
> > > > > > +
> > > > > > +     mipi_dsi_dcs_exit_sleep_mode(ctx->link);
> > > > > > +
> > > > > > +     msleep(135);
> > > > > > +
> > > > > > +     mipi_dsi_compression_mode_raw(ctx->link, &dsc_en, 1);
> > > > >
> > > > > Even though I think we should change this function to describe the known
> > > > > bit layout of command 0x7 per the VESA DSI spec, for now replace 1 with
> > > > > sizeof(dsc_en)?
> > > >
> > > > If dsc_en were an array, it would have been a proper thing. Maybe I
> > > > should change it to the array to remove confusion.
> > >
> > > It should work even with a single byte, just to clarify to readers that the 3rd
> > > argument is the byte-size of the input.
> > >
> > > > > > +     mipi_dsi_dcs_write_seq(ctx->link, 0xb0, 0xac);
> > > > > > +     mipi_dsi_dcs_write_seq(ctx->link, 0xe5,
> > > > > > +                            0x00, 0x3a, 0x00, 0x3a, 0x00, 0x0e, 0x10);
> > > > > > +     mipi_dsi_dcs_write_seq(ctx->link, 0xb5,
> > > > > > +                            0x75, 0x60, 0x2d, 0x5d, 0x80, 0x00, 0x0a, 0x0b,
> > > > > > +                            0x00, 0x05, 0x0b, 0x00, 0x80, 0x0d, 0x0e, 0x40,
> > > > > > +                            0x00, 0x0c, 0x00, 0x16, 0x00, 0xb8, 0x00, 0x80,
> > > > > > +                            0x0d, 0x0e, 0x40, 0x00, 0x0c, 0x00, 0x16, 0x00,
> > > > > > +                            0xb8, 0x00, 0x81, 0x00, 0x03, 0x03, 0x03, 0x01,
> > > > > > +                            0x01);
> > > > > > +     msleep(85);
> > > > > > +     mipi_dsi_dcs_write_seq(ctx->link, 0xcd,
> > > > > > +                            0x00, 0x00, 0x00, 0x19, 0x19, 0x19, 0x19, 0x19,
> > > > > > +                            0x19, 0x19, 0x19, 0x19, 0x19, 0x19, 0x19, 0x19,
> > > > > > +                            0x16, 0x16);
> > > > > > +     mipi_dsi_dcs_write_seq(ctx->link, 0xcb, 0x80, 0x5c, 0x07, 0x03, 0x28);
> > > > > > +     mipi_dsi_dcs_write_seq(ctx->link, 0xc0, 0x02, 0x02, 0x0f);
> > > > > > +     mipi_dsi_dcs_write_seq(ctx->link, 0x55, 0x04, 0x61, 0xdb, 0x04, 0x70, 0xdb);
> > > > > > +     mipi_dsi_dcs_write_seq(ctx->link, 0xb0, 0xca);
> > > > > > +
> > > > > > +     mipi_dsi_dcs_set_display_on(ctx->link);
> > > > >
> > > > > Any specific reason to not have the (un)blanking sequence in the enable/disable
> > > > > callbacks and leaving display configuration in (un)prepare?
> > > >
> > > > We are back to the question on when it's fine to send the commands. I
> > > > think the current agreement is to send everything in the
> > > > prepare/unprepare, because of some strange hosts.
> > >
> > > For my panel drivers I'm sticking with having `post-on` commands (from
> > > downstream) in `enable/disable`, which is typically only `set_display_on`.  In
> > > hopes of proposing a `prepare_atomic()` some time to allow mode selection.
> > >
> > > In a short test on recent -next I am once again allowed to send DSI commands in
> > > both .disable and .unprepare, making both functions a "clean" inverse of .enable
> > > and .prepare respectively.
> >
> > The world isn't limited to the MSM hosts.
>
> If I'm not mistaken this was an ordering issue in the drm_bridge implementation.

No. I think sunxi didn't support sending DSI commands after starting
the video stream.

>
> But you are right that some hosts might not be all too happy with sending
> commands (like unblanking?) after the cmd/video stream started, and before the
> stream stops.  Which, as far as I know, are what .enable and .disable do.  On
> the other hand, I was under the impression that this split mainly existed to do
> all the heavy/required lifting up-front, and only unblank when there's a video
> signal to combat any possible observed corruption?

In the ideal world that would be true. But we are not living in the
ideal world. I still have hopes to get back to the idea of reworling
this part of the DSI framework.

> In the end I'm just curious if there's a specific reason - that I need
> to take into account when resending all my panel patches - to /not/
> use .enable/.disable?

I have bookmarked this email as a main reference for the topic:
https://lore.kernel.org/dri-devel/CAPY8ntBrhYAmsraDqJGuTrSL6VjGXBAMVoN7xweV7E4qZv+v3Q@mail.gmail.com/

>
> - Marijn
>
> > > > > > +     msleep(50);
> > > > > > +
> > > > > > +     ctx->link->mode_flags &= ~MIPI_DSI_MODE_LPM;
> > > > > > +
> > > > > > +     drm_dsc_pps_payload_pack(&pps, ctx->link->dsc);
> > > > > > +     mipi_dsi_picture_parameter_set(ctx->link, &pps);
> > > > >
> > > > > I'm always surprised why this is sent _after_ turning the display on (unblanking
> > > > > it).  Wouldn't that cause unnecessary corruption?
> > > >
> > > > No idea. I followed the dowsntream command sequences here. Most likely
> > > > the panel is not fully on until it receives the full frame to be
> > > > displayed.
> > >
> > > According to the DSI spec a PPS update is allowed to happen every frame, and
> > > (for cmdmode panels) will take effect after the next TE trigger.  Unsure if a TE
> > > event happens before the first frame, otherwise this may start taking effect
> > > on the second frame onwards only.
> > >
> > > If there's no corruption on the first frame there might be a pre-programmed PPS
> > > table in slot 2, supporting the theory above.
> >
> >
> >
> > --
> > With best wishes
> > Dmitry



--
With best wishes
Dmitry

