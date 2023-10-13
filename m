Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78A27C8D66
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 21:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjJMTCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 15:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjJMTCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 15:02:14 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389D2A9;
        Fri, 13 Oct 2023 12:02:13 -0700 (PDT)
Received: from [127.0.0.1] ([98.35.210.218])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 39DJ09gY2258410
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 13 Oct 2023 12:00:09 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 39DJ09gY2258410
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023091101; t=1697223611;
        bh=T1PyI12qkzl7tC8w46EdkMYBVYGjCYpIgqARTxewv6c=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=uV8K0ah0Z4rbshQs+Czco0l8mB3q3iMcNvCm1pFyMA5KNzw6uq5eHqrr/l3Wj56I+
         LWIyHctEy0tPK17/dZT2XQ0k635l+scnK0GbWt26cVgut5wpkHokSpe2FMNcYxVajY
         Gv5rejcpqLJo3qm0Bn0hGIf3CV/VJc/AJ5ymm+vWHt45Job1rg5iHElHRTzdmCymml
         fuzEWHWZpgw6WoCKpa8a8qBXT4ja3TPzCTB/2ELv8u75GnBmGU9FWVFacpSB3IaeuC
         4IDxdaHk5P3sETW5QYJxU2gFbtPVuy4wSRK3DeVYC7FyXI+K2+h6i6vrbIpOBE37RE
         wluBPN3GuXb4g==
Date:   Fri, 13 Oct 2023 12:00:06 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ramon de C Valle <rcvalle@google.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
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
        =?ISO-8859-1?Q?Bj=F6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v10 25/27] x86: enable initial Rust support
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=wjLUit_gae7anFNz4sV0o2Uc=TD_9P8sYeqMSeW_UG2Rg@mail.gmail.com>
References: <20220927131518.30000-1-ojeda@kernel.org> <20220927131518.30000-26-ojeda@kernel.org> <Y0BfN1BdVCWssvEu@hirez.programming.kicks-ass.net> <CABCJKuenkHXtbWOLZ0_isGewxd19qkM7OcLeE2NzM6dSkXS4mQ@mail.gmail.com> <CANiq72k6s4=0E_AHv7FPsCQhkyxf7c-b+wUtzfjf+Spehe9Fmg@mail.gmail.com> <CABCJKuca0fOAs=E6LeHJiT2LOXEoPvLVKztA=u+ARcw=tbT=tw@mail.gmail.com> <20231012104741.GN6307@noisy.programming.kicks-ass.net> <CABCJKufEagwJ=TQnmVSK07RDjsPUt=3JGtwnK9ASmFqb7Vx8JQ@mail.gmail.com> <202310121130.256F581823@keescook> <CAOcBZOTed1a1yOimdUN9yuuysZ1h6VXa57+5fLAE99SZxCwBMQ@mail.gmail.com> <20231013075005.GB12118@noisy.programming.kicks-ass.net> <CAOcBZOTP_vQuFaqREqy-hkG69aBvJ+xrhEQi_EFKvtsNjne1dw@mail.gmail.com> <CAHk-=wjLUit_gae7anFNz4sV0o2Uc=TD_9P8sYeqMSeW_UG2Rg@mail.gmail.com>
Message-ID: <5D8CA5EF-F5B0-4911-85B8-A363D9344FA7@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 13, 2023 11:54:46 AM PDT, Linus Torvalds <torvalds@linux-foundat=
ion=2Eorg> wrote:
>On Fri, 13 Oct 2023 at 05:18, Ramon de C Valle <rcvalle@google=2Ecom> wro=
te:
>>
>> Both C and repr(C) Rust structs have this encoding, but I understand
>> the problems with doing this in C since it doesn't have
>> repr(transparent) structs so there would be a lot of casting back and
>> forth=2E Maybe there is an alternative or this could be done for less
>> used function pairs?
>
>We actually have some C variations of what I think people want to use
>"repr(transparent) struct" for in Rust=2E
>
>Of course, that is depending on what kind of context you want to use
>it for, and I might have lost some background=2E But I'm assuming you're
>talking about the situation where you want to treat two or more types
>as being "compatible" within certain contexts=2E
>
>There's the actual standard C "_Generic()" alternative, which allows
>you to make macros etc that use different types transparently=2E
>
>It's not very widely used in the kernel, because we only fairly
>recently moved to require recent enough compiler versions, but we do
>use it now in a couple of places=2E
>
>And there's the much more traditional gcc extension in the form of the
>__attribute__((__transparent_union__)) thing=2E In the kernel, that one
>is even less used, and that one use is likely going away since the
>need for it is going away=2E
>
>But while it's not standard C, it's actually been supported by
>relevant compilers for much longer than "_Generic" has, and is
>designed exactly for the "I have a function that can take arguments of
>different types", either because the types are bitwise identical (even
>if _conceptually_ not the same), or simply because you have a
>different argument that describes the type (the traditional C union
>model)=2E
>
>I suspect, for example, that we *should* have used those transparent
>unions for the "this function can take either a folio or a page" case,
>instead of duplicating functions for the two uses=2E
>
>But probably because few people aren familiar with the syntax, that's
>not what happened=2E
>
>             Linus

Transparent unions have been standard C since C99=2E
