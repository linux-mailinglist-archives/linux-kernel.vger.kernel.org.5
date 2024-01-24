Return-Path: <linux-kernel+bounces-37165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0553D83AC38
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 377DA1C215A5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F60131E22;
	Wed, 24 Jan 2024 14:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UPR7gDfu"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E46013172C;
	Wed, 24 Jan 2024 14:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106664; cv=none; b=CSc2f2Q1vg8Z6mfbrqR5SGTUMj/Ul+Fnh/s1AqAi6hvP2oSwebhsrQo9XG2cJcIOdVxaVT8bbArJovyfzR5eiLYh7uE8fatrrtLwoCOBz4fA/vbuFkrM4dUMBDMds4ry5285LLr2Q6LnkowRxO/+ZFr+tD+dMSaSJkq/xIKPA58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106664; c=relaxed/simple;
	bh=ZvKJm/sldQeRiwuP+FZg5ecSvivsElsr2/SHuRuOzBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9v2fFAVybZciOzi50dmTgo4+lDXSsZxGJKX/FPDxBCjnUGBqB/tYTZi3+/A5r/MeQy7hHA4sYFPYtgUDxsxzQgMPNcu/xKccm+IyB4Iyrb9Z8cslJHb7do+dmJjjrSDq/Hk9QYzXLXlgNEZg4TpEB4uWK4KXdulCMo31ksd0x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UPR7gDfu; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706106662; x=1737642662;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZvKJm/sldQeRiwuP+FZg5ecSvivsElsr2/SHuRuOzBU=;
  b=UPR7gDfurQ4/9OqZOUx3+WqVycaNv3qZJyT1nHXI/LrLbPHJ2fI5/v4v
   2m0qH2dguZP75wYokoy9axZwNTDQEdnFWBvUWTGPkQ0MdDOFm8ZKpZKVb
   nHs7lb34x31SCokVJPaPyzu6R5z6i+qEFBb6Y8wd4vYf/c+DrT1uiZWHY
   RN6eB2gbYABWfim8Iijg9cYihuPyNP6oev8J20ERe9YaSrPF8xyx1kILW
   V4haLtpF8o4/a+PVzbJvtI7i3/RkhtUoDQgTqscD5xn7JtvXvHjqGXR84
   7tFFeYJGVlZpB+KC0+j8JOQ0Lnbld/1GuC7ef4HxWkcnYnO4Jj0uVVjVc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="400712685"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="400712685"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 06:30:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="929700627"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="929700627"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 24 Jan 2024 06:30:51 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 24 Jan 2024 16:30:50 +0200
Date: Wed, 24 Jan 2024 16:30:50 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Abhishek Pandit-Subedi <abhishekpandit@google.com>
Cc: linux-usb@vger.kernel.org, pmalani@chromium.org, jthies@google.com,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Saranya Gopal <saranya.gopal@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] usb: typec: ucsi: Get PD revision for partner
Message-ID: <ZbEfGlrcMX56YvqU@kuha.fi.intel.com>
References: <20240123223039.1471557-1-abhishekpandit@google.com>
 <20240123143026.v1.3.Idf7d373c3cbb54058403cb951d644f1f09973d15@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123143026.v1.3.Idf7d373c3cbb54058403cb951d644f1f09973d15@changeid>

Hi Abhishek,

Few nitpicks for this one.

