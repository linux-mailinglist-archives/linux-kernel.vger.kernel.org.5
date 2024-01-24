Return-Path: <linux-kernel+bounces-36612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0A683A3C1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F3481F28697
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5953517555;
	Wed, 24 Jan 2024 08:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DMs6aQ+3"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CBE171D2;
	Wed, 24 Jan 2024 08:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706083751; cv=none; b=llFxNy9Fe6vPG4Me7J3HGUG2he140NjvMyISqS49+mq0ce/4bWb430vw8IzzWYmh57HY7RHrllvwXzwRfeBhLYyJfpRk82xGQ6fxbJyubARzIT/dfYmgcGQ94QQv/gaOK6JzXmMfkJfiOVmBNBUZg553f2F779hO1aX7NVgze10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706083751; c=relaxed/simple;
	bh=cgxB4DRRm2xX7+FLr84/z4D2NTlt+tcxsAZxnhaZSmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b57Ly9kq3jFujP3R5YvglKOm3SaDS8sPhFjnCw10s3WsQBNzEJ2PISxxBKPsyGIzSQ8JCw8AoxUBlzYfWZN/j7b0spz1yUZxh2+SRdJqa1059fZPIn65ynuv5cmVT95/52DBifGzoHpLm1mNF7Fx7ehb65aCfXRs3pFF/wN6vjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DMs6aQ+3; arc=none smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706083749; x=1737619749;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cgxB4DRRm2xX7+FLr84/z4D2NTlt+tcxsAZxnhaZSmA=;
  b=DMs6aQ+3906mw3nEbqVupziQ6IetfY8MNPvCjNnZAxom6k+oZARvPqzI
   uM0jCfLOydQ430ta1vlO5J/GDZh9SvDlVb2TEY69h52gnnpDljiVqcSD0
   mJaKrM8mcBme24kwNXhxT705ziuVWFqG+VA0zBUpyEbybvrOhaWRgGHu3
   n3p3eLWINhi2YZHYdiYI/PdoJeZ0P8jEpEdpDbHYSOx5QM8RgTHZeFmJm
   Fi14X/2BFz8QSsB4sMlnkoDVUErLBZgov/ThpDNbPiwQhczFffe1GRRLd
   nPcCyC+eNCYZ11JpMLDebpSdbJO0oxGB1b/CLAu6h/or+G+Otj9g3RPhv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="398929358"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="398929358"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 00:09:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="929594235"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="929594235"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 24 Jan 2024 00:09:04 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 24 Jan 2024 10:09:04 +0200
Date: Wed, 24 Jan 2024 10:09:04 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: "Christian A. Ehrhardt" <lk@c--e.de>
Cc: linux-usb@vger.kernel.org, Dell.Client.Kernel@dell.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Jack Pham <quic_jackp@quicinc.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Samuel =?utf-8?B?xIxhdm9q?= <samuel@cavoj.net>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] usb: ucsi: Add missing ppm_lock
Message-ID: <ZbDFoGL1GnxZAXER@kuha.fi.intel.com>
References: <20240121204123.275441-1-lk@c--e.de>
 <20240121204123.275441-2-lk@c--e.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240121204123.275441-2-lk@c--e.de>

On Sun, Jan 21, 2024 at 09:41:21PM +0100, Christian A. Ehrhardt wrote:
> Calling ->sync_write must be done while holding the PPM lock as
> the mailbox logic does not support concurrent commands.
> 
> At least since the addition of partner task this means that
> ucsi_acknowledge_connector_change should be called with the
> PPM lock held as it calls ->sync_write.
> 
> Thus protect the only call to ucsi_acknowledge_connector_change
> with the PPM. All other calls to ->sync_write already happen
> under the PPM lock.
> 
> Fixes: b9aa02ca39a4 ("usb: typec: ucsi: Add polling mechanism for partner tasks like alt mode checking")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
> ---
>  drivers/usb/typec/ucsi/ucsi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 61b64558f96c..8f9dff993b3d 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -935,7 +935,9 @@ static void ucsi_handle_connector_change(struct work_struct *work)
>  
>  	clear_bit(EVENT_PENDING, &con->ucsi->flags);
>  
> +	mutex_lock(&ucsi->ppm_lock);
>  	ret = ucsi_acknowledge_connector_change(ucsi);
> +	mutex_unlock(&ucsi->ppm_lock);
>  	if (ret)
>  		dev_err(ucsi->dev, "%s: ACK failed (%d)", __func__, ret);

Is this really actually fixing some issue? The function has already
taken the connector lock, so what exactly could happen without this?

thanks,

-- 
heikki

