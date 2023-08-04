Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7584476FAA5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 09:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbjHDHHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 03:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbjHDHHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 03:07:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275541724;
        Fri,  4 Aug 2023 00:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691132838; x=1722668838;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=XhBnO7O38nhcyi4NaA+y0fGHzyCETSMIHKwkyQg/vr8=;
  b=cRuA5PJXKI6Pr7iZMMdwfJFejLcAnfVjN0WEQt5E26CygcUFAkF+p97M
   tVbmH8yeks6NL0EyIwVF6sAx0B/TJUUuVt2IVKDI8FlyiLnaV/ACC8YTW
   6Y8IZM3cShO7lmhdkG6gBx6WzqwX8pjEl8uZpJskNErnwYTS4pX1TCmac
   Cr07Cb0UBpaG+NWegAlVdWMnc3wWhvrioP4uqTI3C1KrJpnSJ2BHe4NQd
   G4C5tF7slSCHLfFj/VAAu8B/GpXZsvYrrohw45EM0vq+vHBChB0bhnS3O
   77O7D0Hu28uP9yi2cf9Yp2uzGp4COrLA0xXvuvUZ4BN0f6L4ICkqw3PYS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="370074613"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="370074613"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 00:07:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="795280483"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="795280483"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.37.129])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 00:07:12 -0700
Message-ID: <f04991f8-7bca-d36f-2c86-6cf03437aa6d@intel.com>
Date:   Fri, 4 Aug 2023 10:07:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.1
Subject: Re: [PATCH v5 6/7] perf test: Add test case for record sideband
 events
Content-Language: en-US
To:     Yang Jihong <yangjihong1@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, kan.liang@linux.intel.com,
        james.clark@arm.com, tmricht@linux.ibm.com, ak@linux.intel.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20230804020741.99806-1-yangjihong1@huawei.com>
 <20230804020741.99806-7-yangjihong1@huawei.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230804020741.99806-7-yangjihong1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/08/23 05:07, Yang Jihong wrote:
> Add a new test case to record sideband events for all CPUs when tracing
> selected CPUs
> 
> Test result:
> 
>   # ./perf test list 2>&1 | grep 'perf record sideband tests'
>    95: perf record sideband tests
>   # ./perf test 95
>    95: perf record sideband tests                                      : Ok
> 
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>

Tested-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/tests/shell/record_sideband.sh | 44 +++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100755 tools/perf/tests/shell/record_sideband.sh
> 
> diff --git a/tools/perf/tests/shell/record_sideband.sh b/tools/perf/tests/shell/record_sideband.sh
> new file mode 100755
> index 000000000000..2ecf00011cb1
> --- /dev/null
> +++ b/tools/perf/tests/shell/record_sideband.sh
> @@ -0,0 +1,44 @@
> +#!/bin/sh
> +# perf record sideband tests
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +
> +err=0
> +perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> +
> +can_cpu_wide()
> +{
> +    if ! perf record -o ${perfdata} -BN --no-bpf-event -C $1 true 2>&1 >/dev/null
> +    then
> +        echo "record sideband test [Skipped cannot record cpu$1]"
> +        err=2
> +    fi
> +
> +    rm -f ${perfdata}
> +    return $err
> +}
> +
> +test_system_wide_tracking()
> +{
> +    # Need CPU 0 and CPU 1
> +    can_cpu_wide 0 || return 0
> +    can_cpu_wide 1 || return 0
> +
> +    # Record on CPU 0 a task running on CPU 1
> +    perf record -BN --no-bpf-event -o ${perfdata} -C 0 -- taskset --cpu-list 1 true
> +
> +    # Should get MMAP events from CPU 1
> +    mmap_cnt=`perf script -i ${perfdata} --show-mmap-events -C 1 2>/dev/null | grep MMAP | wc -l`
> +
> +    rm -f ${perfdata}
> +
> +    if [ ${mmap_cnt} -gt 0 ] ; then
> +        return 0
> +    fi
> +
> +    echo "Failed to record MMAP events on CPU 1 when tracing CPU 0"
> +    return 1
> +}
> +
> +test_system_wide_tracking

