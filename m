Return-Path: <linux-kernel+bounces-45062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1581842B47
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F226F1C2265B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B1F151CE0;
	Tue, 30 Jan 2024 17:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R/Vha1nT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDC1128368
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 17:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706637331; cv=none; b=m+nLD7kuj8tG7K+QSlS2A0QOTYv6qgqjS/Vnr7+qJHho5FtR2DH+p/syvlyQOS+QoLfDv7oodyvbOWRXM0YFZT0JC+S9Koze/s1CTx8VKFo8P6EO7P1apvqvXAhi7C00xqqCit/O6Vco+Dw891YXDl1wTRWlWduW3l52MdK4wBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706637331; c=relaxed/simple;
	bh=R2VzgYZ8PIGLvqOWpprYx4WeO6X3A/KijcaqP9qfvQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dhj7Ci4D5ah4x/A7c8D0pnwIkX6m0AUjfh93wCLauio4jCXLxCLB0JVM8BH9Go+d8AdRkxwKe0eyyaBJFlxQIUjwzLDpViw12PHiSge1vb4+/hG5BqNOlMnTuJkrYLMS9KKTqdwvehePn0s5901YBm2VRXfJ2YupEWWgo9XsmKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R/Vha1nT; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706637329; x=1738173329;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R2VzgYZ8PIGLvqOWpprYx4WeO6X3A/KijcaqP9qfvQM=;
  b=R/Vha1nTusWl8xkb4fGOOZG1l7rtT1cGwqPfPrpq00O9GMljVZ33/cDS
   UD/qhUwXCncuUz0PZ8pUutwfoo+UeEktFzquH7i0J7kJoC9WeBFSBVWX4
   pVTUNvr5/bsdSdI33MU8N8MHgifHX5ycVxImXSXHiQYM07dicltrVXkKL
   5BxddfPvW0ALFpW84Iu1mPh5k+f9YhjgIamFXIAgrsUZaIWs8O5WlX0T1
   7lgLniVjvfwBTppYqQ8yKk1gtnYMImEgja7hn3pKv6wdTuaa/GvcCgF1n
   of3CDsVocKTHBLeVGxvUhVJu2MKAFVER2cUmL5qse/9/Y9CNKGhHcFx4/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3205943"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="3205943"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 09:55:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="30216135"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.213.21.72])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 09:55:26 -0800
From: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To: linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RFC PATCH v2] cleanup: Add cond_guard() to conditional guards
Date: Tue, 30 Jan 2024 18:55:23 +0100
Message-ID: <1785218.VLH7GnMWUR@fdefranc-mobl3>
Organization: intel
In-Reply-To:
 <65b92b91a41a8_5cc6f29484@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References:
 <20240130164059.25130-1-fabio.maria.de.francesco@linux.intel.com>
 <65b92b91a41a8_5cc6f29484@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, 30 January 2024 18:02:09 CET Dan Williams wrote:
> Fabio M. De Francesco wrote:

[skip}

> > 
> > @@ -165,6 +174,10 @@ static inline class_##_name##_t
> > class_##_name##ext##_constructor(_init_args) \> 
> >  #define __guard_ptr(_name) class_##_name##_lock_ptr
> > 
> > +#define cond_guard(_name, args...) \
> > +	CLASS(_name, scope)(args); \
> > +	if (!__guard_ptr(_name)(&scope))
> 
> This needs to protect against being used within another if () block.
> Imagine a case of:
> 
>     if (...) {
>     	cond_guard(...);
> 	    <statement>
>     } else if (...)

Could it be made clear in the documentation that cond_guard() shouldn't be 
misused as you showed above? 

Actually, I don't know how effective the documentation can be in avoiding 
incorrect use of cond_guard().

Fabio
 
> ...does that "else if" belong to the first "if ()" or the hidden one
> inside the macro?
> 
> You can steal the embedded "if ()" trick from scoped_cond_guard() and do
> something like (untested):
> 
> #define cond_guard(_name, _fail, args...) \
> 	CLASS(_name, scope)(args); \
> 	if (!__guard_ptr(_name)(&scope)) _fail; else /* pass */;





