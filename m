Return-Path: <linux-kernel+bounces-111256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7E38869C8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF6A11C233B6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3FF22611;
	Fri, 22 Mar 2024 09:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eTjJqdfp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C57F224CF;
	Fri, 22 Mar 2024 09:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711101273; cv=none; b=GK92hRormZN485RfGmcPp6KKq2r2WLN04aV4ZySWqyVWJJIjjmi9Ag66gsmoRQgh+xv2DJRwpOOtWTVA5QzUAG/lyLnsOOF+UJbu/lh3FA48mhkEZHhCOgKbNGBd/DNG3dmHIBqk8900e0wUf2OGfHsra1xwxDdsd/XKHTwCoEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711101273; c=relaxed/simple;
	bh=I99OtoggqVQ+CHYuX9e5N8dwaYZ+BHkENlZwYobcauQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTR6ie3U6Fn84YuqjfkqUN/lwmbFv+6MQFHb3XTyPn3rh6wE6QIsdpF+uLFGa1xXzwXbvbeZQckHVI5rqBQZ5Pm8EQZymszOPRU7MR5q3e8bW8qY9xUUdK8s9V6zfAL0s3eyW3qKsgatsL/BXMOtVEiBzzy0pflyclh33DsC3d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eTjJqdfp; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711101270; x=1742637270;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I99OtoggqVQ+CHYuX9e5N8dwaYZ+BHkENlZwYobcauQ=;
  b=eTjJqdfpGZHsYxhjZuOLeGhXH1Lb6KVeno7RwTVmMEIiMI6F4jnhenyQ
   A/nLcn3CkXQIS8+zbiu5WxPSX7Db9QMTY1HnLsgSh3Lgiyn/7iPCfLcFW
   oYkn/mtCrFYCKYK86eQJQrjcETDnFJvJTEGRFVXE/LVlPrMcnJv541KPJ
   TRr0PqsCmhRJAvCaNJsNCcmcHfDgkOb/njUkmFnCrW2gqw0kRx/ny4/1I
   NwK8Z+qkl5mGXGQs+kMaBru2kOogksMMOR8/+drP4fftZsGsB4XTzA0TH
   RcqbE+azLJ/foKkiPAKxopiR3a+qRpDPXUtiEd2CGtAVRzcGI75II/JPe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="16869416"
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="16869416"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 02:54:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="937066506"
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="937066506"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 22 Mar 2024 02:54:26 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 22 Mar 2024 11:54:25 +0200
Date: Fri, 22 Mar 2024 11:54:25 +0200
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
Subject: Re: [PATCH 2/5] usb: typec: ucsi: Check for notifications after init
Message-ID: <Zf1VUTa8JlXuJlwx@kuha.fi.intel.com>
References: <20240320073927.1641788-1-lk@c--e.de>
 <20240320073927.1641788-3-lk@c--e.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320073927.1641788-3-lk@c--e.de>

On Wed, Mar 20, 2024 at 08:39:23AM +0100, Christian A. Ehrhardt wrote:
> The completion notification for the final SET_NOTIFICATION_ENABLE
> command during initialization can include a connector change
> notification.  However, at the time this completion notification is
> processed, the ucsi struct is not ready to handle this notification.
> As a result the notification is ignored and the controller
> never sends an interrupt again.
> 
> Re-check CCI for a pending connector state change after
> initialization is complete. Adjust the corresponding debug
> message accordingly.
> 
> Fixes: 71a1fa0df2a3 ("usb: typec: ucsi: Store the notification mask")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 8a6645ffd938..dceeed207569 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1237,7 +1237,7 @@ void ucsi_connector_change(struct ucsi *ucsi, u8 num)
>  	struct ucsi_connector *con = &ucsi->connector[num - 1];
>  
>  	if (!(ucsi->ntfy & UCSI_ENABLE_NTFY_CONNECTOR_CHANGE)) {
> -		dev_dbg(ucsi->dev, "Bogus connector change event\n");
> +		dev_dbg(ucsi->dev, "Early connector change event\n");
>  		return;
>  	}
>  
> @@ -1636,6 +1636,7 @@ static int ucsi_init(struct ucsi *ucsi)
>  {
>  	struct ucsi_connector *con, *connector;
>  	u64 command, ntfy;
> +	u32 cci;
>  	int ret;
>  	int i;
>  
> @@ -1688,6 +1689,13 @@ static int ucsi_init(struct ucsi *ucsi)
>  
>  	ucsi->connector = connector;
>  	ucsi->ntfy = ntfy;
> +
> +	ret = ucsi->ops->read(ucsi, UCSI_CCI, &cci, sizeof(cci));
> +	if (ret)
> +		return ret;
> +	if (UCSI_CCI_CONNECTOR(READ_ONCE(cci)))
> +		ucsi_connector_change(ucsi, cci);
> +
>  	return 0;
>  
>  err_unregister:
> -- 
> 2.40.1

-- 
heikki

