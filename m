Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3237F267C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 08:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjKUHjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 02:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjKUHjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 02:39:37 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2E3C3;
        Mon, 20 Nov 2023 23:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700552372; x=1732088372;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8+iupdkYjP2gRjVTUeD0WGE4EXxdTodJbZkzY2nHgKI=;
  b=LfnIPw+o1WKAUp9Yh4fwQUqKoX0tzVf8f96ESfqDmqVTpY1NMl2OQjeg
   pCEQm+94pxEetjteERA3qF5SLs5HfsFpjmbXza7tUXw6OCBvmXIrMYKua
   OmxtZTYo8SCz1mDTRdsB6s+76NDQbCiZ61wCKUzYFau7ePp7uC4Bubyeg
   WcXS3PBFqqY8tbbUaJe4AITncu077o3XYTojmKipxPzRfoQdRnEcP6My+
   ty80tHh9ozXKp4jK27t4nBXYtGbFcbfzyKpjTauMpquiLKXuCxxqhadKf
   LtmL30K2XZs9xPhp4ar7aCq6Cpz5kvZU5m739tztqyBiV5nGF6LuVM63M
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="391561063"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="391561063"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 23:39:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="716441517"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="716441517"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.56.230])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 23:39:18 -0800
Message-ID: <4890f020-b4ad-4a50-9394-2cf4be1c19ca@intel.com>
Date:   Tue, 21 Nov 2023 09:39:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 RESEND] perf script python: Fail check on dynamic
 allocation
To:     Paran Lee <p4ranlee@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Li Dong <lidong@vivo.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        shjy180909@gmail.com, austindh.kim@gmail.com, honggyu.kp@gmail.com
References: <20231120223218.9036-1-p4ranlee@gmail.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231120223218.9036-1-p4ranlee@gmail.com>
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

On 21/11/23 00:32, Paran Lee wrote:
> Add PyList_New() Fail check in get_field_numeric_entry()
> function and dynamic allocation checking for
> set_regs_in_dict(), python_start_script().
> 
> Signed-off-by: Paran Lee <p4ranlee@gmail.com>
> Reviewed-by: MichelleJin <shjy180909@gmail.com>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

I did not give a Reviewed-by tag.

Please never assume someone else's tag.  It breaks the process.

However, I have now reviewed it, so:

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  .../util/scripting-engines/trace-event-python.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> index 94312741443a..860e1837ba96 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -353,6 +353,8 @@ static PyObject *get_field_numeric_entry(struct tep_event *event,
>  
>  	if (is_array) {
>  		list = PyList_New(field->arraylen);
> +		if (!list)
> +			Py_FatalError("couldn't create Python list");
>  		item_size = field->size / field->arraylen;
>  		n_items = field->arraylen;
>  	} else {
> @@ -754,7 +756,7 @@ static void regs_map(struct regs_dump *regs, uint64_t mask, const char *arch, ch
>  	}
>  }
>  
> -static void set_regs_in_dict(PyObject *dict,
> +static int set_regs_in_dict(PyObject *dict,
>  			     struct perf_sample *sample,
>  			     struct evsel *evsel)
>  {
> @@ -770,6 +772,8 @@ static void set_regs_in_dict(PyObject *dict,
>  	 */
>  	int size = __sw_hweight64(attr->sample_regs_intr) * 28;
>  	char *bf = malloc(size);
> +	if (!bf)
> +		return -1;
>  
>  	regs_map(&sample->intr_regs, attr->sample_regs_intr, arch, bf, size);
>  
> @@ -781,6 +785,8 @@ static void set_regs_in_dict(PyObject *dict,
>  	pydict_set_item_string_decref(dict, "uregs",
>  			_PyUnicode_FromString(bf));
>  	free(bf);
> +
> +	return 0;
>  }
>  
>  static void set_sym_in_dict(PyObject *dict, struct addr_location *al,
> @@ -920,7 +926,8 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
>  			PyLong_FromUnsignedLongLong(sample->cyc_cnt));
>  	}
>  
> -	set_regs_in_dict(dict, sample, evsel);
> +	if (set_regs_in_dict(dict, sample, evsel))
> +		Py_FatalError("Failed to setting regs in dict");
>  
>  	return dict;
>  }
> @@ -1918,12 +1925,18 @@ static int python_start_script(const char *script, int argc, const char **argv,
>  	scripting_context->session = session;
>  #if PY_MAJOR_VERSION < 3
>  	command_line = malloc((argc + 1) * sizeof(const char *));
> +	if (!command_line)
> +		return -1;
> +
>  	command_line[0] = script;
>  	for (i = 1; i < argc + 1; i++)
>  		command_line[i] = argv[i - 1];
>  	PyImport_AppendInittab(name, initperf_trace_context);
>  #else
>  	command_line = malloc((argc + 1) * sizeof(wchar_t *));
> +	if (!command_line)
> +		return -1;
> +
>  	command_line[0] = Py_DecodeLocale(script, NULL);
>  	for (i = 1; i < argc + 1; i++)
>  		command_line[i] = Py_DecodeLocale(argv[i - 1], NULL);

