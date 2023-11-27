Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7DA7FA0BA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 14:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbjK0NSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 08:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbjK0NR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 08:17:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CDC10F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 05:18:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A01C433C7;
        Mon, 27 Nov 2023 13:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701091085;
        bh=McrNEpfZZaZARie6QYahkn6MCqkCCeXaKU1VOHtga9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pl2TTh2kcriaU1EUjLRa4gu4jUprUbnia5vCe+KAgNDrKYJX8dgFzPsUswbNMNL/I
         8AzdlrFXpL0pmzcWbUg/qcZ+jxFrX0j2mt/N2pK1sK/H9ai0OwbCMitdmd78IOBau8
         WEIlCVyKm/SshMKPi1akWI8CKHsAHvGD3s0JhCGOLXcKG3JfuaPwTfPsD7fGPJ+J6L
         LJNqcBVbuzfjcBWWEnG7HXcSSDr1X7n8P0NJysuBIGkCoppp8OK4G2HgrbVokqEQNT
         yZMqHSCrSs6eRn0BvSuiGmB8qSnAecgrJdOuZ9/ZbDCR0UlsjY1S4O2yZi2ivp4Wr7
         d2I18wWFr/h7Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1920B40094; Mon, 27 Nov 2023 10:18:03 -0300 (-03)
Date:   Mon, 27 Nov 2023 10:18:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        zhaimingbing <zhaimingbing@cmss.chinamobile.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Li Dong <lidong@vivo.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf lock: Fix a memory leak on an error path
Message-ID: <ZWSXCwrx5BUpYGi/@kernel.org>
References: <20231124092657.10392-1-zhaimingbing@cmss.chinamobile.com>
 <20231124095319.GN3818@noisy.programming.kicks-ass.net>
 <ZWCdg5gcizJitxVw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWCdg5gcizJitxVw@gmail.com>
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

Em Fri, Nov 24, 2023 at 01:56:35PM +0100, Ingo Molnar escreveu:
> 
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Fri, Nov 24, 2023 at 05:26:57PM +0800, zhaimingbing wrote:
> > > if a strdup-ed string is NULL,the allocated memory needs freeing.
> > > 
> > > Signed-off-by: zhaimingbing <zhaimingbing@cmss.chinamobile.com>
> > > ---
> > >  tools/perf/builtin-lock.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> > > index b141f2134..086041bcb 100644
> > > --- a/tools/perf/builtin-lock.c
> > > +++ b/tools/perf/builtin-lock.c
> > > @@ -2228,8 +2228,10 @@ static int __cmd_record(int argc, const char **argv)
> > >  		else
> > >  			ev_name = strdup(contention_tracepoints[j].name);
> > >  
> > > -		if (!ev_name)
> > > +		if (!ev_name) {
> > > +			free(rec_argv);
> > >  			return -ENOMEM;
> > > +		}
> > 
> > Isn't this an error path straight into exit?
> 
> It increases the quality of implementation if resources are free()d 
> consistently regardless of whether the task is going to exit() immediately, 
> for example it makes it easier to validate perf for the lack of memory 
> leaks with Valgrind.

I'm taking this positive comment about the patch as an Acked-by, ok?

- Arnaldo
