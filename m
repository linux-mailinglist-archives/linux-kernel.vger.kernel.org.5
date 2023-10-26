Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133557D7B1D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 04:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjJZC5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 22:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjJZC5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 22:57:06 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA7ECC
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 19:57:03 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-7b9b2ba34d3so184018241.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 19:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698289022; x=1698893822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjcX8xEr22WkDUSJPrJz4vn34WBOxifwZu4rEIY0Thc=;
        b=RMfxJxIf3WMdx2CYP9Y89LnA7y74OmfGVroaad9MBynSY/OGvHtgtO78s96Jq87eJM
         mSfY4jv6AkxUhgQN03zvcxNzfyByMfAc4kb3NWPHHR414uu7inyq3Z12fioV6fQeE5Rm
         +sgzf0jvwCvj4S5vvpqWWrQz/VXkj5F1WfZ7s+4Q0bQ1uRW+gbz1HIUa7oewg0Vgz9/r
         iIvZDFs/UEMO3S77yoRoRW5l17LyugMUeG7eJvewtwDdJXfF6ZmlpTs/Ny8/pk1b4onz
         bhSg5+9VrUCTZWhzrfyg2FbaS3VErhpyxDXlFbvrO83dnkT0EwuhKWTg0bnHCu1b4Ng/
         9loA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698289022; x=1698893822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wjcX8xEr22WkDUSJPrJz4vn34WBOxifwZu4rEIY0Thc=;
        b=Sb9Iyic8BBbxwwXX0lZbLTb2AvljhSnEMwVNrJQhx2jT8Jaz+XJgt0n4pyWFDDKrEA
         DxnyYu0UGBgs8SdAEkxeVIUI9D/3y27/s9bKhQprCuPYpg23latPTOoHeE8w2wSKvkXq
         Lw6OS3feDFQ88THsUT4FHHF0M55X/eT+wA5SRAwMmuEOgV45M29tgcOxwhp2uUPuty4K
         /ZrLkTy034da4/X5lIVgw6tIJDjTPbzY1W3I8PtYeIWyLUi9Vt45swPnmgIrBIFnmXjj
         7yqEJKKVxHdKxhbDEN89Dk5q+8q4FVG3lPTxEfCNZo0EF/46Er/vjVjfs+VU0fei0Qa9
         gCZA==
X-Gm-Message-State: AOJu0YxHH5WCrV+3NU59kteoaGbHI1m7wyDrMj/oKlEvcGh5PZAuHRgF
        CtIbP6Me7p5vqcLdEF5/BM/XtEwe8WVpIVaF594YjVxr
X-Google-Smtp-Source: AGHT+IExVucxUyxKYRBKH3I0xHBJJNlUffiCa3mxWTA/HSYEeYSgWi1I/Msizhzz2fZKKryIlWTV5wmJeLHOUhN3Xp4=
X-Received: by 2002:a67:e150:0:b0:452:b574:3c9a with SMTP id
 o16-20020a67e150000000b00452b5743c9amr15549593vsl.26.1698289022471; Wed, 25
 Oct 2023 19:57:02 -0700 (PDT)
MIME-Version: 1.0
References: <20231018223925.2135987-1-daeho43@gmail.com>
In-Reply-To: <20231018223925.2135987-1-daeho43@gmail.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Wed, 25 Oct 2023 19:56:51 -0700
Message-ID: <CACOAw_wKXnHznkN-LWnNp8Va4-Lx_BKgVzQEfPjhuY248yhcjQ@mail.gmail.com>
Subject: Re: [PATCH] f2fs-tools: make six open zone check resilient
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let me fix one thing for this patch.

