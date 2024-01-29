Return-Path: <linux-kernel+bounces-43574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AF28415CA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51CF9B23B73
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9887F15959E;
	Mon, 29 Jan 2024 22:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QgrlIxjD"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F655103E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 22:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706567751; cv=none; b=uCVLjifqg4W43yn3wDQIfaMkAKrMNCGbXKHaeZG2e6PohZLnFh7V+Y/49PMCGnfBI4Z2r4Mg5+AM4OL8MS+UexWY4ImksdVl67sQrQ4v7UxZkL3P/9Et+4FLm2w/gXo/XvT2vvzO3HWFl8plySQWNQyBnIpVYTbpA6n0l+GLvQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706567751; c=relaxed/simple;
	bh=s+G+9sjvSoX5XgBQ6z4AUcbG6RL1FicQxfKQ3QcjecI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Ii8hvy1MPJl25GB8FBAbTMthqhqNcE9HWqcOGHJBHhPO3nR1tMoRM4E3Jb742A4OOOAbSsNSl5dX/Z+Jq0pnmmoOvo2rXHseTWM7iSMr/EZYU/qb1PUniAz8vIr1XliqNdhQ/vs7iMrXGdsuILytaF703fj2ZIjH/ed2AKHTcaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QgrlIxjD; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40ef207c654so18153645e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 14:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706567747; x=1707172547; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nAcge6e4bZ+atcwcU+LlRcSma3RpIGNh/KwuVkxAx7I=;
        b=QgrlIxjDEMlozJTce9wkxflhX0/NBBau3dkMkY+j8K8z2m+TG4q2Ee1+a/Dfiw3yRe
         1SwFXhSYF4pe3boDYf9NLi9x4ZGtSSL3BH5sh3aBh+wd9/slNX3bTYBJcWlTTpMSsObK
         FWnH+YVYC6D9CAE8T0meVYw8OJObY4uLEkoid3KM1GV4PjgymJzF98fZ4J9/QXxkfatb
         rSbnGPBh3Khr+hwesnTGjtrOh358TXTxHMYon5clGTM8gfW/03fQemNtI6dCiGucwG7e
         EBCLYJardMRc0MKXqiMUPSQz17MIPR2V6x3FA3Xa6WHAP6s5kTsBVXQY+UTwrCPyw2Ha
         LD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706567747; x=1707172547;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nAcge6e4bZ+atcwcU+LlRcSma3RpIGNh/KwuVkxAx7I=;
        b=ojAq7jxHkrUyd+lgdZKXK8w1MQ+fZ8r9M3DQ9XT1Ip3q89BB0eGZSkVQex6Z/qZkz0
         JZOjlnBPC8oE4UAfgOjxvw5I9WOCg55toYBmQdpHyLAdLo2+tB08uI13T9hmKSxJOKAD
         sl+Zf9Zj7Hv2v4PEvu7MwYzaGdKeOoi4ZF8C0nM9f8/vcjb3OMC5dizGrkowwLDUMzBk
         YFzTi1GjL6Nojk0aD2hOKKjVD6wysdmPe8zcvnURTC0i/vNFGdgN4c4RR/Q6NBs6hCHz
         kx4K0oaSfFmE0lSCinuEHzHZQl69UzoFF5w3G6McRPIoiTGSFgOGN35F5gKRf863PfGj
         Z31A==
X-Gm-Message-State: AOJu0Yyhtu6PhVJQQP3CQrAeu5exZZpoCJhxfKpMfPZpiN96bw6cnwAK
	9ht7ViYVhnQCNHhLmzFdlnmpnxqANXePZgYCikgsYf/oXe/h2V9hkZwPOAiEJghw26/iVhinoDK
	G6WLIfDCFg7C2SX0+xdeur/agCXzYckK2ogqh
