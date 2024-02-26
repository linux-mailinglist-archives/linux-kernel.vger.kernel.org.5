Return-Path: <linux-kernel+bounces-81006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54375866EE8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B50FC1F26B36
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0319A7AE4E;
	Mon, 26 Feb 2024 09:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eGBgYzeD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD4C1C292;
	Mon, 26 Feb 2024 09:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708938423; cv=none; b=J1A08YikPw5AANH2P5GgM/rVdVGRLaJRlaVUqq5REv6IgndvoPHmVhx1VOmP0hOO/sdwbZKp8RwZa7dmoF5GjK4mrhL+hJqfc9gq/rijqDFKCTrp+j3tOvcfw29g6XZXXAoqPKWJCdpDwTYDHlJ2iHJBWik/TJF1QTzWJqVJ5wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708938423; c=relaxed/simple;
	bh=PxVSJM8IltCM28qJWE+APNDV9QG3SdAEpx5yqt5EDaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8KnhVWoi9CpegzadA9t280QT59zxoRl49fH/84tGSNdEI5ZNnNBw/fA3AI47XJ+lYxEEKKSw+Lu8TNiKXtEGs5ciWZ5Lc+Jq2HoPIqH7GiHNfSPGZO1YZX4HKc3AW+1i9iwRuv0AYjZOOLIhJGXNzBZZIMmTom07HKh3Bp7UNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eGBgYzeD; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708938421; x=1740474421;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PxVSJM8IltCM28qJWE+APNDV9QG3SdAEpx5yqt5EDaA=;
  b=eGBgYzeDUr45yMkQgJH5TJQpXMcC2bSxqrgcYXbZ+aWx7Lh5u2YuLso5
   9Q/oOfpyAPSEP247dcPttZm42Hw99ABf0WsKlI0JOW4iD+tsXqpQN52hY
   2logInPT67c5K7+WKdDZsg1PIYlQz35ri/6kLResnB3p6EdoeXgoilHEI
   NPjo5bSL9BpuvkyUNpr7N1JSXdtXhZyI66I+uh15kqjxA7MnJ7Mmbx0he
   B92Sq8S4zK0y8EYvhg3DOm8fU9rLCzU7/cZUynt4lKgJLzOMepIWBohJW
   Cln8lGWj98XwwHLUVx5SRWwjdKTLZ91sQql62xxQU3MOxJbdP+PJ5RBXz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="6997776"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6997776"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 01:07:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="937029624"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="937029624"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 26 Feb 2024 01:06:56 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 26 Feb 2024 11:06:55 +0200
Date: Mon, 26 Feb 2024 11:06:55 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Jameson Thies <jthies@google.com>
Cc: linux-usb@vger.kernel.org, pmalani@chromium.org, bleung@google.com,
	abhishekpandit@chromium.org, andersson@kernel.org,
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com,
	gregkh@linuxfoundation.org, hdegoede@redhat.com,
	neil.armstrong@linaro.org, rajaram.regupathy@intel.com,
	saranya.gopal@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] usb: typec: ucsi: Register SOP/SOP' Discover
 Identity Responses
Message-ID: <ZdxUr/ibI9tPdvjn@kuha.fi.intel.com>
References: <20240223010328.2826774-1-jthies@google.com>
 <20240223010328.2826774-4-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223010328.2826774-4-jthies@google.com>

