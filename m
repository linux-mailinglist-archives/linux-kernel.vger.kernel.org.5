Return-Path: <linux-kernel+bounces-164647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 522198B809C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78C06B22DC2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154DB19DF48;
	Tue, 30 Apr 2024 19:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="k3oI2cPL"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23177199E8C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 19:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714505555; cv=none; b=WwYjc+Vqhpb6lxf5JqgX1PFo3RDbsrXYX4PQKlXRVOCYdlib4JT7xsSEkBo4lM+GvmkDA0I9VSfEF+xymxQplnxi7N2fUOvln+QqoyyxEaB4dkzmoA7sKqoIL56eRZ1jxM6u6Ec9NakOLNciiGq+eANcCSZLKyu0YN/o7n/hZfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714505555; c=relaxed/simple;
	bh=UJLqytGp3OTRG9/cYcksPJrkSyquPpBl8bgFG7LfZl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8t3C5aQWr/z1IerPRiq9ZlOtBwpyxUWXr8oixaD1M7Ut+NUaF37Izy+iGHRfCH5Bhq14/fEoH3IJInyeX+zr0elEOYVw8ClSxiChpYvRkI7lTiLHdiCn5zy4qmqdM/Ce17ofVUwNTr+VuV2NNKM2gVxfZREzIweZDiw+9RDHmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=k3oI2cPL; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 14FBD40E01E8;
	Tue, 30 Apr 2024 19:32:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id R3gHbPJ8A3ZS; Tue, 30 Apr 2024 19:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714505545; bh=JU4aymvuSrbmUI4cPP+NTtovpZW0bUCvqaMeZt65ydQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k3oI2cPL2O1cWG7otQLgxt9lPmV5wHqYOVqcHnWgsQeav64rH5zrxnH+Ib+oa+II4
	 7B6ZJ1ljpigb/nD1gv/WlxWhb2WeZJ/Y/e1IhUOeV12UzMJ7uIQylvjmIcPnZQ5UrF
	 SZhzWmbdwc6F/V2w90RJOz3o4r/QsHHbM3zNL23AOzDXdv3J0OXjpCoYhMRoIWrnL2
	 1psbJQS88A/KjG+GCOuVuOol/D1VGlLgUqIaUdlEt2h2//hQ26NFclHQT12w9vdJgE
	 bw0qlUocwkLNjy99orlBq37x9+1DdvRwqdCBy0zVyHIChjbhbyFsTv3BDxaLjtTYO3
	 wz10vjnRu67DNtE9WVBlQ6q3/VMO4dW2pwT9F1TXuhNg8XLBabvA8p7g5IhHhbMUHO
	 zDCn5I3HjMvWnovNdpOm8m/Qw2bSVMFSq0koALpV9eG+0lAjA8oWLi/TLT2irRs8Qg
	 gF4uhIsvEhRe4WO3KTI+na1+w+HrPa0q9LxU9dXroUDqKZRWB36SNTJRY/u0g/wbHv
	 2LdgtVLImyz5BKPgmQnAK7Ryzhfvvxe6AmfRyvQWxP8bwqyAsP762X5DcA6F8DYZRQ
	 o3XRDglCLVToUgFMF+h0N/dKhRcfkAYk6G/IRA8RRwWVQ7WziDIOVhuDhpohgu1h8D
	 AxPFOjWtoWDc8lFQb6Eyv9RM=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BA19340E01A1;
	Tue, 30 Apr 2024 19:32:17 +0000 (UTC)
Date: Tue, 30 Apr 2024 21:32:11 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sean Christopherson <seanjc@google.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>, Srikanth Aithal <sraithal@amd.com>
Subject: Re: [tip:x86/alternatives] [x86/alternatives] ee8962082a:
 WARNING:at_arch/x86/kernel/cpu/cpuid-deps.c:#do_clear_cpu_cap
Message-ID: <20240430193211.GEZjFHO0ayDXtgvbE7@fat_crate.local>
References: <202404302233.f27f91b2-oliver.sang@intel.com>
 <20240430172313.GCZjEpAfUECkEZ9S5L@fat_crate.local>
 <ZjE7DkTBSbPlBN8k@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZjE7DkTBSbPlBN8k@google.com>

On Tue, Apr 30, 2024 at 11:40:14AM -0700, Sean Christopherson wrote:
> Hmm, I don't think the problem is that init_ia32_feat_ctl() is called too late.
> It too is called from the BSP prior to alternative_instructions():
> 
>   arch_cpu_finalize_init()
>   |
>   -> identify_boot_cpu()
>      |
>      -> identify_cpu()
>         |
>         -> .c_init() => init_intel()

Yeah, but look at the his stacktrace:

[ 0.055225][ T0] init_intel (arch/x86/include/asm/msr.h:146 arch/x86/include/asm/msr.h:300 arch/x86/kernel/cpu/intel.c:583
+arch/x86/kernel/cpu/intel.c:687)
[ 0.055225][ T0] identify_cpu (arch/x86/kernel/cpu/common.c:1824)
[ 0.055225][ T0] identify_secondary_cpu (arch/x86/kernel/cpu/common.c:1949)
[ 0.055225][ T0] smp_store_cpu_info (arch/x86/kernel/smpboot.c:333)

That's after alternatives.

> Ah, and the WARN even specifically checks for the case where there's divergence
> from the boot CPU:
> 
> 	if (boot_cpu_has(feature))
> 		WARN_ON(alternatives_patched);

Funny you should mention that - I have this check in
setup_force_cpu_cap() too which works on boot_cpu_data *BUT*, actually,
the test in do_clear_cpu_cap() should be:

        if (c && cpu_has(c, feature))
                WARN_ON(alternatives_patched);

because setting a feature flag in *any* CPU's cap field is wrong after
alternatives because as explained earlier.

I know, our feature flags handling is a major mess.

> So I think this is a "real" warning about a misconfigured system, where VMX is
> fully configured in MSR_IA32_FEAT_CTL on the boot CPU, but is disabled on a
> secondary CPU.

And that's yet another issue. And it already warns about it:

[    0.835741][    T1] smpboot: x86: Booting SMP configuration:
[    0.836040][    T1] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  #9 #10 #11 #12 #13 #14 #15 #16 #17
[    0.055225][    T0] masked ExtINT on CPU#1
[    0.055225][    T0] x86/cpu: VMX (outside TXT) disabled by BIOS
^^^^^^^^^^^^^^^^^^^^

Oliver, does the second warning go away if you do this?

---
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index 5dd427c6feb2..93fa2afc0c67 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -114,7 +114,7 @@ static void do_clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int feature)
 	if (WARN_ON(feature >= MAX_FEATURE_BITS))
 		return;
 
-	if (boot_cpu_has(feature))
+	if (c && cpu_has(c, feature))
 		WARN_ON(alternatives_patched);
 
 	clear_feature(c, feature);

--

my guess would be no and that init_ia32_feat_ctl() really needs to go
before alternatives have been patched because it clears flags.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

