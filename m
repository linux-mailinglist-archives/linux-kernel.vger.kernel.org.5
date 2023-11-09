Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D48B7E677B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 11:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbjKIKKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 05:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbjKIKKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 05:10:43 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF43F2D6D;
        Thu,  9 Nov 2023 02:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699524640; x=1731060640;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4qGhbTIRC708KjN7HRwtdwzqwPhWWMW76mIn+hrZgRo=;
  b=WZA9heMtudmVOXYJTdxWVcjDxIY4LHzPE6HuqIttJHAJlCECh4M5Jy+Q
   UU1AyjEt8ikE7etSpAWfwFBpS+NiUm97crP68ugu0kLWjRY7/+MRwTLaR
   KKV3kW054WRHjaIZQnMEtVm4a5vqiT1zR8UZZ9cTW3JAwGqqEhuBaQ1Cd
   WuUcc7I0YU/6/2P9YI1UNME+D0aCJCP0cZGC0T4vdznXsB/ymUnOvtsVA
   M9FyXV9y48pZscMsgj2flwBVy6gYwOUNjcwdW0GYtu7FMC/YWqtZbuMid
   PNk5431O0w3g5o3OlOMRyI7ANDlzNIwsyPbyfZUVO88AIkMmdj8fCQkwR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="393866786"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="393866786"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 02:10:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="4489377"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.mshome.net) ([10.237.66.38])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 02:10:36 -0800
Date:   Thu, 9 Nov 2023 12:10:33 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Mark Pearson <mpearson-lenovo@squebb.ca>
cc:     platform-driver-x86@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        ibm-acpi-devel@lists.sourceforge.net, mario.limonciello@amd.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: Add support for improved performance
 mode
In-Reply-To: <20231108162039.13737-1-mpearson-lenovo@squebb.ca>
Message-ID: <8b29ab8-fef4-8a60-e6c5-447f31f144a7@linux.intel.com>
References: <mpearson-lenovo@squebb.ca> <20231108162039.13737-1-mpearson-lenovo@squebb.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Nov 2023, Mark Pearson wrote:

