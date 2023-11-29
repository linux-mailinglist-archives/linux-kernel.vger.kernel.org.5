Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65477FD278
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjK2J0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjK2J0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:26:46 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD391BD5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701250012; x=1732786012;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=poiK1yo9lPuaW4EnpGFoANhEWrq6YSdTlqrnepy9ZE4=;
  b=IV6kCOItPI7o9obj192WehxRJXNxiCiuqD8Tn4wn0n7IWpWlnJWv4j5m
   9nfGyPILGYrtggiXDus07SkX9kcKGM61G+cYfqKeoR8U7Cq6q8ltAbvtc
   e3ENALSVe0T/cvnv+rm+qWjStDOIWCOmdxmhMZMvbYqboTzIJY7IBPvzQ
   qsEyk/xBJXicDdN7AW1Y+uOx7LLFLJSLLsVg0xMO1+3XDhEaJn5/x61+W
   fSXMpWRWDR41f5DDG/ctWie8VtG4R0XYueYlUIb6GyNK4QZ0cZaDPQenw
   jAmZrIOrW4LEGznwm/2iDDLb1i8Q1ualHWVusQtRkI+v2IGXmYULgh6mc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="395950737"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="395950737"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 01:26:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="768845355"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="768845355"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 01:26:50 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 25FFC11FC11;
        Wed, 29 Nov 2023 11:26:47 +0200 (EET)
Date:   Wed, 29 Nov 2023 09:26:47 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Wentong Wu <wentong.wu@intel.com>
Cc:     gregkh@linuxfoundation.org, tomas.winkler@intel.com,
        hdegoede@redhat.com, andriy.shevchenko@linux.intel.com,
        alexander.usyskin@intel.com, zhifeng.wang@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mei: Add MEI hardware support for IVSC device
Message-ID: <ZWcD18B916Xs1JiU@kekkonen.localdomain>
References: <1701174846-16316-1-git-send-email-wentong.wu@intel.com>
 <1701174846-16316-3-git-send-email-wentong.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1701174846-16316-3-git-send-email-wentong.wu@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wentong,

On Tue, Nov 28, 2023 at 08:34:06PM +0800, Wentong Wu wrote:
> The protocol used for the IVSC device to communicate with HOST is MEI.
> The MEI hardware interfaces for the IVSC device are implemented.
> 
> The APIs are exposed by MEI framework to mei clients, e.g. mei_csi and
> mei_ace.
> 
> Signed-off-by: Wentong Wu <wentong.wu@intel.com>
> Reviewed-by: Alexander Usyskin <alexander.usyskin@intel.com>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/misc/mei/Kconfig        |  13 ++
>  drivers/misc/mei/Makefile       |   3 +
>  drivers/misc/mei/platform-vsc.c | 442 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 458 insertions(+)
>  create mode 100644 drivers/misc/mei/platform-vsc.c
> 
> diff --git a/drivers/misc/mei/Kconfig b/drivers/misc/mei/Kconfig
> index 470957a..2c5312b 100644
> --- a/drivers/misc/mei/Kconfig
> +++ b/drivers/misc/mei/Kconfig
> @@ -71,6 +71,19 @@ config INTEL_MEI_VSC_HW
>  	  This driver can also be built as a module. If so, the module
>  	  will be called mei-vsc-hw.
>  
> +config INTEL_MEI_VSC
> +	tristate "Intel visual sensing controller device with ME interface"
> +	select INTEL_MEI_VSC_HW

Changing the select here to depends on addresses the Kconfig option
dependency issue (as select just blindly selects the options while ignoring
their dependencies).

I wouldn't mind having a single Kconfig option for the two drivers either.
They're always used together, aren't they?

> +	depends on INTEL_MEI
> +	help
> +	  Intel MEI over SPI driver for Intel visual sensing controller
> +	  (IVSC) device embedded in IA platform. It supports camera sharing
> +	  between IVSC for context sensing and IPU for typical media usage.
> +	  Select this config will enable transport layer for IVSC device.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called mei-vsc.
> +
>  source "drivers/misc/mei/hdcp/Kconfig"
>  source "drivers/misc/mei/pxp/Kconfig"
>  source "drivers/misc/mei/gsc_proxy/Kconfig"

-- 
Regards,

Sakari Ailus
