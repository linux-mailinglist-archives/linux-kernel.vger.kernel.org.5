Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885977FD18B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbjK2JAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbjK2JAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:00:38 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC31111;
        Wed, 29 Nov 2023 01:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701248441; x=1732784441;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=29gtM7lRrs8xXEzW5BzN8a4ywpjYYsoTZjZd3DuYHwc=;
  b=N2QjqL9Ae+30BVIsQmcRfu//DEZXE/3dsu7GjP+xM8Jzs230EHMbhRDa
   FMBPkeZum6idCdBlgeP3JlkLk7kxHGsl8rjDiRkUsvFvoh4Iu66KUvtgJ
   ulSTMp0M9zDfINC+NCQycOcmAcC/6Q9zO1YbWjOq/uTmqiFD1UFS8Hjx0
   3alc6jRfZ2odQeFALbAppbwYVJbmHu2M1MF1YDEQQqhc5Ee8bqqM6bJg9
   OLqhCSrBkcSCGlRm0IBcAXJ4978j6oxlGoXplByglLoXNPBh9jWw62Kb5
   EgovtZ5GtqUKvQXfBFLTUQ1qWMna+FKsj10VuSTLWr9E4irdBlrx9/Ng3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="392873524"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="392873524"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 01:00:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="762240382"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="762240382"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.43.226])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 01:00:37 -0800
Message-ID: <a54d0a93-aacd-4c69-a34c-8628b0e18ee7@intel.com>
Date:   Wed, 29 Nov 2023 11:00:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] perf test: Add basic list test
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20231129081004.1918096-1-irogers@google.com>
 <20231129081004.1918096-2-irogers@google.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231129081004.1918096-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/23 10:10, Ian Rogers wrote:
> Test that json output produces valid json.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/shell/list.sh | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100755 tools/perf/tests/shell/list.sh
> 
> diff --git a/tools/perf/tests/shell/list.sh b/tools/perf/tests/shell/list.sh
> new file mode 100755
> index 000000000000..286879a9837a
> --- /dev/null
> +++ b/tools/perf/tests/shell/list.sh
> @@ -0,0 +1,29 @@
> +#!/bin/sh
> +# perf list tests
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +err=0
> +
> +if [ "x$PYTHON" == "x" ]
> +then
> +	if which python3 > /dev/null

'which' isn't always present.  Maybe

python3 --version >/dev/null 2>&1 && PYTHON=python3

> +	then
> +		PYTHON=python3
> +	elif which python > /dev/null
> +	then
> +		PYTHON=python
> +	else
> +		echo Skipping test, python not detected please set environment variable PYTHON.
> +		exit 2
> +	fi
> +fi
> +
> +test_list_json() {
> +  echo "Json output test"
> +  perf list -j | $PYTHON -m json.tool
> +  echo "Json output test [Success]"
> +}
> +
> +test_list_json
> +exit $err

