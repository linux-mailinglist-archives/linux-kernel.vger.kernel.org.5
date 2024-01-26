Return-Path: <linux-kernel+bounces-39630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D8283D3D4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 05:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54E8228B5F2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 04:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11989DDBD;
	Fri, 26 Jan 2024 04:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zk1ot/hQ"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71989D29B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 04:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706244980; cv=none; b=tkSURtP7LENBIa5cR95fWdD/KOtUFoSYHXvwuQ3kbkbe7YTk8CuXv+DxBJdbcsfVKfsdV/mlQKVQB0XLd2tyN+FTHcgMW0+aeSZ1QLUiF3nGzADxykqlEBWehngnwaSjB9BFxbn8p3g2on6LomlZmczW3kJndxnwoDQwnjSn6kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706244980; c=relaxed/simple;
	bh=Iva3SkfYc+3/M49tzvUZURGm8UL+XiDVMaMrj6MxcmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=akyT07rOERBJcN4R0vji4c5lA3NO0h8794x9CFzeVtrsSszLWBqYlZt5+Ut2Ib2JiPxCY3ZG1E5wm5Sxfeik23YHs8uCajB+S9aWrvm2paEAatqgKJO5+/fQ8Fvrsv75VgaSPVWwVCbqzE9Ho6uU4mL5gMzyigjBBwXkHgWCBos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zk1ot/hQ; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6dde5d308c6so112663a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 20:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706244977; x=1706849777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=74RQ2oIUc1ObkcR3+myxEPLduZaF3Pdh1Cwy7vDeVhE=;
        b=Zk1ot/hQnIqqIvVrEapzzy4+e60xVmBo2Mwn/9Ct6UW4IaGRwBFnsnCUovBw3ycFFE
         sSFlBJuzxok3zmzbO17Z2y0uIArFSjmdHb2hcm12mt75IFxUpdwKjLvkWv+Z7pRizAT/
         WnWtC78X0ZyYkg7zG+L5yMBNIrFLw+uVeLYr1F7vIjEVAU6iVFXwK2wCgZ8VC+2xQ5ef
         rh7sk7rTK48MkTYcTAHzhwJgtCUj8uPAsyapB/l/Qy/QBABHpljKR1dZB3izzDvk5Bbu
         D6ELaZRayD+FqcJT+zQvcNUM+XNopX2Ga27Mp5EeZ0ZMg+QSkNUqN7PY5RBSmv6Oy4s9
         hXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706244977; x=1706849777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=74RQ2oIUc1ObkcR3+myxEPLduZaF3Pdh1Cwy7vDeVhE=;
        b=OsQx3A9gINPOd99bgGs+7IfZj3kN6mGP7+0uBuCRYiqYDUZ3rL1FNJ5Q9vPiam3pF7
         +tp9VrARsnO05mu/vzZm8GLQEUrxxfj+ypXQ0tSj0kHyciBrwmxKDuHWmf2UnBtuEde7
         Th0q+1arAkh+ofi/U6RD2c6+T021C0VcOYk5R+3cTFn3YS6wvNrp7SRKfJ22Lq48YMkG
         +4su1DICa9YafJxvenU3/4bl1yDbaGa+c8js8wLDdooD+BnqEy6TGlX7ceLVWxDCZmfc
         6eXxPnOTGItB3ryMLMLImm6oh6c84Lo1fty/Mj0oIUhbf62t7ABWzZlLzUbYGmBQBWYd
         xgyA==
X-Gm-Message-State: AOJu0YwloOULIbgfkQZP7NVgZ0a2wUK9p5Sf2yRYulKuKIr90ku0zCP/
	bzLLbU4xwouHf8OD9OFZm3o/PnpDAfzi7ozdVNr5EtqGboI78k0/FwmBYVpDrRyyFXSF0tsH6GR
	9d6OOkZVu+zuUMjmC8qlHVXeK125ppUHnIxpo
X-Google-Smtp-Source: AGHT+IFhmRJas2IvuqlY1vmoSoIIaVGnnCvEt9x3un3/Ksd+gKInTzvkP0/0W4UG1DQcxGYYmrDStIuf2mp/XAqKK6k=
X-Received: by 2002:a05:6830:3150:b0:6db:ffa6:6c4d with SMTP id
 c16-20020a056830315000b006dbffa66c4dmr972059ots.24.1706244977191; Thu, 25 Jan
 2024 20:56:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125120039.3228103-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20240125120039.3228103-1-hsiangkao@linux.alibaba.com>
