Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D8D809232
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 21:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443889AbjLGUWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 15:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjLGUWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 15:22:04 -0500
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F191719
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 12:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1701980528; x=1702239728;
        bh=uJSND0rxUIaQSNMIcl3FEGD0TOMeemf0Jpuoq4FqA1o=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=FaDt5exgc4gRIStEIuctEsxtbjMiHrEXxCl6hXCl4U76PpBJUnY5/dflD4X4A9uQJ
         cokabxPmFDSJM7ulWQdXwSOTj0ntKhg3hd55W4CCySVv9ongeuq4V/NUjcbMpAcxSC
         K9QuoG0U5H9+7uSJKKti4dFeDk01MWvonuGJDiV87A45dO6OK/KA7OKXl4IxABwdwy
         9//peOXdMCIv45qae3HwYNyjrR3lPZ+LWhfzfyJcvF7mbS0fUe6Ngr4lgI+2I87UB/
         CuH7jmVLXuxhGamsEXK8DWQt3bbGhjO7X/ku43Gljln8yCNn9OPHBepfcxB7cq1IET
         ppsSxMVsWhwqw==
Date:   Thu, 07 Dec 2023 20:21:48 +0000
To:     Alice Ryhl <aliceryhl@google.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rust: sync: add `CondVar::notify_sync`
Message-ID: <n18Cdl9DQXfuGtD6d664Mn0rrPfxebZs31-3vQfu5N0vP0ZgfHNwBZYC4qYgU1GD-4Ue4bUhgNqs40-u8t0baAzlQ0cMMiSzTgjQnhcG50o=@proton.me>
In-Reply-To: <20231206-rb-new-condvar-methods-v1-1-33a4cab7fdaa@google.com>
References: <20231206-rb-new-condvar-methods-v1-0-33a4cab7fdaa@google.com> <20231206-rb-new-condvar-methods-v1-1-33a4cab7fdaa@google.com>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/23 11:09, Alice Ryhl wrote:
> Wake up another thread synchronously.
>=20
> This method behaves like `notify_one`, except that it hints to the
> scheduler that the current thread is about to go to sleep, so it should
> schedule the target thread on the same CPU.
>=20
> This is used by Rust Binder as a performance optimization. When sending
> a transaction to a different process, we usually know which thread will
> handle it, so we can schedule that thread for execution next on this
> CPU for better cache locality.
>=20
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/sync/condvar.rs | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
> index b679b6f6dbeb..9861c6749ad0 100644
> --- a/rust/kernel/sync/condvar.rs
> +++ b/rust/kernel/sync/condvar.rs
> @@ -155,6 +155,12 @@ fn notify(&self, count: i32, flags: u32) {
>          };
>      }
>=20
> +    /// Calls the kernel function to notify one thread synchronously.
> +    pub fn notify_sync(&self) {
> +        // SAFETY: `wait_list` points to valid memory.
> +        unsafe { bindings::__wake_up_sync(self.wait_list.get(), bindings=
::TASK_NORMAL) };

I took a look at the C function (i.e. __wake_up_common) and there I
found this:

    lockdep_assert_held(&wq_head->lock);

So I think this function requires that the lock is held, how are you
ensuring this?

--=20
Cheers,
Benno
