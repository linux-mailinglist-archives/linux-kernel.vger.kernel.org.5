Return-Path: <linux-kernel+bounces-3876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A9C817494
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78F94282BB9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201B137899;
	Mon, 18 Dec 2023 15:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q84+5Cpu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E9D1D15F;
	Mon, 18 Dec 2023 15:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702911755; x=1734447755;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=n+CcIVCq8nUf1G5r1wyIIWCphC7mHVA3V90KQXIpPuU=;
  b=Q84+5Cpus3jFocHsFXUU+HtRao80Bt7psQ6kQdZEV7KKRgpkk+XuAaYo
   9rdOrmKkhpe767NTP0y9yJuS/SJCWi9Q3fyJ+t0zKce4iHD3BtQIg+AbF
   heHPI1v/bwyRYayYyeRF05gRl98QJn1tbm3V/0S4fUy3k5tfiaED+XZck
   IsoxXCXVzO2GpNb9YJhbFaBmBqzA4dsMUbu03lRXup3eCXX/Pt/+GZ4Qg
   +7Ea3v9KLSn1cE5fFmtdhRlns3D6+GTh+FNC/wwppC2uu7j/HNk3sr7Vu
   5vLJH9k/Wrvf3FLQYcUVyCEuz3lDTb59DraqFifvze90NALqa7U+fwSTs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="426651283"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="426651283"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 07:02:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="948802262"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="948802262"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 07:02:29 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rFF8U-00000006y5z-00uS;
	Mon, 18 Dec 2023 17:02:26 +0200
Date: Mon, 18 Dec 2023 17:02:25 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v1 0/3] gpio: mmio: Make driver agnostic
Message-ID: <ZYBfAbvs-7lMzuy-@smile.fi.intel.com>
References: <20231025184259.250588-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=MfZm7TDHRRLrDmnyj3vmbscmpveR0fveYfsGz0SdaskKw@mail.gmail.com>
 <ZYBKn9UZIhY03DiV@smile.fi.intel.com>
 <ZYBKxv_M23j0k_K-@smile.fi.intel.com>
 <CAMRc=Mcu4H12pV0rT4OXLsaEShn4r9XM2rbQ1VK-SmgxwidWUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mcu4H12pV0rT4OXLsaEShn4r9XM2rbQ1VK-SmgxwidWUg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Dec 18, 2023 at 02:37:48PM +0100, Bartosz Golaszewski wrote:
> On Mon, Dec 18, 2023 at 2:36 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Dec 18, 2023 at 03:35:28PM +0200, Andy Shevchenko wrote:
> > > On Mon, Dec 18, 2023 at 01:43:40PM +0100, Bartosz Golaszewski wrote:

...

> > > Thank you! I guess you forgot to add --sign-off to the `git merge ...`
> >
> > Sorry, it's --signoff.
> 
> I never sign-off on merges though, is it mandatory? Probably not as
> there are no warnings from next like for regular commits about missing
> sign-offs.

No idea. I do it as it is harmless, and makes commit more robust.

For me it's fine, but I leave for me to exclaim later "Yay, had told ya!" :-)

-- 
With Best Regards,
Andy Shevchenko



