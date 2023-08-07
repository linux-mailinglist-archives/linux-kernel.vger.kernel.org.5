Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D989772457
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbjHGMiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233609AbjHGMhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:37:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C7310D8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 05:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691411822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5CuphCgJIGsELzZCHyihudC7C9xErjXAeUjA0Czr5WA=;
        b=Dy/jDYAzrOW1/vw2dgSi5tQDNTUyMessiXf2Qg/PV1BxYx9CUwuiNsjOe5c00sK1CjDXfE
        L+gYaFZPL3o8tXlubmfI6DAXAnZtgTO8Ie08ItLrllHKpNUWlZW0D4Bgec7U6hX8O1ry5i
        pywDNpwvAmZyNc6Vhn9ZoaMq3/NbdRo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-tFAqekpKOEu5hfmv8bj1iQ-1; Mon, 07 Aug 2023 08:37:00 -0400
X-MC-Unique: tFAqekpKOEu5hfmv8bj1iQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 327BD801CF3;
        Mon,  7 Aug 2023 12:36:58 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 033731121314;
        Mon,  7 Aug 2023 12:36:54 +0000 (UTC)
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
        <87il9rgjvw.fsf@oldenburg.str.redhat.com>
        <CANpmjNN4h2+i3LUG__GHha849PZ3jK=mBoFQWpSz4jffXB4wrw@mail.gmail.com>
Date:   Mon, 07 Aug 2023 14:36:53 +0200
In-Reply-To: <CANpmjNN4h2+i3LUG__GHha849PZ3jK=mBoFQWpSz4jffXB4wrw@mail.gmail.com>
        (Marco Elver's message of "Mon, 7 Aug 2023 14:24:26 +0200")
Message-ID: <87pm3zf2qi.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Marco Elver:

> Good idea. I had already created
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=110899, and we need
> better spec to proceed for GCC anyway.

Thanks for the reference.

>> Doesn't this change impact the kernel module ABI?
>>
>> I would really expect a check here
>>
>> > +#if __has_attribute(__preserve_most__)
>> > +# define __preserve_most notrace __attribute__((__preserve_most__))
>> > +#else
>> > +# define __preserve_most
>> > +#endif
>>
>> that this is not a compilation for a module.  Otherwise modules built
>> with a compiler with __preserve_most__ attribute support are
>> incompatible with kernels built with a compiler without that attribute.
>
> That's true, but is it a real problem? Isn't it known that trying to
> make kernel modules built for a kernel with a different config (incl.
> compiler) is not guaranteed to work? See IBT, CFI schemes, kernel
> sanitizers, etc?
>
> If we were to start trying to introduce some kind of minimal kernel to
> module ABI so that modules and kernels built with different toolchains
> keep working together, we'd need a mechanism to guarantee this minimal
> ABI or prohibit incompatible modules and kernels somehow. Is there a
> precedence for this somewhere?

I think the GCC vs Clang thing is expected to work today, isn't it?
Using the Clang-based BPF tools with a GCC-compiled kernel requires a
matching ABI.

The other things you listed result in fairly obvious breakage, sometimes
even module loading failures.  Unconditional crashes are possible as
well.  With __preserve_most__, the issues are much more subtle and may
only appear for some kernel/module compielr combinations and
optimization settings.  The impact of incorrectly clobbered registers
tends to be like that.

Thanks,
Florian

