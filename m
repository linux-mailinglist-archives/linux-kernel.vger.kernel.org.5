Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8164768975
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 03:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjGaBGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 21:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjGaBGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 21:06:32 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124F2A8
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 18:06:30 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-403a85eb723so32805321cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 18:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690765589; x=1691370389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tFmc3LSzrpEqyrtFMsjpuqEL6tx6bxO7/K5KB2HQeYI=;
        b=nb65YHarYEOj1MpY9L+5D+t/XGN0YKVf8GmPHeLemYM9iv5Ew8+GMLtXi1NEdPm86s
         7qyEynL9gf/SaaZ+hyDdmpi1TWY2Y2zxwsbRBJdFo3mTa33DQhgyz3eVZ8bBiKG8hONn
         N+39ETFQVGZVbahoPb1z0du7m/HlmrnjtygF1j8+Z8oFDu53pculHXEo62tqGtK4kWEz
         kx5lt7GlkaTX+oXMGWBFo5rZEeZ1nQULhiWoYcLQEQSZXlkZJ3enow1NqmNcxu1IaIu2
         C0AKYlNQK9Bq6ZZgwIH9+BFArb3fu5XVp/HKfuo0QyJTTatlzTRqlTi6+wjZnMaubwga
         afjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690765589; x=1691370389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tFmc3LSzrpEqyrtFMsjpuqEL6tx6bxO7/K5KB2HQeYI=;
        b=MN6an4cIRQ9sZQoJYXv5vW7gkVCCttLU4CSJzJH3E85RVN1qwfwwoclzJwZtfZgHHw
         b/laQ1wop98tPqCmiLLg092lzs0Pks56JAUlM7NfKkFkCIT6MZUNkruQg851Vi6sOfnF
         XLWaQACwF5BAbc/Gb7EIwLcOJoK8iJW/rGjNAysthY42ytggD2VMORkQ58kteXQUc6Hd
         mUMY9CugNz2eTEGrnMtrF0z7sIoJCWJt4yqCQVeXUXUYwRcjl11cXf1d97U5WcTp+Js9
         PM4bMOj/U692EHwfNkMeRtPlz/jiEhsDrnSQ1Jx3EWJBbBV8jhCJE9tIsCYJi9Hq9fuP
         CwCw==
X-Gm-Message-State: ABy/qLbhxiP5boy8DBowLr0dlp3AoMtWa8gB0lQQztsqaX7IPNqwxC07
        RBnImssBqP0hp5ZRXDyWi4Vb6s8AJ5VJK4b8o/I=
X-Google-Smtp-Source: APBJJlHJuMYSAMTZZClGEz5NR785dOjQIKU7YpcJh+77Cc2xMhnXxKru7xwtPhSSqWM0VcXdOqFehG4qO3WQ47kPaJc=
X-Received: by 2002:ac8:5808:0:b0:406:56cb:b617 with SMTP id
 g8-20020ac85808000000b0040656cbb617mr13227416qtg.53.1690765588579; Sun, 30
 Jul 2023 18:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230730024409.1738559-1-zhangshida@kylinos.cn>
In-Reply-To: <20230730024409.1738559-1-zhangshida@kylinos.cn>
From:   Stephen Zhang <starzhangzsd@gmail.com>
Date:   Mon, 31 Jul 2023 09:05:52 +0800
Message-ID: <CANubcdWBRHU1Jc+PtneaJ=YpDtoQtFhoxiNOgOVCM55VJF45TQ@mail.gmail.com>
Subject: Re: [PATCH v2] ext4: Fix rec_len verify error
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-kernel@vger.kernel.org, zhangshida@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zhangshida <starzhangzsd@gmail.com> =E4=BA=8E2023=E5=B9=B47=E6=9C=8830=E6=
=97=A5=E5=91=A8=E6=97=A5 10:44=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Shida Zhang <zhangshida@kylinos.cn>
>
> With the configuration PAGE_SIZE 64k and filesystem blocksize 64k,
> a problem occurred when more than 13 million files were directly created
> under a directory:
>
> EXT4-fs error (device xx): ext4_dx_csum_set:492: inode #xxxx: comm xxxxx:=
 dir seems corrupt?  Run e2fsck -D.
> EXT4-fs error (device xx): ext4_dx_csum_verify:463: inode #xxxx: comm xxx=
xx: dir seems corrupt?  Run e2fsck -D.
> EXT4-fs error (device xx): dx_probe:856: inode #xxxx: block 8188: comm xx=
xxx: Directory index failed checksum
>
> When enough files are created, the fake_dirent->reclen will be 0xffff.
> it doesn't equal to the blocksize 65536, i.e. 0x10000.
>
> But it is not the same condition when blocksize equals to 4k.
> when enough file are created, the fake_dirent->reclen will be 0x1000.
> it equals to the blocksize 4k, i.e. 0x1000.
>
> The problem seems to be related to the limitation of the 16-bit field
> when the blocksize is set to 64k. To address this, Modify the check so
> as to handle it properly.
>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> ---
> v1->v2:
>   Use a better way to check the condition, as suggested by Andreas.
>
>  fs/ext4/namei.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 0caf6c730ce3..fffed95f8531 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -445,8 +445,9 @@ static struct dx_countlimit *get_dx_countlimit(struct=
 inode *inode,
>         struct ext4_dir_entry *dp;
>         struct dx_root_info *root;
>         int count_offset;
> +       int blocksize =3D EXT4_BLOCK_SIZE(inode->i_sb);
>
> -       if (le16_to_cpu(dirent->rec_len) =3D=3D EXT4_BLOCK_SIZE(inode->i_=
sb))
> +       if (ext4_rec_len_from_disk(dirent->rec_len, blocksize) =3D=3D blo=
cksize)
>                 count_offset =3D 8;
>         else if (le16_to_cpu(dirent->rec_len) =3D=3D 12) {
>                 dp =3D (struct ext4_dir_entry *)(((void *)dirent) + 12);
> --
> 2.27.0
>

Sorry, this one seems to missing Ccing to linux-ext4@vger.kernel.org.

-Shida
