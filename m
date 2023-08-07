Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94EE47722F7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbjHGLoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbjHGLo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:44:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E494693
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 04:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691408477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WmODk+CdskyMtYG8TdUz/Cv201lmsUcEqfPEQkGIYLY=;
        b=G+kX1ODjU9xbFOZYfOo4hYtnSaB8wLwhgmr7/5RrQ7+tmAdEc9g9dbYUZW1035SnXjRucI
        bihnZhLYn2NawdRPzPBGscq0xR9x0oXwURcTFrbak6iZdu0Sc305A3oIcbSVp6egBeIOC9
        NkPUFbSTVCJfuzTjG3BzZMFF5o1NcO0=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-74-2LnRN-WnO9Klk1-rMuLD1w-1; Mon, 07 Aug 2023 07:41:14 -0400
X-MC-Unique: 2LnRN-WnO9Klk1-rMuLD1w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F38281C0690C;
        Mon,  7 Aug 2023 11:41:12 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 72335140E962;
        Mon,  7 Aug 2023 11:41:08 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
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
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-toolchains@vger.kernel.org
Subject: Re: [PATCH v2 1/3] compiler_types: Introduce the Clang
 __preserve_most function attribute
References: <20230804090621.400-1-elver@google.com>
Date:   Mon, 07 Aug 2023 13:41:07 +0200
In-Reply-To: <20230804090621.400-1-elver@google.com> (Marco Elver's message of
        "Fri, 4 Aug 2023 11:02:56 +0200")
Message-ID: <87il9rgjvw.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Marco Elver:

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

You dropped the interesting part:

| If the arguments are passed in callee-saved registers, then they will
| be preserved by the callee across the call. This doesn=E2=80=99t apply for
| values returned in callee-saved registers.
|=20
|  =C2=B7  On X86-64 the callee preserves all general purpose registers, ex=
cept
|     for R11. R11 can be used as a scratch register. Floating-point
|     registers (XMMs/YMMs) are not preserved and need to be saved by the
|     caller.
|=20=20=20=20=20
|  =C2=B7  On AArch64 the callee preserve all general purpose registers, ex=
cept
|     X0-X8 and X16-X18.

Ideally, this would be documented in the respective psABI supplement.
I filled in some gaps and filed:

  Document the ABI for __preserve_most__ function calls
  <https://gitlab.com/x86-psABIs/x86-64-ABI/-/merge_requests/45>

Doesn't this change impact the kernel module ABI?

I would really expect a check here

> +#if __has_attribute(__preserve_most__)
> +# define __preserve_most notrace __attribute__((__preserve_most__))
> +#else
> +# define __preserve_most
> +#endif

that this is not a compilation for a module.  Otherwise modules built
with a compiler with __preserve_most__ attribute support are
incompatible with kernels built with a compiler without that attribute.

Thanks,
Florian

