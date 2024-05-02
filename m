Return-Path: <linux-kernel+bounces-166513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C988B9BBA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F086C1F22AFB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F48413C673;
	Thu,  2 May 2024 13:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="X39r+wIW"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA80E4776E
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 13:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714657135; cv=none; b=khPxHl3n2JlkmxGg4JZwbgqwnF2sqaiymYYZVqXahCGo4biz/yLy7xdDcLfO1tTKq4WtAI4NWxhlPP+YDXv1hUngBdNoWaXEK85jItAcUmS/fL9dB8u5jM8KfODwI/TGL+cuf2DT1ghsie+5svbFMjpLRe7I+v48T/JbuA47sMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714657135; c=relaxed/simple;
	bh=ScOkqAHpUXznhwm8vbi0lYVOvidWa+p7C1YfcaGK+VU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NE9oAB7HmpDH21bO+Ql1XMVbloKrycGw0Ag24CGi1fNqNoHdWmOD/qcZkCjeB8Edgl4KikeNSl3MdIX4xz5FbKBkE8voK9zmC+0/p7yaxBu5gC3jr2mgqFVbwDJoygj8d2ygk85Z4HMOrq85oLvvfvskofelmf0uZFVUvlLFOz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=X39r+wIW; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 775AC40E01A3;
	Thu,  2 May 2024 13:38:51 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id l_s99-7BjvYn; Thu,  2 May 2024 13:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714657127; bh=NyYmeY7t/s2GQQKn87wSqq3dsZFSPDINkuen5Y8kiMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X39r+wIWRnzuxWsssjH553F9MdeacckWybvXWlb2Tk9cjCOG+auPv3jccG/PqlhcK
	 +6X8MJRtJFq7psS/POAiGA4xH1h1tbIr10GhExT7s2OPzDtLPjE/25Nsoxgwv4mdn6
	 FDI0alDsD6e123aZYhhQNR36rTzL9FPVPo200BS76E8TP8FdNerzQfhylSmDamF77o
	 2AkA0K9ETkpoWT7+utJSK/7gWQlJsUQKiDWItzzIYoEn3vhLymlOiVZbH40uOef++f
	 LOhBJ0nBbG5XnCV700srKFMTgKw/BtDT8MKxNZxVPEnDTmvZzgHFawmYS/pUJI30/U
	 vbu4/ayAKOE83QpN2qyaQ8OsomwPHVstLL1aBZrm6pDF7kmatPBLaSuu1qMBfXmHou
	 fbbGh1d3/N+4MCMisoZHJZ/75BCgEDRRMIIVhlhcKBcpVVx4Sa+qKfM3V00pSq4NIF
	 8/HMKXy5z623YLc78SfFCSdUZNEeqCUbN8ucrun2njbVax9WdCTv6suy93FgId00T/
	 l92sXc4Vk2pTF4pM2AuwSOky1fU0qZWDaKhrGR9R82s+95xurzb79DJA6+VULN9ic/
	 oQbigxFl0CcKYAibaEw/gaj1yweE/SjGZZJW2DEuSWNJAwKv3b+8htzMgLmTUa2q41
	 RBHLuHoa+0ZDLmvol0+VBFzg=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D1F5640E0192;
	Thu,  2 May 2024 13:38:26 +0000 (UTC)
Date: Thu, 2 May 2024 15:38:22 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv10 05/18] x86/kexec: Keep CR4.MCE set during kexec for
 TDX guest
Message-ID: <20240502133822.GCZjOXThULx5nZPeg5@fat_crate.local>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-6-kirill.shutemov@linux.intel.com>
 <20240430130323.GAZjDsG00Xdhv5mv8W@fat_crate.local>
 <rneuozes2fafzowtyftfhsqznapdr4tlfwpd5bbuw5ssvflaxo@fq3ufljshsid>
 <20240502132229.GBZjOTlWg-CzSkrKA0@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240502132229.GBZjOTlWg-CzSkrKA0@fat_crate.local>

On Thu, May 02, 2024 at 03:22:29PM +0200, Borislav Petkov wrote:
> On Tue, Apr 30, 2024 at 05:49:08PM +0300, Kirill A. Shutemov wrote:
> > I assume all of these new labels have to be prefixed with ".L", right?
> 
> Oh yes, please.

Here's a fixed version:

---
From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Tue, 30 Apr 2024 15:00:16 +0200
Subject: [PATCH] x86/relocate_kernel: Use named labels for less confusion

That identity_mapped() functions was loving that "1" label to the point
of completely confusing its readers.

Use named labels in each place for clarity.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/relocate_kernel_64.S | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 8e2037d78a1f..7f70707c7372 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -152,13 +152,15 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	 */
 	movl	$X86_CR4_PAE, %eax
 	testq	$X86_CR4_LA57, %r13
-	jz	1f
+	jz	.Lno_la57
 	orl	$X86_CR4_LA57, %eax
-1:
+.Lno_la57:
+
 	testq	$X86_CR4_MCE, %r13
-	jz	1f
+	jz	.Lmca_off
 	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %eax), X86_FEATURE_TDX_GUEST
-1:
+.Lmca_off:
+
 	movq	%rax, %cr4
 
 	jmp 1f
@@ -173,9 +175,9 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	 * used by kexec. Flush the caches before copying the kernel.
 	 */
 	testq	%r12, %r12
-	jz 1f
+	jz .Lsme_off
 	wbinvd
-1:
+.Lsme_off:
 
 	movq	%rcx, %r11
 	call	swap_pages
@@ -195,7 +197,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	 */
 
 	testq	%r11, %r11
-	jnz 1f
+	jnz .Lrelocate
 	xorl	%eax, %eax
 	xorl	%ebx, %ebx
 	xorl    %ecx, %ecx
@@ -216,7 +218,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	ret
 	int3
 
-1:
+.Lrelocate:
 	popq	%rdx
 	leaq	PAGE_SIZE(%r10), %rsp
 	ANNOTATE_RETPOLINE_SAFE
-- 
2.43.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

