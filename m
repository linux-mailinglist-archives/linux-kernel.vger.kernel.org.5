Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BEB7C73F5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379575AbjJLRRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347339AbjJLRRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:17:05 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D50C6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:17:03 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso201006566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697131021; x=1697735821; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wFXiKIURKZBCGix17NH07fGcqKfM7DqUcRWS63HZQM0=;
        b=BLIhoj2dAcUQY35Scp7r7h9OGOlfUl+asJ1I9dZgGPqVxKzPCDKQEuaK+2QZ6+OJ+N
         y1EBqzGHT2RBLQaQEPWHtS10sa63N+yMMo0kLqijDRyBeRGXmf6U+6lfafQRWg9+ERxl
         QE7G/utCrJx5v52/uPL/fc79vToqbNfgWC3eI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697131021; x=1697735821;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wFXiKIURKZBCGix17NH07fGcqKfM7DqUcRWS63HZQM0=;
        b=UGBL+R/hpYu/aCbC6aV0DCVd9qwPvlsLyrqnh9vllfJ1rVyUO5XhVf24omQVU+Egze
         6zUphQQkOQeVB5xcB7yPOOtspHNOXWzeoAdLvBeGo46ZqSShQKE3Jkh7ppk257kvsiZQ
         OCnsAmGnJ7tDcX7OUchPlecTtSn0CncqD/QSHaHrq6Ja3sObLFT7Xt9SIU1etsaDAk18
         w0IijhAuIWOemlpW4H5W4QD/sZfloEWPm8lJw9obhXNBck3aQ3uJ52MYrD0612C19U0b
         9XCQjOAXiMvvvuLGRcMxxYhrKUOYp+023Q00m6HaPpKXhY+PJZ6+rLkaYZpl5lm9jwsu
         dfSw==
X-Gm-Message-State: AOJu0YxzgLFlsYK3XwO36YA7GWDUCBKpwjKul43tidb7EdrLdWcv3TMX
        vQyrTwj0CnqfCtCC0FZD9KosNdyOZFAUVk0DUrcrFaON
X-Google-Smtp-Source: AGHT+IEJakrjDzl9r1HSJhCXKWdu3dIGLvwhLCF9kdkCXF16fgm9tKRAsIqozoeBAZFk8Vu5UrMdQQ==
X-Received: by 2002:a17:906:7697:b0:9b2:b119:4918 with SMTP id o23-20020a170906769700b009b2b1194918mr23759526ejm.13.1697131021724;
        Thu, 12 Oct 2023 10:17:01 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id cf7-20020a170906b2c700b009b296ce13a3sm11589882ejb.18.2023.10.12.10.17.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 10:17:01 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-9ad8a822508so203102366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:17:01 -0700 (PDT)
X-Received: by 2002:a17:906:8467:b0:9ae:62ec:f4a1 with SMTP id
 hx7-20020a170906846700b009ae62ecf4a1mr21592590ejc.33.1697131020742; Thu, 12
 Oct 2023 10:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <20231010164234.140750-1-ubizjak@gmail.com> <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <F48A9D34-3627-4372-B555-B58CBFC3F241@vmware.com> <CAHk-=wjF4gzCZKh-zN-sY0WpX1kCo+s9gYE9sOcSv0QieH1dwQ@mail.gmail.com>
 <CAFULd4bmOa7G2dXd_mu4J=_bsEs+TbxH691tYx9QQBwJPAma9w@mail.gmail.com>
 <CAHk-=wj2Co_g3RQ=JkDZC7PYbRqDPq7mePQ0=eYhhtpEgqJD0w@mail.gmail.com> <0617BB2F-D08F-410F-A6EE-4135BB03863C@vmware.com>
In-Reply-To: <0617BB2F-D08F-410F-A6EE-4135BB03863C@vmware.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Oct 2023 10:16:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=whNVf+YghEH4JNjp99NzG5+M7CQrLK42VNKnDydBG4ovA@mail.gmail.com>
Message-ID: <CAHk-=whNVf+YghEH4JNjp99NzG5+M7CQrLK42VNKnDydBG4ovA@mail.gmail.com>
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

On Thu, 12 Oct 2023 at 08:19, Nadav Amit <namit@vmware.com> wrote:
>
> +/*
> + * Hold a constant alias for current_task, which would allow to avoid caching of
> + * current task.
> + *
> + * We must mark const_current_task with the segment qualifiers, as otherwise gcc
> + * would do redundant reads of const_current_task.
> + */
> +DECLARE_PER_CPU(struct pcpu_hot const __percpu_seg_override, const_pcpu_hot);

Hmm. The only things I'm not super-happy about with your patch is

 (a) it looks like this depends on the alias analysis knowing that the
__seg_gs isn't affected by normal memory ops. That implies that this
will not work well with compiler versions that don't do that?

 (b) This declaration doesn't match the other one. So now there are
two *different* declarations for const_pcpu_hot, which I really don't
like.

That second one would seem to be trivial to just fix (or maybe not,
and you do it that way for some horrible reason).

The first one sounds bad to me - basically making the *reason* for
this patch go away - but maybe the compilers that don't support
address spaces are so rare that we can ignore it.

            Linus
