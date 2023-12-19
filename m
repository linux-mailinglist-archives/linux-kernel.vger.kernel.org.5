Return-Path: <linux-kernel+bounces-5370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF668189F7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9B0A282A5F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A2E358BA;
	Tue, 19 Dec 2023 14:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zrqj5KUe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AD1374FA;
	Tue, 19 Dec 2023 14:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702996018; x=1734532018;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NMTALL5LaLth0gU3WHVwSBfrCq2Dr+XUdfUtUbJYJx4=;
  b=Zrqj5KUeT1y5o9UKt3BtVf8aKxnWQO4cuHJPWbXZLkY3vUZqUQ2h/azh
   PZDHQAkvxG+r+Ih8Z9FwrueWzgfJgycF8d8x0w2sB34rpia4uPrbmTMNI
   YMGarM7Ndgqn783ervelxX62xDdLmlVm8d2vMuwzLWK11mCH3F+/eK8tf
   fvCBfAcKewNRKg9yI6ukn6DR0A9J7DhGfxDyJdmvjK+Zl3wiufHLiz5q8
   y328WfTDRH7Nn4WaEcCZJZPfGZBooawzTErE/qrXoxFue8tEpbGdZfRmC
   3QF1ENI3hnh2vTaHR1+6e3CpFnM8jTqj/uRJwo8JZG46JC+crcqE/74wD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="460006287"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="460006287"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 06:26:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="894310521"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="894310521"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga002.fm.intel.com with SMTP; 19 Dec 2023 06:26:54 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 19 Dec 2023 16:26:53 +0200
Date: Tue, 19 Dec 2023 16:26:53 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: RD Babiera <rdbabiera@google.com>
Cc: linux@roeck-us.net, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	badhri@google.com, bryan.odonoghue@linaro.org, agross@kernel.org,
	andersson@kernel.org, konrad.dybcio@linaro.org
Subject: Re: [PATCH v2 09/12] usb: typec: tcpm: add state machine support for
 SRC_VDM_IDENTITY_REQUEST
Message-ID: <ZYGoLTm2VyU8cWfD@kuha.fi.intel.com>
References: <20231214230850.379863-14-rdbabiera@google.com>
 <20231214230850.379863-23-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214230850.379863-23-rdbabiera@google.com>

On Thu, Dec 14, 2023 at 11:08:53PM +0000, RD Babiera wrote:
> Add SRC_VDM_IDENTITY_REQUEST state which first enters after SRC_STARTUP.
> The state sends Discover Identity on SOP' and transitions to
> SRC_SEND_CAPABILITIES. SRC_SEND_CAPABILITIES will transition back into
> SRC_VDM_IDENTITY_REQUEST instead of retrying immediately.
> 
> Signed-off-by: RD Babiera <rdbabiera@google.com>
> ---

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

