Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E651B80A96C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574011AbjLHQkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbjLHQkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:40:09 -0500
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4351995
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 08:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1702053614; x=1702312814;
        bh=iOcAdvmkOxmMqWA6VMNdNeHSDm9Y1yQ4G8UPvASaJ3o=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=RDUdK0QZ007pRxsGGYl1Y1rMyM8MlCsVdH41VwLUTLTVAl+7ARMq5nMpGZEb88xF6
         cIHqptWrxnculVk7rkFGCH7Gfry1clDWcMtxwV1vlzp7cCLjd6G5BtkgTt3XuCSDxh
         9jDpt2Z5gbuAdCWK+5UO1aKvO/VLgMVjNFAJjBnnLPl+K3KBza38L0lQGnjkznzjDy
         ztFuU3mx32rtI9nWlns6oSXANQuDgiqtS5/YSlb2Wcr1SaF3ysmxGVaM4QK/M/raZj
         bHIbXgY8eyl/yKbEkWF0bwkQTmE8Hoydwg4wr7/ArOsh0LoTxrH1dMvAYXAQbh/9oW
         mma2vT8fEJ4mQ==
Date:   Fri, 08 Dec 2023 16:40:09 +0000
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
Subject: Re: [PATCH v2 5/7] rust: file: add `Kuid` wrapper
Message-ID: <jtCKrRw-FNajNJOXOuI1sweeDxI8T_uYnJ7DxMuqnJc9sgWjS0zouT_XIS-KmPferL7lU51BwD6nu73jZtzzB0T17pDeQP0-sFGRQxdjnaA=@proton.me>
In-Reply-To: <20231206-alice-file-v2-5-af617c0d9d94@google.com>
References: <20231206-alice-file-v2-0-af617c0d9d94@google.com> <20231206-alice-file-v2-5-af617c0d9d94@google.com>
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
> +    /// Returns the given task's pid in the current pid namespace.
> +    pub fn pid_in_current_ns(&self) -> Pid {
> +        // SAFETY: Calling `task_active_pid_ns` with the current task is=
 always safe.
> +        let namespace =3D unsafe { bindings::task_active_pid_ns(bindings=
::get_current()) };

Why not create a safe wrapper for `bindings::get_current()`?
This patch series has three occurrences of `get_current`, so I think it
should be ok to add a wrapper.
I would also prefer to move the call to `bindings::get_current()` out of
the `unsafe` block.

> +        // SAFETY: We know that `self.0.get()` is valid by the type inva=
riant.

What about `namespace`?

--=20
Cheers,
Benno

> +        unsafe { bindings::task_tgid_nr_ns(self.0.get(), namespace) }
> +    }
