Return-Path: <linux-kernel+bounces-82647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E988687A9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C18881F25C9A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE1F1B962;
	Tue, 27 Feb 2024 03:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQmTrVV2"
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA576FC6
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 03:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709003910; cv=none; b=a1afUtb2Yg2OHJtBr/0F8dpYH9RgxxLdXDz8j2ypcpa8xq1sFlD2XxMcLCp03Fy37dlLuiNVqANXIF1uf+dVxngUJIxyDYJDzS18Y+fzXKRrgjVoKpS2s6ZcX9KmQKKHGUy7EyCgpwaf51MxUHpe5drqMvi75myh8Wsn0e/rD6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709003910; c=relaxed/simple;
	bh=KjPHTiSTwg32S1R3S8oshUP2UzgRbl2OG36gTs7izEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JHjEmF1x36MJK09C+noj/G7t50Nv4osKFYFAOlmklsypMNUlkFmBcYkAYlQ8NrdgXGEwnpBv4jvZIDJQn9PJBydviUR7kzYdY15pWGAB00Pb0n2lDPUrJpoTP5u+dFtR51I7D0rukRCp/1i8UAmw4Pfta3O5h/yyJp5fG7cErBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQmTrVV2; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7d2e21181c1so2523221241.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 19:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709003908; x=1709608708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJZD2KtLrf71EHvovaXk1j0WO0+M7+xSSk4VodUZBz8=;
        b=dQmTrVV2lCz893yKAnTcqrcomG/wp3nN9qGsmWD5kkP8IbObWTU5Umvq7X3gDF0i/+
         Nmw1XDudFzsu8/U6P6Tmzvj0BZjw8gKtE+G6VUpvTDdExqq5/nDE8BqYBm+qbAvYQXeK
         1W9slgdTONVvHQA3cQ1NrYdnsDxGxOQWTQ6kyp0XiQN+ybD6tupAk3RTPaX5wiObB7NO
         jfZAl2PojNUoZKOeBfLmn45Z/R1PaIaRr+posRD2X+6mIT/BvmfR+mzQHsF0C9FuN+qH
         Y4+ibP0wOpAj8bz5rCyKYn2lu6bTQ54+12fB/mRACZWETs5jMG+yViiKKxLF4FJHz/jG
         vX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709003908; x=1709608708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJZD2KtLrf71EHvovaXk1j0WO0+M7+xSSk4VodUZBz8=;
        b=fuvHuoLzVYo4jDGBqIIRa1r4pSY39XcCMCuWJAg8beFLz4QPUg/zb4N5/DATUPhvhe
         44W4iKUaRPpMWQZxu9VE8llkPZfIRzaFQL9zWGHpRCOGPUUfPW7K8wfzaQ4uHLuLDrev
         lepBfqO/W+DkBDBByLCi3j9tDp7ZdLZRekdLjVHNLrfIZKtTEIPPOE9spHsqgG6uVfsl
         oychQ8Tm8DEGu65Ml1DcdLAinCLtGkpncan7teVKzJvNaw/unq1qunyJ5e6uh6iL6ouD
         QUgKbj+2GYJRZG0+G3zrkc3KHJTKuyqpuQYNYVfoWcCISy5971tkarhoQaN2/Fw7rmbg
         mkRQ==
X-Gm-Message-State: AOJu0Yw8tRB1I2TVaO+DNgXOBVeHQj46c25MaEJMGB5bJF8a81zVKkP+
	kBpAEvSMSW/KpW7JQ6kCvyxw0vK13k13u5qNs47V8NVqUYAdZXWpCFwMsfc4Kkl7gUjLJ+pDHUc
	I2OSm114Xs4+bitoPv52q/g5Mges=
X-Google-Smtp-Source: AGHT+IFs5rDr+LuGs9pbJ463izehId6OYEso4XQoI7Xjg8YIH59ntMm6AwuRqaiP2Afn7zDCUuO5FWl8zKOx3RYW6Dw=
X-Received: by 2002:a1f:6283:0:b0:4d1:34a1:d94f with SMTP id
 w125-20020a1f6283000000b004d134a1d94fmr5573937vkb.6.1709003907709; Mon, 26
 Feb 2024 19:18:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227024050.244567-1-21cnbao@gmail.com>
