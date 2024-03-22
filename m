Return-Path: <linux-kernel+bounces-111252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5B28869BC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88B48B22DBA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C9E224F1;
	Fri, 22 Mar 2024 09:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hqk45EGR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A1918EC3;
	Fri, 22 Mar 2024 09:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711101210; cv=none; b=kkOKw06y26YSZpsNqgJdpo3C6A0g28KCbwKz+kpUWwZYgDozTbz6LC4oFo5tDQmfPnQAKrZyZNDkpurv23cgaXaavczrEXGNbvqZSbtNxDDNxYd3TkCXiUj63z7C5XDXsxKfIgyfOgiDthVKkVFSgrVyuFsF9n4QADmCVvUBppM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711101210; c=relaxed/simple;
	bh=LEYSOkamyNi59UriO71s2y6PNJhbxCI+6IL5kL8GRI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBy2U23W5P9mn8fGQ+EgQ4wx1FiB8jWSj37CR6v5EP8k1PF14K+buwZAvG59+6+zwXKAhC2CoHSmgM1BKgqCGy74oUUrxWm1UFBnAHfgdtj6thB43anyC74rk87jIKGHVICEsu4P12uo/zb1OM2fwZh5OZVxJVZ+SyxEnN4kkdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hqk45EGR; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711101207; x=1742637207;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LEYSOkamyNi59UriO71s2y6PNJhbxCI+6IL5kL8GRI4=;
  b=hqk45EGRTWO3AiRJx6uW/7bCraaIsvbxgv0ia9crwpLn/YkV6DQZQSq4
   Q++VqfKExAVuKK8BfcgKWaBaWVql4Rk58pHukC4vAqKLicBHdsBlMiZzv
   T3Jq234x8F+iIMmg/IukJntScExG/MlkLthhEpUvYO6+oCX8JYwjKXNx5
   7agL7U3DTACr0mj2tCsAE1b3cTkxonMthxlkdCxmdoIVF6QIRJpLIaT6J
   ReQ5Uc4lA7BHobIgwf8hp4tQqgfUZj9HXTzW1xwL7GibLq15559lwZ9aK
   NoJye6NmNqPzeZ0IJ8EMWff4HtsiWypO/g519swanpAmJaBxiE7Jumx+1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="16869363"
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="16869363"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 02:53:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="937066505"
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="937066505"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 22 Mar 2024 02:53:23 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 22 Mar 2024 11:53:22 +0200
Date: Fri, 22 Mar 2024 11:53:22 +0200
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
Subject: Re: [PATCH 1/5] usb: typec: ucsi: Clear EVENT_PENDING under PPM lock
Message-ID: <Zf1VEimCKdRIKPXQ@kuha.fi.intel.com>
References: <20240320073927.1641788-1-lk@c--e.de>
 <20240320073927.1641788-2-lk@c--e.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320073927.1641788-2-lk@c--e.de>

On Wed, Mar 20, 2024 at 08:39:22AM +0100, Christian A. Ehrhardt wrote:
> Suppose we sleep on the PPM lock after clearing the EVENT_PENDING
> bit because the thread for another connector is executing a command.
> In this case the command completion of the other command will still
> report the connector change for our connector.
> 
> Clear the EVENT_PENDING bit under the PPM lock to avoid another
> useless call to ucsi_handle_connector_change() in this case.
> 
> Fixes: c9aed03a0a68 ("usb: ucsi: Add missing ppm_lock")
> Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index cf52cb34d285..8a6645ffd938 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1215,11 +1215,11 @@ static void ucsi_handle_connector_change(struct work_struct *work)
>  	if (con->status.change & UCSI_CONSTAT_CAM_CHANGE)
>  		ucsi_partner_task(con, ucsi_check_altmodes, 1, 0);
>  
> -	clear_bit(EVENT_PENDING, &con->ucsi->flags);
> -
>  	mutex_lock(&ucsi->ppm_lock);
> +	clear_bit(EVENT_PENDING, &con->ucsi->flags);
>  	ret = ucsi_acknowledge_connector_change(ucsi);
>  	mutex_unlock(&ucsi->ppm_lock);
> +
>  	if (ret)
>  		dev_err(ucsi->dev, "%s: ACK failed (%d)", __func__, ret);
>  
> -- 
> 2.40.1

-- 
heikki

