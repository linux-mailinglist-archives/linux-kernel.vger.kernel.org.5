Return-Path: <linux-kernel+bounces-18588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B550825FC6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 15:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C99EB2187B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 14:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB03748E;
	Sat,  6 Jan 2024 14:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WnhsEeM4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CC07469;
	Sat,  6 Jan 2024 14:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704549955; x=1736085955;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b8S9YQ723Vakq/AypdH+EFs2g1D+6lWqicTwgFrXQVY=;
  b=WnhsEeM47w4acjUoTE0d+WugJ3tUhpSkBWxmi66OWMQ3eGckmWG26yda
   n9AU4MOEs2fm3QLE+Y4iw1LVS7fgPhDocTbKK5w0z+UxRSuB9fgenqrz/
   kRRz/rq/J0A+X//rFleXgYrMzGXKzoqXor3nIKJpPjUNyt/ECWEAEtygf
   YrCxcm/Q13p21vH37Ft+f9G7JddjO5+RWOIiBDUbPWXGMhY/JuEl4vlpU
   ppOToTOxeVhNkxdd6zxxmVYSBzp1nwtvw9LzXn3cIWL2xVQlnWyBeVJcq
   mb1HWSsxucJ6hsN90yQNA6kazJKzNyayxKuGe9XAshKExeCiPDrwDHRWf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="5025338"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="5025338"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 06:05:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="1112336317"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="1112336317"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 06:05:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rM7J4-0000000BvKX-1CLt;
	Sat, 06 Jan 2024 16:05:46 +0200
Date: Sat, 6 Jan 2024 16:05:46 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Mark Hasemeyer <markhas@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Raul Rangel <rrangel@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Frank Rowand <frowand.list@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 21/24] device property: Modify fwnode irq_get() to use
 resource
Message-ID: <ZZleOi6-ekoTL-Jk@smile.fi.intel.com>
References: <20231226192149.1830592-1-markhas@chromium.org>
 <20231226122113.v3.21.I38ac58ab04985a404ed6551eb5813fa7841ef410@changeid>
 <ZYxdwrJw7_JudQXB@smile.fi.intel.com>
 <CANg-bXBwWXaJWv9gMtjYvRBnOaP3E8U1nh5-ScWOoyRayzn7Zw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANg-bXBwWXaJWv9gMtjYvRBnOaP3E8U1nh5-ScWOoyRayzn7Zw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Dec 27, 2023 at 12:09:19PM -0700, Mark Hasemeyer wrote:
> > A side note: in all files where you use ioport.h check if you actually included it.

...

> > > -#include <linux/types.h>
> > > -#include <linux/list.h>
> > >  #include <linux/bits.h>
> > >  #include <linux/err.h>
> > > +#include <linux/ioport.h>
> > > +#include <linux/list.h>
> > > +#include <linux/types.h>
> >
> > Fine, but no. This file is still not using the iopoll.h.
> > See the forward declarations below? It should be there.
> >
> > >  struct fwnode_operations;
> > >  struct device;

...

> > > --- a/include/linux/property.h
> > > +++ b/include/linux/property.h
> >
> > Same comment(s) here.
> 
> I don't fully follow. Are you suggesting adding an explicit 'struct
> resource' declaration as opposed to including ioport.h?

Yes.

> If so, why? To reduce scope?

Build time, better granularity, less include hellness.

-- 
With Best Regards,
Andy Shevchenko



