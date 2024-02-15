Return-Path: <linux-kernel+bounces-66624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D501855F21
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3235B1F21801
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77DA69D19;
	Thu, 15 Feb 2024 10:26:49 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7949C69D05;
	Thu, 15 Feb 2024 10:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707992809; cv=none; b=GhccxBjcCAHNBHiDYuHSr19hfEdVLc+fsqdDj8KfVDp5F7todqPXb3/kv/v+4mRAUnFPJY1lAGbUwLRqyRbrhuBD7U6MMkQrWzmxSmkhu0hImCHuccAo4dhZ6LojqE0DvxxAOh8rRhGUNRXQkzDR7G4JS8UUkeZf5PsAgSXLBgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707992809; c=relaxed/simple;
	bh=20qbWw4eZocIiRgqnsx02KAsr2J5ezEMIV7F1eRgzYQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VAuhYccRmQzHWyZeCZ/DHqI+x4WovnP0S/QqJFGKxgvevA4a5FrWg0dxSIN1h/DCkA2pP7O4pso8jdG0GojCSyu7Gw7maUQZewOmaLTSXl7otYoflO+iDozd4oXXXmjIUINikfkFnnI5YtrMjW1/uIA+7m7FFuCVrYB6hKLlwgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbB3S0L7Qz67Ldy;
	Thu, 15 Feb 2024 18:23:16 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 8A0221400D4;
	Thu, 15 Feb 2024 18:26:43 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 10:26:43 +0000
Date: Thu, 15 Feb 2024 10:26:42 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
CC: Peter Zijlstra <peterz@infradead.org>, Dan Williams
	<dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Dave Jiang
	<dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 1/2 v4] cleanup: Add cond_guard() to conditional guards
Message-ID: <20240215102642.000067c5@Huawei.com>
In-Reply-To: <20240214180452.00000974@Huawei.com>
References: <20240208130424.59568-1-fabio.maria.de.francesco@linux.intel.com>
	<20240208130424.59568-2-fabio.maria.de.francesco@linux.intel.com>
	<3917370.kQq0lBPeGt@fdefranc-mobl3>
	<20240214180452.00000974@Huawei.com>
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
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 14 Feb 2024 18:04:52 +0000
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Tue, 13 Feb 2024 17:51:26 +0100
> "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com> wrote:
> 
> > On Thursday, 8 February 2024 14:04:23 CET Fabio M. De Francesco wrote:  
> > > Add cond_guard() macro to conditional guards.
> > > 
> > > cond_guard() is a guard to be used with the conditional variants of locks,
> > > like down_read_trylock() or mutex_lock_interruptible().
> > > 
> > > It takes a statement (or statement-expression) that is passed as its
> > > second argument. That statement (or statement-expression) is executed if
> > > waiting for a lock is interrupted or if a _trylock() fails in case of
> > > contention.
> > > 
> > > Usage example:
> > > 
> > > 	cond_guard(mutex_intr, return -EINTR, &mutex);
> > > 
> > > Consistent with other usage of _guard(), locks are unlocked at the exit of
> > > the scope where cond_guard() is called.
> > >     
> > [snip]  
> > > 
> > > +#define cond_guard(_name, _fail, args...) \
> > > +	CLASS(_name, scope)(args); \
> > > +	if (!__guard_ptr(_name)(&scope)) _fail; \
> > > +	else { }
> > > +    
> > 
> > I have converted and tested several functions in drivers/cxl and found that 
> > there are cases where this macro needs to be called twice in the same scope.
> > 
> > The current implementation fails to compile because any subsequent call to 
> > cond_guard() redefines "scope".
> > 
> > I have a solution for this, which is to instantiate a differently named 
> > variable each time cond_guard() is used:
> > 
> > #define __UNIQUE_LINE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __LINE__)
> > #define cond_guard(_name, _fail, args...) \
> >         CLASS(_name, __UNIQUE_LINE_ID(scope))(args); \
> >         if (!__guard_ptr(_name)(&__UNIQUE_LINE_ID(scope))) _fail; \
> >         else { }
> > 
> > But, before sending v5, I think it's best to wait for comments from those with 
> > more experience than me.  
> 
> Ah. So you can't use __UNIQUE_ID as guard does because we need it to be stable
> across the two uses.  What you have looks fine to me.
> We might end up with someone putting multiple calls in a macro but in my
> view anyone doing that level of complexity in a macro is shooting themselves
> in the foot.

Thought more on this whilst cycling home.  Can you use another level
of macros in combination with __UNIQUE_ID that guard uses?
My skills with macros are very limited so I'm sure I got something wrong,
but along the lines of.

#define __cond_class(__unique, _name, _fail, args...) \
   CLASS(_name, __unique)(args); \
         if (!__guard_ptr(_name)(&__unique)) _fail; \
         else { }
#define cond_class(_name, _fail, args... ) \
    __cond_class(__UNIQUE_ID(guard), _name, _fail, args...

?

> 
> Jonathan
> 
> 
> > 
> > Fabio
> > 
> > 
> > 
> >   
> 
> 


