Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F77798B7B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 19:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241068AbjIHR0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 13:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbjIHR0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 13:26:33 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AF91FC7;
        Fri,  8 Sep 2023 10:26:29 -0700 (PDT)
Received: from pendragon.ideasonboard.com (unknown [31.94.18.223])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CF8E310FE;
        Fri,  8 Sep 2023 19:24:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1694193899;
        bh=oWaVYJ84yTw1F3FOc83sGFaJxwx0456GDMdxWGrUfRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fN3CZgDk/6BOrsjuDCPxlMB7Mww+IeF5LEWUm3jf3SUaWSkcGhmp0HWjfqkXp4Hks
         1ZWp7AfG39C7bic6LRpn2wHmce4MlZlfDnpg2SFlRvGMN8xk1J7gk4wL8psrllJN2J
         VTMYwuXqD5+LzpXxvD8dQpirPw+Ixwfbd80BuWTE=
Date:   Fri, 8 Sep 2023 20:26:41 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Umang Jain <umang.jain@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jackson <lee.jackson@arducam.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Shawn Tu <shawnx.tu@intel.com>,
        kieran.bingham@ideasonboard.com, jacopo.mondi@ideasonboard.com
Subject: Re: [PATCH v6 2/2] media: i2c: Add driver for IMX519 sensor
Message-ID: <20230908172641.GF17610@pendragon.ideasonboard.com>
References: <20230908124344.171662-1-umang.jain@ideasonboard.com>
 <20230908124344.171662-3-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230908124344.171662-3-umang.jain@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Umang,

Thank you for the patch.

On Fri, Sep 08, 2023 at 08:43:44AM -0400, Umang Jain wrote:
> From: Lee Jackson <lee.jackson@arducam.com>
> 
> Add a driver for the 16MPix IMX519 CSI2 sensor.
> Whilst the sensor supports 2 or 4 CSI2 data lanes, this driver
> currently only supports 2 lanes.
> 
> The following Bayer modes are currently available:
> 
> 4656x3496 10-bit @ 10fps
> 3840x2160 10-bit (cropped) @ 21fps
> 2328x1748 10-bit (binned) @ 30fps
> 1920x1080 10-bit (cropped/binned) @ 60fps
> 1280x720 10-bit (cropped/binned) @ 120fps
> 
> Signed-off-by: Lee Jackson <lee.jackson@arducam.com>
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>  MAINTAINERS                |    1 +
>  drivers/media/i2c/Kconfig  |   14 +
>  drivers/media/i2c/Makefile |    1 +
>  drivers/media/i2c/imx519.c | 1842 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 1858 insertions(+)
>  create mode 100644 drivers/media/i2c/imx519.c

[snip]

> diff --git a/drivers/media/i2c/imx519.c b/drivers/media/i2c/imx519.c
> new file mode 100644
> index 000000000000..f818a3d0bd25
> --- /dev/null
> +++ b/drivers/media/i2c/imx519.c
> @@ -0,0 +1,1842 @@

[snip]

