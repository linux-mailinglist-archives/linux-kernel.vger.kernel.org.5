Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D327CE5F3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 20:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjJRSLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 14:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjJRSLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 14:11:46 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A0798
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 11:11:45 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-991c786369cso1147005466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 11:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697652703; x=1698257503; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AG805s5rglsAs2sFJw1WGAFX/DsGdyuOOy8APS0Kxyc=;
        b=U0bC6VDvtRp02dUm3kTChDofZ7J6okSongRSWcBVrV8fLJ1MDvtmje8X9eSMvEUOeG
         enyb8yqzEVdrlgF+G1u3FVsgtBY3dXLWOtGh2SO11/AqPuiRZLqSWw3InNZt2XVIR0G2
         IXzh3ALbdYKUYCgyeCpuZo4PBPGImZXEyr+Bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697652703; x=1698257503;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AG805s5rglsAs2sFJw1WGAFX/DsGdyuOOy8APS0Kxyc=;
        b=MYgXf0G05WZJHh+ALOUCKrcvhjkckaYu1+dAaVh/wycM9V4FGZYxaWvR091GEZHrj7
         JHKqOCLsEkSSFVDOsZ4ZP2qYSCX3z5KCPStwkU5J9tliX1OLxyNb4PR1IwoNN3IJ7nMZ
         h5+DQFWY6PRS9YbuHZAHaRsmq2E1DzqNqERPQzFGMa1ZPs2w75vVsr2Jy2+YFTJYLEoN
         76Edimn4ZT1emD7Ry6ncKE6GaupgSKgHe45xc3lTHXX6pKogrX4pVoFdBuHNqu2eimjQ
         xFFm1ldp5UYRCNzg9bIC4r9e7w4lG09i5xVd+VDCF6+6SXa1Dk6CAVCRIhcm2IPzlzaP
         cAUA==
X-Gm-Message-State: AOJu0YxeNP6SVfeLucFlS6xaW9b+zxf0CXwmb0iLGvpKM6ljor9EP5EC
        nTePO9zUNSJuhcJqBzm8QZ6B/8MwdLfOEypMKvpv1a+4
X-Google-Smtp-Source: AGHT+IHSnNAiYxdA5J+CIn+lugVy/Bi+DN5ujLdDrBmugLeu5VCxKUy3ZPvwj4HTe4WydSJiPB0DxQ==
X-Received: by 2002:a17:906:ee8c:b0:9be:466c:1824 with SMTP id wt12-20020a170906ee8c00b009be466c1824mr43609ejb.11.1697652703476;
        Wed, 18 Oct 2023 11:11:43 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id fi10-20020a170906da0a00b0098669cc16b2sm2106461ejb.83.2023.10.18.11.11.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 11:11:43 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-53db1fbee70so12060275a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 11:11:42 -0700 (PDT)
X-Received: by 2002:a17:907:3e1a:b0:9b6:f0e2:3c00 with SMTP id
 hp26-20020a1709073e1a00b009b6f0e23c00mr14573ejc.71.1697652701886; Wed, 18 Oct
 2023 11:11:41 -0700 (PDT)
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
 <CAFULd4akMtMxk1C-NsfzYFP6rkt5QUuHACq+BFEJV6u_8n+yiA@mail.gmail.com>
In-Reply-To: <CAFULd4akMtMxk1C-NsfzYFP6rkt5QUuHACq+BFEJV6u_8n+yiA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Oct 2023 11:11:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=whm81-JmJ_ej8wPuifTOD7rF35MXjwJeGDKCR7h99Eyaw@mail.gmail.com>
Message-ID: <CAHk-=whm81-JmJ_ej8wPuifTOD7rF35MXjwJeGDKCR7h99Eyaw@mail.gmail.com>
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

On Wed, 18 Oct 2023 at 10:23, Uros Bizjak <ubizjak@gmail.com> wrote:
>
> In processor.h, we have:
>
> static __always_inline unsigned long current_top_of_stack(void)

Yeah, but that is never used multiple times afaik. I think it's purely
for things like

        WARN_ON_ONCE(!on_thread_stack());

in the entry code, for example.

So I guess it can use the same infrastructure, but I doubt it matters
in any practical way.

Grepping around for it, it looks like the 32-bit code has some stale commentary:

         * Reload esp0 and pcpu_hot.top_of_stack.  This changes
         * current_thread_info().

but that seems entirely bogus. We historically picked up
current_thread_info() from %esp, but that hasn't been true in ages,
afaik. Now it's all based on 'current'.

           Linus
