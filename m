Return-Path: <linux-kernel+bounces-12142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0DD81F07F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 767FD281EDF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 16:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CA445030;
	Wed, 27 Dec 2023 16:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d6AfPwTg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA0D1E529;
	Wed, 27 Dec 2023 16:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703695137; x=1735231137;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tCXv9QMQM3EUDowZwDiCOGywQdITNJJvAjpDRRmMORE=;
  b=d6AfPwTg+uKA7bhMpHMJiuCWhm0ZfzLPKS58NsjlIN2l8kha+M82iClb
   K0FK8dzudmrtQZmHJrrnz8B6uQWfEx/KOEa4cY+QSdvGeovJmXcQWRNR/
   D8FCAwnDnt9hHoGJVJRAppmYI3ki/sVegNCDcBdIxGUuK8+TLXgvqssjc
   yJZmtQrgLbF1sSGXHmGZR43a37ZcMuzIY6EZcuJ6vSI0fgq5kIN9rtY3Y
   DE0GekaloERJ5XtCXoeLum5AdTJ+CQZSrWmdOwt2SgVM8FTrsr1BbTZYj
   SmgrBCIy/zZu0k6AEFAp+QGWjAczetPLekkUpzG7WKZaj4x4Brvl9wv6W
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="3748665"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="3748665"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 08:38:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="921876930"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="921876930"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 08:38:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rIWvh-00000009StU-3kO5;
	Wed, 27 Dec 2023 18:38:49 +0200
Date: Wed, 27 Dec 2023 18:38:49 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Tero Kristo <kristo@kernel.org>, Tony Lindgren <tony@atomide.com>,
	LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Subject: Re: [PATCH 01/10] clk: ti: Less function calls in
 of_omap2_apll_setup() after error detection
Message-ID: <ZYxTGQyl8vTFTHDo@smile.fi.intel.com>
References: <20849a8e-e0f5-46df-ad8a-9eae6cbe337b@web.de>
 <422c6249-31ac-410e-911d-ec25aeee126a@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422c6249-31ac-410e-911d-ec25aeee126a@web.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Dec 24, 2023 at 05:36:57PM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 24 Dec 2023 11:15:27 +0100
> 
> The kfree() function was called in up to three cases by
> the of_omap2_apll_setup() function during error handling
> even if the passed variable contained a null pointer.
> This issue was detected by using the Coccinelle software.

> * Split a condition check.
> 
> * Adjust jump targets.
> 
> * Delete three initialisations which became unnecessary
>   with this refactoring.

Instead, make use of cleanup.h.

-- 
With Best Regards,
Andy Shevchenko



