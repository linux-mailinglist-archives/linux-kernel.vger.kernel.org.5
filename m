Return-Path: <linux-kernel+bounces-55736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0247284C0FA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 00:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BFF31F25101
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B05C1CD2D;
	Tue,  6 Feb 2024 23:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWlTlkPL"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74241CD33
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 23:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707262748; cv=none; b=Amq6FbB1pgnu/BhNu37JwSSJP1IRzd6QH47lP2dSmdhAUPTYwbqUrBdpn0OOuRkEVwgQr0JeNHojgI8/Cbq48JxdqK13rSGrXmZuvy4PfqE9GmVNFquiacR4gFuFO8KsDPqwhs12h9seVoOyKbfHL6voAqLUHkEWZfAqllHI+NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707262748; c=relaxed/simple;
	bh=xK1h7JcCyUgcHE5+S8gzyZDzVG1R/f37gvtjCFB4OaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jegcRXAfK5uMelmJzXxwE4+EAjkNXOTqbdHAF60XXLWPuP6yti0QLrCCrZTXMGrxObhVLQ3VKJS1bMJJpb4tUf6+tpiTiYZDOd/Vr2TfQ5p/QnuLtuJ2BxYmKhW8E+/4m8ygKtG2a9/WbSY9zpEijKwEG6aq9moQwkiWNSaJ0TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWlTlkPL; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d0b4ea773eso623011fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 15:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707262741; x=1707867541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Ay/wmQBGa/QgXcT4SCYzDcg/BJP+Mh/Ml8UB7GvwyI=;
        b=LWlTlkPLzMbSWna7AvVUDktjzOkhGG/oDLlwWmCPjNVlu98M/LvCOO44ctRvRL+yuw
         Z69SqaxSltKOHWW9bZnH0ETiee+NYqktvJjFSTsB/IQiChJC576I5Gp1JuLlNOhu7PRM
         /sD6jrwPRDlDqS3aGytJtsPHZrcfuRgl0KgZzyrQI8l+ikmjZbuS7xoLyiwe8AiNlJtx
         n9rLfFym8PyQdCqz1qY2IsDdN5sRHl28GfJ9x+NeVDp8eQ5yrSgfcZKr0c1k42rMChTn
         ub4UVZiFJwH85tYMJv65phzvWfEe/Z58oT81JBPMa7bDGCd/g1GsjZUEnhLri5Jlqq24
         V7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707262741; x=1707867541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Ay/wmQBGa/QgXcT4SCYzDcg/BJP+Mh/Ml8UB7GvwyI=;
        b=wL7zHXB8IMC5xbHcvpxNyxH0s9ltzTfvM1HzSHJyTwwT8fQLVhNeKcyV53UHTCFqBi
         Kl+N2XMDAileQ31WpaWqRe0JLKd17RLZpcCymLCAqhDy0Z7HSC7D3rrDfI57gn8Tvva8
         fS6XV+x2d5cKDEArno9gFQqSNQYonlTEUhaP9bhOUQgrXEG9tNoU8ZAMhIkDrRreCmX8
         ttx7YhYF+Pfybuzm6Jm4cretM14R0Ke+iZxCMJqwLCM4/SrnnlD0NngC1lMShK7QvN6r
         n4pJ3+eWiua9kkwBP7cgouMt9tYxxt1PdfIdkHeYzRoLGWrw7myU65QOOUlxpR9sKeIE
         5XlA==
X-Gm-Message-State: AOJu0YwuGflLQKVOcLahilAyjvGd3W1crI8BVTe4bLllef7Ut0fiHmDK
	rmIYzDgb1rnSBQABHQjMq8mCgaQbDPFcteRJfOa4koXY6EkYmuxMN5hJxpX5Vqz3//lVec8XKEc
	0oJuwNxPsUJaNAi1VRBkbhQItXvRN1DUXHaKNvA==
X-Google-Smtp-Source: AGHT+IG1kEaWggvufauvMaJ+pvC2z8XIcXPrVEsSDRS66zPxE16F5sRkQvpnOFPaJyPRsGfzogFiB8dnq0HnEzTDLVc=
X-Received: by 2002:a2e:9084:0:b0:2d0:a307:f167 with SMTP id
 l4-20020a2e9084000000b002d0a307f167mr2540524ljg.24.1707262740413; Tue, 06 Feb
 2024 15:39:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1707103845-17220-1-git-send-email-zhiguo.niu@unisoc.com>
 <e2680238-9e9c-422a-adf3-bcee71dfe0a8@kernel.org> <ZcGoWAsl08d5-U0g@google.com>
 <2155b7d2-f7ee-4ce6-b4c9-48f715f6aa00@kernel.org>
