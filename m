Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB40754817
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 12:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjGOKAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 06:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjGOKAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 06:00:47 -0400
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFECB2701
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 03:00:45 -0700 (PDT)
Date:   Sat, 15 Jul 2023 10:00:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1689415244; x=1689674444;
        bh=QnF59vl5+yCYRQpMrd2L/uF0PGzIplpwVi1jkdKlyBY=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Q6UkrPgLIIJU7b8/F8r0FqjyX9koF7x8ThbaXuvrSa7L4b74Qox63R8l+kmRz1f/j
         9+yOUhlEaqz4mkzyHnHVStt4Sakh07G3jaOIJ4FnNQRb5pLXdP8Wx2J6+CUnN5r8Xv
         b1dvJYa0D1OWk7CmYnMXJUI1fbT6naJlSsTB2PJwNM9fSgTu+WOTyKHri8Huy2XAUy
         L3becJS07dyXOF1lBcc2o1lDqFn1yTKJAuRN+ckEe5jI1X+EnRFl34xSGBB+rqRDLv
         VH0lNDVEwwau/55u820bNeTME6csSA4DBU+wjnc9/LZj0C7WPIjEq6CxqW64iE9Pn3
         sIVvdspHn0G3g==
To:     Asahi Lina <lina@asahilina.net>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
Subject: Re: [PATCH] rust: kernel: str: Implement Debug for CString
Message-ID: <Fri3hO6JBOzZwR7YKGQqy8HYwzn_ciV2HgjLNm36zwf1p8BsWCSrecnz-00K2dsztvOI1c2PP7cd_Kh6xjFVjbsX6U7qAPqvsdsi7WaaVow=@proton.me>
In-Reply-To: <20230714-cstring-debug-v1-1-4e7c3018dd4f@asahilina.net>
References: <20230714-cstring-debug-v1-1-4e7c3018dd4f@asahilina.net>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.07.23 11:19, Asahi Lina wrote:
> Trivial implementation.
>=20
> Signed-off-by: Asahi Lina <lina@asahilina.net>

With a better commit message you can add

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

--=20
Cheers,
Benno

> ---
>   rust/kernel/str.rs | 6 ++++++
>   1 file changed, 6 insertions(+)
>=20
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index c9dd3bf59e34..a94e396d39e1 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -606,6 +606,12 @@ fn try_from(cstr: &'a CStr) -> Result<CString, Alloc=
Error> {
>       }
>   }
>=20
> +impl fmt::Debug for CString {
> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> +        fmt::Debug::fmt(&**self, f)
> +    }
> +}
> +
>   /// A convenience alias for [`core::format_args`].
>   #[macro_export]
>   macro_rules! fmt {
>=20
> ---
> base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
> change-id: 20230714-cstring-debug-ca021fe0ad78
>=20
> Thank you,
> ~~ Lina
> 
