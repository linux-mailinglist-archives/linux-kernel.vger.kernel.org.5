Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B92E779373
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbjHKPrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236439AbjHKPrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:47:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EC7270F;
        Fri, 11 Aug 2023 08:47:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC5B664DE7;
        Fri, 11 Aug 2023 15:46:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5815C433C7;
        Fri, 11 Aug 2023 15:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691768819;
        bh=eltIzQyV4cMYnPohsCHCTRWfiqKbJADJmTzB21iR7Oc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VfATPPpN3mE7Qw/AfWV/bQ6xNc+JHdeH3QvU5jwdNcF1OO/S7+b/ZfDhzyQ+4AcGe
         oGc1qFULWjlb/2ti7l351Q/O7buOrcOUa4e/hUolKuMN7WsfAAgjm5969pN01nH9aj
         Uc4EeErhvA1le1HM+HbtuL1N1D5UVXFschAM+6SMp/v/U+9tHXI3x6uPnDN+muVnCh
         vEF5tgby9IR9O3LQg8kN0POA0x6qNyhh5nmJyJPL69AZa8Bhr1AiZk7h+xNh7lDTsv
         LItTasiYpqp2XZdbDThvqzCuSaGUS92yFa6bhpYQeJDn8t4ATMUEu1jRSZro1LjAci
         X8BC2ghTa1l7A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3B929404DF; Fri, 11 Aug 2023 12:46:56 -0300 (-03)
Date:   Fri, 11 Aug 2023 12:46:56 -0300
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
Subject: Re: [PATCH v2 1/3] perf pmus: Sort pmus by name then suffix
Message-ID: <ZNZX8G+SozoC13go@kernel.org>
References: <20230810214952.2934029-1-irogers@google.com>
 <20230810214952.2934029-2-irogers@google.com>
 <ZNY+BHUFETc2eNib@kernel.org>
 <CAP-5=fXPBVmSxt=96wyRJnDu-Hm6oPxt8XxG2_9P-FfH4VFDGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXPBVmSxt=96wyRJnDu-Hm6oPxt8XxG2_9P-FfH4VFDGg@mail.gmail.com>
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

Em Fri, Aug 11, 2023 at 08:19:00AM -0700, Ian Rogers escreveu:
> On Fri, Aug 11, 2023 at 6:56 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Thu, Aug 10, 2023 at 02:49:50PM -0700, Ian Rogers escreveu:
> > > Sort PMUs by name. If two PMUs have the same name but differ by
> > > suffix, sort the suffixes numerically. For example, "breakpoint" comes
> > > before "cpu", "uncore_imc_free_running_0" comes before
> > > "uncore_imc_free_running_1".
> >
> > Why is this needed?
> 
> It is needed so that in the later patches we just "perf list" the
> uncore_imc_free_running_0 and skip all the other suffix numbers.
> Sorting using strcmp isn't sufficient as consider uncore_imc_10 and
> uncore_imc_9, where 9 would appear before 10 if only the characters
> were being compared.

I think there will be a v2 for this series, from other reviews, so
please add this to this patch so that we know what is its intent in
addition to the description of what it is doing.
 
> Thanks,
> Ian
> 
> > - Arnaldo
> >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/util/pmus.c | 48 ++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 48 insertions(+)
> > >
> > > diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> > > index c58ba9fb6a36..3581710667b0 100644
> > > --- a/tools/perf/util/pmus.c
> > > +++ b/tools/perf/util/pmus.c
> > > @@ -1,8 +1,10 @@
> > >  // SPDX-License-Identifier: GPL-2.0
> > >  #include <linux/list.h>
> > > +#include <linux/list_sort.h>
> > >  #include <linux/zalloc.h>
> > >  #include <subcmd/pager.h>
> > >  #include <sys/types.h>
> > > +#include <ctype.h>
> > >  #include <dirent.h>
> > >  #include <pthread.h>
> > >  #include <string.h>
> > > @@ -33,6 +35,31 @@ static LIST_HEAD(other_pmus);
> > >  static bool read_sysfs_core_pmus;
> > >  static bool read_sysfs_all_pmus;
> > >
> > > +static int pmu_name_len_no_suffix(const char *str, unsigned long *num)
> > > +{
> > > +     int orig_len, len;
> > > +
> > > +     orig_len = len = strlen(str);
> > > +
> > > +     /* Non-uncore PMUs have their full length, for example, i915. */
> > > +     if (strncmp(str, "uncore_", 7))
> > > +             return len;
> > > +
> > > +     /*
> > > +      * Count trailing digits and '_', if '_{num}' suffix isn't present use
> > > +      * the full length.
> > > +      */
> > > +     while (len > 0 && isdigit(str[len - 1]))
> > > +             len--;
> > > +
> > > +     if (len > 0 && len != orig_len && str[len - 1] == '_') {
> > > +             if (num)
> > > +                     *num = strtoul(&str[len], NULL, 10);
> > > +             return len - 1;
> > > +     }
> > > +     return orig_len;
> > > +}
> > > +
> > >  void perf_pmus__destroy(void)
> > >  {
> > >       struct perf_pmu *pmu, *tmp;
> > > @@ -122,6 +149,25 @@ static struct perf_pmu *perf_pmu__find2(int dirfd, const char *name)
> > >       return perf_pmu__lookup(core_pmu ? &core_pmus : &other_pmus, dirfd, name);
> > >  }
> > >
> > > +static int pmus_cmp(void *priv __maybe_unused,
> > > +                 const struct list_head *lhs, const struct list_head *rhs)
> > > +{
> > > +     unsigned long lhs_num, rhs_num;
> > > +     struct perf_pmu *lhs_pmu = container_of(lhs, struct perf_pmu, list);
> > > +     struct perf_pmu *rhs_pmu = container_of(rhs, struct perf_pmu, list);
> > > +     const char *lhs_pmu_name = lhs_pmu->name ?: "";
> > > +     const char *rhs_pmu_name = rhs_pmu->name ?: "";
> > > +     int lhs_pmu_name_len = pmu_name_len_no_suffix(lhs_pmu_name, &lhs_num);
> > > +     int rhs_pmu_name_len = pmu_name_len_no_suffix(rhs_pmu_name, &rhs_num);
> > > +     int ret = strncmp(lhs_pmu_name, rhs_pmu_name,
> > > +                     lhs_pmu_name_len < rhs_pmu_name_len ? lhs_pmu_name_len : rhs_pmu_name_len);
> > > +
> > > +     if (lhs_pmu_name_len != rhs_pmu_name_len || ret != 0 || lhs_pmu_name_len == 0)
> > > +             return ret;
> > > +
> > > +     return lhs_num < rhs_num ? -1 : (lhs_num > rhs_num ? 1 : 0);
> > > +}
> > > +
> > >  /* Add all pmus in sysfs to pmu list: */
> > >  static void pmu_read_sysfs(bool core_only)
> > >  {
> > > @@ -156,6 +202,8 @@ static void pmu_read_sysfs(bool core_only)
> > >               if (!perf_pmu__create_placeholder_core_pmu(&core_pmus))
> > >                       pr_err("Failure to set up any core PMUs\n");
> > >       }
> > > +     list_sort(NULL, &core_pmus, pmus_cmp);
> > > +     list_sort(NULL, &other_pmus, pmus_cmp);
> > >       if (!list_empty(&core_pmus)) {
> > >               read_sysfs_core_pmus = true;
> > >               if (!core_only)
> > > --
> > > 2.41.0.640.ga95def55d0-goog
> > >
> >
> > --
> >
> > - Arnaldo

-- 

- Arnaldo
