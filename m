Return-Path: <linux-kernel+bounces-90752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5959A87046F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0CE528550A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42064087F;
	Mon,  4 Mar 2024 14:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rp8RuEU7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FFB3CF6D;
	Mon,  4 Mar 2024 14:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709563382; cv=none; b=D54ZbS6NFur54ZsNQW+RGykgxSzI05FoxEX8eYyHK2Nu36GBsBpI5etzTPOXzyAemfollihE1KmxRQaL7oUF5NAI4TizKvxLBw8fo6RIMSto7Mkv0acn5ImvGMUZjJD5bymw32BUs3Zq9KrwzxsJrQY5eMRTKaHeLFNIyxIm43A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709563382; c=relaxed/simple;
	bh=Abu6KV/lFFLKD51x+ZBxHtUmWCCRD5VIXURSK2hf1xw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L52Q+EaUn593rkNJoeb0CeT9aWUo1zLui0nt7KXZqeLIBzjTtZdZs8LPpds+d8jQ2/EuCu82Q82nmPBgjSVTQdithvIU4BRz/xTRtbKSxF9yM62z2gbKq8tDETW5kHUghDmc9ecmMxhSleoFzNMO6vgsXpvL9ZeBHh83kBp6sIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rp8RuEU7; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709563381; x=1741099381;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=Abu6KV/lFFLKD51x+ZBxHtUmWCCRD5VIXURSK2hf1xw=;
  b=Rp8RuEU7dtR7h+atP4W/dgxWPiHhqBoZ9ICd5GR3+ZwqRYu/f2cMZR9a
   jmkHHgYmJs2hZ2sepNo8HCqI66THUh0GPOpBe8PWRIYMYCO5DBdhCfec+
   ydUECLpsa3FwYomQQWGTKDpuGa+190HSxd5FwoxtuOY6XiQu0AKYccsH4
   FGsWQEEe2bE3K1o6WwXxQaw5xwLn31MtsscypGhHOx0Mw+BS1qB29h1Ou
   S0/d9QfxUeXObUnG3zJ5vmjs7y1FNo2ui0rrja1SfsSURP8Ol/H3+M8af
   Z+eCD3YOhifPPiOR/OjmRZohnnAk2YdZ7QAhLSSjNWkPN94S09wSdVk6b
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="3912267"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="3912267"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 06:43:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="914107619"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="914107619"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 06:42:58 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rh9Wq-00000009k94-18X0;
	Mon, 04 Mar 2024 16:42:56 +0200
Date: Mon, 4 Mar 2024 16:42:55 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] spi: oc-tiny: Remove unused of_gpio.h
Message-ID: <ZeXd7zrNZSTW3va0@smile.fi.intel.com>
References: <20240228193732.3605768-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228193732.3605768-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 28, 2024 at 09:37:31PM +0200, Andy Shevchenko wrote:
> of_gpio.h is deprecated and subject to remove.
> The driver doesn't use it, simply remove the unused header.

Hmm... did it fall through cracks or anything should I do?

-- 
With Best Regards,
Andy Shevchenko



