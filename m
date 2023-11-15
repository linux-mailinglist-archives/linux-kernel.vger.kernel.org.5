Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CA97ED12A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 20:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344035AbjKOT7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 14:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344050AbjKOT7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 14:59:47 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD39A198;
        Wed, 15 Nov 2023 11:59:43 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 66D4829A;
        Wed, 15 Nov 2023 20:59:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1700078355;
        bh=PegmATKsI+yOYqC6YPDozlL/Qfi0uj6FjDrtkWOyIJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nQ2i43KSroDNlGLXdrDJL8QjKLXezf8wfXWFitbIv7NvEMg9jwlf1YBkD5BB5X+BE
         thZqQAi/NBrNC/vMyM9A2QFMpqrfmSDPJKRUSUw9HkrNOEzNmnvHc0yASZLDKLG995
         zVJbUubwdJHk/OTa0Jrlq3F/AZlCwvFdT5QAIR+s=
Date:   Wed, 15 Nov 2023 21:59:47 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Umang Jain <umang.jain@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, kernel-list@raspberrypi.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        "Ricardo B . Marliere" <ricardo@marliere.net>,
        Dan Carpenter <error27@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH v2 00/15] staging: vc04_services: bcm2835-isp support
Message-ID: <20231115195947.GD29486@pendragon.ideasonboard.com>
References: <20231109210309.638594-1-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231109210309.638594-1-umang.jain@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Nov 09, 2023 at 04:02:52PM -0500, Umang Jain wrote:
> This series aims to upport bcm2835-isp from the RPi kernel.
> It is developed on top of staging-next which comprises many
> VC04 changes for it's de-staging. Hence, the merge of this
> driver is targeted when VC04 is de-staged completely (which I
> have been pushing), but it can be helped getting reviewed meanwhile.
> Hence, the reason for posting the series.

Related question, what do people think about dropping the legacy
firmware-based bcm2385-camera driver once this gets merged ?
firmware-based camera operation is deprecated by Raspberry Pi, and
doesn't work on the Pi 5.

