Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9625D79879C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 15:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243398AbjIHNKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 09:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjIHNKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 09:10:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D51C19B5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 06:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QRChBe5PZMuw+zPsASEy2dEzmm9n/h3rkYmxC0tWOYs=; b=Hdnr4ID2aydT9hhHxq/HiSr6nU
        bDqb2vDxhqGdqAR+KQMM0w/2ASZoQnHLYp2wKk9Dr1eiiE0xldEpXPAnEVkJ2ld1eLFt7Ey+6pkAO
        UJ4qRm4wQJRhY3UHRXUuhPjgECoUVqXfa+pR2YiVMylpHa3kpyAvSQK2m+vUy3Q69Kgu4UB/B0fxB
        eM3F+a2vlX7pWcgVnFeIn4hLq1UJXLG78tQMD8A44lwv4PHOfbGqPewjG1feq9GN4bIW+gT866lNV
        giXQUgFsNPX6DC44yKe9AFFzttXmqVPT/5aP83Q08/XIo4g/0kn/NqqaURNgRB+BY3YpfLeAKoUOe
        kEG3cBdA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qebFB-000HDw-0T; Fri, 08 Sep 2023 13:09:53 +0000
Date:   Fri, 8 Sep 2023 14:09:52 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, mgorman@suse.de,
        peterz@infradead.org, rostedt@goodmis.org, tglx@linutronix.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v2 3/9] mm/huge_page: cleanup clear_/copy_subpage()
Message-ID: <ZPsdIJn1Ef/3uNpL@casper.infradead.org>
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
 <20230830184958.2333078-4-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830184958.2333078-4-ankur.a.arora@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 11:49:52AM -0700, Ankur Arora wrote:
> @@ -5945,9 +5935,7 @@ static int __clear_huge_page(
>  		/* Process subpages at the end of huge page */
>  		for (i = pages_per_huge_page - 1; i >= 2 * n; i--) {
>  			cond_resched();
> -			ret = process_subpage(addr + i * PAGE_SIZE, i, arg);
> -			if (ret)
> -				return ret;
> +			clear_user_highpage(page + i, addr + i * PAGE_SIZE);

It's possible for a 1GB page to cross a memmap discontiguity.  This
needs to be:

			clear_user_highpage(nth_page(page, i),
					addr + i * PAGE_SIZE);

(similarly in other places)
