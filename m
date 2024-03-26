Return-Path: <linux-kernel+bounces-119616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F37988CB1B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 248DC2E52D2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397D41CFA0;
	Tue, 26 Mar 2024 17:38:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8891C69C
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 17:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711474705; cv=none; b=Fc1LOGd9OX85L5Davxtzok47kZtC6HpqHpkhiqA9UGPIOhJf3ESXVdgGGgZxlzXZ1MOpR8t0OV8BHvnokhTNKkdd1xWd6ZDmb022Q5hTj3k5jSd9IerOByNBBVoZbH4D4y4SckbwlC2JU60jMKp/OSbeagHO+g4fjymRwOvm7H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711474705; c=relaxed/simple;
	bh=UndDdIVYnAnJDWxr67Fb1eKNseyWiL/CoHXbJE2geUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdqW1x7vKu25BhmEFy9xPRToHL24tcr42enhO7VTmEIxlYuBGXNaHmwVSjxMBM8OhjyNCUb6p3Mq0kEQj14Yvqcvf8jChxl3cJbNXX0xeTxU3xxl7hNm6j8mNowcUPgaeMMVfMVImgbZ2JVgxxg2kVCtrXdiYZY0eqfk203vIAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 645F52F4;
	Tue, 26 Mar 2024 10:38:57 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.35.184])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14E4D3F64C;
	Tue, 26 Mar 2024 10:38:20 -0700 (PDT)
Date: Tue, 26 Mar 2024 17:38:18 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-kernel@vger.kernel.org, agordeev@linux.ibm.com,
	anil.s.keshavamurthy@intel.com, aou@eecs.berkeley.edu, bp@alien8.de,
	catalin.marinas@arm.com, dave.hansen@linux.intel.com,
	davem@davemloft.net, gor@linux.ibm.com, hca@linux.ibm.com,
	jcalvinowens@gmail.com, linux-arm-kernel@lists.infradead.org,
	mhiramat@kernel.org, mingo@redhat.com, mpe@ellerman.id.au,
	naveen.n.rao@linux.ibm.com, palmer@dabbelt.com,
	paul.walmsley@sifive.com, tglx@linutronix.de, will@kernel.org
Subject: Re: [PATCH 4/4] kprobes: Remove core dependency on modules
Message-ID: <ZgMICo-dZJgVklc4@FVFF77S0Q05N.cambridge.arm.com>
References: <20240326163624.3253157-1-mark.rutland@arm.com>
 <20240326163624.3253157-5-mark.rutland@arm.com>
 <D03UMKC71414.2D6NN1BIWD5TZ@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D03UMKC71414.2D6NN1BIWD5TZ@kernel.org>

On Tue, Mar 26, 2024 at 07:13:51PM +0200, Jarkko Sakkinen wrote:
> On Tue Mar 26, 2024 at 6:36 PM EET, Mark Rutland wrote:

> > +#ifdef CONFIG_MODULES
> >  	/* Check if 'p' is probing a module. */
> >  	*probed_mod = __module_text_address((unsigned long) p->addr);
> >  	if (*probed_mod) {
> > @@ -1605,6 +1606,8 @@ static int check_kprobe_address_safe(struct kprobe *p,
> >  			ret = -ENOENT;
> >  		}
> >  	}
> > +#endif
> 
> This can be scoped a bit more (see v7 of my patch set).

> > +#ifdef CONFIG_MODULES
> >  static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
> >  {
> >  	char *p;
> > @@ -129,6 +130,9 @@ static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
> >  
> >  	return ret;
> >  }
> > +#else
> > +#define trace_kprobe_module_exist(tk) false /* aka a module never exists */
> > +#endif /* CONFIG_MODULES */
> >  
> >  static bool trace_kprobe_is_busy(struct dyn_event *ev)
> >  {
> > @@ -670,6 +674,7 @@ static int register_trace_kprobe(struct trace_kprobe *tk)
> >  	return ret;
> >  }
> >  
> > +#ifdef CONFIG_MODULES
> >  /* Module notifier call back, checking event on the module */
> >  static int trace_kprobe_module_callback(struct notifier_block *nb,
> >  				       unsigned long val, void *data)
> > @@ -699,6 +704,9 @@ static int trace_kprobe_module_callback(struct notifier_block *nb,
> >  
> >  	return NOTIFY_DONE;
> >  }
> > +#else
> > +#define trace_kprobe_module_callback (NULL)
> > +#endif /* CONFIG_MODULES */
> 
> The last two CONFIG_MODULES sections could be combined. This was also in
> v7.

> Other than lgtm.

Great! I've folded your v7 changes in, and pushed that out to:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=kprobes/without-modules

I'll hold off sending that out to the list until other folk have had a chance
to comment.

Mark.

