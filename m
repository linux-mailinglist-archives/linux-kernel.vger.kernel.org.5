Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CFD7D0235
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 21:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346413AbjJSTID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 15:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235518AbjJSTIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 15:08:02 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90026CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 12:07:58 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso7501466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 12:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697742477; x=1698347277; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pxkX0hlLsrsi0HqjozFEPHzJw86ORdSfG0zaw7CJEN0=;
        b=M8fNyV8V7ugc8Xf97wC4UhQxX1abftL3rgXD5RcckU6S42weGSD2KtT1wKAR5hI1uU
         RxdIFbNwYQtS/8bKqyw7nrDs7JFsKfTG7VHkYUjYkP8rpqdkf5VJb+u3DglsKYOLgcp4
         XXY+dxhNn7ZAQk1t9Pw39JYiKetZXrZmLybow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697742477; x=1698347277;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pxkX0hlLsrsi0HqjozFEPHzJw86ORdSfG0zaw7CJEN0=;
        b=iltV/2EIUTGY1tJyq51XqqgHTwLHapY7h5D65TgGsWuN9HClwvC/a7216G77ASA8X3
         xonP273BrAOzPZx4+S0UsiQR+n0Cd7M7RHl9BgtIj5GwA5gy3ee5VePSt69HySFg/MZ4
         kxjAjKnChYr5nm7c7hJNKqXUGT77yDo1QSE1dZmRY3AQvhfuCLMcaBY8SjlyOjpk34eK
         Be+iMCxHxNf67s4EkVkWZgS/DNwgLO717pSreiGYBZ2/suhqRlqpPyEZy3qLVMSv2UUB
         j2IbZo1S+nOM9IZ3spfGSgRFsUeZRcjLLOoiZaRTwQ+mBf0jliXjoLglukRTTzNym4V5
         3n5A==
X-Gm-Message-State: AOJu0Ywi0B2b1xMXiq2PTOPecM19n44ZYvt8wDW87EzqEtEOYu2aMCZa
        PmyiVG/ZG0Be95+FCUr2PZAEWkHQ3J9c4fMYEZD6R6cW
X-Google-Smtp-Source: AGHT+IEYrfQm5ZjiteqSMpvilmQOV33JnngdS+OV4K/KwHJgaDdBvkud+U+cb9DjWxMCAecKHp3Hyg==
X-Received: by 2002:a17:907:268e:b0:9c7:4d98:9847 with SMTP id bn14-20020a170907268e00b009c74d989847mr2406245ejc.53.1697742476747;
        Thu, 19 Oct 2023 12:07:56 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id 26-20020a170906011a00b009ae69c303aasm50924eje.137.2023.10.19.12.07.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 12:07:56 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-9936b3d0286so9324066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 12:07:56 -0700 (PDT)