> Patch (01-02)/15  adds a new driver named vc-sm-cma to handle memory sharing
> with the VC4 VPU. 
> 
> Patch 03/15 adds a small extension to videobuf2 to allow exporting as a
> dma_buf instead of a file-descriptor.
> 
> Patch (04-05)/15 adds a couple of improvements/support for
> bcm2835-isp(event callback and zero-copy) to vchiq-mmal.
> 
> Patch (06-10)/15 adds the core bcm2835-isp driver along with headers
> and format defintions. 09/15 is a standalone patch which can be merged
> independently I believe.
> 
> Patch (11-12)/15 deals with the colorspace support.
> 
> Patch 13/15 allows multiple instances of the ISP.
> 
> Patch 14/15 adds a admin-guide document on bcm2835-isp.
> 
> Patch 15/15 deals with driver registeration.
> 
> Dave Stevenson (6):
>   staging: vc04_services: Add new vc-sm-cma driver
>   media: videobuf2: Allow exporting of a struct dmabuf
>   staging: mmal-vchiq: Add support for event callbacks
>   staging: mmal-vchiq: Use vc-sm-cma to support zero copy
>   staging: mmal_vchiq: Add image formats to be used by bcm2835-isp
>   uapi: bcm2835-isp: Add bcm2835-isp uapi header file
> 
> David Plowman (2):
>   vc04_services: bcm2835-isp: Allow formats with different colour spaces
>   vc04_services: bcm2835-isp: Permit all sRGB colour spaces on ISP
>     outputs
> 
> Naushir Patuck (4):
>   media: uapi: v4l2-core: Add ISP statistics output V4L2 fourcc type
>   staging: vc04_services: bcm2835-isp: Add a more complex ISP processing
>     component
>   staging: vc04_services: bcm2835_isp: Allow multiple users
>   docs: admin-guide: media: bcm2835-isp: Add documentation for
>     bcm2835-isp
> 
> Umang Jain (3):
>   staging: vc04_services: vchiq_arm: Register vcsm-cma driver
>   staging: vc04_services: Add helpers for vchiq driver data
>   staging: vc04_services: vchiq: Register bcm2835-isp
> 
>  .../admin-guide/media/bcm2835-isp.rst         |  127 ++
>  .../userspace-api/media/drivers/index.rst     |    1 +
>  .../userspace-api/media/v4l/meta-formats.rst  |    1 +
>  .../v4l/pixfmt-meta-bcm2835-isp-stats.rst     |   32 +
>  MAINTAINERS                                   |    9 +
>  .../media/common/videobuf2/videobuf2-core.c   |   36 +-
>  drivers/media/v4l2-core/v4l2-ioctl.c          |    1 +
>  drivers/staging/vc04_services/Kconfig         |    4 +
>  drivers/staging/vc04_services/Makefile        |    3 +-
>  .../staging/vc04_services/bcm2835-isp/Kconfig |   14 +
>  .../vc04_services/bcm2835-isp/Makefile        |    4 +
>  .../bcm2835-isp/bcm2835-isp-ctrls.h           |   72 +
>  .../bcm2835-isp/bcm2835-isp-fmts.h            |  559 +++++
>  .../bcm2835-isp/bcm2835-v4l2-isp.c            | 1822 +++++++++++++++++
>  .../interface/vchiq_arm/vchiq_arm.c           |    6 +
>  .../interface/vchiq_arm/vchiq_bus.h           |   10 +
>  .../staging/vc04_services/vc-sm-cma/Kconfig   |   10 +
>  .../staging/vc04_services/vc-sm-cma/Makefile  |    4 +
>  .../staging/vc04_services/vc-sm-cma/vc_sm.c   |  817 ++++++++
>  .../staging/vc04_services/vc-sm-cma/vc_sm.h   |   54 +
>  .../vc04_services/vc-sm-cma/vc_sm_cma_vchi.c  |  507 +++++
>  .../vc04_services/vc-sm-cma/vc_sm_cma_vchi.h  |   63 +
>  .../vc04_services/vc-sm-cma/vc_sm_defs.h      |  187 ++
>  .../vc04_services/vc-sm-cma/vc_sm_knl.h       |   28 +
>  .../staging/vc04_services/vchiq-mmal/Kconfig  |    1 +
>  .../vc04_services/vchiq-mmal/mmal-common.h    |    5 +
>  .../vc04_services/vchiq-mmal/mmal-encodings.h |   66 +
>  .../vc04_services/vchiq-mmal/mmal-msg.h       |   35 +
>  .../vchiq-mmal/mmal-parameters.h              |  165 +-
>  .../vc04_services/vchiq-mmal/mmal-vchiq.c     |  253 ++-
>  .../vc04_services/vchiq-mmal/mmal-vchiq.h     |    5 +
>  include/media/videobuf2-core.h                |   15 +
>  include/uapi/linux/bcm2835-isp.h              |  347 ++++
>  include/uapi/linux/v4l2-controls.h            |    5 +
>  include/uapi/linux/videodev2.h                |    1 +
>  35 files changed, 5235 insertions(+), 34 deletions(-)
>  create mode 100644 Documentation/admin-guide/media/bcm2835-isp.rst
>  create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-meta-bcm2835-isp-stats.rst
>  create mode 100644 drivers/staging/vc04_services/bcm2835-isp/Kconfig
>  create mode 100644 drivers/staging/vc04_services/bcm2835-isp/Makefile
>  create mode 100644 drivers/staging/vc04_services/bcm2835-isp/bcm2835-isp-ctrls.h
>  create mode 100644 drivers/staging/vc04_services/bcm2835-isp/bcm2835-isp-fmts.h
>  create mode 100644 drivers/staging/vc04_services/bcm2835-isp/bcm2835-v4l2-isp.c
>  create mode 100644 drivers/staging/vc04_services/vc-sm-cma/Kconfig
>  create mode 100644 drivers/staging/vc04_services/vc-sm-cma/Makefile
>  create mode 100644 drivers/staging/vc04_services/vc-sm-cma/vc_sm.c
>  create mode 100644 drivers/staging/vc04_services/vc-sm-cma/vc_sm.h
>  create mode 100644 drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.c
>  create mode 100644 drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.h
>  create mode 100644 drivers/staging/vc04_services/vc-sm-cma/vc_sm_defs.h
>  create mode 100644 drivers/staging/vc04_services/vc-sm-cma/vc_sm_knl.h
>  create mode 100644 include/uapi/linux/bcm2835-isp.h

-- 
Regards,

Laurent Pinchart
