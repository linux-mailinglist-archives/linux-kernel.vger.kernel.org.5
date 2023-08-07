Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC02177249A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbjHGMo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbjHGMoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:44:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C283AC9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 05:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691412231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pgN6ITNOX4XAghEqnE7rc109x2dPHO2XXLtjfGMGEBw=;
        b=ZiWN/a3p4R6zIVtKfkSGQ/XwOazIHTNuaxp8kYidz2edqLEeDpUpEGuw+eOaxCObb2ZKYj
        9/t6S1Px5sjAER6BlxrqFD9fu1budZ8Z1N1+rG1bnBWGR6cI1nwmEMHoorqj/U0rboz5v/
        8bIEdQXdJljmkIuRqV7DKha2mxFBywE=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-VkhQ3GWqNk66vZeVUGT2Qw-1; Mon, 07 Aug 2023 08:43:49 -0400
X-MC-Unique: VkhQ3GWqNk66vZeVUGT2Qw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BD5F6381AE49;
        Mon,  7 Aug 2023 12:43:43 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6342E40C2076;
        Mon,  7 Aug 2023 12:43:40 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Jakub Jelinek <jakub@redhat.com>
Cc:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        <ZNDlrRrUS2AWTCiw@tucnak>
Date:   Mon, 07 Aug 2023 14:43:39 +0200
In-Reply-To: <ZNDlrRrUS2AWTCiw@tucnak> (Jakub Jelinek's message of "Mon, 7 Aug
        2023 14:38:05 +0200")
Message-ID: <87h6pbf2f8.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Jakub Jelinek:

> On Mon, Aug 07, 2023 at 02:24:26PM +0200, Marco Elver wrote:
>> > | If the arguments are passed in callee-saved registers, then they will
>> > | be preserved by the callee across the call. This doesn=E2=80=99t app=
ly for
>> > | values returned in callee-saved registers.
>> > |
>> > |  =C2=B7  On X86-64 the callee preserves all general purpose register=
s, except
>> > |     for R11. R11 can be used as a scratch register. Floating-point
>> > |     registers (XMMs/YMMs) are not preserved and need to be saved by =
the
>> > |     caller.
>> > |
>> > |  =C2=B7  On AArch64 the callee preserve all general purpose register=
s, except
>> > |     X0-X8 and X16-X18.
>> >
>> > Ideally, this would be documented in the respective psABI supplement.
>> > I filled in some gaps and filed:
>> >
>> >   Document the ABI for __preserve_most__ function calls
>> >   <https://gitlab.com/x86-psABIs/x86-64-ABI/-/merge_requests/45>
>>=20
>> Good idea. I had already created
>> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D110899, and we need
>> better spec to proceed for GCC anyway.
>
> "Registers used for passing arguments
> are preserved by the called function, but registers used for
> returning results are not."
>
> You mean just GPRs or also vector SSE or MMX registers?

I think this is pretty clear for x86-64:

| Floating-point registers (XMMs/YMMs) are not preserved and need to be
| saved by the caller.

The issue is more with future GPR extensions like APX.

Thanks,
Florian

