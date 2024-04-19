Return-Path: <linux-kernel+bounces-151646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 537328AB186
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09BF0282CDC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE51B7E11E;
	Fri, 19 Apr 2024 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Huu6lu15"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7094E12F582
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 15:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713539824; cv=none; b=KoYg8mXtEgZn03xOkiIopDHwDqM4sk7x/ssYRIkAcNfiC3e4HD6dvPAJqKM9y6GwxNhAs66+pZzCxuO0S6i18m5VVBtY3CiuoXVjX0ycWEkAKKW5YLCUfyPh0PjpDA1qjm8LxkC7GeQQaechCcpmxhpUToO3BwvtAK3Gff/l/Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713539824; c=relaxed/simple;
	bh=NK0v0Rj0ooM2z0ZXghNw5yCj6eyFI20OYerd9Uwa8VA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HWoNiiyDCKzG85hc+KGrR4542UOqM5PbKeDUtk8m9dTE9dDApkdmP5zwdHLGnzAruzxQIJeqsI0niWV6Zf3CQedQF03nSrD9ymaox6WjhWuDhSGgvXO7GCObblkQW8dh4SXjJV+xK6sIWntTF4QqhfNAzaJocHQeAV1lGWMcspA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Huu6lu15; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a44ad785a44so220039666b.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 08:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713539821; x=1714144621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKVsh5Q6uavCX2L8UHvFm8eJ4q1LcfOkw4OmFRzHRl0=;
        b=Huu6lu15aisNyufIrdgt+YQ6b0ehvr1RrIkEpJ51gpM44QggmMquqkwv816bOzARKP
         d8sULdlitEQhEBd08ZR1sMfHyEZpcELzIlPJ//ZF14kKNROFMevjzSSn2lPWfAl0Y2od
         UScmqmh7DFShWcUL3J4glFj2YI8Ulv3CfYKTsLP3MarJ0/FfVbhqwU9bfUe5IucwyJOy
         ynZXNTthO+sy5vC58v4PX2GsAIhGnY0/dFr4gTNoaTPXAMz1Bo3Wf1VtBsvYpeorXS9V
         evFXgcxB+fOURIR6Kylg8ERhaPR1dre/TGJwZ7NzvSO0qYZtO3djpJbZIMtudCsinUGU
         Vr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713539821; x=1714144621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OKVsh5Q6uavCX2L8UHvFm8eJ4q1LcfOkw4OmFRzHRl0=;
        b=W2SKC4WPQOYJv3I5sfZ2fhRS1bMRzH2CYM1yceYm68a2DoTPqn0bW3hTn0J5QCmlxQ
         pQ8Iom/kha+1xnjupzzhi0U4+SXKs6oOuRe0dC7Aag6A89ON1vDVlJZXafW7LHYO7h5s
         FNaxwMzDwcsokP3Icn37QHysn0mQS0b6VgtW1ckagFsrrQvPIcEb0wNepG+E+f2QS2tk
         hfDEpUC8dbcCrvRSx5jERx3B7kIFPrAsKnJf6DSQTORagmOY4+FhxDijHzrInUkjfYKg
         JXhWuvsaBMC0RjR1WoYxlKtxnehx5S8s+PBvWgtJgCeLbqifsa3p5smw7qj//qD4fZ9s
         iW+w==
X-Forwarded-Encrypted: i=1; AJvYcCWiycpSPXl81CtqwvL4C36sA3tdY0tyFxvEbtqo98y2k9zD1kBxmc37sXerqcltKAmad1lfUMrMaIxKBIA9b9pYvvugui43kjP3uiLl
X-Gm-Message-State: AOJu0Yy1ZoGiAZvxnHfP33NeAzgZJogcTv7piIHC/a9JphMz62UO47WC
	wIngotDFK57foAY5EDrWFaZdHYMq5uwdrVx6bJPEBda+8hy/IdD5NYd5ontnwoF6OihscOrv4GC
	SgzhN69229m+nC6TdhHtoSfuTGPK47wh6/+9g2JbHx/ELMRJZZA==
X-Google-Smtp-Source: AGHT+IGSF4R/7XyVxnbZU+tg0tRVhzLFWy1sVPooyzjHSt4OkmCfCHyvuqMsmrQd3CiTr11yPzmQ/sLnIiwlWdA353c=
X-Received: by 2002:a17:906:4fc7:b0:a52:5925:2a31 with SMTP id
 i7-20020a1709064fc700b00a5259252a31mr1836689ejw.29.1713539820384; Fri, 19 Apr
 2024 08:17:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417211836.2742593-1-peterx@redhat.com> <20240417211836.2742593-3-peterx@redhat.com>
In-Reply-To: <20240417211836.2742593-3-peterx@redhat.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 19 Apr 2024 08:16:48 -0700
Message-ID: <CAHS8izPqCyQxMN_hRqwXQkG6WbaFg9GnmY-4=PHZSErNGjiaOQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm/hugetlb: Fix missing hugetlb_lock for resv uncharge
To: Peter Xu <peterx@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Muchun Song <muchun.song@linux.dev>, David Rientjes <rientjes@google.com>, 
	syzbot+4b8077a5fccc61c385a1@syzkaller.appspotmail.com, 
	linux-stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 2:18=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> There is a recent report on UFFDIO_COPY over hugetlb:
>
> https://lore.kernel.org/all/000000000000ee06de0616177560@google.com/
>
> 350:    lockdep_assert_held(&hugetlb_lock);
>
> Should be an issue in hugetlb but triggered in an userfault context, wher=
e
> it goes into the unlikely path where two threads modifying the resv map
> together.  Mike has a fix in that path for resv uncharge but it looks lik=
e
> the locking criteria was overlooked: hugetlb_cgroup_uncharge_folio_rsvd()
> will update the cgroup pointer, so it requires to be called with the lock
> held.
>
> Looks like a stable material, so have it copied.
>
> Reported-by: syzbot+4b8077a5fccc61c385a1@syzkaller.appspotmail.com
> Cc: Mina Almasry <almasrymina@google.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: linux-stable <stable@vger.kernel.org>
> Fixes: 79aa925bf239 ("hugetlb_cgroup: fix reservation accounting")
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

> ---
>  mm/hugetlb.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 26ab9dfc7d63..3158a55ce567 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3247,9 +3247,12 @@ struct folio *alloc_hugetlb_folio(struct vm_area_s=
truct *vma,
>
>                 rsv_adjust =3D hugepage_subpool_put_pages(spool, 1);
>                 hugetlb_acct_memory(h, -rsv_adjust);
> -               if (deferred_reserve)
> +               if (deferred_reserve) {
> +                       spin_lock_irq(&hugetlb_lock);
>                         hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h=
),
>                                         pages_per_huge_page(h), folio);
> +                       spin_unlock_irq(&hugetlb_lock);
> +               }
>         }
>
>         if (!memcg_charge_ret)
> --
> 2.44.0
>


--=20
Thanks,
Mina

