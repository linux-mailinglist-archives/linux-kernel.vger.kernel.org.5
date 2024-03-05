Return-Path: <linux-kernel+bounces-92723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F34948724EF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EC26B25FA2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9372A14A81;
	Tue,  5 Mar 2024 16:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WG9a0llL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D74D9457
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 16:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709657758; cv=none; b=eGORTRbEIarnpw19VB+CFHWGDfvkY7xpwIOuX8YB5sA3973g6BemrXig3zfUeKxWf4v1/+MVM6gkPXIASHMwUYBszsZUZh1fsF0Oa7nndqRGAsZ5oh3eVZMaLmBGCzA5u+Wc7SKY1Vg9k0Zkr7TGlQHxd5iLZbPGHI+5KsB/REM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709657758; c=relaxed/simple;
	bh=/ZaQ4D5/sj6XpmRCQPaFpiu0I/0aiGn7MZVxvLsa6gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYN79usFB2BfZMLPuj8sp31ehg0N3IFWzLl/+FkSbleCd2pFl5m6Vf+YgIl1MNtDgQIZxYBZgzr6Qd3qkQ2sWtQpW71IUzX7ypoq1tPCRFpkorHz/thyW7zT0//cfrT8NThAHe7X+rJIYKI22IUdD1iBbn0/45eC9zV+Yoc+VYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WG9a0llL; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709657757; x=1741193757;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=/ZaQ4D5/sj6XpmRCQPaFpiu0I/0aiGn7MZVxvLsa6gs=;
  b=WG9a0llLsDyLrOw71USOxyr2yhLwXKpVoTeI8Bk3YrqY4sOaPlEjK6Ec
   DuXGRDbSxU6iyd7pjcEYrB7oO1GTL0j+K+oW/RMrUEjLBNo7/leUhOVLe
   IcurGeEXFrMKUhBhiMgg4/+yYAPKSdusSMbaYTwcqdWnlQueTw02meJ4b
   kvV+L3GPzW6lFSPrjSavWR0AU0exyr1uxtRPIbhwKK4NcIfw905wk4Juv
   OajoWa/dVOqyAz4vTIynE6ekybzlrOghLLO+Xn/vjDLZG4qpHcDpOra89
   H8fbp7Mp2jCKpfpoEIypD/E2q0mldvV/zCYoxac61Ux7O2CU6Hjj39VNq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="15627262"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="15627262"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 08:55:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="914145099"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="914145099"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 08:55:53 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rhY50-0000000A2QW-0Je1;
	Tue, 05 Mar 2024 18:55:50 +0200
Date: Tue, 5 Mar 2024 18:55:49 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Mateusz =?utf-8?Q?Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v1 1/1] x86/rtc: Remove unused intel-mid.h
Message-ID: <ZedOldNSTdKWCgVD@smile.fi.intel.com>
References: <20240305161024.1364098-1-andriy.shevchenko@linux.intel.com>
 <14750023-e5fb-45f7-9c28-9510ce5a5994@intel.com>
 <ZedI9vCoCf9KtHcr@smile.fi.intel.com>
 <0c7c00c0-3b4a-41b3-8664-9ea6ee7e0814@intel.com>
 <ZedKGoPoTgWfOVNO@smile.fi.intel.com>
 <77d906e6-ff0c-489a-bc2b-5342196eb4b1@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77d906e6-ff0c-489a-bc2b-5342196eb4b1@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 05, 2024 at 08:43:47AM -0800, Dave Hansen wrote:
> On 3/5/24 08:36, Andy Shevchenko wrote:
> >> Ahh, thanks for the context.  Any chance you could share that up front
> >> next time? 😉
> > Hmm... I'm not sure how. If it's a cover letter, then it requires a series,
> > which seems an overkill, commenting on a single patch sounds a bit weird to
> > me.
> 
> I honestly don't care how you do it.  You could send all the patches in
> a series and ask the individual maintainers to pick them up
> individually.  Or send cc all the maintainers and ask _one_ of them to
> pick up all of the patches.  Or just mention in the changelog of the
> singleton patch that it's part of a (slightly) larger effort, then Link:
> over to the other related ones.

Got it.

> Seriously, the only way to go wrong is to just pretend that this patch
> *is* a singleton when it's not.

But technically speaking it is completely independent. TBH it is the _first_
time I ever got such a request from a maintainer. But okay, sending in a series
to be picked up separately sounds like in use: I have heard about such series
more than once.

-- 
With Best Regards,
Andy Shevchenko



