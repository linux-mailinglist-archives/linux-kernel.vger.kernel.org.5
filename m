Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298A676F577
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 00:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjHCWHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 18:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjHCWHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 18:07:44 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC9B3A9C;
        Thu,  3 Aug 2023 15:07:41 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6848D7F5;
        Fri,  4 Aug 2023 00:06:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1691100395;
        bh=YjB7f0h/8P7aC2Vm93VPe9ailgBLZJRpd2gZj9147IQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lrXiUw8qrqX2XndvY6nC4EtY9QcmoqmJUKi5mg0pZ7I680ItRtPN9z3lJztwEBRnI
         3Cyfh6NM2R4XWqbLimAvYOLflRl4+ubzIfooDB+RGmn+WE2PklRDeGYvJfKLYAHqT5
         IkhPNyE5dHQ7aBi5AC1jjORZQXhateh2+j8Dsr/Q=
Date:   Fri, 4 Aug 2023 01:07:46 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jack Zhu <jack.zhu@starfivetech.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>, bryan.odonoghue@linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, changhuang.liang@starfivetech.com,
        Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v7 5/6] media: starfive: camss: Add ISP driver
Message-ID: <20230803220746.GD9722@pendragon.ideasonboard.com>
References: <20230619112838.19797-1-jack.zhu@starfivetech.com>
 <20230619112838.19797-6-jack.zhu@starfivetech.com>
 <20230727204103.GJ25174@pendragon.ideasonboard.com>
 <2504080f-86af-161f-5c0d-284e89e33ce1@starfivetech.com>
 <20230802104840.GC5269@pendragon.ideasonboard.com>
 <45879269-e72b-b13a-00bc-2d10e9f90c2c@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <45879269-e72b-b13a-00bc-2d10e9f90c2c@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jack,

