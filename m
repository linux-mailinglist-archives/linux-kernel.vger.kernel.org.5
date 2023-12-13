Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7253A8114AD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441960AbjLMOdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441923AbjLMOdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:33:00 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42160B9;
        Wed, 13 Dec 2023 06:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702477986; x=1734013986;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+/l+0BNbimCMHUlKMvEhWrN0nsKQrugc4xTA+mJbo1c=;
  b=kv7uqr2kUo1yeoctXIXLoJ5mx5gwUcLr9ZWsRO1FJttkh7qHNtjoYJw+
   IlMvf1A8cOGhVHTyxSn8qV20KetSSzfknzppJMwdgMuWeWlBrcOli8WIY
   PN7Y5+/aB1n49O/NdQ5BcEJ8CVfzqBYWEwfuCxE08nEvgHokHSeLvLNcB
   pOMm8mdV8p1jega0sYFvKBUfFgXsmbsKWnOxfY1kLhFJhdEaXdxo85pis
   eaiXC/DtCOg1dRPoVbFeS51X1NhJ8txkYwfKbp47wz2ObHO53a2/5P2m5
   Cf9SpfBndCF7fr6ou4H2pW+zMaHRj9UFb14lY3jpjNS5qdMGyd0b94LGh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="2111276"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="2111276"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 06:32:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="1105333851"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="1105333851"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga005.fm.intel.com with SMTP; 13 Dec 2023 06:32:42 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 13 Dec 2023 16:32:41 +0200
Date:   Wed, 13 Dec 2023 16:32:41 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Kyle Tso <kyletso@google.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux@roeck-us.net,
        gregkh@linuxfoundation.org, badhri@google.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v5 2/2] usb: typec: tcpm: Support multiple capabilities
Message-ID: <ZXnAiRa9bBacASQ5@kuha.fi.intel.com>
References: <20231205030114.1349089-1-kyletso@google.com>
 <20231205030114.1349089-3-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205030114.1349089-3-kyletso@google.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kyle,

On Tue, Dec 05, 2023 at 11:01:14AM +0800, Kyle Tso wrote:
> Refactor tcpm_fw_get_caps to support the multiple pd capabilities got
> from fwnode. For backward compatibility, the original single capability
> is still applicable. The fetched data is stored in the newly defined
> structure "pd_data" and there is an array "pd_list" to store the
> pointers to them. A dedicated array "pds" is used to store the handles
> of the registered usb_power_delivery instances.
> 
> Also implement the .pd_get and .pd_set ops which are introduced in
> commit a7cff92f0635 ("usb: typec: USB Power Delivery helpers for ports
> and partners"). Once the .pd_set is called, the current capability will
> be updated and state machine will re-negotiate the power contract if
> possible.
> 
> Signed-off-by: Kyle Tso <kyletso@google.com>
> ---
> v4 -> v5:
> - no change
> 
>  drivers/usb/typec/tcpm/tcpm.c | 389 ++++++++++++++++++++++++++--------
>  1 file changed, 303 insertions(+), 86 deletions(-)

<snip>

> @@ -6124,12 +6243,11 @@ static int tcpm_port_register_pd(struct tcpm_port *port)
>  	return ret;
>  }
>  
> -static int tcpm_fw_get_caps(struct tcpm_port *port,
> -			    struct fwnode_handle *fwnode)
> +static int tcpm_fw_get_properties(struct tcpm_port *port, struct fwnode_handle *fwnode)

The function names got me confused first :). Even though you now call
this "properties", I think the term "capablities" can in practice
still mean two things in this driver (you are for example still
calling typec_get_fw_cap() from this function).

So how about you don't change the name of this function, but
instead..

>  {
>  	const char *opmode_str;
> +	u32 frs_current;
>  	int ret;
> -	u32 mw, frs_current;
>  
>  	if (!fwnode)
>  		return -EINVAL;
> @@ -6149,28 +6267,10 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
>  
>  	port->port_type = port->typec_caps.type;
>  	port->pd_supported = !fwnode_property_read_bool(fwnode, "pd-disable");
> -
>  	port->slow_charger_loop = fwnode_property_read_bool(fwnode, "slow-charger-loop");
> -	if (port->port_type == TYPEC_PORT_SNK)
> -		goto sink;
> -
> -	/* Get Source PDOs for the PD port or Source Rp value for the non-PD port */
> -	if (port->pd_supported) {
> -		ret = fwnode_property_count_u32(fwnode, "source-pdos");
> -		if (ret == 0)
> -			return -EINVAL;
> -		else if (ret < 0)
> -			return ret;
> +	port->self_powered = fwnode_property_read_bool(fwnode, "self-powered");
>  
> -		port->nr_src_pdo = min(ret, PDO_MAX_OBJECTS);
> -		ret = fwnode_property_read_u32_array(fwnode, "source-pdos",
> -						     port->src_pdo, port->nr_src_pdo);
> -		if (ret)
> -			return ret;
> -		ret = tcpm_validate_caps(port, port->src_pdo, port->nr_src_pdo);
> -		if (ret)
> -			return ret;
> -	} else {
> +	if (!port->pd_supported) {
>  		ret = fwnode_property_read_string(fwnode, "typec-power-opmode", &opmode_str);
>  		if (ret)
>  			return ret;
> @@ -6180,43 +6280,156 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
>  		port->src_rp = tcpm_pwr_opmode_to_rp(ret);
>  	}
>  
> -	if (port->port_type == TYPEC_PORT_SRC)
> -		return 0;
> +	/* FRS can only be supported by DRP ports */
> +	if (port->port_type == TYPEC_PORT_DRP) {
> +		ret = fwnode_property_read_u32(fwnode, "new-source-frs-typec-current",
> +					       &frs_current);
> +		if (!ret && frs_current <= FRS_5V_3A)
> +			port->new_source_frs_current = frs_current;
> +	}
>  
> -sink:
> -	port->self_powered = fwnode_property_read_bool(fwnode, "self-powered");
> +	return 0;
> +}
> +
> +static int tcpm_fw_get_caps(struct tcpm_port *port, struct fwnode_handle *fwnode)

..make that tcpm_fw_get_pd_capabilities() (or something like that) to
be more clear?

Also, since you are only calling this ones, why not just call this
directly from tcpm_fw_get_cap() instead of right after it?

thanks,

-- 
heikki
