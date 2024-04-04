Return-Path: <linux-kernel+bounces-131737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2BC898B43
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 987011F22281
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA38712A16C;
	Thu,  4 Apr 2024 15:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pm6lCRsq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CD976033;
	Thu,  4 Apr 2024 15:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712244986; cv=none; b=PelvLETv9bN9Y1ADYs0g+cmpa/UaHASfpJU3I6qDmrFbJYgdyhLT3DaE546hAhW1o06mxEGsKoV5eTXIlGh6JLkatNE7ab5biHfkV3bP3WUNbuy9MgXflHRXk3xKumIIN9OC8iIrTSQoleQ+KIf5vxl/J6y0pV6TZySzVZe2wro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712244986; c=relaxed/simple;
	bh=mqU4Ab8nucfJiHZpDwZ2rqsNF9/3h9DMm+EcXQt2KTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DON6FAFaaE/lJ70amwXV4JNEbbQecyWDqrBF8n+y9FJO8NYV09lr/G2GSwzDkXKHTwgkMaB0/KJ047/3ieKBak96l0kx4hFd0oKIYm9o+S2NoxonhKaLI6vgXA9yIVn/peA814600ueT6dHpWeKdpy6IGPUXY0D8ZlS0P+8QqJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pm6lCRsq; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712244984; x=1743780984;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mqU4Ab8nucfJiHZpDwZ2rqsNF9/3h9DMm+EcXQt2KTQ=;
  b=Pm6lCRsq0cA/ZHIslzqdWPptVkZmfjlbOH413wYwqmNDM091z0d1l1np
   Sa8LVdsbSAZGqiEcREuWGXUIO5FnuwKCTewGRxPwLPF2YetDrBrD9Ev+l
   uVXjRJ1uEvFvPwI0t0gQcWUxkx4PpyZjbOgcUvOEfo2lQszWTW2mqHvK5
   P56Mr1RomnuKbuViDTQRyX2U+QxbjX0XRYwxtoTDEdgxxHd+SBNPtxQ1E
   ompRtOQ4VBjk0ZiJpVQNTTGOvY7dW3kpZldqcSCMPQBvzKEdPYwUzhzBE
   Cq+s50zYFH4sgiL8OM5dSlZkwWxBDitwh4clDlVpk7u+2BLfb3nm2UsKX
   g==;
X-CSE-ConnectionGUID: RLCFqjZPTHa30l0i7eInUg==
X-CSE-MsgGUID: 2B8SIto2SuC4H4EJiD8/Ag==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="25042567"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="25042567"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 08:36:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="915221673"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="915221673"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 08:36:17 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rsP8Q-00000001V4g-3ARn;
	Thu, 04 Apr 2024 18:36:14 +0300
Date: Thu, 4 Apr 2024 18:36:14 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kent Gibson <warthog618@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alexey Dobriyan <adobriyan@gmail.com>, stable@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 2/2] gpio: cdev: fix missed label sanitizing in
 debounce_setup()
Message-ID: <Zg7I7nYkZLcIgETq@smile.fi.intel.com>
References: <20240404093328.21604-1-brgl@bgdev.pl>
 <20240404093328.21604-3-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404093328.21604-3-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 04, 2024 at 11:33:28AM +0200, Bartosz Golaszewski wrote:
> From: Kent Gibson <warthog618@gmail.com>
> 
> When adding sanitization of the label, the path through
> edge_detector_setup() that leads to debounce_setup() was overlooked.
> A request taking this path does not allocate a new label and the
> request label is freed twice when the request is released, resulting
> in memory corruption.
> 
> Add label sanitization to debounce_setup().

..

> +static inline char *make_irq_label(const char *orig)
> +{
> +	char *new;
> +
> +	if (!orig)
> +		return NULL;
> +
> +	new = kstrdup_and_replace(orig, '/', ':', GFP_KERNEL);
> +	if (!new)
> +		return ERR_PTR(-ENOMEM);
> +
> +	return new;
> +}
> +
> +static inline void free_irq_label(const char *label)
> +{
> +	kfree(label);
> +}

First of all this could have been done in the previous patch already, but okay.

..

> +			label = make_irq_label(line->req->label);
> +			if (IS_ERR(label))
> +				return -ENOMEM;
> +
>  			irqflags = IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING;
>  			ret = request_irq(irq, debounce_irq_handler, irqflags,
>  					  line->req->label, line);

But the main point how does this change fix anything?

Shouldn't be

-					  line->req->label, line);
+					  label, line);

?

> +			if (ret) {
> +				free_irq_label(label);
>  				return ret;
> +			}

-- 
With Best Regards,
Andy Shevchenko



