Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977BF7E0DBC
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 05:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344801AbjKDD5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 23:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbjKDD5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 23:57:47 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9607D71;
        Fri,  3 Nov 2023 20:57:41 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-777719639adso164778185a.3;
        Fri, 03 Nov 2023 20:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699070261; x=1699675061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWhGUunWhxUTuSWanhab2prz9GQ9mAMBfZZdeTV0d7A=;
        b=kUf9bz6d/iq6dHSRF5SFuX8ftL/4abrNh6TZRAO7/MiciaYjB5EwBglbGIIz4ptcx2
         GLauZMZaU36OCTb4KSwBsyZFrPBh5Wzz3dkwAryGGF2CuVKq6qj0fzmCZxy+vL8q+E7D
         n0RwR12bQHimUUfZKqG5+Zy2wHSYvVYu5IkIj5qq89WMmoroqNp/etMLhzyF7VxKQmjk
         bn0xODDstmvA3xxPKKQNyzwjCosc41Ddoo2h3q3SWsLlXCwKldadttEUXW5i4GjZADRb
         +PAJP7V2HkGcilBS9kkm0QT/hoGgmaxDCdPCZET1j7CVN2MX6Wg+4j/x8Crux4sY2VgP
         UJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699070261; x=1699675061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pWhGUunWhxUTuSWanhab2prz9GQ9mAMBfZZdeTV0d7A=;
        b=qHZhKgMrh/oyaWafodrxdLxlRDW/Dfej9KeTyNxUIKPKGGUu1CU4Pk8LwXAQrGEQwQ
         X03M5cQ4GgMH9mwOmxoalDrJXsqBeemv3aQQ3ZRrPbTmo9FEHZt7ij2MTiUuLOjHD7Cc
         SmXU0Sua/IoCufAWiTRzUosFNZScaG4sz3ObVKYvAfZo/fb21XKW9QUuq+uxx3f+gCvk
         8o3p9Tfju/+drqgp5WWKh49AtTG0E1+V/lg2ZEOdoYLto7CPt5NdCAEqD3VYCPOe9ACF
         lHdeg+ICtLa6ULlpcRiNu7SasRR/MXFqSz1dH9o9ESVPJEqcmKGUPiX4YEC8kLnLJ4py
         G5jQ==
X-Gm-Message-State: AOJu0YwxeppJhyZq0v92b7xk0tH0XMNCxtApsy9CX5rMGDkSS8UPSobI
        ppF4oDCmdPmRmjqooSUqN+iz0N+eFzbN7AOxE7/B4QwHnp4=
X-Google-Smtp-Source: AGHT+IEJWbO5SCDFS/PmNlgjmH1yPMZE3KW5hdhtf9cMHoNaO6Oca6hJVwNtOOAtjenVe1f5dVO1DfH9bsLcbbY8I/Q=
X-Received: by 2002:a05:620a:45a3:b0:774:3235:4e6d with SMTP id
 bp35-20020a05620a45a300b0077432354e6dmr28193713qkb.21.1699070260685; Fri, 03
 Nov 2023 20:57:40 -0700 (PDT)
MIME-Version: 1.0
References: <20231103184831.99406-2-pstanner@redhat.com>
In-Reply-To: <20231103184831.99406-2-pstanner@redhat.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Sat, 4 Nov 2023 12:57:24 +0900
Message-ID: <CAKFNMona2dYnMpEoQMPatEJrPW2qkkdCnnsRzvNcwsxrakyPOQ@mail.gmail.com>
Subject: Re: [PATCH v2] fs/nilfs2: use standard array-copy-function
To:     Philipp Stanner <pstanner@redhat.com>
Cc:     linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dave Airlie <airlied@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 4, 2023 at 3:49=E2=80=AFAM Philipp Stanner wrote:
>
> ioctl.c utilizes memdup_user() to copy a userspace array. An overflow
> check is performed manually before the function's invocation.
>
> The new function memdup_array_user() standardizes copying userspace
> arrays, thus, improving readability by making it more clear that an
> array is being copied. Additionally, it also performs an overflow check.
>
> Remove the (now redundant) manual overflow-check and replace
> memdup_user() with memdup_array_user().
>
> In addition, improve the grammar of the comment above
> memdup_array_user().
>
> Suggested-by: Dave Airlie <airlied@redhat.com>
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
> Changes in v2:
> - Rename + rephrase commit so that it's clear that this is a
>   cleanup-patch.
> - Mention the grammar improvement of the comment in the commit message.
> - Remove the preceding manual overflow-check, since that is now
>   redundant.
> ---
>  fs/nilfs2/ioctl.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
> index 40ffade49f38..cfb6aca5ec38 100644
> --- a/fs/nilfs2/ioctl.c
> +++ b/fs/nilfs2/ioctl.c
> @@ -872,16 +872,14 @@ static int nilfs_ioctl_clean_segments(struct inode =
*inode, struct file *filp,
>         nsegs =3D argv[4].v_nmembs;
>         if (argv[4].v_size !=3D argsz[4])
>                 goto out;
> -       if (nsegs > UINT_MAX / sizeof(__u64))
> -               goto out;
>
>         /*
>          * argv[4] points to segment numbers this ioctl cleans.  We
> -        * use kmalloc() for its buffer because memory used for the
> -        * segment numbers is enough small.
> +        * use kmalloc() for its buffer because the memory used for the
> +        * segment numbers is small enough.
>          */
> -       kbufs[4] =3D memdup_user((void __user *)(unsigned long)argv[4].v_=
base,
> -                              nsegs * sizeof(__u64));
> +       kbufs[4] =3D memdup_array_user((void __user *)(unsigned long)argv=
[4].v_base,
> +                                    nsegs, sizeof(__u64));
>         if (IS_ERR(kbufs[4])) {
>                 ret =3D PTR_ERR(kbufs[4]);
>                 goto out;
> --
> 2.41.0
>

Looks good.  Also, thank you for your detailed changelog.
As mentioned earlier, I will handle this for the next cycle.

Thanks,
Ryusuke Konishi