In-Reply-To: <2155b7d2-f7ee-4ce6-b4c9-48f715f6aa00@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Wed, 7 Feb 2024 07:38:49 +0800
Message-ID: <CAHJ8P3K1jnT=vU1Gj=afA86Fe19rxA5DfdFdPk-yaa3WPM6iig@mail.gmail.com>
Subject: Re: [PATCH v7] f2fs: unify the error handling of f2fs_is_valid_blkaddr
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao@kernel.org>, Zhiguo Niu <zhiguo.niu@unisoc.com>, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com, hongyu.jin@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 11:36=E2=80=AFAM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/2/6 11:32, Jaegeuk Kim wrote:
> > On 02/05, Chao Yu wrote:
> >> On 2024/2/5 11:30, Zhiguo Niu wrote:
> >>> There are some cases of f2fs_is_valid_blkaddr not handled as
> >>> ERROR_INVALID_BLKADDR,so unify the error handling about all of
> >>> f2fs_is_valid_blkaddr.
> >>>
> >>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> >>> Signed-off-by: Chao Yu <chao@kernel.org>
> >>> ---
> >>> changes of v7: update patch according to sync with Chao
> >>>     -restore some code to original
> >>>     -modify err handle of __is_bitmap_valid for covering all cases
> >>> changes of v6: improve patch according to Chao's suggestions
> >>>     -restore dump_stack to original position
> >>>     -adjuest code sequence of __is_bitmap_check_valid
> >>> changes of v5: improve patch according to Jaegeuk's suggestiongs
> >>>     -restore return value of some f2fs_is_valid_blkaddr error case to=
 original
> >>>     -move cp_err checking to outermost for unified processing
> >>>     -return true directly for case (type=3DDATA_GENERIC_ENHANCE_READ)=
 in
> >>>      __is_bitmap_valid to avoid meaningless flow
> >>>     -rename __is_bitmap_valid to __is_bitmap_check_valid for avoiding=
 ambiguity
