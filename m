Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DDE754F39
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 17:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjGPPJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 11:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGPPJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 11:09:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3346A1BF
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 08:09:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C49706027E
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 15:09:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098A6C433C7;
        Sun, 16 Jul 2023 15:09:53 +0000 (UTC)
Date:   Sun, 16 Jul 2023 08:09:52 -0700
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v1 11/14] arm64/mm: Wire up PTE_CONT for user mappings
Message-ID: <ZLQIQAtq6NfSjX1C@arm.com>
References: <20230622144210.2623299-1-ryan.roberts@arm.com>
 <20230622144210.2623299-12-ryan.roberts@arm.com>
 <ZKLmbRpEEKosj9/Q@arm.com>
 <f59228dd-2186-c882-3774-c9778918cd31@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f59228dd-2186-c882-3774-c9778918cd31@arm.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 12:09:31PM +0100, Ryan Roberts wrote:
> On 03/07/2023 16:17, Catalin Marinas wrote:
> > Hi Ryan,
> > 
> > Some comments below. I did not have time to trim down the quoted text,
> > so you may need to scroll through it.
> 
> Thanks for the review!
> 
> Looking at the comments, I think they all relate to implementation. Does that
> imply that you are happy with the shape/approach?

I can't really tell yet as there are a few dependencies and I haven't
applied them to look at the bigger picture. My preference would be to
handle the large folio breaking/making in the core code via APIs like
set_ptes() and eliminate the loop heuristics in the arm64
code to fold/unfold. Maybe it's not entirely possible I need to look at
the bigger picture with all the series applied (and on a bigger screen,
writing this reply on a laptop in flight).

> Talking with Anshuman yesterday, he suggested putting this behind a new Kconfig
> option that defaults to disabled and also adding a command line option to
> disable it when compiled in. I think that makes sense for now at least to reduce
> risk of performance regression?

I'm fine with a Kconfig option (maybe expert) but default enabled,
otherwise it won't get enough coverage. AFAICT, the biggest risk of
regression is the heuristics for folding/unfolding. In general the
overhead should be offset by the reduced TLB pressure but we may find
some pathological case where this gets in the way.

> > On Thu, Jun 22, 2023 at 03:42:06PM +0100, Ryan Roberts wrote:
> >> +		/*
> >> +		 * No need to flush here; This is always "more permissive" so we
> >> +		 * can only be _adding_ the access or dirty bit. And since the
> >> +		 * tlb can't cache an entry without the AF set and the dirty bit
> >> +		 * is a SW bit, there can be no confusion. For HW access
> >> +		 * management, we technically only need to update the flag on a
> >> +		 * single pte in the range. But for SW access management, we
> >> +		 * need to update all the ptes to prevent extra faults.
> >> +		 */
> > 
> > On pre-DBM hardware, a PTE_RDONLY entry (writable from the kernel
> > perspective but clean) may be cached in the TLB and we do need flushing.
> 
> I don't follow; The Arm ARM says:
> 
>   IPNQBP When an Access flag fault is generated, the translation table entry
>          causing the fault is not cached in a TLB.
> 
> So the entry can only be in the TLB if AF is already 1. And given the dirty bit
> is SW, it shouldn't affect the TLB state. And this function promises to only
> change the bits so they are more permissive (so AF=0 -> AF=1, D=0 -> D=1).
> 
> So I'm not sure what case you are describing here?

The comment for this function states that it sets the access/dirty flags
as well as the write permission. Prior to DBM, the page is marked
PTE_RDONLY and we take a fault. This function marks the page dirty by
setting the software PTE_DIRTY bit (no need to worry) but also clearing
PTE_RDONLY so that a subsequent access won't fault again. We do need the
TLBI here since PTE_RDONLY is allowed to be cached in the TLB.

Sorry, I did not reply to your other comments (we can talk in person in
about a week time). I also noticed you figured the above but I had
written it already.

-- 
Catalin
