Return-Path: <linux-kernel+bounces-128106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE7889564D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2141B229F7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4D186120;
	Tue,  2 Apr 2024 14:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MMupnFhb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E2985268;
	Tue,  2 Apr 2024 14:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066965; cv=none; b=Parppya4PA2GY1At/kKfwOOnqqe4K0hbX3lfujK7fPubiq7+CU5aSOCMlgTeWWKQNOglZQqsPmAHTIM9wPHKaHgFWIlJ0dd1xZxDosxes/jcHFOIMXCVDFJmAMXlFC92pfcFRiPF3nYH8uVX6p/06LYh1RjozVdX9BJv2FrLil4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066965; c=relaxed/simple;
	bh=uEC3a2yUsQ6IMUZDu++fBR8R8oM+dRgeV4GJKC1kyJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c38Dagp/iSfhGp4G9rV5CaOJcy8lq+LYzvftDp0vgsEfGvs4oEkZwaILDHAcOM79DZoBbb6Dh70HtOex//2oX5SrCMh75Ax2lv0LVWFDspmtIo2I5vFXKwc6Je0yaumxFN6BpvbOnEIywe+kcQjtaQf1oX2frLfrjUF2oPGgRdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MMupnFhb; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712066964; x=1743602964;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uEC3a2yUsQ6IMUZDu++fBR8R8oM+dRgeV4GJKC1kyJ4=;
  b=MMupnFhb3XCs6dLvyp0XcP/G1ag++noF/AYxfGUXTZpoH+iIbzbEZQRt
   MJgWC5u/Tcw/uClJAUaswWKoL7fhziqRJGwExJ/ylwzj1qfXwkMNbhNcN
   7H2W6tIPxPdkGiblZb7WEjqKJPZa6SpzazuxXlU0yDX/TALs+0w7Du5gg
   04Tn0Cz13XVmDy7jVfSLmfbGgzLPjqOgG+Zz6FHfgpF0yLm2D6kRJlrRE
   XILk6uToUBy+h6YNGd1gXKg6DXds+wtGxI1CG/a6oGwes5R9hY4NysAmQ
   FHxfY0uQv/atDQaUwpTlTnAbyOsWA5KkJkeWbCI4Z/g2Eh+KqywonNnjZ
   A==;
X-CSE-ConnectionGUID: cVH/vLLbQTGejBwQGrAHIQ==
X-CSE-MsgGUID: Z4dBD783QEGe62H+acCQMQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="18689668"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="18689668"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 07:09:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="915142247"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="915142247"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 07:09:19 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rrepB-00000000pQY-1kBR;
	Tue, 02 Apr 2024 17:09:17 +0300
Date: Tue, 2 Apr 2024 17:09:17 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Subject: Re: [PATCH v7 4/4] pinctrl: Implementation of the generic
 scmi-pinctrl driver
Message-ID: <ZgwRjXbf_EV23S-P@smile.fi.intel.com>
References: <20240402-pinctrl-scmi-v7-0-3ea519d12cf7@nxp.com>
 <20240402-pinctrl-scmi-v7-4-3ea519d12cf7@nxp.com>
 <ZgwGpZ6S13vjk8jh@smile.fi.intel.com>
 <DU0PR04MB9417D0D33573E99D440D7BD7883E2@DU0PR04MB9417.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB9417D0D33573E99D440D7BD7883E2@DU0PR04MB9417.eurprd04.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 02, 2024 at 01:59:19PM +0000, Peng Fan wrote:
> > On Tue, Apr 02, 2024 at 10:22:24AM +0800, Peng Fan (OSS) wrote:

..

> > > +#include <linux/device.h>
> > > +#include <linux/err.h>
> > > +#include <linux/module.h>
> > > +#include <linux/seq_file.h>
> > > +#include <linux/scmi_protocol.h>
> > > +#include <linux/slab.h>
> > 
> > Missing headers.
> 
> Not sure there is an easy way to filter out what is missed.

And?..

You are the author, not me. You know your code much better and
it will be quite easy to perform. I may miss things, but reading
briefly the 1000 lines and get what headers are required takes
no more than half an hour.

(Tools that help me, in case I don't remember by heart, are
 `cscope` and `git grep ...`.)

..

> > > +		ret = pinctrl_ops->name_get(pmx->ph, i, PIN_TYPE,
> > &pins[i].name);
> > > +		if (ret)
> > 
> > How does the cleanup work for the previously assigned pin names? Is it
> > needed?
> 
> No need. The "name" memory region is allocated in firmware pinctrl
> Protocol init phase.
> 
> > Maybe a comment?
> 
> ok.  As below.
> /*
>  * The region for name is handled by the scmi firmware driver, 
>  * no need free here
> */

LGTM.

> > > +			return dev_err_probe(pmx->dev, ret,
> > > +					     "Can't get name for pin %d", i);

-- 
With Best Regards,
Andy Shevchenko



