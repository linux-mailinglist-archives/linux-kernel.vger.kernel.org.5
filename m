Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DE1806FD4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 13:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378292AbjLFMe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 07:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378248AbjLFMe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 07:34:26 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F84112;
        Wed,  6 Dec 2023 04:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r8reRFycb0Atah5iaBjoNtNIC5cecXDQ0jXEw5GxuRE=; b=f7sWydaiK+oeu4P4WF61PAzdkX
        hWE6AEt1dMN2zq6wRzVq+L5Ue00Cw0BTq+V+IUydwNrQhkwyL3DPep2ORkCXVlRvL9T3CPpfn8t4w
        ZYWCFo6OJioGHuyCT+iXJKm4itcVw8paebhEFv/n+qo1MSJO5diXi7RRd/p9MywKiXbwTbn5JyBlZ
        cFnmMsFgCRKsx4+JWiYbEuHivDPjGpu+BtCShwuKGzFHxfoj1KaKmTbV8SiFTXCgNOiPC6t4E58a6
        7x6NHM/NS10Ihe7NAisXnLORbcpMYI6xKyNypVedTqgB4og+3OqwFH7RvI8bxqULR+b40rP1Grs/O
        HKNkMAHg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rAr6K-005A3G-0P;
        Wed, 06 Dec 2023 12:34:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id CD81E300451; Wed,  6 Dec 2023 13:34:02 +0100 (CET)
Date:   Wed, 6 Dec 2023 13:34:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
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
Message-ID: <20231206123402.GE30174@noisy.programming.kicks-ass.net>
References: <20231206-alice-file-v2-0-af617c0d9d94@google.com>
 <20231206-alice-file-v2-5-af617c0d9d94@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206-alice-file-v2-5-af617c0d9d94@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 11:59:50AM +0000, Alice Ryhl wrote:

> diff --git a/rust/helpers.c b/rust/helpers.c
> index fd633d9db79a..58e3a9dff349 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -142,6 +142,51 @@ void rust_helper_put_task_struct(struct task_struct *t)
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_put_task_struct);
>  
> +kuid_t rust_helper_task_uid(struct task_struct *task)
> +{
> +	return task_uid(task);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_task_uid);
> +
> +kuid_t rust_helper_task_euid(struct task_struct *task)
> +{
> +	return task_euid(task);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_task_euid);

So I still object to these on the ground that they're obvious and
trivial speculation gadgets.

We should not have (exported) functions that are basically a single
dereference of a pointer argument.

And I do not appreciate my feedback on the previous round being ignored.
