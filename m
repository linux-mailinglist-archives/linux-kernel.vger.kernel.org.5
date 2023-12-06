Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB728070D3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378486AbjLFN0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378468AbjLFN0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:26:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B2FD47
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 05:26:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3CB4C433C7;
        Wed,  6 Dec 2023 13:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701869170;
        bh=kY88AoLa3ot5oNZ2xunTh93/qoZpoRK13BhBUv2JbLM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oaBtu7ykS3bebpcM/l82Q0Ed1Cz+UbZbBJop+Z4dY/WMjGyu0MwOHg3k7VkIwXtXW
         3f3Y0rNE3DApL2F+IMTJslYub2smDvJoT2xq5SC5B6V7xSNPV6TADRmyaAE0ilsAkj
         GwqPNKytF54L6R4f6e0Z3PbsG/9WwdVDzheGvFEWenroxDalPm2CjA4SihZEKpW5TI
         f8+eduyfRYOmB8CwXoCUK3zgtlusG/UNyokxhkmBHiMY2bmJN7T3xACidHBZ4rbbc0
         stK0nhgErVd6pqbYyhRlru/2W8UX+0Rb4mCzbQfW01Ts2zE7YXK4lzIlxpSZuKgz0x
         OlpqmpXByvPsA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 99789403EF; Wed,  6 Dec 2023 10:26:07 -0300 (-03)
Date:   Wed, 6 Dec 2023 10:26:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        atrajeev@linux.vnet.ibm.com
Subject: Re: [PATCH v1] perf test: Add basic perf diff test
Message-ID: <ZXB2bxcWjzLosY7L@kernel.org>
References: <20231120190408.281826-1-irogers@google.com>
 <CAP-5=fWvADeeHVQObwk-eVNeOSC=eTTv2q8Rz4j3UtL5-6Getw@mail.gmail.com>
 <ee68f32d-72a2-4e9f-aee1-7c195ad44765@intel.com>
 <CAP-5=fVo+YVAc44Pkes-bXp4Tm605x6RuRi=EdFJeGEEE4iwkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVo+YVAc44Pkes-bXp4Tm605x6RuRi=EdFJeGEEE4iwkQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 05, 2023 at 08:52:04AM -0800, Ian Rogers escreveu:
> On Mon, Dec 4, 2023 at 9:44 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >
> > On 4/12/23 18:00, Ian Rogers wrote:
> > > On Mon, Nov 20, 2023 at 11:04 AM Ian Rogers <irogers@google.com> wrote:
> > >>
> > >> There are some old bug reports on perf diff crashing:
> > >> https://rhaas.blogspot.com/2012/06/perf-good-bad-ugly.html
> > >>
> > >> Happening across them I was prompted to add two very basic tests that
> > >> will give some perf diff coverage.
> > >>
> > >> Signed-off-by: Ian Rogers <irogers@google.com>
> > >
> > > Ping.
> > >
> > > Thanks,
> > > Ian
> > >
> > >> ---
> > >>  tools/perf/tests/shell/diff.sh | 101 +++++++++++++++++++++++++++++++++
> > >>  1 file changed, 101 insertions(+)
> > >>  create mode 100755 tools/perf/tests/shell/diff.sh
> > >>
> > >> diff --git a/tools/perf/tests/shell/diff.sh b/tools/perf/tests/shell/diff.sh
> > >> new file mode 100755
> > >> index 000000000000..213185763688
> > >> --- /dev/null
> > >> +++ b/tools/perf/tests/shell/diff.sh
> > >> @@ -0,0 +1,101 @@
> > >> +#!/bin/sh
> > >> +# perf diff tests
> > >> +# SPDX-License-Identifier: GPL-2.0
> > >> +
> > >> +set -e
> > >> +
> > >> +err=0
> > >> +perfdata1=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> > >> +perfdata2=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> > >> +perfdata3=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> > >> +testprog="perf test -w thloop"
> > >> +testsym="test_loop"
> >
> > Could it benefit from skip_test_missing_symbol
> 
> Good idea, sent:
> https://lore.kernel.org/lkml/20231205164924.835682-1-irogers@google.com/

Applied, and added this:

Suggested-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks,

- Arnaldo
