Return-Path: <linux-kernel+bounces-43704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E929684180E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DCAF1F2374B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575542D05B;
	Tue, 30 Jan 2024 01:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWtc+h2y"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C6329CF8
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706576524; cv=none; b=jXSYW1r/T3MaIQutHI9k6y4szYs1iLKqZctxa2Qkbx4Y4XBuUaDUkVuIXpDF0IOU123jKzFfl4AidX7qMfCPoB7Ps3apEpjQLsl3PT/ehZNsKifXTAkpA8HjdfCHRUNv1VRqJSTt5yLprlsTBkts5JNWvJlkxYnKZcjROSDsA5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706576524; c=relaxed/simple;
	bh=zhyJibVVgewrHzOLSljAzXyJ8B2COUsr6sI0gVE+dMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PjrDjCBhrNPeqR34URV0q9uZlK2LlyoO9VGyslQwIemwAyeQF175CIg1tJqDBf6ke1efepNPV+NXcWulUZyp0gtf1I4D90dyIgqkxPdVrZWHE5kisf8uYFn+AUZ0KXrJ3FfUHAL9HGPvEwjS4i24GLcbpxhA46yGvbQE6QidV0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWtc+h2y; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55f15762840so1288474a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706576520; x=1707181320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlrl68rOPHe86RUmDc+SSnJULkCOyj/oiv9iqE8xefw=;
        b=bWtc+h2y6czE39a8fE97IDaog6Z631Oqub56BA9kY1mkQkZgoqkOpKyUtmBpLq1iaG
         Y+fO/IO10TYK/TmUtX7GD9n9wyM/+/b8swj5J4EWljVVA+JOmhG6chQGXGze/FJ+C54z
         GZQ56cevLqSiGXY7JS8Z7XN0kAQmYLgAV+ufoW0qAZxW+nSn9ADDGEs1qYqy64/Es8vT
         e9b46ZXjQ3D4nTtCYedD3URfaXF1NBa/v0ShavYf0KCt4aqnWHKJpObQ8WdNhkL7YQ8p
         OlS0dK8OusmodMMPquuL69ao0/D0w45hk0gHO+5SfV/jPyWgLCTEfLA5+WjoWsn5RnaN
         IlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706576520; x=1707181320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zlrl68rOPHe86RUmDc+SSnJULkCOyj/oiv9iqE8xefw=;
        b=BfWTDvbNb82xV7SNLQmx+4kmEKv6R12coQi+1t9+SvZbSbMMVfjONlnavFUMt8Oc18
         JsuXxSpWrlzrnJNojPZgmUiEVGzI4DrBI3NEUCeseKHPB+8yEGocUTLHFCD/t/5gxvLL
         Jxox/YvxyZZSiv552dBERNpLtZy73BTC+SA4tARSD7dcRgsolo1Y1y5gO9DO+lK67A/B
         HffaS2j9b/sLitBZs7cA8RoIdVCwQ2Zpx/I5rGr601SBRZWrbPHGzTU9/5sEHZ6LTHdW
         8P2DmRp3/96b/jyI3FdCEhWd+772rW5b80ytp+YGVjsGS/mLj9mhTmvs67WAazsP3mu2
         3kzA==
X-Gm-Message-State: AOJu0Yzt3qDRQCAs4VNcJX8xn5rvAyvUQp+t8qt6OQMXYeXIOGxy1+9G
	fZ4V57oTC/RVQKRxWjPBXF8//HlR5DcBtsyKTFcb4lSRynsAD5fkmCHc4VtSI2QIldlTWjcMKk6
	vnHXX6bNjECtcC0W+mHilxiatmAVltsX+AMM=
X-Google-Smtp-Source: AGHT+IFTUELXs6lheLuoLUhCjkkEKxzYYP6AKFgw6LgokBWz/2dZFtGAaVxt16IJMRP+n1pItEJCsyqon1+vuiHp4/A=
X-Received: by 2002:a05:6402:b05:b0:55f:4bc:a74b with SMTP id
 bm5-20020a0564020b0500b0055f04bca74bmr2742618edb.2.1706576520230; Mon, 29 Jan
 2024 17:02:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1706011734-1617-1-git-send-email-zhiguo.niu@unisoc.com>
 <ZbgCVfZfl7s14dM7@google.com> <CAHJ8P3K_fpoL+VQ+3SsAe+X9uxKk6WGW1EFsrsTQhnqjykVA8w@mail.gmail.com>
