Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7717DC338
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 00:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjJ3XiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 19:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjJ3XiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 19:38:09 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05575C2;
        Mon, 30 Oct 2023 16:38:05 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E16593D6;
        Tue, 31 Oct 2023 00:37:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1698709068;
        bh=ocghPvUkVuC2JBXsnLGBMenNLVMIBQOAXmT2GXhPlRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LrgxHWQ9b0cjebEd6q0+TTQjZAuK/YqP+yhs60AcMWdYvDhZ6zKcUWH40Xn7qm4ec
         8gvHNaMRpIHEo/v8ZO1qf3eVpe5ZN6acMlbyWzlmia/zK23kStt6/AiaCs1nx3wimL
         MWGlVvgxUvYvFW+5M7YoSsiqRX27eczfrDDwnj00=
Date:   Tue, 31 Oct 2023 01:38:09 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Tommaso Merciai <tomm.merciai@gmail.com>, martin.hecht@avnet.eu,
        michael.roeder@avnet.eu, mhecht73@gmail.com,
        linuxfancy@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Scally <djrscally@gmail.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v10 3/3] media: i2c: Add support for alvium camera
Message-ID: <20231030233809.GD12764@pendragon.ideasonboard.com>
References: <20231020141354.2500602-1-tomm.merciai@gmail.com>
 <20231020141354.2500602-4-tomm.merciai@gmail.com>
 <ZTpnHdpTgRNll3TC@kekkonen.localdomain>
 <ZT+hEg7WqkQBnLV5@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <ZUAxoy2cRR6Rm9ig@kekkonen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZUAxoy2cRR6Rm9ig@kekkonen.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Hans, there's a question for you below.

