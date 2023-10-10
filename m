Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BF97BF564
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442692AbjJJIND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378097AbjJJINB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:13:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BE597;
        Tue, 10 Oct 2023 01:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PV5bBWwhGn2puA47DlzssLedbM0lpZgwBXeayCliFs4=; b=l9MVUl25pttq5mJ76VwM+f6Gms
        XKRlUkOf555nICE7NLGCuwY00h9MeJ0csQBHIjRJ3+hrUKOJotDjECDRD7ZofAmxVE9ZgLlQmZjJS
        btUiPXjERyox7NhjS0Z9tzTxTFoXqoQMzQFRKyruBZuHdjQTP2tcjTnG1HJDllivs4ie5T+4wozQ3
        NgpiCD/S3mBoDO6CW90OJ2si6YwNL+4BaABM0CO5jdYgaNwtF8Hd7ICRfK9vkkDOkXJw8boVvWe8F
        ScD6O2nx60knalPjg/ioPci1xE6vltfnLO3emJaucWB3h31cb6qMcbHJJdVOmaVk9rSp9CbZrvTnT
        Llm9lRyw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qq7qm-003T1w-JI; Tue, 10 Oct 2023 08:12:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 45B9B300392; Tue, 10 Oct 2023 10:12:20 +0200 (CEST)
Date:   Tue, 10 Oct 2023 10:12:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matthew Maurer <mmaurer@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] x86: Enable IBT in Rust if enabled in C
Message-ID: <20231010081220.GD377@noisy.programming.kicks-ass.net>
References: <20231009224347.2076221-1-mmaurer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009224347.2076221-1-mmaurer@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 10:42:54PM +0000, Matthew Maurer wrote:
> These flags are not made conditional on compiler support because at the
> moment exactly one version of rustc supported, and that one supports
> these flags.
> 
> Building without these additional flags will manifest as objtool
> printing a large number of errors about missing ENDBR and if CFI is
> enabled (not currently possible) will result in incorrectly structured
> function prefixes.

Well, I would also imagine running it on actual IBT enabled hardware
will get you a non-booting kernel.

> Signed-off-by: Matthew Maurer <mmaurer@google.com>
> ---
> 
> Split out the IBT additions as per
> https://lkml.kernel.org/linux-fsdevel/CANiq72kK6ppBE7j=z7uua1cJMKaLoR5U3NUAZXT5MrNEs9ZhfQ@mail.gmail.com/
> 
> arch/x86/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 5bfe5caaa444..941f7abf6dbf 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -81,6 +81,7 @@ ifeq ($(CONFIG_X86_KERNEL_IBT),y)
>  #   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=104816
>  #
>  KBUILD_CFLAGS += $(call cc-option,-fcf-protection=branch -fno-jump-tables)
> +KBUILD_RUSTFLAGS += -Zcf-protection=branch -Zno-jump-tables

One question, -Zcf-protection=branch, will that ever emit NOTRACK
prefix? The kernel very explicitly does not support (enable) NOTRACK.

>  else
>  KBUILD_CFLAGS += $(call cc-option,-fcf-protection=none)
>  endif
> -- 
> 2.42.0.609.gbb76f46606-goog
> 
