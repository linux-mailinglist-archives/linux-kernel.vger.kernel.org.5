Return-Path: <linux-kernel+bounces-12137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B8481F06D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4A001C21205
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 16:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1979B4644A;
	Wed, 27 Dec 2023 16:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R5ppuGc3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E4946454;
	Wed, 27 Dec 2023 16:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703694609; x=1735230609;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T4ZSeN9/8jL/yNrTDLrgwzo3w9DAS+9wlmLrwIMp3C8=;
  b=R5ppuGc3pSt7+eXb0AvqqswsvTUXHtTrYn+AASV6kXtin6xejliGowjX
   gSiGnZA4avEzQTo993vepEVhfOSvgVa9KKtt32JknW6kv3K+MtDWKld+5
   LjGluUT29aP+RIACBQG4rZkbdCGWDcrPCvUIArQUWKLMgrBc6erncJ2fO
   XdQF2zRb48fxc6lmvoYhel2C1x7aCGlPEqIonOwGooXW+dfCKJJxt/0ei
   FWUVtvQUfM9hJr9wLbDFmhBb1zb+z3uV2coA3Uj3zVQRF7Qhsb9tQL3JX
   Ny1yy/I/lxC1kjXvNEAGN7aPMlmEWiW0NI7TGD+BR7Z/TH/p80cWWRyrT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="3293578"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="3293578"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 08:30:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="951534508"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="951534508"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 08:30:04 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rIWnB-00000009Sn6-1TEW;
	Wed, 27 Dec 2023 18:30:01 +0200
Date: Wed, 27 Dec 2023 18:30:01 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Angel Iglesias <ang.iglesiasg@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 04/10] iio: pressure: mprls0025pa.c fix off-by-one enum
Message-ID: <ZYxRCWFs0KdrkziG@smile.fi.intel.com>
References: <20231224143500.10940-1-petre.rodan@subdimension.ro>
 <20231224143500.10940-5-petre.rodan@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231224143500.10940-5-petre.rodan@subdimension.ro>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Dec 24, 2023 at 04:34:49PM +0200, Petre Rodan wrote:
> Fix off-by-one error in transfer-function property.
> The honeywell,transfer-function property takes values between 1-3 so
> make sure the proper enum gets used.

> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>

Submitter's SoB always goes last, this is written in Submitting Patches document.

-- 
With Best Regards,
Andy Shevchenko



