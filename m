Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FB87FF6E3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345566AbjK3Qsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbjK3Qss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:48:48 -0500
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540D410F8;
        Thu, 30 Nov 2023 08:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1701362933; x=1701622133;
        bh=ma6iKXmyJ476bBrogFjyVSkUY7XrgEHkL0/Xftslrt4=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=SmOdraL93gFqTu2k/5T2ohP1ZJp2b+CgRREaU2e5H1ZUq4x+EQvILLt2aSngvbMa6
         PuK9x5xisRVyi5GJs6FPfdfzAX85fwq8Xrl5f6AnTNOgFSBCQzSrvkP5g4+EGQDsHL
         EDBFtQ/XfIaDvnkhJpKS55tbPYn/LRm42eGm3PN6XQjcfWymtg7hYZG97eEo82RFCS
         DhIXHhEsObboS66pGMYvBvB+X7350grHi5wzpZmkhB6NTESy/2TtQQClKyerIxp0qL
         RQT4giTnYFEp7mYhmjHeCd9EKaUCvyy8q3Cqe1rdbp4PpCBmDq+9ZX4rAFkBo0Sd5R
         Gasrmyqv2pBdw==
Date:   Thu, 30 Nov 2023 16:48:29 +0000
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
Subject: Re: [PATCH 5/7] rust: file: add `Kuid` wrapper
Message-ID: <1fDBLge_kImhS4koYYda8t5pmIAeA9Zxo8haE_x1zKgxqGtrQd3wHhOgTbV8db3exz-Q6kXoDh3XWMyX4aox0oGTDSX2udA6ZDSV3r3D1_U=@proton.me>
In-Reply-To: <20231129-alice-file-v1-5-f81afe8c7261@google.com>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com> <20231129-alice-file-v1-5-f81afe8c7261@google.com>
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

On 11/29/23 14:12, Alice Ryhl wrote:
> +    /// Returns the given task's pid in the current pid namespace.
> +    pub fn pid_in_current_ns(&self) -> Pid {
> +        // SAFETY: We know that `self.0.get()` is valid by the type inva=
riant. The rest is just FFI
> +        // calls.
> +        unsafe {
> +            let namespace =3D bindings::task_active_pid_ns(bindings::get=
_current());
> +            bindings::task_tgid_nr_ns(self.0.get(), namespace)
> +        }

I would split this into two `unsafe` blocks.

> +    }
> +
>      /// Wakes up the task.
>      pub fn wake_up(&self) {
>          // SAFETY: By the type invariant, we know that `self.0.get()` is=
 non-null and valid.
> @@ -147,6 +180,42 @@ pub fn wake_up(&self) {
>      }
>  }
>=20
> +impl Kuid {
> +    /// Get the current euid.
> +    pub fn current_euid() -> Kuid {
> +        // SAFETY: Just an FFI call.
> +        Self {
> +            kuid: unsafe { bindings::current_euid() },
> +        }

Would expect a call to `from_raw` here instead of `Self {}`.

> +    }
> +
> +    /// Create a `Kuid` given the raw C type.
> +    pub fn from_raw(kuid: bindings::kuid_t) -> Self {
> +        Self { kuid }
> +    }

Is there a reason that this is named `from_raw` and not just a normal
`From` impl? AFAICT any `bindings::kuid_t` is a valid `Kuid`.

> +
> +    /// Turn this kuid into the raw C type.
> +    pub fn into_raw(self) -> bindings::kuid_t {
> +        self.kuid
> +    }
> +
> +    /// Converts this kernel UID into a UID that userspace understands. =
Uses the namespace of the
> +    /// current task.

Why not:

    /// Converts this kernel UID into a userspace UID.
    ///
    /// Uses the namespace of the current task.

--=20
Cheers,
Benno

> +    pub fn into_uid_in_current_ns(self) -> bindings::uid_t {
> +        // SAFETY: Just an FFI call.
> +        unsafe { bindings::from_kuid(bindings::current_user_ns(), self.k=
uid) }
> +    }
> +}
