Return-Path: <linux-kernel+bounces-149202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E701A8A8D1E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B205B24A86
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1126E4AEDB;
	Wed, 17 Apr 2024 20:41:02 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866DD481A8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 20:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713386461; cv=none; b=LdGRskCWa+LLNnBpU3YKpwxbfsmwk7gTXqT0cnHB8GfEMA0StSMzXvVxH2DuJe5ClQG2aU4gZxinp/xWFerG6mDxSh+zwj877Ahme3IqFyXdSUFqU8JhP+bM2KVyAhyYf7ZBJBbC0qcQQDVFOkG4f0KOtSefU8SwuU65zANSFNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713386461; c=relaxed/simple;
	bh=xgZogUj89WqzyBAwgAsuVQjVj5WTZ3i1Q7lV9smEZo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+sIYtcU51xEtm2JgaBqDlAKnJN2kCrqZmVYXSXOxMDnKiwszR5FQWBkdUxJg7t0wg9l04kuCIGXdd46LzmMZRR754cWeSydOI5TP75WzJImkumNTBm3I7YxFghI6JRZidlFAEYjN8YavCW2U6aVaJPng5Q/eTnxajq/4Mw26g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2342440E0177;
	Wed, 17 Apr 2024 20:40:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id oCVnpNi6NNcn; Wed, 17 Apr 2024 20:40:52 +0000 (UTC)
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 110B140E0187;
	Wed, 17 Apr 2024 20:40:36 +0000 (UTC)
Date: Wed, 17 Apr 2024 22:40:30 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-coco@lists.linux.dev, svsm-devel@coconut-svsm.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH v3 03/14] x86/sev: Check for the presence of an SVSM in
 the SNP Secrets page
Message-ID: <20240417204030.GIZiAzvuLG6qcFFMyT@fat_crate.local>
References: <cover.1711405593.git.thomas.lendacky@amd.com>
 <e8d4877f3b7248031931ed193c026c42dd3363ef.1711405593.git.thomas.lendacky@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e8d4877f3b7248031931ed193c026c42dd3363ef.1711405593.git.thomas.lendacky@amd.com>

On Mon, Mar 25, 2024 at 05:26:22PM -0500, Tom Lendacky wrote:
> During early boot phases, check for the presence of an SVSM when running
> as an SEV-SNP guest.
> 
> An SVSM is present if the 64-bit value at offset 0x148 into the secrets
> page is non-zero. If an SVSM is present, save the SVSM Calling Area
> address (CAA), located at offset 0x150 into the secrets page, and set
> the VMPL level of the guest, which should be non-zero, to indicate the
> presence of an SVSM.

Where are we pointing to the SVSM spec?

This is in the 0th message

https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf

but pls add it to our documentation here:

Documentation/arch/x86/amd-memory-encryption.rst

> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/boot/compressed/sev.c    | 35 ++++++++---------
>  arch/x86/include/asm/sev-common.h |  4 ++
>  arch/x86/include/asm/sev.h        | 25 +++++++++++-
>  arch/x86/kernel/sev-shared.c      | 64 +++++++++++++++++++++++++++++++
>  arch/x86/kernel/sev.c             | 16 ++++++++
>  5 files changed, 125 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index 49dc9661176d..fe61ff630c7e 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -12,6 +12,7 @@
>   */
>  #include "misc.h"
>  
> +#include <linux/mm.h>
>  #include <asm/bootparam.h>
>  #include <asm/pgtable_types.h>
>  #include <asm/sev.h>
> @@ -29,6 +30,15 @@
>  static struct ghcb boot_ghcb_page __aligned(PAGE_SIZE);
>  struct ghcb *boot_ghcb;
>  
> +/*
> + * SVSM related information:
> + *   When running under an SVSM, the VMPL that Linux is executing at must be
> + *   non-zero. The VMPL is therefore used to indicate the presence of an SVSM.
> + */
> +static u8 vmpl __section(".data");
> +static u64 boot_svsm_caa_pa __section(".data");
> +static struct svsm_ca *boot_svsm_caa __section(".data");

Explain what those last 2 are in comments above it pls.

