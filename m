Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DC47E9E7D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 15:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjKMOUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 09:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjKMOUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 09:20:49 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A200C2;
        Mon, 13 Nov 2023 06:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699885246; x=1731421246;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=BkajzwN4z7DsEUm+ldWOYbi0p1iAY7ihbaza0XOUrDs=;
  b=Azq49J8IAbb2xaF5vmlrZd8CKUM71+PzS21EJcNM2Y5b4Hmg6RFNkfLE
   LyDpT12Y0VIOAlUUY+UXZgQRkCk8Se90hDT4Cce1zJpLgBoUShFKXugET
   JVdvjCDF7GuPRKW2qURq/IyJM+MpsfzZ6qsQvp4D6LE9Ou6RN9Q18V5Pk
   wBWvM0YD2D8jgIkObUskzPDNDgTcl/On9Y3ag+CBES/imF/8xAVPRuIWn
   VYTjeM2ot7J/y6nQf9yMN6iSovUbNVso5Tz0HeZ/UR8aWnsjo24Ve0dKH
   OiKR0pqbTtcf/jmG5+vfEn79ikNCC7kUuhq95OweCPaHslwmvgrl+khsp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="393304931"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="393304931"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 06:20:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="793446848"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="793446848"
Received: from alexdsou-mobl3.gar.corp.intel.com ([10.249.44.83])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 06:20:43 -0800
Date:   Mon, 13 Nov 2023 16:20:40 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Mark Pearson <mpearson-lenovo@squebb.ca>
cc:     platform-driver-x86@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        ibm-acpi-devel@lists.sourceforge.net, mario.limonciello@amd.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] platform/x86: Add support for improved performance
 mode
In-Reply-To: <20231113135741.4787-1-mpearson-lenovo@squebb.ca>
Message-ID: <17aa8729-11dd-c04a-fbcb-812121157ae@linux.intel.com>
References: <mpearson-lenovo@squebb.ca> <20231113135741.4787-1-mpearson-lenovo@squebb.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2023, Mark Pearson wrote:

> Some new Thinkpads have a new improved performance mode available.
> Add support to make this mode usable.
> 
> To avoid having to create a new profile, just use the improved performance
> mode in place of the existing performance mode, when available.
> 
> Tested on P14s AMD G4 AMD.
> 
> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> ---
> Changes in v2: updated implementation for DYTC_UP_SUPPORT define
> 
>  drivers/platform/x86/thinkpad_acpi.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index ad460417f901..ed8860caa9c1 100644
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
> +#define DYTC_UP_SUPPORT        8  /* Ultra-performance (TMS) mode support */

You forgot to add BIT() here. (But took it away from the other place 
so this patch is actually broken currently I think).

> +
>  #define DYTC_ERR_MASK       0xF  /* Bits 0-3 in cmd result are the error result */
>  #define DYTC_ERR_SUCCESS      1  /* CMD completed successful */
>  
> @@ -10185,6 +10190,7 @@ static enum platform_profile_option dytc_current_profile;
>  static atomic_t dytc_ignore_event = ATOMIC_INIT(0);
>  static DEFINE_MUTEX(dytc_mutex);
>  static int dytc_capabilities;
> +static bool dytc_ultraperf_cap; /* ultra performance capable */

I think the comment is repeating the same information already given in the 
variable name so just drop the comment.

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
> +	dytc_ultraperf_cap = output & DYTC_UP_SUPPORT ? true : false;

Assigning to bool doesn't require "? true : false" construct like I 
already mentioned, just drop that part.

-- 
 i.


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
