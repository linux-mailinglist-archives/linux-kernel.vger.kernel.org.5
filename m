Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528CD78292F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbjHUMeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234861AbjHUMeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:34:03 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE196FB;
        Mon, 21 Aug 2023 05:33:51 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2D2223F1;
        Mon, 21 Aug 2023 14:32:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1692621154;
        bh=hzxnAgjoqqIoNYOZ1HJwhHqc1zwJObXxon+9+RFCRts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H4+E4e1kOlBIOMqjkbZQN1FvotQcnPCq9Fjn5mi4FjGxfMUY9R9h9wGGTP4ds+UHr
         ivzLfFjVnw+JGhU+2OUuPps9VAMSWOjwpzlyRuQX+bj4JRGTiqcK1DnLxa4sGbozCW
         NBRZ43ds1CSuqKVeqAmJPn1aaeiWBuRX/C61ufWU=
Date:   Mon, 21 Aug 2023 15:33:56 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Mark Brown <broonie@kernel.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/5] media: add V4L2 vendor specific control handlers
Message-ID: <20230821123356.GH10135@pendragon.ideasonboard.com>
References: <20230714015059.18775-1-yuji2.ishikawa@toshiba.co.jp>
 <20230714015059.18775-4-yuji2.ishikawa@toshiba.co.jp>
 <d2925a76-ab66-9d76-803b-3e3a421411d9@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d2925a76-ab66-9d76-803b-3e3a421411d9@xs4all.nl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 02:28:11PM +0200, Hans Verkuil wrote:
