Return-Path: <linux-kernel+bounces-152268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD4C8ABBA5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 15:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 773B5281A93
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 13:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266898C10;
	Sat, 20 Apr 2024 13:06:10 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB7117580
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 13:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713618369; cv=none; b=TgW6AJVISnN/t1CllRnx4C7S8RHwDABIr/l9KXg84L1xcZRd/Tp7U9/bVufjsKHhHlYSno6N5//TzmJDwRXkdmrD+b7hNOmKxvhttmV5KChQUaBGM9G/LH+jGf2V2LXYL98o+e6nAv1xIz8esCHgdakF42PIEYsF37wCmkEG0Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713618369; c=relaxed/simple;
	bh=9FNjsY4SfCCF83uhFcZiCjsGormsgNgUkcwz7Kbc7WE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5HU6kg6nCsaonCbDNAQwjuBQNKHN5i7ht8Q3xBzEslL2nFBddVV4XQ/+eCyu1sfiYCZ6/mZWjeANqF9NMlEJ+A3rw4sEDEx127Cuv6B1Sh6ub2JgqOgAJ7hYKUGL+kb+NCJUd00XPnIptB660enEsrDFh1Es7eMmUWdOGp1O2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 13D5B40E02A8;
	Sat, 20 Apr 2024 13:06:05 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jGdvA8dLsOo6; Sat, 20 Apr 2024 13:05:58 +0000 (UTC)
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 58DB940E00B2;
	Sat, 20 Apr 2024 13:05:52 +0000 (UTC)
Date: Sat, 20 Apr 2024 15:05:46 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: thomas.lendacky@amd.com, michael.roth@amd.com, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] x86/sev: Add callback to apply RMP table fixups
 for kexec.
Message-ID: <20240420130533.GNZiO9nShSxjxB-FQn@fat_crate.local>
References: <cover.1713212104.git.ashish.kalra@amd.com>
 <96b2949cf225501d686b47070c7bbad341e160a3.1713212104.git.ashish.kalra@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <96b2949cf225501d686b47070c7bbad341e160a3.1713212104.git.ashish.kalra@amd.com>

On Mon, Apr 15, 2024 at 09:09:24PM +0000, Ashish Kalra wrote:

> Subject: Re: [PATCH v2 2/2] x86/sev: Add callback to apply RMP table fixups for kexec.
										       ^
patch subject doesn't need a fullstop:						-------|

> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> Handle cases where the RMP table placement in the BIOS is
> not 2M aligned and then the kexec kernel could try to allocate
> from within that chunk and that causes a fatal RMP fault.

> Check if RMP table start & end physical range in e820_table
> is not aligned to 2MB and in that case use e820__range_update()
> to map this range to reserved.

Why do you keep explaining in your commit messages what a patch does?

Do not talk about *what* the patch is doing in the commit message - that
should be obvious from the diff itself. Rather, concentrate on the *why*
it needs to be done.

Imagine one fine day you're doing git archeology, you find the place in
the code about which you want to find out why it was changed the way it
is now.

You do git annotate <filename> ... find the line, see the commit id and
you do:

git show <commit id>

You read the commit message and there's just gibberish and nothing's
explaining *why* that change was done. And you start scratching your
head, trying to figure out why. Because the damn commit message is worth
sh*t.

> The callback to apply these RMP table fixups needs to be called
> after the e820 tables are setup/populated and before the e820 map
> has been converted to the standard Linux memory resources and e820 map
> is no longer used and modifying it has no effect.

This commit message is not even trying to summarize what was figured out
in previous review in the thread here:

https://lore.kernel.org/r/20240312184757.52699-1-Ashish.Kalra@amd.com

Please restructure this commit message using all the info from that
thread and use this structure, for example:

1. Prepare the context for the explanation briefly.

2. Explain the problem at hand.

3. "It happens because of <...>"

4. "Fix it by doing X"

