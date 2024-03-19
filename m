Return-Path: <linux-kernel+bounces-106988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D038B87F65E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9E791C21D9C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 04:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86877C092;
	Tue, 19 Mar 2024 04:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mdpkWybJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D0B5F544;
	Tue, 19 Mar 2024 04:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710822294; cv=none; b=E3O24uuruA7HrZUOkpJKbnjH2dP6lflJEfTR/gJnkxQJyrK6dBeV3TBzCHw0o4nwDpvuCYIvfXGGAjUZRL+KyWb43drVecgYJWjok+vUlZNejADtImtgkUsvi2Z5o7DjWYnQufNJmWsniRTKxh+kn+SWtMscfMbKrnpafX0JcRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710822294; c=relaxed/simple;
	bh=8COTqAO78HYhmDSxjg8TTpsRSgxaVPz9po3QmqxHMyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rRAEJtSrAVT4IjZXpTrYx2KyeEEUzxIBd1kCur7Ujr2meEYCEJCzHvRAPo/WcHjTAmMNoZq24ZiA8Pu8x1utJw45WZdvrB92UCtFCvUv50gYch6dHBDNZn/aOL+G4rIfwjPVidpR/+MO1nlgAl6GNFuBDc/DDw/9cb4lOXKYLFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mdpkWybJ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710822292; x=1742358292;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8COTqAO78HYhmDSxjg8TTpsRSgxaVPz9po3QmqxHMyA=;
  b=mdpkWybJg0oQLh7VDqqnVeY7ZQ9Uxi7u+g5so/ZLpXEf1Z6mjJeECiQD
   eZg0iQEh0G8QpaE5J58xhP7cYJwJeRp+Yv3h4bokXpjlbQ9BLQevEdsqD
   LHmwMi8Icnmu8GHUNHJVXCMrBWoEsKGfkZLBx4HBI8YJMaZdHeY91zTLy
   Fd6ZWufro/6Mzbs3dD257ltfS2/ZPr/75aQ7dwFRGxVX/AXy3BieYoQ3w
   jJfrOmMPRu+Sm4CJAjJm0YXbHwwf8INKIl4dh6bxpBBh7x2+7GdVbo+VB
   CX3xgVllAzXrNxO4rqNVWqeYzzUO22JF427Xj5Vo8oJH7w2ap7JhNv/pf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="23174513"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="23174513"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 21:24:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="14146453"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa007.jf.intel.com with ESMTP; 18 Mar 2024 21:24:47 -0700
Date: Tue, 19 Mar 2024 12:20:15 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Charles Perry <charles.perry@savoirfairelinux.com>
Cc: mdf@kernel.org, avandiver@markem-imaje.com, bcody@markem-imaje.com,
	Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michal Simek <michal.simek@amd.com>, linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 1/3] fpga: xilinx-spi: extract a common driver core
Message-ID: <ZfkSf6QG5nIY0zpx@yilunxu-OptiPlex-7050>
References: <20240313225746.489253-1-charles.perry@savoirfairelinux.com>
 <20240313225746.489253-2-charles.perry@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313225746.489253-2-charles.perry@savoirfairelinux.com>

> +/**
> + * struct xilinx_fpga_core - interface between the driver and the core manager
> + *                           of Xilinx 7 Series FPGA manager
> + * @dev:       device node
> + * @write:     write callback of the driver
> + * @prog_b:    PROGRAM_B gpio descriptor
> + * @init_b:    INIT_B gpio descriptor
> + * @done:      DONE gpio descriptor

Please re-check the Documentation again:
"Structure fields that are inside a private: area are not listed in the generated output documentation"

> + */
> +struct xilinx_fpga_core {
> +/* public: */
> +	struct device *dev;
> +	int (*write)(struct xilinx_fpga_core *core, const char *buf,
> +		     size_t count);
> +/* private: handled by xilinx-core */
> +	struct gpio_desc *prog_b;
> +	struct gpio_desc *init_b;
> +	struct gpio_desc *done;
> +};
> +
[...]
> -
>  static int xilinx_spi_probe(struct spi_device *spi)
>  {
> -	struct xilinx_spi_conf *conf;
> -	struct fpga_manager *mgr;
> +	struct xilinx_fpga_core *conf;

Why do you name it conf? Maybe "core" is better?

Thanks,
Yilun

