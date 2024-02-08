Return-Path: <linux-kernel+bounces-58445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 536C584E697
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 546801C23D54
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1711823A7;
	Thu,  8 Feb 2024 17:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E6PIkqSo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E807BAE3;
	Thu,  8 Feb 2024 17:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707412941; cv=none; b=hQj0Rx2F1AMyiTYTZ3xmHtsvslI5Td1FZIKoPbr0uHzMrowpSyKNlO9x3b2WdiPfpOy2ijwfOmHGPNBtARcvq4BbzuRmwnxFXcfXiYf97c6+rker5tbU1TFUtoYGcUuWXNvca/GoTduN9LqmtO2XBG+zaX9K//5SgJxmst4REqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707412941; c=relaxed/simple;
	bh=rr8ZJxXonkzhW9rsfoKVdr0RuDOiP81rEOHReOmPIHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWam0vweFn8Ba57nxEFOA6KEnh1JZylpRFSMJLS+hXX4R2yEBc3K284RVMl0r1La2mVi8lOyS/Egy83vyS5yjKfkY38rVnhpGvobRe77VIMtwsdSlf6fYwftC5UtFkfr02CYEDKv7xejc5M8qJ4OgbgKlBcHjU3tzAH9JRJViTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E6PIkqSo; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707412940; x=1738948940;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rr8ZJxXonkzhW9rsfoKVdr0RuDOiP81rEOHReOmPIHk=;
  b=E6PIkqSoxBfG99MMIz4WMLxrIMW//1KbBZuitnmfADApIti6onTEBAQG
   pvvAk25+buI18/9P1DSuEhTS9E0JO9sHgn4E8OBEGsGKYtdQGCvmuQTLp
   RedP+WWer6ID7I7cGZM2flD8zJbgAMKHS6uMmpJ7qQWFWBy3rxOYnHtcX
   7Vb5oi+p9kNel0EEhxVIx/iJ5T8EIXEUwhLPTQ3qj85YzcotplwIRFc0l
   8/Q0LR/TBo9NdOdL21s9RvlvEF1i/JBTFxDAHeNqbYgwdYKIFJXsysNcs
   3yFRLXn9VJbsFykcDZeQd7IyQl9F8hTtqgSiZj+EzFl5LL/wBWhlvZME5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="11843429"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="11843429"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 09:22:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="910433615"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="910433615"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 09:22:16 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rY86H-00000002w4n-2huk;
	Thu, 08 Feb 2024 19:22:13 +0200
Date: Thu, 8 Feb 2024 19:22:13 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: u.kleine-koenig@pengutronix.de, jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com, lakshmi.sowjanya.d@intel.com,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] pwm: dwc: simplify error handling
Message-ID: <ZcUNxT4lxFYhZNBB@smile.fi.intel.com>
References: <20240208070529.28562-1-raag.jadav@intel.com>
 <20240208070529.28562-4-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208070529.28562-4-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 08, 2024 at 12:35:27PM +0530, Raag Jadav wrote:
> Simplify error handling in ->probe() function using dev_err_probe() helper.

..

> +		return dev_err_probe(dev, ret, "Failed to enable device (%pe)\n", ERR_PTR(ret));

Have you checked the output?
Note, it will duplicate error codes which we don't want.

..

> +		return dev_err_probe(dev, ret, "Failed to iomap PCI BAR (%pe)\n", ERR_PTR(ret));

Ditto.

-- 
With Best Regards,
Andy Shevchenko



