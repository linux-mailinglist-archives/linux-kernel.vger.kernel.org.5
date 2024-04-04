Return-Path: <linux-kernel+bounces-132117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53039898FD3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7614A1C22273
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2257C13AA4D;
	Thu,  4 Apr 2024 20:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r1EPaD/B"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B65131BDB
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 20:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712264144; cv=none; b=r1bbZ7Ohj8j/Dv71Q8hHiMPUc3kTnr97Ggh8SBM8BYgroH7R5u+Rvs59KWXH9WesCviTagg8pY9NP9Zxx5+A8sa+r/olkgjUMR5/qu6NkWKa4BJsB8SQ1Qc16f58uOs+Ro/JIhJxoXWzjq02RJIJMAsxEYquwqYhzH64NkMl8SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712264144; c=relaxed/simple;
	bh=OE4yu3ZUnNdgSiP234pBsxHy1AYqpkYuDYd/9Y/7ivY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p5tOpCL4h0azuQ4HkpsyDEV3WaV+OWEbfmwXCuA0RL07l3A3uwRP3dVkdWx/iAINdASBAXDeIo2rGJdhowMHqvs3+tXDThY8IWmPMwjgG3zy2r+R68TxT+7CZJ//tOY7x+ByjgXVAxuPba88ivTyNgBbpnb3KTaVej+jctPuA/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r1EPaD/B; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e0f43074edso920356a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 13:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712264141; x=1712868941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5iC1pIqUXTSnTgmvGouWQ95I32tg1xlV1RokQzbsyAY=;
        b=r1EPaD/BuX+9iemCQWqrP91j6O5AlvwhCJYhfSXiV8NFTsh+Y3/ky3Ms/7aV+74QBJ
         OIB4I2Vjl2R3KOscvXJde4HqwMQ79BkXG5J+wqiwYck3VbXxusLr1ysflwm/8AS2ZA5N
         QrJ5mzdQExZZYCLSkwWAs9IugLYEo+Zg7wluvQBPpoHcOl9d4Fg1Qi+mDSo0GMntzE67
         IqauQRG4t3YZ+Fl4XKk2TFaALH2npVu/zV2mRcUBj12uXbmB7CeUQQS3uv7v8KfHAF0K
         ipER7KEjtR0/63Tz30wBPegqoex7JbfzD0ecY2Oat5qt973zQTQp3y0IlP72Ve8EXiG/
         oqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712264141; x=1712868941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5iC1pIqUXTSnTgmvGouWQ95I32tg1xlV1RokQzbsyAY=;
        b=JbmQ/W82DXL+cXqA0GMr2K8IVb8I5xTE3U14TMWQDLaO5UZ2t8uJXJdUL4Srcxs7g/
         r4ZZtTXcuKc8D1KGPEBJSX8UIgW1vncvcLM/rJO1fjfYWu3xXMmJMhd5HPh+x+kdMC9M
         aE3LLtxC9vMwgLMxE1LLrQPpvXPx0tz7pQ2UMzcPO20yf+E4evKlEZGoG1HNprngHh6y
         Cqol73LridDZ7x+EBMxA9fTSb3Qb10NoBT60OWitZw4DExuvh+gII9haaUp8iLdmX8wH
         4BgzKg5VWLeouTs+JNLNk3acWFqjrhGdGI+qGSBtaLX3NpVxTyNXEWHppPQyZmJ7mCJX
         fDeA==
X-Forwarded-Encrypted: i=1; AJvYcCWyRbgjxcn53QUIuvz4WUKsRfUE6rG3WETlSh+zIJ2J4nwcIDu1ZkRD4zK8E/+CK8nVWH5/KQAEVzDHz3T9XfpplTt3UQgTaqRpNa2G
X-Gm-Message-State: AOJu0YxzEQ3/r5SCIl52/6sLgNejLj4/Uw6+4V7Y4sHITwdahvlxPTcJ
	PfP5Apl8szg0v3lU2cOPJW96raW5Rf6EPs2eWQhzU7XqC868tgc2YMDVT6yCWDApXcMgkQ5sX+w
	RWJQ58ROlsrFJ93colG0X17CjQHJAE+fKNCh2xBeX+R20dKtzQmvf
X-Google-Smtp-Source: AGHT+IFijaaIO1cUULiBvsqMMPBKsSOmh3PkrPxo3Hj+Z8lo29i0nEnJkkdTCXecC4aWAvTTz0SokQGmPbK/tFGMp7E=
X-Received: by 2002:a25:e015:0:b0:dcf:c389:854c with SMTP id
 x21-20020a25e015000000b00dcfc389854cmr4048035ybg.16.1712264120095; Thu, 04
 Apr 2024 13:55:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404171726.2302435-1-lokeshgidra@google.com>
 <Zg7hrt5HudXLBUn_@casper.infradead.org> <Zg8OYYV7DDo7S2Yf@x1n>
In-Reply-To: <Zg8OYYV7DDo7S2Yf@x1n>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 4 Apr 2024 13:55:07 -0700
Message-ID: <CAJuCfpGHe2=noJomL0XonT4dVGvZmVujRMEbgpYgVg_d5wo-+g@mail.gmail.com>
Subject: Re: [PATCH] userfaultfd: change src_folio after ensuring it's
 unpinned in UFFDIO_MOVE
