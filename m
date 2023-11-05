Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504DA7E1778
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 23:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjKEWyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 17:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjKEWyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 17:54:35 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CD5E1
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 14:54:32 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CC1785AA;
        Sun,  5 Nov 2023 23:54:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1699224852;
        bh=pcacsgb3OWxdK2khmiavqPxLlnW99wbidArlPanL5Q4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ufh7ZOGijsOwjyrtF/B1P4um8Wdp7NK3TFok4eiqodaZzQO/FKij2OFCUmYNMgiM7
         ClkfagKSsDhWIdblmbV0CIBM3cfr4+XFXE/aq2uDFd5VkisHHkcDpJ5vhlNo8rSetm
         Uk01uTd1vMlrYw0kM3/DxrFA0NH+qTIXBCL4rRT0=
Date:   Mon, 6 Nov 2023 00:54:38 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     Aradhya Bhatia <a-bhatia1@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/10] drm/tidss: Move reset to the end of dispc_init()
Message-ID: <20231105225438.GB15635@pendragon.ideasonboard.com>
References: <20231101-tidss-probe-v1-0-45149e0f9415@ideasonboard.com>
 <20231101-tidss-probe-v1-4-45149e0f9415@ideasonboard.com>
 <20231101135749.GT12764@pendragon.ideasonboard.com>
 <71056358-f91e-4a88-a979-33bfe157289a@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <71056358-f91e-4a88-a979-33bfe157289a@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 08:40:10AM +0200, Tomi Valkeinen wrote:
> On 01/11/2023 15:57, Laurent Pinchart wrote:
> > On Wed, Nov 01, 2023 at 11:17:41AM +0200, Tomi Valkeinen wrote:
> >> We do a DSS reset in the middle of the dispc_init(). While that happens
> >> to work now, we should really make sure that e..g the fclk, which is
> >> acquired only later in the function, is enabled when doing a reset. This
> >> will be handled in a later patch, but for now, let's move the
> >> dispc_softreset() call to the end of dispc_init(), which is a sensible
> >> place for it anyway.
> >>
> >> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> > 
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > 
> > But do I understand correctly that the device isn't powered up at this
> > point ? That seems problematic.
> 
> Indeed. It's fixed later in this series.
> 
> > I'm also not sure why we need to reset the device at probe time.
> 
> That's the usual place to do a reset, to make sure the HW is in a known 
> state, is it not? Where would you place it?

The first time the device is used, or possibly every time it is resumed
? It seems that you're resuming it at probe time for the only reason
that you want to then reset it. Resuming it at probe could get entirely
skipped.

-- 
Regards,

Laurent Pinchart