On Mon, Oct 30, 2023 at 10:43:47PM +0000, Sakari Ailus wrote:
> Hi Tommaso,
> 
> On Mon, Oct 30, 2023 at 01:26:58PM +0100, Tommaso Merciai wrote:
> 
> ...
> 
> > > > +static int alvium_get_host_supp_csi_lanes(struct alvium_dev *alvium)
> > > > +{
> > > > +	u64 val;
> > > > +	int ret = 0;
> > > > +
> > > > +	alvium_read(alvium, REG_BCRM_CSI2_LANE_COUNT_RW, &val, &ret);
> > > 
> > > Missing error checking before the use of the value. The same pattern
> > > remains prevalent throughout the driver.
> > > 
> > > I think it'd be easier if you didn't use a temporary variable for reading,
> > > but instead had a register width specific access function. You could even
> > > introduce a helper macro to read this information as I suggested in an
> > > earlier review.
> > 
> > oks.
> > We are moving to use the following macros:
> > 
> > #define alvium_read_check(alvium, reg, value) \
> > { \
> > 	int ret = alvium_read(alvium, reg, value, NULL); \
> > 	if (ret) \
> > 		return ret; \
> > }
> > 
> 
> You could do something like (entirely untested):
> 
> #define ALVIUM_DECLARE_READ(sign, bits) \
> 	static int
> 	alvium_read_ ## sign ## bits(struct alvium_dev *alvium, u32 reg, \
> 				     sign ## bits *val, int *err) \
> 	{ \
> 		u64 val64; \
> 		int ret; \
> 			\
> 		if (err && *err < 0) \
> 			return *err; \
> 			\
> 		alvium_read(alvium, reg, &val64, &ret); \
> 		if (ret < 0) { \
> 			if (err) \
> 				*err = ret; \
> 			return ret; \
> 		}	\
> 			\
> 		*val = val64; \
> 			\
> 		return 0; \
> 	}
> 
> ALVIUM_DECLARE_READ(u, 32);
> 
> And then, e.g. instead of (and failing to check ret):
> 
> 	u64 val;
> 
> 	alvium_read(alvium, REG_BCRM_CONTRAST_VALUE_RW, &val, &ret);
> 	alvium->dft_contrast = val;
> 
> you'd have a single call:
> 
> 	alvium_read_u32(alvium, REG_BCRM_CONTRAST_VALUE_RW,
> 		        &alvium->dft_contrast, &ret);
> 
> And so on.
> 
> You can drop sign if you don't need signed reads but some of the struct
> fields you're writing something appear to be signed.
> 
> It'd be good to check the register size matches with the size of *val, too.
> Maybe something like:
> 
> WARN_ON((CCI_REG ## bits(0) && CCI_REG_WIDTH_MASK) >> CCI_REG_WIDTH_SHIFT
> 	!= sizeof(sign ## bits));

I think this could actually be automated, and implemented in v4l2-cci.
Something like the following:

diff --git a/drivers/media/v4l2-core/v4l2-cci.c b/drivers/media/v4l2-core/v4l2-cci.c
index bc2dbec019b0..27f1eaa7777d 100644
--- a/drivers/media/v4l2-core/v4l2-cci.c
+++ b/drivers/media/v4l2-core/v4l2-cci.c
@@ -16,7 +16,7 @@

 #include <media/v4l2-cci.h>

-int cci_read(struct regmap *map, u32 reg, u64 *val, int *err)
+int __cci_read(struct regmap *map, u32 reg, void *val, int *err)
 {
 	unsigned int len;
 	u8 buf[8];
@@ -37,19 +37,19 @@ int cci_read(struct regmap *map, u32 reg, u64 *val, int *err)

 	switch (len) {
 	case 1:
-		*val = buf[0];
+		*(u8 *)val = buf[0];
 		break;
 	case 2:
-		*val = get_unaligned_be16(buf);
+		*(u16 *)val = get_unaligned_be16(buf);
 		break;
 	case 3:
-		*val = get_unaligned_be24(buf);
+		*(u32 *)val = get_unaligned_be24(buf);
 		break;
 	case 4:
-		*val = get_unaligned_be32(buf);
+		*(u32 *)val = get_unaligned_be32(buf);
 		break;
 	case 8:
-		*val = get_unaligned_be64(buf);
+		*(u64 *)val = get_unaligned_be64(buf);
 		break;
 	default:
 		dev_err(regmap_get_device(map), "Error invalid reg-width %u for reg 0x%04x\n",
@@ -64,7 +64,7 @@ int cci_read(struct regmap *map, u32 reg, u64 *val, int *err)

 	return ret;
 }
-EXPORT_SYMBOL_GPL(cci_read);
+EXPORT_SYMBOL_GPL(__cci_read);

 int cci_write(struct regmap *map, u32 reg, u64 val, int *err)
 {
@@ -119,7 +119,7 @@ int cci_update_bits(struct regmap *map, u32 reg, u64 mask, u64 val, int *err)
 	u64 readval;
 	int ret;

-	ret = cci_read(map, reg, &readval, err);
+	ret = __cci_read(map, reg, &readval, err);
 	if (ret)
 		return ret;

diff --git a/include/media/v4l2-cci.h b/include/media/v4l2-cci.h
index 0f6803e4b17e..31223ce8d741 100644
--- a/include/media/v4l2-cci.h
+++ b/include/media/v4l2-cci.h
@@ -7,6 +7,9 @@
 #ifndef _V4L2_CCI_H
 #define _V4L2_CCI_H

+#include <linux/bitfield.h>
+#include <linux/build_bug.h>
+#include <linux/log2.h>
 #include <linux/types.h>

 struct i2c_client;
@@ -39,6 +42,8 @@ struct cci_reg_sequence {
 #define CCI_REG32(x)			((4 << CCI_REG_WIDTH_SHIFT) | (x))
 #define CCI_REG64(x)			((8 << CCI_REG_WIDTH_SHIFT) | (x))

+int __cci_read(struct regmap *map, u32 reg, void *val, int *err);
+
 /**
  * cci_read() - Read a value from a single CCI register
  *
@@ -48,9 +53,17 @@ struct cci_reg_sequence {
  * @err: Optional pointer to store errors, if a previous error is set
  *       then the read will be skipped
  *
+ * The type of the @val pointer must match the size of the register being read.
+ * Mismatches will result in compile-time errors.
+ *
  * Return: %0 on success or a negative error code on failure.
  */
-int cci_read(struct regmap *map, u32 reg, u64 *val, int *err);
+#define cci_read(map, reg, val, err) ({					\
+	u32 __reg = (reg);						\
+	u32 __size = FIELD_GET(CCI_REG_WIDTH_MASK, __reg);		\
+	BUILD_BUG_ON(sizeof(*(val)) != roundup_pow_of_two(__size));	\
+	__cci_read(map, __reg, (void *)(val), err);			\
+})

 /**
  * cci_write() - Write a value to a single CCI register

The change to cci_update_bits() is obviously wrong, I've hacked that to
compile-test the rest with the drivers using cci_read(), and I get nice
build-time errors due to usage of the wrong type :-)

Is this something that would be considered ? Bonus points to anyone who
would fix cci_update_bits() :-)

> > > > +static int alvium_get_csi_clk_params(struct alvium_dev *alvium)
> > > > +{
> > > > +	u64 val;
> > > > +	int ret = 0;
> > > > +
> > > > +	alvium_read(alvium, REG_BCRM_CSI2_CLOCK_MIN_R, &val, &ret);
> > > > +	alvium->min_csi_clk = val;
> > > > +
> > > > +	alvium_read(alvium, REG_BCRM_CSI2_CLOCK_MAX_R, &val, &ret);
> > > > +	alvium->max_csi_clk = val;
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +static int alvium_set_csi_clk(struct alvium_dev *alvium)
> > > > +{
> > > > +	struct device *dev = &alvium->i2c_client->dev;
> > > > +	u64 csi_clk;
> > > > +	int ret;
> > > > +
> > > > +	csi_clk = (u32)alvium->ep.link_frequencies[0];
> > > 
> > > Why casting to u32? Shouldn't csi_clk be u32 instead?
> > 
> > Ok we fix this in v11.
> > Change to use u64 for calculation because type of ep.link_frequencies[0]
> > Plan is to clamp csi_clk between min/max instead of returning error.
> 
> I think I would keep it as-is: this isn't V4L2 UAPI.
> 
> > > > +
> > > > +	if (csi_clk < alvium->min_csi_clk || csi_clk > alvium->max_csi_clk)
> > > > +		return -EINVAL;
> > > > +
> > > > +	ret = alvium_write_hshake(alvium, REG_BCRM_CSI2_CLOCK_RW, csi_clk);
> > > > +	if (ret) {
> > > > +		dev_err(dev, "Fail to set csi lanes reg\n");
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	alvium->link_freq = alvium->ep.link_frequencies[0];
> > > > +
> > > > +	return 0;
> > > > +}
> 
> ...
> 
> > > > +			goto out;
> > > > +
> > > > +		ret = alvium_set_mode(alvium, state);
> > > > +		if (ret)
> > > > +			goto out;
> > > > +
> > > > +		fmt = v4l2_subdev_get_pad_format(sd, state, 0);
> > > > +		ret = alvium_set_framefmt(alvium, fmt);
> > > > +		if (ret)
> > > > +			goto out;
> > > > +
> > > > +		ret = alvium_set_stream_mipi(alvium, enable);
> > > > +		if (ret)
> > > > +			goto out;
> > > > +
> > > > +	} else {
> > > > +		alvium_set_stream_mipi(alvium, enable);
> > > > +		pm_runtime_mark_last_busy(&client->dev);
> > > > +		pm_runtime_put_autosuspend(&client->dev);
> > > 
> > > pm_runtime_put() here, too.
> > 
> > Here is not needed we already have pm_runtime_put_autosuspend.
> > I'm missing something?
> 
> Ah, I missed that while reviewing. Please ignore that comment then.
> 
> > > > +	}
> > > > +
> > > > +	alvium->streaming = !!enable;
> > > > +	v4l2_subdev_unlock_state(state);
> > > > +
> > > > +	return 0;
> > > > +
> > > > +out:
> > > > +	v4l2_subdev_unlock_state(state);
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +static int alvium_init_cfg(struct v4l2_subdev *sd,
> > > > +			   struct v4l2_subdev_state *state)
> > > > +{
> > > > +	struct alvium_dev *alvium = sd_to_alvium(sd);
> > > > +	struct alvium_mode *mode = &alvium->mode;
> > > 
> > > Init_cfg() is expected to be configuration independent (as much as
> > > possible). Therefore you should use defaults here, not current mode.
> > 
> > Defaults alvium mode already used here.
> 
> Ah, indeed. Please ignore.

-- 
Regards,

Laurent Pinchart
