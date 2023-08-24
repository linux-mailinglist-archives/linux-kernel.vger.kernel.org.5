Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A377870FB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 16:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240831AbjHXOAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 10:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbjHXOAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:00:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4C0E7A;
        Thu, 24 Aug 2023 07:00:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEDEE65384;
        Thu, 24 Aug 2023 14:00:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDBC9C433C7;
        Thu, 24 Aug 2023 14:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692885602;
        bh=oyQ7Y3sa5I8ZMyB/lp9x5Zm0BLOOgyy5pToR+nkA12M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dmWOCNXtobdEKPTRgdQCXkoCF6Qn4NNQ6poR1eos2vzyqdzRr0xIhm4i26hCUBHhL
         cu5yaHeO6RvnY7jYFjbHDgFN7jowb/3AramCl8lf1Ts+RTIgTBsNIBpkF1Ks3slxL8
         fcerm8WWSBGjY82vGqq4YZF59+6JBZKN+OfCvNIsse1xdv33kfi710q+VjNiZyyvel
         zzNXuMPId3oiIuMtyrRbYKqPV53Pw/hxsgVq9sPBpwUIPgPnZv6kKarudl9NK/sEj/
         9Mwa3MP4I0Oq5FBz3FRMi2UXjNOXE+T8/C3QbPV5LjxNtoNZTG67w/sJh44iJCytGv
         R0H8P44BWmvVA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6C91640722; Thu, 24 Aug 2023 10:59:59 -0300 (-03)
Date:   Thu, 24 Aug 2023 10:59:59 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH v2 06/18] perf s390 s390_cpumcfdg_dump: Don't scan all
 PMUs
Message-ID: <ZOdiX4eJHFfFbQhi@kernel.org>
References: <20230824041330.266337-1-irogers@google.com>
 <20230824041330.266337-7-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824041330.266337-7-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 23, 2023 at 09:13:18PM -0700, Ian Rogers escreveu:
> Rather than scanning all PMUs for a counter name, scan the PMU
> associated with the evsel of the sample. This is done to remove a
> dependence on pmu-events.h.