On Wed, Oct 18, 2023 at 3:39=E2=80=AFPM Daeho Jeong <daeho43@gmail.com> wro=
te:
>
> From: Daeho Jeong <daehojeong@google.com>
>
> We need to make sure to finish all the zones except six open zones. In
> a case of that the previous mount wasn't successfully unmounted, we have
> to change all the current segments.
>
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  fsck/fsck.c         | 87 +++++++++++++++++++--------------------------
>  include/f2fs_fs.h   |  1 +
>  lib/libf2fs_zoned.c | 28 +++++++++++++++
>  3 files changed, 65 insertions(+), 51 deletions(-)
>
> diff --git a/fsck/fsck.c b/fsck/fsck.c
> index 99cface..890b536 100644
> --- a/fsck/fsck.c
> +++ b/fsck/fsck.c
> @@ -2587,10 +2587,9 @@ static int check_curseg_write_pointer(struct f2fs_=
sb_info *sbi, int type)
>         struct curseg_info *curseg =3D CURSEG_I(sbi, type);
>         struct f2fs_fsck *fsck =3D F2FS_FSCK(sbi);
>         struct blk_zone blkz;
> -       block_t cs_block, wp_block, zone_last_vblock;
> +       block_t cs_block, wp_block;
>         uint64_t cs_sector, wp_sector;
>         int i, ret;
> -       unsigned int zone_segno;
>         int log_sectors_per_block =3D sbi->log_blocksize - SECTOR_SHIFT;
>
>         /* get the device the curseg points to */
> @@ -2624,49 +2623,28 @@ static int check_curseg_write_pointer(struct f2fs=
_sb_info *sbi, int type)
>                 (blk_zone_wp_sector(&blkz) >> log_sectors_per_block);
>         wp_sector =3D blk_zone_wp_sector(&blkz);
>
> -       if (cs_sector =3D=3D wp_sector)
> -               return 0;
> -
> -       if (cs_sector > wp_sector) {
> +       if (cs_sector =3D=3D wp_sector) {
> +               if (is_set_ckpt_flags(F2FS_CKPT(sbi), CP_UMOUNT_FLAG))
> +                       return 0;
> +               MSG(0, "Correct write pointer. But, we can't trust it, "
> +                   "since the previous mount wasn't safely unmounted: "
> +                   "curseg %d[0x%x,0x%x]\n",
> +                   type, curseg->segno, curseg->next_blkoff);
> +       } else if (cs_sector > wp_sector) {
>                 MSG(0, "Inconsistent write pointer with curseg %d: "
>                     "curseg %d[0x%x,0x%x] > wp[0x%x,0x%x]\n",
>                     type, type, curseg->segno, curseg->next_blkoff,
> +                   GET_SEGNO(sbi, wp_block),
> +                   OFFSET_IN_SEG(sbi, wp_block));
> +               if (!c.fix_on)
> +                       fsck->chk.wp_inconsistent_zones++;
> +       } else {
> +               MSG(0, "Write pointer goes advance from curseg %d: "
> +                   "curseg %d[0x%x,0x%x] wp[0x%x,0x%x]\n",
> +                   type, type, curseg->segno, curseg->next_blkoff,
>                     GET_SEGNO(sbi, wp_block), OFFSET_IN_SEG(sbi, wp_block=
));
> -               fsck->chk.wp_inconsistent_zones++;
> -               return -EINVAL;
> -       }
> -
> -       MSG(0, "Write pointer goes advance from curseg %d: "
> -           "curseg %d[0x%x,0x%x] wp[0x%x,0x%x]\n",
> -           type, type, curseg->segno, curseg->next_blkoff,
> -           GET_SEGNO(sbi, wp_block), OFFSET_IN_SEG(sbi, wp_block));
> -
> -       zone_segno =3D GET_SEG_FROM_SEC(sbi,
> -                                     GET_SEC_FROM_SEG(sbi, curseg->segno=
));
> -       zone_last_vblock =3D START_BLOCK(sbi, zone_segno) +
> -               last_vblk_off_in_zone(sbi, zone_segno);
> -
> -       /*
> -        * If valid blocks exist between the curseg position and the writ=
e
> -        * pointer, they are fsync data. This is not an error to fix. Lea=
ve it
> -        * for kernel to recover later.
> -        * If valid blocks exist between the curseg's zone start and the =
curseg
> -        * position, or if there is no valid block in the curseg's zone, =
fix
> -        * the inconsistency between the curseg and the writ pointer.
> -        * Of Note is that if there is no valid block in the curseg's zon=
e,
> -        * last_vblk_off_in_zone() returns -1 and zone_last_vblock is alw=
ays
> -        * smaller than cs_block.
> -        */
> -       if (cs_block <=3D zone_last_vblock && zone_last_vblock < wp_block=
) {
> -               MSG(0, "Curseg has fsync data: curseg %d[0x%x,0x%x] "
> -                   "last valid block in zone[0x%x,0x%x]\n",
> -                   type, curseg->segno, curseg->next_blkoff,
> -                   GET_SEGNO(sbi, zone_last_vblock),
> -                   OFFSET_IN_SEG(sbi, zone_last_vblock));
> -               return 0;
>         }
>
> -       fsck->chk.wp_inconsistent_zones++;
>         return -EINVAL;
>  }
>
> @@ -3155,10 +3133,8 @@ static int chk_and_fix_wp_with_sit(int UNUSED(i), =
void *blkzone, void *opaque)
>         struct f2fs_fsck *fsck =3D F2FS_FSCK(sbi);
>         block_t zone_block, wp_block, wp_blkoff;
>         unsigned int zone_segno, wp_segno;
> -       struct curseg_info *cs;
> -       int cs_index, ret, last_valid_blkoff;
> +       int ret, last_valid_blkoff;
>         int log_sectors_per_block =3D sbi->log_blocksize - SECTOR_SHIFT;
> -       unsigned int segs_per_zone =3D sbi->segs_per_sec * sbi->secs_per_=
zone;
>
>         if (blk_zone_conv(blkz))
>                 return 0;
> @@ -3174,14 +3150,6 @@ static int chk_and_fix_wp_with_sit(int UNUSED(i), =
void *blkzone, void *opaque)
>         wp_segno =3D GET_SEGNO(sbi, wp_block);
>         wp_blkoff =3D wp_block - START_BLOCK(sbi, wp_segno);
>
> -       /* if a curseg points to the zone, skip the check */
> -       for (cs_index =3D 0; cs_index < NO_CHECK_TYPE; cs_index++) {
> -               cs =3D &SM_I(sbi)->curseg_array[cs_index];
> -               if (zone_segno <=3D cs->segno &&
> -                   cs->segno < zone_segno + segs_per_zone)
> -                       return 0;
> -       }
> -
>         last_valid_blkoff =3D last_vblk_off_in_zone(sbi, zone_segno);
>
>         /*
> @@ -3217,10 +3185,27 @@ static int chk_and_fix_wp_with_sit(int UNUSED(i),=
 void *blkzone, void *opaque)
>         if (last_valid_blkoff + zone_block > wp_block) {
>                 MSG(0, "Unexpected invalid write pointer: wp[0x%x,0x%x]\n=
",
>                     wp_segno, wp_blkoff);
> +               if (!c.fix_on)
> +                       fsck->chk.wp_inconsistent_zones++;
> +       }
> +
> +       if (!c.fix_on)
>                 return 0;
> +
> +       ret =3D f2fs_finish_zone(wpd->dev_index, blkz);
> +       if (ret) {
> +               u64 fill_sects =3D blk_zone_length(blkz) -
> +                       (blk_zone_wp_sector(blkz) - blk_zone_sector(blkz)=
);
> +               printf("[FSCK] Finishing zone failed: %s\n", dev->path);
> +               ret =3D dev_fill(NULL, wp_block * F2FS_BLKSIZE,
> +                       (fill_sects >> log_sectors_per_block) * F2FS_BLKS=
IZE);
> +               if (ret)
> +                       printf("[FSCK] Fill up zone failed: %s\n", dev->p=
ath);
>         }
>
> -       return 0;
> +       if (!ret)
> +               fsck->chk.wp_fixed =3D 1;
> +       return ret;
>  }
>
>  static void fix_wp_sit_alignment(struct f2fs_sb_info *sbi)
> diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
> index 772a6a5..d94e447 100644
> --- a/include/f2fs_fs.h
> +++ b/include/f2fs_fs.h
> @@ -1749,6 +1749,7 @@ extern int f2fs_report_zones(int, report_zones_cb_t=
 *, void *);
>  extern int f2fs_check_zones(int);
>  int f2fs_reset_zone(int, void *);
>  extern int f2fs_reset_zones(int);
> +int f2fs_finish_zone(int i, void *blkzone);
>  extern uint32_t f2fs_get_usable_segments(struct f2fs_super_block *sb);
>
>  #define SIZE_ALIGN(val, size)  (((val) + (size) - 1) / (size))
> diff --git a/lib/libf2fs_zoned.c b/lib/libf2fs_zoned.c
> index 2ab2497..ba9286f 100644
> --- a/lib/libf2fs_zoned.c
> +++ b/lib/libf2fs_zoned.c
> @@ -502,6 +502,28 @@ out:
>         return ret;
>  }
>
> +int f2fs_finish_zone(int i, void *blkzone)
> +{
> +       struct blk_zone *blkz =3D (struct blk_zone *)blkzone;
> +       struct device_info *dev =3D c.devices + i;
> +       struct blk_zone_range range;
> +       int ret;
> +
> +       if (!blk_zone_seq(blkz) || blk_zone_empty(blkz))
> +               return 0;
> +
> +       /* Non empty sequential zone: finish */
> +       range.sector =3D blk_zone_sector(blkz);
> +       range.nr_sectors =3D blk_zone_length(blkz);
> +       ret =3D ioctl(dev->fd, BLKFINISHZONE, &range);
> +       if (ret !=3D 0) {
> +               ret =3D -errno;
> +               ERR_MSG("ioctl BLKFINISHZONE failed: errno=3D%d\n", errno=
);
> +       }
> +
> +       return ret;
> +}
> +
>  uint32_t f2fs_get_usable_segments(struct f2fs_super_block *sb)
>  {
>  #ifdef HAVE_BLK_ZONE_REP_V2
> @@ -588,6 +610,12 @@ int f2fs_reset_zones(int i)
>         return -1;
>  }
>
> +int f2fs_finish_zone(int i, void *UNUSED(blkzone))
> +{
> +       ERR_MSG("%d: Unsupported zoned block device\n", i);
> +       return -1;
> +}
> +
>  uint32_t f2fs_get_usable_segments(struct f2fs_super_block *sb)
>  {
>         return get_sb(segment_count_main);
> --
> 2.42.0.655.g421f12c284-goog
>
