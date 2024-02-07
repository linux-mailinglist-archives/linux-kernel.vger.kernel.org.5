Return-Path: <linux-kernel+bounces-57304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5449D84D6C9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 00:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 838D6B20CD7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AF820325;
	Wed,  7 Feb 2024 23:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEXyldxs"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D15535AB
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 23:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707349911; cv=none; b=P5VbZs6fIB8GeyGsGXkvEPcDFr4orRbINCOYwHxTBjh1yN+75VV7QV6aX4UjHeDMQjbNKBZ31y+rXZ3kcaNiQhwDCFFp/vCcnqZ8ioEMnc7JpltwRS1g8xD1IX9IweXQ2WyPh9MZA48kQ5Zpt11fX9StIE4MiNQ+ZSqc3EDatiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707349911; c=relaxed/simple;
	bh=m0VsVIZaQqwr4CFJ7CPkPQYMmDHGJ+sMbiePaST/Pxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lpu8qe/m/uNH0+yqQRO83WyPDz7SmMmUrrPyVdnDjG7CRD49Eub0H0M74CEB0iBa3BngeOm7SsaG57+eplEhuHCoOwdOAEUuQGLv4aJBguD4dJWlqHbSMXRCNOPefIMtce2wZad0M/YxQ5Yfvt0mojyAgDXzkQ30Gizu1K90uPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEXyldxs; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4c02779e68cso423214e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 15:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707349907; x=1707954707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANZ0zc1aFSyIuIePtuKB1dq4Pb5ykQDU68xmm5dP0Dk=;
        b=aEXyldxsIF7zjz2VRDH5HHwscbRaP97tvyaQsurWWiZik7m8OYfVR/9KWPdmNzZazs
         g0NSGM4GQaCq2//u+5pqIGJDIjPZslUjQxwVbsH+3GLdMO029wko19bSmYQED+2RIMZA
         he5+XdSwYBGnFx33dcqqozDluprPnCDifVfFvNWthEEewemeVNOoUGamhJGIOLItRnqr
         3HexrAjTpjcjp00G1m9DnksOTmwgxltjJvmqB2fmT1e3oe+D8EdURP6mbxzX9nqK68MK
         4qbQlOG5JOLsCqaTU9EXvPN9XwN8R7SaTPELeQ0O4pRbWwQi+J5ASnz8+oDwX+NHH96J
         Z96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707349907; x=1707954707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ANZ0zc1aFSyIuIePtuKB1dq4Pb5ykQDU68xmm5dP0Dk=;
        b=N4khM7XqUSP3CQQMmPGwlU37mgKOzqwvABd88rkz5+sNPQuuNk8xUKDgK8O1LmadUq
         0u+0U206+YOTsMf4HkflNe36NgSb0lVO1lnRMRSl+OrTNVtmpaGolIeiNqh87G0RcZ2Y
         nlgWvBSVOz9rEw6c+8zQcMhj81Fv0p0W7SoV+lLRSmqJBr49XOit2r36Ro/xqm+EMHFB
         1uiiPAtvPf4kwJIq+/nOani/XXpVrZ7rsWBN6wdI+2Im4wX7k15WGNYEA1bSRH/gTmsV
         bTSfzEd8QZ3t6/PtTMIxAaEOcyNdjz+7VsPNwIgtQ1BVmC6+2cgBoH8Xo2oCOOlS56r8
         pf5Q==
X-Gm-Message-State: AOJu0YyyfRh9TklF2CAaBxbRNwHI9opoT4Iv1/6zI2o4nbwMFrfbDig1
	EUFoC6iSjlqMzTogApigMH4MHwAPiDdV0UOtBGCFdsCsRzTdg1uRUeiXGvRNJgfEqKiYLU4fKR/
	5g8w+6xHx0Dq2tFRYy7wQOB7tIW+xuvyy830=
X-Google-Smtp-Source: AGHT+IEHMyMTVOn+j+rQo7f0A0QE+QLyiNgu1emg6CAJoO7LdryoYzVQVnCAOBLPThw3SIq/z7Ip+DP2z5tZL2UosEo=
X-Received: by 2002:a05:6122:390b:b0:4c0:2036:7899 with SMTP id
 ep11-20020a056122390b00b004c020367899mr4597293vkb.4.1707349906968; Wed, 07
 Feb 2024 15:51:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207005105.3744811-1-jaegeuk@kernel.org> <20240207005105.3744811-2-jaegeuk@kernel.org>
In-Reply-To: <20240207005105.3744811-2-jaegeuk@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Wed, 7 Feb 2024 15:51:35 -0800
Message-ID: <CACOAw_x9NvuGo3AjB5ckLsDwJ+LJaDdFefE=k+6pNeNBvkXY=A@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH 2/3] f2fs: use BLKS_PER_SEG, BLKS_PER_SEC, and SEGS_PER_SEC
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Daeho Jeong <daehojeong@google.com>

