Return-Path: <linux-kernel+bounces-168205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D97BD8BB50E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82D8E1F235DF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D4A3398A;
	Fri,  3 May 2024 20:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYQ88gBf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F10D2C694
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 20:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714769487; cv=none; b=iKR9DR95fwbhVoiYAEh+arMRuVC2+SN672uHwIpFsUd17rpOLc9VzbfsmFGCQ05fAUQzyoDU+orXioHiegDHzDW35dgKzLuG2XvyAbgn048E2EzUZHRZdOx1OivS738a23p5t3fc/51R7kh/pxiMclpVeubSPp0XAyKO4u7RPM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714769487; c=relaxed/simple;
	bh=4XNjsHGUY0RC797A6oE4dTcXr7seQv3KyDJvK+El79A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ps/WkfLja/HKWuRvfyV1Rki8ScJZmfNVzZOG0iNIWF/ji2O9M5HYCyRxYK68HawUJ08S1gnZNwbDC5ysVkbltlAnNwvxzsbHJ702Hr1veDxYrSoIre04c20G7RMx9Vf2Tvwv+PdOOn06y4O5ok2gUjP3DxH/brAMu2lH0wV4TpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYQ88gBf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7F6C4AF19
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 20:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714769485;
	bh=4XNjsHGUY0RC797A6oE4dTcXr7seQv3KyDJvK+El79A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YYQ88gBfQOkaq1jvXc/ooIFhTfEznNbbA1MbnlOkpI/Dm3vP0yXaUHNNONjmnaHLR
	 C8YTdQEPW3NYj+UH3YgBovP91pPVElMPw98gnq14OpuGJTUVdVajLPKZJgxIyvUghZ
	 3PjnG0natAs3oEYkzsIfos3gh85sajboRDtNb4r3XfPOTBXscb82DT2dEFO/L3zvmh
	 YWDno7dJAq3OlY/Kr5baI4Pa47LZrm0GTumgHGktvfSX7b8DQWIJe5ShnDWDcxHgF3
	 gZebjOy2if+eMaOYqCKV5PBtE87oGdOzGq17lTwiIKJOQh0UJWMQ3YcaAatdNhZdU3
	 0z4ED4Y7Ychew==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51f1b378ca5so117450e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 13:51:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUymLGUT0lZbLAMR1tubtrDioaRN7tM/XN6Z3KIjHY/Z8Xsj67wfqBNS5U4U7NHV6OLq+pweS4cHxkQtzu1FTcmajdqn84Zd6UI24Fv
X-Gm-Message-State: AOJu0YwtHxS8A6CwTgEcwLh8wrxpDufPd269KTJyBlX+u9K3DC7B3LDD
	NaI7F0kiOFhJ1lhB7CsoLgUtjZ9AXENRhxvNFSRoj4ayLhc/OV+TtzX3QZR4zRqV4dkVSsfJVeB
	jjoNCPOuDpaifzGXGN+6Whv+QiQ==
X-Google-Smtp-Source: AGHT+IFZ23IZczDqkjVsLxinkpZSI1sgPKhwnVRu/Zwtb8VFOa3yiOi/48WRYHm1djJW/THYjXxPwkE9mGAcEDsuvfo=
X-Received: by 2002:a05:6512:457:b0:51f:b781:7293 with SMTP id
 y23-20020a056512045700b0051fb7817293mr1668940lfk.11.1714769484171; Fri, 03
 May 2024 13:51:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503005023.174597-1-21cnbao@gmail.com> <20240503005023.174597-4-21cnbao@gmail.com>
In-Reply-To: <20240503005023.174597-4-21cnbao@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 3 May 2024 13:51:11 -0700
X-Gmail-Original-Message-ID: <CANeU7Q=RFC7i6q=BjK3cXG+J0U2KeGMDuz0sV1K2sG2ifvpYcw@mail.gmail.com>
Message-ID: <CANeU7Q=RFC7i6q=BjK3cXG+J0U2KeGMDuz0sV1K2sG2ifvpYcw@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] mm: introduce pte_move_swp_offset() helper which
 can move offset bidirectionally
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	baolin.wang@linux.alibaba.com, david@redhat.com, hanchuanhua@oppo.com, 
	hannes@cmpxchg.org, hughd@google.com, kasong@tencent.com, 
	linux-kernel@vger.kernel.org, ryan.roberts@arm.com, surenb@google.com, 
	v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org, 
	ying.huang@intel.com, yosryahmed@google.com, yuzhao@google.com, 
	ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 5:51=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrote=
:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> There could arise a necessity to obtain the first pte_t from a swap
> pte_t located in the middle. For instance, this may occur within the
> context of do_swap_page(), where a page fault can potentially occur in
> any PTE of a large folio. To address this, the following patch introduces
> pte_move_swp_offset(), a function capable of bidirectional movement by
> a specified delta argument. Consequently, pte_increment_swp_offset()
> will directly invoke it with delta =3D 1.

BTW, this patch has conflict with the latest mm-unstable. You might
need to refresh it.

I do not see the delta =3D -1 usage case here. Maybe merge the patch
with the follow up patch that uses the delta =3D -1?
Does delta only make sense as 1 and -1?

This patch doesn't seem straightly necessary to me.

Chris


Chris

>
> Suggested-by: "Huang, Ying" <ying.huang@intel.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  mm/internal.h | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/mm/internal.h b/mm/internal.h
> index c5552d35d995..cfe4aed66a5c 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -211,18 +211,21 @@ static inline int folio_pte_batch(struct folio *fol=
io, unsigned long addr,
>  }
>
>  /**
> - * pte_next_swp_offset - Increment the swap entry offset field of a swap=
 pte.
> + * pte_move_swp_offset - Move the swap entry offset field of a swap pte
> + *      forward or backward by delta
>   * @pte: The initial pte state; is_swap_pte(pte) must be true and
>   *      non_swap_entry() must be false.
> + * @delta: The direction and the offset we are moving; forward if delta
> + *      is positive; backward if delta is negative
>   *
> - * Increments the swap offset, while maintaining all other fields, inclu=
ding
> + * Moves the swap offset, while maintaining all other fields, including
>   * swap type, and any swp pte bits. The resulting pte is returned.
>   */
> -static inline pte_t pte_next_swp_offset(pte_t pte)
> +static inline pte_t pte_move_swp_offset(pte_t pte, long delta)
>  {
>         swp_entry_t entry =3D pte_to_swp_entry(pte);
>         pte_t new =3D __swp_entry_to_pte(__swp_entry(swp_type(entry),
> -                                                  (swp_offset(entry) + 1=
)));
> +                                                  (swp_offset(entry) + d=
elta)));
>
>         if (pte_swp_soft_dirty(pte))
>                 new =3D pte_swp_mksoft_dirty(new);
> @@ -234,6 +237,20 @@ static inline pte_t pte_next_swp_offset(pte_t pte)
>         return new;
>  }
>
> +
> +/**
> + * pte_next_swp_offset - Increment the swap entry offset field of a swap=
 pte.
> + * @pte: The initial pte state; is_swap_pte(pte) must be true and
> + *      non_swap_entry() must be false.
> + *
> + * Increments the swap offset, while maintaining all other fields, inclu=
ding
> + * swap type, and any swp pte bits. The resulting pte is returned.
> + */
> +static inline pte_t pte_next_swp_offset(pte_t pte)
> +{
> +       return pte_move_swp_offset(pte, 1);
> +}
> +
>  /**
>   * swap_pte_batch - detect a PTE batch for a set of contiguous swap entr=
ies
>   * @start_ptep: Page table pointer for the first entry.
> --
> 2.34.1
>
>