X-Google-Smtp-Source: AGHT+IHKTx6TKKMJqRKYrlcoWFxencD+Ug2zjqF2Z5Pjq/Ylpfs4IiZgAEMP7vijiJBgFprWXOWwkVzBJ1nlff5tOys=
X-Received: by 2002:a05:6000:1a8c:b0:33a:ed47:2858 with SMTP id
 f12-20020a0560001a8c00b0033aed472858mr3625434wry.63.1706567746536; Mon, 29
 Jan 2024 14:35:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129193512.123145-1-lokeshgidra@google.com>
 <20240129193512.123145-3-lokeshgidra@google.com> <20240129210014.troxejbr3mzorcvx@revolver>
In-Reply-To: <20240129210014.troxejbr3mzorcvx@revolver>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Mon, 29 Jan 2024 14:35:34 -0800
Message-ID: <CA+EESO6XiPfbUBgU3FukGvi_NG5XpAQxWKu7vg534t=rtWmGXg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] userfaultfd: protect mmap_changing with rw_sem in userfaulfd_ctx
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Lokesh Gidra <lokeshgidra@google.com>, 
	akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, surenb@google.com, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 1:00=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Lokesh Gidra <lokeshgidra@google.com> [240129 14:35]:
> > Increments and loads to mmap_changing are always in mmap_lock
> > critical section.
>
> Read or write?
>
It's write-mode when incrementing (except in case of
userfaultfd_remove() where it's done in read-mode) and loads are in
mmap_lock (read-mode). I'll clarify this in the next version.
>
> > This ensures that if userspace requests event
> > notification for non-cooperative operations (e.g. mremap), userfaultfd
> > operations don't occur concurrently.
> >
> > This can be achieved by using a separate read-write semaphore in
> > userfaultfd_ctx such that increments are done in write-mode and loads
> > in read-mode, thereby eliminating the dependency on mmap_lock for this
> > purpose.
> >
> > This is a preparatory step before we replace mmap_lock usage with
> > per-vma locks in fill/move ioctls.
> >
> > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > ---
> >  fs/userfaultfd.c              | 40 ++++++++++++----------
> >  include/linux/userfaultfd_k.h | 31 ++++++++++--------
> >  mm/userfaultfd.c              | 62 ++++++++++++++++++++---------------
> >  3 files changed, 75 insertions(+), 58 deletions(-)
> >
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index 58331b83d648..c00a021bcce4 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -685,12 +685,15 @@ int dup_userfaultfd(struct vm_area_struct *vma, s=
truct list_head *fcs)
> >               ctx->flags =3D octx->flags;
> >               ctx->features =3D octx->features;
> >               ctx->released =3D false;
> > +             init_rwsem(&ctx->map_changing_lock);
> >               atomic_set(&ctx->mmap_changing, 0);
> >               ctx->mm =3D vma->vm_mm;
> >               mmgrab(ctx->mm);
> >
> >               userfaultfd_ctx_get(octx);
> > +             down_write(&octx->map_changing_lock);
> >               atomic_inc(&octx->mmap_changing);
> > +             up_write(&octx->map_changing_lock);
>
> This can potentially hold up your writer as the readers execute.  I
> think this will change your priority (ie: priority inversion)?

Priority inversion, if any, is already happening due to mmap_lock, no?
Also, I thought rw_semaphore implementation is fair, so the writer
will eventually get the lock right? Please correct me if I'm wrong.

At this patch: there can't be any readers as they need to acquire
mmap_lock in read-mode first. While writers, at the point of
incrementing mmap_changing, already hold mmap_lock in write-mode.

With per-vma locks, the same synchronization that mmap_lock achieved
around mmap_changing, will be achieved by ctx->map_changing_lock.
>
> You could use the first bit of the atomic_inc as indication of a write.
> So if the mmap_changing is even, then there are no writers.  If it
> didn't change and it's even then you know no modification has happened
> (or it overflowed and hit the same number which would be rare, but
> maybe okay?).

This is already achievable, right? If mmap_changing is >0 then we know
there are writers. The problem is that we want writers (like mremap
operations) to block as long as there is a userfaultfd operation (also
reader of mmap_changing) going on. Please note that I'm inferring this
from current implementation.

