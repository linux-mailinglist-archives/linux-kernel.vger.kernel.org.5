Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46D87D9088
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbjJ0ICj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjJ0ICf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:02:35 -0400
Received: from gimli.kloenk.dev (gimli.kloenk.dev [49.12.72.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79495111;
        Fri, 27 Oct 2023 01:02:33 -0700 (PDT)
From:   Finn Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
        t=1698393750; bh=28rUFQhaEDsdQWxzMiXwFJiB6uc5xzFDDph6JYWbtHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=dXCBI2MbzckTQiGWSYieVoxuc4bOzN9HKyWyRNRlkVd3tUTM0PZvKn015dDadGsAh
         ipqfIcbCCS/YP4Fz0Ra0CDRmp3XjG+3z1owXK3a+cCLzoLBcml5tqEgPDzonuOOS+N
         Q0SLA9xE2AIgr4EWTfibjmHPRzG7EFN1nXpyJAto=
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Asahi Lina <lina@asahilina.net>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Viktor Garske <viktor@v-gar.de>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] rust: macros: improve `#[vtable]` documentation
Date:   Fri, 27 Oct 2023 10:02:26 +0200
Message-ID: <BB8A8468-135F-4F2E-9B3F-0BA229B3A276@kloenk.dev>
In-Reply-To: <20231026201855.1497680-1-benno.lossin@proton.me>
References: <20231026201855.1497680-1-benno.lossin@proton.me>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26 Oct 2023, at 22:19, Benno Lossin wrote:

> Traits marked with `#[vtable]` need to provide default implementations
> for optional functions. The C side represents these with `NULL` in the
> vtable, so the default functions are never actually called. We do not
> want to replicate the default behavior from C in Rust, because that is
> not maintainable. Therefore we should use `build_error` in those defaul=
t
> implementations. The error message for that is provided at
> `kernel::error::VTABLE_DEFAULT_ERROR`.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---
> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
> index c42105c2ff96..917a51183c23 100644
> --- a/rust/macros/lib.rs
> +++ b/rust/macros/lib.rs
> @@ -87,27 +87,48 @@ pub fn module(ts: TokenStream) -> TokenStream {
>  /// implementation could just return `Error::EINVAL`); Linux typically=
 use C
>  /// `NULL` pointers to represent these functions.
>  ///
> -/// This attribute is intended to close the gap. Traits can be declare=
d and
> -/// implemented with the `#[vtable]` attribute, and a `HAS_*` associat=
ed constant
> -/// will be generated for each method in the trait, indicating if the =
implementor
> -/// has overridden a method.
> +/// This attribute closes that gap. A trait can be annotated with the =
`#[vtable]` attribute.
> +/// Implementers of the trait will then also have to annotate the trai=
t with `#[vtable]`. This
> +/// attribute generates a `HAS_*` associated constant bool for each me=
thod in the trait that is set
> +/// to true if the implementer has overridden the associated method.
> +///
> +/// For a trait method to be optional, it must have a default implemen=
tation.
> +/// This is also the case for traits annotated with `#[vtable]`, but i=
n this
> +/// case the default implementation will never be executed. The reason=
 for this
> +/// is that the functions will be called through function pointers ins=
talled in
> +/// C side vtables. When an optional method is not implemented on a `#=
[vtable]`
> +/// trait, a NULL entry is installed in the vtable. Thus the default
> +/// implementation is never called. Since these traits are not designe=
d to be
> +/// used on the Rust side, it should not be possible to call the defau=
lt
> +/// implementation. This is done to ensure that we call the vtable met=
hods
> +/// through the C vtable, and not through the Rust vtable. Therefore, =
the
> +/// default implementation should call `kernel::build_error`, which pr=
events
> +/// calls to this function at compile time:
In the future it would be nice to have something like `#[default]` or `#[=
optional]` to automatically derive the implementation.
> +///
> +/// ```compile_fail
> +/// # use kernel::error::VTABLE_DEFAULT_ERROR;
> +/// kernel::build_error(VTABLE_DEFAULT_ERROR)
> +/// ```
> +///
> +/// note that you might need to import [`kernel::error::VTABLE_DEFAULT=
_ERROR`].
>  ///
> -/// This attribute is not needed if all methods are required.
> +/// This macro should not be used when all functions are required.
Reviewed-by: Finn Behrens <me@kloenk.dev>
