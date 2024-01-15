Return-Path: <linux-kernel+bounces-25778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D152B82D5A5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B0AAB21166
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAFAC2C7;
	Mon, 15 Jan 2024 09:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CAuclIMJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E15CEAE7;
	Mon, 15 Jan 2024 09:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705310151; x=1736846151;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J7WY+pvU5HWXCFYG3mlc0sUuzayrggHjtu3nTGkydWk=;
  b=CAuclIMJjbvLcxp4qsabyaMjGCV+QZsUs06gak6YaDkAonj8ROhhDo8C
   ZiyUM42mQ7MNr6VuegCe/P/Fke9UOhTjC9q7wPdr4aTI5y+dHODSQFchE
   JQFno0IQO2V0+c8+xLK1/nhKU+gdXEOYA/yiKosUuV1YzrtSTCfR7vOBz
   C7ILJn95OrNhMw5wfkSNza0Ai1SWHXxIEGFwdYSZ/VH0HDdTK8NUO34Mr
   zScxrwIlw6tAVJgusnCo4NqlznWVNWKRQNDHoEfCgaTS2LvSEKKYG7WW0
   PKDEKqgJ/t/ip3ssF8qua1N4fK5dbfgrqAaFSrC/gj/c7+p1O/+T81Iab
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="6932730"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; 
   d="scan'208";a="6932730"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 01:15:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="787027838"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; 
   d="scan'208";a="787027838"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga007.fm.intel.com with SMTP; 15 Jan 2024 01:15:48 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 15 Jan 2024 11:15:47 +0200
Date: Mon, 15 Jan 2024 11:15:47 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: RD Babiera <rdbabiera@google.com>
Cc: linux@roeck-us.net, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	badhri@google.com, bryan.odonoghue@linaro.org, agross@kernel.org,
	andersson@kernel.org, konrad.dybcio@linaro.org
Subject: Re: [PATCH v3 11/12] usb: typec: tcpm: add alt mode enter/exit/vdm
 support for sop'
Message-ID: <ZaT3w53W61Klihcf@kuha.fi.intel.com>
References: <20240108191620.987785-14-rdbabiera@google.com>
 <20240108191620.987785-25-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108191620.987785-25-rdbabiera@google.com>