To: Peter Xu <peterx@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, Lokesh Gidra <lokeshgidra@google.com>, 
	akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@android.com, aarcange@redhat.com, david@redhat.com, 
	zhengqi.arch@bytedance.com, kaleshsingh@google.com, ngeoffray@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 1:32=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Apr 04, 2024 at 06:21:50PM +0100, Matthew Wilcox wrote:
> > On Thu, Apr 04, 2024 at 10:17:26AM -0700, Lokesh Gidra wrote:
> > > -           folio_move_anon_rmap(src_folio, dst_vma);
> > > -           WRITE_ONCE(src_folio->index, linear_page_index(dst_vma, d=
st_addr));
> > > -
> > >             src_pmdval =3D pmdp_huge_clear_flush(src_vma, src_addr, s=
rc_pmd);
> > >             /* Folio got pinned from under us. Put it back and fail t=
he move. */
> > >             if (folio_maybe_dma_pinned(src_folio)) {
> > > @@ -2270,6 +2267,9 @@ int move_pages_huge_pmd(struct mm_struct *mm, p=
md_t *dst_pmd, pmd_t *src_pmd, pm
> > >                     goto unlock_ptls;
> > >             }
> > >
> > > +           folio_move_anon_rmap(src_folio, dst_vma);
> > > +           WRITE_ONCE(src_folio->index, linear_page_index(dst_vma, d=
st_addr));
> > > +
> >
> > This use of WRITE_ONCE scares me.  We hold the folio locked.  Why do
> > we need to use WRITE_ONCE?  Who's looking at folio->index without
> > holding the folio lock?
>
> Seems true, but maybe suitable for a separate patch to clean it even so?
> We also have the other pte level which has the same WRITE_ONCE(), so if w=
e
> want to drop we may want to drop both.

Yes, I'll do that separately and will remove WRITE_ONCE() in both places.

>
> I just got to start reading some the new move codes (Lokesh, apologies on
> not be able to provide feedbacks previously..), but then I found one thin=
g
> unclear, on special handling of private file mappings only in userfault
> context, and I didn't know why:
>
> lock_vma():
>         if (vma) {
>                 /*
>                  * lock_vma_under_rcu() only checks anon_vma for private
>                  * anonymous mappings. But we need to ensure it is assign=
ed in
>                  * private file-backed vmas as well.
>                  */
>                 if (!(vma->vm_flags & VM_SHARED) && unlikely(!vma->anon_v=
ma))
>                         vma_end_read(vma);
>                 else
>                         return vma;
>         }
>
> AFAIU even for generic users of lock_vma_under_rcu(), anon_vma must be
> stable to be used.  Here it's weird to become an userfault specific
> operation to me.
>
> I was surprised how it worked for private file maps on faults, then I had=
 a
> check and it seems we postponed such check until vmf_anon_prepare(), whic=
h
> is the CoW path already, so we do as I expected, but seems unnecessary to
> that point?
>
> Would something like below make it much cleaner for us?  As I just don't
> yet see why userfault is special here.
>
> Thanks,
>
> =3D=3D=3D8<=3D=3D=3D
> diff --git a/mm/memory.c b/mm/memory.c
> index 984b138f85b4..d5cf1d31c671 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3213,10 +3213,8 @@ vm_fault_t vmf_anon_prepare(struct vm_fault *vmf)
>
>         if (likely(vma->anon_vma))
>                 return 0;
> -       if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> -               vma_end_read(vma);
> -               return VM_FAULT_RETRY;
> -       }
> +       /* We shouldn't try a per-vma fault at all if anon_vma isn't soli=
d */
> +       WARN_ON_ONCE(vmf->flags & FAULT_FLAG_VMA_LOCK);
>         if (__anon_vma_prepare(vma))
>                 return VM_FAULT_OOM;
>         return 0;
> @@ -5817,9 +5815,9 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm=
_struct *mm,
>          * find_mergeable_anon_vma uses adjacent vmas which are not locke=
d.
>          * This check must happen after vma_start_read(); otherwise, a
>          * concurrent mremap() with MREMAP_DONTUNMAP could dissociate the=
 VMA
> -        * from its anon_vma.
> +        * from its anon_vma.  This applies to both anon or private file =
maps.
>          */
> -       if (unlikely(vma_is_anonymous(vma) && !vma->anon_vma))
> +       if (unlikely(!(vma->vm_flags & VM_SHARED) && !vma->anon_vma))
>                 goto inval_end_read;
>
>         /* Check since vm_start/vm_end might change before we lock the VM=
A */
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index f6267afe65d1..61f21da77dcd 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -72,17 +72,8 @@ static struct vm_area_struct *lock_vma(struct mm_struc=
t *mm,
>         struct vm_area_struct *vma;
>
>         vma =3D lock_vma_under_rcu(mm, address);
> -       if (vma) {
> -               /*
> -                * lock_vma_under_rcu() only checks anon_vma for private
> -                * anonymous mappings. But we need to ensure it is assign=
ed in
> -                * private file-backed vmas as well.
> -                */
> -               if (!(vma->vm_flags & VM_SHARED) && unlikely(!vma->anon_v=
ma))
> -                       vma_end_read(vma);
> -               else
> -                       return vma;
> -       }
> +       if (vma)
> +               return vma;
>
>         mmap_read_lock(mm);
>         vma =3D find_vma_and_prepare_anon(mm, address);
> --
> 2.44.0
>
>
> --
> Peter Xu
>

