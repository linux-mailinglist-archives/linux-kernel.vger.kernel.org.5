Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD1C7CCF89
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 23:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbjJQVx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 17:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjJQVxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 17:53:55 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DB0B0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:53:54 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9b1ebc80d0aso969706866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697579632; x=1698184432; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=psxzYy8Ro6VCd0vtaHbgahw7/JWUti7oPPeTmbqEN7o=;
        b=PviMAFjmQlBe39l+CiUpy8lAgv3LnR19JBAVxakMoarbksmaSI2boIW1zM7un9IsVi
         Ui5pRxSoj5+txLC+2dpT6Yt/qom+Fcl1syBUizMqXnb6jee7fZ9XYR2BIY62nlJ+el2g
         WZKDlIowslBgSqi5TRn16rnGadiVMB7awMBj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697579632; x=1698184432;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=psxzYy8Ro6VCd0vtaHbgahw7/JWUti7oPPeTmbqEN7o=;
        b=s72zq5JmJejoMDztt86Z8iC1PKQee8zAF6cqk86noDdJY1K2+CGE20PANWbJsacT6F
         g/FqWZ9XtukjKVLlMMiQplzHKTrZsAFarWy1VStEUu7im1C2JiuC73ElnqMlpWai2Uqf
         VIMdH3rhQddeX9PWijmENgAD/hUyF11JlTJJn0+A1K6DGF3QbDVx9Qa0e7Y1RhTvWVxs
         9NU08OOaqPpIyezDf+cK421U2UQxRnsjwQi7QkleVNM3yiD6QxWjCWufPBNHHmYH86CD
         SAMvh7K0+Antqu0mDPAtzXJv/6F0qBRmNnavtWgGtjXxYXCgapVXq0YaibMP4ydzT5mK
         a9Bw==
X-Gm-Message-State: AOJu0YyvwQNaQIKZ1XaZhsr3MsLf9rJnG4mvt+kmOt/sthX4W6Az0ZxV
        rKt0v6k+agV3628fw0tGSUBcsTKnRqWZKZ802MOeWKmz
X-Google-Smtp-Source: AGHT+IEiYCGvORSzHzMnnLuYN482T9kR7FkRIvPzWMqYnrY/k8G3DD25SGvG4ysms+OrQoRawvFGVw==
X-Received: by 2002:a17:907:3fa3:b0:9bd:c592:e0ce with SMTP id hr35-20020a1709073fa300b009bdc592e0cemr2782381ejc.51.1697579632545;
        Tue, 17 Oct 2023 14:53:52 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id k19-20020a170906579300b0099bd5d28dc4sm429455ejq.195.2023.10.17.14.53.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 14:53:51 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5384975e34cso10918680a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:53:51 -0700 (PDT)
X-Received: by 2002:a17:907:25c4:b0:9c4:4b20:44b2 with SMTP id
 ae4-20020a17090725c400b009c44b2044b2mr2580462ejc.23.1697579631483; Tue, 17
 Oct 2023 14:53:51 -0700 (PDT)
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
 <CAFULd4bpHkNzCzKed23mTTBWRyhPnOm91f+F6UE413VK+oFtMQ@mail.gmail.com> <CAFULd4Z-q4Ot6iyOLo7DkjE=dY3RHXUV+yx6R0iWk=-tZ6ufhQ@mail.gmail.com>
In-Reply-To: <CAFULd4Z-q4Ot6iyOLo7DkjE=dY3RHXUV+yx6R0iWk=-tZ6ufhQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Oct 2023 14:53:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjSnECwAe+Bi0PD6uods3ZDs8up5OAy-qZKF5OgPLpDiA@mail.gmail.com>
Message-ID: <CAHk-=wjSnECwAe+Bi0PD6uods3ZDs8up5OAy-qZKF5OgPLpDiA@mail.gmail.com>
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

On Tue, 17 Oct 2023 at 14:06, Uros Bizjak <ubizjak@gmail.com> wrote:
>
> But adding the attached patch on top of both patches boots OK.

Funky.

Mind adding a

        WARN_ON_ONCE(!active_mm);

to there to give a nice backtrace for the odd NULL case.

That code *is* related to 'current', in how we do

        tsk = current;
...
        local_irq_disable();
        active_mm = tsk->active_mm;
        tsk->active_mm = mm;
        tsk->mm = mm;
...
        activate_mm(active_mm, mm);
...
        mmdrop_lazy_tlb(active_mm);

but I don't see how 'active_mm' could *poossibly* be validly NULL
here, and why caching 'current' would matter and change it.

Strange.

Hmm. We do set

        tsk->active_mm = NULL;

in copy_mm(), and then we have that odd kernel thread case:

        /*
         * Are we cloning a kernel thread?
         *
         * We need to steal a active VM for that..
         */
        oldmm = current->mm;
        if (!oldmm)
                return 0;

but none of this should even matter, because by the time we actually
*schedule* that thread, we'll set active_mm to the right thing.

Can anybody see what's up?

             Linus
