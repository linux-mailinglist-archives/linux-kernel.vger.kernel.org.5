Return-Path: <linux-kernel+bounces-111267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E108869E4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 976241F25630
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DE42D78A;
	Fri, 22 Mar 2024 10:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l0vO/cRa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E7B2556E;
	Fri, 22 Mar 2024 10:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711101861; cv=none; b=fzyeYUsWFONF2gv4DEU2y2H4Vf828oluarAl9HoZVFjD1Vc91DB+WYdcP9/4fEGIzx2FaiSKlUoZ2ou9K0KZQWG7xsCxyAm4+Qyo2YPXYtfNg2QF8tkUNBTLKhm1g+XMkTp3g3W9LkIHYqykENxXVn2VweXHMYuwR0jDVTQEbsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711101861; c=relaxed/simple;
	bh=R7fiJlvHXXPfk/5nfmw6Moa8sktAs3sdecIxZhYQ3Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnFptYTAzWYaYDSgV5BA4pEy3up8e5ien9/LVBQCcSCcFVoNT1R0VHt53KbVLUNf0sbdk0xOpkg6eba0lly+SPHmmS4NEALDY8wdSieNgTdupIpDL7gHeQUICFjpBKnIOvaswmGdadky/B1Hai1K29gUuAhKZhfsQJ145Er0Ass=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l0vO/cRa; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711101859; x=1742637859;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R7fiJlvHXXPfk/5nfmw6Moa8sktAs3sdecIxZhYQ3Zk=;
  b=l0vO/cRaVYkGd2HAH1305jPrpgd9hRIpRVqAFTuuGWxyGUyKpFqo0cdW
   /oSkESFDMbw5ZTHO8yzUSBHuiAkFhKcN/VDAfIchTRYq6KglMLsbQ+7iH
   NVVxHHAqnhrc1DqnogopPqUhrS4E7yZZp8P1l61ps0tQbcP8lJB3cEOts
   yWNfJiYW6rHAusVEwdZND8YhYRtpm5q/NV+rSE1jyID6PDfZTO/Nbf1ov
   eFzXppOxugFyOwvqG/GB8JTNjM91Evhe/h9dT48G8zXvtrgRKFwlMVwH2
   7SQPExk1UWgQ2FvLpGDgMWh/q6I/IToZR/cHRBBk1fd9f4IBoi1HvRQf1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="6267505"
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="6267505"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 03:04:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="937066513"
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="937066513"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 22 Mar 2024 03:04:14 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 22 Mar 2024 12:04:14 +0200
Date: Fri, 22 Mar 2024 12:04:14 +0200
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
Subject: Re: [PATCH 3/5] usb: typec: ucsi: Ack unsupported commands
Message-ID: <Zf1XnmQlsQxpeK/Q@kuha.fi.intel.com>
References: <20240320073927.1641788-1-lk@c--e.de>
 <20240320073927.1641788-4-lk@c--e.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320073927.1641788-4-lk@c--e.de>

On Wed, Mar 20, 2024 at 08:39:24AM +0100, Christian A. Ehrhardt wrote:
> If a command completes the OPM must send an ack. This applies
> to unsupported commands, too.
> 
> Send the required ACK for unsupported commands.
> 
> Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index dceeed207569..63f340dbd867 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -151,8 +151,12 @@ static int ucsi_exec_command(struct ucsi *ucsi, u64 cmd)
>  	if (!(cci & UCSI_CCI_COMMAND_COMPLETE))
>  		return -EIO;
>  
> -	if (cci & UCSI_CCI_NOT_SUPPORTED)
> +	if (cci & UCSI_CCI_NOT_SUPPORTED) {
> +		if (ucsi_acknowledge_command(ucsi) < 0)
> +			dev_err(ucsi->dev,
> +				"ACK of unsupported command failed\n");
>  		return -EOPNOTSUPP;
> +	}
>  
>  	if (cci & UCSI_CCI_ERROR) {
>  		if (cmd == UCSI_GET_ERROR_STATUS)
> -- 
> 2.40.1

-- 
heikki

