Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E0F76D50D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjHBRYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjHBRYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:24:46 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B19E6F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:24:44 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d1c988afebfso40617276.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 10:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690997084; x=1691601884;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vonn9Nv7xLTAA7QB9ihtuwGys78qYxgDJws1s06z/mQ=;
        b=WcHMpeypLP0g9pk+qDTMvf7PQ86yHHyNTjgKDEoZsAaVjuf5p/6FpC7KWKZVa/aHKX
         ZAd6GG1s9OnXgPwHmnqju+vP+EFwzO+xX3NkJUVR0wxpRkGiyZq9DwaXvkc3bU0c8af+
         YQYZ9kLnQ/3IGfCprPu16Y9jYfO/5ELr53I3uOXTxlw6Ae90J51VzLufYUNy8JVFIVJv
         HccYSBC0ewTnYj2TdOH7uetfnnw9NxegkJKX5EegZOv2lyksJxLCKapGQnh9w60WIMve
         YpAOGqUF2+g9Be8NXCyTvL3yXyhrknAl6DtWou80EcT08N1ZULCz9xr/7V91k3ZHN4rn
         FM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690997084; x=1691601884;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vonn9Nv7xLTAA7QB9ihtuwGys78qYxgDJws1s06z/mQ=;
        b=l/EXY2tpSqCA0I2xVBcUCdOjiSR/HQV9bijAPbgp0N4+XNZDoAMzVwMrCo8aS2oaUq
         K1wyjJFfOy4gxaec3Wt/cMPsi9GzRubm22L/2xJoeMo8tFOs7fynFHS3yVAC1ek2OdMl
         zeO+fDrNim71ysSeTO3d21tsacfmjcfrQfeDJmTf9lYlKg0xd5kexPCUJZWTTHE1fw3d
         GXkKkkzd756gDB1QRlTZZ5rGTkmCxDxtAPivixh/KT0eQtiw141prALj8RKWBenOde0d
         H6DxnLU/de6v+gTteyf2ydIO2HoRucbZubpiAuxRZ8QV5wcNbnkWKeuah6+C33qwPIih
         Atrw==
X-Gm-Message-State: ABy/qLbhvnJa+gk0XUL6G4U0oyQ5GY4jMPeHPDa5nWBb2GchYS/ArWPb
        r9miC7gjSdlgbcx/av7eXwghyN6xmJpyzNKpJm62gQ==
X-Google-Smtp-Source: APBJJlHNaztWUZNK2qaAukx3iAp3HkWF0OrzF7JTtkcV0k83rCaybZZ1NXfPQKEwLseZJjELCViDs9rhFDNwa23Tt3g=
X-Received: by 2002:a05:6902:563:b0:d0e:b5c8:6359 with SMTP id
 a3-20020a056902056300b00d0eb5c86359mr16012678ybt.55.1690997083904; Wed, 02
 Aug 2023 10:24:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230801220733.1987762-1-surenb@google.com> <20230801220733.1987762-7-surenb@google.com>
 <20230802165900.otlirhbjr54wymvl@revolver>
