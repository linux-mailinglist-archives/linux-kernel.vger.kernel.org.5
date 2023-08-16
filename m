Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7B877E612
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243828AbjHPQL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234312AbjHPQLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:11:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FC4E2;
        Wed, 16 Aug 2023 09:11:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A95264A17;
        Wed, 16 Aug 2023 16:11:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A8FC433C7;
        Wed, 16 Aug 2023 16:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692202283;
        bh=l0J8yDMBc74nmT7gwZGggcXqRVTFJWQG2J54M7XA4UI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BPp0q5QqydyqEXh/RKGyCfuudu+haCSzEXo8u/ua6uYq8RgUjltDdIFycod4kJCTz
         wY3Ml5pwlnFsI9dJgfIhOnzXzK2u6NbP1XZBby9cLzY/IJYiwylv8aJYaPTz0x7F2/
         YFn+D40+ZYw7aP0iMym2qVoBRyQ5raJUMDztW96kPHz/58DnMl4Pqn0BJkJ58zXhTm
         95D2m3ysSi2K+YNtDpffRR66V2DflNFOXqC668ykO5yNWSFZ2XM2EQ7+9cr0shykPk
         GDA15EOwoKnlG7FhLiUEbK5L0y5Of4I6PgYkcQI0h5XDrCX1Zw6fjBHci1NjcRxcpu
         M03bniOi6LiXw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E6BD6404DF; Wed, 16 Aug 2023 13:11:20 -0300 (-03)
Date:   Wed, 16 Aug 2023 13:11:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, irogers@google.com,
        john.g.garry@oracle.com, renyu.zj@linux.alibaba.com,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Haixin Yu <yuhaixin.yhx@linux.alibaba.com>,
        Nick Forrington <nick.forrington@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Sohom Datta <sohomdatta1@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 2/6] perf test: Add a test for the new Arm CPU ID
 comparison behavior
Message-ID: <ZNz1KNaNhct35bzd@kernel.org>
References: <20230816114841.1679234-1-james.clark@arm.com>
 <20230816114841.1679234-3-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230816114841.1679234-3-james.clark@arm.com>
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

Em Wed, Aug 16, 2023 at 12:47:44PM +0100, James Clark escreveu:
> +++ b/tools/perf/arch/arm64/tests/cpuid-match.c
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/compiler.h>
> +
> +#include "arch-tests.h"
> +#include "tests/tests.h"
> +#include "util/header.h"
> +
> +int test__cpuid_match(struct test_suite *test __maybe_unused,
> +			     int subtest __maybe_unused)
> +{
> +	/* midr with no leading zeros matches */
> +	if (strcmp_cpuid_str("0x410fd0c0", "0x00000000410fd0c0"))
> +		return -1;
> +	/* Upper case matches */
> +	if (strcmp_cpuid_str("0x410fd0c0", "0x00000000410FD0C0"))
> +		return -1;
> +	/* r0p0 = r0p0 matches */
> +	if (strcmp_cpuid_str("0x00000000410fd480", "0x00000000410fd480"))
> +		return -1;
> +	/* r0p1 > r0p0 matches */
> +	if (strcmp_cpuid_str("0x00000000410fd480", "0x00000000410fd481"))
> +		return -1;
> +	/* r1p0 > r0p0 matches*/
> +	if (strcmp_cpuid_str("0x00000000410fd480", "0x00000000411fd480"))
> +		return -1;
> +	/* r0p0 < r0p1 doesn't match */
> +	if (!strcmp_cpuid_str("0x00000000410fd481", "0x00000000410fd480"))
> +		return -1;
> +	/* r0p0 < r1p0 doesn't match */
> +	if (!strcmp_cpuid_str("0x00000000411fd480", "0x00000000410fd480"))
> +		return -1;
> +	/* Different CPU doesn't match */
> +	if (!strcmp_cpuid_str("0x00000000410fd4c0", "0x00000000430f0af0"))
> +		return -1;
> +
> +	return 0;
> +}
> +
> -- 
> 2.34.1
> 
⬢[acme@toolbox perf-tools-next]$        git am ./v6_20230816_james_clark_perf_vendor_events_arm64_update_n2_and_v2_metrics_and_events_using_arm_telem.mbx
Applying: perf test: Add a test for the new Arm CPU ID comparison behavior
.git/rebase-apply/patch:93: new blank line at EOF.
+
warning: 1 line adds whitespace errors.
⬢[acme@toolbox perf-tools-next]$

I'm removing it
