Return-Path: <linux-kernel+bounces-90156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD2186FB21
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 486E71C20F64
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2521168BA;
	Mon,  4 Mar 2024 07:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAcbZKdq"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC3E16429
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 07:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709538758; cv=none; b=HTtOxr+3G1kCp5IE4Bb/2Jp/QCenDWqc04Rm8ebEAHYGvdkr6/+t9vAnLUVDQljAc3N7+sdQAwi0dhUNyacFBZKic0ey5LMJzBhd/VP7W1N86zLVqp+3gndU8pvkSFZNgioNLgNydyzZyC9wxQN3AvEdwLLhzreL2n9o/ET8pWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709538758; c=relaxed/simple;
	bh=r9HHtJnYVUKchs7aXVrXEujd+FfyutSQcERR7mI0IJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mjaaxtkcsOIL9rdKtv0VcDVTxlT/mNTESJacOHNBgFrvMhgYZkLaK0w7Crzt+32rEaeyO1Zr3BqLCXHT0RbBjBE1auW8ZiBTervtEf5sAxlzEsPZkcSRDgWOlFbx0NjdYE8RZnQfGuhkRVe6FKYFXbDNLmeCSl/TqMb5nHqkCoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UAcbZKdq; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5133d276cbaso2106599e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 23:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709538755; x=1710143555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4wbgivd5+75Dv+XUKqvmXgCNe2XqRsJil0CRCI0gOU=;
        b=UAcbZKdq1VKEMyB7sSodCfwtYYJGoCBtfAT7pH6Y4GVwV1bsxuA/h2H1NQpNoe1mz5
         fEw+Uf6IHlttOiccrd8jcHmw4BEykdRWq/qm5EQxAXkTCf6u7t9WMu/AJKEUHG8Fa3Q4
         R5m+XXPwdQjD05u+ab5DJCTh2olQUshMqNXIjaPemT0nOyJgk9QKZTXjPo2EkMK9JR+n
         qyeM+zEB+kBOI3bXeBCNsG+sZRzAmxVCdVmzCIwjf6PsDSq9IYPaMi6TncNk+uko5M75
         LcDfbmHv1FbWji4uSPDK2pOLUcbTT8TVbgFCVPlrx2JMh/lXI1JZzQKFppVBMWALJ5qX
         KbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709538755; x=1710143555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4wbgivd5+75Dv+XUKqvmXgCNe2XqRsJil0CRCI0gOU=;
        b=Yknxqlw16tLbEzG9fuMIF5UE31eKkuzFDuefuzEqhFVeQjSnw2IWYBeP1bRaHJye0c
         xjj1Ky2CS/HsULuNA8srlvnPWQwRFevrWwNs5XmmN+w+2QY77CUNIDLZMN8/DPW+X+hh
         b2XRhEzhW3Zv3b/sBBi5DKhYX3F/4udNsFwkCQFalHqlApbbo16O6dfi8EZspazxnFp/
         CxpvcZmpEPkdzjntS8M0g0e0gi18UEMFGltOtKt6pHGJWQ8EpqvHih3/wBV94vwHgQpz
         /c8vqUAkq3s+VbdO3l7W7syUld7FytGWm8JHmJPGnugzInb6xwMGlkh7yvDaXFlSAPOr
         qZ8g==
X-Forwarded-Encrypted: i=1; AJvYcCWAEoB0ekgTEL3El4Mi/QnlGyDdXk8HOpP6vSFMv0uJoSiZrKYY/M+xU0ovQwQdoRWf/xI0WjuLKzh085kjpHSGAZsPEcsRfO9YSp5A
X-Gm-Message-State: AOJu0Yzsbi/TySqrHPh/dFepU3ddaaCz5F0/ngR6dmzJfZSOkOb2YxAF
	DUUkMHIKX5MH+keQWsYO15YbIE8QlUW8Ge3ai1+ZXnNVD819POjjpir/eWeRJGu/seWrGO7Q8/I
	gXm+Np5QO40b00i+AicjYYVSE686HSt/lASqF/w==
