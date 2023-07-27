Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6CE765DB0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 23:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjG0VE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 17:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjG0VEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:04:23 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C85273E;
        Thu, 27 Jul 2023 14:04:21 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 34C4A2E4;
        Thu, 27 Jul 2023 23:03:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690491800;
        bh=YfEcvIPkQ/u1qCXnD/eO6Jp2xF7xny1sba71dt626Lc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rC3oF+PQ411Lgg3BcS3TkykhDt+QyuQzf3hJbZEz7Nhe34SU/fEQwMbuITJvQP7Dj
         ra+haFKjyQ/j4LHUQQyVMPwgsm1oiRcQeosfKbFM0Ajg0I2EOgb/kXjsnnQaqyHcOD
         gzNnzFNohgvsJG48KwZ0GQHG7z/eArM2/yCc3Rj4=
Date:   Fri, 28 Jul 2023 00:04:25 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     Devarsh Thakkar <devarsht@ti.com>, mchehab@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, hverkuil-cisco@xs4all.nl,
        eugen.hristev@collabora.com, ezequiel@vanguardiasur.com.ar,
        u.kleine-koenig@pengutronix.de, sakari.ailus@linux.intel.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, praneeth@ti.com, nm@ti.com,
        vigneshr@ti.com, a-bhatia1@ti.com, j-luthra@ti.com,
        b-brnich@ti.com, detheridge@ti.com, p-mantena@ti.com, vijayp@ti.com
Subject: Re: [PATCH v2 2/2] media: imagination: Add E5010 JPEG Encoder driver
Message-ID: <20230727210425.GK25174@pendragon.ideasonboard.com>
References: <20230727112546.2201995-1-devarsht@ti.com>
 <20230727112546.2201995-3-devarsht@ti.com>
 <b83249c002c6986f471913cf96fa631c46ec69be.camel@ndufresne.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b83249c002c6986f471913cf96fa631c46ec69be.camel@ndufresne.ca>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 10:10:41AM -0400, Nicolas Dufresne wrote:
> Le jeudi 27 juillet 2023 à 16:55 +0530, Devarsh Thakkar a écrit :
> > This adds support for stateful V4L2 M2M based driver
> > for Imagination E5010 JPEG Encoder [1] which supports baseline
> > encoding with two different quantization tables and compression
> > ratio as demanded.
> > 
> > Support for both contigous and non-contigous YUV420 and YUV422
>                    contiguous        contiguous
> 
> > semiplanar formats is added along with alignment restrictions
> > as required by the hardware.
> > 
> > System and runtime PM hooks are added in the driver along with v4l2
> > crop and selection API support.
> > 
> > Minimum resolution supported is 64x64 and
> > Maximum resolution supported is 8192x8192.
> > 
> > All v4l2-compliance tests are passing [2] :
> > v4l2-compliance -s -f -a  -d /dev/video0 -e /dev/video1
> > 
> > Total for e5010 device /dev/video0: 78, Succeeded: 78, Failed: 0,
> > Warnings: 0
> > 
> > NOTE: video1 here is VIVID test pattern generator
> > 
> > Also tests [3] were run manually to verify below driver features:
> >  - Runtime Power Management
> >  - Multi-instance JPEG Encoding
> >  - DMABUF import, export support
> >  - NV12, NV21, NV16, NV61 video format support
> >  - Compression quality S_CTRL
> > 
> > Existing V4L2 M2M based JPEG drivers namely s5p-jpeg,
> > imx-jpeg and rcar_jpu were referred while making this.
> > 
> > [1]:  AM62A TRM (Section 7.6 is for JPEG Encoder)
> > Link: https://www.ti.com/lit/pdf/spruj16
> > 
> > [2]: v4l2-compliance test :
> > Link: https://gist.github.com/devarsht/867b1d646bca3f3877edb1f3638aae31
> > 
> > [3]: E5010 JPEG Encoder Manual tests :
> > Link: https://gist.github.com/devarsht/ea31179199393c2026ae457219bb6321
> > 
> > Co-developed-by: David Huang <d-huang@ti.com>
> > Signed-off-by: David Huang <d-huang@ti.com>
> > Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> > ---
> > V2: No change
> > 
> >  MAINTAINERS                                   |    2 +
> >  drivers/media/platform/Kconfig                |    1 +
> >  drivers/media/platform/Makefile               |    1 +
> >  drivers/media/platform/imagination/Kconfig    |   13 +
> >  drivers/media/platform/imagination/Makefile   |    3 +
> >  .../platform/imagination/e5010-core-regs.h    |  584 ++++++
> >  .../platform/imagination/e5010-jpeg-enc-hw.c  |  319 +++
> >  .../platform/imagination/e5010-jpeg-enc-hw.h  |   41 +
> >  .../platform/imagination/e5010-jpeg-enc.c     | 1762 +++++++++++++++++
> >  .../platform/imagination/e5010-jpeg-enc.h     |  165 ++
> >  .../platform/imagination/e5010-mmu-regs.h     |  303 +++
> >  11 files changed, 3194 insertions(+)
> >  create mode 100644 drivers/media/platform/imagination/Kconfig
> >  create mode 100644 drivers/media/platform/imagination/Makefile
> >  create mode 100644 drivers/media/platform/imagination/e5010-core-regs.h
> >  create mode 100644 drivers/media/platform/imagination/e5010-jpeg-enc-hw.c
> >  create mode 100644 drivers/media/platform/imagination/e5010-jpeg-enc-hw.h
> >  create mode 100644 drivers/media/platform/imagination/e5010-jpeg-enc.c
> >  create mode 100644 drivers/media/platform/imagination/e5010-jpeg-enc.h
> >  create mode 100644 drivers/media/platform/imagination/e5010-mmu-regs.h

[snip]

> > diff --git a/drivers/media/platform/imagination/e5010-core-regs.h b/drivers/media/platform/imagination/e5010-core-regs.h
> > new file mode 100644
> > index 000000000000..aa2d57146c3d
> > --- /dev/null
> > +++ b/drivers/media/platform/imagination/e5010-core-regs.h
> > @@ -0,0 +1,584 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * TI E5010 JPEG Encoder driver.
> > + *
> > + * Copyright (c) 2023 Texas Instruments Inc.
> > + * Author: David Huang <d-huang@ti.com>
> > + * Author: Devarsh Thakkar <devarsht@ti.com>
> > + */
> > +
> > +#ifndef _E5010_CORE_REGS_H
> > +#define _E5010_CORE_REGS_H
> 
> nit: Could be modernized to "#pragma once" (though only used in selftest so far)

I don't know if there's a kernel-wide policy regarding its use, but
Linus has not too long ago expressed a dislike for "#pragma once", see
https://lore.kernel.org/lkml/CAHk-=wi13+FLcRo4zmnRUmmY=AAns-Yd5NR_mVdcAd6ZrPq2fA@mail.gmail.com/.

[snip]

-- 
Regards,

Laurent Pinchart
