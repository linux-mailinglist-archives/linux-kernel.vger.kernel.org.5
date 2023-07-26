Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B84763F80
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 21:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjGZT0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 15:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjGZT0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 15:26:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533A82722;
        Wed, 26 Jul 2023 12:26:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C41E461CAB;
        Wed, 26 Jul 2023 19:26:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C5AC433C8;
        Wed, 26 Jul 2023 19:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690399581;
        bh=dbIwUSErpljSFjSlNL6UV2E5yY64QH+jCpPm7PZ5xfY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Iac3BijivUSkcHBBk+DCzxdixpbJR6KfDx93tiVepIrblkU83LY3Am01/NsV/8UEo
         mgq3oatxKDla0pFMRcNc9Y4nvAhEKWSsMtYna1kU/h4qXUuZekzNTWEyN4iZg1vS5r
         RG6LcWDc7gQnsl4dNiZScOeFxgbGMWjWyIxanuNXLqnELz+Kd7R6M+aNABlQJaFWOZ
         ZMnzNxg1sTXfM40cgYGK8YiOpaKTwPoHIH9MUscJJcFC2Gn1ccqufGsRTHBIEJJxMt
         8pB61f9rFck0CrGGhwkjqPbv2fJcYJxbKxG5V68PYup3j+ZlHAgVNN8IkOqh++sNkS
         wDpksMumoGAZw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D608B40516; Wed, 26 Jul 2023 16:26:17 -0300 (-03)
Date:   Wed, 26 Jul 2023 16:26:17 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf tools: Add kallsyms__get_symbol_start()
Message-ID: <ZMFzWcKUn2M2j9lF@kernel.org>
References: <20230725001929.368041-1-namhyung@kernel.org>
 <9e0147e3-2a6a-6b84-bdfa-365c0762058a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e0147e3-2a6a-6b84-bdfa-365c0762058a@intel.com>
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

Em Tue, Jul 25, 2023 at 05:07:40PM +0300, Adrian Hunter escreveu:
> On 25/07/23 03:19, Namhyung Kim wrote:
> > The kallsyms__get_symbol_start() to get any symbol address from
> > kallsyms.  The existing kallsyms__get_function_start() only allows text
> > symbols so create this to allow data symbols too.
> > 
> > Acked-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied both patches.

- Arnaldo
 
> > ---
> >  tools/perf/util/event.c | 30 +++++++++++++++++++++++++++---
> >  tools/perf/util/event.h |  2 ++
> >  2 files changed, 29 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> > index 4cbb092e0684..923c0fb15122 100644
> > --- a/tools/perf/util/event.c
> > +++ b/tools/perf/util/event.c
> > @@ -93,8 +93,8 @@ struct process_symbol_args {
> >  	u64	   start;
> >  };
> >  
> > -static int find_symbol_cb(void *arg, const char *name, char type,
> > -			  u64 start)
> > +static int find_func_symbol_cb(void *arg, const char *name, char type,
> > +			       u64 start)
> >  {
> >  	struct process_symbol_args *args = arg;
> >  
> > @@ -110,12 +110,36 @@ static int find_symbol_cb(void *arg, const char *name, char type,
> >  	return 1;
> >  }
> >  
> > +static int find_any_symbol_cb(void *arg, const char *name,
> > +			      char type __maybe_unused, u64 start)
> > +{
> > +	struct process_symbol_args *args = arg;
> > +
> > +	if (strcmp(name, args->name))
> > +		return 0;
> > +
> > +	args->start = start;
> > +	return 1;
> > +}
> > +
> >  int kallsyms__get_function_start(const char *kallsyms_filename,
> >  				 const char *symbol_name, u64 *addr)
> >  {
> >  	struct process_symbol_args args = { .name = symbol_name, };
> >  
> > -	if (kallsyms__parse(kallsyms_filename, &args, find_symbol_cb) <= 0)
> > +	if (kallsyms__parse(kallsyms_filename, &args, find_func_symbol_cb) <= 0)
> > +		return -1;
> > +
> > +	*addr = args.start;
> > +	return 0;
> > +}
> > +
> > +int kallsyms__get_symbol_start(const char *kallsyms_filename,
> > +			       const char *symbol_name, u64 *addr)
> > +{
> > +	struct process_symbol_args args = { .name = symbol_name, };
> > +
> > +	if (kallsyms__parse(kallsyms_filename, &args, find_any_symbol_cb) <= 0)
> >  		return -1;
> >  
> >  	*addr = args.start;
> > diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
> > index de20e01c9d72..d8bcee2e9b93 100644
> > --- a/tools/perf/util/event.h
> > +++ b/tools/perf/util/event.h
> > @@ -360,6 +360,8 @@ size_t perf_event__fprintf(union perf_event *event, struct machine *machine, FIL
> >  
> >  int kallsyms__get_function_start(const char *kallsyms_filename,
> >  				 const char *symbol_name, u64 *addr);
> > +int kallsyms__get_symbol_start(const char *kallsyms_filename,
> > +			       const char *symbol_name, u64 *addr);
> >  
> >  void event_attr_init(struct perf_event_attr *attr);
> >  
> 

-- 

- Arnaldo
