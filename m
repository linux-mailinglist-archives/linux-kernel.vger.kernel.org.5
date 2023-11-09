Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFFE7E6E5F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbjKIQOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjKIQOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:14:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4D4327D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 08:14:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 035A4C433C8;
        Thu,  9 Nov 2023 16:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699546476;
        bh=H5gRNhBAojyGz06n4nyUjlE+Ck3M94YyNimHQhe4wK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XVKfYxmbDwtVvUxGpJMuZJjv4ORhmYur2uarLSbeBoyiCBt2Auo0DEzF5Uyp2mNcE
         FGC0OvDqkm/k4/Zxsr0R6X1M76+2+WX6R46GjeNmom0QWQioEIfsoKjv5amzQrKOpB
         FzSv1hrw+u+4Yz+d+Suja/cuZNeUEBDMMWU89otDpwEXFKHOuO1+JZ5cwd0oa6hHvk
         2e3GUEGim23OhhnaXh7mO/SGuaL2KfKoeiJmmKn+UGOKPMy3381ZwAAro8VhvgQrFR
         DLqs72x0xVumhq0CIV/oKxzv1+EvCRvjrZXY8QgjGbeGGDquGJ1IQAhsO2fshaxBzw
         k7FOFrlPPtAJw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 653D840094; Thu,  9 Nov 2023 13:14:33 -0300 (-03)
Date:   Thu, 9 Nov 2023 13:14:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, irogers@google.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Yonghong Song <yhs@fb.com>,
        Fangrui Song <maskray@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2 2/2] perf test: Add support for setting objdump binary
 via perf config
Message-ID: <ZU0FaXoGf/HcLBlb@kernel.org>
References: <20231106151051.129440-1-james.clark@arm.com>
 <20231106151051.129440-3-james.clark@arm.com>
 <ZUv1TgveArYdvTsl@kernel.org>
 <2e0fb2d4-1410-6a7e-902d-8249a9ea523a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e0fb2d4-1410-6a7e-902d-8249a9ea523a@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 09, 2023 at 10:26:34AM +0000, James Clark escreveu:
> 
> 
> On 08/11/2023 20:53, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Nov 06, 2023 at 03:10:49PM +0000, James Clark escreveu:
> >> Add a perf config variable that does the same thing as "perf test
> >> --objdump <x>".
> >>
> >> Also update the man page.
> > 
> > That is ok, if one wants to change objdump just for testing, as a
> > followup improvement it may be interesting to allow that for the other
> > tools that have --objdump as well as to add this as a global option,
> > that affects all tools, no?
> 
> For the tools they already all share annotate.objdump in the config. Do
> you mean that the tests could share the same config instead?

Probably.
 
> Maybe I could have used annotate.objdump for the tests, but it was used
> in a slightly different way, and I thought it would be easier for people
> to find if it started with "test."

Well, we can have both, with "test." overriding "annotate."?

Anyway, I applied this patch locally, now trying to fix some unrelated
problem that is making 'perf test' fail so that I can push
perf-tools-next publicly.

- Arnaldo
 
> > 
> > Anyway, applied both patches.
> > 
> > - Arnaldo
> >  
> >> Signed-off-by: James Clark <james.clark@arm.com>
> >> ---
> >>  tools/perf/Documentation/perf-config.txt |  4 ++++
> >>  tools/perf/tests/builtin-test.c          | 12 ++++++++++++
> >>  2 files changed, 16 insertions(+)
> >>
> >> diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
> >> index 0b4e79dbd3f6..16398babd1ef 100644
> >> --- a/tools/perf/Documentation/perf-config.txt
> >> +++ b/tools/perf/Documentation/perf-config.txt
> >> @@ -722,6 +722,10 @@ session-<NAME>.*::
> >>  		Defines new record session for daemon. The value is record's
> >>  		command line without the 'record' keyword.
> >>  
> >> +test.*::
> >> +
> >> +	test.objdump::
> >> +		objdump binary to use for disassembly and annotations.
> >>  
> >>  SEE ALSO
> >>  --------
> >> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> >> index a8d17dd50588..113e92119e1d 100644
> >> --- a/tools/perf/tests/builtin-test.c
> >> +++ b/tools/perf/tests/builtin-test.c
> >> @@ -14,6 +14,7 @@
> >>  #include <sys/wait.h>
> >>  #include <sys/stat.h>
> >>  #include "builtin.h"
> >> +#include "config.h"
> >>  #include "hist.h"
> >>  #include "intlist.h"
> >>  #include "tests.h"
> >> @@ -514,6 +515,15 @@ static int run_workload(const char *work, int argc, const char **argv)
> >>  	return -1;
> >>  }
> >>  
> >> +static int perf_test__config(const char *var, const char *value,
> >> +			     void *data __maybe_unused)
> >> +{
> >> +	if (!strcmp(var, "test.objdump"))
> >> +		test_objdump_path = value;
> >> +
> >> +	return 0;
> >> +}
> >> +
> >>  int cmd_test(int argc, const char **argv)
> >>  {
> >>  	const char *test_usage[] = {
> >> @@ -541,6 +551,8 @@ int cmd_test(int argc, const char **argv)
> >>          if (ret < 0)
> >>                  return ret;
> >>  
> >> +	perf_config(perf_test__config, NULL);
> >> +
> >>  	/* Unbuffered output */
> >>  	setvbuf(stdout, NULL, _IONBF, 0);
> >>  
> >> -- 
> >> 2.34.1
> >>
> > 

-- 

- Arnaldo
