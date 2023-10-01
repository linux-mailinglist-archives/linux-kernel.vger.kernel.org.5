Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6EEC7B4992
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 22:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbjJAUVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 16:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235346AbjJAUVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 16:21:42 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285A3A7
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 13:21:39 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99c136ee106so2184713466b.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 13:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1696191697; x=1696796497; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u1n+ZWsHXBr8FhnGB0kWER6c5yvJ+Tmgd0dVGu15OJg=;
        b=WXCVxI/wBzliWVLUw0z6FjGmBfcUXdBKvf9l1NbAzk+sxqiE9GtZGfATXONdFYtAGa
         pBvOR+ZZwRIElxeT0GvtHkRQGCAMELllUeo64Frr0zlzIpZuv5t15oLUI0TrYIj5UTzR
         d3fI7WxZ2Q403IjeKRFs9BGUZPeZXF8KAWj58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696191697; x=1696796497;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u1n+ZWsHXBr8FhnGB0kWER6c5yvJ+Tmgd0dVGu15OJg=;
        b=NU5nYIoEH2vDw2rSMzID4e010/bBPQPFQadtwMveaTC356ilmHRDzYT6xiqWCKkOic
         p4X/lpFtpVLsv1QuEb9oLaH0UlYtuSkGvRxVaOOX0mxhg0oOIr4OPPd8o/FCfrJxiirQ
         fv5yhnWSId+KaRnSS8hkup/z9/m2xsM2tkww4wqJV2nlBynz3FWJXDm2EySzWaxZOTVI
         kTSyzQdf8hfKAsbdf7tMXuyrcDrwri8jXpWA312JHgjs+dJDvWVvi2cxyrgoTdXIQ64/
         Fv7tr/r+CgPVf0VlVnb4Pr3liXwLCEqbLwXMMC3uM75ihu/GvH3ETlklUl24bqYRvJkX
         x2ww==
X-Gm-Message-State: AOJu0YwBWbjrKZvpPhZ9bhmoTrjFNcnvQZ/sCn1iMSIIfmYRfcs8hvVH
        4+8KH5tmHR2sJ2DTsGIbW3h+g3inepHHo5rN9rIEgw==
X-Google-Smtp-Source: AGHT+IGb35y+MHDzEOo1KzUGuCvRtdtf6Bw9DLAfx1seuV/nGZ6RiX2auJOz2cskirn9kFUEYQIN4w==
X-Received: by 2002:a17:906:328b:b0:9ae:658f:a80a with SMTP id 11-20020a170906328b00b009ae658fa80amr8357288ejw.48.1696191697356;
        Sun, 01 Oct 2023 13:21:37 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id lf23-20020a170906ae5700b00991d54db2acsm15834780ejb.44.2023.10.01.13.21.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Oct 2023 13:21:36 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-533d9925094so17466346a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 13:21:36 -0700 (PDT)
X-Received: by 2002:a05:6402:1257:b0:530:77e6:849f with SMTP id
 l23-20020a056402125700b0053077e6849fmr8682600edw.27.1696191696452; Sun, 01
 Oct 2023 13:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <20231001131620.112484-1-ubizjak@gmail.com> <CAHk-=wg6P8pPg-x4BPUQj-wE0xC7HkGzFk89ftuji8MVo+RRxw@mail.gmail.com>
 <CAFULd4Y+HXuditB51Q0LznqiBsvxJr3BjEYvx4_224XmqrycCw@mail.gmail.com>
In-Reply-To: <CAFULd4Y+HXuditB51Q0LznqiBsvxJr3BjEYvx4_224XmqrycCw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 1 Oct 2023 13:21:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh+cfn58XxMLnG6dH+Eb9-2dYfABXJF2FtSZ+vfqVvWzA@mail.gmail.com>
Message-ID: <CAHk-=wh+cfn58XxMLnG6dH+Eb9-2dYfABXJF2FtSZ+vfqVvWzA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] x86/percpu: Use segment qualifiers
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Oct 2023 at 12:53, Uros Bizjak <ubizjak@gmail.com> wrote:
>
> Regarding x86 target specific code, the same functionality used for
> explicit address space is used internally to handle __thread
> qualifier.

Ok, that's interesting, in that __thread is certainly widely used so
it will have seen testing.

> Even *if* there are some issues with aliasing, the kernel
> is immune to them due to
>
> KBUILD_CFLAGS += -fno-strict-aliasing

It's not aliasing I'd worry about. It's correctness.

And indeed, the *very* first thing I tried shows that this is all very
very buggy in gcc.

What did I try? A simple memory copy with a structure assignment.

Try to compile this:

    #include <string.h>
    struct a { long arr[30]; };

    __seg_fs struct a m;
    void foo(struct a *dst) { *dst = m; }

using the kernel compiler options (it's the "don't use sse/avx" ones
that matter):

    gcc -mno-avx -mno-sse -O2 -S t.c

and look at the end result. It's complete and utter sh*t:

        foo:
                xorl    %eax, %eax
                cmpq    $240, %rax
                jnb     .L5
        .L2:
                movzbl  %fs:m(%rax), %edx
                movb    %dl, (%rdi,%rax)
                addq    $1, %rax
                cmpq    $240, %rax
                jb      .L2
        .L5:
                ret

to the point that I can only go "WTF"?

I mean, it's not just that it does the copy one byte at a time. It
literally compares %rax to $240 just after it has cleared it. I look
at that code, and I go "a five-year old with a crayon could have done
better".

In other words, no, we're not using this thing that generates that
kind of garbage.

Somebody needs to open a bugzilla entry for this kind of code generation.

Clang isn't much better, but at least it doesn't generate bad code. It
just crashes with an internal compiler error on the above trivial
test-case:

    fatal error: error in backend: cannot lower memory intrinsic in
address space 257

which at least tells the user that they can't copy memory from that
address space. But once again shows that no, this feature is not ready
for prime-time.

If literally the *first* thing I thought to test was this broken, what
else is broken in this model?

And no, the kernel doesn't currently do the above kinds of things.
That's not the point. The point was "how well is this compiler support
tested". The answer is "not at all".

                   Linus
