Return-Path: <linux-kernel+bounces-112832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 152B2887ECA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 21:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 388181C20B5F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 20:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0228711190;
	Sun, 24 Mar 2024 20:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BjMfNKjc"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19791A28C
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 20:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711310746; cv=none; b=lXntgL8gRXpHyN+88Wr+v4iC/AjwIUmFO5f2O8ntmeqqxop5Th6JR/mlY9yMcJY/ueeamR/2c/VL2PW6RBQ5BwhkM+QlVDVYW2wU0Xkab+waBV8ltofUpRr+e6qhy7D6ETEM1vokt5iAmicW7sw78+FH7iLJ4GK9S/DuFXcHrnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711310746; c=relaxed/simple;
	bh=cW+YU1XlZ5vYFaTFF3vKz0kL8bnQjxLtI410MCC6MUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHGqWsxW5K2uH2AVGI/7TsPe/rtwZ0g02p1xdHStuIj3QVqsHtZWfEYCTvupoWDcBZU1T6oIP2ZVDNl92PDXnZKtvWkovOLtZZjL0+1QjzKvW8v3/uLu8kahTb5XK1ohSe0OhguHiYlMR5klgs+i86IBeqi9vNu7JcTyMDX2zxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BjMfNKjc; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6B46740E016C;
	Sun, 24 Mar 2024 20:05:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id GKOOIudFRk0j; Sun, 24 Mar 2024 20:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711310736; bh=82hqTK4pWEYKzLLuwyP+q3ZaxSRcGvFQDLUeU9hdfYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BjMfNKjcLm/kw/p+0bt0FqVm3Nh/bAaBp0b/Sr3dDxuxDuguYfM4cwONFncL60vGm
	 LpnOdjFSFib5Ai8WU7R1ANtWj/GHwIaOpXPPkc1Ij46/IHC+47m6Tc3bcaFbBfIdQl
	 AEdRImE/rNRFs9B1Z/e4fdQhd44tScLGeY7k9FYciqqtoePFk63q51YP4ZWMAkhDlc
	 C/0HlAm2ceagO6VwGVUHwtNEPNqLbUQcztHBVvTg3iW7DzD9YDGBHuVbvEVE7gdcaB
	 AtVOMLiNkEA6g4TnlHbulSdaxAqp8byne6dCygvHEy/AzHHsn7zkgRQR6MCLzHWrAl
	 sdSNVGHw7jBg4XrnP79JaK2EHSXnFilT3ynLVDHlkHLUPti+eSrrtu+96hpKCRYxq0
	 lHBneDlnI7KXm97VmH78fKZGdJzzhq4J9M7zeYynybOta5Y+FkvzOsJaEwj0MNw3HR
	 Xb335bG5wNXnYwR0yxj4qd55puvatnlaADG4XtMltlXzDTIZipogQlrjBRKljMavka
	 z86DgEc85W1I4URx5bHdOg86c1yVEe3eAeGng8c8pipGQ7PXUJXzXS/XIeqI4moEeX
	 CBAkxZcf7WjuscoH3ujctJgvXMDzwW3wcGHbr1BgqDswEh9PWS+D2TaeXXqr2TiUzW
	 E+GRU1kSnOCWdPJUsfpHPW8c=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 33E8140E01A0;
	Sun, 24 Mar 2024 20:05:32 +0000 (UTC)
Date: Sun, 24 Mar 2024 21:05:25 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	X86 ML <x86@kernel.org>
Subject: [PATCH -v2] x86/CPU/AMD: Improve the erratum 1386 workaround
Message-ID: <20240324200525.GBZgCHhYFsBj12PrKv@fat_crate.local>
References: <20240321120548.22687-1-bp@alien8.de>
 <20240321120548.22687-2-bp@alien8.de>
 <79125c93-285c-43f8-ac05-87c34c99e6bb@maciej.szmigiero.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <79125c93-285c-43f8-ac05-87c34c99e6bb@maciej.szmigiero.name>

