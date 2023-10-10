Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18AF97BF647
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjJJImm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjJJIml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:42:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546E8AF;
        Tue, 10 Oct 2023 01:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696927359; x=1728463359;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kkyLSf4/qcEQkbIbtLZI4kvgbwssKuyY44JGAodpz8k=;
  b=NVxKT9UEXxURGiWVMOqhqqedsZpP2Z1SnuU0cDnaVWgfLg+uL+HqBnuv
   ycsTUX595037eTirAZ21iW610m6aXUDr6MsXqhwgtkGn7KNfxbjRvhP6I
   PQ5VO0YcysaGWcQ92z55i3ugRHAJTjbHEb8PLsNSxPg5hiudTXQHMOH3z
   sha1vw6RSkA/ybsF0VxB1fmTVTvq6LJE/efxZTdvBXhXadPyP4tBLEOIn
   va5SFTwzT3GeqIimdbe0mg6hliceD7ER/oyIKtPGYboUz6+O+r9zywKOB
   rJrvcMpu+sLCntvzseFgKgjjbxIFllfBoK4zs1QDs232RNX6T+0RcWIm8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="364637356"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="364637356"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 01:42:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="757041419"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="757041419"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga007.fm.intel.com with SMTP; 10 Oct 2023 01:42:29 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 10 Oct 2023 11:42:25 +0300
Date:   Tue, 10 Oct 2023 11:42:25 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     gregkh@linuxfoundation.org, wsa@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander.Deucher@amd.com, Richard.Gong@amd.com,
        kai.heng.feng@canonical.com, sebastian.reichel@collabora.com
Subject: Re: [PATCH v3] usb: typec: ucsi: Use GET_CAPABILITY attributes data
 to set power supply scope
Message-ID: <ZSUOcdtWQ/AlAH+c@kuha.fi.intel.com>
References: <20231009184643.129986-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009184643.129986-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 01:46:43PM -0500, Mario Limonciello wrote:
> On some OEM systems, adding a W7900 dGPU triggers RAS errors and hangs
> at a black screen on startup.  This issue occurs only if `ucsi_acpi` has
> loaded before `amdgpu` has loaded.  The reason for this failure is that
> `amdgpu` uses power_supply_is_system_supplied() to determine if running
> on AC or DC power at startup. If this value is reported incorrectly the
> dGPU will also be programmed incorrectly and trigger errors.
> 
> power_supply_is_system_supplied() reports the wrong value because UCSI
> power supplies provided as part of the system don't properly report the
> scope as "DEVICE" scope (not powering the system).
> 
> In order to fix this issue check the capabilities reported from the UCSI
> power supply to ensure that it supports charging a battery and that it can
> be powered by AC.  Mark the scope accordingly.
> 
> Cc: stable@vger.kernel.org
> Fixes: a7fbfd44c020 ("usb: typec: ucsi: Mark dGPUs as DEVICE scope")
> Link: https://www.intel.com/content/www/us/en/products/docs/io/universal-serial-bus/usb-type-c-ucsi-spec.html p28
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>>
> Cc: Richard Gong <Richard.Gong@amd.com>
> 
> v2->v3:
>  * Pick up tag
>  * Add missing stable tag
>  * Drop patch 2, we'll just avoid upstreaming it.
> ---
>  drivers/usb/typec/ucsi/psy.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/usb/typec/ucsi/psy.c b/drivers/usb/typec/ucsi/psy.c
> index 384b42267f1f..b35c6e07911e 100644
> --- a/drivers/usb/typec/ucsi/psy.c
> +++ b/drivers/usb/typec/ucsi/psy.c
> @@ -37,6 +37,15 @@ static int ucsi_psy_get_scope(struct ucsi_connector *con,
>  	struct device *dev = con->ucsi->dev;
>  
>  	device_property_read_u8(dev, "scope", &scope);
> +	if (scope == POWER_SUPPLY_SCOPE_UNKNOWN) {
> +		u32 mask = UCSI_CAP_ATTR_POWER_AC_SUPPLY |
> +			   UCSI_CAP_ATTR_BATTERY_CHARGING;
> +
> +		if (con->ucsi->cap.attributes & mask)
> +			scope = POWER_SUPPLY_SCOPE_SYSTEM;
> +		else
> +			scope = POWER_SUPPLY_SCOPE_DEVICE;
> +	}
>  	val->intval = scope;
>  	return 0;
>  }
> -- 
> 2.34.1

-- 
heikki
