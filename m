Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF0380A892
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574472AbjLHQOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235994AbjLHQO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:14:27 -0500
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D1D212A;
        Fri,  8 Dec 2023 08:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1702052023; x=1702311223;
        bh=ek4co/YpsGRGW/CGOUlf0EOIjWRaI4i0rP+RwDefBy4=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=YXm7Jqtm2MRsihn4lo0W4ggKNDyx9zcUfb6gxx6B0Wt0+w5Tdh1sbAkvAOypJ9lnH
         1ILv9/Ns9LQCE+unShsUMCttnsFElCpxKdA/WnL6mJ4T7HkD155i+KrKfLdzuZW4NO
         9ezlowMCpgkhJb0YmHGMrw4645Ds6PyPNTAWcrFU22eAd13IwrzWOakiRs5cglpcEQ
         D9PjW7u7fbSCihRCYbl86+j2m1F0xivRLHi6MArRCvSM0YtwvzMs9xg/0oq14sJEob
         l/XqpZ2H0THWfSk0qUts3LgyPeVFJYwzfGFHe7p/j/qoyAJWOGxNvJ0BEzqT+EVNXh
         pHRipQHGInDKg==
Date:   Fri, 08 Dec 2023 16:13:26 +0000
To:     Alice Ryhl <aliceryhl@google.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] rust: cred: add Rust abstraction for `struct cred`
Message-ID: <8VBM8spxE8lhkvhYGfxxUFwslCWxi-ZL6rGHHDYD6Gn5dZqsdUQfZYDqtykJzQNFJVsQje_B4hGVDRqy3zY3TZGLSL7_YXbhKcIYfvBS02I=@proton.me>
In-Reply-To: <20231206-alice-file-v2-2-af617c0d9d94@google.com>
References: <20231206-alice-file-v2-0-af617c0d9d94@google.com> <20231206-alice-file-v2-2-af617c0d9d94@google.com>
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

On 12/6/23 12:59, Alice Ryhl wrote:
> +/// Wraps the kernel's `struct cred`.
> +///
> +/// # Invariants
> +///
> +/// Instances of this type are always ref-counted, that is, a call to `g=
et_cred` ensures that the
> +/// allocation remains valid at least until the matching call to `put_cr=
ed`.
> +#[repr(transparent)]
> +pub struct Credential(pub(crate) Opaque<bindings::cred>);

Why is the field `pub(crate)`?

[...]

> +// SAFETY: The type invariants guarantee that `Credential` is always ref=
-counted.
> +unsafe impl AlwaysRefCounted for Credential {
> +    fn inc_ref(&self) {
> +        // SAFETY: The existence of a shared reference means that the re=
fcount is nonzero.
> +        unsafe { bindings::get_cred(self.0.get()) };
> +    }
> +
> +    unsafe fn dec_ref(obj: core::ptr::NonNull<Self>) {
> +        // SAFETY: The safety requirements guarantee that the refcount i=
s nonzero.

Can you also justify the `cast()`?

--=20
Cheers,
Benno

> +        unsafe { bindings::put_cred(obj.cast().as_ptr()) };
> +    }
> +}
