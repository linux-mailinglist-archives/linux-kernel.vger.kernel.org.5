Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783157583DA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 19:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbjGRRui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 13:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbjGRRue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 13:50:34 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD840C0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 10:50:33 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-635dd1b52a2so31416056d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 10:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689702633; x=1692294633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FakhO3efxXs79fOL17bUjDsDDzuXwblSHaFpqeVimdw=;
        b=bTuSMkUBvr4fylgeHAiAN25RP9JNHB7zTbDbqfWscsW2JgPB8o/8BeqWZQO/eXySTO
         slzdF+ITVkW8uOs8DMMyUiQdCVU1wjDg0vTuOvYmRLlVe9KNyOG3PNVGEEilR+9sUvxE
         VmqMGsuv3b9C0SNBB4uK3Og7dysZddca/g1zuNtjMVdk/r07Z2xTFkgTPL0VJAREIYmi
         28JrcRod5na0FQm1k1l8AEa2IshKh1vWVfPS5hpNUkb6YeLhVny8G+aJr49jF1mrjAdI
         sy2GvtCPN74I9Y4Ggd0UK+bW2+OhUDYsSytk/fWCG1oazheZguiZAS9aSVWUK2VdWYlp
         lnLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689702633; x=1692294633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FakhO3efxXs79fOL17bUjDsDDzuXwblSHaFpqeVimdw=;
        b=QoVNcU8N0qxyej7i07GG1ko+kPBLaN2EADvl6/vX5cGDwc6EivU7IxGERwDT+/kxBr
         znnfHJbCIuoylc9UoyupkFrSKlzklg/3WJAge5g7OCdOVqB5rprJ8i77LewKuwqIN37v
         4YTeqEvVKXUghGM7FKhjKWxx8RJZyw8oNnhU/IGcsjSeuWrbGkVUpTw+Cw2YaKu90VOk
         Ae+/01h8hJTWvp2T6hCCi3niH/8IpWw8AjYHiDfVoJUHNZqHhEL6RoSy4XX1JYU4cckW
         hwxubkgFF3zfEK/N8+mZ1zfgLVqx2HIu8Vew5N7qq04Ga9r1SSRlBlUnlKz7H6psa2P9
         QJkw==
X-Gm-Message-State: ABy/qLbFsXn/HkWSFmgNHhoRAH6Y/2UgqNPEHeMu8x/L4aZaczREPz6Y
        8mjVCm6l77WqYdZK8/e0RzzoZhJYiqBvA8hpqKCWuw==
X-Google-Smtp-Source: APBJJlFBlB2IMN6wQ9ljyKuk9C2ygg7N2wP9HjsaHvyNMgk7s3uVNoO1IdE3mpPvcaRxPv6noi+S8RXvGCinQtcL+Z4=
X-Received: by 2002:a0c:d990:0:b0:635:f23e:ef97 with SMTP id
 y16-20020a0cd990000000b00635f23eef97mr14273252qvj.7.1689702632732; Tue, 18
 Jul 2023 10:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230717-enable-kasan-lto1-v2-1-d47bf182f5c6@gmail.com>
In-Reply-To: <20230717-enable-kasan-lto1-v2-1-d47bf182f5c6@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 18 Jul 2023 10:50:21 -0700
Message-ID: <CAKwvOdmjzgPF9g2e5fXtM=_bkGdYdhK21iuwR7EdZJUnCxRc_w@mail.gmail.com>
Subject: Re: [PATCH v2] arch: enable HAS_LTO_CLANG with KASAN and KCOV
To:     Jakob Koschel <jkl820.git@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 11:49=E2=80=AFPM Jakob Koschel <jkl820.git@gmail.co=
m> wrote:
>
> Both KASAN and KCOV had issues with LTO_CLANG if DEBUG_INFO is enabled.
> With LTO inlinable function calls are required to have debug info if
> they are inlined into a function that has debug info.
>
> Starting with LLVM 17 this will be fixed ([1],[2]) and enabling LTO with
> KASAN/KCOV and DEBUG_INFO doesn't cause linker errors anymore.
>
> Link: https://github.com/llvm/llvm-project/commit/913f7e93dac67ecff47bade=
862ba42f27cb68ca9
> Link: https://github.com/llvm/llvm-project/commit/4a8b1249306ff11f229320a=
bdeadf0c215a00400
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Jakob Koschel <jkl820.git@gmail.com>
> ---
> Changes in v2:
> - Added correct To:/Cc:
> - Added comment about required LLVM 17 version dependency
> - Link to v1: https://lore.kernel.org/r/20230717-enable-kasan-lto1-v1-1-4=
71e706a5c4e@gmail.com
> ---
>  arch/Kconfig | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index aff2746c8af2..d722bcfcc870 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -745,7 +745,10 @@ config HAS_LTO_CLANG
>         depends on $(success,$(AR) --help | head -n 1 | grep -qi llvm)
>         depends on ARCH_SUPPORTS_LTO_CLANG
>         depends on !FTRACE_MCOUNT_USE_RECORDMCOUNT
> -       depends on !KASAN || KASAN_HW_TAGS
> +       # KASAN & KCOV were missing necessary debug information prior to =
LLVM 17
> +       # which are required with LTO.

Hi Jakob,
Thanks for follow up with a v2.  I think Nathan meant he was literally
looking for a link here in the comment, like:

# https://github.com/ClangBuiltLinux/linux/issues/1721

Mind sending a v3 with that? You can replace the comment you added to
arch/Kconfig in v2 outright with that link.

If folks need to know more they can follow that link or run git blame on it=
.

> +       depends on (!KASAN || KASAN_HW_TAGS || CLANG_VERSION >=3D 170000)=
 || !DEBUG_INFO
> +       depends on (!KCOV || CLANG_VERSION >=3D 170000) || !DEBUG_INFO
>         depends on !GCOV_KERNEL
>         help
>           The compiler and Kconfig options support building with Clang's
>
> ---
> base-commit: fdf0eaf11452d72945af31804e2a1048ee1b574c
> change-id: 20230717-enable-kasan-lto1-656754c76241
>
> Best regards,
> --
> Jakob Koschel <jkl820.git@gmail.com>
>


--=20
Thanks,
~Nick Desaulniers
