Return-Path: <linux-kernel+bounces-57289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFED084D674
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 00:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 860DC2887B9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596F11EB5D;
	Wed,  7 Feb 2024 23:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O44s0QGU"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8C21D557
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 23:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707346882; cv=none; b=IO4hMZRZ24HKuX2KAVwNG3uS2YvNCO/vCa2pdoC/dSZ64BQnHkZd7Mpm3Pjmdl2DnOeNU24QlSkBIe2XL62aziV2MsH5oB3KRvad/K3mYFy4xEXRpA2LFA27v74Szb66qnBDg3ZehJITRVPTzIgVT6ko3oIjN4X1aafOtaa+GSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707346882; c=relaxed/simple;
	bh=1Cqpk/Frqupt692URrmR1FW5LzkkYT3f3K0j2gDQvf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=egyya3tlaWr1JuCch/ty1K48FpL02B23EXNXWYZTX+d35vVfs1cQudrhVUAZJ3HFAxpFvF/Tjmalz1R971Sqs3wLp9fInQpT3M3TJEor5n9X/bMwsSr4LCnyHEe409JtaKw1NbwlJIdoSGcTQ9P7hZBZuGWEvsu+sYQkQAVS0t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O44s0QGU; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6049fc02a19so5243217b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 15:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707346879; x=1707951679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZKEya9b+S/kZV2MwgCPlNpigzo9kr0iVNksdMGag7s=;
        b=O44s0QGUSgapi4xr8rXUnnBmqsztu8ag4APtkWPaxAZ+WEe0l3541FK8aSqcziJwUH
         MNmfmG8/tbNKS6wllYredxMMeaD9sQvx36NJ2jfFCq1YR0uoXe0ZPJPb4A5kHSev6Gyz
         u8B9iSsclOH56IV4+/SMM514gqUVcJlL4YpzR91bW3Zq0e6QM+hso7v/FhHa001IHTJT
         PeC9BjzkcLGUx+ah5YRFDGcNLBX8xlCStmKE0mRG4//UDWz7pfocSFL7523BVnwWxmkA
         F3h+Z3C4WK+Slbcr2/rfeRb69RXk6tpYh5S93b5/gIxxm1iAzRxIm0SurVbL1VrPmueK
         lhqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707346879; x=1707951679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ZKEya9b+S/kZV2MwgCPlNpigzo9kr0iVNksdMGag7s=;
        b=SZbB0APv+v0nJ2t4tsgpRmfFDY2OvGOCC1G/sHhrjiSwwzmWulM8fk2MOFJxXg72Lk
         OdjVnpmRURdoRprnoT96ZV6VVUsKTWiDLEBV0aK66qGFH5mgvz5wd4LoG5EnWFUSp3Pn
         Vn/dt35n9eXs1I13rDp2nbhRPm+57Kthl4AEoMH3c0qO+IEr+TmgS9puHc9/3c/VKKEG
         Nvl+1GgV0R3+qi1ItE8acdDpqbBZXZtxoCK8yEx4JfcXBvvjPNYQocunlWDoaNjNpCU1
         +eHaEmjKbGiiYQZJHm3eNQwzT0XY3kv3gZPHV2Rff93Kx77lQfG7M/IPkeS6uJ4BGm50
         uEFg==
X-Gm-Message-State: AOJu0YyC15hf6dxBCUvSSxuDpvBiOWqyusu1rUpJMC3/DPTb/RDOVAj7
	fc1udaBEKzxQUrr0Mgn08FdmXMDBZDb+WdzQD/WVjwuiEni0mNsxxw7SXtAIySw3WPxerbxPy9c
	8bSZ0Anj7aq2VQnUwZKhHJjanTj6LaAID3uk=
X-Google-Smtp-Source: AGHT+IFklIY8FgJ9hp3dfnq8SkA60Fv2n7yEhO1oyrM8ji7dAF0c2JfLDkWD562ndbgUQ5dBgdeR1r0EmuLJzlXjNF0=
X-Received: by 2002:a81:d54a:0:b0:603:fdc7:2f93 with SMTP id
 l10-20020a81d54a000000b00603fdc72f93mr6529960ywj.33.1707346878961; Wed, 07
 Feb 2024 15:01:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207164620.1536038-1-jaegeuk@kernel.org>
