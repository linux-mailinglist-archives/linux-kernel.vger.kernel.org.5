Return-Path: <linux-kernel+bounces-5341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C79818998
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AE3F2893A2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1FF1BDE6;
	Tue, 19 Dec 2023 14:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K1k+A7st"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D8C1BDCB;
	Tue, 19 Dec 2023 14:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702995456; x=1734531456;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4fdA+RDRgZi3nbq9zaBgE60rnFsRDkfCTi6quN1D1io=;
  b=K1k+A7stNgs+sdeGPjY4SyZybknVlO5zdinW0bqNlI+G0uG72moUzIQd
   QH7OO+hd+bBfhuTLBPaazFIRwRc/a7UdwF54L/NCu24k4Secg5kn2IdcP
   4Cw2HW2CQzKs2wB25Pp2OVUq817v5VXoJ6vjxiulcQZZD9MV+2pJKL9J0
   tcBqa3SLJS7aDerAAgYMZMvJJIHzeAurjYdb5g6YsLwm0JnPwCDXdvYr2
   DaSCxazK/xzl9Gts2MuBlF/IyPm/hPN3pdBqYQlaGl0RpvHzQURw9uZ8n
   4wI+z2dcRzwbpXD/jqMEZ2nDcRN2I12zjt8Fd0lA23i6zKQsV0YtRbjvD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="380647685"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="380647685"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 06:17:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="841901350"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="841901350"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga008.fm.intel.com with SMTP; 19 Dec 2023 06:17:32 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 19 Dec 2023 16:17:31 +0200
Date: Tue, 19 Dec 2023 16:17:31 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: RD Babiera <rdbabiera@google.com>
Cc: linux@roeck-us.net, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	badhri@google.com, bryan.odonoghue@linaro.org, agross@kernel.org,
	andersson@kernel.org, konrad.dybcio@linaro.org
Subject: Re: [PATCH v2 07/12] usb: typec: tcpci: add
 attempt_vconn_swap_discovery callback
Message-ID: <ZYGl+6FbZM0SHCri@kuha.fi.intel.com>
References: <20231214230850.379863-14-rdbabiera@google.com>
 <20231214230850.379863-21-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214230850.379863-21-rdbabiera@google.com>

