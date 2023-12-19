Return-Path: <linux-kernel+bounces-5317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B05C8818959
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A31B1F24F0F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732C81A73C;
	Tue, 19 Dec 2023 14:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lfXrfHdS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7F120DC7;
	Tue, 19 Dec 2023 14:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702994848; x=1734530848;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=k8HRPwanlNvagjL2x1VWakPdYeKVgB5+5JJkqV1vtPE=;
  b=lfXrfHdSufqoqQkc7VQEayN0Hq2cjJ23ZF8trFPEVaYT8CKdphwrfHkj
   scBkrl6vy2+TLQWAXwWmTwhy5mRK3NP84OOKsKwbPbSyT8ZMlO+NB13qv
   vwo2tmdzp2y9Jbf+vMqeL26x9OARdANY8FVXxweTS6YXeMBaly/qUH0ah
   3uX82YSI89mVrRN9R2jfaBlsvxr/kIPgteFyijqxfK6TwH28PMbgq4h2q
   FxoSNzWgCuRMG5da+X03TjmVKQTQ9Q3tw2Sgp1zxD8pB4J1mu8pC4UORz
   tpIfisEmPYjAcgW66WQlb70FUhJPj0Gz8Z7hAcujrXJrVoRuQZg0fU+k+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="481850882"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="481850882"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 06:07:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="810244022"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="810244022"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orsmga001.jf.intel.com with SMTP; 19 Dec 2023 06:07:23 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 19 Dec 2023 16:07:22 +0200
Date: Tue, 19 Dec 2023 16:07:22 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: RD Babiera <rdbabiera@google.com>
Cc: linux@roeck-us.net, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	badhri@google.com, bryan.odonoghue@linaro.org, agross@kernel.org,
	andersson@kernel.org, konrad.dybcio@linaro.org
Subject: Re: [PATCH v2 05/12] usb: typec: tcpm: process receive and
 transmission of sop' messages
Message-ID: <ZYGjmryUR7m2Q9yw@kuha.fi.intel.com>
References: <20231214230850.379863-14-rdbabiera@google.com>
 <20231214230850.379863-19-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231214230850.379863-19-rdbabiera@google.com>