From: Sandeep Dhavale <dhavale@google.com>
Date: Thu, 25 Jan 2024 20:56:05 -0800
Message-ID: <CAB=BE-QPzipJ8iEjwoHx2_CN-WnRGvKRRZr_Xtm2wqmHWQHjsw@mail.gmail.com>
Subject: Re: [PATCH] erofs: fix infinite loop due to a race of filling compressed_bvecs
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 4:01=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
> I encountered a race issue after lengthy (~594647 sec) stress tests on
> a 64k-page arm64 VM with several 4k-block EROFS images.  The timing
> is like below:
>
> z_erofs_try_inplace_io                  z_erofs_fill_bio_vec
>   cmpxchg(&compressed_bvecs[].page,
>           NULL, ..)
>                                         [access bufvec]
>   compressed_bvecs[] =3D *bvec;
>
> Previously, z_erofs_submit_queue() just accessed bufvec->page only, so
> other fields in bufvec didn't matter.  After the subpage block support
> is landed, .offset and .end can be used too, but filling bufvec isn't
> an atomic operation which can cause inconsistency.
>
> Let's use a spinlock to keep the atomicity of each bufvec.  More
> specifically, just reuse the existing spinlock `pcl->obj.lockref.lock`
> since it's rarely used (also it takes a short time if even used) as long
> as the pcluster has a reference.
>
> Fixes: 192351616a9d ("erofs: support I/O submission for sub-page compress=
ed blocks")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/zdata.c | 74 +++++++++++++++++++++++++-----------------------
>  1 file changed, 38 insertions(+), 36 deletions(-)
>
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 583c062cd0e4..c1c77166b30f 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -563,21 +563,19 @@ static void z_erofs_bind_cache(struct z_erofs_decom=
press_frontend *fe)
>                         __GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN;
>         unsigned int i;
>
> -       if (i_blocksize(fe->inode) !=3D PAGE_SIZE)
> -               return;
> -       if (fe->mode < Z_EROFS_PCLUSTER_FOLLOWED)
> +       if (i_blocksize(fe->inode) !=3D PAGE_SIZE ||
> +           fe->mode < Z_EROFS_PCLUSTER_FOLLOWED)
>                 return;
>
>         for (i =3D 0; i < pclusterpages; ++i) {
>                 struct page *page, *newpage;
>                 void *t;        /* mark pages just found for debugging */
>
> -               /* the compressed page was loaded before */
> +               /* Inaccurate check w/o locking to avoid unneeded lookups=
 */
>                 if (READ_ONCE(pcl->compressed_bvecs[i].page))
>                         continue;
>
>                 page =3D find_get_page(mc, pcl->obj.index + i);
> -
>                 if (page) {
>                         t =3D (void *)((unsigned long)page | 1);
>                         newpage =3D NULL;
> @@ -597,9 +595,13 @@ static void z_erofs_bind_cache(struct z_erofs_decomp=
ress_frontend *fe)
>                         set_page_private(newpage, Z_EROFS_PREALLOCATED_PA=
GE);
>                         t =3D (void *)((unsigned long)newpage | 1);
>                 }
> -
> -               if (!cmpxchg_relaxed(&pcl->compressed_bvecs[i].page, NULL=
, t))
> +               spin_lock(&pcl->obj.lockref.lock);
> +               if (!pcl->compressed_bvecs[i].page) {
> +                       pcl->compressed_bvecs[i].page =3D t;
> +                       spin_unlock(&pcl->obj.lockref.lock);
>                         continue;
> +               }
> +               spin_unlock(&pcl->obj.lockref.lock);
>
>                 if (page)
>                         put_page(page);
> @@ -718,31 +720,25 @@ int erofs_init_managed_cache(struct super_block *sb=
)
>         return 0;
>  }
>
> -static bool z_erofs_try_inplace_io(struct z_erofs_decompress_frontend *f=
e,
> -                                  struct z_erofs_bvec *bvec)
> -{
> -       struct z_erofs_pcluster *const pcl =3D fe->pcl;
> -
> -       while (fe->icur > 0) {
> -               if (!cmpxchg(&pcl->compressed_bvecs[--fe->icur].page,
> -                            NULL, bvec->page)) {
> -                       pcl->compressed_bvecs[fe->icur] =3D *bvec;
> -                       return true;
> -               }
> -       }
> -       return false;
> -}
> -
>  /* callers must be with pcluster lock held */
>  static int z_erofs_attach_page(struct z_erofs_decompress_frontend *fe,
>                                struct z_erofs_bvec *bvec, bool exclusive)
>  {
> +       struct z_erofs_pcluster *pcl =3D fe->pcl;
>         int ret;
>
>         if (exclusive) {
>                 /* give priority for inplaceio to use file pages first */
> -               if (z_erofs_try_inplace_io(fe, bvec))
> +               spin_lock(&pcl->obj.lockref.lock);
> +               while (fe->icur > 0) {
> +                       if (pcl->compressed_bvecs[--fe->icur].page)
> +                               continue;
> +                       pcl->compressed_bvecs[fe->icur] =3D *bvec;
> +                       spin_unlock(&pcl->obj.lockref.lock);
>                         return 0;
> +               }
> +               spin_unlock(&pcl->obj.lockref.lock);
> +
>                 /* otherwise, check if it can be used as a bvpage */
>                 if (fe->mode >=3D Z_EROFS_PCLUSTER_FOLLOWED &&
>                     !fe->candidate_bvpage)
> @@ -1423,23 +1419,26 @@ static void z_erofs_fill_bio_vec(struct bio_vec *=
bvec,
>  {
>         gfp_t gfp =3D mapping_gfp_mask(mc);
>         bool tocache =3D false;
> -       struct z_erofs_bvec *zbv =3D pcl->compressed_bvecs + nr;
> +       struct z_erofs_bvec zbv;
>         struct address_space *mapping;
> -       struct page *page, *oldpage;
> +       struct page *page;
>         int justfound, bs =3D i_blocksize(f->inode);
>
>         /* Except for inplace pages, the entire page can be used for I/Os=
 */
>         bvec->bv_offset =3D 0;
>         bvec->bv_len =3D PAGE_SIZE;
>  repeat:
> -       oldpage =3D READ_ONCE(zbv->page);
> -       if (!oldpage)
> +       spin_lock(&pcl->obj.lockref.lock);
> +       zbv =3D pcl->compressed_bvecs[nr];
> +       page =3D zbv.page;
> +       justfound =3D (unsigned long)page & 1UL;
> +       page =3D (struct page *)((unsigned long)page & ~1UL);
> +       pcl->compressed_bvecs[nr].page =3D page;
> +       spin_unlock(&pcl->obj.lockref.lock);
> +       if (!page)
>                 goto out_allocpage;
>
> -       justfound =3D (unsigned long)oldpage & 1UL;
> -       page =3D (struct page *)((unsigned long)oldpage & ~1UL);
>         bvec->bv_page =3D page;
> -
>         DBG_BUGON(z_erofs_is_shortlived_page(page));
>         /*
>          * Handle preallocated cached pages.  We tried to allocate such p=
ages
> @@ -1448,7 +1447,6 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bv=
ec,
>          */
>         if (page->private =3D=3D Z_EROFS_PREALLOCATED_PAGE) {
>                 set_page_private(page, 0);
> -               WRITE_ONCE(zbv->page, page);
>                 tocache =3D true;
>                 goto out_tocache;
>         }
> @@ -1459,9 +1457,9 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bv=
ec,
>          * therefore it is impossible for `mapping` to be NULL.
>          */
>         if (mapping && mapping !=3D mc) {
> -               if (zbv->offset < 0)
> -                       bvec->bv_offset =3D round_up(-zbv->offset, bs);
> -               bvec->bv_len =3D round_up(zbv->end, bs) - bvec->bv_offset=
;
> +               if (zbv.offset < 0)
> +                       bvec->bv_offset =3D round_up(-zbv.offset, bs);
> +               bvec->bv_len =3D round_up(zbv.end, bs) - bvec->bv_offset;
>                 return;
>         }
>
> @@ -1471,7 +1469,6 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bv=
ec,
>
>         /* the cached page is still in managed cache */
>         if (page->mapping =3D=3D mc) {
> -               WRITE_ONCE(zbv->page, page);
>                 /*
>                  * The cached page is still available but without a valid
>                  * `->private` pcluster hint.  Let's reconnect them.
> @@ -1503,11 +1500,15 @@ static void z_erofs_fill_bio_vec(struct bio_vec *=
bvec,
>         put_page(page);
>  out_allocpage:
>         page =3D erofs_allocpage(&f->pagepool, gfp | __GFP_NOFAIL);
> -       if (oldpage !=3D cmpxchg(&zbv->page, oldpage, page)) {
> +       spin_lock(&pcl->obj.lockref.lock);
> +       if (pcl->compressed_bvecs[nr].page) {
>                 erofs_pagepool_add(&f->pagepool, page);
> +               spin_unlock(&pcl->obj.lockref.lock);
>                 cond_resched();
>                 goto repeat;
>         }
> +       pcl->compressed_bvecs[nr].page =3D page;
> +       spin_unlock(&pcl->obj.lockref.lock);
>         bvec->bv_page =3D page;
>  out_tocache:
>         if (!tocache || bs !=3D PAGE_SIZE ||
> @@ -1685,6 +1686,7 @@ static void z_erofs_submit_queue(struct z_erofs_dec=
ompress_frontend *f,
>
>                         if (cur + bvec.bv_len > end)
>                                 bvec.bv_len =3D end - cur;
> +                       DBG_BUGON(bvec.bv_len < sb->s_blocksize);
>                         if (!bio_add_page(bio, bvec.bv_page, bvec.bv_len,
>                                           bvec.bv_offset))
>                                 goto submit_bio_retry;
> --
> 2.39.3
>

LGTM!

Reviewed-by: Sandeep Dhavale <dhavale@google.com>

