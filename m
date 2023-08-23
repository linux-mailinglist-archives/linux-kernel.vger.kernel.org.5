Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F4086785E52
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 19:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237750AbjHWRL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 13:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237665AbjHWRLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 13:11:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FE7E66;
        Wed, 23 Aug 2023 10:11:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9C4B623EB;
        Wed, 23 Aug 2023 17:11:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B708EC433C7;
        Wed, 23 Aug 2023 17:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692810682;
        bh=LJMJ1SvTLGZZ3fvMcAuL95vkY+dd+cFHsZfZUuFCK+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CDUHjPuunFblXF9CeLztL/MufldPVdQjVwSBR69Cr4IESUWC5vEYPFFgcDWVHifnx
         lZmvPMgojAf4mkQckmDj1IayHvhWESJwbqI0jlyR3MGqlRMRx2AVpLR308Yu3Ud4kF
         i3D2uMlxLU+to8UzjRfoeiKKdPHCyvWMigHFqu4tWjUQY4Y9sEhF5McKX/eVKAkr2g
         IT5aXjEZqr9eCi5rFp+Yz/VeLC70HppNwfRGlvCDzpR5H6Hf0BKFw9wyvGVl3YudbM
         hcmHhTjuyEjnhege/k2vpw20MdGVK2TIyBlhZ+8lkdgWwSHLg73Hi5HRH/RLYhYBl7
         qo2MjQX3BHrAQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A97B340722; Wed, 23 Aug 2023 14:11:19 -0300 (-03)
Date:   Wed, 23 Aug 2023 14:11:19 -0300
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
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 00/25] Lazily load PMU data
Message-ID: <ZOY9t8W1APC/Hurk@kernel.org>
References: <20230823080828.1460376-1-irogers@google.com>
 <ZOYsLZi44G84IWFk@kernel.org>
 <CAP-5=fXYDMo6GgSaLuC3YMNr66yAXLMyZoAOMpdgmMb=xazCOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXYDMo6GgSaLuC3YMNr66yAXLMyZoAOMpdgmMb=xazCOw@mail.gmail.com>
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

Em Wed, Aug 23, 2023 at 09:45:50AM -0700, Ian Rogers escreveu:
> On Wed, Aug 23, 2023, 8:56 AM Arnaldo Carvalho de Melo <acme@kernel.org>
> wrote:
> 
> > Em Wed, Aug 23, 2023 at 01:08:03AM -0700, Ian Rogers escreveu:
> > > Lazily load PMU data both from sysfs and json files. Reorganize
> > > json data to be more PMU oriented to facilitate this, for
> > > example, json data is now sorted into arrays for their PMU.
> > >
> > > In refactoring the code some changes were made to get rid of maximum
> > > encoding sizes for events (256 bytes), with input files being directly
> > > passed to the lex generated code. There is also a small event parse
> > > error message improvement.
> > >
> > > Some results from an Intel tigerlake laptop running Debian:
> > >
> > > Binary size reduction of 1.4% or 143,264 bytes because the PMU
> > > name no longer appears in the string.
> > >
> > > stat -e cpu/cycles/ minor faults reduced from 1733 to 1667, open calls
> > reduced
> > > from 171 to 94.
> > >
> > > stat default minor faults reduced from 1085 to 1727, open calls reduced
> > > from 654 to 343.
> > >
> > > Average PMU scanning reduced from 4720.641usec to 2927.293usec.
> > > Average core PMU scanning reduced from 1004.658usec to 232.668usec
> > > (4.3x faster).
> >
> > I'm now chasing this one when building it on ubuntu arm64
> >
> 
> I'll fix and send a v2.

Its fixed already, I'm pushing it to tmp.perf-tools-next

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 7c51fa182b51dab0..b8d6a953fd7423e1 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -79,9 +79,9 @@ static int cs_etm_validate_context_id(struct auxtrace_record *itr,
 	int err;
 	u32 val;
 	u64 contextid = evsel->core.attr.config &
-		(perf_pmu__format_bits(&cs_etm_pmu->format, "contextid") |
-		 perf_pmu__format_bits(&cs_etm_pmu->format, "contextid1") |
-		 perf_pmu__format_bits(&cs_etm_pmu->format, "contextid2"));
+		(perf_pmu__format_bits(cs_etm_pmu, "contextid") |
+		 perf_pmu__format_bits(cs_etm_pmu, "contextid1") |
+		 perf_pmu__format_bits(cs_etm_pmu, "contextid2"));
 
 	if (!contextid)
 		return 0;
@@ -106,7 +106,7 @@ static int cs_etm_validate_context_id(struct auxtrace_record *itr,
 	}
 
 	if (contextid &
-	    perf_pmu__format_bits(&cs_etm_pmu->format, "contextid1")) {
+	    perf_pmu__format_bits(cs_etm_pmu, "contextid1")) {
 		/*
 		 * TRCIDR2.CIDSIZE, bit [9-5], indicates whether contextID
 		 * tracing is supported:
@@ -122,7 +122,7 @@ static int cs_etm_validate_context_id(struct auxtrace_record *itr,
 	}
 
 	if (contextid &
-	    perf_pmu__format_bits(&cs_etm_pmu->format, "contextid2")) {
+	    perf_pmu__format_bits(cs_etm_pmu, "contextid2")) {
 		/*
 		 * TRCIDR2.VMIDOPT[30:29] != 0 and
 		 * TRCIDR2.VMIDSIZE[14:10] == 0b00100 (32bit virtual contextid)
@@ -151,7 +151,7 @@ static int cs_etm_validate_timestamp(struct auxtrace_record *itr,
 	u32 val;
 
 	if (!(evsel->core.attr.config &
-	      perf_pmu__format_bits(&cs_etm_pmu->format, "timestamp")))
+	      perf_pmu__format_bits(cs_etm_pmu, "timestamp")))
 		return 0;
 
 	if (!cs_etm_is_etmv4(itr, cpu)) {
