Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495AA7AD45F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbjIYJSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbjIYJSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:18:45 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBD9C0;
        Mon, 25 Sep 2023 02:18:38 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-7870821d9a1so4083076241.1;
        Mon, 25 Sep 2023 02:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695633517; x=1696238317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BFL2+1dOPDuK81BwsgyUY35mlJW/J7ln5D7kWMysTk=;
        b=DJr/tYnSAJSrBt3S7wprYru5IqNuAHJVryDtp546qHLoG8KGYEZQz2+ydko/yAzO6T
         k1dJxdT/GBEYhcey1ZFdB1N3DRhEYGobS/kUE69I51s0NJxGTCwk2WlKDBHOaWKnP8el
         i+ue1kP44ljkrkxrORO5eHh7n02lokYx6pTatXoqqHSWG+L8CqJx568l6oK9fp3GMed0
         YLoytvF2xfTadJCfxnrYUCG+Xdf51FjHowbW/OsU34WmCLwIPzGQI5MO3wtN7UwnVTyO
         R3WgKDFvuPTRNaX4jIEIljQaRwE/dSqnoLiwokW+N3VqYRcQV/tE3XrDi2C3emqRm20d
         5Psg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695633517; x=1696238317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3BFL2+1dOPDuK81BwsgyUY35mlJW/J7ln5D7kWMysTk=;
        b=VvMq/PiMIOBZwZYqz8QCoaOZcd6oL5ZeiKDMYZyDd1vXcb+dL3ecwou3CDLImSKSVF
         pzT07BVonxtjPbWFfSO6MAc3vWxo3hH0ClrGLH/ST1Pvhey0e7liydLZsU2u4zrO9cBh
         p+jEAAES8UMBO+0c2nkxUPegxq3yrWaHPqkaWngPqcPALofccCv6lXXMFln+8mfwkXNp
         BWtXgVFuZwdKnkkXajkpnm6gXL0kXzsjb4eVWdX9NtUqk7wO+RuAEFeAyft3nnbmFoXR
         jCnpzvIgvNUBvpSJVtUi+rhtuh0+mNVwpmzumuW/VGQ13EF8pO6bVTyMxI6OK9xMTae0
         ZlYg==
X-Gm-Message-State: AOJu0Yz6LPhweSFtZ0XXglYjXOGqrEeCQmQRFs061TaHOnVqYdiKbJYl
        EwUoAf6w9mzAvnry00BvwNGqIkZ1XjdamNkyed8=
X-Google-Smtp-Source: AGHT+IHlfc+LLcOAb0pLXcmP5zri6tIaUbrPUeezw1TobtmZe6+W08FTH13dzozKQGIEnRyeLk6h9niE9cGdPTJrBzA=
X-Received: by 2002:a05:6102:2c86:b0:452:6478:3e24 with SMTP id
 if6-20020a0561022c8600b0045264783e24mr4673292vsb.12.1695633517574; Mon, 25
 Sep 2023 02:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <71897125-e570-46ce-946a-d4729725e28f@kernel.dk>
In-Reply-To: <71897125-e570-46ce-946a-d4729725e28f@kernel.dk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 25 Sep 2023 12:18:26 +0300
Message-ID: <CAOQ4uxj7hC5iGfJSD35xAGC97x32y9nnKk8qJa8ux6owpgT1wQ@mail.gmail.com>
Subject: Re: [PATCH] ovl: disable IOCB_DIO_CALLER_COMP
To:     Jens Axboe <axboe@kernel.dk>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-unionfs@vger.kernel.org,
        Zorro Lang <zlang@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 9:21=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
> overlayfs copies the kiocb flags when it sets up a new kiocb to handle
> a write, but it doesn't properly support dealing with the deferred
> caller completions of the kiocb. This means it doesn't get the final
> write completion value, and hence will complete the write with '0' as
> the result.
>
> We could support the caller completions in overlayfs, but for now let's
> just disable them in the generated write kiocb.
>
> Reported-by: Zorro Lang <zlang@redhat.com>
> Link: https://lore.kernel.org/io-uring/20230924142754.ejwsjen5pvyc32l4@de=
ll-per750-06-vm-08.rhts.eng.pek2.redhat.com/
> Fixes: 8c052fb3002e ("iomap: support IOCB_DIO_CALLER_COMP")
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>

Thanks for fixing this Jens!
If you or Christian want to send this fix to Linus, you have my ACK.

On the bright side, I am glad that you are aware of the overlayfs
"kiocb_clone" use case, which delegates/forwards the io request to
another file in another fs.

I have already posted an RFC [1] for moving this functionality to
common vfs code. My main goal was to expose it to other filesystem
(fuse), but a very desired side effect is that this functionality gets
more vfs reviewer eyes and then the chances of catching a regression
like this one during review of vfs changes hopefully increases.

As for test coverage, I need to check why my tests did not catch
this - I suspect fsx may not have been rebuilt with io_uring support,
but not sure (not near workstation atm).

If you would like to add overlayfs to your test coverage, as Zorro
explained, it is as simple as running ./check -overlay with your
existing fstests config.
./check -overlay is a relatively faster test run because many of the
tests do _notrun on overlayfs.
I don't have to tell you that io_uring code will end up running on
overlayfs in many container workloads, so it is not a niche setup.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20230912185408.3343163-1-amir73il=
@gmail.com/

> ---
>
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index 4193633c4c7a..693971d20280 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -391,6 +391,12 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, st=
ruct iov_iter *iter)
>         if (!ovl_should_sync(OVL_FS(inode->i_sb)))
>                 ifl &=3D ~(IOCB_DSYNC | IOCB_SYNC);
>
> +       /*
> +        * Overlayfs doesn't support deferred completions, don't copy
> +        * this property in case it is set by the issuer.
> +        */
> +       ifl &=3D ~IOCB_DIO_CALLER_COMP;
> +
>         old_cred =3D ovl_override_creds(file_inode(file)->i_sb);
>         if (is_sync_kiocb(iocb)) {
>                 file_start_write(real.file);
>
> --
> Jens Axboe
>
>
