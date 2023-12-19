Return-Path: <linux-kernel+bounces-5257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B588188A0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5154281AC9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1EE19464;
	Tue, 19 Dec 2023 13:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eDNw3Dbk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744A21945B;
	Tue, 19 Dec 2023 13:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702992331; x=1734528331;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZL8mJ+MiEm0edIiOsgaqMnUw5Ho6siAo3hb1ggpThD4=;
  b=eDNw3Dbk66Roii5tt2yLzQucQEsHY3lGkvVydZrNdJHdy4TfWHAy2aw+
   nVfwqR7Xz6XVp46T+wG4N7wL6LNSAt5AE4QNAgQIEGfhPiAyA+/KSUgaG
   VSggrUxDF6K2ohD5M56eP2W6glSYN7sn5jnRz3WNOGpxTz6VEJBa4t1e0
   z/wMpN2PS/EWe2WzgEKb3rlaf+y9/GjUu/VXYYaqhMGMUSlAewU3Cf6Za
   xw9FO5CnxQvtvQDIBBwLn4dykWphouwo9DNJ07g4zGVANJkyXtVPkvnky
   oFIgmTSjcU9aGSlltWilA9Lx6kMfKXKcwn/nV/4Bgp3kAVjzFeaDPJE2l
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="481845389"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="481845389"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 05:25:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="846341721"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="846341721"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga004.fm.intel.com with SMTP; 19 Dec 2023 05:25:27 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 19 Dec 2023 15:25:26 +0200
Date: Tue, 19 Dec 2023 15:25:26 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Kyle Tso <kyletso@google.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, linux@roeck-us.net, gregkh@linuxfoundation.org,
	badhri@google.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v6 2/2] usb: typec: tcpm: Support multiple capabilities
Message-ID: <ZYGZxgW7ViuNo1wH@kuha.fi.intel.com>
References: <20231216104630.2720818-1-kyletso@google.com>
 <20231216104630.2720818-3-kyletso@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231216104630.2720818-3-kyletso@google.com>

