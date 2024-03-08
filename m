Return-Path: <linux-kernel+bounces-97447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B7D876AAA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8693CB21852
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132765646E;
	Fri,  8 Mar 2024 18:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EgR/AB14"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD07822086
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 18:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709921920; cv=none; b=faokwfg2KjbbjtJDZ8qjWaG8FJ7RCSYmYUPQIfkVYZaKJfsQLpkWiDwmfMen4geLucY+pO6jGDz0b9YjIFm52nREUxUdO8CL+3UXI7tw8WVW57qeLulkfzTy8xfjN7XZisdNvvWjA/WsUmTkjxOntmBiY6JGn7D0jBWOyPZemh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709921920; c=relaxed/simple;
	bh=gq7+JjRtDe8WuE7Xt3z4Svy36SZ/wWjmXmaR0mY39+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pas6ryLlrmI32X2UecXGhh0d0kF+txNTTptpFA79H73zM35rkMnaCqXQArNO7IDVuMRixZmEXvg3pqDQBfo02b7yRqpNlJ976ifdr1m1ESlOGvF/rvgiCshOR9Jy24fQ68vT2gLjS2pGGjoR7NG6BEJLN0HVm0roHy1Jce/B+aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EgR/AB14; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709921918; x=1741457918;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gq7+JjRtDe8WuE7Xt3z4Svy36SZ/wWjmXmaR0mY39+I=;
  b=EgR/AB14dvuvFgi3cuUThdUrd1PVLudfRD2rSZz4Sm9GdVC2ucUwpgXU
   G+VEgMRE1REakXZu7Is+rBZyTGlXM4IHEYTrzwBIXiLE1GNPAoBnTl6q/
   S2nZCkMJ/ufrgDeQCOIA2vq4ViZg3RYNZw3tD0p3goSKG/ZN+Q1q4vLCu
   yeAAvwuZr4Ro6YGBPez79wHVHreyl7ATEdndiZhUfHdm8y3kaaHDqWi2c
   koCdLf3QQQJoDevsAf+JPYM2lxF1Caf17o6ZD82ySEcGPbTigXTvRzCCE
   RYb3uCWqYI7h0dkP/X4OGop5kH5cxViypO006jIUIIGdeqvv6pJ5O6T/j
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11007"; a="4497604"
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="4497604"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 10:18:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11007"; a="937047748"
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="937047748"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Mar 2024 10:18:29 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 9D04D1F1; Fri,  8 Mar 2024 20:18:28 +0200 (EET)
Date: Fri, 8 Mar 2024 20:18:28 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, the arch/x86 maintainers <x86@kernel.org>, linux-mm@kvack.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/3] x86/mm: make sure LAM is up-to-date during
 context switching
Message-ID: <cbxzo4e3zkr5pxxr4e2hualiucqudsizr2bmxgh3rr7yagcazd@fer5qemogcls>
References: <20240307133916.3782068-1-yosryahmed@google.com>
 <20240307133916.3782068-3-yosryahmed@google.com>
 <420fcb06-c3c3-4e8f-a82d-be2fb2ef444d@app.fastmail.com>
 <35b670e2-9ef5-4d3a-b6ea-f8016dfa088d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35b670e2-9ef5-4d3a-b6ea-f8016dfa088d@intel.com>

On Fri, Mar 08, 2024 at 07:23:58AM -0800, Dave Hansen wrote:
> On 3/7/24 17:34, Andy Lutomirski wrote:
> >> Fix this by making sure we write a new CR3 if LAM is not
> >> up-to-date. No problems were observed in practice, this was found
> >> by code inspection.
> > I think it should be fixed with a much bigger hammer: explicit IPIs.
> > Just don't ever let it get out of date, like install_ldt().
> I guess it matters whether the thing that matters is having a persistent
> inconsistency or a temporary one.  IPIs will definitely turn a permanent
> one into a temporary one.
> 
> But this is all easier to reason about if we can get rid of even the
> temporary inconsistency.
> 
> Wouldn't this be even simpler than IPIs?
> 
> static inline unsigned long set_tlbstate_lam_mode(struct mm_struct *mm)
> {
> 	unsigned long lam = READ_ONCE(mm->context.lam_cr3_mask);
> 
> +	/* LAM is for userspace only.  Ignore it for kernel threads: */
> +	if (tsk->flags & PF_KTHREAD)
> +		return 0;

I like this approach. kthread_use_mm() WARNs if it called for
non-PF_KTHREAD task, so it should be okay.

I was worried that it would also exclude io_uring, but worker threads
don't have the flag set.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

