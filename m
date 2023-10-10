Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509527C00B2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbjJJPtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbjJJPtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:49:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0198B0;
        Tue, 10 Oct 2023 08:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=hcO6nbqUQCaTitXMmYutkN0cL6Et6mB9aV0MG0pJiLk=; b=mg8IuD3mWYwtoSxIe0694DSttk
        h9BJQEuppRy+URK+6LfaihMRw0WJDU2QDbIIqzprRjAof3NRISqdKdrBzRNjp0u11f0yILgiwFtGk
        n7o9Vsek58Irbon9f4KcFpCE3iBlQgraRch16NRv656pEi1qC9nm9eHlBIbLPzt5VJKyGhCPeUTnd
        mkD+Xq4M/RyQ4LY867kuGUBFmamYMCBeko+dynwJaxg3KWkHq14CKEcGHzMiJ6pPAvOTHi3eSoMJk
        SN4rvt1A0ymaYo7gDY1GDjVAueWWPv1lnjwOj86MXjC3Pz2q1vv2H/DiKUedfKc4fkK+Bix3XbOA4
        LrPWE7ng==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qqEyY-005RGN-Uu; Tue, 10 Oct 2023 15:48:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9C5B03006DD; Tue, 10 Oct 2023 17:48:50 +0200 (CEST)
Date:   Tue, 10 Oct 2023 17:48:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Matthew Maurer <mmaurer@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <20231010154850.GR377@noisy.programming.kicks-ass.net>
References: <20231009224347.2076221-1-mmaurer@google.com>
 <20231010081220.GD377@noisy.programming.kicks-ass.net>
 <CAKwvOdk1c3N05R9fya6HsZwPZzrkDhC3LrK=nRVOoUwyXsiXQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdk1c3N05R9fya6HsZwPZzrkDhC3LrK=nRVOoUwyXsiXQg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 08:38:58AM -0700, Nick Desaulniers wrote:
> On Tue, Oct 10, 2023 at 1:13 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Oct 09, 2023 at 10:42:54PM +0000, Matthew Maurer wrote:
> > > These flags are not made conditional on compiler support because at the
> > > moment exactly one version of rustc supported, and that one supports
> > > these flags.
> > >
> > > Building without these additional flags will manifest as objtool
> > > printing a large number of errors about missing ENDBR and if CFI is
> > > enabled (not currently possible) will result in incorrectly structured
> > > function prefixes.
> >
> > Well, I would also imagine running it on actual IBT enabled hardware
> > will get you a non-booting kernel.
> 
> Do you know what machine type in QEMU first supports IBT?

I'm not sure QEMU has IBT support at all atm -- the whole CET
virtualization stuff is a bit of a mess.

But hardware wise it's Tigerlake (11) and everything after that - so
Alderlake (12) and Saphire Rapids (4th gen scalable -- or somesuch
nonsense).
