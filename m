Return-Path: <linux-kernel+bounces-75231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 366DD85E4F1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59F481C23A7A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF7E84A4C;
	Wed, 21 Feb 2024 17:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3A0o2Bx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D159F1C20;
	Wed, 21 Feb 2024 17:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708537968; cv=none; b=RhZQCtgcYuA41vvb/9oBPOE67fSU82SX6ImxmG00gPnalPrVUWD5MlI95/La9FwvWzHzvxLljO55SmsSB2Cv6BJXWBVkUDK0s/BSF6fJoo5l0RpiK44BcSf8vzTD7wY1RUzYdxkNSangzLa4NmXP4PmPDoTgVCwgKTCV9e/iHxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708537968; c=relaxed/simple;
	bh=IKee1AmsQtKeY/pOHr7cvRpR/aRhR2L3PLSUcLTKyb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AH1u6C134+NDC5TIAoGqpVHCGP5uTNNP8oZAsBGfou7waSw2Kbkas4awZo0VNpsLB8iNYq+FOLz0eflWuvzjyiaNyNkpOX0ZJ8hpcQIttxFWW3NBSj20sq0lr5ltofVI1yfCV0Fr6vudajsq//DgpYoC4VSQjVnFrPmYXt2R5tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3A0o2Bx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87689C433F1;
	Wed, 21 Feb 2024 17:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708537968;
	bh=IKee1AmsQtKeY/pOHr7cvRpR/aRhR2L3PLSUcLTKyb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N3A0o2BxELZ/boKITgo4PEeoQrahbLiH2HaqZH/GSxoGEY8MkRjeOX5MSyxHv7gmk
	 70KcT4EFVaIR4cQS9KMIaN8urAR44pRZyrI2pIqZxL+TkTB2h//xtwOSBqao+320EN
	 CcXiYZycFmO3u8Y0dqzU+43aUD8aVON99/cM0JrlsebNAKROpqdBWfOMVc4Yq1nVad
	 Zzia8XdbD1IM4OUZyAjwR5ERft9uVeQ8JOghPP5NpVqOybi+WrCNgc/BjkU2bup5PW
	 fqDiM/UcR5MglosjpCjGNd09Rfwi53hPG10hZlCUFI4dxi1EKIEV/CQHKJj4kUt0iw
	 5crV2yPfCXk6A==
Date: Wed, 21 Feb 2024 14:52:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: weilin.wang@intel.com
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>
Subject: Re: [RFC PATCH v1 2/5] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
Message-ID: <ZdY4a5yx-C9ziobq@x1>
References: <20240221072100.412939-1-weilin.wang@intel.com>
 <20240221072100.412939-3-weilin.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221072100.412939-3-weilin.wang@intel.com>

On Wed, Feb 21, 2024 at 02:20:56AM -0500, weilin.wang@intel.com wrote:
> From: Weilin Wang <weilin.wang@intel.com>

You wrote no description for this patch, please add one and show
examples of the feature being used, if possible.

