Return-Path: <linux-kernel+bounces-68920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A1F8581ED
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18E641C20A82
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CCD1350F5;
	Fri, 16 Feb 2024 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ECy4aIFV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37ACB133298;
	Fri, 16 Feb 2024 15:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708098793; cv=none; b=Nd7K3ZMpMvPV9wd5DqEHyF7m8+omQAc6VCeRMGgqCZhKnXIgOKkCqPOK3UBxniCb2MFILHBUxGEtLKgS8tbeHbYoXeY7PFQu/7nW3kRnhd988wrBTxn6goWjmPaDmpaj3y3Y4/9tuM3TjWVKZ1pn5bVfPwz7dXex2iEwjos+xk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708098793; c=relaxed/simple;
	bh=ETzxVU5TL7u3yOgl+fq2bk8/qmTAeHHWvLXY1JVcMm4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=n1uFory1NeEd1uYGixrpNO3hsUGPBJu/OgNUtnUFQNYVz1kASyspy9OQ3fSKy3bnVo9YiGY9dFt1o8N1LOMOVMZlNmmt4szxYtRh/ekO/w1rl6BetCxqV25r29HiFGB1wNxYnqS7We2XJyeewHOx3r2XbF8QnezxV6C+D6Wm0I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ECy4aIFV; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708098791; x=1739634791;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ETzxVU5TL7u3yOgl+fq2bk8/qmTAeHHWvLXY1JVcMm4=;
  b=ECy4aIFVWmkqCWBchhdtU24tWMJBGIzZtosancRfm0fzYAuzjt4yKyBF
   Ifqwgldp3hbSW2oQbnJ2OhrGvi7iRJk5LpnactuBAGrHOZVBd70h/MJTr
   RzpOPHsYWwhmUIhT+Y5e7oeV+f/fNsXjYMP9ztxlS02kCG4vHnpE7aCam
   cPOFZJyU/ziSJpkMYhwbB9brwzynQ6Al9nT9v4xgnELlTt2V/zAwD91Lw
   W6YUkooVcJQbirGlA1os/WQlvK29I7NBQLAsycEDqrLiqOZay7/1gKv9t
   /CtX1UHWf6l766RnNYgMDUCnwIBRrfC8zZBho/eaMUyE5bmzgAoqZqIz1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="13630527"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="13630527"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 07:53:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="935862609"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="935862609"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 07:53:06 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rb0WN-000000055TF-2g31;
	Fri, 16 Feb 2024 17:53:03 +0200
Date: Fri, 16 Feb 2024 17:53:03 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mike Looijmans <mike.looijmans@topic.nl>, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Cc: Mike Looijmans <mike.looijmans@topic.nl>,
	Arnd Bergmann <arnd@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Liam Beguin <liambeguin@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Maksim Kiselev <bigunclemax@gmail.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Mark Brown <broonie@kernel.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Okan Sahin <okan.sahin@analog.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] iio: adc: ti-ads1298: Add driver
Message-ID: <Zc-E3-MNe9dG9tdW@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

..

+	if (reset_gpio) {
+		/*
+		 * Deassert reset now that clock and power are active.
+		 * Minimum reset pulsewidth is 2 clock cycles.
+		 */
+		udelay(ADS1298_CLOCKS_TO_USECS(2));

This is sleeping context and you are calling unsleeping function. I haven't
checked the macro implementation and I have no idea what is the maximum it may
give, but making code robust just use fsleep() call.

+		gpiod_set_value_cansleep(reset_gpio, 0);
+	} else {
+		ret = ads1298_write_cmd(priv, ADS1298_CMD_RESET);
+		if (ret)
+			return dev_err_probe(dev, ret, "RESET failed\n");
+	}
+	/* Wait 18 clock cycles for reset command to complete */
+	udelay(ADS1298_CLOCKS_TO_USECS(18));

Ditto.

..

If it's the only issue I think Jonathan can modify when applying
(no new patch version would be needed).

-- 
With Best Regards,
Andy Shevchenko



