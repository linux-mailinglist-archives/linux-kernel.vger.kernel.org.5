Return-Path: <linux-kernel+bounces-93384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A34872EE7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 421DE289F90
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 06:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608B95479F;
	Wed,  6 Mar 2024 06:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfRhLri6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A851C12E63
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 06:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709706566; cv=none; b=TyvOGcBKATXXPVqoLIbG7rPUPqpu1OyxZGdEcNXcnEf47K9ZpV9oMBJTqYeCAs+Dl8aeREN4toDpBjNGsYHob9DF53fxSwMTRYZgs3gwGRHMZDPh2RFOw1l6PLDu+7F+20l4F9Rgo9XRm7zRnVmJjvYTnl7tMXmyZJuijQbWV3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709706566; c=relaxed/simple;
	bh=t2prn8NVfSlgCXr/ufwWnITjShOYjafeq9mcR4kzmvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5B2VtiPvajti2TvCUXuc1jwEHMrsw8OpnQu8lzrbM8GP2J/0OR4rl6DsItYxg5Wjl8XftbUi4zeU4LVd5nLc+lKMgaaPtBxb9io1GIowznlfeq3qZDl9d0m2iNJWVpNAw/B+ker/6PVzADpgdIDkFtIPYwPoaAsksEKuzqYgMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfRhLri6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D312C433C7;
	Wed,  6 Mar 2024 06:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709706565;
	bh=t2prn8NVfSlgCXr/ufwWnITjShOYjafeq9mcR4kzmvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MfRhLri6MiYJ+a8DZTv59cV8JbopCdO+KDu2/kDALeTLRDcDbQZ5ZzxMVRIcB3XOw
	 XlhEmGG9FfA6RXiMK9HLhrOPMl5cKnjJyKaugvmVK6bGJNJROchNsH6FCmqyya9bfQ
	 15JjE4TxrrT+5tTqK1PZWtU608MrBxqvqp0UJA1XM6iRTcLwq802/IkeuleIBe4TFn
	 l+PmZrxvAxpr/z/RDBNSS2VYyrl4WK5hjLt2TTB7qpA4mx58o3Dqj5qV3eAi9w+ABv
	 V2ABDFP8hCc6yI7H4X0n05yHnyO0tBKRobIdXY7hDbwwKsxl8dAUxu/nkXoi9umx1q
	 w76VXD6hrSSfg==
Date: Wed, 6 Mar 2024 08:28:30 +0200
From: Mike Rapoport <rppt@kernel.org>
To: peterx@redhat.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>, x86@kernel.org,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Jason Gunthorpe <jgg@nvidia.com>, Yang Shi <shy828301@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev@lists.ozlabs.org, Muchun Song <muchun.song@linux.dev>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com
Subject: Re: [PATCH v3 06/10] mm/kasan: Use pXd_leaf() in shadow_mapped()
Message-ID: <ZegNDhbFjPHTC3Pp@kernel.org>
References: <20240305043750.93762-1-peterx@redhat.com>
 <20240305043750.93762-7-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305043750.93762-7-peterx@redhat.com>

On Tue, Mar 05, 2024 at 12:37:46PM +0800, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> There is an old trick in shadow_mapped() to use pXd_bad() to detect huge
> pages.  After commit 93fab1b22ef7 ("mm: add generic p?d_leaf() macros") we
> have a global API for huge mappings.  Use that to replace the trick.
> 
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Cc: kasan-dev@googlegroups.com
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  mm/kasan/shadow.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index 9ef84f31833f..d6210ca48dda 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -199,19 +199,12 @@ static bool shadow_mapped(unsigned long addr)
>  	pud = pud_offset(p4d, addr);
>  	if (pud_none(*pud))
>  		return false;
> -
> -	/*
> -	 * We can't use pud_large() or pud_huge(), the first one is
> -	 * arch-specific, the last one depends on HUGETLB_PAGE.  So let's abuse
> -	 * pud_bad(), if pud is bad then it's bad because it's huge.
> -	 */
> -	if (pud_bad(*pud))
> +	if (pud_leaf(*pud))
>  		return true;
>  	pmd = pmd_offset(pud, addr);
>  	if (pmd_none(*pmd))
>  		return false;
> -
> -	if (pmd_bad(*pmd))
> +	if (pmd_leaf(*pmd))
>  		return true;
>  	pte = pte_offset_kernel(pmd, addr);
>  	return !pte_none(ptep_get(pte));
> -- 
> 2.44.0
> 
> 

-- 
Sincerely yours,
Mike.

