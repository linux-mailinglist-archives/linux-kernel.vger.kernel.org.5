Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C02802BBC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 07:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbjLDGy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 01:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLDGyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 01:54:54 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1105ED5;
        Sun,  3 Dec 2023 22:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701672901; x=1733208901;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=DkI6Gqdi3oM5F1BCGG/SyVaLLGeuLY9c6+WsMZZX+HU=;
  b=ct2yt0LBod7DpN68pdzMxw7R/apgJ/tUkjHyv8brE7hBcNr2rnftldnl
   jb3JCP7nF2Okc9z3FV/Glvp9P5TCxMBYT5U/RzIz9d3SsQrPBkddyhMpn
   xKuyjZhay6i9xahY9NAfdUzSqHYgXHO2mSggqn2FLql2TuAkKUo4/tr2w
   VFCBWai5alOIxlF3co8l4aiQ2szSYHeQBF56/ckMMcYtzNMT55Y8+Qgcm
   KpBuTQ7JfsEq1yW7Hvtk3wqmEUndC0Erewlh/P6ZxRn1PA9MBKY0SwLtc
   Jd+74YmeTuhXFSJQ2wHSCnhUd5rasnwocxt8/sMCxb/YK2OpelWkPD034
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="573866"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="573866"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2023 22:55:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="888430244"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="888430244"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.44.211])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2023 22:54:55 -0800
Message-ID: <cc1f77b9-6a3f-4574-8d45-8c2ded43b589@intel.com>
Date:   Mon, 4 Dec 2023 08:54:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/9] perf tests: Avoid fork in perf_has_symbol test
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        llvm@lists.linux.dev
References: <20231201235031.475293-1-irogers@google.com>
 <20231201235031.475293-3-irogers@google.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231201235031.475293-3-irogers@google.com>
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

On 2/12/23 01:50, Ian Rogers wrote:
> perf test -vv Symbols is used to indentify symbols within the perf
> binary. Add the -F flag so that the test command doesn't fork the test
> before running. This removes a little overhead.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/tests/shell/lib/perf_has_symbol.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/lib/perf_has_symbol.sh b/tools/perf/tests/shell/lib/perf_has_symbol.sh
> index 5d59c32ae3e7..561c93b75d77 100644
> --- a/tools/perf/tests/shell/lib/perf_has_symbol.sh
> +++ b/tools/perf/tests/shell/lib/perf_has_symbol.sh
> @@ -3,7 +3,7 @@
>  
>  perf_has_symbol()
>  {
> -	if perf test -vv "Symbols" 2>&1 | grep "[[:space:]]$1$"; then
> +	if perf test -vv -F "Symbols" 2>&1 | grep "[[:space:]]$1$"; then
>  		echo "perf does have symbol '$1'"
>  		return 0
>  	fi

