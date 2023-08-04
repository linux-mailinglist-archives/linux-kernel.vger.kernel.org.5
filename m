Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1439476FA90
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 08:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbjHDG6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 02:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbjHDG6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 02:58:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628B11990;
        Thu,  3 Aug 2023 23:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691132292; x=1722668292;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=HUq72x+zb7n5uc1c1jfBqDMu/TGb4LXSGevx7yaHEXI=;
  b=J43BhaOkSYbMsib1lxp63Fm1ld2PAzDEpKIDpqxDGtfuTlVNi+0g8eB2
   QJ4evnjM/cnWOPooYg5GVAjq/1dPyKsUJtqfiEdAzfV1oGqQVbqRGGAaZ
   0dl1a88aylMvU5grmu+b9szeFBpB/MZ1cfXncy+eeaqOLv4brKIGWRX5D
   ljqqY3mokv1PQn8Ifp8nlNFjlGmsUTtZzilwRgsn4jGX8ndD7L/jbdNm3
   sqQ08YN30qCR/hyJJFBY+FSxb0YD6OHObHXPP7k0kwKs15uAB+rr3NWG/
   r0m5Lb4BJJ8hMYFiT14N0UIcCkZC5Wx02izqIzBfqyXxgvN2JPpAIsmYZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="349679869"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="349679869"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 23:58:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="1060611938"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="1060611938"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.37.129])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 23:58:07 -0700
Message-ID: <67b82936-3250-3eb3-7d84-cd3ce9337f6f@intel.com>
Date:   Fri, 4 Aug 2023 09:58:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.1
Subject: Re: [PATCH v5 2/7] perf evlist: Add evlist__findnew_tracking_event()
 helper
Content-Language: en-US
To:     Yang Jihong <yangjihong1@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, kan.liang@linux.intel.com,
        james.clark@arm.com, tmricht@linux.ibm.com, ak@linux.intel.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20230804020741.99806-1-yangjihong1@huawei.com>
 <20230804020741.99806-3-yangjihong1@huawei.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230804020741.99806-3-yangjihong1@huawei.com>
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
> Currently, intel-bts, intel-pt, and arm-spe may add a dummy event for
> tracking to the evlist. We may need to search for the dummy event for
> some settings. Therefore, add evlist__findnew_tracking_event() helper.
> 
> evlist__findnew_tracking_event() also deal with system_wide maps if
> system_wide is true.
> 
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/builtin-record.c | 11 +++--------
>  tools/perf/util/evlist.c    | 18 ++++++++++++++++++
>  tools/perf/util/evlist.h    |  1 +
>  3 files changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index aec18db7ff23..ca83599cc50c 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1295,14 +1295,9 @@ static int record__open(struct record *rec)
>  	 */
>  	if (opts->target.initial_delay || target__has_cpu(&opts->target) ||
>  	    perf_pmus__num_core_pmus() > 1) {
> -		pos = evlist__get_tracking_event(evlist);
> -		if (!evsel__is_dummy_event(pos)) {
> -			/* Set up dummy event. */
> -			if (evlist__add_dummy(evlist))
> -				return -ENOMEM;
> -			pos = evlist__last(evlist);
> -			evlist__set_tracking_event(evlist, pos);
> -		}
> +		pos = evlist__findnew_tracking_event(evlist, false);
> +		if (!pos)
> +			return -ENOMEM;
>  
>  		/*
>  		 * Enable the dummy event when the process is forked for
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 7ef43f72098e..25c3ebe2c2f5 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -1694,6 +1694,24 @@ void evlist__set_tracking_event(struct evlist *evlist, struct evsel *tracking_ev
>  	tracking_evsel->tracking = true;
>  }
>  
> +struct evsel *evlist__findnew_tracking_event(struct evlist *evlist, bool system_wide)
> +{
> +	struct evsel *evsel;
> +
> +	evsel = evlist__get_tracking_event(evlist);
> +	if (!evsel__is_dummy_event(evsel)) {
> +		evsel = evlist__add_aux_dummy(evlist, system_wide);
> +		if (!evsel)
> +			return NULL;
> +
> +		evlist__set_tracking_event(evlist, evsel);
> +	} else if (system_wide) {
> +		perf_evlist__go_system_wide(&evlist->core, &evsel->core);
> +	}
> +
> +	return evsel;
> +}
> +
>  struct evsel *evlist__find_evsel_by_str(struct evlist *evlist, const char *str)
>  {
>  	struct evsel *evsel;
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index 664c6bf7b3e0..98e7ddb2bd30 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -387,6 +387,7 @@ bool evlist_cpu_iterator__end(const struct evlist_cpu_iterator *evlist_cpu_itr);
>  
>  struct evsel *evlist__get_tracking_event(struct evlist *evlist);
>  void evlist__set_tracking_event(struct evlist *evlist, struct evsel *tracking_evsel);
> +struct evsel *evlist__findnew_tracking_event(struct evlist *evlist, bool system_wide);
>  
>  struct evsel *evlist__find_evsel_by_str(struct evlist *evlist, const char *str);
>  

