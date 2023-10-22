Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF0D7D259E
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 21:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbjJVTjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 15:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJVTjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 15:39:12 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85308EE;
        Sun, 22 Oct 2023 12:39:10 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507a55302e0so3389798e87.0;
        Sun, 22 Oct 2023 12:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698003548; x=1698608348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqK68qL/LBpriR+Z38aMUAzm2thbKObKANRwoPFwvps=;
        b=ftf1xu8PThiMXuxYVjKyQX5b7aNkbcpMJTFITHq7i9u7TdPlirzhG3ciKet3ksww45
         XEUM/TPkROc0PEMSfuKYo2zinEkm8TK7wH5U+l7+r5yDkCSx3IEg9Li3DLjaw97ThKjD
         kOwLTZ2pQUR8jes22gYEWOb74FlknyR3y7odNIlSYZ8vVpFpox1PwNUy2C0WKZDI4pMf
         qhEnPRM3Uprpob002PHvVk2gIZGmZnXuaN79TFkwRzlhjwHLGR8RgQ2+DuTCLqReCnVd
         D/qfp8EukiV8aURlE1eljwXFccKGzqdGNlVf0T0TE+1kFrvJElcNaYx0zZELZaicusuI
         DuYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698003548; x=1698608348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dqK68qL/LBpriR+Z38aMUAzm2thbKObKANRwoPFwvps=;
        b=TxFRas2vgJnW4i7FemCZCYCz9sroS/G8N4QftHEknJTAYTnowKRQDDZNS7BM9C306t
         1e/L5qpDg747mqnX+XUfEKu06+3nn1jy2UE7HMMNuEdsdutEyuS446cSOQmstTIRmrRp
         FDUAqvzSlB4H3h7zLU5MBVPe6n/XUdscIaEKaO54uRC4Orph3CpX4qH0UugtX+DE1/bK
         GjObDpegezjAIzXqBvq79rLyt/6iQnW6kyp7416vchJjwQgjKccVsFxPEtNPPxJYzMVV
         4HReJqmAjbkG7Cx+YI4kzb0qQOMbLZmyJx4QHgvi4U8BY44f25pZbLMP+zPhE9QSEawq
         iLZA==
X-Gm-Message-State: AOJu0YwotP1NUO9WW0SGgrfXIggexbybPIiP4HqUpdMr70KMbuF+2WS1
        lrCscA1cg3/Lh86D5pcg1LVn2z1PuEL3xLjyCS4=
X-Google-Smtp-Source: AGHT+IFCVpNx/CwDrWgJlpgu+sGa9KHr+Cuvl10CkZ2YccNvsOmOZLZ9Rjt7wP5j2x0pImdPOsubw3hPx/365gw3aeY=
X-Received: by 2002:ac2:5dd0:0:b0:507:9fd8:832a with SMTP id
 x16-20020ac25dd0000000b005079fd8832amr4852646lfq.64.1698003547861; Sun, 22
 Oct 2023 12:39:07 -0700 (PDT)
MIME-Version: 1.0
References: <20231022183917.1013135-1-sanpeqf@gmail.com>
In-Reply-To: <20231022183917.1013135-1-sanpeqf@gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Sun, 22 Oct 2023 14:38:56 -0500
Message-ID: <CAH2r5mvAvXaXTWr8CWnVZcXa3tiU+ZfpBoo0tiY-RH194f2xow@mail.gmail.com>
Subject: Re: [PATCH] fs/smb: using crypto lib instead cifs_arc4
To:     John Sanpe <sanpeqf@gmail.com>
Cc:     stfrench@microsoft.com, linkinjeon@kernel.org, pc@manguebit.com,
        sprasad@microsoft.com, linux-cifs@vger.kernel.org,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I thought that the whole point of kernel crypto guys was the reverse -
ie arc4 must be moved to cifs.ko since cifs/smb3 mounts had the only
approved use case.  Ronnie may have additional context, but there was
a push to remove arc4 and md4 (see e.g. the emails threads about:
"crypto: remove MD4 generic shash").  I also want to be careful that
we don't accidentally disable smb3.1.1 mounts (which are highly
secure) because they have small dependencies on old algorithms (even
if that doesn't cause problems with typical reasonable length password
cases)

commit 71c02863246167b3d1639b8278681ca8ebedcb4e
Author: Ronnie Sahlberg <lsahlber@redhat.com>
Date:   Thu Aug 19 20:34:59 2021 +1000

    cifs: fork arc4 and create a separate module for it for cifs and other =
