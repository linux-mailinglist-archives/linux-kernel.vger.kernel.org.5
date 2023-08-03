Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D714E76F346
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 21:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjHCTPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 15:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjHCTPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 15:15:16 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66C33A8D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 12:15:14 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d066d72eb12so1960861276.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 12:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691090112; x=1691694912;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djFJX1OhEMWIt9+JtDxnjKllG6+RaJwtr30/ZUm6fls=;
        b=vbHQutePvfDyc688KRgvZbfnElOsr7PcYYJp1WDfyRRLzMDnIBjPQLQjI8YY1zdZZI
         RKmRVL4I9yQmuwm4KK8uj6/A1nC5/W1+ocpcRKI9/mrbO6BVHZ5jy91Ox2uzYuLUVeT9
         XxN53hBKG/9s5KEhQM8n0dtOHhBsFaXlbCfLZONxIjRj59EMWysgWa2nBla2AHronVJL
         0TCHmbsE5yxZfcQcZLEb04BF4/voHVVBvD2SpwUFjDsmlFPwZsd/eb1eP0ANpIXUv/Dp
         48JziEwYKcX6wNGn8dahnJ73PhywUDwA68H7k7Ajlh9H0NTbvJYOgxCm4vFLiHqvCz51
         E5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691090112; x=1691694912;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djFJX1OhEMWIt9+JtDxnjKllG6+RaJwtr30/ZUm6fls=;
        b=lp7gIa676y4ttwVmgkFSl6nB4sXLQPInzCuKcZj4Z/Imy+FXNbdETZDDRs0TV+nltg
         vAyoX/xQ6a+jnUkI96T8qbNG680zV7M6InJD5isrCYkAplsj250P4PtTj9gwTfpxHFrJ
         crOduxUSUJvxNjUHdUO1oVBsPOc7r16xm9jDWrRoph11M9OHUL8CJsMsYwmUiKElXIx1
         XTSaTk8rQOldtaAPfcIBcI3sae5ULoabwxJBd4/ao2+m4xlAtnNrC8H+KbsBmH3OvjKe
         A6VOU66WUXlivN8bJ9Al89OIWhfiAOorj8oaiP47Kpsx25bfy6Juin+UYMYAxtf0XWJV
         bHBQ==
X-Gm-Message-State: ABy/qLaRVvlWl359CDon9i33AMK2o2JR1nz+ayPzHomE7yS7qMaxCrAg
        gzJVuLpycPbVIvmqX16x2gOiUYGliMW785QgJPJdTQ==
X-Google-Smtp-Source: APBJJlGlDnONnDU/o3MkHLp0kgBm0ml4OcPWLSX7F+2EQESh8CWjBvM5PsMGQHsHyiPP4vnpnBnGIkNFlPuPQjSLX30=
X-Received: by 2002:a25:b28a:0:b0:d03:37fe:5ae6 with SMTP id
 k10-20020a25b28a000000b00d0337fe5ae6mr21693483ybj.22.1691090111689; Thu, 03
 Aug 2023 12:15:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230803172652.2849981-1-surenb@google.com> <20230803172652.2849981-7-surenb@google.com>
 <20230803183228.zreczwv3g3qp4kux@revolver>
In-Reply-To: <20230803183228.zreczwv3g3qp4kux@revolver>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 3 Aug 2023 12:14:58 -0700
Message-ID: <CAJuCfpHUp5xVV-p=pKXp6javYq+GmUx_3cDKr9mmTnHYxsg0Mw@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] mm: move vma locking out of vma_prepare and dup_anon_vma
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        jannh@google.com, willy@infradead.org, david@redhat.com,
        peterx@redhat.com, ldufour@linux.ibm.com, vbabka@suse.cz,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        hannes@cmpxchg.org, dave@stgolabs.net, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 11:32=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Suren Baghdasaryan <surenb@google.com> [230803 13:27]:
