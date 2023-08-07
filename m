Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2C077250E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbjHGNI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233805AbjHGNIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:08:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A294E1721
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691413626;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wTw5UGHZz4e2SdP2OePYtf5FEiTOr08NgMVHrTIjIdY=;
        b=i+YSWZcQBfhBd4CvvrH4LD7YfWtDSORKDQOfndvnuDxSNNMKwis5+IQD2M0eNxRIjzfxyk
        g1KupK6F7mque85VW3/BViuNq51hmu4gNqAfarU2dwvVjOjLtwk5Q6tt0gk9kfe0YdqvsK
        /Vx5QlfnCsULFpzouzC96LbUvthsfTg=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-684-8FRjDLUHNAWmNwU-04hwKw-1; Mon, 07 Aug 2023 09:07:01 -0400
X-MC-Unique: 8FRjDLUHNAWmNwU-04hwKw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B69B3C108CB;
        Mon,  7 Aug 2023 13:07:00 +0000 (UTC)
Received: from tucnak.zalov.cz (unknown [10.45.224.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A81C2026D4B;
        Mon,  7 Aug 2023 13:06:59 +0000 (UTC)
Received: from tucnak.zalov.cz (localhost [127.0.0.1])
        by tucnak.zalov.cz (8.17.1/8.17.1) with ESMTPS id 377D6th33645769
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 7 Aug 2023 15:06:55 +0200
Received: (from jakub@localhost)
        by tucnak.zalov.cz (8.17.1/8.17.1/Submit) id 377D6pvb3645768;
        Mon, 7 Aug 2023 15:06:51 +0200
Date:   Mon, 7 Aug 2023 15:06:51 +0200
From:   Jakub Jelinek <jakub@redhat.com>
To:     Florian Weimer <fweimer@redhat.com>
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
Message-ID: <ZNDsa3AyR6EvIDeq@tucnak>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20230804090621.400-1-elver@google.com>
 <87il9rgjvw.fsf@oldenburg.str.redhat.com>
 <CANpmjNN4h2+i3LUG__GHha849PZ3jK=mBoFQWpSz4jffXB4wrw@mail.gmail.com>
 <ZNDlrRrUS2AWTCiw@tucnak>
 <87h6pbf2f8.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h6pbf2f8.fsf@oldenburg.str.redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 02:43:39PM +0200, Florian Weimer wrote:
> > On Mon, Aug 07, 2023 at 02:24:26PM +0200, Marco Elver wrote:
> >> > | If the arguments are passed in callee-saved registers, then they will
> >> > | be preserved by the callee across the call. This doesn’t apply for
> >> > | values returned in callee-saved registers.
> >> > |
> >> > |  ·  On X86-64 the callee preserves all general purpose registers, except
> >> > |     for R11. R11 can be used as a scratch register. Floating-point
> >> > |     registers (XMMs/YMMs) are not preserved and need to be saved by the
> >> > |     caller.
> >> > |
> >> > |  ·  On AArch64 the callee preserve all general purpose registers, except
> >> > |     X0-X8 and X16-X18.
> >> >
> >> > Ideally, this would be documented in the respective psABI supplement.
> >> > I filled in some gaps and filed:
> >> >
> >> >   Document the ABI for __preserve_most__ function calls
> >> >   <https://gitlab.com/x86-psABIs/x86-64-ABI/-/merge_requests/45>
> >> 
> >> Good idea. I had already created
> >> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=110899, and we need
> >> better spec to proceed for GCC anyway.
> >
> > "Registers used for passing arguments
> > are preserved by the called function, but registers used for
> > returning results are not."
> >
> > You mean just GPRs or also vector SSE or MMX registers?
> 
> I think this is pretty clear for x86-64:
> 
> | Floating-point registers (XMMs/YMMs) are not preserved and need to be
> | saved by the caller.

The above wording conflicts with that, so it should be clarified.

	Jakub

