Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DCB79745E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbjIGPhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344785AbjIGPdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:33:49 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754A02100;
        Thu,  7 Sep 2023 08:33:21 -0700 (PDT)
Received: from pyrite.rasen.tech (h175-177-042-159.catv02.itscom.jp [175.177.42.159])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C27F71AF0;
        Thu,  7 Sep 2023 16:52:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1694098368;
        bh=PZx4Rhc2LOFe1v9kvH2btTFZm7vOvBNqobwbYAr1QbI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Iv2A0Kyhiwt18nfOSglJM8pLVx0Cr4PkMkQQZw6ikVElPzb/6FojhrTmD6cXHZvf3
         Yjbhh7XTQa1vPg8P7s6lI44UGvk0q1XXQh0ImZduI8n7ee4Cv0eSZkNUQbsks2LSmU
         KQxIfx8BrVbl7sy2U5baaRDAwX4SfMMhrEXfrcIY=
Date:   Thu, 7 Sep 2023 23:54:05 +0900
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] media: i2c: Add driver for THine THP7312
Message-ID: <ZPnkDYYP3WsiHsWu@pyrite.rasen.tech>
References: <20230905233118.183140-1-paul.elder@ideasonboard.com>
 <20230905233118.183140-3-paul.elder@ideasonboard.com>
 <CAPY8ntD6ps40myv9UWJUnv_DzxK1-S7iikCGXP4nn45UiUa4xA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPY8ntD6ps40myv9UWJUnv_DzxK1-S7iikCGXP4nn45UiUa4xA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Wed, Sep 06, 2023 at 11:50:14AM +0100, Dave Stevenson wrote:
> Hi Paul
> 
> On Wed, 6 Sept 2023 at 00:32, Paul Elder <paul.elder@ideasonboard.com> wrote:
> >
> > Add driver for the THine THP7312 ISP.
> >
> > Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> > ---
> >  drivers/media/i2c/Kconfig   |    9 +
> >  drivers/media/i2c/Makefile  |    1 +
> >  drivers/media/i2c/thp7312.c | 1674 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 1684 insertions(+)
> >  create mode 100644 drivers/media/i2c/thp7312.c
> >
> > diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
> > index 226454b6a90d..ab7d333f1e43 100644
> > --- a/drivers/media/i2c/Kconfig
> > +++ b/drivers/media/i2c/Kconfig
> > @@ -807,6 +807,15 @@ config VIDEO_ST_VGXY61
> >           This is a Video4Linux2 sensor driver for the ST VGXY61
> >           camera sensor.
> >
> > +config VIDEO_THP7312
> > +       tristate "THP7312 ISP"
> > +       depends on VIDEO_DEV && I2C && VIDEO_V4L2_SUBDEV_API
> > +       help
> > +         Support for THine THP7312 Image Signal Processor
> > +
> > +         To compile this driver as a module, choose M here: the
> > +         module will be called thp7312.
> > +
> >  source "drivers/media/i2c/ccs/Kconfig"
> >  source "drivers/media/i2c/et8ek8/Kconfig"
> >
> > diff --git a/drivers/media/i2c/Makefile b/drivers/media/i2c/Makefile
> > index c743aeb5d1ad..c831c0761aa7 100644
> > --- a/drivers/media/i2c/Makefile
> > +++ b/drivers/media/i2c/Makefile
> > @@ -123,6 +123,7 @@ obj-$(CONFIG_VIDEO_TDA7432) += tda7432.o
> >  obj-$(CONFIG_VIDEO_TDA9840) += tda9840.o
> >  obj-$(CONFIG_VIDEO_TEA6415C) += tea6415c.o
> >  obj-$(CONFIG_VIDEO_TEA6420) += tea6420.o
> > +obj-$(CONFIG_VIDEO_THP7312) += thp7312.o
> >  obj-$(CONFIG_VIDEO_THS7303) += ths7303.o
> >  obj-$(CONFIG_VIDEO_THS8200) += ths8200.o
> >  obj-$(CONFIG_VIDEO_TLV320AIC23B) += tlv320aic23b.o
> > diff --git a/drivers/media/i2c/thp7312.c b/drivers/media/i2c/thp7312.c
> > new file mode 100644
> > index 000000000000..c289641a9e92
> > --- /dev/null
> > +++ b/drivers/media/i2c/thp7312.c
> > @@ -0,0 +1,1674 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (C) 2011-2013 Freescale Semiconductor, Inc. All Rights Reserved.
> > + * Copyright (C) 2014-2017 Mentor Graphics Inc.
> > + * Copyright (C) 2021 THine Electronics, Inc.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/clk.h>
> > +#include <linux/clk-provider.h>
> > +#include <linux/clkdev.h>
> > +#include <linux/ctype.h>
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/i2c.h>
> > +#include <linux/init.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/slab.h>
> > +#include <linux/types.h>
> > +#include <linux/firmware.h>
> > +#include <media/v4l2-async.h>
> > +#include <media/v4l2-ctrls.h>
> > +#include <media/v4l2-device.h>
> > +#include <media/v4l2-event.h>
> > +#include <media/v4l2-fwnode.h>
> > +#include <media/v4l2-subdev.h>
> > +
> > +#define V4L2_CID_THINE_BASE                                    V4L2_CID_USER_BASE+0x1100
> > +
> > +#define V4L2_CID_THINE_LOW_LIGHT_COMPENSATION                  V4L2_CID_THINE_BASE+0x01
> > +#define V4L2_CID_THINE_AUTO_FOCUS_METHOD                       V4L2_CID_THINE_BASE+0x02
> > +#define V4L2_CID_THINE_NOISE_REDUCTION_AUTO                    V4L2_CID_THINE_BASE+0x03
> > +#define V4L2_CID_THINE_NOISE_REDUCTION_ABSOLUTE                        V4L2_CID_THINE_BASE+0x04
> 
> I only cast a quick glance at the patch, but this stood out.
> 
> Presumably these control defines are needed by userspace, so should be
> split between include/uapi/linux/v4l2-controls.h and
> include/uapi/linux/thine_thp7312.h (or similarly named header).
> 
> V4L2_CID_USER_BASE+0x1100 is in part of the block reserved by
> V4L2_CID_USER_CCS_BASE [1], when it should be unique.

I totally missed that; thanks for catching it.


Paul

