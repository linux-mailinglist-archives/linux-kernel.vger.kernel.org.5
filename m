Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967987F34DD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 18:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234171AbjKURVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 12:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbjKURVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 12:21:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B016DD50
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:21:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D45CC433C7;
        Tue, 21 Nov 2023 17:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700587304;
        bh=aTJWlG4/89RSZo7lqtYiYHxKSO1In+COa2oKMyyaAiw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tdjlrNYsCBlBXHs2rsBylv2ju5LVVItyFohcZG+xaLMlxMolNHhN+NYggcVDFfmrG
         G4Sszr55VVjURjnulIp3T3OlqW35DHecMV9DvFnvaemwlCzy7e2m8aGzQILrjpKbYx
         smPRIBNbEUQQSRyxg3RcCMAI3vW5S8cPTO746siMRoTBgQqmV2JwZ1CrPxo86qZM6B
         tmB5mcXzQT6E4SvIjTz249mjIDmYznD7+C9YKfeBpvYxlvTdlgj0AFfRbwr/PVL9ka
         datQzrF07aoJWBtbRKhP/U9oYfyMnRaJ1sz10tuk50ntDyZ3GjJNX/Fw1y8obL9tVa
         c78O/nFLpWXwA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1EF9B40094; Tue, 21 Nov 2023 14:21:41 -0300 (-03)
Date:   Tue, 21 Nov 2023 14:21:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Paran Lee <p4ranlee@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Li Dong <lidong@vivo.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, shjy180909@gmail.com,
        austindh.kim@gmail.com, honggyu.kp@gmail.com
Subject: Re: [PATCH V3 RESEND] perf script python: Fail check on dynamic
 allocation
Message-ID: <ZVznJS+LF7fySGom@kernel.org>
References: <20231120223218.9036-1-p4ranlee@gmail.com>
 <4890f020-b4ad-4a50-9394-2cf4be1c19ca@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4890f020-b4ad-4a50-9394-2cf4be1c19ca@intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 21, 2023 at 09:39:12AM +0200, Adrian Hunter escreveu:
> On 21/11/23 00:32, Paran Lee wrote:
> > Add PyList_New() Fail check in get_field_numeric_entry()
> > function and dynamic allocation checking for
> > set_regs_in_dict(), python_start_script().
> > 
> > Signed-off-by: Paran Lee <p4ranlee@gmail.com>
> > Reviewed-by: MichelleJin <shjy180909@gmail.com>
> > Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> I did not give a Reviewed-by tag.
> 
> Please never assume someone else's tag.  It breaks the process.
> 
> However, I have now reviewed it, so:
> 
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied.

- Arnaldo
 
> > ---
> >  .../util/scripting-engines/trace-event-python.c | 17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> > index 94312741443a..860e1837ba96 100644
> > --- a/tools/perf/util/scripting-engines/trace-event-python.c
> > +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> > @@ -353,6 +353,8 @@ static PyObject *get_field_numeric_entry(struct tep_event *event,
> >  
> >  	if (is_array) {
> >  		list = PyList_New(field->arraylen);
> > +		if (!list)
> > +			Py_FatalError("couldn't create Python list");
> >  		item_size = field->size / field->arraylen;
> >  		n_items = field->arraylen;
> >  	} else {
> > @@ -754,7 +756,7 @@ static void regs_map(struct regs_dump *regs, uint64_t mask, const char *arch, ch
> >  	}
> >  }
> >  
> > -static void set_regs_in_dict(PyObject *dict,
> > +static int set_regs_in_dict(PyObject *dict,
> >  			     struct perf_sample *sample,
> >  			     struct evsel *evsel)
> >  {
> > @@ -770,6 +772,8 @@ static void set_regs_in_dict(PyObject *dict,
> >  	 */
> >  	int size = __sw_hweight64(attr->sample_regs_intr) * 28;
> >  	char *bf = malloc(size);
> > +	if (!bf)
> > +		return -1;
> >  
> >  	regs_map(&sample->intr_regs, attr->sample_regs_intr, arch, bf, size);
> >  
> > @@ -781,6 +785,8 @@ static void set_regs_in_dict(PyObject *dict,
> >  	pydict_set_item_string_decref(dict, "uregs",
> >  			_PyUnicode_FromString(bf));
> >  	free(bf);
> > +
> > +	return 0;
> >  }
> >  
> >  static void set_sym_in_dict(PyObject *dict, struct addr_location *al,
> > @@ -920,7 +926,8 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
> >  			PyLong_FromUnsignedLongLong(sample->cyc_cnt));
> >  	}
> >  
> > -	set_regs_in_dict(dict, sample, evsel);
> > +	if (set_regs_in_dict(dict, sample, evsel))
> > +		Py_FatalError("Failed to setting regs in dict");
> >  
> >  	return dict;
> >  }
> > @@ -1918,12 +1925,18 @@ static int python_start_script(const char *script, int argc, const char **argv,
> >  	scripting_context->session = session;
> >  #if PY_MAJOR_VERSION < 3
> >  	command_line = malloc((argc + 1) * sizeof(const char *));
> > +	if (!command_line)
> > +		return -1;
> > +
> >  	command_line[0] = script;
> >  	for (i = 1; i < argc + 1; i++)
> >  		command_line[i] = argv[i - 1];
> >  	PyImport_AppendInittab(name, initperf_trace_context);
> >  #else
> >  	command_line = malloc((argc + 1) * sizeof(wchar_t *));
> > +	if (!command_line)
> > +		return -1;
> > +
> >  	command_line[0] = Py_DecodeLocale(script, NULL);
> >  	for (i = 1; i < argc + 1; i++)
> >  		command_line[i] = Py_DecodeLocale(argv[i - 1], NULL);
> 

-- 

- Arnaldo
