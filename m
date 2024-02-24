Return-Path: <linux-kernel+bounces-79825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B72D9862739
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 21:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D62A1C211F7
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 20:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8104CDFB;
	Sat, 24 Feb 2024 20:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KYX2oOlS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03D64CB2B;
	Sat, 24 Feb 2024 20:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708805097; cv=none; b=c3ug7J+fhlfiHavBYXuWVtGFDWym6e6kG1MvDZ2U5PzB7CUXyFoZsHLza3tDUpVaLERigb56v5ev8z98BsPLdITfeRtwMbFiJtH5ojKA41j4gPmZaqoh8H7x8I7LZOTqQQqPLtndlJAIqTrpEk/TTx7+NFxPZvIo84w81ipcxdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708805097; c=relaxed/simple;
	bh=6OkBdB3y/dJKRAA+NQ+DnvqRiRsVO0YLvBl3cn4W4DU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rkev04eN06+0EPlBttpYhpPbdGCScg0N7SQCUfwAPCyqHx4nQWRB1t+UYkXwJP30in6GbBILVi8gfAAOlYPDl69DBG8CgKjyMWygcVJHYQP3s2n/OikHgDqtjCWOASVjc/PzbaNUFkMgIzstYU0bcj2WSesGhVxfWSGaoTddboA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KYX2oOlS; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708805096; x=1740341096;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6OkBdB3y/dJKRAA+NQ+DnvqRiRsVO0YLvBl3cn4W4DU=;
  b=KYX2oOlSr1UjV4oXm6Anau7ami09+WDtuCIG5tkyKeEGBog4fl8XhquF
   51oPNCPP9JXB/WsGhwlPVsQYZgsEUMgClj1JBUnV0iTjqSZJRsUEw/P0a
   IQRJ0SjyWPnHxGOybGDulh10NagsOEXS55BsJUmRKNk8LkWqaFGF76Vu+
   sr0qxeCcOxW7j9ka1XwvK+c6pO90qF1bje5OVsPyd/COZncPm1ipHFaUP
   vIl9iwO4BzXwO/IWPypiFA9PzeqoDSuxBC8fOzYp6Ufdpgbe9iw7wNKV9
   9c1oUoEjj/DzSSNsZTrpAXvEbn/DHgsaNSHxtsPZM74j7C+Rkgna/Y8YF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10994"; a="3289847"
X-IronPort-AV: E=Sophos;i="6.06,182,1705392000"; 
   d="scan'208";a="3289847"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2024 12:04:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,182,1705392000"; 
   d="scan'208";a="11036058"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2024 12:04:52 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id BCE0B11F853;
	Sat, 24 Feb 2024 22:04:49 +0200 (EET)
Date: Sat, 24 Feb 2024 20:04:49 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Mikhail Rudenko <mike.rudenko@gmail.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Tommaso Merciai <tomm.merciai@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v2 12/20] media: i2c: ov4689: Implement vflip/hflip
 controls
Message-ID: <ZdpL4UxSy8elHkdZ@kekkonen.localdomain>
References: <20231218174042.794012-1-mike.rudenko@gmail.com>
 <20231218174042.794012-13-mike.rudenko@gmail.com>
 <ZdhWzCNalXnScMQy@kekkonen.localdomain>
 <87h6hzdsi4.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6hzdsi4.fsf@gmail.com>

Hi Mikhail,

