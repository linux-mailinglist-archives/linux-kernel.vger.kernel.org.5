Return-Path: <linux-kernel+bounces-63436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79472852F43
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2AF61F2165E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F164D374C9;
	Tue, 13 Feb 2024 11:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nWOUkteQ"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F49374C1
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 11:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707823509; cv=none; b=ZDs3q+6bfQfb5AfnJtrVSNU4aDg13d+5iTcydFnBFm3iybZClx2iQR4SZDA4V2oJSRSQwy+UnHVzz/5S/YP20NudK6uT9IOrH3mzbdEhiFmRwYm6uga9jlxmMEmMWzpD15Iblm2RY765AZJnbQ7i5DDtN19BE6YX6ZcvHjqBRjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707823509; c=relaxed/simple;
	bh=Zw8haxAapUBG44nEylJwQccZGFGgWD0ChLnhmjrvZNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=SktGz7SnHpk1orIefYh+BNNrNRy6AGq/fKEGESvdEml/HdxD8AsZLYQXeY9/WQ6T45yuFB53PCBCKpcl1rzW/2OcATq5+haruEnvKK1K0MHPaXJzHmRTm6C7U1q5kpo7Xv7S9FeY4+jp+rPHQfkObvLK/meV0cymfCZ1YYGqbKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nWOUkteQ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33cddf4b4b5so220466f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 03:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707823505; x=1708428305; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7B1VdNEjxdBHUG+t3lw56dnlzhGxxWmEE0AwtlQokM=;
        b=nWOUkteQTjFRGq8xUbJgA4b5tA7kklIZ/tVCWet1dHXNrVQJb+gUS7YOwVIa3TOosf
         0prgb7d8lsWlmXuUI5tDovUulHiIBp4+rvRkoNOqvW/dMA07R4EH/J5Nxa2iFJhqvmKc
         GjSFjCxXL9mfOHgirVkERoYLEO+G6tvqh5pCAsuDQZpixsGQuiOQ4PRIm6eKnwLIxFSx
         U1vEegxGPnCRDPoKyCgd8hJC5OOrYu+BtURGK6pewwl95PmIgP6eBM9xAnxQI4W4Zhka
         97yRPiyQxpF3Fmv2veKvOe8Y1UyhkQcfyM+dl1xvCHFYOQz9sn1bsg5n5JuIkqFxmcAs
         9q1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707823505; x=1708428305;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7B1VdNEjxdBHUG+t3lw56dnlzhGxxWmEE0AwtlQokM=;
        b=iKN9tzF7O+shN57y1CH7nlKX5E6ESu0sjskvF5cajos97HHZjqN5aEHExQVUyA3co8
         H6C+I2HtIm/U/EX48UJYNpvQ3mpT0N8IqhoPHM1tK+MamIy14diLwGwoqkdJLaRKwWrj
         /iOO8sMrnHSqrr0cZJT3DaDE2FpnaxBBqTcEJkJdtwQHabxMrvl7WLyExT7lKsitlS+O
         pY0WwYKSmfe6YwVaM7lgm+RbV7W7fyr6CMVtqAfaRSZi4QH6aCOkUfyMSNMLqDj3rgML
         GOE6xaP5BN8k//whs6rvMAV+cgrFYVY58Wl+tw13loqZ9EjDc6FH6YIn8J5hmgCH5X3q
         NaVA==
X-Forwarded-Encrypted: i=1; AJvYcCWkhqT0wIwbHDs0BYEtX5FFRRV/RUcvx8cRgRR+HnnHR4zTu5G7hsm2LvzUhyIrtLZgiXJEr9MiCtHQ3TaWbR3tQcOsszvla0plBfRn
X-Gm-Message-State: AOJu0YzFMJYsLjsPKuMexJkrro0AWOxJ64KyfSne79F2cXeENxxhYAlY
	DjF/Fz6HSr5xtA7iLhoiBecjEL1V78ZuNQ+ruk0FmZjONntJi7rs482b38ujjqlRCtfl6FNxy0A
	kPVVRVCWiYD2m2llaV+otWyZDCLJtWibt+zRA
X-Google-Smtp-Source: AGHT+IFDvKZilqGPmprSihukL2cOV+DX1TDTDe1cz5RyBlvdIbIU9j0HXFdr6eKEBuH81WUcfNsiM9yJ0Ex2CNjDRAA=
X-Received: by 2002:adf:eec9:0:b0:33b:2281:ef32 with SMTP id
 a9-20020adfeec9000000b0033b2281ef32mr7382022wrp.69.1707823505374; Tue, 13 Feb
 2024 03:25:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213001920.3551772-1-lokeshgidra@google.com>
 <20240213001920.3551772-4-lokeshgidra@google.com> <20240213033307.zbhrpjigco7vl56z@revolver>
In-Reply-To: <20240213033307.zbhrpjigco7vl56z@revolver>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Tue, 13 Feb 2024 03:24:53 -0800
Message-ID: <CA+EESO5TNubw4vi08P6BO-4XKTLNVeNfjM92ieZJTd_oJt9Ygw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] userfaultfd: use per-vma locks in userfaultfd operations
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Lokesh Gidra <lokeshgidra@google.com>, 
	akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, surenb@google.com, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 7:33=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Lokesh Gidra <lokeshgidra@google.com> [240212 19:19]:
> > All userfaultfd operations, except write-protect, opportunistically use
> > per-vma locks to lock vmas. On failure, attempt again inside mmap_lock
> > critical section.
> >
> > Write-protect operation requires mmap_lock as it iterates over multiple
> > vmas.
> >
> > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > ---
> >  fs/userfaultfd.c              |  13 +-
> >  include/linux/userfaultfd_k.h |   5 +-
> >  mm/userfaultfd.c              | 392 ++++++++++++++++++++++++++--------
> >  3 files changed, 312 insertions(+), 98 deletions(-)
> >
> ...
>
> > +
> > +static __always_inline
> > +struct vm_area_struct *find_vma_and_prepare_anon(struct mm_struct *mm,
> > +                                              unsigned long addr)
> > +{
> > +     struct vm_area_struct *vma;
> > +
> > +     mmap_assert_locked(mm);
> > +     vma =3D vma_lookup(mm, addr);
> > +     if (!vma)
> > +             vma =3D ERR_PTR(-ENOENT);
> > +     else if (!(vma->vm_flags & VM_SHARED) && anon_vma_prepare(vma))
> > +             vma =3D ERR_PTR(-ENOMEM);
>
> Nit: I just noticed that the code below says anon_vma_prepare() is unlike=
ly.
>
Thanks for catching this. I'll add it in next version.
> ...
>
> > +static struct vm_area_struct *lock_mm_and_find_dst_vma(struct mm_struc=
t *dst_mm,
> > +                                                    unsigned long dst_=
start,
> > +                                                    unsigned long len)
> > +{
> > +     struct vm_area_struct *dst_vma;
> > +     int err;
> > +
> > +     mmap_read_lock(dst_mm);
> > +     dst_vma =3D find_vma_and_prepare_anon(dst_mm, dst_start);
> > +     if (IS_ERR(dst_vma)) {
> > +             err =3D PTR_ERR(dst_vma);
>
> It's sort of odd you decode then re-encode this error, but it's correct
> the way you have it written.  You could just encode ENOENT instead?

Thanks. It was an oversight. I'll fix it.
>
> > +             goto out_unlock;
> > +     }
> > +
> > +     if (validate_dst_vma(dst_vma, dst_start + len))
> > +             return dst_vma;
> > +
> > +     err =3D -ENOENT;
> > +out_unlock:
> > +     mmap_read_unlock(dst_mm);
> > +     return ERR_PTR(err);
> >  }
> > +#endif
> >
> ...
>
> > +static __always_inline
> > +long find_vmas_mm_locked(struct mm_struct *mm,
>
> int would probably do?
> > +                      unsigned long dst_start,
> > +                      unsigned long src_start,
> > +                      struct vm_area_struct **dst_vmap,
> > +                      struct vm_area_struct **src_vmap)
> > +{
> > +     struct vm_area_struct *vma;
> > +
> > +     mmap_assert_locked(mm);
> > +     vma =3D find_vma_and_prepare_anon(mm, dst_start);
> > +     if (IS_ERR(vma))
> > +             return PTR_ERR(vma);
> > +
> > +     *dst_vmap =3D vma;
> > +     /* Skip finding src_vma if src_start is in dst_vma */
> > +     if (src_start >=3D vma->vm_start && src_start < vma->vm_end)
> > +             goto out_success;
> > +
> > +     vma =3D vma_lookup(mm, src_start);
> > +     if (!vma)
> > +             return -ENOENT;
> > +out_success:
> > +     *src_vmap =3D vma;
> > +     return 0;
> > +}
> > +
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +static long find_and_lock_vmas(struct mm_struct *mm,
>
> This could also be an int return type, I must be missing something?

If you look at ERR_PTR() etc. macros, they all use 'long' for
conversions. Also, this file uses long/ssize_t/int at different
places. So I went in favor of long. I'm sure int would work just fine
too. Let me know if you want me to change it to int.
>
> ...
>
> > +     *src_vmap =3D lock_vma_under_rcu(mm, src_start);
> > +     if (likely(*src_vmap))
> > +             return 0;
> > +
> > +     /* Undo any locking and retry in mmap_lock critical section */
> > +     vma_end_read(*dst_vmap);
> > +
> > +     mmap_read_lock(mm);
> > +     err =3D find_vmas_mm_locked(mm, dst_start, src_start, dst_vmap, s=
rc_vmap);
> > +     if (!err) {
> > +             /*
> > +              * See comment in lock_vma() as to why not using
> > +              * vma_start_read() here.
> > +              */
> > +             down_read(&(*dst_vmap)->vm_lock->lock);
> > +             if (*dst_vmap !=3D *src_vmap)
> > +                     down_read(&(*src_vmap)->vm_lock->lock);
> > +     }
> > +     mmap_read_unlock(mm);
> > +     return err;
> > +}
> > +#else
> > +static long lock_mm_and_find_vmas(struct mm_struct *mm,
> > +                               unsigned long dst_start,
> > +                               unsigned long src_start,
> > +                               struct vm_area_struct **dst_vmap,
> > +                               struct vm_area_struct **src_vmap)
> > +{
> > +     long err;
> > +
> > +     mmap_read_lock(mm);
> > +     err =3D find_vmas_mm_locked(mm, dst_start, src_start, dst_vmap, s=
rc_vmap);
> > +     if (err)
> > +             mmap_read_unlock(mm);
> > +     return err;
> >  }
> > +#endif
>
> This section is much easier to understand.  Thanks.

I'm glad finally the patch is easier to follow. Thanks so much for
your prompt reviews.
>
> Thanks,
> Liam

