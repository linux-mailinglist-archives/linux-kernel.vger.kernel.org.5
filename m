Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8227850CE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 08:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbjHWGut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 02:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbjHWGus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 02:50:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FB5E5A;
        Tue, 22 Aug 2023 23:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692773444; x=1724309444;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TREB1LHq6cZ6inH86OPR1ocARs1m7G9NR39QZcMNDvo=;
  b=Q3DpbdvfPnHY2rJMFSdUs39SQbvfQeYF4JYlYOqZ+zBlm2bGUm5W19c7
   iRQ5VkGmy8J4rUxorxSCIsGzNysu0phE1mvSg8A2R5x2JoY19CH46C7Vu
   jNvIXuGQ36F9ka0qHQHbVl9ao1+kVeTbNbayIrzkpcgiC9E3NicOQ1Rtm
   4SoYKA98O+V5cKx0eSAtNFuqbAn0DGfDLdaG76HveNDMEqMA9HT5f2WEz
   9wE0pdpk33ymJ69WscpykOUe9FUPIA5sKAuxL+eOGm+8bIJHouaEV9bY8
   LzswboY8Q/hXy9nBHp0FC3DXzyEnI3i8AptcKnHuyXpLAhJwal/o7eLeW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="359068084"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="359068084"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 23:49:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="880288241"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 22 Aug 2023 23:49:13 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 23 Aug 2023 09:49:07 +0300
Date:   Wed, 23 Aug 2023 09:49:07 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     gregkh@linuxfoundation.org, linux@roeck-us.net, kyletso@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v1] tcpm: Avoid soft reset when partner does not support
 get_status
Message-ID: <ZOWr42vfSexOFDjq@kuha.fi.intel.com>
References: <20230820044449.1005889-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230820044449.1005889-1-badhri@google.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2023 at 04:44:48AM +0000, Badhri Jagan Sridharan wrote:
> When partner does not support get_status message, tcpm right now
> responds with soft reset message. This causes PD renegotiation to
> happen and resets PPS link. Avoid soft resetting the link when
> partner does not support get_status message to mitigate PPS resets.
> 
> [  208.926752] Setting voltage/current limit 9500 mV 2450 mA
> [  208.930407] set_auto_vbus_discharge_threshold mode:3 pps_active:y vbus:9500 ret:0
> [  208.930418] state change SNK_TRANSITION_SINK -> SNK_READY [rev3 POWER_NEGOTIATION]
> [  208.930455] AMS POWER_NEGOTIATION finished
> 
> // ALERT message from the Source
> [  213.948442] PD RX, header: 0x19a6 [1]
> [  213.948451] state change SNK_READY -> GET_STATUS_SEND [rev3 GETTING_SOURCE_SINK_STATUS]
> [  213.948457] PD TX, header: 0x492
> [  213.950402] PD TX complete, status: 0
> [  213.950427] pending state change GET_STATUS_SEND -> GET_STATUS_SEND_TIMEOUT @ 60 ms [rev3 GETTING_SOURCE_SINK_STATUS]
> 
> // NOT_SUPPORTED from the Source
> [  213.959954] PD RX, header: 0xbb0 [1]
> 
> // sink sends SOFT_RESET
> [  213.959958] state change GET_STATUS_SEND -> SNK_SOFT_RESET [rev3 GETTING_SOURCE_SINK_STATUS]
> [  213.959962] AMS GETTING_SOURCE_SINK_STATUS finished
> [  213.959964] AMS SOFT_RESET_AMS start
> [  213.959966] state change SNK_SOFT_RESET -> AMS_START [rev3 SOFT_RESET_AMS]
> [  213.959969] state change AMS_START -> SOFT_RESET_SEND [rev3 SOFT_RESET_AMS]
> 
> Cc: stable@vger.kernel.org
> Fixes: 8dea75e11380 ("usb: typec: tcpm: Protocol Error handling")
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 5639b9a1e0bf..280ce1bd7b53 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -2753,6 +2753,13 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
>  			port->sink_cap_done = true;
>  			tcpm_set_state(port, ready_state(port), 0);
>  			break;
> +		/*
> +		 * Some port partners do not support GET_STATUS, avoid soft reset the link to
> +		 * prevent redundant power re-negotiation
> +		 */
> +		case GET_STATUS_SEND:
> +			tcpm_set_state(port, ready_state(port), 0);
> +			break;
>  		case SRC_READY:
>  		case SNK_READY:
>  			if (port->vdm_state > VDM_STATE_READY) {
> 
> base-commit: bbb9e06d2c6435af9c62074ad7048910eeb2e7bc
> -- 
> 2.42.0.rc1.204.g551eb34607-goog

-- 
heikki