See below for more comments.
 
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> +static int __cmd_script(struct child_process *cmd __maybe_unused)
> +{
> +	int err = 0;
> +	struct perf_session *session;
> +	struct perf_data data = {
> +		.mode = PERF_DATA_MODE_READ,
> +		.path = PERF_DATA,
> +		.fd   = cmd->out,
> +	};
> +	struct perf_script script = {
> +		.tool = {
> +		.sample		 = process_sample_event,
> +		.ordered_events	 = true,
> +		.ordering_requires_timestamps = true,
> +		.feature	 = process_feature_event,
> +		.attr		 = perf_event__process_attr,
> +		},
> +	};
> +	struct tpebs_event *e;
> +
> +	list_for_each_entry(e, &stat_config.tpebs_events, nd) {
> +		struct tpebs_retire_lat *new = malloc(sizeof(struct tpebs_retire_lat));
> +
> +		if (!new)
> +			return -1;
> +		new->name = strdup(e->name);
> +		new->tpebs_name = strdup(e->tpebs_name);
> +		new->count = 0;
> +		new->sum = 0;

Without even having thought that much about this overall architecture,
that looks too heavy at first sight, the above is done in tools/perf/
as:

void tpebs_retire_lat__delete(struct tpebs_retire_lat *retire_lat)
{
	if (retire_lat == NULL)
		return;

	zfree(&retire_lat->tpebs_name);
	zfree(&retire_lat->tpebs_name);
}

struct tpebs_retire_lat__new(tpebs_event *e)
{
	struct tpebs_retire_lat *retire_lat = zalloc(sizeof(*retire_lat));

	if (retire_lat != NULL) {
		retire_lat->name = strdup(e->name);
		retire_lat->tpebs_name = strdup(e->tpebs_name);

		if (retire_lat->name == NULL || retire_lat->tpebs_name == NULL) {
			tpebs_retire_lat__delete(retire_lat);
			retire_lat = NULL;
		}
	}

	return retire_lat;
}

And then you call the constructor  in that loop, and the destructor at
some point when those data structures are not needed.

We do it because perf has a TUI mode and we may end up calling tools
from them in a long running session, so we need to avoid leaks.

Also can we somehow hide Intel specific terms in arch specific files
while leaving something generic, possibly implementable in other arches
in the core code? I mean hiding clearly intel specific stuff like the
"tpebs" term in tools/perf/arch/x86/.

> +		list_add_tail(&new->nd, &stat_config.tpebs_results);
> +	}
> +
> +	kill(cmd->pid, SIGTERM);
> +	session = perf_session__new(&data, &script.tool);
> +	if (IS_ERR(session))
> +		return PTR_ERR(session);
> +	script.session = session;
> +	err = perf_session__process_events(session);
> +	perf_session__delete(session);
> +
> +	return err;
> +}
> +
>  static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  {
>  	int interval = stat_config.interval;
> @@ -709,12 +866,14 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  	struct affinity saved_affinity, *affinity = NULL;
>  	int err;
>  	bool second_pass = false;
> +	struct child_process cmd;
>  
>  	//Prepare perf record for sampling event retire_latency before fork and prepare workload
>  	if (stat_config.tpebs_event_size > 0) {
>  		int ret;
>  
> -		ret = __run_perf_record();
> +		pr_debug("perf stat pid = %d\n", getpid());
> +		ret = prepare_perf_record(&cmd);
>  		if (ret)
>  			return ret;
>  	}
> @@ -924,6 +1083,17 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  
>  	t1 = rdclock();
>  
> +	if (stat_config.tpebs_event_size > 0) {
> +		int ret;
> +
> +		pr_debug("pid = %d\n", getpid());
> +		pr_debug("cmd.pid = %d\n", cmd.pid);
> +
> +		ret = __cmd_script(&cmd);
> +		close(cmd.out);
> +		pr_debug("%d\n", ret);
> +	}
> +
>  	if (stat_config.walltime_run_table)
>  		stat_config.walltime_run[run_idx] = t1 - t0;
>  
> @@ -2714,6 +2884,7 @@ int cmd_stat(int argc, const char **argv)
>  	}
>  
>  	INIT_LIST_HEAD(&stat_config.tpebs_events);
> +	INIT_LIST_HEAD(&stat_config.tpebs_results);
>  
>  	/*
>  	 * Metric parsing needs to be delayed as metrics may optimize events
> @@ -2921,5 +3092,7 @@ int cmd_stat(int argc, const char **argv)
>  	metricgroup__rblist_exit(&stat_config.metric_events);
>  	evlist__close_control(stat_config.ctl_fd, stat_config.ctl_fd_ack, &stat_config.ctl_fd_close);
>  
> +	tpebs_data__delete();
> +
>  	return status;
>  }
> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> index fc16299c915f..2298ca3b370b 100644
> --- a/tools/perf/util/data.c
> +++ b/tools/perf/util/data.c
> @@ -173,6 +173,10 @@ static bool check_pipe(struct perf_data *data)
>  	int fd = perf_data__is_read(data) ?
>  		 STDIN_FILENO : STDOUT_FILENO;
>  
> +	if (data->fd > 0) {
> +		fd = data->fd;
> +	}
> +
>  	if (!data->path) {
>  		if (!fstat(fd, &st) && S_ISFIFO(st.st_mode))
>  			is_pipe = true;
> diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
> index effcc195d7e9..5554d46ad212 100644
> --- a/tools/perf/util/data.h
> +++ b/tools/perf/util/data.h
> @@ -28,6 +28,7 @@ struct perf_data_file {
>  
>  struct perf_data {
>  	const char		*path;
> +	int			 fd;
>  	struct perf_data_file	 file;
>  	bool			 is_pipe;
>  	bool			 is_dir;
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 6c16e5a0b1fc..8518e2b3e5be 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -691,8 +691,17 @@ static int metricgroup__build_event_string(struct strbuf *events,
>  
>  		if (p) {
>  			struct tpebs_event *new_event = malloc(sizeof(struct tpebs_event));
> -			*p = '\0';
> +			char *name;
> +
>  			new_event->tpebs_name = strdup(id);
> +			*p = '\0';
> +			name = malloc(strlen(id) + 2);
> +			if (!name)
> +				return -ENOMEM;
> +
> +			strcpy(name, id);
> +			strcat(name, ":p");
> +			new_event->name = name;

For such cases we use asprintf(), that allocates and formats the string
in one call, look for examples in other tools/perf/ files.

>  			*tpebs_event_size += 1;
>  			pr_debug("retire_latency required, tpebs_event_size=%lu, new_event=%s\n",
>  			*tpebs_event_size, new_event->name);
> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
> index 7c24ed768ff3..1fa12cc3294e 100644
> --- a/tools/perf/util/metricgroup.h
> +++ b/tools/perf/util/metricgroup.h
> @@ -71,6 +71,13 @@ struct tpebs_event {
>  	const char *name;
>  	const char *tpebs_name;
>  };
> +struct tpebs_retire_lat {
> +	struct list_head nd;
> +	const char *name;
> +	const char *tpebs_name;
> +	size_t count;
> +	int sum;
> +};

Here you declare the constructor and destructor I suggested above.
  
>  struct metric_event *metricgroup__lookup(struct rblist *metric_events,
>  					 struct evsel *evsel,
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index 9d0186316b29..8e180f13aa2d 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -111,6 +111,9 @@ struct perf_stat_config {
>  	struct rblist		 metric_events;
>  	struct list_head	 tpebs_events;
>  	size_t			 tpebs_event_size;
> +	struct list_head	 tpebs_results;
> +	pid_t			 tpebs_pid;
> +	int			 tpebs_pipe;
>  	int			 ctl_fd;
>  	int			 ctl_fd_ack;
>  	bool			 ctl_fd_close;
> -- 
> 2.43.0
> 

