Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7055D79D0D8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 14:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbjILMQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 08:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234845AbjILMQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:16:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B8110D5;
        Tue, 12 Sep 2023 05:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694520969; x=1726056969;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=273xH1Jhe5FYT96Y87AVqnja0Rc26UYu66UAyKYIGJA=;
  b=Q4nhibZSgj3u5hObnEpE9TNdUgVtkyAaYlXBk2Mt/2DYS6MofGiPJXko
   fM+TwwBHYn2MagNVVqWZUYi8G9tA9JGvUlXSKzOmc8ZbbJ2nq95BHKEJ2
   vWxCVGjEQDwpslTgzhPePnWSSV+naDDmljF5cUzRLGOK5NQZa2UI4DBDg
   Q0V+Bq5cTCoHRlXhV3IEsHgejqoZJ/pDTUrdZtQRsUrzMfraMsBBVP3LS
   YWlmhN5uJfJk04qdy1V+TLFVBqW6pn22z+iIYZzpaT/sGrcSP4iPeHL+j
   I4WQV7Rsv80v/jJf+ACp43SJmZervPw4nZ6KRUjOFzt9L25wQ1mOUN0TD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="464726767"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="464726767"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 05:16:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="693471982"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="693471982"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 05:16:06 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id B6D3111F831;
        Tue, 12 Sep 2023 15:16:03 +0300 (EEST)
Date:   Tue, 12 Sep 2023 12:16:03 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: fix VIDEO_CAMERA_SENSOR dependencies
Message-ID: <ZQBWg0Ck1NFIvk7j@kekkonen.localdomain>
References: <20230912120159.4118842-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912120159.4118842-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Tue, Sep 12, 2023 at 02:01:42PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The new Kconfig submenu now guards the visibility of camera sensor drivers,
> and any driver that selects one of them runs into a missing dependency warning
> if it's disabled:
> 
> WARNING: unmet direct dependencies detected for VIDEO_OV2640
>   Depends on [n]: MEDIA_SUPPORT [=y] && VIDEO_DEV [=y] && VIDEO_CAMERA_SENSOR [=n]
>   Selected by [y]:
>   - VIDEO_EM28XX_V4L2 [=y] && USB [=y] && MEDIA_SUPPORT [=y] && MEDIA_USB_SUPPORT [=y] && (MEDIA_CAMERA_SUPPORT [=y] || MEDIA_ANALOG_TV_SUPPORT [=y] || MEDIA_DIGITAL_TV_SUPPORT [=y]) && VIDEO_EM28XX [=y] && MEDIA_SUBDRV_AUTOSELECT [=y] && MEDIA_CAMERA_SUPPORT [=y]
>   - VIDEO_GO7007 [=y] && MEDIA_SUPPORT [=y] && MEDIA_USB_SUPPORT [=y] && MEDIA_ANALOG_TV_SUPPORT [=y] && VIDEO_DEV [=y] && I2C [=y] && SND [=y] && USB [=y] && MEDIA_SUBDRV_AUTOSELECT [=y] && MEDIA_CAMERA_SUPPORT [=y]
> 
> WARNING: unmet direct dependencies detected for VIDEO_MT9V011
>   Depends on [n]: MEDIA_SUPPORT [=y] && VIDEO_DEV [=y] && VIDEO_CAMERA_SENSOR [=n]
>   Selected by [y]:
>   - VIDEO_EM28XX_V4L2 [=y] && USB [=y] && MEDIA_SUPPORT [=y] && MEDIA_USB_SUPPORT [=y] && (MEDIA_CAMERA_SUPPORT [=y] || MEDIA_ANALOG_TV_SUPPORT [=y] || MEDIA_DIGITAL_TV_SUPPORT [=y]) && VIDEO_EM28XX [=y] && MEDIA_SUBDRV_AUTOSELECT [=y] && MEDIA_CAMERA_SUPPORT [=y]
> 
> WARNING: unmet direct dependencies detected for VIDEO_OV7670
>   Depends on [n]: MEDIA_SUPPORT [=y] && VIDEO_DEV [=y] && VIDEO_CAMERA_SENSOR [=n]
>   Selected by [y]:
>   - VIDEO_CAFE_CCIC [=y] && MEDIA_SUPPORT [=y] && MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] && V4L_PLATFORM_DRIVERS [=y] && PCI [=y] && I2C [=y] && VIDEO_DEV [=y] && COMMON_CLK [=y]
>   - VIDEO_MMP_CAMERA [=y] && MEDIA_SUPPORT [=y] && MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] && V4L_PLATFORM_DRIVERS [=y] && I2C [=y] && VIDEO_DEV [=y] && (ARCH_MMP [=y] || COMPILE_TEST [=y]) && COMMON_CLK [=y]
>   - VIDEO_VIA_CAMERA [=y] && MEDIA_SUPPORT [=y] && MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] && V4L_PLATFORM_DRIVERS [=y] && FB_VIA [=y] && VIDEO_DEV [=y]
> 
> Some of these are guarded by 'if MEDIA_SUBDRV_AUTOSELECT &&
> MEDIA_CAMERA_SUPPORT', which seems to be the right approach, so update
> those to use the new VIDEO_CAMERA_SENSOR symbol instead of
> MEDIA_CAMERA_SUPPORT and add the same condition to the ones that
> don't already have one.
> 
> Fixes: 7d3c7d2a2914e ("media: i2c: Add a camera sensor top level menu")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I believe these matters have been fixed, but the fixes are only in the
media stage tree so far (and not in the fixes branch). They should go to
v6.6, not v6.7.

-- 
Regards,

Sakari Ailus
