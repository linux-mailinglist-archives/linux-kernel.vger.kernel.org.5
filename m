Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE497FF481
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjK3QRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjK3QRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:17:17 -0500
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C74197;
        Thu, 30 Nov 2023 08:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1701361042; x=1701620242;
        bh=mRFq5LKYHvE44IpjbLDOnURptajquKGU1HNJazPPf9o=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=MP7805FfoSY6qKMdB3HRW99VFJ5WcaPwsXR+VYTX5bibjTIn/r+D+DLMg469O5PMM
         JZO7Sv0a1oiqk0JEHJx7pZ1PMw9e61rM/HDujeJlKTNrr56n31fC4AdssIRKuMtL3M
         0CafqvFLKKZODXZ071RjfCz2QUGcvYHUEIwN+WCBhke3L+mPNLLoctQISw5Jn/dcJb
         SE5L8+LokHeV1z8EmulRJgjUBlDgml5mng2mAgAzzzU8vjdwTS6bxrvdl/urIziLI3
         LkwjlMXG6xpSXlJhXWO6lWkcYS7oA3ZsRfcxS8IBOhhZotPUmLY4jx4fooGXuxCX0+
         rQzJn+72hPvEA==
Date:   Thu, 30 Nov 2023 16:17:03 +0000
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
Subject: Re: [PATCH 2/7] rust: cred: add Rust abstraction for `struct cred`
Message-ID: <W6StBLpVsvvGchAT5ZEvH9JJyzu401dMqR3yN73NZPjPeZRoaKAuoYe40QWErmPwrnJVTH7BbLKtWXDOMYny5xjwd3CSLyz5IYYReB6-450=@proton.me>
In-Reply-To: <20231129-alice-file-v1-2-f81afe8c7261@google.com>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com> <20231129-alice-file-v1-2-f81afe8c7261@google.com>
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

On 11/29/23 13:51, Alice Ryhl wrote:
> +    /// Returns the credentials of the task that originally opened the f=
ile.
> +    pub fn cred(&self) -> &Credential {
> +        // This `read_volatile` is intended to correspond to a READ_ONCE=
 call.
> +        //
> +        // SAFETY: The file is valid because the shared reference guaran=
tees a nonzero refcount.
> +        //
> +        // TODO: Replace with `read_once` when available on the Rust sid=
e.
> +        let ptr =3D unsafe { core::ptr::addr_of!((*self.0.get()).f_cred)=
.read_volatile() };
> +
> +        // SAFETY: The signature of this function ensures that the calle=
r will only access the
> +        // returned credential while the file is still valid, and the cr=
edential must stay valid
> +        // while the file is valid.

About the last part of this safety comment, is this a guarantee from the
C side? If yes, then I would phrase it that way:

    ... while the file is still valid, and the C side ensures that the
    credentials stay valid while the file is valid.

--=20
Cheers,
Benno

> +        unsafe { Credential::from_ptr(ptr) }
> +    }
> +
