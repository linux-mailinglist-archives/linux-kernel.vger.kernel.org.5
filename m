Return-Path: <linux-kernel+bounces-111245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F4A8869A3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C82CC1C21A25
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF34F2233B;
	Fri, 22 Mar 2024 09:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FKhkGeK6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869B022071;
	Fri, 22 Mar 2024 09:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711100868; cv=none; b=oumoXRHoNdEgY29pPSTt+dcMia+/igyvmt2QZCuKVK/RVTzN5AXB1Z0/eBiV3yuxWRStnM9d7C8dx8rrCrIy0nZ3KhAu71Rxo+qSVidpmNeGk8NQt9MT2tY1cnwCR1DJbMpIZJ9/NKIeE+bApYv+svDF2WcDtu4X5BtY0JvxJQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711100868; c=relaxed/simple;
	bh=d8QI1fvrWimyZ+FSH0Pau+AvhF+Z/HjOosxcR2O3zaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pb3EXRYV1PnL+SV7po9WQ/Zip6J9DZNrlptRh+5rArsIMSq8UpTCVbXimmxXgvWK3ZSQBB2fHo3coL9FonhIS6V2yr5V/I7JrCtqIYLONFleaIjtZI7PWs4GBiNL88rOv9L8Ecpy5HKmcXVJC99Yek7znpla109oLsx8YjL7Rws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FKhkGeK6; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711100866; x=1742636866;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d8QI1fvrWimyZ+FSH0Pau+AvhF+Z/HjOosxcR2O3zaQ=;
  b=FKhkGeK6EVi2iOlbZpB4g5G9kOk5gLbKHhi7brru8IjFBkleItDngykA
   PHE1t6ExjhQfkB097BoriziaACzYAYnG5LdXkuSnWbe3YGUGfM82SaZxc
   GA4OhiUARCQfCh0rizAv+Q8A96/XVGWG/yeCsjOsKe+bjYu+dG3YjIe+p
   tELNwp7YIz8/2CkEqKwBBMylAbNgKRtXc1Y6In1Ko/GDVdsDCSjy3ygI3
   jLeJzz1ARXTgGCW4IzVp+hV4dAJqGFwsC1KMmwKKHBdc14Gk9++giF7do
   C47LB7/3B1RJRD6m2dQqQF+rH6U3KAAtOhEYtlfXJ3fywRB5jybbiPvTC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="16868984"
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="16868984"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 02:47:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="937066503"
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="937066503"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 22 Mar 2024 02:47:43 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 22 Mar 2024 11:47:42 +0200
Date: Fri, 22 Mar 2024 11:47:42 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Kyle Tso <kyletso@google.com>
Cc: linux@roeck-us.net, gregkh@linuxfoundation.org, badhri@google.com,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: Return size of buffer if pd_set operation
 succeeds
Message-ID: <Zf1Tvk0SeE9oxXiA@kuha.fi.intel.com>
References: <20240319074309.3306579-1-kyletso@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319074309.3306579-1-kyletso@google.com>

On Tue, Mar 19, 2024 at 03:43:09PM +0800, Kyle Tso wrote:
> The attribute writing should return the number of bytes used from the
> buffer on success.
> 
> Fixes: a7cff92f0635 ("usb: typec: USB Power Delivery helpers for ports and partners")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kyle Tso <kyletso@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/class.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 389c7f0b8d93..9610e647a8d4 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -1310,6 +1310,7 @@ static ssize_t select_usb_power_delivery_store(struct device *dev,
>  {
>  	struct typec_port *port = to_typec_port(dev);
>  	struct usb_power_delivery *pd;
> +	int ret;
>  
>  	if (!port->ops || !port->ops->pd_set)
>  		return -EOPNOTSUPP;
> @@ -1318,7 +1319,11 @@ static ssize_t select_usb_power_delivery_store(struct device *dev,
>  	if (!pd)
>  		return -EINVAL;
>  
> -	return port->ops->pd_set(port, pd);
> +	ret = port->ops->pd_set(port, pd);
> +	if (ret)
> +		return ret;
> +
> +	return size;
>  }
>  
>  static ssize_t select_usb_power_delivery_show(struct device *dev,
> -- 
> 2.44.0.291.gc1ea87d7ee-goog

-- 
heikki

