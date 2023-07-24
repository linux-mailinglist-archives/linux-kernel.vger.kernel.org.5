Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FD0760195
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 23:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjGXVzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 17:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjGXVzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:55:17 -0400
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DA6118;
        Mon, 24 Jul 2023 14:55:15 -0700 (PDT)
Date:   Mon, 24 Jul 2023 21:55:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1690235712; x=1690494912;
        bh=mQ0wVbJZR6Qqo1f6a7btQ5EY0YN+6oKaQQ8JxSOeS/w=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=gB22Eo3q0kUmG8e6tgL+f8mLMNn6WdDfiToEXTVAgaHbWsVdYEeVX6n9+kZTxqXHZ
         kgPc+e0ujGzBYji5jP3IZ9YITKZhKbQBHHE3KVS8mIkPFgJrqHUo5J2wYgz81IM1h1
         GBEYfSMhymndkTxv6iG2TE5fBWDJbTX6C6IDG/CH/y4eQg34mztVIoWoPQt9rAuRH9
         B/RJYJkjhHGqSlWJo77J9kEBVSG+Zzl5a3Pdw5s3J7Fh6HI9yB/xlbCjepqEsPM+bl
         n4dRgL90afLOBXkEMlaSNd5JrDze2btqR2lEarQt12rh4XW20E3ucIjxuOC0jEEtOd
         mPjkmb/7+U6YQ==
To:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Asahi Lina <lina@asahilina.net>
Subject: Re: [PATCH v2 11/12] rust: init: add `{pin_}chain` functions to `{Pin}Init<T, E>`
Message-ID: <e02b8645-4284-7573-966a-6b6654d4a772@proton.me>
In-Reply-To: <ebdf2635-6003-fc62-310f-5b9071473415@gmail.com>
References: <20230719141918.543938-1-benno.lossin@proton.me> <20230719141918.543938-12-benno.lossin@proton.me> <0b818707-4762-c12d-8624-7d3c4f6841da@gmail.com> <5f22b25d-132d-7cbc-8bca-8333516c1663@proton.me> <ebdf2635-6003-fc62-310f-5b9071473415@gmail.com>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/23 18:07, Martin Rodriguez Reboredo wrote:
> On 7/24/23 11:08, Benno Lossin wrote:
>> This is a bit confusing to me, because dropping the value on returning `=
Err`
>> is a safety requirement of `PinInit`. Could you elaborate why this is
>> surprising? I can of course add it to the documentation, but I do not se=
e
>> how it could be implemented differently. Since if you do not drop the va=
lue
>> here, nobody would know that it is still initialized.
>=20
> I knew about the requirement of dropping on `Err`, but what has caught my
> attention is that `{pin_}chain` might not abide with it per the doc
> comment as it says that `self` is initialized before calling `f`...
>=20
>       /// First initializes the value using `self` then calls the functio=
n
>       /// `f` with the initialized value.
>=20
> But one can not know what would happen when `f` fails, specially if
> such failure can be ignored or it's only temporarily.
>=20
> So then, the best course IMO is to mention that in some way the value is
> still being initialized, kinda setting it up, and that it will be dropped
> when an error is returned. WDYT?

I see, then I will just expand the documentation.

--=20
Cheers,
Benno