> 
> [1] https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/v4l2-controls.h#L181
> 
> > +
> > +#define DEFAULT_FPS 30
> > +
> > +/* THP7312 register addresses for format */
> > +#define THP7312_REG_SET_OUTPUT_ENABLE                      (0xF008)
> > +#define THP7312_REG_SET_OUTPUT_COLOR_COMPRESSION           (0xF009)
> > +#define THP7312_REG_SET_DRIVING_MODE                       (0xF010)
> > +#define THP7312_REG_DRIVING_MODE_STATUS                            (0xF011)
> > +
> > +/* THP7312 register values for format */
> > +#define        THP7312_OUTPUT_ENABLE                               (0x01)
> > +#define        THP7312_OUTPUT_DISABLE                              (0x00)
> > +
> > +#define THP7312_REG_SET_OUTPUT_COLOR_UYVY                  (0x00)
> > +#define THP7312_REG_SET_OUTPUT_COLOR_YUY2                  (0x04)
> > +
> > +#define THP7312_REG_VIDEO_IMAGE_SIZE                       (0xF00D)
> > +#define THP7312_VIDEO_IMAGE_SIZE_640x360   (0x52)
> > +#define THP7312_VIDEO_IMAGE_SIZE_640x460   (0x03)
> > +#define THP7312_VIDEO_IMAGE_SIZE_1280x720  (0x0A)
> > +#define THP7312_VIDEO_IMAGE_SIZE_1920x1080 (0x0B)
> > +#define THP7312_VIDEO_IMAGE_SIZE_3840x2160 (0x0D)
> > +#define THP7312_VIDEO_IMAGE_SIZE_4160x3120 (0x14)
> > +#define THP7312_VIDEO_IMAGE_SIZE_2016x1512 (0x20)
> > +#define THP7312_VIDEO_IMAGE_SIZE_2048x1536 (0x21)
> > +
> > +#define THP7312_REG_VIDEO_FRAME_RATE_MODE                  (0xF00F)
> > +#define THP7312_VIDEO_FRAME_RATE_MODE1 (0x80)
> > +#define THP7312_VIDEO_FRAME_RATE_MODE2 (0x81)
> > +#define THP7312_VIDEO_FRAME_RATE_MODE3 (0x82)
> > +
> > +#define THP7312_REG_JPEG_COMPRESSION_FACTOR                (0xF01B)
> > +
> > +//THP7312 register addresses for ctrls
> > +#define        THP7312_REG_FIRMWARE_VERSION_1                      (0xF000)
> > +#define THP7312_REG_CAMERA_STATUS                          (0xF001)
> > +#define        THP7312_REG_FIRMWARE_VERSION_2                      (0xF005)
> > +#define        THP7312_REG_FLIP_MIRROR                             (0xF00C)
> > +#define THP7312_REG_AE_EXPOSURE_COMPENSATION               (0xF022)
> > +#define THP7312_REG_AE_FLICKER_MODE                        (0xF023)
> > +#define THP7312_REG_AE_FIX_FRAME_RATE                      (0xF02E)
> > +#define THP7312_REG_MANUAL_WB_RED_GAIN                     (0xF036)
> > +#define THP7312_REG_MANUAL_WB_BLUE_GAIN                            (0xF037)
> > +#define THP7312_REG_WB_MODE                                (0xF039)
> > +#define        THP7312_REG_MANUAL_FOCUS_POSITION                   (0xF03C)
> > +#define        THP7312_REG_AF_CONTROL                              (0xF040)
> > +#define THP7312_REG_AF_SETTING                             (0xF041)
> > +#define THP7312_REG_SATURATION                                     (0xF052)
> > +#define THP7312_REG_SHARPNESS                              (0xF053)
> > +#define THP7312_REG_BRIGHTNESS                                     (0xF056)
> > +#define THP7312_REG_CONTRAST                               (0xF057)
> > +#define THP7312_REG_NOISE_REDUCTION                        (0xF059)
> > +
> > +#define TH7312_REG_CUSTOM_MIPI_SET                         (0xF0F6)
> > +#define TH7312_REG_CUSTOM_MIPI_STATUS                      (0xF0F7)
> > +#define TH7312_REG_CUSTOM_MIPI_RD                          (0xF0F8)
> > +#define TH7312_REG_CUSTOM_MIPI_TD                          (0xF0F9)
> > +
> > +/* THP7312 register values for control */
> > +#define        THP7312_FOCUS_MODE_AUTO_CONTINOUS                   (0x01)
> > +#define        THP7312_FOCUS_MODE_AUTO_LOCK                        (0x80)
> > +#define        THP7312_FOCUS_MODE_MANUAL                           (0x10)
> > +
> > +enum thp7312_focus_method {
> > +       THP7312_FOCUS_METHOD_CONTRAST = 0x00,
> > +       THP7312_FOCUS_METHOD_PDAF = 0x01,
> > +       THP7312_FOCUS_METHOD_HYBRID = 0x02,
> > +};
> > +
> > +#define THP7312_WB_MODE_AUTO                               (0x00)
> > +#define THP7312_WB_MODE_MANUAL                             (0x11)
> > +
> > +#define THP7312_AE_FLICKER_MODE_50                         (0x00)
> > +#define THP7312_AE_FLICKER_MODE_60                         (0x01)
> > +#define THP7312_AE_FLICKER_MODE_DISABLE                    (0x80)
> > +
> > +#define THP7312_NUM_FORMATS                             ARRAY_SIZE(thp7312_colour_fmts)
> > +
> > +#define THP7312_I2C_ADDRESS_AT_FW_UPDATA                (0x60)
> > +
> > +
> > +enum thp7312_mode {
> > +       THP7312_MODE_MIN = 0,
> > +       THP7312_MODE_FHD_30FPS = 0,
> > +       THP7312_MODE_FHD_60FPS = 1,
> > +       THP7312_MODE_3M_30FPS = 2,
> > +       THP7312_MODE_4K_30FPS = 3,
> > +       THP7312_MODE_13M_20FPS = 4,
> > +       THP7312_MODE_MAX = 4,
> > +};
> > +
> > +enum thp7312_frame_rate {
> > +       THP7312_20_FPS = 0,
> > +       THP7312_30_FPS,
> > +       THP7312_60_FPS,
> > +       THP7312_NUM_FRAMERATES,
> > +};
> > +
> > +struct thp7312_datafmt {
> > +       u32 code;
> > +       enum v4l2_colorspace colorspace;
> > +};
> > +
> > +struct reg_value {
> > +       u16 addr;
> > +       u8 val;
> > +};
> > +
> > +struct thp7312_mode_info {
> > +       enum thp7312_mode mode;
> > +       u16 width;
> > +       u16 height;
> > +       u32 fps;
> > +       u16 frame_time;
> > +       u32 pixel_rate;
> > +       struct reg_value *reg_data;
> > +       u32 reg_data_size;
> > +};
> > +
> > +static const struct thp7312_datafmt thp7312_colour_fmts[] = {
> > +       /*
> > +        * According to the hardware documentation UYVY should be supported,
> > +        * but in reality it does not work. This could however be fixed in a
> > +        * firmware update, so keep this here both for documentation and to
> > +        * make it easier to re-add later.
> > +        * { MEDIA_BUS_FMT_UYVY8_1X16, V4L2_COLORSPACE_SRGB, },
> > +        */
> > +       { MEDIA_BUS_FMT_YUYV8_1X16, V4L2_COLORSPACE_SRGB, },
> > +};
> > +
> > +static const int thp7312_framerates[] = {
> > +       [THP7312_20_FPS] = 20,
> > +       [THP7312_30_FPS] = 30,
> > +       [THP7312_60_FPS] = 60,
> > +};
> > +
> > +static struct reg_value thp7312_setting_fhd30p[] = {
> > +       { THP7312_REG_VIDEO_IMAGE_SIZE, THP7312_VIDEO_IMAGE_SIZE_1920x1080 },
> > +       { THP7312_REG_VIDEO_FRAME_RATE_MODE, 0x81 },
> > +       { THP7312_REG_JPEG_COMPRESSION_FACTOR, 0x5E },
> > +       { THP7312_REG_SET_DRIVING_MODE, 0x01 },
> > +};
> > +
> > +static struct reg_value thp7312_setting_fhd60p[] = {
> > +       { THP7312_REG_VIDEO_IMAGE_SIZE, THP7312_VIDEO_IMAGE_SIZE_1920x1080 },
> > +       { THP7312_REG_VIDEO_FRAME_RATE_MODE, 0x82 },
> > +       { THP7312_REG_JPEG_COMPRESSION_FACTOR, 0x5E },
> > +       { THP7312_REG_SET_DRIVING_MODE, 0x01 },
> > +};
> > +
> > +static struct reg_value thp7312_setting_3m30p[] = {
> > +       { THP7312_REG_VIDEO_IMAGE_SIZE, THP7312_VIDEO_IMAGE_SIZE_2048x1536 },
> > +       { THP7312_REG_VIDEO_FRAME_RATE_MODE, 0x81 },
> > +       { THP7312_REG_JPEG_COMPRESSION_FACTOR, 0x5E },
> > +       { THP7312_REG_SET_DRIVING_MODE, 0x01 },
> > +};
> > +
> > +static struct reg_value thp7312_setting_4k30p[] = {
> > +       { THP7312_REG_VIDEO_IMAGE_SIZE, THP7312_VIDEO_IMAGE_SIZE_3840x2160 },
> > +       { THP7312_REG_VIDEO_FRAME_RATE_MODE, 0x81 },
> > +       { THP7312_REG_JPEG_COMPRESSION_FACTOR, 0x5E },
> > +       { THP7312_REG_SET_DRIVING_MODE, 0x01 },
> > +};
> > +
> > +static struct reg_value thp7312_setting_13m20p[] = {
> > +       { THP7312_REG_VIDEO_IMAGE_SIZE, THP7312_VIDEO_IMAGE_SIZE_4160x3120 },
> > +       { THP7312_REG_VIDEO_FRAME_RATE_MODE, 0x81 },
> > +       { THP7312_REG_JPEG_COMPRESSION_FACTOR, 0x5E },
> > +       { THP7312_REG_SET_DRIVING_MODE, 0x01 },
> > +};
> > +
> > +
> > +/* regulator supplies */
> > +static const char * const thp7312_supply_name[] = {
> > +       "vddcore",
> > +       "vhtermrx",
> > +       "vddtx",
> > +       "vddhost",
> > +       "vddcmos",
> > +       "vddgpio_0",
> > +       "vddgpio_1",
> > +       "DOVDD",
> > +       "AVDD",
> > +       "DVDD",
> > +};
> > +
> > +#define THP7312_NUM_SUPPLIES ARRAY_SIZE(thp7312_supply_name)
> > +
> > +static struct thp7312_mode_info thp7312_mode_info_data[] = {
> > +       { THP7312_MODE_FHD_30FPS, 1920, 1080, THP7312_30_FPS, 33, 150000000,
> > +         thp7312_setting_fhd30p, ARRAY_SIZE(thp7312_setting_fhd30p)},
> > +       { THP7312_MODE_FHD_60FPS, 1920, 1080, THP7312_60_FPS, 17, 193750000,
> > +         thp7312_setting_fhd60p, ARRAY_SIZE(thp7312_setting_fhd60p)},
> > +       { THP7312_MODE_3M_30FPS, 2048, 1536, THP7312_30_FPS, 33, 150000000,
> > +         thp7312_setting_3m30p, ARRAY_SIZE(thp7312_setting_3m30p)},
> > +       { THP7312_MODE_4K_30FPS, 3840, 2160, THP7312_30_FPS, 33, 300000000,
> > +         thp7312_setting_4k30p, ARRAY_SIZE(thp7312_setting_4k30p)},
> > +       { THP7312_MODE_13M_20FPS, 4160, 3120, THP7312_20_FPS, 50, 300000000,
> > +         thp7312_setting_13m20p, ARRAY_SIZE(thp7312_setting_13m20p)},
> > +};
> > +
> > +#define THP7312_NUM_MODES ARRAY_SIZE(thp7312_mode_info_data)
> > +
> > +struct thp7312_isp_dev {
> > +       struct i2c_client *i2c_client;
> > +       struct v4l2_subdev sd;
> > +       struct media_pad pad;
> > +       /* the parsed DT endpoint info */
> > +       struct v4l2_fwnode_endpoint ep;
> > +       struct gpio_desc *reset_gpio;
> > +       struct regulator_bulk_data supplies[THP7312_NUM_SUPPLIES];
> > +       struct clk *iclk;
> > +       /* lock to protect all members below */
> > +       struct mutex lock;
> > +
> > +       struct thp7312_mode_info *active_mode;
> > +
> > +       struct v4l2_ctrl_handler ctrl_handler;
> > +
> > +       struct thp7312_mode_info *current_mode;
> > +       enum thp7312_frame_rate current_fr;
> > +       struct v4l2_fract frame_interval;
> > +       struct v4l2_mbus_framefmt fmt;
> > +
> > +       bool focus_mode_auto;
> > +       bool af_continuous;
> > +       bool af_lock;
> > +       enum thp7312_focus_method  af_method;
> > +       int boot_mode;
> > +
> > +       const char *fw_name;
> > +       u8      *fw_data;
> > +       size_t  fw_size;
> > +
> > +       u8 fw_update_mode;
> > +       u16 thp7312_register_rw_address;
> > +       u8      fw_major_version;
> > +       u8      fw_minor_version;
> > +
> > +       bool streaming;
> > +};
> > +
> > +static inline struct thp7312_isp_dev *to_thp7312_dev(struct v4l2_subdev *sd)
> > +{
> > +       return container_of(sd, struct thp7312_isp_dev, sd);
> > +}
> > +
> > +static int thp7312_write_reg(struct thp7312_isp_dev *isp_dev, u16 reg, u8 val)
> > +{
> > +       struct i2c_client *client = isp_dev->i2c_client;
> > +       int ret = 0;
> > +       u8 buf[3] = {0};
> > +
> > +       buf[0] = reg >> 8;
> > +       buf[1] = reg & 0xff;
> > +       buf[2] = val;
> > +
> > +       ret = i2c_master_send(client, buf, 3);
> > +       if (ret < 0) {
> > +               dev_err(&client->dev, "%s(): write reg failed, reg=0x%x,val=0x%x ret=%d\n",
> > +                       __func__, reg, val, ret);
> > +               return ret;
> > +       }
> > +
> > +       dev_err(&client->dev, "%s(): wrote reg, reg=0x%x,val=0x%x ret=%d\n",
> > +               __func__, reg, val, ret);
> > +
> > +       return 0;
> > +}
> > +
> > +static int thp7312_read_reg(struct thp7312_isp_dev *isp_dev, u16 reg, u8 *val)
> > +{
> > +       struct i2c_client *client = isp_dev->i2c_client;
> > +       struct i2c_msg msgs[2];
> > +       u8 buf[2];
> > +       int ret;
> > +
> > +       buf[0] = reg >> 8;
> > +       buf[1] = reg & 0xff;
> > +       msgs[0].addr = client->addr;
> > +       msgs[0].flags = 0;
> > +       msgs[0].len = 2;
> > +       msgs[0].buf = buf;
> > +
> > +       msgs[1].addr = client->addr;
> > +       msgs[1].flags = I2C_M_RD;
> > +       msgs[1].len = 1;
> > +       msgs[1].buf = buf;
> > +
> > +       ret = i2c_transfer(client->adapter, msgs, 2);
> > +       if (ret < 0) {
> > +               dev_err(&client->dev, "%s():reg=0x%x ret=%d\n", __func__, reg, ret);
> > +               return ret;
> > +       }
> > +
> > +       *val = buf[0];
> > +
> > +       return 0;
> > +}
> > +
> > +static int thp7312_check_valid_mode(const struct thp7312_mode_info *mode_info,
> > +                                   enum thp7312_frame_rate frame_rate)
> > +{
> > +       struct thp7312_mode_info *info;
> > +       enum thp7312_mode mode = mode_info->mode;
> > +
> > +       if (mode < THP7312_MODE_MIN || THP7312_MODE_MAX < mode)
> > +               return -EINVAL;
> > +
> > +       info = &thp7312_mode_info_data[mode];
> > +       if (info->mode != mode || info->fps != frame_rate)
> > +               return -EINVAL;
> > +
> > +       return 0;
> > +}
> > +
> > +#define thp7312_read_poll_timeout(dev, addr, val, cond, sleep_us, timeout_us) \
> > +({ \
> > +       int __ret; \
> > +       u64 __timeout_us = (timeout_us); \
> > +       unsigned long __sleep_us = (sleep_us); \
> > +       ktime_t __timeout = ktime_add_us(ktime_get(), __timeout_us); \
> > +       might_sleep_if((__sleep_us) != 0); \
> > +       for (;;) { \
> > +               __ret = thp7312_read_reg((dev), (addr), &(val)); \
> > +               if (cond) \
> > +                       break; \
> > +               if (__ret < 0 || \
> > +                   (__timeout_us && \
> > +                    ktime_compare(ktime_get(), __timeout) > 0)) { \
> > +                       __ret = thp7312_read_reg((dev), (addr), &(val)); \
> > +                       break; \
> > +               } \
> > +               if (__sleep_us) \
> > +                       usleep_range((__sleep_us >> 2) + 1, __sleep_us); \
> > +       } \
> > +       (cond) ? 0 : (__ret ? __ret : -ETIMEDOUT); \
> > +})
> > +
> > +static int thp7312_set_mipi_regs(struct thp7312_isp_dev *isp_dev, u16 reg,
> > +                                u8 *lanes, u8 num_lanes)
> > +{
> > +       u8 used_lanes = 0;
> > +       u8 conv_lanes[4];
> > +       u8 val;
> > +       int ret, i;
> > +
> > +       if (num_lanes != 4)
> > +               return -EINVAL;
> > +
> > +       /*
> > +        * The value that we write to the register is the index in the
> > +        * data-lanes array, so we need to do a conversion. Do this in the same
> > +        * pass as validating data-lanes.
> > +        */
> > +       for (i = 0; i < num_lanes; i++) {
> > +               if (lanes[i] > 4)
> > +                       return -EINVAL;
> > +
> > +               if (used_lanes & (1 << lanes[i]))
> > +                       return -EINVAL;
> > +
> > +               used_lanes |= 1 << lanes[i];
> > +
> > +               /*
> > +                * data-lanes is 1-indexed while we'll use 0-indexing for
> > +                * writing the register.
> > +                */
> > +               conv_lanes[lanes[i] - 1] = i;
> > +       }
> > +
> > +       val = ((conv_lanes[3] & 0x03) << 6) |
> > +             ((conv_lanes[2] & 0x03) << 4) |
> > +             ((conv_lanes[1] & 0x03) << 2) |
> > +              (conv_lanes[0] & 0x03);
> > +
> > +       ret = thp7312_write_reg(isp_dev, reg, val);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       return 0;
> > +}
> > +
> > +static int thp7312_set_mipi_lanes(struct thp7312_isp_dev *isp_dev)
> > +{
> > +       struct device *dev = &isp_dev->i2c_client->dev;
> > +       int ret;
> > +       u8 val;
> > +       int i;
> > +       u32 data_lanes_rx_u32[4];
> > +       unsigned char data_lanes_rx[4];
> > +
> > +       ret = of_property_read_u32_array(dev->of_node, "thine,rx,data-lanes",
> > +                                        data_lanes_rx_u32, ARRAY_SIZE(data_lanes_rx_u32));
> > +       if (ret < 0) {
> > +               dev_err(dev, "Failed to read property thine,rx,data-lanes: %d\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       for (i = 0; i < 4; i++)
> > +               data_lanes_rx[i] = (u8)data_lanes_rx_u32[i];
> > +
> > +       ret = thp7312_set_mipi_regs(isp_dev, TH7312_REG_CUSTOM_MIPI_RD,
> > +                                   data_lanes_rx,
> > +                                   ARRAY_SIZE(data_lanes_rx));
> > +       if (ret < 0) {
> > +               dev_err(dev, "Failed to set RD MIPI lanes: %d\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       thp7312_set_mipi_regs(isp_dev, TH7312_REG_CUSTOM_MIPI_TD,
> > +                             isp_dev->ep.bus.mipi_csi2.data_lanes,
> > +                             isp_dev->ep.bus.mipi_csi2.num_data_lanes);
> > +       if (ret < 0) {
> > +               dev_err(dev, "Failed to set TD MIPI lanes: %d\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       ret = thp7312_write_reg(isp_dev, TH7312_REG_CUSTOM_MIPI_SET, 1);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       ret = thp7312_read_poll_timeout(isp_dev, TH7312_REG_CUSTOM_MIPI_STATUS,
> > +                                       val, val == 0x00, 100000, 2000000);
> > +       if (ret < 0) {
> > +               dev_err(&isp_dev->i2c_client->dev,
> > +                       "Failed to poll MIPI lane status: %d\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int thp7312_change_mode(struct thp7312_isp_dev *isp_dev,
> > +                              enum thp7312_mode mode)
> > +{
> > +       struct i2c_client *client = isp_dev->i2c_client;
> > +       u8 reg_val = 0;
> > +       struct reg_value *reg_data;
> > +       int i;
> > +       int ret;
> > +       struct thp7312_mode_info *info = &thp7312_mode_info_data[mode];
> > +
> > +       ret = thp7312_read_poll_timeout(isp_dev, THP7312_REG_CAMERA_STATUS, reg_val,
> > +                                       reg_val == 0x80, 20000, 200000);
> > +       if (ret < 0) {
> > +               dev_err(&client->dev, "%s(): failed to poll ISP: %d\n",
> > +                       __func__, ret);
> > +               return ret;
> > +       }
> > +
> > +       reg_data = info->reg_data;
> > +       for (i = 0; i < info->reg_data_size; i++) {
> > +               ret = thp7312_write_reg(isp_dev, reg_data[i].addr, reg_data[i].val);
> > +               if (ret < 0) {
> > +                       dev_err(&client->dev, "%s(): write mode failed\n", __func__);
> > +                       return ret;
> > +               }
> > +       }
> > +
> > +       ret = thp7312_read_poll_timeout(isp_dev, THP7312_REG_DRIVING_MODE_STATUS,
> > +                                       reg_val, reg_val == 0x01, 20000, 100000);
> > +       if (ret) {
> > +               dev_err(&client->dev,"%s(): failed\n", __func__);
> > +               return ret;
> > +       }
> > +
> > +       isp_dev->active_mode = info;
> > +
> > +       return 0;
> > +}
> > +
> > +static int thp7312_set_framefmt(struct thp7312_isp_dev *isp_dev,
> > +                               struct v4l2_mbus_framefmt *format)
> > +{
> > +       int ret = 0;
> > +
> > +       struct i2c_client *client = isp_dev->i2c_client;
> > +
> > +       switch (format->code) {
> > +       case MEDIA_BUS_FMT_UYVY8_1X16:
> > +               /* YUV422, UYVY */
> > +               ret = thp7312_write_reg(isp_dev, THP7312_REG_SET_OUTPUT_COLOR_COMPRESSION,
> > +                                       THP7312_REG_SET_OUTPUT_COLOR_UYVY);
> > +               break;
> > +       case MEDIA_BUS_FMT_YUYV8_1X16:
> > +               /* YUV422, YUYV */
> > +               ret = thp7312_write_reg(isp_dev, THP7312_REG_SET_OUTPUT_COLOR_COMPRESSION,
> > +                                       THP7312_REG_SET_OUTPUT_COLOR_YUY2);
> > +               break;
> > +       default:
> > +               dev_err(&client->dev, "thp7312_set_framefmt: ERROR \n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> > +static int thp7312_init_mode(struct thp7312_isp_dev *isp_dev)
> > +{
> > +       struct i2c_client *client = isp_dev->i2c_client;
> > +       int ret = 0;
> > +       enum thp7312_mode mode = isp_dev->current_mode->mode;
> > +
> > +       dev_dbg(&client->dev, "%s(): mode = %d\n",__func__, mode);
> > +       if ((mode > THP7312_MODE_MAX || mode < THP7312_MODE_MIN) ){
> > +               dev_err(&client->dev, "%s(): thp7312 mode is invalid\n", __func__);
> > +               return -EINVAL;
> > +       }
> > +
> > +       ret = thp7312_set_framefmt(isp_dev, &isp_dev->fmt);
> > +       if (ret)
> > +               return ret;
> > +
> > +       return thp7312_change_mode(isp_dev, mode);
> > +}
> > +
> > +static int thp7312_stream_enable(struct thp7312_isp_dev *isp_dev, int enable)
> > +{
> > +       return thp7312_write_reg(isp_dev, THP7312_REG_SET_OUTPUT_ENABLE,
> > +                                enable ? THP7312_OUTPUT_ENABLE
> > +                                       : THP7312_OUTPUT_DISABLE);
> > +}
> > +
> > +static int thp7312_reset(struct thp7312_isp_dev *isp_dev)
> > +{
> > +       struct device *dev = &isp_dev->i2c_client->dev;
> > +       u8 camera_status = -1;
> > +       int ret;
> > +
> > +       gpiod_set_value_cansleep(isp_dev->reset_gpio, 1);
> > +
> > +       fsleep(10000);
> > +
> > +       gpiod_set_value_cansleep(isp_dev->reset_gpio, 0);
> > +
> > +       fsleep(300000);
> > +
> > +       while (camera_status != 0x80) {
> > +               ret = thp7312_read_reg(isp_dev, 0xF001, &camera_status);
> > +               if (ret < 0) {
> > +                       dev_err(dev, "Failed to read camera status register\n");
> > +                       return ret;
> > +               }
> > +
> > +               if (camera_status == 0x00) {
> > +                       dev_info(dev, "Camera initializing...");
> > +               } else if (camera_status == 0x80) {
> > +                       dev_info(dev, "Camera initialization done");
> > +                       break;
> > +               } else {
> > +                       dev_err(dev,
> > +                               "Camera Status field incorrect; camera_status=%x\n",
> > +                               camera_status);
> > +               }
> > +
> > +               usleep_range(70000, 80000);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int thp7312_set_power_on(struct device *dev)
> > +{
> > +       struct v4l2_subdev *sd = dev_get_drvdata(dev);
> > +       struct thp7312_isp_dev *isp_dev = to_thp7312_dev(sd);
> > +
> > +       int ret;
> > +
> > +       ret = regulator_bulk_enable(THP7312_NUM_SUPPLIES, isp_dev->supplies);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       ret = clk_prepare_enable(isp_dev->iclk);
> > +       if (ret < 0) {
> > +               dev_err(dev, "clk prepare enable failed\n");
> > +               goto error_pwdn;
> > +       }
> > +
> > +       /*
> > +        * We cannot assume that turning off and on again will reset, so do a
> > +        * software reset on power up. While at it, reprogram the MIPI lanes,
> > +        * in case they get cleared when powered off.
> > +        */
> > +       ret = thp7312_reset(isp_dev);
> > +       if (ret < 0)
> > +               goto error_clk_disable;
> > +
> > +       ret = thp7312_set_mipi_lanes(isp_dev);
> > +       if (ret < 0)
> > +               goto error_clk_disable;
> > +
> > +       return 0;
> > +
> > +error_clk_disable:
> > +       clk_disable_unprepare(isp_dev->iclk);
> > +error_pwdn:
> > +       regulator_bulk_disable(THP7312_NUM_SUPPLIES, isp_dev->supplies);
> > +
> > +       return ret;
> > +}
> > +
> > +static int thp7312_set_power_off(struct device *dev)
> > +{
> > +       struct v4l2_subdev *sd = dev_get_drvdata(dev);
> > +       struct thp7312_isp_dev *isp_dev = to_thp7312_dev(sd);
> > +
> > +       isp_dev->streaming = false;
> > +
> > +       regulator_bulk_disable(THP7312_NUM_SUPPLIES, isp_dev->supplies);
> > +       clk_disable_unprepare(isp_dev->iclk);
> > +
> > +       return 0;
> > +}
> > +
> > +static int thp7312_get_regulators(struct thp7312_isp_dev *isp_dev)
> > +{
> > +       int i;
> > +
> > +       for (i = 0; i < THP7312_NUM_SUPPLIES; i++)
> > +               isp_dev->supplies[i].supply = thp7312_supply_name[i];
> > +
> > +       return devm_regulator_bulk_get(&isp_dev->i2c_client->dev,
> > +                                      THP7312_NUM_SUPPLIES,
> > +                                      isp_dev->supplies);
> > +}
> > +
> > +/* --------------- Subdev Operations --------------- */
> > +
> > +static const struct thp7312_mode_info *
> > +thp7312_find_mode(struct thp7312_isp_dev *isp_dev, enum thp7312_frame_rate fr,
> > +                 int width, int height, bool nearest)
> > +{
> > +       struct thp7312_mode_info *mode_info;
> > +       unsigned int delta = UINT_MAX;
> > +       unsigned int smallest_delta_index = 0;
> > +       unsigned int tmp;
> > +       int i;
> > +
> > +       for (i = 0; i < THP7312_NUM_MODES; i++) {
> > +               mode_info = &thp7312_mode_info_data[i];
> > +               if (mode_info->width == width &&
> > +                   mode_info->height == height &&
> > +                   mode_info->fps == fr)
> > +                       return mode_info;
> > +
> > +               tmp = abs((mode_info->width * mode_info->height) - (width * height));
> > +               if (tmp < delta) {
> > +                       delta = tmp;
> > +                       smallest_delta_index = i;
> > +               }
> > +       }
> > +
> > +       if (!nearest)
> > +               return NULL;
> > +
> > +       return &thp7312_mode_info_data[smallest_delta_index];
> > +}
> > +
> > +static int thp7312_try_frame_interval(struct thp7312_isp_dev *isp_dev,
> > +                                     struct v4l2_fract *fi,
> > +                                     u32 width, u32 height)
> > +{
> > +       const struct thp7312_mode_info *mode_info;
> > +       int minfps, maxfps, best_fps, fps;
> > +       int i;
> > +       enum thp7312_frame_rate rate = THP7312_20_FPS;
> > +       minfps = thp7312_framerates[THP7312_20_FPS];
> > +       maxfps = thp7312_framerates[THP7312_60_FPS];
> > +
> > +       if (fi->numerator == 0) {
> > +               fi->denominator = maxfps;
> > +               fi->numerator = 1;
> > +               rate = THP7312_60_FPS;
> > +               goto find_mode;
> > +       }
> > +
> > +       fps = clamp_val(DIV_ROUND_CLOSEST(fi->denominator, fi->numerator),
> > +                       minfps, maxfps);
> > +
> > +       best_fps = minfps;
> > +       for (i = 0; i < ARRAY_SIZE(thp7312_framerates); i++) {
> > +               int curr_fps = thp7312_framerates[i];
> > +
> > +               if (abs(curr_fps - fps) < abs(best_fps - fps)) {
> > +                       best_fps = curr_fps;
> > +                       rate = i;
> > +               }
> > +       }
> > +
> > +       fi->numerator = 1;
> > +       fi->denominator = best_fps;
> > +
> > +find_mode:
> > +       mode_info = thp7312_find_mode(isp_dev, rate, width, height, false);
> > +       return mode_info ? rate : -EINVAL;
> > +}
> > +
> > +static int thp7312_get_fmt(struct v4l2_subdev *sd,
> > +                          struct v4l2_subdev_state *sd_state,
> > +                          struct v4l2_subdev_format *format)
> > +{
> > +       struct thp7312_isp_dev *isp_dev = to_thp7312_dev(sd);
> > +       struct v4l2_mbus_framefmt *fmt;
> > +
> > +       if (format->pad != 0)
> > +               return -EINVAL;
> > +
> > +       mutex_lock(&isp_dev->lock);
> > +
> > +       if (format->which == V4L2_SUBDEV_FORMAT_TRY) {
> > +               fmt = v4l2_subdev_get_try_format(&isp_dev->sd, sd_state,
> > +                                                format->pad);
> > +       } else {
> > +               fmt = &isp_dev->fmt;
> > +       }
> > +
> > +       format->format = *fmt;
> > +
> > +       mutex_unlock(&isp_dev->lock);
> > +
> > +       return 0;
> > +}
> > +
> > +static int thp7312_try_fmt_internal(struct v4l2_subdev *sd,
> > +                                   struct v4l2_mbus_framefmt *fmt,
> > +                                   enum thp7312_frame_rate frame_rate,
> > +                                   const struct thp7312_mode_info **new_mode)
> > +{
> > +       struct thp7312_isp_dev *isp_dev = to_thp7312_dev(sd);
> > +       const struct thp7312_mode_info *mode_info;
> > +       int i;
> > +
> > +       mode_info = thp7312_find_mode(isp_dev, frame_rate, fmt->width, fmt->height, true);
> > +       if (!mode_info)
> > +               return -EINVAL;
> > +       fmt->width = mode_info->width;
> > +       fmt->height = mode_info->height;
> > +       memset(fmt->reserved, 0, sizeof(fmt->reserved));
> > +
> > +       if (new_mode)
> > +               *new_mode = mode_info;
> > +
> > +       for (i = 0; i < ARRAY_SIZE(thp7312_colour_fmts); i++)
> > +               if (thp7312_colour_fmts[i].code == fmt->code)
> > +                       break;
> > +       if (i >= ARRAY_SIZE(thp7312_colour_fmts))
> > +               i = 0;
> > +
> > +       fmt->code = thp7312_colour_fmts[i].code;
> > +       fmt->colorspace = thp7312_colour_fmts[i].colorspace;
> > +       fmt->ycbcr_enc = V4L2_MAP_YCBCR_ENC_DEFAULT(fmt->colorspace);
> > +       fmt->quantization = V4L2_QUANTIZATION_FULL_RANGE;
> > +       fmt->xfer_func = V4L2_MAP_XFER_FUNC_DEFAULT(fmt->colorspace);
> > +
> > +       return 0;
> > +}
> > +
> > +static int thp7312_set_fmt(struct v4l2_subdev *sd,
> > +                          struct v4l2_subdev_state *sd_state,
> > +                          struct v4l2_subdev_format *format)
> > +{
> > +       struct thp7312_isp_dev *isp_dev = to_thp7312_dev(sd);
> > +       const struct thp7312_mode_info *new_mode;
> > +       struct v4l2_mbus_framefmt *mbus_fmt = &format->format;
> > +       struct v4l2_mbus_framefmt *fmt;
> > +       int ret;
> > +
> > +       if (format->pad != 0)
> > +               return -EINVAL;
> > +
> > +       mutex_lock(&isp_dev->lock);
> > +
> > +       if (isp_dev->streaming) {
> > +               ret = -EBUSY;
> > +               goto out;
> > +       }
> > +
> > +       ret = thp7312_try_fmt_internal(sd, mbus_fmt,
> > +                                      isp_dev->current_fr, &new_mode);
> > +       if (ret)
> > +               goto out;
> > +
> > +       if (format->which == V4L2_SUBDEV_FORMAT_TRY)
> > +               fmt = v4l2_subdev_get_try_format(sd, sd_state, format->pad);
> > +       else
> > +               fmt = &isp_dev->fmt;
> > +
> > +       *fmt = *mbus_fmt;
> > +
> > +       if (format->which == V4L2_SUBDEV_FORMAT_TRY)
> > +               goto out;
> > +
> > +       isp_dev->current_mode = (struct thp7312_mode_info *)new_mode;
> > +       isp_dev->fmt = *mbus_fmt;
> > +
> > +out:
> > +       mutex_unlock(&isp_dev->lock);
> > +       return ret;
> > +}
> > +
> > +static int thp7312_enum_frame_size(struct v4l2_subdev *sd,
> > +                                  struct v4l2_subdev_state *sd_state,
> > +                                  struct v4l2_subdev_frame_size_enum *fse)
> > +{
> > +       if (fse->pad != 0)
> > +               return -EINVAL;
> > +       if (fse->index >= THP7312_NUM_MODES)
> > +               return -EINVAL;
> > +
> > +       fse->min_width =
> > +               thp7312_mode_info_data[fse->index].width;
> > +       fse->max_width = fse->min_width;
> > +       fse->min_height =
> > +               thp7312_mode_info_data[fse->index].height;
> > +       fse->max_height = fse->min_height;
> > +
> > +       return 0;
> > +}
> > +
> > +static int thp7312_enum_frame_interval(struct v4l2_subdev *sd,
> > +                                      struct v4l2_subdev_state *sd_state,
> > +                                      struct v4l2_subdev_frame_interval_enum *fie)
> > +{
> > +       int i, j, count;
> > +
> > +       if (fie->pad != 0)
> > +               return -EINVAL;
> > +       if (fie->index >= THP7312_NUM_FRAMERATES)
> > +               return -EINVAL;
> > +
> > +       if (fie->width == 0 || fie->height == 0 || fie->code == 0)
> > +               return -EINVAL;
> > +
> > +       fie->interval.numerator = 1;
> > +
> > +       /*
> > +        * This is correct but, given the limited number of modes that we
> > +        * support, could be heavily simplified. Or do we want to keep this
> > +        * complexity for future-proofing?
> > +        */
> > +       count = 0;
> > +       for (i = 0; i < THP7312_NUM_FRAMERATES; i++) {
> > +               for (j = 0; j < THP7312_NUM_MODES; j++) {
> > +                       if (fie->width  == thp7312_mode_info_data[j].width &&
> > +                           fie->height == thp7312_mode_info_data[j].height &&
> > +                           !thp7312_check_valid_mode(&thp7312_mode_info_data[j], i))
> > +                               count++;
> > +
> > +                       if (fie->index == (count - 1)) {
> > +                               fie->interval.denominator = thp7312_framerates[i];
> > +                               return 0;
> > +                       }
> > +               }
> > +       }
> > +
> > +       return -EINVAL;
> > +}
> > +
> > +static int thp7312_g_frame_interval(struct v4l2_subdev *sd,
> > +                                   struct v4l2_subdev_frame_interval *fi)
> > +{
> > +       struct thp7312_isp_dev *isp_dev = to_thp7312_dev(sd);
> > +
> > +       mutex_lock(&isp_dev->lock);
> > +       fi->interval = isp_dev->frame_interval;
> > +       mutex_unlock(&isp_dev->lock);
> > +
> > +       return 0;
> > +}
> > +
> > +static int thp7312_s_frame_interval(struct v4l2_subdev *sd,
> > +                                   struct v4l2_subdev_frame_interval *fi)
> > +{
> > +       struct thp7312_isp_dev *isp_dev = to_thp7312_dev(sd);
> > +       const struct thp7312_mode_info *mode_info;
> > +       int frame_rate, ret = 0;
> > +
> > +       if (fi->pad != 0)
> > +               return -EINVAL;
> > +
> > +       mutex_lock(&isp_dev->lock);
> > +
> > +       if (isp_dev->streaming) {
> > +               ret = -EBUSY;
> > +               goto out;
> > +       }
> > +
> > +       mode_info = isp_dev->current_mode;
> > +
> > +       frame_rate = thp7312_try_frame_interval(isp_dev, &fi->interval,
> > +                                               mode_info->width, mode_info->height);
> > +       if (frame_rate < 0) {
> > +               /* This shouldn't be possible */
> > +               ret = -EINVAL;
> > +               goto out;
> > +       }
> > +
> > +       mode_info = thp7312_find_mode(isp_dev, frame_rate, mode_info->width,
> > +                                     mode_info->height, true);
> > +       if (!mode_info) {
> > +               ret = -EINVAL;
> > +               goto out;
> > +       }
> > +
> > +       isp_dev->current_fr = frame_rate;
> > +       isp_dev->frame_interval = fi->interval;
> > +       isp_dev->current_mode = (struct thp7312_mode_info *)mode_info;
> > +
> > +out:
> > +       mutex_unlock(&isp_dev->lock);
> > +       return ret;
> > +}
> > +
> > +static int thp7312_enum_mbus_code(struct v4l2_subdev *sd,
> > +                                 struct v4l2_subdev_state *sd_state,
> > +                                 struct v4l2_subdev_mbus_code_enum *code)
> > +{
> > +       if (code->pad != 0)
> > +               return -EINVAL;
> > +       if (code->index >= THP7312_NUM_FORMATS)
> > +               return -EINVAL;
> > +
> > +       code->code = thp7312_colour_fmts[code->index].code;
> > +
> > +       return 0;
> > +}
> > +
> > +static int thp7312_s_stream(struct v4l2_subdev *sd, int enable)
> > +{
> > +       struct thp7312_isp_dev *isp_dev = to_thp7312_dev(sd);
> > +       struct i2c_client *client = isp_dev->i2c_client;
> > +       int ret = 0;
> > +
> > +       mutex_lock(&isp_dev->lock);
> > +
> > +       if (!enable) {
> > +               ret = thp7312_stream_enable(isp_dev, enable);
> > +               if (ret < 0) {
> > +                       dev_err(&client->dev, "stream stop failed: %d\n", ret);
> > +                       goto finish_unlock;
> > +               }
> > +
> > +               isp_dev->streaming = enable;
> > +
> > +               goto finish_pm;
> > +       }
> > +
> > +       ret = pm_runtime_resume_and_get(&client->dev);
> > +       if (ret < 0)
> > +               goto finish_unlock;
> > +
> > +       ret = thp7312_check_valid_mode(isp_dev->current_mode,
> > +                                      isp_dev->current_fr);
> > +       if (ret) {
> > +               dev_err(&client->dev, "Not support WxH@fps=%dx%d@%d\n",
> > +                       isp_dev->current_mode->width,
> > +                       isp_dev->current_mode->height,
> > +                       thp7312_framerates[isp_dev->current_fr]);
> > +               goto finish_pm;
> > +       }
> > +
> > +       ret = thp7312_init_mode(isp_dev);
> > +       if (ret)
> > +               goto finish_pm;
> > +
> > +       ret = thp7312_stream_enable(isp_dev, enable);
> > +       if (ret < 0)
> > +               goto finish_pm;
> > +
> > +       isp_dev->streaming = enable;
> > +
> > +finish_pm:
> > +       pm_runtime_put(&client->dev);
> > +finish_unlock:
> > +       mutex_unlock(&isp_dev->lock);
> > +
> > +       return ret;
> > +}
> > +
> > +static const struct v4l2_subdev_core_ops thp7312_core_ops = {
> > +       .log_status = v4l2_ctrl_subdev_log_status,
> > +       .subscribe_event = v4l2_ctrl_subdev_subscribe_event,
> > +       .unsubscribe_event = v4l2_event_subdev_unsubscribe,
> > +};
> > +
> > +static const struct v4l2_subdev_video_ops thp7312_video_ops = {
> > +       .g_frame_interval = thp7312_g_frame_interval,
> > +       .s_frame_interval = thp7312_s_frame_interval,
> > +       .s_stream = thp7312_s_stream,
> > +};
> > +
> > +static const struct v4l2_subdev_pad_ops thp7312_pad_ops = {
> > +       .enum_mbus_code = thp7312_enum_mbus_code,
> > +       .get_fmt = thp7312_get_fmt,
> > +       .set_fmt = thp7312_set_fmt,
> > +       .enum_frame_size = thp7312_enum_frame_size,
> > +       .enum_frame_interval = thp7312_enum_frame_interval,
> > +};
> > +
> > +static const struct v4l2_subdev_ops thp7312_subdev_ops = {
> > +       .core = &thp7312_core_ops,
> > +       .video = &thp7312_video_ops,
> > +       .pad = &thp7312_pad_ops,
> > +};
> > +
> > +static inline struct thp7312_isp_dev *to_thp7312_from_ctrl(struct v4l2_ctrl *ctrl)
> > +{
> > +       return container_of(ctrl->handler, struct thp7312_isp_dev, ctrl_handler);
> > +}
> > +
> > +static int thp7312_set_manual_focus_position(struct thp7312_isp_dev *isp_dev, s32 val)
> > +{
> > +       struct i2c_client *client = isp_dev->i2c_client;
> > +       struct device *dev = &client->dev;
> > +
> > +       int ret = 0;
> > +       u16 value = 3000;
> > +
> > +       static u16 focus_values[] = {
> > +               3000, 1000, 600, 450, 350,
> > +               290,  240,  200, 170, 150,
> > +               140,  130,  120, 110, 100,
> > +               93,   87,   83,  80,
> > +       };
> > +
> > +       if (0 <= val && val < ARRAY_SIZE(focus_values))
> > +               value = focus_values[val];
> > +       else
> > +               dev_err(dev, "unsupported focus position = %d\n",val);
> > +
> > +       ret = thp7312_write_reg(isp_dev, THP7312_REG_MANUAL_FOCUS_POSITION,
> > +                               (s8)(value >> 8));
> > +       if (ret < 0)
> > +               goto out;
> > +
> > +       ret = thp7312_write_reg(isp_dev, THP7312_REG_MANUAL_FOCUS_POSITION + 1,
> > +                               (s8)(value & 0x00ff));
> > +       if (ret < 0)
> > +               goto out;
> > +
> > +out:
> > +       if (ret < 0)
> > +               dev_err(dev, "Failed to set manual focus position %d: %d\n", val, ret);
> > +
> > +       return ret;
> > +}
> > +
> > +static int
> > +thp7312_set_focus_mode(struct thp7312_isp_dev *isp_dev, bool auto_focus,
> > +                      bool continous, bool lock, enum thp7312_focus_method method)
> > +{
> > +       u8 value;
> > +       int ret = 0;
> > +
> > +       /* Set Continous and AF Method */
> > +
> > +       if (continous == true) {
> > +               /* Continous AF */
> > +               if (method == THP7312_FOCUS_METHOD_CONTRAST)
> > +                       value = 0x30;
> > +               else if (method == THP7312_FOCUS_METHOD_PDAF)
> > +                       value = 0x70;
> > +               else /* method == THP7312_FOCUS_METHOD_HYBRID */
> > +                       value = 0xF0;
> > +       } else {
> > +               /* One Shot AF */
> > +               if (method == THP7312_FOCUS_METHOD_CONTRAST)
> > +                       value = 0x00;
> > +               else if (method == THP7312_FOCUS_METHOD_PDAF)
> > +                       value = 0x40;
> > +               else /* method == THP7312_FOCUS_METHOD_HYBRID */
> > +                       value = 0x80;
> > +       }
> > +
> > +       ret = thp7312_write_reg(isp_dev, THP7312_REG_AF_SETTING, value);
> > +
> > +       isp_dev->af_continuous = continous;
> > +       isp_dev->af_method = method;
> > +
> > +       /* Set Lock and Focus Mode */
> > +
> > +       if (auto_focus == true) {
> > +               if (lock == true && continous == true)
> > +                       value = THP7312_FOCUS_MODE_AUTO_LOCK;
> > +               else
> > +                       value = THP7312_FOCUS_MODE_AUTO_CONTINOUS;
> > +
> > +               isp_dev->focus_mode_auto = true;
> > +       } else {
> > +               /* Lock AF to prepare to set manual focus mode */
> > +               ret = thp7312_write_reg(isp_dev, THP7312_REG_AF_CONTROL,
> > +                                       THP7312_FOCUS_MODE_AUTO_LOCK);
> > +               value = THP7312_FOCUS_MODE_MANUAL;
> > +
> > +               isp_dev->focus_mode_auto = false;
> > +       }
> > +
> > +       ret = thp7312_write_reg(isp_dev, THP7312_REG_AF_CONTROL, value);
> > +
> > +       isp_dev->af_lock = lock;
> > +
> > +       return ret;
> > +}
> > +
> > +static int thp7312_s_ctrl(struct v4l2_ctrl *ctrl)
> > +{
> > +       struct thp7312_isp_dev *isp_dev = to_thp7312_from_ctrl(ctrl);
> > +       struct i2c_client *client = isp_dev->i2c_client;
> > +       struct device *dev = &client->dev;
> > +       int ret = 0;
> > +       u8 value;
> > +       bool lock;
> > +
> > +       if (ctrl->flags & V4L2_CTRL_FLAG_INACTIVE)
> > +               return -EINVAL;
> > +
> > +       dev_dbg(dev, "s_ctrl id %d, value %d\n", ctrl->id, ctrl->val);
> > +
> > +       if (pm_runtime_get_if_in_use(&client->dev))
> > +               return 0;
> > +
> > +       switch (ctrl->id) {
> > +
> > +       case V4L2_CID_BRIGHTNESS:
> > +               value = clamp_t(int, ctrl->val, -10, 10) + 10;
> > +               ret = thp7312_write_reg(isp_dev, THP7312_REG_BRIGHTNESS, value);
> > +               break;
> > +
> > +       case V4L2_CID_THINE_LOW_LIGHT_COMPENSATION:
> > +               /* 0 = Auto adjust frame rate, 1 = Fix frame rate */
> > +               value = (ctrl->val == true) ? 0 : 1;
> > +               ret = thp7312_write_reg(isp_dev, THP7312_REG_AE_FIX_FRAME_RATE, value);
> > +               break;
> > +
> > +       case V4L2_CID_FOCUS_AUTO:
> > +               lock = (ctrl->val == true) ? false : true;
> > +               ret = thp7312_set_focus_mode(isp_dev, true, true, lock,
> > +                                            isp_dev->af_method);
> > +               break;
> > +
> > +       case V4L2_CID_FOCUS_ABSOLUTE:
> > +               ret = thp7312_set_manual_focus_position(isp_dev, ctrl->val);
> > +               if (ret < 0) {
> > +                       dev_err(dev, "thp7312_set_manual_focus failed  %d\n", value);
> > +                       break;
> > +               }
> > +
> > +               /*
> > +                * If we're in auto, don't change to manual mode. The hardware
> > +                * will not apply the focus potision if it's set to auto, so no
> > +                * need to skip that.
> > +                */
> > +               if (isp_dev->af_continuous == true && isp_dev->af_lock == false)
> > +                       break;
> > +
> > +               /* Change to manual mode */
> > +               ret = thp7312_set_focus_mode(isp_dev, false, false, false,
> > +                                            isp_dev->af_method);
> > +               break;
> > +
> > +
> > +       case V4L2_CID_AUTO_FOCUS_START:
> > +               /* If we're in auto, don't do one-shot AF. */
> > +               if (isp_dev->af_continuous == true && isp_dev->af_lock == false)
> > +                       break;
> > +
> > +               /* Change to one-shot auto mode (with lock) */
> > +               ret = thp7312_set_focus_mode(isp_dev, true, false, true,
> > +                                            isp_dev->af_method);
> > +               break;
> > +
> > +
> > +       case V4L2_CID_THINE_AUTO_FOCUS_METHOD:
> > +               ret = thp7312_set_focus_mode(isp_dev, isp_dev->focus_mode_auto,
> > +                                            isp_dev->af_continuous,
> > +                                            isp_dev->af_lock, ctrl->val);
> > +               break;
> > +
> > +
> > +       case V4L2_CID_ROTATE:
> > +               if (ctrl->val == 0)
> > +                       value = 0; /* 0 degree. camera is set to normal.*/
> > +               else
> > +                       value = 3; /* 180 degree. camera is set to flip & mirror */
> > +
> > +               ret = thp7312_write_reg(isp_dev, THP7312_REG_FLIP_MIRROR, value);
> > +               if (ret < 0)
> > +                       dev_err(dev, "Failed to set flip and mirror: %d\n", ret);
> > +               break;
> > +
> > +       case V4L2_CID_THINE_NOISE_REDUCTION_AUTO:
> > +               ret = thp7312_read_reg(isp_dev, THP7312_REG_NOISE_REDUCTION, &value);
> > +               if (ret < 0) {
> > +                       dev_err(dev, "Failed to read noise reduction: %d\n", ret);
> > +                       break;
> > +               }
> > +
> > +               value = (ctrl->val == true) ? (value & 0x7F) : (value | 0x80);
> > +
> > +               ret = thp7312_write_reg(isp_dev, THP7312_REG_NOISE_REDUCTION, value);
> > +               if (ret < 0)
> > +                       dev_err(dev, "Failed to set noise reduction auto: %d\n", ret);
> > +               break;
> > +
> > +       case V4L2_CID_THINE_NOISE_REDUCTION_ABSOLUTE:
> > +               ret = thp7312_read_reg(isp_dev, THP7312_REG_NOISE_REDUCTION, &value);
> > +               if (ret < 0) {
> > +                       dev_err(dev, "Failed to read noise reduction: %d\n", ret);
> > +                       break;
> > +               }
> > +
> > +               value = value & 0x80;
> > +               value = value | (ctrl->val & 0x7F);
> > +
> > +               ret = thp7312_write_reg(isp_dev, THP7312_REG_NOISE_REDUCTION, value);
> > +               if (ret < 0)
> > +                       dev_err(dev, "Failed to set noise reduction absolute: %d\n", ret);
> > +               break;
> > +
> > +       case V4L2_CID_AUTO_WHITE_BALANCE:
> > +               value = (ctrl->val == true) ? THP7312_WB_MODE_AUTO : THP7312_WB_MODE_MANUAL;
> > +
> > +               ret = thp7312_write_reg(isp_dev, THP7312_REG_WB_MODE, value);
> > +               if (ret < 0)
> > +                       dev_err(dev, "Failed to write auto white balance: %d\n", ret);
> > +               break;
> > +
> > +       case V4L2_CID_RED_BALANCE:
> > +               ret = thp7312_write_reg(isp_dev, THP7312_REG_MANUAL_WB_RED_GAIN, ctrl->val);
> > +               if (ret < 0)
> > +                       dev_err(dev, "Failed to write manual red balance: %d\n", ret);
> > +               break;
> > +
> > +       case V4L2_CID_BLUE_BALANCE:
> > +               ret = thp7312_write_reg(isp_dev, THP7312_REG_MANUAL_WB_BLUE_GAIN, ctrl->val);
> > +               if (ret < 0)
> > +                       dev_err(dev, "Failed to write manual blue balance: %d\n", ret);
> > +               break;
> > +
> > +       case V4L2_CID_AUTO_EXPOSURE_BIAS:
> > +               ret = thp7312_write_reg(isp_dev, THP7312_REG_AE_EXPOSURE_COMPENSATION, ctrl->val);
> > +               break;
> > +
> > +       case V4L2_CID_POWER_LINE_FREQUENCY:
> > +               if (ctrl->val == V4L2_CID_POWER_LINE_FREQUENCY_60HZ) {
> > +                       value = THP7312_AE_FLICKER_MODE_60;
> > +               } else if (ctrl->val==V4L2_CID_POWER_LINE_FREQUENCY_50HZ) {
> > +                       value = THP7312_AE_FLICKER_MODE_50;
> > +               } else {
> > +                       if (isp_dev->fw_major_version == 40 && isp_dev->fw_minor_version == 03) {
> > +                               /* THP7312_AE_FLICKER_MODE_DISABLE is not supported */
> > +                               value = THP7312_AE_FLICKER_MODE_50;
> > +                       } else {
> > +                               value = THP7312_AE_FLICKER_MODE_DISABLE;
> > +                       }
> > +               }
> > +               ret = thp7312_write_reg(isp_dev, THP7312_REG_AE_FLICKER_MODE, value);
> > +               break;
> > +
> > +       case V4L2_CID_SATURATION:
> > +               ret = thp7312_write_reg(isp_dev, THP7312_REG_SATURATION, ctrl->val);
> > +               break;
> > +
> > +       case V4L2_CID_CONTRAST:
> > +               ret = thp7312_write_reg(isp_dev, THP7312_REG_CONTRAST, ctrl->val);
> > +               break;
> > +
> > +       case V4L2_CID_SHARPNESS:
> > +               ret = thp7312_write_reg(isp_dev, THP7312_REG_SHARPNESS, ctrl->val);
> > +               break;
> > +
> > +       default:
> > +               dev_err(dev, "unsupported control id: %d\n", ctrl->id);
> > +               break;
> > +       }
> > +
> > +       pm_runtime_put(&client->dev);
> > +
> > +       return ret;
> > +}
> > +
> > +static const struct v4l2_ctrl_ops thp7312_ctrl_ops = {
> > +       .s_ctrl = thp7312_s_ctrl,
> > +};
> > +
> > +static const struct v4l2_ctrl_config thp7312_v4l2_ctrls_custom[] = {
> > +       {
> > +               .ops = &thp7312_ctrl_ops,
> > +               .id = V4L2_CID_THINE_LOW_LIGHT_COMPENSATION,
> > +               .name = "Low Light Compensation",
> > +               .type = V4L2_CTRL_TYPE_BOOLEAN,
> > +               .min = 0,
> > +               .def = 1,
> > +               .max = 1,
> > +               .step = 1,
> > +       },
> > +
> > +       {
> > +               .ops = &thp7312_ctrl_ops,
> > +               .id = V4L2_CID_THINE_AUTO_FOCUS_METHOD,
> > +               .name = "Auto-Focus Method",
> > +               .type = V4L2_CTRL_TYPE_INTEGER,
> > +               .min = 0,
> > +               .def = 2,
> > +               .max = 2,
> > +               .step = 1,
> > +       },
> > +
> > +       {
> > +               .ops = &thp7312_ctrl_ops,
> > +               .id = V4L2_CID_THINE_NOISE_REDUCTION_AUTO,
> > +               .name = "Noise Reduction Auto",
> > +               .type = V4L2_CTRL_TYPE_BOOLEAN,
> > +               .min = 0,
> > +               .def = 1,
> > +               .max = 1,
> > +               .step = 1,
> > +       },
> > +
> > +       {
> > +               .ops = &thp7312_ctrl_ops,
> > +               .id = V4L2_CID_THINE_NOISE_REDUCTION_ABSOLUTE,
> > +               .name = "Noise Reduction Level",
> > +               .type = V4L2_CTRL_TYPE_INTEGER,
> > +               .min = 0,
> > +               .def = 0,
> > +               .max = 10,
> > +               .step = 1,
> > +       },
> > +};
> > +
> > +static const s64 exp_bias_qmenu[] = {
> > +       -2000, -1667, -1333, -1000, -667, -333, 0, 333, 667, 1000, 1333, 1667, 2000
> > +};
> > +
> > +static int thp7312_init_controls(struct thp7312_isp_dev *isp_dev)
> > +{
> > +       struct v4l2_ctrl *ctrl;
> > +       struct device *dev = &isp_dev->i2c_client->dev;
> > +       int i, ret = 0;
> > +       struct v4l2_ctrl_handler *hdl = &isp_dev->ctrl_handler;
> > +       struct v4l2_fwnode_device_properties props;
> > +
> > +       v4l2_ctrl_handler_init(hdl, 64);
> > +
> > +       v4l2_ctrl_new_std(hdl, &thp7312_ctrl_ops, V4L2_CID_FOCUS_AUTO,
> > +                         0, 1, 1, 1);
> > +       v4l2_ctrl_new_std(hdl, &thp7312_ctrl_ops, V4L2_CID_AUTO_FOCUS_START,
> > +                         1, 1, 1, 1);
> > +       /* 0: 3000cm, 18: 8cm */
> > +       ctrl = v4l2_ctrl_new_std(hdl, &thp7312_ctrl_ops, V4L2_CID_FOCUS_ABSOLUTE,
> > +                                0, 18, 1, 0);
> > +       if (ctrl != NULL) {
> > +               /*
> > +                * This needs to be set so that the value will be saved even if
> > +                * it is set while FOCUS_AUTO is true
> > +                */
> > +               ctrl->flags |= V4L2_CTRL_FLAG_EXECUTE_ON_WRITE;
> > +       }
> > +
> > +       v4l2_ctrl_new_std(hdl, &thp7312_ctrl_ops, V4L2_CID_AUTO_WHITE_BALANCE,
> > +                         0, 1, 1, 1);
> > +       /* 32: 1x, 255: 7.95x */
> > +       v4l2_ctrl_new_std(hdl, &thp7312_ctrl_ops, V4L2_CID_RED_BALANCE,
> > +                         32, 255, 1, 64);
> > +       /* 32: 1x, 255: 7.95x */
> > +       v4l2_ctrl_new_std(hdl, &thp7312_ctrl_ops, V4L2_CID_BLUE_BALANCE,
> > +                         32, 255, 1, 50);
> > +
> > +       v4l2_ctrl_new_std(hdl, &thp7312_ctrl_ops, V4L2_CID_BRIGHTNESS,
> > +                         -10, 10, 1, 0);
> > +       v4l2_ctrl_new_std(hdl, &thp7312_ctrl_ops, V4L2_CID_SATURATION,
> > +                         0, 31, 1, 10);
> > +       v4l2_ctrl_new_std(hdl, &thp7312_ctrl_ops, V4L2_CID_CONTRAST,
> > +                         0, 20, 1, 10);
> > +       v4l2_ctrl_new_std(hdl, &thp7312_ctrl_ops, V4L2_CID_SHARPNESS,
> > +                         0, 31, 1, 8);
> > +
> > +       v4l2_ctrl_new_std(hdl, &thp7312_ctrl_ops, V4L2_CID_ROTATE,
> > +                         0, 180, 180, 0);
> > +
> > +       v4l2_ctrl_new_int_menu(hdl, &thp7312_ctrl_ops,
> > +                              V4L2_CID_AUTO_EXPOSURE_BIAS,
> > +                              ARRAY_SIZE(exp_bias_qmenu) - 1,
> > +                              ARRAY_SIZE(exp_bias_qmenu) / 2, exp_bias_qmenu);
> > +
> > +       v4l2_ctrl_new_std_menu(hdl, &thp7312_ctrl_ops,
> > +                              V4L2_CID_POWER_LINE_FREQUENCY,
> > +                              V4L2_CID_POWER_LINE_FREQUENCY_60HZ, 0,
> > +                              V4L2_CID_POWER_LINE_FREQUENCY_50HZ);
> > +
> > +       /* set properties from fwnode (e.g. rotation, orientation) */
> > +       ret = v4l2_fwnode_device_parse(dev, &props);
> > +       if (ret) {
> > +               dev_err(dev, "Failed to parse fwnode: %d\n", ret);
> > +               goto error;
> > +       }
> > +
> > +       ret = v4l2_ctrl_new_fwnode_properties(hdl, &thp7312_ctrl_ops, &props);
> > +       if (ret) {
> > +               dev_err(dev, "Failed to create new v4l2 ctrl for fwnode properties: %d\n", ret);
> > +               goto error;
> > +       }
> > +
> > +       for (i = 0; i < ARRAY_SIZE(thp7312_v4l2_ctrls_custom); i++)
> > +               v4l2_ctrl_new_custom(hdl, &thp7312_v4l2_ctrls_custom[i], NULL);
> > +
> > +       if (hdl->error) {
> > +               dev_err(dev, "v4l2_ctrl_handler error\n");
> > +               ret = hdl->error;
> > +               goto error;
> > +       }
> > +
> > +       v4l2_ctrl_handler_setup(hdl);
> > +
> > +       return ret;
> > +
> > +error:
> > +       v4l2_ctrl_handler_free(hdl);
> > +       return ret;
> > +}
> > +
> > +static int thp7312_read_firmware_version(struct thp7312_isp_dev *isp_dev)
> > +{
> > +       int ret;
> > +
> > +       ret = thp7312_read_reg(isp_dev, THP7312_REG_FIRMWARE_VERSION_1,
> > +                              &isp_dev->fw_major_version);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       return thp7312_read_reg(isp_dev, THP7312_REG_FIRMWARE_VERSION_2,
> > +                               &isp_dev->fw_minor_version);
> > +}
> > +
> > +static void thp7312_init_fmt(struct thp7312_isp_dev *isp_dev)
> > +{
> > +       struct v4l2_mbus_framefmt *fmt;
> > +
> > +       /*
> > +        * default init sequence initialize isp_dev to
> > +        * YUV422 YUYV VGA@30fps
> > +        */
> > +       fmt = &isp_dev->fmt;
> > +       fmt->code = MEDIA_BUS_FMT_YUYV8_1X16;
> > +       fmt->colorspace = V4L2_COLORSPACE_SRGB;
> > +       fmt->ycbcr_enc = V4L2_MAP_YCBCR_ENC_DEFAULT(fmt->colorspace);
> > +       fmt->quantization = V4L2_QUANTIZATION_FULL_RANGE;
> > +       fmt->xfer_func = V4L2_MAP_XFER_FUNC_DEFAULT(fmt->colorspace);
> > +       fmt->width = 1920;
> > +       fmt->height = 1080;
> > +       fmt->field = V4L2_FIELD_NONE;
> > +       isp_dev->frame_interval.numerator = 1;
> > +       isp_dev->frame_interval.denominator = thp7312_framerates[THP7312_30_FPS];
> > +       isp_dev->current_fr = THP7312_30_FPS;
> > +
> > +       isp_dev->active_mode = &thp7312_mode_info_data[0];
> > +}
> > +
> > +static int thp7312_parse_dt(struct thp7312_isp_dev *isp_dev)
> > +{
> > +       struct fwnode_handle *endpoint;
> > +       struct device *dev = &isp_dev->i2c_client->dev;
> > +       int ret;
> > +
> > +       endpoint = fwnode_graph_get_next_endpoint(dev_fwnode(dev), NULL);
> > +       if (!endpoint) {
> > +               dev_err(dev, "endpoint node not found\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       ret = v4l2_fwnode_endpoint_parse(endpoint, &isp_dev->ep);
> > +       fwnode_handle_put(endpoint);
> > +       if (ret) {
> > +               dev_err(dev, "Could not parse endpoint\n");
> > +               return ret;
> > +       }
> > +
> > +       if (isp_dev->ep.bus_type != V4L2_MBUS_CSI2_DPHY) {
> > +               dev_err(dev, "Unsupported bus type %d\n", isp_dev->ep.bus_type);
> > +               return -EINVAL;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int thp7312_probe(struct i2c_client *client)
> > +{
> > +       struct device *dev = &client->dev;
> > +       struct thp7312_isp_dev *isp_dev;
> > +       int ret;
> > +
> > +       dev_info(dev, "Start of probe %s:%d", __func__, __LINE__);
> > +       isp_dev = devm_kzalloc(dev, sizeof(*isp_dev), GFP_KERNEL);
> > +       if (!isp_dev)
> > +               return -ENOMEM;
> > +       isp_dev->i2c_client = client;
> > +
> > +       thp7312_init_fmt(isp_dev);
> > +
> > +       isp_dev->current_mode =
> > +               (struct thp7312_mode_info *)thp7312_find_mode(isp_dev,
> > +                                                             isp_dev->current_fr,
> > +                                                             isp_dev->fmt.width,
> > +                                                             isp_dev->fmt.height,
> > +                                                             true);
> > +
> > +       /* TODO fix firmware */
> > +       /* update mode hardcoded at 0 for now */
> > +       isp_dev->fw_update_mode = 0;
> > +       isp_dev->fw_major_version = 0;
> > +       isp_dev->fw_minor_version = 0;
> > +       isp_dev->thp7312_register_rw_address = 61440;
> > +
> > +       ret = thp7312_parse_dt(isp_dev);
> > +       if (ret < 0) {
> > +               dev_err(dev, "Failed to parse DT: %d\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       ret = thp7312_get_regulators(isp_dev);
> > +       if (ret) {
> > +               dev_err(dev, "Failed to get regulators: %d\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       isp_dev->iclk = devm_clk_get(dev, NULL);
> > +       if (IS_ERR(isp_dev->iclk)) {
> > +               dev_err(dev, "Failed to get iclk\n");
> > +               return PTR_ERR(isp_dev->iclk);
> > +       }
> > +
> > +       /* request reset pin */
> > +       isp_dev->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> > +       if (IS_ERR(isp_dev->reset_gpio)) {
> > +               dev_err(dev, "Failed to get reset gpio\n");
> > +               return PTR_ERR(isp_dev->reset_gpio);
> > +       }
> > +
> > +       v4l2_i2c_subdev_init(&isp_dev->sd, client, &thp7312_subdev_ops);
> > +       isp_dev->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE | V4L2_SUBDEV_FL_HAS_EVENTS;
> > +       isp_dev->pad.flags = MEDIA_PAD_FL_SOURCE;
> > +       isp_dev->sd.entity.function = MEDIA_ENT_F_CAM_SENSOR;
> > +
> > +       mutex_init(&isp_dev->lock);
> > +
> > +       ret = media_entity_pads_init(&isp_dev->sd.entity, 1, &isp_dev->pad);
> > +       if (ret)
> > +               goto mutex_destroy;
> > +
> > +       ret = thp7312_set_power_on(dev);
> > +       if (ret)
> > +               goto entity_cleanup;
> > +
> > +       ret = thp7312_read_firmware_version(isp_dev);
> > +       if (ret < 0) {
> > +               dev_warn(dev, "Camera is not found\n");
> > +               goto power_off;
> > +       }
> > +
> > +       dev_info(dev, "THP7312 firmware version = %02d.%02d",
> > +                isp_dev->fw_major_version, isp_dev->fw_minor_version);
> > +
> > +       ret = thp7312_init_controls(isp_dev);
> > +       if (ret)
> > +               goto power_off;
> > +
> > +       isp_dev->sd.ctrl_handler = &isp_dev->ctrl_handler;
> > +
> > +       ret = v4l2_async_register_subdev(&isp_dev->sd);
> > +       if (ret < 0) {
> > +               dev_err(dev, "Subdev registeration failed");
> > +               goto free_ctrls;
> > +       }
> > +
> > +       pm_runtime_set_active(dev);
> > +       pm_runtime_enable(dev);
> > +
> > +       dev_info(dev, "v4l2 async register subdev done");
> > +
> > +       return 0;
> > +
> > +free_ctrls:
> > +       v4l2_ctrl_handler_free(&isp_dev->ctrl_handler);
> > +power_off:
> > +       thp7312_set_power_off(dev);
> > +entity_cleanup:
> > +       media_entity_cleanup(&isp_dev->sd.entity);
> > +mutex_destroy:
> > +       mutex_destroy(&isp_dev->lock);
> > +       return ret;
> > +}
> > +
> > +static void thp7312_remove(struct i2c_client *client)
> > +{
> > +       struct v4l2_subdev *sd = i2c_get_clientdata(client);
> > +       struct thp7312_isp_dev *isp_dev = to_thp7312_dev(sd);
> > +
> > +       v4l2_async_unregister_subdev(&isp_dev->sd);
> > +       v4l2_ctrl_handler_free(&isp_dev->ctrl_handler);
> > +       media_entity_cleanup(&isp_dev->sd.entity);
> > +       v4l2_device_unregister_subdev(sd);
> > +       pm_runtime_disable(&client->dev);
> > +       mutex_destroy(&isp_dev->lock);
> > +}
> > +
> > +static const struct i2c_device_id thp7312_id[] = {
> > +       {"thp7312", 0},
> > +       {},
> > +};
> > +MODULE_DEVICE_TABLE(i2c, thp7312_id);
> > +
> > +static const struct of_device_id thp7312_dt_ids[] = {
> > +       { .compatible = "thine,thp7312" },
> > +       { /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, thp7312_dt_ids);
> > +
> > +static const struct dev_pm_ops thp7312_pm_ops = {
> > +       SET_RUNTIME_PM_OPS(thp7312_set_power_off, thp7312_set_power_on, NULL)
> > +};
> > +
> > +static struct i2c_driver thp7312_i2c_driver = {
> > +       .driver = {
> > +               .name  = "thp7312",
> > +               .of_match_table = thp7312_dt_ids,
> > +       },
> > +       .id_table = thp7312_id,
> > +       .probe_new = thp7312_probe,
> > +       .remove   = thp7312_remove,
> > +};
> > +
> > +module_i2c_driver(thp7312_i2c_driver);
> > +
> > +MODULE_DESCRIPTION("THP7312 MIPI Camera Subdev Driver");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.39.2
> >
