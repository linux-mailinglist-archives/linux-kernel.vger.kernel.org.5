Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599A17C5DE1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 21:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346812AbjJKTwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 15:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233369AbjJKTwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 15:52:19 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E099E
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 12:52:15 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9a9f139cd94so30544466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 12:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697053934; x=1697658734; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GfFDJdH5W2KsoZBFM8tAF2+ELipfCkZ7tnwEzIAb7iM=;
        b=aOY5eeiodXb7Zhynz7Z4S8ASd5wJHZIxXiYTSSH4XEQrVGf32YBG4oKnjLCMQ4Mkmh
         QDLm90BbXN2/o1woOHC/E6F1PTp2DXMgZe3bbUtP78oQ1wggmk8G79SxridTo55Zmyeq
         OXKOqmSCNsmgFXB6C5NfTtjv0DIW4xy52HwtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697053934; x=1697658734;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GfFDJdH5W2KsoZBFM8tAF2+ELipfCkZ7tnwEzIAb7iM=;
        b=ietqx50BopVJyXw4bPHtE+G/aiPJi5nHb6jJbk+ZWhZfDXu893lkNIx9V2yzsEJdeR
         Fj6kCO7QZo0lXQRvBgIJ/RjD2eBQDLBWwi1jv2yDxxrDM346gme4zv8hv+LEiooBQyGO
         eDmb5Dg21J4GcJ2g/Z6na32JksUg3UpTOoNtE6JVutafk3meFpjigQv8RLvD//HhOnsG
         yjON0BkU0vZBqhsrG42Aj2iesbGAuZcLxssLdB1MpAGme+FkIz05QXyUkO0f8WCDYQ4n
         A3UEN5RrhKdEd2oZBmC2t7t2tOTrvENQby5OpHhIZu2BfL2A3lqGj29zYDXTfXAieMss
         0UZw==
X-Gm-Message-State: AOJu0Yykar14ag5gY9nTL41BIeTSBs+ivYB57eDrpAsPULzpkVMiKByW
        NR2pPfAJ8Us03qtNTeeSoJrXx2jMl5wBQ2x06onJ8Szi
X-Google-Smtp-Source: AGHT+IFlOpDu8vnTc1gVf+N4yTh1A/lFwjZLKQNd0CkMQqlSrNbwBup7fTU5OoJ+f8ZaJntBCHtIxw==
X-Received: by 2002:a17:906:100e:b0:9b3:47f:1c05 with SMTP id 14-20020a170906100e00b009b3047f1c05mr17326723ejm.64.1697053933940;
        Wed, 11 Oct 2023 12:52:13 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id e25-20020a1709062c1900b009adc77fe164sm10250416ejh.66.2023.10.11.12.52.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 12:52:13 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-53dd3f169d8so426786a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 12:52:13 -0700 (PDT)
X-Received: by 2002:a05:6402:1859:b0:530:74ed:fc8a with SMTP id
 v25-20020a056402185900b0053074edfc8amr19163331edy.41.1697053933076; Wed, 11
 Oct 2023 12:52:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231010164234.140750-1-ubizjak@gmail.com> <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <CAFULd4Y8NSArDqH=VMy8F97eNosUUGxrBMEyHH=MytjUBSCmjg@mail.gmail.com>
 <CAHk-=whMr8V_q3dq4iS0dpx4Nssu+aYWz+mA36p2ykA+OXTjXA@mail.gmail.com> <CAFULd4afyYK0-wAOo3oJDapX0iyu86m5+vVn9c35gk8fd6iwRQ@mail.gmail.com>
In-Reply-To: <CAFULd4afyYK0-wAOo3oJDapX0iyu86m5+vVn9c35gk8fd6iwRQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Oct 2023 12:51:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiLyA0g3BvQ_nsF2PWi-FDtcNS5+4-ai1FX-xFzTBeTzg@mail.gmail.com>
Message-ID: <CAHk-=wiLyA0g3BvQ_nsF2PWi-FDtcNS5+4-ai1FX-xFzTBeTzg@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Nadav Amit <namit@vmware.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
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

On Wed, 11 Oct 2023 at 11:42, Uros Bizjak <ubizjak@gmail.com> wrote:
>
> The attached patch was tested on a target with fsgsbase CPUID and
> without it. It works!

.. I should clearly read all my emails before answering some of them.

Yes, that patch looks good to me, and I'm happy to hear that you
actually tested it unlike my "maybe something like this".

> The patch improves amd_pmu_enable_virt() in the same way as reported
> in the original patch submission and also reduces the number of percpu
> offset reads (either from this_cpu_off or with rdgsbase) from 1663 to
> 1571.

Dio y ou have any actka performance numbers? The patch looks good to
me, and I *think* rdgsbase ends up being faster in practice due to
avoiding a memory access, but that's very much a gut feel.

> The only drawback is a larger binary size:
>
>   text    data     bss     dec     hex filename
> 25546594        4387686  808452 30742732        1d518cc vmlinux-new.o
> 25515256        4387814  808452 30711522        1d49ee2 vmlinux-old.o
>
> that increases by 31k (0.123%), probably due to 1578 rdgsbase alternatives.

I'm actually surprised that it increases the text size. The 'rdgsbase'
instruction should be smaller than a 'mov %gs', so I would have
expected the *data* size to increase due to the alternatives tables,
but not the text size.

[ Looks around ]

Oh. It's because we put the altinstructions into the text section.
That's kind of silly, but whatever.

So I think that increase in text-size is not "real" - yes, it
increases our binary size because we obviously have two instructions,
but the actual *executable* part likely stays the same, and it's just
that we grow the altinstruction metadata.

                  Linus
