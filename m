Return-Path: <linux-kernel+bounces-77419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC218604FA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DE64284A72
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75E373F3D;
	Thu, 22 Feb 2024 21:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ltjpLBje"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB2473F1C
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 21:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708638098; cv=none; b=Uli2DPzTv5aFdiD+pWU5MXVJolULzPJlGe2P5fNrBQEl2Q+4IjkooAqWeVduryiQYB3T0PWu2ZqNOsQ/JnyExeyweQAUDLb9bf0i5FIivmV7oGvDrdBcg4c04KRZkLiZ2m3I+zv6GU0Ot/8exyso3ocyCCphwcd2VdS5NtDJYrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708638098; c=relaxed/simple;
	bh=iMuX0s4VaALEnLzlD+D8IQh3rFJI+DIf/ErWvzT8vhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fu8bGv8T2V1dTVidopQw2Xxghmu6cCPnYg7WwAN0hbhnQRFHLanVZt6U3GkepQXMjwNdiCFoBc3F1gQOqsmdAkvX/ULIOgWCAZSu7Z2439JZikUSCMfyDKAcMos8s06eHCkSFjQ0QEqpb/5W4Qw+9pLkyyHHcnZeV6lGu4Nw6us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ltjpLBje; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dcbcea9c261so192219276.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 13:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708638095; x=1709242895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmgCzE9LjwDzmPCc5NVDUCPpvcBzTrPnv764C/CP8R4=;
        b=ltjpLBjepsxTaPPzGKJEjVVFff5l0uVFJjYK/BbdKBRdlD9lT1r71o1zSQ/hHeuMx6
         WlQfuNTxvMoS5fbslhoqRVqjvuk2tIiiBZMmTLXE/aDiU0rcYwIVybyP7mN+RCuWKjgn
         Y8PsSUSkDaE2Fl3OprRrRjwL3dTmxv6KhmXDOMQI+gGUcafWehC/06fdDdwuecuPeFP9
         p9d2ypgh6q5OrBi+1GI+4+VNK4SgSGjqF7kMKqlMpzSyfBcVijYC4BurFvWAFg7yBHW2
         MIfEjTkmXv3EFKJYP22bkwfWyal9Of8NcTu1YDECuNONuyNEeIG6lQRXMsY8PL1Nltm1
         GW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708638095; x=1709242895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QmgCzE9LjwDzmPCc5NVDUCPpvcBzTrPnv764C/CP8R4=;
        b=wvH6of0/WgPhUoaS1gFlmw8OzPimcIZXJBG0Q8qyBShG0wT34vpxUM+xluGzzDSEsk
         mY5BRn1+ZrWjKLYktDepZpP7QLqTn++2ZPonsreicFQWeTp/ctcrweGsoZJrHvdBPNeH
         HRD3ZgFCKx4vCHbOpaO1lsgpTkmzygd3WR6J5uqiAzSd7puhh7Vg050uyy42Xp4WWftX
         yFFpOIpg+xx+vt49bVtnd6knwYuW4RLdRGx+1oEpj1WKoXrD4y98Eed+CG2nts/E+R1y
         7QP8hk2zfadaEgqfCm1R6e5Nhri/sjESIvxsrimEKboP+L1snihmx4gglKH/ItzLRu2d
         XMBw==
X-Forwarded-Encrypted: i=1; AJvYcCUHXaDTvBXP9BhRIauRc0VaQLUsPq6wAqmHO611irnJKRyo85Sf26ZYS5DBQMzRE9xz/WGuCFy8apsU4d2kql+wu4WsBPEPpx27njeP
X-Gm-Message-State: AOJu0YxMHou/RhQUCqK1gsqL3mB3zGQgHJoZ6E1fnXt2hJfPdJP+Ph4K
	YLQawThu3knpGVHrDd11GZynoaSzhS65hSVTJfK9/gQJmlf7ccw3B3/C4cZQh7D0A/adGxpRst4
	XyHVrHhaRTQ/y1wSJw5PhcqABB1es5xbvXtog
X-Google-Smtp-Source: AGHT+IE5Cduia9Zqq/neFK9r466+MplB0k8dv91Jf+qZqUaukHu2rdbTtyZUd+6fF0kheatV3u2BeQ5qtuFLjjqN4+A=
X-Received: by 2002:a05:690c:3388:b0:602:b697:dc60 with SMTP id
 fl8-20020a05690c338800b00602b697dc60mr472794ywb.50.1708638095219; Thu, 22 Feb
 2024 13:41:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222080815.46291-1-zhengqi.arch@bytedance.com> <ad82668d-10c6-4670-97f3-77c60a391c5f@redhat.com>
In-Reply-To: <ad82668d-10c6-4670-97f3-77c60a391c5f@redhat.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 22 Feb 2024 13:41:22 -0800
Message-ID: <CAJuCfpGznL_4PJXq6JfYTR6VZ7H=xbdQYNN_DzS1QR3OtRHGEQ@mail.gmail.com>
Subject: Re: [PATCH] mm: userfaultfd: fix unexpected change to src_folio when
 UFFDIO_MOVE fails
To: David Hildenbrand <david@redhat.com>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org, 
	aarcange@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 12:43=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 22.02.24 09:08, Qi Zheng wrote:
> > After ptep_clear_flush(), if we find that src_folio is pinned we will f=
ail
> > UFFDIO_MOVE and put src_folio back to src_pte entry, but the change to
> > src_folio->{mapping,index} is not restored in this process. This is not
> > what we expected, so fix it.
> >
> > Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> > Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> > ---
> >   mm/userfaultfd.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index 4744d6a96f96..503ea77c81aa 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -1008,9 +1008,6 @@ static int move_present_pte(struct mm_struct *mm,
> >               goto out;
> >       }
> >
> > -     folio_move_anon_rmap(src_folio, dst_vma);
> > -     WRITE_ONCE(src_folio->index, linear_page_index(dst_vma, dst_addr)=
);
> > -
> >       orig_src_pte =3D ptep_clear_flush(src_vma, src_addr, src_pte);
> >       /* Folio got pinned from under us. Put it back and fail the move.=
 */
> >       if (folio_maybe_dma_pinned(src_folio)) {
> > @@ -1019,6 +1016,9 @@ static int move_present_pte(struct mm_struct *mm,
> >               goto out;
> >       }
> >
> > +     folio_move_anon_rmap(src_folio, dst_vma);
> > +     WRITE_ONCE(src_folio->index, linear_page_index(dst_vma, dst_addr)=
);
> > +
> >       orig_dst_pte =3D mk_pte(&src_folio->page, dst_vma->vm_page_prot);
> >       /* Follow mremap() behavior and treat the entry dirty after the m=
ove */
> >       orig_dst_pte =3D pte_mkwrite(pte_mkdirty(orig_dst_pte), dst_vma);
>
> Indeed, LGTM.
>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks for catching this! Makes total sense to check before modification.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> --
> Cheers,
>
> David / dhildenb
>

