Return-Path: <linux-kernel+bounces-122497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA33988F885
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84D3F2955BB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AFD535D3;
	Thu, 28 Mar 2024 07:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0FvkBxL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37553524CB
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 07:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711610608; cv=none; b=uhghtr88cL1Zu+gv0la/nl4cqv1r7oJ1GCLdTB6rwS2SyFzpOGvuL26xBUf/AuT2isY00lQr7zEyF678slnKD3DsIob1A8v2MQUWWbzL2ucNyfnPHlYznDN+KbJTMmNv2lwl4vhxqB3Tvppf2hQ5aGAKS6/PDtHp/XR8GE7p99g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711610608; c=relaxed/simple;
	bh=XmbHnD8qe5aW6XPRjOV9YFMPug+OvB5+dSMP4t9whfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QXFvMbCdsxfsuLRw40/nF6vy6cHQ3wd2i+vF8ytfqWjN6SovTLLxMbcZr2q5t2C+B+Bpe5W/mIxJJWRE5vJe1P/0ohKFzWAyai+MUxeArGbCSlXatHB+QqoJCeOYWdAWp1TVytNpE2WtZFI4niOVRp3qHSJt73OmvJ3R2l2o+zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0FvkBxL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFC6C43390
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 07:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711610607;
	bh=XmbHnD8qe5aW6XPRjOV9YFMPug+OvB5+dSMP4t9whfY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=V0FvkBxLyuWhtd28hts4XhbeswCAyF4eMKfRhOk5011RmUbRJj4Ul3ySDFNGMJTlH
	 fjyl/qUr4Edp0H+9PzLKFGGbJLum+uYkjlZxbqY+K26V5SdrlJ3czlixadDQpfgtwj
	 NYy76U5Gz08OXFbkxAEoaWKH2hrbkQafuVBkjpjYzI+Pjda6+xXXxRqWnLgCQphZiz
	 tcJcvJmn3Lca52yetlMbcj6PEIg4DGSjWPB0Xj60dAqy292lSu2F30Y4THCMMI7ynQ
	 tpkgoTHKNaRDXQKHjRGS9Qgz3wFr3qC7o2euvxeKlISB+jCDD6oc/NXoD+6TeHjDUP
	 lWD0q7zZ4rqqw==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51381021af1so813873e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 00:23:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUaJOmcOjnlmFrVnOZnHFD248Jqnst6h2AAzdlA0tZUR0XVrQHuuki41W5dBBn6sxL8Z2lLOBoheSUCfe3XKEmCtakPqFHJEtUfwO5i
X-Gm-Message-State: AOJu0YxTBQ/QJL1lGwzHtZF1kOSTnmARLPCqKBSJcUtuMyRy/jVuMRCv
	eenM3mR6T+NfptMlrZaA1CiX0AGf9QM4Z73IcPxzhrZo0BXOB2Ugoj3DdPvSlsbZ5EAhUKTO6uA
	+Njhyomnhrp/AkH9CpOiBJ/rcRXw=
X-Google-Smtp-Source: AGHT+IEq+RlOgbPuv8bkw8C+loFT0rmP+XuNLaOGeX0z3pW3rpKt+sHlQC22Cua4/UqOONkrU4utZVXWFPijrjkoW4Q=
X-Received: by 2002:a19:6457:0:b0:513:db29:8905 with SMTP id
 b23-20020a196457000000b00513db298905mr1421799lfj.69.1711610606165; Thu, 28
 Mar 2024 00:23:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326101448.3453626-1-ryan.roberts@arm.com> <20240327190723.185232-1-ryan.roberts@arm.com>
In-Reply-To: <20240327190723.185232-1-ryan.roberts@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 28 Mar 2024 09:23:14 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF68MH0HUH8FHpHAoSs_tPbMGek5mY2U4BL-i_RWoZ+5Q@mail.gmail.com>
Message-ID: <CAMj1kXF68MH0HUH8FHpHAoSs_tPbMGek5mY2U4BL-i_RWoZ+5Q@mail.gmail.com>
Subject: Re: [PATCH v1] arm64: mm: Batch dsb and isb when populating pgtables
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, David Hildenbrand <david@redhat.com>, 
	Donald Dutile <ddutile@redhat.com>, Eric Chanudet <echanude@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Mar 2024 at 21:07, Ryan Roberts <ryan.roberts@arm.com> wrote:
>
> After removing uneccessary TLBIs, the next bottleneck when creating the
> page tables for the linear map is DSB and ISB, which were previously
> issued per-pte in __set_pte(). Since we are writing multiple ptes in a
> given pte table, we can elide these barriers and insert them once we
> have finished writing to the table.
>

Nice!

> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  arch/arm64/include/asm/pgtable.h |  7 ++++++-
>  arch/arm64/mm/mmu.c              | 13 ++++++++++++-
>  2 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index bd5d02f3f0a3..81e427b23b3f 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -271,9 +271,14 @@ static inline pte_t pte_mkdevmap(pte_t pte)
>         return set_pte_bit(pte, __pgprot(PTE_DEVMAP | PTE_SPECIAL));
>  }
>
> -static inline void __set_pte(pte_t *ptep, pte_t pte)
> +static inline void ___set_pte(pte_t *ptep, pte_t pte)

IMHO, we should either use WRITE_ONCE() directly in the caller, or
find a better name.

>  {
>         WRITE_ONCE(*ptep, pte);
> +}
> +
> +static inline void __set_pte(pte_t *ptep, pte_t pte)
> +{
> +       ___set_pte(ptep, pte);
>
>         /*
>          * Only if the new pte is valid and kernel, otherwise TLB maintenance
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 1b2a2a2d09b7..c6d5a76732d4 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -301,7 +301,11 @@ static pte_t *init_pte(pte_t *ptep, unsigned long addr, unsigned long end,
>         do {
>                 pte_t old_pte = __ptep_get(ptep);
>
> -               __set_pte(ptep, pfn_pte(__phys_to_pfn(phys), prot));
> +               /*
> +                * Required barriers to make this visible to the table walker
> +                * are deferred to the end of alloc_init_cont_pte().
> +                */
> +               ___set_pte(ptep, pfn_pte(__phys_to_pfn(phys), prot));
>
>                 /*
>                  * After the PTE entry has been populated once, we
> @@ -358,6 +362,13 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>         } while (addr = next, addr != end);
>
>         ops->unmap(TYPE_PTE);
> +
> +       /*
> +        * Ensure all previous pgtable writes are visible to the table walker.
> +        * See init_pte().
> +        */
> +       dsb(ishst);
> +       isb();
>  }
>
>  static pmd_t *init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
> --
> 2.25.1
>