> +/* 16 mpix 10fps */
> +static const struct cci_reg_sequence mode_4656x3496_regs[] = {
> +	{ CCI_REG8(0x0111), 0x02 },
> +	{ CCI_REG8(0x0112), 0x0a },
> +	{ CCI_REG8(0x0113), 0x0a },
> +	{ CCI_REG8(0x0114), 0x01 },
> +	{ CCI_REG8(0x0342), 0x42 },
> +	{ CCI_REG8(0x0343), 0x00 },
> +	{ CCI_REG8(0x0340), 0x0d },
> +	{ CCI_REG8(0x0341), 0xf4 },
> +	{ CCI_REG8(0x0344), 0x00 },
> +	{ CCI_REG8(0x0345), 0x00 },
> +	{ CCI_REG8(0x0346), 0x00 },
> +	{ CCI_REG8(0x0347), 0x00 },
> +	{ CCI_REG8(0x0348), 0x12 },
> +	{ CCI_REG8(0x0349), 0x2f },
> +	{ CCI_REG8(0x034a), 0x0d },
> +	{ CCI_REG8(0x034b), 0xa7 },
> +	{ CCI_REG8(0x0220), 0x00 },
> +	{ CCI_REG8(0x0221), 0x11 },
> +	{ CCI_REG8(0x0222), 0x01 },
> +	{ CCI_REG8(0x0900), 0x00 },
> +	{ CCI_REG8(0x0901), 0x11 },
> +	{ CCI_REG8(0x0902), 0x0a },
> +	{ CCI_REG8(0x3f4c), 0x01 },
> +	{ CCI_REG8(0x3f4d), 0x01 },
> +	{ CCI_REG8(0x4254), 0x7f },
> +	{ CCI_REG8(0x0401), 0x00 },
> +	{ CCI_REG8(0x0404), 0x00 },
> +	{ CCI_REG8(0x0405), 0x10 },
> +	{ CCI_REG8(0x0408), 0x00 },
> +	{ CCI_REG8(0x0409), 0x00 },
> +	{ CCI_REG8(0x040a), 0x00 },
> +	{ CCI_REG8(0x040b), 0x00 },
> +	{ CCI_REG8(0x040c), 0x12 },
> +	{ CCI_REG8(0x040d), 0x30 },
> +	{ CCI_REG8(0x040e), 0x0d },
> +	{ CCI_REG8(0x040f), 0xa8 },
> +	{ CCI_REG8(0x034c), 0x12 },
> +	{ CCI_REG8(0x034d), 0x30 },
> +	{ CCI_REG8(0x034e), 0x0d },
> +	{ CCI_REG8(0x034f), 0xa8 },
> +	{ CCI_REG8(0x0301), 0x06 },
> +	{ CCI_REG8(0x0303), 0x04 },
> +	{ CCI_REG8(0x0305), 0x04 },
> +	{ CCI_REG8(0x0306), 0x01 },
> +	{ CCI_REG8(0x0307), 0x57 },
> +	{ CCI_REG8(0x0309), 0x0a },
> +	{ CCI_REG8(0x030b), 0x02 },
> +	{ CCI_REG8(0x030d), 0x04 },
> +	{ CCI_REG8(0x030e), 0x01 },
> +	{ CCI_REG8(0x030f), 0x49 },
> +	{ CCI_REG8(0x0310), 0x01 },
> +	{ CCI_REG8(0x0820), 0x07 },
> +	{ CCI_REG8(0x0821), 0xb6 },
> +	{ CCI_REG8(0x0822), 0x00 },
> +	{ CCI_REG8(0x0823), 0x00 },
> +	{ CCI_REG8(0x3e20), 0x01 },
> +	{ CCI_REG8(0x3e37), 0x00 },
> +	{ CCI_REG8(0x3e3b), 0x00 },
> +	{ CCI_REG8(0x0106), 0x00 },
> +	{ CCI_REG8(0x0b00), 0x00 },
> +	{ CCI_REG8(0x3230), 0x00 },
> +	{ CCI_REG8(0x3f14), 0x01 },
> +	{ CCI_REG8(0x3f3c), 0x01 },
> +	{ CCI_REG8(0x3f0d), 0x0a },
> +	{ CCI_REG8(0x3fbc), 0x00 },
> +	{ CCI_REG8(0x3c06), 0x00 },
> +	{ CCI_REG8(0x3c07), 0x48 },
> +	{ CCI_REG8(0x3c0a), 0x00 },
> +	{ CCI_REG8(0x3c0b), 0x00 },
> +	{ CCI_REG8(0x3f78), 0x00 },
> +	{ CCI_REG8(0x3f79), 0x40 },
> +	{ CCI_REG8(0x3f7c), 0x00 },
> +	{ CCI_REG8(0x3f7d), 0x00 },
> +};

Looking at the per-mode tables, it appears that all registers below
0x3000 are CCS-compliant. Furthermore, all registers from 0x3000 above
(defined in CCS as the manufacturer-specific register - or MSR - range)
are identical for all modes. I can't tell if other modes could require
different values for MSRs, so it's hard to assess real CCS compliance,
but it looks like giving the CCS driver a try would be a good idea.

I'm sure Sakari will be delighted :-)

[snip]

-- 
Regards,

Laurent Pinchart
