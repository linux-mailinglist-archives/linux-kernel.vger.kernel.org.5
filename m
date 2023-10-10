Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBD57BFE8B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbjJJNzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbjJJNzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:55:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A335E9E;
        Tue, 10 Oct 2023 06:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S2MeW9xBBP5ir4MyshyKYBTdw1uG9obgtaYQpOlwGak=; b=X22LW5WCmFCOs0EIQlxClY2wvI
        8hEg5mMCJLwgn58uuFizRFpQMS58hRoUjXq62gWqtShVnZ8VbJAYcS/SbRoP5QWRU2k1ZWwT5cBSc
        34bz+gbt84eT31L3BrNmjcamRNtclt2f+TA5zNVWpnmMaaMxK6G0cDEeYnP7i8Yu04Yku/+3lJrEi
        kASq2PzPKtHuzVLC1HW0MnJlTLgB8hTorast+sqQdXVqAt79xhJvQJiKXZ+U2WZtxDQdnNtvAlFoC
        wSUYANUEkDMeNgQOuFC/sfDX+9IMeYAuSIrNoWPzunNXL8b+dmoGN9pZI2adiznG6PIrdoORzUy93
        hUqhqeyw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qqDCK-004xqT-W8; Tue, 10 Oct 2023 13:54:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id A6E4F300392; Tue, 10 Oct 2023 15:54:56 +0200 (CEST)
Date:   Tue, 10 Oct 2023 15:54:56 +0200
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
Message-ID: <20231010135456.GL377@noisy.programming.kicks-ass.net>
References: <20231010053716.2481-1-kirill.shutemov@linux.intel.com>
 <20231010081938.GBZSUJGlSvEkFIDnES@fat_crate.local>
 <20231010101056.GF377@noisy.programming.kicks-ass.net>
 <20231010131054.GHZSVNXhruJIx0iCzq@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010131054.GHZSVNXhruJIx0iCzq@fat_crate.local>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 03:10:54PM +0200, Borislav Petkov wrote:
> On Tue, Oct 10, 2023 at 12:10:56PM +0200, Peter Zijlstra wrote:
> > Now, obviously you really don't want boot_cpu_has() in
> > __VIRTUAL_MASK_SHIFT, that would be really bad (Linus recently
> > complained about how horrible the code-gen is around this already, must
> > not make it far worse).
> 
> You mean a MOV (%rip) and a TEST are so horrible there because it is
> a mask?
> 
> I'd experiment with it when I get a chance...

That gets you a memory-reference and potential cachemiss what should
have been an immediate :/
