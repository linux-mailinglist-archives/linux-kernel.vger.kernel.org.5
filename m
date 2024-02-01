Return-Path: <linux-kernel+bounces-48327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7F7845A6C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADCAF1F23DF1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBA15F460;
	Thu,  1 Feb 2024 14:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nb8AG3X2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871085D460
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 14:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706798348; cv=none; b=eVyjuji70UclazqU531VaOwiQYoPkf7NrMBI4BpJgHcBubKyQ/BA0sKdNsDt4LdFCc6i4i2vxUZ2A3gTDbxDZ40Kc/Kz9Jfr6ujBUktcjNsS1csMJ1hi4yReMhR7ztmKXyhBeoBU4+p5CtY2L2CzSWOBROzBOrvQ0dvagd52ke0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706798348; c=relaxed/simple;
	bh=DU4icRwi3TNyBbtjNR34RkFqYSFJ8gRYgLp/MM3e20c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4HH4ErJ8x162DAcCpd4tZQmFhbA8N7WiBXuCgymAuRtxpVQcJmVEgXi4xCnB7vnqaeoAFqW2FfGkUQRNQGRpH/VWonvSxtdw9eRA9HMFcepFVzavheq17nrKSp9QwnTGxNogblTUJY1Psj2LLZqOK9OWGau2xxSNur29N5+Iuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nb8AG3X2; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706798346; x=1738334346;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=DU4icRwi3TNyBbtjNR34RkFqYSFJ8gRYgLp/MM3e20c=;
  b=nb8AG3X21UYdtVJ3Fv4Z19FtbU2uucGf/tUan4CrOxeyib7p0OCJFIpw
   4IleUkQsiWXCARzWqOSzcISIdvEvj7t7lMBn0Q6T0Wxz/+1XFxD/FRJma
   +hurLdenQQnnKwdxkFQaZuhhbFYm7HzB/MghNhzB+4Oo9QbyRin6gh2r8
   0iVPuVK+dMVbhPXSVf11SsdGkY+gcO1sqrI7w3/zJyIDzqzDeO6yVKbO5
   +EST48fjEbrAI3zrISpmH0FSY+lXBHtzy8LzGCo6eSjEMP5rdz8C69F45
   290KYGoD6GL6DvgE8krdu2+khX3umtqGsI687ZnZ91XjwFMK+LmeBr9Pz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10561070"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="10561070"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 06:39:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="932190575"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="932190575"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 01 Feb 2024 06:39:02 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id D78C1A23; Thu,  1 Feb 2024 16:39:00 +0200 (EET)
Date: Thu, 1 Feb 2024 16:39:00 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, tglx@linutronix.de, bp@alien8.de, mingo@redhat.com, 
	hpa@zytor.com, luto@kernel.org, peterz@infradead.org, thomas.lendacky@amd.com, 
	chao.gao@intel.com, bhe@redhat.com, nik.borisov@suse.com, pbonzini@redhat.com
Subject: Re: [PATCH 3/4] x86/kexec(): Reset TDX private memory on platforms
 with TDX erratum
Message-ID: <ixp6wj4763kc5vgpmipyrijddwnxblhdn2v7hio7ze756w5f2x@6uyc7hwtrbbn>
References: <cover.1706698706.git.kai.huang@intel.com>
 <b52ed259e0d487b3a968b98da91cb4f55a28ae82.1706698706.git.kai.huang@intel.com>
 <12a927df-e437-40ff-ba4d-ceca5446c5b1@intel.com>
 <l3uo3n3li27czehll2wz34xxkcv5j2vcshgp5a6w7u4h4aidpu@4oe2cwye2e6z>
 <0c990c7d-4df9-45c1-8c03-980d9842b963@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0c990c7d-4df9-45c1-8c03-980d9842b963@intel.com>

On Thu, Feb 01, 2024 at 10:22:18PM +0800, Huang, Kai wrote:
> 
> 
> On 1/02/2024 6:03 am, Kirill A. Shutemov wrote:
> > On Wed, Jan 31, 2024 at 01:21:39PM -0800, Dave Hansen wrote:
> > > >   #ifdef CONFIG_KEXEC_JUMP
> > > >   	if (image->preserve_context)
> > > >   		save_processor_state();
> > > > +	else
> > > > +		tdx_reset_memory();
> > > > +#else
> > > > +	tdx_reset_memory();
> > > >   #endif
> > > 
> > > Wow, that's awfully hard to read.  I really wish folks' gag reflex would
> > > kick in when they see stuff like this to get them to spend an additional
> > > 15 seconds to turn this into:
> > > 
> > > 	if (IS_ENABLED(CONFIG_KEXEC_JUMP) && image->preserve_context)
> > > 		save_processor_state();
> > > 	else
> > > 		tdx_reset_memory();
> > 
> > save_processor_state() is declared under CONFIG_PM_SLEEP, so I guess your
> > variant might break build in some cases without updated suspend.h.
> 
> I tried.  If I turn off both SUSPEND and HIBERNATION in the Kconfig I got
> build error：
> 
> arch/x86/kernel/machine_kexec_64.c:325:17: error: implicit declaration of
> function ‘save_processor_state’ [-Werror=implicit-function-declaration]
>   325 |                 save_processor_state();
>       |                 ^~~~~~~~~~~~~~~~~~~~

Moving save_processor_state() declaration outside all defines would do the
trick.

Something like the patch below.

But finding the right spot for the move can be tricky. I don't particular
like where I moved it.

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index ef503088942d..1c17059df039 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -201,6 +201,9 @@ struct platform_s2idle_ops {
 	void (*end)(void);
 };
 
+void save_processor_state(void);
+void restore_processor_state(void);
+
 #ifdef CONFIG_SUSPEND
 extern suspend_state_t pm_suspend_target_state;
 extern suspend_state_t mem_sleep_current;
@@ -491,8 +494,6 @@ static inline int is_hibernate_resume_dev(dev_t dev) { return 0; }
 extern struct mutex system_transition_mutex;
 
 #ifdef CONFIG_PM_SLEEP
-void save_processor_state(void);
-void restore_processor_state(void);
 
 /* kernel/power/main.c */
 extern int register_pm_notifier(struct notifier_block *nb);
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

