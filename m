Return-Path: <linux-kernel+bounces-38346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E4983BE1B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBDDE1F25E0B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22351C6AD;
	Thu, 25 Jan 2024 09:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OSdk7Bne"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D221C696
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706176641; cv=none; b=X9vHjZb2edKoWhan72q5Re10SOc9d04ZWeyZSeWfFIVASkzwbrkLWp535x5vz342o0CG99iyl3RF9EIOzafo94/NQk/fQVIpicQxUPH6knhf9HssuAlVHR5qpDMoMHNahg7V0fJCoCBdvTDaHkwi4PDZn7DxF1ZcB8YMQVjM5ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706176641; c=relaxed/simple;
	bh=GCTjaxAzQpiJeogtIM7YnckgDznFssj6Z9QaoT8dp7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ce+C7WMCNXZ+DnYg+DCY62SmL034EqAtOlD6cmNg0u7VJb9xQSrY6HwEQOtPd7+RRwOq+mZR5Vwt8v3Yx+uJjhvzz2bBssiHnfyTUYKYn47HbwqtjT9IeoxPQWtt0QLeYJPB7zAbc0IPP+FYMiEIu/wai1ZLq/1DzdPlXBZUJvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OSdk7Bne; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706176640; x=1737712640;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GCTjaxAzQpiJeogtIM7YnckgDznFssj6Z9QaoT8dp7E=;
  b=OSdk7BnecvXacXgED+3Z0PWZ8dipZUgvljSL1NiyIC9TI7jXpJF5zqZ8
   +y0OD3gmcFXSbqFci6tlgVQSt7/rWDoDdhPziwK+paeNqz1INQX82ordE
   08xHV6RyBMnecOpFlL/EYjQA6HhdPelFt5DYizmlqz0scsw/nlkTOCbuA
   CKd9Uf1nxWT2e3QmtCuln0TYMJriIHivsk/Ndasz/eRt+SRRakGGndpDx
   o74iVdj70PfqPBwWjU78z0LoiPIOo1xPDjj5i4wdnmlHI+bgFA1/Iq2mD
   52s12wLAJdNYAHc6GgxaoCrAWDY1n0RcKXFzIzROt2SU6BgUDuqmb0U4I
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="8771467"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="8771467"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 01:57:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="28427016"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 01:57:19 -0800
Date: Thu, 25 Jan 2024 01:57:18 -0800
From: Andi Kleen <ak@linux.intel.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	Kai Huang <kai.huang@intel.com>,
	Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCHv3, RESEND] x86/trampoline: Bypass compat mode in
 trampoline_start64() if not needed
Message-ID: <ZbIwfp-jOOlPNb1z@tassilo>
References: <20240124131510.496803-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124131510.496803-1-kirill.shutemov@linux.intel.com>

> +	/* Paging mode is correct proceed in 64-bit mode */
> +
> +	LOCK_AND_LOAD_REALMODE_ESP lock_rip=1
> +
> +	movw	$__KERNEL_DS, %dx
> +	movl	%edx, %ss
> +	addl	$pa_real_mode_base, %esp
> +	movl	%edx, %ds
> +	movl	%edx, %es
> +	movl	%edx, %fs
> +	movl	%edx, %gs
> +
> +	movl	$pa_trampoline_pgd, %eax
> +	movq	%rax, %cr3
> +
> +	jmpq	*tr_start(%rip)

Still think we should add a far jump here so that we run on a defined
code segment. It probably doesn't matter since there are likely no
IRETs before reloading anyways, but it seems cleaner.

-Andi


