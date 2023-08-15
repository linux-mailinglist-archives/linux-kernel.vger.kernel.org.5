Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C714977D1E3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 20:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239150AbjHOSaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 14:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239266AbjHOSaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 14:30:24 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E16B1BEA
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 11:30:10 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b9db1de50cso86514911fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 11:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692124209; x=1692729009;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rRFUf4dNqMSfHq2+lBU85kOOjIYPLnDmd2dSara3YQ0=;
        b=oSGd6RTmJjm9YNpTfurQGJQobx8UnlO6mbOUQ4qC2fUPs998QGIOCYYL6frxvq7tYv
         JtrDn/x1qo+saWEXqVbgt8N8ddlQl5BQfo9Dgh+3eSFvGLrcySIHUb0lf1gG75mZ3vOY
         G0xNqZNOmXrP9UZN3cVWXLYrqvxycLEIPDHzLddqVo07q3Oh5bLbeBugc5K4DvY+dJ7v
         Y3c8Y5BiCRZkGDPa7uTcFM8Kb0jz6vR9l2yXc/enj4Gxf13yaV3bCTDogqwz4vSSnsPw
         hlE0ZjQTw+uYay5WKTwCpMv53AzcPnTYWD8pUAmu5OU+n1JpwZHU8P3WQwcE2+iLk8DQ
         nwNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692124209; x=1692729009;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rRFUf4dNqMSfHq2+lBU85kOOjIYPLnDmd2dSara3YQ0=;
        b=S6EOT2b2QUb5qaBI/A/GGnGPBU3yNkVvrgcZY2ExgJARhIITwOaHw6OfRbDLKdXO6Q
         Zfwz/fLkpmAFfKV9IEywze/zacDMHHJtmBYwiUOkCunqaLtxhSVtHpQakQPYVvXsokd0
         Rk7O0PAvyf1uNJdjqo8FV3R+K6nJB96Hzrt1mTnLUquTG7+d5RahHp2kuYamDt+oDRL/
         zDVTG9+w4IrAAABjyywjct55efNm3rdMqAWs8qbv4Ovr/SZvvZMRzmL2tNMoykoelCn1
         AdMHE9j6eKHFUnmnfp6YlEYJNuijLmHmg1jNFVEAH9g2zx+Xe7jeU8sGFAtFIiI6KIdD
         dbVQ==
X-Gm-Message-State: AOJu0YzOc/BLaQF3bJM0yZcgzILCYTRJrQlnvIYM3ArRj4RPLEcZ375b
        WTUgb73DbCl4PwwLmrGrguCfClFdBkY8JfwXS0niPbV+h0QyBqDpPIrnZg==
X-Google-Smtp-Source: AGHT+IGIPWace5mdmcxiYsdjUOHTOAtdVTz9UvfQVQP31URfweI7ITp2r94AA2XEk86pkT7L3VWHyy8DVHcpStWzCas=
X-Received: by 2002:a7b:cd99:0:b0:3fe:14af:ea21 with SMTP id
 y25-20020a7bcd99000000b003fe14afea21mr10108651wmj.21.1692123756120; Tue, 15
 Aug 2023 11:22:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230811151847.1594958-1-elver@google.com> <202308141620.E16B93279@keescook>
In-Reply-To: <202308141620.E16B93279@keescook>
From:   Marco Elver <elver@google.com>
Date:   Tue, 15 Aug 2023 20:21:59 +0200
Message-ID: <CANpmjNNDcVK9gmnBfxbthD3KEzsdc=PJb97AXcPEaweLNM5mPw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] compiler_types: Introduce the Clang
 __preserve_most function attribute
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, llvm@lists.linux.dev,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2023 at 01:21, Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Aug 11, 2023 at 05:18:38PM +0200, Marco Elver wrote:
> > [1]: "On X86-64 and AArch64 targets, this attribute changes the calling
> > convention of a function. The preserve_most calling convention attempts
> > to make the code in the caller as unintrusive as possible. This
> > convention behaves identically to the C calling convention on how
> > arguments and return values are passed, but it uses a different set of
> > caller/callee-saved registers. This alleviates the burden of saving and
> > recovering a large register set before and after the call in the caller.
> > If the arguments are passed in callee-saved registers, then they will be
> > preserved by the callee across the call. This doesn't apply for values
> > returned in callee-saved registers.
> >
> >  * On X86-64 the callee preserves all general purpose registers, except
> >    for R11. R11 can be used as a scratch register. Floating-point
> >    registers (XMMs/YMMs) are not preserved and need to be saved by the
> >    caller.
> >
> >  * On AArch64 the callee preserve all general purpose registers, except
> >    x0-X8 and X16-X18."
> >
> > [1] https://clang.llvm.org/docs/AttributeReference.html#preserve-most
> >
> > Introduce the attribute to compiler_types.h as __preserve_most.
> >
> > Use of this attribute results in better code generation for calls to
> > very rarely called functions, such as error-reporting functions, or
> > rarely executed slow paths.
> >
> > Beware that the attribute conflicts with instrumentation calls inserted
> > on function entry which do not use __preserve_most themselves. Notably,
> > function tracing which assumes the normal C calling convention for the
> > given architecture.  Where the attribute is supported, __preserve_most
> > will imply notrace. It is recommended to restrict use of the attribute
> > to functions that should or already disable tracing.
> >
> > Note: The additional preprocessor check against architecture should not
> > be necessary if __has_attribute() only returns true where supported;
> > also see https://github.com/ClangBuiltLinux/linux/issues/1908. But until
> > __has_attribute() does the right thing, we also guard by known-supported
> > architectures to avoid build warnings on other architectures.
> >
> > The attribute may be supported by a future GCC version (see
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=110899).
> >
> > Signed-off-by: Marco Elver <elver@google.com>
> > Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
>
> Should this go via -mm, the hardening tree, or something else? I'm happy
> to carry it if no one else wants it?

v3 of this series is already in mm-unstable, and has had some -next
exposure (which was helpful in uncovering some additional issues).
Therefore, I think it's appropriate that it continues in mm and Andrew
picks up the latest v4 here.

Your official Ack would nevertheless be much appreciated!

Thanks,
-- Marco
