Return-Path: <linux-kernel+bounces-93383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 610CB872EE4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E525128A02E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 06:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBC35466A;
	Wed,  6 Mar 2024 06:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKNIDLuN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F353A12E63
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 06:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709706492; cv=none; b=F7/ZKKG1BmYnO4u8dnPF/Ai9qC/45/hVnF32LWpYZv6SWRdaezka+eSmcOAm+mImEnXjn6HoQ28nFKcZwuI0M749MuanuqDN+HWGrfGgt5p9mPSlWXaJdz/ckOZZFU/TdON64IwrAm26JddvMmZzpHM6jAatIyot3IyomVgjykk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709706492; c=relaxed/simple;
	bh=V1Mfq7Y3AfGZ+fTn0cuNK5g8OD2Cj2Hf0foPZDXtLP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPQIUs2Pv0Dwe8it5AKNo3hEFivqqch+tML1XpFo0eqWpoo+1VsSuNN+Eo+WV0pLQCMl9wRhC3DGyqVDGzseAUcAlVA+PR2CQL1vdySzxJl8ki3V+pcDEerTztOr+hx5QEbBKIvfDVKYv2TJuum9F7mek9A6xmbAsYjmyVWolwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKNIDLuN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91E1C433F1;
	Wed,  6 Mar 2024 06:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709706491;
	bh=V1Mfq7Y3AfGZ+fTn0cuNK5g8OD2Cj2Hf0foPZDXtLP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oKNIDLuN1zcY9zNB8rL62xeb/R+s5Gzot2AtdqSnRtFkZGmCVsAO4jRtML4UfdAEe
	 pUqr2Rdg77iw5wNSF9UF+HiEAQCgZtNyoJfL9RIM1UoqbWFIuG/s3owFFls+0ptqtM
	 /wCULQejCsKlUfHMnEPjWlMU8WNNPjZayaSuhoMrb3b3ZQ889cQsfe5w66uKXN7K0T
	 dlirD+YfaP2xoM1QZxAVly75hKm/AZZ4AdXsGYColI/iqY4iIJuXNO5U97O3g/WYuZ
	 QMJZKeR5k6quh8zJ5keTU8L/HDykc2GpgeWTm4muXBQke04hp0lO0s+4oQsB6O+5jy
	 buAMbCC9wt+Ng==
Date: Wed, 6 Mar 2024 08:27:17 +0200
From: Mike Rapoport <rppt@kernel.org>
To: peterx@redhat.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>, x86@kernel.org,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Jason Gunthorpe <jgg@nvidia.com>, Yang Shi <shy828301@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev@lists.ozlabs.org, Muchun Song <muchun.song@linux.dev>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v3 05/10] mm/x86: Drop two unnecessary pud_leaf()
 definitions
Message-ID: <ZegMxVPdfZD1r0oT@kernel.org>
References: <20240305043750.93762-1-peterx@redhat.com>
 <20240305043750.93762-6-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305043750.93762-6-peterx@redhat.com>

On Tue, Mar 05, 2024 at 12:37:45PM +0800, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> pud_leaf() has a fallback macro defined in include/linux/pgtable.h already.
> Drop the extra two for x86.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/x86/include/asm/pgtable.h      | 1 -
>  include/asm-generic/pgtable-nopmd.h | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index d6e993a5659f..9db7a38a0e9f 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1097,7 +1097,6 @@ static inline int pud_bad(pud_t pud)
>  	return (pud_flags(pud) & ~(_KERNPG_TABLE | _PAGE_USER)) != 0;
>  }
>  #else
> -#define pud_leaf	pud_large
>  static inline int pud_large(pud_t pud)
>  {
>  	return 0;
> diff --git a/include/asm-generic/pgtable-nopmd.h b/include/asm-generic/pgtable-nopmd.h
> index 8ffd64e7a24c..fa27e16bbe1b 100644
> --- a/include/asm-generic/pgtable-nopmd.h
> +++ b/include/asm-generic/pgtable-nopmd.h
> @@ -31,7 +31,6 @@ static inline int pud_none(pud_t pud)		{ return 0; }
>  static inline int pud_bad(pud_t pud)		{ return 0; }
>  static inline int pud_present(pud_t pud)	{ return 1; }
>  static inline int pud_user(pud_t pud)		{ return 0; }
> -static inline int pud_leaf(pud_t pud)		{ return 0; }
>  static inline void pud_clear(pud_t *pud)	{ }
>  #define pmd_ERROR(pmd)				(pud_ERROR((pmd).pud))
>  
> -- 
> 2.44.0
> 
> 

-- 
Sincerely yours,
Mike.

