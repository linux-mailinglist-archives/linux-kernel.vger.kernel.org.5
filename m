Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067B779E84F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240184AbjIMMun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 08:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjIMMum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:50:42 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 817CD19B1;
        Wed, 13 Sep 2023 05:50:38 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id EC6FE8088;
        Wed, 13 Sep 2023 12:50:37 +0000 (UTC)
Date:   Wed, 13 Sep 2023 15:50:36 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sebastian Reichel <sre@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>
Subject: Re: [PATCH] drm/omap: dsi: Fix deferred probe warnings
Message-ID: <20230913125036.GM5285@atomide.com>
References: <20230412073954.20601-1-tony@atomide.com>
 <9daacd2f-0dbf-dddc-9403-b802447896a2@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9daacd2f-0dbf-dddc-9403-b802447896a2@ideasonboard.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> [230913 11:59]:
> On 12/04/2023 10:39, Tony Lindgren wrote:
> > We may not have dsi->dsidev initialized during probe, and that can
> > lead into various dsi related warnings as omap_dsi_host_detach() gets
> > called with dsi->dsidev set to NULL.
> > 
> > The warnings can be "Fixed dependency cycle(s)" followed by a
> > WARNING: CPU: 0 PID: 787 at drivers/gpu/drm/omapdrm/dss/dsi.c:4414.
> > 
> > Let's fix the warnings by checking for a valid dsi->dsidev.
> > 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >   drivers/gpu/drm/omapdrm/dss/dsi.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
> > --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
> > +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
> > @@ -4411,7 +4411,7 @@ static int omap_dsi_host_detach(struct mipi_dsi_host *host,
> >   {
> >   	struct dsi_data *dsi = host_to_omap(host);
> > -	if (WARN_ON(dsi->dsidev != client))
> > +	if (dsi->dsidev && WARN_ON(dsi->dsidev != client))
> >   		return -EINVAL;
> >   	cancel_delayed_work_sync(&dsi->dsi_disable_work);
> 
> Shouldn't this rather be
> 
> if (!dsi->dsidev)
> 	return 0;
> 
> before the if (WARN_ON(dsi->dsidev != client)) line?
> 
> If dsi->dsidev is NULL, then attach hasn't been called, and we shouldn't do
> anything in the detach callback either.
> 
> With your change we'll end up doing all the work in the detach callback,
> without ever doing their counterpart in the attach side.

Oops, I'll check that thanks.

Tony
