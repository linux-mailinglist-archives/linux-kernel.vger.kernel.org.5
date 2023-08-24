Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54AFB787259
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 16:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241826AbjHXOxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 10:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241810AbjHXOwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:52:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB67E19AD;
        Thu, 24 Aug 2023 07:52:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59A6866EAB;
        Thu, 24 Aug 2023 14:52:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69657C433C8;
        Thu, 24 Aug 2023 14:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692888748;
        bh=be9S20F26UBLGXvg5MoMfSeQ2U5uvkDtL1GKsTTbqZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iUwNCS80mj+iVZGFqG7u6DEYz0TZJjBNBHxJI0jkvvovZipVwp28rL+DXoPS21AyX
         aqm82FCka3HEYSbm1fDyyEhmoN5/E1a/DrsfE3fJwC2SmMVwCjr66kGlMk2ZskF9zn
         F4T1JJZgPTTc0QOQ3TnecmDBZHEQQS/zArCTyYBQCZ8+i70rDdHHrFbDxBYOl6n8GC
         9JrxUzu3NYwVY8yVnvzFLEtEtaOSjCq8pCqNP/J/2w3vSFTB4exrB9/PImarMYL17c
         P5NYL+ZfHfdk0Y/+5ADJ9RuN3xGWRysPz4jDs7i35p94y1RLOIN6WC1VJt2Ywd3385
         hC2SMDcYJufNw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 32DB440722; Thu, 24 Aug 2023 11:52:26 -0300 (-03)
Date:   Thu, 24 Aug 2023 11:52:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Rob Herring <robh@kernel.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/18] Lazily load PMU data
Message-ID: <ZOduqlhnP6+HNSUl@kernel.org>
References: <20230824041330.266337-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824041330.266337-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 23, 2023 at 09:13:12PM -0700, Ian Rogers escreveu:
> Lazily load PMU data both from sysfs and json files. Reorganize
> json data to be more PMU oriented to facilitate this, for
> example, json data is now sorted into arrays for their PMU.
> 
> In refactoring the code some changes were made to get rid of maximum
> encoding sizes for events (256 bytes), with input files being directly
> passed to the lex generated code. There is also a small event parse
> error message improvement.
> 
> Some results from an Intel tigerlake laptop running Debian:
> 
> Binary size reduction of 5.3% or 552,864 bytes because the PMU
> name no longer appears in the string or desc field.
> 
> stat -e cpu/cycles/ minor faults reduced from 1733 to 1667, open calls reduced
> from 171 to 94.
> 
> stat default minor faults reduced from 1805 to 1717, open calls reduced
> from 654 to 343.
> 
> Average PMU scanning reduced from 4720.641usec to 2927.293usec.
> Average core PMU scanning reduced from 1004.658usec to 232.668usec
> (4.3x faster).
> 
> v2: Add error path for failing strdup when allocating a format,
>     suggested by Arnaldo. Rebased on top of tmp.perf-tools-next
>     removing 8 patches. Added "perf jevents: Don't append Unit to
>     desc" to save yet more encoding json event space.

So this is failing here:

[acme@quaco ~]$ perf test 10
 10: PMU events                                 :
 10.1: PMU event table sanity                           : FAILED!
 10.2: PMU event map aliases                            : FAILED!
 10.3: Parsing of PMU event table metrics               : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs: Ok
 10.5: Parsing of metric thresholds with fake PMUs      : Ok
[acme@quaco ~]$

[root@quaco ~]# grep -m1 "model name" /proc/cpuinfo
model name	: Intel(R) Core(TM) i7-8650U CPU @ 1.90GHz
[root@quaco ~]# 


[root@quaco ~]# perf test -vv -F 10 |& head -40
 10: PMU events                                                      :
 10.1: PMU event table sanity                                        :
--- start ---
testing event table bp_l1_btb_correct: pass
testing event table bp_l2_btb_correct: pass
testing event table dispatch_blocked.any: pass
testing event table eist_trans: pass
testing event table l3_cache_rd: pass
testing event table segment_reg_loads.any: pass
testing event e1 uncore_hisi_ddrc.flux_wcmd: mismatched desc, DDRC write commands vs DDRC write commands. Unit: hisi_sccl,ddrc


Strange:

        if (!is_same(e1->desc, e2->desc)) {
                pr_debug2("testing event e1 %s: mismatched desc, %s vs %s\n",
                          e1->name, e1->desc, e2->desc);
                return -1;
        }

Adding "" around those descs:

testing event e1 uncore_hisi_ddrc.flux_wcmd: mismatched desc, "DDRC write commands" vs "DDRC write commands. Unit: hisi_sccl,ddrc"

