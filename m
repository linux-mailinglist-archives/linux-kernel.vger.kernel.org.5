Return-Path: <linux-kernel+bounces-152921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F278AC624
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A3231C202ED
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEC24D9FC;
	Mon, 22 Apr 2024 07:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfRmzDgx"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBE0482EB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 07:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713772698; cv=none; b=TqKXTKIpCjC0fAn1qMk7dazxiZQIycWBe0ES1wJFeyd7xb8gsgty/0xTm86mI4v7pBo5Spor51DPmA38fwDMgjuU0BQfLP3s4eamMus9KJ9zJ8MY21VaFmQ0nM41Cp6J0S/wrXCjMksm6rqDroKg+ycrFlqH/8WMp7BABQkxdts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713772698; c=relaxed/simple;
	bh=T+YNP4kKfVO10XpruaTmkA8hvrYIjbTqVQPTPFlIpa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fNpRYSi3OrPGY936EdUk1BWoi84LlQZ6A0Ov987o65yKZnrTsaBxWzkWdURACf0i9gVYDs1HtVT2pCgo1TlClN4I49xIMNXoWHek85pIuogR7LP55xUm+IipWUW1WZhdyX2fu7et4M8ao6EdWeXzGupuKeTrjLWkwK8/Zgov2ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SfRmzDgx; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56e1baf0380so4737914a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 00:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713772695; x=1714377495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEhcavnEs1V/XX4IMzhM7uRhg/YxgKJQGKXZTm7j7AQ=;
        b=SfRmzDgxqZdVu40xsELam2fTAhxUso5tqbaBCYDzcqoi2H+JpR3PG5UNmkMTR0o+KO
         AliwFqwn2Q9M/Al7HxigA4g8I0Lo+CF/w/zqFl3XDBC1S3uRORNvTGzCUETXTj8G+SVy
         YelyeFxs/Za8HtzRmkgBx3hIufFLYEY0FBlENLwETDd+vG9f7rFTJ/svnO0h6hzThNj9
         A7hVNkMiSjJ/IkByhnng8c3X5WHvmE9NYMgsdHXBsVjBSxARWUbZODF0Rz6Fa1AehJF+
         76Jh9NhRPchEse2kYEPguNWuqZiS0KP6E2pCkV3SFt8hbcBPTS/qcu+WDuFiewVdYaVS
         QyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713772695; x=1714377495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tEhcavnEs1V/XX4IMzhM7uRhg/YxgKJQGKXZTm7j7AQ=;
        b=qa+2MkYL8tz4OqyiUB0fm2NLyDrAGCiMfNiUDuvsYbYfTaNmMu4nJ2Ytl0HDEfejNd
         GcIqdLkDD0pBe/sYHJ8hy0ErUVkvo5N0llMUryQLsu6ze2swaCTiRHUfYrd0cttmfURN
         rW42iz+/piT1+YZAOcYwe8fYuQySCz7c2soMLdN20CupesfPUfFn0929VvtbTBz+HZ2x
         OsdEd2khofZE484zE+ZoPpz5VZYuxUMf6r1ip68FSmXkinalmklpW5AGZ7L4VTAhF7zO
         rA5pwy1qjFj1xbJopAeX7WTy1b56N+F6UMwLDglNAoPE1ynx+QHMgX6m6f1YJeqEEwqp
         fatA==
X-Forwarded-Encrypted: i=1; AJvYcCU0H9J7T2Cv3Ehe07GjHdZOCk5TFwC0rLEphfWYy+2WjFBK1a738o5vyTVF87HOuvwpmlEuFWe24309/QTAebSljyHCtlP5pMY3EdKu
X-Gm-Message-State: AOJu0YwESqe1cXD5Do9iUFCVy00iW2n7RHBc2TPp3qWX3QrO3U0S8LcH
	VOoi+ZU57aWobOUctWTQtRa0Bp19kIkodXDEj2C06npv/5YB9pG6ngB2SInVMxBogvNWufffjBM
	V377uHtdG3TC+F2M4FlpUflC53PslQ1xo9G4=
X-Google-Smtp-Source: AGHT+IGxwVPXLiHmh1PX6RRP1ezJ6rlKaVTjnjihHxnN3YeAlcNfpVKkXNFb38kD6EVITHaDd0/T3TDoUkk18MWhDQ0=
X-Received: by 2002:a50:9342:0:b0:56c:5a7b:5dbd with SMTP id
 n2-20020a509342000000b0056c5a7b5dbdmr5253627eda.15.1713772694530; Mon, 22 Apr
 2024 00:58:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b99f8cb14bc85fdb6ab43721d1331cb5ebed2581.1713771041.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <b99f8cb14bc85fdb6ab43721d1331cb5ebed2581.1713771041.git.baolin.wang@linux.alibaba.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Mon, 22 Apr 2024 15:58:03 +0800
Message-ID: <CAK1f24kwVP2SG2B5WFcHpRkA8fa_fdcEMD8i3N3e-vw9YPabEg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: huge_memory: add the missing folio_test_pmd_mappable()
 for THP split statistics
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 3:33=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
> Now the mTHP can also be split or added into the deferred list, so add
> folio_test_pmd_mappable() validation for PMD mapped THP, to avoid confusi=
on
> with PMD mapped THP related statistics.
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Acked-by: David Hildenbrand <david@redhat.com>

LGTM!

Reviewed-by: Lance Yang <ioworker0@gmail.com>

Thanks,
Lance

> ---
> Changes from v1:
>  - Add acked tag from David.
>  - Check the THP earlier in case the folio is split per Lance.
> ---
>  mm/huge_memory.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 716d29c21b6e..a9789ca823bc 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2994,6 +2994,7 @@ int split_huge_page_to_list_to_order(struct page *p=
age, struct list_head *list,
>         XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new_o=
rder);
>         struct anon_vma *anon_vma =3D NULL;
>         struct address_space *mapping =3D NULL;
> +       bool is_thp =3D folio_test_pmd_mappable(folio);
>         int extra_pins, ret;
>         pgoff_t end;
>         bool is_hzp;
> @@ -3172,7 +3173,8 @@ int split_huge_page_to_list_to_order(struct page *p=
age, struct list_head *list,
>                 i_mmap_unlock_read(mapping);
>  out:
>         xas_destroy(&xas);
> -       count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE_FAILED);
> +       if (is_thp)
> +               count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE_FAI=
LED);
>         return ret;
>  }
>
> @@ -3234,7 +3236,8 @@ void deferred_split_folio(struct folio *folio)
>
>         spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>         if (list_empty(&folio->_deferred_list)) {
> -               count_vm_event(THP_DEFERRED_SPLIT_PAGE);
> +               if (folio_test_pmd_mappable(folio))
> +                       count_vm_event(THP_DEFERRED_SPLIT_PAGE);
>                 list_add_tail(&folio->_deferred_list, &ds_queue->split_qu=
eue);
>                 ds_queue->split_queue_len++;
>  #ifdef CONFIG_MEMCG
> --
> 2.39.3
>

