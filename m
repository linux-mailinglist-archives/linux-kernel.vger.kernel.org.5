Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D35179E695
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239961AbjIMLXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236689AbjIMLXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:23:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8874F1BF1;
        Wed, 13 Sep 2023 04:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694604219; x=1726140219;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qB+psZAiJV5s+cle8h9zCVh4A1p3LGypwTsSrk1Fzb8=;
  b=X6Ks3DG5oFDWLIjq2RbKw2KzzTVwCIehKkneO/T/Rs9470sLNe0RNy+5
   Cg8p3SSdPW8jK/4O6Pcnf54qnfk5AcgD6bH1O/vE8Exn17q62zKqT/Lfq
   hZmzDEHIWeRBzR8XAv4+pK//UB2/fVlpgTUpCelIC10uOuV7hKE1tQq3u
   rTMG+JknSeaGKB/MXFfy27zRlM0v30IswsRKFDDWUotrUdRAeosBWTAgq
   YLcg6szyHjxsko+CwNjIULXreDni+A0bVyj6HeRsAv9DzgyN0Gyt0jfNS
   coaLGRZNPGbZAgUOSo7dM5SWU+XTrro7GugR+9IIZmPSuS0IFev3c2Pna
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="409582040"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="409582040"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:23:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="773427816"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="773427816"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:23:20 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 8098911F831;
        Wed, 13 Sep 2023 14:23:11 +0300 (EEST)
Date:   Wed, 13 Sep 2023 11:23:11 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Hans de Goede <hdegoede@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: fix VIDEO_CAMERA_SENSOR dependencies
Message-ID: <ZQGbn76+vd9mFmUa@kekkonen.localdomain>
References: <20230912120159.4118842-1-arnd@kernel.org>
 <ZQBWg0Ck1NFIvk7j@kekkonen.localdomain>
 <20230912155956.GC30767@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912155956.GC30767@pendragon.ideasonboard.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Tue, Sep 12, 2023 at 06:59:56PM +0300, Laurent Pinchart wrote:
> On Tue, Sep 12, 2023 at 12:16:03PM +0000, Sakari Ailus wrote:
> > Hi Arnd,
> > 
> > On Tue, Sep 12, 2023 at 02:01:42PM +0200, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > > 
> > > The new Kconfig submenu now guards the visibility of camera sensor drivers,
> > > and any driver that selects one of them runs into a missing dependency warning
> > > if it's disabled:
> > > 
> > > WARNING: unmet direct dependencies detected for VIDEO_OV2640
> > >   Depends on [n]: MEDIA_SUPPORT [=y] && VIDEO_DEV [=y] && VIDEO_CAMERA_SENSOR [=n]
> > >   Selected by [y]:
> > >   - VIDEO_EM28XX_V4L2 [=y] && USB [=y] && MEDIA_SUPPORT [=y] && MEDIA_USB_SUPPORT [=y] && (MEDIA_CAMERA_SUPPORT [=y] || MEDIA_ANALOG_TV_SUPPORT [=y] || MEDIA_DIGITAL_TV_SUPPORT [=y]) && VIDEO_EM28XX [=y] && MEDIA_SUBDRV_AUTOSELECT [=y] && MEDIA_CAMERA_SUPPORT [=y]
> > >   - VIDEO_GO7007 [=y] && MEDIA_SUPPORT [=y] && MEDIA_USB_SUPPORT [=y] && MEDIA_ANALOG_TV_SUPPORT [=y] && VIDEO_DEV [=y] && I2C [=y] && SND [=y] && USB [=y] && MEDIA_SUBDRV_AUTOSELECT [=y] && MEDIA_CAMERA_SUPPORT [=y]
> > > 
> > > WARNING: unmet direct dependencies detected for VIDEO_MT9V011
> > >   Depends on [n]: MEDIA_SUPPORT [=y] && VIDEO_DEV [=y] && VIDEO_CAMERA_SENSOR [=n]
> > >   Selected by [y]:
> > >   - VIDEO_EM28XX_V4L2 [=y] && USB [=y] && MEDIA_SUPPORT [=y] && MEDIA_USB_SUPPORT [=y] && (MEDIA_CAMERA_SUPPORT [=y] || MEDIA_ANALOG_TV_SUPPORT [=y] || MEDIA_DIGITAL_TV_SUPPORT [=y]) && VIDEO_EM28XX [=y] && MEDIA_SUBDRV_AUTOSELECT [=y] && MEDIA_CAMERA_SUPPORT [=y]
> > > 
> > > WARNING: unmet direct dependencies detected for VIDEO_OV7670
> > >   Depends on [n]: MEDIA_SUPPORT [=y] && VIDEO_DEV [=y] && VIDEO_CAMERA_SENSOR [=n]
> > >   Selected by [y]:
> > >   - VIDEO_CAFE_CCIC [=y] && MEDIA_SUPPORT [=y] && MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] && V4L_PLATFORM_DRIVERS [=y] && PCI [=y] && I2C [=y] && VIDEO_DEV [=y] && COMMON_CLK [=y]
> > >   - VIDEO_MMP_CAMERA [=y] && MEDIA_SUPPORT [=y] && MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] && V4L_PLATFORM_DRIVERS [=y] && I2C [=y] && VIDEO_DEV [=y] && (ARCH_MMP [=y] || COMPILE_TEST [=y]) && COMMON_CLK [=y]
> > >   - VIDEO_VIA_CAMERA [=y] && MEDIA_SUPPORT [=y] && MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] && V4L_PLATFORM_DRIVERS [=y] && FB_VIA [=y] && VIDEO_DEV [=y]
> > > 
> > > Some of these are guarded by 'if MEDIA_SUBDRV_AUTOSELECT &&
> > > MEDIA_CAMERA_SUPPORT', which seems to be the right approach, so update
> > > those to use the new VIDEO_CAMERA_SENSOR symbol instead of
> > > MEDIA_CAMERA_SUPPORT and add the same condition to the ones that
> > > don't already have one.
> > > 
> > > Fixes: 7d3c7d2a2914e ("media: i2c: Add a camera sensor top level menu")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > I believe these matters have been fixed, but the fixes are only in the
> > media stage tree so far (and not in the fixes branch). They should go to
> > v6.6, not v6.7.
> 
> That would be commits f59933e8b1d1 ("media: via: Use correct dependency
> for camera sensor drivers") and 8ba283f6c929 ("media: v4l: Use correct
> dependency for camera sensor drivers"). The latter is identical to the
> corresponding changes in this patch, but the former lacks the
> MEDIA_SUBDRV_AUTOSELECT check. Is this intentional ?

This is a bit grey area.

The via parallel receiver driver has been apparently used with a single
camera, the ov7670. It's a very old driver so I don't necessarily expect
this to change.

Changing this either way would have fixed the core issue.

Ideally there should be no connection between the via parallel receiver
driver and any sensor driver.

-- 
Regards,

Sakari Ailus