I see, its the last patch, removing it the tests passes, please take a
look at tmp.perf-tools-next

- Arnaldo



---- end ----
PMU events subtest 1: FAILED!
 10.2: PMU event map aliases                                         :
--- start ---
Using CPUID GenuineIntel-6-8E-A
testing aliases core PMU cpu: matched event bp_l1_btb_correct
testing aliases core PMU cpu: matched event bp_l2_btb_correct
testing aliases core PMU cpu: matched event segment_reg_loads.any
testing aliases core PMU cpu: matched event dispatch_blocked.any
testing aliases core PMU cpu: matched event eist_trans
testing aliases core PMU cpu: matched event l3_cache_rd
testing core PMU cpu aliases: pass
testing aliases PMU hisi_sccl1_ddrc2: mismatched desc, DDRC write commands vs DDRC write commands. Unit: hisi_sccl,ddrc
testing aliases uncore PMU hisi_sccl1_ddrc2: could not match alias uncore_hisi_ddrc.flux_wcmd
---- end ----
PMU events subtest 2: FAILED!
 10.3: Parsing of PMU event table metrics                            :
--- start ---
Found metric 'CPI'
metric expr 1 / IPC for CPI
parsing metric: 1 / IPC
metric expr inst_retired.any / cpu_clk_unhalted.thread for IPC
parsing metric: inst_retired.any / cpu_clk_unhalted.thread
found event inst_retired.any
found event cpu_clk_unhalted.thread
Parsing metric events '{inst_retired.any/metric-id=inst_retired.any/,cpu_clk_unhalted.thread/metric-id=cpu_clk_unhalted.thread/}:W'
Attempting to add event pmu 'inst_retired.any' with '(null),' that may result in non-fatal errors
After aliases, add event pmu 'inst_retired.any' with '(null),' that may result in non-fatal errors
Attempting to add event pmu 'cpu_clk_unhalted.thread' with '(null),' that may result in non-fatal errors
After aliases, add event pmu 'cpu_clk_unhalted.thread' with '(null),' that may result in non-fatal errors
[root@quaco ~]#

Trying on a AMD 5950x:

[root@five ~]# perf test -F -vv 10 |& head -40
 10: PMU events                                                      :
 10.1: PMU event table sanity                                        :
--- start ---
testing event table bp_l1_btb_correct: pass
testing event table bp_l2_btb_correct: pass
testing event table dispatch_blocked.any: pass
testing event table eist_trans: pass
testing event table l3_cache_rd: pass
testing event table segment_reg_loads.any: pass
testing event e1 uncore_hisi_ddrc.flux_wcmd: mismatched desc, DDRC write commands vs DDRC write commands. Unit: hisi_sccl,ddrc
---- end ----
PMU events subtest 1: FAILED!
 10.2: PMU event map aliases                                         :
--- start ---
Using CPUID AuthenticAMD-25-21-0
testing aliases core PMU cpu: matched event bp_l1_btb_correct
testing aliases core PMU cpu: matched event bp_l2_btb_correct
testing aliases core PMU cpu: matched event segment_reg_loads.any
testing aliases core PMU cpu: matched event dispatch_blocked.any
testing aliases core PMU cpu: matched event eist_trans
testing aliases core PMU cpu: matched event l3_cache_rd
testing core PMU cpu aliases: pass
testing aliases PMU hisi_sccl1_ddrc2: mismatched desc, DDRC write commands vs DDRC write commands. Unit: hisi_sccl,ddrc
testing aliases uncore PMU hisi_sccl1_ddrc2: could not match alias uncore_hisi_ddrc.flux_wcmd
---- end ----
PMU events subtest 2: FAILED!
 10.3: Parsing of PMU event table metrics                            :
--- start ---
Found metric 'CPI'
metric expr 1 / IPC for CPI
parsing metric: 1 / IPC
metric expr inst_retired.any / cpu_clk_unhalted.thread for IPC
parsing metric: inst_retired.any / cpu_clk_unhalted.thread
found event inst_retired.any
found event cpu_clk_unhalted.thread
Parsing metric events '{inst_retired.any/metric-id=inst_retired.any/,cpu_clk_unhalted.thread/metric-id=cpu_clk_unhalted.thread/}:W'
Attempting to add event pmu 'inst_retired.any' with '(null),' that may result in non-fatal errors
After aliases, add event pmu 'inst_retired.any' with '(null),' that may result in non-fatal errors
Attempting to add event pmu 'cpu_clk_unhalted.thread' with '(null),' that may result in non-fatal errors
After aliases, add event pmu 'cpu_clk_unhalted.thread' with '(null),' that may result in non-fatal errors
[root@five ~]#
