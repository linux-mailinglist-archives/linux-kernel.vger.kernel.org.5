Return-Path: <linux-kernel+bounces-166232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D6D8B97DA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2EE61C22EED
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611FB54FA0;
	Thu,  2 May 2024 09:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Hz+jF8+E"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE93D3399F
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 09:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714642564; cv=none; b=cMsRQ7zZuJ89aP6V+01b/sZbZ0bAsl6cnkogk9G7/5HwXkDUq5DC6bG7aqNEAAGAzskaJn/63a7L7BbVUgkGoR5JFSJnDHX5JJhZY2CkzSLoT3ShwiDmWFjPChaNe26DpPltqEAZmFpNSy4jmckCsnhxCwOYY7SzZxxxvnANhR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714642564; c=relaxed/simple;
	bh=2aTCyavI6LshqbkjZ0UFINRrKMQ2FVlXeJ1I7H/hLRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icn7KthCnOWSTYDxAy00BWy7oJUawrotmAUor+6tMVZeJWc/jHPscRRVI+DX/VSui+zaZLv80D0M38wQauw37rtjFu+jIhBqVQw54HfUvYLvhrWRQt90OGL3JpQtCFgOgcxT93kVF0ECnbZ32f3IB32M8MfXgK/zbgFuqGv1Cqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Hz+jF8+E reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 665ED40E01A3;
	Thu,  2 May 2024 09:35:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id KSB0DJ7EMwkt; Thu,  2 May 2024 09:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714642540; bh=dorBD1OH7eDSHdWk0QDptXqjjj2UqAFZRRg4RSaaZ9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hz+jF8+EfYoHwvErWGPCRIhERnG5BvJlOZrY6VPTFvBfPS9YUifvjptASlZiC9t3L
	 hX0qn5voXVVORjxOIbeXVcGgRBE0oKtgJJHv4sZ9zx4MUHXNx68Q5Q5MDq1YpilGIf
	 qukme+CoVEnUmsyFgUya0wg/7gq6G3Jw/hIAA67iKtoAfDuPgLrJOUNn0w8Bk4JSWl
	 aSQJdsYMRDLPXrO33X4ZJVkGMwCOo/udwCAVTuS63yF5gqJGif9u5BmuY2FxLF7lqf
	 t0M0yzdWj3zXDcYhD91CrLs0iwvDfAk4P8iCoi5CBYeYlzKS71b7wAGQyickL5hbhd
	 laPEANftXQzH/hfTc0T1izzzfjDtUcn+hVka2CdjD1a0/XGU0HqlkmZ+z1FGmdCM1s
	 Ndd41pngN+DB6OUYhPyS2GZ4ZVcAvx5jOL53LKFzqiozXJ+2bO6+1Q05S5dQTeXfQ5
	 kbH3YEBmZYCX1gtbtQGqCofaZAuvMXVp9YmhhEg2fbde19p3q+8c0zw0VbtnBVoJVO
	 VKnQ4Fc8a686iEPWwgTURUVkaV558dMJC1KFdl4IG1QWZQxFWAvKgBQA+sChEV5e8m
	 cz1v96CTl56vnL6SHFlFxUTavwGhlCPHBCNZbqoFAFpXvRx/J2g+8t9OIbKtBy6Fk5
	 n/Wj4rx5FIpdWcvAGjhIB50I=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 74D1F40E0192;
	Thu,  2 May 2024 09:35:26 +0000 (UTC)
Date: Thu, 2 May 2024 11:35:20 +0200
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
Subject: Re: [PATCH v4 04/15] x86/sev: Check for the presence of an SVSM in
 the SNP Secrets page
Message-ID: <20240502093520.GRZjNeWLXU5j2UMOAM@fat_crate.local>
References: <cover.1713974291.git.thomas.lendacky@amd.com>
 <6cf54cac47f212f4c2b59b123855d8c183989022.1713974291.git.thomas.lendacky@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6cf54cac47f212f4c2b59b123855d8c183989022.1713974291.git.thomas.lendacky@amd.com>
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 10:58:00AM -0500, Tom Lendacky wrote:
> During early boot phases, check for the presence of an SVSM when runnin=
g
> as an SEV-SNP guest.
>=20
> An SVSM is present if not running at VMPL0 and the 64-bit value at offs=
et
> 0x148 into the secrets page is non-zero. If an SVSM is present, save th=
e
> SVSM Calling Area address (CAA), located at offset 0x150 into the secre=
ts
> page, and set the VMPL level of the guest, which should be non-zero, to
> indicate the presence of an SVSM.
>=20
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  .../arch/x86/amd-memory-encryption.rst        | 22 ++++++
>  arch/x86/boot/compressed/sev.c                |  8 +++
>  arch/x86/include/asm/sev-common.h             |  4 ++
>  arch/x86/include/asm/sev.h                    | 25 ++++++-
>  arch/x86/kernel/sev-shared.c                  | 70 +++++++++++++++++++
>  arch/x86/kernel/sev.c                         |  7 ++
>  6 files changed, 135 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/arch/x86/amd-memory-encryption.rst b/Documen=
tation/arch/x86/amd-memory-encryption.rst
> index 414bc7402ae7..32737718d4a2 100644
> --- a/Documentation/arch/x86/amd-memory-encryption.rst
> +++ b/Documentation/arch/x86/amd-memory-encryption.rst
> @@ -130,4 +130,26 @@ SNP feature support.
> =20
>  More details in AMD64 APM[1] Vol 2: 15.34.10 SEV_STATUS MSR
> =20
> +Secure VM Service Module (SVSM)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> +
> +SNP provides a feature called Virtual Machine Privilege Levels (VMPL).=
 The most
