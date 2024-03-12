Return-Path: <linux-kernel+bounces-100263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D4687943C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BACE61C231C5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C88056450;
	Tue, 12 Mar 2024 12:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ub5jhZKg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1373811
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 12:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710246953; cv=none; b=Ef41JX2x+TqyHF8AmRKLGFwO+kGOmi9lSYnLHXAESPCAt+Eu+nI9uSYsBN3x+jluW87eE0A42AiBNhJzGq2TifvfJBRIU/bnwi77ENLWb13uoNelOW46fS+sGy4dbidAVIG3DYIneW89RDSRCfx0aeqIc9LToYDvORnFRzGhgDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710246953; c=relaxed/simple;
	bh=qYQ0JG/iS1IbYFpGyQjCg6wBVOUOXL3yCkQafpIV1Eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYFoc5C99p5UF5rRGOnj1m777x0vc6O/ld9vNC95PdZ1QUIr3AISdUYTukjDgoBxxggk72EzRL8CKB33bP62oSq/mBqk6mFac87cDh3TV+EK/LP/9ArNBMuu/Vwm5pHvk8Vobq2kTtpdgIdqrxhETKVeCJtRvwGjplTaezZp5Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ub5jhZKg; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710246952; x=1741782952;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qYQ0JG/iS1IbYFpGyQjCg6wBVOUOXL3yCkQafpIV1Eg=;
  b=Ub5jhZKgntWjVim1zM4rlmVOMeAsrnB7q63Tkl/r+p6S2vhAa4/AyZPW
   Af8rZPSfUTh4iUw3w3ZPW47NeGChYUh956A76v+zGo0K8um6cglmcJpoC
   U92CimqcTgubEzqOQzNKemQRUIXD69msBWpkLUfJVpvIbElkX1QrRJhry
   MNeeIrp01tVUTaLlEcwQrNKnD4aeOYDquR+L2R7S18CLCxIjkqlRhyy0F
   eezLWj+MSs2VBNvqxShRtEtxwoKMgHSPs1sIa+Df8N77eLATSiASBhgRj
   1dTyoEtIuxyDe6aUOjdgfuNmMt1K0Ld5ibbNc36t00wpZZNA6P3FcimKd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="4823961"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="4823961"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 05:35:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="937051832"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="937051832"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Mar 2024 05:35:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id AD4CA27D; Tue, 12 Mar 2024 14:35:46 +0200 (EET)
Date: Tue, 12 Mar 2024 14:35:46 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] x86/mm: Fix LAM inconsistency during context switch
Message-ID: <3a56vovcqy7ju5og76nqlekfruq42i56wmp4oek3jgkffvzjby@q5guufebkpzr>
References: <20240312035951.3535980-1-yosryahmed@google.com>
 <20240312035951.3535980-2-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312035951.3535980-2-yosryahmed@google.com>

On Tue, Mar 12, 2024 at 03:59:50AM +0000, Yosry Ahmed wrote:
> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> index 76e91fc68c5f3..748d2b3bdb985 100644
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -753,10 +753,12 @@ static long prctl_map_vdso(const struct vdso_image *image, unsigned long addr)
>  static void enable_lam_func(void *__mm)
>  {
>  	struct mm_struct *mm = __mm;
> +	unsigned long lam = mm_lam_cr3_mask(mm);
> +	u64 untag_mask = mm_untag_mask(mm);
>  

Maybe push these mm dereferences inside the if block below?
I am not sure if compiler can re-order operations past this_cpu_read().

>  	if (this_cpu_read(cpu_tlbstate.loaded_mm) == mm) {
> -		write_cr3(__read_cr3() | mm->context.lam_cr3_mask);
> -		set_tlbstate_lam_mode(mm);
> +		write_cr3(__read_cr3() | lam);
> +		cpu_tlbstate_update_lam(lam, untag_mask);
>  	}
>  }
>  

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

