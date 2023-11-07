Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C727E4357
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbjKGPVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235130AbjKGPVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:21:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699D93C31
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 07:11:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E9CC433C8;
        Tue,  7 Nov 2023 15:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699369913;
        bh=/5HohiLai8R6jOStIHsi8HKBDs26PKJTsZuI+N2dvik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C95TnDoonVzBZ7VLAx82s3qWtumWPFE9763QPgWxM+TCUqdrNmZA4OUt5uS9tc70Q
         ENhxuPbnJeLpGF2dZPqQJD4UE2+ulxUHWGjYQe2hmsDR54WS3PuZtKXQVeoOBgiRqR
         kTJC4rIZd6oRdE8sEDqIExUTFcvDYUT20vMM4ZjdeecG8K443sYISlUvlIAN4C+Tiy
         pk8H3exUT/DYeADa6HQJN/gYQrsb1ZSdZf9v80p7M/12ALZrJvhB5xK70i4VUlHV5T
         Ul3mUugPw9vcJI3uNpe+szH5+ksGm761hLZqCUtGKg+TVdXaKKNmPDso9L3IuGnG4Z
         BeozLVYhWJdqA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1D2CA4035D; Tue,  7 Nov 2023 12:11:50 -0300 (-03)
Date:   Tue, 7 Nov 2023 12:11:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com
Subject: Re: [PATCH V5 2/8] perf/x86: Add PERF_X86_EVENT_NEEDS_BRANCH_STACK
 flag
Message-ID: <ZUpTtoCzJFHhnSdh@kernel.org>
References: <20231025201626.3000228-1-kan.liang@linux.intel.com>
 <20231025201626.3000228-2-kan.liang@linux.intel.com>
 <ZUlWuROfYcYJlRn4@kernel.org>
 <fb1ebf48-ac2f-499a-b480-ba8474b12200@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb1ebf48-ac2f-499a-b480-ba8474b12200@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 06, 2023 at 04:19:13PM -0500, Liang, Kan escreveu:
> 
> 
> On 2023-11-06 4:12 p.m., Arnaldo Carvalho de Melo wrote:
> > Em Wed, Oct 25, 2023 at 01:16:20PM -0700, kan.liang@linux.intel.com escreveu:
> >> From: Kan Liang <kan.liang@linux.intel.com>
> >>
> >> Currently, branch_sample_type !=0 is used to check whether a branch
> >> stack setup is required. But it doesn't check the sample type,
> >> unnecessary branch stack setup may be done for a counting event. E.g.,
> >> perf record -e "{branch-instructions,branch-misses}:S" -j any
> >> Also, the event only with the new PERF_SAMPLE_BRANCH_COUNTERS branch
> >> sample type may not require a branch stack setup either.
> >>
> >> Add a new flag NEEDS_BRANCH_STACK to indicate whether the event requires
> >> a branch stack setup. Replace the needs_branch_stack() by checking the
> >> new flag.
> >>
> >> The counting event check is implemented here. The later patch will take
> >> the new PERF_SAMPLE_BRANCH_COUNTERS into account.
> >>
> >> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> >> ---
> >>
> >> No changes since V4
> > 
> > So I saw this on tip/perf/urgent, I'm picking the tools bits then.
> 
> Thanks Arnaldo.
> 
> Ian has already reviewed the tool parts.
> 
> But I still owe a test case for the feature. I will post a patch later.
> https://lore.kernel.org/lkml/acbb895a-475e-4679-98fc-6b90c05a00af@linux.intel.com/

I saw Ian's suggestion, and agree with it, we need to pair new features
with regression tests in 'perf test', thanks for working on it!

- Arnaldo