> +privileged VMPL is 0 with numerically higher numbers having lesser pri=
vileges.
> +More details in AMD64 APM[1] Vol 2: 15.35.7 Virtual Machine Privilege =
Levels.
> +
> +The VMPL feature provides the ability to run software services at a mo=
re
> +privileged level than the guest OS is running at. This provides a secu=
re

Too many "provides".

> +environment for services within the guest's SNP environment, while pro=
tecting
> +the service from hypervisor interference. An example of a secure servi=
ce
> +would be a virtual TPM (vTPM). Additionally, certain operations requir=
e the
> +guest to be running at VMPL0 in order for them to be performed. For ex=
ample,
> +the PVALIDATE instruction is required to be executed at VMPL0.
> +
> +When a guest is not running at VMPL0, it needs to communicate with the=
 software
> +running at VMPL0 to perform privileged operations or to interact with =
secure
> +services. This software running at VMPL0 is known as a Secure VM Servi=
ce Module
> +(SVSM). Discovery of an SVSM and the API used to communicate with it i=
s
> +documented in Secure VM Service Module for SEV-SNP Guests[2].

This paragraph needs to go second, not third.

Somehow that text is missing "restraint" and is all over the place.
Lemme try to restructure it:

"SNP provides a feature called Virtual Machine Privilege Levels (VMPL) wh=
ich
defines four privilege levels at which guest software can run. The most
privileged level is 0 and numerically higher numbers have lesser privileg=
es.
More details in the AMD64 APM[1] Vol 2, section "15.35.7 Virtual Machine
Privilege Levels", docID: 24593.

When using that feature, different services can run at different protecti=
on
levels, apart from the guest OS but still within the secure SNP environme=
nt.
They can provide services to the guest, like a vTPM, for example.

When a guest is not running at VMPL0, it needs to communicate with the so=
ftware
running at VMPL0 to perform privileged operations or to interact with sec=
ure
services. An example fur such a privileged operation is PVALIDATE which i=
s
*required* to be executed at VMPL0.

In this scenario, the software running at VMPL0 is usually called a Secur=
e VM
Service Module (SVSM). Discovery of an SVSM and the API used to communica=
te
with it is documented in "Secure VM Service Module for SEV-SNP Guests", d=
ocID:
58019."

How's that?

> +
>  [1] https://www.amd.com/content/dam/amd/en/documents/processor-tech-do=
cs/programmer-references/24593.pdf
> +[2] https://www.amd.com/content/dam/amd/en/documents/epyc-technical-do=
cs/specifications/58019.pdf

Yeah, about those links - they get stale pretty quickly. I think it suffi=
ces to
explain what the document is and what it is called so that one can find i=
t by
searching the web. See what I did above.

> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/=
sev.c
> index 0457a9d7e515..cb771b380a6b 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -12,6 +12,7 @@
>   */
>  #include "misc.h"
> =20
> +#include <linux/mm.h>

Please do not include a kernel-proper header into the decompresssor.
Those things are solved by exposing the shared *minimal* functionality
into

arch/x86/include/asm/shared/

There are examples there.

By the looks of it:

In file included from arch/x86/boot/compressed/sev.c:130:
arch/x86/boot/compressed/../../kernel/sev-shared.c: In function =E2=80=98=
setup_svsm_ca=E2=80=99:
arch/x86/boot/compressed/../../kernel/sev-shared.c:1332:14: warning: impl=
icit declaration of function =E2=80=98PAGE_ALIGNED=E2=80=99; did you mean=
 =E2=80=98IS_ALIGNED=E2=80=99? [-Wimplicit-function-declaration]
 1332 |         if (!PAGE_ALIGNED(caa))
      |              ^~~~~~~~~~~~
      |              IS_ALIGNED

it'll need PAGE_ALIGNED and IS_ALIGNED into an arch/x86/include/asm/share=
d/mm.h
header.

>  #include <asm/bootparam.h>
>  #include <asm/pgtable_types.h>
>  #include <asm/sev.h>

..

