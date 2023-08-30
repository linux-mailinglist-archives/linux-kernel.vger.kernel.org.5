Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4284678DFA4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240908AbjH3TJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244982AbjH3OPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 10:15:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24880122;
        Wed, 30 Aug 2023 07:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693404942; x=1724940942;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=9nUsW9E756XKH/ZqO1z7yXlVxgWZzxBiBpaF8uclgFg=;
  b=DunAO0krIXvY6VN1VojUmTvRU/W8gUyGm2VWI755G4BIcF46yNbrNe6k
   uAn+KndoPkqTOtsmfIE7WxgO00F2rLNsV1yQYWeYufd5rKHcyow7XohEz
   dp9z8YBWSrULCNqICBtllkHZHfJVgat/UYIqA5BSWhUt5qgGTBGlcir9w
   Iyu8earbprqu7wTA74ryeg3HXLvb9AhkhDUkcpsMb8eFg5u4BmHf5PmCJ
   TeHaC3TN/sj9Z/IyoEJ9NDLW3xECwoELqmbsUSj0Oeq6XwBukmhH9eW7y
   mgeMi1pbIjs790jc3yzzp7XNloVKIhcFyGglHrKz2oSQu28WkwtVo2Uk8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="365858269"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="365858269"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 07:11:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="985755279"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="985755279"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 30 Aug 2023 07:11:14 -0700
