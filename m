Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764E27B5737
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238168AbjJBPp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238157AbjJBPp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:45:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8665B3
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 08:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3aFLeSG9X6alvJD9LfWKuaxnd6GsDmKMa7pc0W8gnlY=; b=LXdbomvWgna9Io0KYiYpo0Fms8
        XQjWGgCsOu4Pd3pi8aniUZfvPyudIId1EhaOJOw8mXLxQsVyY/DPoquQQapu0pqQXVGlbc+/09ixl
        oV6FcDYjovQRVrs6zylTv7EjyrX1Yn9gAL8/nSsTHbTYkonRkfYE6WpSHJRk1mD/JceYNocjydGJq
        ph/YpEo9Xu9lGzjKP6G3LwivkC1f+ui5KZmKml44EBwA+giIarWuzJvhGfImM6ZsZ0JJI1L21hleY
        MTmXO7oFI8sdbumvjBze+89aKJt/ELcCjsSU8EEZHFG3SktM/gE4a0YxRp+bE14YSkUIW4754mJSD
        qvwZ+GlA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qnL72-009qnN-59; Mon, 02 Oct 2023 15:45:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id CD313300454; Mon,  2 Oct 2023 17:45:35 +0200 (CEST)
Date:   Mon, 2 Oct 2023 17:45:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com,
        Sandipan Das <sandipan.das@amd.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [RESEND PATCH V3 1/6] perf: Add branch stack extra
Message-ID: <20231002154535.GB35785@noisy.programming.kicks-ass.net>
References: <20230911154822.2559213-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911154822.2559213-1-kan.liang@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 08:48:17AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Currently, the additional information of a branch entry is stored in a
> u64 space. With more and more information added, the space is running
> out. For example, the information of occurrences of events will be added
> for each branch.
> 
> Add a new branch sample type, PERF_SAMPLE_BRANCH_EXTRA, to indicate
> whether to support an extra space.
> 
> Two places were suggested to append the extra space.
> https://lore.kernel.org/lkml/20230802215814.GH231007@hirez.programming.kicks-ass.net/
> One place is right after the flags of each branch entry. It changes the
> existing struct perf_branch_entry. In the later Intel-specific
> implementation, two separate spaces have to be created in the
> struct cpu_hw_events to store different branch entry structures. That
> duplicates space.

Well, something like so:

-       struct perf_branch_entry        lbr_entries[MAX_LBR_ENTRIES];
+
+       union {
+               struct perf_branch_entry        lbr_entries[MAX_LBR_ENTRIES];
+               struct perf_branch_entry_ext    lbr_entries_ext[MAX_LBR_ENTRIES];
+       };

would just do... you just have to be really careful to consistently pick
the right one.

Something that might help would be to do make perf_branch_stack::entries
a 'void *' and use:

struct perf_branch_entry_ext *
perf_get_branch_entry(struct perf_sample_data *data, int idx)
{
	if (data->sample_flags & PERF_SAMPLE_BRANCH_EXTRA)
		return (struct perf_branch_entry_ext *)data->br_stack->entries + idx;
	
	return (struct perf_branch_entry *)data->br_stack->entries + idx;
}

> The other place is right after the entire struct perf_branch_stack.
> Only adding the new extra space in the struct cpu_hw_event is necessary.
> The disadvantage is that the pointer of the extra space has to be
> recorded. The common interface perf_sample_save_brstack() has to be
> updated as well.

Right.. probably easier.

> The latter requires less space and is much straight forward. It is
> implemented in the patch.

Same amount of space either way around. 'n*x+n*y == n*(x+y)' and all that.

> Also, add a new branch sample type, PERF_SAMPLE_BRANCH_EVT_CNTRS, to
> indicate whether include occurrences of events in branch info. The
> information will be stored in the extra space.

This... why do we need two flags?

Also, I can't find this in the SDM, how wide are these counter deltas?
ISTR they're saturating, but not how wide they are.


