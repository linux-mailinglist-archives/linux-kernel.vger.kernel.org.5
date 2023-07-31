Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE367690D4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjGaIxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjGaIwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:52:31 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFA949D5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:49:32 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9e6cc93c6so13149621fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1690793371; x=1691398171;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=AEpQPsL8CKvgd9jCnKauvgppTMsvJVGBjZ9X1QDN9oE=;
        b=4CsLTWSrXtKZeou89ehTdDcI35pXhzam4Gf+T2BNZK/F9IAwoXnSZdoCJhiuzuWEob
         v+FHWghCDcj3bHalbjjF+ZQpieuLc22Up7FE1aLSBkKUodTfIVMGIuVzXjati/lwr9gN
         XAU30D5Zh4A4gcTRNx85Pq1gBYV9VweZylbeWjn8M8U2ijFQBPYl1taHlJn3CxMF0CVh
         GA8hHanjU1vc9LC8TTV0LsX0+xlRcpJ6WxpwyzrK8ioLE8hEH0VzN2K8ePI9xuHXUvtL
         e1Inx4wkGuVdOmVskj2bNxagSFMJU2veOk4Xv/8H35PxkMBvvSD7cWsft78kMFPaGKOK
         WNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690793371; x=1691398171;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEpQPsL8CKvgd9jCnKauvgppTMsvJVGBjZ9X1QDN9oE=;
        b=JASF65IqRW9KtZKyQDH80n/s4sh36bM2BCASYJhOFx2yzI+6TmnCbdi5C5wv1MRpu7
         Qdi6oYJJ8p9Mu2gfpCKFX6dRUIJkTQUwu6SOV2+lksFAfKL2vGyQZh6U1l/40GhHRfsx
         U2rhXx0396R0gSvcCw5vVQJSNt00wBb/IK8q1j5P0rMnUO8C8pVOvoo9lBlwZ+UNUGN9
         uMDaPzciqSdocSOrw7GXPQBtCNbL7GQlOMmKjZUKXaIkytUpUZKiNtVij99gTTy+z4I8
         bfgDvUMa+3SPjRWS/9YmE2CFw6QbMpN98NAGRf6K9j1GWpTzeUiSdC4/FdJmJl3f413q
         MHeA==
X-Gm-Message-State: ABy/qLYZkOS7MinkGgphdPRyAxodvwJ498ld/WbawEG6QSstxoA1Glsc
        cvNO/5cNA1zl+Gkg8mBVNZ2S2w==
X-Google-Smtp-Source: APBJJlGFJ70YghXLG/YDeubPbpWWwMiyEaj0546fMRnCHGzwMbMfwcMsEuKBc1tsdJm+7ssl+pZkYQ==
X-Received: by 2002:a2e:2c19:0:b0:2b7:3b73:2589 with SMTP id s25-20020a2e2c19000000b002b73b732589mr5498532ljs.32.1690793370676;
        Mon, 31 Jul 2023 01:49:30 -0700 (PDT)
Received: from localhost ([165.225.194.221])
        by smtp.gmail.com with ESMTPSA id w3-20020a1cf603000000b003fa973e6612sm13350468wmc.44.2023.07.31.01.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 01:49:29 -0700 (PDT)
References: <20230730012905.643822-1-boqun.feng@gmail.com>
 <20230730012905.643822-3-boqun.feng@gmail.com>
User-agent: mu4e 1.10.5; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Fox Chen <foxhlchen@gmail.com>,
        John Baublitz <john.m.baublitz@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Kees Cook <keescook@chromium.org>, stable@vger.kernel.org
Subject: Re: [PATCH 2/3] rust: allocator: Use krealloc_aligned() in
 KernelAllocator::alloc
Date:   Mon, 31 Jul 2023 10:48:57 +0200
In-reply-to: <20230730012905.643822-3-boqun.feng@gmail.com>
Message-ID: <873514qxd2.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Boqun Feng <boqun.feng@gmail.com> writes:

> This fixes the potential issue that when KernelAllocator is used, the
> allocation may be mis-aligned due to SLAB's alignment guarantee.
>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  rust/kernel/allocator.rs | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/rust/kernel/allocator.rs b/rust/kernel/allocator.rs
> index fae11d1fdba7..1aec688cf0e0 100644
> --- a/rust/kernel/allocator.rs
> +++ b/rust/kernel/allocator.rs
> @@ -41,9 +41,9 @@ unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: bindings::gf
>  
>  unsafe impl GlobalAlloc for KernelAllocator {
>      unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
> -        // `krealloc()` is used instead of `kmalloc()` because the latter is
> -        // an inline function and cannot be bound to as a result.
> -        unsafe { bindings::krealloc(ptr::null(), layout.size(), bindings::GFP_KERNEL) as *mut u8 }
> +        // SAFETY: `ptr::null_mut()` is null and `layout` has a non-zero size by the function safety
> +        // requirement.
> +        unsafe { krealloc_aligned(ptr::null_mut(), layout, bindings::GFP_KERNEL) }
>      }
>  
>      unsafe fn dealloc(&self, ptr: *mut u8, _layout: Layout) {

Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>

