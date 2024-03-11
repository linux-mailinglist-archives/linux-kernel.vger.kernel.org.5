Return-Path: <linux-kernel+bounces-99243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3338787857E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48D38B23091
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E018482E5;
	Mon, 11 Mar 2024 16:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DFW08AHX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B67344C6A;
	Mon, 11 Mar 2024 16:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710174582; cv=none; b=dXi/2yiGceQCuI6RVmUC481AkhyLXOPpak0noaZzVteHDQryoYy6TR21MDPYYffgbD894TK8KEk6RKoa0BU9TeLBcXuRj79l829Zmd2RXJC8HwQgTc3WZ6333pH1iybuDRkgkIdwVlFwZXUP44sp/bMN05hm6/MrbP3tD8HDi0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710174582; c=relaxed/simple;
	bh=k3yTiSv5S5+7qOf3JHckmtzDEXPnqIwubcE354Gdu1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBk/aybcjWt1brwn4g8x2rhhvSmx75eZ7Ee3VVGd2O4dPmqXF5fj7ij2IZO7YHK9WU9XfdigqOze+jXscRDDzkJqgcFW26nh6IbSdJnEHouiUVo8m1jevg8h+WB0/EVVVvF/qT0rr13CNAF3cxw75AR4oE4fzy3L1nP4CGcAeQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DFW08AHX; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710174580; x=1741710580;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k3yTiSv5S5+7qOf3JHckmtzDEXPnqIwubcE354Gdu1o=;
  b=DFW08AHXtxvqn0lQb7ZWW2oWfIuGt5Y6dSxGGoM/Hw2GNmnC9H3pDTCC
   oRxVJ4NBi4+LlogTGeZYpmUXqSsakRNtHBr8yqaB/cuA3IiGAqFiWS2t4
   NOzg0dNJaXRH/fO2s4GZO/n29KDWnj49qnUpJw+6SuMGJ/OGntSbHuIDn
   0tf+ME16a1ArOihXnhd8Et3BQnu7VSUYoOd32ytGRRrlurhRN/RBAW/XL
   VW4gFkuWYDHSvSQNUySHILbnK1JAJuUUM0kAqaKoffXj6FO7jA9uZ6m39
   KnvrQCtgO2vUx6lMIWL+wGCMPWc+rBBNaSJf+a1JiI1GXRTnDSlCrb6jb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="4701368"
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="4701368"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 09:29:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="42196799"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 09:29:26 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id B8E7911FCAC;
	Mon, 11 Mar 2024 18:29:23 +0200 (EET)
Date: Mon, 11 Mar 2024 16:29:23 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: Umang Jain <umang.jain@ideasonboard.com>, linux-media@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	willl will <will@willwhang.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Hans de Goede <hdegoede@redhat.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Paul Elder <paul.elder@ideasonboard.com>,
	Mehdi Djait <mehdi.djait@bootlin.com>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] media: i2c: Add imx283 camera sensor driver
Message-ID: <Ze8xY1bqTiXzRvKp@kekkonen.localdomain>
References: <20240307214048.858318-1-umang.jain@ideasonboard.com>
 <20240307214048.858318-3-umang.jain@ideasonboard.com>
 <Zeq7HBMqqrw4nSPj@kekkonen.localdomain>
 <171016009901.2924028.16001544322304093037@ping.linuxembedded.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171016009901.2924028.16001544322304093037@ping.linuxembedded.co.uk>

Hi Kieran,

