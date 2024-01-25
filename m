Return-Path: <linux-kernel+bounces-38664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1FD83C3DA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7DA4290DF9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE9D55E57;
	Thu, 25 Jan 2024 13:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P1oWm1Og"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6483156466
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 13:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706189921; cv=none; b=pdBprvAG6O+s336q+P9lctAmM0El/tdMvCI+31jIzV1CoGRYN2WGUz0wKBvRzPFghp3FeNssOLzPnYDOnP9e2KV5EJ4dHCPJB6hCcQWbF3iU+JlJUTcehgnfc0sU3BpEyCceLBFCh/Y6c1hS/loSWXRA9d5bpUkKAlJe1+2CSoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706189921; c=relaxed/simple;
	bh=0KkKS2Lpl5mRNSE1P7HynJ6+LBCmeeLRI2yzv2QtUl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IT5YJaRXMVqvq3f34QQIJLYkHKOGh2zDWJVgBdaaFjm7RTib25LmXMKCODZ60kCIjqMZHqPAZ0OMGjO1vZMJ8QCNuXFXUJ7AGiB1DLd9WmJh1TdNvs2Tfad7KCWmyCTkItLBzzodJSUdYq9vRB9IMTgQCAIy6DdzLs76Yw7/nUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P1oWm1Og; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706189920; x=1737725920;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0KkKS2Lpl5mRNSE1P7HynJ6+LBCmeeLRI2yzv2QtUl8=;
  b=P1oWm1OgZF0SdKkZMmx00SttafHJx5S4yUuvSaZU2q1hHn8qdJXaEIdO
   D8gkHXSY2HsGdOPgIS5Fod1aNpqKZKkCMbMWm0FCoN9NGS4PAKa298ZMr
   SB7nyiY8sFzAVHPLdcAbhiQ9bcsOpFXaxNj2zvBV6euVk1jWvRfxnSGap
   0zmrSDL9ghMzDnRqqUGAf9wdmGxi0UYJ3FCOnb1F5zPW2e/7PFfHMxlZs
   uQNjAZ6K2QQYxhDbN1sxdYcqA/JcPxpR3RPrgcjr15fiPDxfIqBgN4x0x
   QXGXlXMQkvQD4mIFMsS0SUjP8IuhHvXc8aMo3qhHxH/26dgim94MUt/yG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="405911361"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="405911361"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 05:38:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="905962073"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="905962073"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 25 Jan 2024 05:38:21 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 2BF4876A; Thu, 25 Jan 2024 13:44:54 +0200 (EET)
Date: Thu, 25 Jan 2024 13:44:54 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Andi Kleen <ak@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Kai Huang <kai.huang@intel.com>, 
	Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCHv3, RESEND] x86/trampoline: Bypass compat mode in
 trampoline_start64() if not needed
Message-ID: <wo4wcvuhvqsqissocu7nz2urg5yt7mx65s5dxkjxqimgnxv3ax@qsa3lqlfsaxi>
References: <20240124131510.496803-1-kirill.shutemov@linux.intel.com>
 <ZbIwfp-jOOlPNb1z@tassilo>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbIwfp-jOOlPNb1z@tassilo>

On Thu, Jan 25, 2024 at 01:57:18AM -0800, Andi Kleen wrote:
> > +	/* Paging mode is correct proceed in 64-bit mode */
> > +
> > +	LOCK_AND_LOAD_REALMODE_ESP lock_rip=1
> > +
> > +	movw	$__KERNEL_DS, %dx
> > +	movl	%edx, %ss
> > +	addl	$pa_real_mode_base, %esp
> > +	movl	%edx, %ds
> > +	movl	%edx, %es
> > +	movl	%edx, %fs
> > +	movl	%edx, %gs
> > +
> > +	movl	$pa_trampoline_pgd, %eax
> > +	movq	%rax, %cr3
> > +
> > +	jmpq	*tr_start(%rip)
> 
> Still think we should add a far jump here so that we run on a defined
> code segment. It probably doesn't matter since there are likely no
> IRETs before reloading anyways, but it seems cleaner.

I think it is cleaner to switch to IRET here. Does this work for you?

diff --git a/arch/x86/realmode/rm/trampoline_64.S b/arch/x86/realmode/rm/trampoline_64.S
index 608f108cba7d..14d9c7daf90f 100644
--- a/arch/x86/realmode/rm/trampoline_64.S
+++ b/arch/x86/realmode/rm/trampoline_64.S
@@ -243,7 +243,9 @@ SYM_CODE_START(trampoline_start64)
 	movl	$pa_trampoline_pgd, %eax
 	movq	%rax, %cr3
 
-	jmpq	*tr_start(%rip)
+	pushq	$__KERNEL_CS
+	pushq	tr_start(%rip)
+	lretq
 .L_switch_paging:
 	/*
 	 * To switch between 4- and 5-level paging modes, it is necessary
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