On Thu, Dec 14, 2023 at 11:08:49PM +0000, RD Babiera wrote:
> Add negotiated revision and tx/rx message ids to tcpm_port specific to
> SOP'. tx_sop_type is added to the tcpm_port to determine whether the
> current constructed message will be sent over SOP or SOP' if not
> sent immediately.
> 
> tcpm_pd_rx_handler updates the received message ids. SOP* messages are not
> processed afterwards. The handler also calls tcpm_can_communicate_sop_prime
> to determine if a SOP' message is directed towards the port, and drops SOP'
> messages it should not respond to.
> 
> tcpm_can_communicate_sop_prime is added as a helper to determine whether
> the port is capable of communicating over SOP' at a given moment. Being
> the Vconn source is a requirement in Power Delivery 3.0 but only a
> recommendation in Power Delviery 2.0. Because the port should ensure that
> the cable is powered before communication, always enforce the port is the
> Vconn source regardless of revision.
> 
> Signed-off-by: RD Babiera <rdbabiera@google.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 156 +++++++++++++++++++++++++++++++---
>  1 file changed, 145 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index b05325dcd7ac..bc6c5f04e62f 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -493,6 +493,35 @@ struct tcpm_port {
>  	 * transitions.
>  	 */
>  	bool potential_contaminant;
> +
> +	/* SOP* Related Fields */
> +	/*
> +	 * tx_sop_type determines which SOP* a message is being sent on.
> +	 * For messages that are queued and not sent immediately such as in
> +	 * tcpm_queue_message or messages that send after state changes,
> +	 * the tx_sop_type is set accordingly.
> +	 */
> +	enum tcpm_transmit_type tx_sop_type;
> +	/*
> +	 * Prior to discovering the port partner's Specification Revision, the
> +	 * Vconn source and cable plug will use the lower of their two revisions.
> +	 *
> +	 * When the port partner's Specification Revision is discovered, the following
> +	 * rules are put in place.
> +	 *	1. If the cable revision (1) is lower than the revision negotiated
> +	 * between the port and partner (2), the port and partner will communicate
> +	 * on revision (2), but the port and cable will communicate on revision (1).
> +	 *	2. If the cable revision (1) is higher than the revision negotiated
> +	 * between the port and partner (2), the port and partner will communicate
> +	 * on revision (2), and the port and cable will communicate on revision (2)
> +	 * as well.
> +	 */
> +	unsigned int negotiated_rev_prime;
> +	/*
> +	 * Each SOP* type must maintain their own tx and rx message IDs
> +	 */
> +	unsigned int message_id_prime;
> +	unsigned int rx_msgid_prime;
>  #ifdef CONFIG_DEBUG_FS
>  	struct dentry *dentry;
>  	struct mutex logbuffer_lock;	/* log buffer access lock */
> @@ -882,19 +911,32 @@ static void tcpm_ams_finish(struct tcpm_port *port)
>  }
>  
>  static int tcpm_pd_transmit(struct tcpm_port *port,
> -			    enum tcpm_transmit_type type,
> +			    enum tcpm_transmit_type tx_sop_type,
>  			    const struct pd_message *msg)
>  {
>  	unsigned long timeout;
>  	int ret;
> +	unsigned int negotiated_rev;
> +
> +	switch (tx_sop_type) {
> +	case TCPC_TX_SOP_PRIME:
> +		negotiated_rev = port->negotiated_rev_prime;
> +		break;
> +	case TCPC_TX_SOP:
> +		negotiated_rev = port->negotiated_rev;
> +		break;
> +	default:
> +		negotiated_rev = port->negotiated_rev;
> +		break;

Why not just fall through?

	case TCPC_TX_SOP:
	default:
		negotiated_rev = port->negotiated_rev;
		break;

> +	}
>  
>  	if (msg)
>  		tcpm_log(port, "PD TX, header: %#x", le16_to_cpu(msg->header));
>  	else
> -		tcpm_log(port, "PD TX, type: %#x", type);
> +		tcpm_log(port, "PD TX, type: %#x", tx_sop_type);
>  
>  	reinit_completion(&port->tx_complete);
> -	ret = port->tcpc->pd_transmit(port->tcpc, type, msg, port->negotiated_rev);
> +	ret = port->tcpc->pd_transmit(port->tcpc, tx_sop_type, msg, negotiated_rev);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -907,7 +949,20 @@ static int tcpm_pd_transmit(struct tcpm_port *port,
>  
>  	switch (port->tx_status) {
>  	case TCPC_TX_SUCCESS:
> -		port->message_id = (port->message_id + 1) & PD_HEADER_ID_MASK;
> +		switch (tx_sop_type) {
> +		case TCPC_TX_SOP_PRIME:
> +			port->message_id_prime = (port->message_id_prime + 1) &
> +						 PD_HEADER_ID_MASK;
> +			break;
> +		case TCPC_TX_SOP:
> +			port->message_id = (port->message_id + 1) &
> +					   PD_HEADER_ID_MASK;
> +			break;

Ditto.

> +		default:
> +			port->message_id = (port->message_id + 1) &
> +					   PD_HEADER_ID_MASK;
> +			break;
> +		}
>  		/*
>  		 * USB PD rev 2.0, 8.3.2.2.1:
>  		 * USB PD rev 3.0, 8.3.2.1.3:
> @@ -1592,6 +1647,57 @@ static void tcpm_register_partner_altmodes(struct tcpm_port *port)
>  
>  #define supports_modal(port)	PD_IDH_MODAL_SUPP((port)->partner_ident.id_header)
>  
> +/*
> + * Helper to determine whether the port is capable of SOP' communication at the
> + * current point in time.
> + */
> +static bool tcpm_can_communicate_sop_prime(struct tcpm_port *port)
> +{
> +	/* Check to see if tcpc supports SOP' communication */
> +	if (!port->tcpc->cable_comm_capable || !port->tcpc->cable_comm_capable(port->tcpc))
> +		return false;
> +	/*
> +	 * Power Delivery 2.0 Section 6.3.11
> +	 * Before communicating with a Cable Plug a Port Should ensure that it
> +	 * is the Vconn Source and that the Cable Plugs are powered by
> +	 * performing a Vconn swap if necessary. Since it cannot be guaranteed
> +	 * that the present Vconn Source is supplying Vconn, the only means to
> +	 * ensure that the Cable Plugs are powered is for a Port wishing to
> +	 * communicate with a Cable Plug is to become the Vconn Source.
> +	 *
> +	 * Power Delivery 3.0 Section 6.3.11
> +	 * Before communicating with a Cable Plug a Port Shall ensure that it
> +	 * is the Vconn source.
> +	 */
> +	if (port->vconn_role != TYPEC_SOURCE)
> +		return false;
> +	/*
> +	 * Power Delivery 2.0 Section 2.4.4
> +	 * When no Contract or an Implicit Contract is in place the Source can
> +	 * communicate with a Cable Plug using SOP' packets in order to discover
> +	 * its characteristics.
> +	 *
> +	 * Power Delivery 3.0 Section 2.4.4
> +	 * When no Contract or an Implicit Contract is in place only the Source
> +	 * port that is supplying Vconn is allowed to send packets to a Cable
> +	 * Plug and is allowed to respond to packets from the Cable Plug.
> +	 */
> +	if (!port->explicit_contract)
> +		return port->pwr_role == TYPEC_SOURCE;
> +	if (port->negotiated_rev == PD_REV30)
> +		return true;
> +	/*
> +	 * Power Delivery 2.0 Section 2.4.4
> +	 *
> +	 * When an Explicit Contract is in place the DFP (either the Source or
> +	 * the Sink) can communicate with the Cable Plug(s) using SOP’/SOP”
> +	 * Packets (see Figure 2-3).
> +	 */
> +	if (port->negotiated_rev == PD_REV20)
> +		return port->data_role == TYPEC_HOST;
> +	return false;
> +}
> +
>  static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  			const u32 *p, int cnt, u32 *response,
>  			enum adev_actions *adev_action)
> @@ -2977,14 +3083,18 @@ static void tcpm_pd_rx_handler(struct kthread_work *work)
>  	tcpm_log(port, "PD RX, header: %#x [%d]", le16_to_cpu(msg->header),
>  		 port->attached);
>  
> -	/* Ignore SOP' for now */
> -	if (rx_sop_type == TCPC_TX_SOP_PRIME)
> -		goto done;
> -
>  	if (port->attached) {
>  		enum pd_ctrl_msg_type type = pd_header_type_le(msg->header);
>  		unsigned int msgid = pd_header_msgid_le(msg->header);
>  
> +		/*
> +		 * Drop SOP' messages if cannot receive via
> +		 * tcpm_can_communicate_sop_prime
> +		 */
> +		if (rx_sop_type == TCPC_TX_SOP_PRIME &&
> +		    !tcpm_can_communicate_sop_prime(port))
> +			goto done;
> +
>  		/*
>  		 * USB PD standard, 6.6.1.2:
>  		 * "... if MessageID value in a received Message is the
> @@ -2994,16 +3104,33 @@ static void tcpm_pd_rx_handler(struct kthread_work *work)
>  		 * Message). Note: this shall not apply to the Soft_Reset
>  		 * Message which always has a MessageID value of zero."
>  		 */
> -		if (msgid == port->rx_msgid && type != PD_CTRL_SOFT_RESET)
> +		switch (rx_sop_type) {
> +		case TCPC_TX_SOP_PRIME:
> +			if (msgid == port->rx_msgid_prime)
> +				goto done;
> +			port->rx_msgid_prime = msgid;
> +			/* Ignore SOP' for now */
>  			goto done;
> -		port->rx_msgid = msgid;
> +		case TCPC_TX_SOP:
> +			if (msgid == port->rx_msgid &&
> +			    type != PD_CTRL_SOFT_RESET)
> +				goto done;
> +			port->rx_msgid = msgid;
> +			break;

Ditto.

> +		default:
> +			if (msgid == port->rx_msgid &&
> +			    type != PD_CTRL_SOFT_RESET)

And that fits on one line.

> +				goto done;
> +			port->rx_msgid = msgid;
> +			break;
> +		}
>  
>  		/*
>  		 * If both ends believe to be DFP/host, we have a data role
>  		 * mismatch.
>  		 */
>  		if (!!(le16_to_cpu(msg->header) & PD_HEADER_DATA_ROLE) ==
> -		    (port->data_role == TYPEC_HOST)) {
> +		    (port->data_role == TYPEC_HOST) && rx_sop_type == TCPC_TX_SOP) {
>  			tcpm_log(port,
>  				 "Data role mismatch, initiating error recovery");
>  			tcpm_set_state(port, ERROR_RECOVERY, 0);
> @@ -3708,6 +3835,7 @@ static void tcpm_reset_port(struct tcpm_port *port)
>  	 * we can check tcpm_pd_rx_handler() if we had seen it before.
>  	 */
>  	port->rx_msgid = -1;
> +	port->rx_msgid_prime = -1;
>  
>  	port->tcpc->set_pd_rx(port->tcpc, false);
>  	tcpm_init_vbus(port);	/* also disables charging */
> @@ -4022,8 +4150,11 @@ static void run_state_machine(struct tcpm_port *port)
>  		port->pwr_opmode = TYPEC_PWR_MODE_USB;
>  		port->caps_count = 0;
>  		port->negotiated_rev = PD_MAX_REV;
> +		port->negotiated_rev_prime = PD_MAX_REV;
>  		port->message_id = 0;
> +		port->message_id_prime = 0;
>  		port->rx_msgid = -1;
> +		port->rx_msgid_prime = -1;
>  		port->explicit_contract = false;
>  		/* SNK -> SRC POWER/FAST_ROLE_SWAP finished */
>  		if (port->ams == POWER_ROLE_SWAP ||
> @@ -4263,8 +4394,11 @@ static void run_state_machine(struct tcpm_port *port)
>  		typec_set_pwr_opmode(port->typec_port, opmode);
>  		port->pwr_opmode = TYPEC_PWR_MODE_USB;
>  		port->negotiated_rev = PD_MAX_REV;
> +		port->negotiated_rev_prime = PD_MAX_REV;
>  		port->message_id = 0;
> +		port->message_id_prime = 0;
>  		port->rx_msgid = -1;
> +		port->rx_msgid_prime = -1;
>  		port->explicit_contract = false;
>  
>  		if (port->ams == POWER_ROLE_SWAP ||
> -- 
> 2.43.0.472.g3155946c3a-goog

-- 
heikki

