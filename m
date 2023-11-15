Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6497ECC27
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 20:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbjKOT1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 14:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbjKOT1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 14:27:05 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA09FD43;
        Wed, 15 Nov 2023 11:27:01 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1B11F29A;
        Wed, 15 Nov 2023 20:26:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1700076393;
        bh=HuvqlF4fz7sV1Btrlh+F7H9LaWiQ+2kuf+3ugMlgbII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SH3pZ8UsCtCH4aQvZPeCAc/JEA/VsNBXYIruQ7dpIXgRP2IGApeRfodtdKOUtGSpQ
         0tOr+1ARI49S/OtijiXwNSvJPJsz59o9H2NBHHE56PSaGaE0p4IY14TOJCG81AV3Yt
         ovyzzYOmN4QpKG4xN/kKoiu6Rj5D6hoe0jcEpkEg=
Date:   Wed, 15 Nov 2023 21:27:05 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Umang Jain <umang.jain@ideasonboard.com>,
        linux-media@vger.kernel.org, kernel-list@raspberrypi.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        "Ricardo B . Marliere" <ricardo@marliere.net>,
        Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v2 05/15] staging: mmal-vchiq: Use vc-sm-cma to support
 zero copy
Message-ID: <20231115192705.GC21100@pendragon.ideasonboard.com>
References: <20231109210309.638594-1-umang.jain@ideasonboard.com>
 <20231109210309.638594-6-umang.jain@ideasonboard.com>
 <3b9ec650-8a99-4bac-9ac9-d2cd87efced5@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3b9ec650-8a99-4bac-9ac9-d2cd87efced5@i2se.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 08:03:47PM +0100, Stefan Wahren wrote:
> Hi Umang,
> 
> Am 09.11.23 um 22:02 schrieb Umang Jain:
> > From: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > 
> > With the vc-sm-cma driver we can support zero copy of buffers between
> > the kernel and VPU. Add this support to mmal-vchiq.
> > 
> > Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> > ---
> >   .../staging/vc04_services/vchiq-mmal/Kconfig  |  1 +
> >   .../vc04_services/vchiq-mmal/mmal-common.h    |  4 +
> >   .../vc04_services/vchiq-mmal/mmal-vchiq.c     | 84 +++++++++++++++++--
> >   .../vc04_services/vchiq-mmal/mmal-vchiq.h     |  1 +
> >   4 files changed, 83 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/staging/vc04_services/vchiq-mmal/Kconfig b/drivers/staging/vc04_services/vchiq-mmal/Kconfig
> > index c99525a0bb45..a7c1a7bf516e 100644
> > --- a/drivers/staging/vc04_services/vchiq-mmal/Kconfig
> > +++ b/drivers/staging/vc04_services/vchiq-mmal/Kconfig
> > @@ -1,6 +1,7 @@
> >   config BCM2835_VCHIQ_MMAL
> >   	tristate "BCM2835 MMAL VCHIQ service"
> >   	depends on BCM2835_VCHIQ
> > +	select BCM_VC_SM_CMA
> 
> i think we need more explanation in the commit message of the relation 
> between these both modules.
> 
> On the one side BCM_VC_SM_CMA should be a driver, but it's not a driver 
> for a specific hardware. It looks like more an extension of VCHIQ MMAL 
> or does other (maybe not yet imported) vc04 driver make also use of this.
> 
> My question is: is BCM_VC_SM_CMA a real member on the VCHIQ bus and why?

The vchiq_device pointer passed to the vc_sm_cma probe function is used
in the driver for the sole purpose of accessing the underlying struct
device, which, beside being used for dev_*() log calls, is just passed
to dma_buf_attach(). It does indeed appear to be more of a service than
a device.

-- 
Regards,

Laurent Pinchart
