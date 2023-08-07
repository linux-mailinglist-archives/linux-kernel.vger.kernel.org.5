Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E6977245D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjHGMkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjHGMkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:40:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3972125
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 05:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691411902;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ePFRnq6E9cmG1Qs9e3n4TY2fhHkanWOkJ/7w8uarlKU=;
        b=NCu+0CXT09x/c2G6JFFd6oliB2FWC0LHHHu5v269PEeGLt9208GcOE7/eBpEhj24/3+IjZ
        WhMD+2erLDyrX9ZeGbpQ181gvMpsml3CVpFb9apaj1tpbk+6lx66VHNeBvV6xqoBog+QJL
        08c7/9W0zPlwVcBDoQx+tWjuLb+KvJc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-wZWr1zJaMSiPiVo_gSlCsg-1; Mon, 07 Aug 2023 08:38:16 -0400
X-MC-Unique: wZWr1zJaMSiPiVo_gSlCsg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6FED585CBF9;
        Mon,  7 Aug 2023 12:38:15 +0000 (UTC)
Received: from tucnak.zalov.cz (unknown [10.45.224.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DFFC1121314;
        Mon,  7 Aug 2023 12:38:14 +0000 (UTC)
Received: from tucnak.zalov.cz (localhost [127.0.0.1])
        by tucnak.zalov.cz (8.17.1/8.17.1) with ESMTPS id 377Cc9Gu3645380
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 7 Aug 2023 14:38:09 +0200
Received: (from jakub@localhost)
        by tucnak.zalov.cz (8.17.1/8.17.1/Submit) id 377Cc5lu3645379;
        Mon, 7 Aug 2023 14:38:05 +0200
Date:   Mon, 7 Aug 2023 14:38:05 +0200
From:   Jakub Jelinek <jakub@redhat.com>
To:     Marco Elver <elver@google.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
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
Message-ID: <ZNDlrRrUS2AWTCiw@tucnak>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20230804090621.400-1-elver@google.com>
 <87il9rgjvw.fsf@oldenburg.str.redhat.com>
 <CANpmjNN4h2+i3LUG__GHha849PZ3jK=mBoFQWpSz4jffXB4wrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANpmjNN4h2+i3LUG__GHha849PZ3jK=mBoFQWpSz4jffXB4wrw@mail.gmail.com>
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

On Mon, Aug 07, 2023 at 02:24:26PM +0200, Marco Elver wrote:
> > | If the arguments are passed in callee-saved registers, then they will
> > | be preserved by the callee across the call. This doesn’t apply for
> > | values returned in callee-saved registers.
> > |
> > |  ·  On X86-64 the callee preserves all general purpose registers, except
> > |     for R11. R11 can be used as a scratch register. Floating-point
> > |     registers (XMMs/YMMs) are not preserved and need to be saved by the
> > |     caller.
> > |
> > |  ·  On AArch64 the callee preserve all general purpose registers, except
> > |     X0-X8 and X16-X18.
> >
> > Ideally, this would be documented in the respective psABI supplement.
> > I filled in some gaps and filed:
> >
> >   Document the ABI for __preserve_most__ function calls
> >   <https://gitlab.com/x86-psABIs/x86-64-ABI/-/merge_requests/45>
> 
> Good idea. I had already created
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=110899, and we need
> better spec to proceed for GCC anyway.

"Registers used for passing arguments
are preserved by the called function, but registers used for
returning results are not."

You mean just GPRs or also vector SSE or MMX registers?  Because if some
of those are to be preserved by callee, there is an issue that they need
to be e.g. handled during unwinding, with all the consequences.  It is hard
to impossible to guess what size needs to be saved/restored, both normally
or during unwinding.  As caller could be say -mavx512f and expect
preservation of all 512 bits and callee -msse2 or -mavx{,2},
or caller -mavx{,2} and expect preservation of all 256 bits and callee -msse2 etc.
MSABI "solves" that by making just the low 128 bits preserved and upper bits
clobbered.

	Jakub

