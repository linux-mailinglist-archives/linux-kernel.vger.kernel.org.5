Return-Path: <linux-kernel+bounces-71013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0DC859F63
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 430FC1C21124
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCACB22EF0;
	Mon, 19 Feb 2024 09:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HS1FsVtG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5325C225DD;
	Mon, 19 Feb 2024 09:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708334132; cv=none; b=nqQFxPwXmTGVrNqE81HZcP/RY103YbOm/e2ADpLybL44ukFQGIRiy4LnzvTNbKbefqZvlGDBNwr71eJTjtzv7qjsy/IO6dyHXZ7R8OJ2UYEfbJkPPWXtIxdDF+jOwFf3/jNTAhJnFVzo0JjaCA8hRdpEwBt95/UmDPQjVf0kMyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708334132; c=relaxed/simple;
	bh=2IsOrnwrUtDaBBPgkkbsCmwW81iCZ5GY65RJOKc5n64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPO2orar2DgnHFBvKHHONe69dIWaOyGZ0uJVSJiFabQlojLaMZit2kOFpvncJ62vtVZ+1H7ZVJisfGlEnasueXNPaq6bxVbrvcv4ZCQGmlOe+BAf+XL9R0AdqNzn5nk48d3syh2GAgv+enrZDaGahL38Kl5a8VYO5vPAQR7kNzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HS1FsVtG; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708334130; x=1739870130;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=2IsOrnwrUtDaBBPgkkbsCmwW81iCZ5GY65RJOKc5n64=;
  b=HS1FsVtG2/jB4fYuY3fWXAK45NdotxuKx0woVkoVpOyNJkKALI3MrWQG
   YZY9OMfniYNZLtFYms9kEZYMXv6BegWhx9O/hheKWr089ERYlYq/mmFlB
   SlwxygBw75ZaEwuOUrqAJQv+rD7/7PLbJC2FNrDeB7OhaBcadCC7Wuf94
   +N53CGht3VtJKnY39iqRsqNwj06shfUV+BXkcqtsb9RqVgM3hpeerATn4
   Vv/weuXak8WkEJF3Y1BSB66PyFmZfXYpNSt+cz2AiKWx4UteG1anHxzyY
   sL3D3tvwgpnW6HxkMBEURGTTClAZI3iJgzB7ns26XA+om0ASbAnysNL6z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="19933946"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="19933946"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 01:15:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="936260979"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="936260979"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 01:15:27 -0800
Date: Mon, 19 Feb 2024 11:15:24 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thorsten Scherer <T.Scherer@eckelmann.de>,
	jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com, lakshmi.sowjanya.d@intel.com,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] pwm: dwc: drop redundant error check
Message-ID: <ZdMcLAIsi6UHPUho@black.fi.intel.com>
References: <20240219033835.11369-1-raag.jadav@intel.com>
 <20240219033835.11369-3-raag.jadav@intel.com>
 <m57yqdldszy3s44p5rdxd6kwii5tqzqa44aaevpe7bep2yyeuo@wls3ad3gcl7y>
 <4cl5y62fv4jezk7i3cacv5ukzwyp66uflp3upg4czy4dp7g43v@cfbm2seewpst>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4cl5y62fv4jezk7i3cacv5ukzwyp66uflp3upg4czy4dp7g43v@cfbm2seewpst>

On Mon, Feb 19, 2024 at 08:27:43AM +0100, Uwe Kleine-König wrote:
> Hello,
> 
> On Mon, Feb 19, 2024 at 08:11:00AM +0100, Thorsten Scherer wrote:
> > On Mon, Feb 19, 2024 at 09:08:33AM +0530, Raag Jadav wrote:
> > > pcim_iomap_table() fails only if pcim_iomap_regions() fails. No need to
> > > check for failure if the latter is already successful.
> > > 
> > > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > > Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> > > ---
> > >  drivers/pwm/pwm-dwc.c | 5 +----
> > >  1 file changed, 1 insertion(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
> > > index c0e586688e57..7dbb72c80ef5 100644
> > > --- a/drivers/pwm/pwm-dwc.c
> > > +++ b/drivers/pwm/pwm-dwc.c
> > > @@ -51,11 +51,8 @@ static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
> > >  		return ret;
> > >  	}
> > >  
> > > +	/* No need to check for failure, pcim_iomap_regions() does it for us. */
> > 
> > IMHO this comment could be omitted.
> 
> I like the comment (and even asked for it). Is it really only me who
> doesn't know that after pcim_iomap_regions() calling pcim_iomap_table()
> is unproblematic?

Neither did I :) (Check the v1 discussion)

Raag

