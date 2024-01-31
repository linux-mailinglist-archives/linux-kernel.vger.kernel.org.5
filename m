Return-Path: <linux-kernel+bounces-45989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 630708438D4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 642BC1C26402
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9411B58AA0;
	Wed, 31 Jan 2024 08:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FZfkbxbO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883015788C
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706689462; cv=none; b=lm+YRXjfd57ML8OHG90FGqA3u8glSlEGERRXTqAsMYRFV6hGvohtvEKsa9edYI44Hc0Li0JL4yLe4dIaHy5xM6i8I2XbSoEn5ICCk2x4flY3rpDkNJ+vLsujCgS2ZD+2kPmcsbodvTf77Svrkpt5H6UBiIuEKoj9LTbIbxSEoLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706689462; c=relaxed/simple;
	bh=p2eNGaNPy/qRkXoqrBMs9FtoycBXq4Fa+3HgEddDlkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3G0PLr6aMnYTqKlWC4YO3yKPiDvOWMgCv3EhJ4WaeMjgg4GGgpsrjr6JQ9RRvW8zI/Aopuv1uR1aBzk3CPkE1tlyadhmIZ6AueYKmyk/r7HxfELG6o+sOMl9/89HFmDzwP8QKMAzetnN6ki+IN3sz5IOH9jUxS1nPbVOBtfun4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FZfkbxbO; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706689462; x=1738225462;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p2eNGaNPy/qRkXoqrBMs9FtoycBXq4Fa+3HgEddDlkA=;
  b=FZfkbxbOavkUx128m/D5r0K+l/rO3y21VAcS4rNE/X0i7aFp3N6GZccn
   hg9J8bkS75rPBg8DTgYX9fClcB0CcO3988dmUM8rtqCWHLrvzYc987O/Z
   DbI2Ax2RWajn3PwsgVuKyAQS3pKuZp/8r/sZ02hWXhjFfMGJxstx4Q+Fk
   XkRzZOJALflxxbGXZ6p0b863Hn4syY+HrciqqyCjmgka2d5Br6uzHtS9M
   tqwaJFjF0UV794G3//ejVzW2XRb/lxDfsgvs3xJ57/XLdhV0IFqyDcWK0
   aetcUvub3zIV6GRa200T73AQ/6tZkig0lT+1wWXkCO1UDeaLX3De1G0LB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3399896"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="3399896"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 00:24:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="911715756"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="911715756"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 31 Jan 2024 00:24:15 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 6D2A42D5; Wed, 31 Jan 2024 10:22:52 +0200 (EET)
Date: Wed, 31 Jan 2024 10:22:52 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Kevin Loughlin <kevinloughlin@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Pankaj Gupta <pankaj.gupta@amd.com>, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Dionna Glaze <dionnaglaze@google.com>, Brijesh Singh <brijesh.singh@amd.com>, 
	Michael Roth <michael.roth@amd.com>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-coco@lists.linux.dev, Ashish Kalra <ashish.kalra@amd.com>, 
	Andi Kleen <ak@linux.intel.com>, Adam Dunlap <acdunlap@google.com>, 
	Peter Gonda <pgonda@google.com>, Jacob Xu <jacobhxu@google.com>, 
	Sidharth Telang <sidtelang@google.com>
Subject: Re: [PATCH v3 2/2] x86/head64: Replace pointer fixups with
 RIP_RELATIVE_ADDR()
Message-ID: <sx3i6e6rgggh6wxtqt6odvwubg5vqotfleyjditiicjvjgpf6r@bswwhdt6zzti>
References: <20240121182040.GBZa1geI5NxWSslvt0@fat_crate.local>
 <20240130220845.1978329-3-kevinloughlin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130220845.1978329-3-kevinloughlin@google.com>

On Tue, Jan 30, 2024 at 10:08:45PM +0000, Kevin Loughlin wrote:
> @@ -594,15 +579,15 @@ static void set_bringup_idt_handler(gate_desc *idt, int n, void *handler)
>  /* This runs while still in the direct mapping */
>  static void __head startup_64_load_idt(unsigned long physbase)
>  {
> -	struct desc_ptr *desc = fixup_pointer(&bringup_idt_descr, physbase);
> -	gate_desc *idt = fixup_pointer(bringup_idt_table, physbase);
> +	struct desc_ptr *desc = RIP_RELATIVE_ADDR(bringup_idt_descr);
> +	gate_desc *idt = RIP_RELATIVE_ADDR(bringup_idt_table);
>  
>  
>  	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
>  		void *handler;
>  
>  		/* VMM Communication Exception */
> -		handler = fixup_pointer(vc_no_ghcb, physbase);
> +		handler = RIP_RELATIVE_ADDR(vc_no_ghcb);
>  		set_bringup_idt_handler(idt, X86_TRAP_VC, handler);
>  	}
>  

Looks like you removed all physbase users in the function. No need to pass
it to it.

> @@ -629,7 +614,7 @@ void early_setup_idt(void)
>  void __head startup_64_setup_env(unsigned long physbase)
>  {
>  	/* Load GDT */
> -	startup_gdt_descr.address = (unsigned long)fixup_pointer(startup_gdt, physbase);
> +	startup_gdt_descr.address = (unsigned long)RIP_RELATIVE_ADDR(startup_gdt);
>  	native_load_gdt(&startup_gdt_descr);
>  
>  	/* New GDT is live - reload data segment registers */

With startup_64_load_idt() fixed, no users for physbase in this function
either.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

