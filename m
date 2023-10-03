Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036B27B6E90
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240596AbjJCQdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240421AbjJCQdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:33:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E78CD3
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 09:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R/ibdb86WTscNhAmgSNZfoPz8ITVLMRdEmg42XxgAA0=; b=EQjBJXUfZ8ykIbmaRrFMsm5r8i
        xd5t8J8YqhRxkBl7m1mp9kagYXoyjtB19yGUiZcdqKY5ARlN+/yKFYoLEqnCa8rx2GXEjF8GOTo5N
        COntVN6+0hUG5WA2pggVnda2SWj6PnhsPX3baD853w0XWAsPaW46mM9mu6ThQjZOzEfTP7o0wcO1l
        xJifW5eG8UfeLNoterHeoynMGS5jI0uUINl0kJP58wb5Y7oUHJduJANp7/tSnLCd0fY58D40ngbkd
        YV96S4fbaUceXKyYns4YyHg3bV1GXHZnuKpKVbdQgJr4LPXyoVziKFrIO5KoqJHixS/BcJ5C4hYaF
        yV9gBRFg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qniKT-00G0yK-1v; Tue, 03 Oct 2023 16:33:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id B6C3E300348; Tue,  3 Oct 2023 18:33:00 +0200 (CEST)
Date:   Tue, 3 Oct 2023 18:33:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>, mingo@redhat.com,
        acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com,
        Sandipan Das <sandipan.das@amd.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [RESEND PATCH V3 1/6] perf: Add branch stack extra
Message-ID: <20231003163300.GF1539@noisy.programming.kicks-ass.net>
References: <20230911154822.2559213-1-kan.liang@linux.intel.com>
 <20231002154535.GB35785@noisy.programming.kicks-ass.net>
 <ce16c6c1-9bdc-35e2-fe85-155bd7edbaa4@linux.intel.com>
 <20231002213752.GB1539@noisy.programming.kicks-ass.net>
 <ed169d4d-76d5-c134-c685-ad3d812028be@linux.intel.com>
 <20231003102733.GC1539@noisy.programming.kicks-ass.net>
 <ZRwuE8LPkwtkjX5C@tassilo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRwuE8LPkwtkjX5C@tassilo>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 08:06:59AM -0700, Andi Kleen wrote:
> > I'm thinking we should do something like expose branch_counter_nr and
> > branch_counter_width in the sysfs node, and then rename this extra field
> > to counters.
> > 
> > Then userspace can do something like:
> > 
> > 	for (i = 0; i < branch_counter_nr; i++) {
> > 		counter[i] = counters & ((1 << branch_counter_width) - 1);
> > 		counters >>= branch_counter_width;
> > 	}
> > 
> > to extract the actual counter values.
> 
> perf script/report won't necessarily have access to the sysfs
> values if they run on a different system
> 
> It would need extra PT style metadata written by perf record to
> perf.data and read by the user tools.
> 
> Seems complicated. It would be better if it just parsed on its own.

Well, you really don't want to repeat the 4,2 thing in every event, that
seems daft (and a waste of space, because how large do we want those
fields to be etc..).

We don't really have a better place for these sorts of things. And yeah,
the PT thing sets precedent here.
