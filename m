Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392627DA118
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 20:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbjJ0S4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 14:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjJ0S4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 14:56:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AE5E1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 11:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8Ng2tJqwczIjFESHm7ZVk4sDc0+QSuVVNEX3VTMD8Ig=; b=XhRxQ4TCMzIPi5sbMUJ7mDQoBq
        z/et/pXHSr7Gx+34bRYCEFvH4albrd8bp49wtTNygLvtlKBnHvsId8NYjEJg5jNaTxdYU0R/BCxw0
        gGncfKGG+VBJu4MNRCsd/2+2aZpkCQNj0fZqXNNMwnh84w5Z5elFIryuMPVhb+TErTq5PHADAA8PA
        Mx8az1ilsuisjL+XZbS0DMvX2qdTlyCJDPhP4OK4LIRVAKftRcC6ylq8Jf0mAb+Y0rJx2Qo38T7e/
        vGY1U6SqDSFiq3idYt1eno0ybplG4BtmJFfrTq/tpMRK8yvJWOv7FN8tm8R9HfZ06Ls97mJpfCi06
        fZ+l5OSQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qwS0f-0051TA-Mk; Fri, 27 Oct 2023 18:56:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5D682300392; Fri, 27 Oct 2023 20:56:41 +0200 (CEST)
Date:   Fri, 27 Oct 2023 20:56:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>,
        Kishon VijayAbraham <Kishon.VijayAbraham@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/barrier: Do not serialize MSR accesses on AMD
Message-ID: <20231027185641.GE26550@noisy.programming.kicks-ass.net>
References: <20230622095212.20940-1-bp@alien8.de>
 <20230703125419.GJ4253@hirez.programming.kicks-ass.net>
 <20230704074631.GAZKPOV/9BfqP0aU8v@fat_crate.local>
 <20230704090132.GP4253@hirez.programming.kicks-ass.net>
 <20230704092222.GBZKPkzgdM8rbPe7zA@fat_crate.local>
 <20231027153327.GKZTvYR3qslaTUjtCT@fat_crate.local>
 <20231027153458.GMZTvYou1tlK6HD8/Y@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027153458.GMZTvYou1tlK6HD8/Y@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 05:34:58PM +0200, Borislav Petkov wrote:

> +static inline void weak_wrmsr_fence(void)
> +{
> +	alternative("mfence; lfence", "", ALT_VENDOR(X86_VENDOR_AMD));
> +}

Well, you see, AFAICT the non-serializing MSRs thing is an Intel thing,
so everything !Intel wants this gone, no?

Definitely the Hygon thing wants this right along with AMD, because
that's basically AMD, no?
