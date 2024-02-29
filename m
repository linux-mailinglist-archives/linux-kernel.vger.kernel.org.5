Return-Path: <linux-kernel+bounces-86441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C77FC86C560
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10D07B23866
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB975E22B;
	Thu, 29 Feb 2024 09:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KeS6W0EW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7557A5DF2E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709199267; cv=none; b=q1T9/9f+nab8B/JNTbt3jVhph8wrAoYRdZqpddkukxIqg0vEi5/kUTCVfA2zWSYvTGtEq5ofTyGPbECibV7/mUow4Y8cAPvk4FfjVraigh3rkxu7U9sHsQJTpmts7IDwO773DIDvPZSzbJOqrOqsPCozGoA3WNMl4yQ/dZkxQNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709199267; c=relaxed/simple;
	bh=StLx1U6ANyaxhU7Kg8zvsXAct3f95Q4ofWakuARJ13s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=StBM0GmssEfh9X32ekYGdvm/s+9EBrWAkVADQ/v6aCytsgND1CBjFkSxmm0GwKaj8AWVZdOD2C50MRjUVf4bGpaCkjNN3lQN6zMhVcGrPdVLujRYYmfLaVCzPdD2o2/l40PMt4KlJ/iqAZ8ej/tpWG+61R0MMv14zTvbdeuGlps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KeS6W0EW; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709199265; x=1740735265;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=StLx1U6ANyaxhU7Kg8zvsXAct3f95Q4ofWakuARJ13s=;
  b=KeS6W0EWE1C98iwWoPRjrJa/26gDnTv1YQoIPumF5hb3yNM4OkCrf02t
   e9uZQZ8JnRD8MInrQjsjImuhqksCeiN3/UbyGtViycKAqjQ+UcdhTLR+P
   RyW9VnVioi77J5B/Po+EPA7Qy8LaNeaCxDGCX0OWrIsBdleGJ1jLAILIY
   SdE7S0xsobt+JI6WHGrbiWrhxR1cpCu/JhTas8U04wkEceZvBCc4V5boR
   UcGxvmrEetkcPJAWOiU3UgKx3la/RwAr6Cv66eprbOEphjRaKPMsznbol
   ibjV/LUVqgRuOS1LLG8HNwsA+Za7WsJ0WmhfLOQ/llKPAbvLQ3HTPfdnA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="15069949"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="15069949"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 01:34:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="30944373"
Received: from vyalavar-mobl1.amr.corp.intel.com (HELO desk) ([10.209.79.44])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 01:34:20 -0800
Date: Thu, 29 Feb 2024 01:34:16 -0800
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
Message-ID: <20240229093416.ubabob5aykjgh47l@desk>
References: <20240226-verw-arg-fix-v1-1-7b37ee6fd57d@linux.intel.com>
 <92440f47-21b7-4f4f-ad99-a99358cfbedf@suse.com>
 <373674e4-cbd0-44d7-98c7-304b0ab4f34b@kernel.org>
 <20240229013924.cksuxebpylyeymzo@desk>
 <20240229091428.lnbcvhm3udzl5jd5@desk>
 <28205b59-50b8-4e05-b267-503179156431@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28205b59-50b8-4e05-b267-503179156431@kernel.org>

On Thu, Feb 29, 2024 at 10:19:09AM +0100, Jiri Slaby wrote:
> On 29. 02. 24, 10:14, Pawan Gupta wrote:
> > On Wed, Feb 28, 2024 at 05:39:27PM -0800, Pawan Gupta wrote:
> > > On Tue, Feb 27, 2024 at 10:43:53AM +0100, Jiri Slaby wrote:
> > > > On 27. 02. 24, 9:47, Nikolay Borisov wrote:
> > > > > 
> > > > > 
> > > > > On 27.02.24 г. 1:52 ч., Pawan Gupta wrote:
> > > > > > Macro used for MDS mitigation executes VERW with relative addressing for
> > > > > > the operand. This is unnecessary and creates a problem for backports on
> > > > > > older kernels that don't support relocations in alternatives. Relocation
> > > > > > support was added by commit 270a69c4485d ("x86/alternative: Support
> > > > > > relocations in alternatives"). Also asm for fixed addressing is much
> > > > > > more cleaner than relative RIP addressing.
> > > > > > 
> > > > > > Simplify the asm by using fixed addressing for VERW operand.
> > > > > > 
> > > > > > Fixes: baf8361e5455 ("x86/bugs: Add asm helpers for executing VERW")
> > > > > > Reported-by: Nikolay Borisov <nik.borisov@suse.com>
> > > > > > Closes: https://lore.kernel.org/lkml/20558f89-299b-472e-9a96-171403a83bd6@suse.com/
> > > > > > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > > > > > ---
> > > > > >    arch/x86/include/asm/nospec-branch.h | 2 +-
> > > > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/arch/x86/include/asm/nospec-branch.h
> > > > > > b/arch/x86/include/asm/nospec-branch.h
> > > > > > index 2aa52cab1e46..ab19c7f1167b 100644
> > > > > > --- a/arch/x86/include/asm/nospec-branch.h
> > > > > > +++ b/arch/x86/include/asm/nospec-branch.h
> > > > > > @@ -323,7 +323,7 @@
> > > > > >     * Note: Only the memory operand variant of VERW clears the CPU
> > > > > > buffers.
> > > > > >     */
> > > > > >    .macro CLEAR_CPU_BUFFERS
> > > > > > -    ALTERNATIVE "", __stringify(verw _ASM_RIP(mds_verw_sel)),
> > > > > > X86_FEATURE_CLEAR_CPU_BUF
> > > > > > +    ALTERNATIVE "", __stringify(verw mds_verw_sel),
> > > > > > X86_FEATURE_CLEAR_CPU_BUF
> > > > > 
> > > > > Actually thinking about it more and discussing with Jiri (cc'ed), will
> > > > > this work with KASLR enabled?
> > > > 
> > > > I might of course be wrong. We appear to rely on the asm+linker here.
> > > 
> > > You were right, with KASLR enabled, instructions with fixed addressing
> > > in alternatives don't get relocated. I guess we will have to keep
> > > rip-relative as is. Thanks for catching that.
> > 
> > Looks like this is not settled yet, it was naive of me to trust gdb on
> > /proc/kcore earlier with KASLR enabled.
> > 
> > With the below debug patch it appears the relocation with fixed
> > addresses is working as expected with KASLR enabled.
> 
> As I wrote already, asm+linker converts the fixed address to rip-rela
> anyway:
> 
> https://lore.kernel.org/all/fd8f2df0-563e-4f5c-aca4-bc92a14e9426@kernel.org/
> 
> I also raised questions in there:
> ====
> The assembler generates a relocation for the fixed address anyway. And
> the linker resolves it as rip-relative. At least the pair from my
> binutils-2.42.
> 
> But if it generates a rip-relative address, is < 6.5 with no support of
> rip-rel in alternatives still fine?

In that case backports < 6.5 can do:

+.macro CLEAR_CPU_BUFFERS
+	ALTERNATIVE "jmp .Lskip_verw_\@", "", X86_FEATURE_CLEAR_CPU_BUF
+	verw _ASM_RIP(mds_verw_sel)
+.Lskip_verw_\@:
+.endm

As done in Nikolay's 5.4 backport:

https://lore.kernel.org/stable/20240226122237.198921-3-nik.borisov@suse.com/

> Another question: can we rely on the assembler to generate a relocation
> and on the linker to resolve it as rip-relative?

This is definitely not my area of expertise, but with the above approach
VERW should be inlined always, and rip-relative should be resolved as
with any other instruction.

