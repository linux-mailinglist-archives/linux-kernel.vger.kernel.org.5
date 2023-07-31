Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82BA76A212
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 22:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjGaUjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 16:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjGaUjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 16:39:12 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6379EE5F
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 13:39:10 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-c4cb4919bb9so5114277276.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 13:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690835949; x=1691440749;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LlRYd4YMaajQ0xXPSbk9pEmLduWsiZdsNXzqgUFeIsA=;
        b=5MbruZmoSbLb/zevKa240hssKFM2XzUyqhw7ssvcHHJn4mIGQrY5W6LzNX3jVU5Yek
         6G7+IOxVUZJW3+htvGee1hd+VBFSESt2reHypW5zUrGo7OFYCblkvY9QojFjK5SHEx8Y
         WA7f4kY2MyQwkXeeqQPzVGwzDk5puAdNQm+9zuvD0IUsGvOKBXEiBObLg3S59mQPwd1k
         9/+BXGy+1X4GJqMGmP7sEPJiEnEbgg0Lwf4N4PqgpCev5KPsGeLie9kacRGpmuzN/IbE
         0k/CzLV0QLp+vN7jSB/6RAP8c6/UgU8jNUr629eyRG0iiQqCwZPPF/gcslcx2gjMhI7C
         H8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690835949; x=1691440749;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LlRYd4YMaajQ0xXPSbk9pEmLduWsiZdsNXzqgUFeIsA=;
        b=W+XIHEQOCPxMZp9Y0z3vT30ETNg2QpKFmNQCJe8MtQe4ylMIyH0zjnOjkLeg9Wqly3
         7MNU3N28RF6Gq4gihZplUEIXKBuO63JeFehTsxHKHaTNiGEZT5Hpo52k/ha1vC01Ql2O
         K4uZsNFOOKQmpwglZvoJzaB5nEGcWurmXyyNAWEKr/Y/z6qmNGtePVBpq2rnmIu4+s97
         3s70slNOQLWsHoZQvNXTjMiuti1sPX3+8BrNelz/bkmNYOzuRquhWjLd3iJKfbjtr0Dc
         U2KWy7wRIy9rTvsLpJq4KXdBRoNQPxruppAPB/MU9DOKHoDmRlp6kR7pIPXRNJeao2YO
         uO6g==
X-Gm-Message-State: ABy/qLYKSb1VLkJohJ5ntD8GWx4dim20QlnnmPc3lN7J8GOzDCspJVwz
        C0Da5BSHWkvpy4oHw8S+/9GHJW/+gaSwoQv/wYf2/Q==
X-Google-Smtp-Source: APBJJlFu2UEwyyq7d3CDSqXwCOLCd4McJ8AzkctZiKIZQEhb6BKbLMy0406YWzEI58g3jYog+ildUQfmSA0lq2oxJm0=
X-Received: by 2002:a5b:750:0:b0:d0c:fd53:aaae with SMTP id
 s16-20020a5b0750000000b00d0cfd53aaaemr10065125ybq.2.1690835949388; Mon, 31
 Jul 2023 13:39:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230731171233.1098105-7-surenb@google.com> <20230731203032.z66gjqv5p4y662zo@revolver>
In-Reply-To: <20230731203032.z66gjqv5p4y662zo@revolver>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 31 Jul 2023 13:38:58 -0700
Message-ID: <CAJuCfpHjzVeFYnZU-TRwnec3R4KZp+4c=hMk323d57TpDB32Hw@mail.gmail.com>
Subject: Re: [PATCH 6/6] mm: move vma locking out of vma_prepare
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        jannh@google.com, willy@infradead.org, david@redhat.com,
        peterx@redhat.com, ldufour@linux.ibm.com, vbabka@suse.cz,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        hannes@cmpxchg.org, dave@stgolabs.net, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>,
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

On Mon, Jul 31, 2023 at 1:30=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> Adding Lorenzo since this also touches vma_merge() again..
>
> * Suren Baghdasaryan <surenb@google.com> [230731 13:12]:
> > vma_prepare() is currently the central place where vmas are being locke=
d
> > before vma_complete() applies changes to them. While this is convenient=
,
> > it also obscures vma locking and makes it hard to follow the locking ru=
les.
> > Move vma locking out of vma_prepare() and take vma locks explicitly at =
the
> > locations where vmas are being modified.
>
> I get the idea of locking closer to the edits, but vma_merge() is very
> hard to follow.  It was worse when it was two functions and much larger,
> but adding this into vma_merge() is difficult to validate.
>
> We still set vma =3D <another vma> in places, so that adds to the
> difficulty of ensuring the end result is all VMAs that will be
> modified/removed have been locked...and the 'locking rules' are also
> obscured.
>
> It's also annoying that this doesn't fully allow you to follow the
> locking anyways.  dup_anon_vma() still locks internally, with good
> reason, but it's still not clear that the VMA is locked when looking at
> this.
>
> That being said, I did go through each case and it looks like it locks
> the correct VMA(s) to me.

Thanks!
Yeah, it took me some time to ensure the locking there is correct. If
you see a better alternative to make the locking more obvious I'm open
to suggestions. I accept that locking in vma_merge() is not easy to
follow.

>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>
> >
> > Suggested-by: Linus Torvalds <torvalds@linuxfoundation.org>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
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
> > 2.41.0.487.g6d72f3e995-goog
> >
