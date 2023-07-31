Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE947694A9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjGaLVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjGaLVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:21:19 -0400
Received: from mgamail.intel.com (unknown [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A311725;
        Mon, 31 Jul 2023 04:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690802472; x=1722338472;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F383v6e7PZXrXOhnmeDdxH0xkRInOWuQNTUB1QVjx2g=;
  b=lAColInEjFEl99nnulzmqTT//Zb/S8ep8yvbyhZL1YEAXeWk2OQz5a/n
   EzwvyQ4UYWe4RpQrHt9IQ/NVt6heeY2mkoyzt/fbi0vx8+g0Ws+CGrXhX
   6TeTJSjYylDw5/gAu0hRZDnCqhhLYqu+H6xGfi2+dV3lE1e/dKtgR0BoE
   vLEIGB6ADT3347h2TvMsMssfW7jwWWzhY571dLqMStqtrQdbykLB4VFFm
   iEOo4H2EycXSzavox0sYJFHAxqfJrahQ2VSzGMTfmSVmdBU1WM0+m6iIE
   R/uo8BRKtPVd3ADoW7dNpksP6BuXIV5iLxCponSOpfYmBmL14pI7L0YAQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="455364791"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="455364791"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 04:16:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="871646173"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 31 Jul 2023 04:16:25 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 31 Jul 2023 14:16:22 +0300
Date:   Mon, 31 Jul 2023 14:16:22 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     RD Babiera <rdbabiera@google.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org, kyletso@google.com,
        badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: tcpm: set initial svdm version based on
 pd revision
Message-ID: <ZMeYBvD+I1U8HNfF@kuha.fi.intel.com>
References: <20230726020810.1408299-1-rdbabiera@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726020810.1408299-1-rdbabiera@google.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm sorry to keep you waiting.

On Wed, Jul 26, 2023 at 02:08:07AM +0000, RD Babiera wrote:
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

This makes sense to me, but couple of nitpicks below.

> Fixes: c34e85fa69b9 ("usb: typec: tcpm: Send DISCOVER_IDENTITY from dedicated work")
> Cc: stable@vger.kernel.org
> Signed-off-by: RD Babiera <rdbabiera@google.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 35 +++++++++++++++++++++++++++++++----
>  1 file changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 829d75ebab42..5b0a428fcf5d 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -3928,6 +3928,31 @@ static enum typec_cc_status tcpm_pwr_opmode_to_rp(enum typec_pwr_opmode opmode)
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
> +		typec_partner_set_svdm_version(port->partner,
> +					       SVDM_VER_1_0);

One line is enough.

> +		break;
> +	default:
> +		typec_partner_set_svdm_version(port->partner,
> +					       SVDM_VER_1_0);

Ditto.

> +		break;
> +	}
> +}
> +
>  static void run_state_machine(struct tcpm_port *port)
>  {
>  	int ret;
> @@ -4165,9 +4190,10 @@ static void run_state_machine(struct tcpm_port *port)
>  		 * For now, this driver only supports SOP for DISCOVER_IDENTITY, thus using
>  		 * port->explicit_contract to decide whether to send the command.
>  		 */
> -		if (port->explicit_contract)
> +		if (port->explicit_contract) {
> +			tcpm_set_initial_svdm_version(port);
>  			mod_send_discover_delayed_work(port, 0);
> -		else
> +		} else
>  			port->send_discover = false;

The else statement needs to be wrapped in curly brackets in this case
since the if statement had them.

>  		/*
> @@ -4455,9 +4481,10 @@ static void run_state_machine(struct tcpm_port *port)
>  		 * For now, this driver only supports SOP for DISCOVER_IDENTITY, thus using
>  		 * port->explicit_contract.
>  		 */
> -		if (port->explicit_contract)
> +		if (port->explicit_contract) {
> +			tcpm_set_initial_svdm_version(port);
>  			mod_send_discover_delayed_work(port, 0);
> -		else
> +		} else
>  			port->send_discover = false;

Ditto.

thanks,

-- 
heikki