users

    We can not drop ARC4 and basically destroy CIFS connectivity for
    almost all CIFS users so create a new forked ARC4 module that CIFS and =
other
    subsystems that have a hard dependency on ARC4 can use.

On Sun, Oct 22, 2023 at 1:39=E2=80=AFPM John Sanpe <sanpeqf@gmail.com> wrot=
e:
>
> Replace internal logic with an independent arc4 library.
>
> Signed-off-by: John Sanpe <sanpeqf@gmail.com>
> ---
>  fs/smb/Kconfig              |  1 +
>  fs/smb/client/cifsencrypt.c |  7 ++--
>  fs/smb/common/Makefile      |  1 -
>  fs/smb/common/arc4.h        | 23 ------------
>  fs/smb/common/cifs_arc4.c   | 74 -------------------------------------
>  fs/smb/server/auth.c        |  6 +--
>  6 files changed, 7 insertions(+), 105 deletions(-)
>  delete mode 100644 fs/smb/common/arc4.h
>  delete mode 100644 fs/smb/common/cifs_arc4.c
>
> diff --git a/fs/smb/Kconfig b/fs/smb/Kconfig
> index ef425789fa6a..65e5a437898b 100644
> --- a/fs/smb/Kconfig
> +++ b/fs/smb/Kconfig
> @@ -7,5 +7,6 @@ source "fs/smb/server/Kconfig"
>
>  config SMBFS
>         tristate
> +       select CRYPTO_LIB_ARC4
>         default y if CIFS=3Dy || SMB_SERVER=3Dy
>         default m if CIFS=3Dm || SMB_SERVER=3Dm
> diff --git a/fs/smb/client/cifsencrypt.c b/fs/smb/client/cifsencrypt.c
> index ef4c2e3c9fa6..d8754c406b5f 100644
> --- a/fs/smb/client/cifsencrypt.c
> +++ b/fs/smb/client/cifsencrypt.c
> @@ -21,7 +21,7 @@
>  #include <linux/random.h>
>  #include <linux/highmem.h>
>  #include <linux/fips.h>
> -#include "../common/arc4.h"
> +#include <crypto/arc4.h>
>  #include <crypto/aead.h>
>
>  /*
> @@ -826,9 +826,8 @@ calc_seckey(struct cifs_ses *ses)
>                 return -ENOMEM;
>         }
>
> -       cifs_arc4_setkey(ctx_arc4, ses->auth_key.response, CIFS_SESS_KEY_=
SIZE);
> -       cifs_arc4_crypt(ctx_arc4, ses->ntlmssp->ciphertext, sec_key,
> -                       CIFS_CPHTXT_SIZE);
> +       arc4_setkey(ctx_arc4, ses->auth_key.response, CIFS_SESS_KEY_SIZE)=
;
> +       arc4_crypt(ctx_arc4, ses->ntlmssp->ciphertext, sec_key, CIFS_CPHT=
XT_SIZE);
>
>         /* make secondary_key/nonce as session key */
>         memcpy(ses->auth_key.response, sec_key, CIFS_SESS_KEY_SIZE);
> diff --git a/fs/smb/common/Makefile b/fs/smb/common/Makefile
> index c66dbbc1469c..9e0730a385fb 100644
> --- a/fs/smb/common/Makefile
> +++ b/fs/smb/common/Makefile
> @@ -3,5 +3,4 @@
>  # Makefile for Linux filesystem routines that are shared by client and s=
erver.
>  #
>
> -obj-$(CONFIG_SMBFS) +=3D cifs_arc4.o
>  obj-$(CONFIG_SMBFS) +=3D cifs_md4.o
> diff --git a/fs/smb/common/arc4.h b/fs/smb/common/arc4.h
> deleted file mode 100644
> index 12e71ec033a1..000000000000
> --- a/fs/smb/common/arc4.h
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> -/*
> - * Common values for ARC4 Cipher Algorithm
> - */
> -
> -#ifndef _CRYPTO_ARC4_H
> -#define _CRYPTO_ARC4_H
> -
> -#include <linux/types.h>
> -
> -#define ARC4_MIN_KEY_SIZE      1
> -#define ARC4_MAX_KEY_SIZE      256
> -#define ARC4_BLOCK_SIZE                1
> -
> -struct arc4_ctx {
> -       u32 S[256];
> -       u32 x, y;
> -};
> -
> -int cifs_arc4_setkey(struct arc4_ctx *ctx, const u8 *in_key, unsigned in=
t key_len);
> -void cifs_arc4_crypt(struct arc4_ctx *ctx, u8 *out, const u8 *in, unsign=
ed int len);
> -
> -#endif /* _CRYPTO_ARC4_H */
> diff --git a/fs/smb/common/cifs_arc4.c b/fs/smb/common/cifs_arc4.c
> deleted file mode 100644
> index 043e4cb839fa..000000000000
> --- a/fs/smb/common/cifs_arc4.c
> +++ /dev/null
> @@ -1,74 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * Cryptographic API
> - *
> - * ARC4 Cipher Algorithm
> - *
> - * Jon Oberheide <jon@oberheide.org>
> - */
> -
> -#include <linux/module.h>
> -#include "arc4.h"
> -
> -MODULE_LICENSE("GPL");
> -
> -int cifs_arc4_setkey(struct arc4_ctx *ctx, const u8 *in_key, unsigned in=
t key_len)
> -{
> -       int i, j =3D 0, k =3D 0;
> -
> -       ctx->x =3D 1;
> -       ctx->y =3D 0;
> -
> -       for (i =3D 0; i < 256; i++)
> -               ctx->S[i] =3D i;
> -
> -       for (i =3D 0; i < 256; i++) {
> -               u32 a =3D ctx->S[i];
> -
> -               j =3D (j + in_key[k] + a) & 0xff;
> -               ctx->S[i] =3D ctx->S[j];
> -               ctx->S[j] =3D a;
> -               if (++k >=3D key_len)
> -                       k =3D 0;
> -       }
> -
> -       return 0;
> -}
> -EXPORT_SYMBOL_GPL(cifs_arc4_setkey);
> -
> -void cifs_arc4_crypt(struct arc4_ctx *ctx, u8 *out, const u8 *in, unsign=
ed int len)
> -{
> -       u32 *const S =3D ctx->S;
> -       u32 x, y, a, b;
> -       u32 ty, ta, tb;
> -
> -       if (len =3D=3D 0)
> -               return;
> -
> -       x =3D ctx->x;
> -       y =3D ctx->y;
> -
> -       a =3D S[x];
> -       y =3D (y + a) & 0xff;
> -       b =3D S[y];
> -
> -       do {
> -               S[y] =3D a;
> -               a =3D (a + b) & 0xff;
> -               S[x] =3D b;
> -               x =3D (x + 1) & 0xff;
> -               ta =3D S[x];
> -               ty =3D (y + ta) & 0xff;
> -               tb =3D S[ty];
> -               *out++ =3D *in++ ^ S[a];
> -               if (--len =3D=3D 0)
> -                       break;
> -               y =3D ty;
> -               a =3D ta;
> -               b =3D tb;
> -       } while (true);
> -
> -       ctx->x =3D x;
> -       ctx->y =3D y;
> -}
> -EXPORT_SYMBOL_GPL(cifs_arc4_crypt);
> diff --git a/fs/smb/server/auth.c b/fs/smb/server/auth.c
> index 229a6527870d..5640196b313f 100644
> --- a/fs/smb/server/auth.c
> +++ b/fs/smb/server/auth.c
> @@ -29,7 +29,7 @@
>  #include "mgmt/user_config.h"
>  #include "crypto_ctx.h"
>  #include "transport_ipc.h"
> -#include "../common/arc4.h"
> +#include <crypto/arc4.h>
>
>  /*
>   * Fixed format data defining GSS header and fixed string
> @@ -362,9 +362,9 @@ int ksmbd_decode_ntlmssp_auth_blob(struct authenticat=
e_message *authblob,
>                 if (!ctx_arc4)
>                         return -ENOMEM;
>
> -               cifs_arc4_setkey(ctx_arc4, sess->sess_key,
> +               arc4_setkey(ctx_arc4, sess->sess_key,
>                                  SMB2_NTLMV2_SESSKEY_SIZE);
> -               cifs_arc4_crypt(ctx_arc4, sess->sess_key,
> +               arc4_crypt(ctx_arc4, sess->sess_key,
>                                 (char *)authblob + sess_key_off, sess_key=
_len);
>                 kfree_sensitive(ctx_arc4);
>         }
> --
> 2.41.0
>


--=20
Thanks,

Steve