AFAIU, mmap_changing isn't required for correctness, because all
operations are happening under the right mode of mmap_lock. It's used
to ensure that while a non-cooperative operations is happening, if the
user has asked it to be notified, then no other userfaultfd operations
should take place until the user gets the event notification.
>
> >               fctx->orig =3D octx;
> >               fctx->new =3D ctx;
> >               list_add_tail(&fctx->list, fcs);
> > @@ -737,7 +740,9 @@ void mremap_userfaultfd_prep(struct vm_area_struct =
*vma,
> >       if (ctx->features & UFFD_FEATURE_EVENT_REMAP) {
> >               vm_ctx->ctx =3D ctx;
> >               userfaultfd_ctx_get(ctx);
> > +             down_write(&ctx->map_changing_lock);
> >               atomic_inc(&ctx->mmap_changing);
> > +             up_write(&ctx->map_changing_lock);
> >       } else {
> >               /* Drop uffd context if remap feature not enabled */
> >               vma_start_write(vma);
> > @@ -783,7 +788,9 @@ bool userfaultfd_remove(struct vm_area_struct *vma,
> >               return true;
> >
> >       userfaultfd_ctx_get(ctx);
> > +     down_write(&ctx->map_changing_lock);
> >       atomic_inc(&ctx->mmap_changing);
> > +     up_write(&ctx->map_changing_lock);
> >       mmap_read_unlock(mm);
> >
> >       msg_init(&ewq.msg);
> > @@ -825,7 +832,9 @@ int userfaultfd_unmap_prep(struct vm_area_struct *v=
ma, unsigned long start,
> >               return -ENOMEM;
> >
> >       userfaultfd_ctx_get(ctx);
> > +     down_write(&ctx->map_changing_lock);
> >       atomic_inc(&ctx->mmap_changing);
> > +     up_write(&ctx->map_changing_lock);
> >       unmap_ctx->ctx =3D ctx;
> >       unmap_ctx->start =3D start;
> >       unmap_ctx->end =3D end;
> > @@ -1709,9 +1718,8 @@ static int userfaultfd_copy(struct userfaultfd_ct=
x *ctx,
> >       if (uffdio_copy.mode & UFFDIO_COPY_MODE_WP)
> >               flags |=3D MFILL_ATOMIC_WP;
> >       if (mmget_not_zero(ctx->mm)) {
> > -             ret =3D mfill_atomic_copy(ctx->mm, uffdio_copy.dst, uffdi=
o_copy.src,
> > -                                     uffdio_copy.len, &ctx->mmap_chang=
ing,
> > -                                     flags);
> > +             ret =3D mfill_atomic_copy(ctx, uffdio_copy.dst, uffdio_co=
py.src,
> > +                                     uffdio_copy.len, flags);
> >               mmput(ctx->mm);
> >       } else {
> >               return -ESRCH;
> > @@ -1761,9 +1769,8 @@ static int userfaultfd_zeropage(struct userfaultf=
d_ctx *ctx,
> >               goto out;
> >
> >       if (mmget_not_zero(ctx->mm)) {
> > -             ret =3D mfill_atomic_zeropage(ctx->mm, uffdio_zeropage.ra=
nge.start,
> > -                                        uffdio_zeropage.range.len,
> > -                                        &ctx->mmap_changing);
> > +             ret =3D mfill_atomic_zeropage(ctx, uffdio_zeropage.range.=
start,
> > +                                        uffdio_zeropage.range.len);
> >               mmput(ctx->mm);
> >       } else {
> >               return -ESRCH;
> > @@ -1818,9 +1825,8 @@ static int userfaultfd_writeprotect(struct userfa=
ultfd_ctx *ctx,
> >               return -EINVAL;
> >
> >       if (mmget_not_zero(ctx->mm)) {
> > -             ret =3D mwriteprotect_range(ctx->mm, uffdio_wp.range.star=
t,
> > -                                       uffdio_wp.range.len, mode_wp,
> > -                                       &ctx->mmap_changing);
> > +             ret =3D mwriteprotect_range(ctx, uffdio_wp.range.start,
> > +                                       uffdio_wp.range.len, mode_wp);
> >               mmput(ctx->mm);
> >       } else {
> >               return -ESRCH;
> > @@ -1870,9 +1876,8 @@ static int userfaultfd_continue(struct userfaultf=
d_ctx *ctx, unsigned long arg)
> >               flags |=3D MFILL_ATOMIC_WP;
> >
> >       if (mmget_not_zero(ctx->mm)) {
> > -             ret =3D mfill_atomic_continue(ctx->mm, uffdio_continue.ra=
nge.start,
> > -                                         uffdio_continue.range.len,
> > -                                         &ctx->mmap_changing, flags);
> > +             ret =3D mfill_atomic_continue(ctx, uffdio_continue.range.=
start,
> > +                                         uffdio_continue.range.len, fl=
ags);
> >               mmput(ctx->mm);
> >       } else {
> >               return -ESRCH;
> > @@ -1925,9 +1930,8 @@ static inline int userfaultfd_poison(struct userf=
aultfd_ctx *ctx, unsigned long
> >               goto out;
> >
> >       if (mmget_not_zero(ctx->mm)) {
> > -             ret =3D mfill_atomic_poison(ctx->mm, uffdio_poison.range.=
start,
> > -                                       uffdio_poison.range.len,
> > -                                       &ctx->mmap_changing, 0);
> > +             ret =3D mfill_atomic_poison(ctx, uffdio_poison.range.star=
t,
> > +                                       uffdio_poison.range.len, 0);
> >               mmput(ctx->mm);
> >       } else {
> >               return -ESRCH;
> > @@ -2003,13 +2007,14 @@ static int userfaultfd_move(struct userfaultfd_=
ctx *ctx,
> >       if (mmget_not_zero(mm)) {
> >               mmap_read_lock(mm);
> >
> > -             /* Re-check after taking mmap_lock */
> > +             /* Re-check after taking map_changing_lock */
> > +             down_read(&ctx->map_changing_lock);
> >               if (likely(!atomic_read(&ctx->mmap_changing)))
> >                       ret =3D move_pages(ctx, mm, uffdio_move.dst, uffd=
io_move.src,
> >                                        uffdio_move.len, uffdio_move.mod=
e);
> >               else
> >                       ret =3D -EAGAIN;
> > -
> > +             up_read(&ctx->map_changing_lock);
> >               mmap_read_unlock(mm);
> >               mmput(mm);
> >       } else {
> > @@ -2216,6 +2221,7 @@ static int new_userfaultfd(int flags)
> >       ctx->flags =3D flags;
> >       ctx->features =3D 0;
> >       ctx->released =3D false;
> > +     init_rwsem(&ctx->map_changing_lock);
> >       atomic_set(&ctx->mmap_changing, 0);
> >       ctx->mm =3D current->mm;
> >       /* prevent the mm struct to be freed */
> > diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_=
k.h
> > index 691d928ee864..3210c3552976 100644
> > --- a/include/linux/userfaultfd_k.h
> > +++ b/include/linux/userfaultfd_k.h
> > @@ -69,6 +69,13 @@ struct userfaultfd_ctx {
> >       unsigned int features;
> >       /* released */
> >       bool released;
> > +     /*
> > +      * Prevents userfaultfd operations (fill/move/wp) from happening =
while
> > +      * some non-cooperative event(s) is taking place. Increments are =
done
> > +      * in write-mode. Whereas, userfaultfd operations, which includes
> > +      * reading mmap_changing, is done under read-mode.
> > +      */
> > +     struct rw_semaphore map_changing_lock;
> >       /* memory mappings are changing because of non-cooperative event =
*/
> >       atomic_t mmap_changing;
> >       /* mm with one ore more vmas attached to this userfaultfd_ctx */
> > @@ -113,22 +120,18 @@ extern int mfill_atomic_install_pte(pmd_t *dst_pm=
d,
> >                                   unsigned long dst_addr, struct page *=
page,
> >                                   bool newly_allocated, uffd_flags_t fl=
ags);
> >
> > -extern ssize_t mfill_atomic_copy(struct mm_struct *dst_mm, unsigned lo=
ng dst_start,
> > +extern ssize_t mfill_atomic_copy(struct userfaultfd_ctx *ctx, unsigned=
 long dst_start,
> >                                unsigned long src_start, unsigned long l=
en,
> > -                              atomic_t *mmap_changing, uffd_flags_t fl=
ags);
> > -extern ssize_t mfill_atomic_zeropage(struct mm_struct *dst_mm,
> > +                              uffd_flags_t flags);
> > +extern ssize_t mfill_atomic_zeropage(struct userfaultfd_ctx *ctx,
> >                                    unsigned long dst_start,
> > -                                  unsigned long len,
> > -                                  atomic_t *mmap_changing);
> > -extern ssize_t mfill_atomic_continue(struct mm_struct *dst_mm, unsigne=
d long dst_start,
> > -                                  unsigned long len, atomic_t *mmap_ch=
anging,
> > -                                  uffd_flags_t flags);
> > -extern ssize_t mfill_atomic_poison(struct mm_struct *dst_mm, unsigned =
long start,
> > -                                unsigned long len, atomic_t *mmap_chan=
ging,
> > -                                uffd_flags_t flags);
> > -extern int mwriteprotect_range(struct mm_struct *dst_mm,
> > -                            unsigned long start, unsigned long len,
> > -                            bool enable_wp, atomic_t *mmap_changing);
> > +                                  unsigned long len);
> > +extern ssize_t mfill_atomic_continue(struct userfaultfd_ctx *ctx, unsi=
gned long dst_start,
> > +                                  unsigned long len, uffd_flags_t flag=
s);
> > +extern ssize_t mfill_atomic_poison(struct userfaultfd_ctx *ctx, unsign=
ed long start,
> > +                                unsigned long len, uffd_flags_t flags)=
;
> > +extern int mwriteprotect_range(struct userfaultfd_ctx *ctx, unsigned l=
ong start,
> > +                            unsigned long len, bool enable_wp);
> >  extern long uffd_wp_range(struct vm_area_struct *vma,
> >                         unsigned long start, unsigned long len, bool en=
able_wp);
> >
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index e3a91871462a..6e2ca04ab04d 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -353,11 +353,11 @@ static pmd_t *mm_alloc_pmd(struct mm_struct *mm, =
unsigned long address)
> >   * called with mmap_lock held, it will release mmap_lock before return=
ing.
> >   */
> >  static __always_inline ssize_t mfill_atomic_hugetlb(
> > +                                           struct userfaultfd_ctx *ctx=
,
> >                                             struct vm_area_struct *dst_=
vma,
> >                                             unsigned long dst_start,
> >                                             unsigned long src_start,
> >                                             unsigned long len,
> > -                                           atomic_t *mmap_changing,
> >                                             uffd_flags_t flags)
> >  {
> >       struct mm_struct *dst_mm =3D dst_vma->vm_mm;
> > @@ -379,6 +379,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb=
(
> >        * feature is not supported.
> >        */
> >       if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE)) {
> > +             up_read(&ctx->map_changing_lock);
> >               mmap_read_unlock(dst_mm);
> >               return -EINVAL;
> >       }
> > @@ -463,6 +464,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb=
(
> >               cond_resched();
> >
> >               if (unlikely(err =3D=3D -ENOENT)) {
> > +                     up_read(&ctx->map_changing_lock);
> >                       mmap_read_unlock(dst_mm);
> >                       BUG_ON(!folio);
> >
> > @@ -473,12 +475,13 @@ static __always_inline ssize_t mfill_atomic_huget=
lb(
> >                               goto out;
> >                       }
> >                       mmap_read_lock(dst_mm);
> > +                     down_read(&ctx->map_changing_lock);
> >                       /*
> >                        * If memory mappings are changing because of non=
-cooperative
> >                        * operation (e.g. mremap) running in parallel, b=
ail out and
> >                        * request the user to retry later
> >                        */
> > -                     if (mmap_changing && atomic_read(mmap_changing)) =
{
> > +                     if (atomic_read(ctx->mmap_changing)) {
> >                               err =3D -EAGAIN;
> >                               break;
> >                       }
> > @@ -501,6 +504,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb=
(
> >       }
> >
> >  out_unlock:
> > +     up_read(&ctx->map_changing_lock);
> >       mmap_read_unlock(dst_mm);
> >  out:
> >       if (folio)
> > @@ -512,11 +516,11 @@ static __always_inline ssize_t mfill_atomic_huget=
lb(
> >  }
> >  #else /* !CONFIG_HUGETLB_PAGE */
> >  /* fail at build time if gcc attempts to use this */
> > -extern ssize_t mfill_atomic_hugetlb(struct vm_area_struct *dst_vma,
> > +extern ssize_t mfill_atomic_hugetlb(struct userfaultfd_ctx *ctx,
> > +                                 struct vm_area_struct *dst_vma,
> >                                   unsigned long dst_start,
> >                                   unsigned long src_start,
> >                                   unsigned long len,
> > -                                 atomic_t *mmap_changing,
> >                                   uffd_flags_t flags);
> >  #endif /* CONFIG_HUGETLB_PAGE */
> >
> > @@ -564,13 +568,13 @@ static __always_inline ssize_t mfill_atomic_pte(p=
md_t *dst_pmd,
> >       return err;
> >  }
> >
> > -static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
> > +static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ct=
x,
> >                                           unsigned long dst_start,
> >                                           unsigned long src_start,
> >                                           unsigned long len,
> > -                                         atomic_t *mmap_changing,
> >                                           uffd_flags_t flags)
> >  {
> > +     struct mm_struct *dst_mm =3D ctx->mm;
> >       struct vm_area_struct *dst_vma;
> >       ssize_t err;
> >       pmd_t *dst_pmd;
> > @@ -600,8 +604,9 @@ static __always_inline ssize_t mfill_atomic(struct =
mm_struct *dst_mm,
> >        * operation (e.g. mremap) running in parallel, bail out and
> >        * request the user to retry later
> >        */
> > +     down_read(&ctx->map_changing_lock);
> >       err =3D -EAGAIN;
> > -     if (mmap_changing && atomic_read(mmap_changing))
> > +     if (atomic_read(&ctx->mmap_changing))
> >               goto out_unlock;
> >
> >       /*
> > @@ -633,8 +638,8 @@ static __always_inline ssize_t mfill_atomic(struct =
mm_struct *dst_mm,
> >        * If this is a HUGETLB vma, pass off to appropriate routine
> >        */
> >       if (is_vm_hugetlb_page(dst_vma))
> > -             return  mfill_atomic_hugetlb(dst_vma, dst_start, src_star=
t,
> > -                                          len, mmap_changing, flags);
> > +             return  mfill_atomic_hugetlb(ctx, dst_vma, dst_start,
> > +                                          src_start, len, flags);
> >
> >       if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
> >               goto out_unlock;
> > @@ -693,6 +698,7 @@ static __always_inline ssize_t mfill_atomic(struct =
mm_struct *dst_mm,
> >               if (unlikely(err =3D=3D -ENOENT)) {
> >                       void *kaddr;
> >
> > +                     up_read(&ctx->map_changing_lock);
> >                       mmap_read_unlock(dst_mm);
> >                       BUG_ON(!folio);
> >
> > @@ -723,6 +729,7 @@ static __always_inline ssize_t mfill_atomic(struct =
mm_struct *dst_mm,
> >       }
> >
> >  out_unlock:
> > +     up_read(&ctx->map_changing_lock);
> >       mmap_read_unlock(dst_mm);
> >  out:
> >       if (folio)
> > @@ -733,34 +740,33 @@ static __always_inline ssize_t mfill_atomic(struc=
t mm_struct *dst_mm,
> >       return copied ? copied : err;
> >  }
> >
> > -ssize_t mfill_atomic_copy(struct mm_struct *dst_mm, unsigned long dst_=
start,
> > +ssize_t mfill_atomic_copy(struct userfaultfd_ctx *ctx, unsigned long d=
st_start,
> >                         unsigned long src_start, unsigned long len,
> > -                       atomic_t *mmap_changing, uffd_flags_t flags)
> > +                       uffd_flags_t flags)
> >  {
> > -     return mfill_atomic(dst_mm, dst_start, src_start, len, mmap_chang=
ing,
> > +     return mfill_atomic(ctx, dst_start, src_start, len,
> >                           uffd_flags_set_mode(flags, MFILL_ATOMIC_COPY)=
);
> >  }
> >
> > -ssize_t mfill_atomic_zeropage(struct mm_struct *dst_mm, unsigned long =
start,
> > -                           unsigned long len, atomic_t *mmap_changing)
> > +ssize_t mfill_atomic_zeropage(struct userfaultfd_ctx *ctx,
> > +                           unsigned long start,
> > +                           unsigned long len)
> >  {
> > -     return mfill_atomic(dst_mm, start, 0, len, mmap_changing,
> > +     return mfill_atomic(ctx, start, 0, len,
> >                           uffd_flags_set_mode(0, MFILL_ATOMIC_ZEROPAGE)=
);
> >  }
> >
> > -ssize_t mfill_atomic_continue(struct mm_struct *dst_mm, unsigned long =
start,
> > -                           unsigned long len, atomic_t *mmap_changing,
> > -                           uffd_flags_t flags)
> > +ssize_t mfill_atomic_continue(struct userfaultfd_ctx *ctx, unsigned lo=
ng start,
> > +                           unsigned long len, uffd_flags_t flags)
> >  {
> > -     return mfill_atomic(dst_mm, start, 0, len, mmap_changing,
> > +     return mfill_atomic(ctx, start, 0, len,
> >                           uffd_flags_set_mode(flags, MFILL_ATOMIC_CONTI=
NUE));
> >  }
> >
> > -ssize_t mfill_atomic_poison(struct mm_struct *dst_mm, unsigned long st=
art,
> > -                         unsigned long len, atomic_t *mmap_changing,
> > -                         uffd_flags_t flags)
> > +ssize_t mfill_atomic_poison(struct userfaultfd_ctx *ctx, unsigned long=
 start,
> > +                         unsigned long len, uffd_flags_t flags)
> >  {
> > -     return mfill_atomic(dst_mm, start, 0, len, mmap_changing,
> > +     return mfill_atomic(ctx, start, 0, len,
> >                           uffd_flags_set_mode(flags, MFILL_ATOMIC_POISO=
N));
> >  }
> >
> > @@ -793,10 +799,10 @@ long uffd_wp_range(struct vm_area_struct *dst_vma=
,
> >       return ret;
> >  }
> >
> > -int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
> > -                     unsigned long len, bool enable_wp,
> > -                     atomic_t *mmap_changing)
> > +int mwriteprotect_range(struct userfaultfd_ctx *ctx, unsigned long sta=
rt,
> > +                     unsigned long len, bool enable_wp)
> >  {
> > +     struct mm_struct *dst_mm =3D ctx->mm;
> >       unsigned long end =3D start + len;
> >       unsigned long _start, _end;
> >       struct vm_area_struct *dst_vma;
> > @@ -820,8 +826,9 @@ int mwriteprotect_range(struct mm_struct *dst_mm, u=
nsigned long start,
> >        * operation (e.g. mremap) running in parallel, bail out and
> >        * request the user to retry later
> >        */
> > +     down_read(&ctx->map_changing_lock);
> >       err =3D -EAGAIN;
> > -     if (mmap_changing && atomic_read(mmap_changing))
> > +     if (atomic_read(&ctx->mmap_changing))
> >               goto out_unlock;
> >
> >       err =3D -ENOENT;
> > @@ -850,6 +857,7 @@ int mwriteprotect_range(struct mm_struct *dst_mm, u=
nsigned long start,
> >               err =3D 0;
> >       }
> >  out_unlock:
> > +     up_read(&ctx->map_changing_lock);
> >       mmap_read_unlock(dst_mm);
> >       return err;
> >  }
> > --
> > 2.43.0.429.g432eaa2c6b-goog
> >
> >

