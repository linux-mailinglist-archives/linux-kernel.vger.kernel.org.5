Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549707F8C08
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 16:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbjKYP0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 10:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjKYP0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 10:26:12 -0500
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D94E10A
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 07:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=7bkobibq2ver7p3fnntwujk6hq.protonmail; t=1700925975; x=1701185175;
        bh=CresfKqNPceVr7nx//OsH0O83BJu9CLfB3p0kHEWEpw=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=HJxukUSGz6pwgdGZAZshMCviglofAdNeRRGYwHBljRYO0JmiPM0SbgAmZshanU2UX
         tehxBjzjRiNC6jbCFUpbzFurOLoTWnyd+LrURy4s06lVzuiU1LqljlZxzJJRCyaxct
         7iaar9hVGLBJ102GeL255iJ0ysVzezbu773PBc3JM6Qw1Sh2KKAa0oeCqvbwxJZrbo
         EtW8n47KPxFmXww/9IBwwcvBviT21t7jFQV40wSqom2ys2shcoKiUyn0xvqJ1ayWB3
         jbicCUf3gJk8vx6jjo2Si2rQLaI+TIFzv5ZDCUgZdnSdsN8rda8pIXBDiW0m49RO1Q
         47n/MDDEVUGXQ==
Date:   Sat, 25 Nov 2023 15:26:02 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] rust: macros: allow generic parameter default values in `#[pin_data]`
Message-ID: <5hsq7OfTOZ9Wi70n6p9nfFPr4IDJ9YECqWHEgsnMnzN3lcLeojK5ZlwR7nzDGdK5Wjrb95Jk60CGKszSiUhMsZQA2vlwSltMMypfk4HzgJM=@proton.me>
In-Reply-To: <2023112514-laziness-valium-7a25@gregkh>
References: <20231125125024.1235933-1-benno.lossin@proton.me> <20231125125024.1235933-2-benno.lossin@proton.me> <2023112525-impatient-untwist-ee3d@gregkh> <t4HJjY0Oft2K2H1ssXTxZchdPTx25J6WqSJqAx75NiRUYg40BBLt1AHxm9ZF0UA70FkqIXb6Pp2sz3BErD-AyXmQCkU4xDvqyXHSinaWGb4=@proton.me> <2023112514-laziness-valium-7a25@gregkh>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.11.23 16:10, Greg KH wrote:
> On Sat, Nov 25, 2023 at 03:02:00PM +0000, Benno Lossin wrote:
>> On 25.11.23 15:26, Greg KH wrote:
>>> On Sat, Nov 25, 2023 at 12:51:09PM +0000, Benno Lossin wrote:
>>>> This patch adds compatibilty for generic parameters defaults by using
>>>> the newly introduced `decl_generics` instead of the `impl_generics`.
>>>
>>> This says _what_ is happening here, but not _why_ this is needed at all=
.
>>>
>>> Try taking a look a the kernel documentation for how to write a good
>>> changelog text to make this much better.  It's often times the most
>>> difficult portion of making a kernel patch, the code is easy, writing a
>>> summary of why everyone else should agree that this code is acceptable
>>> is hard.
>>
>> The reason is hidden in the third patch.
>=20
> Please do not hide things, patches need to be stand-alone and
> understandable that way, otherwise they will be rejected as no one can
> understand why they would be needed.

This was not my intention, I just realized this due to your question. I
wanted to point you to the third patch (which for some reason sadly does
not have the correct In-Reply-To header). Since that might help you
understand some of the context.

>> Without this, the `#[pin_data]
>> macro would not allow specifying const generic parameter default values
>> and instead emit a compile error.
>=20
> That's nice, but it still doesn't tell me _why_ this is needed.  Why
> would I want any generic paramter default values at all?  Who needs any
> of this?  What will it be used for?  What does it actually do?

`#[pin_data]` is a proc-macro that one can put on any struct to make the
pin-init API available for use with that struct. Since e.g. mutexes are
initialized using the pin-init API, you have to do this for anything
that contains a mutex.
This macro should be compatible with any struct definition even with
ones that have const generic parameter defaults. This was an oversight
in the original design, as it does not support that, since the proc
macro parsing cannot handle the `=3D` character.

The short answer for why one would want to have const generic parameter
defaults is that the language supports it. And since there is nothing
that prevents `#[pin_data]` to be implemented for such structs, we
should it do it.
Rust generally aims to make all features compatible
with each other and we would like to do the same for our
libraries/customized features.

The longer answer is a concrete example of a usecase for const generic
parameter defaults: the `Work<T, ID>` struct of the workqueue bindings.
The `ID` parameter is used to identify multiple instances of `Work`
within the same struct. But if you only intend to have a single `Work`
struct embedded in your struct, then there is no need to distinguish it
from something else (after all there is only one) and therefore we want
people to just write `Work<T>`. This is where the author of
`Work<T, ID>` can write:

    struct Work<T, const ID: usize =3D 0> {
        // ...
    }

But the `=3D 0` syntax is currently not supported by `#[pin_data]`.

--=20
Cheers,
Benno
