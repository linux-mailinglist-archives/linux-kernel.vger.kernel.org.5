Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04170809253
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 21:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjLGUbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 15:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235268AbjLGUbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 15:31:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4127E172C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 12:31:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D3A8C433C8;
        Thu,  7 Dec 2023 20:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701981112;
        bh=Pz3fIHmphmYWdAiauPzUciG6N7OeXMTXmvPgnZGRLHo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gW8hi2v+aBgORmpOJC4OZrDlEYEBRWIJaEsNdRzVlr/r71a/QL+0uDWmtUtqxAjsr
         ++j2JJ9IwUvDeDbjj7hxMrb2v1eNS891YuE5Ps4DlFLK+afg7KuMmydhPr7xl8PzfF
         uAAJFUfxREBKm2YYLKdDa7Aog+fLbVrSu8VlX7/EDx5dH8RRIv3+ikaTY1MFGqmbtZ
         WqjGJtkYTzlto25xpRTiuayz7wUNJ/oWgx61MfthqgDYOd+EW+9x2tYRYxWlpaHEou
         uruOpxblZAlqCIC0JJicyWj7tM4xh3rV077ibP6CEv0Rm7XojSVU+9K1mOFF//5aNm
         VdvRO+5BiKJxw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6A9F2403EF; Thu,  7 Dec 2023 17:31:49 -0300 (-03)
Date:   Thu, 7 Dec 2023 17:31:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     kan.liang@linux.intel.com, ravi.bangoria@amd.com
Cc:     irogers@google.com, peterz@infradead.org, mingo@redhat.com,
        namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        john.g.garry@oracle.com, will@kernel.org, james.clark@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org,
        yuhaixin.yhx@linux.alibaba.com, renyu.zj@linux.alibaba.com,
        tmricht@linux.ibm.com, ravi.bangoria@amd.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2 0/5] Clean up perf mem
Message-ID: <ZXIrtcYkvpA8Uwj1@kernel.org>
References: <20231207192338.400336-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207192338.400336-1-kan.liang@linux.intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Dec 07, 2023 at 11:23:33AM -0800, kan.liang@linux.intel.com escreveu:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Changes since V1:
> - Fix strcmp of PMU name checking (Ravi)
> - Fix "/," typo (Ian)
> - Rename several functions with perf_pmu__mem_events prefix. (Ian)
> - Fold the header removal patch into the patch where the cleanups made.
>   (Arnaldo)
> - Add reviewed-by and tested-by from Ian and Ravi

It would be good to have a Tested-by from people working in all the
architectures affectes, like we got from Ravi for AMD, can we get those?

I'm applying it locally for test building, will push to
perf-tools-next/tmp.perf-tools-next for a while, so there is some time
to test.

ARM64 (Leo?) and ppc, for PPC... humm Ravi did it, who could test it now?

- Arnaldo
 
> As discussed in the below thread, the patch set is to clean up perf mem.
> https://lore.kernel.org/lkml/afefab15-cffc-4345-9cf4-c6a4128d4d9c@linux.intel.com/
> 
> Introduce generic functions perf_mem_events__ptr(),
> perf_mem_events__name() ,and is_mem_loads_aux_event() to replace the
> ARCH specific ones.
> Simplify the perf_mem_event__supported().
> 
> Only keeps the ARCH-specific perf_mem_events array in the corresponding
> mem-events.c for each ARCH.
> 
> There is no functional change.
> 
> The patch set touches almost all the ARCHs, Intel, AMD, ARM, Power and
> etc. But I can only test it on two Intel platforms.
> Please give it try, if you have machines with other ARCHs.
> 
> Here are the test results:
> Intel hybrid machine:
> 
> $perf mem record -e list
> ldlat-loads  : available
> ldlat-stores : available
> 
> $perf mem record -e ldlat-loads -v --ldlat 50
> calling: record -e cpu_atom/mem-loads,ldlat=50/P -e cpu_core/mem-loads,ldlat=50/P
> 
> $perf mem record -v
> calling: record -e cpu_atom/mem-loads,ldlat=30/P -e cpu_atom/mem-stores/P -e cpu_core/mem-loads,ldlat=30/P -e cpu_core/mem-stores/P
> 
> $perf mem record -t store -v
> calling: record -e cpu_atom/mem-stores/P -e cpu_core/mem-stores/P
> 
> 
> Intel SPR:
> $perf mem record -e list
> ldlat-loads  : available
> ldlat-stores : available
> 
> $perf mem record -e ldlat-loads -v --ldlat 50
> calling: record -e {cpu/mem-loads-aux/,cpu/mem-loads,ldlat=50/}:P
> 
> $perf mem record -v
> calling: record -e {cpu/mem-loads-aux/,cpu/mem-loads,ldlat=30/}:P -e cpu/mem-stores/P
> 
> $perf mem record -t store -v
> calling: record -e cpu/mem-stores/P
> 
> Kan Liang (5):
>   perf mem: Add mem_events into the supported perf_pmu
>   perf mem: Clean up perf_mem_events__ptr()
>   perf mem: Clean up perf_mem_events__name()
>   perf mem: Clean up perf_mem_event__supported()
>   perf mem: Clean up is_mem_loads_aux_event()
> 
>  tools/perf/arch/arm64/util/mem-events.c   |  36 +----
>  tools/perf/arch/arm64/util/pmu.c          |   6 +
>  tools/perf/arch/powerpc/util/mem-events.c |  13 +-
>  tools/perf/arch/powerpc/util/mem-events.h |   7 +
>  tools/perf/arch/powerpc/util/pmu.c        |  11 ++
>  tools/perf/arch/s390/util/pmu.c           |   3 +
>  tools/perf/arch/x86/util/mem-events.c     |  99 ++----------
>  tools/perf/arch/x86/util/pmu.c            |  11 ++
>  tools/perf/builtin-c2c.c                  |  28 +++-
>  tools/perf/builtin-mem.c                  |  28 +++-
>  tools/perf/util/mem-events.c              | 181 +++++++++++++---------
>  tools/perf/util/mem-events.h              |  15 +-
>  tools/perf/util/pmu.c                     |   4 +-
>  tools/perf/util/pmu.h                     |   7 +
>  14 files changed, 233 insertions(+), 216 deletions(-)
>  create mode 100644 tools/perf/arch/powerpc/util/mem-events.h
>  create mode 100644 tools/perf/arch/powerpc/util/pmu.c
> 
> -- 
> 2.35.1
> 

-- 

- Arnaldo