On Fri, Feb 23, 2024 at 01:03:27AM +0000, Jameson Thies wrote:
> Register SOP and SOP' Discover Identity responses with the USB Type-C
> Connector Class as partner and cable identities, respectively. Discover
> Identity responses are requested from the PPM using the GET_PD_MESSAGE
> UCSI command.
> 
> Signed-off-by: Jameson Thies <jthies@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Tested on v6.6 kernel. GET_PD_MESSAGE responses from the PPM populate
> partner and cable identity in sysfs.
> redrix-rev3 /sys/class/typec # ls port2-partner/identity/
> cert_stat  id_header  product  product_type_vdo1  product_type_vdo2
> product_type_vdo3
> redrix-rev3 /sys/class/typec # ls port2-cable/identity/
> cert_stat  id_header  product  product_type_vdo1  product_type_vdo2
> product_type_vdo3
> 
>  drivers/usb/typec/ucsi/ucsi.c | 77 +++++++++++++++++++++++++++++++++++
>  drivers/usb/typec/ucsi/ucsi.h | 29 +++++++++++++
>  2 files changed, 106 insertions(+)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 15e82f5fab37..6d6443e61faa 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -646,6 +646,73 @@ static int ucsi_get_src_pdos(struct ucsi_connector *con)
>  	return ret;
>  }
>  
> +static int ucsi_read_identity(struct ucsi_connector *con, u8 recipient, struct usb_pd_identity *id)
> +{
> +	struct ucsi *ucsi = con->ucsi;
> +	struct ucsi_pd_message_disc_id resp = {};
> +	u64 command;
> +	int ret;
> +
> +	/*
> +	 * Skip identity discovery and registration if UCSI version is less than
> +	 * v2.0. Before v2.0 MESSAGE_IN is 16 bytes which cannot fit a complete
> +	 * 24 byte identity response.
> +	 */
> +	if (ucsi->version < UCSI_VERSION_2_0)
> +		return -EPROTO;
> +
> +	command = UCSI_COMMAND(UCSI_GET_PD_MESSAGE) | UCSI_CONNECTOR_NUMBER(con->num);
> +	command |= UCSI_GET_PD_MESSAGE_RECIPIENT(recipient);
> +	/* VDM Header + 6 VDOs (0x1c bytes) without an offset */
> +	command |= UCSI_GET_PD_MESSAGE_OFFSET(0);
> +	command |= UCSI_GET_PD_MESSAGE_BYTES(0x1c);
> +	command |= UCSI_GET_PD_MESSAGE_TYPE(UCSI_GET_PD_MESSAGE_TYPE_IDENTITY);
> +
> +	ret = ucsi_send_command(ucsi, command, &resp, sizeof(resp));
> +	if (ret < 0) {
> +		dev_err(ucsi->dev, "UCSI_GET_PD_MESSAGE failed (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	id->id_header = resp.id_header;
> +	id->cert_stat = resp.cert_stat;
> +	id->product = resp.product;
> +	id->vdo[0] = resp.vdo[0];
> +	id->vdo[1] = resp.vdo[1];
> +	id->vdo[2] = resp.vdo[2];
> +	return 0;
> +}
> +
> +static int ucsi_get_partner_identity(struct ucsi_connector *con)
> +{
> +	int ret;
> +
> +	ret = ucsi_read_identity(con, UCSI_RECIPIENT_SOP, &con->partner_identity);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = typec_partner_set_identity(con->partner);
> +	if (ret < 0)
> +		dev_err(con->ucsi->dev, "Failed to set partner identity (%d)\n", ret);
> +
> +	return ret;
> +}
> +
> +static int ucsi_get_cable_identity(struct ucsi_connector *con)
> +{
> +	int ret;
> +
> +	ret = ucsi_read_identity(con, UCSI_RECIPIENT_SOP_P, &con->cable_identity);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = typec_cable_set_identity(con->cable);
> +	if (ret < 0)
> +		dev_err(con->ucsi->dev, "Failed to set cable identity (%d)\n", ret);
> +
> +	return ret;
> +}
> +
>  static int ucsi_check_altmodes(struct ucsi_connector *con)
>  {
>  	int ret, num_partner_am;
> @@ -754,6 +821,7 @@ static int ucsi_register_cable(struct ucsi_connector *con)
>  		break;
>  	}
>  
> +	desc.identity = &con->cable_identity;
>  	desc.active = !!(UCSI_CABLE_PROP_FLAG_ACTIVE_CABLE & con->cable_prop.flags);
>  	desc.pd_revision = UCSI_CABLE_PROP_FLAG_PD_MAJOR_REV_AS_BCD(con->cable_prop.flags);
>  
> @@ -776,6 +844,7 @@ static void ucsi_unregister_cable(struct ucsi_connector *con)
>  
>  	typec_unregister_cable(con->cable);
>  	con->cable = NULL;
> +	memset(&con->cable_identity, 0, sizeof(con->cable_identity));
>  }
>  
>  static void ucsi_pwr_opmode_change(struct ucsi_connector *con)
> @@ -825,6 +894,7 @@ static int ucsi_register_partner(struct ucsi_connector *con)
>  		break;
>  	}
>  
> +	desc.identity = &con->partner_identity;
>  	desc.usb_pd = pwr_opmode == UCSI_CONSTAT_PWR_OPMODE_PD;
>  	desc.pd_revision = UCSI_CONCAP_FLAG_PARTNER_PD_MAJOR_REV_AS_BCD(con->cap.flags);
>  
> @@ -854,6 +924,7 @@ static void ucsi_unregister_partner(struct ucsi_connector *con)
>  	ucsi_unregister_cable(con);
>  	typec_unregister_partner(con->partner);
>  	con->partner = NULL;
> +	memset(&con->partner_identity, 0, sizeof(con->partner_identity));
>  }
>  
>  static void ucsi_partner_change(struct ucsi_connector *con)
> @@ -971,6 +1042,10 @@ static int ucsi_check_cable(struct ucsi_connector *con)
>  	if (ret < 0)
>  		return ret;
>  
> +	ret = ucsi_get_cable_identity(con);
> +	if (ret < 0)
> +		return ret;
> +
>  	return 0;
>  }
>  
> @@ -1015,6 +1090,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
>  			ucsi_register_partner(con);
>  			ucsi_partner_task(con, ucsi_check_connection, 1, HZ);
>  			ucsi_partner_task(con, ucsi_check_connector_capability, 1, HZ);
> +			ucsi_partner_task(con, ucsi_get_partner_identity, 1, HZ);
>  			ucsi_partner_task(con, ucsi_check_cable, 1, HZ);
>  
>  			if (UCSI_CONSTAT_PWR_OPMODE(con->status.flags) ==
> @@ -1414,6 +1490,7 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
>  		ucsi_register_partner(con);
>  		ucsi_pwr_opmode_change(con);
>  		ucsi_port_psy_changed(con);
> +		ucsi_get_partner_identity(con);
>  		ucsi_check_cable(con);
>  	}
>  
> diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> index f0aabef0b7c6..b89fae82e8ce 100644
> --- a/drivers/usb/typec/ucsi/ucsi.h
> +++ b/drivers/usb/typec/ucsi/ucsi.h
> @@ -106,6 +106,7 @@ void ucsi_connector_change(struct ucsi *ucsi, u8 num);
>  #define UCSI_GET_CABLE_PROPERTY		0x11
>  #define UCSI_GET_CONNECTOR_STATUS	0x12
>  #define UCSI_GET_ERROR_STATUS		0x13
> +#define UCSI_GET_PD_MESSAGE		0x15
>  
>  #define UCSI_CONNECTOR_NUMBER(_num_)		((u64)(_num_) << 16)
>  #define UCSI_COMMAND(_cmd_)			((_cmd_) & 0xff)
> @@ -159,6 +160,18 @@ void ucsi_connector_change(struct ucsi *ucsi, u8 num);
>  #define UCSI_MAX_PDOS				(4)
>  #define UCSI_GET_PDOS_SRC_PDOS			((u64)1 << 34)
>  
> +/* GET_PD_MESSAGE command bits */
> +#define UCSI_GET_PD_MESSAGE_RECIPIENT(_r_)	((u64)(_r_) << 23)
> +#define UCSI_GET_PD_MESSAGE_OFFSET(_r_)		((u64)(_r_) << 26)
> +#define UCSI_GET_PD_MESSAGE_BYTES(_r_)		((u64)(_r_) << 34)
> +#define UCSI_GET_PD_MESSAGE_TYPE(_r_)		((u64)(_r_) << 42)
> +#define   UCSI_GET_PD_MESSAGE_TYPE_SNK_CAP_EXT	0
> +#define   UCSI_GET_PD_MESSAGE_TYPE_SRC_CAP_EXT	1
> +#define   UCSI_GET_PD_MESSAGE_TYPE_BAT_CAP	2
> +#define   UCSI_GET_PD_MESSAGE_TYPE_BAT_STAT	3
> +#define   UCSI_GET_PD_MESSAGE_TYPE_IDENTITY	4
> +#define   UCSI_GET_PD_MESSAGE_TYPE_REVISION	5
> +
>  /* -------------------------------------------------------------------------- */
>  
>  /* Error information returned by PPM in response to GET_ERROR_STATUS command. */
> @@ -338,6 +351,18 @@ struct ucsi_connector_status {
>  	((get_unaligned_le32(&(_p_)[5]) & GENMASK(16, 1)) >> 1)
>  } __packed;
>  
> +/*
> + * Data structure filled by PPM in response to GET_PD_MESSAGE command with the
> + * Response Message Type set to Discover Identity Response.
> + */
> +struct ucsi_pd_message_disc_id {
> +	u32 vdm_header;
> +	u32 id_header;
> +	u32 cert_stat;
> +	u32 product;
> +	u32 vdo[3];
> +} __packed;
> +
>  /* -------------------------------------------------------------------------- */
>  
>  struct ucsi_debugfs_entry {
> @@ -428,6 +453,10 @@ struct ucsi_connector {
>  	struct usb_power_delivery_capabilities *partner_sink_caps;
>  
>  	struct usb_role_switch *usb_role_sw;
> +
> +	/* USB PD identity */
> +	struct usb_pd_identity partner_identity;
> +	struct usb_pd_identity cable_identity;
>  };
>  
>  int ucsi_send_command(struct ucsi *ucsi, u64 command,
> -- 
> 2.44.0.rc0.258.g7320e95886-goog

-- 
heikki

