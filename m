Return-Path: <linux-kernel+bounces-92687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7F187245C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60AC11C2202E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BC4C8C4;
	Tue,  5 Mar 2024 16:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WJrBQolc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D352A9473
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 16:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709656318; cv=none; b=XlTDpwfNyLZ+VyTFWUUzUVYNGefZvVhxJaWuYX1MGqoIW3G6hes1NT/WcQm8HWWxjSoShvxeyCsAz4emmeXkiqztljMF9A+ZclIWacDn+Jr3Zbht+rlPI9VOcb3uruCTSWVuxGymOVLdYLGcFPdVUmZsJxAtXxOtp6uD9WmzG5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709656318; c=relaxed/simple;
	bh=2G1UkZcYsE3LUTygxe32aCkrpgkM1wkUz1zKu91EUkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqPqMjJk8A0FAhdKLR/iJKdm6ovSALw/aeT6jl6UlHMiTCR9a7kGuJYU48st09HI1OWAyWf8SYyMOOaFRpwzXFSUgtQHMlEPnwuUTZNWRuLtI0+WUO+QrcQiFuOaN2Ccnadu2KYYFHjBUox7dBe8B7LO8VJI20Z6MYF4kClC8Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WJrBQolc; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709656317; x=1741192317;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2G1UkZcYsE3LUTygxe32aCkrpgkM1wkUz1zKu91EUkg=;
  b=WJrBQolctxx19OYA94kDmUUD9MlKpYEDws/bwhsRsdgLqPgw8KsPaz4S
   Y1fNkVMubAR9aLdzkeY695tfquk/K/9XgnrRN/bF6FN2RGfaqAlE5V4cg
   LhjpC5+7D+ogJozAzkK9TA7vrcNeuRlCvrnvz2IgBLKyYOuohEH9WdkOj
   9uciju8PLPEkV4En7i/qKHfnN5KcfzLvxTL/OSx7L6+aVZ2G0tu8zxaOg
   iApExnnrSEvtlumCXoiAicMlzy1GWNeO//LpPm5oVcABgOhkF5klcvurp
   615RSVI8VhTzeBIkah0l0jg6k4TQFip9H3+BrZnhN2MquKj7rRTPrvAe2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4080903"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4080903"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 08:31:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="914144608"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="914144608"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 08:31:53 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rhXhm-0000000A23J-1Bt2;
	Tue, 05 Mar 2024 18:31:50 +0200
Date: Tue, 5 Mar 2024 18:31:50 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Mateusz =?utf-8?Q?Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v1 1/1] x86/rtc: Remove unused intel-mid.h
Message-ID: <ZedI9vCoCf9KtHcr@smile.fi.intel.com>
References: <20240305161024.1364098-1-andriy.shevchenko@linux.intel.com>
 <14750023-e5fb-45f7-9c28-9510ce5a5994@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14750023-e5fb-45f7-9c28-9510ce5a5994@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 05, 2024 at 08:21:32AM -0800, Dave Hansen wrote:
> On 3/5/24 08:10, Andy Shevchenko wrote:
> > intel-mid.h is providing some core parts of the South Complex PM,
> > which are usually are not used by individual drivers. In particular,
> > this driver doesn't use it, so simply remove the unused header.
> 
> Indeed.  intel-mid.h provides a pretty small amount of stuff and it's
> included in quite a few random-looking spots.  There's also gunk that's
> only compiled in if CONFIG_X86_INTEL_MID=y so if anyone _did_ somehow
> use any of those functions in generic code, they'd probably be creating
> compile problems.
> 
> Any chance you'd like to look a _bit_ more widely and just clean up all
> of the unnecessary intel-mid.h #includes that are scattered around?

All relative patches just have been sent. They are independent, hence sent
separately. Please, apply, what you can, if there is no objection.

-- 
With Best Regards,
Andy Shevchenko



