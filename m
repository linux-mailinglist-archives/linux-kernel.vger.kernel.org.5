Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B1C7F0D06
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 08:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjKTHwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 02:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKTHwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 02:52:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DF9B4;
        Sun, 19 Nov 2023 23:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700466752; x=1732002752;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dArwzQiDbI+Mn5NFShSzQiDLHCFzEJbY1RjkIBlYTVI=;
  b=MWXIh6Xpe2Ux5tA8VBK5yeo/Vtzvf4I5iygsrHE5BkN9VGyoTN9xj9Kw
   XSQKI7+ewanky8KwDtOOzSo/5Nn2+knNC/nsb/ydxhvVfI/yCIC0Uk0ob
   oXcCuBAFXAbT+Lg+u1a17Pr1kpBWcibzrX93l0tmCot7QF8GeQzoxo3z3
   YPnWoPN466aJ6DOMutdxTNKYfKoQZ+F7/yWqldRTywAhIdzS98hqlM6Zh
   rsz9+XYILAqttkjKKk72RZwYpXbGyr/NX4qMamigLj5gb8LYbC7IB2m+J
   5p6qOUNBsJvra9E7KLfaT4aYQu926SEYPZPRZ+CEc5ULZtP5kT0XFPxVx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="4746849"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="4746849"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 23:52:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="14513096"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.219.253])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 23:52:27 -0800
Message-ID: <551d8ee8-416b-47b4-b405-b4d39e46b333@intel.com>
Date:   Mon, 20 Nov 2023 09:52:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] perf script python: Fail check on dynamic allocation
Content-Language: en-US
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
References: <20231119040943.13500-1-p4ranlee@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231119040943.13500-1-p4ranlee@gmail.com>
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

On 19/11/23 06:09, Paran Lee wrote:
> Add PyList_New() Fail check in
> get_field_numeric_entry() function
> and dynamic allocation checking for
> set_regs_in_dict(), python_start_script().

Try to wrap lines at 75 characters (max).

> 
> Signed-off-by: Paran Lee <p4ranlee@gmail.com>
> Reviewed-by: Seonghee Jin<shjy180909@gmail.com>

Other instances of that email address in the kernel git repo
use the name MichelleJin <shjy180909@gmail.com>.  Might as well
be consistent.

> ---
>  .../util/scripting-engines/trace-event-python.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> index 94312741443a..f96968ba371f 100644
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
> +	if (!set_regs_in_dict(dict, sample, evsel))

The condition is the wrong way around.

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