On Mon, Mar 11, 2024 at 12:28:19PM +0000, Kieran Bingham wrote:
> Hi Sakari, Umang,
> 
> I've replied inline below to a couple of points that I was responsible for.
> 
> --
> Kieran
> 
> Quoting Sakari Ailus (2024-03-08 07:15:40)
> > Hi Umang,
> > 
> > On Fri, Mar 08, 2024 at 03:10:43AM +0530, Umang Jain wrote:
> > > From: Kieran Bingham <kieran.bingham@ideasonboard.com>
> > > 
> > > Add a v4l2 subdevice driver for the Sony IMX283 image sensor.
> > > 
> > > The IMX283 is a 20MP Diagonal 15.86 mm (Type 1) CMOS Image Sensor with
> > > Square Pixel for Color Cameras.
> > > 
> > > The following features are supported:
> > > - Manual exposure an gain control support
> > > - vblank/hblank/link freq control support
> > > - Test pattern support control
> > > - Arbitrary horizontal and vertical cropping
> > > - Supported resolution:
> > >   - 5472x3648 @ 20fps (SRGGB12)
> > >   - 5472x3648 @ 25fps (SRGGB10)
> > >   - 2736x1824 @ 50fps (SRGGB12)
> > > 
> > > Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> > > Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> > > ---
> > >  MAINTAINERS                |    1 +
> > >  drivers/media/i2c/Kconfig  |   10 +
> > >  drivers/media/i2c/Makefile |    1 +
> > >  drivers/media/i2c/imx283.c | 1573 ++++++++++++++++++++++++++++++++++++
> > >  4 files changed, 1585 insertions(+)
> > >  create mode 100644 drivers/media/i2c/imx283.c
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 32f790c3a5f9..8169f0e41293 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -20375,6 +20375,7 @@ L:    linux-media@vger.kernel.org
> > >  S:   Maintained
> > >  T:   git git://linuxtv.org/media_tree.git
> > >  F:   Documentation/devicetree/bindings/media/i2c/sony,imx283.yaml
> > > +F:   drivers/media/i2c/imx283.c
> > >  
> > >  SONY IMX290 SENSOR DRIVER
> > >  M:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
> > > index 4c3435921f19..2090b06b1827 100644
> > > --- a/drivers/media/i2c/Kconfig
> > > +++ b/drivers/media/i2c/Kconfig
> > > @@ -153,6 +153,16 @@ config VIDEO_IMX274
> > >         This is a V4L2 sensor driver for the Sony IMX274
> > >         CMOS image sensor.
> > >  
> > > +config VIDEO_IMX283
> > > +     tristate "Sony IMX283 sensor support"
> > > +     select V4L2_CCI_I2C
> > > +     help
> > > +       This is a V4L2 sensor driver for the Sony IMX283
> > > +       CMOS image sensor.
> > > +
> > > +       To compile this driver as a module, choose M here: the
> > > +       module will be called imx283.
> > > +
> > >  config VIDEO_IMX290
> > >       tristate "Sony IMX290 sensor support"
> > >       select REGMAP_I2C
> > > diff --git a/drivers/media/i2c/Makefile b/drivers/media/i2c/Makefile
> > > index dfbe6448b549..0fbd81f9f420 100644
> > > --- a/drivers/media/i2c/Makefile
> > > +++ b/drivers/media/i2c/Makefile
> > > @@ -48,6 +48,7 @@ obj-$(CONFIG_VIDEO_IMX214) += imx214.o
> > >  obj-$(CONFIG_VIDEO_IMX219) += imx219.o
> > >  obj-$(CONFIG_VIDEO_IMX258) += imx258.o
> > >  obj-$(CONFIG_VIDEO_IMX274) += imx274.o
> > > +obj-$(CONFIG_VIDEO_IMX283) += imx283.o
> > >  obj-$(CONFIG_VIDEO_IMX290) += imx290.o
> > >  obj-$(CONFIG_VIDEO_IMX296) += imx296.o
> > >  obj-$(CONFIG_VIDEO_IMX319) += imx319.o
> > > diff --git a/drivers/media/i2c/imx283.c b/drivers/media/i2c/imx283.c
> > > new file mode 100644
> > > index 000000000000..bdedcb73148d
> > > --- /dev/null
> > > +++ b/drivers/media/i2c/imx283.c
> > > @@ -0,0 +1,1573 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * V4L2 Support for the IMX283
> > > + *
> > > + * Diagonal 15.86 mm (Type 1) CMOS Image Sensor with Square Pixel for Color
> > > + * Cameras.
> > > + *
> > > + * Copyright (C) 2024 Ideas on Board Oy.
> > > + *
> > > + * Based on Sony IMX283 driver prepared by Will Whang
> > > + *
> > > + * Based on Sony imx477 camera driver
> > > + * Copyright (C) 2019-2020 Raspberry Pi (Trading) Ltd
> > > + */
> > > +
> > > +#include <linux/clk.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/gpio/consumer.h>
> > > +#include <linux/i2c.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of.h>
> > > +#include <linux/pm_runtime.h>
> > > +#include <linux/regulator/consumer.h>
> > > +#include <linux/units.h>
> > > +#include <media/v4l2-cci.h>
> > > +#include <media/v4l2-ctrls.h>
> > > +#include <media/v4l2-device.h>
> > > +#include <media/v4l2-event.h>
> > > +#include <media/v4l2-fwnode.h>
> > > +#include <media/v4l2-mediabus.h>
> > > +
> > > +/* Chip ID */
> > > +#define IMX283_REG_CHIP_ID           CCI_REG8(0x3000)
> > > +#define IMX283_CHIP_ID                       0x0b    // Default power on state
> > > +
> > > +#define IMX283_REG_STANDBY           CCI_REG8(0x3000)
> > > +#define   IMX283_ACTIVE                      0
> > > +#define   IMX283_STANDBY             BIT(0)
> > > +#define   IMX283_STBLOGIC            BIT(1)
> > > +#define   IMX283_STBMIPI             BIT(2)
> > > +#define   IMX283_STBDV                       BIT(3)
> > > +#define   IMX283_SLEEP                       BIT(4)
> > > +
> > > +#define IMX283_REG_CLAMP             CCI_REG8(0x3001)
> > > +#define   IMX283_CLPSQRST            BIT(4)
> > > +
> > > +#define IMX283_REG_PLSTMG08          CCI_REG8(0x3003)
> > > +#define   IMX283_PLSTMG08_VAL                0x77
> > > +
> > > +#define IMX283_REG_MDSEL1            CCI_REG8(0x3004)
> > > +#define IMX283_REG_MDSEL2            CCI_REG8(0x3005)
> > > +#define IMX283_REG_MDSEL3            CCI_REG8(0x3006)
> > > +#define   IMX283_MDSEL3_VCROP_EN     BIT(5)
> > > +#define IMX283_REG_MDSEL4            CCI_REG8(0x3007)
> > > +#define   IMX283_MDSEL4_VCROP_EN     (BIT(4) | BIT(6))
> > > +
> > > +#define IMX283_REG_SVR                       CCI_REG16_LE(0x3009)
> > > +
> > > +#define IMX283_REG_HTRIMMING         CCI_REG8(0x300b)
> > > +#define   IMX283_MDVREV                      BIT(0) /* VFLIP */
> > > +#define   IMX283_HTRIMMING_EN                BIT(4)
> > > +
> > > +#define IMX283_REG_VWINPOS           CCI_REG16_LE(0x300f)
> > > +#define IMX283_REG_VWIDCUT           CCI_REG16_LE(0x3011)
> > > +
> > > +#define IMX283_REG_MDSEL7            CCI_REG16_LE(0x3013)
> > > +
> > > +/* CSI Clock Configuration */
> > > +#define IMX283_REG_TCLKPOST          CCI_REG8(0x3018)
> > > +#define IMX283_REG_THSPREPARE                CCI_REG8(0x301a)
> > > +#define IMX283_REG_THSZERO           CCI_REG8(0x301c)
> > > +#define IMX283_REG_THSTRAIL          CCI_REG8(0x301e)
> > > +#define IMX283_REG_TCLKTRAIL         CCI_REG8(0x3020)
> > > +#define IMX283_REG_TCLKPREPARE               CCI_REG8(0x3022)
> > > +#define IMX283_REG_TCLKZERO          CCI_REG16_LE(0x3024)
> > > +#define IMX283_REG_TLPX                      CCI_REG8(0x3026)
> > > +#define IMX283_REG_THSEXIT           CCI_REG8(0x3028)
> > > +#define IMX283_REG_TCLKPRE           CCI_REG8(0x302a)
> > > +#define IMX283_REG_SYSMODE           CCI_REG8(0x3104)
> > > +
> > > +#define IMX283_REG_Y_OUT_SIZE                CCI_REG16_LE(0x302f)
> > > +#define IMX283_REG_WRITE_VSIZE               CCI_REG16_LE(0x3031)
> > > +#define IMX283_REG_OB_SIZE_V         CCI_REG8(0x3033)
> > > +
> > > +/* HMAX internal HBLANK */
> > > +#define IMX283_REG_HMAX                      CCI_REG16_LE(0x3036)
> > > +#define IMX283_HMAX_MAX                      0xffff
> > > +
> > > +/* VMAX internal VBLANK */
> > > +#define IMX283_REG_VMAX                      CCI_REG24_LE(0x3038)
> > > +#define   IMX283_VMAX_MAX            0xfffff
> > > +
> > > +/* SHR internal */
> > > +#define IMX283_REG_SHR                       CCI_REG16_LE(0x303b)
> > > +#define   IMX283_SHR_MIN             11
> > > +
> > > +/*
> > > + * Analog gain control
> > > + *  Gain [dB] = -20log{(2048 - value [10:0]) /2048}
> > > + *  Range: 0dB to approximately +27dB
> > > + */
> > > +#define IMX283_REG_ANALOG_GAIN               CCI_REG16_LE(0x3042)
> > > +#define   IMX283_ANA_GAIN_MIN                0
> > > +#define   IMX283_ANA_GAIN_MAX                1957
> > > +#define   IMX283_ANA_GAIN_STEP               1
> > > +#define   IMX283_ANA_GAIN_DEFAULT    0x0
> > > +
> > > +/*
> > > + * Digital gain control
> > > + *  Gain [dB] = value * 6
> > > + *  Range: 0dB to +18db
> > > + */
> > > +#define IMX283_REG_DIGITAL_GAIN              CCI_REG8(0x3044)
> > > +#define IMX283_DGTL_GAIN_MIN         0
> > > +#define IMX283_DGTL_GAIN_MAX         3
> > > +#define IMX283_DGTL_GAIN_DEFAULT     0
> > > +#define IMX283_DGTL_GAIN_STEP                1
> > > +
> > > +#define IMX283_REG_HTRIMMING_START   CCI_REG16_LE(0x3058)
> > > +#define IMX283_REG_HTRIMMING_END     CCI_REG16_LE(0x305a)
> > > +
> > > +#define IMX283_REG_MDSEL18           CCI_REG16_LE(0x30f6)
> > > +
> > > +/* Master Mode Operation Control */
> > > +#define IMX283_REG_XMSTA             CCI_REG8(0x3105)
> > > +#define   IMX283_XMSTA                       BIT(0)
> > > +
> > > +#define IMX283_REG_SYNCDRV           CCI_REG8(0x3107)
> > > +#define   IMX283_SYNCDRV_XHS_XVS     (0xa0 | 0x02)
> > > +#define   IMX283_SYNCDRV_HIZ         (0xa0 | 0x03)
> > > +
> > > +/* PLL Standby */
> > > +#define IMX283_REG_STBPL             CCI_REG8(0x320b)
> > > +#define  IMX283_STBPL_NORMAL         0x00
> > > +#define  IMX283_STBPL_STANDBY                0x03
> > > +
> > > +/* Input Frequency Setting */
> > > +#define IMX283_REG_PLRD1             CCI_REG8(0x36c1)
> > > +#define IMX283_REG_PLRD2             CCI_REG16_LE(0x36c2)
> > > +#define IMX283_REG_PLRD3             CCI_REG8(0x36f7)
> > > +#define IMX283_REG_PLRD4             CCI_REG8(0x36f8)
> > > +
> > > +#define IMX283_REG_PLSTMG02          CCI_REG8(0x36aa)
> > > +#define   IMX283_PLSTMG02_VAL                0x00
> > > +
> > > +#define IMX283_REG_EBD_X_OUT_SIZE    CCI_REG16_LE(0x3a54)
> > > +
> > > +/* Test pattern generator */
> > > +#define IMX283_REG_TPG_CTRL          CCI_REG8(0x3156)
> > > +#define   IMX283_TPG_CTRL_CLKEN              BIT(0)
> > > +#define   IMX283_TPG_CTRL_PATEN              BIT(4)
> > > +
> > > +#define IMX283_REG_TPG_PAT           CCI_REG8(0x3157)
> > > +#define   IMX283_TPG_PAT_ALL_000     0x00
> > > +#define   IMX283_TPG_PAT_ALL_FFF     0x01
> > > +#define   IMX283_TPG_PAT_ALL_555     0x02
> > > +#define   IMX283_TPG_PAT_ALL_AAA     0x03
> > > +#define   IMX283_TPG_PAT_H_COLOR_BARS        0x0a
> > > +#define   IMX283_TPG_PAT_V_COLOR_BARS        0x0b
> > > +
> > > +/* Exposure control */
> > > +#define IMX283_EXPOSURE_MIN          52
> > > +#define IMX283_EXPOSURE_STEP         1
> > > +#define IMX283_EXPOSURE_DEFAULT              1000
> > > +#define IMX283_EXPOSURE_MAX          49865
> > > +
> > > +#define IMAGE_PAD                    0
> > > +
> > > +#define IMX283_XCLR_MIN_DELAY_US     1000
> > > +#define IMX283_XCLR_DELAY_RANGE_US   1000
> > > +
> > > +/* IMX283 native and active pixel array size. */
> > > +static const struct v4l2_rect imx283_native_area = {
> > > +     .top = 0,
> > > +     .left = 0,
> > > +     .width = 5592,
> > > +     .height = 3710,
> > > +};
> > > +
> > > +static const struct v4l2_rect imx283_active_area = {
> > > +     .top = 40,
> > > +     .left = 108,
> > > +     .width = 5472,
> > > +     .height = 3648,
> > > +};
> > > +
> > > +struct imx283_reg_list {
> > > +     unsigned int num_of_regs;
> > > +     const struct cci_reg_sequence *regs;
> > > +};
> > > +
> > > +/* Mode : resolution and related config values */
> > > +struct imx283_mode {
> > > +     unsigned int mode;
> > > +
> > > +     /* Bits per pixel */
> > > +     unsigned int bpp;
> > > +
> > > +     /* Frame width */
> > > +     unsigned int width;
> > > +
> > > +     /* Frame height */
> > > +     unsigned int height;
> > > +
> > > +     /*
> > > +      * Minimum horizontal timing in pixel-units
> > > +      *
> > > +      * Note that HMAX is written in 72MHz units, and the datasheet assumes a
> > > +      * 720MHz link frequency. Convert datasheet values with the following:
> > > +      *
> > > +      * For 12 bpp modes (480Mbps) convert with:
> > > +      *   hmax = [hmax in 72MHz units] * 480 / 72
> > > +      *
> > > +      * For 10 bpp modes (576Mbps) convert with:
> > > +      *   hmax = [hmax in 72MHz units] * 576 / 72
> > > +      */
> > > +     u32 min_hmax;
> > > +
> > > +     /* minimum V-timing in lines */
> > > +     u32 min_vmax;
> > > +
> > > +     /* default H-timing */
> > > +     u32 default_hmax;
> > > +
> > > +     /* default V-timing */
> > > +     u32 default_vmax;
> > > +
> > > +     /* minimum SHR */
> > > +     u32 min_shr;
> > > +
> > > +     /*
> > > +      * Per-mode vertical crop constants used to calculate values
> > > +      * of IMX283REG_WIDCUT and IMX283_REG_VWINPOS.
> > > +      */
> > > +     u32 veff;
> > > +     u32 vst;
> > > +     u32 vct;
> > > +
> > > +     /* Horizontal and vertical binning ratio */
> > > +     u8 hbin_ratio;
> > > +     u8 vbin_ratio;
> > > +
> > > +     /* Optical Blanking */
> > > +     u32 horizontal_ob;
> > > +     u32 vertical_ob;
> > > +
> > > +     /* Analog crop rectangle. */
> > > +     struct v4l2_rect crop;
> > > +};
> > > +
> > > +struct imx283_input_frequency {
> > > +     unsigned int mhz;
> > > +     unsigned int reg_count;
> > > +     struct cci_reg_sequence regs[4];
> > > +};
> > > +
> > > +static const struct imx283_input_frequency imx283_frequencies[] = {
> > > +     {
> > > +             .mhz = 6 * MEGA,
> > > +             .reg_count = 4,
> > > +             .regs = {
> > > +                     { IMX283_REG_PLRD1, 0x00 },
> > > +                     { IMX283_REG_PLRD2, 0x00f0 },
> > > +                     { IMX283_REG_PLRD3, 0x00 },
> > > +                     { IMX283_REG_PLRD4, 0xc0 },
> > > +             },
> > > +     },
> > > +     {
> > > +             .mhz = 12 * MEGA,
> > > +             .reg_count = 4,
> > > +             .regs = {
> > > +                     { IMX283_REG_PLRD1, 0x01 },
> > > +                     { IMX283_REG_PLRD2, 0x00f0 },
> > > +                     { IMX283_REG_PLRD3, 0x01 },
> > > +                     { IMX283_REG_PLRD4, 0xc0 },
> > > +             },
> > > +     },
> > > +     {
> > > +             .mhz = 18 * MEGA,
> > > +             .reg_count = 4,
> > > +             .regs = {
> > > +                     { IMX283_REG_PLRD1, 0x01 },
> > > +                     { IMX283_REG_PLRD2, 0x00a0 },
> > > +                     { IMX283_REG_PLRD3, 0x01 },
> > > +                     { IMX283_REG_PLRD4, 0x80 },
> > > +             },
> > > +     },
> > > +     {
> > > +             .mhz = 24 * MEGA,
> > > +             .reg_count = 4,
> > > +             .regs = {
> > > +                     { IMX283_REG_PLRD1, 0x02 },
> > > +                     { IMX283_REG_PLRD2, 0x00f0 },
> > > +                     { IMX283_REG_PLRD3, 0x02 },
> > > +                     { IMX283_REG_PLRD4, 0xc0 },
> > > +             },
> > > +     },
> > > +};
> > > +
> > > +enum imx283_modes {
> > > +     IMX283_MODE_0,
> > > +     IMX283_MODE_1,
> > > +     IMX283_MODE_1A,
> > > +     IMX283_MODE_1S,
> > > +     IMX283_MODE_2,
> > > +     IMX283_MODE_2A,
> > > +     IMX283_MODE_3,
> > > +     IMX283_MODE_4,
> > > +     IMX283_MODE_5,
> > > +     IMX283_MODE_6,
> > > +};
> > > +
> > > +struct imx283_readout_mode {
> > > +     u64 mdsel1;
> > > +     u64 mdsel2;
> > > +     u64 mdsel3;
> > > +     u64 mdsel4;
> > > +};
> > 
> > What's the reasoning for using u64 here? These seem to be 8-bit values (and
> > registers).
> 
> I don't really remember my reasoning there, but whatever it was may not
> still hold up to scrutiny ;-) Perhaps it was about how the CCI writes
> were being handled.
> 
> But indeed 4 u8 values are likely sufficient here.

