Return-Path: <linux-kernel+bounces-128101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E3E895625
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C00F1C228F2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1451885C4E;
	Tue,  2 Apr 2024 14:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XGVIEOve"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FE833D1;
	Tue,  2 Apr 2024 14:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066727; cv=none; b=L0jxwowQTuo62xTXmbaO5jT7q86r4aP5rEkb+2digoqoZji9CKO2/YZJ6ct0jzKLyUPI7NDJAvzNtJD0Kk07WevasoSEjrgiHiMprMPDLsfHUiXDL9RtCEeDvQbQ001ThfwhPaayBnJYpGOxURPs54PwBB0YlD1CT0HvSxi3v4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066727; c=relaxed/simple;
	bh=Z8Q+FvrgVLtKZvinSRjIAzqcwxHLMko61zcYomKVbtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kbn5H2f2sidG2k8leX1Pgg8UR0JB80A0eADmZV6h5H2/BI1+J97MUNtZGC6y04V0sQQ3RaMR59vvlGzXFMvt8ClCkJmIxHikSXhUYyt0wl0nTYCJxh+BgdPTuRwHWeQv5QXSB+r0oZaGA+y2M69Cw/KwlmwBujPYUGxOaVv84Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XGVIEOve; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712066726; x=1743602726;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z8Q+FvrgVLtKZvinSRjIAzqcwxHLMko61zcYomKVbtY=;
  b=XGVIEOveVighIFYSGxGQ8arUQZ7BRYlMb2vnkOWcNy3mZjvhs1R2g7st
   ZjoaAqq3sWV42eYd//hoku5gHCf50O2E0jmss2jvzhJIhhirTNFFRHqB/
   dyNf6bh5zfYG32V/qmE4W6LEFbc6nEeheKA0x8p0P+nJiO3iq6NvxbeoD
   lnrpDcf6gbm6ncJ2V24ky3nyK8iRjy/l5w49tHN+kEAgeC5eIAXlQAUH1
   86+RR7mvhUC0TYGt4j5hvWdsgRT7UFRYXyZYyt3qCs+KnNJpQBLQq7evt
   KbhTIamwwTy5XCzPa55LP0StNlBsDuTeM3r82ZrbwU5BJ4NQxq97akcO8
   Q==;
X-CSE-ConnectionGUID: /bNXem5VSN+p6GjhkfTuzA==
X-CSE-MsgGUID: j5Fk0iLoSRqN+ZyP312XyQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="18688675"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="18688675"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 07:05:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="915142121"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="915142121"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 07:05:21 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rrelL-00000000pMt-1Qwx;
	Tue, 02 Apr 2024 17:05:19 +0300
Date: Tue, 2 Apr 2024 17:05:19 +0300
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
Subject: Re: [PATCH v7 3/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Message-ID: <ZgwQn7DzrBh-aUVX@smile.fi.intel.com>
References: <20240402-pinctrl-scmi-v7-0-3ea519d12cf7@nxp.com>
 <20240402-pinctrl-scmi-v7-3-3ea519d12cf7@nxp.com>
 <ZgwEtxj-qi6uy_m2@smile.fi.intel.com>
 <DU0PR04MB941780B4C28DB353C64966F8883E2@DU0PR04MB9417.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB941780B4C28DB353C64966F8883E2@DU0PR04MB9417.eurprd04.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 02, 2024 at 01:27:19PM +0000, Peng Fan wrote:
> > On Tue, Apr 02, 2024 at 10:22:23AM +0800, Peng Fan (OSS) wrote:

..

> > > +#include <linux/module.h>
> > > +#include <linux/scmi_protocol.h>
> > > +#include <linux/slab.h>
> > 
> > Please, follow IWYU principle, a lot of headers are missed.
> 
> ok. I will try to figure out. BTW, is there an easy way to filter
> out what is missed?

For you is much easier than to me as I'm not familiar with the code.
Basically you should know what you wrote :-)

But if you are asking about tooling, we would appreciate when somebody comes
with a such.

> > > +#include "common.h"
> > > +#include "protocols.h"

..

> > > +		ret = scmi_pinctrl_get_pin_info(ph, selector,
> > > +						&pi->pins[selector]);
> > 
> > It's netter as a single line.
> 
> I try to follow 80 max chars per SCMI coding style. If Sudeep and Cristian
> is ok, I could use a single line.

It's minor, but even before relaxation of 80 limit it was and is mentioned
in the documentation that you may go over if it increases readability.

> > > +		if (ret)
> > > +			return ret;
> > > +	}

..

> > > +static int scmi_pinctrl_protocol_init(const struct
> > > +scmi_protocol_handle *ph) {
> > > +	int ret;
> > > +	u32 version;
> > > +	struct scmi_pinctrl_info *pinfo;
> > > +
> > > +	ret = ph->xops->version_get(ph, &version);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	dev_dbg(ph->dev, "Pinctrl Version %d.%d\n",
> > > +		PROTOCOL_REV_MAJOR(version),
> > PROTOCOL_REV_MINOR(version));
> > > +
> > > +	pinfo = devm_kzalloc(ph->dev, sizeof(*pinfo), GFP_KERNEL);
> > > +	if (!pinfo)
> > > +		return -ENOMEM;
> > > +
> > > +	ret = scmi_pinctrl_attributes_get(ph, pinfo);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	pinfo->pins = devm_kcalloc(ph->dev, pinfo->nr_pins,
> > > +				   sizeof(*pinfo->pins), GFP_KERNEL);
> > > +	if (!pinfo->pins)
> > > +		return -ENOMEM;
> > > +
> > > +	pinfo->groups = devm_kcalloc(ph->dev, pinfo->nr_groups,
> > > +				     sizeof(*pinfo->groups), GFP_KERNEL);
> > > +	if (!pinfo->groups)
> > > +		return -ENOMEM;
> > > +
> > > +	pinfo->functions = devm_kcalloc(ph->dev, pinfo->nr_functions,
> > > +					sizeof(*pinfo->functions),
> > GFP_KERNEL);
> > > +	if (!pinfo->functions)
> > > +		return -ENOMEM;
> > > +
> > > +	pinfo->version = version;
> > > +
> > > +	return ph->set_priv(ph, pinfo, version);
> > 
> > Same comments as per previous version. devm_ here is simply wrong.
> > It breaks the order of freeing resources.
> > 
> > I.o.w. I see *no guarantee* that these init-deinit functions will be properly
> > called from the respective probe-remove. Moreover the latter one may also
> > have its own devm allocations (which are rightfully placed) and you get
> > completely out of control the resource management.
> 
> I see an old thread.
> https://lore.kernel.org/linux-arm-kernel/ZJ78hBcjAhiU+ZBO@e120937-lin/#t
> 
> The free in deinit is not to free the ones alloced in init, it is to free the ones
> alloced such as in scmi_pinctrl_get_function_info

Even messier than I thought. For bare minimum these two should be documented
and renamed accordingly that no-one will think that deinit is a counter part
of init.


-- 
With Best Regards,
Andy Shevchenko



