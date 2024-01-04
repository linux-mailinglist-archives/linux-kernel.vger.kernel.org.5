Return-Path: <linux-kernel+bounces-17341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8A8824BF1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 00:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 785891F264E0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 23:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051892D615;
	Thu,  4 Jan 2024 23:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="egS53Q1X"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A986D2D605
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 23:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704412329; x=1735948329;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9nqtjCjKM0cfwvjSbln5H9YEhguoQMEUM2RClN0EhKc=;
  b=egS53Q1Xy+VNhsLEE6yPv7N01ZF0TnYXCQjaVHCSCsuVyiUJ54jp0xkp
   iesbEja+uMhXc6Le29cCii5lEYYZ1X1HtUMqAL9DCb3J78/34QC8fhERO
   Q/C7if+yf7B3Lm8s4LD3tRWC3jbVh+9+V5shAaCO1gS59TXkRraKJWnCx
   TK/iCDW3h056mGtqzZohycdNOzItmE4Nzt2meTHMZo7FWzNC/Acu0QGaU
   DFtC16FTDKQBA+AwI+5U5QyjvxlMhRHcbBaypnsYyW6ptj8YCryljjgEg
   lF2aQgB08q+fT1X8SiuKMsSwi8YTZRiM4U4KAudxFKiKWAXWVqpXmgD4U
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="387843323"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="387843323"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 15:52:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="784045461"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="784045461"
Received: from dekblom-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.36.199])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 15:52:04 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 71EEB10A57C; Fri,  5 Jan 2024 02:52:01 +0300 (+03)
Date: Fri, 5 Jan 2024 02:52:01 +0300
From: kirill.shutemov@linux.intel.com
To: Kai Huang <kai.huang@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, dave.hansen@intel.com,
	tglx@linutronix.de, bp@alien8.de, mingo@redhat.com,
	peterz@infradead.org, rafael@kernel.org, dan.j.williams@intel.com,
	hpa@zytor.com, geert@linux-m68k.org, bhe@redhat.com,
	akpm@linux-foundation.org, rppt@kernel.org, frederic@kernel.org,
	dave.jiang@intel.com, xin3.li@intel.com, rick.p.edgecombe@intel.com,
	isaku.yamahata@intel.com, yuan.yao@intel.com
Subject: Re: [PATCH] x86/asm: Remove the __iomem annotation of movdir64b()'s
 dst argument
Message-ID: <20240104235201.hzv2kb7vxocs3asx@box>
References: <20240104221219.572258-1-kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104221219.572258-1-kai.huang@intel.com>

On Fri, Jan 05, 2024 at 11:12:19AM +1300, Kai Huang wrote:
> Commit e56d28df2f66 ("x86/virt/tdx: Configure global KeyID on all
> packages") causes below sparse check warning:
> 
>   arch/x86/virt/vmx/tdx/tdx.c:683:27: warning: incorrect type in argument 1 (different address spaces)
>   arch/x86/virt/vmx/tdx/tdx.c:683:27:    expected void [noderef] __iomem *dst
>   arch/x86/virt/vmx/tdx/tdx.c:683:27:    got void *
> 
> The reason is TDX must use the MOVDIR64B instruction to convert TDX
> private memory (which is normal RAM but not MMIO) back to normal.  The
> TDX code uses existing movdir64b() helper to do that, but the first
> argument @dst of movdir64b() is annotated with __iomem.
> 
> When movdir64b() was firstly introduced in commit 0888e1030d3e
> ("x86/asm: Carve out a generic movdir64b() helper for general usage"),
> it didn't have the __iomem annotation.  But this commit also introduced
> the same "incorrect type" sparse warning because the iosubmit_cmds512(),
> which was the solo caller of movdir64b(), has the __iomem annotation.
> 
> This was later fixed by commit 6ae58d871319 ("x86/asm: Annotate
> movdir64b()'s dst argument with __iomem").  That fix was reasonable
> because until TDX code the movdir64b() was only used to move data to
> MMIO location, as described by the commit message:
> 
>   ... The current usages send a 64-bytes command descriptor to an MMIO
>   location (portal) on a device for consumption. When future usages for
>   the MOVDIR64B instruction warrant a separate variant of a memory to
>   memory operation, the argument annotation can be revisited.
> 
> Now TDX code uses MOVDIR64B to move data to normal memory so it's time
> to revisit.
> 
> The SDM says the destination of MOVDIR64B is "memory location specified
> in a general register", thus it's more reasonable that movdir64b() does
> not have the __iomem annotation on the @dst.
> 
> Remove the __iomem annotation from the @dst argument of movdir64b() to
> fix the sparse warning in TDX code.  Similar to memset_io(), introduce a
> new movdir64b_io() to cover the case where the destination is an MMIO
> location, and change the solo caller iosubmit_cmds512() to use the new
> movdir64b_io().
> 
> In movdir64b_io() explicitly use __force in the type casting otherwise
> there will be below sparse warning:
> 
>   warning: cast removes address space '__iomem' of expression
> 
> Fixes: e56d28df2f66 ("x86/virt/tdx: Configure global KeyID on all packages")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312311924.tGjsBIQD-lkp@intel.com/
> Signed-off-by: Kai Huang <kai.huang@intel.com>

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

