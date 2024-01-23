Return-Path: <linux-kernel+bounces-35155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04453838CE9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBCDDB26CD5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AC05EE84;
	Tue, 23 Jan 2024 11:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g93HG1ct"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88185EE66;
	Tue, 23 Jan 2024 11:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706007901; cv=none; b=Q+1sikuWFnjCqfZBs5jcECvTDTEbAVZnj9TMy5S9y3Y16iKoJo1aXf5xoVvzQaVDdKe12shLW1b7auYYh2+sVsoSMq5dEBPtuww/Z8O35aw6T1A44Zvf1JuJrd4BIjPMir6Qyu98mJPWqrU4/uxTGbm6juZJ2Izz68pqeYzN9h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706007901; c=relaxed/simple;
	bh=WKeHkcLVdNzwTogDGSQCrv2EoH0ey3sbC8/sZ+MwpjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tz35oAGEbor5otYFgTN1YzSKsEivmZ334S99zq8X/iOeHLA9Mh+N5hWdlTHF98KBFkyS5Eu3vC2wPwbcQvUVJI+pjzBlY48KSZM/RYjX9bZngMpMuZsqpWLZmfpLGOpO1QnauWX1QFlhhqRlz/JxCprM4MoG43W8qgx7fq11nkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g93HG1ct; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706007900; x=1737543900;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WKeHkcLVdNzwTogDGSQCrv2EoH0ey3sbC8/sZ+MwpjY=;
  b=g93HG1ctUHmbRV4hbxycQ7UDhyS5LRv1TZyHuz88gh9FYDpn3G7EicaT
   Bf7XmA5288xai2W4yUrT6nfnjPalWXzcykHfbAz7TARWUws/hrBJ4qMMn
   djOxCP/Lw87O6EoUgxGCLWHpsN23NqigK08ozBlL3sJ4kkGuZ1Z+1YMIY
   O2HJxQb5EYQh2DtmxdiRXt9Na4/8n9PnhjkDxs2/+MdUUiJ2RvZZe83LA
   j0dXN2ZeE/Up0zZc5P4tc7NZzpTBfGhis43iUz/aMA1gbSA1WlhN914Oh
   15Ml+SyNADumINOvqAsgEHhQsPa/gjqUN6PCeeLzfREAXShPUmegD+P2s
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="14838874"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="14838874"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 03:05:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="1505734"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.57.4])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 03:04:55 -0800
Message-ID: <8568a3c6-00c9-4801-b710-e70cc06e021b@intel.com>
Date: Tue, 23 Jan 2024 13:04:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tools: perf: Expose sample ID / stream ID to python
 scripts
Content-Language: en-US
To: Ben Gainey <ben.gainey@arm.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 namhyung@kernel.org, irogers@google.com, will@kernel.org
References: <20240123103137.1890779-1-ben.gainey@arm.com>
 <20240123103137.1890779-2-ben.gainey@arm.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240123103137.1890779-2-ben.gainey@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/01/24 12:31, Ben Gainey wrote:
> perf script exposes the evsel_name to python scripts as part of the data
> passed to the sample or tracepoint handler function, and it passes the id and
> stream_id to the throttled/unthrottled handler functions. This makes matching
> throttle events and samples difficult.
> 
> To make this possible, this change exposes the sample id and stream_id values
> to the script.
> 
> Signed-off-by: Ben Gainey <ben.gainey@arm.com>
> ---
>  tools/perf/Documentation/perf-script-python.txt        | 4 ++--
>  tools/perf/util/scripting-engines/trace-event-python.c | 8 +++++++-
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-script-python.txt b/tools/perf/Documentation/perf-script-python.txt
> index 6a8581012e162..13e37e9385ee4 100644
> --- a/tools/perf/Documentation/perf-script-python.txt
> +++ b/tools/perf/Documentation/perf-script-python.txt
> @@ -642,8 +642,8 @@ SUPPORTED FIELDS
>  
>  Currently supported fields:
>  
> -ev_name, comm, pid, tid, cpu, ip, time, period, phys_addr, addr,
> -symbol, symoff, dso, time_enabled, time_running, values, callchain,
> +ev_name, comm, id, stream_id, pid, tid, cpu, ip, time, period, phys_addr,
> +addr, symbol, symoff, dso, time_enabled, time_running, values, callchain,
>  brstack, brstacksym, datasrc, datasrc_decode, iregs, uregs,
>  weight, transaction, raw_buf, attr, cpumode.
>  
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> index 860e1837ba969..d88966645b2f4 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -858,6 +858,10 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
>  	pydict_set_item_string_decref(dict, "ev_name", _PyUnicode_FromString(evsel__name(evsel)));
>  	pydict_set_item_string_decref(dict, "attr", _PyBytes_FromStringAndSize((const char *)&evsel->core.attr, sizeof(evsel->core.attr)));
>  
> +	pydict_set_item_string_decref(dict_sample, "id",
> +			PyLong_FromUnsignedLongLong(sample->id));
> +	pydict_set_item_string_decref(dict_sample, "stream_id",
> +			PyLong_FromUnsignedLongLong(sample->stream_id));
>  	pydict_set_item_string_decref(dict_sample, "pid",
>  			_PyLong_FromLong(sample->pid));
>  	pydict_set_item_string_decref(dict_sample, "tid",
> @@ -1306,7 +1310,7 @@ static void python_export_sample_table(struct db_export *dbe,
>  	struct tables *tables = container_of(dbe, struct tables, dbe);
>  	PyObject *t;
>  
> -	t = tuple_new(25);
> +	t = tuple_new(27);
>  
>  	tuple_set_d64(t, 0, es->db_id);
>  	tuple_set_d64(t, 1, es->evsel->db_id);
> @@ -1333,6 +1337,8 @@ static void python_export_sample_table(struct db_export *dbe,
>  	tuple_set_d64(t, 22, es->sample->insn_cnt);
>  	tuple_set_d64(t, 23, es->sample->cyc_cnt);
>  	tuple_set_s32(t, 24, es->sample->flags);
> +	tuple_set_d64(t, 25, es->sample->id);
> +	tuple_set_d64(t, 26, es->sample->stream_id);

Unless you actually plan to use the db_export interface with
these, there is no need to add them at this time.

>  
>  	call_object(tables->sample_handler, t, "sample_table");
>  


