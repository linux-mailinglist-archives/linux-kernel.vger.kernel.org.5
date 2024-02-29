Return-Path: <linux-kernel+bounces-86384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C385186C4AF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D50F7B23D29
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AD35823F;
	Thu, 29 Feb 2024 09:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AbwbDOiR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EABF58232
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709198073; cv=none; b=bS/tQ3c6v7Kk4SJjjiA5WQEnjt05CgexjSVvekm2SLcpMNgYO3WL4kRv3xVaXovfENJuLjnjRzjhVdoIPK7KikUZ1K5/XYKPFgIvofGr5m4EaAztR1UN68Wg2jOonoBg5s8TOe1NAaP7wLjmwnePl3oFsSS3vuFKNtkzipRWWCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709198073; c=relaxed/simple;
	bh=KTqfuT0Bo1Ssr89vHRNq5K7XJnolvbqM5EFtTtZ2Hn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7TBAVDLV/IuGK+jbdqauD+C5HxlpQSRnDKZzxCQ11Z5/pqSD1oUEAy74MeWahsaOCP+G+7dRMnSlHmRTmsgw9Qyr9rAfTWWA2VNNCUp2QjaqYmDaFBjzqI6Ncsj89VrVEajIwBru+NgXFVysLHhPt7pNyoT1v4waXnrHsOmArc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AbwbDOiR; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709198072; x=1740734072;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=KTqfuT0Bo1Ssr89vHRNq5K7XJnolvbqM5EFtTtZ2Hn8=;
  b=AbwbDOiRup0MEJTWSBzzRc8x3SB1qycEWb44iOfsirDaFTQEmtynnYt3
   WJW+h8q0SeUBg8wYoJN03olVooYTWtajsIw6j65TfLCWV3vSUAzrob9vU
   pgAoimHEOXUOQE+Q+87RbcMpWfnH6CBh+wWxHN1x9ZUn4Le+ba1VhrJhq
   zo65vM2DQhTuDV7v5yYhJc4gmBLKzT/c3b0YMQh6u8jINA6nmG08/VBvX
   qSvSXipMB6xkN9LCqrC7BJWmrqmk8Nc/+9KdXdGeFK1qIIspZ2km1PDro
   gUmqudEeHMQW7RpWPuL6CmBeevRYp44orsTJtBreuucesX27R76C3m3wx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="15093898"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="15093898"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 01:14:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="12411842"
Received: from vyalavar-mobl1.amr.corp.intel.com (HELO desk) ([10.209.79.44])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 01:14:29 -0800
Date: Thu, 29 Feb 2024 01:14:28 -0800
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
Message-ID: <20240229091428.lnbcvhm3udzl5jd5@desk>
References: <20240226-verw-arg-fix-v1-1-7b37ee6fd57d@linux.intel.com>
 <92440f47-21b7-4f4f-ad99-a99358cfbedf@suse.com>
 <373674e4-cbd0-44d7-98c7-304b0ab4f34b@kernel.org>
 <20240229013924.cksuxebpylyeymzo@desk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240229013924.cksuxebpylyeymzo@desk>

