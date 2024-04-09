Return-Path: <linux-kernel+bounces-137081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C35E589DC1B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2316BB25EFC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FF912FF62;
	Tue,  9 Apr 2024 14:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ggNJCzxA"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2993085935
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 14:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712672548; cv=none; b=nWryxdIdXza2vmp6fGny9T76Hf76FSl3iP84S5WELKgJ/92rG/5KQ4xy3H1tSSjdtfUlx9P/f6MggSyW3P66i3Q9gH4j6AfZH6naAYJHhZBbCflq3ATVO0/8teSbdsjFTbCzk7XSgZYpG7okcR6LBgjbJYGCnqL3438fK/kUvwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712672548; c=relaxed/simple;
	bh=zqSRsfssEgGBYxYTJL13zKkEImkEMLvoC/JiWtFn3dU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n1qqBYhiTmY0WGbWh/+bwnyGc+AFJjFHJ4l/dsxlNfP8iY1y7sCnVNOkfP+5JmKLy3ny1Gx8JyVx8HOsR9eSW0VXHJTxkberStwre+CiH4YZoZfj9RBB2Wq2MMoJ6WWHB1ta+bahP/jVNz3wOK19p0/rzZ9JUeqlOCHYVGq1yOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ggNJCzxA; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1e2c0d3eadeso41293735ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 07:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712672546; x=1713277346; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rzf284ZBrPEw96jPmf6sJWqKEUO80DMFZq6QcuaB1j4=;
        b=ggNJCzxA72DZH7XuYO07RfOILbB60IzrZV3BNegAilGtOG8NtvrfEVUBdZYAGfeKMP
         rG4CLm0JVQvG/xdM1Y+Wb2b8OZiXR76f8FKAqbAi2+M9dSUDMclnB+9v4Gu4MkzH0F7g
         fMFnIe+y32tw808yg5L3CRAxaCy96yj9/hGRm0eufP1eMGgF0dU4O+UAPHHrTsVtZPOD
         ajRo+LYr/VS1E8xIuzYl7GEm2Qg3//IbTA7RdHGttjXv7ckkqQHJfn56gshbEw7Osjhz
         AGLwQ/jGw1qUW6C0kgi3V+3vftPyUAxA8LpZd4LqDvgmDPlUnKVq9zfifkVwH+UvZUOt
         RiRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712672546; x=1713277346;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rzf284ZBrPEw96jPmf6sJWqKEUO80DMFZq6QcuaB1j4=;
        b=Vz2CT8jQVa23kBclAiF0G87xjvlWWZ11Mej4Pn1MfGPufqM5zzwnJRVjYXju4Apyw8
         yAwZLU+UycHGHJJQ2sDkYjWIvPHr+cyH0jIpxcGG3ol5uz3u9iubc42obnshwqI/7CG9
         YG91a3R5lIDCu1BwTb9ekRStK6qHkWMAtNBZbAUzzVsCmhNSVHZlamJz9dhuybHEy7Gb
         lKR6mHkPoVji88q1+Gh97hCjMfL3udoZ1oywk5NjYsBzpaymSNJMNv8RkYfozqW4Ifdv
         CSoFU0pVqo+8IUx6JBE1pYAwxegGakqsisWTMrhh1vXuL1mDLFT75/HHbh79SIBeTh/x
         Ke7A==
X-Forwarded-Encrypted: i=1; AJvYcCVCGbXhy3QlVinwFfUNSo+xAa0TLjD2/hZ/zu3mmuA5ZGmftotJyGxPsecwkbdDbST+ODNF9QZQ2+e7XSeMcFBI4ay/4/Xd4vTtqvc0
X-Gm-Message-State: AOJu0YyWt2dLEDjI1ZoO/unDwZZzJgEjC3AavljSmoLComsyggz1+Em9
	dQk6mAUlxs13AG1TZiCgAHsOOVNEmgFfWTNfk1z4Xu280n9jSWQheb7O1LJm2mM0HUEOOoRoH9V
	/2w==
X-Google-Smtp-Source: AGHT+IFQbZfL17SFF2bj/UJ0pxxiOljLr4AR0LD/VuM1TYSQ/VvBmRf2Ryf8KUJHwwaq9RypgUOGlGE46Kc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e807:b0:1e2:588:b5bb with SMTP id
 u7-20020a170902e80700b001e20588b5bbmr693928plg.8.1712672545971; Tue, 09 Apr
 2024 07:22:25 -0700 (PDT)
Date: Tue, 9 Apr 2024 07:22:24 -0700
In-Reply-To: <20240409113010.465412-6-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com> <20240409113010.465412-6-kirill.shutemov@linux.intel.com>
Message-ID: <ZhVPIDDLkjOB96fI@google.com>
Subject: Re: [PATCHv10 05/18] x86/kexec: Keep CR4.MCE set during kexec for TDX guest
From: Sean Christopherson <seanjc@google.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Elena Reshetova <elena.reshetova@intel.com>, Jun Nakajima <jun.nakajima@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Kai Huang <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 09, 2024, Kirill A. Shutemov wrote:
> Depending on setup, TDX guests might be allowed to clear CR4.MCE.
> Attempt to clear it leads to #VE.
> 
> Use alternatives to keep the flag during kexec for TDX guests.
> 
> The change doesn't affect non-TDX-guest environments.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/kernel/relocate_kernel_64.S | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> index 56cab1bb25f5..8e2037d78a1f 100644
> --- a/arch/x86/kernel/relocate_kernel_64.S
> +++ b/arch/x86/kernel/relocate_kernel_64.S
> @@ -5,6 +5,8 @@
>   */
>  
>  #include <linux/linkage.h>
> +#include <linux/stringify.h>
> +#include <asm/alternative.h>
>  #include <asm/page_types.h>
>  #include <asm/kexec.h>
>  #include <asm/processor-flags.h>
> @@ -145,11 +147,17 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>  	 * Set cr4 to a known state:
>  	 *  - physical address extension enabled
>  	 *  - 5-level paging, if it was enabled before
> +	 *  - Machine check exception on TDX guest, if it was enabled before.
> +	 *    Clearing MCE might not allowed in TDX guests, depending on setup.
>  	 */
>  	movl	$X86_CR4_PAE, %eax
>  	testq	$X86_CR4_LA57, %r13
>  	jz	1f
>  	orl	$X86_CR4_LA57, %eax
> +1:
> +	testq	$X86_CR4_MCE, %r13
> +	jz	1f
> +	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %eax), X86_FEATURE_TDX_GUEST

The TEST+Jcc+OR sequences are rather odd, and require way more instructions and
thus way more copy+paste than is necessary.

	movl	$X86_CR4_LA57, %eax
	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %eax), X86_FEATURE_TDX_GUEST
	andl	%r13d, %eax
	orl	$X86_CR4_PAE, %eax
	movq	%rax, %cr4

Then preserving new bits unconditionally only requires adding the flag to the
initial move, and feature-dependent bits only need a single ALTERNATIVE line.

And there's no branches, blazing fast kexec! ;-)