In-Reply-To: <CAHJ8P3K_fpoL+VQ+3SsAe+X9uxKk6WGW1EFsrsTQhnqjykVA8w@mail.gmail.com>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Tue, 30 Jan 2024 09:01:49 +0800
Message-ID: <CAHJ8P3+CCtx+52EJeg8aiLcfh9E6BwEfqaHwYtDSfv3P8VQRHA@mail.gmail.com>
Subject: Re: [PATCH v4] f2fs: unify the error handling of f2fs_is_valid_blkaddr
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, chao@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com, hongyu.jin@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 8:46=E2=80=AFAM Zhiguo Niu <niuzhiguo84@gmail.com> =
wrote:
>
> Hi Jaegeuk,
> Thanks for your suggestion,the following is my comment.
>
> On Tue, Jan 30, 2024 at 3:53=E2=80=AFAM Jaegeuk Kim <jaegeuk@kernel.org> =
wrote:
> >
> > On 01/23, Zhiguo Niu wrote:
> > > There are some cases of f2fs_is_valid_blkaddr not handled as
> > > ERROR_INVALID_BLKADDR,so unify the error handling about all of
> > > f2fs_is_valid_blkaddr.
> > >
> > > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > > ---
> > > changes of v2: improve patch according Chao's suggestions.
> > > changes of v3:
> > >       -rebase patch to dev-test
> > >       -correct return value for some f2fs_is_valid_blkaddr error case
> > > changes of v4: update according to the latest code
> > > ---
> > > ---
> > >  fs/f2fs/checkpoint.c   | 37 +++++++++++++++++++------------------
> > >  fs/f2fs/data.c         | 24 ++++--------------------
> > >  fs/f2fs/extent_cache.c |  7 ++-----
> > >  fs/f2fs/file.c         | 16 +++-------------
> > >  fs/f2fs/gc.c           |  2 --
> > >  fs/f2fs/node.c         |  2 +-
> > >  fs/f2fs/recovery.c     |  4 ----
> > >  fs/f2fs/segment.c      |  2 --
> > >  8 files changed, 29 insertions(+), 65 deletions(-)
> > >
> > > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > > index b85820e..b9bafd7 100644
> > > --- a/fs/f2fs/checkpoint.c
> > > +++ b/fs/f2fs/checkpoint.c
> > > @@ -154,19 +154,17 @@ static bool __is_bitmap_valid(struct f2fs_sb_in=
fo *sbi, block_t blkaddr,
> > >       if (unlikely(f2fs_cp_error(sbi)))
> > >               return exist;
> > > -     if (exist && type =3D=3D DATA_GENERIC_ENHANCE_UPDATE) {
> > > -             f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit bitma=
p:%d",
> > > -                      blkaddr, exist);
> > > -             set_sbi_flag(sbi, SBI_NEED_FSCK);
> > > -             return exist;
> > > -     }
> > > +     if ((exist && type =3D=3D DATA_GENERIC_ENHANCE_UPDATE) ||
> > > +                     (!exist && type =3D=3D DATA_GENERIC_ENHANCE))
> > > +             goto err;
> >
> >         if (unlikely((exist && type =3D=3D DATA_GENERIC_ENHANCE_UPDATE)=
 ||
> >                         (!exist && type =3D=3D DATA_GENERIC_ENHANCE))) =
{
> >                 f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit bitma=
p:%d",
> >                         blkaddr, exist);
> >                 set_sbi_flag(sbi, SBI_NEED_FSCK);
> >                 dump_stack();
> >
> >                 f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> >                  ^-- remove and done by caller below.
>
> The original logic of __is_bitmap_valid is to return the result
> directly , so f2fs_handle_error in
> its caller(__f2fs_is_valid_blkaddr) cannot be executed.
>
> >         }
> >         return exist;
> >
> > >
> > > -     if (!exist && type =3D=3D DATA_GENERIC_ENHANCE) {
> > > -             f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit bitma=
p:%d",
> > > -                      blkaddr, exist);
> > > -             set_sbi_flag(sbi, SBI_NEED_FSCK);
> > > -             dump_stack();
> > > -     }
> > > +     return exist;
> > > +err:
> > > +     f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit bitmap:%d",
> > > +             blkaddr, exist);
> > > +     set_sbi_flag(sbi, SBI_NEED_FSCK);
> > > +     dump_stack();
> > > +     f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> > >       return exist;
> > >  }
> > >
> > > @@ -178,22 +176,22 @@ static bool __f2fs_is_valid_blkaddr(struct f2fs=
_sb_info *sbi,
> > >               break;
> > >       case META_SIT:
> > >               if (unlikely(blkaddr >=3D SIT_BLK_CNT(sbi)))
> > > -                     return false;
> > > +                     goto err;
> > >               break;
> > >       case META_SSA:
> > >               if (unlikely(blkaddr >=3D MAIN_BLKADDR(sbi) ||
> > >                       blkaddr < SM_I(sbi)->ssa_blkaddr))
> > > -                     return false;
> > > +                     goto err;
> > >               break;
> > >       case META_CP:
> > >               if (unlikely(blkaddr >=3D SIT_I(sbi)->sit_base_addr ||
> > >                       blkaddr < __start_cp_addr(sbi)))
> > > -                     return false;
> > > +                     goto err;
> > >               break;
> > >       case META_POR:
> > >               if (unlikely(blkaddr >=3D MAX_BLKADDR(sbi) ||
> > >                       blkaddr < MAIN_BLKADDR(sbi)))
> > > -                     return false;
> > > +                     goto err;
> > >               break;
> > >       case DATA_GENERIC:
> > >       case DATA_GENERIC_ENHANCE:
> > > @@ -210,7 +208,7 @@ static bool __f2fs_is_valid_blkaddr(struct f2fs_s=
b_info *sbi,
> > >                                 blkaddr);
> > >                       set_sbi_flag(sbi, SBI_NEED_FSCK);
> > >                       dump_stack();
> > > -                     return false;
> > > +                     goto err;
> > >               } else {
> > >                       return __is_bitmap_valid(sbi, blkaddr, type);
> >
> >                         if (!__is_bitmap_valid())
> >                                 goto err;
sorry I miss these codes  in the previous e-mail=EF=BC=8C thiis can not cov=
er
the case __is_bitmap_valid
return true of (type=3D=3DDATA_GENERIC_ENHANCE_UPDATE && related blkaddr
bitmap exist in se->cur_valid_map)
> >
> > >               }
> > > @@ -218,13 +216,16 @@ static bool __f2fs_is_valid_blkaddr(struct f2fs=
_sb_info *sbi,
> > >       case META_GENERIC:
> > >               if (unlikely(blkaddr < SEG0_BLKADDR(sbi) ||
> > >                       blkaddr >=3D MAIN_BLKADDR(sbi)))
> > > -                     return false;
> > > +                     goto err;
> > >               break;
> > >       default:
> > >               BUG();
> > >       }
> > >
> > >       return true;
> > > +err:
> > > +     f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> > > +     return false;
> > >  }
> > >
> > >  bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
> > > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > > index 65fe48b..0f9a657 100644
> > > --- a/fs/f2fs/data.c
> > > +++ b/fs/f2fs/data.c
> > > @@ -738,10 +738,8 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fi=
o)
> > >
> > >       if (!f2fs_is_valid_blkaddr(fio->sbi, fio->new_blkaddr,
> > >                       fio->is_por ? META_POR : (__is_meta_io(fio) ?
> > > -                     META_GENERIC : DATA_GENERIC_ENHANCE))) {
> > > -             f2fs_handle_error(fio->sbi, ERROR_INVALID_BLKADDR);
> > > +                     META_GENERIC : DATA_GENERIC_ENHANCE)))
> > >               return -EFSCORRUPTED;
> > > -     }
> > >
> > >       trace_f2fs_submit_page_bio(page, fio);
> > >
> > > @@ -946,10 +944,8 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio=
)
> > >                       fio->encrypted_page : fio->page;
> > >
> > >       if (!f2fs_is_valid_blkaddr(fio->sbi, fio->new_blkaddr,
> > > -                     __is_meta_io(fio) ? META_GENERIC : DATA_GENERIC=
)) {
> > > -             f2fs_handle_error(fio->sbi, ERROR_INVALID_BLKADDR);
> > > +                     __is_meta_io(fio) ? META_GENERIC : DATA_GENERIC=
))
> > >               return -EFSCORRUPTED;
> > > -     }
> > >
> > >       trace_f2fs_submit_page_bio(page, fio);
> > >
> > > @@ -1287,8 +1283,6 @@ struct page *f2fs_get_read_data_page(struct ino=
de *inode, pgoff_t index,
> > >               if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode), dn.data_bl=
kaddr,
> > >                                               DATA_GENERIC_ENHANCE_RE=
AD)) {
> > >                       err =3D -EFSCORRUPTED;
> > > -                     f2fs_handle_error(F2FS_I_SB(inode),
> > > -                                             ERROR_INVALID_BLKADDR);
> > >                       goto put_err;
> > >               }
> > >               goto got_it;
> > > @@ -1314,8 +1308,6 @@ struct page *f2fs_get_read_data_page(struct ino=
de *inode, pgoff_t index,
> > >                                               dn.data_blkaddr,
> > >                                               DATA_GENERIC_ENHANCE)) =
{
> > >               err =3D -EFSCORRUPTED;
> > > -             f2fs_handle_error(F2FS_I_SB(inode),
> > > -                                     ERROR_INVALID_BLKADDR);
> > >               goto put_err;
> > >       }
> > >  got_it:
> > > @@ -1643,7 +1635,6 @@ int f2fs_map_blocks(struct inode *inode, struct=
 f2fs_map_blocks *map, int flag)
