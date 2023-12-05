Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22AD804822
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 04:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjLEDqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 22:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjLEDqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 22:46:04 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96431D5;
        Mon,  4 Dec 2023 19:46:10 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-67ac4fc7217so12931826d6.0;
        Mon, 04 Dec 2023 19:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701747969; x=1702352769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jg6rTNWBMwsjipN+E71IGBGvENV2ioiceBuyhFpWrbw=;
        b=evvFv7qEeXdLzBU59s6sjBCru4bt4w2p5lOoXr7LVwBzVjcyh/EpUZpXZrDCD+osvl
         Dt/c0rCn7er9MU99jcgybPFLBkh5F2NXXOK1ETn/Nfi80NP4712BkeNNnZwumwj5xreN
         I9XG8VU3OYc6NNhB88feDxAaVUFmypXZjw8bzd8emlrGWrHHnfhpWdszRnZiDQQ3AZP9
         DUPyJcRa+Y+FeKow7YLlv/TlbbTiAWBaypYygQUBayPKg8i0cwa7m3X3rhDAvA/VWv+2
         THfakoTnwkJus5KBzI0HATCbluij7rYzSInZdK8mZ3NEMmUBrMoAC3gpuScNHp7aBZS2
         5WlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701747969; x=1702352769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jg6rTNWBMwsjipN+E71IGBGvENV2ioiceBuyhFpWrbw=;
        b=YIzzzTRb6HlgaGXtK/o7wj9JpuDUmDtjVfR9PAfXdMRDNOfP4SOdb4PKExfql5WMs4
         H9MiX4pNZoSvHzaUCHTMbdtubUJ+7/ZxVYqCl3qE38aiXdbQ4Vilu8jcB8QTPjpFtmca
         fMsgKxzRjgLjUjcHzT2BjlhsPEeK0EvvrxR7RG98jfSW2IZap+/zyP4cABoCibK/ZDQ5
         Il6NO3aBeQzBPaBX9XzUe0urRW4/71yJPQ7eJlZutnpBcBsHFXDZ1FuhKv00XnsxSrGs
         DHyEpcjU/ifrTijOKHSXFWNWAT13QGHL1bMq+48HTpipQireneDLG41Q/eEpik+7nT2/
         8Yxg==
X-Gm-Message-State: AOJu0YwFd27ONooV73fOC7mIjRZ9mOyaL9sRqZG9QDfohWcXAb35ecdy
        Qd6mEidcDAq/Lq08eC1enUi6nzeLr3Rnk/T92nCoRTNFGvQ=
X-Google-Smtp-Source: AGHT+IGcgNKJwG3kLPMY0x6CmB2jQk6fPYVXN0wEo5GyARPqapoSFhNttNXCaGPn+W6gFd6GrrOctQP6LSmCvkW2Di4=
X-Received: by 2002:a0c:f842:0:b0:67a:a89e:41a with SMTP id
 g2-20020a0cf842000000b0067aa89e041amr768215qvo.76.1701747969573; Mon, 04 Dec
 2023 19:46:09 -0800 (PST)
MIME-Version: 1.0
References: <20231130141624.3338942-4-amir73il@gmail.com> <20231205001620.4566-1-spasswolf@web.de>
In-Reply-To: <20231205001620.4566-1-spasswolf@web.de>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 5 Dec 2023 05:45:57 +0200
Message-ID: <CAOQ4uxiw8a+zh-x2a+A+EEZOFj1KYrBQucCvDv6s9w0XeDW-ZA@mail.gmail.com>
Subject: Re: [PATCH] fs: read_write: make default in vfs_copy_file_range() reachable
To:     Bert Karwatzki <spasswolf@web.de>,
        Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, axboe@kernel.dk, dhowells@redhat.com,
        hch@lst.de, jlayton@kernel.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, miklos@szeredi.hu,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
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

On Tue, Dec 5, 2023 at 2:16=E2=80=AFAM Bert Karwatzki <spasswolf@web.de> wr=
ote:
>
> If vfs_copy_file_range() is called with (flags & COPY_FILE_SPLICE =3D=3D =
0)
> and both file_out->f_op->copy_file_range and file_in->f_op->remap_file_ra=
nge
> are NULL, too, the default call to do_splice_direct() cannot be reached.
> This patch adds an else clause to make the default reachable in all
> cases.
>
> Signed-off-by: Bert Karwatzki <spasswolf@web.de>

Hi Bert,

Thank you for testing and reporting this so early!!

I would edit the commit message differently, but anyway, I think that
the fix should be folded into commit 05ee2d85cd4a ("fs: use
do_splice_direct() for nfsd/ksmbd server-side-copy").

Since I end up making a mistake every time I touch this code,
I also added a small edit to your patch below, that should make the logic
more clear to readers. Hopefully, that will help me avoid making a mistake
the next time I touch this code...

Would you mind testing my revised fix, so we can add:
  Tested-by: Bert Karwatzki <spasswolf@web.de>
when folding it into the original patch?

Thanks,
Amir.

> ---
>  fs/read_write.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/read_write.c b/fs/read_write.c
> index e0c2c1b5962b..3599c54bd26d 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1554,6 +1554,8 @@ ssize_t vfs_copy_file_range(struct file *file_in, l=
off_t pos_in,
>                 /* fallback to splice */
>                 if (ret <=3D 0)
>                         splice =3D true;
> +       } else {

This is logically correct because of the earlier "same sb" check in
generic_copy_file_checks(), but we better spell out the logic here as well:

+            } else if (file_inode(file_in)->i_sb =3D=3D
file_inode(file_out)->i_sb) {
+                    /* Fallback to splice for same sb copy for
backward compat */

> +               splice =3D true;
>         }
>
>         file_end_write(file_out);
> --
> 2.39.2
>
> Since linux-next-20231204 I noticed that it was impossible to start the
> game Path of Exile (using the steam client). I bisected the error to
> commit 05ee2d85cd4ace5cd37dc24132e3fd7f5142ebef. Reverting this commit
> in linux-next-20231204 made the game start again and after inserting
> printks into vfs_copy_file_range() I found that steam (via python3)
> calls this function with (flags & COPY_FILE_SPLICE =3D=3D 0),
> file_out->f_op->copy_file_range =3D=3D NULL and
> file_in->f_op->remap_file_range =3D=3D NULL so the default is never reach=
ed.
> This patch adds a catch all else clause so the default is reached in
> all cases. This patch fixes the describe issue with steam and Path of
> Exile.
>
> Bert Karwatzki
