Return-Path: <linux-kernel+bounces-38638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4279A83C384
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 748021C21424
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A0350A69;
	Thu, 25 Jan 2024 13:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvPwZ6Az"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A8650A71;
	Thu, 25 Jan 2024 13:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706188846; cv=none; b=ltmBi4on713LOemDg2V9/wCu9vWS1Bz1NEPF2XMDNSC2YhCTpwwIC2nkGOPL4OviFzV/NQHljLPNapn1GKcI6DB0R+wce/O4JARJ6lsGt7MSnArhKwrNDuZAnPAngbp253K0Ui+eUpqjhba7LBuwfvToprwmO+nstX0xspWgiD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706188846; c=relaxed/simple;
	bh=REBZVG9ehyWFJMZdJCjxgTWUOv9y1bMZcqreSj6u5EI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=id8kvQ6XSudqaafBYNjURxtN70KWZ6ONk6uYgNo+SV+I1qf737haIJe3JvranBMkRQFbvLubFhRM1mZSVKEFosAbvoOnBzUTJW2s3CPdkop44XnLLD0dMyzvtH/Xx6XiOgZ6yWB5+wHCQ05sMIKamXQ0A4Q2uKlgGPj8pvfrR80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvPwZ6Az; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 549DCC433F1;
	Thu, 25 Jan 2024 13:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706188845;
	bh=REBZVG9ehyWFJMZdJCjxgTWUOv9y1bMZcqreSj6u5EI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=XvPwZ6AzhOVK6A3/vsuVyOFrAjO4c/mAA4zUw9lmJ6R/R6KL+mNzUgYzYot46Levk
	 FzWTm8sMRVWeLfbMe4vMOBygGZdpmHeJoLmuSRU3JfLE0oGmmJY4FCresqAsmfLqmv
	 hq0B6ly4ckUdxQ3A5+NEV806+lmOzSqI2GjVp26vbRgUrhIHWKL685tdCvsGUbk1I4
	 T2V4X9nZ35yxMAyMQbmfuzaO/6Ro3Nq55TbN1lb1HzB+NXF6sn3AvEv9n3lqFDBG1Y
	 NziJ6+upFovUW2qO8Jyqz0vTUynOnQbbbNVt5E34YzJYAAfliyQlDV2zQrzgCbsSaA
	 CcLD9dMoaUdlw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E6F0FCE189D; Thu, 25 Jan 2024 05:20:44 -0800 (PST)
Date: Thu, 25 Jan 2024 05:20:44 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Marco Elver <elver@google.com>
Cc: Alexander Potapenko <glider@google.com>, quic_charante@quicinc.com,
	akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
	dan.j.williams@intel.com, david@redhat.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	mgorman@techsingularity.net, osalvador@suse.de, vbabka@suse.cz,
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Nicholas Miehlbradt <nicholas@linux.ibm.com>, rcu@vger.kernel.org
Subject: Re: [PATCH] mm/sparsemem: fix race in accessing memory_section->usage
Message-ID: <9d94958c-7ab3-4f0d-a718-1f72c1467925@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <1697202267-23600-1-git-send-email-quic_charante@quicinc.com>
 <20240115184430.2710652-1-glider@google.com>
 <CANpmjNMP802yN0i6puHHKX5E1PZ_6_h1x9nkGHCXZ4DVabxy7A@mail.gmail.com>
 <Zagn_T44RU94dZa7@elver.google.com>
 <CAG_fn=XcMBWLCZKNY+hiP9HxT9vr0bXDEaHmOcr9-jVro5yAxw@mail.gmail.com>
 <ZajyqgE3ZHYHSvZC@elver.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZajyqgE3ZHYHSvZC@elver.google.com>

