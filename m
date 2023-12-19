Return-Path: <linux-kernel+bounces-5293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 646DD818912
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AA851C23F65
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0F91A73C;
	Tue, 19 Dec 2023 13:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V2oWBMIw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5131A5A0;
	Tue, 19 Dec 2023 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702994123; x=1734530123;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+wx1Q/itu8M2fGNsNHzaGefWDFg1PjDsGBGv7TE6v74=;
  b=V2oWBMIwV9ANnCjvC8jGaY8G11IJKNoxju+IygT290Dk20QHmUrFoSt8
   ftgfBcbciKd8W0C/MvUGXcNvqTiIWnx4pFgcDXi67LdpZzMt/lAOAQwZz
   JIfBB8187WvUXgU0qVoi2vPDlyzb4LXpsgf1WL8WhIFEXPxepfZthtNCX
   fGpHmiR3uMSnXdGzjGhPmtpK/eUptsPJs+0vRNzsfeFLimXsmj03Uhblk
   iq15WvSLABV1aqTAfg9iZ/7S7ppY0l5YaOtrJeT3OlrfLoUQvTCtdAr94
   PvovRuNyaQa6evgZI74xOmKEXkePWAyd4F4pLwX9B2oJBto2oPkR+Bls5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="394537319"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="394537319"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 05:55:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="894297892"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="894297892"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga002.fm.intel.com with SMTP; 19 Dec 2023 05:55:18 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 19 Dec 2023 15:55:18 +0200
Date: Tue, 19 Dec 2023 15:55:18 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: RD Babiera <rdbabiera@google.com>
Cc: linux@roeck-us.net, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	badhri@google.com, bryan.odonoghue@linaro.org, agross@kernel.org,
	andersson@kernel.org, konrad.dybcio@linaro.org
Subject: Re: [PATCH v2 03/12] usb: typec: tcpci: add cable_comm_capable
 attribute
Message-ID: <ZYGgxs9eEBXPi984@kuha.fi.intel.com>
References: <20231214230850.379863-14-rdbabiera@google.com>
 <20231214230850.379863-17-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214230850.379863-17-rdbabiera@google.com>

On Thu, Dec 14, 2023 at 11:08:47PM +0000, RD Babiera wrote:
> Add cable_comm_capable to tcpci_data for tcpci drivers to indicate that
> the port tcpc is capable of communicating to cables over SOP. A
> corresponding tcpci callback tcpci_cable_comm_capable returns this value.
> The tcpm will primarily use this in later patches to determine if the port
> can transmit and receive SOP' messages.
> 
> Maxim based tcpci drivers are capable of SOP' communication, so the
> cable_comm_capable flag is set to true.
> 
> Signed-off-by: RD Babiera <rdbabiera@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes since v1:
> * Moved tcpm_pd_receive changes to separate patch
> ---
>  drivers/usb/typec/tcpm/tcpci.c            | 8 ++++++++
>  drivers/usb/typec/tcpm/tcpci_maxim_core.c | 1 +
>  include/linux/usb/tcpci.h                 | 3 +++
>  include/linux/usb/tcpm.h                  | 4 ++++
>  4 files changed, 16 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index 0ee3e6e29bb1..1ededbcecc09 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -584,6 +584,13 @@ static int tcpci_pd_transmit(struct tcpc_dev *tcpc, enum tcpm_transmit_type type
>  	return 0;
>  }
>  
> +static bool tcpci_cable_comm_capable(struct tcpc_dev *tcpc)
> +{
> +	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
> +
> +	return tcpci->data->cable_comm_capable;
> +}
> +
>  static int tcpci_init(struct tcpc_dev *tcpc)
>  {
>  	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
> @@ -793,6 +800,7 @@ struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data)
>  	tcpci->tcpc.enable_frs = tcpci_enable_frs;
>  	tcpci->tcpc.frs_sourcing_vbus = tcpci_frs_sourcing_vbus;
>  	tcpci->tcpc.set_partner_usb_comm_capable = tcpci_set_partner_usb_comm_capable;
> +	tcpci->tcpc.cable_comm_capable = tcpci_cable_comm_capable;
>  
>  	if (tcpci->data->check_contaminant)
>  		tcpci->tcpc.check_contaminant = tcpci_check_contaminant;
> diff --git a/drivers/usb/typec/tcpm/tcpci_maxim_core.c b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> index 7fb966fd639b..7b2d4e6e52a2 100644
> --- a/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> +++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> @@ -478,6 +478,7 @@ static int max_tcpci_probe(struct i2c_client *client)
>  	chip->data.vbus_vsafe0v = true;
>  	chip->data.set_partner_usb_comm_capable = max_tcpci_set_partner_usb_comm_capable;
>  	chip->data.check_contaminant = max_tcpci_check_contaminant;
> +	chip->data.cable_comm_capable = true;
>  
>  	max_tcpci_init_regs(chip);
>  	chip->tcpci = tcpci_register_port(chip->dev, &chip->data);
> diff --git a/include/linux/usb/tcpci.h b/include/linux/usb/tcpci.h
> index 467e8045e9f8..1d0b849defd0 100644
> --- a/include/linux/usb/tcpci.h
> +++ b/include/linux/usb/tcpci.h
> @@ -198,12 +198,15 @@ struct tcpci;
>   *		Chip level drivers are expected to check for contaminant and call
>   *		tcpm_clean_port when the port is clean to put the port back into
>   *		toggling state.
> + * @cable_comm_capable
> + *		optional; Set when TCPC can communicate with cable plugs over SOP'
>   */
>  struct tcpci_data {
>  	struct regmap *regmap;
>  	unsigned char TX_BUF_BYTE_x_hidden:1;
>  	unsigned char auto_discharge_disconnect:1;
>  	unsigned char vbus_vsafe0v:1;
> +	unsigned char cable_comm_capable:1;
>  
>  	int (*init)(struct tcpci *tcpci, struct tcpci_data *data);
>  	int (*set_vconn)(struct tcpci *tcpci, struct tcpci_data *data,
> diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
> index 65fac5e1f317..430fa3ec69bb 100644
> --- a/include/linux/usb/tcpm.h
> +++ b/include/linux/usb/tcpm.h
> @@ -119,6 +119,9 @@ enum tcpm_transmit_type {
>   *		at the end of the deboumce period or when the port is still
>   *		toggling. Chip level drivers are expected to check for contaminant
>   *		and call tcpm_clean_port when the port is clean.
> + * @cable_comm_capable
> + *		Optional; Returns whether cable communication over SOP' is supported
> + *		by the tcpc
>   */
>  struct tcpc_dev {
>  	struct fwnode_handle *fwnode;
> @@ -154,6 +157,7 @@ struct tcpc_dev {
>  	bool (*is_vbus_vsafe0v)(struct tcpc_dev *dev);
>  	void (*set_partner_usb_comm_capable)(struct tcpc_dev *dev, bool enable);
>  	void (*check_contaminant)(struct tcpc_dev *dev);
> +	bool (*cable_comm_capable)(struct tcpc_dev *dev);
>  };
>  
>  struct tcpm_port;
> -- 
> 2.43.0.472.g3155946c3a-goog

-- 
heikki

