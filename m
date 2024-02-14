Return-Path: <linux-kernel+bounces-65774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 694768551AD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2605C298AB8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4126512DDB0;
	Wed, 14 Feb 2024 18:04:59 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49ACC1292DB;
	Wed, 14 Feb 2024 18:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933898; cv=none; b=XWkFJn0hferKHz8Fc1bZpG6bY8R5PISVRdwTUiOkTQWvdKTi8RSuN55BtAhT9B6s9ahvcxYB7J9lxFXOEXZgSUb3NMKni4PgRc4nJ5DAryBgBKOUWydAAIExPqHRB2lXZPVzWu5qlpqNzRYZDybREKGeySh/Xq67+XKrCdlgJt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933898; c=relaxed/simple;
	bh=1opVNwI5g0qTfL7RCSwClpE248xDSuhAxDOStvKcVJI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ez84ekcnLhIFMYy93zPf1jeRt+zJOiWCTtfcko6OLwtZAIzGXaTvoG9AuOc1PGnbutrkSvI4gLN7TFWRebmnu2Hhp52sLtENuqfRNGT25yHGpng6nijAc9xika8Qz53sMF0B1GCekyynKmNmkAkC5Uyj2gW5APNP2Q72z0neyZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TZmFx2cqfz6JB0p;
	Thu, 15 Feb 2024 02:00:53 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 8034B140682;
	Thu, 15 Feb 2024 02:04:53 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 18:04:53 +0000
Date: Wed, 14 Feb 2024 18:04:52 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
CC: Peter Zijlstra <peterz@infradead.org>, Dan Williams
	<dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Dave Jiang
	<dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 1/2 v4] cleanup: Add cond_guard() to conditional guards
Message-ID: <20240214180452.00000974@Huawei.com>
In-Reply-To: <3917370.kQq0lBPeGt@fdefranc-mobl3>
References: <20240208130424.59568-1-fabio.maria.de.francesco@linux.intel.com>
	<20240208130424.59568-2-fabio.maria.de.francesco@linux.intel.com>
	<3917370.kQq0lBPeGt@fdefranc-mobl3>
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
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 13 Feb 2024 17:51:26 +0100
"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com> wrote:

> On Thursday, 8 February 2024 14:04:23 CET Fabio M. De Francesco wrote:
> > Add cond_guard() macro to conditional guards.
> > 
> > cond_guard() is a guard to be used with the conditional variants of locks,
> > like down_read_trylock() or mutex_lock_interruptible().
> > 
> > It takes a statement (or statement-expression) that is passed as its
> > second argument. That statement (or statement-expression) is executed if
> > waiting for a lock is interrupted or if a _trylock() fails in case of
> > contention.
> > 
> > Usage example:
> > 
> > 	cond_guard(mutex_intr, return -EINTR, &mutex);
> > 
> > Consistent with other usage of _guard(), locks are unlocked at the exit of
> > the scope where cond_guard() is called.
> >   
> [snip]
> > 
> > +#define cond_guard(_name, _fail, args...) \
> > +	CLASS(_name, scope)(args); \
> > +	if (!__guard_ptr(_name)(&scope)) _fail; \
> > +	else { }
> > +  
> 
> I have converted and tested several functions in drivers/cxl and found that 
> there are cases where this macro needs to be called twice in the same scope.
> 
> The current implementation fails to compile because any subsequent call to 
> cond_guard() redefines "scope".
> 
> I have a solution for this, which is to instantiate a differently named 
> variable each time cond_guard() is used:
> 
> #define __UNIQUE_LINE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __LINE__)
> #define cond_guard(_name, _fail, args...) \
>         CLASS(_name, __UNIQUE_LINE_ID(scope))(args); \
>         if (!__guard_ptr(_name)(&__UNIQUE_LINE_ID(scope))) _fail; \
>         else { }
> 
> But, before sending v5, I think it's best to wait for comments from those with 
> more experience than me.

Ah. So you can't use __UNIQUE_ID as guard does because we need it to be stable
across the two uses.  What you have looks fine to me.
We might end up with someone putting multiple calls in a macro but in my
view anyone doing that level of complexity in a macro is shooting themselves
in the foot.

Jonathan


> 
> Fabio
> 
> 
> 
> 


