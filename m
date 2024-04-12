Return-Path: <linux-kernel+bounces-143190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0874F8A3581
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 396281C23F52
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAEE14EC4E;
	Fri, 12 Apr 2024 18:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhSYSO1A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E5614D44F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 18:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712946053; cv=none; b=ECjQWT1NqSAxqCzHpWVREIrybKUje2JwDVNff/WPdI1GhVMSAFmDzWhn+LRDx5AO73lR+PQAJqv8kQhYXcAPUutPNqXxqq4hAly78zfQxVyT6VUj2N47uT0w4hK0433FlmBhNT+OGNL7hWVXIYtJqSsEWttQn6CgAlbq39QfUmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712946053; c=relaxed/simple;
	bh=KXiutQ9tdS1FwQ0AOqobuUPzDrGZYlvSr0VuMrqsuvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZxTfSIRsnjM+7AhXqeFKZZEEkgzRLHlYZNNi1SsdP5r3ccchykU6tVOOMZ4HggHeHoaVc3HAGM6jBtDk2T4m8G8nf9M+FhlYuD8mIS3Dw3TmesAghER7awKWezZeZK8koTxtOi2yzQotdKEnxSqBNlIRohFSF5lQ/0BZNJL0cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhSYSO1A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B0D3C113CC;
	Fri, 12 Apr 2024 18:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712946052;
	bh=KXiutQ9tdS1FwQ0AOqobuUPzDrGZYlvSr0VuMrqsuvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RhSYSO1AG1UigulrfSRJZIRU1pzkErgBymY6vGWXGR7RqBINWesrsgbTvOwe1M7Yp
	 pz4tEuHjyW8FewJ0ydkXCnrvAmiAqiLQrxqrUwNyDIUBcYFHGbUdlVQ8eZhU9qrtE9
	 7PfDQwr7xuO56C96IQKxBG5+mhglX7f7JN7pqAvAR+UZgqKSkVtrFB9RO11WnH2N7Z
	 K4A+aMa19MerhQ/yEUUgZmwwDxmN0us2IfK1eybznxNOJYuyatBus3scIBluOYAmaQ
	 kLeUqv4bDyBQK+9CEDPvyFIA2lIP0pQGItgwvjSsIGrZ6URxiCRZEMtVb63ur8a4eY
	 b8TqfMYgqPuLg==
Date: Fri, 12 Apr 2024 11:20:49 -0700
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
Message-ID: <20240412182049.r234qj2h2nuzqfxy@treble>
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
> ---
>  arch/x86/Makefile                             |  1 -
>  arch/x86/include/asm/cpufeatures.h            |  1 -
>  arch/x86/include/asm/disabled-features.h      |  3 +-
>  arch/x86/include/asm/nospec-branch.h          | 18 ++---
>  arch/x86/kernel/alternative.c                 | 17 +----
>  arch/x86/kernel/cpu/bugs.c                    | 66 +------------------
>  arch/x86/kernel/cpu/cpu.h                     |  3 +-
>  arch/x86/lib/retpoline.S                      |  5 +-
>  arch/x86/net/bpf_jit_comp.c                   |  5 +-
>  tools/arch/x86/include/asm/cpufeatures.h      |  1 -
>  .../arch/x86/include/asm/disabled-features.h  |  3 +-

Forgot the documentation updates:

diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst b/Documentation/admin-guide/hw-vuln/spectre.rst
index 25a04cda4c2c..de780db82cd8 100644
--- a/Documentation/admin-guide/hw-vuln/spectre.rst
+++ b/Documentation/admin-guide/hw-vuln/spectre.rst
@@ -380,10 +380,8 @@ The possible values in this file are:
   'Not affected'                            The processor is not vulnerable
   'Mitigation: None'                        Vulnerable, no mitigation
   'Mitigation: Retpolines'                  Use Retpoline thunks
-  'Mitigation: LFENCE'                      Use LFENCE instructions
   'Mitigation: Enhanced IBRS'               Hardware-focused mitigation
   'Mitigation: Enhanced IBRS + Retpolines'  Hardware-focused + Retpolines
-  'Mitigation: Enhanced IBRS + LFENCE'      Hardware-focused + LFENCE
   ========================================  =================================
 
   - Firmware status: Show if Indirect Branch Restricted Speculation (IBRS) is
@@ -640,13 +638,10 @@ kernel command line.
 
 		Specific mitigations can also be selected manually:
 
-                retpoline               auto pick between generic,lfence
+                retpoline               Retpolines
                 retpoline,generic       Retpolines
-                retpoline,lfence        LFENCE; indirect branch
-                retpoline,amd           alias for retpoline,lfence
                 eibrs                   Enhanced/Auto IBRS
                 eibrs,retpoline         Enhanced/Auto IBRS + Retpolines
-                eibrs,lfence            Enhanced/Auto IBRS + LFENCE
                 ibrs                    use IBRS to protect kernel
 
 		Not specifying this option is equivalent to
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 902ecd92a29f..edbfba7299e7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6099,13 +6099,10 @@
 
 			Specific mitigations can also be selected manually:
 
-			retpoline	  - replace indirect branches
+			retpoline	  - Retpolines
 			retpoline,generic - Retpolines
-			retpoline,lfence  - LFENCE; indirect branch
-			retpoline,amd     - alias for retpoline,lfence
 			eibrs		  - Enhanced/Auto IBRS
 			eibrs,retpoline   - Enhanced/Auto IBRS + Retpolines
-			eibrs,lfence      - Enhanced/Auto IBRS + LFENCE
 			ibrs		  - use IBRS to protect kernel
 
 			Not specifying this option is equivalent to

