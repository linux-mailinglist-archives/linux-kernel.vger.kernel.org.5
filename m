Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D910803D85
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 19:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjLDSxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 13:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjLDSxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 13:53:16 -0500
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C70AB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 10:53:22 -0800 (PST)
Received: by mail-vk1-xa32.google.com with SMTP id 71dfb90a1353d-4b2eaa89796so263378e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 10:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701716001; x=1702320801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubRXQTeiFt9GpRXI/6OBGRrpxykvw56RWRgyn02NYIk=;
        b=S6FF8s6JTUHnHPfMyT9xpM2qy7C07lgemeTE3ulgzH8jwKxrDoeSF4ckOxxlZIXW/V
         9L9ggAZaDJc9MQ+SuwA7XvfFlBylJM5EDCtguQaRPhLFx1OCByF+nfvydxtGLg6vjEiF
         m1DhoJbRiiS/VXhQC+cyC2YaFhALk7K7IXg1tv17QeSVU3Rq4SucmiphY/8uDQ/BagNC
         CQMMwjwV5SztwO8fUfWiN6LT8EmqXXDeXDbSyEyVXKmXvOYPoXaP9gWcYpJIFixUMgHA
         ew42feiuFFRjc1vYadZnEjFtEfsL/77FbloapqiTxNa6NotWa3lDPl/M8VIsL9Ver49J
         2cIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701716001; x=1702320801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ubRXQTeiFt9GpRXI/6OBGRrpxykvw56RWRgyn02NYIk=;
        b=sP2pJ9N52I6+lG+M9acD7fNw7Nnphi8H1sP8CXn9ERaT+PNqyGcUQdLFw+tp83bt+J
         5JgUlcPu+i4kuZauooZF2nDe6mbpjgN3WH+7M+VdiF7O2Xp5EVEB+IaGJNBFtGVPN1VK
         /LUf9l7Atm5xcAZO5VyXuu+zB51La+8ycWFdIs+/Ikz/h/cjcghmYrHtOHgeCBGnbV47
         hgP0hd4/aSihx+9zDiCVDk20c04Ri2MbxuL1Xu7Mf1uuAVV4hC5ubDbmBoxK/zEw5tRy
         S5hd9B25MjJdxmamglqdticMZ21/9l/ZqI5aRlP+8ej7fZRetmaU+kusEyPYTl70aeRJ
         YnYQ==
X-Gm-Message-State: AOJu0YzKazBjhNGtzy2w8vlL60QiuL2BgG75MpRg+E+aT8xeYHR9ipDJ
        MK676KrouEWkRuyChyIqR7BBV6xtsua+jZ8iiZnAgWPbSgE=
X-Google-Smtp-Source: AGHT+IElefo3g8xyw63YgpgwE6qjcPayyqksyAZn+TpsInT2m5BM3/xxggErNz95a8EeujF1i0HioktW+LG64o9DmKQ=
X-Received: by 2002:ac5:c24f:0:b0:4b2:e003:e16 with SMTP id
 n15-20020ac5c24f000000b004b2e0030e16mr1725996vkk.3.1701716001159; Mon, 04 Dec
 2023 10:53:21 -0800 (PST)
MIME-Version: 1.0
References: <20231204180428.925779-1-jaegeuk@kernel.org>
In-Reply-To: <20231204180428.925779-1-jaegeuk@kernel.org>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Mon, 4 Dec 2023 10:53:10 -0800
Message-ID: <CACOAw_x-QMsCyW9Tiw408TSfKXudBnJUJ7Pc3VkRmYQ-vi+eug@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH 1/4] f2fs: allocate new section if it's not new
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LGTM

On Mon, Dec 4, 2023 at 10:06=E2=80=AFAM Jaegeuk Kim <jaegeuk@kernel.org> wr=
ote:
>
> If fsck can allocate a new zone, it'd be better to use that instead of
> allocating a new one.
>
> And, it modifies kernel messages.
>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/segment.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
>
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 08e2f44a1264..9081c9af977a 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -4949,20 +4949,18 @@ static int check_zone_write_pointer(struct f2fs_s=
b_info *sbi,
>                 return ret;
>         }
>
> -       if (is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG)) {
> -               /*
> -                * If there are valid blocks and the write pointer doesn'=
t match
> -                * with them, we need to report the inconsistency and fil=
l
> -                * the zone till the end to close the zone. This inconsis=
tency
> -                * does not cause write error because the zone will not b=
e
> -                * selected for write operation until it get discarded.
> -                */
> -               f2fs_notice(sbi, "Valid blocks are not aligned with write=
 "
> +       /*
> +        * If there are valid blocks and the write pointer doesn't match
> +        * with them, we need to report the inconsistency and fill
> +        * the zone till the end to close the zone. This inconsistency
> +        * does not cause write error because the zone will not be
> +        * selected for write operation until it get discarded.
> +        */
> +       f2fs_notice(sbi, "Valid blocks are not aligned with write "
>                             "pointer: valid block[0x%x,0x%x] wp[0x%x,0x%x=
]",
>                             GET_SEGNO(sbi, last_valid_block),
>                             GET_BLKOFF_FROM_SEG0(sbi, last_valid_block),
>                             wp_segno, wp_blkoff);
> -       }
>
>         ret =3D blkdev_zone_mgmt(fdev->bdev, REQ_OP_ZONE_FINISH,
>                                 zone->start, zone->len, GFP_NOFS);
> @@ -5053,15 +5051,18 @@ static int fix_curseg_write_pointer(struct f2fs_s=
b_info *sbi, int type)
>                 f2fs_notice(sbi, "Unaligned curseg[%d] with write pointer=
: "
>                             "curseg[0x%x,0x%x] wp[0x%x,0x%x]", type, cs->=
segno,
>                             cs->next_blkoff, wp_segno, wp_blkoff);
> -       } else {
> -               f2fs_notice(sbi, "Not successfully unmounted in the previ=
ous "
> -                           "mount");
>         }
>
> -       f2fs_notice(sbi, "Assign new section to curseg[%d]: "
> -                   "curseg[0x%x,0x%x]", type, cs->segno, cs->next_blkoff=
);
> +       /* Allocate a new section if it's not new. */
> +       if (cs->next_blkoff) {
> +               unsigned int old_segno =3D cs->segno, old_blkoff =3D cs->=
next_blkoff;
>
> -       f2fs_allocate_new_section(sbi, type, true);
> +               f2fs_allocate_new_section(sbi, type, true);
> +               f2fs_notice(sbi, "Assign new section to curseg[%d]: "
> +                               "[0x%x,0x%x] -> [0x%x,0x%x]",
> +                               type, old_segno, old_blkoff,
> +                               cs->segno, cs->next_blkoff);
> +       }
>
>         /* check consistency of the zone curseg pointed to */
>         if (check_zone_write_pointer(sbi, zbd, &zone))
> --
> 2.43.0.rc2.451.g8631bc7472-goog
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
