Return-Path: <linux-kernel+bounces-58646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B25784E95C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 21:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CF3F1C225C2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D33383A1;
	Thu,  8 Feb 2024 20:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BatepFwE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4587C37711
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 20:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707422859; cv=none; b=JZeT/FTJtGfiprnAdJh7KJEe5t1oWA8Lz6hT9Ww1COejiCrTKeueSw4MlTZElo+URenZkUI4LAgOv6sD/6iV7hgP3XXlqwSphpC40LAi8JPJA+nBvGwmSzRJn6+fbJp2WfhSIiq7nsDWrOCTII+tsPxHuObRV71kFnKjcB5XaJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707422859; c=relaxed/simple;
	bh=jEFILA4AOQFKP5N74g+wybLTvwBqH/t+DpqAbP4ze7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCuPlhN2RfYvNcjAoRKg3edZ22dVv+1mYPfPEsg+OoYPQQbcC7btjZd8h4sBgGxQ1XXR9YZWufBV1/KL/7IjmV+ETfNJDnF0TJbIc0YOH/4tKKGJheb5cGSYQ9PuX91WyC9u4NyihPUxydhE19JfrD1bHilZ95RWRLjTs+AdK6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BatepFwE; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707422858; x=1738958858;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jEFILA4AOQFKP5N74g+wybLTvwBqH/t+DpqAbP4ze7w=;
  b=BatepFwE/5EMDIIUvc1oScRNASq4mwjchjmvL5CIlFmGYFhKbqmcDV42
   IM4qO2wioX5+vPK9Zqu6iEMMeQYeJ+NLIiVs2Gu/GOJVroVFdSv/z1aqv
   HQxQ5Mt+TzHsC21ZB+1Rp3DhlcLLFyywsFu7pKAZtg/qeIlnn3p+nvZBq
   UoCTLMH5cDVXp58E4LgRCQxXENb4cs4KAn0QjbsMiS5kmRtNjnb7zA5Hj
   rwkhZutChhJF56oX9YgJUilY/Hi+DkL0GuFqJ/DOcMZUjDExPDSSU55Iq
   9eR43IM902lyo9oXBSxfVLkwjO63gKxAHGbXgVNVM7f321dT3qxdwWLIM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1463070"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1463070"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 12:07:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="6388559"
Received: from udig-mobl1.ger.corp.intel.com (HELO intel.com) ([10.246.32.229])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 12:07:35 -0800
Date: Thu, 8 Feb 2024 21:07:32 +0100
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v3 3/3] drm/i915: Convert REG_GENMASK* to fixed-width
 GENMASK_*
Message-ID: <ZcU0hDSPOmhX76pq@ashyti-mobl2.lan>
References: <20240208074521.577076-1-lucas.demarchi@intel.com>
 <20240208074521.577076-4-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208074521.577076-4-lucas.demarchi@intel.com>

Hi Lucas,

..

> +#define REG_GENMASK(__high, __low)	GENMASK_U32(__high, __low)
> +#define REG_GENMASK64(__high, __low)	GENMASK_U64(__high, __low)
> +#define REG_GENMASK16(__high, __low)	GENMASK_U16(__high, __low)
> +#define REG_GENMASK8(__high, __low)	GENMASK_U8(__high, __low)

I was hoping to use directly GENMASK_U*() functions.

Andi

