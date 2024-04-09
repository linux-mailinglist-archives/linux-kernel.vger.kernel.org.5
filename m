Return-Path: <linux-kernel+bounces-136418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF1A89D3E1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6F5B1C2160E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03397F476;
	Tue,  9 Apr 2024 08:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c5+1vN/w"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1667EEF3;
	Tue,  9 Apr 2024 08:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712650297; cv=none; b=qo+2WwyekIpKapRgKwUms0RofXYEkDN4HQwLTvSiTK3ACGGa26OVSJ34mN/CTzLAbB62+5Jou+S5btfjiaXQ3qsThzrQLoaRN0OvtOsB435zmo0suS7W9Uz1kTTPbgTtY2yAk1l8J1r19po0ahSEtaN7O9Bf6QQ1lO0Pm17vF0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712650297; c=relaxed/simple;
	bh=uU+FnGbctk6dn7tcOByt4eDdKmXna0RlgB6MAvZx8fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1Kthka7sLh14boXnQAtAYos8vl8bmIJ0y01BpY/y1VP8GEx49SSxJoWZoJhUiZHl8I4yETBdUhTsCMMetU9GJz2iGv+kf/if+QJBC29K+IdAYbfbyGXA2FXclRxin2vqdAe2F9gMkwXbxDXC/ot/VOzRwZfK2ZaNttqzURn7ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c5+1vN/w; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712650295; x=1744186295;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uU+FnGbctk6dn7tcOByt4eDdKmXna0RlgB6MAvZx8fo=;
  b=c5+1vN/wYGOSB/nIfyueiqKpaCn3q7wjIegdywklHbvfdI0iNpXmsXrm
   8FSSdakTI9bPFNaWPBhIhEccXVDIdB1oIGo0LQBpS6lGbF5q20JoDBKmL
   vua/NE7sUnqRT9S5EaSxgyLObUVYhMu/1QGmGwQAtQx9MsoHFn0RZUz2m
   ZEmX+SyzqLT3H+75+pBRSk7N8RSpZqrSiDeW1P4/qOeQ3191kgSQlHkln
   FP8RQUPnXf7If4udWTPcNYJfMIFwyRb3MnxsouoXI0R4OxAKCGbme1WTc
   raUOredHPSlvhtB0zWLDafkDKNBbFJ+sjfvCnyyeYog9v/ZZrVcz5dUQK
   A==;
X-CSE-ConnectionGUID: 9xO9fmz0T4+AereoZ5YGHQ==
X-CSE-MsgGUID: mRgUCmRJT2ybt6w3nkreog==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="11750435"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="11750435"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 01:11:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="937093186"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="937093186"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 09 Apr 2024 01:11:32 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 09 Apr 2024 11:11:31 +0300
Date: Tue, 9 Apr 2024 11:11:31 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Pavan Holla <pholla@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Prashant Malani <pmalani@chromium.org>
Subject: Re: [PATCH v3] usb: typec: ucsi: Wait 20ms before reading CCI after
 a reset
Message-ID: <ZhT4MzZ9FriHqoa4@kuha.fi.intel.com>
References: <20240409-ucsi-reset-delay-v3-1-8440710b012b@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409-ucsi-reset-delay-v3-1-8440710b012b@chromium.org>

On Tue, Apr 09, 2024 at 01:58:57AM +0000, Pavan Holla wrote:
> The PPM might take time to process a reset. Allow 20ms for the reset to
> be processed before reading the CCI.
> 
> This should not slow down existing implementations because they would
> not set any bits in the CCI after a reset, and would take a 20ms delay
> to read the CCI anyway. This change makes the delay explicit, and
> reduces a CCI read. Based on the spec, the PPM has 10ms to set busy, so,
> 20ms seems like a reasonable delay before we read the CCI.
> 
> Signed-off-by: Pavan Holla <pholla@chromium.org>
> Reviewed-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> The PPM might take time to process a reset and set the CCI. Give the PPM
> 20ms to update it's CCI.
> 
> Commit message now summarizes discussion in v1.
> ---
> Changes in v3:
> - Commit message updated.
> - Link to v2: https://lore.kernel.org/r/20240403-ucsi-reset-delay-v2-1-244c175825a4@chromium.org
> 
> Changes in v2:
> - Commit message updated.
> - Link to v1: https://lore.kernel.org/r/20240325-ucsi-reset-delay-v1-1-d9e183e0f1e6@chromium.org
> ---
>  drivers/usb/typec/ucsi/ucsi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index cf52cb34d285..c0706c40fa64 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1280,6 +1280,9 @@ static int ucsi_reset_ppm(struct ucsi *ucsi)
>  			goto out;
>  		}
>  
> +		/* Give the PPM time to process a reset before reading CCI */
> +		msleep(20);
> +
>  		ret = ucsi->ops->read(ucsi, UCSI_CCI, &cci, sizeof(cci));
>  		if (ret)
>  			goto out;
> @@ -1293,7 +1296,6 @@ static int ucsi_reset_ppm(struct ucsi *ucsi)
>  				goto out;
>  		}
>  
> -		msleep(20);
>  	} while (!(cci & UCSI_CCI_RESET_COMPLETE));
>  
>  out:
> 
> ---
> base-commit: 4cece764965020c22cff7665b18a012006359095
> change-id: 20240325-ucsi-reset-delay-bdf6712455fd
> 
> Best regards,
> -- 
> Pavan Holla <pholla@chromium.org>

-- 
heikki

