Return-Path: <linux-kernel+bounces-25777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E93E82D5A3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEB681F2105B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E98C2C7;
	Mon, 15 Jan 2024 09:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TqVCdmmG"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49885DF41;
	Mon, 15 Jan 2024 09:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705310098; x=1736846098;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fzbsGcb8zWMmSPq/aZIB0x9EMwH5csTzzSIv8HghDNI=;
  b=TqVCdmmGLEkpQ83kBVwA4oY3iHWlKbiEkDo29ywmSnC1b9n4yzE4JUOQ
   NKFZuaFggG/DkcI+p7VGXS4yyvtmC665793qhRBY/mjNwwGYOFlLuJhHI
   fnophYH0rlBfippWm/MzoitFs5pCCH78z35ZUxR0EDtdhU0wpYxfJ/+RK
   O8dYuXfjAFvTWvRDhRBO2jUXSET9g71siJyuMwbtvD5BlHrQ5URGuia1K
   ywvfEYnEGJl7GWmv6YkBJBgOz3f6KdtAXvT1o3TeZwHenz8DtB7Ljt/v0
   88XIPMhKwvX9FkMsROITNP6EMbTKEPh1yckJ32TrrJUdT/zRwYc3oAYjv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="398435313"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; 
   d="scan'208";a="398435313"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 01:14:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="1114884973"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; 
   d="scan'208";a="1114884973"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga005.fm.intel.com with SMTP; 15 Jan 2024 01:14:54 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 15 Jan 2024 11:14:53 +0200
Date: Mon, 15 Jan 2024 11:14:53 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: RD Babiera <rdbabiera@google.com>
Cc: linux@roeck-us.net, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	badhri@google.com, bryan.odonoghue@linaro.org, agross@kernel.org,
	andersson@kernel.org, konrad.dybcio@linaro.org
Subject: Re: [PATCH v3 10/12] usb: typec: tcpm: add discover svids and
 discover modes support for sop'
Message-ID: <ZaT3jaqQiueYO2s+@kuha.fi.intel.com>
References: <20240108191620.987785-14-rdbabiera@google.com>
 <20240108191620.987785-24-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108191620.987785-24-rdbabiera@google.com>

