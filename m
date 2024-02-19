Return-Path: <linux-kernel+bounces-70998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4192D859F33
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 741451C2169A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C76623766;
	Mon, 19 Feb 2024 09:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SBK6igsu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362982421E;
	Mon, 19 Feb 2024 09:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708333555; cv=none; b=NQOIsxo1vacZ7AJEfeedxjZIyfxuQnY5NseoaUJn0L8evy5DGbyPtXR+D+lowkOi7kAWq3054aZuA44F3TfL6zs5+rT3fcx7mX7MYwieITLNoeqAWpD17eJlvc4tqL8JcmYQZZevfa4O47DPgohYgXnGN/IjTbW66wpM/lYsPsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708333555; c=relaxed/simple;
	bh=vNFZEnPjscvlCrvcCpkiA2cM6MQpRkPtvd7PWqYE+Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuAp19EkZK/WT6pMMWJpL4YrBqxa9XxlEuWasJLjND71BsBRYxSzcAcnPJsxyGQ0WHzpsmacnQbJwBulRrBhFjzvoE5hggorAuziAjvE6QGTi/2tMsXLQMYcPshFwKvaY/TyI0h4j+KWi+zY/QDz/3WUHBkXgN1wwxWvqYyVAfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SBK6igsu; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708333553; x=1739869553;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=vNFZEnPjscvlCrvcCpkiA2cM6MQpRkPtvd7PWqYE+Eo=;
  b=SBK6igsuQGpb0s2VktCpmLD9NF3mpJek4AEey/1vB8g8sjOZQvynHMsV
   Q+cJHAb5eFZQBWoGBQQbOVLp6iNTQlWllRwXAjA7E7Cw0v4YxgSf6BR7Y
   HEdAZcp4AmokfYXMyhfVzD4vkuU1ecjZryO8BTJWLFtly8qOR65cx4F7q
   sIKhYXSoGm0PAjUpYalo6Yoxe7NNdMlIY8PSFY8FGPeXjaedSqGxbUpgP
   z4YFiAW1jf4l0qcwd4IghmeaVxcOdRvIlHNbIYCNmWXdFVId8xmTuZMGR
   Un9WMzTqAmlEspW4hjoQ4/05qqiTX6nrEdqYOmLRRg71fSvNiiX35dAqq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="27849824"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="27849824"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 01:05:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="826976921"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="826976921"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 01:05:32 -0800
Date: Mon, 19 Feb 2024 11:05:29 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com, lakshmi.sowjanya.d@intel.com,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] pwm: dwc: Fix PM regression
Message-ID: <ZdMZ2dgoVYbZgd4K@black.fi.intel.com>
References: <20240219033835.11369-1-raag.jadav@intel.com>
 <20240219033835.11369-2-raag.jadav@intel.com>
 <luewujhgmgypcpnngyriv4trklznrkzngxe7syvfp2dontorwf@3xoooabwfitg>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <luewujhgmgypcpnngyriv4trklznrkzngxe7syvfp2dontorwf@3xoooabwfitg>

On Mon, Feb 19, 2024 at 08:22:15AM +0100, Uwe Kleine-König wrote:
> Hello Raag,
> 
> On Mon, Feb 19, 2024 at 09:08:32AM +0530, Raag Jadav wrote:
> > While preparing dwc driver for devm_pwmchip_alloc() usage, commit
> > df41cd8bbcad ("pwm: dwc: Prepare removing pwm_chip from driver data")
> > modified ->suspend() handle to use the pwm_chip as driver_data for
> > accessing struct dwc_pwm, but didn't modify ->resume() handle with
> > relevant changes. This results into illegal memory access during
> > device wakeup and causes a PM regression.
> > 
> > Fix this by correctly accessing struct dwc_pwm in ->resume() handle.
> > 
> > Fixes: df41cd8bbcad ("pwm: dwc: Prepare removing pwm_chip from driver data")
> > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > ---
> >  drivers/pwm/pwm-dwc.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
> > index 8ca1c20a6aaf..c0e586688e57 100644
> > --- a/drivers/pwm/pwm-dwc.c
> > +++ b/drivers/pwm/pwm-dwc.c
> > @@ -95,7 +95,8 @@ static int dwc_pwm_suspend(struct device *dev)
> >  
> >  static int dwc_pwm_resume(struct device *dev)
> >  {
> > -	struct dwc_pwm *dwc = dev_get_drvdata(dev);
> > +	struct pwm_chip *chip = dev_get_drvdata(dev);
> > +	struct dwc_pwm *dwc = to_dwc_pwm(chip);
> >  	int i;
> >  
> >  	for (i = 0; i < DWC_TIMERS_TOTAL; i++) {
> 
> If you're ok I'd squash this into df41cd8bbcad adding
> 
> 	Thanks to Raag Jadav for providing a hunk of this patch that Uwe
> 	missed during creation of this patch.
> 
> to the commit log.

Works for me.

Raag

