Return-Path: <linux-kernel+bounces-140857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC248A1939
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66E342810BA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E79B139568;
	Thu, 11 Apr 2024 15:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TsKroPqu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30C51386B3
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849666; cv=none; b=DUyeQ5opV1z3xdCUH9VHvhEEDzkp9GOb6v2STsb+uxEwxNzPvq5DSljG7mHRfGe3usZCdveCO5otBfBl/GhoxHKlUZUKPlZJCWxuFNINsAYQP9Z+plvNP3liH3lEVeePbzFICB1SwgfPFzxw3i9ZBPqJL5uElexh7kXdmsF2wis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849666; c=relaxed/simple;
	bh=YuahbXm5K4d78BIJVxJtPpmqTY2F+D+qHk/aXZOQcK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYg67Ay2k2jVi+MR+462Kz//ZgKA2GQMM5lB7LK3in8jECGumPc8idMEKprOGAQXHd1O4I3kQsdfDZqQy3acZhz/Ht2cBL8FEYLtJqSj2sdNWYteMVI/SY9lvf+VklIzOdJuyUzR81L7RrVHK2dk2MnAxjewrvXNmX+acX4QFFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TsKroPqu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9704C072AA;
	Thu, 11 Apr 2024 15:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712849665;
	bh=YuahbXm5K4d78BIJVxJtPpmqTY2F+D+qHk/aXZOQcK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TsKroPqupbSVei8wIXh/rCDph/186G/6XSinWmH51RZRs3XsWiDI795Vo3M5sgcLt
	 CFCh4pTDBu8zEW/GKJFn7dlYqC5uT9qjrtLDUwlxa7HE8RkAjcpq+NUAQkLnPVsitz
	 pHQV9OU5rKwT/cmntNigeKhydhv33kkpvsT3cAG/ORLrakBGMyZ7uyMdOBXbUmqYK+
	 8T/UG3ucar9c92RxVWgnG9fqAipB8T9K4r1KeDWrE6E+t/ItdNqxWkPP2s2IPncEYl
	 E4JBA5U6wlZufMmhpbNXbJo+yr4rqaQO2J3iwGq4k7125yEHw1aoTrrXR/PHHeEvWR
	 NVCN4uhUfEIZA==
Date: Thu, 11 Apr 2024 08:34:23 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	KP Singh <kpsingh@kernel.org>, Waiman Long <longman@redhat.com>,
	Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 3/7] x86/bugs: Fix BHI handling of RRSBA
Message-ID: <20240411153423.6oolchbhjvnk2jm3@treble>
References: <cover.1712813475.git.jpoimboe@kernel.org>
 <6f56f13da34a0834b69163467449be7f58f253dc.1712813475.git.jpoimboe@kernel.org>
 <997d9bf9-2a8b-452f-b458-2fa15f92918e@citrix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <997d9bf9-2a8b-452f-b458-2fa15f92918e@citrix.com>

On Thu, Apr 11, 2024 at 11:02:42AM +0100, Andrew Cooper wrote:
> >  /* Disable in-kernel use of non-RSB RET predictors */
> >  static void __init spec_ctrl_disable_kernel_rrsba(void)
> >  {
> > -	u64 ia32_cap;
> > +	if (rrsba_disabled)
> > +		return;
> > +
> > +	if (!(ia32_cap & ARCH_CAP_RRSBA)) {
> > +		rrsba_disabled = true;
> > +		return;
> > +	}
> 
> You'll take this path if you have out-of-date microcode.
> 
> RRSBA is only enumerated from September last year, IIRC.  (Definitely
> from this point on some CPUs.)
> 
> When RRSBA was introduced, I was under the (false) impression that all
> eIBRS systems suffered RRSBA, but it turns out that select parts
> (ICX,TGL,RKL) are non-RRSBA despite not having RRSBA_CTRL.

Hm, so the original code here had this problem too, right?

	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE) &&
	    !(x86_read_arch_cap_msr() & ARCH_CAP_RRSBA))
		return;

At this point I'm having a hard time caring about 7 months out-of-date
microcode, but is there a reasonable way to check for that?

-- 
Josh

