Return-Path: <linux-kernel+bounces-45051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A700842B14
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E61C11F28E6D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7D414D459;
	Tue, 30 Jan 2024 17:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J9Ukos84"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55F014E2C5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 17:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706636043; cv=none; b=GQSUWq6mBFHlRdg19+UgbI7f0MkycrdvBKmjSijg3SWrLCMLdR7rZFIwcb4SwD3JvXEU7FKaf8S8b1oQl94X+NJr7sMxaPh93oCRROzfcd2WcoBbOgG6aoJeCYo3W5tvzQ7IOUrqUv/x0lrSAyEzs3KiajrjJcSwfwM5swLtc6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706636043; c=relaxed/simple;
	bh=vmVmSnCpNwM1iU6DsPBex0hsSHgShK/dUt17/5kPrZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ceE7uyr7S0HNz3sEFAynvaTPE8+n/3KDX+mRqHO+BVaeIra3g75dqHZJYHXMWexEt3zJz+OUXSopmKX5m6fRWPg+SevOVP1EPxmvC1ZHhir2ela337LIEQPimFbIVct5Z8MuG37HvEBGYW4s9JO0K5TflISm+nqZRGJano8iiLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J9Ukos84; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706636042; x=1738172042;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vmVmSnCpNwM1iU6DsPBex0hsSHgShK/dUt17/5kPrZw=;
  b=J9Ukos842g42ZQZg+c5j48DbCh5Nj5F7hB1S/j0VKxsJhiuEzIrW+JHK
   3sEItuAfUAXK2nAZ/Hp4q9zWWMM8V/DIA+h0PvENqy910pOEyjRJN6/Nu
   n88wrEDVSxKUufIqoaygpZT57xN51FUQ8J4MMMnCB+xVZ1bI32t+Ajc1j
   yZu8FEUwAVgPnI09QAIEU02NRskRyL95VzWRIn+0vzcBSIXwyVBxHFzLO
   2oVfCKd+NMwWww5j+V/qc/MJhAFVuPSI5tsRrmZdFGXnE3CLRAOljoTUr
   p2oXt0yLJXiaxnj1f0j0x9YGMSLD1EZMKzs5GCPbfVbkdPvF1+sGkmn1z
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="24828650"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="24828650"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 09:34:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="29968742"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.213.21.72])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 09:33:58 -0800
From: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To: linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RFC PATCH v2] cleanup: Add cond_guard() to conditional guards
Date: Tue, 30 Jan 2024 18:33:54 +0100
Message-ID: <22169722.EfDdHjke4D@fdefranc-mobl3>
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
> > Add cond_guard() to conditional guards.
> > 
> > cond_guard() is used for the _interruptible(), _killable(), and _try
> > versions of locks. It expects a block where the failure can be handled
> > (e.g., calling printk() and returning -EINTR in case of failure).
> > 
> > As the other guards, it avoids to open code the release of the lock
> > after a goto to an 'out' label.
> > 
> > This remains an RFC because Dan suggested a slightly different syntax:
> > 	if (cond_guard(...))
> > 	
> > 		return -EINTR;
> > 
> > But the scoped_cond_guard() macro omits the if statement:
> >     	scoped_cond_guard (...) {
> >     	}
> > 
> > Thus define cond_guard() similarly to scoped_cond_guard() but with a block
> > 
> > to handle the failure case:
> > 	cond_guard(...)
> > 	
> > 		return -EINTR;
> 
> That's too subtle for me, because of the mistakes that can be made with
> brackets how about a syntax like:
> 
>  	cond_guard(..., return -EINTR, ...)
> 
> ...to make it clear what happens if the lock acquisition fails without
> having to remember there is a hidden incomplete "if ()" statement in
> that macro? More below...

As you propose I can't see how to handle multi-line error path like in:

	cond_guard(...) {
		dev_dbg(...);
		return -EINTR;
	} 

I added a similar example in a comment in cleanup.h.

> 
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Fabio M. De Francesco
> > <fabio.maria.de.francesco@linux.intel.com> ---
> > 
> >  drivers/cxl/core/region.c | 17 +++++------------
> >  include/linux/cleanup.h   | 13 +++++++++++++
> >  2 files changed, 18 insertions(+), 12 deletions(-)
> > 
> > [...] 
> >
> > diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
> > index c2d09bc4f976..fc850e61a47e 100644
> > --- a/include/linux/cleanup.h
> > +++ b/include/linux/cleanup.h
> > @@ -134,6 +134,15 @@ static inline class_##_name##_t
> > class_##_name##ext##_constructor(_init_args) \> 
> >   *	an anonymous instance of the (guard) class, not recommended for
> >   *	conditional locks.
> >   *
> > 
> > + * cond_guard(_name, args...):
> > + * 	for conditional locks like mutex_trylock() or
> > down_read_interruptible(). + * 	It expects a block for handling 
errors
> > like in the following example: + *
> > + * 	cond_guard(rwsem_read_intr, &my_sem) {
> > + * 		printk(KERN_NOTICE "Try failure in work0()\n");
> > + * 		return -EINTR;
> > + * 	}
> > + *
> > 
> >   * scoped_guard (name, args...) { }:
> >   *	similar to CLASS(name, scope)(args), except the variable (with the
> >   *	explicit name 'scope') is declard in a for-loop such that its scope 
is
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
> 
> ...does that "else if" belong to the first "if ()" or the hidden one
> inside the macro?

Good question.

> You can steal the embedded "if ()" trick from scoped_cond_guard() and do
> something like (untested):
> 
> #define cond_guard(_name, _fail, args...) \
> 	CLASS(_name, scope)(args); \
> 	if (!__guard_ptr(_name)(&scope)) _fail; else /* pass */;

I think this may work, but...

Again, with this interface there is no means to handle multi-line error paths. 
I wanted an interface sufficiently flexible to handle logging + return -EINTR, 
and possibly more lines to undo something.

Can we have two macros, this for multi-line error paths, and one other, like 
you suggested, for an immediate 'return -EINTR'?

Thanks,

Fabio