On Sat, Dec 16, 2023 at 06:46:30PM +0800, Kyle Tso wrote:
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

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> v5 -> v6:
>  - Removed the function tcpm_fw_get_properties
>  - Merged it to tcpm_fw_get_caps
> 
>  drivers/usb/typec/tcpm/tcpm.c | 387 ++++++++++++++++++++++++++--------
>  1 file changed, 298 insertions(+), 89 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index ff67553b6932..e11d680fd8b7 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -297,6 +297,15 @@ struct pd_pps_data {
>  	bool active;
>  };
>  
> +struct pd_data {
> +	struct usb_power_delivery *pd;
> +	struct usb_power_delivery_capabilities *source_cap;
> +	struct usb_power_delivery_capabilities_desc source_desc;
> +	struct usb_power_delivery_capabilities *sink_cap;
> +	struct usb_power_delivery_capabilities_desc sink_desc;
> +	unsigned int operating_snk_mw;
> +};
> +
>  struct tcpm_port {
>  	struct device *dev;
>  
> @@ -398,12 +407,14 @@ struct tcpm_port {
>  	unsigned int rx_msgid;
>  
>  	/* USB PD objects */
> -	struct usb_power_delivery *pd;
> +	struct usb_power_delivery **pds;
> +	struct pd_data **pd_list;
>  	struct usb_power_delivery_capabilities *port_source_caps;
>  	struct usb_power_delivery_capabilities *port_sink_caps;
>  	struct usb_power_delivery *partner_pd;
>  	struct usb_power_delivery_capabilities *partner_source_caps;
>  	struct usb_power_delivery_capabilities *partner_sink_caps;
> +	struct usb_power_delivery *selected_pd;
>  
>  	/* Partner capabilities/requests */
>  	u32 sink_request;
> @@ -413,6 +424,7 @@ struct tcpm_port {
>  	unsigned int nr_sink_caps;
>  
>  	/* Local capabilities */
> +	unsigned int pd_count;
>  	u32 src_pdo[PDO_MAX_OBJECTS];
>  	unsigned int nr_src_pdo;
>  	u32 snk_pdo[PDO_MAX_OBJECTS];
> @@ -6059,12 +6071,114 @@ static int tcpm_port_type_set(struct typec_port *p, enum typec_port_type type)
>  	return 0;
>  }
>  
> +static struct pd_data *tcpm_find_pd_data(struct tcpm_port *port, struct usb_power_delivery *pd)
> +{
> +	int i;
> +
> +	for (i = 0; port->pd_list[i]; i++) {
> +		if (port->pd_list[i]->pd == pd)
> +			return port->pd_list[i];
> +	}
> +
> +	return ERR_PTR(-ENODATA);
> +}
> +
> +static struct usb_power_delivery **tcpm_pd_get(struct typec_port *p)
> +{
> +	struct tcpm_port *port = typec_get_drvdata(p);
> +
> +	return port->pds;
> +}
> +
> +static int tcpm_pd_set(struct typec_port *p, struct usb_power_delivery *pd)
> +{
> +	struct tcpm_port *port = typec_get_drvdata(p);
> +	struct pd_data *data;
> +	int i, ret = 0;
> +
> +	mutex_lock(&port->lock);
> +
> +	if (port->selected_pd == pd)
> +		goto unlock;
> +
> +	data = tcpm_find_pd_data(port, pd);
> +	if (IS_ERR(data)) {
> +		ret = PTR_ERR(data);
> +		goto unlock;
> +	}
> +
> +	if (data->sink_desc.pdo[0]) {
> +		for (i = 0; i < PDO_MAX_OBJECTS && data->sink_desc.pdo[i]; i++)
> +			port->snk_pdo[i] = data->sink_desc.pdo[i];
> +		port->nr_snk_pdo = i + 1;
> +		port->operating_snk_mw = data->operating_snk_mw;
> +	}
> +
> +	if (data->source_desc.pdo[0]) {
> +		for (i = 0; i < PDO_MAX_OBJECTS && data->source_desc.pdo[i]; i++)
> +			port->snk_pdo[i] = data->source_desc.pdo[i];
> +		port->nr_src_pdo = i + 1;
> +	}
> +
> +	switch (port->state) {
> +	case SRC_UNATTACHED:
> +	case SRC_ATTACH_WAIT:
> +	case SRC_TRYWAIT:
> +		tcpm_set_cc(port, tcpm_rp_cc(port));
> +		break;
> +	case SRC_SEND_CAPABILITIES:
> +	case SRC_SEND_CAPABILITIES_TIMEOUT:
> +	case SRC_NEGOTIATE_CAPABILITIES:
> +	case SRC_READY:
> +	case SRC_WAIT_NEW_CAPABILITIES:
> +		port->caps_count = 0;
> +		port->upcoming_state = SRC_SEND_CAPABILITIES;
> +		ret = tcpm_ams_start(port, POWER_NEGOTIATION);
> +		if (ret == -EAGAIN) {
> +			port->upcoming_state = INVALID_STATE;
> +			goto unlock;
> +		}
> +		break;
> +	case SNK_NEGOTIATE_CAPABILITIES:
> +	case SNK_NEGOTIATE_PPS_CAPABILITIES:
> +	case SNK_READY:
> +	case SNK_TRANSITION_SINK:
> +	case SNK_TRANSITION_SINK_VBUS:
> +		if (port->pps_data.active)
> +			port->upcoming_state = SNK_NEGOTIATE_PPS_CAPABILITIES;
> +		else if (port->pd_capable)
> +			port->upcoming_state = SNK_NEGOTIATE_CAPABILITIES;
> +		else
> +			break;
> +
> +		port->update_sink_caps = true;
> +
> +		ret = tcpm_ams_start(port, POWER_NEGOTIATION);
> +		if (ret == -EAGAIN) {
> +			port->upcoming_state = INVALID_STATE;
> +			goto unlock;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	port->port_source_caps = data->source_cap;
> +	port->port_sink_caps = data->sink_cap;
> +	port->selected_pd = pd;
> +unlock:
> +	mutex_unlock(&port->lock);
> +	return ret;
> +}
> +
>  static const struct typec_operations tcpm_ops = {
>  	.try_role = tcpm_try_role,
>  	.dr_set = tcpm_dr_set,
>  	.pr_set = tcpm_pr_set,
>  	.vconn_set = tcpm_vconn_set,
> -	.port_type_set = tcpm_port_type_set
> +	.port_type_set = tcpm_port_type_set,
> +	.pd_get = tcpm_pd_get,
> +	.pd_set = tcpm_pd_set
>  };
>  
>  void tcpm_tcpc_reset(struct tcpm_port *port)
> @@ -6078,58 +6192,63 @@ EXPORT_SYMBOL_GPL(tcpm_tcpc_reset);
>  
>  static void tcpm_port_unregister_pd(struct tcpm_port *port)
>  {
> -	usb_power_delivery_unregister_capabilities(port->port_sink_caps);
> +	int i;
> +
>  	port->port_sink_caps = NULL;
> -	usb_power_delivery_unregister_capabilities(port->port_source_caps);
>  	port->port_source_caps = NULL;
> -	usb_power_delivery_unregister(port->pd);
> -	port->pd = NULL;
> +	for (i = 0; i < port->pd_count; i++) {
> +		usb_power_delivery_unregister_capabilities(port->pd_list[i]->sink_cap);
> +		kfree(port->pd_list[i]->sink_cap);
> +		usb_power_delivery_unregister_capabilities(port->pd_list[i]->source_cap);
> +		kfree(port->pd_list[i]->source_cap);
> +		devm_kfree(port->dev, port->pd_list[i]);
> +		port->pd_list[i] = NULL;
> +		usb_power_delivery_unregister(port->pds[i]);
> +		port->pds[i] = NULL;
> +	}
>  }
>  
>  static int tcpm_port_register_pd(struct tcpm_port *port)
>  {
>  	struct usb_power_delivery_desc desc = { port->typec_caps.pd_revision };
> -	struct usb_power_delivery_capabilities_desc caps = { };
>  	struct usb_power_delivery_capabilities *cap;
> -	int ret;
> +	int ret, i;
>  
>  	if (!port->nr_src_pdo && !port->nr_snk_pdo)
>  		return 0;
>  
> -	port->pd = usb_power_delivery_register(port->dev, &desc);
> -	if (IS_ERR(port->pd)) {
> -		ret = PTR_ERR(port->pd);
> -		goto err_unregister;
> -	}
> -
> -	if (port->nr_src_pdo) {
> -		memcpy_and_pad(caps.pdo, sizeof(caps.pdo), port->src_pdo,
> -			       port->nr_src_pdo * sizeof(u32), 0);
> -		caps.role = TYPEC_SOURCE;
> -
> -		cap = usb_power_delivery_register_capabilities(port->pd, &caps);
> -		if (IS_ERR(cap)) {
> -			ret = PTR_ERR(cap);
> +	for (i = 0; i < port->pd_count; i++) {
> +		port->pds[i] = usb_power_delivery_register(port->dev, &desc);
> +		if (IS_ERR(port->pds[i])) {
> +			ret = PTR_ERR(port->pds[i]);
>  			goto err_unregister;
>  		}
> -
> -		port->port_source_caps = cap;
> -	}
> -
> -	if (port->nr_snk_pdo) {
> -		memcpy_and_pad(caps.pdo, sizeof(caps.pdo), port->snk_pdo,
> -			       port->nr_snk_pdo * sizeof(u32), 0);
> -		caps.role = TYPEC_SINK;
> -
> -		cap = usb_power_delivery_register_capabilities(port->pd, &caps);
> -		if (IS_ERR(cap)) {
> -			ret = PTR_ERR(cap);
> -			goto err_unregister;
> +		port->pd_list[i]->pd = port->pds[i];
> +
> +		if (port->pd_list[i]->source_desc.pdo[0]) {
> +			cap = usb_power_delivery_register_capabilities(port->pds[i],
> +								&port->pd_list[i]->source_desc);
> +			if (IS_ERR(cap)) {
> +				ret = PTR_ERR(cap);
> +				goto err_unregister;
> +			}
> +			port->pd_list[i]->source_cap = cap;
>  		}
>  
> -		port->port_sink_caps = cap;
> +		if (port->pd_list[i]->sink_desc.pdo[0]) {
> +			cap = usb_power_delivery_register_capabilities(port->pds[i],
> +								&port->pd_list[i]->sink_desc);
> +			if (IS_ERR(cap)) {
> +				ret = PTR_ERR(cap);
> +				goto err_unregister;
> +			}
> +			port->pd_list[i]->sink_cap = cap;
> +		}
>  	}
>  
> +	port->port_source_caps = port->pd_list[0]->source_cap;
> +	port->port_sink_caps = port->pd_list[0]->sink_cap;
> +	port->selected_pd = port->pds[0];
>  	return 0;
>  
>  err_unregister:
> @@ -6138,12 +6257,14 @@ static int tcpm_port_register_pd(struct tcpm_port *port)
>  	return ret;
>  }
>  
> -static int tcpm_fw_get_caps(struct tcpm_port *port,
> -			    struct fwnode_handle *fwnode)
> +static int tcpm_fw_get_caps(struct tcpm_port *port, struct fwnode_handle *fwnode)
>  {
> +	struct fwnode_handle *capabilities, *child, *caps = NULL;
> +	unsigned int nr_src_pdo, nr_snk_pdo;
>  	const char *opmode_str;
> -	int ret;
> -	u32 mw, frs_current;
> +	u32 *src_pdo, *snk_pdo;
> +	u32 uw, frs_current;
> +	int ret = 0, i;
>  
>  	if (!fwnode)
>  		return -EINVAL;
> @@ -6163,28 +6284,10 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
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
> @@ -6192,45 +6295,150 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
>  		if (ret < 0)
>  			return ret;
>  		port->src_rp = tcpm_pwr_opmode_to_rp(ret);
> -	}
> -
> -	if (port->port_type == TYPEC_PORT_SRC)
> -		return 0;
> -
> -sink:
> -	port->self_powered = fwnode_property_read_bool(fwnode, "self-powered");
> -
> -	if (!port->pd_supported)
>  		return 0;
> +	}
>  
> -	/* Get sink pdos */
> -	ret = fwnode_property_count_u32(fwnode, "sink-pdos");
> -	if (ret <= 0)
> -		return -EINVAL;
> -
> -	port->nr_snk_pdo = min(ret, PDO_MAX_OBJECTS);
> -	ret = fwnode_property_read_u32_array(fwnode, "sink-pdos",
> -					     port->snk_pdo, port->nr_snk_pdo);
> -	if ((ret < 0) || tcpm_validate_caps(port, port->snk_pdo,
> -					    port->nr_snk_pdo))
> -		return -EINVAL;
> -
> -	if (fwnode_property_read_u32(fwnode, "op-sink-microwatt", &mw) < 0)
> -		return -EINVAL;
> -	port->operating_snk_mw = mw / 1000;
> +	/* The following code are applicable to pd-capable ports, i.e. pd_supported is true. */
>  
>  	/* FRS can only be supported by DRP ports */
>  	if (port->port_type == TYPEC_PORT_DRP) {
>  		ret = fwnode_property_read_u32(fwnode, "new-source-frs-typec-current",
>  					       &frs_current);
> -		if (ret >= 0 && frs_current <= FRS_5V_3A)
> +		if (!ret && frs_current <= FRS_5V_3A)
>  			port->new_source_frs_current = frs_current;
> +
> +		if (ret)
> +			ret = 0;
>  	}
>  
> +	/* For the backward compatibility, "capabilities" node is optional. */
> +	capabilities = fwnode_get_named_child_node(fwnode, "capabilities");
> +	if (!capabilities) {
> +		port->pd_count = 1;
> +	} else {
> +		fwnode_for_each_child_node(capabilities, child)
> +			port->pd_count++;
> +
> +		if (!port->pd_count) {
> +			ret = -ENODATA;
> +			goto put_capabilities;
> +		}
> +	}
> +
> +	port->pds = devm_kcalloc(port->dev, port->pd_count, sizeof(struct usb_power_delivery *),
> +				 GFP_KERNEL);
> +	if (!port->pds) {
> +		ret = -ENOMEM;
> +		goto put_capabilities;
> +	}
> +
> +	port->pd_list = devm_kcalloc(port->dev, port->pd_count, sizeof(struct pd_data *),
> +				     GFP_KERNEL);
> +	if (!port->pd_list) {
> +		ret = -ENOMEM;
> +		goto put_capabilities;
> +	}
> +
> +	for (i = 0; i < port->pd_count; i++) {
> +		port->pd_list[i] = devm_kzalloc(port->dev, sizeof(struct pd_data), GFP_KERNEL);
> +		if (!port->pd_list[i]) {
> +			ret = -ENOMEM;
> +			goto put_capabilities;
> +		}
> +
> +		src_pdo = port->pd_list[i]->source_desc.pdo;
> +		port->pd_list[i]->source_desc.role = TYPEC_SOURCE;
> +		snk_pdo = port->pd_list[i]->sink_desc.pdo;
> +		port->pd_list[i]->sink_desc.role = TYPEC_SINK;
> +
> +		/* If "capabilities" is NULL, fall back to single pd cap population. */
> +		if (!capabilities)
> +			caps = fwnode;
> +		else
> +			caps = fwnode_get_next_child_node(capabilities, caps);
> +
> +		if (port->port_type != TYPEC_PORT_SNK) {
> +			ret = fwnode_property_count_u32(caps, "source-pdos");
> +			if (ret == 0) {
> +				ret = -EINVAL;
> +				goto put_caps;
> +			}
> +			if (ret < 0)
> +				goto put_caps;
> +
> +			nr_src_pdo = min(ret, PDO_MAX_OBJECTS);
> +			ret = fwnode_property_read_u32_array(caps, "source-pdos", src_pdo,
> +							     nr_src_pdo);
> +			if (ret)
> +				goto put_caps;
> +
> +			ret = tcpm_validate_caps(port, src_pdo, nr_src_pdo);
> +			if (ret)
> +				goto put_caps;
> +
> +			if (i == 0) {
> +				port->nr_src_pdo = nr_src_pdo;
> +				memcpy_and_pad(port->src_pdo, sizeof(u32) * PDO_MAX_OBJECTS,
> +					       port->pd_list[0]->source_desc.pdo,
> +					       sizeof(u32) * nr_src_pdo,
> +					       0);
> +			}
> +		}
> +
> +		if (port->port_type != TYPEC_PORT_SRC) {
> +			ret = fwnode_property_count_u32(caps, "sink-pdos");
> +			if (ret == 0) {
> +				ret = -EINVAL;
> +				goto put_caps;
> +			}
> +
> +			if (ret < 0)
> +				goto put_caps;
> +
> +			nr_snk_pdo = min(ret, PDO_MAX_OBJECTS);
> +			ret = fwnode_property_read_u32_array(caps, "sink-pdos", snk_pdo,
> +							     nr_snk_pdo);
> +			if (ret)
> +				goto put_caps;
> +
> +			ret = tcpm_validate_caps(port, snk_pdo, nr_snk_pdo);
> +			if (ret)
> +				goto put_caps;
> +
> +			if (fwnode_property_read_u32(caps, "op-sink-microwatt", &uw) < 0) {
> +				ret = -EINVAL;
> +				goto put_caps;
> +			}
> +
> +			port->pd_list[i]->operating_snk_mw = uw / 1000;
> +
> +			if (i == 0) {
> +				port->nr_snk_pdo = nr_snk_pdo;
> +				memcpy_and_pad(port->snk_pdo, sizeof(u32) * PDO_MAX_OBJECTS,
> +					       port->pd_list[0]->sink_desc.pdo,
> +					       sizeof(u32) * nr_snk_pdo,
> +					       0);
> +				port->operating_snk_mw = port->pd_list[0]->operating_snk_mw;
> +			}
> +		}
> +	}
> +
> +put_caps:
> +	if (caps != fwnode)
> +		fwnode_handle_put(caps);
> +put_capabilities:
> +	fwnode_handle_put(capabilities);
> +	return ret;
> +}
> +
> +static int tcpm_fw_get_snk_vdos(struct tcpm_port *port, struct fwnode_handle *fwnode)
> +{
> +	int ret;
> +
>  	/* sink-vdos is optional */
>  	ret = fwnode_property_count_u32(fwnode, "sink-vdos");
>  	if (ret < 0)
> -		ret = 0;
> +		return 0;
>  
>  	port->nr_snk_vdo = min(ret, VDO_MAX_OBJECTS);
>  	if (port->nr_snk_vdo) {
> @@ -6596,12 +6804,14 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
>  	tcpm_debugfs_init(port);
>  
>  	err = tcpm_fw_get_caps(port, tcpc->fwnode);
> +	if (err < 0)
> +		goto out_destroy_wq;
> +	err = tcpm_fw_get_snk_vdos(port, tcpc->fwnode);
>  	if (err < 0)
>  		goto out_destroy_wq;
>  
>  	port->try_role = port->typec_caps.prefer_role;
>  
> -	port->typec_caps.fwnode = tcpc->fwnode;
>  	port->typec_caps.revision = 0x0120;	/* Type-C spec release 1.2 */
>  	port->typec_caps.pd_revision = 0x0300;	/* USB-PD spec release 3.0 */
>  	port->typec_caps.svdm_version = SVDM_VER_2_0;
> @@ -6610,7 +6820,6 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
>  	port->typec_caps.orientation_aware = 1;
>  
>  	port->partner_desc.identity = &port->partner_ident;
> -	port->port_type = port->typec_caps.type;
>  
>  	port->role_sw = usb_role_switch_get(port->dev);
>  	if (!port->role_sw)
> @@ -6629,7 +6838,7 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
>  	if (err)
>  		goto out_role_sw_put;
>  
> -	port->typec_caps.pd = port->pd;
> +	port->typec_caps.pd = port->pds[0];
>  
>  	port->typec_port = typec_register_port(port->dev, &port->typec_caps);
>  	if (IS_ERR(port->typec_port)) {
> -- 
> 2.43.0.472.g3155946c3a-goog

-- 
heikki

