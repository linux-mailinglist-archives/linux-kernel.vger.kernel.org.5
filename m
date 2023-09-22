Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99787ABA47
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 21:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjIVTuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 15:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjIVTun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 15:50:43 -0400
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2E819C
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 12:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1695412235; x=1695671435;
        bh=U4A9K1zNIXRCw9KzMm6IvaGs64bl/qNBaodwviRiufw=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=jE66wvYrOoFyIU8vgTqpffHwXE0XhzH4qv+Y2eVkkw21JergvKZUNNTlyHmn3rZKe
         mNJxqZEq0CnP5GMBlFcXIDJOTBQ7IK4a0Gsd+dLwLb/jpPscBRKnH+4eun3TVCYW+z
         +lBRMAu36HTdL2fAlsrDCk6zytS72HLdA4EeLHmkLAAbCj1mROLApc65lSB1X76EWU
         DifXNs7+6AQCiWrqAGtgH8pb+Nd+dxEamoebnwV3cUqb+WLCbEbDbFen3iGIkZ/j1T
         mbjrPhL4Lzn4TKTiqL8Vv66H3Vg0C/dP6UVYdwz7Cgun2nML1zBwnm3arWkgCCHy0f
         gj2CokyHrxWRQ==
Date:   Fri, 22 Sep 2023 19:50:22 +0000
To:     Alice Ryhl <aliceryhl@google.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH 2/2] rust: arc: remove `ArcBorrow` in favour of `WithRef`
Message-ID: <b2e5befc-1a56-1657-1656-1b5792dbf3e2@proton.me>
In-Reply-To: <CAH5fLgj_wQtmW4A6-4wPeP-Qmk2ga2NoVRwZDujjYvHWY7Bk3A@mail.gmail.com>
References: <20230921213440.202017-1-wedsonaf@gmail.com> <20230921213440.202017-3-wedsonaf@gmail.com> <CAH5fLgj_wQtmW4A6-4wPeP-Qmk2ga2NoVRwZDujjYvHWY7Bk3A@mail.gmail.com>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.09.23 17:29, Alice Ryhl wrote:
> On Thu, Sep 21, 2023 at 11:35=E2=80=AFPM Wedson Almeida Filho
> <wedsonaf@gmail.com> wrote:
>>
>> From: Wedson Almeida Filho <walmeida@microsoft.com>
>>
>> With GATs, we don't need a separate type to represent a borrowed object
>> with a refcount, we can just use Rust's regular shared borrowing. In
>> this case, we use `&WithRef<T>` instead of `ArcBorrow<'_, T>`.
>>
>> Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
>> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
>> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
>=20
> I wonder whether "WithArc" is a better name? After all, arc is short
> for "atomic refcount".
> I also think it's nice to include Arc in the name of the type.

I think `WithArc` would be confusing, since `Arc` is the smartpointer
that points to a `WithRef`.

--=20
Cheers,
Benno


