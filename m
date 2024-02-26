Return-Path: <linux-kernel+bounces-82381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDFB868380
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A45B1C22BE7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4C6131E3A;
	Mon, 26 Feb 2024 22:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VEam6rVe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B788F1EA72;
	Mon, 26 Feb 2024 22:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708985466; cv=none; b=c0fJ/n28epG+nEwlSjxFWj/EdWCTEe3TIKPqs7hBlQu6ObqJD8RShDKElQ/O+R2ijQS9Dbq91hU45hU/zotKpEwl0tnsLFqSQ0dMVap3G0UgR9MRuct9/15O2fB03xCwYowptJFyG868B93E61ToQp0cvBZcZMT5hSwrtwAlUFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708985466; c=relaxed/simple;
	bh=aLP1wrwgND98W3fl2x4ZMt1cA9P2D4b6s5545BhBdRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNPrDHLktTqjVN/SiYOeu/Rh3DWE6mfsz6u92e5USIS6aP3F7X1ag8135mAqxfUtCPYTi9o6uQ88t5DOQpOD39/qi7nx/I93fc7fwXXAqXC1vLKQ1ZFvK8be4gfV8oPorQ5O5dlUgjca3BDWNCxk9iDp3nZn26VVv2dj008ycQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VEam6rVe; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708985462; x=1740521462;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aLP1wrwgND98W3fl2x4ZMt1cA9P2D4b6s5545BhBdRA=;
  b=VEam6rVeShjbXNBpnszmCLS6L6xle8F8d5BZfdr52JMlVNRATnb+Z2th
   9nUB5vnyZ2HtpWbN2cnPcE52ypjH/fZVyfNKNCwbWFqtVk8ISGQ7V8Mrp
   GGP6huu9xDe1aDo+nkt9x2ukQ82lZzQCyWZOjF+y4/XP1D+9IWwudoCkR
   9rD9Vt7tLJq9H3w5N/20p8Qa663Ac8DCOeRVoljk3TOkePbkjDKDHyf9W
   ah3Jta+tCkNHyDWFmMSDMQIDKltraul9gN7lxvi74i8TKHrPaLCcDvMhu
   iyixFxJjfCJHTunmdNIs34K2XnnEZmHlTrbAGpLYEupxrQq4cLSZ5ASKU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="7119032"
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="7119032"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 14:11:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="11596128"
Received: from jhaqq-mobl1.amr.corp.intel.com (HELO desk) ([10.209.17.170])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 14:11:01 -0800
Date: Mon, 26 Feb 2024 14:10:59 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Alyssa Milburn <alyssa.milburn@intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/bugs: Add asm helpers for executing VERW
Message-ID: <20240226221059.mnuurhn6g3irys37@desk>
References: <170839092792.398.3678407222202963581.tip-bot2@tip-bot2>
 <6380ba8d-4e99-46e6-8d92-911d10963ba7@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6380ba8d-4e99-46e6-8d92-911d10963ba7@suse.com>

On Mon, Feb 26, 2024 at 09:17:30AM +0200, Nikolay Borisov wrote:
> > diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> > index 262e655..077083e 100644
> > --- a/arch/x86/include/asm/nospec-branch.h
> > +++ b/arch/x86/include/asm/nospec-branch.h
> > @@ -315,6 +315,17 @@
> >   #endif
> >   .endm
> > +/*
> > + * Macro to execute VERW instruction that mitigate transient data sampling
> > + * attacks such as MDS. On affected systems a microcode update overloaded VERW
> > + * instruction to also clear the CPU buffers. VERW clobbers CFLAGS.ZF.
> > + *
> > + * Note: Only the memory operand variant of VERW clears the CPU buffers.
> > + */
> > +.macro CLEAR_CPU_BUFFERS
> > +	ALTERNATIVE "", __stringify(verw _ASM_RIP(mds_verw_sel)), X86_FEATURE_CLEAR_CPU_BUF
> 
> Any particular reason why this uses RIP-relative vs an absolute address
> mode?

Early versions of the series had the VERW arg pointing to the macro
itself, that is why relative addressing was used. That got changed in a
later version with all VERW sites pointing to a single memory location.

> I know in our private exchange you said there is no significance but
> for example older kernels have a missing relocation support in alternatives.
> This of course can be worked around by slightly changing the logic of the
> macro which means different kernels will have slightly different macros.

Do you anticipate a problem with that? If yes, I can send a patch to use
fixed addressing in upstream as well.

