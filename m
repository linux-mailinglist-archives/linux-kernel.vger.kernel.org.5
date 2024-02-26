Return-Path: <linux-kernel+bounces-81007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE129866EEA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 537931F2700A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9587AE7D;
	Mon, 26 Feb 2024 09:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UyEmmUbQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F0A7AE60;
	Mon, 26 Feb 2024 09:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708938469; cv=none; b=kjpgbQYej1Gvoh5s4ab9rhXpX537TIkO/nMZIizQHjOuTZZFvNQtrgREDNtPVPwHofzS3wRAg9eGT2PnA159q9QuJQnKwZ5CyzDp84s4/T4QyzFUXxicUUNrvQR3VtXZbR5/I7sDM0RaOInNH1kupFKIs4fuKmIJO/be0ojYpvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708938469; c=relaxed/simple;
	bh=0h+QPYCBOa+lFPOYm0hdCnXgUZg87EDE2Bud1O1gZnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+M//Q5Y7qDjPgIyBsJOhwxzms7ZxinNi9lTxy7fB8Iz1tFu3jxMmJ3gb0jflgP10nUWKtr4ZKnLWHQ4GLIIzeEvFu9M3t4MVk8/lN7vUq4QgZHR+w4mjyQzv9mBHXubZa6AwWA/zrTcSPf/Qs98+cC1A9quS26Cze/YRLY/1fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UyEmmUbQ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708938468; x=1740474468;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0h+QPYCBOa+lFPOYm0hdCnXgUZg87EDE2Bud1O1gZnM=;
  b=UyEmmUbQcx2alXDSza9abyTwJXC4VpdY1EZGV/RJWhLHwRhNJQwa57iT
   h/2OXTyHVqUZ7wVd53GsOSBRCFkT8jrCvpXpUSVwAehT8XVdwpwq2b6Xv
   oNAaSQYz7QxK1IjccU3nuwjAdCvhGIgkPuIpxwcnZP278CBVWWWMNHmkx
   R1SrVf0ak805Ppo1wb3YMFNgK0ODtq6pOlv7MgCc+sdZeTMYTHS1w8dcv
   ORI9WCASTX0S2xU2ygsbpBwHwAByl3SbmgXDHKN7yS2GMyjOEHEvxt8rZ
   UYidCowZz1Ltyx/WN5AKmBSw2ObNhSJvWsC8RwISCqCncpHGOxTZ5iMRO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="6997880"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6997880"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 01:07:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="937029627"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="937029627"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 26 Feb 2024 01:07:42 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 26 Feb 2024 11:07:41 +0200
Date: Mon, 26 Feb 2024 11:07:41 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Jameson Thies <jthies@google.com>
Cc: linux-usb@vger.kernel.org, pmalani@chromium.org, bleung@google.com,
	abhishekpandit@chromium.org, andersson@kernel.org,
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com,
	gregkh@linuxfoundation.org, hdegoede@redhat.com,
	neil.armstrong@linaro.org, rajaram.regupathy@intel.com,
	saranya.gopal@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] usb: typec: ucsi: Register SOP' alternate modes with
 cable plug
Message-ID: <ZdxU3dB2/GVlxWFe@kuha.fi.intel.com>
References: <20240223010328.2826774-1-jthies@google.com>
 <20240223010328.2826774-5-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223010328.2826774-5-jthies@google.com>

