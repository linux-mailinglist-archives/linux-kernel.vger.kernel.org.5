Return-Path: <linux-kernel+bounces-120150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E294588D2FA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 01:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97CD11F22B11
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 00:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DDE1DFF7;
	Wed, 27 Mar 2024 00:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqfqpiE/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D595F20EE
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 00:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711497722; cv=none; b=VifWx3Ilwv99R2/0lIlQwSTLsLepohXFl7m6vHAk7K1OPzm6puuWhbjiAOfQgwU7CLqTbjqzMfaMTdRczJMIv/pEKE5Wpvn2RFpfHf0YoHexGj30ypIwNZFuYooeRB/bQINZyDolPvBbmKiNMsrJ2pooj4dGVTT7j6seiFa08nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711497722; c=relaxed/simple;
	bh=h1ujNBBy/aBs5SW6I/JPn+LTBRALB6UclagN9KkHVDc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=goYB6YQt2kDuRiAk7f7DDdS5TNfB8/qqkKRegYkNVWWDqolJj98I0NW0ujgWZ/KbffAFiaonhR4c4EM1GP1/c7wrtCsxf8MgJ2TiypyVPUedh93DC1sGq9y3hi9DoAryKpZ4FOGIxibD71P9IGMuEwfuTI8LYsYBB5syig28CbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqfqpiE/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D00C433C7;
	Wed, 27 Mar 2024 00:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711497722;
	bh=h1ujNBBy/aBs5SW6I/JPn+LTBRALB6UclagN9KkHVDc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eqfqpiE/HKWvyIVb/EgbcC1g5iAtm+HLjwRUgFHbs9U8rp3c2WSUqHye2xfVRf0+B
	 Uxy5b+pmom73QwIRXGHUJXlxr7nhOPrIynCmtY9qHHAhBT3CH2XXAqx1sw8vOW9qRJ
	 FnxEyMBCI3smmROycLHUN1C9te9Jz+fidz1Z0Uxy/R6hDm+kXt4NXiZYcA5/QAx7oN
	 4Yj2UKDllfUz1IAMl7ChOAxv42I9cg+2rkWEmW2otQqwZuQdQiCS/suP+zGxjEml/Y
	 uwEAOgEwHNqZNp3eXg5Lr9vMXJZLr3eDy3BRYEoxHXOZyTWAuY2rBicwz3rHvguSVg
	 17Xl6Xy699tGA==
Date: Wed, 27 Mar 2024 09:01:55 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, linux-kernel@vger.kernel.org,
 agordeev@linux.ibm.com, anil.s.keshavamurthy@intel.com,
 aou@eecs.berkeley.edu, bp@alien8.de, catalin.marinas@arm.com,
 dave.hansen@linux.intel.com, davem@davemloft.net, gor@linux.ibm.com,
 hca@linux.ibm.com, jcalvinowens@gmail.com,
 linux-arm-kernel@lists.infradead.org, mhiramat@kernel.org,
 mingo@redhat.com, mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com,
 palmer@dabbelt.com, paul.walmsley@sifive.com, tglx@linutronix.de,
 will@kernel.org
Subject: Re: [PATCH 4/4] kprobes: Remove core dependency on modules
Message-Id: <20240327090155.873f1ed32700dbdb75f8eada@kernel.org>
In-Reply-To: <ZgMICo-dZJgVklc4@FVFF77S0Q05N.cambridge.arm.com>
References: <20240326163624.3253157-1-mark.rutland@arm.com>
	<20240326163624.3253157-5-mark.rutland@arm.com>
	<D03UMKC71414.2D6NN1BIWD5TZ@kernel.org>
	<ZgMICo-dZJgVklc4@FVFF77S0Q05N.cambridge.arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Mar 2024 17:38:18 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> On Tue, Mar 26, 2024 at 07:13:51PM +0200, Jarkko Sakkinen wrote:
> > On Tue Mar 26, 2024 at 6:36 PM EET, Mark Rutland wrote:
> 
> > > +#ifdef CONFIG_MODULES
> > >  	/* Check if 'p' is probing a module. */
> > >  	*probed_mod = __module_text_address((unsigned long) p->addr);
> > >  	if (*probed_mod) {
> > > @@ -1605,6 +1606,8 @@ static int check_kprobe_address_safe(struct kprobe *p,
> > >  			ret = -ENOENT;
> > >  		}
> > >  	}
> > > +#endif
> > 
> > This can be scoped a bit more (see v7 of my patch set).
> 
> > > +#ifdef CONFIG_MODULES
> > >  static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
> > >  {
> > >  	char *p;
> > > @@ -129,6 +130,9 @@ static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
> > >  
> > >  	return ret;
> > >  }
> > > +#else
> > > +#define trace_kprobe_module_exist(tk) false /* aka a module never exists */
> > > +#endif /* CONFIG_MODULES */
> > >  
> > >  static bool trace_kprobe_is_busy(struct dyn_event *ev)
> > >  {
> > > @@ -670,6 +674,7 @@ static int register_trace_kprobe(struct trace_kprobe *tk)
> > >  	return ret;
> > >  }
> > >  
> > > +#ifdef CONFIG_MODULES
> > >  /* Module notifier call back, checking event on the module */
> > >  static int trace_kprobe_module_callback(struct notifier_block *nb,
> > >  				       unsigned long val, void *data)
> > > @@ -699,6 +704,9 @@ static int trace_kprobe_module_callback(struct notifier_block *nb,
> > >  
> > >  	return NOTIFY_DONE;
> > >  }
> > > +#else
> > > +#define trace_kprobe_module_callback (NULL)
> > > +#endif /* CONFIG_MODULES */
> > 
> > The last two CONFIG_MODULES sections could be combined. This was also in
> > v7.
> 
> > Other than lgtm.
> 
> Great! I've folded your v7 changes in, and pushed that out to:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=kprobes/without-modules
> 
> I'll hold off sending that out to the list until other folk have had a chance
> to comment.

Yeah, the updated one looks good to me too.

Thanks!

> 
> Mark.


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

