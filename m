Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093A07F7588
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjKXNtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjKXNtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:49:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EC3A2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:49:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A4BC433C7;
        Fri, 24 Nov 2023 13:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700833760;
        bh=RK/Qw8o4ovbyL3c/RrcyncPvhe8T4y1yfBBbLNiqdck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MflN0XjxEtFzbz6akRRAKiW1WlNp0Aa39uvDxNCE+H2yHsfMETcSGfT54TsfpH2hj
         muordg+4h/Z5FOx7u+TQGBtosrkhU9GwWibuZje+NpE4V5XVGUwPFLMto6hwl1JfCE
         cZ4Ak09zk5qiEda3LY00mZ3CZ+V+ZxknExb3VGzFt1sWvsxU7NzY/Z/lYbUXt5hGNZ
         GUBFkn5HgjIT1wt96ZimOYXptHGKJoD4jzZPdYs/u7BOwvheEh0HOBnqjGaXleMjuX
         clolK4MrVlAK740BietvtX/6yw+topNR9YsZuIRhfhBA4U4M8BZszIK+T2ADYZezlM
         ztoNEXXvIj01Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E547A40094; Fri, 24 Nov 2023 10:49:17 -0300 (-03)
Date:   Fri, 24 Nov 2023 10:49:17 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Hector Martin <marcan@marcan.st>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1] perf parse-events: Make legacy events lower
 priority than sysfs/json
Message-ID: <ZWCp3beoYHR8Ka2V@kernel.org>
References: <20231123042922.834425-1-irogers@google.com>
 <ac4cf01d-4bb5-4b4d-bd87-bf05ddb67f2d@marcan.st>
 <ZV9fLgHshKGoAPYK@kernel.org>
 <ZV/A3YhtMHsZZRQd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV/A3YhtMHsZZRQd@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NUMERIC_HTTP_ADDR,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 23, 2023 at 06:15:09PM -0300, Arnaldo Carvalho de Melo escreveu:
> 
> I'll collect those, but only after addressing these:
> 
> [perfbuilder@five ~]$ export BUILD_TARBALL=http://192.168.86.5/perf/perf-6.6.0-rc1.tar.xz
> [perfbuilder@five ~]$ time dm
>    1   100.09 almalinux:8                   : FAIL clang version 15.0.7 (Red Hat 15.0.7-1.module_el8.8.0+3466+dfcbc058)
>     util/parse-events.c:1461:6: error: variable 'alias_rewrote_terms' is used uninitialized whenever '&&' condition is false [-Werror,-Wsometimes-uninitialized]
>             if (!parse_state->fake_pmu && perf_pmu__check_alias(pmu, &parsed_terms,
>                 ^~~~~~~~~~~~~~~~~~~~~~
>     util/parse-events.c:1477:6: note: uninitialized use occurs here
>             if (alias_rewrote_terms &&
>                 ^~~~~~~~~~~~~~~~~~~
>     util/parse-events.c:1461:6: note: remove the '&&' if its condition is always true
>             if (!parse_state->fake_pmu && perf_pmu__check_alias(pmu, &parsed_terms,
>                 ^~~~~~~~~~~~~~~~~~~~~~~~~
>     util/parse-events.c:1401:26: note: initialize the variable 'alias_rewrote_terms' to silence this warning
>             bool alias_rewrote_terms;
>                                     ^
>                                      = false
>     1 error generated.
>     make[3]: *** [/git/perf-6.6.0-rc1/tools/build/Makefile.build:158: util] Error 2

It built well with gcc but clang didn't notice that
perf_pmu__check_alias() unconditionally initializes that variable to
false as one of its first steps.

So I just did what clang suggested.

- Arnaldo
