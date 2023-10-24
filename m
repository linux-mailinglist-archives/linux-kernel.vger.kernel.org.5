Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA9D7D5E45
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 00:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344646AbjJXWfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 18:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344557AbjJXWfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 18:35:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A521991;
        Tue, 24 Oct 2023 15:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tdtY+rOfxTbr9drW5NLNeRW9YMJyiKxVA9Zf3q8HibE=; b=ePLGJIvdK78pGMF9dtQv/hD8KY
        H2uxMOBgTglKUg5+JeAfl7KPq/BEnBPSyV+/hOMXvVo+5Bg6oJDS2Ed+gaLkechO+HUF85Rp+Guw4
        kVsByxpUsbn4k8Z7Tfw2Qz3Dfq5UxqwSKN8KOuv9z7+PkLnEUf7vSkEIyWrlVOA2CDXynpn+Soyz6
        hcCm4Y0Zq8B5oTclYAh6eZIYp6SkP6ZHzwecdgvmck1ebyZ+fICYg79naepTJyhWEF+uih/DNq/Uj
        eNXg7icLxIDuULiiV3alDDGfbMAISM+KO4eGEn6mZlCRQ0n47zKIcoTkJdz97j7aRUpZAn3wh7SER
        fLDd17Vg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qvPpE-0054eF-Sx; Tue, 24 Oct 2023 22:24:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 825E630072F; Wed, 25 Oct 2023 00:24:36 +0200 (CEST)
Date:   Wed, 25 Oct 2023 00:24:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org, rafael@kernel.org,
        pavel@ucw.cz, linux-perf-users@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/2] perf/x86/amd: Don't allow pre-emption in
 amd_pmu_lbr_reset()
Message-ID: <20231024222436.GG33965@noisy.programming.kicks-ass.net>
References: <20231023160018.164054-1-mario.limonciello@amd.com>
 <20231023160018.164054-3-mario.limonciello@amd.com>
 <ZTd6BYr17ycdHR2a@gmail.com>
 <ZTf2IxAVPUFq91F4@gmail.com>
 <0022df64-b7f5-43b4-87ed-5df5d47c5c6a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0022df64-b7f5-43b4-87ed-5df5d47c5c6a@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 01:30:59PM -0500, Mario Limonciello wrote:

> In that case - should preemption be disabled for all of x86_pmu_dying_cpu()
> perhaps?
> 
> For good measure x86_pmu_starting_cpu() too?

starting and dying are with IRQs disabled.
