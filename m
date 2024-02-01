Return-Path: <linux-kernel+bounces-47764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEEF845283
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28A9E1C27ACD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1A1158D88;
	Thu,  1 Feb 2024 08:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V9Q5Y2kL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9406943AC0;
	Thu,  1 Feb 2024 08:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706775427; cv=none; b=X8jQ/3jFZ4JT7d2kZLRqibCz1pmZOEUKeLiZeraCql9Drqh3lfjE02kMgYTQaiI/oH9zBTjebsDHp6Ro88jHMzUHt9Ieb+bNChX9iv80gKT6ErG2sdXqc1QdwPm/KqiptwgWsP8FBrFOJzNmOM7KHwVg5BIDfTbyi4F62OzbwDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706775427; c=relaxed/simple;
	bh=lgBMpNmuZS58C3wWqdInFJ2/en+rrDKUD9rdFLLWX2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lxpAzXcDk6ywtipVZFI6qBOeCbf+3tXANKmeUlJAiLTiiNPjfLpuvITv9El4TQ+rPcAinASg6eccvGV6tiYLGS4YSVfTYQ3niJc3b5oKuXBAmMgO4eqQTgi6TIZs0FRGq6BryfJl+zpopG5LhdhuJUKJzIwLX9hs6PpaQP0U9IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V9Q5Y2kL; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706775425; x=1738311425;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lgBMpNmuZS58C3wWqdInFJ2/en+rrDKUD9rdFLLWX2M=;
  b=V9Q5Y2kLRCCFpdss2/+3MRFn7W19Pw0d1QdJOHCZOYqcti6X2Q0h9NfD
   lCQRtBnOPNw5rRmnVHQPuZN2oOAmkfPQnAjulp6gMNS2GxbZBryWBh1nQ
   KBRYw4KtSrlrNdYu1pIJGWqcn9tjd4ZY8l0V2Jrw48q2waSI6LBu+LrP/
   WlTND9fvCZnjW641GWi3qUBwjqQSYWG2M6sQDVeQ3RNJGlTYEZDghsi8f
   kJJIAsq1extPF9iHVJngtPNt/KAd+jUwNCY2P9X53NqGe5yUJ5x0xHvHY
   v3rGZT9PSITl3Ugm+0qhVqjAkA8ERmAMMeLofrab5X7BmsXeA3xmiQi7W
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="11217331"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="11217331"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 00:17:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="908169066"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="908169066"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.213.21.108])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 00:17:02 -0800
From: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>, dan.j.williams@intel.com,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
 linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RFC PATCH v3] cleanup: Add cond_guard() to conditional guards
Date: Thu, 01 Feb 2024 09:16:59 +0100
Message-ID: <1785013.VLH7GnMWUR@fdefranc-mobl3>
Organization: intel
In-Reply-To: <65baefec49c1a_4e7f52946b@dwillia2-xfh.jf.intel.com.notmuch>
References:
 <20240131134108.423258-1-fabio.maria.de.francesco@linux.intel.com>
 <6168759.DvuYhMxLoT@fdefranc-mobl3>
 <65baefec49c1a_4e7f52946b@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, 1 February 2024 02:12:12 CET Dan Williams wrote:
> Fabio M. De Francesco wrote:
> > I just noticed that this is not the final version. It misses a semicolon.
> > Please discard this v3. I'm sending v4.
> 
> Ok, but do please copy the aspect of scoped_conf_guard() to take a
> "_fail" statement argument. Passing a return code collector variable by
> reference just feels a bit too magical. I like the explicitness of
> passing the statement directly.

I had introduced a bug in my tests that made me see failures when there were 
not. Now I fixed it and tests don't fail.

I'm sending a new version that passes the return variable directly, not as a 
reference, similar but not equal to:

	cond_guard(..., rc, -EINTR, ...);

Actually, I'm doing this:

	cond_guard(..., rc, 0, -EINTR, ...);

I'm not passing 'rc = -EINTR' because I want to take into account the 
possibility that rc contains values different than 0 from previous assignments. 
I'm passing rc, so that the macro can assign either a success code or a 
failure error to this variable. Any value from previous assignments must be 
always overwritten: 

	#define cond_guard(_name, _ret, _scs, _err, args...) \
        	CLASS(_name, scope)(args); \
        	if (!__guard_ptr(_name)(&scope)) _ret = _err; \
        	else _ret = _scs;

I should have seen long ago that my tests were failing because of a missing 
'else' when passing a statement in 'cond_guard(..., rc = -EINTR, ...);'. It 
had nothing to do with how to pass 'rc'. Sorry for that confusion.

Fabio

Fabio 



