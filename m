Return-Path: <linux-kernel+bounces-119773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B650C88CCD8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9C0B1C33FD2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969ED13CC65;
	Tue, 26 Mar 2024 19:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="lNXVLKDt"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDA213CA97
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 19:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711480383; cv=none; b=lfLsoeb2Qz3aAsjOi/m+JSAJrCnlBI7yEwop6u9RzRCdy9nLsJPuvWlS07wFVJmZsrnFDsx17m/RmNik/NAcKNt/DoQbejpkwartmsuJ2As8S3/p/hDwNvKVjQlxlkKKV6e8mRAtk1buUEnS5EpEUC0NouvKz5ijUP3phgNppIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711480383; c=relaxed/simple;
	bh=YfLzbr1Cbu1iedRDur0CjMqPaAAfzdvJz0kdWY4MeP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cshgt3tugxs/r9s6VpcxfyxaLeq1ktjuICgxKXayFkHnk61TCDEMOEA4MxQq9OEc+z722+B+O/1OOxZdsOiQt8zvMov+gH59TbTsqCtRNeq/GmRWlgZBKqRv+g1m38nOeEMTIm7doderG5yIAjmjmJ6yU6Ep040uuCTf43PVyyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=lNXVLKDt; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4EEA940E024C;
	Tue, 26 Mar 2024 19:12:51 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dEwE2u3E4tLL; Tue, 26 Mar 2024 19:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711480367; bh=XXsjYyRIb1HQzV+63JjLPbHzP1gIoqqZ5bMRYD4+nG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lNXVLKDtvB4LiuXinh24KxW/JaOFd0z5aHbq9YlVg4Hp/bHTAwexliUkh0a6kGPjh
	 Xd/1dBwxOFKhvFsMPDJWHMKK+K7qdiH4eWNR1sLDeAwqyRHbnnJaVCicFPCaOdOPXw
	 JSi2Xgqzuk4iSVHuHBN+vmOuY4jjoq7Vr3jIC393rSmrvhUYru31GBL+6avklF+QIf
	 xRg1sngQqfTTCzZXqxZww6bx5s84JWGQmOOZOxeAHxroZVYzinEnhijRDZj8GY0DCl
	 o+BszBm6QMchdl5uBu9hYRIEqKlvseKGITwFbjluFsG/Y62LpWA2vfr3tb++ZK/7vP
	 ISrodBREkx6+Ro2nfUR1Wi2ooIl66qR3vFvJ+OJ62me4T+/IuOsg39oizGLaz8hZ7y
	 M8uyQ9oTxEJWDBvIITshtVgnNQjn4/Cu7K6vDuaTAGk+XysQKtb6DEg8U56K6b6D/u
	 86H3ar5ju3OgZIJCl2jr945HfX1yzi32b1Q+phId7Z+k/aPUlkOAquEPNwWRp1rVnq
	 XJ1EYIYAaQpdHHp1tckeFweqBEa0b6t/0971tG8qP5q77ha5EhIzcS1biKrDpH13Ub
	 AR/krgLxAV6QPrhPcF57ypYGxSwRBFJkmPbmMZQMJl7fvEJXUqfUNPE1ko86T7GQmr
	 rzxRJ2pE4xXGyxU68iDMDnxs=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 17D9940E00B2;
	Tue, 26 Mar 2024 19:12:35 +0000 (UTC)
Date: Tue, 26 Mar 2024 20:12:29 +0100
From: Borislav Petkov <bp@alien8.de>
To: Nikolay Borisov <nik.borisov@suse.com>, Marco Elver <elver@google.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	LKML <linux-kernel@vger.kernel.org>, kasan-dev@googlegroups.com,
	David Kaplan <David.Kaplan@amd.com>
