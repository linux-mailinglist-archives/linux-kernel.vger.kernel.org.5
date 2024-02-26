Return-Path: <linux-kernel+bounces-81005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09222866EE3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DE0A1F26943
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C3A7A700;
	Mon, 26 Feb 2024 09:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XOBc0yUZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A1921A14;
	Mon, 26 Feb 2024 09:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708938340; cv=none; b=E2cYkvMiazkm2Do1as/b0mb24m6+Ki+lMp1mZiI1brHYZftPh1Bg5fqUdA+qlipS8PQGq3Mm6MMbGNKTDhagQvkUJ34UDnEAbY6VCO7XfHEgTqPxxErX7qJubqtqt9VKho6kKTNXlhiP+qCtNWNI8A4nxyFsZZAEV0E25KnR0Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708938340; c=relaxed/simple;
	bh=S8gKWyE7cMaxsz53QmeYdf2C4bKVTLAnugHHvwdiP9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVvLf2CYWmPDB0+wZHHFy8MAbbaUB33A/kJusVijH1dEJlMOUf8MVvqFmF+XyhGqAza61iSeIJ4DAaVrokXSDwqpAn/YCYIVLORk3K5NWpjcsU97AG8/wnk6Bo55ZTsoX42gf2mEJ82bN9wRZEE7UoJnKNYFGiMhoiTAmQj56wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XOBc0yUZ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708938339; x=1740474339;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S8gKWyE7cMaxsz53QmeYdf2C4bKVTLAnugHHvwdiP9s=;
  b=XOBc0yUZXTFR3LvjFuV8zo39tRbmqM37EK8/zZc64JchVzQ08sYNyxXE
   jNJE+A3XXFgYkUwWGyUcfcpSq8TNYAaYx9e7rDG5wRy3nMf6r5c9X8Zwv
   rT185w10wOFuiOsc/cV7GCkz+3F2VbHxLNmKcCtX6V1sRPDncvwxfaKhO
   3r9SXlv0Xoul66zIlqq+kq5EnDCmVZkEaLEhrdlUeFn/iwmcbHzkEhNiM
   j2wp3YgbStY9wbJ288HEM1BXKv10xVoL6VSagjLlMGy1r9eHCXtpQrr0V
   u01Z5f6DtdaIp+wp96MdEvqJA6DcVRMhGu9jAPITxZhxWGy8QF8zG0KUG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="6997608"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6997608"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 01:05:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="937029619"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="937029619"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 26 Feb 2024 01:05:33 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 26 Feb 2024 11:05:32 +0200
Date: Mon, 26 Feb 2024 11:05:32 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Jameson Thies <jthies@google.com>
Cc: linux-usb@vger.kernel.org, pmalani@chromium.org, bleung@google.com,
	abhishekpandit@chromium.org, andersson@kernel.org,
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com,
	gregkh@linuxfoundation.org, hdegoede@redhat.com,
	neil.armstrong@linaro.org, rajaram.regupathy@intel.com,
	saranya.gopal@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] usb: typec: ucsi: Register cables based on
 GET_CABLE_PROPERTY
Message-ID: <ZdxUXPX1mT8JUxtT@kuha.fi.intel.com>
References: <20240223010328.2826774-1-jthies@google.com>
 <20240223010328.2826774-3-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223010328.2826774-3-jthies@google.com>

