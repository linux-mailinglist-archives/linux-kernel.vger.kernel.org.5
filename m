Return-Path: <linux-kernel+bounces-48471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA47B845C77
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A226429A99F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7424F626B5;
	Thu,  1 Feb 2024 16:05:12 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573DE626B2;
	Thu,  1 Feb 2024 16:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706803512; cv=none; b=PG8LH+NlJvwweyJlar5US8WOYLNxS+Yknz7O3lxh6AffDitJgvxPwd1oAMJUc6oWr2Gzt6neRw0rILbOlJkElxQ3Ad+8+Ky4Wd5G+QV0jN7oK3wJxBgJQTgdWSsBcTlAyrbGx2iUn8KJ/97b5Xj+ecuyrPCScLdUQjf3MEsZxBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706803512; c=relaxed/simple;
	bh=Z4KWkopw0P8NWY+NdbIbasEYRbUcxFGfdL8V5cww8KI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IxiUyR/GtE6DB6SLPxHIkKWx0lVxygvmS70IzInz5cady7Zuog0kmvv0cstkcx11z+DR57aV0kBqXFLa8A6HhX89sjRR10KqYz9q9wBmsS1WoS0whjShkW6ihZiUzs0t3qcVZaBUrdde2NTD16I28qjWGOYJ8A7mh0puFY5EHTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TQkDt68ZCz6FGZ8;
	Fri,  2 Feb 2024 00:02:06 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 9586A1404F5;
	Fri,  2 Feb 2024 00:05:06 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 1 Feb
 2024 16:05:06 +0000
Date: Thu, 1 Feb 2024 16:05:05 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
CC: Peter Zijlstra <peterz@infradead.org>, <dan.j.williams@intel.com>,
	<linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
	<linux-cxl@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RFC PATCH v3] cleanup: Add cond_guard() to conditional guards
Message-ID: <20240201160505.00007151@Huawei.com>
In-Reply-To: <3280120.44csPzL39Z@fdefranc-mobl3>
References: <20240131134108.423258-1-fabio.maria.de.francesco@linux.intel.com>
	<20240201113612.00001d90@Huawei.com>
	<2172852.irdbgypaU6@fdefranc-mobl3>
	<3280120.44csPzL39Z@fdefranc-mobl3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 01 Feb 2024 16:32:25 +0100
"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com> wrote:

> On Thursday, 1 February 2024 16:13:34 CET Fabio M. De Francesco wrote:
> > On Thursday, 1 February 2024 12:36:12 CET Jonathan Cameron wrote:  
> > > On Thu, 01 Feb 2024 09:16:59 +0100
> > > 
> > > "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com> wrote:  
> > > > [snip]
> > > > 
> > > > Actually, I'm doing this:
> > > > 	cond_guard(..., rc, 0, -EINTR, ...);  
> > > 
> > > Can we not works some magic to do.
> > > 
> > > 	cond_guard(..., return -EINTR, ...)
> > > 
> > > and not have an rc at all if we don't want to.
> > > 
> > > Something like
> > > 
> > > #define cond_guard(_name, _fail, args...) \
> > > 
> > > 	CLASS(_name, scope)(args); \
> > > 	if (!__guard_ptr(_name)(&scope)) _fail
> > > 
> > > Completely untested so I'm probably missing some subtleties.
> > > 
> > > Jonathan  
> > 
> > Jonathan,
> > 
> > Can you please comment on the v5 of this RFC?

Would lose context of this discussion.

> > It is at
> > https://lore.kernel.org/all/20240201131033.9850-1-fabio.maria.de.francesco@
> > linux.intel.com/
> > 
> > The macro introduced in v5 has the following, more general, use case:
> > 
> > * * 	int ret;
> > + * 	// down_read_trylock() returns 1 on success, 0 on contention
> > + * 	cond_guard(rwsem_read_try, ret, 1, 0, &sem);
> > + * 	if (!ret) {
> > + * 		dev_dbg("down_read_trylock() failed to down 'sem')\n");
> > + * 		return ret;
> > + * 	}
> > 
> > The text above has been copy-pasted from the RFC Patch v5.
> > 
> > Please notice that we need to provide both the success and the failure code
> > to make it work also with the _trylock() variants (more details in the
> > patch).  
> 
> The next three lines have been messed up by a copy-paste.
> They are:
> 
> If we simply do something like:
> 
> 	cond_guard(..., ret = 0, ...)
> 
> We won't store the success (that is 1) in ret and it would still contain 0, 
> that is the code of the contended case.

 
If there are cases that need to do different things in the two paths the
define full conditions for success and failure.

#define cond_guard(_name, _fail, _success, args...) \
 	CLASS(_name, scope)(args); \
 	if (!__guard_ptr(_name)(&scope)) _fail; \
	else _success

However I'm not sure that additional complexity is worth while.
Maybe just handling failure is all we need.

This should allow

cond_guard(rwsem_read_try, return -EINVAL, , lock); or
cond_guard(rwsem_read_try, rc = 1, rc = 0, lock);

So similar to scoped_cond_guard() there is no need to
have a local variable if all you want to do is return on
failure.

> 
> > If we simply do something like:
> > 
> > 	cond_guard(..., ret = 0, ...)
> > 
> > to be able store in 'ret' the code of the contended case, that is 0.
> > 
> > Since down_read_trylock() returns 1 on down semaphore, when we later check
> > 'ret' with "if (!ret) <failure path>;" we always enter in that failure path
> > even if the semaphore is down because we didn't store the success code in
> > ret (and ret is still probably 0).
> > 
> > This is why, I think, we need a five arguments cond_guard(). This can manage
> > also the _interruptible() and _killable() cases as:
> > 
> > 	cond_guard(..., ret, 0, -EINTR, ...)
> > 
> > In this case we don't need 5 arguments, but we have a general use case, one
> > only macro, that can work with all the three variants of locks.
> > 
> > Fabio  
> 
> 
> 
> 


