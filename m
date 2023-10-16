Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2C57CB352
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 21:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbjJPTZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 15:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbjJPTY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 15:24:59 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9075EE
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 12:24:57 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9bf86b77a2aso299184566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 12:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697484296; x=1698089096; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WsIjTeZOu9htqQEjgAreyLOIbAhG2K4ek2GrQ6G5Ftw=;
        b=Pyn3bBwj9JqgyBk/SnZHHC8LYFZb3JHU6o45p8m5cGP2n6q2RfBojQk/k0tsHKrv5E
         zuI0vSWg70h8Zkzl7MqASH7YrCcl54AQ+ar3G6nj0udGZEfI7qVP3fr6kOXahM5m8ub+
         Mx6JhQi7xuX2IHJ4zNCG2meEHllxyTdimle8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697484296; x=1698089096;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WsIjTeZOu9htqQEjgAreyLOIbAhG2K4ek2GrQ6G5Ftw=;
        b=ZGWq/24AeOCcwyEahfZa7/apbK8zhOQNUuu76GsmBg1z7PqcXEC9byO1errKnkh3nJ
         aaq4cOE9M/M+XQoX1VovUFeVPGJrN7/UW0pwquulkcuc6zL0MKU7FkcLYmRbrW+OqwYs
         ea6gKssvnlA7PqhBzSVbLprbNc4GJoBeESIXxJghw5ELBIpRgJtcG+Zr2XDT692UKP/7
         iNahnfr1fA4XAzeu2bOaYW4tTJDH/to5SemfHvqCWXHOttAvEd05BmKOjLGkcAr59ELh
         lLN2E9E3RTbK/zBNOsZ+XAYXGAkV0WTNIdrqcc0b/VonsN3HhN7xufyfyPNlhuozMfsF
         2tDA==
X-Gm-Message-State: AOJu0YxkUcuA0AHFgj6VSLZYab3p+C7CuRVyuwg6KspYDMN0YPmHNQHZ
        ejIN9Z9pyEeikROSRcRHiJNvQBxNwpmwdB7pAUHVcP+7
X-Google-Smtp-Source: AGHT+IHf3+ovhrTzUV6qYzWFIvviT4x6OwqnlLF0SH+NuCNvBn2BuhUsZhRlWH3tfBAH8mSJy3N6vw==
X-Received: by 2002:a17:907:26c1:b0:9ae:4eb9:e09b with SMTP id bp1-20020a17090726c100b009ae4eb9e09bmr17050ejc.27.1697484295974;
        Mon, 16 Oct 2023 12:24:55 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id u24-20020a170906069800b00997e99a662bsm4510690ejb.20.2023.10.16.12.24.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 12:24:55 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-9bf86b77a2aso299179766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 12:24:55 -0700 (PDT)
X-Received: by 2002:a17:906:478b:b0:9ae:52fb:2202 with SMTP id
 cw11-20020a170906478b00b009ae52fb2202mr12181ejc.40.1697484294731; Mon, 16 Oct
 2023 12:24:54 -0700 (PDT)
MIME-Version: 1.0
References: <20231010164234.140750-1-ubizjak@gmail.com> <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <F48A9D34-3627-4372-B555-B58CBFC3F241@vmware.com> <CAHk-=wjF4gzCZKh-zN-sY0WpX1kCo+s9gYE9sOcSv0QieH1dwQ@mail.gmail.com>
 <CAFULd4bmOa7G2dXd_mu4J=_bsEs+TbxH691tYx9QQBwJPAma9w@mail.gmail.com>
 <CAHk-=wj2Co_g3RQ=JkDZC7PYbRqDPq7mePQ0=eYhhtpEgqJD0w@mail.gmail.com>
 <0617BB2F-D08F-410F-A6EE-4135BB03863C@vmware.com> <CAFULd4Zjd6idrLXuF59cwKxyd1a--DsiJwGQAKai9Tph30dAow@mail.gmail.com>