On Thu, Jan 18, 2024 at 10:43:06AM +0100, Marco Elver wrote:
> On Thu, Jan 18, 2024 at 10:01AM +0100, Alexander Potapenko wrote:
> > >
> > > Hrm, rcu_read_unlock_sched_notrace() can still call
> > > __preempt_schedule_notrace(), which is again instrumented by KMSAN.
> > >
> > > This patch gets me a working kernel:
> > >
> [...]
> > > Disabling interrupts is a little heavy handed - it also assumes the
> > > current RCU implementation. There is
> > > preempt_enable_no_resched_notrace(), but that might be worse because it
> > > breaks scheduling guarantees.
> > >
> > > That being said, whatever we do here should be wrapped in some
> > > rcu_read_lock/unlock_<newvariant>() helper.
> > 
> > We could as well redefine rcu_read_lock/unlock in mm/kmsan/shadow.c
> > (or the x86-specific KMSAN header, depending on whether people are
> > seeing the problem on s390 and Power) with some header magic.
> > But that's probably more fragile than adding a helper.
> > 
> > >
> > > Is there an existing helper we can use? If not, we need a variant that
> > > can be used from extremely constrained contexts that can't even call
> > > into the scheduler. And if we want pfn_valid() to switch to it, it also
> > > should be fast.
> 
> The below patch also gets me a working kernel. For pfn_valid(), using
> rcu_read_lock_sched() should be reasonable, given its critical section
> is very small and also enables it to be called from more constrained
> contexts again (like KMSAN).
> 
> Within KMSAN we also have to suppress reschedules. This is again not
> ideal, but since it's limited to KMSAN should be tolerable.
> 
> WDYT?

I like this one better from a purely selfish RCU perspective.  ;-)

							Thanx, Paul

> ------ >8 ------
> 
> diff --git a/arch/x86/include/asm/kmsan.h b/arch/x86/include/asm/kmsan.h
> index 8fa6ac0e2d76..bbb1ba102129 100644
> --- a/arch/x86/include/asm/kmsan.h
> +++ b/arch/x86/include/asm/kmsan.h
> @@ -64,6 +64,7 @@ static inline bool kmsan_virt_addr_valid(void *addr)
>  {
>  	unsigned long x = (unsigned long)addr;
>  	unsigned long y = x - __START_KERNEL_map;
> +	bool ret;
>  
>  	/* use the carry flag to determine if x was < __START_KERNEL_map */
>  	if (unlikely(x > y)) {
> @@ -79,7 +80,21 @@ static inline bool kmsan_virt_addr_valid(void *addr)
>  			return false;
>  	}
>  
> -	return pfn_valid(x >> PAGE_SHIFT);
> +	/*
> +	 * pfn_valid() relies on RCU, and may call into the scheduler on exiting
> +	 * the critical section. However, this would result in recursion with
> +	 * KMSAN. Therefore, disable preemption here, and re-enable preemption
> +	 * below while suppressing rescheduls to avoid recursion.
> +	 *
> +	 * Note, this sacrifices occasionally breaking scheduling guarantees.
> +	 * Although, a kernel compiled with KMSAN has already given up on any
> +	 * performance guarantees due to being heavily instrumented.
> +	 */
> +	preempt_disable();
> +	ret = pfn_valid(x >> PAGE_SHIFT);
> +	preempt_enable_no_resched();
> +
> +	return ret;
>  }
>  
>  #endif /* !MODULE */
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 4ed33b127821..a497f189d988 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -2013,9 +2013,9 @@ static inline int pfn_valid(unsigned long pfn)
>  	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
>  		return 0;
>  	ms = __pfn_to_section(pfn);
> -	rcu_read_lock();
> +	rcu_read_lock_sched();
>  	if (!valid_section(ms)) {
> -		rcu_read_unlock();
> +		rcu_read_unlock_sched();
>  		return 0;
>  	}
>  	/*
> @@ -2023,7 +2023,7 @@ static inline int pfn_valid(unsigned long pfn)
>  	 * the entire section-sized span.
>  	 */
>  	ret = early_section(ms) || pfn_section_valid(ms, pfn);
> -	rcu_read_unlock();
> +	rcu_read_unlock_sched();
>  
>  	return ret;
>  }

