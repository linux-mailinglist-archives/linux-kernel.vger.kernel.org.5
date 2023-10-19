Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9FC7D003C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 19:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345876AbjJSRJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 13:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbjJSRJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 13:09:21 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB498113
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 10:09:19 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9b6559cbd74so1403259866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 10:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697735358; x=1698340158; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nE4fsIYsBmCRNwb93La93oAtrxtAoet3UHnKWJSghM0=;
        b=gtWRrOt9b2tAkhgj/dEUUh+ZaLd0Ixv83391ydMFm3fFl86sA+1S9lzLakCIWDOzEv
         EHIdgq1DUoC+LWDG3xwRG/s9WEFQXGzOqjINeYMdRB7Sc/2BUtvCZnKEUowDBJAK8uBP
         19KlLYsJc463J0zbX9NYI0aGdH8qRF9CVXQ3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697735358; x=1698340158;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nE4fsIYsBmCRNwb93La93oAtrxtAoet3UHnKWJSghM0=;
        b=RqhGtsCpMehbhFFjdoPzwwWU1HBCsjscPL9P/Eqa/3tH9MGqnkLbCVipwZlFzVZZYm
         GbCwfZHQcMHP+ej1z0XdQzdLFea1cqCtaEbD94Au9N8yQoEx0MOfucABEzOeXqJGmx9p
         Zxzz10KScymBl0JFJgBRk8cmEe4tu6c9UoH0tGO2CTadhkMLgcMHs4WmgxBY6sRIdXmK
         Gn17bvXFWqjLZVd4RaCstm4RXDORVLp/DGgXMJW1s2Sq3yYwBrUuDJwgiklEjbgG5Ukx
         Y9l2Z26TSyb/5F9O36o0q8uFzyZpbuv/XqV4M66ByDhz9aUhSU4mqI66VvEmRYp4c7X1
         roFA==
X-Gm-Message-State: AOJu0Yy1LKUlWU5elonpUfNFLnbib7PgrmiclpiYVkUVZF/IgHbJCOgb
        4iSpIPhzyXWMOhLeh22V4LXezux/IIlUNgYaP7hlQvVd
X-Google-Smtp-Source: AGHT+IG7YkAlfSuOESbL4zTvLNBFi3HF31QYkQMJixxMo7E79+RV64SnWRNcK9hacaZyIVqx9vUVnQ==
X-Received: by 2002:a17:906:db07:b0:9ae:6388:e09b with SMTP id xj7-20020a170906db0700b009ae6388e09bmr2205919ejb.40.1697735358250;
        Thu, 19 Oct 2023 10:09:18 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id j14-20020a170906104e00b009c5c5c2c5a4sm3814316ejj.219.2023.10.19.10.09.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 10:09:17 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-9b95622c620so1403552366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 10:09:17 -0700 (PDT)
X-Received: by 2002:a17:906:fe45:b0:9a9:eef6:434a with SMTP id
 wz5-20020a170906fe4500b009a9eef6434amr2219550ejb.36.1697735357153; Thu, 19
 Oct 2023 10:09:17 -0700 (PDT)
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
 <CAHk-=wgoWOcToLYbuL2GccbNXwj_MH-LxmB_7MMjw6uu50k57Q@mail.gmail.com> <CAFULd4ZXh2oDrTUWNginc3SjKzcEsJq=aTThvJ47msmCYbRsnw@mail.gmail.com>
In-Reply-To: <CAFULd4ZXh2oDrTUWNginc3SjKzcEsJq=aTThvJ47msmCYbRsnw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Oct 2023 10:08:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiDDkik_ZnQsHJjZUNzH+XZvwPN-8ddW-0XOpF-sXcV2Q@mail.gmail.com>
Message-ID: <CAHk-=wiDDkik_ZnQsHJjZUNzH+XZvwPN-8ddW-0XOpF-sXcV2Q@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2023 at 09:32, Uros Bizjak <ubizjak@gmail.com> wrote:
>
> Perhaps you will be interested in chapter 6.47.2.1, "Volatile" of GCC
> manual that says:
>
> " Under certain circumstances, GCC may duplicate (or remove duplicates
> of) your assembly code when optimizing."
>
> The compiler may re-materialize non-volatile asm in the same way it
> may re-materialize arguments from non-volatile memory. To avoid this,
> volatile asm is necessary when unstable memory arguments are accessed
> using this_* variants.

That's disgusting. The whole (and only) point of rematerialization is
as an optimization. When gcc doesn't know how expensive an inline asm
is (and they can be very expensive indeed), doing remat on it would be
an obvious mistake.

I think what you say is "we're technically allowed to do it, but we'd
be crazy to *actually* do it".

The kernel does require a sane compiler. We will turn off options that
make it do insane things - even when said insane things are allowed by
a bad standard.

Do you actually have gcc code that rematerializes an inline asm?

                   Linus
