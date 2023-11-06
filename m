Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413D97E1FFF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 12:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjKFL3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 06:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjKFL26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 06:28:58 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8998F;
        Mon,  6 Nov 2023 03:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699270135; x=1730806135;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=DQ7rMfvWgYUMuinr30MKysM2GNxuYBC0Zo4SHjV6554=;
  b=lqP7eu2LE7dGBxNQ48sA6L5s041izsDJMwkMDBYP5OhOGxUqSYlVR/wE
   7Ue4wqJ0BRQ0OGI0SiKm4mC0eZ6qYzbdFMKYr2nXD6QZJXrrRsEGewNCl
   DjqN98o8E44ZbL9LBsLcmeSQBRmUun8iN8dhNaF8sVasX2s1ucshpDwhD
   OwX4lOf5tzR/n6zZXIQDQ2V0cMu8uqGPCVvLux3dN0AFQ0I97PY+a7I+W
   LjFkniBNyJv/70Gxd12kKAAnyIoRQqWObnWFdgS4BTRbMsxmFRoUCeCUs
   JQ3mpkwy5LSfS5zdjzrJdfMBVTptAmxVlvVOS6y523hpQQK4QhdyCwf4L
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="369462616"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="369462616"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 03:28:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="1093758672"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="1093758672"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.215.231])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 03:28:46 -0800
Message-ID: <371634c4-756a-498c-a46d-7459a07075e0@intel.com>
Date:   Mon, 6 Nov 2023 13:28:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/53] perf machine thread: Remove exited threads by
 default
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
 <20231102175735.2272696-6-irogers@google.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231102175735.2272696-6-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/23 19:56, Ian Rogers wrote:
> struct thread values hold onto references to mmaps, dsos, etc. When a
> thread exits it is necessary to clean all of this memory up by
> removing the thread from the machine's threads. Some tools require
> this doesn't happen, such as auxtrace events, perf report if offcpu
> events exist or if a task list is being generated, so add a
> symbol_conf value to make the behavior optional. When an exited thread
> is left in the machine's threads, mark it as exited.
> 
> This change relates to commit 40826c45eb0b ("perf thread: Remove
> notion of dead threads"). Dead threads were removed as they had a
> reference count of 0 and were difficult to reason about with the
> reference count checker. Here a thread is removed from threads when it
> exits, unless via symbol_conf the exited thread isn't remove and is
> marked as exited. Reference counting behaves as it normally does.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

For auxtrace:

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/builtin-report.c   |  7 +++++++
>  tools/perf/util/machine.c     | 10 +++++++---
>  tools/perf/util/session.c     |  5 +++++
>  tools/perf/util/symbol_conf.h |  3 ++-
>  tools/perf/util/thread.h      | 14 ++++++++++++++
>  5 files changed, 35 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 9cb1da2dc0c0..121a2781323c 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -1426,6 +1426,13 @@ int cmd_report(int argc, const char **argv)
>  	if (ret < 0)
>  		goto exit;
>  
> +	/*
> +	 * tasks_mode require access to exited threads to list those that are in
> +	 * the data file. Off-cpu events are synthesized after other events and
> +	 * reference exited threads.
> +	 */
> +	symbol_conf.keep_exited_threads = true;
> +
>  	annotation_options__init(&report.annotation_opts);
>  
>  	ret = perf_config(report__config, &report);
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 90c750150b19..a985d004aa8d 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -2157,9 +2157,13 @@ int machine__process_exit_event(struct machine *machine, union perf_event *event
>  	if (dump_trace)
>  		perf_event__fprintf_task(event, stdout);
>  
> -	if (thread != NULL)
> -		thread__put(thread);
> -
> +	if (thread != NULL) {
> +		if (symbol_conf.keep_exited_threads)
> +			thread__set_exited(thread, /*exited=*/true);
> +		else
> +			machine__remove_thread(machine, thread);
> +	}
> +	thread__put(thread);
>  	return 0;
>  }
>  
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 1e9aa8ed15b6..c6afba7ab1a5 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -115,6 +115,11 @@ static int perf_session__open(struct perf_session *session, int repipe_fd)
>  		return -1;
>  	}
>  
> +	if (perf_header__has_feat(&session->header, HEADER_AUXTRACE)) {
> +		/* Auxiliary events may reference exited threads, hold onto dead ones. */
> +		symbol_conf.keep_exited_threads = true;
> +	}
> +
>  	if (perf_data__is_pipe(data))
>  		return 0;
>  
> diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
> index 2b2fb9e224b0..6040286e07a6 100644
> --- a/tools/perf/util/symbol_conf.h
> +++ b/tools/perf/util/symbol_conf.h
> @@ -43,7 +43,8 @@ struct symbol_conf {
>  			disable_add2line_warn,
>  			buildid_mmap2,
>  			guest_code,
> -			lazy_load_kernel_maps;
> +			lazy_load_kernel_maps,
> +			keep_exited_threads;
>  	const char	*vmlinux_name,
>  			*kallsyms_name,
>  			*source_prefix,
> diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
> index e79225a0ea46..0df775b5c110 100644
> --- a/tools/perf/util/thread.h
> +++ b/tools/perf/util/thread.h
> @@ -36,13 +36,22 @@ struct thread_rb_node {
>  };
>  
>  DECLARE_RC_STRUCT(thread) {
> +	/** @maps: mmaps associated with this thread. */
>  	struct maps		*maps;
>  	pid_t			pid_; /* Not all tools update this */
> +	/** @tid: thread ID number unique to a machine. */
>  	pid_t			tid;
> +	/** @ppid: parent process of the process this thread belongs to. */
>  	pid_t			ppid;
>  	int			cpu;
>  	int			guest_cpu; /* For QEMU thread */
>  	refcount_t		refcnt;
> +	/**
> +	 * @exited: Has the thread had an exit event. Such threads are usually
> +	 * removed from the machine's threads but some events/tools require
> +	 * access to dead threads.
> +	 */
> +	bool			exited;
>  	bool			comm_set;
>  	int			comm_len;
>  	struct list_head	namespaces_list;
> @@ -189,6 +198,11 @@ static inline refcount_t *thread__refcnt(struct thread *thread)
>  	return &RC_CHK_ACCESS(thread)->refcnt;
>  }
>  
> +static inline void thread__set_exited(struct thread *thread, bool exited)
> +{
> +	RC_CHK_ACCESS(thread)->exited = exited;
> +}
> +
>  static inline bool thread__comm_set(const struct thread *thread)
>  {
>  	return RC_CHK_ACCESS(thread)->comm_set;

