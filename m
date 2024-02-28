Return-Path: <linux-kernel+bounces-85438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 253D686B5F6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAB2FB28833
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E1B15957C;
	Wed, 28 Feb 2024 17:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ix/XMzvG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EFB34CDE;
	Wed, 28 Feb 2024 17:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709141259; cv=none; b=jAJz4lhMuZHIlQnOyP1g4eZVVDObxqE3pRrlLk8N3OouApyS6xqGcdmAFoNnMp2nvzfF0TCDZ94RFGHiY5qzcoEdLWInOUz5Igef/Erdl3aVWNMUmza186MlQYA1hS4it+D0FSZtgPN/OwTaIF+VfZIBiLpThEVdhFMBLx/Zo9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709141259; c=relaxed/simple;
	bh=a6yPinrfFCyv1D0aYBQjzitLgkEQTPi0B91kfaZLW0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqr40XIWgaXW8Vtsqm91OmZRiplyvMetFrM20mGmxb3Lv9RiTg8hClNrL2IkAE2LxyDbtKASXjVHHCxpGl8OLbClnzpzsTIB2InKPS4Q3aG1BeHhw07jYbI7etwCyI9TR+ZFEkGaRD9BB8oR+//wl/aCrIKtebPYr+1jznEthh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ix/XMzvG; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709141259; x=1740677259;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a6yPinrfFCyv1D0aYBQjzitLgkEQTPi0B91kfaZLW0U=;
  b=Ix/XMzvGBqid+ta5dulE/RJq/IBijC7mt94AEL1asjECxCFSzfXstxqM
   e0JSRmyXof+T9utEClK5Jm5fFpZs/BxiNr5UlJW+TT+bm4T83HbXQ8JJE
   DHL8NssyWTJRwYBjavOjHn7TZQXP0cskQlMUExEzCc480BHieFPl/FsIl
   kbiCP/+XuIK510nO3kZ39itOM09kP755hZsnkGEaCFthKGkkOJa6FeU11
   7Agw8+VZfp/T/Xz1Mau/O9OmQfjuDX90fMWekM1/6fnbWCD1ofuJkwMh9
   gtDEWRm9CKhfIWnEiGoWvG4R1KLKD7mt73JUvhgUzUJfQ50frLDOlug/i
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3720069"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="3720069"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 09:27:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="913956212"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="913956212"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 09:27:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rfNiM-00000008Has-1Z2p;
	Wed, 28 Feb 2024 19:27:30 +0200
Date: Wed, 28 Feb 2024 19:27:30 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
	Anshul Dalal <anshulusr@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Matt Ranostay <matt@ranostay.sg>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 5/5] iio: light: Add support for APDS9306 Light Sensor
Message-ID: <Zd9tApJClX7Frq20@smile.fi.intel.com>
References: <20240228122408.18619-1-subhajit.ghosh@tweaklogic.com>
 <20240228122408.18619-6-subhajit.ghosh@tweaklogic.com>
 <a828e77c-b3d4-49bb-b0bb-b9fd6cb7d114@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a828e77c-b3d4-49bb-b0bb-b9fd6cb7d114@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 28, 2024 at 03:08:56PM +0200, Matti Vaittinen wrote:
> On 2/28/24 14:24, Subhajit Ghosh wrote:

..

> > +	ret = iio_gts_find_new_gain_by_old_gain_time(&data->gts, gain_old,
> > +						     intg_old, val2, &gain_new);
> 
> You don't use the 'ret' here, so maybe for the clarity, not assign it.
> Or, maybe you wan't to try to squeeze out few cycles for succesful case and
> check the ret for '0' - in which case you should be able to omit the check
> right below as well as the call to iio_find_closest_gain_low(). OTOH, this
> is likely not a "hot path" so I don't care too much about the extra call if
> you think code is clearer this way.
> 
> > +	if (gain_new < 0) {
> > +		dev_err_ratelimited(dev, "Unsupported gain with time\n");
> > +		return gain_new;
> > +	}

What is the difference between negative response from the function itself and
similar in gain_new?

-- 
With Best Regards,
Andy Shevchenko



