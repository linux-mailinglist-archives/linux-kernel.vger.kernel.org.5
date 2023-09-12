Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E284379D577
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236516AbjILP7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233980AbjILP7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:59:48 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6050E10DE;
        Tue, 12 Sep 2023 08:59:44 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7640C512;
        Tue, 12 Sep 2023 17:58:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1694534290;
        bh=xfhmlz5ckdLY0YdTm7FkPxuK4u/istlO5fGdwX4PDec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cFGN96ZpPXODQ1neJ4wrzI5s+h4ebba0YsgFpvlsgdmX1lc6MmDs0OtHtU78+ixek
         g9Xqbz8+vnK1hg3zqO3VYPQFFFoRgjdooTecIl539xF5F4RMepYkF5iAd6LjRZI0SQ
         B464Yn4rE0Bz7l32yroHPXWeK9kSXQKxSHQXtr7o=
Date:   Tue, 12 Sep 2023 18:59:56 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Hans de Goede <hdegoede@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: fix VIDEO_CAMERA_SENSOR dependencies
Message-ID: <20230912155956.GC30767@pendragon.ideasonboard.com>
References: <20230912120159.4118842-1-arnd@kernel.org>
 <ZQBWg0Ck1NFIvk7j@kekkonen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZQBWg0Ck1NFIvk7j@kekkonen.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 12:16:03PM +0000, Sakari Ailus wrote:
> Hi Arnd,
> 
> On Tue, Sep 12, 2023 at 02:01:42PM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > The new Kconfig submenu now guards the visibility of camera sensor drivers,
> > and any driver that selects one of them runs into a missing dependency warning
> > if it's disabled:
> > 
> > WARNING: unmet direct dependencies detected for VIDEO_OV2640
> >   Depends on [n]: MEDIA_SUPPORT [=y] && VIDEO_DEV [=y] && VIDEO_CAMERA_SENSOR [=n]
> >   Selected by [y]:
> >   - VIDEO_EM28XX_V4L2 [=y] && USB [=y] && MEDIA_SUPPORT [=y] && MEDIA_USB_SUPPORT [=y] && (MEDIA_CAMERA_SUPPORT [=y] || MEDIA_ANALOG_TV_SUPPORT [=y] || MEDIA_DIGITAL_TV_SUPPORT [=y]) && VIDEO_EM28XX [=y] && MEDIA_SUBDRV_AUTOSELECT [=y] && MEDIA_CAMERA_SUPPORT [=y]
> >   - VIDEO_GO7007 [=y] && MEDIA_SUPPORT [=y] && MEDIA_USB_SUPPORT [=y] && MEDIA_ANALOG_TV_SUPPORT [=y] && VIDEO_DEV [=y] && I2C [=y] && SND [=y] && USB [=y] && MEDIA_SUBDRV_AUTOSELECT [=y] && MEDIA_CAMERA_SUPPORT [=y]
> > 
> > WARNING: unmet direct dependencies detected for VIDEO_MT9V011
> >   Depends on [n]: MEDIA_SUPPORT [=y] && VIDEO_DEV [=y] && VIDEO_CAMERA_SENSOR [=n]
> >   Selected by [y]:
> >   - VIDEO_EM28XX_V4L2 [=y] && USB [=y] && MEDIA_SUPPORT [=y] && MEDIA_USB_SUPPORT [=y] && (MEDIA_CAMERA_SUPPORT [=y] || MEDIA_ANALOG_TV_SUPPORT [=y] || MEDIA_DIGITAL_TV_SUPPORT [=y]) && VIDEO_EM28XX [=y] && MEDIA_SUBDRV_AUTOSELECT [=y] && MEDIA_CAMERA_SUPPORT [=y]
> > 
> > WARNING: unmet direct dependencies detected for VIDEO_OV7670
> >   Depends on [n]: MEDIA_SUPPORT [=y] && VIDEO_DEV [=y] && VIDEO_CAMERA_SENSOR [=n]
> >   Selected by [y]:
> >   - VIDEO_CAFE_CCIC [=y] && MEDIA_SUPPORT [=y] && MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] && V4L_PLATFORM_DRIVERS [=y] && PCI [=y] && I2C [=y] && VIDEO_DEV [=y] && COMMON_CLK [=y]
> >   - VIDEO_MMP_CAMERA [=y] && MEDIA_SUPPORT [=y] && MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] && V4L_PLATFORM_DRIVERS [=y] && I2C [=y] && VIDEO_DEV [=y] && (ARCH_MMP [=y] || COMPILE_TEST [=y]) && COMMON_CLK [=y]
> >   - VIDEO_VIA_CAMERA [=y] && MEDIA_SUPPORT [=y] && MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] && V4L_PLATFORM_DRIVERS [=y] && FB_VIA [=y] && VIDEO_DEV [=y]
> > 
> > Some of these are guarded by 'if MEDIA_SUBDRV_AUTOSELECT &&
> > MEDIA_CAMERA_SUPPORT', which seems to be the right approach, so update
> > those to use the new VIDEO_CAMERA_SENSOR symbol instead of
> > MEDIA_CAMERA_SUPPORT and add the same condition to the ones that
> > don't already have one.
> > 
> > Fixes: 7d3c7d2a2914e ("media: i2c: Add a camera sensor top level menu")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> I believe these matters have been fixed, but the fixes are only in the
> media stage tree so far (and not in the fixes branch). They should go to
> v6.6, not v6.7.

That would be commits f59933e8b1d1 ("media: via: Use correct dependency
for camera sensor drivers") and 8ba283f6c929 ("media: v4l: Use correct
dependency for camera sensor drivers"). The latter is identical to the
corresponding changes in this patch, but the former lacks the
MEDIA_SUBDRV_AUTOSELECT check. Is this intentional ?


-- 
Regards,

Laurent Pinchart
