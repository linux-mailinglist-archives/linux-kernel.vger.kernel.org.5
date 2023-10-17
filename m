Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3052D7CCB81
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344020AbjJQTBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234992AbjJQTA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:00:59 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6DAB0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 12:00:57 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9be3b66f254so604192166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 12:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697569256; x=1698174056; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8eFHCOzN0B4Aj/Uzad3Mw8nk7BErU1ParoR6czT34U=;
        b=f2lR4fmVMcyZE1Bxdofjzq+0KDZt+hicVKcZV+2Fl15YL0smWLYhvRhaun62XRy2Fp
         mN6I2pg07/aYz/qimp72ELl2kqZZGXRb8UaEnVj4M16NstEKYrkWubxcVIXJfASVjLE7
         qtmJo38nbv/uFFN0LsYi6INwHM1q/c/JBtU3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697569256; x=1698174056;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q8eFHCOzN0B4Aj/Uzad3Mw8nk7BErU1ParoR6czT34U=;
        b=nDuNqFmtzerYjXC4xtvb6mZ0qhJJpCSpX+FTfvKpbx3F8iq/YnIUro9mvEiV3cL6Zd
         QydnW1WOrWpiwfaKHI8hvRAi0tV/6+pNcDm3VmA7KJ+dXFDuAyMY7iqF/V8PGx1MLSMZ
         rkZL72XsPtathEJ2Xe7x5KqFy6Kn1HlNi+bH7erUdlBOh4RbjD6Gj09nVw/Z1Z7daJJ7
         ImYU37EbhXAbGK3VWs2fXfCPNq+yjzctmF4OYvzw4Rb50dzul8b4fARACv9wdjpUsS6B
         llxCUznT9HwDpX+HRwZsMvNNscJHFGiyfc3g+E4iTtnhhqjn4mhusfc8Yja5NiXmfWPH
         6ihA==
X-Gm-Message-State: AOJu0Yy1AeaZbjWQmm+h68c8mwpkMvwpDm12IahJ6MrwwDNNp/RSfMUq
        7WY9u0pf78qOQMwKMPzv2LndVI7CFoNW5bHGq+/PZCnp
X-Google-Smtp-Source: AGHT+IFzCb298uMjS6OIclAGc+Yvtouy+BkYT8L4zrcmOsJm8oPQKHW2sH1oy1qFv2Ku1K/lKYFFig==
X-Received: by 2002:a17:907:c08:b0:9bd:e017:370e with SMTP id ga8-20020a1709070c0800b009bde017370emr2730834ejc.54.1697569256022;
        Tue, 17 Oct 2023 12:00:56 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a10-20020a170906244a00b009920a690cd9sm268755ejb.59.2023.10.17.12.00.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 12:00:54 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-53de0d1dc46so10462185a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 12:00:54 -0700 (PDT)
X-Received: by 2002:a17:907:78d1:b0:9c6:3c94:69de with SMTP id
 kv17-20020a17090778d100b009c63c9469demr1559185ejc.53.1697569254221; Tue, 17
 Oct 2023 12:00:54 -0700 (PDT)
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
 <9F926586-20D9-4979-AB7A-71124BBAABD3@vmware.com>
In-Reply-To: <9F926586-20D9-4979-AB7A-71124BBAABD3@vmware.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Oct 2023 12:00:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi7YKPKKZw5SpA9gZcf4paG4pZ2kUM50g-LQmdF0g6vWg@mail.gmail.com>
Message-ID: <CAHk-=wi7YKPKKZw5SpA9gZcf4paG4pZ2kUM50g-LQmdF0g6vWg@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Nadav Amit <namit@vmware.com>
Cc:     Uros Bizjak <ubizjak@gmail.com>,
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

On Tue, 17 Oct 2023 at 00:23, Nadav Amit <namit@vmware.com> wrote:
>
> Yes, the FPU issue is the one that caused me to crash before.

Uros, can you verify whether that patch of mine resolves the issue you saw?

That patch is _technically_ an actual bug-fix, although right now our
existing 'current' caching that depends on just CSE'ing the inline asm
(and is apparently limited to only doing so within single basic
blocks) doesn't actually trigger the bug in our __switch_to() logic in
practice.

            Linus