X-Received: by 2002:a17:907:6092:b0:9b2:b9ad:ddd1 with SMTP id
 ht18-20020a170907609200b009b2b9adddd1mr2654778ejc.28.1697742475784; Thu, 19
 Oct 2023 12:07:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231010164234.140750-1-ubizjak@gmail.com> <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <F48A9D34-3627-4372-B555-B58CBFC3F241@vmware.com> <CAHk-=wjF4gzCZKh-zN-sY0WpX1kCo+s9gYE9sOcSv0QieH1dwQ@mail.gmail.com>
 <CAFULd4bmOa7G2dXd_mu4J=_bsEs+TbxH691tYx9QQBwJPAma9w@mail.gmail.com>
 <CAHk-=wj2Co_g3RQ=JkDZC7PYbRqDPq7mePQ0=eYhhtpEgqJD0w@mail.gmail.com>
 <0617BB2F-D08F-410F-A6EE-4135BB03863C@vmware.com> <CAFULd4Zjd6idrLXuF59cwKxyd1a--DsiJwGQAKai9Tph30dAow@mail.gmail.com>
 <CAHk-=wgSsfo89ESHcngvPCkQSh_YAJG-0g7fupb+Uv0E1d_EcQ@mail.gmail.com>
 <7D77A452-E61E-4B8B-B49C-949E1C8E257C@vmware.com> <CAHk-=wj1dLFkL9Qv2vtk0O8Q6WE-11Jq3KucZoz2Kkw59LAexw@mail.gmail.com>
 <9F926586-20D9-4979-AB7A-71124BBAABD3@vmware.com> <CAHk-=wi7YKPKKZw5SpA9gZcf4paG4pZ2kUM50g-LQmdF0g6vWg@mail.gmail.com>
 <CAFULd4bpHkNzCzKed23mTTBWRyhPnOm91f+F6UE413VK+oFtMQ@mail.gmail.com>
 <CAFULd4Z-q4Ot6iyOLo7DkjE=dY3RHXUV+yx6R0iWk=-tZ6ufhQ@mail.gmail.com>
 <CAHk-=wjSnECwAe+Bi0PD6uods3ZDs8up5OAy-qZKF5OgPLpDiA@mail.gmail.com>
 <CAFULd4bLEU-tBC8dO1wf66UAxQ2d1HxQ=D6wvtHZfdQCKhnpkw@mail.gmail.com>
 <CAFULd4YAFTFqon3ojv7N6h=G_1pAjSH3T6YvX0G=g7Fwh7j1jQ@mail.gmail.com>
 <A2E458DE-8B84-4FB2-BF6D-3EAB2B355078@vmware.com> <CAFULd4b_PdKb=8U5+Zz-XNoYdULtcQJnmf-yCrpCv7RRogSXyQ@mail.gmail.com>
 <CAFULd4Y8_MOMGcatcMuUaC89zX5F-VYr0niiJ9Yd8hQ16neHjw@mail.gmail.com>
 <3F9D776E-AD7E-4814-9E3C-508550AD9287@vmware.com> <CAFULd4Zruoq4b5imt3NfN4D+0RY2-i==KGAwUHR8JD0T8=HJBw@mail.gmail.com>
 <28B9471C-4FB0-4AB0-81DD-4885C3645E95@vmware.com> <CAHk-=whS8-Lk_=mFp=mr-JrbRYtScgz-4s_GLAOQGafa_3zP9g@mail.gmail.com>
 <CAFULd4Yy-v40tK94rexSOL99FGMke2Jk42wgcjoEBxV=2hXoCw@mail.gmail.com>
 <CAHk-=wjrLoy6xEDXB=piEUagDLMmV5Up7UK75W1D0E0UFVO-iA@mail.gmail.com>
 <CAFULd4autFT=96EckL9vUDgO5t0ESp27+NDVXQHGi7N=PAo-HQ@mail.gmail.com>
 <CAFULd4Zhw=zoDtir03FdPxJD15GZ5N=SV9=4Z45_Q_P9BL1rvQ@mail.gmail.com>
 <CAHk-=wgoWOcToLYbuL2GccbNXwj_MH-LxmB_7MMjw6uu50k57Q@mail.gmail.com>
 <CAHk-=wgCPbkf0Kdi=4T3LAVvNEH0jxJBWcTiBkrFDBsxkC9mKQ@mail.gmail.com>
 <CAFULd4aTY002A7NHRCX21aTpYOE=tnpouBk6hkoeWND=LnT4ww@mail.gmail.com>
 <CAHk-=wia9vFmyCJPkYg0vvegF8eojLy+DxVtpfoDv-UHoWKfqQ@mail.gmail.com>
 <CAFULd4Zj5hTvATZUVYhUGrxH3fiAUWjO9C27UV_USf2H164thQ@mail.gmail.com>
 <CAHk-=whEc2HR3En32uyAufPM3tEh8J4+dot6JyGW=Eg5SEhx7A@mail.gmail.com>
 <CAFULd4avm_TaEoRauohRc90SUrx-D+wBJvg+htQDQ1_N=zNemw@mail.gmail.com>
 <CAHk-=wijmmRB7-ZeT-sdxCSUoB83Lb5dnN7a7mCcH3cRw_aghQ@mail.gmail.com>
 <CAFULd4b91Tr9Q2p4a20eusC+QO6O81gxY+nP-zpFiFKGTmLpYg@mail.gmail.com>
 <CAHk-=wi3LZ_4OGAMhvgO0JSTp-eEPOGp+siq1nJNLY1JAxdP5Q@mail.gmail.com>
 <CAFULd4YxvMtTEfQL-RiLisTxDwoJZZxXXB+3CWqCpzZkUf85JA@mail.gmail.com> <CAHk-=wj0UTj3dfuKK=DEQ+AQ2GPUddjVUVZ_nRHdY=L_rRb2KQ@mail.gmail.com>
In-Reply-To: <CAHk-=wj0UTj3dfuKK=DEQ+AQ2GPUddjVUVZ_nRHdY=L_rRb2KQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Oct 2023 12:07:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgw6C9kgTAmD4r2XWMbaiMRG3ZqCzYs8VptVekuo2g=Qg@mail.gmail.com>
Message-ID: <CAHk-=wgw6C9kgTAmD4r2XWMbaiMRG3ZqCzYs8VptVekuo2g=Qg@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     peterz@infradead.org, Nadav Amit <namit@vmware.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2023 at 11:49, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Honestly, I've actually never seen gcc rematerialize anything at all.
>
> I really only started worrying about remat issues in a theoretical
> sense, and because I feel it would be relatively *easy* to do for
> something where the source is a load.

.. I started looking around, since I actually have gcc sources around.

At least lra-remat.cc explicitly says

   o no any memory (as access to memory is non-profitable)

so if we could just *rely* on that, it would actually allow us to use
memory ops without the volatile.

That would be the best of all worlds, of course.

I do have clang sources too, but I've looked at gcc enough that I at
least can do the "grep and look for patterns" and tend to have an idea
of what the passes are. Clang, not so much.

From my "monkey see patterns" check, it does look like clang mainly
just rematerializes immediates (and some address generation), but also
memory accesses without a base register (allowing a "base register" of
(%rip)).

See X86InstrInfo::isReallyTriviallyReMaterializable() in case anybody cares.

So it does look like clang might actually rematerialize exactly percpu
loads with a constant address, and my "those are easy to
rematerialize" worry may have been correct.

HOWEVER, I'd like to once again say that I know so little about llvm
that my "monkey with 'grep' and some pattern matching ability" thing
really means that I'm just guessing.

Now, PeterZ is obviously worried about even just CSE and re-ordering,
so remat isn't the *only* issue. I do agree that we've had 'volatile'
on many of the asms possibly hiding any issues for the last five
years.

                   Linus
