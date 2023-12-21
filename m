Return-Path: <linux-kernel+bounces-8604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5E581BA0E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37B2EB248EA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9778438DC9;
	Thu, 21 Dec 2023 14:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CVERI9Cz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684B4539E4;
	Thu, 21 Dec 2023 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703170797; x=1734706797;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OoapTPukjShzEohQxJsr9nMKqKZQxWObxkyyNaa2x2o=;
  b=CVERI9Cz7w/UOXBmVypCObeprp4Dik3z4YE2uu/CDu25zSo+ajYIN6CQ
   nytYl/+NNNFY5R9GjXge6OnWy9k7EBa2kuDNGz6vVyrPcdG8ByMNa00je
   gp2CI8lAJLAdwkervr/4/hUCt9yEftljlJYR8+Bc+pCQ6oANjCa3KyEn7
   yjtsSni0xMtzF+uGGlTeQCTF7PpIQAJhhBgUhJKteswSNGFuXzylD4Cv2
   2ik3aUbpYdcibEUzhbJ35OlCQpQtD1c1ctMUQYGDcKcl1Jw+gMZg3aJYa
   XpYztKL3w2spkJOyYmyfdCizXgAvG65INdT8hnPFqMExcPS/1qUnUsHwD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="2811584"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="2811584"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 06:59:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="900120139"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="900120139"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 06:59:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rGJWv-00000007rjT-2rCh;
	Thu, 21 Dec 2023 15:56:05 +0200
Date: Thu, 21 Dec 2023 15:56:05 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Mark Hasemeyer <markhas@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Raul Rangel <rrangel@chromium.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
	Daniel Scally <djrscally@gmail.com>,
	Frank Rowand <frowand.list@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 20/22] device property: Modify fwnode irq_get() to use
 resource
Message-ID: <ZYRD9Y3Y_jd1NBs8@smile.fi.intel.com>
References: <20231220235459.2965548-1-markhas@chromium.org>
 <20231220165423.v2.20.I38ac58ab04985a404ed6551eb5813fa7841ef410@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220165423.v2.20.I38ac58ab04985a404ed6551eb5813fa7841ef410@changeid>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Dec 20, 2023 at 04:54:34PM -0700, Mark Hasemeyer wrote:
> The underlying ACPI and OF subsystems provide their own APIs which
> provide IRQ information as a struct resource. This allows callers to get
> more information about the IRQ by looking at the resource flags.  For

Double space when other lines have a single space.

> example, whether or not an IRQ is wake capable.

Suggested-by?

...

> -int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index)
> +int fwnode_irq_get_resource(const struct fwnode_handle *fwnode,
> +			    unsigned int index, struct resource *r)

It's perfectly fine to replace ) by , on the previous line, no need
to make it shorter.

...

> +int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index)
> +{
> +	struct resource r;

	struct resource r = {};

?

> +	return fwnode_irq_get_resource(fwnode, index, &r);
> +}

-- 
With Best Regards,
Andy Shevchenko



