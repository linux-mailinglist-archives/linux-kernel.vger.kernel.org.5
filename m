Return-Path: <linux-kernel+bounces-9719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C12E881CA2E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 13:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 770541F2287C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6091C18631;
	Fri, 22 Dec 2023 12:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TIfgSUDs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197001803A;
	Fri, 22 Dec 2023 12:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703249210; x=1734785210;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CHn976YL5HBziRVUDO+1XcDkDlkynI0AtiosgSm9of8=;
  b=TIfgSUDsNZmBGorfcsxahOdjUWyFnnY9gyDbk8Nh/9HfyB6q687KlsPV
   hcySZFxN1nHm4/VsQpV8naWLsATrC0P4qB94am925ox+H7uFNjPyq3ui3
   l1vW/UmDQe/MccXNSEaMbARjEZAUb1Viype3/HNuZyUK2ckLHA5Pz1BVZ
   7MAntAZEahopxHfL529iWdyfp/xG4W4+DVtOb7lO3GGixT8OMD/uvNGcp
   Y2t5dV7oexdmJ0LN4C9P5Ym3B5Xr/0PiC+nxjrDlgbbXKN2dmDg/4N8nw
   bSnazQczgaZ70DvD1ZgT5mdYRm5jfK6StIpQv9TiKb/xzoldPjiRCBeeX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="460444172"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="460444172"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 04:46:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="780541262"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="780541262"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 04:46:45 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rGevK-00000008969-0kvJ;
	Fri, 22 Dec 2023 14:46:42 +0200
Date: Fri, 22 Dec 2023 14:46:41 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Mark Hasemeyer <markhas@chromium.org>
Cc: Raul Rangel <rrangel@chromium.org>, LKML <linux-kernel@vger.kernel.org>,
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
Message-ID: <ZYWFMU2UN09J0Ef4@smile.fi.intel.com>
References: <20231220235459.2965548-1-markhas@chromium.org>
 <20231220165423.v2.20.I38ac58ab04985a404ed6551eb5813fa7841ef410@changeid>
 <ZYRD9Y3Y_jd1NBs8@smile.fi.intel.com>
 <CANg-bXDLC_+mxFU+dHyCx1K=HKTwwGw+r__6_++Co2-viTbsgQ@mail.gmail.com>
 <CAHQZ30BOA7zuRrN-kK5Qw+NYSVydfhJ0gDPr9q-U+7VKXHzG8g@mail.gmail.com>
 <CANg-bXAsaKJxQ8xON59BAH1_SdVqvCQfDTco-osehjLW2T0Vmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANg-bXAsaKJxQ8xON59BAH1_SdVqvCQfDTco-osehjLW2T0Vmg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Dec 21, 2023 at 04:59:42PM -0700, Mark Hasemeyer wrote:
> >> > > -int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index)
> >> > > +int fwnode_irq_get_resource(const struct fwnode_handle *fwnode,
> >> > > +                         unsigned int index, struct resource *r)
> >> >
> >> > It's perfectly fine to replace ) by , on the previous line, no need
> >> > to make it shorter.
> >>
> >> That puts the line at 115 chars? checkpatch.pl allows a maximum line
> >> length of 100. I can bump the 'index' argument up a line and keep it
> >> to a length of 95?
> >
> > clang-format should do the right thing.
> 
> It formats the line as-is in the patch: with 'unsigned int index' on
> the next line.

Exactly, and I don't think we need that "smartness" in this case.

-- 
With Best Regards,
Andy Shevchenko



