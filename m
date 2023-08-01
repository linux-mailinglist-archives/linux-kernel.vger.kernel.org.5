Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4AA276C086
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 00:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjHAWp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 18:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjHAWpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 18:45:54 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E24F12B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 15:45:53 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-7870821d9a1so197671241.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 15:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690929952; x=1691534752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OdPkX0CC2VjYJ8VMcmkz2D7hthuzhQQ3AXRrePA3BM=;
        b=t2+9tyXaGpOdn04QANqvLNXV+epcnvNM+l6id6wvpktsmc5++GScBtJNivcq8glPtp
         Hbq+8fNhuiLvGxs6BtoGMy3GZNSTXRLhouIaapZLUJchFz579SV56lBhZFNQYphKDafv
         DjwZqSJb/izBo0Jrm7IltsIDgFEtHucJmE2m8asF6E7pq0XIeOc+bCVNM/zbFA5A+iU+
         Lu9ZDZePX5t1EUn4UdhaV69dio+X9Wwrwix1jV41roWL6MMu4YYWH3r/w9vjK5uP8yQ1
         vsxg1Y8kJw2JM2e/SbZOcXprK4gBkQAogV8Ms7NEMDjWn0c895bQYeIvGotH4XHfzcPx
         laDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690929952; x=1691534752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4OdPkX0CC2VjYJ8VMcmkz2D7hthuzhQQ3AXRrePA3BM=;
        b=YKyvcSKRGF6bwKeBxN0AhPnR4HjgYf/OD11o/3He0mHn5SQa924K/FyP810Gi2W+VT
         APh2JSlvnhTSqh3TMZEzW6A420UuXIu8wuOYg7s8FO6mzILy8ktXuxoaKAZYrYyTQDBx
         o3UArlvvo7YtnN27HYx2/OZ67enrGoPzT9qW4y//51xCrObYtdNQOMJlVRYASHF8KqmE
         FfTesdTy338h+AKYz2l4glhaiqZ6wV+we5spOcshOIGvClMXfRJLJWzBwMZ3w3IPhlVG
         voZmGYSd57V6sfRZU3DCZzUCup7a7gbP3QohQ7GFSFZGzAL0o9bSmBzuTplaikBlkmoq
         N+5Q==
X-Gm-Message-State: ABy/qLZ+nuFLX6umbf+NW8hASqnO+QNSygE5BuXOqVVct+JdA3aH34Xp
        m7Y4EfPgKwVg1WK2/Wttrwp/3B0vRtsDE9qxgCc60A==
X-Google-Smtp-Source: APBJJlHpgfpyTAtn7Azsg5rnKPsrEbhD57+ZqKzUUvZ8dViu3PgYhN+OuVad3AX+Gef/CwN0k4mzRRLvp+8kylWiu9o=
X-Received: by 2002:a05:6102:1347:b0:443:79be:e529 with SMTP id
 j7-20020a056102134700b0044379bee529mr1744162vsl.11.1690929952134; Tue, 01 Aug
 2023 15:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230801-bitwise-v1-1-799bec468dc4@google.com>
In-Reply-To: <20230801-bitwise-v1-1-799bec468dc4@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 1 Aug 2023 15:45:40 -0700
Message-ID: <CAKwvOdk03FoKQ6g09rffj_mtwYHbL15_ctiuBo2Cno6WDvkSkg@mail.gmail.com>
Subject: Re: [PATCH] word-at-a-time: use the same return type for has_zero
 regardless of endianness
To:     Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
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

On Tue, Aug 1, 2023 at 3:22=E2=80=AFPM <ndesaulniers@google.com> wrote:
>
> Compiling big-endian targets with Clang produces the diagnostic:
>
> fs/namei.c:2173:13: warning: use of bitwise '|' with boolean operands
> [-Wbitwise-instead-of-logical]
> } while (!(has_zero(a, &adata, &constants) | has_zero(b, &bdata, &constan=
ts)));
>           ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
>                                            ||
> fs/namei.c:2173:13: note: cast one or both operands to int to silence
> this warning
>
> It appears that when has_zero was introduced, two definitions were
> produced with different signatures (in particular different return types)=
.
>
> Looking at the usage in hash_name() in fs/namei.c, I suspect that
> has_zero() is meant to be invoked twice per while loop iteration; using
> logical-or would not update `bdata` when `a` did not have zeros. So I
> think it's preferred to always return an unsigned long rather than a
> bool then update the while loop in hash_name() to use a logical-or

s/then/than/

> rather than bitwise-or.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1832
> Fixes: 36126f8f2ed8 ("word-at-a-time: make the interfaces truly generic")
> Debugged-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  include/asm-generic/word-at-a-time.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/asm-generic/word-at-a-time.h b/include/asm-generic/w=
ord-at-a-time.h
> index 20c93f08c993..95a1d214108a 100644
> --- a/include/asm-generic/word-at-a-time.h
> +++ b/include/asm-generic/word-at-a-time.h
> @@ -38,7 +38,7 @@ static inline long find_zero(unsigned long mask)
>         return (mask >> 8) ? byte : byte + 1;
>  }
>
> -static inline bool has_zero(unsigned long val, unsigned long *data, cons=
t struct word_at_a_time *c)
> +static inline unsigned long has_zero(unsigned long val, unsigned long *d=
ata, const struct word_at_a_time *c)
>  {
>         unsigned long rhs =3D val | c->low_bits;
>         *data =3D rhs;
>
> ---
> base-commit: 18b44bc5a67275641fb26f2c54ba7eef80ac5950
> change-id: 20230801-bitwise-7812b11e5fb7
>
> Best regards,
> --
> Nick Desaulniers <ndesaulniers@google.com>
>


--=20
Thanks,
~Nick Desaulniers
