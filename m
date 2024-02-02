Return-Path: <linux-kernel+bounces-50211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E626F8475CC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A4F41F2187D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C29114D429;
	Fri,  2 Feb 2024 17:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X3a74InP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BBF149012;
	Fri,  2 Feb 2024 17:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706893698; cv=none; b=QS13IVCQ6jKktY4r/oWeGufe8W8kEw218J5zt/VcoNwhBX+hg/LB7Hoti9QYgabWGqmsz6JhlQEj1ADw9LkXpYnwOC4eF9Ep1Rp5uJVyiPT5o32gO4BXjZQDdh53LxmnjCEapNko3GCtLOvlMHvLUbx0O0lQKogdbXwjoqmR1Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706893698; c=relaxed/simple;
	bh=tjGciSGl0ur/hl1ZLVMU17REAhGH4g8QmpkEWPPJGXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bORiCmf+jxzO5BAYqkE4S5WdWX9sjylUjBneDcJQ3JGYfYDHn+dck5zDYnG/Q4BAISocQ52/fZtHiml2pM9+MFU8FmaOi/tdGya7T33qrCYsN7OQOIxTPkKmYPFeFw/5HEVBmvy66HMkSvzvihji+n9AyJUFwfDJLk8WdmnJkSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X3a74InP; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706893696; x=1738429696;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tjGciSGl0ur/hl1ZLVMU17REAhGH4g8QmpkEWPPJGXY=;
  b=X3a74InPNDt0jl3rD7VRlVWZwrPY5pEvlOogwyOU/x/O+AvjWal6UwIc
   HI2uVmiLPUGryoY001AWQoUuXB7g8WZ7G67DhKOs5q3Pm2E6CmBfzATi2
   /R0YX+5wFYraHNZKek1DwzAprNt9s/Y2+QAvEf1c/iTDiWSA9CBdd93Mq
   3haL8rn1lXG241TaXhFHyt0qvid5ribHNwZYLf1vFF9Z0qziPlchhriej
   7kxNzHDgQzCBOcAhPfVBYN5sBm5V8LJZB/Od6Ped1TrxXesLBkaewi1Uj
   R8Y7VSHlms++RfFm5df4zfrFzb+f4e5TPWu3nT5emf4jNwpUK6ZDm5Kdc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="360197"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="360197"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 09:05:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="126636"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.59.118])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 09:05:49 -0800
Message-ID: <8cea7b3f-1cdf-41e7-a8fb-f5c276973ad6@intel.com>
Date: Fri, 2 Feb 2024 19:05:42 +0200
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

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

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
>  
>  	call_object(tables->sample_handler, t, "sample_table");
>  


