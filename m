Return-Path: <linux-kernel+bounces-82563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 208CE868665
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5AB828E39B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFC5EAD7;
	Tue, 27 Feb 2024 01:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWfWTPvy"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92ECC746E
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 01:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708998528; cv=none; b=lL5mZszv5fzaIwljOgeOUJql40s+aMGeWoVHL0THOpe5K6+bwWdEUvsD9zZAbKY7kiWpCEBkMp7pt0EcdsjbGGaGOTKJBLnAPbGME6xmRgR2xZUDMBbOU/4Zi25QDxXPCJcNmgQsOcRa+1Aqz1sh6vjPFB7jvYT6bIs+5KxOkC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708998528; c=relaxed/simple;
	bh=V2zldjz7rPR5UN7z800aW/ADOx9Os94VdT725S90kkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aI5rq7KC8mSRkTOYEra4ESMgnGJJ9+4ou4OlR90uDwf8Dkz2r0aIQ+pjzjhZNhpxG2Icvclzn1lyIgPNu4qeOozVNdyUK/25ZTWMStsz68pdaO/aJTKQx4eu5WZxQgVoXjqTxQF8ADUd9WdkQQ1I+7AODrQUeunXT3YltCUK2o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWfWTPvy; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-607dec82853so39871727b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 17:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708998525; x=1709603325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Q3okeBK/888jP630KPQ8RoIb8Z1wYCvm95ViNJwrqE=;
        b=cWfWTPvyZvOrhJon00Jd6XXeWCSIz4vAxIUZEYz8YA4IVnkwtN4TS7a4BVu1MhF43p
         IQmFMdQCFCmQHOQ44at4msPNcKHM8F6djmO2DWk5x+X/gU0dXS8depn863B8wtrISlHX
         6xwBSBUR83X83JEmgJXUzbIHKR4rdIBumPo3k+KHtDWf5VPfKdwditzdbpiYYN6nx24b
         NNRuSFZkO0ubMnEEkE+IJq6H/zd4p1Axv6bgeNHQyvK4RZ89B3VZwNmyo12Lb7vV132A
         /XPZl03BdDATYrRlzThrJh16pCR3M2o0XsFzHqPoacoJI2o/naffeMicPjRkyN7InVGu
         Sd2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708998525; x=1709603325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Q3okeBK/888jP630KPQ8RoIb8Z1wYCvm95ViNJwrqE=;
        b=r4paQJXh1Smchu/w5/XJws4vUAd1gYkRkFSfZp/GkQUDhsDmBiF/L1tmTob79mB5K3
         Yt6alUxn8Ee4bwGKChEQDSCduBkYoQAiPgAV/VkO2glYb2Yk6In//J1SC+J7iRjtBdN8
         gP5CN2r0MjvX22K87pp0iLL0S+3GjrLbR3qfujeu0DX6DFoIxVvtheLTLYcGO5ZRa8qA
         GqJuYnSiyhYUVF0xq78c4YZflWNI/R+bWQQAKsLOSa+G4AI/HDpVKvYCfMvkx2EK3HQY
         iE9XTQkIQkG1x3q05dQWA2M1WpPdKuJpUAGyvVsg+idNTNJn0YEVgG88LcrIrcy6U2b7
         WEBA==
X-Forwarded-Encrypted: i=1; AJvYcCUgiGts9ja6iSXvYxNL+ke32Vc4dxbTILVKPaGdqrd3R8+v4/xr3dkWBilbDH45WNAVkZfJlhR4fKKYqcGn3E/OzCwG7WELILOunm8p
X-Gm-Message-State: AOJu0Yw7bWDUdnIyBGJslGWe0xTiJNoLqmzVvQ02TxfgxLT4ebpktknO
	/+iauqUDqcoutarcDDAdQVpE3dVxOotitmabsI37nvSICmsQuDFs5aICzHe+yWT3paTxnS37ZyM
	KxjIXOj64F4J4VLwS4I1ed3FlNVY=
X-Google-Smtp-Source: AGHT+IGEtkH5U0Ho/pR/EiR+6jzzUK8Pzq+Um5FnixRZ1QQY5N9BT0sDFGamb+RN2Ibx1R8bnBmjXjvwMSRvXoRJi6k=
X-Received: by 2002:a81:a9c6:0:b0:608:15e8:9283 with SMTP id
 g189-20020a81a9c6000000b0060815e89283mr824256ywh.3.1708998525650; Mon, 26 Feb
 2024 17:48:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK1f24=yWPQnYuQYgc3cXdBC0HoR1yAwY59Xs2DYPAC4DQzw0A@mail.gmail.com>
 <20240227012127.174048-1-21cnbao@gmail.com>
In-Reply-To: <20240227012127.174048-1-21cnbao@gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Tue, 27 Feb 2024 09:48:34 +0800
Message-ID: <CAK1f24kuorp8nzdeugURmnGunBhcA5VFTXi_G8M_r+Fmm=_DaQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/madvise: enhance lazyfreeing with mTHP in madvise_free
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, fengwei.yin@intel.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com, 
	minchan@kernel.org, peterx@redhat.com, ryan.roberts@arm.com, 
	shy828301@gmail.com, songmuchun@bytedance.com, wangkefeng.wang@huawei.com, 
	zokeefe@google.com, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 9:21=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> > Thanks for your suggestion. I'll use folio_pte_batch() in v2.
>
> Hi Lance,
> Obviously, we both need this. While making large folio swap-in
> v2, I am exporting folio_pte_batch() as below,

Thanks, Barry.

Could you separate the export of folio_pte_batch() from the large folio
swap-in v2? Prioritizing the push for this specific change would aid in
the development of the v2 based on it.

Best,
Lance

>
> From: Barry Song <v-songbaohua@oppo.com>
> Date: Tue, 27 Feb 2024 14:05:43 +1300
> Subject: [PATCH] mm: export folio_pte_batch as a couple of modules need i=
t
>
> MADV_FREE, MADV_PAGEOUT and some other modules might need folio_pte_batch
> to check if a range of PTEs are completely mapped to a large folio with
> contiguous physcial offset.
>
> Cc: Lance Yang <ioworker0@gmail.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  mm/internal.h | 13 +++++++++++++
>  mm/memory.c   |  2 +-
>  2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/mm/internal.h b/mm/internal.h
> index 36c11ea41f47..7e11aea3eda9 100644
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
> index 6378f6bc22c5..dd9bd67f037a 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -989,7 +989,7 @@ static inline pte_t __pte_batch_clear_ignored(pte_t p=
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
> > Best,
> > Lance
>
> Thanks
> Barry
>

