Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD4976B98F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 18:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjHAQTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 12:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjHAQTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 12:19:11 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4326D10CA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 09:19:07 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-63d058b9cafso38342616d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 09:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690906746; x=1691511546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bO4EMps/8stuDZiI8Gpdidb8h9+MIAhmvaNg3KYj1s=;
        b=o4UnwJgpk8yeTzZUK1FZTs65eYsnacdGTDhjwzMy+DqQRhE2jTupyokcvRFqP1MKuo
         qAu+yNtKzWXdHC5YGT3qGXgvBJ0yvodc24S05t5lVNoUZlrjld+c3ZYg84ALagFSl5E1
         0e1IPmRVyqT2GVIRYdARMkHo0CkuvhYNhdAmnof9UiM53aClnQ1FS5ZSzeTK2gVSd53B
         063XdvfBsZ51WyTLXABYzSrXYL1XyijHBazCJn4+IrTGw38FuZoFnqi2U6TZNyoEfv5r
         ytN07iG/2nB0AbEtc586oI3xWMZoIT8TzfHqCOMBm0ZBpqNjIRXHSeGMlbbE1pfY9N/D
         MP5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690906746; x=1691511546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9bO4EMps/8stuDZiI8Gpdidb8h9+MIAhmvaNg3KYj1s=;
        b=WUs2/OoKNd0xBXwFR1ei/oy3R2m8oo6utxRijLe/orMYAutUSWujgp2yskAhFkG40a
         0mdK0bbE8Egp2EEzNvo06uqSk8dxj5Pz3V+CknZV5jMz+99kgDePljYoJSoNsPr9H4A+
         ZsDhngUIcCUvuT1P0Ri4Szz6tCYfXytVbdTXZ+dFSiGfd0u9A2Y3Mm4/3zaiXDmYj2CG
         dPa5Tp2quqq+oFK5r8wrcuGBWDZ9qioRo+pMk/eGn2u7UW8gqIO1j3nB0DNssfn6lbGc
         6psqk9I7jvwVwZmrezI5+rxkULyoVWfDDfbEE9WXpMH20LiQPIcbubojWNbz1QnuI4l4
         Ixsg==
X-Gm-Message-State: ABy/qLanzxOlepyj3jYCKTucalSvz/U0tS6Tqn5VYALm8gwWI/sp5TCT
        1VwjcBShb7bYh+3LEgtRsTo+wfgernqzTGxkpaJqtA==
X-Google-Smtp-Source: APBJJlExjHsbEshbD/7fM07TlWTefBlG0GYpx+aMVrkgKVZzEhxPirjTfZFjF6Rla5/eWjDqzfKNP/t4CWrr7MCsFFs=
X-Received: by 2002:ad4:5847:0:b0:635:fa7b:6c22 with SMTP id
 de7-20020ad45847000000b00635fa7b6c22mr10424824qvb.55.1690906745972; Tue, 01
 Aug 2023 09:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230725043310.1227621-1-suhui@nfschina.com>
In-Reply-To: <20230725043310.1227621-1-suhui@nfschina.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 1 Aug 2023 09:18:55 -0700
Message-ID: <CAKwvOdn2Qn219Ys6vyR0Xryi_32XTARBWsfmuc3zhdH8TLREWQ@mail.gmail.com>
Subject: Re: [PATCH v2] ext4: mballoc: avoid garbage value from err
To:     Su Hui <suhui@nfschina.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, nathan@kernel.org,
        trix@redhat.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 9:34=E2=80=AFPM Su Hui <suhui@nfschina.com> wrote:
>
> clang's static analysis warning: fs/ext4/mballoc.c
> line 4178, column 6, Branch condition evaluates to a garbage value.
>
> err is uninitialized and will be judged when 'len <=3D 0' or
> it first enters the loop while the condition "!ext4_sb_block_valid()"
> is true. Although this can't make problems now, it's better to
> correct it.
>
> Signed-off-by: Su Hui <suhui@nfschina.com>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
> v2:
>  - modify commit message
>
>  fs/ext4/mballoc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 21b903fe546e..769000c970b0 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4084,7 +4084,7 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_f=
sblk_t block,
>         struct ext4_sb_info *sbi =3D EXT4_SB(sb);
>         ext4_group_t group;
>         ext4_grpblk_t blkoff;
> -       int i, err;
> +       int i, err =3D 0;
>         int already;
>         unsigned int clen, clen_changed, thisgrp_len;
>
> --
> 2.30.2
>


--=20
Thanks,
~Nick Desaulniers