On Fri, Feb 23, 2024 at 01:03:26AM +0000, Jameson Thies wrote:
> Register cables with the Type-C Connector Class in the UCSI driver based
> on the PPM response to GET_CABLE_PROPERTY. Registered cable properties
> include plug type, cable type and major revision.
> 
> Signed-off-by: Jameson Thies <jthies@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Tested on v6.6 kernel. Expected cable properties populate the USB Type-C
> connector class sysfs paths:
> redrix-rev3 /sys/class/typec # ls port2-cable
> device  identity  plug_type  port2-plug0  power  subsystem  type  uevent
> usb_power_delivery_revision
> 
>  drivers/usb/typec/ucsi/ucsi.c | 69 +++++++++++++++++++++++++++++++++++
>  drivers/usb/typec/ucsi/ucsi.h |  5 +++
>  2 files changed, 74 insertions(+)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index ae105383e69e..15e82f5fab37 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -734,6 +734,50 @@ static void ucsi_unregister_partner_pdos(struct ucsi_connector *con)
>  	con->partner_pd = NULL;
>  }
>  
> +static int ucsi_register_cable(struct ucsi_connector *con)
> +{
> +	struct typec_cable *cable;
> +	struct typec_cable_desc desc = {};
> +
> +	switch (UCSI_CABLE_PROP_FLAG_PLUG_TYPE(con->cable_prop.flags)) {
> +	case UCSI_CABLE_PROPERTY_PLUG_TYPE_A:
> +		desc.type = USB_PLUG_TYPE_A;
> +		break;
> +	case UCSI_CABLE_PROPERTY_PLUG_TYPE_B:
> +		desc.type = USB_PLUG_TYPE_B;
> +		break;
> +	case UCSI_CABLE_PROPERTY_PLUG_TYPE_C:
> +		desc.type = USB_PLUG_TYPE_C;
> +		break;
> +	default:
> +		desc.type = USB_PLUG_NONE;
> +		break;
> +	}
> +
> +	desc.active = !!(UCSI_CABLE_PROP_FLAG_ACTIVE_CABLE & con->cable_prop.flags);
> +	desc.pd_revision = UCSI_CABLE_PROP_FLAG_PD_MAJOR_REV_AS_BCD(con->cable_prop.flags);
> +
> +	cable = typec_register_cable(con->port, &desc);
> +	if (IS_ERR(cable)) {
> +		dev_err(con->ucsi->dev,
> +			"con%d: failed to register cable (%ld)\n", con->num,
> +			PTR_ERR(cable));
> +		return PTR_ERR(cable);
> +	}
> +
> +	con->cable = cable;
> +	return 0;
> +}
> +
> +static void ucsi_unregister_cable(struct ucsi_connector *con)
> +{
> +	if (!con->cable)
> +		return;
> +
> +	typec_unregister_cable(con->cable);
> +	con->cable = NULL;
> +}
> +
>  static void ucsi_pwr_opmode_change(struct ucsi_connector *con)
>  {
>  	switch (UCSI_CONSTAT_PWR_OPMODE(con->status.flags)) {
> @@ -807,6 +851,7 @@ static void ucsi_unregister_partner(struct ucsi_connector *con)
>  	typec_partner_set_usb_power_delivery(con->partner, NULL);
>  	ucsi_unregister_partner_pdos(con);
>  	ucsi_unregister_altmodes(con, UCSI_RECIPIENT_SOP);
> +	ucsi_unregister_cable(con);
>  	typec_unregister_partner(con->partner);
>  	con->partner = NULL;
>  }
> @@ -907,6 +952,28 @@ static int ucsi_check_connection(struct ucsi_connector *con)
>  	return 0;
>  }
>  
> +static int ucsi_check_cable(struct ucsi_connector *con)
> +{
> +	u64 command;
> +	int ret;
> +
> +	if (con->cable)
> +		return 0;
> +
> +	command = UCSI_GET_CABLE_PROPERTY | UCSI_CONNECTOR_NUMBER(con->num);
> +	ret = ucsi_send_command(con->ucsi, command, &con->cable_prop, sizeof(con->cable_prop));
> +	if (ret < 0) {
> +		dev_err(con->ucsi->dev, "GET_CABLE_PROPERTY failed (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	ret = ucsi_register_cable(con);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
>  static void ucsi_handle_connector_change(struct work_struct *work)
>  {
>  	struct ucsi_connector *con = container_of(work, struct ucsi_connector,
> @@ -948,6 +1015,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
>  			ucsi_register_partner(con);
>  			ucsi_partner_task(con, ucsi_check_connection, 1, HZ);
>  			ucsi_partner_task(con, ucsi_check_connector_capability, 1, HZ);
> +			ucsi_partner_task(con, ucsi_check_cable, 1, HZ);
>  
>  			if (UCSI_CONSTAT_PWR_OPMODE(con->status.flags) ==
>  			    UCSI_CONSTAT_PWR_OPMODE_PD)
> @@ -1346,6 +1414,7 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
>  		ucsi_register_partner(con);
>  		ucsi_pwr_opmode_change(con);
>  		ucsi_port_psy_changed(con);
> +		ucsi_check_cable(con);
>  	}
>  
>  	/* Only notify USB controller if partner supports USB data */
> diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> index 469a2baf472e..f0aabef0b7c6 100644
> --- a/drivers/usb/typec/ucsi/ucsi.h
> +++ b/drivers/usb/typec/ucsi/ucsi.h
> @@ -265,6 +265,9 @@ struct ucsi_cable_property {
>  #define   UCSI_CABLE_PROPERTY_PLUG_TYPE_C	2
>  #define   UCSI_CABLE_PROPERTY_PLUG_OTHER	3
>  #define UCSI_CABLE_PROP_FLAG_MODE_SUPPORT	BIT(5)
> +#define UCSI_CABLE_PROP_FLAG_PD_MAJOR_REV(_f_)	(((_f_) & GENMASK(7, 6)) >> 6)
> +#define UCSI_CABLE_PROP_FLAG_PD_MAJOR_REV_AS_BCD(_f_) \
> +	UCSI_SPEC_REVISION_TO_BCD(UCSI_CABLE_PROP_FLAG_PD_MAJOR_REV(_f_))
>  	u8 latency;
>  } __packed;
>  
> @@ -400,6 +403,7 @@ struct ucsi_connector {
>  
>  	struct typec_port *port;
>  	struct typec_partner *partner;
> +	struct typec_cable *cable;
>  
>  	struct typec_altmode *port_altmode[UCSI_MAX_ALTMODES];
>  	struct typec_altmode *partner_altmode[UCSI_MAX_ALTMODES];
> @@ -408,6 +412,7 @@ struct ucsi_connector {
>  
>  	struct ucsi_connector_status status;
>  	struct ucsi_connector_capability cap;
> +	struct ucsi_cable_property cable_prop;
>  	struct power_supply *psy;
>  	struct power_supply_desc psy_desc;
>  	u32 rdo;
> -- 
> 2.44.0.rc0.258.g7320e95886-goog

-- 
heikki

