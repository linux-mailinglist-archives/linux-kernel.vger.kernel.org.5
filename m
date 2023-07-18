Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7019A7588A6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 00:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjGRWpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 18:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjGRWpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 18:45:03 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6B81996
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:45:01 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-7672303c831so575634885a.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689720301; x=1692312301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovgopksrcBDDM5q7wb3QImYeaqgjH+ws4yyLYfsMj1A=;
        b=tWO9NBwqDPSUi5OtEkdsiPLvuQRsr4CBjfybKGktzr1NeDTDrkpixDVWTtw1j3O7IU
         A09XlqcwkQjn1h2ktQdMuwZYwXQ8yo7D7btq1Y/AGOvRP9InzW9CJYkrlNwSpHGi97tF
         wJulhRaZ1A26/IgI0EdSh/C9XAYtnq/weMSNqvVMy73ZjW1JcdynBeV7QHEv/xA2H4T1
         HdC+a5wigliyyDueeIdLHEzHgj7gqwT2033xwwb/w3iafpl2Q1ZTmdA4BZ8fYeHa5rQY
         mbLkNjai4ywP3qAQRFJgvmoKzCRgbI+w40qX6BADV3grkI22uoHsZGJNn4poYmoLDQoF
         6DOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689720301; x=1692312301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovgopksrcBDDM5q7wb3QImYeaqgjH+ws4yyLYfsMj1A=;
        b=GcGYB8PiVUMx2vZEABt1rZxk1gKy9dJ3SlwNDojAivnXvwSvopj6oj2vIKwSy2EUZb
         gZTCqX0uC7OYtV4IiH2m8zpz/m4BJI1IYp5aywN9oQmEfVwoxUv74oYyfB4RAwKsXgYV
         dRTU1rIWtM4XvZMN/tLf5q2E5KLnvmVRQJvo3PqqYGdMOA/voXbQaQsOiGCCybQ/ybpG
         6YdVUMQczjFqY/sbLIm8SN/pUdV6ocXyKdbumXJixOIaUk6sR+FnW2nyYRrafVIGOHVf
         IkauMNq4KeYKzbzfs03UXF3QLbFH2DvTgu5kJwz8JxNBf/SRS4gcxhu1feOzxXN2tD6m
         OUMg==
X-Gm-Message-State: ABy/qLYl6IlHh3Lb/jaiwvOHzva13HzkCqcKU9Ub0QOmqttmlodLX116
        SphijEQA3vDQyJWQwZx8HjV5ewDYLlpDMnhHxnhUrQ==
X-Google-Smtp-Source: APBJJlHF6DVEgKMyfr14pLA4GVoX3CZmbt83NMHTNj8W8ZeAyqS/bTVyj4a1bheclQLu4wVQc9gGBZyUAiY5ib10pRA=
X-Received: by 2002:a0c:d802:0:b0:635:fa7b:6c22 with SMTP id
 h2-20020a0cd802000000b00635fa7b6c22mr15249575qvj.55.1689720300936; Tue, 18
 Jul 2023 15:45:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230717-enable-kasan-lto1-v3-1-650e1efc19d1@gmail.com>
In-Reply-To: <20230717-enable-kasan-lto1-v3-1-650e1efc19d1@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 18 Jul 2023 15:44:49 -0700
Message-ID: <CAKwvOd=6Pr2TP+xrqm9DkZGNjB7YPY+sB7gqgu=KZ96Dtq3KDA@mail.gmail.com>
Subject: Re: [PATCH v3] arch: enable HAS_LTO_CLANG with KASAN and KCOV
To:     Jakob Koschel <jkl820.git@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>,
        Kees Cook <keescook@chromium.org>,
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

On Tue, Jul 18, 2023 at 3:29=E2=80=AFPM Jakob Koschel <jkl820.git@gmail.com=
> wrote:
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

Thanks!

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

AKPM, do you mind please picking this up for us?

> ---
> Changes in v3:
> - Fixed the comment linking to the Github issue
> - Link to v2: https://lore.kernel.org/r/20230717-enable-kasan-lto1-v2-1-d=
47bf182f5c6@gmail.com
>
> Changes in v2:
> - Added correct To:/Cc:
> - Added comment about required LLVM 17 version dependency
> - Link to v1: https://lore.kernel.org/r/20230717-enable-kasan-lto1-v1-1-4=
71e706a5c4e@gmail.com
> ---
>  arch/Kconfig | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index aff2746c8af2..847b52495656 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -745,7 +745,9 @@ config HAS_LTO_CLANG
>         depends on $(success,$(AR) --help | head -n 1 | grep -qi llvm)
>         depends on ARCH_SUPPORTS_LTO_CLANG
>         depends on !FTRACE_MCOUNT_USE_RECORDMCOUNT
> -       depends on !KASAN || KASAN_HW_TAGS
> +       # https://github.com/ClangBuiltLinux/linux/issues/1721
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