On Fri, Feb 23, 2024 at 01:03:28AM +0000, Jameson Thies wrote:
> Register SOP' alternate modes with a Type-C Connector Class cable plug.
> Alternate modes are queried from the PPM using the GET_ALTERNATE_MODES
> command with recipient set to SOP'.
> 
> Signed-off-by: Jameson Thies <jthies@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Tested on v6.6 kernel. SOP' GET_ALTERNATE_MODE responses from the PPM
> are correctly registered as to the cable plug.
> redrix-rev3 /sys/class/typec # ls port2-cable/port2-plug0/
> device  port2-plug0.0  port2-plug0.1  power  subsystem  uevent
> 
>  drivers/usb/typec/ucsi/ucsi.c | 60 +++++++++++++++++++++++++++++++++++
>  drivers/usb/typec/ucsi/ucsi.h |  2 ++
>  2 files changed, 62 insertions(+)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 6d6443e61faa..9b541547917b 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -399,6 +399,27 @@ static int ucsi_register_altmode(struct ucsi_connector *con,
>  
>  		con->partner_altmode[i] = alt;
>  		break;
> +	case UCSI_RECIPIENT_SOP_P:
> +		i = ucsi_next_altmode(con->plug_altmode);
> +		if (i < 0) {
> +			ret = i;
> +			goto err;
> +		}
> +
> +		ret = ucsi_altmode_next_mode(con->plug_altmode, desc->svid);
> +		if (ret < 0)
> +			return ret;
> +
> +		desc->mode = ret;
> +
> +		alt = typec_plug_register_altmode(con->plug, desc);
> +		if (IS_ERR(alt)) {
> +			ret = PTR_ERR(alt);
> +			goto err;
> +		}
> +
> +		con->plug_altmode[i] = alt;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -566,6 +587,9 @@ static void ucsi_unregister_altmodes(struct ucsi_connector *con, u8 recipient)
>  	case UCSI_RECIPIENT_SOP:
>  		adev = con->partner_altmode;
>  		break;
> +	case UCSI_RECIPIENT_SOP_P:
> +		adev = con->plug_altmode;
> +		break;
>  	default:
>  		return;
>  	}
> @@ -801,6 +825,33 @@ static void ucsi_unregister_partner_pdos(struct ucsi_connector *con)
>  	con->partner_pd = NULL;
>  }
>  
> +static int ucsi_register_plug(struct ucsi_connector *con)
> +{
> +	struct typec_plug *plug;
> +	struct typec_plug_desc desc = {.index = TYPEC_PLUG_SOP_P};
> +
> +	plug = typec_register_plug(con->cable, &desc);
> +	if (IS_ERR(plug)) {
> +		dev_err(con->ucsi->dev,
> +			"con%d: failed to register plug (%ld)\n", con->num,
> +			PTR_ERR(plug));
> +		return PTR_ERR(plug);
> +	}
> +
> +	con->plug = plug;
> +	return 0;
> +}
> +
> +static void ucsi_unregister_plug(struct ucsi_connector *con)
> +{
> +	if (!con->plug)
> +		return;
> +
> +	ucsi_unregister_altmodes(con, UCSI_RECIPIENT_SOP_P);
> +	typec_unregister_plug(con->plug);
> +	con->plug = NULL;
> +}
> +
>  static int ucsi_register_cable(struct ucsi_connector *con)
>  {
>  	struct typec_cable *cable;
> @@ -842,6 +893,7 @@ static void ucsi_unregister_cable(struct ucsi_connector *con)
>  	if (!con->cable)
>  		return;
>  
> +	ucsi_unregister_plug(con);
>  	typec_unregister_cable(con->cable);
>  	con->cable = NULL;
>  	memset(&con->cable_identity, 0, sizeof(con->cable_identity));
> @@ -1046,6 +1098,14 @@ static int ucsi_check_cable(struct ucsi_connector *con)
>  	if (ret < 0)
>  		return ret;
>  
> +	ret = ucsi_register_plug(con);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ucsi_register_altmodes(con, UCSI_RECIPIENT_SOP_P);
> +	if (ret < 0)
> +		return ret;
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> index b89fae82e8ce..32daf5f58650 100644
> --- a/drivers/usb/typec/ucsi/ucsi.h
> +++ b/drivers/usb/typec/ucsi/ucsi.h
> @@ -429,9 +429,11 @@ struct ucsi_connector {
>  	struct typec_port *port;
>  	struct typec_partner *partner;
>  	struct typec_cable *cable;
> +	struct typec_plug *plug;
>  
>  	struct typec_altmode *port_altmode[UCSI_MAX_ALTMODES];
>  	struct typec_altmode *partner_altmode[UCSI_MAX_ALTMODES];
> +	struct typec_altmode *plug_altmode[UCSI_MAX_ALTMODES];
>  
>  	struct typec_capability typec_cap;
>  
> -- 
> 2.44.0.rc0.258.g7320e95886-goog

-- 
heikki