On Fri, Feb 23, 2024 at 06:21:20PM +0300, Mikhail Rudenko wrote:
> 
> Hi Sakari,
> 
> and thanks for the review!
> 
> On 2024-02-23 at 08:26 GMT, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
> 
> > Hi Mikhail,
> >
> > On Mon, Dec 18, 2023 at 08:40:33PM +0300, Mikhail Rudenko wrote:
> >> The OV4689 sensor supports horizontal and vertical flipping. Add
> >> appropriate controls to the driver. Toggling both array flip and
> >> digital flip bits allows to achieve flipping while maintaining output
> >> Bayer order. Note that the default value of hflip control corresponds
> >> to both bits set, as it was before this patch.
> >>
> >> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
> >> ---
> >>  drivers/media/i2c/ov4689.c | 24 ++++++++++++++++++++++--
> >>  1 file changed, 22 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
> >> index 06ed9d22b2c8..6cf986bf305d 100644
> >> --- a/drivers/media/i2c/ov4689.c
> >> +++ b/drivers/media/i2c/ov4689.c
> >> @@ -42,6 +42,14 @@
> >>  #define OV4689_REG_VTS			CCI_REG16(0x380e)
> >>  #define OV4689_VTS_MAX			0x7fff
> >>
> >> +#define OV4689_REG_TIMING_FORMAT1	CCI_REG8(0x3820)
> >> +#define OV4689_REG_TIMING_FORMAT2	CCI_REG8(0x3821)
> >> +#define OV4689_TIMING_FLIP_MASK		GENMASK(2, 1)
> >> +#define OV4689_TIMING_FLIP_ARRAY	BIT(1)
> >> +#define OV4689_TIMING_FLIP_DIGITAL	BIT(2)
> >> +#define OV4689_TIMING_FLIP_BOTH		(OV4689_TIMING_FLIP_ARRAY |\
> >> +					 OV4689_TIMING_FLIP_DIGITAL)
> >> +
> >>  #define OV4689_REG_TEST_PATTERN		CCI_REG8(0x5040)
> >>  #define OV4689_TEST_PATTERN_ENABLE	0x80
> >>  #define OV4689_TEST_PATTERN_DISABLE	0x0
> >> @@ -183,7 +191,6 @@ static const struct cci_reg_sequence ov4689_2688x1520_regs[] = {
> >>  	{CCI_REG8(0x3811), 0x08}, /* H_WIN_OFF_L h_win_off[7:0] = 0x08*/
> >>  	{CCI_REG8(0x3813), 0x04}, /* V_WIN_OFF_L v_win_off[7:0] = 0x04 */
> >>  	{CCI_REG8(0x3819), 0x01}, /* VSYNC_END_L vsync_end_point[7:0] = 0x01 */
> >> -	{CCI_REG8(0x3821), 0x06}, /* TIMING_FORMAT2 array_h_mirror = 1, digital_h_mirror = 1 */
> >>
> >>  	/* OTP control */
> >>  	{CCI_REG8(0x3d85), 0x36}, /* OTP_REG85 OTP_power_up_load_setting_enable = 1,
> >> @@ -607,6 +614,16 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
> >>  			  (ctrl->val + ov4689->cur_mode->width) /
> >>  			  OV4689_HTS_DIVIDER, &ret);
> >>  		break;
> >> +	case V4L2_CID_VFLIP:
> >> +		cci_update_bits(regmap, OV4689_REG_TIMING_FORMAT1,
> >> +				OV4689_TIMING_FLIP_MASK,
> >> +				ctrl->val ? OV4689_TIMING_FLIP_BOTH : 0, &ret);
> >> +		break;
> >> +	case V4L2_CID_HFLIP:
> >> +		cci_update_bits(regmap, OV4689_REG_TIMING_FORMAT2,
> >> +				OV4689_TIMING_FLIP_MASK,
> >> +				ctrl->val ? 0 : OV4689_TIMING_FLIP_BOTH, &ret);
> >> +		break;
> >>  	default:
> >>  		dev_warn(dev, "%s Unhandled id:0x%x, val:0x%x\n",
> >>  			 __func__, ctrl->id, ctrl->val);
> >> @@ -637,7 +654,7 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
> >>
> >>  	handler = &ov4689->ctrl_handler;
> >>  	mode = ov4689->cur_mode;
> >> -	ret = v4l2_ctrl_handler_init(handler, 10);
> >> +	ret = v4l2_ctrl_handler_init(handler, 12);
> >>  	if (ret)
> >>  		return ret;
> >>
> >> @@ -677,6 +694,9 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
> >>  				     ARRAY_SIZE(ov4689_test_pattern_menu) - 1,
> >>  				     0, 0, ov4689_test_pattern_menu);
> >>
> >> +	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_VFLIP, 0, 1, 1, 0);
> >> +	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_HFLIP, 0, 1, 1, 0);
> >
> > Could you take the default value from the mounting rotation?
> 
> Could you provide an example (maybe a link to an existing driver) which
> does this right? If I understand you correctly, I should flip default
> for both flip controls for 180 degree rotation. But what should I do for
> 90, 270 and all the rest rotation values?

Looking at the patch again, it seems that the image wasn't flipped both
vertically and horizontally, but only horizontally. Was that the case?

Shouldn't the default then be no flipping?

> 
> > The default should be upside-up, but this is an existing driver and
> > changing the flipping now could affect existing users.
> 
> Do you mean default rotation value when missing device tree property?
> 
> > <URL:https://hverkuil.home.xs4all.nl/spec/userspace-api/drivers/camera-sensor.html#rotation-orientation-and-flipping>
> >
> 
> 
> 

-- 
Regards,

Sakari Ailus