In-Reply-To: <CAFULd4Zjd6idrLXuF59cwKxyd1a--DsiJwGQAKai9Tph30dAow@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Oct 2023 12:24:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgSsfo89ESHcngvPCkQSh_YAJG-0g7fupb+Uv0E1d_EcQ@mail.gmail.com>
Message-ID: <CAHk-=wgSsfo89ESHcngvPCkQSh_YAJG-0g7fupb+Uv0E1d_EcQ@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     Nadav Amit <namit@vmware.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>
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

On Mon, 16 Oct 2023 at 11:53, Uros Bizjak <ubizjak@gmail.com> wrote:
>
> Unfortunately, it does not work and dies early in the boot with:

Side note: build the kernel with debug info (the limited form is
sufficient), and then run oopses through

  ./scripts/decode_stacktrace.sh

to get much nicer oops information that has line numbers and inlining
information in the backtrace.

> [    4.939358] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [    4.940090] RIP: 0010:begin_new_exec+0x8f2/0xa30
> [    4.940090] Code: 31 f6 e8 c1 49 f9 ff e9 3c fa ff ff 31 f6 4c 89
> ef e8 b2 4a f9 ff e9 19 fa ff ff 31 f6 4c 89 ef e8 23 4a f9 ff e9 ea
> fa ff ff <f0> 41 ff 0c 24 0f
> 85 55 fb ff ff 4c 89 e7 e8 4b 02 df ff e9 48 fb

That decodes to

   0: 31 f6                xor    %esi,%esi
   2: e8 c1 49 f9 ff        call   0xfffffffffff949c8
   7: e9 3c fa ff ff        jmp    0xfffffffffffffa48
   c: 31 f6                xor    %esi,%esi
   e: 4c 89 ef              mov    %r13,%rdi
  11: e8 b2 4a f9 ff        call   0xfffffffffff94ac8
  16: e9 19 fa ff ff        jmp    0xfffffffffffffa34
  1b: 31 f6                xor    %esi,%esi
  1d: 4c 89 ef              mov    %r13,%rdi
  20: e8 23 4a f9 ff        call   0xfffffffffff94a48
  25: e9 ea fa ff ff        jmp    0xfffffffffffffb14
  2a:* f0 41 ff 0c 24        lock decl (%r12) <-- trapping instruction
  2f: 0f 85 55 fb ff ff    jne    0xfffffffffffffb8a
  35: 4c 89 e7              mov    %r12,%rdi
  38: e8 4b 02 df ff        call   0xffffffffffdf0288

but without a nicer backtrace it's nasty to guess where this is.

The "lock decl ; jne" is a good hint, though - that sequence is most
definitely "atomic_dec_and_test()".

And that in turn means that it's almost certainly mmdrop(), which is

        if (unlikely(atomic_dec_and_test(&mm->mm_count)))
                __mmdrop(mm);

where that

  35: 4c 89 e7              mov    %r12,%rdi
  38: e8 4b 02 df ff        call   0xffffffffffdf0288

is exactly the unlikely "__mmdrop(mm)" part (and gcc decided to make
the likely branch a branch-out for some reason - presumably with the
inlining the code around it meant that was the better layout - maybe
this was all inside another "unlikely()" branch.

And if I read that right, this has all been inlined from
begin_new_exec() -> exec_mmap() -> mmdrop_lazy_tlb().

Now, how and why 'mm' would be NULL in that path, and why any
'current' reloading optimization would matter in this all I very much
can't see. The call site in begin_new_exec() is

        /*
         * Release all of the old mmap stuff
         */
        acct_arg_size(bprm, 0);
        retval = exec_mmap(bprm->mm);
        if (retval)
                goto out;

        bprm->mm = NULL;

and "bprm->mm" is most definitely non-NULL there because we earlier did

So I suspect the problem happened much earlier, caused some nasty
internal corruption, and the odd 'mm is NULL' is just a symptom.

        retval = set_mm_exe_file(bprm->mm, bprm->file);

using it, and that would have oopsed had bprm->mm been NULL then.

So there's some serious corruption there, but from the oops itself I
can't tell the source. I guess if we get 'current' wrong anywhere, all
bets are off.

             Linus
