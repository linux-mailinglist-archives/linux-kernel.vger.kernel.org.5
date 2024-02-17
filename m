Return-Path: <linux-kernel+bounces-69852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F05858F77
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 13:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20BBA1F21B66
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 12:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669F97A727;
	Sat, 17 Feb 2024 12:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F3ZkYkYn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F3F64A8E
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 12:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708174672; cv=none; b=BpO/uLrani/gfTVcDDyA4RZBIJ1+5n+eHRDQB5ijewYluqfYV7NFDHp2RxcOOVWwALqoL3pwSt7qXAWp1vK/7oUvTfXe+gQUji7+/tO7e0JLaSxgxHNpFOcml7EQr9mcy6WyyDkFiwN+Mt17pypLGhfIMSOOWM0V09Umx2NTV1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708174672; c=relaxed/simple;
	bh=UO5I9VNSJI0f7byi/v8nNKzsJNlXdqv1O1K5PAuBLGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MhHhYkgVp0xDU24LRqvdjGrvpZylZWAU5oXQ09dG4eGkDFWYQ6mDmXV8W6Lr4fMHfMLcmTn1a/kRjB5DubDeF7stacIOTrChmca5jjraPgl0p9BV7J+KeZSfdUxoO8VaF4997ZHwkTL4Erl057SPqn0Guv+PMd16pe+IZ8rIv8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F3ZkYkYn; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708174671; x=1739710671;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=UO5I9VNSJI0f7byi/v8nNKzsJNlXdqv1O1K5PAuBLGk=;
  b=F3ZkYkYnuOMUhMC/ctCp5zM1pc+oVq7hz9FBsbF0oN3ZNK6jM0nTmBSe
   g6ZwdlNaBj4BXMyXJ5UhMKdzny5f/PzO3IkbFUuRIYbzOOb0LxMPRqu4W
   cYtyRJQoLGuhPv5jpUBsa5K31HMU3WH4ZVSLgzjp9kDMXXew0T1sD/bS0
   gcfjjVI6BQBtbKK5x+s0VyeWhscag5/ks+z3t7jqfKTjpD6QVEV7Dl6f/
   pfpQ/zgEMA9O+6UeRHN21YUnmuXmwFkXSUksr5jKvirTGMmcwOt4eF/5t
   UxBMX9HnJXHa30QakQ0EKStbVE1sUydV0TuT+zgJd1WPt3nzB08UV9X4d
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="2164430"
X-IronPort-AV: E=Sophos;i="6.06,166,1705392000"; 
   d="scan'208";a="2164430"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2024 04:57:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="935995886"
X-IronPort-AV: E=Sophos;i="6.06,166,1705392000"; 
   d="scan'208";a="935995886"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 17 Feb 2024 04:57:46 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 0446D2E9; Sat, 17 Feb 2024 14:57:44 +0200 (EET)
Date: Sat, 17 Feb 2024 14:57:44 +0200
From: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "debug@rivosinc.com" <debug@rivosinc.com>, 
	"luto@kernel.org" <luto@kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "broonie@kernel.org" <broonie@kernel.org>, 
	"keescook@chromium.org" <keescook@chromium.org>, "bp@alien8.de" <bp@alien8.de>, 
	"mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "hpa@zytor.com" <hpa@zytor.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 4/8] thp: Add thp_get_unmapped_area_vmflags()
Message-ID: <652xgd4wemokoomshvncmhufwkr6o4ftzg5nrhugcchbnaiaao@jjf6dfjidwvc>
References: <20240215231332.1556787-1-rick.p.edgecombe@intel.com>
 <20240215231332.1556787-5-rick.p.edgecombe@intel.com>
 <bfvjvaeuan5ojbfleq425lajj4vfgcomgubksqpxlvqdo2g5o3@44nolzrcuea2>
 <cbc567bd38931a1fba6009c97ec935fabe15a01a.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cbc567bd38931a1fba6009c97ec935fabe15a01a.camel@intel.com>

On Fri, Feb 16, 2024 at 10:21:13PM +0000, Edgecombe, Rick P wrote:
> On Fri, 2024-02-16 at 14:59 +0200, Kirill A. Shutemov wrote:
> > On Thu, Feb 15, 2024 at 03:13:28PM -0800, Rick Edgecombe wrote:
> > > +unsigned long thp_get_unmapped_area(struct file *filp, unsigned
> > > long addr,
> > > +               unsigned long len, unsigned long pgoff, unsigned
> > > long flags)
> > > +{
> > > +       return thp_get_unmapped_area_vmflags(filp, addr, len,
> > > pgoff, flags, 0);
> > >   }
> > >   EXPORT_SYMBOL_GPL(thp_get_unmapped_area);
> > 
> > Again, static inline should be fine.
> 
> Not sure if the diff might be a bit misleading here, the signature of
> thp_get_unmapped_area() didn't actually change.
> 
> If thp_get_unmapped_area() is made into a static inline, then
> thp_get_unmapped_area_vmflags() would need to be exported instead so it
> could be used in some modules. Unlike get_unmapped_area()
> thp_get_unmapped_area is actually is used that way.
> 
> Better to export the more limited version?

Okay, it is a valid point.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

