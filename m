Return-Path: <linux-kernel+bounces-129390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7C48969FF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F9F01C25D9F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA807350C;
	Wed,  3 Apr 2024 09:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EL4Yk29I"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726BB6F076;
	Wed,  3 Apr 2024 09:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712135096; cv=none; b=Ei9XbzqW4Q8sCrtULoMf3W2ZBDb/5uAbmrM/o6FMKbFcfZBrqKyck0TZNitNFIhszN9hKKyxE5mHJSelzOYDwszB5yI0NMc4w34htgelRaxpsXpoE54BTd1poFesguKAdtdujz5H/DrUlFc9XjIP9vDMSgAXP62HnmfACUnb59E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712135096; c=relaxed/simple;
	bh=3vfTelqA3yYRG96fAMrL2EeVlynnaMGtmej49RqpETA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XgPhKCfsIGEw2u2xTQvnnSeKK95OoZbm+jBebSurPJlXN+zT8V8Fq8dmpBl0KeEor6Z2QQ7CfxTDLF1hePL6Hy7n/f54345Bo3hzHK6LYhGTujU/BnoYVjZ/x5GS4pYkjdH6YUaXIzVCKLXIoZs/25oO3qPwoS9+t1HWlHsUEK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EL4Yk29I; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712135094; x=1743671094;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3vfTelqA3yYRG96fAMrL2EeVlynnaMGtmej49RqpETA=;
  b=EL4Yk29IeK6PyLDyUy+BkNN0z/cectJFnJumoVyxEvuwcFl4y0M5gtiQ
   EXKDHFkGL0Qqwr/hvYGunK0cfdhsWGOAYysjzwIp+TLJWPVRZlwkYw6+E
   MmgZ8umZVIl/7qSFyxAeHpCHmHSV5CR9NfOOtG8N6RKd6Vpp1/+ork43s
   /qEaYbukpPsxQjjkbIQQu480wFnY5wfnf9vQIEjvY5xh/dAfg3vuebPd9
   KuemOnObChOWB2yPtz7nH/EJ0ZiQEMQrGa3K8bTsLw0qWjPKNKW0RDJeM
   XJfUa97GRiVPa3vqct+phlPVkqPRZbHkSCVECm1xzTDeGIhHOKQRLIMHX
   A==;
X-CSE-ConnectionGUID: k9lZ3D+JRKy4k2LkrYi8FQ==
X-CSE-MsgGUID: Xr+aJUvvSh6z4bXs9Z32pg==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7480119"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7480119"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 02:04:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="915175028"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="915175028"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 02:04:47 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rrwY1-000000014L0-0vqT;
	Wed, 03 Apr 2024 12:04:45 +0300
Date: Wed, 3 Apr 2024 12:04:44 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Andi Shyti <andi.shyti@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Li Zetao <lizetao1@huawei.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Rob Herring <robh@kernel.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Luis de Arquer <luis.dearquer@inertim.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Sam Protsenko <semen.protsenko@linaro.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Jaewon Kim <jaewon02.kim@samsung.com>, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 31/34] spi: remove incorrect of_match_ptr annotations
Message-ID: <Zg0brIClNuW_Ur1B@smile.fi.intel.com>
References: <20240403080702.3509288-1-arnd@kernel.org>
 <20240403080702.3509288-32-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403080702.3509288-32-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 03, 2024 at 10:06:49AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When building with CONFIG_OF  disabled but W=1 extra warnings enabled,
> a couple of driver cause a warning about an unused ID table:
> 
> drivers/spi/spi-armada-3700.c:806:34: error: unused variable 'a3700_spi_dt_ids' [-Werror,-Wunused-const-variable]
> drivers/spi/spi-orion.c:614:34: error: unused variable 'orion_spi_of_match_table' [-Werror,-Wunused-const-variable]
> drivers/spi/spi-pic32-sqi.c:673:34: error: unused variable 'pic32_sqi_of_ids' [-Werror,-Wunused-const-variable]
> drivers/spi/spi-pic32.c:850:34: error: unused variable 'pic32_spi_of_match' [-Werror,-Wunused-const-variable]
> drivers/spi/spi-rockchip.c:1020:34: error: unused variable 'rockchip_spi_dt_match' [-Werror,-Wunused-const-variable]
> drivers/spi/spi-s3c64xx.c:1642:34: error: unused variable 's3c64xx_spi_dt_match' [-Werror,-Wunused-const-variable]
> drivers/spi/spi-st-ssc4.c:439:34: error: unused variable 'stm_spi_match' [-Werror,-Wunused-const-variable]

I would drop these 'drivers/spi/' parts as we know they are all in the same folder.

> These appear to all be copied from the same original driver, so fix them at the
> same time by removing the unnecessary of_match_ptr() annotation. As far as I
> can tell, all these drivers are only actually used on configurations that
> have CONFIG_OF enabled.

LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



