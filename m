Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCFB81128F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379083AbjLMNMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbjLMNML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:12:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990F8B2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702473134; x=1734009134;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jIG6M/Yn7tdVnC/GYp6BlnOGTi9WCt9aIwpTh04ob7I=;
  b=V9+g7TtssLPwteF4JcSK17XzEhU0ME+S/kZagh7wOpUEBET3ZyKzOaSt
   2Nl/pou679SH3QPZcmX78uPaUQRf5ixJtDeyJAqbAktC8IgzAdR/CFhuX
   mHfk9TCksmb1J/s7gn4R2PEC8J+MxT/+LYhgtv/O8heYscQXMSIEW/ST0
   qdsCu8gLs50iJn4zKJHGPk42DbN/8TIAjkMWcrpVV6+3yWQn5PxEivTO9
   69YXZ9WQsY6tPLHW1NPo2tHCRkE80xPLg/V/icE6L6Lo5BLg/rHkXLuGq
   yG6M7v84ZVLRfmqlTYeqBlRRlpWIQL/t/5jpyHdne2hc4O3T2QNr52HGW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="16515076"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="16515076"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 05:12:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="947180830"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="947180830"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 05:12:11 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 3336211FC21;
        Wed, 13 Dec 2023 15:12:09 +0200 (EET)
Date:   Wed, 13 Dec 2023 13:12:09 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wentong Wu <wentong.wu@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mei: fix vsc dependency
Message-ID: <ZXmtqc7fTeZbRW5B@kekkonen.localdomain>
References: <20231213124310.761638-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213124310.761638-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Thanks for the patch.

On Wed, Dec 13, 2023 at 01:43:05PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The Kconfig dependency in the new module is reversed from the dependency
> on the exported symbols, so it fails to link with CONFIG_INTEL_MEI_VSC
> disabled and CONFIG_INTEL_MEI_VSC_HW enabled:
> 
> ERROR: modpost: "vsc_tp_reset" [drivers/misc/mei/mei-vsc.ko] undefined!
> ERROR: modpost: "vsc_tp_init" [drivers/misc/mei/mei-vsc.ko] undefined!
> ERROR: modpost: "vsc_tp_xfer" [drivers/misc/mei/mei-vsc.ko] undefined!
> ERROR: modpost: "vsc_tp_need_read" [drivers/misc/mei/mei-vsc.ko] undefined!
> ERROR: modpost: "vsc_tp_intr_enable" [drivers/misc/mei/mei-vsc.ko] undefined!
> ERROR: modpost: "vsc_tp_intr_synchronize" [drivers/misc/mei/mei-vsc.ko] undefined!
> ERROR: modpost: "vsc_tp_intr_disable" [drivers/misc/mei/mei-vsc.ko] undefined!
> ERROR: modpost: "vsc_tp_register_event_cb" [drivers/misc/mei/mei-vsc.ko] undefined!
> 
> Make the dependency reflect the module dependency.
> 
> Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/misc/mei/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/mei/Kconfig b/drivers/misc/mei/Kconfig
> index 858bd701d68c..eb69987f8325 100644
> --- a/drivers/misc/mei/Kconfig
> +++ b/drivers/misc/mei/Kconfig
> @@ -64,6 +64,7 @@ config INTEL_MEI_VSC_HW
>  	tristate "Intel visual sensing controller device transport driver"
>  	depends on ACPI && SPI
>  	depends on GPIOLIB || COMPILE_TEST
> +	depends on INTEL_MEI_VSC

Oops. The dependency indeed seems to have been reversed.

Could you also reorder the entries so the one that depends on the other
would be below?

>  	help
>  	  Intel SPI transport driver between host and Intel visual sensing
>  	  controller (IVSC) device.
> @@ -73,7 +74,6 @@ config INTEL_MEI_VSC_HW
>  
>  config INTEL_MEI_VSC
>  	tristate "Intel visual sensing controller device with ME interface"
> -	depends on INTEL_MEI_VSC_HW
>  	depends on INTEL_MEI
>  	help
>  	  Intel MEI over SPI driver for Intel visual sensing controller

-- 
Kind regards,

Sakari Ailus
