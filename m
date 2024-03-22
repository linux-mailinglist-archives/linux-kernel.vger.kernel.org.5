Return-Path: <linux-kernel+bounces-111271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD9E8869EE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8ECC1C243F1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D898F288AE;
	Fri, 22 Mar 2024 10:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cTBjg6PG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD702D78A;
	Fri, 22 Mar 2024 10:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711102011; cv=none; b=R9KRoQvJx+e/fUJzogEaWNUa0Fbaa3AoCeVvmxcq5+PgK8pSI8CFSC9nJif/maSfHBp8kWq0n3ZLBj4Gl8d6OGHfriYdyfg633M6+JzCVru/WxHeTigpPV4wh6QivUs6XsPpGW38FGPbzIiv2JhABV00KvOmL2jmFPr+1hZroN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711102011; c=relaxed/simple;
	bh=DBMidGRbt2hOCRudWUM91w11Hu7XZpYXaJPG/atgNP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHw9nl+ihvzwjU9nhuU3exlsSmRXX9yG6G0sgPDfO7w3b8FulRpjsYGnuZ9SU5VDL/biZaPItUoHuskAEEbqymTNTAtzOtLN4MRpERQ+oc+7W87sVgA2DG8tzerBRQQpefLacRX/M/AIZ4RAp0XnJcYlVNXbtyQrLpJaOlTtF5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cTBjg6PG; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711102010; x=1742638010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DBMidGRbt2hOCRudWUM91w11Hu7XZpYXaJPG/atgNP0=;
  b=cTBjg6PGPgq7cjttxWtHIMqHJkmHeoZ9rhFvOpYqMnR4Gav1sFFCo9Dd
   SfOAks+TuhRu7m6qEuPQZCCEGV7ZqOemCQX5fftiXOqj7e1om5uJYtL64
   5KysHvHJphet3Y3WT8cTr52+/x1X35eqYsFLH213yu+GdTZnHm+iiT8RL
   yqJ4dtSbI/AUR9todmvbBDFlIW3o4WWnHBZ03zWqqhq0W/4KyAjTSuoof
   ZdRubsMw4NgDw4Qni0S1jmU/x/LHXwLvk84yW5tnavG78Q27jA/dIPuIr
   rGf/aaCCBzlchlXUYrpb4XEeGYacubQE0bCAYUnLJXMpfzgi5KcCiqq0G
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="6267762"
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="6267762"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 03:06:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="937066514"
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="937066514"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 22 Mar 2024 03:06:17 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 22 Mar 2024 12:06:17 +0200
Date: Fri, 22 Mar 2024 12:06:17 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: "Christian A. Ehrhardt" <lk@c--e.de>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Prashant Malani <pmalani@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Samuel =?utf-8?B?xIxhdm9q?= <samuel@cavoj.net>,
	linux-usb@vger.kernel.org, Kenneth Crudup <kenny@panix.com>
Subject: Re: [PATCH 5/5] usb: typec: ucsi: Clear UCSI_CCI_RESET_COMPLETE
 before reset
Message-ID: <Zf1YGe9M4ZjDTYMS@kuha.fi.intel.com>
References: <20240320073927.1641788-1-lk@c--e.de>
 <20240320073927.1641788-6-lk@c--e.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320073927.1641788-6-lk@c--e.de>

On Wed, Mar 20, 2024 at 08:39:26AM +0100, Christian A. Ehrhardt wrote:
> Check the UCSI_CCI_RESET_COMPLETE complete flag before starting
> another reset. Use a UCSI_SET_NOTIFICATION_ENABLE command to clear
> the flag if it is set.
> 
> Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi.c | 36 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 63f340dbd867..85e507df7fa8 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1264,13 +1264,47 @@ static int ucsi_reset_connector(struct ucsi_connector *con, bool hard)
>  
>  static int ucsi_reset_ppm(struct ucsi *ucsi)
>  {
> -	u64 command = UCSI_PPM_RESET;
> +	u64 command;
>  	unsigned long tmo;
>  	u32 cci;
>  	int ret;
>  
>  	mutex_lock(&ucsi->ppm_lock);
>  
> +	ret = ucsi->ops->read(ucsi, UCSI_CCI, &cci, sizeof(cci));
> +	if (ret < 0)
> +		goto out;
> +
> +	/*
> +	 * If UCSI_CCI_RESET_COMPLETE is already set we must clear
> +	 * the flag before we start another reset. Send a
> +	 * UCSI_SET_NOTIFICATION_ENABLE command to achieve this.
> +	 * Ignore a timeout and try the reset anyway if this fails.
> +	 */
> +	if (cci & UCSI_CCI_RESET_COMPLETE) {
> +		command = UCSI_SET_NOTIFICATION_ENABLE;
> +		ret = ucsi->ops->async_write(ucsi, UCSI_CONTROL, &command,
> +					     sizeof(command));
> +		if (ret < 0)
> +			goto out;
> +
> +		tmo = jiffies + msecs_to_jiffies(UCSI_TIMEOUT_MS);
> +		do {
> +			ret = ucsi->ops->read(ucsi, UCSI_CCI,
> +					      &cci, sizeof(cci));
> +			if (ret < 0)
> +				goto out;
> +			if (cci & UCSI_CCI_COMMAND_COMPLETE)
> +				break;
> +			if (time_is_before_jiffies(tmo))
> +				break;
> +			msleep(20);
> +		} while (1);
> +
> +		WARN_ON(cci & UCSI_CCI_RESET_COMPLETE);
> +	}
> +
> +	command = UCSI_PPM_RESET;
>  	ret = ucsi->ops->async_write(ucsi, UCSI_CONTROL, &command,
>  				     sizeof(command));
>  	if (ret < 0)
> -- 
> 2.40.1

-- 
heikki