I think so, too. :-)

> 
> > 
> > > +
> > > +static const struct imx283_readout_mode imx283_readout_modes[] = {
> > > +     /* All pixel scan modes */
> > > +     [IMX283_MODE_0] = { 0x04, 0x03, 0x10, 0x00 }, /* 12 bit */
> > > +     [IMX283_MODE_1] = { 0x04, 0x01, 0x00, 0x00 }, /* 10 bit */
> > > +     [IMX283_MODE_1A] = { 0x04, 0x01, 0x20, 0x50 }, /* 10 bit */
> > > +     [IMX283_MODE_1S] = { 0x04, 0x41, 0x20, 0x50 }, /* 10 bit */
> > > +
> > > +     /* Horizontal / Vertical 2/2-line binning */
> > > +     [IMX283_MODE_2] = { 0x0d, 0x11, 0x50, 0x00 }, /* 12 bit */
> > > +     [IMX283_MODE_2A] = { 0x0d, 0x11, 0x70, 0x50 }, /* 12 bit */
> > > +
> > > +     /* Horizontal / Vertical 3/3-line binning */
> > > +     [IMX283_MODE_3] = { 0x1e, 0x18, 0x10, 0x00 }, /* 12 bit */
> > > +
> > > +     /* Veritcal 2/9 subsampling, horizontal 3 binning cropping */
> > > +     [IMX283_MODE_4] = { 0x29, 0x18, 0x30, 0x50 }, /* 12 bit */
> > > +
> > > +     /* Vertical 2/19 subsampling binning, horizontal 3 binning */
> > > +     [IMX283_MODE_5] = { 0x2d, 0x18, 0x10, 0x00 }, /* 12 bit */
> > > +
> > > +     /* Vertical 2 binning horizontal 2/4, subsampling 16:9 cropping */
> > > +     [IMX283_MODE_6] = { 0x18, 0x21, 0x00, 0x09 }, /* 10 bit */
> > > +};
> > > +
> > > +static const struct cci_reg_sequence mipi_data_rate_1440Mbps[] = {
> > > +     /* The default register settings provide the 1440Mbps rate */
> > > +     { CCI_REG8(0x36c5), 0x00 }, /* Undocumented */
> > > +     { CCI_REG8(0x3ac4), 0x00 }, /* Undocumented */
> > > +
> > > +     { IMX283_REG_STBPL, 0x00 },
> > > +     { IMX283_REG_TCLKPOST, 0xa7 },
> > > +     { IMX283_REG_THSPREPARE, 0x6f },
> > > +     { IMX283_REG_THSZERO, 0x9f },
> > > +     { IMX283_REG_THSTRAIL, 0x5f },
> > > +     { IMX283_REG_TCLKTRAIL, 0x5f },
> > > +     { IMX283_REG_TCLKPREPARE, 0x6f },
> > > +     { IMX283_REG_TCLKZERO, 0x017f },
> > > +     { IMX283_REG_TLPX, 0x4f },
> > > +     { IMX283_REG_THSEXIT, 0x47 },
> > > +     { IMX283_REG_TCLKPRE, 0x07 },
> > > +     { IMX283_REG_SYSMODE, 0x02 },
> > > +};
> > > +
> > > +static const struct cci_reg_sequence mipi_data_rate_720Mbps[] = {
> > > +     /* Undocumented Additions "For 720MBps" Setting */
> > > +     { CCI_REG8(0x36c5), 0x01 }, /* Undocumented */
> > > +     { CCI_REG8(0x3ac4), 0x01 }, /* Undocumented */
> > > +
> > > +     { IMX283_REG_STBPL, 0x00 },
> > > +     { IMX283_REG_TCLKPOST, 0x77 },
> > > +     { IMX283_REG_THSPREPARE, 0x37 },
> > > +     { IMX283_REG_THSZERO, 0x67 },
> > > +     { IMX283_REG_THSTRAIL, 0x37 },
> > > +     { IMX283_REG_TCLKTRAIL, 0x37 },
> > > +     { IMX283_REG_TCLKPREPARE, 0x37 },
> > > +     { IMX283_REG_TCLKZERO, 0xdf },
> > > +     { IMX283_REG_TLPX, 0x2f },
> > > +     { IMX283_REG_THSEXIT, 0x47 },
> > > +     { IMX283_REG_TCLKPRE, 0x0f },
> > > +     { IMX283_REG_SYSMODE, 0x02 },
> > > +};
> > > +
> > > +static const s64 link_frequencies[] = {
> > > +     720 * MEGA, /* 1440 Mbps lane data rate */
> > > +     360 * MEGA, /* 720 Mbps data lane rate */
> > > +};
> > > +
> > > +static const struct imx283_reg_list link_freq_reglist[] = {
> > > +     { /* 720 MHz */
> > > +             .num_of_regs = ARRAY_SIZE(mipi_data_rate_1440Mbps),
> > > +             .regs = mipi_data_rate_1440Mbps,
> > > +     },
> > > +     { /* 360 MHz */
> > > +             .num_of_regs = ARRAY_SIZE(mipi_data_rate_720Mbps),
> > > +             .regs = mipi_data_rate_720Mbps,
> > > +     },
> > > +};
> > > +
> > > +#define CENTERED_RECTANGLE(rect, _width, _height)                    \
> > > +     {                                                               \
> > > +             .left = rect.left + ((rect.width - (_width)) / 2),      \
> > > +             .top = rect.top + ((rect.height - (_height)) / 2),      \
> > > +             .width = (_width),                                      \
> > > +             .height = (_height),                                    \
> > > +     }
> > > +
> > > +/* Mode configs */
> > > +static const struct imx283_mode supported_modes_12bit[] = {
> > > +     {
> > > +             /* 20MPix 21.40 fps readout mode 0 */
> > > +             .mode = IMX283_MODE_0,
> > > +             .bpp = 12,
> > > +             .width = 5472,
> > > +             .height = 3648,
> > > +             .min_hmax = 5914, /* 887 @ 480MHz/72MHz */
> > > +             .min_vmax = 3793, /* Lines */
> > > +
> > > +             .veff = 3694,
> > > +             .vst = 0,
> > > +             .vct = 0,
> > > +
> > > +             .hbin_ratio = 1,
> > > +             .vbin_ratio = 1,
> > > +
> > > +             /* 20.00 FPS */
> > > +             .default_hmax = 6000, /* 900 @ 480MHz/72MHz */
> > > +             .default_vmax = 4000,
> > > +
> > > +             .min_shr = 11,
> > > +             .horizontal_ob = 96,
> > > +             .vertical_ob = 16,
> > > +             .crop = CENTERED_RECTANGLE(imx283_active_area, 5472, 3648),
> > > +     },
> > > +     {
> > > +             /*
> > > +              * Readout mode 2 : 2/2 binned mode (2736x1824)
> > > +              */
> > > +             .mode = IMX283_MODE_2,
> > > +             .bpp = 12,
> > > +             .width = 2736,
> > > +             .height = 1824,
> > > +             .min_hmax = 1870, /* Pixels (362 * 360/72 + padding) */
> > > +             .min_vmax = 3840, /* Lines */
> > > +
> > > +             /* 50.00 FPS */
> > > +             .default_hmax = 1870, /* 362 @ 360MHz/72MHz */
> > > +             .default_vmax = 3960,
> > > +
> > > +             .veff = 1824,
> > > +             .vst = 0,
> > > +             .vct = 0,
> > > +
> > > +             .hbin_ratio = 2,
> > > +             .vbin_ratio = 2,
> > > +
> > > +             .min_shr = 12,
> > > +             .horizontal_ob = 48,
> > > +             .vertical_ob = 4,
> > > +
> > > +             .crop = CENTERED_RECTANGLE(imx283_active_area, 5472, 3648),
> > > +     },
> > > +};
> > > +
> > > +static const struct imx283_mode supported_modes_10bit[] = {
> > > +     {
> > > +             /* 20MPix 25.48 fps readout mode 1 */
> > > +             .mode = IMX283_MODE_1,
> > > +             .bpp = 10,
> > > +             .width = 5472,
> > > +             .height = 3648,
> > > +             .min_hmax = 5960, /* 745 @ 576MHz / 72MHz */
> > > +             .min_vmax = 3793,
> > > +
> > > +             /* 25.00 FPS */
> > > +             .default_hmax = 1500, /* 750 @ 576MHz / 72MHz */
> > > +             .default_vmax = 3840,
> > > +
> > > +             .min_shr = 10,
> > > +             .horizontal_ob = 96,
> > > +             .vertical_ob = 16,
> > > +             .crop = CENTERED_RECTANGLE(imx283_active_area, 5472, 3648),
> > > +     },
> > > +};
> > > +
> > > +static const u32 imx283_mbus_codes[] = {
> > > +     MEDIA_BUS_FMT_SRGGB12_1X12,
> > > +     MEDIA_BUS_FMT_SRGGB10_1X10,
> > > +};
> > > +
> > > +/* regulator supplies */
> > > +static const char *const imx283_supply_name[] = {
> > > +     "vadd", /* Analog (2.9V) supply */
> > > +     "vdd1", /* Supply Voltage 2 (1.8V) supply */
> > > +     "vdd2", /* Supply Voltage 3 (1.2V) supply */
> > > +};
> > > +
> > 
> > Extra newline.
> > 
> > > +
> > > +struct imx283 {
> > > +     struct device *dev;
> > > +     struct regmap *cci;
> > > +
> > > +     const struct imx283_input_frequency *freq;
> > > +
> > > +     struct v4l2_subdev sd;
> > > +     struct media_pad pad;
> > > +
> > > +     struct clk *xclk;
> > > +
> > > +     struct gpio_desc *reset_gpio;
> > > +     struct regulator_bulk_data supplies[ARRAY_SIZE(imx283_supply_name)];
> > > +
> > > +     /* V4L2 Controls */
> > > +     struct v4l2_ctrl_handler ctrl_handler;
> > > +     struct v4l2_ctrl *exposure;
> > > +     struct v4l2_ctrl *vblank;
> > > +     struct v4l2_ctrl *hblank;
> > > +     struct v4l2_ctrl *vflip;
> > > +
> > > +     unsigned long link_freq_bitmap;
> > > +
> > > +     u16 hmax;
> > > +     u32 vmax;
> > > +};
> > > +
> > > +static inline struct imx283 *to_imx283(struct v4l2_subdev *_sd)
> > > +{
> > > +     return container_of(_sd, struct imx283, sd);
> > 
> > It's a function, you can call _sd sd instead.
> 
> Except then that could 'look' like it is passed as the first and third
> argument to container_of...

It's really a non-issue: the third argument is a field name, not a
variable.

> 
> But if it's fine / accepted otherwise then sure.

And please use container_of_const(). :)

