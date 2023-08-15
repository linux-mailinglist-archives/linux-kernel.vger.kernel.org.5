Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4083977D140
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 19:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238924AbjHORmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 13:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238927AbjHORmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 13:42:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3F31BD2;
        Tue, 15 Aug 2023 10:42:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2516C60F0B;
        Tue, 15 Aug 2023 17:42:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49406C433C8;
        Tue, 15 Aug 2023 17:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692121327;
        bh=kjqDWpUP6z5slpWqs3Zt6WzwVljhS5woggD1qaRxuYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R9xTJA+B6I1+pXAdLJZTxnFDKq0uV6y1++K5PeuYx76fSPZxK5bgjxKCRrnBbEQD8
         l7EOigH7NMkbcPW+mC81F58sAaLaO0ATU49OWVd/+YnpR7K1lA2zPc/6uC4nUsQXqE
         NRy02w7XSiPsY8wsV794/QHEnnwQgWIiknb1EQ5/fEeBvb950n31R4K4e6amvVCNQc
         tJ/H+aanq4PzsrEI40N0ePXnLAmHILlxgxEf3k8XQLcEFr1BY2yOSZMdFYfTkevbRE
         f6sezmmTDPivKjfDNLSd29jR0qdaMe921I13gEIbFBGQn8js3K9NwallUNTPv6yTis
         ybSCosczoccsQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A286C404DF; Tue, 15 Aug 2023 14:42:04 -0300 (-03)
Date:   Tue, 15 Aug 2023 14:42:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] perf test: Add perf record sample filtering test
Message-ID: <ZNu47CYXV0nuav+G@kernel.org>
References: <20230811025822.3859771-1-namhyung@kernel.org>
 <20230811025822.3859771-2-namhyung@kernel.org>
 <ZNu2KrbgFPY69K2+@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNu2KrbgFPY69K2+@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 15, 2023 at 02:30:18PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Aug 10, 2023 at 07:58:22PM -0700, Namhyung Kim escreveu:
> >   $ sudo ./perf test 'sample filter' -v
> >    94: perf record sample filtering (by BPF) tests                     :
> >   --- start ---
> >   test child forked, pid 3817527
> >   Checking BPF-filter privilege
> >   Basic bpf-filter test
> >   Basic bpf-filter test [Success]
> >   Failing bpf-filter test
> >   Error: task-clock event does not have PERF_SAMPLE_CPU
> >   Failing bpf-filter test [Success]
> >   Group bpf-filter test
> >   Error: task-clock event does not have PERF_SAMPLE_CPU
> >   Error: task-clock event does not have PERF_SAMPLE_CODE_PAGE_SIZE
> >   Group bpf-filter test [Success]
> >   test child finished with 0
> >   ---- end ----
> >   perf record sample filtering (by BPF) tests: Ok
> 
> [root@five ~]# perf test -v "by BPF"
>  91: perf record sample filtering (by BPF) tests                     :
> --- start ---
> test child forked, pid 64165
> Checking BPF-filter privilege
> Basic bpf-filter test
>  ffffffff97f4f688
>  ffffffff97f73859
>  ffffffff97412ce6
>  ffffffff976da215
>  ffffffff973a92bf
>  ffffffff97376ad7
>  ffffffff97f73859
<SNIP
>  ffffffff971fdca5
>  ffffffff9737dbc4
>  ffffffff971b4e04
> Basic bpf-filter test [Failed invalid output]
> test child finished with -1
> ---- end ----
> perf record sample filtering (by BPF) tests: FAILED!
> [root@five ~]#
> 
> [root@five ~]# uname -a
> Linux five 6.2.15-100.fc36.x86_64 #1 SMP PREEMPT_DYNAMIC Thu May 11 16:51:53 UTC 2023 x86_64 x86_64 x86_64 GNU/Linux
> [root@five ~]# 

Above was on a AMD Ryzen 5950X, the following was on a lenovo t480s,
Intel notebook:

[root@quaco ~]# uname -a
Linux quaco 6.4.7-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Jul 27 20:01:18 UTC 2023 x86_64 GNU/Linux
[root@quaco ~]# perf test "filter"
 30: Filter hist entries                                             : Ok
 36: Filter fds with revents mask in a fdarray                       : Ok
 67: dlfilter C API                                                  : Ok
 91: perf record sample filtering (by BPF) tests                     : Ok
[root@quaco ~]# perf test -v "by BPF"
 91: perf record sample filtering (by BPF) tests                     :
--- start ---
test child forked, pid 273609
Checking BPF-filter privilege
Basic bpf-filter test
Basic bpf-filter test [Success]
Failing bpf-filter test
Error: task-clock event does not have PERF_SAMPLE_CPU
Failing bpf-filter test [Success]
Group bpf-filter test
Error: task-clock event does not have PERF_SAMPLE_CPU
Error: task-clock event does not have PERF_SAMPLE_CODE_PAGE_SIZE
Group bpf-filter test [Success]
test child finished with 0
---- end ----
perf record sample filtering (by BPF) tests: Ok
[root@quaco ~]#
