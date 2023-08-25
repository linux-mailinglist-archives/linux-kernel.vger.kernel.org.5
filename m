Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2DDB788BED
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 16:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343506AbjHYOsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 10:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240257AbjHYOsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:48:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76832123;
        Fri, 25 Aug 2023 07:48:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 456F362E10;
        Fri, 25 Aug 2023 14:48:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ECE0C433C8;
        Fri, 25 Aug 2023 14:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692974891;
        bh=dtx9kmdF/LG3mX8S6EMJe+DBoecxVbeW8TUaVPajiMs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c5aJW7l2sV4Eu7+KSJYSmNMm6KcEjcQRsNO+IMMqvFCxIkts5xQIspqoKuxuciWhU
         SXceuyiZAahe5RwS8YPdGgn85epKceuoYAmwCOKWL/PWgxmqbG7jSElsB+rvMyct6w
         EUQC7rnJpv6eCjn+WIPWU1bBxgLW1OJLsdqw+tjOl4LDeZBjIyUzeH2/98tWHp2JQg
         GDdXW0RRqMxkwAW60VMChQhKpFUdYOHr2qsFTn3JG9dvBdlaZCZR8N1awfJjFWS2BS
         Z2mQqQmLMeElj9WHVN2hr9lIvIpABjpsCAGyF4pdRpUv76Si8IXB8cTVD7u9jZOsxI
         FxoFcz3v7pQ2w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BFB4F40722; Fri, 25 Aug 2023 11:48:08 -0300 (-03)
Date:   Fri, 25 Aug 2023 11:48:08 -0300
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
Message-ID: <ZOi/KDRRrnkvJmkB@kernel.org>
References: <20230825135237.921058-1-irogers@google.com>
 <20230825135237.921058-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825135237.921058-2-irogers@google.com>
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

I applied the patch, but we have strstarts() for this case, to avoid
having to count the size of the prefix in tools/include/linux/string.h,
that we copied from the kernel sources:

/**
 * strstarts - does @str start with @prefix?
 * @str: string to examine
 * @prefix: prefix to look for.
 */
static inline bool strstarts(const char *str, const char *prefix)
{
        return strncmp(str, prefix, strlen(prefix)) == 0;
}

I'll change it, ok?

- Arnaldo



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
> +
>  /* Add all pmus in sysfs to pmu list: */
>  static void pmu_read_sysfs(bool core_only)
>  {
> @@ -156,6 +202,8 @@ static void pmu_read_sysfs(bool core_only)
>  		if (!perf_pmu__create_placeholder_core_pmu(&core_pmus))
>  			pr_err("Failure to set up any core PMUs\n");
>  	}
> +	list_sort(NULL, &core_pmus, pmus_cmp);
> +	list_sort(NULL, &other_pmus, pmus_cmp);
>  	if (!list_empty(&core_pmus)) {
>  		read_sysfs_core_pmus = true;
>  		if (!core_only)
> -- 
> 2.42.0.rc2.253.gd59a3bf2b4-goog
> 

-- 

- Arnaldo
