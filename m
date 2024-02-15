Return-Path: <linux-kernel+bounces-66959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CF6856417
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F09428BA2C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D29812FF7C;
	Thu, 15 Feb 2024 13:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JS53fqJN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E407312F595;
	Thu, 15 Feb 2024 13:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708002770; cv=none; b=hZzO488iC6w2kL1pAXU1XBnzMLCvLzm6xs63j5N4ha5PbpF8oUf8N+jNVHvhogk6y+SlwOznKvX0Y/8Hg5tGM0rxxfwxxHhcJ6Hmxd/lC3+G7Ccs5y3g9eM/6ktNoix/Treo9egXsXfTbaaDgTdLn9lL33005zQS8L1yZd22zWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708002770; c=relaxed/simple;
	bh=f5naG3H0m5jjSQTWaScUfYqNDrTUuPCFedrqUbopnOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jSkRO2DxsHXbJlq+ZB6lFpof8sENGQ6SRw27mlkkbbsbOsRLMpcc5l4sNuPlayQBSVlw0df/nyk+bAfPzi3l22UF4BifBq8Ucunx6KFnjcsoQWQQAncPRCoN0B4HxxOTZGGkWgiz0dcrUiJMmTXfCFc23TsDTXVnwT4aR+ycqUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JS53fqJN; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708002769; x=1739538769;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f5naG3H0m5jjSQTWaScUfYqNDrTUuPCFedrqUbopnOA=;
  b=JS53fqJNebRVW9fEfr3P2rT5HkREc0J7SU8LWIeC5DIvt88PMuJDhFMM
   PDxNyOaC2nAXYiKaXW1FI9obZkAdznHaU55XbUtSDV8RsfcJlhWLi77uC
   TCLzkSswC1PJh83+AgyiUMaH2moaBVX0C2GTkSYwP37//A0l/y6eSAOEm
   4AYA3iQS19PEHw095iXwxOOWMYp8PYDzh9CpTGPWcXRhDBHapNxP2eBZ2
   QX+QA0Cmb3HA0Tg9bMpsZ6z70lx9Ge0f+qTZ3S4QoAzVQyoZdJGNEPEWe
   OBpS7f4cAnped3kb7RY22PUB+j36YRFfleE28wDbBZDpTAUOTq1YV+rYI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="12632313"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="12632313"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 05:12:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="3682346"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.213.3.132])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 05:12:35 -0800
From: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 1/2 v4] cleanup: Add cond_guard() to conditional guards
Date: Thu, 15 Feb 2024 14:12:31 +0100
Message-ID: <2768675.PYKUYFuaPT@fdefranc-mobl3>
Organization: intel
In-Reply-To: <20240215102642.000067c5@Huawei.com>
References:
 <20240208130424.59568-1-fabio.maria.de.francesco@linux.intel.com>
 <20240214180452.00000974@Huawei.com> <20240215102642.000067c5@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, 15 February 2024 11:26:42 CET Jonathan Cameron wrote:
> On Wed, 14 Feb 2024 18:04:52 +0000
> 
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> > On Tue, 13 Feb 2024 17:51:26 +0100
> > 
> > "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com> wrote:
> > > On Thursday, 8 February 2024 14:04:23 CET Fabio M. De Francesco wrote:
> > > > Add cond_guard() macro to conditional guards.
> > > > 
> > > > cond_guard() is a guard to be used with the conditional variants of
> > > > locks,
> > > > like down_read_trylock() or mutex_lock_interruptible().
> > > > 
> > > > It takes a statement (or statement-expression) that is passed as its
> > > > second argument. That statement (or statement-expression) is executed
> > > > if
> > > > waiting for a lock is interrupted or if a _trylock() fails in case of
> > > > contention.
> > > > 
> > > > Usage example:
> > > > 	cond_guard(mutex_intr, return -EINTR, &mutex);
> > > > 
> > > > Consistent with other usage of _guard(), locks are unlocked at the
> > > > exit of
> > > > the scope where cond_guard() is called.
> > > 
> > > [snip]
> > > 
> > > > +#define cond_guard(_name, _fail, args...) \
> > > > +	CLASS(_name, scope)(args); \
> > > > +	if (!__guard_ptr(_name)(&scope)) _fail; \
> > > > +	else { }
> > > > +
> > > 
> > > I have converted and tested several functions in drivers/cxl and found
> > > that
> > > there are cases where this macro needs to be called twice in the same
> > > scope.
> > > 
> > > The current implementation fails to compile because any subsequent call
> > > to
> > > cond_guard() redefines "scope".
> > > 
> > > I have a solution for this, which is to instantiate a differently named
> > > variable each time cond_guard() is used:
> > > 
> > > #define __UNIQUE_LINE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix),
> > > __LINE__) #define cond_guard(_name, _fail, args...) \
> > > 
> > >         CLASS(_name, __UNIQUE_LINE_ID(scope))(args); \
> > >         if (!__guard_ptr(_name)(&__UNIQUE_LINE_ID(scope))) _fail; \
> > >         else { }
> > > 
> > > But, before sending v5, I think it's best to wait for comments from
> > > those with more experience than me.
> > 
> > Ah. So you can't use __UNIQUE_ID as guard does because we need it to be
> > stable across the two uses.  What you have looks fine to me.
> > We might end up with someone putting multiple calls in a macro but in my
> > view anyone doing that level of complexity in a macro is shooting
> > themselves in the foot.
> 
> Thought more on this whilst cycling home.  Can you use another level
> of macros in combination with __UNIQUE_ID that guard uses?
> My skills with macros are very limited so I'm sure I got something wrong,
> but along the lines of.
> 
> #define __cond_class(__unique, _name, _fail, args...) \
>    CLASS(_name, __unique)(args); \
>          if (!__guard_ptr(_name)(&__unique)) _fail; \
>          else { }
> #define cond_class(_name, _fail, args... ) \
>     __cond_class(__UNIQUE_ID(guard), _name, _fail, args...
> 
> ?
>
Yes, certainly.

Your solution is more elegant. We can reuse __UNIQUE_ID(). There is no need of 
a new helper macro. Thanks.

But with s/cond_class/cond_guard/ and s/guard/scope/ (I think that "scope" 
makes the purpose of that variable clearer).  

I think I'll wait a bit more in case someone else wants to comment and then 
I'll submit v5.

Fabio
> 
> > Jonathan
> > 
> > > Fabio




