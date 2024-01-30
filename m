Return-Path: <linux-kernel+bounces-44398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81464842184
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4AF01C2558D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C3467E71;
	Tue, 30 Jan 2024 10:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dYTREBys"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6059F67E61;
	Tue, 30 Jan 2024 10:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706611044; cv=none; b=T6CoUSP+QcBJTx56XHpiTmzkkucyJER8YoPPprm9C+j+iZ1s2Joo4TFGKkBanhCVCKuer4RDSI0K57hwd02lFeGatjrxMv9hZEh1zqZMsdWs/3YEijdo3JGsP1O+pz53ZMPqBLW9P0c5PX4la03rtAd8I39JJ0/CjtcU9M2s8oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706611044; c=relaxed/simple;
	bh=TKTRofUYYrbUThvbqcMKPrRzLs8Got0eDI2UGF040b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwbs1Jb8xv2aEVYx6r43xROs9nKkR/kc+ZY0ATPInuq07J3alyDbk3MXW1oTR1vZRM7gA4OCZsNLygSNz9fJ3aeADU6/7ijWeH2o1fPCg1X5bhskl3r3nsBtV+KkLm5nzmUfHly1WuXAc+LNIg3jA7xLhWZL+E0B9ZzVAFhSbzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dYTREBys; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706611042; x=1738147042;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TKTRofUYYrbUThvbqcMKPrRzLs8Got0eDI2UGF040b4=;
  b=dYTREBysH8qpUOMNHZEFC8ziUD+64ipnFiPab1/nU5vpOT/fOxNZGjks
   jkDTxw1EHVkD9djcTlA2D88lFxDlZFtAq41gMFRmht8bgbhqvX0ENLsCF
   D7j5BmTgJBGhhfHjIGDI1nOT9QI8cuQ7ephSxzk7HgClbuOw7iCk1nTYt
   QK307zeoYuqpYv9PTjY6K4zxfszeVfk8HRC6FC/1VN7v9AO0qQXJbv6OB
   UAXzD5pluWr6mMCpfyC73oK4RybKnP+QRtFm4ehlbmRKg3QqKWshLCe+G
   bck5MUBPlgMzBeoqwvPH3WuvTRmZni/JqU+aG4mzC9E3OIoRJQ8PETHF1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="10624642"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="10624642"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 02:31:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="1119221035"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="1119221035"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 02:30:25 -0800
Date: Tue, 30 Jan 2024 12:30:23 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: u.kleine-koenig@pengutronix.de, jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com, lakshmi.sowjanya.d@intel.com,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] pwm: dwc: Add 16 channel support for Intel
 Elkhart Lake
Message-ID: <ZbjPv_-S-6CQsaja@black.fi.intel.com>
References: <20240122030238.29437-1-raag.jadav@intel.com>
 <20240122030238.29437-2-raag.jadav@intel.com>
 <ZbZqZDvdw-_D3hyb@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbZqZDvdw-_D3hyb@smile.fi.intel.com>

On Sun, Jan 28, 2024 at 04:53:24PM +0200, Andy Shevchenko wrote:
> On Mon, Jan 22, 2024 at 08:32:36AM +0530, Raag Jadav wrote:
> > Intel Elkhart Lake PSE includes two instances of PWM as a single PCI
> > function with 8 channels each. Add support for the remaining channels.
> 
> ...
> 
> > +static int dwc_pwm_init(struct device *dev, const struct dwc_pwm_info *info, void __iomem *base)
> > +{
> > +	/* Default values for single instance devices */
> > +	unsigned int nr = 1, size = 0;
> > +	int i, ret;
> > +
> > +	/* Fill up values from driver_data, if any */
> > +	if (info) {
> > +		nr = info->nr;
> > +		size = info->size;
> > +	}
> > +
> > +	for (i = 0; i < nr; i++) {
> > +		struct dwc_pwm *dwc;
> > +
> > +		dwc = dwc_pwm_alloc(dev);
> > +		if (!dwc)
> > +			return -ENOMEM;
> > +
> > +		dwc->base = base + (i * size);
> > +
> > +		ret = devm_pwmchip_add(dev, &dwc->chip);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> Why not doing this slightly differently?
> 
> First option: Always provide driver data (info is never NULL).

Allowing empty driver_data would save us from adding dummy info
for single instance devices in the future.

> Second option, have the body of the for-loop be factored to a helper
> dwc_pwm_init_one() and here
> 
> 	if (!info)
> 		return dwc_pwm_init_one(..., 1, 0);
> 
> 	for (i = 0; i < info->nr; i++) {
> 		ret = dwc_pwm_init_one(...);
> 		if (ret)
> 			return ret;
> 	}

Considering above, we're looking at something like this.

static int dwc_pwm_init_one(struct device *dev, void __iomem *base, unsigned int size)
{
        struct dwc_pwm *dwc;

        dwc = dwc_pwm_alloc(dev);
        if (!dwc)
                return -ENOMEM;

        dwc->base = base + size;

        return devm_pwmchip_add(dev, &dwc->chip);
}

	...

        if (info) {
                for (i = 0; i < info->nr; i++) {
                        ret = dwc_pwm_init_one(dev, base, i * info->size);
                        if (ret)
                                return ret;
                }
        } else {
                ret = dwc_pwm_init_one(dev, base, 0);
                if (ret)
                        return ret;
        }
	...

Raag

