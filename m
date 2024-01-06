Return-Path: <linux-kernel+bounces-18605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE878825FF9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 15:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A3961C21333
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 14:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78CA79FE;
	Sat,  6 Jan 2024 14:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ig5ZCnMq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F0C8479;
	Sat,  6 Jan 2024 14:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704552733; x=1736088733;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y5/uUMEmJcCndbVOyCLkZXNxUvIla4uXJAA27rlc62s=;
  b=Ig5ZCnMq6p1i5IvnS/5vTeHhBhy09YqbTnLG9YZ5App1N+Vx+waBSX5U
   BUzrm8yEI9ZLTWrfR6KKpzRLIT1EOqi4lhd2mzx3xf4Vvsw/yNrV2UxAz
   pVe64MzjjLKuPs1qFkWH6jj5jEbp5rifNcqR0mu83vDBsr8M/wwVj1iN9
   KjBobfV3U/nxJZ/RoeFwGYO5IoXw+qm9SZngnwT2jVwd3a/c9On7KMOVs
   PjuUUaOrTqT4PM/avHYKJvBVYvHGVChd5S/A2BnaPBj0jiuJfLoDsPxCO
   5uoMP4mk+Yprq8Dj9bKka1o0JcjFG+p1/hsDqopvyvoKuWcldJ3PVjBbb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="5016721"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="5016721"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 06:52:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="871473188"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="871473188"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 06:52:07 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rM81s-0000000Bvwn-2NJ5;
	Sat, 06 Jan 2024 16:52:04 +0200
Date: Sat, 6 Jan 2024 16:52:04 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Mark Hasemeyer <markhas@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Raul Rangel <rrangel@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Frank Rowand <frowand.list@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 21/24] device property: Modify fwnode irq_get() to use
 resource
Message-ID: <ZZlpFFZQuj99CQux@smile.fi.intel.com>
References: <20240102210820.2604667-1-markhas@chromium.org>
 <20240102140734.v4.21.I38ac58ab04985a404ed6551eb5813fa7841ef410@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102140734.v4.21.I38ac58ab04985a404ed6551eb5813fa7841ef410@changeid>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Jan 02, 2024 at 02:07:45PM -0700, Mark Hasemeyer wrote:
> The underlying ACPI and OF subsystems provide their own APIs which
> provide IRQ information as a struct resource. This allows callers to get
> more information about the IRQ by looking at the resource flags. For
> example, whether or not an IRQ is wake capable.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



