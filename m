Return-Path: <linux-kernel+bounces-51411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 933D4848AEC
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 04:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 243B0B243C1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 03:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7032F1C0F;
	Sun,  4 Feb 2024 03:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R8dLUbZS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E1F15B7;
	Sun,  4 Feb 2024 03:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707018439; cv=none; b=n0V60mqtpywtWxuBqn+y/puSe3jdsaWkn8JpyOW9l//7Q93Yz8IZjt3TPhKU6UErfGoPqemh8WI9T08e9uhXiqJQvpU44WNkG/tqxOYEp6f3e5wsmDcH8EMKT72UqgZFBGFNHbCRZZxxfIhCwJQveK2IR91tKJoK95/v4vnG44Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707018439; c=relaxed/simple;
	bh=nN8b/YIhvuAxbyPKPHgRfYM5wEEdCOqOUQZ/LG7L0wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldvB2ajod1dV9+jsol8hyHNUHb6tN+zQjSTxXsN6rRUNGW5FafE5403OKXlHGGDwlcEDo35Z9+KtAdVTNzGy79ihXQ80GyRSMUIkQDXIs7KsgpeU1coMRQVwUxmjfYsERBJfROOcKZ6lJuvoDh3SaA58tw4jq/bLsy3d29Hccr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R8dLUbZS; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707018438; x=1738554438;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nN8b/YIhvuAxbyPKPHgRfYM5wEEdCOqOUQZ/LG7L0wY=;
  b=R8dLUbZSfjtA67RvHMERXTp9JIFzORbk4eLUJc7bjdePJCqDiLHaHlC9
   LcujNgmuPj9xPIwMtqHBCuhDO9vZjIeFGF/gjyZpfTdtHdv0nlQJFVzC0
   D64W7GdNNvEkUdLSY8yQV6AWx9xji2+PwHbtziSkPfdoN/DxjjuGYxohH
   SaYqylufWm/HtkCsghN6+/Rlv9QNrRwSv1ZWXN0VaL4OJVe18A56tGSmq
   1DRowcGbWpUPok0m4wu1nvIAgkqUzCtId9xacFGKCMMHyek6ghGqMDdvu
   v3J7z3Aotp8Zy43DcrAbT7MCSIXSTD/N2MGrMVSBYTJyLf5gNYDgkkaKe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="251493"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="251493"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 19:47:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="908969342"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="908969342"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 19:47:17 -0800
Date: Sat, 3 Feb 2024 19:48:37 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <len.brown@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Zhuocheng Ding <zhuocheng.ding@intel.com>, x86@kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zhao Liu <zhao1.liu@linux.intel.com>
Subject: Re: [PATCH 9/9] x86/cpu: Introduce interface to reset hardware
 history
Message-ID: <20240204034837.GA26316@ranerica-svr.sc.intel.com>
References: <20240203040515.23947-1-ricardo.neri-calderon@linux.intel.com>
 <20240203040515.23947-10-ricardo.neri-calderon@linux.intel.com>
 <20240203094014.GCZb4J_loB5DEohHxT@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203094014.GCZb4J_loB5DEohHxT@fat_crate.local>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Sat, Feb 03, 2024 at 10:40:14AM +0100, Borislav Petkov wrote:
> On Fri, Feb 02, 2024 at 08:05:15PM -0800, Ricardo Neri wrote:
> > +void reset_hardware_history(void)
> > +{
> > +	asm_inline volatile (ALTERNATIVE("", __ASM_HRESET, X86_FEATURE_HRESET)
> > +			     : : "a" (hardware_history_features) : "memory");
> > +}
> 
> This thing belongs in the header too, and it should be __always_inline.

Thanks a lot for your feedback Boris!

Sure, I can move this code to the header ad use __always_inline.

BR,
Ricardo

