Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81AB57A9742
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjIURMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjIURKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:10:39 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDDCAD1F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:06:02 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id F2F7D10FE;
        Thu, 21 Sep 2023 14:11:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1695298276;
        bh=iO0UHzPBM95Q2gC6Mfq+/hI5nIK6J68Fe0rzREmv7NM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tmdFjAhuh7h5Bc4T4ykOgiI5rN/HF3hDjOgZBMb3SvMmlHDpiNUNtzd1ETXeasVyE
         uGPn/i3q44xCOIfwXRVpl0RdQZnxsR0dBQ0qadut6wzJ+VC2yuOm/TOIiPvDedA0La
         6OVXn2zaAPqz2u24lt/qZ4NgAw9hzyng/C1N6vJA=
Date:   Thu, 21 Sep 2023 15:13:05 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Xin Ji <xji@analogixsemi.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, qwen@analogixsemi.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hsinyi@chromium.org, bliang@analogixsemi.com
Subject: Re: [PATCH] drm/bridge: Add 200ms delay to wait FW HPD status stable
Message-ID: <20230921121305.GA19112@pendragon.ideasonboard.com>
References: <20230921091435.3524869-1-xji@analogixsemi.com>
 <87leczpw2h.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87leczpw2h.fsf@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The subject line is missing the driver name.

On Thu, Sep 21, 2023 at 03:09:10PM +0300, Jani Nikula wrote:
> On Thu, 21 Sep 2023, Xin Ji <xji@analogixsemi.com> wrote:
> > For the none-interrupt design(sink device is panel, polling HPD

s/none-interrupt/no-interrupt/ ?

s/design/design /

> > status when chip power on), anx7625 FW has more than 200ms HPD
> > de-bounce time in FW, for the safety to get HPD status, driver
> > better to wait 200ms before HPD detection after OS resume back.
> >
> > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > ---
> >  drivers/gpu/drm/bridge/analogix/anx7625.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > index 51abe42c639e..833d6d50a03d 100644
> > --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > @@ -1464,6 +1464,9 @@ static int _anx7625_hpd_polling(struct anx7625_data *ctx,
> >  	if (ctx->pdata.intp_irq)
> >  		return 0;
> >  
> > +	/* Delay 200ms for FW HPD de-bounce */
> > +	usleep_range(200000, 201000);
> 
> If you need to sleep for 200 ms, maybe use msleep instead?

fsleep() could be a nice replacement.

> > +
> >  	ret = readx_poll_timeout(anx7625_read_hpd_status_p0,
> >  				 ctx, val,
> >  				 ((val & HPD_STATUS) || (val < 0)),

-- 
Regards,

Laurent Pinchart
