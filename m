Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617F07F021F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 19:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjKRS4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 13:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjKRS4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 13:56:38 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE76B7;
        Sat, 18 Nov 2023 10:56:34 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B63C59B6;
        Sat, 18 Nov 2023 19:56:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1700333763;
        bh=Rh0UrSp9L3/GLQFW+ybv9m3qnxHHW+PS0Ir9n1DdEh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n5RjrxFsWKRcdF9+XfCR69MdzRUfTdJyxcoyFFQWYVem/kC3HwDTik3uNsGVkhPKp
         owyrjal4MtJaFo4R0YTtPO/PpLkWvGNRO9PSuVRzNLAhGSfId5oTBFgAoJNzWCkmv5
         gE1FyIWL3Gq7n9cJi5mMKI6b5qGxUuf+/YTg+25A=
Date:   Sat, 18 Nov 2023 20:56:38 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Stefan Wahren <wahrenst@gmx.net>
Cc:     Umang Jain <umang.jain@ideasonboard.com>,
        linux-media@vger.kernel.org, kernel-list@raspberrypi.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        "Ricardo B . Marliere" <ricardo@marliere.net>,
        Dan Carpenter <error27@gmail.com>,
        Naushir Patuck <naush@raspberrypi.com>
Subject: Re: [PATCH v2 10/15] staging: vc04_services: bcm2835-isp: Add a more
 complex ISP processing component
Message-ID: <20231118185638.GJ20846@pendragon.ideasonboard.com>
References: <20231109210309.638594-1-umang.jain@ideasonboard.com>
 <20231109210309.638594-11-umang.jain@ideasonboard.com>
 <414ba478-3a96-48e6-a3a7-88c920a20960@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <414ba478-3a96-48e6-a3a7-88c920a20960@gmx.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On Sat, Nov 18, 2023 at 03:53:41PM +0100, Stefan Wahren wrote:
> Am 09.11.23 um 22:03 schrieb Umang Jain:
> > From: Naushir Patuck <naush@raspberrypi.com>
> >
> > Driver for the BCM2835 ISP hardware block.  This driver uses the MMAL
> > component to program the ISP hardware through the VC firmware.
> >
> > The ISP component can produce two video stream outputs, and Bayer
> > image statistics. This can't be encompassed in a simple V4L2
> > M2M device, so create a new device that registers 4 video nodes.
> 
> sorry, i don't have much knowledge about V4L2, so someone else should
> review this in depth.
> 
> But from my PoV, patch 11, 12, 13 and 15 should be squash into this one.

For 11 and 12, I agree. 13 is a bit of a workaround for a missing
feature in V4L2, and while it's acceptable today, having it as a
separate commit may make it easier to revert it in the future when the
V4L2 API will be extended (that may or may not happen, and I wouldn't
count on it happening quickly in any case). I would keep patch 15
separate as it's not part of this driver.

> > Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
> > Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> > ---
> >   MAINTAINERS                                   |    9 +
> >   drivers/staging/vc04_services/Kconfig         |    2 +
> >   drivers/staging/vc04_services/Makefile        |    1 +
> >   .../staging/vc04_services/bcm2835-isp/Kconfig |   14 +
> >   .../vc04_services/bcm2835-isp/Makefile        |    4 +
> >   .../bcm2835-isp/bcm2835-isp-ctrls.h           |   72 +
> >   .../bcm2835-isp/bcm2835-isp-fmts.h            |  482 +++++
> >   .../bcm2835-isp/bcm2835-v4l2-isp.c            | 1712 +++++++++++++++++
> >   .../vc04_services/vchiq-mmal/mmal-encodings.h |    4 +
> >   .../vchiq-mmal/mmal-parameters.h              |  165 +-
> >   include/uapi/linux/bcm2835-isp.h              |   27 +
> >   11 files changed, 2491 insertions(+), 1 deletion(-)
> >   create mode 100644 drivers/staging/vc04_services/bcm2835-isp/Kconfig
> >   create mode 100644 drivers/staging/vc04_services/bcm2835-isp/Makefile
> >   create mode 100644 drivers/staging/vc04_services/bcm2835-isp/bcm2835-isp-ctrls.h
> >   create mode 100644 drivers/staging/vc04_services/bcm2835-isp/bcm2835-isp-fmts.h
> >   create mode 100644 drivers/staging/vc04_services/bcm2835-isp/bcm2835-v4l2-isp.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 0748cc15588c..8670a8d95400 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3976,6 +3976,15 @@ F:	Documentation/devicetree/bindings/mips/brcm/
> >   F:	arch/mips/bcm47xx/*
> >   F:	arch/mips/include/asm/mach-bcm47xx/*
> >
> > +BROADCOM BCM2835 ISP DRIVER
> > +M:	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
> > +L:	linux-media@vger.kernel.org
> > +S:	Maintained
> > +F:	Documentation/media/uapi/v4l/pixfmt-meta-bcm2835-isp-stats.rst
> > +F:	Documentation/media/v4l-drivers/bcm2835-isp.rst
> > +F:	drivers/staging/vc04_services/bcm2835-isp
> > +F:	include/uapi/linux/bcm2835-isp.h
> > +
> >   BROADCOM BCM4908 ETHERNET DRIVER
> >   M:	Rafał Miłecki <rafal@milecki.pl>
> >   R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
> > diff --git a/drivers/staging/vc04_services/Kconfig b/drivers/staging/vc04_services/Kconfig
> > index 6c0e77d64376..e71e5a8b820a 100644
> > --- a/drivers/staging/vc04_services/Kconfig
> > +++ b/drivers/staging/vc04_services/Kconfig
> > @@ -44,6 +44,8 @@ source "drivers/staging/vc04_services/bcm2835-audio/Kconfig"
> >
> >   source "drivers/staging/vc04_services/bcm2835-camera/Kconfig"
> >
> > +source "drivers/staging/vc04_services/bcm2835-isp/Kconfig"
> > +
> >   source "drivers/staging/vc04_services/vchiq-mmal/Kconfig"
> >
> >   source "drivers/staging/vc04_services/vc-sm-cma/Kconfig"
> > diff --git a/drivers/staging/vc04_services/Makefile b/drivers/staging/vc04_services/Makefile
> > index 1f61a263f22d..2cebf92525a0 100644
> > --- a/drivers/staging/vc04_services/Makefile
> > +++ b/drivers/staging/vc04_services/Makefile
> > @@ -16,3 +16,4 @@ obj-$(CONFIG_SND_BCM2835)		+= bcm2835-audio/
> >   obj-$(CONFIG_VIDEO_BCM2835)		+= bcm2835-camera/
> >   obj-$(CONFIG_BCM2835_VCHIQ_MMAL)	+= vchiq-mmal/
> >   obj-$(CONFIG_BCM_VC_SM_CMA)		+= vc-sm-cma/
> > +obj-$(CONFIG_VIDEO_ISP_BCM2835) 	+= bcm2835-isp/
> > diff --git a/drivers/staging/vc04_services/bcm2835-isp/Kconfig b/drivers/staging/vc04_services/bcm2835-isp/Kconfig
> > new file mode 100644
> > index 000000000000..6222799ebe16
> > --- /dev/null
> > +++ b/drivers/staging/vc04_services/bcm2835-isp/Kconfig
> > @@ -0,0 +1,14 @@
> > +config VIDEO_ISP_BCM2835
> > +	tristate "BCM2835 ISP support"
> > +	depends on MEDIA_SUPPORT
> > +	depends on VIDEO_DEV && (ARCH_BCM2835 || COMPILE_TEST)
> > +	depends on MEDIA_CONTROLLER
> > +	select BCM2835_VCHIQ_MMAL
> > +	select VIDEOBUF2_DMA_CONTIG
> > +	help
> > +	  This is the V4L2 driver for the Broadcom BCM2835 ISP hardware.
> 
> I think the description is not helpful for all users. Not everybody
> knows what ISP is for. Please describe it more for an end user.
> 
> > +	  This operates over the VCHIQ interface to a service running on
> > +	  VideoCore.
> > +
> > +	  To compile this driver as a module, choose M here: the module
> > +	  will be called bcm2835-isp.

-- 
Regards,

Laurent Pinchart