> On 14/07/2023 03:50, Yuji Ishikawa wrote:
> > Add support to Image Signal Processors of Visconti's Video Input Interface.
> > This patch adds vendor specific compound controls
> > to configure the image signal processor.
> > 
> > Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
> > ---
> > Changelog v2:
> > - Resend v1 because a patch exceeds size limit.
> > 
> > Changelog v3:
> > - Adapted to media control framework
> > - Introduced ISP subdevice, capture device
> > - Remove private IOCTLs and add vendor specific V4L2 controls
> > - Change function name avoiding camelcase and uppercase letters
> > 
> > Changelog v4:
> > - Split patches because the v3 patch exceeds size limit
> > - Stop using ID number to identify driver instance:
> >   - Use dynamically allocated structure to hold HW specific context,
> >     instead of static one.
> >   - Call HW layer functions with the context structure instead of ID number
> > 
> > Changelog v5:
> > - no change
> > 
> > Changelog v6:
> > - remove unused macros
> > - removed hwd_ and HWD_ prefix
> > - update source code documentation
> > - Suggestion from Hans Verkuil
> >   - pointer to userland memory is removed from uAPI arguments
> >     - style of structure is now "nested" instead of "chained by pointer";
> >   - use div64_u64 for 64bit division
> >   - vendor specific controls support TRY_EXT_CTRLS
> >   - add READ_ONLY flag to GET_CALIBRATION_STATUS control and similar ones
> >   - human friendry control names for vendor specific controls
> >   - add initial value to each vendor specific control
> >   - GET_LAST_CAPTURE_STATUS control is updated asyncnously from workqueue
> >   - remove EXECUTE_ON_WRITE flag of vendor specific control
> >   - uAPI: return value of GET_CALIBRATION_STATUS follows common rules of error codes
> >   - applied v4l2-compliance
> > - Suggestion from Sakari Ailus
> >   - use div64_u64 for 64bit division
> >   - update copyright's year
> >   - remove redandunt cast
> >   - use bool instead of HWD_VIIF_ENABLE/DISABLE
> >   - simplify comparison to 0
> >   - simplify statements with trigram operator
> >   - remove redundant local variables
> >   - use general integer types instead of u32/s32
> > - Suggestion from Laurent Pinchart
> >   - moved VIIF driver to driver/platform/toshiba/visconti
> >   - change register access: struct-style to macro-style
> >   - remove unused type definitions
> >   - define enums instead of successive macro constants
> >   - remove redundant parenthesis of macro constant
> >   - embed struct hwd_res into struct viif_device
> >   - use xxx_dma instead of xxx_paddr for variable names of IOVA
> >   - literal value: just 0 instead of 0x0
> >   - use literal 1 or 0 instead of HWD_VIIF_ENABLE, DISABLE for register access
> >   - use true or false instead of HWD_VIIF_ENABLE, DISABLE for function calls
> >   - uAPI: return value of GET_CALIBRATION_STATUS follows common rules of error codes
> > 
> > Changelog v7:
> > - remove unused variables
> > - split long statements which have multiple logical-OR and trigram operators
> > 
> >  .../media/platform/toshiba/visconti/Makefile  |    2 +-
> >  .../media/platform/toshiba/visconti/viif.c    |   10 +-
> >  .../platform/toshiba/visconti/viif_controls.c | 3407 +++++++++++++++++
> >  .../platform/toshiba/visconti/viif_controls.h |   18 +
> >  .../platform/toshiba/visconti/viif_isp.c      |   15 +-
> >  5 files changed, 3435 insertions(+), 17 deletions(-)
> >  create mode 100644 drivers/media/platform/toshiba/visconti/viif_controls.c
> >  create mode 100644 drivers/media/platform/toshiba/visconti/viif_controls.h
> > 
> > diff --git a/drivers/media/platform/toshiba/visconti/Makefile b/drivers/media/platform/toshiba/visconti/Makefile
> > index 5f2f9199c..a28e6fa84 100644
> > --- a/drivers/media/platform/toshiba/visconti/Makefile
> > +++ b/drivers/media/platform/toshiba/visconti/Makefile
> > @@ -3,6 +3,6 @@
> >  # Makefile for the Visconti video input device driver
> >  #
> >  
> > -visconti-viif-objs = viif.o viif_capture.o viif_isp.o viif_csi2rx.o viif_common.o
> > +visconti-viif-objs = viif.o viif_capture.o viif_controls.o viif_isp.o viif_csi2rx.o viif_common.o
> >  
> >  obj-$(CONFIG_VIDEO_VISCONTI_VIIF) += visconti-viif.o
> > diff --git a/drivers/media/platform/toshiba/visconti/viif.c b/drivers/media/platform/toshiba/visconti/viif.c
> > index c07dc2626..1b3d61abf 100644
> > --- a/drivers/media/platform/toshiba/visconti/viif.c
> > +++ b/drivers/media/platform/toshiba/visconti/viif.c
> > @@ -18,6 +18,7 @@
> >  
> >  #include "viif.h"
> >  #include "viif_capture.h"
> > +#include "viif_controls.h"
> >  #include "viif_csi2rx.h"
> >  #include "viif_common.h"
> >  #include "viif_isp.h"
> > @@ -178,12 +179,9 @@ static struct viif_subdev *to_viif_subdev(struct v4l2_async_subdev *asd)
> >  /* before a userland capture application is trigered by vb2_buffer_done() */
> >  static void visconti_viif_wthread_l1info(struct work_struct *work)
> >  {
> > -	/* called function is implemented by the next patch */
> > -/*
> > - *	struct viif_device *viif_dev = container_of(work, struct viif_device, work);
> > - *
> > - *	visconti_viif_save_l1_info(viif_dev);
> > - */
> > +	struct viif_device *viif_dev = container_of(work, struct viif_device, work);
> > +
> > +	visconti_viif_save_l1_info(viif_dev);
> >  }
> >  
> >  static void viif_vsync_irq_handler_w_isp(struct viif_device *viif_dev)
> > diff --git a/drivers/media/platform/toshiba/visconti/viif_controls.c b/drivers/media/platform/toshiba/visconti/viif_controls.c
> > new file mode 100644
> > index 000000000..3cf10e15c
> > --- /dev/null
> > +++ b/drivers/media/platform/toshiba/visconti/viif_controls.c
> > @@ -0,0 +1,3407 @@
> 
> <snip>
> 
> > +static int visconti_viif_isp_try_ctrl(struct v4l2_ctrl *ctrl)
> > +{
> > +	struct viif_device *viif_dev = ctrl->priv;
> > +
> > +	switch (ctrl->id) {
> > +	case V4L2_CID_VISCONTI_VIIF_MAIN_SET_RAWPACK_MODE:
> > +		return viif_main_set_rawpack_mode_try(viif_dev, ctrl->p_new.p);
> > +	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_INPUT_MODE:
> > +		return viif_l1_set_input_mode_try(viif_dev, ctrl->p_new.p);
> > +	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_RGB_TO_Y_COEF:
> > +		return viif_l1_set_rgb_to_y_coef_try(viif_dev, ctrl->p_new.p);
> > +	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AG_MODE:
> > +		return viif_l1_set_ag_mode_try(viif_dev, ctrl->p_new.p);
> > +	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AG:
> > +		return 0; //no need to check
> > +	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRE:
> > +		return viif_l1_set_hdre_try(viif_dev, ctrl->p_new.p);
> > +	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_IMG_EXTRACTION:
> > +		return viif_l1_set_img_extraction_try(viif_dev, ctrl->p_new.p);
> > +	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_DPC:
> > +		return viif_l1_set_dpc_try(viif_dev, ctrl->p_new.p);
> > +	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_PRESET_WHITE_BALANCE:
> > +		return viif_l1_set_preset_white_balance_try(viif_dev, ctrl->p_new.p);
> > +	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_RAW_COLOR_NOISE_REDUCTION:
> > +		return viif_l1_set_raw_color_noise_reduction_try(viif_dev, ctrl->p_new.p);
> > +	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRS:
> > +		return viif_l1_set_hdrs_try(viif_dev, ctrl->p_new.p);
> > +	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_BLACK_LEVEL_CORRECTION:
> > +		return viif_l1_set_black_level_correction_try(viif_dev, ctrl->p_new.p);
> > +	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_LSC:
> > +		return viif_l1_set_lsc_try(viif_dev, ctrl->p_new.p);
> > +	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_MAIN_PROCESS:
> > +		return viif_l1_set_main_process_try(viif_dev, ctrl->p_new.p);
> > +	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AWB:
> > +		return viif_l1_set_awb_try(viif_dev, ctrl->p_new.p);
> > +	case V4L2_CID_VISCONTI_VIIF_ISP_L1_LOCK_AWB_GAIN:
> > +		return 0;
> > +	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRC:
> > +		return viif_l1_set_hdrc_try(viif_dev, ctrl->p_new.p);
> > +	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRC_LTM:
> > +		return viif_l1_set_hdrc_ltm_try(viif_dev, ctrl->p_new.p);
> > +	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_GAMMA:
> > +		return viif_l1_set_gamma_try(viif_dev, ctrl->p_new.p);
> > +	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_IMG_QUALITY_ADJUSTMENT:
> > +		return viif_l1_set_img_quality_adjustment_try(viif_dev, ctrl->p_new.p);
> > +	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AVG_LUM_GENERATION:
> > +		return viif_l1_set_avg_lum_generation_try(viif_dev, ctrl->p_new.p);
> > +	case V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_UNDIST:
> > +		return viif_l2_set_undist_try(viif_dev, ctrl->p_new.p);
> > +	case V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_ROI:
> > +		return viif_l2_set_roi_try(viif_dev, ctrl->p_new.p);
> > +	case V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_GAMMA:
> > +		return viif_l2_set_gamma_try(viif_dev, ctrl->p_new.p);
> > +	case V4L2_CID_VISCONTI_VIIF_GET_LAST_CAPTURE_STATUS:
> > +		return 0;
> > +	default:
> > +		pr_info("unknown_ctrl:t: id=%08X val=%d", ctrl->id, ctrl->val);
> > +		break;
> > +	}
> > +	return -EINVAL;
> > +}
> > +
> > +static int visconti_viif_isp_set_ctrl(struct v4l2_ctrl *ctrl)
> > +{
> > +	struct viif_device *viif_dev = ctrl->priv;
> > +	int ret;
> > +
> > +	pr_info("isp_set_ctrl: %s", ctrl->name);
> 
> Don't use pr_info for what is just a debug message! Either drop it, or
> replace it with dev_dbg.

In drivers, almost all occurences of pr_*() should be replaced by
dev_*(). It's very rare that pr_*() would be the right API.

In this specific case, I'd just drop it.

> > +	if (pm_runtime_status_suspended(viif_dev->dev)) {
> > +		pr_info("warning: visconti viif HW is not powered");
> 
> And here pr_info is used for a warning, so shouldn't this be dev_warn?

I don't think there's a need to warn about this, it's a normal
situation.

The right runtime PM API here is pm_runtime_get_if_in_use() by the way,
not pm_runtime_status_suspended(). Don't forget to call pm_runtime_put()
at the end of the function.

> I see pr_info being used in a lot of places where it doesn't belong and
> would just spam the kernel log.
>
> Something to go through for v8.

-- 
Regards,

Laurent Pinchart
