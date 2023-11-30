Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316E17FF53F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345300AbjK3Q1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjK3Q1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:27:01 -0500
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11E01A4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1701361625; x=1701620825;
        bh=mOMEDalTJ2nNUHEjuiH1o7OWgTyvdhbuWe5AEnNE+rE=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=c4vHt3HJnr971aFPIjhH2bWoBzKLFTA107/xMOElWr2Ts62ZXLCjBr0Lb2VzbBDs7
         9UKaJv36630aCSacS1ZEgU/tQEj/4b3cVpBHjzWH+7OSFe4WriK0GoqdTfEYUwVXjC
         E05iZDseAd4T+Tc3Rfnqe9QwedU0hp52+g+m0vMKfJGDwN015ekgFMw77xnfRQqGv3
         dyJIwabpinaI7/gkzfQXZaQxnyafW0Q+X/uEEf9okalERYauEXm21rYce+4YZyXcC6
         JSeVVibmVBFv7+0FbpgBnGowPLXl5irsMbeBF+t//BbIRhtYeo5BK8YUZ2b7U7P9cB
         pG4BRgWSuydbw==
Date:   Thu, 30 Nov 2023 16:26:39 +0000
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
Subject: Re: [PATCH 3/7] rust: security: add abstraction for secctx
Message-ID: <qwxqEq_l1jj3cAKSEh7gBZCUyBGCDmThdz6JJIQiFVl94ASI4yyNB6956XLrsQXnE4ulo48QRMaKPjgt7JZoolisVEiGOUP7IyRdecdhXqw=@proton.me>
In-Reply-To: <20231129-alice-file-v1-3-f81afe8c7261@google.com>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com> <20231129-alice-file-v1-3-f81afe8c7261@google.com>
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

On 11/29/23 14:11, Alice Ryhl wrote:
> +/// A security context string.
> +///
> +/// The struct has the invariant that it always contains a valid securit=
y context.

Refactor to use the `# Invariants` section:

    # Invariants
    `secdata` points to a valid security context.

I also do not know what a "valid security context" is, so a link to the
definition wouldn't hurt.

> +pub struct SecurityCtx {
> +    secdata: *mut core::ffi::c_char,
> +    seclen: usize,
> +}
> +
> +impl SecurityCtx {
> +    /// Get the security context given its id.
> +    pub fn from_secid(secid: u32) -> Result<Self> {
> +        let mut secdata =3D core::ptr::null_mut();
> +        let mut seclen =3D 0;
> +        // SAFETY: Just a C FFI call. The pointers are valid for writes.
> +        unsafe {
> +            to_result(bindings::security_secid_to_secctx(
> +                secid,
> +                &mut secdata,
> +                &mut seclen,
> +            ))?;
> +        }
> +
> +        // If the above call did not fail, then we have a valid security
> +        // context, so the invariants are not violated.

Should be tagged `INVARIANT`.

> +        Ok(Self {
> +            secdata,
> +            seclen: usize::try_from(seclen).unwrap(),
> +        })
> +    }
> +
> +    /// Returns whether the security context is empty.
> +    pub fn is_empty(&self) -> bool {
> +        self.seclen =3D=3D 0
> +    }
> +
> +    /// Returns the length of this security context.
> +    pub fn len(&self) -> usize {
> +        self.seclen
> +    }
> +
> +    /// Returns the bytes for this security context.
> +    pub fn as_bytes(&self) -> &[u8] {
> +        let mut ptr =3D self.secdata;
> +        if ptr.is_null() {
> +            // Many C APIs will use null pointers for strings of length =
zero, but

I would just write that the secctx API uses null pointers to denote a
string of length zero.

> +            // `slice::from_raw_parts` doesn't allow the pointer to be n=
ull even if the length is
> +            // zero. Replace the pointer with a dangling but non-null po=
inter in this case.
> +            debug_assert_eq!(self.seclen, 0);

I am feeling a bit uncomfortable with this, why can't we just return
an empty slice in this case?

> +            ptr =3D core::ptr::NonNull::dangling().as_ptr();
> +        }
> +
> +        // SAFETY: The call to `security_secid_to_secctx` guarantees tha=
t the pointer is valid for
> +        // `seclen` bytes. Furthermore, if the length is zero, then we h=
ave ensured that the
> +        // pointer is not null.
> +        unsafe { core::slice::from_raw_parts(ptr.cast(), self.seclen) }
> +    }
> +}
> +
> +impl Drop for SecurityCtx {
> +    fn drop(&mut self) {
> +        // SAFETY: This frees a pointer that came from a successful call=
 to
> +        // `security_secid_to_secctx`.

This should be part of the type invariant.

--=20
Cheers,
Benno

> +        unsafe {
> +            bindings::security_release_secctx(self.secdata, self.seclen =
as u32);
> +        }
> +    }
> +}
> --
> 2.43.0.rc1.413.gea7ed67945-goog
> 
