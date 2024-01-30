Return-Path: <linux-kernel+bounces-44766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B3F842719
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75E6F1C26217
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D58C6A01C;
	Tue, 30 Jan 2024 14:45:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72406F4EE;
	Tue, 30 Jan 2024 14:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706625901; cv=none; b=m1wYAB/4HKq8wCwu3DUfNmMcEFfTRtrsvTqIMKAygK3SxsMzhSoAbys87YseW10rTrVktwX3ZgCgAbtSaPLG9SIjqK86KddvCp6FkQuylMYV41d3vqWpx+YFBVat8Zox7J3MHMJebryQIOSiNCcTHNrXOi4OtQYvEKNHYAtxStY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706625901; c=relaxed/simple;
	bh=0VbkX8braxi3BLs1wzLKUruKz9+ZnyZtunF5Xh0bD5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fs36wyUifsX2yzmJ67Hf6ULw0EUj/hH5bK48+qe7sJXadQGihVTztIK3H8KhJQuqZQPY36JylUdQR9PPUXE284Er1sQmdZ36qYe/yhaH1HLk6ocpcCM95muhsALaem87qyco4hXpcC/kPlN78VsV2X+FINkJ7ojH4scSSATeGHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E629FDA7;
	Tue, 30 Jan 2024 06:45:39 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 884443F762;
	Tue, 30 Jan 2024 06:44:54 -0800 (PST)
Date: Tue, 30 Jan 2024 14:44:51 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64/signal: Don't assume that TIF_SVE means we saved
 SVE state
Message-ID: <ZbkLY+gz7Az1OgNK@e133380.arm.com>
References: <20240119-arm64-sve-signal-regs-v1-1-b9fd61b0289a@kernel.org>
 <20240130115107.GB13551@willie-the-truck>
 <b0ed6698-bc65-48fb-96b8-0cd077448196@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0ed6698-bc65-48fb-96b8-0cd077448196@sirena.org.uk>

On Tue, Jan 30, 2024 at 02:09:34PM +0000, Mark Brown wrote:
> On Tue, Jan 30, 2024 at 11:51:07AM +0000, Will Deacon wrote:
> > On Fri, Jan 19, 2024 at 12:29:13PM +0000, Mark Brown wrote:
> 
> > > -	if (test_thread_flag(TIF_SVE))
> > > +	if (current->thread.fp_type == FP_STATE_SVE)
> > >  		sve_to_fpsimd(current);
> > >  }
> 
> > I don't think this hunk applies on -rc2 ^^.
> 
> Hrm, git seemed to figure out a rebase with no intervention - I've
> thrown it at my CI and will resend assuming no changes from the rest of
> the discussion.
> 
> > > -		if (add_all || test_thread_flag(TIF_SVE) ||
> > > +		if (add_all || current->thread.fp_type == FP_STATE_SVE ||
> > >  		    thread_sm_enabled(&current->thread)) {
> > >  			int vl = max(sve_max_vl(), sme_max_vl());
> 
> > I think this code is preemptible, so I'm struggling to understand what
> > happens if the fp_type changes under our feet as a result of a context
> > switch.
> 
> We are relying here on having forced a flush of the floating point
> register state prior to this code running, simple preemption won't
> change the state from what was already saved.  The same consideration
> also applies to the check for streaming mode here.
> 
> That said if this is preempted ptrace *could* come in and rewrite the
> data or at worst change the vector length (which could leave us with
> sve_state deallocated or a different size, possibly while we're in the
> middle of accessing it).  This could also happen with the existing check
> for TIF_SVE so I don't think there's anything new here - AFAICT this has
> always been an issue with the vector code, unless I'm missing some
> bigger thing which excludes ptrace.  I think any change that's needed
> there won't overlap with this one, I'm looking.

I'm pretty sure that terrible things will happen treewide if ptrace can
ever access or manipulate the internal state of a _running_ task.

I think the logic is that any ptrace call that can access or manipulate
the state of a task is gated on the task being ptrace-stopped.  Once we
have committed to deliveing a signal, we have obviously run past the
opportunity to stop (and hence be ptraced) on that signal.

Cases where a multiple signals are delivered before acutally reaching
userspace might want some thought.

I haven't tracked down the smokeproof gun in the code yet, though.


From memory, I think that the above forced flush was there to protect
against the context switch code rather than ptrace, and guarantees that
any change that ctxsw _might_ spontaneously make to the task state has
already been done and dusted before we do the actual signal delivery.
This may be a red herring so far as ptrace hazards are concerned.

Cheers
---Dave

