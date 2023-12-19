Return-Path: <linux-kernel+bounces-5335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F6E818982
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE0411F25083
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3C41B283;
	Tue, 19 Dec 2023 14:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RCAlpybO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3B21F93E;
	Tue, 19 Dec 2023 14:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702995168; x=1734531168;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bNDhJx+a1SdOPTC/jyiXoS3pJkVH+RObqegJrABBZG8=;
  b=RCAlpybOefEkqoNyoNlDNPgqh9chFWHIgdD1RP6dvQHh29CGVI3DDJCR
   UXLgjFrKw5IMCDJ4Ltr54xDsygiXq/f135etAUrdZvUkVOggSfF578SPo
   gD0FYqFPH5erBIQM5Cv0BSoh3YFtxYT5MtLC8Hh5jHaowxYFBC/vtO3sm
   0hULiQaSPO/w0hm7m1aAAIeb9n28TlWth1G4gLLzRr+fd/7lFzM0w6OyA
   7iLJJM4J2AArKTIfXmGsRMF5j7EThgax/I4q0hivyEBjRZDkLLzKG5Nw+
   HpbFJkQQxK6WPxQI6QTYRwOa+2k68wAYb2Lfj1oqws1uG3jHeAqAa0ykp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="386087182"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="386087182"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 06:12:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="725745677"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="725745677"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orsmga003.jf.intel.com with SMTP; 19 Dec 2023 06:12:43 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 19 Dec 2023 16:12:42 +0200
Date: Tue, 19 Dec 2023 16:12:42 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: RD Babiera <rdbabiera@google.com>
Cc: linux@roeck-us.net, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	badhri@google.com, bryan.odonoghue@linaro.org, agross@kernel.org,
	andersson@kernel.org, konrad.dybcio@linaro.org
Subject: Re: [PATCH v2 06/12] usb: typec: tcpm: add control message support
 to sop'
Message-ID: <ZYGkQSfPVP2fnQP9@kuha.fi.intel.com>
References: <20231214230850.379863-14-rdbabiera@google.com>
 <20231214230850.379863-20-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214230850.379863-20-rdbabiera@google.com>

