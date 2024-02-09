Return-Path: <linux-kernel+bounces-59845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD9184FC6D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A2C31F24EA4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8EE83CB8;
	Fri,  9 Feb 2024 18:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cT+W+JNe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3371A80C19;
	Fri,  9 Feb 2024 18:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707505036; cv=none; b=c+m6+8RGBqDOW6uCPxSdbK27bU06rNh1DLBiPDMSl9VkR1ZMkbwGXYIJpaMuYnG5ng4T1s7fVNBshbwRJlXnlMO6gaYrZI0aPPlidOtREJzd4XWxSyejhYItAyzIZ6zZtT2z3a8QCRvbMKo75dURPxLBAWYL944TL7boSCT5HUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707505036; c=relaxed/simple;
	bh=bUAK1DEExzQReycv2NXfZg8Az8jhS3bv+ZGUUQ7Mu+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsEGOZ0EdeWVq+zlWmqad4ronxrtuKqlkE9zg4w2xLWn9fs/nJ0vn+K0NpJm+hrPB3FeWYbuhTFcBW22jSuAXpGOnPtyGWXtaAggK9zgA3GBc9B3uhDrC2+WbSNztatRRQvK4xFE/bfxDncxzB8Sm7DBE62A9UkCvWVxRL7jOt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cT+W+JNe; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707505035; x=1739041035;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bUAK1DEExzQReycv2NXfZg8Az8jhS3bv+ZGUUQ7Mu+E=;
  b=cT+W+JNeGArekz3WmmLkKkus96GW6XTzDtHtVv4X0WTiHINgwvPxFvaQ
   Xvo2xqVPBkda9fMMox6HMP2g6EVBjxX69NbPG5eGQczHsjaVAiih9qliQ
   RigiCAIZiYEaeiXX1YaazP795w9defDwCh2txiae8/iDHrgGPZ8Vgaym/
   kSYv2Ivcuv1pB1+A5CJd0dHB6wd/r9pS+Bbj79mVLDsRPetsuvi3P+ncK
   m+oY0jFlzd1UqJ9DLVa8SEwh0StxO8uRV0op7hjqEiVEglvlVfbomn0Kf
   OLMq92Hzzr8BlR+zRG3ff6ZvvMTMCIWMLJgpxjD1iUNVWybPL2ICSGcCr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="18897080"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="18897080"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 10:57:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="2350762"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 10:57:14 -0800
Date: Fri, 9 Feb 2024 10:57:11 -0800
From: Tony Luck <tony.luck@intel.com>
To: "Moger, Babu" <babu.moger@amd.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Peter Newman <peternewman@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
	Shaopeng Tan <tan.shaopeng@fujitsu.com>,
	James Morse <james.morse@arm.com>,
	Jamie Iles <quic_jiles@quicinc.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Drew Fustini <dfustini@baylibre.com>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v15-RFC 3/8] x86/resctrl: Prepare for non-cache-scoped
 resources
Message-ID: <ZcZ1hxQTjyCoQr5F@agluck-desk3>
References: <20240126223837.21835-1-tony.luck@intel.com>
 <20240130222034.37181-1-tony.luck@intel.com>
 <20240130222034.37181-4-tony.luck@intel.com>
 <b3e77817-e070-48a7-a92b-630603c81556@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3e77817-e070-48a7-a92b-630603c81556@amd.com>

On Fri, Feb 09, 2024 at 09:28:35AM -0600, Moger, Babu wrote:
> Hi Tony,
> 
> On 1/30/24 16:20, Tony Luck wrote:
> > Not all resources are scoped in line with some level of hardware cache.
> 
> same level?

No. "same" isn't what I meant here. If I shuffle this around:

	Not all resources are scoped to match the scope of a hardware
	cache level.

Is that more clear?


-Tony

