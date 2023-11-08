Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1089E7E5AEA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 17:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjKHQPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 11:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjKHQPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 11:15:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797921BDD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 08:14:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA4DC433C7;
        Wed,  8 Nov 2023 16:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699460098;
        bh=x9AiqdNABhWJBcn7lN0wvEkWHm5XpvpOL/ArzqLMP9I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WWfCzv8HYv2DyvNATYj4ofVaqohC/6tedx5T/306ICURUF6V4mr9osCeL+OFF90Nj
         9M2KONYWc1JNr/9CD+S8pqb06rK0PHwr1qduPll26oqHtVnaCGGY5sXyRWdNOQhUwJ
         i5NULg7MOto7TR3Mu5Z9k8DLcWXHLHm/3/CabGP5MnHudnCEMW/4/QGqWLY62t95F1
         So3pPGvQNQ0IdazUo9ncxKXl95DevKuT/M51gvrFwjDGob9hYyQmR6CAOgWa6qlzoH
         OSNRLfaNT3cd25HUgfStpJfepEMYQm6Vt5HBnV0CYyeHXTDROf/0pTQw08b5Tc+VGC
         551ohL8ajEYrg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D4C074035D; Wed,  8 Nov 2023 13:14:55 -0300 (-03)
Date:   Wed, 8 Nov 2023 13:14:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>, Song Liu <songliubraving@fb.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
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
Subject: Re: [PATCH v4 12/53] perf bpf: Don't synthesize BPF events when
 disabled
Message-ID: <ZUuz/8EC0orXCffn@kernel.org>
References: <20231102175735.2272696-1-irogers@google.com>
 <20231102175735.2272696-13-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102175735.2272696-13-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 02, 2023 at 10:56:54AM -0700, Ian Rogers escreveu:
> If BPF sideband events are disabled on the command line, don't
> synthesize BPF events too.


Interesting, in 71184c6ab7e60fd5 ("perf record: Replace option
--bpf-event with --no-bpf-event") we checked that, but only down at
perf_event__synthesize_one_bpf_prog(), where we have:

        if (!opts->no_bpf_event) {
                /* Synthesize PERF_RECORD_BPF_EVENT */
                *bpf_event = (struct perf_record_bpf_event)


So we better remove that, now redundant check? I'll apply your patch as
is and then we can remove that other check.

Song, can I have your Acked-by or Reviewed-by, please?

- Arnaldo


 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/bpf-event.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> index 38fcf3ba5749..830711cae30d 100644
> --- a/tools/perf/util/bpf-event.c
> +++ b/tools/perf/util/bpf-event.c
> @@ -386,6 +386,9 @@ int perf_event__synthesize_bpf_events(struct perf_session *session,
>  	int err;
>  	int fd;
>  
> +	if (opts->no_bpf_event)
> +		return 0;
> +
>  	event = malloc(sizeof(event->bpf) + KSYM_NAME_LEN + machine->id_hdr_size);
>  	if (!event)
>  		return -1;
> -- 
> 2.42.0.869.gea05f2083d-goog
> 

-- 

- Arnaldo