In-Reply-To: <20230802165900.otlirhbjr54wymvl@revolver>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 2 Aug 2023 10:24:31 -0700
Message-ID: <CAJuCfpF-E65wJcprA80zLWfbfHdaDJMafNe087aUs_-SkwUTdA@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] mm: move vma locking out of vma_prepare
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 2, 2023 at 9:59=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracle=
.com> wrote:
>
> * Suren Baghdasaryan <surenb@google.com> [230801 18:07]:
> > vma_prepare() is currently the central place where vmas are being locke=
d
> > before vma_complete() applies changes to them. While this is convenient=
,
> > it also obscures vma locking and makes it hard to follow the locking ru=
les.
> > Move vma locking out of vma_prepare() and take vma locks explicitly at =
the
> > locations where vmas are being modified.
> >
> > Suggested-by: Linus Torvalds <torvalds@linuxfoundation.org>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > ---
> >  mm/mmap.c | 26 ++++++++++++++++----------
> >  1 file changed, 16 insertions(+), 10 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 850a39dee075..e59d83cb1d7a 100644
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
> > @@ -650,6 +640,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_=
area_struct *vma,
> >       bool remove_next =3D false;
> >       struct vma_prepare vp;
> >
> > +     vma_start_write(vma);
>
> This lock made me think about the lock in dup_anon_vma().. the only
> reason we need to dup the anon vma is because the VMA _will_ be
> modified..  So if we are to remove next the dup_anon_vma() call may lock
> vma again.  This happens multiple times through this patch set.
>
> If we lock both dst and src VMAs before calling dup_anon_vma, then I
> think it will become more clear in the code below which VMAs are locked.
> We could remove the lock in the dup_anon_vma() (and replace with an
> assert?), and drop the vma locking of "vma".
>
> I think this would address the confusion of the locking below that I
> experienced and avoid calling the vma_start_write() multiple times for
> the same vma.  I mean, having the vma_start_write(vma) obscures which
> VMA is locked as well.

Agree, it would result in an easier to understand locking code. I'll
move the lock outside of dup_anon_vma() and will replace it with an
assert. Thanks!

>
>
> >       if (next && (vma !=3D next) && (end =3D=3D next->vm_end)) {
> >               int ret;
> >
> > @@ -657,6 +648,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_=
area_struct *vma,
> >               ret =3D dup_anon_vma(vma, next);
> >               if (ret)
> >                       return ret;
> > +             vma_start_write(next);
> >       }
> >
> >       init_multi_vma_prep(&vp, vma, NULL, remove_next ? next : NULL, NU=
LL);
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
> > @@ -946,10 +940,12 @@ struct vm_area_struct *vma_merge(struct vma_itera=
tor *vmi, struct mm_struct *mm,
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
> > @@ -958,6 +954,7 @@ struct vm_area_struct *vma_merge(struct vma_iterato=
r *vmi, struct mm_struct *mm,
> >       } else if (merge_prev) {                        /* case 2 */
> >               if (curr) {
> >                       err =3D dup_anon_vma(prev, curr);
> > +                     vma_start_write(curr);
> >                       if (end =3D=3D curr->vm_end) {      /* case 7 */
> >                               remove =3D curr;
> >                       } else {                        /* case 5 */
> > @@ -969,6 +966,7 @@ struct vm_area_struct *vma_merge(struct vma_iterato=
r *vmi, struct mm_struct *mm,
> >               res =3D next;
> >               if (prev && addr < prev->vm_end) {      /* case 4 */
> >                       vma_end =3D addr;
> > +                     vma_start_write(next);
> >                       adjust =3D next;
> >                       adj_start =3D -(prev->vm_end - addr);
> >                       err =3D dup_anon_vma(next, prev);
> > @@ -983,6 +981,7 @@ struct vm_area_struct *vma_merge(struct vma_iterato=
r *vmi, struct mm_struct *mm,
> >                       vma_pgoff =3D next->vm_pgoff - pglen;
> >                       if (curr) {                     /* case 8 */
> >                               vma_pgoff =3D curr->vm_pgoff;
> > +                             vma_start_write(curr);
> >                               remove =3D curr;
> >                               err =3D dup_anon_vma(next, curr);
> >                       }
> > @@ -996,6 +995,8 @@ struct vm_area_struct *vma_merge(struct vma_iterato=
r *vmi, struct mm_struct *mm,
> >       if (vma_iter_prealloc(vmi))
> >               return NULL;
> >
> > +     vma_start_write(vma);
> > +
> >       init_multi_vma_prep(&vp, vma, adjust, remove, remove2);
> >       VM_WARN_ON(vp.anon_vma && adjust && adjust->anon_vma &&
> >                  vp.anon_vma !=3D adjust->anon_vma);
> > @@ -2373,6 +2374,9 @@ int __split_vma(struct vma_iterator *vmi, struct =
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
> > @@ -3078,6 +3082,8 @@ static int do_brk_flags(struct vma_iterator *vmi,=
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
