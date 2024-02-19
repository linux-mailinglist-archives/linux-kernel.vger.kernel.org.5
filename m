Return-Path: <linux-kernel+bounces-71182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D1385A1C9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0F5B280C9C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F8C2C19E;
	Mon, 19 Feb 2024 11:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBS5EiL1"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F38D2C191
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708341587; cv=none; b=Vdv20hcNCJSBrs3Kxs/T0toqj5vgURUyDindRfYuSrtgJy3+BbzaGFfDEceMdQOsg0J2RcAEDr7o+EOonpSHNWgTHn5KlES72M5+eVGoqQeDQFmghCplBC+VHoXId1c6Y5FmGfPdWLvmU2DulD6Q15pwZ7JkZCfCIDJiQPcTxs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708341587; c=relaxed/simple;
	bh=wHx6pi4FrwlWD8WjC77wLOozHwt6fGChtQCedQwN1Yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lBgRE3PldUFwm57gqa1mBZ7r9a/KIA8bImH8O9J+b4cFkp673QpAu6pKvVcaEcGM6xlxLM/3dP/VeiZ/hluhYeLb3trUa0gcTVeMV9visvz2FjZ9zZbcrEW3Zj2v58RsqWd06R99IJsukWIAANLV4eGyQBYososMZxW6KYsc0YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBS5EiL1; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-512a65cd2c7so1886105e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 03:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708341583; x=1708946383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44K7c4HN3C+qbikcPUla31//NnnyxNYmejz5eYB2dMY=;
        b=cBS5EiL1Vw7qIgUiGJgtyztB7xCsyILXZOSQ25alepxLtkpXiHXyFDN1wPoUUustYv
         dKkPG0xYVKbCC36b9mfCeR58fmXr7+bBV6vuIyqT4CCEHxmrhcg51dfdQjjxhm1zdPTE
         C48DkOHqDuMIRCFZcrcemeIKhMkHFz+zJphKK7Fow5QEzGn2KiMMDEDOcj/BBsFB20FH
         sQMAwEJpzel77lW85v/bwQI8NhF004wOQDnTWEbON8jNUicNB21m7rKtuSn9G7dPjpPb
         frY5lPspaUGoBMxWMwoSU7lOHeqlenmLgQ4a/3nHe4p5k2CG7Aft91pO5ykacGqKBLvv
         POAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708341583; x=1708946383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=44K7c4HN3C+qbikcPUla31//NnnyxNYmejz5eYB2dMY=;
        b=pf2IAWg/XPeKEL+1ivFMhuuRdgUZDTaeyxO8fzM6j05g+oDKc76EFh/VmSmGj9lNMm
         9Bh6EoQRLeXNyugQ5IEGXzbjFAM78UzzyGNXmmxdNV2jbIDiy8KBvFqlCtHQUV0IdnCp
         aRKm3gwD8JmCo3NclZ26E/CqOOKE1sxrvAY0ctdxpqbq9O/IvY7FSmozUXG7CBeepavi
         tlN/H9HpR5sqhYssTOHGduixpKwhQtuj/nyC52WGZgXzT6gI67j7iZ2bVVOg/5ZeDG8W
         btsQ1j+qDdg7RutJT4c7MfwQFZM7NnsaR3OIas5ASFImrZmhxeVzhqOruWS7e5pVSWz1
         rbXA==
X-Forwarded-Encrypted: i=1; AJvYcCVw52nTjjWrwwFaFUIwTdOfaiOC3KsNQEtpOlCafUCdnMqhyZqDA4ie+e4MMoMfSxgwV+3RpkO0JkdgnIytQnCmnUG5/68h8LRC+vJU
X-Gm-Message-State: AOJu0YwS79gj3mf+1xFI6KVhV3WPcd3QxoghFjmIoIdujruX+U+A/7K0
	Kv0mqSyS6ytYIyx0GEgidd19wukphwsLHwpm9vooZPcUW2RcYZMYVyNNZ8Hxq0PmOaq2piW0BiW
	HDAOnbg4f8XWiEAdWIz6renEC3ws=
