Return-Path: <linux-kernel+bounces-12169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2AA81F0DF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 18:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE0AB1C21002
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B25C4644F;
	Wed, 27 Dec 2023 17:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jp6H7hRj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C7246446;
	Wed, 27 Dec 2023 17:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703697882; x=1735233882;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YeGj6BF4LShX1s5ntKuAPF5HSjvV7r3YboweMh1Hwrs=;
  b=jp6H7hRjHxDm+p3qyOrI4TBKW4BHsSuCUhAFp0+IqMzU70qnLisb1VGu
   f+bmof+DojYD0v9EJQeZsxA6LG8MufJVaRuOjGuON9oYCDV/vCYE/FZAX
   gOwvm4XHRypmpxqRhCK8iFhoYL9o4k08l7pmn7ZYBlF3KZdViW6n7jEqm
   zKwu6AQ84w+uvHB0eREiUNsW1GMFHs0aPTJ3P60nBPzCYVqTaso+NEipH
   pVtjI8gN8YI4NdDYK3yUyYuTs+ZoiYDOzcDcVnebCG7vgV24HSpaeOtL9
   HcQPxDt86u4I1+4UGZxFie5hLvhp1YLVZEglsCQ1aVjc4NsOH6BsjLBle
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="18024038"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="18024038"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 09:24:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="781788630"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="781788630"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 09:24:21 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rIXdi-00000009TSn-3OHF;
	Wed, 27 Dec 2023 19:24:18 +0200
Date: Wed, 27 Dec 2023 19:24:18 +0200
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
Message-ID: <ZYxdwrJw7_JudQXB@smile.fi.intel.com>
References: <20231226192149.1830592-1-markhas@chromium.org>
 <20231226122113.v3.21.I38ac58ab04985a404ed6551eb5813fa7841ef410@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231226122113.v3.21.I38ac58ab04985a404ed6551eb5813fa7841ef410@changeid>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 26, 2023 at 12:21:25PM -0700, Mark Hasemeyer wrote:
> The underlying ACPI and OF subsystems provide their own APIs which
> provide IRQ information as a struct resource. This allows callers to get
> more information about the IRQ by looking at the resource flags. For
> example, whether or not an IRQ is wake capable.

...

> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> Signed-off-by: Mark Hasemeyer <markhas@chromium.org>

No blank line.

...

A side note: in all files where you use ioport.h check if you actually included it.

...

> -#include <linux/types.h>
> -#include <linux/list.h>
>  #include <linux/bits.h>
>  #include <linux/err.h>
> +#include <linux/ioport.h>
> +#include <linux/list.h>
> +#include <linux/types.h>

Fine, but no. This file is still not using the iopoll.h.
See the forward declarations below? It should be there.

>  struct fwnode_operations;
>  struct device;

...

> --- a/include/linux/property.h
> +++ b/include/linux/property.h

Same comment(s) here.

-- 
With Best Regards,
Andy Shevchenko



