Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80C47E04BB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 15:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377876AbjKCOaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 10:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377836AbjKCOaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 10:30:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB808D4D;
        Fri,  3 Nov 2023 07:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TutFGcTUbbtZZeHXA63UR/SNK49qiEmJWb/gtgYEieI=; b=FbyJVXsJzK7XKpDQhQSH2f5bbB
        EgnQqqd9A9MFrtDCw2kOiVC1DIyBIwkyxlhwtCFXD4kA29mLsIB2wnynfa+ilpkl4TDa+mlRCGUQe
        bWhB9NrNZ6N8a2BJoYER/YL5yFnOOOynx4Ntax3dLv5EjBGKpDj2bljHRIgrQ+yhvyLmlCKvwtpD5
        txs3wPs/dADpxkPkUXf9pmOa/WA3wpJwY3mFWqRJarMd6nYaQf+TRGQvYWVUM5qFNc+hNSK3qeSqU
        Xor8VEwOvcszB2K2Ci/7a62ltupYnMXN6gdoUfddkshXy82ilrp/FDK4sJRxXmk1Fx8uhoQ2e0Yne
        T6r8e5EA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qyvBp-005rhq-Os; Fri, 03 Nov 2023 14:30:25 +0000
Date:   Fri, 3 Nov 2023 14:30:25 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH rfc 00/18] mm: convert to use folio mm counter
Message-ID: <ZUUEAbs6/GlZmV+Q@casper.infradead.org>
References: <20231103140119.2306578-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103140119.2306578-1-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 10:01:01PM +0800, Kefeng Wang wrote:
> Convert mm counter page functions to folio ones.
> 
>   mm_counter()       ->	mm_counter_folio()
>   mm_counter_file()  ->	mm_counter_file_folio()
> 
> Maybe it's better to rename folio mm counter function back to mm_counter()
> and mm_counter_file() after all conversion?

I deliberately didn't do this because it's mostly churn.
Once all callers of mm_counter() and mm_counter_file() have been
converted to use folios, we can do one big patch to convert all
callers to pass a folio instead of a page.