I'm applying this one, and CCing the S/390 developers so that they can
try this and maybe provide an Acked-by/Tested-by,

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/s390-sample-raw.c | 50 ++++++++++++++++---------------
>  1 file changed, 26 insertions(+), 24 deletions(-)
> 
> diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
> index 91330c874170..dc1ed3e95d4d 100644
> --- a/tools/perf/util/s390-sample-raw.c
> +++ b/tools/perf/util/s390-sample-raw.c
> @@ -27,7 +27,7 @@
>  #include "color.h"
>  #include "sample-raw.h"
>  #include "s390-cpumcf-kernel.h"
> -#include "pmu-events/pmu-events.h"
> +#include "util/pmu.h"
>  #include "util/sample.h"
>  
>  static size_t ctrset_size(struct cf_ctrset_entry *set)
> @@ -132,56 +132,57 @@ static int get_counterset_start(int setnr)
>  
>  struct get_counter_name_data {
>  	int wanted;
> -	const char *result;
> +	char *result;
>  };
>  
> -static int get_counter_name_callback(const struct pmu_event *evp,
> -				     const struct pmu_events_table *table __maybe_unused,
> -				     void *vdata)
> +static int get_counter_name_callback(void *vdata, struct pmu_event_info *info)
>  {
>  	struct get_counter_name_data *data = vdata;
>  	int rc, event_nr;
> +	const char *event_str;
>  
> -	if (evp->name == NULL || evp->event == NULL)
> +	if (info->str == NULL)
>  		return 0;
> -	rc = sscanf(evp->event, "event=%x", &event_nr);
> +
> +	event_str = strstr(info->str, "event=");
> +	if (!event_str)
> +		return 0;
> +
> +	rc = sscanf(event_str, "event=%x", &event_nr);
>  	if (rc == 1 && event_nr == data->wanted) {
> -		data->result = evp->name;
> +		data->result = strdup(info->name);
>  		return 1; /* Terminate the search. */
>  	}
>  	return 0;
>  }
>  
> -/* Scan the PMU table and extract the logical name of a counter from the
> - * PMU events table. Input is the counter set and counter number with in the
> - * set. Construct the event number and use this as key. If they match return
> - * the name of this counter.
> +/* Scan the PMU and extract the logical name of a counter from the event. Input
> + * is the counter set and counter number with in the set. Construct the event
> + * number and use this as key. If they match return the name of this counter.
>   * If no match is found a NULL pointer is returned.
>   */
> -static const char *get_counter_name(int set, int nr, const struct pmu_events_table *table)
> +static char *get_counter_name(int set, int nr, struct perf_pmu *pmu)
>  {
>  	struct get_counter_name_data data = {
>  		.wanted = get_counterset_start(set) + nr,
>  		.result = NULL,
>  	};
>  
> -	if (!table)
> +	if (!pmu)
>  		return NULL;
>  
> -	pmu_events_table__for_each_event(table, get_counter_name_callback, &data);
> +	perf_pmu__for_each_event(pmu, &data, get_counter_name_callback);
>  	return data.result;
>  }
>  
> -static void s390_cpumcfdg_dump(struct perf_sample *sample)
> +static void s390_cpumcfdg_dump(struct perf_pmu *pmu, struct perf_sample *sample)
>  {
>  	size_t i, len = sample->raw_size, offset = 0;
>  	unsigned char *buf = sample->raw_data;
>  	const char *color = PERF_COLOR_BLUE;
>  	struct cf_ctrset_entry *cep, ce;
> -	const struct pmu_events_table *table;
>  	u64 *p;
>  
> -	table = pmu_events_table__find();
>  	while (offset < len) {
>  		cep = (struct cf_ctrset_entry *)(buf + offset);
>  
> @@ -199,11 +200,12 @@ static void s390_cpumcfdg_dump(struct perf_sample *sample)
>  		color_fprintf(stdout, color, "    [%#08zx] Counterset:%d"
>  			      " Counters:%d\n", offset, ce.set, ce.ctr);
>  		for (i = 0, p = (u64 *)(cep + 1); i < ce.ctr; ++i, ++p) {
> -			const char *ev_name = get_counter_name(ce.set, i, table);
> +			char *ev_name = get_counter_name(ce.set, i, pmu);
>  
>  			color_fprintf(stdout, color,
>  				      "\tCounter:%03d %s Value:%#018lx\n", i,
>  				      ev_name ?: "<unknown>", be64_to_cpu(*p));
> +			free(ev_name);
>  		}
>  		offset += ctrset_size(&ce);
>  	}
> @@ -216,14 +218,14 @@ static void s390_cpumcfdg_dump(struct perf_sample *sample)
>   */
>  void evlist__s390_sample_raw(struct evlist *evlist, union perf_event *event, struct perf_sample *sample)
>  {
> -	struct evsel *ev_bc000;
> +	struct evsel *evsel;
>  
>  	if (event->header.type != PERF_RECORD_SAMPLE)
>  		return;
>  
> -	ev_bc000 = evlist__event2evsel(evlist, event);
> -	if (ev_bc000 == NULL ||
> -	    ev_bc000->core.attr.config != PERF_EVENT_CPUM_CF_DIAG)
> +	evsel = evlist__event2evsel(evlist, event);
> +	if (evsel == NULL ||
> +	    evsel->core.attr.config != PERF_EVENT_CPUM_CF_DIAG)
>  		return;
>  
>  	/* Display raw data on screen */
> @@ -231,5 +233,5 @@ void evlist__s390_sample_raw(struct evlist *evlist, union perf_event *event, str
>  		pr_err("Invalid counter set data encountered\n");
>  		return;
>  	}
> -	s390_cpumcfdg_dump(sample);
> +	s390_cpumcfdg_dump(evsel->pmu, sample);
>  }
> -- 
> 2.42.0.rc1.204.g551eb34607-goog
> 

-- 

- Arnaldo
