Return-Path: <linux-kernel+bounces-93933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7194987371E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8EF41F21E10
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188E712F5B6;
	Wed,  6 Mar 2024 12:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="UfEtVolq"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921DB12D767;
	Wed,  6 Mar 2024 12:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709729825; cv=none; b=MWKbXzQKr0ZG8CX5wwvm2fBX1wRegu6pwzSQ/Dld07P/C4SbQ0E0ab0Mchmhpwrd718RPdxOMylCfO/HYjI8yFUiKuQ//pHaf6ZgiL3KttmHSMva8C3UrAiu8djkVFSCWWJM6kWAhKVC18779fdyQ/yWBPSCTudh00t9Jpif9V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709729825; c=relaxed/simple;
	bh=33SuGDVKhyAmIEY/wnNy0LGNUvfWeALTFWmEh2mPwPA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JoTvS75aw5Z+85b0WqdtgjEHGNwhtcs3jdmGjHsYmRVyVMjWpUHs/NR4RXPY+NcNPzhreluNQm0mt4zUHsjTUlr0tgJuqgqLSMAYJmq/ZvHDooQ+R/AtkL4M2ohH/r9HdFJItABXiltSVo5Q9H7jqSvfHtkNoT9ZHAsGVevfAHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=UfEtVolq; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1709729819;
	bh=7qMkj855gnIh1UQkcFt0aaaoTWPFayqXkWGgolRjo9E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UfEtVolq5MqXw9jCn/GeBb+IBQz1dQvJaH/0rnEilELcXz+ev5Hbtp9B7h7mEpBX6
	 Qz3f0JVrd097eeURWnaXC2C/GW5fBXQWNrwBK0QxwWX1YaRiQ6aIQQ0XFTkV+WzC5v
	 GXYLf6FZmSDmamdgEA80gV9hcMOlFslVWN4X9wP38RFheO1qGLQawaGr7s8/LUFbMT
	 gHkmLZS2HLXRCVJcdsFeWrt3RUA35VQsD9LPG6nt3TSnIA5kK6I5fFJLsrkNZ/vfmm
	 hPS72F4Sajlz8pB2B5k39v9Xa14Hc85llYzAKp2qodd6KdX7Cyd3f5C9srqntJv+gy
	 0gOjJMv33jZmA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TqXWY0xZyz4wc8;
	Wed,  6 Mar 2024 23:56:56 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: peterx@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, Andrew Morton
 <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>, Jason
 Gunthorpe <jgg@nvidia.com>, peterx@redhat.com, Matthew Wilcox
 <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, x86@kernel.org, sparclinux@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, "Naveen N. Rao"
 <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH RFC 09/13] mm/powerpc: Redefine pXd_huge() with pXd_leaf()
In-Reply-To: <20240306104147.193052-10-peterx@redhat.com>
References: <20240306104147.193052-1-peterx@redhat.com>
 <20240306104147.193052-10-peterx@redhat.com>
Date: Wed, 06 Mar 2024 23:56:56 +1100
Message-ID: <87v85zo6w7.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

peterx@redhat.com writes:
> From: Peter Xu <peterx@redhat.com>
>
> PowerPC book3s 4K mostly has the same definition on both, except pXd_huge=
()
> constantly returns 0 for hash MMUs.  AFAICT that is fine to be removed,
> because pXd_huge() reflects a hugetlb entry, while it's own hugetlb pgtab=
le
> lookup function (__find_linux_pte() shared by all powerpc code) already u=
se
> pXd_leaf() irrelevant of the MMU type.  It means pXd_leaf() should work a=
ll
> fine with hash MMU pgtables or something could already went wrong.

Yes I think that's correct.

4K Hash MMU doesn't support any hugepage size at PMD or PUD level (the
geometry is wrong), so pmd/pud_huge() were written with that in mind,
ie. they are hard coded to return false.

But it should be OK to use pmd/pud_leaf(), they will actually look for
_PAGE_PTE, but it should never be set for 4K Hash.

See eg. arch/powerpc/include/asm/book3s/64/hash-4k.h:

static inline pmd_t hash__pmd_mkhuge(pmd_t pmd)
{
	BUG();
	return pmd;
}

> The goal should be that we will have one API pXd_leaf() to detect all kin=
ds
> of huge mappings.  AFAICT we need to use the pXd_leaf() impl (rather than
> pXd_huge() ones) to make sure ie. THPs on hash MMU will also return true.
>
> This helps to simplify a follow up patch to drop pXd_huge() treewide.
>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
> Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  arch/powerpc/include/asm/book3s/64/pgtable-4k.h | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable-4k.h b/arch/power=
pc/include/asm/book3s/64/pgtable-4k.h
> index 48f21820afe2..92545981bb49 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
> @@ -8,22 +8,12 @@
>  #ifdef CONFIG_HUGETLB_PAGE
>  static inline int pmd_huge(pmd_t pmd)
>  {
> -	/*
> -	 * leaf pte for huge page
> -	 */
> -	if (radix_enabled())
> -		return !!(pmd_raw(pmd) & cpu_to_be64(_PAGE_PTE));
> -	return 0;
> +	return pmd_leaf(pmd);
>  }
>=20=20
>  static inline int pud_huge(pud_t pud)
>  {
> -	/*
> -	 * leaf pte for huge page
> -	 */
> -	if (radix_enabled())
> -		return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PTE));
> -	return 0;
> +	return pud_leaf(pud);
>  }

This doesn't actually compile though.

  arch/powerpc/include/asm/book3s/64/pgtable-4k.h:11:16: error: implicit de=
claration of function =E2=80=98pmd_leaf=E2=80=99; did you mean =E2=80=98pgd=
_clear=E2=80=99? [-Werror=3Dimplicit-function-declaration]

etc.

To make it compile we'd need to relocate the pmd/pud_leaf() definitions:

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/in=
clude/asm/book3s/64/pgtable.h
index df66dce8306f..fd7180fded75 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -262,6 +262,18 @@ extern unsigned long __kernel_io_end;

 extern struct page *vmemmap;
 extern unsigned long pci_io_base;
+
+#define pmd_leaf pmd_leaf
+static inline bool pmd_leaf(pmd_t pmd)
+{
+       return !!(pmd_raw(pmd) & cpu_to_be64(_PAGE_PTE));
+}
+
+#define pud_leaf pud_leaf
+static inline bool pud_leaf(pud_t pud)
+{
+       return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PTE));
+}
 #endif /* __ASSEMBLY__ */

 #include <asm/book3s/64/hash.h>
@@ -1436,20 +1448,5 @@ static inline bool is_pte_rw_upgrade(unsigned long o=
ld_val, unsigned long new_va
        return false;
 }

-/*
- * Like pmd_huge(), but works regardless of config options
- */
-#define pmd_leaf pmd_leaf
-static inline bool pmd_leaf(pmd_t pmd)
-{
-       return !!(pmd_raw(pmd) & cpu_to_be64(_PAGE_PTE));
-}
-
-#define pud_leaf pud_leaf
-static inline bool pud_leaf(pud_t pud)
-{
-       return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PTE));
-}
-
 #endif /* __ASSEMBLY__ */
 #endif /* _ASM_POWERPC_BOOK3S_64_PGTABLE_H_ */

cheers