On Tue, Feb 6, 2024 at 4:55=E2=80=AFPM Jaegeuk Kim <jaegeuk@kernel.org> wro=
te:
>
> No functional change.
>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/checkpoint.c |  10 ++--
>  fs/f2fs/debug.c      |   6 +--
>  fs/f2fs/f2fs.h       |  19 +++++---
>  fs/f2fs/file.c       |  12 ++---
>  fs/f2fs/gc.c         |  40 ++++++++--------
>  fs/f2fs/node.c       |   4 +-
>  fs/f2fs/node.h       |   4 +-
>  fs/f2fs/recovery.c   |   2 +-
>  fs/f2fs/segment.c    | 109 +++++++++++++++++++++----------------------
>  fs/f2fs/segment.h    |  18 ++++---
>  fs/f2fs/super.c      |   8 ++--
>  fs/f2fs/sysfs.c      |   6 +--
>  12 files changed, 119 insertions(+), 119 deletions(-)
>
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index b85820e70f5e..a09a9609e228 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -900,7 +900,7 @@ static struct page *validate_checkpoint(struct f2fs_s=
b_info *sbi,
>
>         cp_blocks =3D le32_to_cpu(cp_block->cp_pack_total_block_count);
>
> -       if (cp_blocks > sbi->blocks_per_seg || cp_blocks <=3D F2FS_CP_PAC=
KS) {
> +       if (cp_blocks > BLKS_PER_SEG(sbi) || cp_blocks <=3D F2FS_CP_PACKS=
) {
>                 f2fs_warn(sbi, "invalid cp_pack_total_block_count:%u",
>                           le32_to_cpu(cp_block->cp_pack_total_block_count=
));
>                 goto invalid_cp;
> @@ -1335,7 +1335,7 @@ static void update_ckpt_flags(struct f2fs_sb_info *=
sbi, struct cp_control *cpc)
>
>         if (cpc->reason & CP_UMOUNT) {
>                 if (le32_to_cpu(ckpt->cp_pack_total_block_count) +
> -                       NM_I(sbi)->nat_bits_blocks > sbi->blocks_per_seg)=
 {
> +                       NM_I(sbi)->nat_bits_blocks > BLKS_PER_SEG(sbi)) {
>                         clear_ckpt_flags(sbi, CP_NAT_BITS_FLAG);
>                         f2fs_notice(sbi, "Disable nat_bits due to no spac=
e");
>                 } else if (!is_set_ckpt_flags(sbi, CP_NAT_BITS_FLAG) &&
> @@ -1538,7 +1538,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, =
struct cp_control *cpc)
>                 cp_ver |=3D ((__u64)crc32 << 32);
>                 *(__le64 *)nm_i->nat_bits =3D cpu_to_le64(cp_ver);
>
> -               blk =3D start_blk + sbi->blocks_per_seg - nm_i->nat_bits_=
blocks;
> +               blk =3D start_blk + BLKS_PER_SEG(sbi) - nm_i->nat_bits_bl=
ocks;
>                 for (i =3D 0; i < nm_i->nat_bits_blocks; i++)
>                         f2fs_update_meta_page(sbi, nm_i->nat_bits +
>                                         (i << F2FS_BLKSIZE_BITS), blk + i=
);
> @@ -1741,9 +1741,9 @@ void f2fs_init_ino_entry_info(struct f2fs_sb_info *=
sbi)
>                 im->ino_num =3D 0;
>         }
>
> -       sbi->max_orphans =3D (sbi->blocks_per_seg - F2FS_CP_PACKS -
> +       sbi->max_orphans =3D (BLKS_PER_SEG(sbi) - F2FS_CP_PACKS -
>                         NR_CURSEG_PERSIST_TYPE - __cp_payload(sbi)) *
> -                               F2FS_ORPHANS_PER_BLOCK;
> +                       F2FS_ORPHANS_PER_BLOCK;
>  }
>
>  int __init f2fs_create_checkpoint_caches(void)
> diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
> index fdbf994f1271..0d02224b99b7 100644
> --- a/fs/f2fs/debug.c
> +++ b/fs/f2fs/debug.c
> @@ -41,7 +41,7 @@ void f2fs_update_sit_info(struct f2fs_sb_info *sbi)
>         total_vblocks =3D 0;
>         blks_per_sec =3D CAP_BLKS_PER_SEC(sbi);
>         hblks_per_sec =3D blks_per_sec / 2;
> -       for (segno =3D 0; segno < MAIN_SEGS(sbi); segno +=3D sbi->segs_pe=
r_sec) {
> +       for (segno =3D 0; segno < MAIN_SEGS(sbi); segno +=3D SEGS_PER_SEC=
(sbi)) {
>                 vblocks =3D get_valid_blocks(sbi, segno, true);
>                 dist =3D abs(vblocks - hblks_per_sec);
>                 bimodal +=3D dist * dist;
> @@ -135,7 +135,7 @@ static void update_general_status(struct f2fs_sb_info=
 *sbi)
>         si->cur_ckpt_time =3D sbi->cprc_info.cur_time;
>         si->peak_ckpt_time =3D sbi->cprc_info.peak_time;
>         spin_unlock(&sbi->cprc_info.stat_lock);
> -       si->total_count =3D (int)sbi->user_block_count / sbi->blocks_per_=
seg;
> +       si->total_count =3D (int)sbi->user_block_count / BLKS_PER_SEG(sbi=
);
>         si->rsvd_segs =3D reserved_segments(sbi);
>         si->overp_segs =3D overprovision_segments(sbi);
>         si->valid_count =3D valid_user_blocks(sbi);
> @@ -208,7 +208,7 @@ static void update_general_status(struct f2fs_sb_info=
 *sbi)
>                 if (!blks)
>                         continue;
>
> -               if (blks =3D=3D sbi->blocks_per_seg)
> +               if (blks =3D=3D BLKS_PER_SEG(sbi))
>                         si->full_seg[type]++;
>                 else
>                         si->dirty_seg[type]++;
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 4c52136cbc10..9a9e858083af 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1813,6 +1813,14 @@ struct f2fs_sb_info {
>  #endif
>  };
>
> +/* Definitions to access f2fs_sb_info */
> +#define BLKS_PER_SEG(sbi)                                      \
> +       ((sbi)->blocks_per_seg)
> +#define BLKS_PER_SEC(sbi)                                      \
> +       ((sbi)->segs_per_sec << (sbi)->log_blocks_per_seg)
> +#define SEGS_PER_SEC(sbi)                                      \
> +       ((sbi)->segs_per_sec)
> +
>  __printf(3, 4)
>  void f2fs_printk(struct f2fs_sb_info *sbi, bool limit_rate, const char *=
fmt, ...);
>
> @@ -2511,11 +2519,8 @@ static inline int get_dirty_pages(struct inode *in=
ode)
>
>  static inline int get_blocktype_secs(struct f2fs_sb_info *sbi, int block=
_type)
>  {
> -       unsigned int pages_per_sec =3D sbi->segs_per_sec * sbi->blocks_pe=
r_seg;
> -       unsigned int segs =3D (get_pages(sbi, block_type) + pages_per_sec=
 - 1) >>
> -                                               sbi->log_blocks_per_seg;
> -
> -       return segs / sbi->segs_per_sec;
> +       return (get_pages(sbi, block_type) + BLKS_PER_SEC(sbi) - 1) /
> +                                                       BLKS_PER_SEC(sbi)=
;
>  }
>
>  static inline block_t valid_user_blocks(struct f2fs_sb_info *sbi)
> @@ -2579,7 +2584,7 @@ static inline block_t __start_cp_addr(struct f2fs_s=
b_info *sbi)
>         block_t start_addr =3D le32_to_cpu(F2FS_RAW_SUPER(sbi)->cp_blkadd=
r);
>
>         if (sbi->cur_cp_pack =3D=3D 2)
> -               start_addr +=3D sbi->blocks_per_seg;
> +               start_addr +=3D BLKS_PER_SEG(sbi);
>         return start_addr;
>  }
>
> @@ -2588,7 +2593,7 @@ static inline block_t __start_cp_next_addr(struct f=
2fs_sb_info *sbi)
>         block_t start_addr =3D le32_to_cpu(F2FS_RAW_SUPER(sbi)->cp_blkadd=
r);
>
>         if (sbi->cur_cp_pack =3D=3D 1)
> -               start_addr +=3D sbi->blocks_per_seg;
> +               start_addr +=3D BLKS_PER_SEG(sbi);
>         return start_addr;
>  }
>
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index c6cd9474ba2d..b0be576b2090 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2580,7 +2580,6 @@ static int f2fs_defragment_range(struct f2fs_sb_inf=
o *sbi,
>                                         .m_may_create =3D false };
>         struct extent_info ei =3D {};
>         pgoff_t pg_start, pg_end, next_pgofs;
> -       unsigned int blk_per_seg =3D sbi->blocks_per_seg;
>         unsigned int total =3D 0, sec_num;
>         block_t blk_end =3D 0;
>         bool fragmented =3D false;
> @@ -2689,7 +2688,8 @@ static int f2fs_defragment_range(struct f2fs_sb_inf=
o *sbi,
>                 set_inode_flag(inode, FI_SKIP_WRITES);
>
>                 idx =3D map.m_lblk;
> -               while (idx < map.m_lblk + map.m_len && cnt < blk_per_seg)=
 {
> +               while (idx < map.m_lblk + map.m_len &&
> +                                               cnt < BLKS_PER_SEG(sbi)) =
{
>                         struct page *page;
>
>                         page =3D f2fs_get_lock_data_page(inode, idx, true=
);
> @@ -2709,7 +2709,7 @@ static int f2fs_defragment_range(struct f2fs_sb_inf=
o *sbi,
>
>                 map.m_lblk =3D idx;
>  check:
> -               if (map.m_lblk < pg_end && cnt < blk_per_seg)
> +               if (map.m_lblk < pg_end && cnt < BLKS_PER_SEG(sbi))
>                         goto do_map;
>
>                 clear_inode_flag(inode, FI_SKIP_WRITES);
> @@ -4081,7 +4081,6 @@ static int f2fs_ioc_decompress_file(struct file *fi=
lp)
>         struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);
>         struct f2fs_inode_info *fi =3D F2FS_I(inode);
>         pgoff_t page_idx =3D 0, last_idx;
> -       unsigned int blk_per_seg =3D sbi->blocks_per_seg;
>         int cluster_size =3D fi->i_cluster_size;
>         int count, ret;
>
> @@ -4125,7 +4124,7 @@ static int f2fs_ioc_decompress_file(struct file *fi=
lp)
>                 if (ret < 0)
>                         break;
>
> -               if (get_dirty_pages(inode) >=3D blk_per_seg) {
> +               if (get_dirty_pages(inode) >=3D BLKS_PER_SEG(sbi)) {
>                         ret =3D filemap_fdatawrite(inode->i_mapping);
>                         if (ret < 0)
>                                 break;
> @@ -4160,7 +4159,6 @@ static int f2fs_ioc_compress_file(struct file *filp=
)
>         struct inode *inode =3D file_inode(filp);
>         struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);
>         pgoff_t page_idx =3D 0, last_idx;
> -       unsigned int blk_per_seg =3D sbi->blocks_per_seg;
>         int cluster_size =3D F2FS_I(inode)->i_cluster_size;
>         int count, ret;
>
> @@ -4203,7 +4201,7 @@ static int f2fs_ioc_compress_file(struct file *filp=
)
>                 if (ret < 0)
>                         break;
>
> -               if (get_dirty_pages(inode) >=3D blk_per_seg) {
> +               if (get_dirty_pages(inode) >=3D BLKS_PER_SEG(sbi)) {
>                         ret =3D filemap_fdatawrite(inode->i_mapping);
>                         if (ret < 0)
>                                 break;
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 6899f434ad68..d61a60c1c844 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -259,7 +259,7 @@ static void select_policy(struct f2fs_sb_info *sbi, i=
nt gc_type,
>                 p->ofs_unit =3D 1;
>         } else {
>                 p->gc_mode =3D select_gc_type(sbi, gc_type);
> -               p->ofs_unit =3D sbi->segs_per_sec;
> +               p->ofs_unit =3D SEGS_PER_SEC(sbi);
>                 if (__is_large_section(sbi)) {
>                         p->dirty_bitmap =3D dirty_i->dirty_secmap;
>                         p->max_search =3D count_bits(p->dirty_bitmap,
> @@ -282,7 +282,8 @@ static void select_policy(struct f2fs_sb_info *sbi, i=
nt gc_type,
>
>         /* let's select beginning hot/small space first in no_heap mode*/
>         if (f2fs_need_rand_seg(sbi))
> -               p->offset =3D get_random_u32_below(MAIN_SECS(sbi) * sbi->=
segs_per_sec);
> +               p->offset =3D get_random_u32_below(MAIN_SECS(sbi) *
> +                                               SEGS_PER_SEC(sbi));
>         else if (test_opt(sbi, NOHEAP) &&
>                 (type =3D=3D CURSEG_HOT_DATA || IS_NODESEG(type)))
>                 p->offset =3D 0;
> @@ -295,13 +296,13 @@ static unsigned int get_max_cost(struct f2fs_sb_inf=
o *sbi,
>  {
>         /* SSR allocates in a segment unit */
>         if (p->alloc_mode =3D=3D SSR)
> -               return sbi->blocks_per_seg;
> +               return BLKS_PER_SEG(sbi);
>         else if (p->alloc_mode =3D=3D AT_SSR)
>                 return UINT_MAX;
>
>         /* LFS */
>         if (p->gc_mode =3D=3D GC_GREEDY)
> -               return 2 * sbi->blocks_per_seg * p->ofs_unit;
> +               return 2 * BLKS_PER_SEG(sbi) * p->ofs_unit;
>         else if (p->gc_mode =3D=3D GC_CB)
>                 return UINT_MAX;
>         else if (p->gc_mode =3D=3D GC_AT)
> @@ -496,9 +497,9 @@ static void add_victim_entry(struct f2fs_sb_info *sbi=
,
>                         return;
>         }
>
> -       for (i =3D 0; i < sbi->segs_per_sec; i++)
> +       for (i =3D 0; i < SEGS_PER_SEC(sbi); i++)
>                 mtime +=3D get_seg_entry(sbi, start + i)->mtime;
> -       mtime =3D div_u64(mtime, sbi->segs_per_sec);
> +       mtime =3D div_u64(mtime, SEGS_PER_SEC(sbi));
>
>         /* Handle if the system time has changed by the user */
>         if (mtime < sit_i->min_mtime)
> @@ -599,7 +600,6 @@ static void atssr_lookup_victim(struct f2fs_sb_info *=
sbi,
>         unsigned long long age;
>         unsigned long long max_mtime =3D sit_i->dirty_max_mtime;
>         unsigned long long min_mtime =3D sit_i->dirty_min_mtime;
> -       unsigned int seg_blocks =3D sbi->blocks_per_seg;
>         unsigned int vblocks;
>         unsigned int dirty_threshold =3D max(am->max_candidate_count,
>                                         am->candidate_ratio *
> @@ -629,7 +629,7 @@ static void atssr_lookup_victim(struct f2fs_sb_info *=
sbi,
>         f2fs_bug_on(sbi, !vblocks);
>
>         /* rare case */
> -       if (vblocks =3D=3D seg_blocks)
> +       if (vblocks =3D=3D BLKS_PER_SEG(sbi))
>                 goto skip_node;
>
>         iter++;
> @@ -755,7 +755,7 @@ int f2fs_get_victim(struct f2fs_sb_info *sbi, unsigne=
d int *result,
>         int ret =3D 0;
>
>         mutex_lock(&dirty_i->seglist_lock);
> -       last_segment =3D MAIN_SECS(sbi) * sbi->segs_per_sec;
> +       last_segment =3D MAIN_SECS(sbi) * SEGS_PER_SEC(sbi);
>
>         p.alloc_mode =3D alloc_mode;
>         p.age =3D age;
> @@ -896,7 +896,7 @@ int f2fs_get_victim(struct f2fs_sb_info *sbi, unsigne=
d int *result,
>                         else
>                                 sm->last_victim[p.gc_mode] =3D segno + p.=
ofs_unit;
>                         sm->last_victim[p.gc_mode] %=3D
> -                               (MAIN_SECS(sbi) * sbi->segs_per_sec);
> +                               (MAIN_SECS(sbi) * SEGS_PER_SEC(sbi));
>                         break;
>                 }
>         }
> @@ -1670,7 +1670,7 @@ static int do_garbage_collect(struct f2fs_sb_info *=
sbi,
>         struct f2fs_summary_block *sum;
>         struct blk_plug plug;
>         unsigned int segno =3D start_segno;
> -       unsigned int end_segno =3D start_segno + sbi->segs_per_sec;
> +       unsigned int end_segno =3D start_segno + SEGS_PER_SEC(sbi);
>         int seg_freed =3D 0, migrated =3D 0;
>         unsigned char type =3D IS_DATASEG(get_seg_entry(sbi, segno)->type=
) ?
>                                                 SUM_TYPE_DATA : SUM_TYPE_=
NODE;
> @@ -1678,7 +1678,7 @@ static int do_garbage_collect(struct f2fs_sb_info *=
sbi,
>         int submitted =3D 0;
>
>         if (__is_large_section(sbi))
> -               end_segno =3D rounddown(end_segno, sbi->segs_per_sec);
> +               end_segno =3D rounddown(end_segno, SEGS_PER_SEC(sbi));
>
>         /*
>          * zone-capacity can be less than zone-size in zoned devices,
> @@ -1686,7 +1686,7 @@ static int do_garbage_collect(struct f2fs_sb_info *=
sbi,
>          * calculate the end segno in the zone which can be garbage colle=
cted
>          */
>         if (f2fs_sb_has_blkzoned(sbi))
> -               end_segno -=3D sbi->segs_per_sec -
> +               end_segno -=3D SEGS_PER_SEC(sbi) -
>                                         f2fs_usable_segs_in_sec(sbi, segn=
o);
>
>         sanity_check_seg_type(sbi, get_seg_entry(sbi, segno)->type);
> @@ -1986,7 +1986,7 @@ static int free_segment_range(struct f2fs_sb_info *=
sbi,
>
>         /* Force block allocation for GC */
>         MAIN_SECS(sbi) -=3D secs;
> -       start =3D MAIN_SECS(sbi) * sbi->segs_per_sec;
> +       start =3D MAIN_SECS(sbi) * SEGS_PER_SEC(sbi);
>         end =3D MAIN_SEGS(sbi) - 1;
>
>         mutex_lock(&DIRTY_I(sbi)->seglist_lock);
> @@ -2004,7 +2004,7 @@ static int free_segment_range(struct f2fs_sb_info *=
sbi,
>                 f2fs_allocate_segment_for_resize(sbi, type, start, end);
>
>         /* do GC to move out valid blocks in the range */
> -       for (segno =3D start; segno <=3D end; segno +=3D sbi->segs_per_se=
c) {
> +       for (segno =3D start; segno <=3D end; segno +=3D SEGS_PER_SEC(sbi=
)) {
>                 struct gc_inode_list gc_list =3D {
>                         .ilist =3D LIST_HEAD_INIT(gc_list.ilist),
>                         .iroot =3D RADIX_TREE_INIT(gc_list.iroot, GFP_NOF=
S),
> @@ -2048,7 +2048,7 @@ static void update_sb_metadata(struct f2fs_sb_info =
*sbi, int secs)
>         int segment_count;
>         int segment_count_main;
>         long long block_count;
> -       int segs =3D secs * sbi->segs_per_sec;
> +       int segs =3D secs * SEGS_PER_SEC(sbi);
>
>         f2fs_down_write(&sbi->sb_lock);
>
> @@ -2061,7 +2061,7 @@ static void update_sb_metadata(struct f2fs_sb_info =
*sbi, int secs)
>         raw_sb->segment_count =3D cpu_to_le32(segment_count + segs);
>         raw_sb->segment_count_main =3D cpu_to_le32(segment_count_main + s=
egs);
>         raw_sb->block_count =3D cpu_to_le64(block_count +
> -                                       (long long)segs * sbi->blocks_per=
_seg);
> +                       (long long)(segs << sbi->log_blocks_per_seg));
>         if (f2fs_is_multi_device(sbi)) {
>                 int last_dev =3D sbi->s_ndevs - 1;
>                 int dev_segs =3D
> @@ -2076,8 +2076,8 @@ static void update_sb_metadata(struct f2fs_sb_info =
*sbi, int secs)
>
>  static void update_fs_metadata(struct f2fs_sb_info *sbi, int secs)
>  {
> -       int segs =3D secs * sbi->segs_per_sec;
> -       long long blks =3D (long long)segs * sbi->blocks_per_seg;
> +       int segs =3D secs * SEGS_PER_SEC(sbi);
> +       long long blks =3D (long long)(segs << sbi->log_blocks_per_seg);
>         long long user_block_count =3D
>                                 le64_to_cpu(F2FS_CKPT(sbi)->user_block_co=
unt);
>
> @@ -2119,7 +2119,7 @@ int f2fs_resize_fs(struct file *filp, __u64 block_c=
ount)
>                 int last_dev =3D sbi->s_ndevs - 1;
>                 __u64 last_segs =3D FDEV(last_dev).total_segments;
>
> -               if (block_count + last_segs * sbi->blocks_per_seg <=3D
> +               if (block_count + (last_segs << sbi->log_blocks_per_seg) =
<=3D
>                                                                 old_block=
_count)
>                         return -EINVAL;
>         }
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 1d898a16f05a..51241996b9ec 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -2841,7 +2841,7 @@ int f2fs_restore_node_summary(struct f2fs_sb_info *=
sbi,
>         int i, idx, last_offset, nrpages;
>
>         /* scan the node segment */
> -       last_offset =3D sbi->blocks_per_seg;
> +       last_offset =3D BLKS_PER_SEG(sbi);
>         addr =3D START_BLOCK(sbi, segno);
>         sum_entry =3D &sum->entries[0];
>
> @@ -3158,7 +3158,7 @@ static int __get_nat_bitmaps(struct f2fs_sb_info *s=
bi)
>         if (!is_set_ckpt_flags(sbi, CP_NAT_BITS_FLAG))
>                 return 0;
>
> -       nat_bits_addr =3D __start_cp_addr(sbi) + sbi->blocks_per_seg -
> +       nat_bits_addr =3D __start_cp_addr(sbi) + BLKS_PER_SEG(sbi) -
>                                                 nm_i->nat_bits_blocks;
>         for (i =3D 0; i < nm_i->nat_bits_blocks; i++) {
>                 struct page *page;
> diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
> index 5bd16a95eef8..6aea13024ac1 100644
> --- a/fs/f2fs/node.h
> +++ b/fs/f2fs/node.h
> @@ -208,10 +208,10 @@ static inline pgoff_t current_nat_addr(struct f2fs_=
sb_info *sbi, nid_t start)
>
>         block_addr =3D (pgoff_t)(nm_i->nat_blkaddr +
>                 (block_off << 1) -
> -               (block_off & (sbi->blocks_per_seg - 1)));
> +               (block_off & (BLKS_PER_SEG(sbi) - 1)));
>
>         if (f2fs_test_bit(block_off, nm_i->nat_bitmap))
> -               block_addr +=3D sbi->blocks_per_seg;
> +               block_addr +=3D BLKS_PER_SEG(sbi);
>
>         return block_addr;
>  }
> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> index aad1d1a9b3d6..b3baec666afe 100644
> --- a/fs/f2fs/recovery.c
> +++ b/fs/f2fs/recovery.c
> @@ -354,7 +354,7 @@ static unsigned int adjust_por_ra_blocks(struct f2fs_=
sb_info *sbi,
>         if (blkaddr + 1 =3D=3D next_blkaddr)
>                 ra_blocks =3D min_t(unsigned int, RECOVERY_MAX_RA_BLOCKS,
>                                                         ra_blocks * 2);
> -       else if (next_blkaddr % sbi->blocks_per_seg)
> +       else if (next_blkaddr % BLKS_PER_SEG(sbi))
>                 ra_blocks =3D max_t(unsigned int, RECOVERY_MIN_RA_BLOCKS,
>                                                         ra_blocks / 2);
>         return ra_blocks;
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index e5759813276a..8d330664b925 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -448,8 +448,8 @@ static inline bool excess_dirty_threshold(struct f2fs=
_sb_info *sbi)
>         unsigned int nodes =3D get_pages(sbi, F2FS_DIRTY_NODES);
>         unsigned int meta =3D get_pages(sbi, F2FS_DIRTY_META);
>         unsigned int imeta =3D get_pages(sbi, F2FS_DIRTY_IMETA);
> -       unsigned int threshold =3D sbi->blocks_per_seg * factor *
> -                                       DEFAULT_DIRTY_THRESHOLD;
> +       unsigned int threshold =3D (factor * DEFAULT_DIRTY_THRESHOLD) <<
> +                               sbi->log_blocks_per_seg;
>         unsigned int global_threshold =3D threshold * 3 / 2;
>
>         if (dents >=3D threshold || qdata >=3D threshold ||
> @@ -1134,8 +1134,7 @@ static void __check_sit_bitmap(struct f2fs_sb_info =
*sbi,
>         struct seg_entry *sentry;
>         unsigned int segno;
>         block_t blk =3D start;
> -       unsigned long offset, size, max_blocks =3D sbi->blocks_per_seg;
> -       unsigned long *map;
> +       unsigned long offset, size, *map;
>
>         while (blk < end) {
>                 segno =3D GET_SEGNO(sbi, blk);
> @@ -1145,7 +1144,7 @@ static void __check_sit_bitmap(struct f2fs_sb_info =
*sbi,
>                 if (end < START_BLOCK(sbi, segno + 1))
>                         size =3D GET_BLKOFF_FROM_SEG0(sbi, end);
>                 else
> -                       size =3D max_blocks;
> +                       size =3D BLKS_PER_SEG(sbi);
>                 map =3D (unsigned long *)(sentry->cur_valid_map);
>                 offset =3D __find_rev_next_bit(map, size, offset);
>                 f2fs_bug_on(sbi, offset !=3D size);
> @@ -2044,7 +2043,6 @@ static bool add_discard_addrs(struct f2fs_sb_info *=
sbi, struct cp_control *cpc,
>                                                         bool check_only)
>  {
>         int entries =3D SIT_VBLOCK_MAP_SIZE / sizeof(unsigned long);
> -       int max_blocks =3D sbi->blocks_per_seg;
>         struct seg_entry *se =3D get_seg_entry(sbi, cpc->trim_start);
>         unsigned long *cur_map =3D (unsigned long *)se->cur_valid_map;
>         unsigned long *ckpt_map =3D (unsigned long *)se->ckpt_valid_map;
> @@ -2056,8 +2054,9 @@ static bool add_discard_addrs(struct f2fs_sb_info *=
sbi, struct cp_control *cpc,
>         struct list_head *head =3D &SM_I(sbi)->dcc_info->entry_list;
>         int i;
>
> -       if (se->valid_blocks =3D=3D max_blocks || !f2fs_hw_support_discar=
d(sbi) ||
> -                       !f2fs_block_unit_discard(sbi))
> +       if (se->valid_blocks =3D=3D BLKS_PER_SEG(sbi) ||
> +           !f2fs_hw_support_discard(sbi) ||
> +           !f2fs_block_unit_discard(sbi))
>                 return false;
>
>         if (!force) {
> @@ -2074,13 +2073,14 @@ static bool add_discard_addrs(struct f2fs_sb_info=
 *sbi, struct cp_control *cpc,
>
>         while (force || SM_I(sbi)->dcc_info->nr_discards <=3D
>                                 SM_I(sbi)->dcc_info->max_discards) {
> -               start =3D __find_rev_next_bit(dmap, max_blocks, end + 1);
> -               if (start >=3D max_blocks)
> +               start =3D __find_rev_next_bit(dmap, BLKS_PER_SEG(sbi), en=
d + 1);
> +               if (start >=3D BLKS_PER_SEG(sbi))
>                         break;
>
> -               end =3D __find_rev_next_zero_bit(dmap, max_blocks, start =
+ 1);
> -               if (force && start && end !=3D max_blocks
> -                                       && (end - start) < cpc->trim_minl=
en)
> +               end =3D __find_rev_next_zero_bit(dmap,
> +                                               BLKS_PER_SEG(sbi), start =
+ 1);
> +               if (force && start && end !=3D BLKS_PER_SEG(sbi) &&
> +                   (end - start) < cpc->trim_minlen)
>                         continue;
>
>                 if (check_only)
> @@ -2162,8 +2162,8 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_inf=
o *sbi,
>                                                                 start + 1=
);
>
>                 if (section_alignment) {
> -                       start =3D rounddown(start, sbi->segs_per_sec);
> -                       end =3D roundup(end, sbi->segs_per_sec);
> +                       start =3D rounddown(start, SEGS_PER_SEC(sbi));
> +                       end =3D roundup(end, SEGS_PER_SEC(sbi));
>                 }
>
>                 for (i =3D start; i < end; i++) {
> @@ -2191,9 +2191,9 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_inf=
o *sbi,
>                 if (!IS_CURSEC(sbi, secno) &&
>                         !get_valid_blocks(sbi, start, true))
>                         f2fs_issue_discard(sbi, START_BLOCK(sbi, start_se=
gno),
> -                               sbi->segs_per_sec << sbi->log_blocks_per_=
seg);
> +                                               BLKS_PER_SEC(sbi));
>
> -               start =3D start_segno + sbi->segs_per_sec;
> +               start =3D start_segno + SEGS_PER_SEC(sbi);
>                 if (start < end)
>                         goto next;
>                 else
> @@ -2212,7 +2212,7 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_inf=
o *sbi,
>  find_next:
>                 if (is_valid) {
>                         next_pos =3D find_next_zero_bit_le(entry->discard=
_map,
> -                                       sbi->blocks_per_seg, cur_pos);
> +                                               BLKS_PER_SEG(sbi), cur_po=
s);
>                         len =3D next_pos - cur_pos;
>
>                         if (f2fs_sb_has_blkzoned(sbi) ||
> @@ -2224,13 +2224,13 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_i=
nfo *sbi,
>                         total_len +=3D len;
>                 } else {
>                         next_pos =3D find_next_bit_le(entry->discard_map,
> -                                       sbi->blocks_per_seg, cur_pos);
> +                                               BLKS_PER_SEG(sbi), cur_po=
s);
>                 }
>  skip:
>                 cur_pos =3D next_pos;
>                 is_valid =3D !is_valid;
>
> -               if (cur_pos < sbi->blocks_per_seg)
> +               if (cur_pos < BLKS_PER_SEG(sbi))
>                         goto find_next;
>
>                 release_discard_addr(entry);
> @@ -2279,7 +2279,7 @@ static int create_discard_cmd_control(struct f2fs_s=
b_info *sbi)
>         dcc->max_ordered_discard =3D DEFAULT_MAX_ORDERED_DISCARD_GRANULAR=
ITY;
>         dcc->discard_io_aware =3D DPOLICY_IO_AWARE_ENABLE;
>         if (F2FS_OPTION(sbi).discard_unit =3D=3D DISCARD_UNIT_SEGMENT)
> -               dcc->discard_granularity =3D sbi->blocks_per_seg;
> +               dcc->discard_granularity =3D BLKS_PER_SEG(sbi);
>         else if (F2FS_OPTION(sbi).discard_unit =3D=3D DISCARD_UNIT_SECTIO=
N)
>                 dcc->discard_granularity =3D BLKS_PER_SEC(sbi);
>
> @@ -2542,7 +2542,7 @@ static unsigned short f2fs_curseg_valid_blocks(stru=
ct f2fs_sb_info *sbi, int typ
>         struct curseg_info *curseg =3D CURSEG_I(sbi, type);
>
>         if (sbi->ckpt->alloc_type[type] =3D=3D SSR)
> -               return sbi->blocks_per_seg;
> +               return BLKS_PER_SEG(sbi);
>         return curseg->next_blkoff;
>  }
>
> @@ -2630,7 +2630,7 @@ static int is_next_segment_free(struct f2fs_sb_info=
 *sbi,
>         unsigned int segno =3D curseg->segno + 1;
>         struct free_segmap_info *free_i =3D FREE_I(sbi);
>
> -       if (segno < MAIN_SEGS(sbi) && segno % sbi->segs_per_sec)
> +       if (segno < MAIN_SEGS(sbi) && segno % SEGS_PER_SEC(sbi))
>                 return !test_bit(segno, free_i->free_segmap);
>         return 0;
>  }
> @@ -2654,7 +2654,7 @@ static void get_new_segment(struct f2fs_sb_info *sb=
i,
>
>         spin_lock(&free_i->segmap_lock);
>
> -       if (!new_sec && ((*newseg + 1) % sbi->segs_per_sec)) {
> +       if (!new_sec && ((*newseg + 1) % SEGS_PER_SEC(sbi))) {
>                 segno =3D find_next_zero_bit(free_i->free_segmap,
>                         GET_SEG_FROM_SEC(sbi, hint + 1), *newseg + 1);
>                 if (segno < GET_SEG_FROM_SEC(sbi, hint + 1))
> @@ -2757,7 +2757,7 @@ static unsigned int __get_next_segno(struct f2fs_sb=
_info *sbi, int type)
>
>         sanity_check_seg_type(sbi, seg_type);
>         if (f2fs_need_rand_seg(sbi))
> -               return get_random_u32_below(MAIN_SECS(sbi) * sbi->segs_pe=
r_sec);
> +               return get_random_u32_below(MAIN_SECS(sbi) * SEGS_PER_SEC=
(sbi));
>
>         /* if segs_per_sec is large than 1, we need to keep original poli=
cy. */
>         if (__is_large_section(sbi))
> @@ -2827,7 +2827,7 @@ static int __next_free_blkoff(struct f2fs_sb_info *=
sbi,
>         for (i =3D 0; i < entries; i++)
>                 target_map[i] =3D ckpt_map[i] | cur_map[i];
>
> -       return __find_rev_next_zero_bit(target_map, sbi->blocks_per_seg, =
start);
> +       return __find_rev_next_zero_bit(target_map, BLKS_PER_SEG(sbi), st=
art);
>  }
>
>  static int f2fs_find_next_ssr_block(struct f2fs_sb_info *sbi,
> @@ -2838,7 +2838,7 @@ static int f2fs_find_next_ssr_block(struct f2fs_sb_=
info *sbi,
>
>  bool f2fs_segment_has_free_slot(struct f2fs_sb_info *sbi, int segno)
>  {
> -       return __next_free_blkoff(sbi, segno, 0) < sbi->blocks_per_seg;
> +       return __next_free_blkoff(sbi, segno, 0) < BLKS_PER_SEG(sbi);
>  }
>
>  /*
> @@ -3238,8 +3238,8 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct f=
strim_range *range)
>         end_segno =3D (end >=3D MAX_BLKADDR(sbi)) ? MAIN_SEGS(sbi) - 1 :
>                                                 GET_SEGNO(sbi, end);
>         if (need_align) {
> -               start_segno =3D rounddown(start_segno, sbi->segs_per_sec)=
;
> -               end_segno =3D roundup(end_segno + 1, sbi->segs_per_sec) -=
 1;
> +               start_segno =3D rounddown(start_segno, SEGS_PER_SEC(sbi))=
;
> +               end_segno =3D roundup(end_segno + 1, SEGS_PER_SEC(sbi)) -=
 1;
>         }
>
>         cpc.reason =3D CP_DISCARD;
> @@ -3437,7 +3437,7 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *=
sbi, struct page *page,
>         }
>         *new_blkaddr =3D NEXT_FREE_BLKADDR(sbi, curseg);
>
> -       f2fs_bug_on(sbi, curseg->next_blkoff >=3D sbi->blocks_per_seg);
> +       f2fs_bug_on(sbi, curseg->next_blkoff >=3D BLKS_PER_SEG(sbi));
>
>         f2fs_wait_discard_bio(sbi, *new_blkaddr);
>
> @@ -3881,7 +3881,7 @@ static int read_compacted_summaries(struct f2fs_sb_=
info *sbi)
>                 seg_i->next_blkoff =3D blk_off;
>
>                 if (seg_i->alloc_type =3D=3D SSR)
> -                       blk_off =3D sbi->blocks_per_seg;
> +                       blk_off =3D BLKS_PER_SEG(sbi);
>
>                 for (j =3D 0; j < blk_off; j++) {
>                         struct f2fs_summary *s;
> @@ -3949,7 +3949,7 @@ static int read_normal_summaries(struct f2fs_sb_inf=
o *sbi, int type)
>                         struct f2fs_summary *ns =3D &sum->entries[0];
>                         int i;
>
> -                       for (i =3D 0; i < sbi->blocks_per_seg; i++, ns++)=
 {
> +                       for (i =3D 0; i < BLKS_PER_SEG(sbi); i++, ns++) {
>                                 ns->version =3D 0;
>                                 ns->ofs_in_node =3D 0;
>                         }
> @@ -4582,21 +4582,20 @@ static int build_sit_entries(struct f2fs_sb_info =
*sbi)
>
>                         sit_valid_blocks[SE_PAGETYPE(se)] +=3D se->valid_=
blocks;
>
> -                       if (f2fs_block_unit_discard(sbi)) {
> -                               /* build discard map only one time */
> -                               if (is_set_ckpt_flags(sbi, CP_TRIMMED_FLA=
G)) {
> -                                       memset(se->discard_map, 0xff,
> +                       if (!f2fs_block_unit_discard(sbi))
> +                               goto init_discard_map_done;
> +
> +                       /* build discard map only one time */
> +                       if (is_set_ckpt_flags(sbi, CP_TRIMMED_FLAG)) {
> +                               memset(se->discard_map, 0xff,
>                                                 SIT_VBLOCK_MAP_SIZE);
> -                               } else {
> -                                       memcpy(se->discard_map,
> -                                               se->cur_valid_map,
> +                               goto init_discard_map_done;
> +                       }
> +                       memcpy(se->discard_map, se->cur_valid_map,
>                                                 SIT_VBLOCK_MAP_SIZE);
> -                                       sbi->discard_blks +=3D
> -                                               sbi->blocks_per_seg -
> +                       sbi->discard_blks +=3D BLKS_PER_SEG(sbi) -
>                                                 se->valid_blocks;
> -                               }
> -                       }
> -
> +init_discard_map_done:
>                         if (__is_large_section(sbi))
>                                 get_sec_entry(sbi, start)->valid_blocks +=
=3D
>                                                         se->valid_blocks;
> @@ -4736,7 +4735,7 @@ static void init_dirty_segmap(struct f2fs_sb_info *=
sbi)
>                 return;
>
>         mutex_lock(&dirty_i->seglist_lock);
> -       for (segno =3D 0; segno < MAIN_SEGS(sbi); segno +=3D sbi->segs_pe=
r_sec) {
> +       for (segno =3D 0; segno < MAIN_SEGS(sbi); segno +=3D SEGS_PER_SEC=
(sbi)) {
>                 valid_blocks =3D get_valid_blocks(sbi, segno, true);
>                 secno =3D GET_SEC_FROM_SEG(sbi, segno);
>
> @@ -4835,7 +4834,7 @@ static int sanity_check_curseg(struct f2fs_sb_info =
*sbi)
>                 if (curseg->alloc_type =3D=3D SSR)
>                         continue;
>
> -               for (blkofs +=3D 1; blkofs < sbi->blocks_per_seg; blkofs+=
+) {
> +               for (blkofs +=3D 1; blkofs < BLKS_PER_SEG(sbi); blkofs++)=
 {
>                         if (!f2fs_test_bit(blkofs, se->cur_valid_map))
>                                 continue;
>  out:
> @@ -5114,7 +5113,7 @@ static inline unsigned int f2fs_usable_zone_blks_in=
_seg(
>         unsigned int secno;
>
>         if (!sbi->unusable_blocks_per_sec)
> -               return sbi->blocks_per_seg;
> +               return BLKS_PER_SEG(sbi);
>
>         secno =3D GET_SEC_FROM_SEG(sbi, segno);
>         seg_start =3D START_BLOCK(sbi, segno);
> @@ -5129,10 +5128,10 @@ static inline unsigned int f2fs_usable_zone_blks_=
in_seg(
>          */
>         if (seg_start >=3D sec_cap_blkaddr)
>                 return 0;
> -       if (seg_start + sbi->blocks_per_seg > sec_cap_blkaddr)
> +       if (seg_start + BLKS_PER_SEG(sbi) > sec_cap_blkaddr)
>                 return sec_cap_blkaddr - seg_start;
>
> -       return sbi->blocks_per_seg;
> +       return BLKS_PER_SEG(sbi);
>  }
>  #else
>  int f2fs_fix_curseg_write_pointer(struct f2fs_sb_info *sbi)
> @@ -5158,7 +5157,7 @@ unsigned int f2fs_usable_blks_in_seg(struct f2fs_sb=
_info *sbi,
>         if (f2fs_sb_has_blkzoned(sbi))
>                 return f2fs_usable_zone_blks_in_seg(sbi, segno);
>
> -       return sbi->blocks_per_seg;
> +       return BLKS_PER_SEG(sbi);
>  }
>
>  unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi,
> @@ -5167,7 +5166,7 @@ unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb=
_info *sbi,
>         if (f2fs_sb_has_blkzoned(sbi))
>                 return CAP_SEGS_PER_SEC(sbi);
>
> -       return sbi->segs_per_sec;
> +       return SEGS_PER_SEC(sbi);
>  }
>
>  /*
> @@ -5182,14 +5181,14 @@ static void init_min_max_mtime(struct f2fs_sb_inf=
o *sbi)
>
>         sit_i->min_mtime =3D ULLONG_MAX;
>
> -       for (segno =3D 0; segno < MAIN_SEGS(sbi); segno +=3D sbi->segs_pe=
r_sec) {
> +       for (segno =3D 0; segno < MAIN_SEGS(sbi); segno +=3D SEGS_PER_SEC=
(sbi)) {
>                 unsigned int i;
>                 unsigned long long mtime =3D 0;
>
> -               for (i =3D 0; i < sbi->segs_per_sec; i++)
> +               for (i =3D 0; i < SEGS_PER_SEC(sbi); i++)
>                         mtime +=3D get_seg_entry(sbi, segno + i)->mtime;
>
> -               mtime =3D div_u64(mtime, sbi->segs_per_sec);
> +               mtime =3D div_u64(mtime, SEGS_PER_SEC(sbi));
>
>                 if (sit_i->min_mtime > mtime)
>                         sit_i->min_mtime =3D mtime;
> @@ -5228,7 +5227,7 @@ int f2fs_build_segment_manager(struct f2fs_sb_info =
*sbi)
>                 sm_info->ipu_policy =3D BIT(F2FS_IPU_FSYNC);
>         sm_info->min_ipu_util =3D DEF_MIN_IPU_UTIL;
>         sm_info->min_fsync_blocks =3D DEF_MIN_FSYNC_BLOCKS;
> -       sm_info->min_seq_blocks =3D sbi->blocks_per_seg;
> +       sm_info->min_seq_blocks =3D BLKS_PER_SEG(sbi);
>         sm_info->min_hot_blocks =3D DEF_MIN_HOT_BLOCKS;
>         sm_info->min_ssr_sections =3D reserved_sections(sbi);
>
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index 8129be788bd5..96cec83012f1 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -99,8 +99,6 @@ static inline void sanity_check_seg_type(struct f2fs_sb=
_info *sbi,
>         ((!__is_valid_data_blkaddr(blk_addr)) ?                 \
>         NULL_SEGNO : GET_L2R_SEGNO(FREE_I(sbi),                 \
>                 GET_SEGNO_FROM_SEG0(sbi, blk_addr)))
> -#define BLKS_PER_SEC(sbi)                                      \
> -       ((sbi)->segs_per_sec * (sbi)->blocks_per_seg)
>  #define CAP_BLKS_PER_SEC(sbi)                                  \
>         ((sbi)->segs_per_sec * (sbi)->blocks_per_seg -          \
>          (sbi)->unusable_blocks_per_sec)
> @@ -364,7 +362,7 @@ static inline unsigned int get_ckpt_valid_blocks(stru=
ct f2fs_sb_info *sbi,
>                 unsigned int blocks =3D 0;
>                 int i;
>
> -               for (i =3D 0; i < sbi->segs_per_sec; i++, start_segno++) =
{
> +               for (i =3D 0; i < SEGS_PER_SEC(sbi); i++, start_segno++) =
{
>                         struct seg_entry *se =3D get_seg_entry(sbi, start=
_segno);
>
>                         blocks +=3D se->ckpt_valid_blocks;
> @@ -449,7 +447,7 @@ static inline void __set_free(struct f2fs_sb_info *sb=
i, unsigned int segno)
>         free_i->free_segments++;
>
>         next =3D find_next_bit(free_i->free_segmap,
> -                       start_segno + sbi->segs_per_sec, start_segno);
> +                       start_segno + SEGS_PER_SEC(sbi), start_segno);
>         if (next >=3D start_segno + usable_segs) {
>                 clear_bit(secno, free_i->free_secmap);
>                 free_i->free_sections++;
> @@ -485,7 +483,7 @@ static inline void __set_test_and_free(struct f2fs_sb=
_info *sbi,
>                 if (!inmem && IS_CURSEC(sbi, secno))
>                         goto skip_free;
>                 next =3D find_next_bit(free_i->free_segmap,
> -                               start_segno + sbi->segs_per_sec, start_se=
gno);
> +                               start_segno + SEGS_PER_SEC(sbi), start_se=
gno);
>                 if (next >=3D start_segno + usable_segs) {
>                         if (test_and_clear_bit(secno, free_i->free_secmap=
))
>                                 free_i->free_sections++;
> @@ -793,10 +791,10 @@ static inline int check_block_count(struct f2fs_sb_=
info *sbi,
>                 return -EFSCORRUPTED;
>         }
>
> -       if (usable_blks_per_seg < sbi->blocks_per_seg)
> +       if (usable_blks_per_seg < BLKS_PER_SEG(sbi))
>                 f2fs_bug_on(sbi, find_next_bit_le(&raw_sit->valid_map,
> -                               sbi->blocks_per_seg,
> -                               usable_blks_per_seg) !=3D sbi->blocks_per=
_seg);
> +                               BLKS_PER_SEG(sbi),
> +                               usable_blks_per_seg) !=3D BLKS_PER_SEG(sb=
i));
>
>         /* check segment usage, and check boundary of a given segment num=
ber */
>         if (unlikely(GET_SIT_VBLOCKS(raw_sit) > usable_blks_per_seg
> @@ -915,9 +913,9 @@ static inline int nr_pages_to_skip(struct f2fs_sb_inf=
o *sbi, int type)
>                 return 0;
>
>         if (type =3D=3D DATA)
> -               return sbi->blocks_per_seg;
> +               return BLKS_PER_SEG(sbi);
>         else if (type =3D=3D NODE)
> -               return 8 * sbi->blocks_per_seg;
> +               return 8 * BLKS_PER_SEG(sbi);
>         else if (type =3D=3D META)
>                 return 8 * BIO_MAX_VECS;
>         else
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index f1516fd5088a..c0688c124aa7 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -3643,7 +3643,7 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi=
)
>         }
>
>         main_segs =3D le32_to_cpu(raw_super->segment_count_main);
> -       blocks_per_seg =3D sbi->blocks_per_seg;
> +       blocks_per_seg =3D BLKS_PER_SEG(sbi);
>
>         for (i =3D 0; i < NR_CURSEG_NODE_TYPE; i++) {
>                 if (le32_to_cpu(ckpt->cur_node_segno[i]) >=3D main_segs |=
|
> @@ -3756,8 +3756,8 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
>         sbi->secs_per_zone =3D le32_to_cpu(raw_super->secs_per_zone);
>         sbi->total_sections =3D le32_to_cpu(raw_super->section_count);
>         sbi->total_node_count =3D
> -               (le32_to_cpu(raw_super->segment_count_nat) / 2)
> -                       * sbi->blocks_per_seg * NAT_ENTRY_PER_BLOCK;
> +               ((le32_to_cpu(raw_super->segment_count_nat) / 2) *
> +               NAT_ENTRY_PER_BLOCK) << sbi->log_blocks_per_seg;
>         F2FS_ROOT_INO(sbi) =3D le32_to_cpu(raw_super->root_ino);
>         F2FS_NODE_INO(sbi) =3D le32_to_cpu(raw_super->node_ino);
>         F2FS_META_INO(sbi) =3D le32_to_cpu(raw_super->meta_ino);
> @@ -3766,7 +3766,7 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
>         sbi->next_victim_seg[BG_GC] =3D NULL_SEGNO;
>         sbi->next_victim_seg[FG_GC] =3D NULL_SEGNO;
>         sbi->max_victim_search =3D DEF_MAX_VICTIM_SEARCH;
> -       sbi->migration_granularity =3D sbi->segs_per_sec;
> +       sbi->migration_granularity =3D SEGS_PER_SEC(sbi);
>         sbi->seq_file_ra_mul =3D MIN_RA_MUL;
>         sbi->max_fragment_chunk =3D DEF_FRAGMENT_SIZE;
>         sbi->max_fragment_hole =3D DEF_FRAGMENT_SIZE;
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index a7ec55c7bb20..906d2af2d849 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -493,8 +493,8 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>                 spin_lock(&sbi->stat_lock);
>                 if (t > (unsigned long)(sbi->user_block_count -
>                                 F2FS_OPTION(sbi).root_reserved_blocks -
> -                               sbi->blocks_per_seg *
> -                               SM_I(sbi)->additional_reserved_segments))=
 {
> +                               (SM_I(sbi)->additional_reserved_segments =
<<
> +                                       sbi->log_blocks_per_seg))) {
>                         spin_unlock(&sbi->stat_lock);
>                         return -EINVAL;
>                 }
> @@ -551,7 +551,7 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>         }
>
>         if (!strcmp(a->attr.name, "migration_granularity")) {
> -               if (t =3D=3D 0 || t > sbi->segs_per_sec)
> +               if (t =3D=3D 0 || t > SEGS_PER_SEC(sbi))
>                         return -EINVAL;
>         }
>
> --
> 2.43.0.594.gd9cf4e227d-goog
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