>  /*
>   * SNP_FEATURES_IMPL_REQ is the mask of SNP features that will need
>   * guest side implementation for proper functioning of the guest. If any
> @@ -480,6 +472,13 @@ static bool early_snp_init(struct boot_params *bp)
>  	 */
>  	setup_cpuid_table(cc_info);
>  
> +	/*
> +	 * Record the SVSM Calling Area address (CAA) if the guest is not

			Calling Area (CA) address

> +	 * running at VMPL0. The CA will be used to communicate with the

and then you can use "CA" here.

> +	 * SVSM to perform the SVSM services.
> +	 */
> +	setup_svsm_ca(cc_info);
> +
>  	/*
>  	 * Pass run-time kernel a pointer to CC info via boot_params so EFI
>  	 * config table doesn't need to be searched again during early startup
> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
> index b463fcbd4b90..68a8cdf6fd6a 100644
> --- a/arch/x86/include/asm/sev-common.h
> +++ b/arch/x86/include/asm/sev-common.h
> @@ -159,6 +159,10 @@ struct snp_psc_desc {
>  #define GHCB_TERM_NOT_VMPL0		3	/* SNP guest is not running at VMPL-0 */
>  #define GHCB_TERM_CPUID			4	/* CPUID-validation failure */
>  #define GHCB_TERM_CPUID_HV		5	/* CPUID failure during hypervisor fallback */
> +#define GHCB_TERM_SECRETS_PAGE		6	/* Secrets page failure */
> +#define GHCB_TERM_NO_SVSM		7	/* SVSM is not advertised in the secrets page */
> +#define GHCB_TERM_SVSM_VMPL0		8	/* SVSM is present but has set VMPL to 0 */
> +#define GHCB_TERM_SVSM_CAA		9	/* SVSM is present but the CA is not page aligned */

"CAA" in the comment I guess. :)

> +/*
> + * Maintain the GPA of the SVSM Calling Area (CA) in order to utilize the SVSM
> + * services needed when not running in VMPL0.
> + */
> +static void __head setup_svsm_ca(const struct cc_blob_sev_info *cc_info)
> +{
> +	struct snp_secrets_page_layout *secrets_page;

Why was that thing ever called "_layout" and not simply
snp_secrets_page?

Fix it?

> +	u64 caa;
> +
> +	BUILD_BUG_ON(sizeof(*secrets_page) != PAGE_SIZE);

Put it in the header under the struct definition I guess.

> +	/*
> +	 * Use __pa() since this routine is running identity mapped when
> +	 * called, both by the decompressor code and the early kernel code.
> +	 */
> +	if (running_at_vmpl0((void *)__pa(&boot_ghcb_page)))
> +		return;
> +
> +	/*
> +	 * Not running at VMPL0, ensure everything has been properly supplied
> +	 * for running under an SVSM.
> +	 */
> +	if (!cc_info || !cc_info->secrets_phys || cc_info->secrets_len != PAGE_SIZE)
> +		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SECRETS_PAGE);
> +
> +	secrets_page = (struct snp_secrets_page_layout *)cc_info->secrets_phys;
> +	if (!secrets_page->svsm_size)
> +		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NO_SVSM);
> +
> +	if (!secrets_page->svsm_guest_vmpl)
> +		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SVSM_VMPL0);
> +
> +	vmpl = secrets_page->svsm_guest_vmpl;
> +
> +	caa = secrets_page->svsm_caa;
> +	if (!PAGE_ALIGNED(caa))
> +		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SVSM_CAA);
> +
> +	/*
> +	 * The CA is identity mapped when this routine is called, both by the
> +	 * decompressor code and the early kernel code.
> +	 */
> +	boot_svsm_caa = (struct svsm_ca *)caa;
> +	boot_svsm_caa_pa = caa;
> +}
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index b59b09c2f284..64799a04feb4 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -135,6 +135,15 @@ struct ghcb_state {
>  static DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
>  static DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
>  
> +/*
> + * SVSM related information:
> + *   When running under an SVSM, the VMPL that Linux is executing at must be
> + *   non-zero. The VMPL is therefore used to indicate the presence of an SVSM.
> + */
> +static u8 vmpl __ro_after_init;
> +static struct svsm_ca *boot_svsm_caa __ro_after_init;
> +static u64 boot_svsm_caa_pa __ro_after_init;

Uff, duplication.

Let's put them in sev-shared.c pls and avoid that.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

