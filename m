Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876E0805E8D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 20:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345450AbjLETWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 14:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235005AbjLETW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 14:22:26 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDE2D4D;
        Tue,  5 Dec 2023 11:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701804149; x=1733340149;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=pzyZMQAeOzsTgEO8GOSM7n0lSMGXAXy5xmTZZbwfqRs=;
  b=fsd1KBlSKTG8fyyQJP9IiQHu8A7ngFSWF5XdEKQ/bAxnEoRHdwf+pKhV
   Cm7Dci6PiugGqyzK/XhHbDvj2Q/bumRkBmDFZGTpMBwEFraDGGOWTJb1w
   SlzU+7t/Umranimnk3ntovIacSpaVJz1jXboJX5qwm3LeEiGh70koQlHd
   ejeV00OirzwcRHY3t9BL0GPResyl8Wfo4kzICiJmQmnrz5QM7oZfQQyrL
   NTiRMsvt0+vEq4WdqcNcVaWOCWVBjGhMWZ3aOiWnkC/hmD4qxVQHaQWly
   3fitKm4s86cVJPNmg9L3nTF/Buqljs25IldyXaMEWIYhWdI7wNRe6gKUh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="785701"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="785701"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 11:22:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="805382148"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="805382148"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.46.77])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 11:22:19 -0800
Message-ID: <b72ee8f2-1dae-49a4-b89e-4d5453c8834f@intel.com>
Date:   Tue, 5 Dec 2023 21:22:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf test: Skip diff test if test_loop is missing
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231205164924.835682-1-irogers@google.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231205164924.835682-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/23 18:49, Ian Rogers wrote:
> The diff test depends on finding the symbol test_loop in perf and will
> fail if perf has been stripped and no debug object is available. In
> that case, skip the test instead.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/shell/diff.sh | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/diff.sh b/tools/perf/tests/shell/diff.sh
> index 213185763688..14b87af88703 100755
> --- a/tools/perf/tests/shell/diff.sh
> +++ b/tools/perf/tests/shell/diff.sh
> @@ -9,8 +9,15 @@ perfdata1=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
>  perfdata2=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
>  perfdata3=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
>  testprog="perf test -w thloop"
> +
> +shelldir=$(dirname "$0")
> +# shellcheck source=lib/perf_has_symbol.sh
> +. "${shelldir}"/lib/perf_has_symbol.sh
> +
>  testsym="test_loop"
>  
> +skip_test_missing_symbol ${testsym}
> +
>  cleanup() {
>    rm -rf "${perfdata1}"
>    rm -rf "${perfdata1}".old

The verbose output in the error case could also
be tweaked.

Before patch:

 $ strip tools/perf/perf
 $ tools/perf/perf buildid-cache -p $(realpath tools/perf/perf)
 $ tools/perf/perf test -v 'diff test'
  85: perf diff tests                                                 :
 --- start ---
 test child forked, pid 8621
 Basic two file diff test
 ./tools/perf/tests/shell/diff.sh: 51: [: Workload: unexpected operator
 ./tools/perf/tests/shell/diff.sh: 56: [: Workload: unexpected operator
 Basic two file diff test [Failed diff]
 Basic three file diff test
 ./tools/perf/tests/shell/diff.sh: 73: [: Workload: unexpected operator
 ./tools/perf/tests/shell/diff.sh: 78: [: Workload: unexpected operator
 ./tools/perf/tests/shell/diff.sh: 83: [: Workload: unexpected operator
 Basic three file diff test [Failed diff]
 test child finished with -1
 ---- end ----
 perf diff tests: FAILED!

After patch:

 $ tools/perf/perf test -v 'diff test'
  85: perf diff tests                                                 :
 --- start ---
 test child forked, pid 8853
 perf does not have symbol 'test_loop'
 perf is missing symbols - skipping test
 test child finished with -2
 ---- end ----
 perf diff tests: Skip

 and with symbols:

 $ tools/perf/perf test -v 'diff test'
  85: perf diff tests                                                 :
 --- start ---
 test child forked, pid 10122
  103e20-103e60 g test_loop
 perf does have symbol 'test_loop'
 Basic two file diff test
 Basic two file diff test [Success]
 Basic three file diff test
 Basic three file diff test [Success]
 test child finished with 0
 ---- end ----
 perf diff tests: Ok



Tested-by: Adrian Hunter <adrian.hunter@intel.com>

