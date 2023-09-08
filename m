Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B33A798737
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 14:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240708AbjIHMnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 08:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234445AbjIHMnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 08:43:03 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068C719AB
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 05:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ftcfDlLzJYtTTNZ6CKVdMzoar0kugl5/EzZRiB/4Zb4=; b=NS+uzqd0/vDlawyoCmejFdl/ig
        CsHSzockNidVQJ+sIyyEoUkeHvebdFkP7KBk1GZVobLbGHS2u4i0T+4PL2hFFCq2+l/S3xto9cAnw
        AeRhW35iy5mfuFRX2ECxg//HQo4OHbY8x+4hNgFs/muAtMuHPEp0yhITN7fPcldCdoxBXx8eT5MB8
        mSKEPVorteiitCJKEZRC4TmdAwngTeGFygIHeNiWXCBDUJL2Uxzq3TvBZtOXXpP05VlqBj4JG/356
        ZqvSanl3sXj9RuXjpzVEix1cpK/3mXHVlUINPEsTn4qqRiNERFbpNVUXu55yyygqUyBKAVod/Lv6d
        +brxrFyw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qeaoC-002WUe-0y;
        Fri, 08 Sep 2023 12:42:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 688493002F1; Fri,  8 Sep 2023 14:42:01 +0200 (CEST)
Date:   Fri, 8 Sep 2023 14:42:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        tglx@linutronix.de, jon.grimm@amd.com, bharata@amd.com,
        raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v2 8/9] irqentry: define irqentry_exit_allow_resched()
Message-ID: <20230908124201.GC19320@noisy.programming.kicks-ass.net>
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
 <20230830184958.2333078-9-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830184958.2333078-9-ankur.a.arora@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 11:49:57AM -0700, Ankur Arora wrote:

> +#ifdef TIF_RESCHED_ALLOW
> +#define irqentry_exit_cond_resched_dynamic_disabled	irqentry_exit_allow_resched
> +#else
>  #define irqentry_exit_cond_resched_dynamic_disabled	NULL
> +#endif

per ^, the below comments are not entirely accurate, since not every
architecture has TIF_RESCHED_ALLOW, perhaps make it:

> @@ -8692,25 +8694,25 @@ EXPORT_SYMBOL(__cond_resched_rwlock_write);
>   *
>   *
>   * NONE:
> - *   cond_resched               <- __cond_resched
> - *   might_resched              <- RET0
> - *   preempt_schedule           <- NOP
> - *   preempt_schedule_notrace   <- NOP
> - *   irqentry_exit_cond_resched <- NOP
> + *   cond_resched                <- __cond_resched
> + *   might_resched               <- RET0
> + *   preempt_schedule            <- NOP
> + *   preempt_schedule_notrace    <- NOP
> + *   irqentry_exit_cond_resched  <- irqentry_exit_allow_resched

+ *   irqentry_exit_cond_resched  <- NOP / irqentry_exit_allow_resched

Or something.

Also, why did you add that extra whilespace all over? Makes it a bit
harder to see what actually changed.
