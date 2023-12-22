Return-Path: <linux-kernel+bounces-9734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C40381CA64
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 14:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A418D1C21796
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 13:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3D71B271;
	Fri, 22 Dec 2023 13:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IXZrRXGJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287531A5AC;
	Fri, 22 Dec 2023 13:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703250003; x=1734786003;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fv31BzKXjf3VSQsvu13miz4XDE3frIaa7KSOGe2arrg=;
  b=IXZrRXGJMI1CcYlSE5Bkg3jCZcphEAwjdo4LM37pLYc/aXTu7ROGn6Gh
   MxDa1KIaD0aW1CqvI+Z7nCJcNnDsEvi/Ks6QYyJkdGdrKAau9O9agDD4l
   xT485Eo0L0XBe7fsTvfV3lZRG+yTgOIRsAYOpYOjdV4cpZJ/KLeISdJTq
   i2i6eKrdw5toI+qfrwPvMnXSvj2sTe53kPUYatIhTjGfM3hZLdorcokI5
   +isIWtGhyJpFKKwEpNsVJJ7ILwWzYs1hWWcH7MyxBJKv7O6m3mo0YDwPK
   eBnczlYlZ1EuIwHDbzd7sJRTWZPMVwSLveiIkWHKkQoLzey9BpRMqO/WA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="375600610"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="375600610"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 05:00:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="811306267"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="811306267"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 04:59:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rGetW-0000000894Y-0bLf;
	Fri, 22 Dec 2023 14:44:50 +0200
Date: Fri, 22 Dec 2023 14:44:49 +0200
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
Message-ID: <ZYWEwfcsTHksYkn4@smile.fi.intel.com>
References: <20231220235459.2965548-1-markhas@chromium.org>
 <20231220165423.v2.20.I38ac58ab04985a404ed6551eb5813fa7841ef410@changeid>
 <ZYRD9Y3Y_jd1NBs8@smile.fi.intel.com>
 <CANg-bXDLC_+mxFU+dHyCx1K=HKTwwGw+r__6_++Co2-viTbsgQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANg-bXDLC_+mxFU+dHyCx1K=HKTwwGw+r__6_++Co2-viTbsgQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Dec 21, 2023 at 04:46:11PM -0700, Mark Hasemeyer wrote:
> > > -int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index)
> > > +int fwnode_irq_get_resource(const struct fwnode_handle *fwnode,
> > > +                         unsigned int index, struct resource *r)
> >
> > It's perfectly fine to replace ) by , on the previous line, no need
> > to make it shorter.
> 
> That puts the line at 115 chars? checkpatch.pl allows a maximum line
> length of 100. I can bump the 'index' argument up a line and keep it
> to a length of 95?

Yes, the point is to leave index on the previous line and add a new one with
the r.

-- 
With Best Regards,
Andy Shevchenko