> > vma_prepare() is currently the central place where vmas are being locke=
d
> > before vma_complete() applies changes to them. While this is convenient=
,
> > it also obscures vma locking and makes it harder to follow the locking
> > rules. Move vma locking out of vma_prepare() and take vma locks
> > explicitly at the locations where vmas are being modified. Move vma
> > locking and replace it with an assertion inside dup_anon_vma() to furth=
er
> > clarify the locking pattern inside vma_merge().
> >
> > Suggested-by: Linus Torvalds <torvalds@linuxfoundation.org>
> > Suggested-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  mm/mmap.c | 29 ++++++++++++++++++-----------
> >  1 file changed, 18 insertions(+), 11 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 850a39dee075..ae28d6f94c34 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -476,16 +476,6 @@ static inline void init_vma_prep(struct vma_prepar=
e *vp,
> >   */
> >  static inline void vma_prepare(struct vma_prepare *vp)
> >  {
> > -     vma_start_write(vp->vma);
> > -     if (vp->adj_next)
> > -             vma_start_write(vp->adj_next);
> > -     if (vp->insert)
> > -             vma_start_write(vp->insert);
> > -     if (vp->remove)
> > -             vma_start_write(vp->remove);
> > -     if (vp->remove2)
> > -             vma_start_write(vp->remove2);
> > -
> >       if (vp->file) {
> >               uprobe_munmap(vp->vma, vp->vma->vm_start, vp->vma->vm_end=
);
> >
> > @@ -618,7 +608,7 @@ static inline int dup_anon_vma(struct vm_area_struc=
t *dst,
> >        * anon pages imported.
> >        */
> >       if (src->anon_vma && !dst->anon_vma) {
> > -             vma_start_write(dst);
> > +             vma_assert_write_locked(dst);
> >               dst->anon_vma =3D src->anon_vma;
> >               return anon_vma_clone(dst, src);
> >       }
> > @@ -650,10 +640,12 @@ int vma_expand(struct vma_iterator *vmi, struct v=
m_area_struct *vma,
> >       bool remove_next =3D false;
> >       struct vma_prepare vp;
> >
> > +     vma_start_write(vma);
> >       if (next && (vma !=3D next) && (end =3D=3D next->vm_end)) {
> >               int ret;
> >
> >               remove_next =3D true;
> > +             vma_start_write(next);
> >               ret =3D dup_anon_vma(vma, next);
> >               if (ret)
> >                       return ret;
> > @@ -708,6 +700,8 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_=
area_struct *vma,
> >       if (vma_iter_prealloc(vmi))
> >               return -ENOMEM;
> >
> > +     vma_start_write(vma);
> > +
> >       init_vma_prep(&vp, vma);
> >       vma_prepare(&vp);
> >       vma_adjust_trans_huge(vma, start, end, 0);
> > @@ -940,16 +934,21 @@ struct vm_area_struct *vma_merge(struct vma_itera=
tor *vmi, struct mm_struct *mm,
> >       if (!merge_prev && !merge_next)
> >               return NULL; /* Not mergeable. */
> >
> > +     if (prev)
>
> Maybe if (merge_prev) instead of prev?  We will write lock prev if it
> exists and won't change with the current check (case 3 and 8,
> specifically), with this change case 4 will need to lock prev as it
> shifts prev->vm_end lower.

Ah, I see. I was trying to make sure we don't miss any locks and
over-locked it for case 3 and 8.
Ok, I'll change the check to if (merge_prev) and will add a separate
locking for case 4. I think that's what you meant?

>
> > +             vma_start_write(prev);
> > +
> >       res =3D vma =3D prev;
> >       remove =3D remove2 =3D adjust =3D NULL;
> >
> >       /* Can we merge both the predecessor and the successor? */
> >       if (merge_prev && merge_next &&
> >           is_mergeable_anon_vma(prev->anon_vma, next->anon_vma, NULL)) =
{
> > +             vma_start_write(next);
> >               remove =3D next;                          /* case 1 */
> >               vma_end =3D next->vm_end;
> >               err =3D dup_anon_vma(prev, next);
> >               if (curr) {                             /* case 6 */
> > +                     vma_start_write(curr);
> >                       remove =3D curr;
> >                       remove2 =3D next;
> >                       if (!next->anon_vma)
> > @@ -957,6 +956,7 @@ struct vm_area_struct *vma_merge(struct vma_iterato=
r *vmi, struct mm_struct *mm,
> >               }
> >       } else if (merge_prev) {                        /* case 2 */
> >               if (curr) {
> > +                     vma_start_write(curr);
> >                       err =3D dup_anon_vma(prev, curr);
> >                       if (end =3D=3D curr->vm_end) {      /* case 7 */
> >                               remove =3D curr;
> > @@ -966,6 +966,7 @@ struct vm_area_struct *vma_merge(struct vma_iterato=
r *vmi, struct mm_struct *mm,
> >                       }
> >               }
> >       } else { /* merge_next */
> > +             vma_start_write(next);
> >               res =3D next;
> >               if (prev && addr < prev->vm_end) {      /* case 4 */
> >                       vma_end =3D addr;
> > @@ -983,6 +984,7 @@ struct vm_area_struct *vma_merge(struct vma_iterato=
r *vmi, struct mm_struct *mm,
> >                       vma_pgoff =3D next->vm_pgoff - pglen;
> >                       if (curr) {                     /* case 8 */
> >                               vma_pgoff =3D curr->vm_pgoff;
> > +                             vma_start_write(curr);
> >                               remove =3D curr;
> >                               err =3D dup_anon_vma(next, curr);
> >                       }
> > @@ -2373,6 +2375,9 @@ int __split_vma(struct vma_iterator *vmi, struct =
vm_area_struct *vma,
> >       if (new->vm_ops && new->vm_ops->open)
> >               new->vm_ops->open(new);
> >
> > +     vma_start_write(vma);
> > +     vma_start_write(new);
> > +
> >       init_vma_prep(&vp, vma);
> >       vp.insert =3D new;
> >       vma_prepare(&vp);
> > @@ -3078,6 +3083,8 @@ static int do_brk_flags(struct vma_iterator *vmi,=
 struct vm_area_struct *vma,
> >               if (vma_iter_prealloc(vmi))
> >                       goto unacct_fail;
> >
> > +             vma_start_write(vma);
> > +
> >               init_vma_prep(&vp, vma);
> >               vma_prepare(&vp);
> >               vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
> > --
> > 2.41.0.585.gd2178a4bd4-goog
> >
