Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8815F785CC0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237354AbjHWP4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235629AbjHWP4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:56:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B69E5F;
        Wed, 23 Aug 2023 08:56:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B56E61593;
        Wed, 23 Aug 2023 15:56:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B302C433C8;
        Wed, 23 Aug 2023 15:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692806192;
        bh=7gJ7d9y1sm6DjvQXX2n3/E/aVkpRumzZXdYTZT5fhL0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FbCLrkv3ZJ61R3+6pkRxoC/KgZ08r4IgXUsgiuYSB0U69lRQfDEop3d5foqyryTJq
         duGpE+TBMZwSviWCr9Samz0R0NdZBDUaDnOzBW3St38sqLg2m69wWTjFAY6VMT17pf
         NsfsM6CQQm9ia2EVCcSOmtN0/eU1ut5boQB3QlrpbXhmr3IOvCBI5dSJuBoNy+lLnO
         aZcHZFJtD/++zE9aQg5JYy34A/SsSuTs2MJSOxZD0t3NUmw4gYi5VNS7B6uWz8eCIa
         k3HnKXBMcOpI4YRBN+kbLqtoVZt1rrIgE5OjUpEKzWSdisTNprkzhQnRt8LY5CgeA6
         rmHtZv0nsKwaw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6F18240722; Wed, 23 Aug 2023 12:56:29 -0300 (-03)
Date:   Wed, 23 Aug 2023 12:56:29 -0300
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
Subject: Re: [PATCH v1 00/25] Lazily load PMU data
Message-ID: <ZOYsLZi44G84IWFk@kernel.org>
References: <20230823080828.1460376-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823080828.1460376-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 23, 2023 at 01:08:03AM -0700, Ian Rogers escreveu:
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
> Binary size reduction of 1.4% or 143,264 bytes because the PMU
> name no longer appears in the string.
> 
> stat -e cpu/cycles/ minor faults reduced from 1733 to 1667, open calls reduced
> from 171 to 94.
> 
> stat default minor faults reduced from 1085 to 1727, open calls reduced
> from 654 to 343.
> 
> Average PMU scanning reduced from 4720.641usec to 2927.293usec.
> Average core PMU scanning reduced from 1004.658usec to 232.668usec
> (4.3x faster).

I'm now chasing this one when building it on ubuntu arm64

  CC      /tmp/build/perf/util/env.o
arch/arm64/util/../../arm/util/cs-etm.c: In function 'cs_etm_validate_context_id':
arch/arm64/util/../../arm/util/cs-etm.c:82:26: error: passing argument 1 of 'perf_pmu__format_bits' from incompatible pointer type [-Werror=incompatible-pointer-types]
   (perf_pmu__format_bits(&cs_etm_pmu->format, "contextid") |
                          ^
In file included from arch/arm64/util/../../arm/util/../../../util/header.h:13:0,
                 from arch/arm64/util/../../arm/util/../../../util/session.h:7,
                 from arch/arm64/util/../../arm/util/cs-etm.c:31:
arch/arm64/util/../../arm/util/../../../util/pmu.h:224:7: note: expected 'struct perf_pmu *' but argument is of type 'struct list_head *'
 __u64 perf_pmu__format_bits(struct perf_pmu *pmu, const char *name);
       ^~~~~~~~~~~~~~~~~~~~~
arch/arm64/util/../../arm/util/cs-etm.c:83:26: error: passing argument 1 of 'perf_pmu__format_bits' from incompatible pointer type [-Werror=incompatible-pointer-types]
    perf_pmu__format_bits(&cs_etm_pmu->format, "contextid1") |
                          ^
In file included from arch/arm64/util/../../arm/util/../../../util/header.h:13:0,
                 from arch/arm64/util/../../arm/util/../../../util/session.h:7,
                 from arch/arm64/util/../../arm/util/cs-etm.c:31:
arch/arm64/util/../../arm/util/../../../util/pmu.h:224:7: note: expected 'struct perf_pmu *' but argument is of type 'struct list_head *'
 __u64 perf_pmu__format_bits(struct perf_pmu *pmu, const char *name);
       ^~~~~~~~~~~~~~~~~~~~~
arch/arm64/util/../../arm/util/cs-etm.c:84:26: error: passing argument 1 of 'perf_pmu__format_bits' from incompatible pointer type [-Werror=incompatible-pointer-types]
    perf_pmu__format_bits(&cs_etm_pmu->format, "contextid2"));
                          ^
In file included from arch/arm64/util/../../arm/util/../../../util/header.h:13:0,
                 from arch/arm64/util/../../arm/util/../../../util/session.h:7,
                 from arch/arm64/util/../../arm/util/cs-etm.c:31:
arch/arm64/util/../../arm/util/../../../util/pmu.h:224:7: note: expected 'struct perf_pmu *' but argument is of type 'struct list_head *'
 __u64 perf_pmu__format_bits(struct perf_pmu *pmu, const char *name);
       ^~~~~~~~~~~~~~~~~~~~~
arch/arm64/util/../../arm/util/cs-etm.c:109:28: error: passing argument 1 of 'perf_pmu__format_bits' from incompatible pointer type [-Werror=incompatible-pointer-types]
      perf_pmu__format_bits(&cs_etm_pmu->format, "contextid1")) {
                            ^
In file included from arch/arm64/util/../../arm/util/../../../util/header.h:13:0,
                 from arch/arm64/util/../../arm/util/../../../util/session.h:7,
                 from arch/arm64/util/../../arm/util/cs-etm.c:31:
arch/arm64/util/../../arm/util/../../../util/pmu.h:224:7: note: expected 'struct perf_pmu *' but argument is of type 'struct list_head *'
 __u64 perf_pmu__format_bits(struct perf_pmu *pmu, const char *name);
       ^~~~~~~~~~~~~~~~~~~~~
arch/arm64/util/../../arm/util/cs-etm.c:125:28: error: passing argument 1 of 'perf_pmu__format_bits' from incompatible pointer type [-Werror=incompatible-pointer-types]
      perf_pmu__format_bits(&cs_etm_pmu->format, "contextid2")) {
                            ^
In file included from arch/arm64/util/../../arm/util/../../../util/header.h:13:0,
                 from arch/arm64/util/../../arm/util/../../../util/session.h:7,
                 from arch/arm64/util/../../arm/util/cs-etm.c:31:
arch/arm64/util/../../arm/util/../../../util/pmu.h:224:7: note: expected 'struct perf_pmu *' but argument is of type 'struct list_head *'
 __u64 perf_pmu__format_bits(struct perf_pmu *pmu, const char *name);
       ^~~~~~~~~~~~~~~~~~~~~
  CC      /tmp/build/perf/bench/epoll-ctl.o
arch/arm64/util/../../arm/util/cs-etm.c: In function 'cs_etm_validate_timestamp':
arch/arm64/util/../../arm/util/cs-etm.c:154:30: error: passing argument 1 of 'perf_pmu__format_bits' from incompatible pointer type [-Werror=incompatible-pointer-types]
        perf_pmu__format_bits(&cs_etm_pmu->format, "timestamp")))
                              ^
In file included from arch/arm64/util/../../arm/util/../../../util/header.h:13:0,
                 from arch/arm64/util/../../arm/util/../../../util/session.h:7,
                 from arch/arm64/util/../../arm/util/cs-etm.c:31:
arch/arm64/util/../../arm/util/../../../util/pmu.h:224:7: note: expected 'struct perf_pmu *' but argument is of type 'struct list_head *'
 __u64 perf_pmu__format_bits(struct perf_pmu *pmu, const char *name);
       ^~~~~~~~~~~~~~~~~~~~~
  CC      /tmp/build/perf/tests/vmlinux-kallsyms.o
  CC      /tmp/build/perf/arch/arm64/util/mem-events.o
  CC      /tmp/build/perf/bench/synthesize.o
  CC      /tmp/build/perf/tests/perf-record.o
  CC      /tmp/build/perf/bench/kallsyms-parse.o
arch/arm64/util/arm-spe.c: In function 'arm_spe_recording_options':
arch/arm64/util/arm-spe.c:233:30: error: passing argument 1 of 'perf_pmu__format_bits' from incompatible pointer type [-Werror=incompatible-pointer-types]
  bit = perf_pmu__format_bits(&arm_spe_pmu->format, "pa_enable");
                              ^
In file included from arch/arm64/util/../../../util/header.h:13:0,
                 from arch/arm64/util/../../../util/session.h:7,
                 from arch/arm64/util/arm-spe.c:19:
arch/arm64/util/../../../util/pmu.h:224:7: note: expected 'struct perf_pmu *' but argument is of type 'struct list_head *'
 __u64 perf_pmu__format_bits(struct perf_pmu *pmu, const char *name);
       ^~~~~~~~~~~~~~~~~~~~~
  CC      /tmp/build/perf/bench/find-bit-bench.o
  CC      /tmp/build/perf/tests/evsel-roundtrip-name.o
  CC      /tmp/build/perf/bench/inject-buildid.o
  CC      /tmp/build/perf/util/event.o