On Thu, Aug 03, 2023 at 10:41:08AM +0800, Jack Zhu wrote:
> On 2023/8/2 18:48, Laurent Pinchart wrote:
> > On Wed, Aug 02, 2023 at 05:57:57PM +0800, Jack Zhu wrote:
> >> On 2023/7/28 4:41, Laurent Pinchart wrote:
> >> > On Mon, Jun 19, 2023 at 07:28:37PM +0800, Jack Zhu wrote:
> >> >> Add ISP driver for StarFive Camera Subsystem.
> >> >> 
> >> >> Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
> >> >> ---
> >> >>  .../media/platform/starfive/camss/Makefile    |   2 +
> >> >>  .../media/platform/starfive/camss/stf_camss.c |  76 ++-
> >> >>  .../media/platform/starfive/camss/stf_camss.h |   3 +
> >> >>  .../media/platform/starfive/camss/stf_isp.c   | 519 ++++++++++++++++++
> >> >>  .../media/platform/starfive/camss/stf_isp.h   | 479 ++++++++++++++++
> >> >>  .../platform/starfive/camss/stf_isp_hw_ops.c  | 468 ++++++++++++++++
> >> >>  6 files changed, 1544 insertions(+), 3 deletions(-)
> >> >>  create mode 100644 drivers/media/platform/starfive/camss/stf_isp.c
> >> >>  create mode 100644 drivers/media/platform/starfive/camss/stf_isp.h
> >> >>  create mode 100644 drivers/media/platform/starfive/camss/stf_isp_hw_ops.c
> > 
> > [snip]
> > 
> >> >> diff --git a/drivers/media/platform/starfive/camss/stf_isp.c b/drivers/media/platform/starfive/camss/stf_isp.c
> >> >> new file mode 100644
> >> >> index 000000000000..933a583b398c
> >> >> --- /dev/null
> >> >> +++ b/drivers/media/platform/starfive/camss/stf_isp.c
> >> >> @@ -0,0 +1,519 @@
> >> >> +// SPDX-License-Identifier: GPL-2.0
> >> >> +/*
> >> >> + * stf_isp.c
> >> >> + *
> >> >> + * StarFive Camera Subsystem - ISP Module
> >> >> + *
> >> >> + * Copyright (C) 2021-2023 StarFive Technology Co., Ltd.
> >> >> + */
> >> >> +#include <linux/firmware.h>
> >> > 
> >> > This doesn't seem needed.
> >> > 
> >> >> +#include <media/v4l2-event.h>
> >> >> +
> >> >> +#include "stf_camss.h"
> >> >> +
> >> >> +#define SINK_FORMATS_INDEX    0
> >> >> +#define UO_FORMATS_INDEX      1
> >> > 
> >> > What does "UO" stand for ?
> >> 
> >> "UO" is Usual Out, just represents output. :-)
> > 
> > Maybe "out", "output" or "source" would make the code easier to read
> > then ?
> > 
> >> >> +
> >> >> +static int isp_set_selection(struct v4l2_subdev *sd,
> >> >> +			     struct v4l2_subdev_state *state,
> >> >> +			     struct v4l2_subdev_selection *sel);
> >> >> +
> >> >> +static const struct isp_format isp_formats_sink[] = {
> >> >> +	{ MEDIA_BUS_FMT_SRGGB10_1X10, 10 },
> >> >> +	{ MEDIA_BUS_FMT_SGRBG10_1X10, 10 },
> >> >> +	{ MEDIA_BUS_FMT_SGBRG10_1X10, 10 },
> >> >> +	{ MEDIA_BUS_FMT_SBGGR10_1X10, 10 },
> >> >> +};
> > 
> > [snip]
> > 
> >> >> diff --git a/drivers/media/platform/starfive/camss/stf_isp.h b/drivers/media/platform/starfive/camss/stf_isp.h
> >> >> new file mode 100644
> >> >> index 000000000000..1e5c98482350
> >> >> --- /dev/null
> >> >> +++ b/drivers/media/platform/starfive/camss/stf_isp.h
> >> >> @@ -0,0 +1,479 @@
> > 
> > [snip]
> > 
> >> >> +/* The output line of ISP */
> >> > 
> >> > What is an ISP "line" ?
> >> 
> >> A pipeline contains ISP.
> > 
> > Patch 6/6 uses STF_ISP_LINE_MAX to iterate over the ISP lines. This
> > makes the code somehow generic, but you only support a single line at
> > the moment. Does this or other SoCs in your product line integrate the
> > same ISP with multiple lines ? If so, would it be possible to share a
> > block diagram, to better understand the other hardware architectures
> > that this driver will need to support in the future ?
> 
> Yes, OK, I will add a block diagram and a more detailed description in
> the starfive_camss.rst file in the next version.
> 
> >> >> +enum isp_line_id {
> >> >> +	STF_ISP_LINE_INVALID = -1,
> >> >> +	STF_ISP_LINE_SRC = 1,
> >> >> +	STF_ISP_LINE_MAX = STF_ISP_LINE_SRC
> >> >> +};
> > 
> > [snip]
> > 
> >> >> +void stf_isp_init_cfg(struct stf_isp_dev *isp_dev)
> >> >> +{
> >> >> +	stf_isp_reg_write(isp_dev->stfcamss, ISP_REG_DC_CFG_1, DC_AXI_ID(0x0));
> >> >> +	stf_isp_reg_write(isp_dev->stfcamss, ISP_REG_DEC_CFG,
> >> >> +			  DEC_V_KEEP(0x0) |
> >> >> +			  DEC_V_PERIOD(0x0) |
> >> >> +			  DEC_H_KEEP(0x0) |
> >> >> +			  DEC_H_PERIOD(0x0));
> >> >> +
> >> >> +	stf_isp_config_obc(isp_dev->stfcamss);
> >> >> +	stf_isp_config_oecf(isp_dev->stfcamss);
> >> >> +	stf_isp_config_lccf(isp_dev->stfcamss);
> >> >> +	stf_isp_config_awb(isp_dev->stfcamss);
> >> >> +	stf_isp_config_grgb(isp_dev->stfcamss);
> >> >> +	stf_isp_config_cfa(isp_dev->stfcamss);
> >> >> +	stf_isp_config_ccm(isp_dev->stfcamss);
> >> >> +	stf_isp_config_gamma(isp_dev->stfcamss);
> >> >> +	stf_isp_config_r2y(isp_dev->stfcamss);
> >> >> +	stf_isp_config_y_curve(isp_dev->stfcamss);
> >> >> +	stf_isp_config_sharpen(isp_dev->stfcamss);
> >> >> +	stf_isp_config_dnyuv(isp_dev->stfcamss);
> >> >> +	stf_isp_config_sat(isp_dev->stfcamss);
> >> > 
> >> > All these parameters are hardcoded, why are they not exposed to
> >> > userspace ?
> >> 
> >> Here is a basic startup configuration for the ISP registers. The
> >> function name is confusing, as if it is configuring a specific
> >> function. In fact, it is just a basic init configuration.
> > 
> > Did I miss a place in the patch series where all these parameters can be
> > configured by userspace, or is that not possible at the moment ? If it
> > isn't possible, do you plan to implement that ?
> 
> Yes, we are doing related development internally.

That's nice to hear :-) Without the ability to control the ISP from
userspace, the driver will have very limited usefulness. Still, I
understand that incremental development will be easier to handle, so I'm
not against merging this patch series with hardcoded parameters first,
and adding support for ISP control on top. It may however make sense to
merge the driver in drivers/staging/media/ first, and move it to
drivers/media/ once support for ISP control will be available. That
would give you more room to change the userspace API exposed by the
driver when implementing support for ISP control without having to keep
backward compatibility. Sakari, Hans, do you have any opinion on this ?

Do you have an estimated time frame for when ISP control will be ready ?

> >> >> +
> >> >> +	stf_isp_reg_write(isp_dev->stfcamss, ISP_REG_CSI_MODULE_CFG,
> >> >> +			  CSI_DUMP_EN | CSI_SC_EN | CSI_AWB_EN |
> >> >> +			  CSI_LCCF_EN | CSI_OECF_EN | CSI_OBC_EN | CSI_DEC_EN);
> >> >> +	stf_isp_reg_write(isp_dev->stfcamss, ISP_REG_ISP_CTRL_1,
> >> >> +			  CTRL_SAT(1) | CTRL_DBC | CTRL_CTC | CTRL_YHIST |
> >> >> +			  CTRL_YCURVE | CTRL_BIYUV | CTRL_SCE | CTRL_EE |
> >> >> +			  CTRL_CCE | CTRL_RGE | CTRL_CME | CTRL_AE | CTRL_CE);
> >> >> +}
> > 
> > [snip]

-- 
Regards,

Laurent Pinchart