On Tue, Jan 23, 2024 at 02:30:36PM -0800, Abhishek Pandit-Subedi wrote:
> From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> 
> PD major revision for the port partner is described in
> GET_CONNECTOR_CAPABILITY and is only valid on UCSI 2.0 and newer. Update
> the pd_revision on the partner if the UCSI version is 2.0 or newer.
> 
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
> $ cat /sys/class/typec/port2-partner/usb_power_delivery_revision
> 3.0
> 
>  drivers/usb/typec/ucsi/ucsi.c | 25 +++++++++++++++++++++++++
>  drivers/usb/typec/ucsi/ucsi.h |  3 +++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 4edf785d203b..8e0a512853ba 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -782,6 +782,8 @@ static int ucsi_register_partner(struct ucsi_connector *con)
>  	}
>  
>  	desc.usb_pd = pwr_opmode == UCSI_CONSTAT_PWR_OPMODE_PD;
> +	desc.pd_revision =
> +		UCSI_CONCAP_FLAG_PARTNER_PD_MAJOR_REV_AS_BCD(con->cap.flags);

	desc.pd_revision = UCSI_CONCAP_FLAG_PARTNER_PD_MAJOR_REV_AS_BCD(con->cap.flags);

>  	partner = typec_register_partner(con->port, &desc);
>  	if (IS_ERR(partner)) {
> @@ -856,6 +858,28 @@ static void ucsi_partner_change(struct ucsi_connector *con)
>  			con->num, u_role);
>  }
>  
> +static int ucsi_check_connector_capability(struct ucsi_connector *con)
> +{
> +	u64 command;
> +	int ret;
> +
> +	if (!con->partner && !IS_MIN_VERSION_2_0(con->ucsi))
> +		return 0;
> +
> +	command = UCSI_GET_CONNECTOR_CAPABILITY | UCSI_CONNECTOR_NUMBER(con->num);
> +	ret = ucsi_send_command(con->ucsi, command, &con->cap, sizeof(con->cap));
> +	if (ret < 0) {
> +		dev_err(con->ucsi->dev, "GET_CONNECTOR_CAPABILITY failed (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	typec_partner_set_pd_revision(
> +		con->partner,
> +		UCSI_CONCAP_FLAG_PARTNER_PD_MAJOR_REV_AS_BCD(con->cap.flags));

	typec_partner_set_pd_revision(con->partner,
		UCSI_CONCAP_FLAG_PARTNER_PD_MAJOR_REV_AS_BCD(con->cap.flags));

> +
> +	return ret;
> +}
> +
>  static int ucsi_check_connection(struct ucsi_connector *con)
>  {
>  	u8 prev_flags = con->status.flags;
> @@ -925,6 +949,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
>  		if (con->status.flags & UCSI_CONSTAT_CONNECTED) {
>  			ucsi_register_partner(con);
>  			ucsi_partner_task(con, ucsi_check_connection, 1, HZ);
> +			ucsi_partner_task(con, ucsi_check_connector_capability, 1, HZ);
>  
>  			if (UCSI_CONSTAT_PWR_OPMODE(con->status.flags) ==
>  			    UCSI_CONSTAT_PWR_OPMODE_PD)
> diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> index 94b373378f63..5e60328f398e 100644
> --- a/drivers/usb/typec/ucsi/ucsi.h
> +++ b/drivers/usb/typec/ucsi/ucsi.h
> @@ -36,6 +36,9 @@ struct dentry;
>  #define UCSI_BCD_GET_MINOR(_v_)		(((_v_) >> 4) & 0x0F)
>  #define UCSI_BCD_GET_SUBMINOR(_v_)	((_v_) & 0x0F)
>  
> +#define IS_MIN_VERSION(ucsi, min_ver)	((ucsi)->version >= min_ver)

Probable better to use brackets also with that min_ver:

#define IS_MIN_VERSION(ucsi, min_ver)	((ucsi)->version >= (min_ver))

> +#define IS_MIN_VERSION_2_0(ucsi)	IS_MIN_VERSION(ucsi, UCSI_VERSION_2_0)
> +
>  /* Command Status and Connector Change Indication (CCI) bits */
>  #define UCSI_CCI_CONNECTOR(_c_)		(((_c_) & GENMASK(7, 1)) >> 1)
>  #define UCSI_CCI_LENGTH(_c_)		(((_c_) & GENMASK(15, 8)) >> 8)
> -- 
> 2.43.0.429.g432eaa2c6b-goog

thanks,

-- 
heikki

