Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CC6765476
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 15:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbjG0NCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 09:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjG0NCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 09:02:09 -0400
Received: from mgamail.intel.com (unknown [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913A32113;
        Thu, 27 Jul 2023 06:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690462925; x=1721998925;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S/glewrFHjBxh3ILbSfedw2LTveTs0AGJS6Fxx9/3AU=;
  b=l2YrvuYo9rjq6F34nDpDF+6U6KWInBA+RypGQThUVyMCGu2WdaBoO66W
   Qf2bH1iVYghKg4J6tFz6+iaYx85pWg99/QRsXHlHbsxz9jKMwjCMs8GVD
   weYuyqRRXwaV67qRC3Lwt31TgQ3ZFIcGSMkBimhYZQaWJCAZ60ZwwsSmF
   eHoDxkA9U/Y3SjTbEPS8oYMmuuQvhNOEA9+AEwoYwZarFxhO47F5SILj0
   eE4uZAHPRgbB7nbZAZF1SUzc5xfoKnk4MSA+VI6qFRfCk6M3UOoeUUbI+
   OsCdWDQIMzWlQlMpNEG68UVPfbYY6SCnoJ24JjzYgfIdo4oIRfC7jiz2E
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="368316937"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="368316937"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 06:02:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="720879606"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="720879606"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 27 Jul 2023 06:02:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qP0cw-004wQ7-2w;
        Thu, 27 Jul 2023 16:01:58 +0300
Date:   Thu, 27 Jul 2023 16:01:58 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Scally <djrscally@gmail.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: ipu3-cio2: allow ipu_bridge to be a module again
Message-ID: <ZMJqxnSSkcbKL1lo@smile.fi.intel.com>
References: <20230727122331.2421453-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727122331.2421453-1-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 02:22:58PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This code was previously part of the VIDEO_IPU3_CIO2 driver, which could
> be built-in or a loadable module, but after the move it turned into a
> builtin-only driver. This fails to link when the I2C subsystem is a
> module:

Which probably never happen in (real, like distro kernel) x86 builds due to
other x86 platforms that require I2C to be built-in.  Nevertheless, I agree
with your patch.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> x86_64-linux-ld: drivers/media/pci/intel/ipu-bridge.o: in function `ipu_bridge_unregister_sensors':
> ipu-bridge.c:(.text+0x50): undefined reference to `i2c_unregister_device'
> x86_64-linux-ld: drivers/media/pci/intel/ipu-bridge.o: in function `ipu_bridge_init':
> ipu-bridge.c:(.text+0x9c9): undefined reference to `i2c_acpi_new_device_by_fwnode'
> 
> In general, drivers should not have to be built-in, so change the option
> to a tristate with the corresponding dependency. This in turn opens a
> new problem with the dependency, as the IPU bridge can be a loadable module
> while the ipu3 driver itself is built-in, producing a new link failure:
> 
> 86_64-linux-ld: drivers/media/pci/intel/ipu3/ipu3-cio2.o: in function `cio2_pci_probe':
> ipu3-cio2.c:(.text+0x197e): undefined reference to `ipu_bridge_init'
> 
> In order to fix this, restore the old Kconfig option that controlled
> the ipu bridge driver before it was split out, but make it select a
> hidden symbol that now corresponds to the bridge driver.
> 
> When other drivers get added that share ipu-bridge, this should cover
> all corner cases, and allow any combination of them to be built-in
> or modular.
> 
> Fixes: 881ca25978c6f ("media: ipu3-cio2: rename cio2 bridge to ipu bridge and move out of ipu3")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/media/pci/intel/Kconfig      | 21 +++++----------------
>  drivers/media/pci/intel/ipu-bridge.c |  3 +++
>  drivers/media/pci/intel/ipu3/Kconfig | 20 ++++++++++++++++++++
>  3 files changed, 28 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/media/pci/intel/Kconfig b/drivers/media/pci/intel/Kconfig
> index 64a29b0b7033b..51b18fce6a1de 100644
> --- a/drivers/media/pci/intel/Kconfig
> +++ b/drivers/media/pci/intel/Kconfig
> @@ -1,21 +1,10 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config IPU_BRIDGE
> -	bool "Intel IPU Sensors Bridge"
> -	depends on VIDEO_IPU3_CIO2 && ACPI
> -	depends on I2C
> +	tristate
> +	depends on I2C && ACPI
>  	help
> -	  This extension provides an API for the Intel IPU driver to create
> -	  connections to cameras that are hidden in the SSDB buffer in ACPI.
> -	  It can be used to enable support for cameras in detachable / hybrid
> -	  devices that ship with Windows.
> -
> -	  Say Y here if your device is a detachable / hybrid laptop that comes
> -	  with Windows installed by the OEM, for example:
> -
> -		- Microsoft Surface models (except Surface Pro 3)
> -		- The Lenovo Miix line (for example the 510, 520, 710 and 720)
> -		- Dell 7285
> -
> -	  If in doubt, say N here.
> +	  This is a helper module for the IPU bridge, which can be
> +	  used by ipu3 and other drivers. In order to handle module
> +	  dependencies, this is selected by each driver that needs it.
>  
>  source "drivers/media/pci/intel/ipu3/Kconfig"
> diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
> index 62daa8c1f6b18..bd67c3e990ea8 100644
> --- a/drivers/media/pci/intel/ipu-bridge.c
> +++ b/drivers/media/pci/intel/ipu-bridge.c
> @@ -493,3 +493,6 @@ int ipu_bridge_init(struct pci_dev *ipu)
>  	return ret;
>  }
>  EXPORT_SYMBOL_NS_GPL(ipu_bridge_init, INTEL_IPU_BRIDGE);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Intel IPU Sensors Bridge driver");
> diff --git a/drivers/media/pci/intel/ipu3/Kconfig b/drivers/media/pci/intel/ipu3/Kconfig
> index 9be06ee81ff05..0951545eab21a 100644
> --- a/drivers/media/pci/intel/ipu3/Kconfig
> +++ b/drivers/media/pci/intel/ipu3/Kconfig
> @@ -8,6 +8,7 @@ config VIDEO_IPU3_CIO2
>  	select VIDEO_V4L2_SUBDEV_API
>  	select V4L2_FWNODE
>  	select VIDEOBUF2_DMA_SG
> +	select IPU_BRIDGE if CIO2_BRIDGE
>  
>  	help
>  	  This is the Intel IPU3 CIO2 CSI-2 receiver unit, found in Intel
> @@ -17,3 +18,22 @@ config VIDEO_IPU3_CIO2
>  	  Say Y or M here if you have a Skylake/Kaby Lake SoC with MIPI CSI-2
>  	  connected camera.
>  	  The module will be called ipu3-cio2.
> +
> +config CIO2_BRIDGE
> +	bool "IPU3 CIO2 Sensors Bridge"
> +	depends on VIDEO_IPU3_CIO2 && ACPI
> +	depends on I2C
> +	help
> +	  This extension provides an API for the ipu3-cio2 driver to create
> +	  connections to cameras that are hidden in the SSDB buffer in ACPI.
> +	  It can be used to enable support for cameras in detachable / hybrid
> +	  devices that ship with Windows.
> +
> +	  Say Y here if your device is a detachable / hybrid laptop that comes
> +	  with Windows installed by the OEM, for example:
> +
> +		- Microsoft Surface models (except Surface Pro 3)
> +		- The Lenovo Miix line (for example the 510, 520, 710 and 720)
> +		- Dell 7285
> +
> +	  If in doubt, say N here.
> -- 
> 2.39.2
> 

-- 
With Best Regards,
Andy Shevchenko