On Wed, Feb 28, 2024 at 05:39:27PM -0800, Pawan Gupta wrote:
> On Tue, Feb 27, 2024 at 10:43:53AM +0100, Jiri Slaby wrote:
> > On 27. 02. 24, 9:47, Nikolay Borisov wrote:
> > > 
> > > 
> > > On 27.02.24 г. 1:52 ч., Pawan Gupta wrote:
> > > > Macro used for MDS mitigation executes VERW with relative addressing for
> > > > the operand. This is unnecessary and creates a problem for backports on
> > > > older kernels that don't support relocations in alternatives. Relocation
> > > > support was added by commit 270a69c4485d ("x86/alternative: Support
> > > > relocations in alternatives"). Also asm for fixed addressing is much
> > > > more cleaner than relative RIP addressing.
> > > > 
> > > > Simplify the asm by using fixed addressing for VERW operand.
> > > > 
> > > > Fixes: baf8361e5455 ("x86/bugs: Add asm helpers for executing VERW")
> > > > Reported-by: Nikolay Borisov <nik.borisov@suse.com>
> > > > Closes: https://lore.kernel.org/lkml/20558f89-299b-472e-9a96-171403a83bd6@suse.com/
> > > > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > > > ---
> > > >   arch/x86/include/asm/nospec-branch.h | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/arch/x86/include/asm/nospec-branch.h
> > > > b/arch/x86/include/asm/nospec-branch.h
> > > > index 2aa52cab1e46..ab19c7f1167b 100644
> > > > --- a/arch/x86/include/asm/nospec-branch.h
> > > > +++ b/arch/x86/include/asm/nospec-branch.h
> > > > @@ -323,7 +323,7 @@
> > > >    * Note: Only the memory operand variant of VERW clears the CPU
> > > > buffers.
> > > >    */
> > > >   .macro CLEAR_CPU_BUFFERS
> > > > -    ALTERNATIVE "", __stringify(verw _ASM_RIP(mds_verw_sel)),
> > > > X86_FEATURE_CLEAR_CPU_BUF
> > > > +    ALTERNATIVE "", __stringify(verw mds_verw_sel),
> > > > X86_FEATURE_CLEAR_CPU_BUF
> > > 
> > > Actually thinking about it more and discussing with Jiri (cc'ed), will
> > > this work with KASLR enabled?
> > 
> > I might of course be wrong. We appear to rely on the asm+linker here.
> 
> You were right, with KASLR enabled, instructions with fixed addressing
> in alternatives don't get relocated. I guess we will have to keep
> rip-relative as is. Thanks for catching that.

Looks like this is not settled yet, it was naive of me to trust gdb on
/proc/kcore earlier with KASLR enabled.

With the below debug patch it appears the relocation with fixed
addresses is working as expected with KASLR enabled.

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 6a1fe302c1fd..ae4168db453d 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -323,7 +323,7 @@
  * Note: Only the memory operand variant of VERW clears the CPU buffers.
  */
 .macro CLEAR_CPU_BUFFERS
-	ALTERNATIVE "", __stringify(verw mds_verw_sel), X86_FEATURE_CLEAR_CPU_BUF
+	ALTERNATIVE "", __stringify(verw mds_verw_sel; ud2), X86_FEATURE_CLEAR_CPU_BUF
 .endm
 
 #else /* __ASSEMBLY__ */
---

With the patch adding #UD after verw I get below panic:

[    1.402347] traps: PANIC: double fault, error_code: 0x0
[    1.402350] double fault: 0000 [#1] PREEMPT SMP PTI
[    1.402353] CPU: 0 PID: 1 Comm: init Not tainted 6.7.6-00007-ga040ab9fe827-dirty #27
[    1.402355] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[    1.402356] RIP: 0010:entry_SYSRETQ_unsafe_stack+0xb/0x10
[    1.402365] Code: c7 eb 08 48 89 c7 48 0f ba ef 3f 48 81 cf 00 08 00 00 48 81 cf 00 10 00 00 0f 22 df 58 5f 5c 0f 01 f8 0f 00 2c 25 00 00 60 ab <0f> 0b 48 0f 07 cc 0f 1f 44 00 00 56 48 8b 74 24 08 48 89 7c 24 08
[    1.402366] RSP: 0018:00007ffe253461f8 EFLAGS: 000100c6
[    1.402369] RAX: 000055e5c94f7000 RBX: 00007f3d8d9b4e80 RCX: 00007f3d8d9b8f9b
[    1.402370] RDX: 0000000000000000 RSI: 00007ffe253461ec RDI: 0000000000000000
[    1.402371] RBP: 00007ffe25346290 R08: 0000000000000000 R09: 0000000000000022
[    1.402372] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f3d8d993000
[    1.402373] R13: 0000002300000007 R14: 0000000000000007 R15: 00007ffe253462a0
[    1.402378] FS:  0000000000000000(0000) GS:ffff906d3bc00000(0000) knlGS:ffff906d3bc00000
[    1.402380] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.402381] CR2: 00007ffe253461e8 CR3: 00000001002a8003 CR4: 00000000007706f0
[    1.402382] PKRU: 55555554
[    1.402383] Call Trace:
[    1.402384]  <#DF>
[    1.402386]  ? die+0x37/0x90
[    1.402390]  ? exc_double_fault+0xcf/0x180
[    1.402394]  ? asm_exc_double_fault+0x23/0x30
[    1.402397]  ? entry_SYSRETQ_unsafe_stack+0xb/0x10
[    1.402400]  </#DF>
[    1.402401] Modules linked in:
[    1.402403] Dumping ftrace buffer:
[    1.402406]    (ftrace buffer empty)
[    1.402407] ---[ end trace 0000000000000000 ]---
[    1.402408] RIP: 0010:entry_SYSRETQ_unsafe_stack+0xb/0x10
[    1.402411] Code: c7 eb 08 48 89 c7 48 0f ba ef 3f 48 81 cf 00 08 00 00 48 81 cf 00 10 00 00 0f 22 df 58 5f 5c 0f 01 f8 0f 00
 2c 25 00 00 60 ab <0f> 0b 48 0f 07 cc 0f 1f 44 00 00 56 48 8b 74 24 08 48 89 7c 24 08
[    1.402412] RSP: 0018:00007ffe253461f8 EFLAGS: 000100c6
[    1.402413] RAX: 000055e5c94f7000 RBX: 00007f3d8d9b4e80 RCX: 00007f3d8d9b8f9b
[    1.402414] RDX: 0000000000000000 RSI: 00007ffe253461ec RDI: 0000000000000000
[    1.402415] RBP: 00007ffe25346290 R08: 0000000000000000 R09: 0000000000000022
[    1.402416] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f3d8d993000
[    1.402417] R13: 0000002300000007 R14: 0000000000000007 R15: 00007ffe253462a0
[    1.402419] FS:  0000000000000000(0000) GS:ffff906d3bc00000(0000) knlGS:ffff906d3bc00000
[    1.402420] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.402421] CR2: 00007ffe253461e8 CR3: 00000001002a8003 CR4: 00000000007706f0
[    1.402422] PKRU: 55555554
[    1.402423] Kernel panic - not syncing: Fatal exception in interrupt
[    1.402551] Dumping ftrace buffer:
[    1.402552]    (ftrace buffer empty)
[    1.402552] Kernel Offset: 0x29400000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
                              ^
			      Note the KASLR offset
			      ~~~~~~~~~~~~~~~~~~~~~

Disassembling the code stream in the trace ... :

eb 08 48 89 c7 48 0f ba ef 3f 48 81 cf 00 08 00 00 48 81 cf 00 10 00 00 0f 22 df 58 5f 5c 0f 01 f8 0f 00 2c 25 00 00 60 ab 0f 0b 48 0f 07 cc 0f 1f 44 00 00 56 48 8b 74 24 08 48 89 7c 24 08

.. gives:

  jmp 0xa
  mov rdi, rax
  bts rdi, 0x3f
  or rdi, 0x800
  or rdi, 0x1000
  mov cr3, rdi
  pop rax
  pop rdi
  pop rsp
  swapgs
  verw word ptr [0xffffffffab600000]       <----- mds_verw_sel
  ud2
  sysretq
  int3
  nop dword ptr [rax + rax]
  push rsi
  mov rsi, qword ptr [rsp + 8]
  mov qword ptr [rsp + 8], rdi

$ objdump -S --disassemble=mds_verw_sel vmlinux

ffffffff82200000 <mds_verw_sel>:
ffffffff82200000:       18 00                   sbb    %al,(%rax)

Adding KASLR offset to mds_verw_sel:

  0xffffffff82200000 + 0x29400000 = 0xffffffffab600000

which is the address of mds_verw_sel after KASLR that we saw in the code
stream disassembly. To me it looks like fixed addresses for VERW is
working as intended. Please let me know if I am missing something. It
will be great if someone can independently verify this.

Even with fixed addressing working with KASLR it may still be a good
idea to stick with RIP relative addresses as they are less likely to
be broken with relocation.

And sorry for the noise.

