Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9D07EAD69
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 10:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbjKNJxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 04:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjKNJxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 04:53:32 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22214191;
        Tue, 14 Nov 2023 01:53:28 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 348DE2BC;
        Tue, 14 Nov 2023 10:52:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1699955579;
        bh=GNHoQv0bcWc8Y22LUMF0GP8avbvT78ir75Al0FeLhrc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WI5fqCKOj3RvH11obhS8vnqlv7ht3bI7rAl7ESv0LjDPfw60fur+K+v9MIOdfMxri
         rvvSC99x8NP6aTTTQxfOvJUBKLUzHhPc5SPqOl+2m9bcKEBq4Z+t/JbjhoVr6Kxolm
         98ZYIlQMsCJG0ZJM2PG6UUtxIiFbqQDezprUl4z4=
Date:   Tue, 14 Nov 2023 11:53:31 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/5] media: platform: visconti: add V4L2 vendor
 specific control handlers
Message-ID: <20231114095331.GA13826@pendragon.ideasonboard.com>
References: <20231012071329.2542003-1-yuji2.ishikawa@toshiba.co.jp>
 <20231012071329.2542003-4-yuji2.ishikawa@toshiba.co.jp>
 <6095bd3d-2580-44e2-b622-3ad31e12787f@xs4all.nl>
 <a84ce942-e6df-414e-8d0c-e7d3ef3e62f6@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a84ce942-e6df-414e-8d0c-e7d3ef3e62f6@xs4all.nl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 10:10:50AM +0100, Hans Verkuil wrote:
