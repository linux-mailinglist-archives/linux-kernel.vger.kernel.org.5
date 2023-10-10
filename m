Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409A17BF858
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 12:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjJJKQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 06:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjJJKQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 06:16:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423F1116;
        Tue, 10 Oct 2023 03:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Zb6A2kfpJa7lPS8yNIr1mX5OvpeUAPwA3IcDR1IaKKc=; b=ueKzQLcnmzerXnYo62eevFkVL0
        KreQh9Q1gUxYYHjpqpbTjp3oivGIICOfNTpJsJUVb7fbPeXYvxGghlyUqpUMTKfmKJoPJwwNEoquJ
        8h03g2rYT14em69rgkufYtaf8BTgHY/b7IOchJm9iMQ0Lez6CKSrDRc9HBM/AG7UJe6tAzW/yqppG
        Isa6IYCM58qFZnGUyiApip5VbPWJztRzWrgrqCEj8uSHvCihYTUQv/SXWoijuZ01bliAhmGHfU/Pr
        mCcr+KCQEm3VK1Hdq7/chubA0yWFKc9MsuJjfYSmgYBHZf3S/slGtqLoWQjQMB62KnJ737HCbwLkB
        SdpMivgg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qq9mn-00417M-OM; Tue, 10 Oct 2023 10:16:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 68AF6300392; Tue, 10 Oct 2023 12:16:21 +0200 (CEST)
Date:   Tue, 10 Oct 2023 12:16:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Fei Yang <fei.yang@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] x86/alternatives: Disable KASAN on text_poke_early() in
 apply_alternatives()
Message-ID: <20231010101621.GG377@noisy.programming.kicks-ass.net>
References: <20231010053716.2481-1-kirill.shutemov@linux.intel.com>
 <20231010081938.GBZSUJGlSvEkFIDnES@fat_crate.local>
 <20231010101056.GF377@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010101056.GF377@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 12:10:56PM +0200, Peter Zijlstra wrote:

> That said, I don't particularly like the patch, I think it should, at
> the veyr least, cover all of apply_alternatives, not just
> text_poke_early().

kasan_arch_is_ready() is another option, x86 doesn't currently define
that, but that would allow us to shut kasan down harder around patching.
Not sure if it's worth the trouble though.