> +static void __head setup_svsm_ca(const struct cc_blob_sev_info *cc_inf=
o)
> +{
> +	struct snp_secrets_page *secrets_page;
> +	u64 caa;
> +
> +	BUILD_BUG_ON(sizeof(*secrets_page) !=3D PAGE_SIZE);
> +
> +	/*
> +	 * RMPADJUST modifies RMP permissions of a lesser-privileged (numeric=
ally
> +	 * higher) privilege level. Here, clear the VMPL1 permission mask of =
the
> +	 * GHCB page. If the guest is not running at VMPL0, this will fail.
> +	 *
> +	 * If the guest is running at VMPL0, it will succeed. Even if that op=
eration
> +	 * modifies permission bits, it is still ok to do so currently becaus=
e Linux
> +	 * SNP guests running at VMPL0 only run at VMPL0, so VMPL1 or higher
> +	 * permission mask changes are a don't-care.
> +	 *
> +	 * Use __pa() since this routine is running identity mapped when call=
ed,
> +	 * both by the decompressor code and the early kernel code.
> +	 */

Let's not replicate that comment. Diff ontop:

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/se=
v.c
index cb771b380a6b..cde1890c8843 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -576,18 +576,7 @@ void sev_enable(struct boot_params *bp)
 		if (!(get_hv_features() & GHCB_HV_FT_SNP))
 			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
=20
-		/*
-		 * Enforce running at VMPL0.
-		 *
-		 * RMPADJUST modifies RMP permissions of a lesser-privileged (numerica=
lly
-		 * higher) privilege level. Here, clear the VMPL1 permission mask of t=
he
-		 * GHCB page. If the guest is not running at VMPL0, this will fail.
-		 *
-		 * If the guest is running at VMPL0, it will succeed. Even if that ope=
ration
-		 * modifies permission bits, it is still ok to do so currently because=
 Linux
-		 * SNP guests running at VMPL0 only run at VMPL0, so VMPL1 or higher
-		 * permission mask changes are a don't-care.
-		 */
+		/* Enforce running at VMPL0 - see comment above rmpadjust(). */
 		if (rmpadjust((unsigned long)&boot_ghcb_page, RMP_PG_SIZE_4K, 1))
 			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NOT_VMPL0);
 	}
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 350db22e66be..b168403c07be 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -204,6 +204,17 @@ static __always_inline void sev_es_nmi_complete(void=
)
 extern int __init sev_es_efi_map_ghcbs(pgd_t *pgd);
 extern void sev_enable(struct boot_params *bp);
=20
+/*
+ * RMPADJUST modifies RMP permissions of a lesser-privileged
+ * (numerically higher) privilege level. If @attrs=3D=3D0, it will attem=
pt
+ * to clear the VMPL1 permission mask of @vaddr. If the guest is not
+ * running at VMPL0, this will fail.
+ *
+ * If the guest is running at VMPL0, it will succeed. Even if that opera=
tion
+ * modifies permission bits, it is still ok to do so currently because L=
inux
+ * SNP guests running at VMPL0 only run at VMPL0, so VMPL1 or higher
+ * permission mask changes are a don't-care.
+ */
 static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigne=
d long attrs)
 {
 	int rc;
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 46ea4e5e118a..9ca54bcf0e99 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -1297,17 +1297,9 @@ static void __head setup_svsm_ca(const struct cc_b=
lob_sev_info *cc_info)
 	BUILD_BUG_ON(sizeof(*secrets_page) !=3D PAGE_SIZE);
=20
 	/*
-	 * RMPADJUST modifies RMP permissions of a lesser-privileged (numerical=
ly
-	 * higher) privilege level. Here, clear the VMPL1 permission mask of th=
e
-	 * GHCB page. If the guest is not running at VMPL0, this will fail.
-	 *
-	 * If the guest is running at VMPL0, it will succeed. Even if that oper=
ation
-	 * modifies permission bits, it is still ok to do so currently because =
Linux
-	 * SNP guests running at VMPL0 only run at VMPL0, so VMPL1 or higher
-	 * permission mask changes are a don't-care.
-	 *
-	 * Use __pa() since this routine is running identity mapped when called=
,
-	 * both by the decompressor code and the early kernel code.
+	 * See comment above rmpadjust() for details. Use __pa() since
+	 * this routine is running identity mapped when called both by
+	 * the decompressor code and the early kernel code.
 	 */
 	if (!rmpadjust((unsigned long)__pa(&boot_ghcb_page), RMP_PG_SIZE_4K, 1)=
)
 		return;

> +	if (!rmpadjust((unsigned long)__pa(&boot_ghcb_page), RMP_PG_SIZE_4K, =
1))
> +		return;
> +
> +	/*
> +	 * Not running at VMPL0, ensure everything has been properly supplied
> +	 * for running under an SVSM.
> +	 */
> +	if (!cc_info || !cc_info->secrets_phys || cc_info->secrets_len !=3D P=
AGE_SIZE)
> +		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SECRETS_PAGE);
> +
> +	secrets_page =3D (struct snp_secrets_page *)cc_info->secrets_phys;
> +	if (!secrets_page->svsm_size)
> +		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NO_SVSM);
> +
> +	if (!secrets_page->svsm_guest_vmpl)
> +		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SVSM_VMPL0);

0x15C	1 byte	SVSM_GUEST_VMPL		Indicates the VMPL at which the guest is ex=
ecuting.

Do I understand it correctly that this contains the VMPL of the guest and=
  the
SVSM is running below it?

IOW, SVSM should be at VMPL0 and the guest should be a at a level determi=
ned by
that value and it cannot be 0.

Just making sure I'm reading it right.

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

