Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22907788FC7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 22:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjHYUX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 16:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjHYUXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 16:23:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1851BE6;
        Fri, 25 Aug 2023 13:23:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01C6163393;
        Fri, 25 Aug 2023 20:23:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B060C433C8;
        Fri, 25 Aug 2023 20:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692995023;
        bh=ujj7khbjSaRWUyUcOo3NCNFjsV58vH0Ob3N5Qu66L/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qWK/lPNvKMSSbujXOvfvRN3rRaMx1NaZTo6YJHgkILetm2Wg6nd2t/DOikfiCINPj
         +XhgYOQfAjcpsmDYHuYufMmEf+tV0GH3B2KL6nycgKid0qCx6w7lq0KhNy//pC+JgK
         0bIw7GrhzpIJzroGvabKFw4UWO0Yg7FH9yuC3cxvK9wzIsRoiAqQDTGW3yq73ZACC0
         1m2X4vxrxlIGEGlzGNQYRobMH0wgClq6Ngnoiji8RV1WkBp1q7HawBO3VbIyr4Cqj+
         JxTYl1hP1kAXH66cq1ZVtpQSqmgUb8cnoT8qbH0UUBeP/vlLeYkrOcH8Z4MRwxhwWH
         0nozh/eTrbmhg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9BED340722; Fri, 25 Aug 2023 17:23:40 -0300 (-03)
Date:   Fri, 25 Aug 2023 17:23:40 -0300
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
Message-ID: <ZOkNzHgJ0+mgfSPz@kernel.org>
References: <20230825135237.921058-1-irogers@google.com>
 <20230825135237.921058-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825135237.921058-2-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Aug 25, 2023 at 06:52:36AM -0700, Ian Rogers escreveu:
> Sort PMUs by name. If two PMUs have the same name but differ by
> suffix, sort the suffixes numerically. For example, "breakpoint" comes
> before "cpu", "uncore_imc_free_running_0" comes before
> "uncore_imc_free_running_1". Suffixes need to be treated specially as
> otherwise they will be ordered like 0, 1, 10, 11, .., 2, 20, 21, ..,
> etc. Only PMUs starting 'uncore_' are considered to have a potential
> suffix.
> 
> Sorting of PMUs is done so that later patches can skip duplicate
> uncore PMUs that differ only by there suffix.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/pmus.c | 48 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index 4dd5912617ff..b1f6a64693fe 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
> @@ -1,8 +1,10 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/list.h>
> +#include <linux/list_sort.h>
>  #include <linux/zalloc.h>
>  #include <subcmd/pager.h>
>  #include <sys/types.h>
> +#include <ctype.h>
>  #include <dirent.h>
>  #include <pthread.h>
>  #include <string.h>
> @@ -33,6 +35,31 @@ static LIST_HEAD(other_pmus);
>  static bool read_sysfs_core_pmus;
>  static bool read_sysfs_all_pmus;
>  
> +static int pmu_name_len_no_suffix(const char *str, unsigned long *num)
> +{
> +	int orig_len, len;
> +
> +	orig_len = len = strlen(str);
> +
> +	/* Non-uncore PMUs have their full length, for example, i915. */
> +	if (strncmp(str, "uncore_", 7))
> +		return len;
> +
> +	/*
> +	 * Count trailing digits and '_', if '_{num}' suffix isn't present use
> +	 * the full length.
> +	 */
> +	while (len > 0 && isdigit(str[len - 1]))
> +		len--;
> +
> +	if (len > 0 && len != orig_len && str[len - 1] == '_') {
> +		if (num)
> +			*num = strtoul(&str[len], NULL, 10);
> +		return len - 1;
> +	}
> +	return orig_len;
> +}
> +
>  void perf_pmus__destroy(void)
>  {
>  	struct perf_pmu *pmu, *tmp;
> @@ -122,6 +149,25 @@ static struct perf_pmu *perf_pmu__find2(int dirfd, const char *name)
>  	return perf_pmu__lookup(core_pmu ? &core_pmus : &other_pmus, dirfd, name);
>  }
>  
> +static int pmus_cmp(void *priv __maybe_unused,
> +		    const struct list_head *lhs, const struct list_head *rhs)
> +{
> +	unsigned long lhs_num, rhs_num;
> +	struct perf_pmu *lhs_pmu = container_of(lhs, struct perf_pmu, list);
> +	struct perf_pmu *rhs_pmu = container_of(rhs, struct perf_pmu, list);
> +	const char *lhs_pmu_name = lhs_pmu->name ?: "";
> +	const char *rhs_pmu_name = rhs_pmu->name ?: "";
> +	int lhs_pmu_name_len = pmu_name_len_no_suffix(lhs_pmu_name, &lhs_num);
> +	int rhs_pmu_name_len = pmu_name_len_no_suffix(rhs_pmu_name, &rhs_num);
> +	int ret = strncmp(lhs_pmu_name, rhs_pmu_name,
> +			lhs_pmu_name_len < rhs_pmu_name_len ? lhs_pmu_name_len : rhs_pmu_name_len);
> +
> +	if (lhs_pmu_name_len != rhs_pmu_name_len || ret != 0 || lhs_pmu_name_len == 0)
> +		return ret;
> +
> +	return lhs_num < rhs_num ? -1 : (lhs_num > rhs_num ? 1 : 0);
> +}

Also, I got this in some distros/gcc versions:

  31    12.95 opensuse:15.5                 : FAIL gcc version 7.5.0 (SUSE Linux)
    util/pmus.c: In function 'pmus_cmp':
    util/pmus.c:169:57: error: 'lhs_num' may be used uninitialized in this function [-Werror=maybe-uninitialized]
      return lhs_num < rhs_num ? -1 : (lhs_num > rhs_num ? 1 : 0);
                                      ~~~~~~~~~~~~~~~~~~~~~~~^~~~
    cc1: all warnings being treated as errors
    make[3]: *** [/git/perf-6.5.0-rc5/tools/build/Makefile.build:150: util] Error 2

I applied this, please check.

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index bbf84ccc3aba7d5c..7316da1c0ddb8eaf 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -153,7 +153,7 @@ static struct perf_pmu *perf_pmu__find2(int dirfd, const char *name)
 static int pmus_cmp(void *priv __maybe_unused,
 		    const struct list_head *lhs, const struct list_head *rhs)
 {
-	unsigned long lhs_num, rhs_num;
+	unsigned long lhs_num = 0, rhs_num = 0;
 	struct perf_pmu *lhs_pmu = container_of(lhs, struct perf_pmu, list);
 	struct perf_pmu *rhs_pmu = container_of(rhs, struct perf_pmu, list);
 	const char *lhs_pmu_name = lhs_pmu->name ?: "";
