Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67A27808E6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359345AbjHRJro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359363AbjHRJrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:47:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924692D73;
        Fri, 18 Aug 2023 02:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692352039; x=1723888039;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1sGQdov9Rubt3LSKswOeSvLzIi1+88fPMKlhLghEJAM=;
  b=TEPGFRA18BHwUMCVTKze3d3ccllk4f+w9PVyGgPeSgHiXfaq2hnV2lFH
   SoP26rD7jIMegf5vsllxe+SBWFd0WHoi6P4Pwqzi7hLnGx+to5fwI7LaR
   hAvFA174+26C9nFalAOcB7TaDrIIygyTCdl9EFeiBCeZz66G1sEOpIYh+
   7RRR01BY422iNz00ZiA8cDIKPlnRbs7cIiH+xXix/ZKSiQqb4QKuJtDSH
   yiKVYy2xu79ZZVkiOz6gZKz7DIOlRr4AGCW3OnuIncqjpET9iqkXEqcIs
   Pp/Tj7cHdV5lhbsjohH45mpE7dem+n92rFVM5TvlqXZN6bcUSzCibbuww
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="439443012"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="439443012"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 02:47:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="800419534"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="800419534"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 02:47:16 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id DF87E12035D;
        Fri, 18 Aug 2023 12:47:13 +0300 (EEST)
Date:   Fri, 18 Aug 2023 09:47:13 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-media@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-next@vger.kernel.org, Wentong Wu <wentong.wu@intel.com>,
        Zhifeng Wang <zhifeng.wang@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH 1/2] media: v4l: usb: Use correct dependency for camera
 sensor drivers
Message-ID: <ZN8+IQheaChc3Ks+@kekkonen.localdomain>
References: <20230816133526.3859456-1-sakari.ailus@linux.intel.com>
 <20230816133526.3859456-2-sakari.ailus@linux.intel.com>
 <363d77a7-ee1a-f4c4-941a-7737568a8042@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <363d77a7-ee1a-f4c4-941a-7737568a8042@infradead.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Wed, Aug 16, 2023 at 12:21:31PM -0700, Randy Dunlap wrote:
> Hi Sakari,
> 
> On 8/16/23 06:35, Sakari Ailus wrote:
> > The Kconfig option that enables compiling camera sensor drivers is
> > VIDEO_CAMERA_SENSOR rather than MEDIA_CAMERA_SUPPORT as it was previously.
> > Fix this.
> > 
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Fixes: 7d3c7d2a2914 ("media: i2c: Add a camera sensor top level menu")
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> >  drivers/media/usb/em28xx/Kconfig | 4 ++--
> >  drivers/media/usb/go7007/Kconfig | 2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> 
> This patch reduces the number of kconfig warnings from 4 to 2. I still see these
> (and these appear to be duplicates, so only one):
> 
> WARNING: unmet direct dependencies detected for VIDEO_OV7670
>   Depends on [n]: MEDIA_SUPPORT [=y] && VIDEO_DEV [=y] && VIDEO_CAMERA_SENSOR [=n]
>   Selected by [y]:
>   - VIDEO_MMP_CAMERA [=y] && MEDIA_SUPPORT [=y] && MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] && V4L_PLATFORM_DRIVERS [=y] && I2C [=y] && VIDEO_DEV [=y] && (ARCH_MMP || COMPILE_TEST [=y]) && COMMON_CLK [=y]
> 
> WARNING: unmet direct dependencies detected for VIDEO_OV7670
>   Depends on [n]: MEDIA_SUPPORT [=y] && VIDEO_DEV [=y] && VIDEO_CAMERA_SENSOR [=n]
>   Selected by [y]:
>   - VIDEO_MMP_CAMERA [=y] && MEDIA_SUPPORT [=y] && MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] && V4L_PLATFORM_DRIVERS [=y] && I2C [=y] && VIDEO_DEV [=y] && (ARCH_MMP || COMPILE_TEST [=y]) && COMMON_CLK [=y]

Oops. I missed this bit.

Hans has taken the ivsc Kconfig patch already so I'll send v2 for this one
only.

-- 
Regards,

Sakari Ailus
