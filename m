Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231F77C03BC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 20:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbjJJSws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 14:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjJJSwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 14:52:47 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775DD93
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 11:52:45 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9adb9fa7200so31818066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 11:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1696963964; x=1697568764; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=db9Oi6F6RL9E8C11RxMz6HerARrBDQPURLZa8LiTjno=;
        b=be/Dyz6uosfEopDH8TV7QBPZSmlNCoRFWbn6UjBq1vDSxDWYCsasbg84CpLzYuXSD1
         00jH87GtRQDgOB31tMHnPS6dsrt3eAn2fJTXTd6yUnFma6UTA1ryZBxPppajpAGOgvmR
         /tx7sX3urQCaWjiVRxRtJF+LIuFO2S3ISMDNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696963964; x=1697568764;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=db9Oi6F6RL9E8C11RxMz6HerARrBDQPURLZa8LiTjno=;
        b=t59rjGe60w9h4c7Uv9NUUC9GDxKoWJj1CjmSm1NCHA4NDjLmacKFk5KezjrDhZoxsz
         pMPp80X2k1tD+yTQBxAkpJr9UOPQsKzc5CONKM5yrqotcKYGw1gX9i+THVtudrnk63O1
         StBaBmJlnAoSPgqm2oSLaT4vRFb6E1lU/mhhvIMb+dhVoiHTQneYyNrSLrh5sNu3m9G8
         AcNNuZ+YnNjT4JOYKVFHr0AXnq52h4UurDXcY6ppDIWEzVlK4vVdIFLC6rx/b+c+QCIa
         y2Y2KYOBEo8BqAJsVdDEHbjpOWvVeRGZF46rjeNqb4KecUHX5aSVBfqCaKA/EjTa4HZ6
         zv2A==
X-Gm-Message-State: AOJu0YwVmiaJL/Aji0518EjRyVkj3U7jP2Erec5Z9NjO6V+vMBoG3fq6
        2vE8vJa/b81/sQVHmQgTDmr82+5o7TjD5oe6Hd9p2IRC
X-Google-Smtp-Source: AGHT+IEH7saZF2aJvoG3QQ0S+HUKQtQ6r9gXsEn62GLiw17RVE+44PXKJVfKo89vdvL5NDHKA1V76g==
X-Received: by 2002:a17:907:3da3:b0:9ae:614f:b159 with SMTP id he35-20020a1709073da300b009ae614fb159mr13376546ejc.36.1696963963860;
        Tue, 10 Oct 2023 11:52:43 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id dv8-20020a170906b80800b0099cc36c4681sm8774078ejb.157.2023.10.10.11.52.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 11:52:42 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so275279a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 11:52:42 -0700 (PDT)
X-Received: by 2002:a05:6402:348e:b0:530:cc8c:9e41 with SMTP id
 v14-20020a056402348e00b00530cc8c9e41mr12747972edc.19.1696963962488; Tue, 10
 Oct 2023 11:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <20231010164234.140750-1-ubizjak@gmail.com> <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com> <CAFULd4Y8NSArDqH=VMy8F97eNosUUGxrBMEyHH=MytjUBSCmjg@mail.gmail.com>
In-Reply-To: <CAFULd4Y8NSArDqH=VMy8F97eNosUUGxrBMEyHH=MytjUBSCmjg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 10 Oct 2023 11:52:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=whMr8V_q3dq4iS0dpx4Nssu+aYWz+mA36p2ykA+OXTjXA@mail.gmail.com>
Message-ID: <CAHk-=whMr8V_q3dq4iS0dpx4Nssu+aYWz+mA36p2ykA+OXTjXA@mail.gmail.com>
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
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2023 at 11:41, Uros Bizjak <ubizjak@gmail.com> wrote:
>
> Yes, but does it CSE the load from multiple addresses?

Yes, it should do that just right, because the *asm* itself is
identical, just the offsets (that gcc then adds separately) would be
different.

This is not unlike how we depend on gcc CSE'ing the "current" part
when doing multiple accesses of different members off that:

    static __always_inline struct task_struct *get_current(void)
    {
        return this_cpu_read_stable(pcpu_hot.current_task);
    }

with this_cpu_read_stable() being an inline asm that lacks the memory
component (the same way the fallback hides it by just using
"%%gs:this_cpu_off" directly inside the asm, instead of exposing it as
a memory access to gcc).

Of course, I think that with the "__seg_gs" patches, we *could* expose
the "%%gs:this_cpu_off" part to gcc, since gcc hopefully then can do
the alias analysis on that side and see that it can CSE the thing
anyway.

That might be a better choice than __FORCE_ORDER, in fact.

IOW, something like

    static __always_inline unsigned long new_cpu_offset(void)
    {
        unsigned long res;
        asm(ALTERNATIVE(
                        "movq " __percpu_arg(1) ",%0",
                        "rdgsbase %0",
                        X86_FEATURE_FSGSBASE)
                : "=r" (res)
                : "m" (this_cpu_off));
        return res;
    }

would presumably work together with your __seg_gs stuff.

UNTESTED!!

            Linus
