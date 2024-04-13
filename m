Return-Path: <linux-kernel+bounces-143574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0CF8A3B02
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 06:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C47A1C21FBD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 04:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7BA1C2BD;
	Sat, 13 Apr 2024 04:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1YTh15+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DCD1BF37
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 04:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712982098; cv=none; b=Uq0PUmCzSK94RQTQ9qF1P6DLbUCWBrik+IEbIrfjyqaF+y0kuXVDXcODPRANY86KxYAZDWO/HN6znvNjGrfMjNciIdXxMOJRtIROB7ladaHLhBQu7kbGA3bjrsyeSmtR2C87NHgHObVaGjlUSTuyRF/Edw+wPcl1TSpzNDVUgEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712982098; c=relaxed/simple;
	bh=CCB9vHLqRR69IsVfqOm+w0j+qxCe4Y2M4F8ATCYzNNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LeGk7qMzQkK5I5Y2rvUh0rm2EacsU1lvMlrC1L8vArixsmyhkEFDJ45iTB3I5ayHocAcqdh6tUiUs5+0lyRVIagJ5R+0rD7IyVNqq9++d6z86OtKsHpfz/8U8Tt86NeAvWcvfb+Ypv/I4WxLZPg3EzcyIHE85mFeO9aHg4cttyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1YTh15+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D17FC113CD;
	Sat, 13 Apr 2024 04:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712982097;
	bh=CCB9vHLqRR69IsVfqOm+w0j+qxCe4Y2M4F8ATCYzNNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p1YTh15+eGg5LcpadJEMrQT52iB53KIgbccvUQTglxB52vMCV/L7T90ZDpJCvh//L
	 X1vdiYc45ERAMhcP5VtAoS4wPQOg1BEtHeyzUmhBLuTHON4rP3YVGPrTHZHOoJ09nx
	 wilqxER0gaMhRTIAxlYWyV9dwcvClfvDTCwv9Pn4RZA1sEK9VR0mkssvsNm2vXJZlL
	 MyWSdhdGYvyIEFv78x6MTn8aTz9hGPWTEJSPe+VrOOP+meayPrhpg+R1y6IVzRa2oN
	 QtbGPakljkAxRfdbp5A/jIpH9F2DZoVEArODFDBtT5jSOq6GI+j3sPjjsmTnu4qTRe
	 3tWVXwVbJFJ7w==
Date: Fri, 12 Apr 2024 21:21:35 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	KP Singh <kpsingh@kernel.org>, Waiman Long <longman@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 3/3] x86/bugs: Remove support for Spectre v2 LFENCE
 "retpolines"
Message-ID: <20240413042135.z2vglouqfl763m77@treble>
References: <cover.1712944776.git.jpoimboe@kernel.org>
 <e5356c0e018cd0a96aabe719f685c237ac519403.1712944776.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e5356c0e018cd0a96aabe719f685c237ac519403.1712944776.git.jpoimboe@kernel.org>

On Fri, Apr 12, 2024 at 11:10:34AM -0700, Josh Poimboeuf wrote:
> I found several bugs where code assumes that X86_FEATURE_RETPOLINE
> actually means retpolines (imagine that!).  In fact that feature also
> includes the original AMD LFENCE "retpolines", which aren't in fact
> retpolines.
> 
> Really, those "retpolines" should just be removed.  They're already
> considered vulnerable due to the fact that the speculative window after
> the indirect branch can still be long enough to do multiple dependent
> loads.  And recent tooling makes such gadgets easier to find.
> 
> Also, EIBRS_LFENCE tests worse in real-world benchmarks than the actual
> BHI mitigations, so it's both slower and less secure.
> 
> Specifically this removes support for the following cmdline options:
> 
>   - spectre_v2=retpoline,amd
>   - spectre_v2=retpoline,lfence
>   - spectre_v2=eibrs,lfence
> 
> Now when any of those options are used, it will print an error and fall
> back to the defaults (spectre_v2=auto spectre_bhi=on).
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Compile fix:

diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index e1c421282a78..3a1349c0f225 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -53,7 +53,7 @@
 #ifdef CONFIG_MITIGATION_RETPOLINE
 # define DISABLE_RETPOLINE	0
 #else
-# define DISABLE_RETPOLINE	(1 << (X86_FEATURE_RETPOLINE & 31)
+# define DISABLE_RETPOLINE	(1 << (X86_FEATURE_RETPOLINE & 31))
 #endif
 
 #ifdef CONFIG_MITIGATION_RETHUNK

