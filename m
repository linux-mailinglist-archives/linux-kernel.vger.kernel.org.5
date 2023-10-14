Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFF87C965A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 22:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbjJNUwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 16:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbjJNUv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 16:51:56 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FC9E9;
        Sat, 14 Oct 2023 13:51:50 -0700 (PDT)
Received: from [127.0.0.1] ([98.35.210.218])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 39EKoEiA2727570
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Sat, 14 Oct 2023 13:50:15 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 39EKoEiA2727570
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023101201; t=1697316617;
        bh=LX/qZh+W7D0BjzC3kMTpoByXLORwLrw1issq1DeNzOI=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=cmEtZtL0/Pi2yHywxxrW/vo69bVUWzREGKAQgcbfeQGp95YGmHSJanruTBO52bnTp
         c/NpKM0f69S6I4fKqBAVW4BQaQWygmM6rcwzaEkqlA6Z+6SkC94pbM+EhsrUOaxoBF
         Nz+Ig3h1APbpOVSA9QtIEVK4Dp0Vd72eRQqjE7uAyeeF7EVqWLrJ+EVZzpHEcVfeur
         +4Tc/tRbfMLQ8QgcoKkIWYylpJjzWGtY4MNezyAKCI2niAAY0FLfF+maHpaXpJnnw9
         nK5nIBxIgvaan1hi1DbfDAHRxBXik2Dka7C/Cl7KNf+o5Ruwp0qT/LUgs0qT43MYj9
         tS/QvgasZ2CMg==
Date:   Sat, 14 Oct 2023 13:50:09 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     comex <comexk@gmail.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ramon de C Valle <rcvalle@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
In-Reply-To: <BDD45A2A-1447-40DD-B5F3-29DEE976A3CD@gmail.com>
References: <20220927131518.30000-1-ojeda@kernel.org> <20220927131518.30000-26-ojeda@kernel.org> <Y0BfN1BdVCWssvEu@hirez.programming.kicks-ass.net> <CABCJKuenkHXtbWOLZ0_isGewxd19qkM7OcLeE2NzM6dSkXS4mQ@mail.gmail.com> <CANiq72k6s4=0E_AHv7FPsCQhkyxf7c-b+wUtzfjf+Spehe9Fmg@mail.gmail.com> <CABCJKuca0fOAs=E6LeHJiT2LOXEoPvLVKztA=u+ARcw=tbT=tw@mail.gmail.com> <20231012104741.GN6307@noisy.programming.kicks-ass.net> <CABCJKufEagwJ=TQnmVSK07RDjsPUt=3JGtwnK9ASmFqb7Vx8JQ@mail.gmail.com> <202310121130.256F581823@keescook> <CAOcBZOTed1a1yOimdUN9yuuysZ1h6VXa57+5fLAE99SZxCwBMQ@mail.gmail.com> <20231013075005.GB12118@noisy.programming.kicks-ass.net> <CAOcBZOTP_vQuFaqREqy-hkG69aBvJ+xrhEQi_EFKvtsNjne1dw@mail.gmail.com> <CAHk-=wjLUit_gae7anFNz4sV0o2Uc=TD_9P8sYeqMSeW_UG2Rg@mail.gmail.com> <5D8CA5EF-F5B0-4911-85B8-A363D9344FA7@zytor.com> <BDD45A2A-1447-40DD-B5F3-29DEE976A3CD@gmail.com>
Message-ID: <C0631F27-43CE-4F2F-9075-25988CBD97F0@zytor.com>
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

On October 14, 2023 1:25:12 PM PDT, comex <comexk@gmail=2Ecom> wrote:
>
>
>> On Oct 13, 2023, at 12:00=E2=80=AFPM, H=2E Peter Anvin <hpa@zytor=2Ecom=
> wrote:
>>=20
>> Transparent unions have been standard C since C99=2E
>
>I don=E2=80=99t think that=E2=80=99s right=2E  Certainly __attribute__((t=
ransparent_union)) is not standard C; are you referring to a different feat=
ure?
>

My mistake=2E=2E=2E I was thinking about anonymous unions=2E
