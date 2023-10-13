Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D0F7C8D58
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 20:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjJMSzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 14:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJMSzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 14:55:07 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E650BB
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 11:55:05 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9be3b66f254so34305666b.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 11:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697223304; x=1697828104; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vTnCuQhHu4vMJ5ozMAEPYZByiFfPswag7KkaGVloQKk=;
        b=bqDpJuarTe0xYUp8E2Z8K31fSWhh6FFn+zDQZbfbeCNjT8ztCg7jUYLlZelh1MOYs2
         fZFfNifMRfUL/ZFcdJ7yxHzbvacHBmn/vVPEsgl3NyCogHTh2bIUl7HE0mImJ2Z033r4
         7sGm1pIlttsm+tunGIRtoAhPelsRlZ1oE+65U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697223304; x=1697828104;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vTnCuQhHu4vMJ5ozMAEPYZByiFfPswag7KkaGVloQKk=;
        b=h+KlB7JkAvvY1tAMpeXwiR8TbMlFYyYmGSpPBbiTmkwj9iC4dm63iA/77BSthK3RSt
         VbsHL/imM12wINUJCuxx77PpDpvGySe+Ogbje7bjw8AoYmPmJfzcWkJ2nzIbiPNFRTJh
         lOhfgRStGhzDRbntThUoYPuETdPxk1We4tsoG9xA0ZDW7WmTPBPMTw8ddmjygl1oyM62
         CJ5/7YQANQ63p0s1JzLRSAo4nQiCXzKRpoUtICmo26nreS1ZRjYIdYkTB9oow/uUiUla
         T4wLhkoAKup79ZwnHPguBljFldwxBWgo8N28Fa32TBtvFahsec7YR1U9iICvAwOgToA5
         WzfQ==
X-Gm-Message-State: AOJu0YzS9sKSe5z61AommyBAl38eTv59ZRTRHC3v9JJQs8Kj58zJt6Ng
        C8L+iqthS2h0rsHFcrVWcoZqBX3wKflDYdoBLF122w==
X-Google-Smtp-Source: AGHT+IHjl/UtDt96Jwf7Uc8dOBIYYS72HR7IpJxWDb/qTMlELBZd0NYaryEu21KpK/elbm2rb6lMKw==
X-Received: by 2002:a17:907:778e:b0:9a1:bd82:de24 with SMTP id ky14-20020a170907778e00b009a1bd82de24mr24120517ejc.12.1697223304048;
        Fri, 13 Oct 2023 11:55:04 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id rn4-20020a170906d92400b0099bc038eb2bsm12651044ejb.58.2023.10.13.11.55.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 11:55:03 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-99c3c8adb27so382521266b.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 11:55:03 -0700 (PDT)
X-Received: by 2002:a17:906:2189:b0:9ae:6ad0:f6db with SMTP id
 9-20020a170906218900b009ae6ad0f6dbmr23995223eju.71.1697223303355; Fri, 13 Oct
 2023 11:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220927131518.30000-1-ojeda@kernel.org> <20220927131518.30000-26-ojeda@kernel.org>
 <Y0BfN1BdVCWssvEu@hirez.programming.kicks-ass.net> <CABCJKuenkHXtbWOLZ0_isGewxd19qkM7OcLeE2NzM6dSkXS4mQ@mail.gmail.com>
 <CANiq72k6s4=0E_AHv7FPsCQhkyxf7c-b+wUtzfjf+Spehe9Fmg@mail.gmail.com>
 <CABCJKuca0fOAs=E6LeHJiT2LOXEoPvLVKztA=u+ARcw=tbT=tw@mail.gmail.com>
 <20231012104741.GN6307@noisy.programming.kicks-ass.net> <CABCJKufEagwJ=TQnmVSK07RDjsPUt=3JGtwnK9ASmFqb7Vx8JQ@mail.gmail.com>
 <202310121130.256F581823@keescook> <CAOcBZOTed1a1yOimdUN9yuuysZ1h6VXa57+5fLAE99SZxCwBMQ@mail.gmail.com>
 <20231013075005.GB12118@noisy.programming.kicks-ass.net> <CAOcBZOTP_vQuFaqREqy-hkG69aBvJ+xrhEQi_EFKvtsNjne1dw@mail.gmail.com>
In-Reply-To: <CAOcBZOTP_vQuFaqREqy-hkG69aBvJ+xrhEQi_EFKvtsNjne1dw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 13 Oct 2023 11:54:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjLUit_gae7anFNz4sV0o2Uc=TD_9P8sYeqMSeW_UG2Rg@mail.gmail.com>
Message-ID: <CAHk-=wjLUit_gae7anFNz4sV0o2Uc=TD_9P8sYeqMSeW_UG2Rg@mail.gmail.com>
Subject: Re: [PATCH v10 25/27] x86: enable initial Rust support
To:     Ramon de C Valle <rcvalle@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        David Gow <davidgow@google.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2023 at 05:18, Ramon de C Valle <rcvalle@google.com> wrote:
>
> Both C and repr(C) Rust structs have this encoding, but I understand
> the problems with doing this in C since it doesn't have
> repr(transparent) structs so there would be a lot of casting back and
> forth. Maybe there is an alternative or this could be done for less
> used function pairs?

We actually have some C variations of what I think people want to use
"repr(transparent) struct" for in Rust.

Of course, that is depending on what kind of context you want to use
it for, and I might have lost some background. But I'm assuming you're
talking about the situation where you want to treat two or more types
as being "compatible" within certain contexts.

There's the actual standard C "_Generic()" alternative, which allows
you to make macros etc that use different types transparently.

It's not very widely used in the kernel, because we only fairly
recently moved to require recent enough compiler versions, but we do
use it now in a couple of places.

And there's the much more traditional gcc extension in the form of the
__attribute__((__transparent_union__)) thing. In the kernel, that one
is even less used, and that one use is likely going away since the
need for it is going away.

But while it's not standard C, it's actually been supported by
relevant compilers for much longer than "_Generic" has, and is
designed exactly for the "I have a function that can take arguments of
different types", either because the types are bitwise identical (even
if _conceptually_ not the same), or simply because you have a
different argument that describes the type (the traditional C union
model).

I suspect, for example, that we *should* have used those transparent
unions for the "this function can take either a folio or a page" case,
instead of duplicating functions for the two uses.

But probably because few people aren familiar with the syntax, that's
not what happened.

             Linus
