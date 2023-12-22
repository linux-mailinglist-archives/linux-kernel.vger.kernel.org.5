Return-Path: <linux-kernel+bounces-9733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA4081CA61
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 14:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DDEEB2262D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 13:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C59C18C34;
	Fri, 22 Dec 2023 12:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VGrpT6ab"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B43199A4;
	Fri, 22 Dec 2023 12:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703249997; x=1734785997;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xExjhciA/N3WM9dDckPnrwN2i4ltkIWuaBTMVJdJhwM=;
  b=VGrpT6absRo4j0AqQXQ/FlDmJI3udbyUMZeGsnF7A8GDQ7Xp9F4M3ciI
   oGrDF1yFDdMjc4kNqjXRCnoncQTU/2AqQqggQ/2IXL1qPpxj7/jKn4+Fs
   0IcAnHsgWUl6viZpLD7WD6++LgM2VT8ROaQOhI+QCpxIyrWnHUnJp2uhy
   O9XsharUHRxpZGl7NhOxtDvYKOutnXkqMMIr5UdBpeyLdfiRngsWjG9vl
   TQolwL59S1uy5aqh1eWyah98rSbMlEJH+NbX/M8nuXnKBXFkphhFntTM2
   Lp5oKwHgqZ27/HzAlbNKc7hEgh+tm6cqlCZJyXA6iR1gDsSNcb8GkaZtB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="375600593"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="375600593"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 04:59:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="811306255"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="811306255"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 04:59:51 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rGewv-0000000897j-3zDt;
	Fri, 22 Dec 2023 14:48:21 +0200
Date: Fri, 22 Dec 2023 14:48:21 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Mark Hasemeyer <markhas@chromium.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
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
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 20/22] device property: Modify fwnode irq_get() to use
 resource
Message-ID: <ZYWFlYlDimdP2S2A@smile.fi.intel.com>
References: <20231220235459.2965548-1-markhas@chromium.org>
 <20231220165423.v2.20.I38ac58ab04985a404ed6551eb5813fa7841ef410@changeid>
 <ZYQVdE4esAZbtMrn@kekkonen.localdomain>
 <CANg-bXCshpg5=rRiaxbjdEeD3VNsdV-cKxu-nCqT7K_f8wJodA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANg-bXCshpg5=rRiaxbjdEeD3VNsdV-cKxu-nCqT7K_f8wJodA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Dec 21, 2023 at 04:52:15PM -0700, Mark Hasemeyer wrote:
> > Both acpi_irq_get() and of_irq_to_resourece() use EXPORT_SYMBOL_GPL()
> > instead. I don't see why fwnode_irq_get_resource() shouldn't do the same.
> >
> > With this changed,
> >
> > Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> >
> > In fact this should have always been the case for fwnode_irq_get(). I
> > wouldn't mind changing that, too, in a separate patch.
> 
> Sure. It looks like fwnode_iomap(), fwnode_irq_get(),
> fwnode_irq_get_byname(), and fwnode_graph_parse_endpoint() could all
> be updated. I'll add another patch with these changes unless there's a
> reason some of those functions shouldn't be GPL'd?

Interesting... Once should look at the history of those changes.
I don't think anything prevents us from moving to GPLed versions.

-- 
With Best Regards,
Andy Shevchenko