Subject: Re: Unpatched return thunk in use. This should not happen!
Message-ID: <20240326191211.GKZgMeC21uxi7H16o_@fat_crate.local>
References: <0851a207-7143-417e-be31-8bf2b3afb57d@molgen.mpg.de>
 <47e032a0-c9a0-4639-867b-cb3d67076eaf@suse.com>
 <20240326155247.GJZgLvT_AZi3XPPpBM@fat_crate.local>
 <80582244-8c1c-4eb4-8881-db68a1428817@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <80582244-8c1c-4eb4-8881-db68a1428817@suse.com>

On Tue, Mar 26, 2024 at 06:04:26PM +0200, Nikolay Borisov wrote:
> So this       _sub_I_00099_0 is the compiler generated ctors that is likely
> not patched. What's strange is that when adding debugging code I see that 2
> ctors are being executed and only the 2nd one fires:
> 
> [    7.635418] in do_mod_ctors
> [    7.635425] calling 0 ctor 00000000aa7a443a
> [    7.635430] called 0 ctor
> [    7.635433] calling 1 ctor 00000000fe9d0d54
> [    7.635437] ------------[ cut here ]------------
> [    7.635441] Unpatched return thunk in use. This should not happen!

.. and this is just the beginning of the rabbit hole. David and I went
all the way down.

Turns out that objtool runs on the .o files and creates the
return_sites just fine but then the module building dance creates an
intermediary *.mod.c file and when that thing is built, KCSAN would
cause the addition of *another* constructor to .text.startup in the
module.

The .o file has one:

-------------------
Disassembly of section .text.startup:

..

0000000000000010 <_sub_I_00099_0>:
  10:   f3 0f 1e fa             endbr64
  14:   e8 00 00 00 00          call   19 <_sub_I_00099_0+0x9>
                        15: R_X86_64_PLT32      __tsan_init-0x4
  19:   e9 00 00 00 00          jmp    1e <__UNIQUE_ID___addressable_cryptd_alloc_aead349+0x6>
                        1a: R_X86_64_PLT32      __x86_return_thunk-0x4
-------------------


while the .ko file has two:

-------------------
Disassembly of section .text.startup:

0000000000000010 <_sub_I_00099_0>:
  10:   f3 0f 1e fa             endbr64
  14:   e8 00 00 00 00          call   19 <_sub_I_00099_0+0x9>
                        15: R_X86_64_PLT32      __tsan_init-0x4
  19:   e9 00 00 00 00          jmp    1e <_sub_I_00099_0+0xe>
                        1a: R_X86_64_PLT32      __x86_return_thunk-0x4

..

0000000000000030 <_sub_I_00099_0>:
  30:   f3 0f 1e fa             endbr64
  34:   e8 00 00 00 00          call   39 <_sub_I_00099_0+0x9>
                        35: R_X86_64_PLT32      __tsan_init-0x4
  39:   e9 00 00 00 00          jmp    3e <__ksymtab_cryptd_alloc_ahash+0x2>
                        3a: R_X86_64_PLT32      __x86_return_thunk-0x4
-------------------

Once we've figured that out, finding a fix is easy:

diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 8568d256d6fb..79fcf2731686 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -23,7 +23,7 @@ modname = $(notdir $(@:.mod.o=))
 part-of-module = y
 
 quiet_cmd_cc_o_c = CC [M]  $@
-      cmd_cc_o_c = $(CC) $(filter-out $(CC_FLAGS_CFI) $(CFLAGS_GCOV), $(c_flags)) -c -o $@ $<
+      cmd_cc_o_c = $(CC) $(filter-out $(CC_FLAGS_CFI) $(CFLAGS_GCOV) $(CFLAGS_KCSAN), $(c_flags)) -c -o $@ $<
 
 %.mod.o: %.mod.c FORCE
        $(call if_changed_dep,cc_o_c)

However, I'm not sure.

I wanna say that since those are constructors then we don't care about
dynamic races there so we could exclude them from KCSAN.

If not, I could disable the warning on KCSAN. I'm thinking no one would
run KCSAN in production...

A third option would be to make objtool run on .ko files. Yeah, that
would be fun for Josh. :-P

I'd look into the direction of melver for suggestions here.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

