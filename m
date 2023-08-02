Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE1B76D448
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 18:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjHBQwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 12:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbjHBQwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 12:52:00 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBC33AA7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 09:51:19 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31751d7d96eso21955f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 09:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690995077; x=1691599877;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LrJLBG38n+Wiyfmv9S4MGg4xgt3i7BNwPWJDTs2HMj8=;
        b=Yr2vtAOieZy3/74CDEAGC2Gnt8sgnypV0sH1nFYDYE+Z9U73wi72vRoBj9mOPgJwjv
         99wZ+YY4Rl0iV4S7hY5jTJtBu9E+Wq+0WPHsLe7dYzPVxIQ7tL3K9N9EEAXWyXptkr4R
         ias3QXAFYMwvc666cOayPBqLwNU+Kv7rga8bPxnBbLZRg9CrOcJ+FBK+rP2suecmhpuK
         73IMHyBKaqHCKBxo5PMwGaIBZKNj+nCrhhmAYIbNw5hpKlBf+9T+TnMkonjeqbOS1kee
         h/worVBInk2I1mObvjC5ogsA2iH6t0VXQGFlLd+k2vwihb2JKETOekCztRRPYmPBl9O/
         EQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690995077; x=1691599877;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LrJLBG38n+Wiyfmv9S4MGg4xgt3i7BNwPWJDTs2HMj8=;
        b=NE7TL5/iM8nvEe3ONnhVkwjMq3ugIpuZpwyHVNbHf4dYPSnLYP0S9Hkw+pNNckekIx
         7hN3d0oh2e7q9+JIMFkm9Z1FdoYDutcelWwZuzOx3nSW7oKD9ViY2tHuGiYbjIUdpuXA
         96tfVHNKmjGiXkaTfahmQcn0IftiQ1eZjU3IFrmBO0ymKbFYgcrr6VEglVEDGoGE7EJ4
         /mrFrULeVpf/ILR78JDcItktuh9/Ra0o9OY4V76DQw7qwzfvwegGuJqUIwHVu70fvs79
         ZoDWSMYzaFHUI+dBddoPnl36OnhNoytuC6P95fqJJoPhewuPccQ2tkX5aRk9mfzilsID
         kh8g==
X-Gm-Message-State: ABy/qLYv0rEE+UV7B8rvKsMWUcaVAIc5qd4XmAal5HAwi3j0gQ6kEm3T
        VflPfcGlOld+qqEDy6Ngt2H2a/pNX+9HHnMUOGrxfQ==
X-Google-Smtp-Source: APBJJlEF0ih0QHv1ekEfW69+6kAWN0K+fahB0BVsKiKPMI+3V3I/aF86Y1eNpJYuOPhD4pxG0Cgwhi1Awcn8a9ebJvM=
X-Received: by 2002:adf:facc:0:b0:317:49a2:1f89 with SMTP id
 a12-20020adffacc000000b0031749a21f89mr5196369wrs.1.1690995076610; Wed, 02 Aug
 2023 09:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230802150712.3583252-1-elver@google.com>
In-Reply-To: <20230802150712.3583252-1-elver@google.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 2 Aug 2023 18:50:39 +0200
Message-ID: <CANpmjNPVO_t058c6Wcwr9TBwxeoH7Ba0ECsf6Wapn60br8EtkQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] Compiler attributes: Introduce the __preserve_most
 function attribute
To:     elver@google.com, Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-toolchains@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Aug 2023 at 17:07, Marco Elver <elver@google.com> wrote:
>
> [1]: "On X86-64 and AArch64 targets, this attribute changes the calling
> convention of a function. The preserve_most calling convention attempts
> to make the code in the caller as unintrusive as possible. This
> convention behaves identically to the C calling convention on how
> arguments and return values are passed, but it uses a different set of
> caller/callee-saved registers. This alleviates the burden of saving and
> recovering a large register set before and after the call in the
> caller."
>
> [1] https://clang.llvm.org/docs/AttributeReference.html#preserve-most
>
> Use of this attribute results in better code generation for calls to
> very rarely called functions, such as error-reporting functions, or
> rarely executed slow paths.
>
> Introduce the attribute to compiler_attributes.h.
>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  include/linux/compiler_attributes.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
> index 00efa35c350f..615a63ecfcf6 100644
> --- a/include/linux/compiler_attributes.h
> +++ b/include/linux/compiler_attributes.h
> @@ -321,6 +321,17 @@
>  # define __pass_object_size(type)
>  #endif
>
> +/*
> + * Optional: not supported by gcc.
> + *
> + * clang: https://clang.llvm.org/docs/AttributeReference.html#preserve-most
> + */
> +#if __has_attribute(__preserve_most__)
> +# define __preserve_most __attribute__((__preserve_most__))
> +#else
> +# define __preserve_most
> +#endif

Mark says that there may be an issue with using this in combination
with ftrace because arm64 tracing relies on AAPCS. Probably not just
arm64, but also other architectures (x86?).

To make this safe, I'm going to move __preserve_most to
compiler_types.h and always pair it with notrace and some comments in
v2.