5. "(Potentially do Y)."

And some of those above are optional depending on the issue being
explained.

For more detailed info, see
Documentation/process/submitting-patches.rst,
Section "2) Describe your changes".

Also, to the tone, from Documentation/process/submitting-patches.rst:

 "Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
  instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
  to do frotz", as if you are giving orders to the codebase to change
  its behaviour."

> Fixes: c3b86e61b756 ("x86/cpufeatures: Enable/unmask SEV-SNP CPU feature")
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>  arch/x86/include/asm/sev.h |  2 ++
>  arch/x86/mm/mem_encrypt.c  |  3 +++
>  arch/x86/virt/svm/sev.c    | 44 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 49 insertions(+)
> 
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index 7f57382afee4..6600ac467cf9 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -269,6 +269,7 @@ int rmp_make_private(u64 pfn, u64 gpa, enum pg_level level, u32 asid, bool immut
>  int rmp_make_shared(u64 pfn, enum pg_level level);
>  void snp_leak_pages(u64 pfn, unsigned int npages);
>  void kdump_sev_callback(void);
> +void snp_rmptable_e820_fixup(void);
>  #else
>  static inline bool snp_probe_rmptable_info(void) { return false; }
>  static inline int snp_lookup_rmpentry(u64 pfn, bool *assigned, int *level) { return -ENODEV; }
> @@ -282,6 +283,7 @@ static inline int rmp_make_private(u64 pfn, u64 gpa, enum pg_level level, u32 as
>  static inline int rmp_make_shared(u64 pfn, enum pg_level level) { return -ENODEV; }
>  static inline void snp_leak_pages(u64 pfn, unsigned int npages) {}
>  static inline void kdump_sev_callback(void) { }
> +static inline void snp_rmptable_e820_fixup(void) {}
>  #endif
>  
>  #endif
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index 6f3b3e028718..765ce94e4b89 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -102,6 +102,9 @@ void __init mem_encrypt_setup_arch(void)
>  	phys_addr_t total_mem = memblock_phys_mem_size();
>  	unsigned long size;
>  
> +	if (cpu_feature_enabled(X86_FEATURE_SEV_SNP))

We use CC_ATTR_HOST_SEV_SNP for host SNP support checks, including RMP
table viability.

Also, why isn't this called in snp_init()?

If there's a reason why (I think there is) put that reason as a comment
above it why this thing needs to be called here exactly.

> +		snp_rmptable_e820_fixup();

IOW, point to the comment above that function's definition.

> +
>  	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
>  		return;
>  
> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index ab0e8448bb6e..d999ff7f1671 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c
> @@ -163,6 +163,50 @@ bool snp_probe_rmptable_info(void)
>  	return true;
>  }
>  
> +/*
> + * Callback to do any RMP table fixups, needs to be called
> + * after e820__memory_setup(), after the e820 tables are
> + * setup/populated and before e820__reserve_resources(), before
> + * the e820 map has been converted to the standard Linux memory
> + * resources and e820 map is no longer used and modifying it
> + * has no effect.
> + */
> +void __init snp_rmptable_e820_fixup(void)
> +{
> +	u64 pa;
> +
> +	/*
> +	 * Handle cases where the RMP table placement in the BIOS is not 2M aligned
> +	 * and then the kexec kernel could try to allocate from within that chunk
> +	 * and that causes a fatal RMP fault.

Merge this comment with the one above the function and put it all there.

> Check if RMP table start & end
> +	 * physical range in e820_table is not aligned to 2MB and in that case use
> +	 * e820__range_update() to map this range to reserved, e820__range_update()
> +	 * nicely handles partial range update and also merges any consecutive
> +	 * ranges of the same type.
> +	 */

This comment talks about what this does and is kinda obvious but then
talks about e820__range_update() and not the other ones. Just put the
gist of what this is supposed to do and do not explain the code step by
step.

What is really missing here and what is not really trivial is why all
three e820 tables need updating.

> +	pa = probed_rmp_base;
> +	if (!IS_ALIGNED(pa, PMD_SIZE)) {
> +		pa = ALIGN_DOWN(pa, PMD_SIZE);
> +		if (e820__mapped_any(pa, pa + PMD_SIZE, E820_TYPE_RAM)) {
> +			pr_info("Reserving start of RMP table on a 2MB boundary [0x%016llx]\n", pa);
> +			e820__range_update(pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
> +			e820__range_update_kexec(pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
> +			e820__range_update_firmware(pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
> +		}
> +	}
> +
> +	pa = probed_rmp_base + probed_rmp_size;
> +	if (!IS_ALIGNED(pa, PMD_SIZE)) {
> +		pa = ALIGN_DOWN(pa, PMD_SIZE);
> +		if (e820__mapped_any(pa, pa + PMD_SIZE, E820_TYPE_RAM)) {
> +			pr_info("Reserving end of RMP table on a 2MB boundary [0x%016llx]\n", pa);
> +			e820__range_update(pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
> +			e820__range_update_kexec(pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
> +			e820__range_update_firmware(pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
> +		}
> +	}
> +}

Ontop for less duplication:

diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index be17661fee9b..118dfe61f80e 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -163,6 +163,21 @@ bool snp_probe_rmptable_info(void)
 	return true;
 }
 
+static void __init __snp_e820_tables_fixup(u64 pa)
+{
+	if (IS_ALIGNED(pa, PMD_SIZE))
+		return;
+
+	pa = ALIGN_DOWN(pa, PMD_SIZE);
+	if (!e820__mapped_any(pa, pa + PMD_SIZE, E820_TYPE_RAM))
+		return;
+
+	pr_info("Reserving chunk of RMP table on a 2MB boundary [0x%016llx]\n", pa);
+	e820__range_update(pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
+	e820__range_update_kexec(pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
+	e820__range_update_firmware(pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
+}
+
 /*
  * Callback to do any RMP table fixups, needs to be called
  * after e820__memory_setup(), after the e820 tables are
@@ -173,8 +188,6 @@ bool snp_probe_rmptable_info(void)
  */
 void __init snp_rmptable_e820_fixup(void)
 {
-	u64 pa;
-
 	/*
 	 * Handle cases where the RMP table placement in the BIOS is not 2M aligned
 	 * and then the kexec kernel could try to allocate from within that chunk
@@ -184,27 +197,8 @@ void __init snp_rmptable_e820_fixup(void)
 	 * nicely handles partial range update and also merges any consecutive
 	 * ranges of the same type.
 	 */
-	pa = probed_rmp_base;
-	if (!IS_ALIGNED(pa, PMD_SIZE)) {
-		pa = ALIGN_DOWN(pa, PMD_SIZE);
-		if (e820__mapped_any(pa, pa + PMD_SIZE, E820_TYPE_RAM)) {
-			pr_info("Reserving start of RMP table on a 2MB boundary [0x%016llx]\n", pa);
-			e820__range_update(pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
-			e820__range_update_kexec(pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
-			e820__range_update_firmware(pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
-		}
-	}
-
-	pa = probed_rmp_base + probed_rmp_size;
-	if (!IS_ALIGNED(pa, PMD_SIZE)) {
-		pa = ALIGN_DOWN(pa, PMD_SIZE);
-		if (e820__mapped_any(pa, pa + PMD_SIZE, E820_TYPE_RAM)) {
-			pr_info("Reserving end of RMP table on a 2MB boundary [0x%016llx]\n", pa);
-			e820__range_update(pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
-			e820__range_update_kexec(pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
-			e820__range_update_firmware(pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
-		}
-	}
+	__snp_e820_tables_fixup(probed_rmp_base);
+	__snp_e820_tables_fixup(probed_rmp_base + probed_rmp_size);
 }
 
 /*

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