In-Reply-To: <20240207164620.1536038-1-jaegeuk@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Wed, 7 Feb 2024 15:01:07 -0800
Message-ID: <CACOAw_y8CdM2RN79dW26bXUpd_YYs2UQ+Kw5BkDhwTB8yWFMQw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: kill heap-based allocation
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Daeho Jeong <daehojeong@google.com>

On Wed, Feb 7, 2024 at 8:50=E2=80=AFAM Jaegeuk Kim <jaegeuk@kernel.org> wro=
te:
>
> No one uses this feature. Let's kill it.
>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  Documentation/filesystems/f2fs.rst |  3 --
>  fs/f2fs/f2fs.h                     | 51 ++++++++++++++--------------
>  fs/f2fs/gc.c                       |  5 ++-
>  fs/f2fs/segment.c                  | 54 ++++--------------------------
>  fs/f2fs/segment.h                  | 10 ------
>  fs/f2fs/super.c                    | 15 ---------
>  6 files changed, 34 insertions(+), 104 deletions(-)
>
> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesyste=
ms/f2fs.rst
> index 9ac5083dae8e..1ff751009c43 100644
> --- a/Documentation/filesystems/f2fs.rst
> +++ b/Documentation/filesystems/f2fs.rst
> @@ -126,9 +126,6 @@ norecovery           Disable the roll-forward recover=
y routine, mounted read-
>  discard/nodiscard       Enable/disable real-time discard in f2fs, if dis=
card is
>                          enabled, f2fs will issue discard/TRIM commands w=
hen a
>                          segment is cleaned.
> -no_heap                         Disable heap-style segment allocation wh=
ich finds free
> -                        segments for data from the beginning of main are=
a, while
> -                        for node from the end of main area.
>  nouser_xattr            Disable Extended User Attributes. Note: xattr is=
 enabled
