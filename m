Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1290D797A8D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245239AbjIGRok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243159AbjIGRoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:44:39 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63BF10F1;
        Thu,  7 Sep 2023 10:44:15 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6bf58009a8dso861555a34.1;
        Thu, 07 Sep 2023 10:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694108655; x=1694713455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMuPz+Z8VHaiaFn2Ii58q0kIyXx2k0/qmeW5JC5oah4=;
        b=rLRW/VH1E9LSa0IuTq6+rkh4aLupgvqHqXuLnG1ibYTBlJzQQCoLb5QgtTnYnOY8Fj
         FR/yVerUsuJzfC9tCeymEsxetKaP8fN7aL9NmT6dRHjQg6ecAEs6FkJ3lk4wyJZLg/x2
         JWFvDPlzE0lj4nxwM1mtmNGqUwcCHVvrbLjBjGYKlFKWUDaUZ5Oe4lv9eVgszH28QIgS
         qlEycxYeKW01ayCxTq9wljNM57+0MhIuwjIDasdQTe/P2d1++UmkRTo2aF/lN8XkBAd1
         MfzWWb/9ILpRpPQQ6018HuBMSJxBPZR2elLusjSf05ALkjOvAcLs8wBFZQL+oRZPxXD/
         Uh1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694108655; x=1694713455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iMuPz+Z8VHaiaFn2Ii58q0kIyXx2k0/qmeW5JC5oah4=;
        b=toGfHz8Nx0KDI+MyWu6FpMHbAT/OLGJxkTXkYTzxLKfxTjHAwpAFGTO0vpCmZTYMeg
         k5UUUNjZr7oc6FQAYY5z5Eoj62r8IAJS1MTt2lr0+N3biLVRKNhkk7DX00E7hO2pe0wn
         8Al37zLkeqxMp4leF36d0WrtZwuL3mOo7I5E2DtM0T23ixKBsycWmHWzl1A456/7Drcs
         TZta1mX4pjvOYBmcj22xS9TZhUzLS6w170l7ln2KLmB3p+FcCnbzAUuLGAou5335O7mu
         fI+jFsrujA1gcSL45RjVjGyL1SX7RNQJ5ZRZs1NkCoUlVX50xQ5OCacMXprl1wHVIWJP
         e/Kw==
X-Gm-Message-State: AOJu0Yw8+0BwcQkScW1Zio2sEFW4XhHgfI5RItVVyKr7Ei71gK3Yd9ob
        s9dLqG1yNEgHaQOoPmlZPWhpb+eJoNXJ0+u2PSA=
X-Google-Smtp-Source: AGHT+IEBqq0QGfiPYyYpcjuaYCPDOLD0ITz5tjyOTf4pd5s1iNr18iYFJk4aLMaGin9WQSfJK7HXm9buQbypUXECVtY=
X-Received: by 2002:a9d:7b57:0:b0:6bd:b0c9:a89 with SMTP id
 f23-20020a9d7b57000000b006bdb0c90a89mr57776oto.2.1694108654848; Thu, 07 Sep
 2023 10:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230818151220.166215-1-cgzones@googlemail.com> <20230818151220.166215-5-cgzones@googlemail.com>
In-Reply-To: <20230818151220.166215-5-cgzones@googlemail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 7 Sep 2023 13:44:04 -0400
Message-ID: <CAEjxPJ53LiT79=0L81QVgmfW+yKC6Fyq=sd0o1xF8ginCQjSew@mail.gmail.com>
Subject: Re: [PATCH 6/6] selinux: improve symtab string hashing
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
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

On Fri, Aug 18, 2023 at 11:12=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The number of buckets is calculated by performing a binary AND against
> the mask of the hash table, which is one less than its size (which is a
> power of two).  This leads to all top bits being discarded, requiring
> for short or similar inputs a hash function with a good avalanche
> effect.
>
> Use djb2a:
>
>     # current
>     common prefixes:  7 entries and 5/8 buckets used, longest chain lengt=
h 2, sum of chain length^2 11
>     classes:  134 entries and 100/256 buckets used, longest chain length =
5, sum of chain length^2 234
>     roles:  15 entries and 6/16 buckets used, longest chain length 5, sum=
 of chain length^2 57
>     types:  4448 entries and 3016/8192 buckets used, longest chain length=
 41, sum of chain length^2 14922
>     users:  7 entries and 3/8 buckets used, longest chain length 3, sum o=
f chain length^2 17
>     bools:  306 entries and 221/512 buckets used, longest chain length 4,=
 sum of chain length^2 524
>     levels:  1 entries and 1/1 buckets used, longest chain length 1, sum =
of chain length^2 1
>     categories:  1024 entries and 400/1024 buckets used, longest chain le=
ngth 4, sum of chain length^2 2740
>
>     # patch
>     common prefixes:  7 entries and 5/8 buckets used, longest chain lengt=
h 2, sum of chain length^2 11
>     classes:  134 entries and 101/256 buckets used, longest chain length =
3, sum of chain length^2 210
>     roles:  15 entries and 9/16 buckets used, longest chain length 3, sum=
 of chain length^2 31
>     types:  4448 entries and 3459/8192 buckets used, longest chain length=
 5, sum of chain length^2 6778
>     users:  7 entries and 5/8 buckets used, longest chain length 3, sum o=
f chain length^2 13
>     bools:  306 entries and 236/512 buckets used, longest chain length 5,=
 sum of chain length^2 470
>     levels:  1 entries and 1/1 buckets used, longest chain length 1, sum =
of chain length^2 1
>     categories:  1024 entries and 518/1024 buckets used, longest chain le=
ngth 7, sum of chain length^2 2992
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/symtab.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/security/selinux/ss/symtab.c b/security/selinux/ss/symtab.c
> index 43d7f0319ccd..b6761b96eee4 100644
> --- a/security/selinux/ss/symtab.c
> +++ b/security/selinux/ss/symtab.c
> @@ -11,16 +11,14 @@
>
>  static unsigned int symhash(const void *key)
>  {
> -       const char *p, *keyp;
> -       unsigned int size;
> -       unsigned int val;
> -
> -       val =3D 0;
> -       keyp =3D key;
> -       size =3D strlen(keyp);
> -       for (p =3D keyp; (p - keyp) < size; p++)
> -               val =3D (val << 4 | (val >> (8*sizeof(unsigned int)-4))) =
^ (*p);
> -       return val;
> +       /* djb2a */

Do we need/want something that specifies the author/license (I assume
public domain) of this code?

> +       unsigned int hash =3D 5381;
> +       unsigned char c;
> +
> +       while ((c =3D *(const unsigned char *)key++))
> +               hash =3D ((hash << 5) + hash) ^ c;
> +
> +       return hash;
>  }
>
>  static int symcmp(const void *key1, const void *key2)
> --
> 2.40.1
>
