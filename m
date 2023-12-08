Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EE080AE24
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 21:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574733AbjLHUnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 15:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjLHUnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 15:43:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD93A1724;
        Fri,  8 Dec 2023 12:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8vLlP+pPcWW01QzZqjgtBbIIyAPwFK9O42/VsZGzF5E=; b=Yhg3URpGhmhc5v8U/fS6J/06Tc
        NKkDkeLBjoflzM+RHIJ19vp4D2e2zYXjBM626AEQ7Pswgbyj9yD6vcItTar1poSe0tZ/OIGo+o+fv
        URe4Em6k2Qzh11KOd4VF1+RB5ZVW8wWBC0XDkFBy0+6vyvD0+Qrt54n11/k6XDeXn8sCACK+/48GS
        i7jF1YJ3Bgoku6oytM/hrRZPXNg7dBCVnSTBwfuHdyJShWWgCVyUVhapbY3wz4V0OtOetMdQYpA/Z
        oIQeHxbq1kh7w+OfJt2KzYxUH5U0mU66GhZwxVS3JjLqGe1eFlcn1PeNt5j6MTFV8YQeVIJRDR5Jo
        Suaz3aRg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1rBhh1-006Xz9-Df; Fri, 08 Dec 2023 20:43:27 +0000
Date:   Fri, 8 Dec 2023 20:43:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        comex <comexk@gmail.com>, Christian Brauner <brauner@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alice Ryhl <aliceryhl@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/7] rust: file: add `Kuid` wrapper
Message-ID: <ZXN/72adT83PrfnL@casper.infradead.org>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
 <20231129-alice-file-v1-5-f81afe8c7261@google.com>
 <20231129-etappen-knapp-08e2e3af539f@brauner>
 <20231129164815.GI23596@noisy.programming.kicks-ass.net>
 <20231130-wohle-einfuhr-1708e9c3e596@brauner>
 <A0BFF59C-311C-4C44-9474-65DB069387BD@gmail.com>
 <CANiq72k4H2_NZuQcpeKANqyi_9W01fLC0WxXon5cx4z=WsgeXQ@mail.gmail.com>
 <CAKwvOdkgDwnC_jaGjXjk9yKYo=zWDR_3x7Drw3i=KX0Wyij6ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkgDwnC_jaGjXjk9yKYo=zWDR_3x7Drw3i=KX0Wyij6ew@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 09:08:47AM -0800, Nick Desaulniers wrote:
> From a build system perspective, I'd rather just point users towards
> LTO if they have this concern.  We support full and thin lto.  This
> proposal would add a third variant for just rust drivers.  Each
> variation on LTO has a maintenance cost and each have had their own
> distinct fun bugs in the past.  Not sure an additional variant is
> worth the maintenance cost, even if it's technically feasible.

If we're allowed to talk about ideal solutions ... I hate putting
code in header files.  I'd rather be able to put, eg:

__force_inline int put_page_testzero(struct page *page)
{
	VM_BUG_ON_PAGE(page_ref_count(page) == 0, page);
	return page_ref_dec_and_test(page);
}

__force_inline int folio_put_testzero(struct folio *folio)
{
	return put_page_testzero(&folio->page);
}

__force_inline void folio_put(struct folio *folio)
{
	if (folio_put_testzero(folio))
		__folio_put(folio);
}

into a .c file and have both C and Rust inline folio_put(),
folio_put_testzero(), put_page_testzero(), VM_BUG_ON_PAGE() and
page_ref_dec_and_test(), but not even attempt to inline __folio_put()
(because We Know Better, and have determined that is the point at
which to stop).
