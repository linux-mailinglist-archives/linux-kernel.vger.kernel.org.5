Return-Path: <linux-kernel+bounces-9718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B13081CA2A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 13:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C36B287691
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEFC182DF;
	Fri, 22 Dec 2023 12:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JaGVH2zl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D196E18038;
	Fri, 22 Dec 2023 12:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703249179; x=1734785179;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=79KGKvfI99h6FsUQLnzddH+/22c8KQjG2/EbM0CWaFg=;
  b=JaGVH2zlaSu2zo2OKByQtdScM5q5fIT+aCk5gXKkFqU5nHqJoBaMQ2fE
   YR3LT9qknOaBK69s1r6+1wHIXjmgKf7UTj5Ip6EBgFcHs4jHSaSEP7alo
   w5lCvshrRgb5MLUL+zyUzEm3TjxrRzRUVub3t3Ja9vjlbrV1NpqcYcGFq
   AcFUtHEkauf8cmFdkqF35vcQBNpjUrnYpN2QUOPIay4ojFbYzE83NPpiE
   wMZW1fHoGvrBHeeefg3/wJZeNLAbH3xRHnSarSKN0r3m0uZ1dYs/FFZle
   EeYJlkyvlkbcUokdwaadxWBBw/3DPh94PFIEJlPlTdhm+6z8ADA+GJSu5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="3197001"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="3197001"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 04:46:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="726778691"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="726778691"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 04:46:13 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rGeuo-0000000895l-03PO;
	Fri, 22 Dec 2023 14:46:10 +0200
Date: Fri, 22 Dec 2023 14:46:09 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Raul Rangel <rrangel@chromium.org>
Cc: Mark Hasemeyer <markhas@chromium.org>,
	LKML <linux-kernel@vger.kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
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
Message-ID: <ZYWFEZNPaLASir-y@smile.fi.intel.com>
References: <20231220235459.2965548-1-markhas@chromium.org>
 <20231220165423.v2.20.I38ac58ab04985a404ed6551eb5813fa7841ef410@changeid>
 <ZYRD9Y3Y_jd1NBs8@smile.fi.intel.com>
 <CANg-bXDLC_+mxFU+dHyCx1K=HKTwwGw+r__6_++Co2-viTbsgQ@mail.gmail.com>
 <CAHQZ30BOA7zuRrN-kK5Qw+NYSVydfhJ0gDPr9q-U+7VKXHzG8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHQZ30BOA7zuRrN-kK5Qw+NYSVydfhJ0gDPr9q-U+7VKXHzG8g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Dec 21, 2023 at 04:47:59PM -0700, Raul Rangel wrote:
> On Thu, Dec 21, 2023 at 4:46 PM Mark Hasemeyer <markhas@chromium.org> wrote:
> 
> > > > -int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int
> > index)
> > > > +int fwnode_irq_get_resource(const struct fwnode_handle *fwnode,
> > > > +                         unsigned int index, struct resource *r)
> > >
> > > It's perfectly fine to replace ) by , on the previous line, no need
> > > to make it shorter.
> >
> > That puts the line at 115 chars? checkpatch.pl allows a maximum line
> > length of 100. I can bump the 'index' argument up a line and keep it
> > to a length of 95?
> 
> clang-format should do the right thing.

Sorry, but no. It has some interesting results sometimes.
Like any other tool it has to be used with caution and
common sense. If it works in the particular case, fine.

-- 
With Best Regards,
Andy Shevchenko



