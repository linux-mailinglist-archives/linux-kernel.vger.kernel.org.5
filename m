Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813697EC9D2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 18:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbjKORji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 12:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbjKORjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 12:39:24 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D481FE3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:38:58 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9d216597f64so1065346666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700069936; x=1700674736; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZjnOHCJPMB3Ob6Aoj8djmdEtslB23gqmLaPYvQZfZE8=;
        b=EMvVyCpxkp9r99KXgVKEJyQSTbTWIQRq5av6m5UpaVFgtX1WiB6EyDJRczBsdhNGu5
         3Mqco/q87jgLhGv4px2eUgEU2O/0Z+op38rOlf2l1EWsljLHpM9E0u/Atqfg1W40G2gv
         sYVdqpscQZc9lfxcjqnSebntS2T42swGeIulc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700069936; x=1700674736;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZjnOHCJPMB3Ob6Aoj8djmdEtslB23gqmLaPYvQZfZE8=;
        b=UxTuYXTWk5IYK4aO/dHFSzMF42gNGNnB/x6PzfZpG+xiY3X25zsxTIs87xcxft/iGe
         gcfAKMFXiQdOMt01tfAFSVib2YpCQdVaGrZsqJj3eOOi+X3xWko0UPxDUGg47+kHxG5p
         RDbgcpM6KH4KdYd4npMWQNsV8Qa8fU/YEMF9IUYXZ0pdyk/xrN4rrvXrohFXAAv6Bwx2
         yKNKEaJC8AnwdBLdlzBMqt8AWA4t8rP0pG3EXKo5IkqrcxuOalLsh9zD/JT06N9A2ZaN
         HAZZH5fokvwzb9ZRE4ORBayKbKzgq0Swl/5DgKls0g3qkoW2nGUUWF0i5a3F9B9fCNeM
         0w1A==
X-Gm-Message-State: AOJu0Yw98An8MsHbUL1K8zGlvGJkuHCDrX/Qd6mnHiu2rmKGVQNklzZr
        zr6Am8Ofa2EoYkejdJfETJ/xbt3OIi0Df40HWpV5Zse3
X-Google-Smtp-Source: AGHT+IG2GlKcUhYhBAZVcClnuQYDkWYPwd9cBUZMxSvWRsJ8euH0EilkQGnHQGMskASd5OeRJz5qGQ==
X-Received: by 2002:a17:906:1d0b:b0:9be:aebc:d480 with SMTP id n11-20020a1709061d0b00b009beaebcd480mr11325937ejh.24.1700069936375;
        Wed, 15 Nov 2023 09:38:56 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a10-20020a1709065f8a00b009887f4e0291sm7318486eju.27.2023.11.15.09.38.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 09:38:55 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5437d60fb7aso10676675a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:38:55 -0800 (PST)
X-Received: by 2002:aa7:d44c:0:b0:547:a0a8:634b with SMTP id
 q12-20020aa7d44c000000b00547a0a8634bmr3923054edr.32.1700069935569; Wed, 15
 Nov 2023 09:38:55 -0800 (PST)
MIME-Version: 1.0
References: <202311061616.cd495695-oliver.sang@intel.com> <3865842.1700061614@warthog.procyon.org.uk>
 <CAHk-=whM-cEwAsLtKsf5dYwV7nDTaRv1bUKLVBstMAQBug24uQ@mail.gmail.com>
In-Reply-To: <CAHk-=whM-cEwAsLtKsf5dYwV7nDTaRv1bUKLVBstMAQBug24uQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Nov 2023 12:38:38 -0500
X-Gmail-Original-Message-ID: <CAHk-=wjCUckvZUQf7gqp2ziJUWxVpikM_6srFdbcNdBJTxExRg@mail.gmail.com>
Message-ID: <CAHk-=wjCUckvZUQf7gqp2ziJUWxVpikM_6srFdbcNdBJTxExRg@mail.gmail.com>
Subject: Re: [linus:master] [iov_iter] c9eec08bac: vm-scalability.throughput
 -16.9% regression
To:     David Howells <dhowells@redhat.com>
Cc:     kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        David Laight <David.Laight@aculab.com>, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2023 at 11:53, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I wonder if gcc somehow decided to inline "memcpy()" in
> memcpy_from_iter() as a "rep movsb" because of other inlining changes?
>
> [ Goes out to look ]
>
> Yup, I think that's exactly what happened. Gcc seems to decide that it
> might be a small memcpy(), and seems to do at least part of it
> directly.
>
> So I *think* this all is mainly an artifact of gcc having changed code
> generation due to the code re-organization.

The gcc code generation here is *really* odd. I've never seen this
before, so it may be new to newer versions of gcc. I see code like
this:

# lib/iov_iter.c:73:    memcpy(to + progress, iter_from, len);
        cmpl    $8, %edx        #, _88
        jb      .L400   #,
        movq    (%rsi), %rax    #, tmp288
        movq    %rax, (%rcx)    # tmp288,
        movl    %edx, %eax      # _88, _88
        movq    -8(%rsi,%rax), %rdi     #, tmp295
        movq    %rdi, -8(%rcx,%rax)     # tmp295,
        leaq    8(%rcx), %rdi   #, tmp296
        andq    $-8, %rdi       #, tmp296
        subq    %rdi, %rcx      # tmp296, tmp268
        subq    %rcx, %rsi      # tmp268, tmp269
        addl    %edx, %ecx      # _88, _88
        shrl    $3, %ecx        #,
        rep movsq
        jmp     .L392   #

.L398:
# lib/iov_iter.c:73:    memcpy(to + progress, iter_from, len);
        movl    (%rsi), %eax    #, tmp271
        movl    %eax, (%rcx)    # tmp271,
        movl    %edx, %eax      # _88, _88
        movl    -4(%rsi,%rax), %esi     #, tmp278
        movl    %esi, -4(%rcx,%rax)     # tmp278,
        movl    8(%r9), %edi    # p_72->bv_len, p_72->bv_len
        jmp     .L330   #
...

.L400:
# lib/iov_iter.c:73:    memcpy(to + progress, iter_from, len);
        testb   $4, %dl #, _88
        jne     .L398   #,
        testl   %edx, %edx      # _88
        je      .L330   #,
        movzbl  (%rsi), %eax    #, tmp279
        movb    %al, (%rcx)     # tmp279,
        testb   $2, %dl #, _88
        jne     .L390   #,
...

which makes *zero* sense. It first checks that the the length is at
least 8 bytes, then it moves *one* word by hand, then it aligns the
code to 8 bytes remaining, and does the remaining (possibly
overlapping at the beginning) words as one "rep movsq",

And L398 is the "I have 4..7 bytes to copy" target.

And L400 seems to be "I have 0..7 bytes to copy".

This is literally insane. And it seems to be all just gcc having for
some reason decided to do this instead of "rep movsb" or calling an
out-of-line function.

I get the feeling that this is related to how your patches made that
function be an inline function that is inlined through a function
pointer. I suspect that what happens is that gcc expands the memcpy()
first into that inlined function (without caller context), and then
inserts the crazily expanded inline later into the context of that
function pointer.

I dunno. I really only say that because I haven't seen gcc make this
kind of mess before, and that "inlined through a function pointer" is
the main unusual thing here.

How very annoying.

                 Linus