On Thu, Dec 14, 2023 at 11:08:50PM +0000, RD Babiera wrote:
> Add tx_sop_type to tcpm_pd_send_control and rx_sop_type to
> tcpm_pd_ctrl_request. TCPC_TX_SOP is added to all pd_send_control calls,
> but TCPC_TX_SOP_PRIME is added to pd_send_control for a SOFT_RESET message
> sent after a Vconn swap that makes the Port the Vconn source. Likewise,
> tcpm_pd_ctrl_request resets the proper protocol layer depending on
> rx_sop_type for SOFT_RESET.
> 
> VCONN_SWAP_TURN_ON_VCONN now moves to a new state,
> VCONN_SWAP_SEND_SOFT_RESET. This state sends SOFT_RESET over SOP' before
> transitioning to the ready state if applicable. It transitions after
> PD_T_VCONN_STABLE, definied in pd.h as the time required for Vconn to be
> on before transmitting messages.
> 
> Signed-off-by: RD Babiera <rdbabiera@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 159 ++++++++++++++++++++++++----------
>  include/linux/usb/pd.h        |   1 +
>  2 files changed, 115 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index bc6c5f04e62f..c1e1fd6bd60d 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -108,6 +108,7 @@
>  	S(VCONN_SWAP_WAIT_FOR_VCONN),		\
>  	S(VCONN_SWAP_TURN_ON_VCONN),		\
>  	S(VCONN_SWAP_TURN_OFF_VCONN),		\
> +	S(VCONN_SWAP_SEND_SOFT_RESET),		\
>  						\
>  	S(FR_SWAP_SEND),			\
>  	S(FR_SWAP_SEND_TIMEOUT),		\
> @@ -2388,7 +2389,8 @@ static inline enum tcpm_state ready_state(struct tcpm_port *port)
>  }
>  
>  static int tcpm_pd_send_control(struct tcpm_port *port,
> -				enum pd_ctrl_msg_type type);
> +				enum pd_ctrl_msg_type type,
> +				enum tcpm_transmit_type tx_sop_type);
>  
>  static void tcpm_handle_alert(struct tcpm_port *port, const __le32 *payload,
>  			      int cnt)
> @@ -2742,10 +2744,12 @@ static void tcpm_pps_complete(struct tcpm_port *port, int result)
>  }
>  
>  static void tcpm_pd_ctrl_request(struct tcpm_port *port,
> -				 const struct pd_message *msg)
> +				 const struct pd_message *msg,
> +				 enum tcpm_transmit_type rx_sop_type)
>  {
>  	enum pd_ctrl_msg_type type = pd_header_type_le(msg->header);
>  	enum tcpm_state next_state;
> +	unsigned int rev = pd_header_rev_le(msg->header);
>  
>  	/*
>  	 * Stop VDM state machine if interrupted by other Messages while NOT_SUPP is allowed in
> @@ -2910,6 +2914,16 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
>  		case SOFT_RESET_SEND:
>  			if (port->ams == SOFT_RESET_AMS)
>  				tcpm_ams_finish(port);
> +			/*
> +			 * SOP' Soft Reset is done after Vconn Swap,
> +			 * which returns to ready state
> +			 */
> +			if (rx_sop_type == TCPC_TX_SOP_PRIME) {
> +				if (rev < port->negotiated_rev_prime)
> +					port->negotiated_rev_prime = rev;
> +				tcpm_set_state(port, ready_state(port), 0);
> +				break;
> +			}
>  			if (port->pwr_role == TYPEC_SOURCE) {
>  				port->upcoming_state = SRC_SEND_CAPABILITIES;
>  				tcpm_ams_start(port, POWER_NEGOTIATION);
> @@ -3109,8 +3123,7 @@ static void tcpm_pd_rx_handler(struct kthread_work *work)
>  			if (msgid == port->rx_msgid_prime)
>  				goto done;
>  			port->rx_msgid_prime = msgid;
> -			/* Ignore SOP' for now */
> -			goto done;
> +			break;
>  		case TCPC_TX_SOP:
>  			if (msgid == port->rx_msgid &&
>  			    type != PD_CTRL_SOFT_RESET)
> @@ -3140,7 +3153,7 @@ static void tcpm_pd_rx_handler(struct kthread_work *work)
>  			else if (cnt)
>  				tcpm_pd_data_request(port, msg);
>  			else
> -				tcpm_pd_ctrl_request(port, msg);
> +				tcpm_pd_ctrl_request(port, msg, rx_sop_type);
>  		}
>  	}
>  
> @@ -3167,17 +3180,40 @@ void tcpm_pd_receive(struct tcpm_port *port, const struct pd_message *msg,
>  EXPORT_SYMBOL_GPL(tcpm_pd_receive);
>  
>  static int tcpm_pd_send_control(struct tcpm_port *port,
> -				enum pd_ctrl_msg_type type)
> +				enum pd_ctrl_msg_type type,
> +				enum tcpm_transmit_type tx_sop_type)
>  {
>  	struct pd_message msg;
>  
>  	memset(&msg, 0, sizeof(msg));
> -	msg.header = PD_HEADER_LE(type, port->pwr_role,
> -				  port->data_role,
> -				  port->negotiated_rev,
> -				  port->message_id, 0);
> +	switch (tx_sop_type) {
> +	case TCPC_TX_SOP_PRIME:
> +		msg.header = PD_HEADER_LE(type,
> +					  0,	/* Cable Plug Indicator for DFP/UFP */
> +					  0,	/* Reserved */
> +					  port->negotiated_rev,
> +					  port->message_id_prime,
> +					  0);
> +		break;
> +	case TCPC_TX_SOP:
> +		msg.header = PD_HEADER_LE(type,
> +					  port->pwr_role,
> +					  port->data_role,
> +					  port->negotiated_rev,
> +					  port->message_id,
> +					  0);
> +		break;
> +	default:
> +		msg.header = PD_HEADER_LE(type,
> +					  port->pwr_role,
> +					  port->data_role,
> +					  port->negotiated_rev,
> +					  port->message_id,
> +					  0);
> +		break;
> +	}
>  
> -	return tcpm_pd_transmit(port, TCPC_TX_SOP, &msg);
> +	return tcpm_pd_transmit(port, tx_sop_type, &msg);
>  }
>  
>  /*
> @@ -3196,13 +3232,13 @@ static bool tcpm_send_queued_message(struct tcpm_port *port)
>  
>  		switch (queued_message) {
>  		case PD_MSG_CTRL_WAIT:
> -			tcpm_pd_send_control(port, PD_CTRL_WAIT);
> +			tcpm_pd_send_control(port, PD_CTRL_WAIT, TCPC_TX_SOP);
>  			break;
>  		case PD_MSG_CTRL_REJECT:
> -			tcpm_pd_send_control(port, PD_CTRL_REJECT);
> +			tcpm_pd_send_control(port, PD_CTRL_REJECT, TCPC_TX_SOP);
>  			break;
>  		case PD_MSG_CTRL_NOT_SUPP:
> -			tcpm_pd_send_control(port, PD_CTRL_NOT_SUPP);
> +			tcpm_pd_send_control(port, PD_CTRL_NOT_SUPP, TCPC_TX_SOP);
>  			break;
>  		case PD_MSG_DATA_SINK_CAP:
>  			ret = tcpm_pd_send_sink_caps(port);
> @@ -4217,7 +4253,7 @@ static void run_state_machine(struct tcpm_port *port)
>  	case SRC_NEGOTIATE_CAPABILITIES:
>  		ret = tcpm_pd_check_request(port);
>  		if (ret < 0) {
> -			tcpm_pd_send_control(port, PD_CTRL_REJECT);
> +			tcpm_pd_send_control(port, PD_CTRL_REJECT, TCPC_TX_SOP);
>  			if (!port->explicit_contract) {
>  				tcpm_set_state(port,
>  					       SRC_WAIT_NEW_CAPABILITIES, 0);
> @@ -4225,7 +4261,7 @@ static void run_state_machine(struct tcpm_port *port)
>  				tcpm_set_state(port, SRC_READY, 0);
>  			}
>  		} else {
> -			tcpm_pd_send_control(port, PD_CTRL_ACCEPT);
> +			tcpm_pd_send_control(port, PD_CTRL_ACCEPT, TCPC_TX_SOP);
>  			tcpm_set_partner_usb_comm_capable(port,
>  							  !!(port->sink_request & RDO_USB_COMM));
>  			tcpm_set_state(port, SRC_TRANSITION_SUPPLY,
> @@ -4234,7 +4270,7 @@ static void run_state_machine(struct tcpm_port *port)
>  		break;
>  	case SRC_TRANSITION_SUPPLY:
>  		/* XXX: regulator_set_voltage(vbus, ...) */
> -		tcpm_pd_send_control(port, PD_CTRL_PS_RDY);
> +		tcpm_pd_send_control(port, PD_CTRL_PS_RDY, TCPC_TX_SOP);
>  		port->explicit_contract = true;
>  		typec_set_pwr_opmode(port->typec_port, TYPEC_PWR_MODE_PD);
>  		port->pwr_opmode = TYPEC_PWR_MODE_PD;
> @@ -4718,7 +4754,7 @@ static void run_state_machine(struct tcpm_port *port)
>  		/* remove existing capabilities */
>  		usb_power_delivery_unregister_capabilities(port->partner_source_caps);
>  		port->partner_source_caps = NULL;
> -		tcpm_pd_send_control(port, PD_CTRL_ACCEPT);
> +		tcpm_pd_send_control(port, PD_CTRL_ACCEPT, TCPC_TX_SOP);
>  		tcpm_ams_finish(port);
>  		if (port->pwr_role == TYPEC_SOURCE) {
>  			port->upcoming_state = SRC_SEND_CAPABILITIES;
> @@ -4735,28 +4771,41 @@ static void run_state_machine(struct tcpm_port *port)
>  		tcpm_ams_start(port, SOFT_RESET_AMS);
>  		break;
>  	case SOFT_RESET_SEND:
> -		port->message_id = 0;
> -		port->rx_msgid = -1;
> -		/* remove existing capabilities */
> -		usb_power_delivery_unregister_capabilities(port->partner_source_caps);
> -		port->partner_source_caps = NULL;
> -		if (tcpm_pd_send_control(port, PD_CTRL_SOFT_RESET))
> -			tcpm_set_state_cond(port, hard_reset_state(port), 0);
> -		else
> -			tcpm_set_state_cond(port, hard_reset_state(port),
> -					    PD_T_SENDER_RESPONSE);
> +		/*
> +		 * Power Delivery 3.0 Section 6.3.13
> +		 *
> +		 * A Soft_Reset Message Shall be targeted at a specific entity
> +		 * depending on the type of SOP* packet used.
> +		 */
> +		if (port->tx_sop_type == TCPC_TX_SOP_PRIME) {
> +			port->message_id_prime = 0;
> +			port->rx_msgid_prime = -1;
> +			tcpm_pd_send_control(port, PD_CTRL_SOFT_RESET, TCPC_TX_SOP_PRIME);
> +			tcpm_set_state_cond(port, ready_state(port), PD_T_SENDER_RESPONSE);
> +		} else {
> +			port->message_id = 0;
> +			port->rx_msgid = -1;
> +			/* remove existing capabilities */
> +			usb_power_delivery_unregister_capabilities(port->partner_source_caps);
> +			port->partner_source_caps = NULL;
> +			if (tcpm_pd_send_control(port, PD_CTRL_SOFT_RESET, TCPC_TX_SOP))
> +				tcpm_set_state_cond(port, hard_reset_state(port), 0);
> +			else
> +				tcpm_set_state_cond(port, hard_reset_state(port),
> +						    PD_T_SENDER_RESPONSE);
> +		}
>  		break;
>  
>  	/* DR_Swap states */
>  	case DR_SWAP_SEND:
> -		tcpm_pd_send_control(port, PD_CTRL_DR_SWAP);
> +		tcpm_pd_send_control(port, PD_CTRL_DR_SWAP, TCPC_TX_SOP);
>  		if (port->data_role == TYPEC_DEVICE || port->negotiated_rev > PD_REV20)
>  			port->send_discover = true;
>  		tcpm_set_state_cond(port, DR_SWAP_SEND_TIMEOUT,
>  				    PD_T_SENDER_RESPONSE);
>  		break;
>  	case DR_SWAP_ACCEPT:
> -		tcpm_pd_send_control(port, PD_CTRL_ACCEPT);
> +		tcpm_pd_send_control(port, PD_CTRL_ACCEPT, TCPC_TX_SOP);
>  		if (port->data_role == TYPEC_DEVICE || port->negotiated_rev > PD_REV20)
>  			port->send_discover = true;
>  		tcpm_set_state_cond(port, DR_SWAP_CHANGE_DR, 0);
> @@ -4780,7 +4829,7 @@ static void run_state_machine(struct tcpm_port *port)
>  		break;
>  
>  	case FR_SWAP_SEND:
> -		if (tcpm_pd_send_control(port, PD_CTRL_FR_SWAP)) {
> +		if (tcpm_pd_send_control(port, PD_CTRL_FR_SWAP, TCPC_TX_SOP)) {
>  			tcpm_set_state(port, ERROR_RECOVERY, 0);
>  			break;
>  		}
> @@ -4800,7 +4849,7 @@ static void run_state_machine(struct tcpm_port *port)
>  		break;
>  	case FR_SWAP_SNK_SRC_SOURCE_VBUS_APPLIED:
>  		tcpm_set_pwr_role(port, TYPEC_SOURCE);
> -		if (tcpm_pd_send_control(port, PD_CTRL_PS_RDY)) {
> +		if (tcpm_pd_send_control(port, PD_CTRL_PS_RDY, TCPC_TX_SOP)) {
>  			tcpm_set_state(port, ERROR_RECOVERY, 0);
>  			break;
>  		}
> @@ -4810,11 +4859,11 @@ static void run_state_machine(struct tcpm_port *port)
>  
>  	/* PR_Swap states */
>  	case PR_SWAP_ACCEPT:
> -		tcpm_pd_send_control(port, PD_CTRL_ACCEPT);
> +		tcpm_pd_send_control(port, PD_CTRL_ACCEPT, TCPC_TX_SOP);
>  		tcpm_set_state(port, PR_SWAP_START, 0);
>  		break;
>  	case PR_SWAP_SEND:
> -		tcpm_pd_send_control(port, PD_CTRL_PR_SWAP);
> +		tcpm_pd_send_control(port, PD_CTRL_PR_SWAP, TCPC_TX_SOP);
>  		tcpm_set_state_cond(port, PR_SWAP_SEND_TIMEOUT,
>  				    PD_T_SENDER_RESPONSE);
>  		break;
> @@ -4856,7 +4905,7 @@ static void run_state_machine(struct tcpm_port *port)
>  		 * supply is turned off"
>  		 */
>  		tcpm_set_pwr_role(port, TYPEC_SINK);
> -		if (tcpm_pd_send_control(port, PD_CTRL_PS_RDY)) {
> +		if (tcpm_pd_send_control(port, PD_CTRL_PS_RDY, TCPC_TX_SOP)) {
>  			tcpm_set_state(port, ERROR_RECOVERY, 0);
>  			break;
>  		}
> @@ -4903,17 +4952,17 @@ static void run_state_machine(struct tcpm_port *port)
>  		 * Source."
>  		 */
>  		tcpm_set_pwr_role(port, TYPEC_SOURCE);
> -		tcpm_pd_send_control(port, PD_CTRL_PS_RDY);
> +		tcpm_pd_send_control(port, PD_CTRL_PS_RDY, TCPC_TX_SOP);
>  		tcpm_set_state(port, SRC_STARTUP, PD_T_SWAP_SRC_START);
>  		break;
>  
>  	case VCONN_SWAP_ACCEPT:
> -		tcpm_pd_send_control(port, PD_CTRL_ACCEPT);
> +		tcpm_pd_send_control(port, PD_CTRL_ACCEPT, TCPC_TX_SOP);
>  		tcpm_ams_finish(port);
>  		tcpm_set_state(port, VCONN_SWAP_START, 0);
>  		break;
>  	case VCONN_SWAP_SEND:
> -		tcpm_pd_send_control(port, PD_CTRL_VCONN_SWAP);
> +		tcpm_pd_send_control(port, PD_CTRL_VCONN_SWAP, TCPC_TX_SOP);
>  		tcpm_set_state(port, VCONN_SWAP_SEND_TIMEOUT,
>  			       PD_T_SENDER_RESPONSE);
>  		break;
> @@ -4932,14 +4981,34 @@ static void run_state_machine(struct tcpm_port *port)
>  			       PD_T_VCONN_SOURCE_ON);
>  		break;
>  	case VCONN_SWAP_TURN_ON_VCONN:
> -		tcpm_set_vconn(port, true);
> -		tcpm_pd_send_control(port, PD_CTRL_PS_RDY);
> -		tcpm_set_state(port, ready_state(port), 0);
> +		ret = tcpm_set_vconn(port, true);
> +		tcpm_pd_send_control(port, PD_CTRL_PS_RDY, TCPC_TX_SOP);
> +		/*
> +		 * USB PD 3.0 Section 6.4.4.3.1
> +		 *
> +		 * Note that a Cable Plug or VPD will not be ready for PD
> +		 * Communication until tVCONNStable after VCONN has been applied
> +		 */
> +		if (!ret)
> +			tcpm_set_state(port, VCONN_SWAP_SEND_SOFT_RESET,
> +				       PD_T_VCONN_STABLE);
> +		else
> +			tcpm_set_state(port, ready_state(port), 0);
>  		break;
>  	case VCONN_SWAP_TURN_OFF_VCONN:
>  		tcpm_set_vconn(port, false);
>  		tcpm_set_state(port, ready_state(port), 0);
>  		break;
> +	case VCONN_SWAP_SEND_SOFT_RESET:
> +		tcpm_swap_complete(port, port->swap_status);
> +		if (tcpm_can_communicate_sop_prime(port)) {
> +			port->tx_sop_type = TCPC_TX_SOP_PRIME;
> +			port->upcoming_state = SOFT_RESET_SEND;
> +			tcpm_ams_start(port, SOFT_RESET_AMS);
> +		} else {
> +			tcpm_set_state(port, ready_state(port), 0);
> +		}
> +		break;
>  
>  	case DR_SWAP_CANCEL:
>  	case PR_SWAP_CANCEL:
> @@ -4975,7 +5044,7 @@ static void run_state_machine(struct tcpm_port *port)
>  		}
>  		break;
>  	case GET_STATUS_SEND:
> -		tcpm_pd_send_control(port, PD_CTRL_GET_STATUS);
> +		tcpm_pd_send_control(port, PD_CTRL_GET_STATUS, TCPC_TX_SOP);
>  		tcpm_set_state(port, GET_STATUS_SEND_TIMEOUT,
>  			       PD_T_SENDER_RESPONSE);
>  		break;
> @@ -4983,7 +5052,7 @@ static void run_state_machine(struct tcpm_port *port)
>  		tcpm_set_state(port, ready_state(port), 0);
>  		break;
>  	case GET_PPS_STATUS_SEND:
> -		tcpm_pd_send_control(port, PD_CTRL_GET_PPS_STATUS);
> +		tcpm_pd_send_control(port, PD_CTRL_GET_PPS_STATUS, TCPC_TX_SOP);
>  		tcpm_set_state(port, GET_PPS_STATUS_SEND_TIMEOUT,
>  			       PD_T_SENDER_RESPONSE);
>  		break;
> @@ -4991,7 +5060,7 @@ static void run_state_machine(struct tcpm_port *port)
>  		tcpm_set_state(port, ready_state(port), 0);
>  		break;
>  	case GET_SINK_CAP:
> -		tcpm_pd_send_control(port, PD_CTRL_GET_SINK_CAP);
> +		tcpm_pd_send_control(port, PD_CTRL_GET_SINK_CAP, TCPC_TX_SOP);
>  		tcpm_set_state(port, GET_SINK_CAP_TIMEOUT, PD_T_SENDER_RESPONSE);
>  		break;
>  	case GET_SINK_CAP_TIMEOUT:
> @@ -5031,7 +5100,7 @@ static void run_state_machine(struct tcpm_port *port)
>  
>  	/* Chunk state */
>  	case CHUNK_NOT_SUPP:
> -		tcpm_pd_send_control(port, PD_CTRL_NOT_SUPP);
> +		tcpm_pd_send_control(port, PD_CTRL_NOT_SUPP, TCPC_TX_SOP);
>  		tcpm_set_state(port, port->pwr_role == TYPEC_SOURCE ? SRC_READY : SNK_READY, 0);
>  		break;
>  	default:
> diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
> index eb626af0e4e7..d50098fb16b5 100644
> --- a/include/linux/usb/pd.h
> +++ b/include/linux/usb/pd.h
> @@ -483,6 +483,7 @@ static inline unsigned int rdo_max_power(u32 rdo)
>  #define PD_T_BIST_CONT_MODE	50	/* 30 - 60 ms */
>  #define PD_T_SINK_TX		16	/* 16 - 20 ms */
>  #define PD_T_CHUNK_NOT_SUPP	42	/* 40 - 50 ms */
> +#define PD_T_VCONN_STABLE	50
>  
>  #define PD_T_DRP_TRY		100	/* 75 - 150 ms */
>  #define PD_T_DRP_TRYWAIT	600	/* 400 - 800 ms */
> -- 
> 2.43.0.472.g3155946c3a-goog

-- 
heikki

