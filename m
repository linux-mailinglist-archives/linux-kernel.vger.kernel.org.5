Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F61179C451
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 05:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238073AbjILDmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 23:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237526AbjILDlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 23:41:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C84A44B9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 20:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UgGnk0nsO+8GtcffK/vuEOIa96+K8Xy5NhS6BCauH0g=; b=W00Aax54/nupH6+AnbpFTX1x6E
        0fYuK85Yc9Fe2UirATONwOB73vUNW3NXPvmSKoExpnK7HZhbU4KDZ8ydCfDCd07Qa1ad0ZNrXQLky
        x6oER7s9M5bEPraxaLfkaNPbZAnhZrGgeNsIONaRyXXevdF3jgoKw9h8IevzvNd5JHwYSVZe6nHUk
        uwEYDSOOoWGmtjNNh+0LCoZGzVKoIbLske+fjZd4Vg89cSENwHq8l06dpx1tKwn7KxJhp8wGh6Cfg
        qCg6awZOt65Ass7iTpkQo0VDahA4PWH10QFNGCcEPHM70uJSO2AFEABZSd/951Nb1qV9BbGmHdSve
        cHwma6OA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qfu3W-004oIK-Lh; Tue, 12 Sep 2023 03:27:14 +0000
Date:   Tue, 12 Sep 2023 04:27:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, mgorman@suse.de,
        tglx@linutronix.de, jon.grimm@amd.com, bharata@amd.com,
        raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
Message-ID: <ZP/akhSImBVxff0k@casper.infradead.org>
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
 <20230830184958.2333078-8-ankur.a.arora@oracle.com>
 <20230908070258.GA19320@noisy.programming.kicks-ass.net>
 <87zg1v3xxh.fsf@oracle.com>
 <CAHk-=whagwHrDxhjUVrRPhq78YC195KrSGzuC722-4MvAz40pw@mail.gmail.com>
 <87edj64rj1.fsf@oracle.com>
 <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
 <20230911124856.453fba22@gandalf.local.home>
 <CAHk-=whpYjm_AizQij6XEfTd7xvGjrVCx5gzHcHm=2Xijt+Kyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whpYjm_AizQij6XEfTd7xvGjrVCx5gzHcHm=2Xijt+Kyg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 01:50:53PM -0700, Linus Torvalds wrote:
> Another example of this this is just plain read/write. It's not a
> problem in practice right now, because large pages are effectively
> never used.
> 
> But just imagine what happens once filemap_read() actually does big folios?
> 
> Do you really want this code:
> 
>         copied = copy_folio_to_iter(folio, offset, bytes, iter);
> 
> to forever use the artificial chunking it does now?
> 
> And yes, right now it will still do things in one-page chunks in
> copy_page_to_iter(). It doesn't even have cond_resched() - it's
> currently in the caller, in filemap_read().

Ah, um.  If you take a look in fs/iomap/buffered-io.c, you'll
see ...

iomap_write_iter:
        size_t chunk = PAGE_SIZE << MAX_PAGECACHE_ORDER;
                struct folio *folio;
                bytes = min(chunk - offset, iov_iter_count(i));
                if (unlikely(fault_in_iov_iter_readable(i, bytes) == bytes)) {
                copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);

So we do still cond_resched(), but we might go up to PMD_SIZE
between calls.  This is new code in 6.6 so it hasn't seen use by too
many users yet, but it's certainly bigger than the 16 pages used by
copy_chunked_from_user().  I honestly hadn't thought about preemption
latency.