>  drivers/usb/typec/tcpm/tcpm.c | 49 ++++++++++++++++++++++++++++++-----
>  1 file changed, 43 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 5924e359e14d..e21bc2eea3fc 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -146,7 +146,9 @@
>  	S(PORT_RESET_WAIT_OFF),			\
>  						\
>  	S(AMS_START),				\
> -	S(CHUNK_NOT_SUPP)
> +	S(CHUNK_NOT_SUPP),			\
> +						\
> +	S(SRC_VDM_IDENTITY_REQUEST)
>  
>  #define FOREACH_AMS(S)				\
>  	S(NONE_AMS),				\
> @@ -1956,6 +1958,7 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  					ret = tcpm_ams_start(port, VCONN_SWAP);
>  					if (!ret)
>  						return 0;
> +					/* Cannot perform Vconn swap */
>  					port->upcoming_state = INVALID_STATE;
>  					port->send_discover_prime = false;
>  				}
> @@ -1987,6 +1990,16 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  				 * the svdm_version for the cable moving forward.
>  				 */
>  				svdm_consume_identity_sop_prime(port, p, cnt);
> +
> +				/*
> +				 * If received in SRC_VDM_IDENTITY_REQUEST, continue
> +				 * to SRC_SEND_CAPABILITIES
> +				 */
> +				if (port->state == SRC_VDM_IDENTITY_REQUEST) {
> +					tcpm_set_state(port, SRC_SEND_CAPABILITIES, 0);
> +					return 0;
> +				}
> +
>  				*response_tx_sop_type = TCPC_TX_SOP;
>  				response[0] = VDO(USB_SID_PD, 1,
>  						  typec_get_negotiated_svdm_version(typec),
> @@ -2281,7 +2294,8 @@ static void vdm_run_state_machine(struct tcpm_port *port)
>  		 * if there's traffic or we're not in PDO ready state don't send
>  		 * a VDM.
>  		 */
> -		if (port->state != SRC_READY && port->state != SNK_READY) {
> +		if (port->state != SRC_READY && port->state != SNK_READY &&
> +		    port->state != SRC_VDM_IDENTITY_REQUEST) {
>  			port->vdm_sm_running = false;
>  			break;
>  		}
> @@ -2357,13 +2371,22 @@ static void vdm_run_state_machine(struct tcpm_port *port)
>  			tcpm_ams_finish(port);
>  		break;
>  	case VDM_STATE_ERR_SEND:
> +		/*
> +		 * When sending Discover Identity to SOP' before establishing an
> +		 * explicit contract, do not retry. Instead, weave sending
> +		 * Source_Capabilities over SOP and Discover Identity over SOP'.
> +		 */
> +		if (port->state == SRC_VDM_IDENTITY_REQUEST) {
> +			tcpm_ams_finish(port);
> +			port->vdm_state = VDM_STATE_DONE;
> +			tcpm_set_state(port, SRC_SEND_CAPABILITIES, 0);
>  		/*
>  		 * A partner which does not support USB PD will not reply,
>  		 * so this is not a fatal error. At the same time, some
>  		 * devices may not return GoodCRC under some circumstances,
>  		 * so we need to retry.
>  		 */
> -		if (port->vdm_retries < 3) {
> +		} else if (port->vdm_retries < 3) {
>  			tcpm_log(port, "VDM Tx error, retry");
>  			port->vdm_retries++;
>  			port->vdm_state = VDM_STATE_READY;
> @@ -4477,8 +4500,12 @@ static void run_state_machine(struct tcpm_port *port)
>  		}
>  		ret = tcpm_pd_send_source_caps(port);
>  		if (ret < 0) {
> -			tcpm_set_state(port, SRC_SEND_CAPABILITIES,
> -				       PD_T_SEND_SOURCE_CAP);
> +			if (tcpm_can_communicate_sop_prime(port) &&
> +			    IS_ERR_OR_NULL(port->cable))
> +				tcpm_set_state(port, SRC_VDM_IDENTITY_REQUEST, 0);
> +			else
> +				tcpm_set_state(port, SRC_SEND_CAPABILITIES,
> +					       PD_T_SEND_SOURCE_CAP);
>  		} else {
>  			/*
>  			 * Per standard, we should clear the reset counter here.
> @@ -5393,6 +5420,15 @@ static void run_state_machine(struct tcpm_port *port)
>  		tcpm_pd_send_control(port, PD_CTRL_NOT_SUPP, TCPC_TX_SOP);
>  		tcpm_set_state(port, port->pwr_role == TYPEC_SOURCE ? SRC_READY : SNK_READY, 0);
>  		break;
> +
> +	/* Cable states */
> +	case SRC_VDM_IDENTITY_REQUEST:
> +		port->send_discover_prime = true;
> +		port->tx_sop_type = TCPC_TX_SOP_PRIME;
> +		mod_send_discover_delayed_work(port, 0);
> +		port->upcoming_state = SRC_SEND_CAPABILITIES;
> +		break;
> +
>  	default:
>  		WARN(1, "Unexpected port state %d\n", port->state);
>  		break;
> @@ -6118,7 +6154,8 @@ static void tcpm_send_discover_work(struct kthread_work *work)
>  	}
>  
>  	/* Retry if the port is not idle */
> -	if ((port->state != SRC_READY && port->state != SNK_READY) || port->vdm_sm_running) {
> +	if ((port->state != SRC_READY && port->state != SNK_READY &&
> +	     port->state != SRC_VDM_IDENTITY_REQUEST) || port->vdm_sm_running) {
>  		mod_send_discover_delayed_work(port, SEND_DISCOVER_RETRY_MS);
>  		goto unlock;
>  	}
> -- 
> 2.43.0.472.g3155946c3a-goog

-- 
heikki