On Mon, Jan 08, 2024 at 07:16:24PM +0000, RD Babiera wrote:
> Add tcpm_cable_ops for enter, exit, and vdm to the tcpm, which are
> registered after registering port alt modes through
> typec_port_register_cable_ops. Enter Mode on SOP' now sends Exit Mode upon
> failure to report to the driver.
> 
> tcpm_queue_vdm_unlocked now takes sop type as input. Proper adev_actions
> in tcpm_pd_svdm are selected for SOP' messages.
> 
> Signed-off-by: RD Babiera <rdbabiera@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 126 ++++++++++++++++++++++++++++------
>  1 file changed, 106 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index d16edf112858..86d9962961c2 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -1556,7 +1556,7 @@ static void tcpm_queue_vdm(struct tcpm_port *port, const u32 header,
>  }
>  
>  static void tcpm_queue_vdm_unlocked(struct tcpm_port *port, const u32 header,
> -				    const u32 *data, int cnt)
> +				    const u32 *data, int cnt, enum tcpm_transmit_type tx_sop_type)
>  {
>  	mutex_lock(&port->lock);
>  	tcpm_queue_vdm(port, header, data, cnt, TCPC_TX_SOP);
> @@ -2144,14 +2144,28 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  			}
>  			break;
>  		case CMD_ENTER_MODE:
> -			if (adev && pdev)
> -				*adev_action = ADEV_QUEUE_VDM_SEND_EXIT_MODE_ON_FAIL;
> +			*response_tx_sop_type = rx_sop_type;
> +			if (rx_sop_type == TCPC_TX_SOP) {
> +				if (adev && pdev) {
> +					typec_altmode_update_active(pdev, true);
> +					*adev_action = ADEV_QUEUE_VDM_SEND_EXIT_MODE_ON_FAIL;
> +				}
> +			} else if (rx_sop_type == TCPC_TX_SOP_PRIME) {
> +				if (adev && pdev_prime) {
> +					typec_altmode_update_active(pdev_prime, true);
> +					*adev_action = ADEV_QUEUE_VDM_SEND_EXIT_MODE_ON_FAIL;
> +				}
> +			}
>  			return 0;
>  		case CMD_EXIT_MODE:
> -			if (adev && pdev) {
> -				/* Back to USB Operation */
> -				*adev_action = ADEV_NOTIFY_USB_AND_QUEUE_VDM;
> -				return 0;
> +			*response_tx_sop_type = rx_sop_type;
> +			if (rx_sop_type == TCPC_TX_SOP) {
> +				if (adev && pdev) {
> +					typec_altmode_update_active(pdev, false);
> +					/* Back to USB Operation */
> +					*adev_action = ADEV_NOTIFY_USB_AND_QUEUE_VDM;
> +					return 0;
> +				}
>  			}
>  			break;
>  		case VDO_CMD_VENDOR(0) ... VDO_CMD_VENDOR(15):
> @@ -2284,19 +2298,37 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
>  			typec_altmode_vdm(adev, p[0], &p[1], cnt);
>  			break;
>  		case ADEV_QUEUE_VDM:
> -			typec_altmode_vdm(adev, p[0], &p[1], cnt);
> +			if (response_tx_sop_type == TCPC_TX_SOP_PRIME)
> +				typec_cable_altmode_vdm(adev, TYPEC_PLUG_SOP_P, p[0], &p[1], cnt);
> +			else
> +				typec_altmode_vdm(adev, p[0], &p[1], cnt);
>  			break;
>  		case ADEV_QUEUE_VDM_SEND_EXIT_MODE_ON_FAIL:
> -			if (typec_altmode_vdm(adev, p[0], &p[1], cnt)) {
> -				int svdm_version = typec_get_negotiated_svdm_version(
> -									port->typec_port);
> -				if (svdm_version < 0)
> -					break;
> +			if (response_tx_sop_type == TCPC_TX_SOP_PRIME) {
> +				if (typec_cable_altmode_vdm(adev, TYPEC_PLUG_SOP_P,
> +							    p[0], &p[1], cnt)) {
> +					int svdm_version = typec_get_cable_svdm_version(
> +										port->typec_port);
> +					if (svdm_version < 0)
> +						break;
>  
> -				response[0] = VDO(adev->svid, 1, svdm_version,
> -						  CMD_EXIT_MODE);
> -				response[0] |= VDO_OPOS(adev->mode);
> -				rlen = 1;
> +					response[0] = VDO(adev->svid, 1, svdm_version,
> +							CMD_EXIT_MODE);
> +					response[0] |= VDO_OPOS(adev->mode);
> +					rlen = 1;
> +				}
> +			} else {
> +				if (typec_altmode_vdm(adev, p[0], &p[1], cnt)) {
> +					int svdm_version = typec_get_negotiated_svdm_version(
> +										port->typec_port);
> +					if (svdm_version < 0)
> +						break;
> +
> +					response[0] = VDO(adev->svid, 1, svdm_version,
> +							CMD_EXIT_MODE);
> +					response[0] |= VDO_OPOS(adev->mode);
> +					rlen = 1;
> +				}
>  			}
>  			break;
>  		case ADEV_ATTENTION:
> @@ -2731,7 +2763,7 @@ static int tcpm_altmode_enter(struct typec_altmode *altmode, u32 *vdo)
>  	header = VDO(altmode->svid, vdo ? 2 : 1, svdm_version, CMD_ENTER_MODE);
>  	header |= VDO_OPOS(altmode->mode);
>  
> -	tcpm_queue_vdm_unlocked(port, header, vdo, vdo ? 1 : 0);
> +	tcpm_queue_vdm_unlocked(port, header, vdo, vdo ? 1 : 0, TCPC_TX_SOP);
>  	return 0;
>  }
>  
> @@ -2748,7 +2780,7 @@ static int tcpm_altmode_exit(struct typec_altmode *altmode)
>  	header = VDO(altmode->svid, 1, svdm_version, CMD_EXIT_MODE);
>  	header |= VDO_OPOS(altmode->mode);
>  
> -	tcpm_queue_vdm_unlocked(port, header, NULL, 0);
> +	tcpm_queue_vdm_unlocked(port, header, NULL, 0, TCPC_TX_SOP);
>  	return 0;
>  }
>  
> @@ -2757,7 +2789,7 @@ static int tcpm_altmode_vdm(struct typec_altmode *altmode,
>  {
>  	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
>  
> -	tcpm_queue_vdm_unlocked(port, header, data, count - 1);
> +	tcpm_queue_vdm_unlocked(port, header, data, count - 1, TCPC_TX_SOP);
>  
>  	return 0;
>  }
> @@ -2768,6 +2800,58 @@ static const struct typec_altmode_ops tcpm_altmode_ops = {
>  	.vdm = tcpm_altmode_vdm,
>  };
>  
> +
> +static int tcpm_cable_altmode_enter(struct typec_altmode *altmode, enum typec_plug_index sop,
> +				    u32 *vdo)
> +{
> +	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
> +	int svdm_version;
> +	u32 header;
> +
> +	svdm_version = typec_get_cable_svdm_version(port->typec_port);
> +	if (svdm_version < 0)
> +		return svdm_version;
> +
> +	header = VDO(altmode->svid, vdo ? 2 : 1, svdm_version, CMD_ENTER_MODE);
> +	header |= VDO_OPOS(altmode->mode);
> +
> +	tcpm_queue_vdm_unlocked(port, header, vdo, vdo ? 1 : 0, TCPC_TX_SOP_PRIME);
> +	return 0;
> +}
> +
> +static int tcpm_cable_altmode_exit(struct typec_altmode *altmode, enum typec_plug_index sop)
> +{
> +	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
> +	int svdm_version;
> +	u32 header;
> +
> +	svdm_version = typec_get_cable_svdm_version(port->typec_port);
> +	if (svdm_version < 0)
> +		return svdm_version;
> +
> +	header = VDO(altmode->svid, 1, svdm_version, CMD_EXIT_MODE);
> +	header |= VDO_OPOS(altmode->mode);
> +
> +	tcpm_queue_vdm_unlocked(port, header, NULL, 0, TCPC_TX_SOP_PRIME);
> +	return 0;
> +}
> +
> +static int tcpm_cable_altmode_vdm(struct typec_altmode *altmode, enum typec_plug_index sop,
> +				  u32 header, const u32 *data, int count)
> +{
> +	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
> +
> +	tcpm_queue_vdm_unlocked(port, header, data, count - 1, TCPC_TX_SOP_PRIME);
> +
> +	return 0;
> +}
> +
> +static const struct typec_cable_ops tcpm_cable_ops = {
> +	.enter = tcpm_cable_altmode_enter,
> +	.exit = tcpm_cable_altmode_exit,
> +	.vdm = tcpm_cable_altmode_vdm,
> +};
> +
>  /*
>   * PD (data, control) command handling functions
>   */
> @@ -7507,6 +7591,8 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
>  	typec_port_register_altmodes(port->typec_port,
>  				     &tcpm_altmode_ops, port,
>  				     port->port_altmode, ALTMODE_DISCOVERY_MAX);
> +	typec_port_register_cable_ops(port->port_altmode, ARRAY_SIZE(port->port_altmode),
> +				      &tcpm_cable_ops);
>  	port->registered = true;
>  
>  	mutex_lock(&port->lock);
> -- 
> 2.43.0.472.g3155946c3a-goog

-- 
heikki