> >>>      and handling its return value in the caller uniformly, also coop=
erate
> >>>      switch checking true to false for error case of
> >>>      f2fs_is_valid_blkaddr(type=3DDATA_GENERIC_ENHANCE_UPDATE) in do_=
recover_data
> >>>      for more readable
> >>> changes of v4: update according to the latest code
> >>> changes of v3:
> >>>     -rebase patch to dev-test
> >>>     -correct return value for some f2fs_is_valid_blkaddr error case
> >>> changes of v2: improve patch according Chao's suggestions.
> >>> ---
> >>> ---
> >>>    fs/f2fs/checkpoint.c   | 33 ++++++++++++++++++---------------
> >>>    fs/f2fs/data.c         | 22 +++-------------------
> >>>    fs/f2fs/extent_cache.c |  5 +----
> >>>    fs/f2fs/file.c         | 16 +++-------------
> >>>    fs/f2fs/gc.c           |  2 --
> >>>    fs/f2fs/recovery.c     |  4 ----
> >>>    fs/f2fs/segment.c      |  2 --
> >>>    7 files changed, 25 insertions(+), 59 deletions(-)
> >>>
> >>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> >>> index b85820e..3335619 100644
> >>> --- a/fs/f2fs/checkpoint.c
> >>> +++ b/fs/f2fs/checkpoint.c
> >>> @@ -154,46 +154,43 @@ static bool __is_bitmap_valid(struct f2fs_sb_in=
fo *sbi, block_t blkaddr,
> >>>     if (unlikely(f2fs_cp_error(sbi)))
> >>>             return exist;
> >>> -   if (exist && type =3D=3D DATA_GENERIC_ENHANCE_UPDATE) {
> >>> -           f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit bitmap:=
%d",
> >>> -                    blkaddr, exist);
> >>> -           set_sbi_flag(sbi, SBI_NEED_FSCK);
> >>> -           return exist;
> >>> -   }
> >>> -
> >>> -   if (!exist && type =3D=3D DATA_GENERIC_ENHANCE) {
> >>> +   if ((exist && type =3D=3D DATA_GENERIC_ENHANCE_UPDATE) ||
> >>> +           (!exist && type =3D=3D DATA_GENERIC_ENHANCE)) {
> >>>             f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit bitmap:=
%d",
> >>>                      blkaddr, exist);
> >>>             set_sbi_flag(sbi, SBI_NEED_FSCK);
> >>>             dump_stack();
> >>>     }
> >>> +
> >>
> >> No need to add one blank line.
> >>
> >> Otherwise, it looks good to me.
> >>
> >> Reviewed-by: Chao Yu <chao@kernel.org>
> >>
> >> Thanks,
> >>
> >>>     return exist;
> >>>    }
> >>>    static bool __f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
> >>>                                     block_t blkaddr, int type)
> >>>    {
> >>> +   bool valid =3D false;
> >>> +
> >>>     switch (type) {
> >>>     case META_NAT:
> >>>             break;
> >>>     case META_SIT:
> >>>             if (unlikely(blkaddr >=3D SIT_BLK_CNT(sbi)))
> >>> -                   return false;
> >>> +                   goto err;
> >>>             break;
> >>>     case META_SSA:
> >>>             if (unlikely(blkaddr >=3D MAIN_BLKADDR(sbi) ||
> >>>                     blkaddr < SM_I(sbi)->ssa_blkaddr))
> >>> -                   return false;
> >>> +                   goto err;
> >>>             break;
> >>>     case META_CP:
> >>>             if (unlikely(blkaddr >=3D SIT_I(sbi)->sit_base_addr ||
> >>>                     blkaddr < __start_cp_addr(sbi)))
> >>> -                   return false;
> >>> +                   goto err;
> >>>             break;
> >>>     case META_POR:
> >>>             if (unlikely(blkaddr >=3D MAX_BLKADDR(sbi) ||
> >>>                     blkaddr < MAIN_BLKADDR(sbi)))
> >>> -                   return false;
> >>> +                   goto err;
> >>>             break;
> >>>     case DATA_GENERIC:
> >>>     case DATA_GENERIC_ENHANCE:
> >>> @@ -210,21 +207,27 @@ static bool __f2fs_is_valid_blkaddr(struct f2fs=
_sb_info *sbi,
> >>>                               blkaddr);
> >>>                     set_sbi_flag(sbi, SBI_NEED_FSCK);
> >>>                     dump_stack();
> >>> -                   return false;
> >>> +                   goto err;
> >>>             } else {
> >>> -                   return __is_bitmap_valid(sbi, blkaddr, type);
> >>> +                   valid =3D __is_bitmap_valid(sbi, blkaddr, type);
> >>> +                   if ((!valid && type !=3D DATA_GENERIC_ENHANCE_UPD=
ATE) ||
> >>> +                           (valid && type =3D=3D DATA_GENERIC_ENHANC=
E_UPDATE))
> >>> +                           goto err;
> >
> > Please think about how to optimize this, which is really ugly now.
>
> How about calling f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR) inside
> __is_bitmap_valid()? so that we may not add such logic outside
> __is_bitmap_valid()...
>
> Thanks,

Dear Jaegeuk,
I agree with Chao's options.
The original intention of this patch is that some  failed cases of
f2fs_is_valid_blkaddr
are not processed by f2fs_handle_error, so here do unified processing.
Is it a good way to keep the original main logic of __is_bitmap_valid ?
Do you have any other suggestions?
thanks!
>
> >
> >>>             }
> >>>             break;
> >>>     case META_GENERIC:
> >>>             if (unlikely(blkaddr < SEG0_BLKADDR(sbi) ||
> >>>                     blkaddr >=3D MAIN_BLKADDR(sbi)))
> >>> -                   return false;
> >>> +                   goto err;
> >>>             break;
> >>>     default:
> >>>             BUG();
> >>>     }
> >>>     return true;
> >>> +err:
> >>> +   f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> >>> +   return valid;
> >>>    }
> >>>    bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
> >>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> >>> index 05158f8..300f9ae 100644
> >>> --- a/fs/f2fs/data.c
> >>> +++ b/fs/f2fs/data.c
> >>> @@ -738,10 +738,8 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fi=
o)
> >>>     if (!f2fs_is_valid_blkaddr(fio->sbi, fio->new_blkaddr,
> >>>                     fio->is_por ? META_POR : (__is_meta_io(fio) ?
> >>> -                   META_GENERIC : DATA_GENERIC_ENHANCE))) {
> >>> -           f2fs_handle_error(fio->sbi, ERROR_INVALID_BLKADDR);
> >>> +                   META_GENERIC : DATA_GENERIC_ENHANCE)))
> >>>             return -EFSCORRUPTED;
> >>> -   }
> >>>     trace_f2fs_submit_page_bio(page, fio);
> >>> @@ -946,10 +944,8 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio=
)
> >>>                     fio->encrypted_page : fio->page;
> >>>     if (!f2fs_is_valid_blkaddr(fio->sbi, fio->new_blkaddr,
> >>> -                   __is_meta_io(fio) ? META_GENERIC : DATA_GENERIC))=
 {
> >>> -           f2fs_handle_error(fio->sbi, ERROR_INVALID_BLKADDR);
> >>> +                   __is_meta_io(fio) ? META_GENERIC : DATA_GENERIC))
> >>>             return -EFSCORRUPTED;
> >>> -   }
> >>>     trace_f2fs_submit_page_bio(page, fio);
> >>> @@ -1286,8 +1282,6 @@ struct page *f2fs_get_read_data_page(struct ino=
de *inode, pgoff_t index,
> >>>             if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode), dn.data_blka=
ddr,
> >>>                                             DATA_GENERIC_ENHANCE_READ=
)) {
> >>>                     err =3D -EFSCORRUPTED;
> >>> -                   f2fs_handle_error(F2FS_I_SB(inode),
> >>> -                                           ERROR_INVALID_BLKADDR);
> >>>                     goto put_err;
> >>>             }
> >>>             goto got_it;
> >>> @@ -1313,8 +1307,6 @@ struct page *f2fs_get_read_data_page(struct ino=
de *inode, pgoff_t index,
> >>>                                             dn.data_blkaddr,
> >>>                                             DATA_GENERIC_ENHANCE)) {
> >>>             err =3D -EFSCORRUPTED;
> >>> -           f2fs_handle_error(F2FS_I_SB(inode),
> >>> -                                   ERROR_INVALID_BLKADDR);
> >>>             goto put_err;
> >>>     }
> >>>    got_it:
> >>> @@ -1642,7 +1634,6 @@ int f2fs_map_blocks(struct inode *inode, struct=
 f2fs_map_blocks *map, int flag)
