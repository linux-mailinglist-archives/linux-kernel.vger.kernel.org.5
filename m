Return-Path: <linux-kernel+bounces-46468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05601844033
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DC331F283DC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B66D7B3D4;
	Wed, 31 Jan 2024 13:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="apy6vTQ/"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3FB79DD0
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 13:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706706689; cv=none; b=iTGRHLH5lJgPI8dz6wW0ctJy7+ASXJnCiRUxBRDu3L++FAmSYrEHCMd686ETjrC9waxViXDg7TZfa49ZCjQT+HBFzZRVonVBN8H7UPr4w4ENDxM0vtTrym6/OmDvsC9Zu5yHpQu1DZuC2sHmSaorf9eIydEXLqTcTGpdKNzgkec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706706689; c=relaxed/simple;
	bh=0WbDnoSZ6lV8Nbook1KESp/4NQpmY0I7J1zh1rgAiGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h6g9mYEDlEp1Vp5q36hGehJd33zAdn5PjTgDq7nzvBgPDhpdLBWWDry5YLsIHg+TKtJaqdjxuEfKBRPcW03SnRlOVDzNV4dxvgWesaa9e9NJyBKf6IVOuHtM/SomLWFA/tM6lktrzecOpZXud8vc2fKB8JVhNZmKGnJsff2QGRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=apy6vTQ/; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706706688; x=1738242688;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0WbDnoSZ6lV8Nbook1KESp/4NQpmY0I7J1zh1rgAiGU=;
  b=apy6vTQ/J8uTufYCR3Mnn0oM1uEIIL6487rkWNq8vkbKEWXIy0TePKqH
   0dk4OGqCFbOEJKOxLzyrpHE4Mu8bXw5tQPaUidSiI2LRIhvjc5Q2J9en2
   f5dTNvKmEwJoqD4jbGNeVpHu5C7gU95YndAkQDtlOUuhmc9dDyf14K/T1
   LDT8ByUMXEzq9nt4dMqgfTWwzGyparqty9OCj3gZ+9GYGA3g5w0Fj8mZl
   FZ64eOW8vebaDhmV1gNyRbZHlmK7EWqJSVlCIf3POLPl/cHzYUB1GZo29
   Rm0PdDwzIP0LFMIa/y9n7lnDzDCY1fnC7sf4V/YTKjeaimd7a7w+4GpLt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="434770733"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="434770733"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 05:11:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="1119616228"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="1119616228"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.213.21.82])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 05:11:12 -0800
From: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To: linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RFC PATCH v2] cleanup: Add cond_guard() to conditional guards
Date: Wed, 31 Jan 2024 14:11:09 +0100
Message-ID: <3335653.aeNJFYEL58@fdefranc-mobl3>
Organization: intel
In-Reply-To:
 <65b938c1ad435_5cc6f294eb@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References:
 <20240130164059.25130-1-fabio.maria.de.francesco@linux.intel.com>
 <22169722.EfDdHjke4D@fdefranc-mobl3>
 <65b938c1ad435_5cc6f294eb@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, 30 January 2024 18:58:25 CET Dan Williams wrote:
> Fabio M. De Francesco wrote:
> > On Tuesday, 30 January 2024 18:02:09 CET Dan Williams wrote:
> > > Fabio M. De Francesco wrote:
> > > > Add cond_guard() to conditional guards.
> > > > 
> > > > cond_guard() is used for the _interruptible(), _killable(), and _try
> > > > versions of locks. It expects a block where the failure can be handled
> > > > (e.g., calling printk() and returning -EINTR in case of failure).
> > > > 
> > > > As the other guards, it avoids to open code the release of the lock
> > > > after a goto to an 'out' label.
> > > > 
> > > > This remains an RFC because Dan suggested a slightly different syntax:
> > > > 	if (cond_guard(...))
> > > > 	
> > > > 		return -EINTR;
> > > > 
> > > > But the scoped_cond_guard() macro omits the if statement:
> > > >     	scoped_cond_guard (...) {
> > > >     	}
> > > > 
> > > > Thus define cond_guard() similarly to scoped_cond_guard() but with a
> > > > block
> > > > 
> > > > to handle the failure case:
> > > > 	cond_guard(...)
> > > > 	
> > > > 		return -EINTR;
> > > 
> > > That's too subtle for me, because of the mistakes that can be made with
> > > 
> > > brackets how about a syntax like:
> > >  	cond_guard(..., return -EINTR, ...)
> > > 
> > > ...to make it clear what happens if the lock acquisition fails without
> > > having to remember there is a hidden incomplete "if ()" statement in
> > > that macro? More below...
> > 
> > As you propose I can't see how to handle multi-line error path like in:
> > 	cond_guard(...) {
> > 	
> > 		dev_dbg(...);
> > 		return -EINTR;
> > 	
> > 	}
> 
> The _fail argument is a statement, to make it a compound statement maybe
> just add braces, something like:
> 
>     cond_guard(..., { dev_dbg(...); return -EINTR; }, ...)
> 
> ...another possibility is something like
> 
>     int rc = 0;
> 
>     cond_guard(..., rc = -EINTR, ...)
>     if (rc) {
>         ...
>         return rc;
>     }

I had tried this before sending this patch. It looked the most obvious 
solution. But it fails my tests: it always return -EINTR, regardless of the 
successful down.

It looks like it was not expanded as I was expecting.

Or my tests are wrong, but I can't see any obvious mistake.

BTW, it's interesting to notice that the following instead works. I guess that 
it is due to the same fact that required me to pass a pointer to 'rc' in the 
first version of this patch to (mistakenly) store the boolean of whether the 
constructor succeeded or failed.

	int rc;
	int *rcp = &rc;

	cond_guard(..., *rcp = -EINTR, ...)
	if (rc) {
		dev_dbg(...);
		return rc;
	}

This works but I think nobody wants to see anything like this.

Fabio
 
> 
> ...so, I don't think we need separate macros for the multi-statement
> case.




