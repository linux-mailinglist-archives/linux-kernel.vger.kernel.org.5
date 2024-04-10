Return-Path: <linux-kernel+bounces-139295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E098A0113
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D0241C22549
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B39181B94;
	Wed, 10 Apr 2024 20:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WtU7HoIA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FD431A60
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 20:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712779968; cv=none; b=k1PkeaZfZHL3scAFsBKKbyYQvY0EJYpl3Y+gklJ5Vvfuy38/PjP7xfVq+y/kQZibeV3I/Ot5tmb9PRU7rGuNzNcnYt1WnFxnunr1fnUj/4EWX9QFdqo/U+m3q6bq6Aeby5+WXVfcZGqDxLAOGqD0/lWEIOjHnTJnkg5f+a7SMuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712779968; c=relaxed/simple;
	bh=MQqS0yV7s4VtYWiXLHaJi4gPzGWrodgYI+vYYMo1Cgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqrtCUOspcfE/IfgCc9ckGiFPwb2/1BOgmqyjS4loDpwKFcAnPzxvPh2W5dYcjn3axyaa6Xp3PkYKmaNIHzJGuI9TDRe1zGBzYxMiFom6FXdSsSGLlEQR2YSw9soKgbGUnbolg4nxZnuDMACCZgtCaxjlwhkjDLdkbe3f+1j9NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WtU7HoIA; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712779968; x=1744315968;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MQqS0yV7s4VtYWiXLHaJi4gPzGWrodgYI+vYYMo1Cgo=;
  b=WtU7HoIA/ihutzobYJR259A6AWyti6bcTLiOecB5TQo2nbX6R1bdPxW6
   eGob3bftw1GCJR9880AFO6IYw4ypicsIYJ/rikod3PzKFROK6gi+jnlK2
   OabAnb5AlEJne8MZLplMEMh2S5fARirMYUFT6tohWgj+x3qUXlPgSLfyq
   bg+OQwFJ9hgsNfEYfgdt6RF6RUafBNlaSPPgwz7paMKlQ0QccKPq/a4n1
   KkvzX/pSP349bvlJPUZyDnE7ia9sY00ZJQmD8PDiwb0u4jjAJ6xgAn09c
   WpyB+Dfd8oH6GdxgRWPAwZzBZzp3dUxnkfwqafs+84kQJPYxEtoC7OANW
   g==;
X-CSE-ConnectionGUID: +9jLLLOxRdySB5HM5+vSTw==
X-CSE-MsgGUID: xUgcpTMwSB2SMZET3pjyjQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8021253"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="8021253"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 13:12:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="915441993"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="915441993"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 13:12:45 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rueJH-00000003BCX-1Ztm;
	Wed, 10 Apr 2024 23:12:43 +0300
Date: Wed, 10 Apr 2024 23:12:43 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 1/1] regmap: spi: Add missing MODULE_DESCRIPTION()
Message-ID: <Zhbyu-qI97eBxtxU@smile.fi.intel.com>
References: <20240410200031.1656581-1-andriy.shevchenko@linux.intel.com>
 <3602aa7a-15c9-4e77-8aa9-a12f2136530c@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3602aa7a-15c9-4e77-8aa9-a12f2136530c@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 10, 2024 at 09:05:17PM +0100, Mark Brown wrote:
> On Wed, Apr 10, 2024 at 11:00:31PM +0300, Andy Shevchenko wrote:
> 
> > +MODULE_DESCRIPTION("Regmap SPI Module");
> 
> regmap.

Hmm...

drivers/base/regmap/regmap-i3c.c:59:MODULE_DESCRIPTION("Regmap I3C Module");
drivers/base/regmap/regmap-mdio.c:120:MODULE_DESCRIPTION("Regmap MDIO Module");
drivers/base/regmap/regmap-sdw-mbq.c:100:MODULE_DESCRIPTION("Regmap SoundWire MBQ Module");
drivers/base/regmap/regmap-sdw.c:101:MODULE_DESCRIPTION("Regmap SoundWire Module");
drivers/base/regmap/regmap-spi.c:168:MODULE_DESCRIPTION("Regmap SPI Module");

-- 
With Best Regards,
Andy Shevchenko



