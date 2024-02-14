Return-Path: <linux-kernel+bounces-65689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 824DB855074
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36A191F21C9D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724517F7D1;
	Wed, 14 Feb 2024 17:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ra7JRpsk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C9554FAF;
	Wed, 14 Feb 2024 17:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707932270; cv=none; b=DgMS/WmNwBFIf3Q/uGuCZs8a1Fy6IgHnZsybWZqUEPSypw9lwQTyLH1uCR8AyYxnj9LakB+qEwUOlJtLmnuL9RpfbU8igoBeM7bDkz0UDmRi/NGNlRKoT9CSE/2glNWmxB6MRLmTnsz1JrGjc+jgK5pubGgVaOsLdI2AA0iPYpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707932270; c=relaxed/simple;
	bh=IwbPPhdDlfbilJh1NcaWTRfUL/tISwBKZZwjUC8GC7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eFpAeLAcIQvbDSa0szhcXdXYfcxVDPH0HRYs2eZ02MPC5RAfBzVojqu3MTkRRZlAT25Bse+3ebpS0aRrSEMGXSpdyNt0Imb8msRyDBxk7SDHApDbBmseeDxg28/4qNm1wTJFoAbtLwqWjqOjVEuorzZp0oz3GeFLgmZ4FlNh/y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ra7JRpsk; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707932269; x=1739468269;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IwbPPhdDlfbilJh1NcaWTRfUL/tISwBKZZwjUC8GC7k=;
  b=Ra7JRpskBQGrt3loiMaDaJWpqW6LBC8BkTWAOSDwl/AKXuQ/dL9EQDw5
   +9XWkhJgR026Ww/yaypOvImv8p5C9RO+DOfr7hz0NaHgVJRqA5nIWGE3W
   nNsriARQwTxa1Qh9+tsiyLZqk6+UQMje20lIPbXKVOV0azT5cpOQKmldH
   9jgGlWFg24AS7/zjWXushvYDehAIoV2DuL6mVoTKtALA10pxdNcCEt9Vx
   re2LOfhFZPt6i7y14xyKv4MowRyyRP6x0FB3Vq2hYWvTWHCjf68kqLOPp
   FMMNUzuJwaIHyXnXaugrCYWqA2UttiUHwIEdScsHyIfVbulTDkrl6NxWX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="13379020"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="13379020"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 09:37:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="912092332"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="912092332"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 09:37:45 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1raJCX-00000004YWx-3yTB;
	Wed, 14 Feb 2024 19:37:41 +0200
Date: Wed, 14 Feb 2024 19:37:41 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ralf Schlatterbeck <rsc@runtux.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: auxdisplay: adjust example
 indentation and use generic node names
Message-ID: <Zcz6ZbZZBhVeOELO@smile.fi.intel.com>
References: <20240214155438.155139-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214155438.155139-1-krzysztof.kozlowski@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 14, 2024 at 04:54:37PM +0100, Krzysztof Kozlowski wrote:
> The example DTS should be indented with two or four (preferred) spaces,
> as mentioned in Writing Schema document.  While re-indenting, change the
> node names to somehow generic names, as expected by Devicetree
> specification.

Applied, thanks!

-- 
With Best Regards,
Andy Shevchenko



