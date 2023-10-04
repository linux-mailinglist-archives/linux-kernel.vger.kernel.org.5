Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B689E7B846C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbjJDQCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbjJDQCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:02:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEA9C1;
        Wed,  4 Oct 2023 09:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vt9FHS60uVNYZyxqQgD7PSsuS36ozJibCdDrRmf3YvA=; b=CVDuSnX4NbFCGeK/vsh0fZGmfc
        UiqWRqKjSAc6JsEBY+xwzaJgtxdJ5FsSydYVeYWU/1r37munTBffivlnYjjFahxEuKHF20Qx0R9Sk
        tXg1kUNQ3/OFmIFPwy0fwNClxT5mYuzde3eKaldXIvh4ylKDEdJCIVAYCCrzxR7mWWFvJPZi6U4oJ
        YUn1AFxUSMsAIobzelZVC/YA5COXCxknkH6z5SO/oUM+ZlCaaRgkYsnGWjINzkGLExSB+9Rl6MCGr
        Henu71ipAZtNTPWnbA/ZVG6BGFDqYOvg7Fph5IolXsaRsJY3Jk+CldbcpfEpwVQyzD76gTeFqOMBT
        Hnpwjnsg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qo4KO-004FRW-Sh; Wed, 04 Oct 2023 16:02:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8B512300392; Wed,  4 Oct 2023 18:02:24 +0200 (CEST)
Date:   Wed, 4 Oct 2023 18:02:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>, stable@vger.kernel.org
Subject: Re: [PATCH] perf/core: Introduce cpuctx->cgrp_ctx_list
Message-ID: <20231004160224.GB6307@noisy.programming.kicks-ass.net>
References: <20231004040844.797044-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004040844.797044-1-namhyung@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 09:08:44PM -0700, Namhyung Kim wrote:

> But after the change, it ended up iterating all pmus/events in the cpu
> context if there's a cgroup event somewhere on the cpu context.
> Unfortunately it includes uncore pmus which have much longer latency to
> control.

Can you describe the problem in more detail please?

We have cgrp as part of the tree key: {cpu, pmu, cgroup, idx},
so it should be possible to find a specific cgroup for a cpu and or skip
to the next cgroup on that cpu in O(log n) time.

> To fix the issue, I restored a linked list equivalent to cgrp_cpuctx_list
> in the perf_cpu_context and link perf_cpu_pmu_contexts that have cgroup
> events only.  Also add new helpers to enable/disable and does ctx sched
> in/out for cgroups.

Adding a list and duplicating the whole scheduling infrastructure seems
'unfortunate' at best.
