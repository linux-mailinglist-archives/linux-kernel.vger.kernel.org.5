Return-Path: <linux-kernel+bounces-78914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B372D861A8D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E494F1C259DB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4481420CE;
	Fri, 23 Feb 2024 17:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EVIYKRQW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2021420BA;
	Fri, 23 Feb 2024 17:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710466; cv=none; b=oBL/nuRF7Q08IK3/zweVoErZBH3YDvkYhen2ThBV0hvI/qICN/bC8f1hvDvpZyKWJRvRkPvn0hrm5d17Z0zYdmlfJ9pS56D6f72bbyeRVVal/DhWkGh951MryiocoBE3+I5BUH9nOgfaTKqetCDYlsB+3KPPOaEGGuLwyoteLBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710466; c=relaxed/simple;
	bh=wDJdx3Q8quT65jOfA+Fpt/AIUlp60KA7hpn2802QDLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4NnXTaldTf1pJz8vyRBG9BK9LSQjU9spjPtawahfbKjeNHbkF9cL3lIx1OzBdQD/wWcgJmLbuUtimF1yO7WLs2nZK5Wmn7xH3/Lv+3JVHBlh9aBxoHMDZrN8l3WFnUqqspC7j2kPcgcei3bXfPGm7VPG9licDP0vaLXq+uxnNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EVIYKRQW; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708710464; x=1740246464;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wDJdx3Q8quT65jOfA+Fpt/AIUlp60KA7hpn2802QDLo=;
  b=EVIYKRQWD2c42ttK/zg3tswMxOvwlyeM/X1klZlPCXM/T06bX1v0O6Bk
   fqcs+gTMeaV15BEzZeo/lqd8FXz7rXk06M7gXkkb1LMx0iLiSIu/iG0c0
   4hKs5hAlS+JRo5Sea6Ie6pmbjhS/MvdqgscJUoge9X+yOJ1/xphiKXfJn
   A2r1Ql+GuvSkD601NTftNp/aj++Q5+osN0zsLcknz0089uHULO11a27Ed
   ihaiGeqw//7tpao1zOaX8fsHy9vXGLBGB7WNsHVoLYLD5qF6hufJGDC5R
   JW2vE8YMfyXiMuT3DcGnOCQ6UmXSRihLiC2KEpMtEzX7nfams/q2rC02u
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="6854291"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="6854291"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 09:47:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="913752338"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="913752338"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 09:47:40 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rdZe4-00000006xkT-3grO;
	Fri, 23 Feb 2024 19:47:36 +0200
Date: Fri, 23 Feb 2024 19:47:36 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kees Cook <keescook@chromium.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev,
	Tomislav Denis <tomislav.denis@avl.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] iio: pressure: dlhl60d: Initialize empty DLH bytes
Message-ID: <ZdjaOLVd1yxNXhsp@smile.fi.intel.com>
References: <20240223172936.it.875-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223172936.it.875-kees@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 23, 2024 at 09:29:39AM -0800, Kees Cook wrote:
> 3 bytes were being read but 4 were being written. Explicitly initialize
> the unused bytes to 0 and refactor the loop to use direct array
> indexing, which appears to silence a Clang false positive warning[1].

..

>  	for_each_set_bit(chn, indio_dev->active_scan_mask,
> -		indio_dev->masklength) {
> -		memcpy(tmp_buf + i,
> +			 indio_dev->masklength) {
> +		memcpy(&tmp_buf[i++],
>  			&st->rx_buf[1] + chn * DLH_NUM_DATA_BYTES,
>  			DLH_NUM_DATA_BYTES);
> -		i++;
>  	}

Not that I'm against the changes, but they (in accordance with the commit
message) are irrelevant to this fix. I prefer fixes to be more focused on
the real issues.

-- 
With Best Regards,
Andy Shevchenko



