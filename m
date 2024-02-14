Return-Path: <linux-kernel+bounces-65715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 252D18550C1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5C7728E0A3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10211272D0;
	Wed, 14 Feb 2024 17:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Te0DoadY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D411272C4
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 17:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933023; cv=none; b=YxmrzBggc1fePfGWUw/G7kbymXEetyxoVQtloeqRLbvgL6YMDRdz7hGrw+1gLWABZyLRTyhOsjlN6v2ysHkw0mWfe3HZy0wOE4njgcypvNaVZV8WHLx7+/FJ6/OeON8NMsTMgsT6CDnCY2k3NLv4Q7gOoXTeNEMxyBWg5PV8POM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933023; c=relaxed/simple;
	bh=pwZc27YRL5gt3u/z/Ayw6UyQwtWSrydt57fbBJbZ6BA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iv1rb+J5ptxzi5IK0tGzyzMKcaGqc3T0Ro/jFZNxW6JECp4X7sacD/yy1L1NHEh49am+pRC0m4vz7cnJ0rQDTeqKgg1n8lGj32LmPjbOpU2dE2M2CI2uNUK1SdG/i5ZsVSOqZ+XvA1Er+Zt4EMsCVlY317C0KAEj7MSnYGQkUgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Te0DoadY; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707933022; x=1739469022;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=pwZc27YRL5gt3u/z/Ayw6UyQwtWSrydt57fbBJbZ6BA=;
  b=Te0DoadY1hbm9Ey35aC3l99AaxPUZoJ3VhaEHLoJXl4iBxfFv81uo59O
   aT+BlqH2BjZZd6M8ygYLQmb2TBByfJ7NrEkJACFzR/2PVALPp2SNPKtuh
   /kjE/w02rkRpXJMaz4U6/64o90M/hQHw2Fs2igoDfoGwKviGpi5kKo3n1
   cGcM4BNCmjkXk7vxoJeeEkPrwnVDTb3TrN5dJ1k3lYFMOCiAdmNyxJWVc
   4YvRgv24pv1anMnOe8Z16+Dr08W5k78AXBBeFWhnz94+HlVp6NW4Fa4Yq
   1juU5s3qCXoQaQ7yjWGWTtKYgA5QS4ZyZJMKezc3DEx9hkkBSMOfkvoAA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="13381040"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="13381040"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 09:50:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="912092700"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="912092700"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 09:50:18 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1raJOi-00000004Yi2-2F58;
	Wed, 14 Feb 2024 19:50:16 +0200
Date: Wed, 14 Feb 2024 19:50:16 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH v2 2/3] auxdisplay: Move cfag12864b.h to the subsystem
 folder
Message-ID: <Zcz9WNXpRzv8THKW@smile.fi.intel.com>
References: <20240212132515.2660837-2-andriy.shevchenko@linux.intel.com>
 <20240212132515.2660837-4-andriy.shevchenko@linux.intel.com>
 <Zcoe9axtLXxB7Jeo@smile.fi.intel.com>
 <CAMuHMdUJ4gSGo4A0BVGkieWvNyqa9Dv_rQVMFj9N8GWYoKCZVg@mail.gmail.com>
 <CANiq72muoZHzX+qNKabYWnH738okKqrfAruUOpY-4WUJBLP=Yw@mail.gmail.com>
 <Zcz7Cfc5XSM2MtKV@smile.fi.intel.com>
 <CANiq72ntYrPyybUDavPuT+anrwfjPb27P8VbL+toMvyp8K293w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72ntYrPyybUDavPuT+anrwfjPb27P8VbL+toMvyp8K293w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 14, 2024 at 06:42:56PM +0100, Miguel Ojeda wrote:
> On Wed, Feb 14, 2024 at 6:40 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > I don't want to rebase, esp. taking into account the proposal below.
> 
> Why do you not want to rebase?

It's a standard practice in the Linux kernel development.
If it's not a so critical issue, why should we rebase?

rebasing will break SHA sums and it's not appreciated especially at the late
rcX weeks. Linus can even refuse to accept a PR based on this fact.

> The proposal is orthogonal in any case.

True.

-- 
With Best Regards,
Andy Shevchenko