On Mon, Jan 08, 2024 at 07:16:23PM +0000, RD Babiera wrote:
> Adds Discover SVIDs and Discover Modes support for SOP' and Alt Mode
> SVDM support over SOP'. tcpm_port adds separate Alt Mode data for SOP'.
> 
> svdm_consume_svids and svdm_consume_modes take the received SVDM's SOP*
> type to store svids/modes separately, and tcpm_register_plug_altmodes
> registers the active cable's alt modes.
> 
> In tcpm_pd_svdm, the port will send Discover SVIDs to SOP' after Discover
> Modes on SOP if the connected cable is an active cable. Discover Modes on
> SOP' is sent following Discover SVIDs on SOP. Registering partner alt modes
> is delayed when an active cable is present until Discover Modes completes
> on SOP', or if the Discover SVIDs/Discover Modes request on SOP' encounters
> a transmission error.
> 
> Signed-off-by: RD Babiera <rdbabiera@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes since v2:
> * v2 replaced code that unregistered partner altmodes instead of adding,
>   readded to tcpm_unregister_altmodes.
> 
> Changes since v1:
> * Changes to tcpm_altmode_enter/exit/vdm are moved to next patch
> * adev_action changes are moved to next patch
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 161 +++++++++++++++++++++++++++++-----
>  1 file changed, 140 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 1ce525c8f97c..d16edf112858 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -477,7 +477,9 @@ struct tcpm_port {
>  
>  	/* Alternate mode data */
>  	struct pd_mode_data mode_data;
> +	struct pd_mode_data mode_data_prime;
>  	struct typec_altmode *partner_altmode[ALTMODE_DISCOVERY_MAX];
> +	struct typec_altmode *plug_prime_altmode[ALTMODE_DISCOVERY_MAX];
>  	struct typec_altmode *port_altmode[ALTMODE_DISCOVERY_MAX];
>  
>  	/* Deadline in jiffies to exit src_try_wait state */
> @@ -1636,9 +1638,11 @@ static void svdm_consume_identity_sop_prime(struct tcpm_port *port, const u32 *p
>  	}
>  }
>  
> -static bool svdm_consume_svids(struct tcpm_port *port, const u32 *p, int cnt)
> +static bool svdm_consume_svids(struct tcpm_port *port, const u32 *p, int cnt,
> +			       enum tcpm_transmit_type rx_sop_type)
>  {
> -	struct pd_mode_data *pmdata = &port->mode_data;
> +	struct pd_mode_data *pmdata = rx_sop_type == TCPC_TX_SOP_PRIME ?
> +				      &port->mode_data_prime : &port->mode_data;
>  	int i;
>  
>  	for (i = 1; i < cnt; i++) {
> @@ -1684,14 +1688,29 @@ static bool svdm_consume_svids(struct tcpm_port *port, const u32 *p, int cnt)
>  	return false;
>  }
>  
> -static void svdm_consume_modes(struct tcpm_port *port, const u32 *p, int cnt)
> +static void svdm_consume_modes(struct tcpm_port *port, const u32 *p, int cnt,
> +			       enum tcpm_transmit_type rx_sop_type)
>  {
>  	struct pd_mode_data *pmdata = &port->mode_data;
>  	struct typec_altmode_desc *paltmode;
>  	int i;
>  
> -	if (pmdata->altmodes >= ARRAY_SIZE(port->partner_altmode)) {
> -		/* Already logged in svdm_consume_svids() */
> +	switch (rx_sop_type) {
> +	case TCPC_TX_SOP_PRIME:
> +		pmdata = &port->mode_data_prime;
> +		if (pmdata->altmodes >= ARRAY_SIZE(port->plug_prime_altmode)) {
> +			/* Already logged in svdm_consume_svids() */
> +			return;
> +		}
> +		break;
> +	case TCPC_TX_SOP:
> +		pmdata = &port->mode_data;
> +		if (pmdata->altmodes >= ARRAY_SIZE(port->partner_altmode)) {
> +			/* Already logged in svdm_consume_svids() */
> +			return;
> +		}
> +		break;
> +	default:
>  		return;
>  	}
>  
> @@ -1729,7 +1748,28 @@ static void tcpm_register_partner_altmodes(struct tcpm_port *port)
>  	}
>  }
>  
> +static void tcpm_register_plug_altmodes(struct tcpm_port *port)
> +{
> +	struct pd_mode_data *modep = &port->mode_data_prime;
> +	struct typec_altmode *altmode;
> +	int i;
> +
> +	typec_plug_set_num_altmodes(port->plug_prime, modep->altmodes);
> +
> +	for (i = 0; i < modep->altmodes; i++) {
> +		altmode = typec_plug_register_altmode(port->plug_prime,
> +						&modep->altmode_desc[i]);
> +		if (IS_ERR(altmode)) {
> +			tcpm_log(port, "Failed to register plug SVID 0x%04x",
> +				 modep->altmode_desc[i].svid);
> +			altmode = NULL;
> +		}
> +		port->plug_prime_altmode[i] = altmode;
> +	}
> +}
> +
>  #define supports_modal(port)	PD_IDH_MODAL_SUPP((port)->partner_ident.id_header)
> +#define supports_modal_cable(port)     PD_IDH_MODAL_SUPP((port)->cable_ident.id_header)
>  #define supports_host(port)    PD_IDH_HOST_SUPP((port->partner_ident.id_header))
>  
>  /*
> @@ -1807,6 +1847,15 @@ static bool tcpm_attempt_vconn_swap_discovery(struct tcpm_port *port)
>  	return false;
>  }
>  
> +
> +static bool tcpm_cable_vdm_supported(struct tcpm_port *port)
> +{
> +	return !IS_ERR_OR_NULL(port->cable) &&
> +	       typec_cable_is_active(port->cable) &&
> +	       supports_modal_cable(port) &&
> +	       tcpm_can_communicate_sop_prime(port);
> +}
> +
>  static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  			const u32 *p, int cnt, u32 *response,
>  			enum adev_actions *adev_action,
> @@ -1814,8 +1863,8 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  			enum tcpm_transmit_type *response_tx_sop_type)
>  {
>  	struct typec_port *typec = port->typec_port;
> -	struct typec_altmode *pdev;
> -	struct pd_mode_data *modep;
> +	struct typec_altmode *pdev, *pdev_prime;
> +	struct pd_mode_data *modep, *modep_prime;
>  	int svdm_version;
>  	int rlen = 0;
>  	int cmd_type;
> @@ -1836,6 +1885,11 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  
>  	switch (rx_sop_type) {
>  	case TCPC_TX_SOP_PRIME:
> +		modep_prime = &port->mode_data_prime;
> +		pdev_prime = typec_match_altmode(port->plug_prime_altmode,
> +						 ALTMODE_DISCOVERY_MAX,
> +						 PD_VDO_VID(p[0]),
> +						 PD_VDO_OPOS(p[0]));
>  		if (!IS_ERR_OR_NULL(port->cable)) {
>  			svdm_version = typec_get_cable_svdm_version(typec);
>  			if (PD_VDO_SVDM_VER(p[0]) < svdm_version)
> @@ -1843,11 +1897,21 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  		}
>  		break;
>  	case TCPC_TX_SOP:
> +		modep = &port->mode_data;
> +		pdev = typec_match_altmode(port->partner_altmode,
> +					   ALTMODE_DISCOVERY_MAX,
> +					   PD_VDO_VID(p[0]),
> +					   PD_VDO_OPOS(p[0]));
>  		svdm_version = typec_get_negotiated_svdm_version(typec);
>  		if (svdm_version < 0)
>  			return 0;
>  		break;
>  	default:
> +		modep = &port->mode_data;
> +		pdev = typec_match_altmode(port->partner_altmode,
> +					   ALTMODE_DISCOVERY_MAX,
> +					   PD_VDO_VID(p[0]),
> +					   PD_VDO_OPOS(p[0]));
>  		svdm_version = typec_get_negotiated_svdm_version(typec);
>  		if (svdm_version < 0)
>  			return 0;
> @@ -1939,6 +2003,9 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  		 * SOP'		Discover Identity
>  		 * SOP		Discover SVIDs
>  		 *		Discover Modes
> +		 * (Active Cables)
> +		 * SOP'		Discover SVIDs
> +		 *		Discover Modes
>  		 *
>  		 * Perform Discover SOP' if the port can communicate with cable
>  		 * plug.
> @@ -2018,26 +2085,62 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  			}
>  			break;
>  		case CMD_DISCOVER_SVID:
> +			*response_tx_sop_type = rx_sop_type;
>  			/* 6.4.4.3.2 */
> -			if (svdm_consume_svids(port, p, cnt)) {
> +			if (svdm_consume_svids(port, p, cnt, rx_sop_type)) {
>  				response[0] = VDO(USB_SID_PD, 1, svdm_version, CMD_DISCOVER_SVID);
>  				rlen = 1;
> -			} else if (modep->nsvids && supports_modal(port)) {
> -				response[0] = VDO(modep->svids[0], 1, svdm_version,
> -						  CMD_DISCOVER_MODES);
> -				rlen = 1;
> +			} else {
> +				if (rx_sop_type == TCPC_TX_SOP) {
> +					if (modep->nsvids && supports_modal(port)) {
> +						response[0] = VDO(modep->svids[0], 1, svdm_version,
> +								CMD_DISCOVER_MODES);
> +						rlen = 1;
> +					}
> +				} else if (rx_sop_type == TCPC_TX_SOP_PRIME) {
> +					if (modep_prime->nsvids) {
> +						response[0] = VDO(modep_prime->svids[0], 1,
> +								  svdm_version, CMD_DISCOVER_MODES);
> +						rlen = 1;
> +					}
> +				}
>  			}
>  			break;
>  		case CMD_DISCOVER_MODES:
> -			/* 6.4.4.3.3 */
> -			svdm_consume_modes(port, p, cnt);
> -			modep->svid_index++;
> -			if (modep->svid_index < modep->nsvids) {
> -				u16 svid = modep->svids[modep->svid_index];
> -				response[0] = VDO(svid, 1, svdm_version, CMD_DISCOVER_MODES);
> -				rlen = 1;
> -			} else {
> -				tcpm_register_partner_altmodes(port);
> +			if (rx_sop_type == TCPC_TX_SOP) {
> +				/* 6.4.4.3.3 */
> +				svdm_consume_modes(port, p, cnt, rx_sop_type);
> +				modep->svid_index++;
> +				if (modep->svid_index < modep->nsvids) {
> +					u16 svid = modep->svids[modep->svid_index];
> +					*response_tx_sop_type = TCPC_TX_SOP;
> +					response[0] = VDO(svid, 1, svdm_version,
> +							  CMD_DISCOVER_MODES);
> +					rlen = 1;
> +				} else if (tcpm_cable_vdm_supported(port)) {
> +					*response_tx_sop_type = TCPC_TX_SOP_PRIME;
> +					response[0] = VDO(USB_SID_PD, 1,
> +							  typec_get_cable_svdm_version(typec),
> +							  CMD_DISCOVER_SVID);
> +					rlen = 1;
> +				} else {
> +					tcpm_register_partner_altmodes(port);
> +				}
> +			} else if (rx_sop_type == TCPC_TX_SOP_PRIME) {
> +				/* 6.4.4.3.3 */
> +				svdm_consume_modes(port, p, cnt, rx_sop_type);
> +				modep_prime->svid_index++;
> +				if (modep_prime->svid_index < modep_prime->nsvids) {
> +					u16 svid = modep_prime->svids[modep_prime->svid_index];
> +					*response_tx_sop_type = TCPC_TX_SOP_PRIME;
> +					response[0] = VDO(svid, 1,
> +							  typec_get_cable_svdm_version(typec),
> +							  CMD_DISCOVER_MODES);
> +					rlen = 1;
> +				} else {
> +					tcpm_register_plug_altmodes(port);
> +					tcpm_register_partner_altmodes(port);
> +				}
>  			}
>  			break;
>  		case CMD_ENTER_MODE:
> @@ -2418,6 +2521,16 @@ static void vdm_run_state_machine(struct tcpm_port *port)
>  				tcpm_queue_vdm(port, response[0], &response[1],
>  					       0, TCPC_TX_SOP);
>  				break;
> +			/*
> +			 * If Discover SVIDs or Discover Modes fail, then
> +			 * proceed with Alt Mode discovery process on SOP.
> +			 */
> +			case CMD_DISCOVER_SVID:
> +				tcpm_register_partner_altmodes(port);
> +				break;
> +			case CMD_DISCOVER_MODES:
> +				tcpm_register_partner_altmodes(port);
> +				break;
>  			default:
>  				break;
>  			}
> @@ -4124,14 +4237,20 @@ static void tcpm_typec_disconnect(struct tcpm_port *port)
>  static void tcpm_unregister_altmodes(struct tcpm_port *port)
>  {
>  	struct pd_mode_data *modep = &port->mode_data;
> +	struct pd_mode_data *modep_prime = &port->mode_data_prime;
>  	int i;
>  
>  	for (i = 0; i < modep->altmodes; i++) {
>  		typec_unregister_altmode(port->partner_altmode[i]);
>  		port->partner_altmode[i] = NULL;
>  	}
> +	for (i = 0; i < modep_prime->altmodes; i++) {
> +		typec_unregister_altmode(port->plug_prime_altmode[i]);
> +		port->plug_prime_altmode[i] = NULL;
> +	}
>  
>  	memset(modep, 0, sizeof(*modep));
> +	memset(modep_prime, 0, sizeof(*modep_prime));
>  }
>  
>  static void tcpm_set_partner_usb_comm_capable(struct tcpm_port *port, bool capable)
> -- 
> 2.43.0.472.g3155946c3a-goog

-- 
heikki