> > >       if (!is_hole &&
> > >           !f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE))=
 {
> > >               err =3D -EFSCORRUPTED;
> > > -             f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> > >               goto sync_out;
> > >       }
> > >
> > > @@ -2167,8 +2158,6 @@ static int f2fs_read_single_page(struct inode *=
inode, struct page *page,
> > >               if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode), block_nr,
> > >                                               DATA_GENERIC_ENHANCE_RE=
AD)) {
> > >                       ret =3D -EFSCORRUPTED;
> > > -                     f2fs_handle_error(F2FS_I_SB(inode),
> > > -                                             ERROR_INVALID_BLKADDR);
> > >                       goto out;
> > >               }
> > >       } else {
> > > @@ -2301,7 +2290,7 @@ int f2fs_read_multi_pages(struct compress_ctx *=
cc, struct bio **bio_ret,
> > >                       break;
> > >
> > >               if (!f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC))=
 {
> > > -                     ret =3D -EFAULT;
> > > +                     ret =3D -EFSCORRUPTED;
> >
> > I'd prefer not to change anything.
> OK~
> >
> > >                       goto out_put_dnode;
> > >               }
> > >               cc->nr_cpages++;
> > > @@ -2708,11 +2697,8 @@ int f2fs_do_write_data_page(struct f2fs_io_inf=
o *fio)
> > >           f2fs_lookup_read_extent_cache_block(inode, page->index,
> > >                                               &fio->old_blkaddr)) {
> > >               if (!f2fs_is_valid_blkaddr(fio->sbi, fio->old_blkaddr,
> > > -                                             DATA_GENERIC_ENHANCE)) =
{
> > > -                     f2fs_handle_error(fio->sbi,
> > > -                                             ERROR_INVALID_BLKADDR);
> > > +                                             DATA_GENERIC_ENHANCE))
> > >                       return -EFSCORRUPTED;
> > > -             }
> > >
> > >               ipu_force =3D true;
> > >               fio->need_lock =3D LOCK_DONE;
> > > @@ -2740,7 +2726,6 @@ int f2fs_do_write_data_page(struct f2fs_io_info=
 *fio)
