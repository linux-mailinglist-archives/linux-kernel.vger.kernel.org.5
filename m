Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151DF7D99A8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345833AbjJ0NXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjJ0NW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:22:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EF018A;
        Fri, 27 Oct 2023 06:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698412974; x=1729948974;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=q8RbtznGdq3XlcFBNcvALLjajiJQ2HwAxFk8qehsygo=;
  b=IfRV4Fs/Sy0Y5al1t5SFe2sfQUeefQg7pLhAW5xk6tfPRemC1c3YpLee
   VJ4tCMZa7mABt9zyQZ5HEe4OMMOFEdSeYSGbhTdYhIGGMMyGHbmDZKTFe
   Vpno6b0Z/fTduLlav5QKpfutQSbs7505F5oJ6d9RjOhi2Xy8vsGfeM+yy
   sgC0+zWvCUybIKlD9T2gDvFE6uFQhjKw0TKj1p6a2cHwQ8fNGIriYMJW9
   chx4SmfZWBMP9zAD+JJSkoa6DkEwqiQuaWcue6WjSgKZV1OPgMvT3YS17
   A70uZc91z03l4pSLT/lOPh8ODVGQunY/LrP0mxp39CHMvrmA0v+jrxzab
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="418883580"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="418883580"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 06:22:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="7228162"
Received: from scoltan-mobl.ger.corp.intel.com ([10.252.33.159])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 06:21:22 -0700
Date:   Fri, 27 Oct 2023 16:22:42 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Ai Chao <aichao@kylinos.cn>
cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v5] platform/x86: inspur-platform-profile: Add platform
 profile support
In-Reply-To: <20231020024007.1677962-1-aichao@kylinos.cn>
Message-ID: <a6dc9391-26c9-cb25-44ed-3aab4d528f0@linux.intel.com>
References: <20231020024007.1677962-1-aichao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2023, Ai Chao wrote:

> Add support for Inspur platforms to used the platform profile feature.
> 
> This will allow users to determine and control the platform modes
> between low-power, balanced and performance modes.
> 
> Signed-off-by: Ai Chao <aichao@kylinos.cn>
> ---
> 
> v5: Rename inspur-wmi to inspur_platform_profile
> v4: Add select ACPI_PLATFORM_PROFILE
> v3: Remove input device, using the platform profile interface
> v2: Remove Event GUID, remove inspur_wmi_notify and inspur_wmi_notify.
> 
>  drivers/platform/x86/Kconfig                  |  11 +
>  drivers/platform/x86/Makefile                 |   3 +
>  .../platform/x86/inspur_platform_profile.c    | 216 ++++++++++++++++++
>  3 files changed, 230 insertions(+)
>  create mode 100644 drivers/platform/x86/inspur_platform_profile.c
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 2a1070543391..7e69fdaccdd5 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -988,6 +988,17 @@ config TOUCHSCREEN_DMI
>  	  the OS-image for the device. This option supplies the missing info.
>  	  Enable this for x86 tablets with Silead or Chipone touchscreens.
>  
> +config INSPUR_PLATFORM_PROFILE
> +	tristate "Inspur WMI platform profile driver"
> +	depends on ACPI_WMI
> +	select ACPI_PLATFORM_PROFILE
> +	help
> +	This will allow users to determine and control the platform modes
> +	between low-power, balanced and performance modes.
> +
> +	To compile this driver as a module, choose M here: the module
> +	will be called inspur-platform-profile.
> +
>  source "drivers/platform/x86/x86-android-tablets/Kconfig"
>  
>  config FW_ATTR_CLASS
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index b457de5abf7d..c7a18e95ad8c 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -98,6 +98,9 @@ obj-$(CONFIG_TOSHIBA_WMI)	+= toshiba-wmi.o
>  # before toshiba_acpi initializes
>  obj-$(CONFIG_ACPI_TOSHIBA)	+= toshiba_acpi.o
>  
> +# Inspur
> +obj-$(CONFIG_INSPUR_PLATFORM_PROFILE)	+= inspur_platform_profile.o
> +
>  # Laptop drivers
>  obj-$(CONFIG_ACPI_CMPC)		+= classmate-laptop.o
>  obj-$(CONFIG_COMPAL_LAPTOP)	+= compal-laptop.o
> diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
> new file mode 100644
> index 000000000000..6e376cb6d47e
> --- /dev/null
> +++ b/drivers/platform/x86/inspur_platform_profile.c

> +/**
> + * Power Mode:
> + *           0x0: Balance Mode
> + *           0x1: Performance Mode
> + *           0x2: Power Saver Mode
> + */
> +enum inspur_tmp_profile {
> +	INSPUR_TMP_PROFILE_BALANCE	= 0,
> +	INSPUR_TMP_PROFILE_PERFORMANCE	= 1,
> +	INSPUR_TMP_PROFILE_POWERSAVE	= 2,
> +};

> +/**
> + * Set Power Mode to EC RAM. If Power Mode value greater than 0x3,
> + * return error
> + * Method ID: 0x3
> + * Arg: 4 Bytes
> + * Byte [0]: Power Mode:
> + *         0x0: Balance Mode
> + *         0x1: Performance Mode
> + *         0x2: Power Saver Mode
> + * Return Value: 4 Bytes
> + * Byte [0]: Return Code
> + *         0x0: No Error
> + *         0x1: Error
> + */
> +static int inspur_platform_profile_set(struct platform_profile_handler *pprof,
> +				       enum platform_profile_option profile)
> +{

> +/**
> + * Get Power Mode from EC RAM, If Power Mode value greater than 0x3,
> + * return error
> + * Method ID: 0x2
> + * Return Value: 4 Bytes
> + * Byte [0]: Return Code
> + *         0x0: No Error
> + *         0x1: Error
> + * Byte [1]: Power Mode
> + *         0x0: Balance Mode
> + *         0x1: Performance Mode
> + *         0x2: Power Saver Mode
> + */
> +static int inspur_platform_profile_get(struct platform_profile_handler *pprof,
> +				       enum platform_profile_option *profile)
> +{

Applied to review-ilpo.

I had to remove the kerneldoc markers as the comments above are not 
consistent with what kerneldoc expects and it triggered a warning.

-- 
 i.