On Thu, Mar 21, 2024 at 04:21:39PM +0100, Maciej S. Szmigiero wrote:
> On 21.03.2024 13:05, Borislav Petkov wrote:
> > From: "Borislav Petkov (AMD)" <bp@alien8.de>
> > 
> > Disable XSAVES only on machines which haven't loaded the microcode
> > revision containing the erratum fix.
> > 
> > This will come in handy when running archaic OSes as guests. OSes whose
> > brilliant programmers thought that CPUID is overrated and one should not
> > query it but use features directly, ala shoot first, ask questions
> > later... but only if you're alive after the shooting.
> > 
> > Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> > Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> > Cc: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> > ---
> 
> Tested-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>

Yeah, thanks but still not good enough. Turns out we already have the
min microcode revision testing functionality so there's no need for me
to reinvent the wheel.

No harm no foul, tho, the stuff in those two previous patches I will use
in the microcode loader soon for simplifying the loading.

Here's one *final* variant, I promise! :-)

Sorry about that.

---
From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Sun, 24 Mar 2024 20:51:35 +0100
Subject: [PATCH -v2] x86/CPU/AMD: Improve the erratum 1386 workaround

Disable XSAVES only on machines which haven't loaded the microcode
revision containing the erratum fix.

This will come in handy when running archaic OSes as guests. OSes whose
brilliant programmers thought that CPUID is overrated and one should not
query it but use features directly, ala shoot first, ask questions
later... but only if you're alive after the shooting.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
---
 arch/x86/include/asm/cpu_device_id.h |  8 ++++++++
 arch/x86/kernel/cpu/amd.c            | 12 ++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/x86/include/asm/cpu_device_id.h b/arch/x86/include/asm/cpu_device_id.h
index eb8fcede9e3b..bf4e065cf1e2 100644
--- a/arch/x86/include/asm/cpu_device_id.h
+++ b/arch/x86/include/asm/cpu_device_id.h
@@ -190,6 +190,14 @@ struct x86_cpu_desc {
 	.x86_microcode_rev	= (revision),			\
 }
 
+#define AMD_CPU_DESC(fam, model, stepping, revision) {		\
+	.x86_family		= (fam),			\
+	.x86_vendor		= X86_VENDOR_AMD,		\
+	.x86_model		= (model),			\
+	.x86_stepping		= (stepping),			\
+	.x86_microcode_rev	= (revision),			\
+}
+
 extern const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match);
 extern bool x86_cpu_has_min_microcode_rev(const struct x86_cpu_desc *table);
 
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 6d8677e80ddb..873f0fdc2ef8 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -13,6 +13,7 @@
 #include <asm/apic.h>
 #include <asm/cacheinfo.h>
 #include <asm/cpu.h>
+#include <asm/cpu_device_id.h>
 #include <asm/spec-ctrl.h>
 #include <asm/smp.h>
 #include <asm/numa.h>
@@ -802,6 +803,11 @@ static void init_amd_bd(struct cpuinfo_x86 *c)
 	clear_rdrand_cpuid_bit(c);
 }
 
+static const struct x86_cpu_desc erratum_1386_microcode[] = {
+	AMD_CPU_DESC(0x17,  0x1, 0x2, 0x0800126e),
+	AMD_CPU_DESC(0x17, 0x31, 0x0, 0x08301052),
+};
+
 static void fix_erratum_1386(struct cpuinfo_x86 *c)
 {
 	/*
@@ -811,7 +817,13 @@ static void fix_erratum_1386(struct cpuinfo_x86 *c)
 	 *
 	 * Affected parts all have no supervisor XSAVE states, meaning that
 	 * the XSAVEC instruction (which works fine) is equivalent.
+	 *
+	 * Clear the feature flag only on microcode revisions which
+	 * don't have the fix.
 	 */
+	if (x86_cpu_has_min_microcode_rev(erratum_1386_microcode))
+		return;
+
 	clear_cpu_cap(c, X86_FEATURE_XSAVES);
 }
 
-- 
2.43.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

