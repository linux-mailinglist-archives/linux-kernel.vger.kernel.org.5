Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038847EEFE3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 11:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345794AbjKQKOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 05:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345806AbjKQKOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 05:14:20 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7166C5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 02:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qDDXeLHiSriY7BM8pCXZMV4Qpk9B1bHpijeFpMLolzI=; b=So6OTyMYgVZgAwf0DntpayTPBd
        fGlsxyffbyimbkk+BYAapLXXtxVgN6hfhaSvzt0Y6nQkq7VWiYvQAT2jGuy45YijxYRUW/OoeCQXb
        I/BxIR9yfbs0CK63zoOqyobpQ1Yz98Ocpd91judemQKgYQyv50nkZwullsKQ+epdwmgWdvfuuP9+t
        hj1QDVlQJVuy7wyapvtAjzHeP28HAslQVgI7r+dV68vkJdY2g8Ax8Uq/XIu+HqEYA4Jzbks8KS87r
        EHKDgPDq21hMVFN1a5Zw/EDtdVhOnHUeibJPAjSwCtSOm75NrA5vz8rr4fYs8RaYnnIka0OkJMGSp
        zTIj91SQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r3vr6-007DDR-00;
        Fri, 17 Nov 2023 10:13:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id A635C300478; Fri, 17 Nov 2023 11:13:43 +0100 (CET)
Date:   Fri, 17 Nov 2023 11:13:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Hildenbrand <david@redhat.com>,
        akpm@linux-foundation.org, wangkefeng.wang@huawei.com,
        willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC PATCH] mm: support large folio numa balancing
Message-ID: <20231117101343.GH3818@noisy.programming.kicks-ass.net>
References: <a71a478ce404e93683023dbb7248dd95f11554f4.1699872019.git.baolin.wang@linux.alibaba.com>
 <606d2d7a-d937-4ffe-a6f2-dfe3ae5a0c91@redhat.com>
 <871qctf89m.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <f22001bb-e474-4ddb-8440-2668e6cec000@linux.alibaba.com>
 <87sf57en8n.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20231117100745.fnpijbk4xgmals3k@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117100745.fnpijbk4xgmals3k@techsingularity.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 10:07:45AM +0000, Mel Gorman wrote:

> This leads into a generic problem with large anything with NUMA
> balancing -- false sharing. As it stands, THP can be false shared by
> threads if thread-local data is split within a THP range. In this case,
> the ideal would be the THP is migrated to the hottest node but such
> support doesn't exist. The same applies for folios. If not handled
> properly, a large folio of any type can ping-pong between nodes so just
> migrating because we can is not necessarily a good idea. The patch
> should cover a realistic case why this matters, why splitting the folio
> is not better and supporting data.

Would it make sense to have THP merging conditional on all (most?) pages
having the same node?
