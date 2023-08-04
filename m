Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DF876FAAB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 09:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbjHDHI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 03:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbjHDHIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 03:08:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F59110;
        Fri,  4 Aug 2023 00:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691132901; x=1722668901;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=PeK3rq0/0sJKhXFCcsADtf+QF8bnbSinQiZDECFRWEA=;
  b=mqYd04hv5srsRsWtMIpnCOp/sB8Ah0z7LjaJQwWMFs10Z16G0AK6R79q
   UQhPOs5td+1JPtz5TmyzEqrIbOO8AR8mBNCSC1vdJnv8tBzrS7gk+lXuY
   CAGr6+3H1kJG/DBOsKZm1cdc5CZtt13xBbVMNI5TVrr1AV8nakRCdsG2R
   Wqhw3IdmMX3M8ozFljsW9szR5QPNWwtkATziQVrhpgbSJ9h8rXPTvAYIP
   +DX76ONMkYf58nlFHlVx2F3yAz/AsGE1wHoItSXyf/GtrllJQO6SOxKVj
   KG5CHndCYmqJc+0UAbUY1GhkoyJBY/3Tn3A6togwgHGS9WEZ0F5g6LMPw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="370074733"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="370074733"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 00:08:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="795280730"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="795280730"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.37.129])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 00:08:14 -0700
Message-ID: <e81628fb-0b6d-ccd4-97a4-3afe09159ec4@intel.com>
Date:   Fri, 4 Aug 2023 10:08:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.1
Subject: Re: [PATCH v5 7/7] perf test: Add perf_event_attr test for record
 selected CPUs exclude_user
Content-Language: en-US
To:     Yang Jihong <yangjihong1@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, kan.liang@linux.intel.com,
        james.clark@arm.com, tmricht@linux.ibm.com, ak@linux.intel.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20230804020741.99806-1-yangjihong1@huawei.com>
 <20230804020741.99806-8-yangjihong1@huawei.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230804020741.99806-8-yangjihong1@huawei.com>
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
> If all (non-dummy) evsel have exclude_user, system_wide sideband is not
> needed. Add this test scenario.
> 
> Test result:
> 
>   # ./perf test list 2>&1 | grep 'Setup struct perf_event_attr'
>    17: Setup struct perf_event_attr
>   # ./perf test 17 -v
>    17: Setup struct perf_event_attr                                    :
>   --- start ---
>   test child forked, pid 720198
>   <SNIP>
>   running './tests/attr/test-record-C0-all-kernel'
>   <SNIP>
>   test child finished with 0
>   ---- end ----
>   Setup struct perf_event_attr: Ok
> 
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>

Tested-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  .../perf/tests/attr/test-record-C0-all-kernel | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 tools/perf/tests/attr/test-record-C0-all-kernel
> 
> diff --git a/tools/perf/tests/attr/test-record-C0-all-kernel b/tools/perf/tests/attr/test-record-C0-all-kernel
> new file mode 100644
> index 000000000000..2d7549277c1e
> --- /dev/null
> +++ b/tools/perf/tests/attr/test-record-C0-all-kernel
> @@ -0,0 +1,32 @@
> +[config]
> +command = record
> +args    = --no-bpf-event --all-kernel -C 0 kill >/dev/null 2>&1
> +ret     = 1
> +
> +[event:base-record]
> +cpu=0
> +
> +# no enable on exec for CPU attached
> +enable_on_exec=0
> +
> +# PERF_SAMPLE_IP | PERF_SAMPLE_TID | PERF_SAMPLE_TIME |
> +# PERF_SAMPLE_PERIOD | PERF_SAMPLE_IDENTIFIER
> +# + PERF_SAMPLE_CPU added by -C 0
> +sample_type=65927
> +
> +# Dummy event handles mmaps, comm and task.
> +mmap=0
> +comm=0
> +task=0
> +
> +# exclude_user for all-kernel option
> +exclude_user=1
> +
> +[event:system-wide-dummy]
> +
> +# system_wide is not need for all (non-dummy) events have exclude_user
> +cpu=0
> +
> +# exclude_user for all-kernel option
> +exclude_user=1
> +exclude_kernel=0