> > >               !f2fs_is_valid_blkaddr(fio->sbi, fio->old_blkaddr,
> > >                                               DATA_GENERIC_ENHANCE)) =
{
> > >               err =3D -EFSCORRUPTED;
> > > -             f2fs_handle_error(fio->sbi, ERROR_INVALID_BLKADDR);
> > >               goto out_writepage;
> > >       }
> > >
> > > @@ -3707,7 +3692,6 @@ static int f2fs_write_begin(struct file *file, =
struct address_space *mapping,
> > >               if (!f2fs_is_valid_blkaddr(sbi, blkaddr,
> > >                               DATA_GENERIC_ENHANCE_READ)) {
> > >                       err =3D -EFSCORRUPTED;
> > > -                     f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> > >                       goto fail;
> > >               }
> > >               err =3D f2fs_submit_page_read(use_cow ?
> > > diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> > > index ad8dfac7..99d0442 100644
> > > --- a/fs/f2fs/extent_cache.c
> > > +++ b/fs/f2fs/extent_cache.c
> > > @@ -43,7 +43,6 @@ bool sanity_check_extent_cache(struct inode *inode)
> > >       if (!f2fs_is_valid_blkaddr(sbi, ei->blk, DATA_GENERIC_ENHANCE) =
||
> > >           !f2fs_is_valid_blkaddr(sbi, ei->blk + ei->len - 1,
> > >                                       DATA_GENERIC_ENHANCE)) {
> > > -             set_sbi_flag(sbi, SBI_NEED_FSCK);
> >
> > Why do you remove this?
> there are 2 cases for f2fs_is_valid_blkaddr return false,
> one case is blkaddr is invalid so f2fs_is_valid_blkaddr will do
> set_sbi_flag(sbi, SBI_NEED_FSCK);
> another case is cp_err, and sanity_check_extent_cache also has do
> sanity check this case above the code
> f2fs_is_valid_blkaddr(sbi, ei->blk, DATA_GENERIC_ENHANCE);
> >
> > >               f2fs_warn(sbi, "%s: inode (ino=3D%lx) extent info [%u, =
%u, %u] is incorrect, run fsck to fix",
> > >                         __func__, inode->i_ino,
> > >                         ei->blk, ei->fofs, ei->len);
> > > @@ -856,10 +855,8 @@ static int __get_new_block_age(struct inode *ino=
de, struct extent_info *ei,
> > >               goto out;
> > >
> > >       if (__is_valid_data_blkaddr(blkaddr) &&
> > > -         !f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE))=
 {
> > > -             f2fs_bug_on(sbi, 1);
> > > -             return -EINVAL;
> > > -     }
> > > +         !f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE))
> > > +             return -EFSCORRUPTED;
> >
> > Let's keep EINVAL first.
> OK~
> >
> > >  out:
> > >       /*
> > >        * init block age with zero, this can happen when the block age=
 extent
> > > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > index 25b119cf..23cd6a1 100644
> > > --- a/fs/f2fs/file.c
> > > +++ b/fs/f2fs/file.c
> > > @@ -593,10 +593,8 @@ void f2fs_truncate_data_blocks_range(struct dnod=
e_of_data *dn, int count)
> > >                       if (time_to_inject(sbi, FAULT_BLKADDR_CONSISTEN=
CE))
> > >                               continue;
> > >                       if (!f2fs_is_valid_blkaddr_raw(sbi, blkaddr,
> > > -                                             DATA_GENERIC_ENHANCE)) =
{
> > > -                             f2fs_handle_error(sbi, ERROR_INVALID_BL=
KADDR);
> > > +                                             DATA_GENERIC_ENHANCE))
> > >                               continue;
> > > -                     }
> > >                       if (compressed_cluster)
> > >                               valid_blocks++;
> > >               }
> > > @@ -1196,7 +1194,6 @@ static int __read_out_blkaddrs(struct inode *in=
ode, block_t *blkaddr,
> > >                       !f2fs_is_valid_blkaddr(sbi, *blkaddr,
> > >                                       DATA_GENERIC_ENHANCE)) {
> > >                       f2fs_put_dnode(&dn);
> > > -                     f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> > >                       return -EFSCORRUPTED;
> > >               }
> > >
> > > @@ -1482,7 +1479,6 @@ static int f2fs_do_zero_range(struct dnode_of_d=
ata *dn, pgoff_t start,
> > >               if (!f2fs_is_valid_blkaddr(sbi, dn->data_blkaddr,
> > >                                       DATA_GENERIC_ENHANCE)) {
> > >                       ret =3D -EFSCORRUPTED;
> > > -                     f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> > >                       break;
> > >               }
> > >
> > > @@ -3442,10 +3438,8 @@ static int release_compress_blocks(struct dnod=
e_of_data *dn, pgoff_t count)
> > >               if (!__is_valid_data_blkaddr(blkaddr))
> > >                       continue;
> > >               if (unlikely(!f2fs_is_valid_blkaddr(sbi, blkaddr,
> > > -                                     DATA_GENERIC_ENHANCE))) {
> > > -                     f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> > > +                                     DATA_GENERIC_ENHANCE)))
> > >                       return -EFSCORRUPTED;
> > > -             }
> > >       }
> > >
> > >       while (count) {
> > > @@ -3607,10 +3601,8 @@ static int reserve_compress_blocks(struct dnod=
e_of_data *dn, pgoff_t count)
> > >               if (!__is_valid_data_blkaddr(blkaddr))
> > >                       continue;
> > >               if (unlikely(!f2fs_is_valid_blkaddr(sbi, blkaddr,
> > > -                                     DATA_GENERIC_ENHANCE))) {
> > > -                     f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> > > +                                     DATA_GENERIC_ENHANCE)))
> > >                       return -EFSCORRUPTED;
> > > -             }
> > >       }
> > >
> > >       while (count) {
> > > @@ -3894,8 +3886,6 @@ static int f2fs_sec_trim_file(struct file *filp=
, unsigned long arg)
> > >                                               DATA_GENERIC_ENHANCE)) =
{
> > >                               ret =3D -EFSCORRUPTED;
> > >                               f2fs_put_dnode(&dn);
> > > -                             f2fs_handle_error(sbi,
> > > -                                             ERROR_INVALID_BLKADDR);
> > >                               goto out;
> > >                       }
> > >
> > > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > > index a079eeb..30e93d8 100644
> > > --- a/fs/f2fs/gc.c
> > > +++ b/fs/f2fs/gc.c
> > > @@ -1197,7 +1197,6 @@ static int ra_data_block(struct inode *inode, p=
goff_t index)
> > >               if (unlikely(!f2fs_is_valid_blkaddr(sbi, dn.data_blkadd=
r,
> > >                                               DATA_GENERIC_ENHANCE_RE=
AD))) {
> > >                       err =3D -EFSCORRUPTED;
> > > -                     f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> > >                       goto put_page;
> > >               }
> > >               goto got_it;
> > > @@ -1216,7 +1215,6 @@ static int ra_data_block(struct inode *inode, p=
goff_t index)
> > >       if (unlikely(!f2fs_is_valid_blkaddr(sbi, dn.data_blkaddr,
> > >                                               DATA_GENERIC_ENHANCE)))=
 {
> > >               err =3D -EFSCORRUPTED;
> > > -             f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> > >               goto put_page;
> > >       }
> > >  got_it:
> > > diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> > > index 9b546fd..541c4ad 100644
> > > --- a/fs/f2fs/node.c
> > > +++ b/fs/f2fs/node.c
> > > @@ -612,7 +612,7 @@ int f2fs_get_node_info(struct f2fs_sb_info *sbi, =
nid_t nid,
> > >       blkaddr =3D le32_to_cpu(ne.block_addr);
> > >       if (__is_valid_data_blkaddr(blkaddr) &&
> > >               !f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHAN=
CE))
> > > -             return -EFAULT;
> > > +             return -EFSCORRUPTED;
> >
> > Ditto.
> OK~
> >
> > >
> > >       /* cache nat entry */
> > >       cache_nat_entry(sbi, nid, &ne);
> > > diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> > > index d0f24cc..21381b7 100644
> > > --- a/fs/f2fs/recovery.c
> > > +++ b/fs/f2fs/recovery.c
> > > @@ -680,14 +680,12 @@ static int do_recover_data(struct f2fs_sb_info =
*sbi, struct inode *inode,
> > >               if (__is_valid_data_blkaddr(src) &&
> > >                       !f2fs_is_valid_blkaddr(sbi, src, META_POR)) {
> > >                       err =3D -EFSCORRUPTED;
> > > -                     f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> > >                       goto err;
> > >               }
> > >
> > >               if (__is_valid_data_blkaddr(dest) &&
> > >                       !f2fs_is_valid_blkaddr(sbi, dest, META_POR)) {
> > >                       err =3D -EFSCORRUPTED;
> > > -                     f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> > >                       goto err;
> > >               }
> > >
> > > @@ -756,8 +754,6 @@ static int do_recover_data(struct f2fs_sb_info *s=
bi, struct inode *inode,
> > >                               f2fs_err(sbi, "Inconsistent dest blkadd=
r:%u, ino:%lu, ofs:%u",
> > >                                       dest, inode->i_ino, dn.ofs_in_n=
ode);
> > >                               err =3D -EFSCORRUPTED;
> > > -                             f2fs_handle_error(sbi,
> > > -                                             ERROR_INVALID_BLKADDR);
> > >                               goto err;
> > >                       }
> > >
> > > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > > index 7901ede..ad6511f 100644
> > > --- a/fs/f2fs/segment.c
> > > +++ b/fs/f2fs/segment.c
> > > @@ -334,8 +334,6 @@ static int __f2fs_commit_atomic_write(struct inod=
e *inode)
> > >                                       DATA_GENERIC_ENHANCE)) {
> > >                               f2fs_put_dnode(&dn);
> > >                               ret =3D -EFSCORRUPTED;
> > > -                             f2fs_handle_error(sbi,
> > > -                                             ERROR_INVALID_BLKADDR);
> > >                               goto out;
> > >                       }
> > >
> > > --
> > > 1.9.1

