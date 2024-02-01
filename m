Return-Path: <linux-kernel+bounces-48412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3144C845B9D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC4A6283C6D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9880162167;
	Thu,  1 Feb 2024 15:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TSBZs0tS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838215F46B;
	Thu,  1 Feb 2024 15:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706801553; cv=none; b=DUAebJcLCXerW9QHlt2IJFqRqDv6ZXRzemIX9JpTvmJCCaTUWGZJpV0j53qtBwDIWJy6hhsCwimu7qRSg8RpeHZ42HFujmmisXxZW1qgLiN6sTPNeka08OkDd8nKOOjwe4n7ObNUl64D6+E4iWIMCnnjykRcwCVlEjuqb3IVNF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706801553; c=relaxed/simple;
	bh=LpGYzjNOlORgZQDwJ7JZKno6SgSsqawBk9ndW4fxKr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cdk0PtcA0epHbFkRkJzybgkwWpsHKi3Xt/mA2ebkgjUhbg9fe0RmNZ43ClgJ9f4t/QVVzo3FPDD2gvsjWOugMVJ2oQ67cXtcjRko1ogEJUKa+d4dBnFdOf0ntOytdv8D7+MM0UCyge112DzAnZ6+HgshNrWeNmjcbekfOkJeGVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TSBZs0tS; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706801552; x=1738337552;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LpGYzjNOlORgZQDwJ7JZKno6SgSsqawBk9ndW4fxKr4=;
  b=TSBZs0tSQc0h7M9ghSaR9hVUJrHfslxYPB17eaUqVAAYTDixbL5vt5Sm
   oWqknrgUMRwvycasRY3Vxu2uKQrcK1UqY4CxyU0dnqGXHoANOp6L1LT69
   w1Bc+dw0gcvKCagQqCWuGsN+dfN5LoSMq1dLA9e6xqcViRwnxNCZJRNJj
   66Iyaxefzavj4YyKqQQ0lGevOaa7alDXYlIxt2TphGWT93Ig47OuwCGYJ
   Vf+gpbxdLvYbqq2Xt71o6e7iJCh56LjvLcc18HikZ8dPltzVrDISS/3dI
   Ftxjz8pujPPlM54hm5TdbC2knKLxS2Z9GmUFNItWttZLxdl8bxFsVENqE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="22418289"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="22418289"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 07:32:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="30624124"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.213.2.91])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 07:32:29 -0800
From: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>, dan.j.williams@intel.com,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
 linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RFC PATCH v3] cleanup: Add cond_guard() to conditional guards
Date: Thu, 01 Feb 2024 16:32:25 +0100
Message-ID: <3280120.44csPzL39Z@fdefranc-mobl3>
Organization: intel
In-Reply-To: <2172852.irdbgypaU6@fdefranc-mobl3>
References:
 <20240131134108.423258-1-fabio.maria.de.francesco@linux.intel.com>
 <20240201113612.00001d90@Huawei.com> <2172852.irdbgypaU6@fdefranc-mobl3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, 1 February 2024 16:13:34 CET Fabio M. De Francesco wrote:
> On Thursday, 1 February 2024 12:36:12 CET Jonathan Cameron wrote:
> > On Thu, 01 Feb 2024 09:16:59 +0100
> > 
> > "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com> wrote:
> > > [snip]
> > > 
> > > Actually, I'm doing this:
> > > 	cond_guard(..., rc, 0, -EINTR, ...);
> > 
> > Can we not works some magic to do.
> > 
> > 	cond_guard(..., return -EINTR, ...)
> > 
> > and not have an rc at all if we don't want to.
> > 
> > Something like
> > 
> > #define cond_guard(_name, _fail, args...) \
> > 
> > 	CLASS(_name, scope)(args); \
> > 	if (!__guard_ptr(_name)(&scope)) _fail
> > 
> > Completely untested so I'm probably missing some subtleties.
> > 
> > Jonathan
> 
> Jonathan,
> 
> Can you please comment on the v5 of this RFC?
> It is at
> https://lore.kernel.org/all/20240201131033.9850-1-fabio.maria.de.francesco@
> linux.intel.com/
> 
> The macro introduced in v5 has the following, more general, use case:
> 
> * * 	int ret;
> + * 	// down_read_trylock() returns 1 on success, 0 on contention
> + * 	cond_guard(rwsem_read_try, ret, 1, 0, &sem);
> + * 	if (!ret) {
> + * 		dev_dbg("down_read_trylock() failed to down 'sem')\n");
> + * 		return ret;
> + * 	}
> 
> The text above has been copy-pasted from the RFC Patch v5.
> 
> Please notice that we need to provide both the success and the failure code
> to make it work also with the _trylock() variants (more details in the
> patch).

The next three lines have been messed up by a copy-paste.
They are:

If we simply do something like:

	cond_guard(..., ret = 0, ...)

We won't store the success (that is 1) in ret and it would still contain 0, 
that is the code of the contended case.

> If we simply do something like:
> 
> 	cond_guard(..., ret = 0, ...)
> 
> to be able store in 'ret' the code of the contended case, that is 0.
> 
> Since down_read_trylock() returns 1 on down semaphore, when we later check
> 'ret' with "if (!ret) <failure path>;" we always enter in that failure path
> even if the semaphore is down because we didn't store the success code in
> ret (and ret is still probably 0).
> 
> This is why, I think, we need a five arguments cond_guard(). This can manage
> also the _interruptible() and _killable() cases as:
> 
> 	cond_guard(..., ret, 0, -EINTR, ...)
> 
> In this case we don't need 5 arguments, but we have a general use case, one
> only macro, that can work with all the three variants of locks.
> 
> Fabio