On Thu, Dec 14, 2023 at 11:08:51PM +0000, RD Babiera wrote:
> Add attempt_vconn_swap_discovery callback to determine whether the TCPM
> should perform a Vconn swap following Discover Identity on SOP. The tcpci
> will return false unless chip level drivers implement the callback.
> 
> Maxim based TCPCs will return true unless the last connection resulted in
> a Vconn Over Current Fault, which may be the result of the Vconn swap. In
> addition to the port resetting, the TCPCI will veto the next Vconn swap
> from occurring.
> 
> Signed-off-by: RD Babiera <rdbabiera@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpci.c            | 11 +++++++++++
>  drivers/usb/typec/tcpm/tcpci_maxim.h      |  1 +
>  drivers/usb/typec/tcpm/tcpci_maxim_core.c | 17 ++++++++++++++++-
>  include/linux/usb/tcpci.h                 |  9 +++++++++
>  include/linux/usb/tcpm.h                  |  9 +++++++++
>  5 files changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index 8ea4ed159a13..40c7b6224c74 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -594,6 +594,16 @@ static bool tcpci_cable_comm_capable(struct tcpc_dev *tcpc)
>  	return tcpci->data->cable_comm_capable;
>  }
>  
> +static bool tcpci_attempt_vconn_swap_discovery(struct tcpc_dev *tcpc)
> +{
> +	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
> +
> +	if (tcpci->data->attempt_vconn_swap_discovery)
> +		return tcpci->data->attempt_vconn_swap_discovery(tcpci, tcpci->data);
> +
> +	return false;
> +}
> +
>  static int tcpci_init(struct tcpc_dev *tcpc)
>  {
>  	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
> @@ -804,6 +814,7 @@ struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data)
>  	tcpci->tcpc.frs_sourcing_vbus = tcpci_frs_sourcing_vbus;
>  	tcpci->tcpc.set_partner_usb_comm_capable = tcpci_set_partner_usb_comm_capable;
>  	tcpci->tcpc.cable_comm_capable = tcpci_cable_comm_capable;
> +	tcpci->tcpc.attempt_vconn_swap_discovery = tcpci_attempt_vconn_swap_discovery;
>  
>  	if (tcpci->data->check_contaminant)
>  		tcpci->tcpc.check_contaminant = tcpci_check_contaminant;
> diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.h b/drivers/usb/typec/tcpm/tcpci_maxim.h
> index 2c1c4d161b0d..78ff3b73ee7e 100644
> --- a/drivers/usb/typec/tcpm/tcpci_maxim.h
> +++ b/drivers/usb/typec/tcpm/tcpci_maxim.h
> @@ -62,6 +62,7 @@ struct max_tcpci_chip {
>  	struct i2c_client *client;
>  	struct tcpm_port *port;
>  	enum contamiant_state contaminant_state;
> +	bool veto_vconn_swap;
>  };
>  
>  static inline int max_tcpci_read16(struct max_tcpci_chip *chip, unsigned int reg, u16 *val)
> diff --git a/drivers/usb/typec/tcpm/tcpci_maxim_core.c b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> index f9f838df43f7..eec3bcec119c 100644
> --- a/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> +++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> @@ -323,8 +323,10 @@ static irqreturn_t _max_tcpci_irq(struct max_tcpci_chip *chip, u16 status)
>  		if (ret < 0)
>  			return ret;
>  
> -		if (reg_status & TCPC_FAULT_STATUS_VCONN_OC)
> +		if (reg_status & TCPC_FAULT_STATUS_VCONN_OC) {
> +			chip->veto_vconn_swap = true;
>  			tcpm_port_error_recovery(chip->port);
> +		}
>  	}
>  
>  	if (status & TCPC_ALERT_EXTND) {
> @@ -458,6 +460,18 @@ static void max_tcpci_check_contaminant(struct tcpci *tcpci, struct tcpci_data *
>  		tcpm_port_clean(chip->port);
>  }
>  
> +static bool max_tcpci_attempt_vconn_swap_discovery(struct tcpci *tcpci, struct tcpci_data *tdata)
> +{
> +	struct max_tcpci_chip *chip = tdata_to_max_tcpci(tdata);
> +
> +	if (chip->veto_vconn_swap) {
> +		chip->veto_vconn_swap = false;
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
>  static int max_tcpci_probe(struct i2c_client *client)
>  {
>  	int ret;
> @@ -493,6 +507,7 @@ static int max_tcpci_probe(struct i2c_client *client)
>  	chip->data.set_partner_usb_comm_capable = max_tcpci_set_partner_usb_comm_capable;
>  	chip->data.check_contaminant = max_tcpci_check_contaminant;
>  	chip->data.cable_comm_capable = true;
> +	chip->data.attempt_vconn_swap_discovery = max_tcpci_attempt_vconn_swap_discovery;
>  
>  	max_tcpci_init_regs(chip);
>  	chip->tcpci = tcpci_register_port(chip->dev, &chip->data);
> diff --git a/include/linux/usb/tcpci.h b/include/linux/usb/tcpci.h
> index 9ed6d62c9c5f..47a86b8a4a50 100644
> --- a/include/linux/usb/tcpci.h
> +++ b/include/linux/usb/tcpci.h
> @@ -201,6 +201,14 @@ struct tcpci;
>   *		toggling state.
>   * @cable_comm_capable
>   *		optional; Set when TCPC can communicate with cable plugs over SOP'
> + * @attempt_vconn_swap_discovery:
> + *		Optional; The callback is called by the TCPM when the result of
> + *		a Discover Identity request indicates that the port partner is
> + *		a receptacle capable of modal operation. Chip level TCPCI drivers
> + *		can implement their own policy to determine if and when a Vconn
> + *		swap following Discover Identity on SOP' occurs.
> + *		Return true when the TCPM is allowed to request a Vconn swap
> + *		after Discovery Identity on SOP.
>   */
>  struct tcpci_data {
>  	struct regmap *regmap;
> @@ -219,6 +227,7 @@ struct tcpci_data {
>  	void (*set_partner_usb_comm_capable)(struct tcpci *tcpci, struct tcpci_data *data,
>  					     bool capable);
>  	void (*check_contaminant)(struct tcpci *tcpci, struct tcpci_data *data);
> +	bool (*attempt_vconn_swap_discovery)(struct tcpci *tcpci, struct tcpci_data *data);
>  };
>  
>  struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data);
> diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
> index 41d1ac9c8bbf..6671427f7eeb 100644
> --- a/include/linux/usb/tcpm.h
> +++ b/include/linux/usb/tcpm.h
> @@ -122,6 +122,14 @@ enum tcpm_transmit_type {
>   * @cable_comm_capable
>   *		Optional; Returns whether cable communication over SOP' is supported
>   *		by the tcpc
> + * @attempt_vconn_swap_discovery:
> + *		Optional; The callback is called by the TCPM when the result of
> + *		a Discover Identity request indicates that the port partner is
> + *		a receptacle capable of modal operation. Chip level TCPCI drivers
> + *		can implement their own policy to determine if and when a Vconn
> + *		swap following Discover Identity on SOP' occurs.
> + *		Return true when the TCPM is allowed to request a Vconn swap
> + *		after Discovery Identity on SOP.
>   */
>  struct tcpc_dev {
>  	struct fwnode_handle *fwnode;
> @@ -158,6 +166,7 @@ struct tcpc_dev {
>  	void (*set_partner_usb_comm_capable)(struct tcpc_dev *dev, bool enable);
>  	void (*check_contaminant)(struct tcpc_dev *dev);
>  	bool (*cable_comm_capable)(struct tcpc_dev *dev);
> +	bool (*attempt_vconn_swap_discovery)(struct tcpc_dev *dev);
>  };
>  
>  struct tcpm_port;
> -- 
> 2.43.0.472.g3155946c3a-goog

-- 
heikki

