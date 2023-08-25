Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0585788BF7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 16:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343874AbjHYOwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 10:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343875AbjHYOvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:51:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EB9211E;
        Fri, 25 Aug 2023 07:51:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FCBC63735;
        Fri, 25 Aug 2023 14:51:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30C3C433C8;
        Fri, 25 Aug 2023 14:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692975112;
        bh=oDUKt2y776qkY7mlL5afAMt5eHtx+3g2kNGFrLjZHX4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IH1R55785YKVlrPnoaLltrfwFj5/1XNZaTHxlW0Whd/p1vItVd0Azr/nc4PMPHYtl
         YFW4hz6C12e/y7pHSEaj4/rfVSKjUSf8b3ZfilAgKl7EX/57a9j4sk50NZn2sZ+31u
         aF1vH5xd7hEfykIeQPRdeCQ4j3rOQVQ7E62FA4m3uYsAIVsYSPCqxGKl1AQ5CLLXO5
         LDULB44z6irTmwDQ14VAuONjWwzJOFIEmvmhtORqyKRV+MO21S9Lvu213nFkCRgbYs
         GKerhKEbLWLVd3uNQ6ectj25YrTVB2gMUIdFfb9SQ3Fvkbfx2T+obvOka1dZ76Qg4f
         0CKVDeimIXC+Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C5AEC40722; Fri, 25 Aug 2023 11:51:49 -0300 (-03)
Date:   Fri, 25 Aug 2023 11:51:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] perf pmus: Sort pmus by name then suffix
Message-ID: <ZOjABa9ZfQgra/UX@kernel.org>
References: <20230825135237.921058-1-irogers@google.com>
 <20230825135237.921058-2-irogers@google.com>
 <ZOi/KDRRrnkvJmkB@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOi/KDRRrnkvJmkB@kernel.org>
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

Em Fri, Aug 25, 2023 at 11:48:08AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Aug 25, 2023 at 06:52:36AM -0700, Ian Rogers escreveu:
> > Sort PMUs by name. If two PMUs have the same name but differ by
> > suffix, sort the suffixes numerically. For example, "breakpoint" comes
> > before "cpu", "uncore_imc_free_running_0" comes before
> > "uncore_imc_free_running_1". Suffixes need to be treated specially as
> > otherwise they will be ordered like 0, 1, 10, 11, .., 2, 20, 21, ..,
> > etc. Only PMUs starting 'uncore_' are considered to have a potential
> > suffix.
> > 
> > Sorting of PMUs is done so that later patches can skip duplicate
> > uncore PMUs that differ only by there suffix.
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/pmus.c | 48 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> > 
> > diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> > index 4dd5912617ff..b1f6a64693fe 100644
> > --- a/tools/perf/util/pmus.c
> > +++ b/tools/perf/util/pmus.c
> > @@ -1,8 +1,10 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include <linux/list.h>
> > +#include <linux/list_sort.h>
> >  #include <linux/zalloc.h>
> >  #include <subcmd/pager.h>
> >  #include <sys/types.h>
> > +#include <ctype.h>
> >  #include <dirent.h>
> >  #include <pthread.h>
> >  #include <string.h>
> > @@ -33,6 +35,31 @@ static LIST_HEAD(other_pmus);
> >  static bool read_sysfs_core_pmus;
> >  static bool read_sysfs_all_pmus;
> >  
> > +static int pmu_name_len_no_suffix(const char *str, unsigned long *num)
> > +{
> > +	int orig_len, len;
> > +
> > +	orig_len = len = strlen(str);
> > +
> > +	/* Non-uncore PMUs have their full length, for example, i915. */
> > +	if (strncmp(str, "uncore_", 7))
> > +		return len;
> 
> I applied the patch, but we have strstarts() for this case, to avoid
> having to count the size of the prefix in tools/include/linux/string.h,
> that we copied from the kernel sources:
> 
> /**
>  * strstarts - does @str start with @prefix?
>  * @str: string to examine
>  * @prefix: prefix to look for.
>  */
> static inline bool strstarts(const char *str, const char *prefix)
> {
>         return strncmp(str, prefix, strlen(prefix)) == 0;
> }
> 
> I'll change it, ok?

This:

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index b1f6a64693fe0d49..bbf84ccc3aba7d5c 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/list.h>
 #include <linux/list_sort.h>
+#include <linux/string.h>
 #include <linux/zalloc.h>
 #include <subcmd/pager.h>
 #include <sys/types.h>
@@ -42,7 +43,7 @@ static int pmu_name_len_no_suffix(const char *str, unsigned long *num)
 	orig_len = len = strlen(str);
 
 	/* Non-uncore PMUs have their full length, for example, i915. */
-	if (strncmp(str, "uncore_", 7))
+	if (!strstarts(str, "uncore_"))
 		return len;
 
 	/*
