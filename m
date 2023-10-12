Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11387C7719
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442340AbjJLTlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442210AbjJLTlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:41:15 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B082BB
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:41:13 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so2377227a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697139672; x=1697744472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZuaDBcAqFMciEz4ZI1c+gQ/QSSvF5sHgbYm/hkimkbM=;
        b=R2SKaFntGR15mNVDq37kEYa7Fhki4ATMHhI0vEk4L81Vk+voHhia2gmNUU9GrzCpA6
         MGJMrViy0BC5BYIrk0v94eF+OfGVcjGsTPiaL1LZyVDEo2OYky7EtOZTvlpnGbt3Q1/5
         4cG9w9ffwT4vl6kRPzm1qJSj0OzheB3EtkbDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697139672; x=1697744472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZuaDBcAqFMciEz4ZI1c+gQ/QSSvF5sHgbYm/hkimkbM=;
        b=r6rzgaUegk41ETXPyAtn1Y/yz3nibE+fxFlSpCZayy15Ps+pbHS/uLABw2plzQfU4T
         urtFOHmrOf+Dpoqjfdy6+T4/yWqBk0M1dp5EHa7Oi/bS2S0DmDJogBUSzM5jERtu06jy
         XUPwnI2+WmigBBucDQA1ewTOAFpCGxsTVPfwnnwDBt+0QXXMDKnjVY4GbX9WJhMr+bnw
         +rhFtWK3mdYbvbjhTTF8zI2BDEgfEpGrgLhGrlFn71KPW+AyfgJJtp93zoGhaN96sWSy
         yTyM0H22WTmm2HJCIpLq0x1H0hu5TX4gN8e81U//Bg7OD56juusYwxg1AM/uAD/ZlU5g
         s4iA==
X-Gm-Message-State: AOJu0YyEpYwuir98LhANvZ0ktb61XrVS0qIfef7QOs83aBtsdnPeaATl
        ebc9ARFAgNcijZV5LPjbs/HWBeTOedkTTcVTP0GkIQ==
X-Google-Smtp-Source: AGHT+IGYLgMH6TXnafdTUxlK0+7OK/74IksWR+ScMUAL8DEk7d8fqxcqwOzLimULJA37jBrFYy2gww==
X-Received: by 2002:a17:906:11e:b0:9bd:84af:e67a with SMTP id 30-20020a170906011e00b009bd84afe67amr4294819eje.54.1697139671937;
        Thu, 12 Oct 2023 12:41:11 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id re9-20020a170906d8c900b0099b8234a9fesm11409379ejb.1.2023.10.12.12.41.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 12:41:10 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-99c1c66876aso220151166b.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:41:10 -0700 (PDT)
X-Received: by 2002:a17:906:1da1:b0:9ba:65e:752b with SMTP id
 u1-20020a1709061da100b009ba065e752bmr14307248ejh.39.1697139670299; Thu, 12
 Oct 2023 12:41:10 -0700 (PDT)
MIME-Version: 1.0
References: <20231010164234.140750-1-ubizjak@gmail.com> <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <F48A9D34-3627-4372-B555-B58CBFC3F241@vmware.com> <CAHk-=wjF4gzCZKh-zN-sY0WpX1kCo+s9gYE9sOcSv0QieH1dwQ@mail.gmail.com>
 <CAFULd4bmOa7G2dXd_mu4J=_bsEs+TbxH691tYx9QQBwJPAma9w@mail.gmail.com>
 <CAHk-=wj2Co_g3RQ=JkDZC7PYbRqDPq7mePQ0=eYhhtpEgqJD0w@mail.gmail.com>
 <0617BB2F-D08F-410F-A6EE-4135BB03863C@vmware.com> <CAHk-=whNVf+YghEH4JNjp99NzG5+M7CQrLK42VNKnDydBG4ovA@mail.gmail.com>
 <6EB66FDE-DDE1-40FA-A391-AEFF963CA97E@vmware.com>
In-Reply-To: <6EB66FDE-DDE1-40FA-A391-AEFF963CA97E@vmware.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Oct 2023 12:40:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=whk1WOVzHdoQDm0wM+8ZrpG+zLucWCHhWAcs5OV7M6Q7Q@mail.gmail.com>
Message-ID: <CAHk-=whk1WOVzHdoQDm0wM+8ZrpG+zLucWCHhWAcs5OV7M6Q7Q@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2023 at 12:32, Nadav Amit <namit@vmware.com> wrote:
>
> If you refer to the difference between DECLARE_PER_CPU_ALIGNED() and
> DECLARE_PER_CPU() - that=E2=80=99s just a silly mistake that I made porti=
ng my
> old patch (I also put =E2=80=9Cconst=E2=80=9D in the wrong place of the d=
eclaration, sorry).

Yes, the only difference is the ALIGNED and the 'const', but I think
also the alias attribute.

However, I'd be happier if we had just one place that declares them, not tw=
o.

Even if the two were identical, it seems wrong to have two
declarations for the same thing.

> The =E2=80=9Ctrick=E2=80=9D that the patch does is to expose a new const_=
pcpu_hot symbol that has
> a =E2=80=9Cconst=E2=80=9D qualifier. For compilation units from which the=
 symbol is effectively
> constant, we use const_pcpu_hot. The compiler then knows that the value w=
ould not
> change.

Oh, I don't disagree with that part.

I just don't see why the 'asm' version would have any difference. For
that too, the compiler should see that the result of the asm doesn't
change.

So my confusion / worry is not about the const alias. I like that part.

My worry is literally "in other situations we _have_ to use asm(), and
it's not clear why gcc wouldn't do as well for it".

                  Linus
