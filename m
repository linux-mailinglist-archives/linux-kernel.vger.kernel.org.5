Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F37A7B6660
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 12:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjJCK1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 06:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjJCK1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 06:27:53 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151B3B7
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 03:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6qb4WZ92U8yIFE7GYSvrq4aS/hQetxiLq3tL2nxTeg0=; b=gkvUCEwWmEDjsOagl1Wah+jnga
        vuOazKXCqy9IiKzCgpJlZVnqcbONeyv47g+baPnwDFvwIYrR0Lpwnup6QSSmNU+MX4IQWMLHRs3Gf
        nUPdZHoqwYWkM8OYKyOBrxTpHQrk8R2zqSW2zz19PtlluqtKS74Wu8lJUobKDBqzWzjmRQOPW7TXR
        lv6P+TUdrnGZkOSyc3wPrrz9+SBgpiWmyMPbdwDFIpApUui8qjhHWxV3VCOOBnSN7N5PWu/Pc7jX1
        kjm7SYMbByAeTe57AwdJCCWatIX9m40kzMKrDY7K/s1IhMdPvmrKFhNW7B28AcXM2imUrN+LiWvhi
        8vDEk57Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qnccm-009oOa-1p;
        Tue, 03 Oct 2023 10:27:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 822BC300348; Tue,  3 Oct 2023 12:27:33 +0200 (CEST)
Date:   Tue, 3 Oct 2023 12:27:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com,
        Sandipan Das <sandipan.das@amd.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [RESEND PATCH V3 1/6] perf: Add branch stack extra
Message-ID: <20231003102733.GC1539@noisy.programming.kicks-ass.net>
References: <20230911154822.2559213-1-kan.liang@linux.intel.com>
 <20231002154535.GB35785@noisy.programming.kicks-ass.net>
 <ce16c6c1-9bdc-35e2-fe85-155bd7edbaa4@linux.intel.com>
 <20231002213752.GB1539@noisy.programming.kicks-ass.net>
 <ed169d4d-76d5-c134-c685-ad3d812028be@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed169d4d-76d5-c134-c685-ad3d812028be@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 08:57:57PM -0400, Liang, Kan wrote:

> > Did I already say that the ISE document raises more questions than it
> > provides answers?
> 
> Yes. Would an improved CPUID enumeration can address the questions? For
> example, the CPUID enumeration can give the maximum number of counters
> and supported width? I think we can discuss it with the architect.

So.. no. Suppose another arch goes and does the same, but with a
different number and width of counters. They won't have CPUID.

I'm thinking we should do something like expose branch_counter_nr and
branch_counter_width in the sysfs node, and then rename this extra field
to counters.

Then userspace can do something like:

	for (i = 0; i < branch_counter_nr; i++) {
		counter[i] = counters & ((1 << branch_counter_width) - 1);
		counters >>= branch_counter_width;
	}

to extract the actual counter values.


So then we end up with:

         *      { u64                   nr;
         *        { u64 hw_idx; } && PERF_SAMPLE_BRANCH_HW_INDEX
         *        { u64 from, to, flags } lbr[nr];
+        *        { u64 counters; } cntr[nr] && PERF_SAMPLE_BRANCH_COUNTERS
         *      } && PERF_SAMPLE_BRANCH_STACK

Have it explicitly named counters, have only the one flag and have sysfs
files describe how to decode it.

Then for this Intel thing we have 4 counters of 2 bits, but if someone
else were to do something different (both Power and ARM64 have this
branch stack stuff now) they can describe it.

It is a bit wasteful on bits... but at least its clear I suppose.
