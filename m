Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B735F7851F7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 09:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbjHWHtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 03:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbjHWHtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 03:49:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03ABDCD0;
        Wed, 23 Aug 2023 00:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692776987; x=1724312987;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r2zRQXntKmFL8qUgE3kxpQRyrW02PDNql8A7IwbR+Ao=;
  b=BOc8QqmIHN5P5gpv4WGUbi98S6ii4GNXvlt0/VjO1861dkNn40mMpfOl
   JURibwCorbeGX6ShvKbPSCR6xEkWgTZOXw9BUP1cqlRItoN+72SNRsr5J
   lAN7iz/7A+2Ma693qoxjrEk6DN1vW/kTnMCfpliRDJQixXfqMD840kvvh
   SPq49Mx6UJCcKRIS7axJwwHk8yZoCpmArRjafI47u4W9B6E+0+f0J2++K
   wqhPqXDVygOHeWsSf5QJLU+gGkMvF6XJeYiDPdhQLbbvLzAh8IFXDyZyS
   ozrVlNYlBClNignRS9vd4KXJxB0mGh311Lu5v/Km7cXNgoG4njnjUsWsG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="377855100"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="377855100"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 00:49:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="880308309"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 23 Aug 2023 00:49:48 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 23 Aug 2023 10:49:42 +0300
Date:   Wed, 23 Aug 2023 10:49:42 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     RD Babiera <rdbabiera@google.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org, kyletso@google.com,
        badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: tcpm: set initial svdm version based on
 pd revision
Message-ID: <ZOW6FoLZ7ZUzVz85@kuha.fi.intel.com>
References: <20230731165926.1815338-1-rdbabiera@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731165926.1815338-1-rdbabiera@google.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 04:59:23PM +0000, RD Babiera wrote:
> When sending Discover Identity messages to a Port Partner that uses Power
> Delivery v2 and SVDM v1, we currently send PD v2 messages with SVDM v2.0,
> expecting the port partner to respond with its highest supported SVDM
> version as stated in Section 6.4.4.2.3 in the Power Delivery v3
> specification. However, sending SVDM v2 to some Power Delivery v2 port
> partners results in a NAK whereas sending SVDM v1 does not.
> 
> NAK messages can be handled by the initiator (PD v3 section 6.4.4.2.5.1),
> and one solution could be to resend Discover Identity on a lower SVDM
> version if possible. But, Section 6.4.4.3 of PD v2 states that "A NAK
> response Should be taken as an indication not to retry that particular
> Command."
> 
> Instead, we can set the SVDM version to the maximum one supported by the
> negotiated PD revision. When operating in PD v2, this obeys Section
> 6.4.4.2.3, which states the SVDM field "Shall be set to zero to indicate
> Version 1.0." In PD v3, the SVDM field "Shall be set to 01b to indicate
> Version 2.0."
> 
> Fixes: c34e85fa69b9 ("usb: typec: tcpm: Send DISCOVER_IDENTITY from dedicated work")
> Cc: stable@vger.kernel.org
> Signed-off-by: RD Babiera <rdbabiera@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes since v1:
> * Fixed styling errors.
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 35 +++++++++++++++++++++++++++++++----
>  1 file changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 829d75ebab42..5024354a0fe0 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -3928,6 +3928,29 @@ static enum typec_cc_status tcpm_pwr_opmode_to_rp(enum typec_pwr_opmode opmode)
>  	}
>  }
>  
> +static void tcpm_set_initial_svdm_version(struct tcpm_port *port)
> +{
> +	switch (port->negotiated_rev) {
> +	case PD_REV30:
> +		break;
> +	/*
> +	 * 6.4.4.2.3 Structured VDM Version
> +	 * 2.0 states "At this time, there is only one version (1.0) defined.
> +	 * This field Shall be set to zero to indicate Version 1.0."
> +	 * 3.0 states "This field Shall be set to 01b to indicate Version 2.0."
> +	 * To ensure that we follow the Power Delivery revision we are currently
> +	 * operating on, downgrade the SVDM version to the highest one supported
> +	 * by the Power Delivery revision.
> +	 */
> +	case PD_REV20:
> +		typec_partner_set_svdm_version(port->partner, SVDM_VER_1_0);
> +		break;
> +	default:
> +		typec_partner_set_svdm_version(port->partner, SVDM_VER_1_0);
> +		break;
> +	}
> +}
> +
>  static void run_state_machine(struct tcpm_port *port)
>  {
>  	int ret;
> @@ -4165,10 +4188,12 @@ static void run_state_machine(struct tcpm_port *port)
>  		 * For now, this driver only supports SOP for DISCOVER_IDENTITY, thus using
>  		 * port->explicit_contract to decide whether to send the command.
>  		 */
> -		if (port->explicit_contract)
> +		if (port->explicit_contract) {
> +			tcpm_set_initial_svdm_version(port);
>  			mod_send_discover_delayed_work(port, 0);
> -		else
> +		} else {
>  			port->send_discover = false;
> +		}
>  
>  		/*
>  		 * 6.3.5
> @@ -4455,10 +4480,12 @@ static void run_state_machine(struct tcpm_port *port)
>  		 * For now, this driver only supports SOP for DISCOVER_IDENTITY, thus using
>  		 * port->explicit_contract.
>  		 */
> -		if (port->explicit_contract)
> +		if (port->explicit_contract) {
> +			tcpm_set_initial_svdm_version(port);
>  			mod_send_discover_delayed_work(port, 0);
> -		else
> +		} else {
>  			port->send_discover = false;
> +		}
>  
>  		power_supply_changed(port->psy);
>  		break;
> 
> base-commit: fdf0eaf11452d72945af31804e2a1048ee1b574c
> -- 
> 2.41.0.585.gd2178a4bd4-goog

-- 
heikki
