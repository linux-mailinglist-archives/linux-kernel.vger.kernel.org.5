Return-Path: <linux-kernel+bounces-12156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DF281F0B1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 18:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E16171C21012
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0730A4643A;
	Wed, 27 Dec 2023 17:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cGKi1C07"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA66145C19
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 17:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703696757; x=1735232757;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7/a0YLclKwBhsEARZDQpGejj/9BGpL74a0GALjqa+9I=;
  b=cGKi1C07hmSCl5hZAYkebs4+OvQqiFKhJQIz4bwybJy5sS8gXuubgA0+
   KObcyY60/Js7/s6XxdiB6c1RerGFG17gYmSfxYTDHkA6ZjBGR7NHF/5U9
   ys2mAttZ6jNGTcPvNuhT8zLRngabQaOxe7YCPRyt+2jAffTHevYDazVPn
   sK63yXYi3yWFj/zLpFBKFhvBdHFkCEsYcFaUPQGdarNaZynjSKFICVu2U
   lBYN5+TA69xiWPSIdo4GSWTL+a9J+WrP69RQXrR7k6QPpkhPy2S1XECDm
   d3z0rJa2Rtb33nkuA47DpRh1GyEMVJwIAeWU/vhbEnxGa+ERgLjmw4aTj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="376609029"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="376609029"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 09:05:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="848727174"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="848727174"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 09:05:53 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rIXLq-00000009TF8-3Dn7;
	Wed, 27 Dec 2023 19:05:50 +0200
Date: Wed, 27 Dec 2023 19:05:50 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Hasemeyer <markhas@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Raul Rangel <rrangel@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 01/24] resource: Add DEFINE_RES_*_NAMED_FLAGS macro
Message-ID: <ZYxZbt2nx2m1BFeZ@smile.fi.intel.com>
References: <20231226192149.1830592-1-markhas@chromium.org>
 <20231226122113.v3.1.I59b56ebd2f303784031c27bbb1529cf6ef71ba16@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231226122113.v3.1.I59b56ebd2f303784031c27bbb1529cf6ef71ba16@changeid>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 26, 2023 at 12:21:05PM -0700, Mark Hasemeyer wrote:
> In some cases, it would be nice to instantiate a struct resource with
> custom flags. For example, creating an IRQ resource with a flag that
> marks the interrupt as wake capable.
> 
> Add a set of macros to provide custom flag arguments.

> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Was it @intel.com? Please, use @linux.intel.com anyway.

> Signed-off-by: Mark Hasemeyer <markhas@chromium.org>

Tag block must _not_ have any blank line(s).

Otherwise LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

While we will have user only for IRQ case, the rest are added for symmetry's
sake, I think it's okay and we might even have more (existing) users to convert
to new macros (at least it rings a bell to me for a few places).

-- 
With Best Regards,
Andy Shevchenko



