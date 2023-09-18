Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27CB7A4A0A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241861AbjIRMrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241943AbjIRMrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:47:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F41E10CA;
        Mon, 18 Sep 2023 05:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695041127; x=1726577127;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=evExW3bG5vKXvR/8ACHxSz8qanjHLTzC/i7m/KWMGPU=;
  b=jNEe/K/tjRdDVQSZFAHti12RwNyt/9yOc9zTo+coGnQd1e3xkWKbU4v0
   Gr8xwXQaEZumSdJ8sk7CxQexORIy/i4ob8fAJORMrbECv2G7ARjcZm9Aq
   nwV+6KCnaEmEIjSSE6l0snIPdj8cebDM76pd2S2Bv2NAcly26JOjTFjBV
   cqO8sjIp+1dw1k0oT+E3DRG9FF4qgqbkvgc/M15i/BLVK4ubEcWHtVQnc
   XXhzJg7lkNwYvAcFyFibuTYi3XDfXArTz/EPUCfDQXTSJVSEXcWXXVJYX
   zwm2puByPRW3c5PgxS3Cf7MylaBhyt0+bHnljLRSVPqyrew2VuUO2+NmM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="465990154"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="465990154"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 05:45:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="695496315"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="695496315"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orsmga003.jf.intel.com with SMTP; 18 Sep 2023 05:45:05 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 18 Sep 2023 15:45:04 +0300
Date:   Mon, 18 Sep 2023 15:45:04 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Abdel Alkuor <alkuor@gmail.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, bryan.odonoghue@linaro.org,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        conor+dt@kernel.org, linux-kernel@vger.kernel.org,
        abdelalkuor@geotab.com
Subject: Re: [PATCH v5 05/15] USB: typec: Check for EEPROM present
Message-ID: <ZQhGUKocVc+yjOVL@kuha.fi.intel.com>
References: <20230917152639.21443-1-alkuor@gmail.com>
 <20230917152639.21443-6-alkuor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230917152639.21443-6-alkuor@gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 17, 2023 at 11:26:29AM -0400, Abdel Alkuor wrote:
> From: Abdel Alkuor <abdelalkuor@geotab.com>
> 
> When an EEPROM is present, tps25750 loads the binary configuration from
> EEPROM. Hence, all we need to do is wait for the device to switch to APP
> mode
> 
> Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
> ---
>  drivers/usb/typec/tipd/core.c     | 13 +++++++++++++
>  drivers/usb/typec/tipd/tps6598x.h |  3 +++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index fea139c72d6d..b3d4b2b5bf5f 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -37,6 +37,7 @@
>  #define TPS_REG_STATUS			0x1a
>  #define TPS_REG_SYSTEM_CONF		0x28
>  #define TPS_REG_CTRL_CONF		0x29
> +#define TPS_REG_BOOT_STATUS		0x2D
>  #define TPS_REG_POWER_STATUS		0x3f
>  #define TPS_REG_RX_IDENTITY_SOP		0x48
>  #define TPS_REG_DATA_STATUS		0x5f
> @@ -897,6 +898,17 @@ static int tps25750_apply_patch(struct tps6598x *tps)
>  	int ret;
>  	unsigned long timeout;
>  	u8 mode;
> +	u64 status = 0;
> +
> +	ret = tps6598x_block_read(tps, TPS_REG_BOOT_STATUS, &status, 5);
> +	if (ret)
> +		return ret;
> +	/*
> +	 * Nothing to be done if the configuration
> +	 * is being loaded from EERPOM
> +	 */
> +	if (status & TPS25750_BOOT_STATUS_I2C_EEPROM_PRESENT)
> +		goto wait_for_app;
>  
>  	ret = tps25750_start_patch_burst_mode(tps);
>  	if (ret) {
> @@ -908,6 +920,7 @@ static int tps25750_apply_patch(struct tps6598x *tps)
>  	if (ret)
>  		return ret;
>  
> +wait_for_app:
>  	timeout = jiffies + msecs_to_jiffies(1000);
>  
>  	do {
> diff --git a/drivers/usb/typec/tipd/tps6598x.h b/drivers/usb/typec/tipd/tps6598x.h
> index 527857549d69..5e942c089c27 100644
> --- a/drivers/usb/typec/tipd/tps6598x.h
> +++ b/drivers/usb/typec/tipd/tps6598x.h
> @@ -199,4 +199,7 @@
>  #define TPS_DATA_STATUS_DP_SPEC_PIN_ASSIGNMENT_A    BIT(2)
>  #define TPS_DATA_STATUS_DP_SPEC_PIN_ASSIGNMENT_B    (BIT(2) | BIT(1))
>  
> +/* BOOT STATUS REG*/
> +#define TPS25750_BOOT_STATUS_I2C_EEPROM_PRESENT	BIT(3)

That's not TPS25750 specific bit, so please rename that to
TPS_BOOT_STATUS_I2C_EEPROM_PRESENT

thanks,

-- 
heikki