> On 14/11/2023 10:02, Hans Verkuil wrote:
> > On 12/10/2023 09:13, Yuji Ishikawa wrote:
> >> Add support to Image Signal Processors of Visconti's Video Input Interface.
> >> This patch adds vendor specific compound controls
> >> to configure the image signal processor.
> >>
> >> Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
> >> ---
> >> Changelog v2:
> >> - Resend v1 because a patch exceeds size limit.
> >>
> >> Changelog v3:
> >> - Adapted to media control framework
> >> - Introduced ISP subdevice, capture device
> >> - Remove private IOCTLs and add vendor specific V4L2 controls
> >> - Change function name avoiding camelcase and uppercase letters
> >>
> >> Changelog v4:
> >> - Split patches because the v3 patch exceeds size limit
> >> - Stop using ID number to identify driver instance:
> >>   - Use dynamically allocated structure to hold HW specific context,
> >>     instead of static one.
> >>   - Call HW layer functions with the context structure instead of ID number
> >>
> >> Changelog v5:
> >> - no change
> >>
> >> Changelog v6:
> >> - remove unused macros
> >> - removed hwd_ and HWD_ prefix
> >> - update source code documentation
> >> - Suggestion from Hans Verkuil
> >>   - pointer to userland memory is removed from uAPI arguments
> >>     - style of structure is now "nested" instead of "chained by pointer";
> >>   - use div64_u64 for 64bit division
> >>   - vendor specific controls support TRY_EXT_CTRLS
> >>   - add READ_ONLY flag to GET_CALIBRATION_STATUS control and similar ones
> >>   - human friendry control names for vendor specific controls
> >>   - add initial value to each vendor specific control
> >>   - GET_LAST_CAPTURE_STATUS control is updated asyncnously from workqueue
> >>   - remove EXECUTE_ON_WRITE flag of vendor specific control
> >>   - uAPI: return value of GET_CALIBRATION_STATUS follows common rules of error codes
> >>   - applied v4l2-compliance
> >> - Suggestion from Sakari Ailus
> >>   - use div64_u64 for 64bit division
> >>   - update copyright's year
> >>   - remove redandunt cast
> >>   - use bool instead of HWD_VIIF_ENABLE/DISABLE
> >>   - simplify comparison to 0
> >>   - simplify statements with trigram operator
> >>   - remove redundant local variables
> >>   - use general integer types instead of u32/s32
> >> - Suggestion from Laurent Pinchart
> >>   - moved VIIF driver to driver/platform/toshiba/visconti
> >>   - change register access: struct-style to macro-style
> >>   - remove unused type definitions
> >>   - define enums instead of successive macro constants
> >>   - remove redundant parenthesis of macro constant
> >>   - embed struct hwd_res into struct viif_device
> >>   - use xxx_dma instead of xxx_paddr for variable names of IOVA
> >>   - literal value: just 0 instead of 0x0
> >>   - use literal 1 or 0 instead of HWD_VIIF_ENABLE, DISABLE for register access
> >>   - use true or false instead of HWD_VIIF_ENABLE, DISABLE for function calls
> >>   - uAPI: return value of GET_CALIBRATION_STATUS follows common rules of error codes
> >>
> >> Changelog v7:
> >> - remove unused variables
> >> - split long statements which have multiple logical-OR and trigram operators
> >>
> >> Changelog v8:
> >> - define constant V4L2_CTRL_TYPE_VISCONTI_ISP for datatype
> >>   of Visconti specific controls
> >> - Suggestion from Hans Verkuil
> >>   - remove pr_info()
> >>   - use pm_runtime_get_if_in_use() to get power status
> >>
> >> Changelog v9:
> >> - fix warning for cast between ptr and dma_addr_t
> >>
> >>  .../media/platform/toshiba/visconti/Makefile  |    2 +-
> >>  .../media/platform/toshiba/visconti/viif.c    |   10 +-
> >>  .../platform/toshiba/visconti/viif_controls.c | 3395 +++++++++++++++++
> >>  .../platform/toshiba/visconti/viif_controls.h |   18 +
> >>  .../platform/toshiba/visconti/viif_isp.c      |   15 +-
> >>  drivers/media/v4l2-core/v4l2-ctrls-core.c     |    7 +-
> >>  include/uapi/linux/videodev2.h                |    2 +
> >>  7 files changed, 3431 insertions(+), 18 deletions(-)
> >>  create mode 100644 drivers/media/platform/toshiba/visconti/viif_controls.c
> >>  create mode 100644 drivers/media/platform/toshiba/visconti/viif_controls.h
> >>
> > 
> > <snip>
> > 
> > These core changes below should be in a separate patch, not mixed in with
> > the driver.
> > 
> >> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-core.c b/drivers/media/v4l2-core/v4l2-ctrls-core.c
> >> index a662fb60f73f..0c4df9fffbe0 100644
> >> --- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
> >> +++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
> >> @@ -367,7 +367,9 @@ void v4l2_ctrl_type_op_log(const struct v4l2_ctrl *ctrl)
> >>  	case V4L2_CTRL_TYPE_AV1_FILM_GRAIN:
> >>  		pr_cont("AV1_FILM_GRAIN");
> >>  		break;
> >> -
> >> +	case V4L2_CTRL_TYPE_VISCONTI_ISP:
> >> +		pr_cont("VISCONTI_ISP");
> >> +		break;
> >>  	default:
> >>  		pr_cont("unknown type %d", ctrl->type);
> >>  		break;
> >> @@ -1163,6 +1165,9 @@ static int std_validate_compound(const struct v4l2_ctrl *ctrl, u32 idx,
> >>  	case V4L2_CTRL_TYPE_AV1_FILM_GRAIN:
> >>  		return validate_av1_film_grain(p);
> >>  
> >> +	case V4L2_CTRL_TYPE_VISCONTI_ISP:
> >> +		break;
> >> +
> >>  	case V4L2_CTRL_TYPE_AREA:
> >>  		area = p;
> >>  		if (!area->width || !area->height)
> >> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> >> index c3d4e490ce7c..bbc3cd3efa65 100644
> >> --- a/include/uapi/linux/videodev2.h
> >> +++ b/include/uapi/linux/videodev2.h
> >> @@ -1915,6 +1915,8 @@ enum v4l2_ctrl_type {
> >>  	V4L2_CTRL_TYPE_AV1_TILE_GROUP_ENTRY = 0x281,
> >>  	V4L2_CTRL_TYPE_AV1_FRAME	    = 0x282,
> >>  	V4L2_CTRL_TYPE_AV1_FILM_GRAIN	    = 0x283,
> >> +
> >> +	V4L2_CTRL_TYPE_VISCONTI_ISP = 0x290,
> > 
> > I see you are using the same V4L2_CTRL_TYPE_VISCONTI_ISP for all the compound
> > controls. But that's not allowed: the V4L2_CTRL_TYPE_ defines determine the
> > control type, so each struct used by a control needs its own type.
> 
> Actually, you don't want to add such a type at all. This is all driver specific,
> so support like this belongs in the driver.
> 
> A good example of that is V4L2_CID_DW100_DEWARPING_16x16_VERTEX_MAP in
> drivers/media/platform/nxp/dw100/dw100.c: there all the handling is done in
> the driver, and it adds init/validate/log/equal ops as well.

Actually, I think a better option is to use parameters buffers instead
of controls, like other ISP driver do.

> > I also noticed looking through include/uapi/linux/visconti_viif.h that some
> > of the struct have holes. I really want to avoid holes in structs used by
> > controls, it is bad practice.
> > 
> > The pahole utility is very useful for testing this. It is also highly
> > recommended to check for both 32 and 64 bit compilation: the struct layout
> > must be the same, otherwise you would run into problems if a 32 bit application
> > is used with a 64 bit kernel.
> > 
> > Finally, Laurent and/or Sakari will also take a look at this driver, for some
> > reason this driver has been mostly reviewed by me, but I am not really the
> > expert on ISPs.
> > 
> >>  };
> >>  
> >>  /*  Used in the VIDIOC_QUERYCTRL ioctl for querying controls */

-- 
Regards,

Laurent Pinchart
