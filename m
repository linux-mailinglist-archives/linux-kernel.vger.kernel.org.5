Return-Path: <linux-kernel+bounces-82412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EBD8683D9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2685B23997
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012D91353E4;
	Mon, 26 Feb 2024 22:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PBcNA6wg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6001353E5;
	Mon, 26 Feb 2024 22:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708987075; cv=none; b=SNzHRDUQdcxEpVlpKkJD8sW0uuVNKI4Dk64BdKT+4PlLMxkB9vS0Doy0jtpiFDWgWK3DYngmDZJM7uACCZB6Gb+E1QLsL1Viq9M5rfV55jm+Itcq/3DqW4yxMygWgx5BMl6lMtqoqA3RA9cO6HiD7afhF6LCdd4J7TomEWX5V58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708987075; c=relaxed/simple;
	bh=0rIYe88dI3N1pVGDAqfPwwaB3U7qPp5hPB5M6me5YNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bkm39yPkv6nDZCR3FVds+sOrr7Nscp/8nnmwcxHU6AojzSLjNuJW7to3NnteS8sbAyBj9v9Gu0lYYaCBMTh4/VaSXD8jrd0fPkmJPiY2RpkoEZ4urSbN5MLhLjm4/eA2K7tRUryvCWUkzYLo7Wf4ruCTV5yEvB3vq49ATuc2508=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PBcNA6wg; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708987074; x=1740523074;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=0rIYe88dI3N1pVGDAqfPwwaB3U7qPp5hPB5M6me5YNc=;
  b=PBcNA6wgsHF3iX6HuyKfY0fzldXbnLC7kR5w080vjkNATSPWhfvWkJbE
   AC/PHt7q/7LNY7Bx3lu0wt/LMooNjYQCTwL/s2TwaewgJlR2tpw5yqPrs
   9s5KaKmOJadPfDHCd/dxi2ELj0BOYKgkh5LLiwQsQLAa6pazrprAnSOFg
   fWGzRohvu9Xyam3a9WhuGUvQhKBYHKj+e7d89VA6rBY+MQ+99fCYwYzQU
   LBQt72d15q1VqjZH7IPe5tAUZsQzs1Y7yMUV3BCL8VXzrEbLjb8I77I3x
   0EpZjD60bNPwUyPPBYw6UCnlsEPfZFWwX95V8Kiu1+dWc7Lvs9qJL+KVO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3231820"
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="3231820"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 14:37:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="11600427"
Received: from jhaqq-mobl1.amr.corp.intel.com (HELO desk) ([10.209.17.170])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 14:37:51 -0800
Date: Mon, 26 Feb 2024 14:37:49 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Alyssa Milburn <alyssa.milburn@intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/bugs: Add asm helpers for executing VERW
Message-ID: <20240226223749.ennx7llri7ffps77@desk>
References: <170839092792.398.3678407222202963581.tip-bot2@tip-bot2>
 <6380ba8d-4e99-46e6-8d92-911d10963ba7@suse.com>
 <20240226221059.mnuurhn6g3irys37@desk>
 <20558f89-299b-472e-9a96-171403a83bd6@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20558f89-299b-472e-9a96-171403a83bd6@suse.com>

On Tue, Feb 27, 2024 at 12:20:03AM +0200, Nikolay Borisov wrote:
> 
> 
> On 27.02.24 г. 0:10 ч., Pawan Gupta wrote:
> > On Mon, Feb 26, 2024 at 09:17:30AM +0200, Nikolay Borisov wrote:
> > > > diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> > > > index 262e655..077083e 100644
> > > > --- a/arch/x86/include/asm/nospec-branch.h
> > > > +++ b/arch/x86/include/asm/nospec-branch.h
> > > > @@ -315,6 +315,17 @@
> > > >    #endif
> > > >    .endm
> > > > +/*
> > > > + * Macro to execute VERW instruction that mitigate transient data sampling
> > > > + * attacks such as MDS. On affected systems a microcode update overloaded VERW
> > > > + * instruction to also clear the CPU buffers. VERW clobbers CFLAGS.ZF.
> > > > + *
> > > > + * Note: Only the memory operand variant of VERW clears the CPU buffers.
> > > > + */
> > > > +.macro CLEAR_CPU_BUFFERS
> > > > +	ALTERNATIVE "", __stringify(verw _ASM_RIP(mds_verw_sel)), X86_FEATURE_CLEAR_CPU_BUF
> > > 
> > > Any particular reason why this uses RIP-relative vs an absolute address
> > > mode?
> > 
> > Early versions of the series had the VERW arg pointing to the macro
> > itself, that is why relative addressing was used. That got changed in a
> > later version with all VERW sites pointing to a single memory location.
> > 
> > > I know in our private exchange you said there is no significance but
> > > for example older kernels have a missing relocation support in alternatives.
> > > This of course can be worked around by slightly changing the logic of the
> > > macro which means different kernels will have slightly different macros.
> > 
> > Do you anticipate a problem with that? If yes, I can send a patch to use
> > fixed addressing in upstream as well.
> 
> I experienced crashes on older kernels before realizing that the relocation
> wasn't resolved correctly by the alternative framework. Instead i simply
> changed the macro to jmp 1f, where the next instruction is the verw ( I did
> send a backport for 5.4) and it works. Recently there's been a push to make
> as much of the kernel assembly as possible PIC so having a rip-relative
> addressing helps. Whether that makes any material difference - I cannot say.

Ok, sending the patch.

> Here's my backport version for reference:
> 
> https://lore.kernel.org/stable/20240226122237.198921-3-nik.borisov@suse.com/

Below should also solve the problem with less churn:

---
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 2aa52cab1e46..ab19c7f1167b 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -323,7 +323,7 @@
  * Note: Only the memory operand variant of VERW clears the CPU buffers.
  */
 .macro CLEAR_CPU_BUFFERS
-	ALTERNATIVE "", __stringify(verw _ASM_RIP(mds_verw_sel)), X86_FEATURE_CLEAR_CPU_BUF
+	ALTERNATIVE "", __stringify(verw mds_verw_sel), X86_FEATURE_CLEAR_CPU_BUF
 .endm
 
 #else /* __ASSEMBLY__ */

