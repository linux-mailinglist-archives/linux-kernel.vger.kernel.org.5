Return-Path: <linux-kernel+bounces-100010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC75B8790AF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CDBDB22B33
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F9078B45;
	Tue, 12 Mar 2024 09:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D/4LLAe2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07A178274;
	Tue, 12 Mar 2024 09:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235094; cv=none; b=Aqj1+KC0QI16/WAO4ckICszA0a8Ahx0fqC/SYQpvTgyz3sjVdku3eF9W+niiRqw3oUwZLsaTAkuS4LWdquXRgHslRZzXNkt8BfyuOm/cpLutY6Ph5cDK5/pPHvqVuQ6gdC+83astoMaytGm853SmyS2+nhkNmn5D4qdBWt/dA1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235094; c=relaxed/simple;
	bh=xULG24erpUcoihlm+Uw7EJPRQq7iaA6trJNTM9vkwmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqKvUyqnSss3i8uuRAg8F1Hm7jlPDVSqtZVsj77fNUyitOTtzF2di7JwzGlAv6x5IajZX6rhDjYLyY2vUh3P/tdVC+DYh8ZTFfJSa2hSyBZTwpRZ9iCeWddmdNFth7eu0zsa3FU9bBXhIn3iIzBYxj0gpIX5qSwb1agsOLydvHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D/4LLAe2; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710235093; x=1741771093;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xULG24erpUcoihlm+Uw7EJPRQq7iaA6trJNTM9vkwmA=;
  b=D/4LLAe2jrbdqW0I5nK0r68hdZBaet0Fu6epfge3tpKNbKARAN/SpQby
   nAVUdVGk9uYDj8siktNqS5Tuy81nk0aTLELPbyCSShJI/3pY1fuIz5Bw0
   mhCm2qoHtj9AUYVkCkdNipAZT+Vm6JJcH5LIcKin+0WFLyUxSccACPS2L
   RfTDDCXpmGF4Mzq0HR4nvZI7hsf06B5cPCQ3LCLsFVcYylKbs5LHQ8jod
   5LfA4PzJFRs9rcFivk9Yea8cybJFRkV0ZM1xQ1na6/8WPj/6EElBIicYr
   3gYBKSDEhd6EWyU0pPheTtv3rOM+xENnVz6Ql5z7FiBOHcDnKYeOsFvOJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="4784219"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="4784219"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 02:18:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="937051555"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="937051555"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 12 Mar 2024 02:18:07 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 12 Mar 2024 11:18:06 +0200
Date: Tue, 12 Mar 2024 11:18:06 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?iso-8859-1?Q?G=FCnter_R=F6ck?= <linux@roeck-us.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	RD Babiera <rdbabiera@google.com>, Rob Herring <robh@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Yu Zhe <yuzhe@nfschina.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: typec: fusb302: Use common error handling code in
 fusb302_probe()
Message-ID: <ZfAdzsqXeO/IOY/A@kuha.fi.intel.com>
References: <0b89e175-47da-4e66-bb3b-a45a400dc3ae@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b89e175-47da-4e66-bb3b-a45a400dc3ae@web.de>

On Fri, Mar 01, 2024 at 05:23:25PM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 1 Mar 2024 17:00:23 +0100
> 
> Add a label so that a bit of exception handling can be better reused
> at the end of this function implementation.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/fusb302.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
> index ef18a448b740..e1e030da1dec 100644
> --- a/drivers/usb/typec/tcpm/fusb302.c
> +++ b/drivers/usb/typec/tcpm/fusb302.c
> @@ -1741,10 +1741,9 @@ static int fusb302_probe(struct i2c_client *client)
> 
>  	chip->tcpm_port = tcpm_register_port(&client->dev, &chip->tcpc_dev);
>  	if (IS_ERR(chip->tcpm_port)) {
> -		fwnode_handle_put(chip->tcpc_dev.fwnode);
>  		ret = dev_err_probe(dev, PTR_ERR(chip->tcpm_port),
>  				    "cannot register tcpm port\n");
> -		goto destroy_workqueue;
> +		goto put_fwnode;
>  	}
> 
>  	ret = request_irq(chip->gpio_int_n_irq, fusb302_irq_intn,
> @@ -1761,6 +1760,7 @@ static int fusb302_probe(struct i2c_client *client)
> 
>  tcpm_unregister_port:
>  	tcpm_unregister_port(chip->tcpm_port);
> +put_fwnode:
>  	fwnode_handle_put(chip->tcpc_dev.fwnode);
>  destroy_workqueue:
>  	fusb302_debugfs_exit(chip);
> --
> 2.44.0

-- 
heikki

