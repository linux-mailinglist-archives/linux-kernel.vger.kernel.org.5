Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEB6761AF3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 16:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbjGYOIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 10:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjGYOIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:08:13 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53329102;
        Tue, 25 Jul 2023 07:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690294092; x=1721830092;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=USnH3ynaplC9uLeAMGBazyqCKVUslLdeZoZgqZ2Yn+g=;
  b=bYLYWl1kXbrrl99mUTgXldu4e/e0nfiirHNA6dWkBFl3t2rDtWnGJCDK
   Hdij3LAQ0Ed9/G4DH7YE/lPKd/A4wu13G6EWi6dKzJvIClQRyecxhuBrU
   gmrPN/PBGAaf+4qzSZNWNb8ugs7wg40U18PDcAiS1ej/UvWUeY7jeKFJw
   CRPkrzR4fvGbJ7us0Tz2pjJhfLlcfewBKGyTJsUNK+uNLFworw2Ssj34y
   amZloCzGcvm8OqeqIvMK8QImMHmzHVIKnu6kfr/WwPWeI4bZIu+M5odSA
   96dVqsExn162DO0Nsm+0AOOpRTyearMkTPImFkWRjif77eXsRKapnQubU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="431536525"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="431536525"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 07:07:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="796156872"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="796156872"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.37.150])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 07:07:44 -0700
Message-ID: <9e0147e3-2a6a-6b84-bdfa-365c0762058a@intel.com>
Date:   Tue, 25 Jul 2023 17:07:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/2] perf tools: Add kallsyms__get_symbol_start()
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
References: <20230725001929.368041-1-namhyung@kernel.org>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230725001929.368041-1-namhyung@kernel.org>
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

On 25/07/23 03:19, Namhyung Kim wrote:
> The kallsyms__get_symbol_start() to get any symbol address from
> kallsyms.  The existing kallsyms__get_function_start() only allows text
> symbols so create this to allow data symbols too.
> 
> Acked-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/util/event.c | 30 +++++++++++++++++++++++++++---
>  tools/perf/util/event.h |  2 ++
>  2 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index 4cbb092e0684..923c0fb15122 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -93,8 +93,8 @@ struct process_symbol_args {
>  	u64	   start;
>  };
>  
> -static int find_symbol_cb(void *arg, const char *name, char type,
> -			  u64 start)
> +static int find_func_symbol_cb(void *arg, const char *name, char type,
> +			       u64 start)
>  {
>  	struct process_symbol_args *args = arg;
>  
> @@ -110,12 +110,36 @@ static int find_symbol_cb(void *arg, const char *name, char type,
>  	return 1;
>  }
>  
> +static int find_any_symbol_cb(void *arg, const char *name,
> +			      char type __maybe_unused, u64 start)
> +{
> +	struct process_symbol_args *args = arg;
> +
> +	if (strcmp(name, args->name))
> +		return 0;
> +
> +	args->start = start;
> +	return 1;
> +}
> +
>  int kallsyms__get_function_start(const char *kallsyms_filename,
>  				 const char *symbol_name, u64 *addr)
>  {
>  	struct process_symbol_args args = { .name = symbol_name, };
>  
> -	if (kallsyms__parse(kallsyms_filename, &args, find_symbol_cb) <= 0)
> +	if (kallsyms__parse(kallsyms_filename, &args, find_func_symbol_cb) <= 0)
> +		return -1;
> +
> +	*addr = args.start;
> +	return 0;
> +}
> +
> +int kallsyms__get_symbol_start(const char *kallsyms_filename,
> +			       const char *symbol_name, u64 *addr)
> +{
> +	struct process_symbol_args args = { .name = symbol_name, };
> +
> +	if (kallsyms__parse(kallsyms_filename, &args, find_any_symbol_cb) <= 0)
>  		return -1;
>  
>  	*addr = args.start;
> diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
> index de20e01c9d72..d8bcee2e9b93 100644
> --- a/tools/perf/util/event.h
> +++ b/tools/perf/util/event.h
> @@ -360,6 +360,8 @@ size_t perf_event__fprintf(union perf_event *event, struct machine *machine, FIL
>  
>  int kallsyms__get_function_start(const char *kallsyms_filename,
>  				 const char *symbol_name, u64 *addr);
> +int kallsyms__get_symbol_start(const char *kallsyms_filename,
> +			       const char *symbol_name, u64 *addr);
>  
>  void event_attr_init(struct perf_event_attr *attr);
>  

