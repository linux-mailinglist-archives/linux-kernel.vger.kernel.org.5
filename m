Return-Path: <linux-kernel+bounces-86007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A9186BE64
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E89CE286993
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4292E40F;
	Thu, 29 Feb 2024 01:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FYVBmOLu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCE62C856
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709170769; cv=none; b=TSaAjlH1A3Q4KiIcv4fQz3Q/z9XRJN36pHLRoBOZfBSN7T/6Xy+6s3RsIHgcUzFkvCsiT873iByfN62PR3ZGRZ/7TqcZY8Zkg/OnI0i6lY+/5WgtinxTtGOw00O1TvxLo89pZRWPpF/eAeCcU3S4MHOrS7JrhF28ZU5esJo0vu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709170769; c=relaxed/simple;
	bh=Te/ym0F/L4+BIzQVM6AcrzTissbR9x1/wUhg7GZObjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlhrzZlXsjaRIzg1OwS334gldpnS3ZztDtImrSHSQh0mVszNi9cLQMdJxykBjTJqg88MbVzUZeumjCec1viipSTY1bryd8UxF0h0M2cxXm+UrIcR/7z7gjMSqNbkxrN4MtsNWOmTNkONdW++ixcJoyNTdmbwkL4MWeuXSpEId0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FYVBmOLu; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709170768; x=1740706768;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Te/ym0F/L4+BIzQVM6AcrzTissbR9x1/wUhg7GZObjM=;
  b=FYVBmOLuwDuHLMyMzb41P4dVCgPtC2397DiR92r1uOYUerwQ6bwCsjvJ
   5F3hWFuPWSKa+AYKZLgk8Vdxmpybqg4Cpx5nkSwAJjEhuETvc3yTjUlyy
   N/IpmS64CDQ5MQOJsFGkXvzT7gsss6jrsNmTDgQ9o9OP/bhma7zywGFat
   yuepQxfMlvEOQfdd6C+HZqahQmG4ByVgkn8BzJxWl2QMTGMruU+CggEA6
   n0TmjJKMHvIO/bZIYYzxNAYmscx2NxZaEfMNTnffVXSe9vyjLEfupqfgk
   b/kiPIZ73WLq0SCnHEz39ZnZPyahp00qN4WRpfUjUf44bQepUQfVLk2Js
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="4196284"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="4196284"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 17:39:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="7514126"
Received: from vabarca-mobl1.amr.corp.intel.com (HELO desk) ([10.209.19.138])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 17:39:26 -0800
Date: Wed, 28 Feb 2024 17:39:24 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Nikolay Borisov <nik.borisov@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/bugs: Use fixed addressing for VERW operand
Message-ID: <20240229013924.cksuxebpylyeymzo@desk>
References: <20240226-verw-arg-fix-v1-1-7b37ee6fd57d@linux.intel.com>
 <92440f47-21b7-4f4f-ad99-a99358cfbedf@suse.com>
 <373674e4-cbd0-44d7-98c7-304b0ab4f34b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <373674e4-cbd0-44d7-98c7-304b0ab4f34b@kernel.org>

On Tue, Feb 27, 2024 at 10:43:53AM +0100, Jiri Slaby wrote:
> On 27. 02. 24, 9:47, Nikolay Borisov wrote:
> > 
> > 
> > On 27.02.24 г. 1:52 ч., Pawan Gupta wrote:
> > > Macro used for MDS mitigation executes VERW with relative addressing for
> > > the operand. This is unnecessary and creates a problem for backports on
> > > older kernels that don't support relocations in alternatives. Relocation
> > > support was added by commit 270a69c4485d ("x86/alternative: Support
> > > relocations in alternatives"). Also asm for fixed addressing is much
> > > more cleaner than relative RIP addressing.
> > > 
> > > Simplify the asm by using fixed addressing for VERW operand.
> > > 
> > > Fixes: baf8361e5455 ("x86/bugs: Add asm helpers for executing VERW")
> > > Reported-by: Nikolay Borisov <nik.borisov@suse.com>
> > > Closes: https://lore.kernel.org/lkml/20558f89-299b-472e-9a96-171403a83bd6@suse.com/
> > > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > > ---
> > >   arch/x86/include/asm/nospec-branch.h | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/x86/include/asm/nospec-branch.h
> > > b/arch/x86/include/asm/nospec-branch.h
> > > index 2aa52cab1e46..ab19c7f1167b 100644
> > > --- a/arch/x86/include/asm/nospec-branch.h
> > > +++ b/arch/x86/include/asm/nospec-branch.h
> > > @@ -323,7 +323,7 @@
> > >    * Note: Only the memory operand variant of VERW clears the CPU
> > > buffers.
> > >    */
> > >   .macro CLEAR_CPU_BUFFERS
> > > -    ALTERNATIVE "", __stringify(verw _ASM_RIP(mds_verw_sel)),
> > > X86_FEATURE_CLEAR_CPU_BUF
> > > +    ALTERNATIVE "", __stringify(verw mds_verw_sel),
> > > X86_FEATURE_CLEAR_CPU_BUF
> > 
> > Actually thinking about it more and discussing with Jiri (cc'ed), will
> > this work with KASLR enabled?
> 
> I might of course be wrong. We appear to rely on the asm+linker here.

You were right, with KASLR enabled, instructions with fixed addressing
in alternatives don't get relocated. I guess we will have to keep
rip-relative as is. Thanks for catching that.