X-Google-Smtp-Source: AGHT+IGAIOX1/k2mOKqZxWg80ItiaAPduZoJtFMVO75xTrCP/cM1JdTpKQnqErfMTvhm6qGLlD7G7LSSuGopxlAHOo0=
X-Received: by 2002:a05:6512:3b8f:b0:512:ae9b:559 with SMTP id
 g15-20020a0565123b8f00b00512ae9b0559mr3149491lfv.34.1708341583015; Mon, 19
 Feb 2024 03:19:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1707103845-17220-1-git-send-email-zhiguo.niu@unisoc.com>
 <e2680238-9e9c-422a-adf3-bcee71dfe0a8@kernel.org> <ZcGoWAsl08d5-U0g@google.com>
 <6f01fe1b-d580-4a2a-adc5-7eb3baebeb7a@kernel.org>
In-Reply-To: <6f01fe1b-d580-4a2a-adc5-7eb3baebeb7a@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Mon, 19 Feb 2024 19:19:31 +0800
Message-ID: <CAHJ8P3J6CrYeBHUHmk4rQXRr=V0jHkLWOKHjdC+xuLgb4a+NQQ@mail.gmail.com>
Subject: Re: [PATCH v7] f2fs: unify the error handling of f2fs_is_valid_blkaddr
To: Chao Yu <chao@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Zhiguo Niu <zhiguo.niu@unisoc.com>, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com, hongyu.jin@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Chao

On Mon, Feb 19, 2024 at 11:46=E2=80=AFAM Chao Yu <chao@kernel.org> wrote:
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
> How about this?
>
> ---
>   fs/f2fs/checkpoint.c | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 246b2a063cfb..5a6ac6f26cfe 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -135,7 +135,7 @@ struct page *f2fs_get_tmp_page(struct f2fs_sb_info *s=
bi, pgoff_t index)
>   }
>
>   static bool __is_bitmap_valid(struct f2fs_sb_info *sbi, block_t blkaddr=
,
> -                                                       int type)
> +                                               int type, bool *record_er=
ror)
>   {
>         struct seg_entry *se;
>         unsigned int segno, offset;
> @@ -160,6 +160,7 @@ static bool __is_bitmap_valid(struct f2fs_sb_info *sb=
i, block_t blkaddr,
>                          blkaddr, exist);
>                 set_sbi_flag(sbi, SBI_NEED_FSCK);
>                 dump_stack();
> +               *record_error =3D true;
>         }
>
>         return exist;
> @@ -168,8 +169,6 @@ static bool __is_bitmap_valid(struct f2fs_sb_info *sb=
i, block_t blkaddr,
>   static bool __f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
>                                         block_t blkaddr, int type)
>   {
> -       bool valid =3D false;
> -
>         switch (type) {
>         case META_NAT:
>                 break;
> @@ -209,10 +208,13 @@ static bool __f2fs_is_valid_blkaddr(struct f2fs_sb_=
info *sbi,
>                         dump_stack();
>                         goto err;
>                 } else {
> -                       valid =3D __is_bitmap_valid(sbi, blkaddr, type);
> -                       if ((!valid && type !=3D DATA_GENERIC_ENHANCE_UPD=
ATE) ||
> -                               (valid && type =3D=3D DATA_GENERIC_ENHANC=
E_UPDATE))
> +                       bool valid, record_error =3D false;
> +
> +                       valid =3D __is_bitmap_valid(sbi, blkaddr, type,
> +                                                       &record_error);
> +                       if (!valid || record_error)
>                                 goto err;
> +                       return valid;
>                 }
>                 break;
>         case META_GENERIC:
> @@ -227,7 +229,7 @@ static bool __f2fs_is_valid_blkaddr(struct f2fs_sb_in=
fo *sbi,
>         return true;
>   err:
>         f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> -       return valid;
> +       return false;
for case:   (type =3D=3D DATA_GENERIC_ENHANCE_UPDATE and bitmap check valid=
=EF=BC=89,
true should be returned, but here return false,  it is not  as expected, ri=
ght?
>   }
>
>   bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
> --
> 2.40.1
>
>
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

