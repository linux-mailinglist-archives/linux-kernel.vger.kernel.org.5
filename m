Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA5F754813
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 11:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjGOJ65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 05:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGOJ6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 05:58:55 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F5F26BC;
        Sat, 15 Jul 2023 02:58:54 -0700 (PDT)
Date:   Sat, 15 Jul 2023 09:58:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=j7aktgpa35czjhjokgcjsy3jwi.protonmail; t=1689415133; x=1689674333;
        bh=P50SsUiethDC+ssEwwzmuEWLMRj8U/uFYdIBHOkOt4w=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=X97jvnsSV9GYCozJej8B2G4F9bOzZWnZ6u0RopmzQTGOiCvICdl2hDdW+WwaLGov6
         6QvLWU7i2+eOwdyVXlmzWpHJwur0yRUmrofDlACLd5c0sf8sqrZO3Khzuu9Gdq/NCY
         gh4insHpnwpa3z+u48f3BaU1afhWt1Dou+sxzoqkO+ovvFgjseGwFiJRbgsyB9+OUp
         71oEZCp0lucByK7MxyqZx4cz1BIe1Ag0m3VcY5cREf8//aL55JdiOd6C5M2ao94Axm
         51bUpRpIHR1EyFK9716+VORsPryqd/KYhtuBTQyaktrC/G8MMRPFMwfjVGlQLF5Avq
         nNJbvil+p/ldg==
To:     Asahi Lina <lina@asahilina.net>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: init: Implement Zeroable::zeroed()
Message-ID: <KGzE8bKBnwN0hJkKd2Cdes4IN7iuBDbKsa9OpVt7Q_pZZRithsnP3ygISozTyGn5UmfrOcd-11ZQ-vElMwrma6sozkXF3t8Jl7DKhdc2TGA=@proton.me>
In-Reply-To: <20230714-zeroed-v1-1-494d6820d61b@asahilina.net>
References: <20230714-zeroed-v1-1-494d6820d61b@asahilina.net>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> By analogy to Default::default(), this just returns the zeroed
> representation of the type directly. init::zeroed() is the version that
> returns an initializer.
>=20
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---
>  rust/kernel/init.rs | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> index b4332a4ec1f4..c300ce39ac10 100644
> --- a/rust/kernel/init.rs
> +++ b/rust/kernel/init.rs
> @@ -1354,7 +1354,14 @@ pub unsafe trait PinnedDrop: __internal::HasPinDat=
a {
>  /// ```rust,ignore
>  /// let val: Self =3D unsafe { core::mem::zeroed() };
>  /// ```
> -pub unsafe trait Zeroable {}
> +pub unsafe trait Zeroable: core::marker::Sized {

Note that `Sized` is in the prelude so you do not need the full path
`core::marker::`. Also same concern as Alice.

> +    /// Create a new zeroed T.
> +    ///
> +    /// Directly returns a zeroed T, analogous to Default::default().

Please add a link to `init::zeroed()` and explain that that is the
initializer version of this function.

> +    fn zeroed() -> Self {
> +        unsafe { core::mem::zeroed() }

Missing `SAFETY` comment.

--
Cheers,
Benno

> +    }
> +}
>=20
>  /// Create a new zeroed T.
>  ///
>=20
> ---
> base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
> change-id: 20230714-zeroed-dd05bc737f85
>=20
> Thank you,
> ~~ Lina
>=20

