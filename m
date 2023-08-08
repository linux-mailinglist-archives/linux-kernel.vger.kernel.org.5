Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F59774295
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbjHHRqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234805AbjHHRpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:45:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E62125EF4;
        Tue,  8 Aug 2023 09:20:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0E1C62584;
        Tue,  8 Aug 2023 13:48:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF99C433C7;
        Tue,  8 Aug 2023 13:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691502502;
        bh=78w+7dkfFtK7dL4kn2g0lfF/02wfP7Nhon1XKyRpSpE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Avjv6yfyDTyTM0f83g7YdgTrvEheCdOzZFbRLI5TlArHSsiy7fQZyhEDoP4wkigkg
         F2ySJsiwEn+KHyuYpMlJttGnzEMfMBO4bdzAOzLsECgctWBblbE3+YeiMBYswKZ92O
         1+ie9OHQacqMABW9oYstbWc42TRWrM2e4fEB5QjvwFomAEeG6TJoGmTg+0ukMnnJOC
         4/chym1Q/BNYwAjNkd7uaPStqk49zlvi5VsIZbnB9NfmRwTOom/hrOvc/2inQ4cFJM
         QovfYpYbJnlJloPZ8SLxGTXDSGCfL/qBYmfNj2oxBIO3P9GLQUbjYOD6HN8a1Qu6L6
         jxQlSi7SUZC8g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5D5E0404DF; Tue,  8 Aug 2023 10:48:19 -0300 (-03)
Date:   Tue, 8 Aug 2023 10:48:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>,
        Ivan Babrou <ivan@cloudflare.com>
Cc:     Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
        kernel-team@cloudflare.com, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] perf script: print cgroup on the same line as comm
Message-ID: <ZNJHo+1vhHbd65C0@kernel.org>
References: <CABWYdi2MwP1u5V+RCpvSjqazo7rS9h_oZoJN6o0UoWFdSQNOyQ@mail.gmail.com>
 <ZNJGunGxqspEB5iC@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZNJGunGxqspEB5iC@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 08, 2023 at 10:44:26AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Aug 07, 2023 at 11:02:01AM -0700, Ivan Babrou escreveu:
> > On Fri, Jul 28, 2023 at 10:57 AM Ian Rogers <irogers@google.com> wrote:
> > > On Fri, Jul 28, 2023 at 10:42 AM Ivan Babrou <ivan@cloudflare.com> wrote:
> > > > On Mon, Jul 17, 2023 at 5:07 PM Ivan Babrou <ivan@cloudflare.com> wrote:
> > > > > Commit 3fd7a168bf51 ("perf script: Add 'cgroup' field for output")
> > > > > added support for printing cgroup path in perf script output.
> 
> > > > > It was okay if you didn't want any stacks:
> 
> > > > >     $ sudo perf script --comms jpegtran:23f4bf -F comm,tid,cpu,time,cgroup
> > > > >     jpegtran:23f4bf 3321915 [013] 404718.587488:  /idle.slice/polish.service
> > > > >     jpegtran:23f4bf 3321915 [031] 404718.592073:  /idle.slice/polish.service
> 
> > > > > With stacks it gets messier as cgroup is printed after the stack:
> 
> > > > >     $ perf script --comms jpegtran:23f4bf -F comm,tid,cpu,time,cgroup,ip,sym
> > > > >     jpegtran:23f4bf 3321915 [013] 404718.587488:
> > > > >                     5c554 compress_output
> > > > >                     570d9 jpeg_finish_compress
> > > > >                     3476e jpegtran_main
> > > > >                     330ee jpegtran::main
> > > > >                     326e2 core::ops::function::FnOnce::call_once (inlined)
> > > > >                     326e2 std::sys_common::backtrace::__rust_begin_short_backtrace
> > > > >     /idle.slice/polish.service
> > > > >     jpegtran:23f4bf 3321915 [031] 404718.592073:
> > > > >                     8474d jsimd_encode_mcu_AC_first_prepare_sse2.PADDING
> > > > >                 55af68e62fff [unknown]
> > > > >     /idle.slice/polish.service
> > > > >
> > > > > Let's instead print cgroup on the same line as comm:
> > > > >
> > > > >     $ perf script --comms jpegtran:23f4bf -F comm,tid,cpu,time,cgroup,ip,sym
> > > > >     jpegtran:23f4bf 3321915 [013] 404718.587488:  /idle.slice/polish.service
> > > > >                     5c554 compress_output
> > > > >                     570d9 jpeg_finish_compress
> > > > >                     3476e jpegtran_main
> > > > >                     330ee jpegtran::main
> > > > >                     326e2 core::ops::function::FnOnce::call_once (inlined)
> > > > >                     326e2 std::sys_common::backtrace::__rust_begin_short_backtrace
> > > > >
> > > > >     jpegtran:23f4bf 3321915 [031] 404718.592073:  /idle.slice/polish.service
> > > > >                     8474d jsimd_encode_mcu_AC_first_prepare_sse2.PADDING
> > > > >                 55af68e62fff [unknown]
> > > > >
> > > > > Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
> > > > > Fixes: 3fd7a168bf51 ("perf script: Add 'cgroup' field for output")
> 
> > > This change makes sense to me. Namhyung, wdyt?
>  
> > Hi Namhyung,
> > 
> > This is a really trivial patch and it would be good to get a word from you.
> 
> Hi, this solves the case for cgroup and I think it should be merged, but
> what about the other fields that are being printed after the callchain
> gets printed?
> 
> I looked and we would have to introduce a __sample__fprintf_sym that
> didn't call sample__fprintf_callchain and use it in perf script's
> process_event() then later call sample__fprintf_callchain after all the
> fields that print on the same line.

Nah, or simply moving sample__fprintf_sym() to the end of that function.

- Arnaldo
 
> Anyway, Namhyung, can I have your Acked-by for this patch to move things
> forward at least for cgroups?