In-Reply-To: <20240227024050.244567-1-21cnbao@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 27 Feb 2024 16:18:16 +1300
Message-ID: <CAGsJ_4yF+kuTtN4YmtwSvfcCRqixvzL5qT0BLLfTg9nLLsReZg@mail.gmail.com>
Subject: Re: [PATCH] mm: export folio_pte_batch as a couple of modules might
 need it
To: akpm@linux-foundation.org, linux-mm@kvack.org, 
	David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>
Cc: linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Lance Yang <ioworker0@gmail.com>, Yin Fengwei <fengwei.yin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 3:41=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> madvise and some others might need folio_pte_batch to check if a range
> of PTEs are completely mapped to a large folio with contiguous physcial
> addresses. Let's export it for others to use.
>
> Cc: Lance Yang <ioworker0@gmail.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: David Hildenbrand <david@redhat.com>

Hi David, Ryan,

Sorry, I realize I just made a mistake and your tags should be both
Suggested-by. Please feel
free to review the patch and give comments. I will fix the tags
together with addressing your
review comments in v2.

> Cc: Yin Fengwei <fengwei.yin@intel.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  -v1:
>  at least two jobs madv_free and madv_pageout depend on it. To avoid
>  conflicts and dependencies, after discussing with Lance, we prefer
>  this one can land earlier.
>
>  mm/internal.h | 13 +++++++++++++
>  mm/memory.c   | 11 +----------
>  2 files changed, 14 insertions(+), 10 deletions(-)
>
> diff --git a/mm/internal.h b/mm/internal.h
> index 13b59d384845..8e2bc304f671 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -83,6 +83,19 @@ static inline void *folio_raw_mapping(struct folio *fo=
lio)
>         return (void *)(mapping & ~PAGE_MAPPING_FLAGS);
>  }
>
> +/* Flags for folio_pte_batch(). */
> +typedef int __bitwise fpb_t;
> +
> +/* Compare PTEs after pte_mkclean(), ignoring the dirty bit. */
> +#define FPB_IGNORE_DIRTY               ((__force fpb_t)BIT(0))
> +
> +/* Compare PTEs after pte_clear_soft_dirty(), ignoring the soft-dirty bi=
t. */
> +#define FPB_IGNORE_SOFT_DIRTY          ((__force fpb_t)BIT(1))
> +
> +extern int folio_pte_batch(struct folio *folio, unsigned long addr,
> +               pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
> +               bool *any_writable);
> +
>  void __acct_reclaim_writeback(pg_data_t *pgdat, struct folio *folio,
>                                                 int nr_throttled);
>  static inline void acct_reclaim_writeback(struct folio *folio)
> diff --git a/mm/memory.c b/mm/memory.c
> index 1c45b6a42a1b..319b3be05e75 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -953,15 +953,6 @@ static __always_inline void __copy_present_ptes(stru=
ct vm_area_struct *dst_vma,
>         set_ptes(dst_vma->vm_mm, addr, dst_pte, pte, nr);
>  }
>
> -/* Flags for folio_pte_batch(). */
> -typedef int __bitwise fpb_t;
> -
> -/* Compare PTEs after pte_mkclean(), ignoring the dirty bit. */
> -#define FPB_IGNORE_DIRTY               ((__force fpb_t)BIT(0))
> -
> -/* Compare PTEs after pte_clear_soft_dirty(), ignoring the soft-dirty bi=
t. */
> -#define FPB_IGNORE_SOFT_DIRTY          ((__force fpb_t)BIT(1))
> -
>  static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
>  {
>         if (flags & FPB_IGNORE_DIRTY)
> @@ -982,7 +973,7 @@ static inline pte_t __pte_batch_clear_ignored(pte_t p=
te, fpb_t flags)
>   * If "any_writable" is set, it will indicate if any other PTE besides t=
he
>   * first (given) PTE is writable.
>   */
> -static inline int folio_pte_batch(struct folio *folio, unsigned long add=
r,
> +int folio_pte_batch(struct folio *folio, unsigned long addr,
>                 pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
>                 bool *any_writable)
>  {
> --
> 2.34.1
>

Thanks
Barry

