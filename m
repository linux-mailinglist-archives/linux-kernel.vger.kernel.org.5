Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909A6798748
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 14:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243312AbjIHMqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 08:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjIHMqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 08:46:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2721BFF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 05:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9DL4ykTlB0hN/m8lcjJGvh6M22oyKpixM02sGXThIxc=; b=dLE7TnnvY1s9Kzt65DMmvYZTY3
        Pwk7pVfLqwtax+rzDGODWZ1Pa9zXJuP4nFXqhRXJrjzIMpYixzxAXi9VAfQypEWZmZsw/w8AYoQag
        ansOhHCRRIVSX5a1soQIgrnL6poWRLmVqCVdSo40M0uP6HXYKC/kIKy/oJuBtxAYUeJ5vKtOj+ald
        UT2Al3fSDPBTWtCW6nHWDcyYKYgBff0SHjbMDQEGnQvCQ1qFjT7eylEkh5BR/oXUenYANPT3QN4c+
        LJ7BX3RF6dSO3zRBluLHAe7BKD+yMbHqXhsg3lAgUlbEpX24sagrooLHDq5Yq3KXcFNtXc5An3N0A
        0HMCKFGw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qearR-000Bj5-PA; Fri, 08 Sep 2023 12:45:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6D984300472; Fri,  8 Sep 2023 14:45:21 +0200 (CEST)
Date:   Fri, 8 Sep 2023 14:45:21 +0200
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
Subject: Re: [PATCH v2 9/9] x86/clear_huge_page: make clear_contig_region()
 preemptible
Message-ID: <20230908124521.GD19320@noisy.programming.kicks-ass.net>
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
 <20230830184958.2333078-10-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830184958.2333078-10-ankur.a.arora@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 11:49:58AM -0700, Ankur Arora wrote:
> clear_contig_region() can be used for clearing  regions as large as a
> gigantic page. Allow preemption in irqentry_exit to make sure we don't
> hold on to the CPU for an arbitrarily long period.

It would be very nice to quantify the latency improvement here. At the
very least perhaps mention how long a 2M or 1G clear takes (on you
favourite machine) to illustrate why this is needed.

> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  arch/x86/mm/hugetlbpage.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/x86/mm/hugetlbpage.c b/arch/x86/mm/hugetlbpage.c
> index 0b9f7a6dad93..55d1d15ea618 100644
> --- a/arch/x86/mm/hugetlbpage.c
> +++ b/arch/x86/mm/hugetlbpage.c
> @@ -152,7 +152,12 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>  #ifndef CONFIG_HIGHMEM
>  static void clear_contig_region(struct page *page, unsigned int npages)
>  {
> +	/*
> +	 * We might be clearing a large region. Allow rescheduling.
> +	 */
> +	allow_resched();
>  	clear_pages(page_address(page), npages);
> +	disallow_resched();
>  }

Why is this in clear_contig_region() and not clear_pages() ? Any other
clear_pages() user will have the same problems no?