> >>>     if (!is_hole &&
> >>>         !f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE)) {
> >>>             err =3D -EFSCORRUPTED;
> >>> -           f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> >>>             goto sync_out;
> >>>     }
> >>> @@ -2166,8 +2157,6 @@ static int f2fs_read_single_page(struct inode *=
inode, struct page *page,
> >>>             if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode), block_nr,
> >>>                                             DATA_GENERIC_ENHANCE_READ=
)) {
> >>>                     ret =3D -EFSCORRUPTED;
> >>> -                   f2fs_handle_error(F2FS_I_SB(inode),
> >>> -                                           ERROR_INVALID_BLKADDR);
> >>>                     goto out;
> >>>             }
> >>>     } else {
> >>> @@ -2707,11 +2696,8 @@ int f2fs_do_write_data_page(struct f2fs_io_inf=
o *fio)
> >>>         f2fs_lookup_read_extent_cache_block(inode, page->index,
> >>>                                             &fio->old_blkaddr)) {
> >>>             if (!f2fs_is_valid_blkaddr(fio->sbi, fio->old_blkaddr,
> >>> -                                           DATA_GENERIC_ENHANCE)) {
> >>> -                   f2fs_handle_error(fio->sbi,
> >>> -                                           ERROR_INVALID_BLKADDR);
> >>> +                                           DATA_GENERIC_ENHANCE))
> >>>                     return -EFSCORRUPTED;
> >>> -           }
> >>>             ipu_force =3D true;
> >>>             fio->need_lock =3D LOCK_DONE;
> >>> @@ -2739,7 +2725,6 @@ int f2fs_do_write_data_page(struct f2fs_io_info=
 *fio)
