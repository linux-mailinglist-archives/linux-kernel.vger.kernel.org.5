Return-Path: <linux-kernel+bounces-5292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F38981890C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F31A51F2557D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318831A5A0;
	Tue, 19 Dec 2023 13:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gUvPeHJ8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCC319BD8;
	Tue, 19 Dec 2023 13:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702994079; x=1734530079;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5gQ7r/pmi5wibRZjHmkgsZN5qhQdYc1sTqxinTId8tY=;
  b=gUvPeHJ8PCUiyxOWawSxDPlY9nYnaNjEF1/U5S2d484cV6iEe7J2o0BO
   IeWQWBT43XKC+yQ21JJDzU1yNebPlJkE5KhMmwd+DR/S2bFhkGCPos9BC
   sk2xls4sQ+I5YKl7XmU+NIMmmjk4NGxk6U56/lCgJg1AjtpsQEfVOfg+t
   ON3QIkaelyHgwi6PN1RHLiRZ82tNUKiDCSLldQk584Bae4NEZF7lrFPlt
   KFUTb5EIIocNXQt5qBf2CGaSlk+ZDC+SW4pPqv3favh6afwUmrJa7KfSp
   tLjiaL+aIaYrejWqcHdBdzEsYSp8JEHkXjofOmcI7iUoKQwWXwiRl69HF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="14347790"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="14347790"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 05:54:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="1107357081"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="1107357081"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga005.fm.intel.com with SMTP; 19 Dec 2023 05:54:34 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 19 Dec 2023 15:54:33 +0200
Date: Tue, 19 Dec 2023 15:54:33 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: RD Babiera <rdbabiera@google.com>
Cc: linux@roeck-us.net, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	badhri@google.com, bryan.odonoghue@linaro.org, agross@kernel.org,
	andersson@kernel.org, konrad.dybcio@linaro.org
Subject: Re: [PATCH v2 02/12] usb: typec: altmodes: add svdm version info for
 typec cables
Message-ID: <ZYGgmTr+7bbrjl1T@kuha.fi.intel.com>
References: <20231214230850.379863-14-rdbabiera@google.com>
 <20231214230850.379863-16-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214230850.379863-16-rdbabiera@google.com>

On Thu, Dec 14, 2023 at 11:08:46PM +0000, RD Babiera wrote:
> Add typec_cable_set_svdm_version and typec_get_cable_svdm version symbols.
> Cables can operate under a lower PD revision than the port partner, and the
> max SVDM version is tied to the PD revision. So, typec_cable maintains its
> own svdm_version.
> 
> Add typec_altmode_get_cable_svdm_version to return the cable's negotiated
> svdm_version for altmode drivers to use.
> 
> Signed-off-by: RD Babiera <rdbabiera@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/class.c         | 40 +++++++++++++++++++++++++++++++
>  drivers/usb/typec/class.h         |  1 +
>  include/linux/usb/typec.h         |  3 +++
>  include/linux/usb/typec_altmode.h | 10 ++++++++
>  4 files changed, 54 insertions(+)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 86b5a8414b89..038c6498e683 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -2129,6 +2129,46 @@ int typec_get_negotiated_svdm_version(struct typec_port *port)
>  }
>  EXPORT_SYMBOL_GPL(typec_get_negotiated_svdm_version);
>  
> +/**
> + * typec_get_cable_svdm_version - Get cable negotiated SVDM Version
> + * @port: USB Type-C Port.
> + *
> + * Get the negotiated SVDM Version for the cable. The Version is set to the port
> + * default value based on the PD Revision during cable registration, and updated
> + * after a successful Discover Identity if the negotiated value is less than the
> + * default.
> + *
> + * Returns usb_pd_svdm_ver if the cable has been registered otherwise -ENODEV.
> + */
> +int typec_get_cable_svdm_version(struct typec_port *port)
> +{
> +	enum usb_pd_svdm_ver svdm_version;
> +	struct device *cable_dev;
> +
> +	cable_dev = device_find_child(&port->dev, NULL, cable_match);
> +	if (!cable_dev)
> +		return -ENODEV;
> +
> +	svdm_version = to_typec_cable(cable_dev)->svdm_version;
> +	put_device(cable_dev);
> +
> +	return svdm_version;
> +}
> +EXPORT_SYMBOL_GPL(typec_get_cable_svdm_version);
> +
> +/**
> + * typec_cable_set_svdm_version - Set negotiated Structured VDM (SVDM) Version
> + * @cable: USB Type-C Active Cable that supports SVDM
> + * @svdm_version: Negotiated SVDM Version
> + *
> + * This routine is used to save the negotiated SVDM Version.
> + */
> +void typec_cable_set_svdm_version(struct typec_cable *cable, enum usb_pd_svdm_ver svdm_version)
> +{
> +	cable->svdm_version = svdm_version;
> +}
> +EXPORT_SYMBOL_GPL(typec_cable_set_svdm_version);
> +
>  /**
>   * typec_get_drvdata - Return private driver data pointer
>   * @port: USB Type-C port
> diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
> index c36761ba3f59..759b98355eeb 100644
> --- a/drivers/usb/typec/class.h
> +++ b/drivers/usb/typec/class.h
> @@ -23,6 +23,7 @@ struct typec_cable {
>  	struct usb_pd_identity		*identity;
>  	unsigned int			active:1;
>  	u16				pd_revision; /* 0300H = "3.0" */
> +	enum usb_pd_svdm_ver		svdm_version;
>  };
>  
>  struct typec_partner {
> diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
> index 38f93d72fd1b..b35b427561ab 100644
> --- a/include/linux/usb/typec.h
> +++ b/include/linux/usb/typec.h
> @@ -337,6 +337,9 @@ void typec_partner_set_svdm_version(struct typec_partner *partner,
>  				    enum usb_pd_svdm_ver svdm_version);
>  int typec_get_negotiated_svdm_version(struct typec_port *port);
>  
> +int typec_get_cable_svdm_version(struct typec_port *port);
> +void typec_cable_set_svdm_version(struct typec_cable *cable, enum usb_pd_svdm_ver svdm_version);
> +
>  struct usb_power_delivery *typec_partner_usb_power_delivery_register(struct typec_partner *partner,
>  							struct usb_power_delivery_desc *desc);
>  
> diff --git a/include/linux/usb/typec_altmode.h b/include/linux/usb/typec_altmode.h
> index 72ec8058543a..b3c0866ea70f 100644
> --- a/include/linux/usb/typec_altmode.h
> +++ b/include/linux/usb/typec_altmode.h
> @@ -95,6 +95,16 @@ int typec_cable_altmode_exit(struct typec_altmode *altmode, enum typec_plug_inde
>  int typec_cable_altmode_vdm(struct typec_altmode *altmode, enum typec_plug_index sop,
>  			    const u32 header, const u32 *vdo, int count);
>  
> +/**
> + * typec_altmode_get_cable_svdm_version - Get negotiated SVDM version for cable plug
> + * @altmode: Handle to the alternate mode
> + */
> +static inline int
> +typec_altmode_get_cable_svdm_version(struct typec_altmode *altmode)
> +{
> +	return typec_get_cable_svdm_version(typec_altmode2port(altmode));
> +}
> +
>  /*
>   * These are the connector states (USB, Safe and Alt Mode) defined in USB Type-C
>   * Specification. SVID specific connector states are expected to follow and
> -- 
> 2.43.0.472.g3155946c3a-goog

-- 
heikki