Received: from [10.213.187.192] (kliang2-mobl1.ccr.corp.intel.com [10.213.187.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 4F3F2580C73;
        Wed, 30 Aug 2023 07:11:13 -0700 (PDT)
Message-ID: <4de84370-29f3-75ed-9c91-330636cdd790@linux.intel.com>
Date:   Wed, 30 Aug 2023 10:11:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v1 2/3] perf parse-events: Make common term list to strbuf
 helper
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230830070753.1821629-1-irogers@google.com>
 <20230830070753.1821629-2-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230830070753.1821629-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-08-30 3:07 a.m., Ian Rogers wrote:
> A term list is turned into a string for debug output and for the str
> value in the alias. Add a helper to do this based on existing code,
> but then fix for situations like events being identified. Use strbuf
> to manage the dynamic memory allocation and remove the 256 byte
> limit. Use in various places the string of the term list is required.
> 
> Before:
> ```
> $ sudo perf stat -vv -e inst_retired.any true
> Using CPUID GenuineIntel-6-8D-1
> intel_pt default config: tsc,mtc,mtc_period=3,psb_period=3,pt,branch
> Attempting to add event pmu 'cpu' with 'inst_retired.any,' that may result in non-fatal errors
> After aliases, add event pmu 'cpu' with 'event,period,' that may result in non-fatal errors
> inst_retired.any -> cpu/inst_retired.any/
> ...
> ```
> 
> After:
> ```
> $ sudo perf stat -vv -e inst_retired.any true
> Using CPUID GenuineIntel-6-8D-1
> intel_pt default config: tsc,mtc,mtc_period=3,psb_period=3,pt,branch
> Attempt to add: cpu/inst_retired.any/
> ..after resolving event: cpu/event=0xc0,period=0x1e8483/
> inst_retired.any -> cpu/event=0xc0,period=0x1e8483/
> ...
> ```
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/parse-events.c | 101 ++++++++++++++++++++++++---------
>  tools/perf/util/parse-events.h |   2 +
>  tools/perf/util/pmu.c          |  19 ++-----
>  3 files changed, 81 insertions(+), 41 deletions(-)

Which branch should I use to apply the patch?
I tried the perf-tools-next branch, but there is some conflict.
I'd like to do some tests on a hybrid machine.

Thanks,
Kan
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 4c812fbe0cf9..0b941b58bdc0 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -13,7 +13,7 @@
>  #include <subcmd/parse-options.h>
>  #include "parse-events.h"
>  #include "string2.h"
> -#include "strlist.h"
> +#include "strbuf.h"
>  #include "debug.h"
>  #include <api/fs/tracing_path.h>
>  #include <perf/cpumap.h>
> @@ -1303,19 +1303,6 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
>  
>  	pmu = parse_state->fake_pmu ?: perf_pmus__find(name);
>  
> -	if (verbose > 1 && !(pmu && pmu->selectable)) {
> -		fprintf(stderr, "Attempting to add event pmu '%s' with '",
> -			name);
> -		if (head_config) {
> -			struct parse_events_term *term;
> -
> -			list_for_each_entry(term, head_config, list) {
> -				fprintf(stderr, "%s,", term->config);
> -			}
> -		}
> -		fprintf(stderr, "' that may result in non-fatal errors\n");
> -	}
> -
>  	if (!pmu) {
>  		char *err_str;
>  
> @@ -1325,6 +1312,21 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
>  			parse_events_error__handle(err, loc->first_column, err_str, NULL);
>  		return -EINVAL;
>  	}
> +
> +	if (verbose > 1) {
> +		struct strbuf sb;
> +
> +		strbuf_init(&sb, /*hint=*/ 0);
> +		if (pmu->selectable && !head_config) {
> +			strbuf_addf(&sb, "%s//", name);
> +		} else {
> +			strbuf_addf(&sb, "%s/", name);
> +			parse_events_term__to_strbuf(head_config, &sb);
> +			strbuf_addch(&sb, '/');
> +		}
> +		fprintf(stderr, "Attempt to add: %s\n", sb.buf);
> +		strbuf_release(&sb);
> +	}
>  	if (head_config)
>  		fix_raw(head_config, pmu);
>  
> @@ -1349,16 +1351,12 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
>  		return -EINVAL;
>  
>  	if (verbose > 1) {
> -		fprintf(stderr, "After aliases, add event pmu '%s' with '",
> -			name);
> -		if (head_config) {
> -			struct parse_events_term *term;
> +		struct strbuf sb;
>  
> -			list_for_each_entry(term, head_config, list) {
> -				fprintf(stderr, "%s,", term->config);
> -			}
> -		}
> -		fprintf(stderr, "' that may result in non-fatal errors\n");
> +		strbuf_init(&sb, /*hint=*/ 0);
> +		parse_events_term__to_strbuf(head_config, &sb);
> +		fprintf(stderr, "..after resolving event: %s/%s/\n", name, sb.buf);
> +		strbuf_release(&sb);
>  	}
>  
>  	/*
> @@ -1460,7 +1458,12 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
>  		parse_events_copy_term_list(head, &orig_head);
>  		if (!parse_events_add_pmu(parse_state, list, pmu->name,
>  					  orig_head, auto_merge_stats, loc)) {
> -			pr_debug("%s -> %s/%s/\n", str, pmu->name, str);
> +			struct strbuf sb;
> +
> +			strbuf_init(&sb, /*hint=*/ 0);
> +			parse_events_term__to_strbuf(orig_head, &sb);
> +			pr_debug("%s -> %s/%s/\n", str, pmu->name, sb.buf);
> +			strbuf_release(&sb);
>  			ok++;
>  		}
>  		parse_events_terms__delete(orig_head);
> @@ -1469,7 +1472,12 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
>  	if (parse_state->fake_pmu) {
>  		if (!parse_events_add_pmu(parse_state, list, str, head,
>  					  /*auto_merge_stats=*/true, loc)) {
> -			pr_debug("%s -> %s/%s/\n", str, "fake_pmu", str);
> +			struct strbuf sb;
> +
> +			strbuf_init(&sb, /*hint=*/ 0);
> +			parse_events_term__to_strbuf(head, &sb);
> +			pr_debug("%s -> %s/%s/\n", str, "fake_pmu", sb.buf);
> +			strbuf_release(&sb);
>  			ok++;
>  		}
>  	}
> @@ -2085,7 +2093,7 @@ void parse_events_error__handle(struct parse_events_error *err, int idx,
>  		break;
>  	default:
>  		pr_debug("Multiple errors dropping message: %s (%s)\n",
> -			err->str, err->help);
> +			err->str, err->help ?: "<no help>");
>  		free(err->str);
>  		err->str = str;
>  		free(err->help);
> @@ -2502,6 +2510,47 @@ void parse_events_terms__delete(struct list_head *terms)
>  	free(terms);
>  }
>  
> +int parse_events_term__to_strbuf(struct list_head *term_list, struct strbuf *sb)
> +{
> +	struct parse_events_term *term;
> +	bool first = true;
> +
> +	if (!term_list)
> +		return 0;
> +
> +	list_for_each_entry(term, term_list, list) {
> +		int ret;
> +
> +		if (!first) {
> +			ret = strbuf_addch(sb, ',');
> +			if (ret < 0)
> +				return ret;
> +		}
> +		first = false;
> +
> +		if (term->type_val == PARSE_EVENTS__TERM_TYPE_NUM)
> +			if (term->type_term == PARSE_EVENTS__TERM_TYPE_USER && term->val.num == 1)
> +				ret = strbuf_addf(sb, "%s", term->config);
> +			else
> +				ret = strbuf_addf(sb, "%s=%#"PRIx64, term->config, term->val.num);
> +		else if (term->type_val == PARSE_EVENTS__TERM_TYPE_STR) {
> +			if (term->config) {
> +				ret = strbuf_addf(sb, "%s=", term->config);
> +				if (ret < 0)
> +					return ret;
> +			} else if (term->type_term < __PARSE_EVENTS__TERM_TYPE_NR) {
> +				ret = strbuf_addf(sb, "%s=", config_term_names[term->type_term]);
> +				if (ret < 0)
> +					return ret;
> +			}
> +			ret = strbuf_addf(sb, "%s", term->val.str);
> +		}
> +		if (ret < 0)
> +			return ret;
> +	}
> +	return 0;
> +}
> +
>  void parse_events_evlist_error(struct parse_events_state *parse_state,
>  			       int idx, const char *str)
>  {
> diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
> index 6d75d853ce00..20bdc35d6112 100644
> --- a/tools/perf/util/parse-events.h
> +++ b/tools/perf/util/parse-events.h
> @@ -18,6 +18,7 @@ struct parse_events_error;
>  
>  struct option;
>  struct perf_pmu;
> +struct strbuf;
>  
>  const char *event_type(int type);
>  
> @@ -152,6 +153,7 @@ int parse_events_term__clone(struct parse_events_term **new,
>  void parse_events_term__delete(struct parse_events_term *term);
>  void parse_events_terms__delete(struct list_head *terms);
>  void parse_events_terms__purge(struct list_head *terms);
> +int parse_events_term__to_strbuf(struct list_head *term_list, struct strbuf *sb);
>  int parse_events__modifier_event(struct list_head *list, char *str, bool add);
>  int parse_events__modifier_group(struct list_head *list, char *event_mod);
>  int parse_events_name(struct list_head *list, const char *name);
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index b3f8f3f1e900..8dbb7008877e 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -507,12 +507,11 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
>  				const char *desc, const char *val, FILE *val_fd,
>  				const struct pmu_event *pe)
>  {
> -	struct parse_events_term *term;
>  	struct perf_pmu_alias *alias;
>  	int ret;
> -	char newval[256];
>  	const char *long_desc = NULL, *topic = NULL, *unit = NULL, *pmu_name = NULL;
>  	bool deprecated = false, perpkg = false;
> +	struct strbuf sb;
>  
>  	if (perf_pmu__find_alias(pmu, name, /*load=*/ false)) {
>  		/* Alias was already created/loaded. */
> @@ -582,20 +581,10 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
>  	 *
>  	 * Rebuild string to make alias->str member comparable.
>  	 */
> -	ret = 0;
> -	list_for_each_entry(term, &alias->terms, list) {
> -		if (ret)
> -			ret += scnprintf(newval + ret, sizeof(newval) - ret,
> -					 ",");
> -		if (term->type_val == PARSE_EVENTS__TERM_TYPE_NUM)
> -			ret += scnprintf(newval + ret, sizeof(newval) - ret,
> -					 "%s=%#x", term->config, term->val.num);
> -		else if (term->type_val == PARSE_EVENTS__TERM_TYPE_STR)
> -			ret += scnprintf(newval + ret, sizeof(newval) - ret,
> -					 "%s=%s", term->config, term->val.str);
> -	}
>  	zfree(&alias->str);
> -	alias->str = strdup(newval);
> +	strbuf_init(&sb, /*hint=*/ 0);
> +	parse_events_term__to_strbuf(&alias->terms, &sb);
> +	alias->str = strbuf_detach(&sb, /*sz=*/ NULL);
>  	if (!pe)
>  		pmu->sysfs_aliases++;
>  	else
