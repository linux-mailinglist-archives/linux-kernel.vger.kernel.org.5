Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1771F76968B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbjGaMml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbjGaMmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:42:38 -0400
Received: from mgamail.intel.com (unknown [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011B710DF;
        Mon, 31 Jul 2023 05:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690807358; x=1722343358;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0MB2M7pKhqWAVfxRDoJt9ipjAOPvnCoU+CUBnmXYZ8o=;
  b=PlBeKTTpCsgQwYYjSoWGC2dFQ0hzanX4/eowTCwqluSpnbCPrXH6LlWO
   ESWJMFjDqW/dEimKCy9AwcILrwb5oeBzYc7uKh4wD+wGOiItQirpugUKZ
   Dn9yRnmkkPmxAPclntLWxAa9NdvUZYr/ynLT4epvUlfEQTD2sNFNod08U
   J3irWz0pdrKKqQg+CgfWmLTEQaJjfzLD0vfrRxQFjtxxaPT6mF4ZBh1dW
   Dk5fKw/kYzbO3aDlFLZdonmxJPN9tAGCGGiV+Cd0dDz7FbxRg5pTJUoGB
   Gz5Ntw4o/zz58kabEeqnsDh/Hk9ovmpkFAgYPxODWKrte9ePq9oBLYPKJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="348604838"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="348604838"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 05:42:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="871667298"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 31 Jul 2023 05:42:36 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 31 Jul 2023 15:42:34 +0300
Date:   Mon, 31 Jul 2023 15:42:33 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     RD Babiera <rdbabiera@google.com>
Cc:     gregkh@linuxfoundation.org, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: altmodes/displayport: Signal hpd when
 configuring pin assignment
Message-ID: <ZMesOaooOBvl7X1j@kuha.fi.intel.com>
References: <20230726020903.1409072-1-rdbabiera@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726020903.1409072-1-rdbabiera@google.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 02:09:02AM +0000, RD Babiera wrote:
> When connecting to some DisplayPort partners, the initial status update
> after entering DisplayPort Alt Mode notifies that the DFP_D/UFP_D is not in
> the connected state. This leads to sending a configure message that keeps
> the device in USB mode. The port partner then sets DFP_D/UFP_D to the
> connected state and HPD to high in the same Attention message. Currently,
> the HPD signal is dropped in order to handle configuration.
> 
> This patch saves changes to the HPD signal when the device chooses to
> configure during dp_altmode_status_update, and invokes sysfs_notify if
> necessary for HPD after configuring.
> 
> Fixes: 0e3bb7d6894d ("usb: typec: Add driver for DisplayPort alternate mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: RD Babiera <rdbabiera@google.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/altmodes/displayport.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
> index 66de880b28d0..cdf8261e22db 100644
> --- a/drivers/usb/typec/altmodes/displayport.c
> +++ b/drivers/usb/typec/altmodes/displayport.c
> @@ -60,6 +60,7 @@ struct dp_altmode {
>  
>  	enum dp_state state;
>  	bool hpd;
> +	bool pending_hpd;
>  
>  	struct mutex lock; /* device lock */
>  	struct work_struct work;
> @@ -144,8 +145,13 @@ static int dp_altmode_status_update(struct dp_altmode *dp)
>  		dp->state = DP_STATE_EXIT;
>  	} else if (!(con & DP_CONF_CURRENTLY(dp->data.conf))) {
>  		ret = dp_altmode_configure(dp, con);
> -		if (!ret)
> +		if (!ret) {
>  			dp->state = DP_STATE_CONFIGURE;
> +			if (dp->hpd != hpd) {
> +				dp->hpd = hpd;
> +				dp->pending_hpd = true;
> +			}
> +		}
>  	} else {
>  		if (dp->hpd != hpd) {
>  			drm_connector_oob_hotplug_event(dp->connector_fwnode);
> @@ -161,6 +167,16 @@ static int dp_altmode_configured(struct dp_altmode *dp)
>  {
>  	sysfs_notify(&dp->alt->dev.kobj, "displayport", "configuration");
>  	sysfs_notify(&dp->alt->dev.kobj, "displayport", "pin_assignment");
> +	/*
> +	 * If the DFP_D/UFP_D sends a change in HPD when first notifying the
> +	 * DisplayPort driver that it is connected, then we wait until
> +	 * configuration is complete to signal HPD.
> +	 */
> +	if (dp->pending_hpd) {
> +		drm_connector_oob_hotplug_event(dp->connector_fwnode);
> +		sysfs_notify(&dp->alt->dev.kobj, "displayport", "hpd");
> +		dp->pending_hpd = false;
> +	}
>  
>  	return dp_altmode_notify(dp);
>  }
> 
> base-commit: fdf0eaf11452d72945af31804e2a1048ee1b574c
> -- 
> 2.41.0.487.g6d72f3e995-goog

-- 
heikki
