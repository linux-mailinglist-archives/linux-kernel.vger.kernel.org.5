Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1367748E1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236571AbjHHToE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjHHTnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:43:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5637943CF2
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691513079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LpOwTgxUQueKTTwOJlS9a4DMbQJlgeLRkDEjrIokCAc=;
        b=eVTfxbC36g32xFf3z0JE5AxSimNq+ut3q0sj4Ojop7ygXT6gQ3cifGcjTozEH+7343o/lx
        8azq8J47sPuhTwERCV3mt5b6achj44QVKGQYzo63vVIiOiPg58pupq2dH8fXmBn05TyXk6
        98ElaNHurB1CF6r91PdTNSRFyYh/UJM=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-678-x_BVl-L4N6OBZSXsqfsgqg-1; Tue, 08 Aug 2023 07:41:11 -0400
X-MC-Unique: x_BVl-L4N6OBZSXsqfsgqg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CFA37381AE42;
        Tue,  8 Aug 2023 11:41:09 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 462E41121314;
        Tue,  8 Aug 2023 11:41:06 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
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
        kasan-dev@googlegroups.com, linux-toolchains@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v2 1/3] compiler_types: Introduce the Clang
 __preserve_most function attribute
References: <20230804090621.400-1-elver@google.com>
        <87il9rgjvw.fsf@oldenburg.str.redhat.com>
        <20230808105705.GB212435@hirez.programming.kicks-ass.net>
Date:   Tue, 08 Aug 2023 13:41:05 +0200
In-Reply-To: <20230808105705.GB212435@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Tue, 8 Aug 2023 12:57:05 +0200")
Message-ID: <87pm3xhicu.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Zijlstra:

> Now, the problem with __preserve_most is that it makes it really easy to
> deviate from this pattern, you can trivially write a function that is
> not a trivial wrapper and then does not show up on unwind. This might
> indeed be a problem.

Backtrace generation shouldn't be impacted by a compiler implementation
of __preserve_most__.  If unwinding implies restoring register contents,
the question becomes whether the unwinder can be taught to do this
natively.  For .eh_frame/PT_GNU_EH_FRAME-based unwinders and
__preserve_most__, I think that's true because they already support
custom ABIs (and GCC uses them for local functions).  In other cases, if
the unwinder does not support the extra registers, then it might still
be possible to compensate for that via code generation (e.g., setjmp
won't be __preserve_most__, so the compiler would have to preserve
register contents by other means, also accounting for the returns-twice
nature, likewise for exception handling landing pads).

But __preserve_all__ is a completely different beast.  I *think* it is
possible to do this with helpers (state size, state save, state restore)
and strategically placed restores after returns-twice functions and the
like, but people disagree.  This has come up before in the context of
the s390x vector ABI and the desire to add new callee-saved registers.
We just couldn't make that work at the time.  On the other hand,
__preserve_all__ goes into the other direction (opt-in of extra saves),
so it may be conceptually easier.

Thanks,
Florian

