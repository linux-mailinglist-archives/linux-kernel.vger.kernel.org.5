Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F707BD843
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 12:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346106AbjJIKMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 06:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346082AbjJIKMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 06:12:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B119F;
        Mon,  9 Oct 2023 03:12:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7C4C433C8;
        Mon,  9 Oct 2023 10:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696846359;
        bh=Lhz7NJ1tDCejF86o05TS9JEpIQ4lWXn8MoWl0J9KPqE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=po/0K3QJfM6UIcRGbH6qsu+QJDyBoAmen6H9PM+LUkk3iAHgnZmdq8c+z6xd6XXFd
         SQQfS+t7wYzIiL8t3DsWEptHOi0ZU/UvmLA0eoRcq/Vl5KdHVKAykOxyp9J0QGdc/B
         Z2I9bM10mZygydjgNtTG2XZGwEYJBXqwBvCkX/Hs=
Date:   Mon, 9 Oct 2023 12:12:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Umang Jain <umang.jain@ideasonboard.com>
Cc:     linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v12 5/6] staging: bcm2835-camera: Register bcm2835-camera
 with vchiq_bus_type
Message-ID: <2023100955-stunt-equate-c6fa@gregkh>
References: <20230923143200.268063-1-umang.jain@ideasonboard.com>
 <20230923143200.268063-6-umang.jain@ideasonboard.com>
 <2023100542-gluten-rally-5a96@gregkh>
 <ca3ec33e-4e42-9bce-eb24-99df0e39473e@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca3ec33e-4e42-9bce-eb24-99df0e39473e@ideasonboard.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 09:50:29AM +0530, Umang Jain wrote:
> Hi Greg,
> 
> Sorry for late reply, as I was traveling and then was on vacation for rest
> of the week.
> 
> On 10/5/23 1:34 PM, Greg Kroah-Hartman wrote:
> > On Sat, Sep 23, 2023 at 08:01:59PM +0530, Umang Jain wrote:
> > > Register the bcm2835-camera with the vchiq_bus_type instead of using
> > > platform driver/device.
> > > 
> > > Since we moved away bcm2835-camera from platform driver/device,
> > > we have to set the DMA mask explicitly. Set the DMA mask at probe
> > > time.
> > > 
> > > Also the VCHIQ firmware doesn't support device enumeration, hence
> > > one has to maintain a list of devices to be registered in the interface.
> > > 
> > > Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> > > ---
> > >   .../bcm2835-camera/bcm2835-camera.c           | 21 ++++++++++---------
> > >   .../interface/vchiq_arm/vchiq_arm.c           | 11 +++++++---
> > >   2 files changed, 19 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
> > > index fcad5118f3e8..c873eace1437 100644
> > > --- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
> > > +++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
> > > @@ -11,6 +11,7 @@
> > >    *          Luke Diamand @ Broadcom
> > >    */
> > > +#include <linux/dma-mapping.h>
> > >   #include <linux/errno.h>
> > >   #include <linux/kernel.h>
> > >   #include <linux/module.h>
> > > @@ -24,8 +25,8 @@
> > >   #include <media/v4l2-event.h>
> > >   #include <media/v4l2-common.h>
> > >   #include <linux/delay.h>
> > > -#include <linux/platform_device.h>
> > > +#include "../interface/vchiq_arm/vchiq_bus.h"
> > >   #include "../vchiq-mmal/mmal-common.h"
> > >   #include "../vchiq-mmal/mmal-encodings.h"
> > >   #include "../vchiq-mmal/mmal-vchiq.h"
> > > @@ -1841,7 +1842,7 @@ static struct v4l2_format default_v4l2_format = {
> > >   	.fmt.pix.sizeimage = 1024 * 768,
> > >   };
> > > -static int bcm2835_mmal_probe(struct platform_device *pdev)
> > > +static int bcm2835_mmal_probe(struct vchiq_device *device)
> > >   {
> > >   	int ret;
> > >   	struct bcm2835_mmal_dev *dev;
> > > @@ -1852,9 +1853,9 @@ static int bcm2835_mmal_probe(struct platform_device *pdev)
> > >   	unsigned int resolutions[MAX_BCM2835_CAMERAS][2];
> > >   	int i;
> > > -	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> > > +	ret = dma_set_mask_and_coherent(&device->dev, DMA_BIT_MASK(32));
> > >   	if (ret) {
> > > -		dev_err(&pdev->dev, "dma_set_mask_and_coherent failed: %d\n", ret);
> > > +		dev_err(&device->dev, "dma_set_mask_and_coherent failed: %d\n", ret);
> > >   		return ret;
> > >   	}
> > > @@ -1902,7 +1903,7 @@ static int bcm2835_mmal_probe(struct platform_device *pdev)
> > >   						       &camera_instance);
> > >   		ret = v4l2_device_register(NULL, &dev->v4l2_dev);
> > >   		if (ret) {
> > > -			dev_err(&pdev->dev, "%s: could not register V4L2 device: %d\n",
> > > +			dev_err(&device->dev, "%s: could not register V4L2 device: %d\n",
> > >   				__func__, ret);
> > >   			goto free_dev;
> > >   		}
> > > @@ -1982,7 +1983,7 @@ static int bcm2835_mmal_probe(struct platform_device *pdev)
> > >   	return ret;
> > >   }
> > > -static void bcm2835_mmal_remove(struct platform_device *pdev)
> > > +static void bcm2835_mmal_remove(struct vchiq_device *device)
> > >   {
> > >   	int camera;
> > >   	struct vchiq_mmal_instance *instance = gdev[0]->instance;
> > > @@ -1994,17 +1995,17 @@ static void bcm2835_mmal_remove(struct platform_device *pdev)
> > >   	vchiq_mmal_finalise(instance);
> > >   }
> > > -static struct platform_driver bcm2835_camera_driver = {
> > > +static struct vchiq_driver bcm2835_camera_driver = {
> > >   	.probe		= bcm2835_mmal_probe,
> > > -	.remove_new	= bcm2835_mmal_remove,
> > > +	.remove		= bcm2835_mmal_remove,
> > >   	.driver		= {
> > >   		.name	= "bcm2835-camera",
> > >   	},
> > >   };
> > > -module_platform_driver(bcm2835_camera_driver)
> > > +module_vchiq_driver(bcm2835_camera_driver)
> > >   MODULE_DESCRIPTION("Broadcom 2835 MMAL video capture");
> > >   MODULE_AUTHOR("Vincent Sanders");
> > >   MODULE_LICENSE("GPL");
> > > -MODULE_ALIAS("platform:bcm2835-camera");
> > > +MODULE_ALIAS("bcm2835-camera");
> > Now that you are on your own bus, why do you need the MODULE_ALIAS()
> > line at all?
> 
> Because it breaks the module auto-loading support...

But that's not how auto-loading should work once you have a real bus.

> If you look at the vchiq_bus patch (3/6) in this series, there is
> vchiq_bus_uevent() which sends a event that includes the MODALIAS.

The module alias should be automatically picked out of the
MODULE_DEVICE_TABLE() macro that you should be using for this driver,
you should never have to manually create MODULE_ALIAS() lines.

That's a bad hold-over because the platform driver subsystem can not
handle module aliases on it's own, let's not copy that bad pattern here
as well please.

thanks,

greg k-h
