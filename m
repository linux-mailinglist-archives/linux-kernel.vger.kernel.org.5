Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04830782798
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjHULKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjHULKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:10:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88853D9;
        Mon, 21 Aug 2023 04:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692616229; x=1724152229;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wVfvRIGz8KWE/C39DpVlb2rJxBz2u4AmajqbhP0mkSY=;
  b=N0dVNFcWqrr5yK4WLjShw1kwGdyoqd1jNrkJKHqujGpSOi2gjRiQWWUB
   W/+hdx0SALs2asEstCRpMM6ptt+OUKd/+FUR5hipp0/9FVyWPTnCU631m
   g9s4j3k9EDJVTpwgYmVjirEyd54A9at6cAkDXb/4PYsE6WRVSD1R6YGkB
   jr48BFB73uPSWh5fWieDxt2h+juJHglzOjYAwnTiC7vGVWepXfVawJeiE
   mQwrtfRv5FxH6H2ikIgcrEBdcC3kwMbZ+DEGnNTfbylhl5sigzgspBEdE
   qyW+6DnlB159QnnN6nFGAwKaJ9WmpBcyktVAYc55CM/On496xc5bPpxBt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="404563743"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="404563743"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 04:10:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="712746566"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="712746566"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 04:09:58 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id D1EBE11F915;
        Mon, 21 Aug 2023 14:09:55 +0300 (EEST)
Date:   Mon, 21 Aug 2023 11:09:55 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-media@vger.kernel.org, hverkuil@xs4all.nl,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-next@vger.kernel.org, Wentong Wu <wentong.wu@intel.com>,
        Zhifeng Wang <zhifeng.wang@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v2 1/1] media: v4l: usb: Use correct dependency for
 camera sensor drivers
Message-ID: <ZONGA3HhECT/OnUr@kekkonen.localdomain>
References: <20230818095149.3863285-1-sakari.ailus@linux.intel.com>
 <f5bf21f5-3ca2-ade1-16dc-44588d2663ed@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5bf21f5-3ca2-ade1-16dc-44588d2663ed@infradead.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Fri, Aug 18, 2023 at 06:53:19PM -0700, Randy Dunlap wrote:
> Hi Sakari,
> 
> On 8/18/23 02:51, Sakari Ailus wrote:
> > The Kconfig option that enables compiling camera sensor drivers is
> > VIDEO_CAMERA_SENSOR rather than MEDIA_CAMERA_SUPPORT as it was previously.
> > Fix this.
> > 
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Fixes: 7d3c7d2a2914 ("media: i2c: Add a camera sensor top level menu")
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> > since v1:
> > 
> > - Also include MMP camera Kconfig fix.
> > 
> >  drivers/media/platform/marvell/Kconfig | 4 ++--
> >  drivers/media/usb/em28xx/Kconfig       | 4 ++--
> >  drivers/media/usb/go7007/Kconfig       | 2 +-
> >  3 files changed, 5 insertions(+), 5 deletions(-)
> > 
> 
> This v2 patch fixes a few more issues but there is still one nagging problem
> (2 versions of it, one with VIDEO_VIA_CAMERA=y and one with VIDEO_VIA_CAMERA=m):
> 
> (1)
> WARNING: unmet direct dependencies detected for VIDEO_OV7670
>   Depends on [n]: MEDIA_SUPPORT [=y] && VIDEO_DEV [=y] && VIDEO_CAMERA_SENSOR [=n]
>   Selected by [y]:
>   - VIDEO_VIA_CAMERA [=y] && MEDIA_SUPPORT [=y] && MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] && V4L_PLATFORM_DRIVERS [=y] && FB_VIA [=y] && VIDEO_DEV [=y]
> 
> WARNING: unmet direct dependencies detected for VIDEO_OV7670
>   Depends on [n]: MEDIA_SUPPORT [=y] && VIDEO_DEV [=y] && VIDEO_CAMERA_SENSOR [=n]
>   Selected by [y]:
>   - VIDEO_VIA_CAMERA [=y] && MEDIA_SUPPORT [=y] && MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] && V4L_PLATFORM_DRIVERS [=y] && FB_VIA [=y] && VIDEO_DEV [=y]
> 
> (2)
> WARNING: unmet direct dependencies detected for VIDEO_OV7670
>   Depends on [n]: MEDIA_SUPPORT [=y] && VIDEO_DEV [=m] && VIDEO_CAMERA_SENSOR [=n]
>   Selected by [m]:
>   - VIDEO_VIA_CAMERA [=m] && MEDIA_SUPPORT [=y] && MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] && V4L_PLATFORM_DRIVERS [=y] && FB_VIA [=m] && VIDEO_DEV [=m]
> 
> WARNING: unmet direct dependencies detected for VIDEO_OV7670
>   Depends on [n]: MEDIA_SUPPORT [=y] && VIDEO_DEV [=m] && VIDEO_CAMERA_SENSOR [=n]
>   Selected by [m]:
>   - VIDEO_VIA_CAMERA [=m] && MEDIA_SUPPORT [=y] && MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] && V4L_PLATFORM_DRIVERS [=y] && FB_VIA [=m] && VIDEO_DEV [=m]
> 
> Let me know if you need full randconfig files for any of these.
> Thanks.

Thanks. These were indeed missing from the previous patch. I'll post a fix
to address these as well. I've grepped the Kconfigs and I couldn't find
more --- this one didn't have MEDIA_CAMERA_SUPPORT dependency as most of
the others did.

-- 
Sakari Ailus