> Some new Thinkpads have a new improved performance mode available.
> Add support to make this mode usable.
> 
> To avoid having to create a new profile, just use the improved performance
> mode in place of the existing performance mode, when available.
> 
> Tested on T14 AMD G4 AMD.
> 
> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> ---
>  drivers/platform/x86/thinkpad_acpi.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index ad460417f901..eba701ab340e 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -10136,6 +10136,7 @@ static struct ibm_struct proxsensor_driver_data = {
>  
>  #define DYTC_CMD_SET          1 /* To enable/disable IC function mode */
>  #define DYTC_CMD_MMC_GET      8 /* To get current MMC function and mode */
> +#define DYTC_CMD_UP_CAP     0xA /* To get Ultra-performance capability */
>  #define DYTC_CMD_RESET    0x1ff /* To reset back to default */
>  
>  #define DYTC_CMD_FUNC_CAP     3 /* To get DYTC capabilities */
> @@ -10152,6 +10153,7 @@ static struct ibm_struct proxsensor_driver_data = {
>  
>  #define DYTC_FUNCTION_STD     0  /* Function = 0, standard mode */
>  #define DYTC_FUNCTION_CQL     1  /* Function = 1, lap mode */
> +#define DYTC_FUNCTION_TMS     9  /* Function = 9, TMS mode */
>  #define DYTC_FUNCTION_MMC     11 /* Function = 11, MMC mode */
>  #define DYTC_FUNCTION_PSC     13 /* Function = 13, PSC mode */
>  #define DYTC_FUNCTION_AMT     15 /* Function = 15, AMT mode */
> @@ -10163,11 +10165,14 @@ static struct ibm_struct proxsensor_driver_data = {
>  #define DYTC_MODE_MMC_LOWPOWER 3  /* Low power mode */
>  #define DYTC_MODE_MMC_BALANCE  0xF  /* Default mode aka balanced */
>  #define DYTC_MODE_MMC_DEFAULT  0  /* Default mode from MMC_GET, aka balanced */
> +#define DYTC_NOMODE            0xF  /* When Function does not have a mode */
>  
>  #define DYTC_MODE_PSC_LOWPOWER 3  /* Low power mode */
>  #define DYTC_MODE_PSC_BALANCE  5  /* Default mode aka balanced */
>  #define DYTC_MODE_PSC_PERFORM  7  /* High power mode aka performance */
>  
> +#define DYTC_UP_SUPPORT_BIT    8  /* Bit 8 - 1 = supported, 0 = not */

It would be preferrable to comment what is supported rather than have a 
comment like above which isn't particularly helpful.

>  #define DYTC_ERR_MASK       0xF  /* Bits 0-3 in cmd result are the error result */
>  #define DYTC_ERR_SUCCESS      1  /* CMD completed successful */
>  
> @@ -10185,6 +10190,7 @@ static enum platform_profile_option dytc_current_profile;
>  static atomic_t dytc_ignore_event = ATOMIC_INIT(0);
>  static DEFINE_MUTEX(dytc_mutex);
>  static int dytc_capabilities;
> +static bool dytc_ultraperf_cap; /* ultra performance capable */
>  static bool dytc_mmc_get_available;
>  static int profile_force;
>  
> @@ -10355,6 +10361,17 @@ static int dytc_profile_set(struct platform_profile_handler *pprof,
>  	if (err)
>  		goto unlock;
>  
> +	/* Set TMS mode appropriately (enable for performance), if available */
> +	if (dytc_ultraperf_cap) {
> +		int cmd;
> +
> +		cmd = DYTC_SET_COMMAND(DYTC_FUNCTION_TMS, DYTC_NOMODE,
> +				       profile == PLATFORM_PROFILE_PERFORMANCE);
> +		err = dytc_command(cmd, &output);
> +		if (err)
> +			return err;
> +	}
> +
>  	if (dytc_capabilities & BIT(DYTC_FC_MMC)) {
>  		if (profile == PLATFORM_PROFILE_BALANCED) {
>  			/*
> @@ -10429,6 +10446,7 @@ static struct platform_profile_handler dytc_profile = {
>  static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
>  {
>  	int err, output;
> +	int cmd;
>  
>  	/* Setup supported modes */
>  	set_bit(PLATFORM_PROFILE_LOW_POWER, dytc_profile.choices);
> @@ -10484,6 +10502,16 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
>  		dbg_printk(TPACPI_DBG_INIT, "No DYTC support available\n");
>  		return -ENODEV;
>  	}
> +	err = dytc_command(DYTC_CMD_UP_CAP, &output);
> +	dytc_ultraperf_cap = output & BIT(DYTC_UP_SUPPORT_BIT) ? true : false;

It would be better to put this BIT() into the define itself and remove 
_BIT from the name because it doesn't really add that much information.
Since you're assigning to bool, ? true : false construct is not required 
but implicit cast will handle it for you. So in the end, this line would 
be:

	dytc_ultraperf_cap = output & DYTC_UP_SUPPORT;

Looking into the driver a bit more, there are a few other defines which 
could also move BIT() from the code into defines. Please tell if you're 
going to look at those because if not, I might try to make the patches.

> +	if (dytc_ultraperf_cap) {
> +		pr_debug("TMS is supported\n");
> +		/* Disable TMS by default - only use with performance mode */
> +		cmd = DYTC_SET_COMMAND(DYTC_FUNCTION_TMS, DYTC_NOMODE, 0);
> +		err = dytc_command(cmd, &output);
> +		if (err)
> +			return err;
> +	}
>  
>  	dbg_printk(TPACPI_DBG_INIT,
>  			"DYTC version %d: thermal mode available\n", dytc_version);
> 

-- 
 i.