>                          by default if CONFIG_F2FS_FS_XATTR is selected.
>  noacl                   Disable POSIX Access Control List. Note: acl is =
enabled
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 34d718301392..40eb590ed646 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -88,32 +88,31 @@ extern const char *f2fs_fault_name[FAULT_MAX];
>   */
>  #define F2FS_MOUNT_DISABLE_ROLL_FORWARD        0x00000001
>  #define F2FS_MOUNT_DISCARD             0x00000002
> -#define F2FS_MOUNT_NOHEAP              0x00000004
> -#define F2FS_MOUNT_XATTR_USER          0x00000008
> -#define F2FS_MOUNT_POSIX_ACL           0x00000010
> -#define F2FS_MOUNT_DISABLE_EXT_IDENTIFY        0x00000020
> -#define F2FS_MOUNT_INLINE_XATTR                0x00000040
> -#define F2FS_MOUNT_INLINE_DATA         0x00000080
> -#define F2FS_MOUNT_INLINE_DENTRY       0x00000100
> -#define F2FS_MOUNT_FLUSH_MERGE         0x00000200
> -#define F2FS_MOUNT_NOBARRIER           0x00000400
> -#define F2FS_MOUNT_FASTBOOT            0x00000800
> -#define F2FS_MOUNT_READ_EXTENT_CACHE   0x00001000
> -#define F2FS_MOUNT_DATA_FLUSH          0x00002000
> -#define F2FS_MOUNT_FAULT_INJECTION     0x00004000
> -#define F2FS_MOUNT_USRQUOTA            0x00008000
> -#define F2FS_MOUNT_GRPQUOTA            0x00010000
> -#define F2FS_MOUNT_PRJQUOTA            0x00020000
> -#define F2FS_MOUNT_QUOTA               0x00040000
> -#define F2FS_MOUNT_INLINE_XATTR_SIZE   0x00080000
> -#define F2FS_MOUNT_RESERVE_ROOT                0x00100000
> -#define F2FS_MOUNT_DISABLE_CHECKPOINT  0x00200000
> -#define F2FS_MOUNT_NORECOVERY          0x00400000
> -#define F2FS_MOUNT_ATGC                        0x00800000
> -#define F2FS_MOUNT_MERGE_CHECKPOINT    0x01000000
> -#define        F2FS_MOUNT_GC_MERGE             0x02000000
> -#define F2FS_MOUNT_COMPRESS_CACHE      0x04000000
> -#define F2FS_MOUNT_AGE_EXTENT_CACHE    0x08000000
> +#define F2FS_MOUNT_XATTR_USER          0x00000004
> +#define F2FS_MOUNT_POSIX_ACL           0x00000008
> +#define F2FS_MOUNT_DISABLE_EXT_IDENTIFY        0x00000010
> +#define F2FS_MOUNT_INLINE_XATTR                0x00000020
> +#define F2FS_MOUNT_INLINE_DATA         0x00000040
> +#define F2FS_MOUNT_INLINE_DENTRY       0x00000080
> +#define F2FS_MOUNT_FLUSH_MERGE         0x00000100
> +#define F2FS_MOUNT_NOBARRIER           0x00000200
> +#define F2FS_MOUNT_FASTBOOT            0x00000400
> +#define F2FS_MOUNT_READ_EXTENT_CACHE   0x00000800
> +#define F2FS_MOUNT_DATA_FLUSH          0x00001000
> +#define F2FS_MOUNT_FAULT_INJECTION     0x00002000
> +#define F2FS_MOUNT_USRQUOTA            0x00004000
> +#define F2FS_MOUNT_GRPQUOTA            0x00008000
> +#define F2FS_MOUNT_PRJQUOTA            0x00010000
> +#define F2FS_MOUNT_QUOTA               0x00020000
> +#define F2FS_MOUNT_INLINE_XATTR_SIZE   0x00040000
> +#define F2FS_MOUNT_RESERVE_ROOT                0x00080000
> +#define F2FS_MOUNT_DISABLE_CHECKPOINT  0x00100000
> +#define F2FS_MOUNT_NORECOVERY          0x00200000
> +#define F2FS_MOUNT_ATGC                        0x00400000
> +#define F2FS_MOUNT_MERGE_CHECKPOINT    0x00800000
> +#define        F2FS_MOUNT_GC_MERGE             0x01000000
> +#define F2FS_MOUNT_COMPRESS_CACHE      0x02000000
> +#define F2FS_MOUNT_AGE_EXTENT_CACHE    0x04000000
>
>  #define F2FS_OPTION(sbi)       ((sbi)->mount_opt)
>  #define clear_opt(sbi, option) (F2FS_OPTION(sbi).opt &=3D ~F2FS_MOUNT_##=
option)
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 0a1a50b68df8..8a9cdc5a72c5 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -280,12 +280,11 @@ static void select_policy(struct f2fs_sb_info *sbi,=
 int gc_type,
>                         p->max_search > sbi->max_victim_search)
>                 p->max_search =3D sbi->max_victim_search;
>
> -       /* let's select beginning hot/small space first in no_heap mode*/
> +       /* let's select beginning hot/small space first. */
>         if (f2fs_need_rand_seg(sbi))
>                 p->offset =3D get_random_u32_below(MAIN_SECS(sbi) *
>                                                 SEGS_PER_SEC(sbi));
> -       else if (test_opt(sbi, NOHEAP) &&
> -               (type =3D=3D CURSEG_HOT_DATA || IS_NODESEG(type)))
> +       else if (type =3D=3D CURSEG_HOT_DATA || IS_NODESEG(type))
>                 p->offset =3D 0;
>         else
>                 p->offset =3D SIT_I(sbi)->last_victim[p->gc_mode];
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 1013276ad12a..4e985750c938 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2632,16 +2632,14 @@ static int is_next_segment_free(struct f2fs_sb_in=
fo *sbi,
>   * This function should be returned with success, otherwise BUG
>   */
>  static void get_new_segment(struct f2fs_sb_info *sbi,
> -                       unsigned int *newseg, bool new_sec, int dir)
> +                       unsigned int *newseg, bool new_sec)
>  {
>         struct free_segmap_info *free_i =3D FREE_I(sbi);
>         unsigned int segno, secno, zoneno;
>         unsigned int total_zones =3D MAIN_SECS(sbi) / sbi->secs_per_zone;
>         unsigned int hint =3D GET_SEC_FROM_SEG(sbi, *newseg);
>         unsigned int old_zoneno =3D GET_ZONE_FROM_SEG(sbi, *newseg);
> -       unsigned int left_start =3D hint;
>         bool init =3D true;
> -       int go_left =3D 0;
>         int i;
>
>         spin_lock(&free_i->segmap_lock);
> @@ -2655,30 +2653,10 @@ static void get_new_segment(struct f2fs_sb_info *=
sbi,
>  find_other_zone:
>         secno =3D find_next_zero_bit(free_i->free_secmap, MAIN_SECS(sbi),=
 hint);
>         if (secno >=3D MAIN_SECS(sbi)) {
> -               if (dir =3D=3D ALLOC_RIGHT) {
> -                       secno =3D find_first_zero_bit(free_i->free_secmap=
,
> +               secno =3D find_first_zero_bit(free_i->free_secmap,
>                                                         MAIN_SECS(sbi));
> -                       f2fs_bug_on(sbi, secno >=3D MAIN_SECS(sbi));
> -               } else {
> -                       go_left =3D 1;
> -                       left_start =3D hint - 1;
> -               }
> -       }
> -       if (go_left =3D=3D 0)
> -               goto skip_left;
> -
> -       while (test_bit(left_start, free_i->free_secmap)) {
> -               if (left_start > 0) {
> -                       left_start--;
> -                       continue;
> -               }
> -               left_start =3D find_first_zero_bit(free_i->free_secmap,
> -                                                       MAIN_SECS(sbi));
> -               f2fs_bug_on(sbi, left_start >=3D MAIN_SECS(sbi));
> -               break;
> +               f2fs_bug_on(sbi, secno >=3D MAIN_SECS(sbi));
>         }
> -       secno =3D left_start;
> -skip_left:
>         segno =3D GET_SEG_FROM_SEC(sbi, secno);
>         zoneno =3D GET_ZONE_FROM_SEC(sbi, secno);
>
> @@ -2689,21 +2667,13 @@ static void get_new_segment(struct f2fs_sb_info *=
sbi,
>                 goto got_it;
>         if (zoneno =3D=3D old_zoneno)
>                 goto got_it;
> -       if (dir =3D=3D ALLOC_LEFT) {
> -               if (!go_left && zoneno + 1 >=3D total_zones)
> -                       goto got_it;
> -               if (go_left && zoneno =3D=3D 0)
> -                       goto got_it;
> -       }
>         for (i =3D 0; i < NR_CURSEG_TYPE; i++)
>                 if (CURSEG_I(sbi, i)->zone =3D=3D zoneno)
>                         break;
>
>         if (i < NR_CURSEG_TYPE) {
>                 /* zone is in user, try another */
> -               if (go_left)
> -                       hint =3D zoneno * sbi->secs_per_zone - 1;
> -               else if (zoneno + 1 >=3D total_zones)
> +               if (zoneno + 1 >=3D total_zones)
>                         hint =3D 0;
>                 else
>                         hint =3D (zoneno + 1) * sbi->secs_per_zone;
> @@ -2762,8 +2732,7 @@ static unsigned int __get_next_segno(struct f2fs_sb=
_info *sbi, int type)
>         if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
>                 return 0;
>
> -       if (test_opt(sbi, NOHEAP) &&
> -               (seg_type =3D=3D CURSEG_HOT_DATA || IS_NODESEG(seg_type))=
)
> +       if (seg_type =3D=3D CURSEG_HOT_DATA || IS_NODESEG(seg_type))
>                 return 0;
>
>         if (SIT_I(sbi)->last_victim[ALLOC_NEXT])
> @@ -2783,21 +2752,12 @@ static unsigned int __get_next_segno(struct f2fs_=
sb_info *sbi, int type)
>  static void new_curseg(struct f2fs_sb_info *sbi, int type, bool new_sec)
>  {
>         struct curseg_info *curseg =3D CURSEG_I(sbi, type);
> -       unsigned short seg_type =3D curseg->seg_type;
>         unsigned int segno =3D curseg->segno;
> -       int dir =3D ALLOC_LEFT;
>
>         if (curseg->inited)
> -               write_sum_page(sbi, curseg->sum_blk,
> -                               GET_SUM_BLOCK(sbi, segno));
> -       if (seg_type =3D=3D CURSEG_WARM_DATA || seg_type =3D=3D CURSEG_CO=
LD_DATA)
> -               dir =3D ALLOC_RIGHT;
> -
> -       if (test_opt(sbi, NOHEAP))
> -               dir =3D ALLOC_RIGHT;
> -
> +               write_sum_page(sbi, curseg->sum_blk, GET_SUM_BLOCK(sbi, s=
egno));
>         segno =3D __get_next_segno(sbi, type);
> -       get_new_segment(sbi, &segno, new_sec, dir);
> +       get_new_segment(sbi, &segno, new_sec);
>         curseg->next_segno =3D segno;
>         reset_curseg(sbi, type, 1);
>         curseg->alloc_type =3D LFS;
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index b725ae1a7043..60d93a16f2ac 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -130,16 +130,6 @@ static inline void sanity_check_seg_type(struct f2fs=
_sb_info *sbi,
>  #define SECTOR_TO_BLOCK(sectors)                                       \
>         ((sectors) >> F2FS_LOG_SECTORS_PER_BLOCK)
>
> -/*
> - * indicate a block allocation direction: RIGHT and LEFT.
> - * RIGHT means allocating new sections towards the end of volume.
> - * LEFT means the opposite direction.
> - */
> -enum {
> -       ALLOC_RIGHT =3D 0,
> -       ALLOC_LEFT
> -};
> -
>  /*
>   * In the victim_sel_policy->alloc_mode, there are three block allocatio=
n modes.
>   * LFS writes data sequentially with cleaning operations.
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 3fb44afd0cd1..c04c0d21705f 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -111,8 +111,6 @@ enum {
>         Opt_norecovery,
>         Opt_discard,
>         Opt_nodiscard,
> -       Opt_noheap,
> -       Opt_heap,
>         Opt_user_xattr,
>         Opt_nouser_xattr,
>         Opt_acl,
> @@ -189,8 +187,6 @@ static match_table_t f2fs_tokens =3D {
>         {Opt_norecovery, "norecovery"},
>         {Opt_discard, "discard"},
>         {Opt_nodiscard, "nodiscard"},
> -       {Opt_noheap, "no_heap"},
> -       {Opt_heap, "heap"},
>         {Opt_user_xattr, "user_xattr"},
>         {Opt_nouser_xattr, "nouser_xattr"},
>         {Opt_acl, "acl"},
> @@ -726,12 +722,6 @@ static int parse_options(struct super_block *sb, cha=
r *options, bool is_remount)
>                         }
>                         clear_opt(sbi, DISCARD);
>                         break;
> -               case Opt_noheap:
> -                       set_opt(sbi, NOHEAP);
> -                       break;
> -               case Opt_heap:
> -                       clear_opt(sbi, NOHEAP);
> -                       break;
>  #ifdef CONFIG_F2FS_FS_XATTR
>                 case Opt_user_xattr:
>                         set_opt(sbi, XATTR_USER);
> @@ -1956,10 +1946,6 @@ static int f2fs_show_options(struct seq_file *seq,=
 struct dentry *root)
>         } else {
>                 seq_puts(seq, ",nodiscard");
>         }
> -       if (test_opt(sbi, NOHEAP))
> -               seq_puts(seq, ",no_heap");
> -       else
> -               seq_puts(seq, ",heap");
>  #ifdef CONFIG_F2FS_FS_XATTR
>         if (test_opt(sbi, XATTR_USER))
>                 seq_puts(seq, ",user_xattr");
> @@ -2136,7 +2122,6 @@ static void default_options(struct f2fs_sb_info *sb=
i, bool remount)
>         set_opt(sbi, INLINE_XATTR);
>         set_opt(sbi, INLINE_DATA);
>         set_opt(sbi, INLINE_DENTRY);
> -       set_opt(sbi, NOHEAP);
>         set_opt(sbi, MERGE_CHECKPOINT);
>         F2FS_OPTION(sbi).unusable_cap =3D 0;
>         sbi->sb->s_flags |=3D SB_LAZYTIME;
> --
> 2.43.0.594.gd9cf4e227d-goog
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