X-Google-Smtp-Source: AGHT+IGI8lhkeOLlr4j0ronceXg/nFZYLqUVtI16BzpMfKrWMEZPgxgiadDMsCfmkHRQMmK6qzmKMqPw9adG2ZuUp1I=
X-Received: by 2002:a05:6512:10d4:b0:513:3d98:440 with SMTP id
 k20-20020a05651210d400b005133d980440mr3924245lfg.53.1709538754406; Sun, 03
 Mar 2024 23:52:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1709292976-13118-1-git-send-email-zhiguo.niu@unisoc.com>
 <7dc371ad-2448-4dd4-9551-8caef0a00d48@kernel.org> <CAHJ8P3+ZBuBu9Sdpm_6fxhY2sVyu97dXFKKLdtEF4shi_3Fs1Q@mail.gmail.com>
 <73197f36-4962-4a3d-a56c-8fd3494af7e5@kernel.org>
In-Reply-To: <73197f36-4962-4a3d-a56c-8fd3494af7e5@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Mon, 4 Mar 2024 15:52:23 +0800
Message-ID: <CAHJ8P3Kiys7ZESM-J2oEBYs1dd+zAVQ2zrvg5t02eqXRMEudXQ@mail.gmail.com>
Subject: Re: [PATCH] f2fs: fix to check result of new_curseg in f2fs_allocate_segment_for_resize
To: Chao Yu <chao@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com, hongyu.jin@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 3:17=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/3/4 11:33, Zhiguo Niu wrote:
> > On Mon, Mar 4, 2024 at 11:19=E2=80=AFAM Chao Yu <chao@kernel.org> wrote=
:
> >>
> >> On 2024/3/1 19:36, Zhiguo Niu wrote:
> >>> new_curseg may return error if get_new_segment fail, so its result
> >>> should be check in its caller f2fs_allocate_segment_for_resize,
> >>> alos pass this results to free_segment_range.
> >>
> >> Zhiguo,
> >>
> >> What about handling all error paths of new_curseg() and change_curseg(=
)
> >> in one patch?
> > Dear Chao,
> >
> > Do you mean to merge it with the previous patch =E2=80=9Cf2fs: fix to c=
heck
> > return value of f2fs_gc_range=E2=80=9D?
> > Because in addition to new_curseg/change_curseg error handling, there
> > are some other changes in the previous patch.
> > besides, I searched for new related codes, and there should be the
> > only place left without error handling about new_curseg/
> > change_curseg .
>
> Zhiguo, I meant something like this?
>
> Subject: [PATCH] f2fs: fix to handle error paths of {new,change}_curseg()
Dear Chao,
I got your meaning and I think this patch looks good.
Please ignore my patch and use your version:=EF=BC=89.
thanks!
>
> ---
>   fs/f2fs/f2fs.h    |  4 +--
>   fs/f2fs/gc.c      |  7 +++--
>   fs/f2fs/segment.c | 67 +++++++++++++++++++++++++++++++----------------
>   fs/f2fs/super.c   |  4 ++-
>   4 files changed, 54 insertions(+), 28 deletions(-)
>
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 80789255bf68..03927f1b2ea1 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3702,10 +3702,10 @@ int f2fs_disable_cp_again(struct f2fs_sb_info *sb=
i, block_t unusable);
>   void f2fs_release_discard_addrs(struct f2fs_sb_info *sbi);
>   int f2fs_npages_for_summary_flush(struct f2fs_sb_info *sbi, bool for_ra=
);
>   bool f2fs_segment_has_free_slot(struct f2fs_sb_info *sbi, int segno);
> -void f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi);
> +int f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi);
>   void f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi);
>   void f2fs_restore_inmem_curseg(struct f2fs_sb_info *sbi);
> -void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type=
,
> +int f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
>                                         unsigned int start, unsigned int =
end);
>   int f2fs_allocate_new_section(struct f2fs_sb_info *sbi, int type, bool =
force);
>   int f2fs_allocate_pinning_section(struct f2fs_sb_info *sbi);
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index f8314765246a..854ad0a3f6ea 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -2033,8 +2033,11 @@ static int free_segment_range(struct f2fs_sb_info =
*sbi,
>         mutex_unlock(&DIRTY_I(sbi)->seglist_lock);
>
>         /* Move out cursegs from the target range */
> -       for (type =3D CURSEG_HOT_DATA; type < NR_CURSEG_PERSIST_TYPE; typ=
e++)
> -               f2fs_allocate_segment_for_resize(sbi, type, start, end);
> +       for (type =3D CURSEG_HOT_DATA; type < NR_CURSEG_PERSIST_TYPE; typ=
e++) {
> +               err =3D f2fs_allocate_segment_for_resize(sbi, type, start=
, end);
> +               if (err)
> +                       goto out;
> +       }
>
>         /* do GC to move out valid blocks in the range */
>         err =3D f2fs_gc_range(sbi, start, end, dry_run, 0);
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 22241aba6564..2bcf01fde143 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2863,7 +2863,7 @@ bool f2fs_segment_has_free_slot(struct f2fs_sb_info=
 *sbi, int segno)
>    * This function always allocates a used segment(from dirty seglist) by=
 SSR
>    * manner, so it should recover the existing segment information of val=
id blocks
>    */
> -static void change_curseg(struct f2fs_sb_info *sbi, int type)
> +static int change_curseg(struct f2fs_sb_info *sbi, int type)
>   {
>         struct dirty_seglist_info *dirty_i =3D DIRTY_I(sbi);
>         struct curseg_info *curseg =3D CURSEG_I(sbi, type);
> @@ -2888,21 +2888,24 @@ static void change_curseg(struct f2fs_sb_info *sb=
i, int type)
>         if (IS_ERR(sum_page)) {
>                 /* GC won't be able to use stale summary pages by cp_erro=
r */
>                 memset(curseg->sum_blk, 0, SUM_ENTRY_SIZE);
> -               return;
> +               return PTR_ERR(sum_page);
>         }
>         sum_node =3D (struct f2fs_summary_block *)page_address(sum_page);
>         memcpy(curseg->sum_blk, sum_node, SUM_ENTRY_SIZE);
>         f2fs_put_page(sum_page, 1);
> +
> +       return 0;
>   }
>
>   static int get_ssr_segment(struct f2fs_sb_info *sbi, int type,
>                                 int alloc_mode, unsigned long long age);
>
> -static void get_atssr_segment(struct f2fs_sb_info *sbi, int type,
> +static int get_atssr_segment(struct f2fs_sb_info *sbi, int type,
>                                         int target_type, int alloc_mode,
>                                         unsigned long long age)
>   {
>         struct curseg_info *curseg =3D CURSEG_I(sbi, type);
> +       int ret;
>
>         curseg->seg_type =3D target_type;
>
> @@ -2910,38 +2913,45 @@ static void get_atssr_segment(struct f2fs_sb_info=
 *sbi, int type,
>                 struct seg_entry *se =3D get_seg_entry(sbi, curseg->next_=
segno);
>
>                 curseg->seg_type =3D se->type;
> -               change_curseg(sbi, type);
> +               ret =3D change_curseg(sbi, type);
>         } else {
>                 /* allocate cold segment by default */
>                 curseg->seg_type =3D CURSEG_COLD_DATA;
> -               new_curseg(sbi, type, true);
> +               ret =3D new_curseg(sbi, type, true);
>         }
>         stat_inc_seg_type(sbi, curseg);
> +
> +       return ret;
>   }
>
> -static void __f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi)
> +static int __f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi)
>   {
>         struct curseg_info *curseg =3D CURSEG_I(sbi, CURSEG_ALL_DATA_ATGC=
);
> +       int ret;
>
>         if (!sbi->am.atgc_enabled)
> -               return;
> +               return 0;
>
>         f2fs_down_read(&SM_I(sbi)->curseg_lock);
>
>         mutex_lock(&curseg->curseg_mutex);
>         down_write(&SIT_I(sbi)->sentry_lock);
>
> -       get_atssr_segment(sbi, CURSEG_ALL_DATA_ATGC, CURSEG_COLD_DATA, SS=
R, 0);
> +       ret =3D get_atssr_segment(sbi, CURSEG_ALL_DATA_ATGC,
> +                                       CURSEG_COLD_DATA, SSR, 0);
>
>         up_write(&SIT_I(sbi)->sentry_lock);
>         mutex_unlock(&curseg->curseg_mutex);
>
>         f2fs_up_read(&SM_I(sbi)->curseg_lock);
>
> +       return ret;
> +
>   }
> -void f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi)
> +
> +int f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi)
>   {
> -       __f2fs_init_atgc_curseg(sbi);
> +       return __f2fs_init_atgc_curseg(sbi);
>   }
>
>   static void __f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi, int type=
)
> @@ -3069,11 +3079,12 @@ static bool need_new_seg(struct f2fs_sb_info *sbi=
, int type)
>         return false;
>   }
>
> -void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type=
,
> +int f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
>                                         unsigned int start, unsigned int =
end)
>   {
>         struct curseg_info *curseg =3D CURSEG_I(sbi, type);
>         unsigned int segno;
> +       int ret =3D 0;
>
>         f2fs_down_read(&SM_I(sbi)->curseg_lock);
>         mutex_lock(&curseg->curseg_mutex);
> @@ -3084,9 +3095,9 @@ void f2fs_allocate_segment_for_resize(struct f2fs_s=
b_info *sbi, int type,
>                 goto unlock;
>
>         if (f2fs_need_SSR(sbi) && get_ssr_segment(sbi, type, SSR, 0))
> -               change_curseg(sbi, type);
> +               ret =3D change_curseg(sbi, type);
>         else
> -               new_curseg(sbi, type, true);
> +               ret =3D new_curseg(sbi, type, true);
>
>         stat_inc_seg_type(sbi, curseg);
>
> @@ -3100,6 +3111,8 @@ void f2fs_allocate_segment_for_resize(struct f2fs_s=
b_info *sbi, int type,
>
>         mutex_unlock(&curseg->curseg_mutex);
>         f2fs_up_read(&SM_I(sbi)->curseg_lock);
> +
> +       return ret;
>   }
>
>   static int __allocate_new_segment(struct f2fs_sb_info *sbi, int type,
> @@ -3107,6 +3120,7 @@ static int __allocate_new_segment(struct f2fs_sb_in=
fo *sbi, int type,
>   {
>         struct curseg_info *curseg =3D CURSEG_I(sbi, type);
>         unsigned int old_segno;
> +       int ret;
>
>         if (type =3D=3D CURSEG_COLD_DATA_PINNED && !curseg->inited)
>                 goto allocate;
> @@ -3119,8 +3133,9 @@ static int __allocate_new_segment(struct f2fs_sb_in=
fo *sbi, int type,
>
>   allocate:
>         old_segno =3D curseg->segno;
> -       if (new_curseg(sbi, type, true))
> -               return -EAGAIN;
> +       ret =3D new_curseg(sbi, type, true);
> +       if (ret)
> +               return ret;
>         stat_inc_seg_type(sbi, curseg);
>         locate_dirty_segment(sbi, old_segno);
>         return 0;
> @@ -3480,14 +3495,17 @@ int f2fs_allocate_data_block(struct f2fs_sb_info =
*sbi, struct page *page,
>         bool from_gc =3D (type =3D=3D CURSEG_ALL_DATA_ATGC);
>         struct seg_entry *se =3D NULL;
>         bool segment_full =3D false;
> +       int ret =3D 0;
>
>         f2fs_down_read(&SM_I(sbi)->curseg_lock);
>
>         mutex_lock(&curseg->curseg_mutex);
>         down_write(&sit_i->sentry_lock);
>
> -       if (curseg->segno =3D=3D NULL_SEGNO)
> +       if (curseg->segno =3D=3D NULL_SEGNO) {
> +               ret =3D -ENOSPC;
>                 goto out_err;
> +       }
>
>         if (from_gc) {
>                 f2fs_bug_on(sbi, GET_SEGNO(sbi, old_blkaddr) =3D=3D NULL_=
SEGNO);
> @@ -3541,17 +3559,17 @@ int f2fs_allocate_data_block(struct f2fs_sb_info =
*sbi, struct page *page,
>                 }
>
>                 if (from_gc) {
> -                       get_atssr_segment(sbi, type, se->type,
> +                       ret =3D get_atssr_segment(sbi, type, se->type,
>                                                 AT_SSR, se->mtime);
>                 } else {
>                         if (need_new_seg(sbi, type))
> -                               new_curseg(sbi, type, false);
> +                               ret =3D new_curseg(sbi, type, false);
>                         else
> -                               change_curseg(sbi, type);
> +                               ret =3D change_curseg(sbi, type);
>                         stat_inc_seg_type(sbi, curseg);
>                 }
>
> -               if (curseg->segno =3D=3D NULL_SEGNO)
> +               if (ret)
>                         goto out_err;
>         }
>
> @@ -3594,7 +3612,7 @@ int f2fs_allocate_data_block(struct f2fs_sb_info *s=
bi, struct page *page,
>         up_write(&sit_i->sentry_lock);
>         mutex_unlock(&curseg->curseg_mutex);
>         f2fs_up_read(&SM_I(sbi)->curseg_lock);
> -       return -ENOSPC;
> +       return ret;
>
>   }
>
> @@ -3824,7 +3842,8 @@ void f2fs_do_replace_block(struct f2fs_sb_info *sbi=
, struct f2fs_summary *sum,
>         /* change the current segment */
>         if (segno !=3D curseg->segno) {
>                 curseg->next_segno =3D segno;
> -               change_curseg(sbi, type);
> +               if (change_curseg(sbi, type))
> +                       goto out_unlock;
>         }
>
>         curseg->next_blkoff =3D GET_BLKOFF_FROM_SEG0(sbi, new_blkaddr);
> @@ -3850,12 +3869,14 @@ void f2fs_do_replace_block(struct f2fs_sb_info *s=
bi, struct f2fs_summary *sum,
>         if (recover_curseg) {
>                 if (old_cursegno !=3D curseg->segno) {
>                         curseg->next_segno =3D old_cursegno;
> -                       change_curseg(sbi, type);
> +                       if (change_curseg(sbi, type))
> +                               goto out_unlock;
>                 }
>                 curseg->next_blkoff =3D old_blkoff;
>                 curseg->alloc_type =3D old_alloc_type;
>         }
>
> +out_unlock:
>         up_write(&sit_i->sentry_lock);
>         mutex_unlock(&curseg->curseg_mutex);
>         f2fs_up_write(&SM_I(sbi)->curseg_lock);
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 0676c2dcbbf7..8c69257db8cc 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -4691,7 +4691,9 @@ static int f2fs_fill_super(struct super_block *sb, =
void *data, int silent)
>         if (err)
>                 goto free_meta;
>
> -       f2fs_init_inmem_curseg(sbi);
> +       err =3D f2fs_init_inmem_curseg(sbi);
> +       if (err)
> +               goto sync_free_meta;
>
>         /* f2fs_recover_fsync_data() cleared this already */
>         clear_sbi_flag(sbi, SBI_POR_DOING);
> --
> 2.40.1
>
>
>
> >
> > thanks!
> >>
> >> Thanks,
> >>
> >>>
> >>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> >>> ---
> >>>    fs/f2fs/f2fs.h    | 2 +-
> >>>    fs/f2fs/gc.c      | 7 +++++--
> >>>    fs/f2fs/segment.c | 9 +++++++--
> >>>    3 files changed, 13 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> >>> index 4331012..39dda7d 100644
> >>> --- a/fs/f2fs/f2fs.h
> >>> +++ b/fs/f2fs/f2fs.h
> >>> @@ -3701,7 +3701,7 @@ void f2fs_clear_prefree_segments(struct f2fs_sb=
_info *sbi,
> >>>    void f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi);
> >>>    void f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi);
> >>>    void f2fs_restore_inmem_curseg(struct f2fs_sb_info *sbi);
> >>> -void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int =
type,
> >>> +int f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int t=
ype,
> >>>                                        unsigned int start, unsigned i=
nt end);
> >>>    int f2fs_allocate_new_section(struct f2fs_sb_info *sbi, int type, =
bool force);
> >>>    int f2fs_allocate_pinning_section(struct f2fs_sb_info *sbi);
> >>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> >>> index c60b747..7a458fa 100644
> >>> --- a/fs/f2fs/gc.c
> >>> +++ b/fs/f2fs/gc.c
> >>> @@ -2037,8 +2037,11 @@ static int free_segment_range(struct f2fs_sb_i=
nfo *sbi,
> >>>        mutex_unlock(&DIRTY_I(sbi)->seglist_lock);
> >>>
> >>>        /* Move out cursegs from the target range */
> >>> -     for (type =3D CURSEG_HOT_DATA; type < NR_CURSEG_PERSIST_TYPE; t=
ype++)
> >>> -             f2fs_allocate_segment_for_resize(sbi, type, start, end)=
;
> >>> +     for (type =3D CURSEG_HOT_DATA; type < NR_CURSEG_PERSIST_TYPE; t=
ype++) {
> >>> +             err =3D f2fs_allocate_segment_for_resize(sbi, type, sta=
rt, end);
> >>> +             if (err)
> >>> +                     goto out;
> >>> +     }
> >>>
> >>>        /* do GC to move out valid blocks in the range */
> >>>        err =3D f2fs_gc_range(sbi, start, end, dry_run, 0);
> >>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> >>> index 1bb3019..2a07b9d 100644
> >>> --- a/fs/f2fs/segment.c
> >>> +++ b/fs/f2fs/segment.c
> >>> @@ -3071,11 +3071,12 @@ static bool need_new_seg(struct f2fs_sb_info =
*sbi, int type)
> >>>        return false;
> >>>    }
> >>>
> >>> -void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int =
type,
> >>> +int f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int t=
ype,
> >>>                                        unsigned int start, unsigned i=
nt end)
> >>>    {
> >>>        struct curseg_info *curseg =3D CURSEG_I(sbi, type);
> >>>        unsigned int segno;
> >>> +     int err =3D 0;
> >>>
> >>>        f2fs_down_read(&SM_I(sbi)->curseg_lock);
> >>>        mutex_lock(&curseg->curseg_mutex);
> >>> @@ -3089,7 +3090,10 @@ void f2fs_allocate_segment_for_resize(struct f=
2fs_sb_info *sbi, int type,
> >>>                change_curseg(sbi, type);
> >>>        else
> >>>                new_curseg(sbi, type, true);
> >>> -
> >>> +     if (curseg->segno =3D=3D NULL_SEGNO) {
> >>> +             err =3D -ENOSPC;
> >>> +             goto unlock;
> >>> +     }
> >>>        stat_inc_seg_type(sbi, curseg);
> >>>
> >>>        locate_dirty_segment(sbi, segno);
> >>> @@ -3102,6 +3106,7 @@ void f2fs_allocate_segment_for_resize(struct f2=
fs_sb_info *sbi, int type,
> >>>
> >>>        mutex_unlock(&curseg->curseg_mutex);
> >>>        f2fs_up_read(&SM_I(sbi)->curseg_lock);
> >>> +     return err;
> >>>    }
> >>>
> >>>    static int __allocate_new_segment(struct f2fs_sb_info *sbi, int ty=
pe,