> >>>             !f2fs_is_valid_blkaddr(fio->sbi, fio->old_blkaddr,
> >>>                                             DATA_GENERIC_ENHANCE)) {
> >>>             err =3D -EFSCORRUPTED;
> >>> -           f2fs_handle_error(fio->sbi, ERROR_INVALID_BLKADDR);
> >>>             goto out_writepage;
> >>>     }
> >>> @@ -3706,7 +3691,6 @@ static int f2fs_write_begin(struct file *file, =
struct address_space *mapping,
> >>>             if (!f2fs_is_valid_blkaddr(sbi, blkaddr,
> >>>                             DATA_GENERIC_ENHANCE_READ)) {
> >>>                     err =3D -EFSCORRUPTED;
> >>> -                   f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> >>>                     goto fail;
> >>>             }
> >>>             err =3D f2fs_submit_page_read(use_cow ?
> >>> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> >>> index ad8dfac7..48048fa 100644
> >>> --- a/fs/f2fs/extent_cache.c
> >>> +++ b/fs/f2fs/extent_cache.c
> >>> @@ -43,7 +43,6 @@ bool sanity_check_extent_cache(struct inode *inode)
> >>>     if (!f2fs_is_valid_blkaddr(sbi, ei->blk, DATA_GENERIC_ENHANCE) ||
> >>>         !f2fs_is_valid_blkaddr(sbi, ei->blk + ei->len - 1,
> >>>                                     DATA_GENERIC_ENHANCE)) {
> >>> -           set_sbi_flag(sbi, SBI_NEED_FSCK);
> >>>             f2fs_warn(sbi, "%s: inode (ino=3D%lx) extent info [%u, %u=
, %u] is incorrect, run fsck to fix",
> >>>                       __func__, inode->i_ino,
> >>>                       ei->blk, ei->fofs, ei->len);
> >>> @@ -856,10 +855,8 @@ static int __get_new_block_age(struct inode *ino=
de, struct extent_info *ei,
> >>>             goto out;
> >>>     if (__is_valid_data_blkaddr(blkaddr) &&
> >>> -       !f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE)) {
> >>> -           f2fs_bug_on(sbi, 1);
> >>> +       !f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE))
> >>>             return -EINVAL;
> >>> -   }
> >>>    out:
> >>>     /*
> >>>      * init block age with zero, this can happen when the block age e=
xtent
> >>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> >>> index 25b119cf..23cd6a1 100644
> >>> --- a/fs/f2fs/file.c
> >>> +++ b/fs/f2fs/file.c
> >>> @@ -593,10 +593,8 @@ void f2fs_truncate_data_blocks_range(struct dnod=
e_of_data *dn, int count)
> >>>                     if (time_to_inject(sbi, FAULT_BLKADDR_CONSISTENCE=
))
> >>>                             continue;
> >>>                     if (!f2fs_is_valid_blkaddr_raw(sbi, blkaddr,
> >>> -                                           DATA_GENERIC_ENHANCE)) {
> >>> -                           f2fs_handle_error(sbi, ERROR_INVALID_BLKA=
DDR);
> >>> +                                           DATA_GENERIC_ENHANCE))
> >>>                             continue;
> >>> -                   }
> >>>                     if (compressed_cluster)
> >>>                             valid_blocks++;
> >>>             }
> >>> @@ -1196,7 +1194,6 @@ static int __read_out_blkaddrs(struct inode *in=
ode, block_t *blkaddr,
> >>>                     !f2fs_is_valid_blkaddr(sbi, *blkaddr,
> >>>                                     DATA_GENERIC_ENHANCE)) {
> >>>                     f2fs_put_dnode(&dn);
> >>> -                   f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> >>>                     return -EFSCORRUPTED;
> >>>             }
> >>> @@ -1482,7 +1479,6 @@ static int f2fs_do_zero_range(struct dnode_of_d=
ata *dn, pgoff_t start,
> >>>             if (!f2fs_is_valid_blkaddr(sbi, dn->data_blkaddr,
> >>>                                     DATA_GENERIC_ENHANCE)) {
> >>>                     ret =3D -EFSCORRUPTED;
> >>> -                   f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> >>>                     break;
> >>>             }
> >>> @@ -3442,10 +3438,8 @@ static int release_compress_blocks(struct dnod=
e_of_data *dn, pgoff_t count)
> >>>             if (!__is_valid_data_blkaddr(blkaddr))
> >>>                     continue;
> >>>             if (unlikely(!f2fs_is_valid_blkaddr(sbi, blkaddr,
> >>> -                                   DATA_GENERIC_ENHANCE))) {
> >>> -                   f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> >>> +                                   DATA_GENERIC_ENHANCE)))
> >>>                     return -EFSCORRUPTED;
> >>> -           }
> >>>     }
> >>>     while (count) {
> >>> @@ -3607,10 +3601,8 @@ static int reserve_compress_blocks(struct dnod=
e_of_data *dn, pgoff_t count)
> >>>             if (!__is_valid_data_blkaddr(blkaddr))
> >>>                     continue;
> >>>             if (unlikely(!f2fs_is_valid_blkaddr(sbi, blkaddr,
> >>> -                                   DATA_GENERIC_ENHANCE))) {
> >>> -                   f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> >>> +                                   DATA_GENERIC_ENHANCE)))
> >>>                     return -EFSCORRUPTED;
> >>> -           }
> >>>     }
> >>>     while (count) {
> >>> @@ -3894,8 +3886,6 @@ static int f2fs_sec_trim_file(struct file *filp=
, unsigned long arg)
> >>>                                             DATA_GENERIC_ENHANCE)) {
> >>>                             ret =3D -EFSCORRUPTED;
> >>>                             f2fs_put_dnode(&dn);
> >>> -                           f2fs_handle_error(sbi,
> >>> -                                           ERROR_INVALID_BLKADDR);
> >>>                             goto out;
> >>>                     }
> >>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> >>> index a079eeb..30e93d8 100644
> >>> --- a/fs/f2fs/gc.c
> >>> +++ b/fs/f2fs/gc.c
> >>> @@ -1197,7 +1197,6 @@ static int ra_data_block(struct inode *inode, p=
goff_t index)
> >>>             if (unlikely(!f2fs_is_valid_blkaddr(sbi, dn.data_blkaddr,
> >>>                                             DATA_GENERIC_ENHANCE_READ=
))) {
> >>>                     err =3D -EFSCORRUPTED;
> >>> -                   f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> >>>                     goto put_page;
> >>>             }
> >>>             goto got_it;
> >>> @@ -1216,7 +1215,6 @@ static int ra_data_block(struct inode *inode, p=
goff_t index)
> >>>     if (unlikely(!f2fs_is_valid_blkaddr(sbi, dn.data_blkaddr,
> >>>                                             DATA_GENERIC_ENHANCE))) {
> >>>             err =3D -EFSCORRUPTED;
> >>> -           f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> >>>             goto put_page;
> >>>     }
> >>>    got_it:
> >>> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> >>> index aad1d1a..289c0bf 100644
> >>> --- a/fs/f2fs/recovery.c
> >>> +++ b/fs/f2fs/recovery.c
> >>> @@ -693,14 +693,12 @@ static int do_recover_data(struct f2fs_sb_info =
*sbi, struct inode *inode,
> >>>             if (__is_valid_data_blkaddr(src) &&
> >>>                     !f2fs_is_valid_blkaddr(sbi, src, META_POR)) {
> >>>                     err =3D -EFSCORRUPTED;
> >>> -                   f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> >>>                     goto err;
> >>>             }
> >>>             if (__is_valid_data_blkaddr(dest) &&
> >>>                     !f2fs_is_valid_blkaddr(sbi, dest, META_POR)) {
> >>>                     err =3D -EFSCORRUPTED;
> >>> -                   f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> >>>                     goto err;
> >>>             }
> >>> @@ -755,8 +753,6 @@ static int do_recover_data(struct f2fs_sb_info *s=
bi, struct inode *inode,
> >>>                             f2fs_err(sbi, "Inconsistent dest blkaddr:=
%u, ino:%lu, ofs:%u",
> >>>                                     dest, inode->i_ino, dn.ofs_in_nod=
e);
> >>>                             err =3D -EFSCORRUPTED;
> >>> -                           f2fs_handle_error(sbi,
> >>> -                                           ERROR_INVALID_BLKADDR);
> >>>                             goto err;
> >>>                     }
> >>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> >>> index 7901ede..ad6511f 100644
> >>> --- a/fs/f2fs/segment.c
> >>> +++ b/fs/f2fs/segment.c
> >>> @@ -334,8 +334,6 @@ static int __f2fs_commit_atomic_write(struct inod=
e *inode)
> >>>                                     DATA_GENERIC_ENHANCE)) {
> >>>                             f2fs_put_dnode(&dn);
> >>>                             ret =3D -EFSCORRUPTED;
> >>> -                           f2fs_handle_error(sbi,
> >>> -                                           ERROR_INVALID_BLKADDR);
> >>>                             goto out;
> >>>                     }

