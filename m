Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5692C7E1F12
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 12:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjKFLAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 06:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjKFLAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 06:00:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6FCB0;
        Mon,  6 Nov 2023 03:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699268429; x=1730804429;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=vYGTfzfjTaRu1W/Dx7rwKe4uRJQWKt3qrA6K0mo7Kn0=;
  b=RPFEJhXBiOzclvz0H92IvltjZk59ygjNJoyB402lo4v17p4/oxGd2LX7
   F4ZrLpoqJTypNT64bbBvlF5BZxPz41xCFiXUwyMdhOBG9A+bnkIdZw8I/
   zjy5KNqT4KtCPaYAOzk+DEQP3WK99oGMznYqTq8HFlUCejkdNRVVAaA2/
   frUKpN2jqjvTfJL9SUpENWYD52b0da87o3xm0XvmDnNGvaEKucI6QkAn9
   q1/F9/UIgwQgR3G50hNMz1uU7fXxgX6koPZg3RlRXkBmWIffRM4a3Wsg8
   H4nO3mv12cKnBMCJgA50uvwbdyvaUsgwHc9eqtiYsiyaOVaHsqvUKUmZg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="10788723"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="10788723"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 03:00:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="828176819"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="828176819"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.215.231])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 03:00:17 -0800
Message-ID: <0d232518-4bac-46cc-8635-d834fa232f85@intel.com>
Date:   Mon, 6 Nov 2023 13:00:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/53] perf record: Lazy load kernel symbols
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Ming Wang <wangming01@loongson.cn>,
        James Clark <james.clark@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>,
        Sandipan Das <sandipan.das@amd.com>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20231102175735.2272696-1-irogers@google.com>
 <20231102175735.2272696-3-irogers@google.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231102175735.2272696-3-irogers@google.com>
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

On 2/11/23 19:56, Ian Rogers wrote:
> Commit 5b7ba82a7591 ("perf symbols: Load kernel maps before using")
> changed it so that loading a kernel dso would cause the symbols for
> the dso to be eagerly loaded. For perf record this is overhead as the
> symbols won't be used. Add a symbol_conf to control the behavior and
> disable it for perf record and perf inject.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/builtin-inject.c   | 6 ++++++
>  tools/perf/builtin-record.c   | 2 ++
>  tools/perf/util/event.c       | 4 ++--
>  tools/perf/util/symbol_conf.h | 3 ++-
>  4 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index c8cf2fdd9cff..eb3ef5c24b66 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -2265,6 +2265,12 @@ int cmd_inject(int argc, const char **argv)
>  		"perf inject [<options>]",
>  		NULL
>  	};
> +
> +	if (!inject.itrace_synth_opts.set) {
> +		/* Disable eager loading of kernel symbols that adds overhead to perf inject. */
> +		symbol_conf.lazy_load_kernel_maps = true;
> +	}
> +
>  #ifndef HAVE_JITDUMP
>  	set_option_nobuild(options, 'j', "jit", "NO_LIBELF=1", true);
>  #endif
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index dcf288a4fb9a..8ec818568662 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -3989,6 +3989,8 @@ int cmd_record(int argc, const char **argv)
>  # undef set_nobuild
>  #endif
>  
> +	/* Disable eager loading of kernel symbols that adds overhead to perf record. */
> +	symbol_conf.lazy_load_kernel_maps = true;
>  	rec->opts.affinity = PERF_AFFINITY_SYS;
>  
>  	rec->evlist = evlist__new();
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index 923c0fb15122..68f45e9e63b6 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -617,13 +617,13 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
>  	if (cpumode == PERF_RECORD_MISC_KERNEL && perf_host) {
>  		al->level = 'k';
>  		maps = machine__kernel_maps(machine);
> -		load_map = true;
> +		load_map = !symbol_conf.lazy_load_kernel_maps;
>  	} else if (cpumode == PERF_RECORD_MISC_USER && perf_host) {
>  		al->level = '.';
>  	} else if (cpumode == PERF_RECORD_MISC_GUEST_KERNEL && perf_guest) {
>  		al->level = 'g';
>  		maps = machine__kernel_maps(machine);
> -		load_map = true;
> +		load_map = !symbol_conf.lazy_load_kernel_maps;
>  	} else if (cpumode == PERF_RECORD_MISC_GUEST_USER && perf_guest) {
>  		al->level = 'u';
>  	} else {
> diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
> index 0b589570d1d0..2b2fb9e224b0 100644
> --- a/tools/perf/util/symbol_conf.h
> +++ b/tools/perf/util/symbol_conf.h
> @@ -42,7 +42,8 @@ struct symbol_conf {
>  			inline_name,
>  			disable_add2line_warn,
>  			buildid_mmap2,
> -			guest_code;
> +			guest_code,
> +			lazy_load_kernel_maps;
>  	const char	*vmlinux_name,
>  			*kallsyms_name,
>  			*source_prefix,

