Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BBE77B223
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 09:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbjHNHMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 03:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234108AbjHNHLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 03:11:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD61E71;
        Mon, 14 Aug 2023 00:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691997107; x=1723533107;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5sM6DJTWLycTUGGe9xX3afJEUXb/a6vzz3ZM1xTgFVI=;
  b=hnTBwD5zqkF6UQ/aVoCIph1UvmhFnSCANKJyzZhym45PbHIWEki7IAPP
   PQHBpxSAEaqCsbTIkFJXtixi1PkPailRSq78wD/FqcztY2SpFZO3/4bvX
   pYmaQTK/L9sdaP8ItREjyjm91E9QeJWFvIdVLGg13dcm/AbjThrn+wkFM
   4L9vQUb276+5EjBjzCj7o+vnI5af7r7vKaWrW3XhYCIHwCXhj3VGX2gqt
   KKIpd2LAGx+FRswsg5fuQOkuDcm1bn+UuGEzDD4BTbPVS0hEKcsPTHKIB
   wQ27dO31Hgk4wabf33pjZl3xeEEzevdLJAS79OrKFyY0oTqCKDDKelQOj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="362129920"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="362129920"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 00:11:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="762852526"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="762852526"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.51.71])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 00:11:45 -0700
Message-ID: <b2332dd5-e01e-dc61-e19c-55cf9a684ca2@intel.com>
Date:   Mon, 14 Aug 2023 10:11:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH] perf tools: Handle old data in PERF_RECORD_ATTR
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
References: <20230807061652.2492167-1-namhyung@kernel.org>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230807061652.2492167-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/08/23 09:16, Namhyung Kim wrote:
> The PERF_RECORD_ATTR is used for a pipe mode to describe an event with
> attribute and IDs.  The ID table comes after the attr and it calculate
> size of the table using the total record size and the attr size.
> 
>   n_ids = (total_record_size - end_of_the_attr_field) / sizeof(u64)
> 
> This is fine for most use cases, but sometimes it saves the pipe output
> in a file and then process it later.  And it becomes a problem if there
> is a change in attr size between the record and report.
> 
>   $ perf record -o- > perf-pipe.data  # old version
>   $ perf report -i- < perf-pipe.data  # new version
> 
> For example, if the attr size is 128 and it has 4 IDs, then it would
> save them in 168 byte like below:
> 
>    8 byte: perf event header { .type = PERF_RECORD_ATTR, .size = 168 },
>  128 byte: perf event attr { .size = 128, ... },
>   32 byte: event IDs [] = { 1234, 1235, 1236, 1237 },
> 
> But when report later, it thinks the attr size is 136 then it only read
> the last 3 entries as ID.
> 
>    8 byte: perf event header { .type = PERF_RECORD_ATTR, .size = 168 },
>  136 byte: perf event attr { .size = 136, ... },
>   24 byte: event IDs [] = { 1235, 1236, 1237 },  // 1234 is missing
> 
> So it should use the recorded version of the attr.  The attr has the
> size field already then it should honor the size when reading data.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/header.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 52fbf526fe74..f89321cbfdee 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -4381,7 +4381,8 @@ int perf_event__process_attr(struct perf_tool *tool __maybe_unused,
>  			     union perf_event *event,
>  			     struct evlist **pevlist)
>  {
> -	u32 i, ids, n_ids;
> +	u32 i, n_ids;
> +	u64 *ids;
>  	struct evsel *evsel;
>  	struct evlist *evlist = *pevlist;
>  
> @@ -4397,9 +4398,8 @@ int perf_event__process_attr(struct perf_tool *tool __maybe_unused,
>  
>  	evlist__add(evlist, evsel);
>  
> -	ids = event->header.size;
> -	ids -= (void *)&event->attr.id - (void *)event;
> -	n_ids = ids / sizeof(u64);
> +	n_ids = event->header.size - sizeof(event->header) - event->attr.attr.size;
> +	n_ids = n_ids / sizeof(u64);
>  	/*
>  	 * We don't have the cpu and thread maps on the header, so
>  	 * for allocating the perf_sample_id table we fake 1 cpu and
> @@ -4408,8 +4408,9 @@ int perf_event__process_attr(struct perf_tool *tool __maybe_unused,
>  	if (perf_evsel__alloc_id(&evsel->core, 1, n_ids))
>  		return -ENOMEM;
>  
> +	ids = (void *)&event->attr.attr + event->attr.attr.size;
>  	for (i = 0; i < n_ids; i++) {
> -		perf_evlist__id_add(&evlist->core, &evsel->core, 0, i, event->attr.id[i]);
> +		perf_evlist__id_add(&evlist->core, &evsel->core, 0, i, ids[i]);
>  	}
>  
>  	return 0;

This is a good catch!

It looks like perf_event__hdr_swap() might also have this problem.

I wonder if we should remove 'id' from struct perf_record_header_attr
since the position is not guaranteed?

Probably could use a comment there either way.

Also perhaps a fixes tag and cc stable

