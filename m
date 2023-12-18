Return-Path: <linux-kernel+bounces-4229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF37D81795E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CB561F25F05
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A615D72E;
	Mon, 18 Dec 2023 18:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="L8jJ5DBx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096995BFB5;
	Mon, 18 Dec 2023 18:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 818F856D;
	Mon, 18 Dec 2023 19:04:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1702922643;
	bh=2G5GZYZ2ILPD00J2WA5+Mik9rZH8b2nzLo3y3FT055E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L8jJ5DBxTYu1RrOWvq64ZXjcjviewadYvLSY5LBIzw6i3ooldGacfu0TnacCxdEP5
	 RoZ03bKl0ddPFuUEr0cgyRLcRwH8RNQqd2dmmUMGT7KQlDf2V2ZNnS4uhIXhemZhSt
	 qtYM/xblp9t2+Blpood121l7II8ydibZbDVz/RC0=
Date: Mon, 18 Dec 2023 20:04:59 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Mikhail Rudenko <mike.rudenko@gmail.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH 12/19] media: i2c: ov4689: Implement digital gain control
Message-ID: <20231218180459.GS5290@pendragon.ideasonboard.com>
References: <20231211175023.1680247-1-mike.rudenko@gmail.com>
 <20231211175023.1680247-13-mike.rudenko@gmail.com>
 <20231211221533.GK27535@pendragon.ideasonboard.com>
 <875y13pnn6.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875y13pnn6.fsf@gmail.com>

Hi Mikhail,

On Tue, Dec 12, 2023 at 03:52:48PM +0300, Mikhail Rudenko wrote:
> On 2023-12-12 at 00:15 +02, Laurent Pinchart wrote:
> > On Mon, Dec 11, 2023 at 08:50:15PM +0300, Mikhail Rudenko wrote:
> >> The OV4689 sensor supports digital gain up to 16x. Implement
> >> corresponding control in the driver. Default digital gain value is not
> >> modified by this patch.
> >>
> >> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
> >> ---
> >>  drivers/media/i2c/ov4689.c | 16 ++++++++++++++--
> >>  1 file changed, 14 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
> >> index 62aeae43d749..ed0ce1b9e55b 100644
> >> --- a/drivers/media/i2c/ov4689.c
> >> +++ b/drivers/media/i2c/ov4689.c
> >> @@ -35,6 +35,12 @@
> >>  #define OV4689_GAIN_STEP		1
> >>  #define OV4689_GAIN_DEFAULT		0x80
> >>
> >> +#define OV4689_REG_DIG_GAIN		CCI_REG16(0x352A)
> >
> > Lowercase for hex constatns please.
> 
> Ah, missed it somehow. Is this convention kernel-wide or media specific?
> I think checkpatch could have detetected this..

It's media-wide :-) Lower-case hex constants are the majority through
the kernel, but there's no tree-wide ban on upper-case.

> >> +#define OV4689_DIG_GAIN_MIN		1
> >> +#define OV4689_DIG_GAIN_MAX		0x7fff
> >> +#define OV4689_DIG_GAIN_STEP		1
> >> +#define OV4689_DIG_GAIN_DEFAULT		0x800
> >> +
> >>  #define OV4689_REG_TEST_PATTERN		CCI_REG8(0x5040)
> >>  #define OV4689_TEST_PATTERN_ENABLE	0x80
> >>  #define OV4689_TEST_PATTERN_DISABLE	0x0
> >> @@ -131,7 +137,6 @@ static const struct cci_reg_sequence ov4689_2688x1520_regs[] = {
> >>
> >>  	/* AEC PK */
> >>  	{CCI_REG8(0x3503), 0x04}, /* AEC_MANUAL gain_input_as_sensor_gain_format = 1 */
> >> -	{CCI_REG8(0x352a), 0x08}, /* DIG_GAIN_FRAC_LONG dig_gain_long[14:8] = 0x08 (2x) */
> >
> > Is the default value really x2 ? That's not very nice :-S
> >
> > It would be much nicer if the default value of the control mapped to x1,
> > otherwise it's impossible for userspace to interpret the scale of the
> > digital gain value in a generic way. I suppose that could break existing
> > applications though, which isn't great.
> 
> The datasheet does not explicitly say how register values are mapped to
> the actual gain. 0x8 comes from the original register tables, and can
> also be found in a few other drivers for this sensor, although they do
> not implement digital gain control.
> 
> OTOH, the power-on value of this register, and default value as found in
> the datasheet, is 0x4. This was the motivation behind that "(2x)"
> annotation.

I wonder if the chip has a TPG that would be located before the digital
gain. It would be a nice way to test the digital gain scale.

> So, I'm afraid that we cannot interpret the absolute scale of the
> digital gain in any case, unless we have more documentation. I tend to
> keep the default value of 0x8 for the reasons of not (possibly) breaking
> userspace.
> 
> > Out of curiosity, can you tell what SoC(s) you're using this sensor with
> > ?
> 
> It's Rockchip 3399. I run most of my tests with AGC and AWB off, to be
> sure they do not hide some important details.
> 
> >>
> >>  	/* ADC and analog control*/
> >>  	{CCI_REG8(0x3603), 0x40},
> >> @@ -622,6 +627,9 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
> >>  				OV4689_TIMING_FLIP_MASK,
> >>  				val ? 0 : OV4689_TIMING_FLIP_BOTH, &ret);
> >>  		break;
> >> +	case V4L2_CID_DIGITAL_GAIN:
> >> +		cci_write(regmap, OV4689_REG_DIG_GAIN, val, &ret);
> >> +		break;
> >>  	default:
> >>  		dev_warn(dev, "%s Unhandled id:0x%x, val:0x%x\n",
> >>  			 __func__, ctrl->id, val);
> >> @@ -650,7 +658,7 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
> >>
> >>  	handler = &ov4689->ctrl_handler;
> >>  	mode = ov4689->cur_mode;
> >> -	ret = v4l2_ctrl_handler_init(handler, 13);
> >> +	ret = v4l2_ctrl_handler_init(handler, 14);
> >>  	if (ret)
> >>  		return ret;
> >>
> >> @@ -693,6 +701,10 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
> >>  	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_VFLIP, 0, 1, 1, 0);
> >>  	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_HFLIP, 0, 1, 1, 0);
> >>
> >> +	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_DIGITAL_GAIN,
> >> +			  OV4689_DIG_GAIN_MIN, OV4689_DIG_GAIN_MAX,
> >> +			  OV4689_DIG_GAIN_STEP, OV4689_DIG_GAIN_DEFAULT);
> >> +
> >>  	if (handler->error) {
> >>  		ret = handler->error;
> >>  		dev_err(ov4689->dev, "Failed to init controls(%d)\n", ret);

-- 
Regards,

Laurent Pinchart

