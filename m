Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8727A3343
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 00:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbjIPWkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 18:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjIPWkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 18:40:24 -0400
Received: from gimli.kloenk.dev (gimli.kloenk.dev [IPv6:2a01:4f8:c012:b874::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83068CD1;
        Sat, 16 Sep 2023 15:40:18 -0700 (PDT)
From:   Finn Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
        t=1694904015; bh=JA5/hvn6Yw4Y7noeFUIFzJHIZ1aDogb0GEKwEfAyknQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=MxI3K5J8je9HXIUV++EcVqahwcGKNrqLBY4fIUBlupxPltMiPRt8PshLntJJlH4lR
         FLy2/bTvn9sN9p7sBurRXXLd8n9zinJ5uhYtSl5cpUDN4zg450yyr3YGQfbAPpww7U
         Dnz0bOvY5Hjr04MDB3iHX5V5pb7KUShkNcmCHmtU=
To:     Matthew Maurer <mmaurer@google.com>
Cc:     =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] rust: Respect HOSTCC when linking for host
Date:   Sun, 17 Sep 2023 00:39:46 +0200
Message-ID: <446E67B5-0200-4982-994B-B30C2DEDF098@kloenk.dev>
In-Reply-To: <CAGSQo02p0LWZgV8oVidwvN6X__rv3-rj+ZVg9SaZ5Kx+zYahYQ@mail.gmail.com>
References: <20230915172900.3784163-1-mmaurer@google.com>
 <9966E047-44E7-4665-9628-169F3EBE2F06@kloenk.dev>
 <SLZSYLg5E9OQKI546K87wxTYYLNlT1xM-LhC4W1JFhIate6PFsKq27RcBNhSjUkErYDlzsZB4F2Vc2KOP9tDThg58_tXycWn3K29mQXlFtU=@protonmail.com>
 <0561303E-2089-43FC-AA31-836C7BB844B7@kloenk.dev>
 <CAGSQo02p0LWZgV8oVidwvN6X__rv3-rj+ZVg9SaZ5Kx+zYahYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16 Sep 2023, at 21:54, Matthew Maurer wrote:

> On Sat, Sep 16, 2023 at 11:07=E2=80=AFAM Finn Behrens <me@kloenk.dev> w=
rote:
>>
>>
>>
>> On 16 Sep 2023, at 19:53, Bj=C3=B6rn Roy Baron wrote:
>>
>>> On Saturday, September 16th, 2023 at 18:52, Finn Behrens <me@kloenk.d=
ev> wrote:
>>>
>>>>
>>>> On 15 Sep 2023, at 19:28, Matthew Maurer wrote:
>>>>
>>>>> Currently, rustc defaults to invoking `cc`, even if `HOSTCC` is def=
ined,
>>>>> resulting in build failures in hermetic environments where `cc` doe=
s not
>>>>> exist. This includes both hostprogs and proc-macros.
>>>>>
>>>>> Since we are setting the linker to `HOSTCC`, we set the linker flav=
or to
>>>>> `gcc` explicitly.
>>>> But as `HOSTCC` could also be clang, the linker flavor would then be=
 wrong, would that create a problem?
>>>
>>> Rustc uses the gcc linker flavor for clang too. There has been a prop=
osal to split it up, but I'm not sure of the status of that. In any case =
clang's cli is similar enough to gcc that it works fine to use the gcc li=
nker flavor.
>>>
>> In that case this looks very reasonable.
>>
>> Second thing I noticed is that `HOSTCC` could be the wrong variable, a=
nd `HOSTLD` would make more sense as we look for the linker and not the g=
eneral C compiler.
>>
> Yes, thanks Bjorn - "gcc" is the linker flavor used for "Use the C
> compiler as a linker".
>
> With regards to HOSTLD, I was trying to make the minimum possible
> change. Currently, it is using the command `cc` as a linker, so this
> would preserve existing behavior when HOSTCC is unset.
>
> If we would prefer `HOSTLD` instead we can do that, but we would need
> to additionally inspect `LLVM` to set the linker flavor accordingly
> (e.g. set ld vs ld.lld).
>
> Do folks have strong opinions between these? My primary concern is to
> avoid calling programs by foo when their HOSTFOO variable is set.
I don=E2=80=99t have an educated opinion at all, mainly nudged in the dir=
ection, so that the existence if `HOSTLD` does not get overlooked. If the=
re is a valid reason to not use it, this patch looks good to me.
>
> See https://doc.rust-lang.org/rustc/codegen-options/index.html#linker-f=
lavor
> for details on linker flavor settings.
>>>>>
>>>>> Signed-off-by: Matthew Maurer <mmaurer@google.com>
>>>>> ---
>>>>>  rust/Makefile         | 1 +
>>>>>  scripts/Makefile.host | 1 +
>>>>>  2 files changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/rust/Makefile b/rust/Makefile
>>>>> index 87958e864be0..2a2352638f11 100644
>>>>> --- a/rust/Makefile
>>>>> +++ b/rust/Makefile
>>>>> @@ -383,6 +383,7 @@ $(obj)/exports_kernel_generated.h: $(obj)/kerne=
l.o FORCE
>>>>>  quiet_cmd_rustc_procmacro =3D $(RUSTC_OR_CLIPPY_QUIET) P $@
>>>>>        cmd_rustc_procmacro =3D \
>>>>>     $(RUSTC_OR_CLIPPY) $(rust_common_flags) \
>>>>> +           -C linker-flavor=3Dgcc -C linker=3D$(HOSTCC) \
>>>>>             --emit=3Ddep-info=3D$(depfile) --emit=3Dlink=3D$@ --ext=
ern proc_macro \
>>>>>             --crate-type proc-macro \
>>>>>             --crate-name $(patsubst lib%.so,%,$(notdir $@)) $<
>>>>> diff --git a/scripts/Makefile.host b/scripts/Makefile.host
>>>>> index 8f7f842b54f9..0aa95a3af1c4 100644
>>>>> --- a/scripts/Makefile.host
>>>>> +++ b/scripts/Makefile.host
>>>>> @@ -91,6 +91,7 @@ hostcxx_flags  =3D -Wp,-MMD,$(depfile) \
>>>>>  # current working directory, which may be not accessible in the ou=
t-of-tree
>>>>>  # modules case.
>>>>>  hostrust_flags =3D --out-dir $(dir $@) --emit=3Ddep-info=3D$(depfi=
le) \
>>>>> +            -C linker-flavor=3Dgcc -C linker=3D$(HOSTCC) \
>>>>>                   $(KBUILD_HOSTRUSTFLAGS) $(HOST_EXTRARUSTFLAGS) \
>>>>>                   $(HOSTRUSTFLAGS_$(target-stem))
>>>>>
>>>>> --
>>>>> 2.42.0.459.ge4e396fd5e-goog