> > 
> > > +}
> > > +
> > > +static inline void get_mode_table(unsigned int code,
> > > +                               const struct imx283_mode **mode_list,
> > > +                               unsigned int *num_modes)
> > > +{
> > > +     switch (code) {
> > > +     case MEDIA_BUS_FMT_SRGGB12_1X12:
> > > +     case MEDIA_BUS_FMT_SGRBG12_1X12:
> > > +     case MEDIA_BUS_FMT_SGBRG12_1X12:
> > > +     case MEDIA_BUS_FMT_SBGGR12_1X12:
> > > +             *mode_list = supported_modes_12bit;
> > > +             *num_modes = ARRAY_SIZE(supported_modes_12bit);
> > > +             break;
> > > +
> > > +     case MEDIA_BUS_FMT_SRGGB10_1X10:
> > > +     case MEDIA_BUS_FMT_SGRBG10_1X10:
> > > +     case MEDIA_BUS_FMT_SGBRG10_1X10:
> > > +     case MEDIA_BUS_FMT_SBGGR10_1X10:
> > > +             *mode_list = supported_modes_10bit;
> > > +             *num_modes = ARRAY_SIZE(supported_modes_10bit);
> > > +             break;
> > > +     default:
> > > +             *mode_list = NULL;
> > > +             *num_modes = 0;
> > > +     }
> > > +}
> > > +
> > > +/* Calculate the Pixel Rate based on the current mode */
> > > +static u64 imx283_pixel_rate(struct imx283 *imx283,
> > > +                          const struct imx283_mode *mode)
> > > +{
> > > +     unsigned int bpp = mode->bpp;
> > > +
> > 
> > Extra newline.
> > 
> > > +     const unsigned int ddr = 2; /* Double Data Rate */
> > > +     const unsigned int lanes = 4; /* Only 4 lane support */
> > > +     u64 link_frequency = link_frequencies[__ffs(imx283->link_freq_bitmap)];
> > > +
> > > +     return link_frequency * ddr * lanes / bpp;
> > > +}
> > > +
> > > +/* Convert from a variable pixel_rate to 72 MHz clock cycles */
> > > +static u64 imx283_internal_clock(unsigned int pixel_rate, unsigned int pixels)
> > > +{
> > > +     /*
> > > +      * Determine the following operation without overflow:
> > > +      *    pixels = 72 * MEGA / pixel_rate
> > > +      *
> > > +      * The internal clock at 72MHz and Pixel Rate (between 240 and 576MHz)
> > > +      * can easily overflow this calculation, so pre-divide to simplify.
> > > +      */
> > > +     const u32 iclk_pre = 72 * MEGA / 1000000;
> > 
> > You can replace 1000000 by MEGA. Or just remove the division and
> > multiplication.
> > 
> > > +     const u32 pclk_pre = pixel_rate / 1000000;
> > 
> > Same here regarding 1000000.
> 
> They both made sense to me originally to break out while making sure we
> got the calculations right. But simplifing probably makes sense now.

Up to you.

> 
> > 
> > > +
> > > +     return pixels * iclk_pre / pclk_pre;
> > > +}
> > > +
> > > +/* Internal clock (72MHz) to Pixel Rate clock (Variable) */
> > > +static u64 imx283_iclk_to_pix(unsigned int pixel_rate, unsigned int cycles)
> > > +{
> > > +     /*
> > > +      * Determine the following operation without overflow:
> > > +      *    cycles * pixel_rate / (72 * MEGA)
> > > +      *
> > > +      * The internal clock at 72MHz and Pixel Rate (between 240 and 576MHz)
> > > +      * can easily overflow this calculation, so pre-divide to simplify.
> > > +      */
> > > +     const u32 iclk_pre = 72 * MEGA / 1000000;
> > > +     const u32 pclk_pre = pixel_rate / 1000000;
> > > +
> > > +     return cycles * pclk_pre / iclk_pre;
> > > +}
> > > +
> > > +/* Determine the exposure based on current hmax, vmax and a given SHR */
> > > +static u64 imx283_exposure(struct imx283 *imx283,
> > > +                        const struct imx283_mode *mode, u64 shr)
> > > +{
> > > +     u32 svr = 0; /* SVR feature is not currently supported */
> > 
> > What does this refer to? I guess you could just drop it as well if it's not
> > supported?
> 
> Keeping this will keep the calculation matching the datasheet, and
> provide clear value for what to update when we/others return to enable
> long exposures.
> 
> So it would be nice to keep as it sort of documents/tracks the
> datasheet.

Ack.

> 
> 
> > > +     u32 hmax = imx283->hmax;
> > > +     u64 vmax = imx283->vmax;
> > 
> > You're not changing the values here. I wouldn't introduce temporary
> > variables just for that.
> > 
> > > +     u32 offset;
> > > +     u64 numerator;
> > > +
> > > +     /* Number of clocks per internal offset period */
> > > +     offset = mode->mode == IMX283_MODE_0 ? 209 : 157;
> > 
> > Shouldn't this be in the mode definition?
> 
> It could be, but then there would be one copy of 209, and 9 copies of
> 157. 

That would still be specified explicitly. Someone adding a new mode would
easily miss this.

Or, if you can, derive this from something else that is now a part of the
mode itself.

> 
> > 
> > > +     numerator = (vmax * (svr + 1) - shr) * hmax + offset;
> > > +
> > > +     do_div(numerator, hmax);
> > > +     numerator = clamp_t(u32, numerator, 0, 0xFFFFFFFF);
> > > +     return numerator;
> > > +}
> > > +
> > > +static void imx283_exposure_limits(struct imx283 *imx283,
> > > +                                const struct imx283_mode *mode,
> > > +                                u64 *min_exposure, u64 *max_exposure)
> > 
> > Note that these are s32 values, not u64.
> 
> Hrm, likely due to the return value of imx283_exposure() which could be
> updated if required.

On a 32-bit platform these do make a difference. Please use an integer type
that suits better for the purpose.

-- 
Kind regards,

Sakari Ailus

