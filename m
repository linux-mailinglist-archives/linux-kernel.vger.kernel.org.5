Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA72788856
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 15:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245067AbjHYNVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 09:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245102AbjHYNVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 09:21:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6A2198E;
        Fri, 25 Aug 2023 06:20:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7EB964F56;
        Fri, 25 Aug 2023 13:20:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCEE1C433C8;
        Fri, 25 Aug 2023 13:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692969657;
        bh=hs2GT5+v8q271RR1T2B7yxIscf7b2px4sH5WHEoOSE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sTDUDRoz0K9zUhg45Z/ESRSfvZYmA8Mr22cQEK9WCpu0pV6p4YaVZ1QLTfeE1JFTX
         Vl9Bd6e1JKkgTg4G5HaQrN6Zqbr4CntS2XPkSO5Prk7vu5MsN3dvsWN+vs7hOPIkDv
         10XmyWiq92ZV/81Q/B1hiS3/0nSBhW21qla9UyENV1m3IWvB3VDdUcRecNvvdBSEE1
         9GgCzNwbVCPPweJvK6aMnpfaFiu+4xsIlf7WEEeu5WMu4/RQ9G3g3NNe/zMeHiUPJb
         xyBSSPPHlIjyVMekFamOQuEfYAgGyV0YuvNeK6a0cNUUv6SvnOF5OyfcX4J/ead7sQ
         xZuO9O20clUMg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2807740722; Fri, 25 Aug 2023 10:20:54 -0300 (-03)
Date:   Fri, 25 Aug 2023 10:20:54 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     "liwei (GF)" <liwei391@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf header: Fix missing PMU caps
Message-ID: <ZOiqtn0D8DuWHMKS@kernel.org>
References: <20230818171952.3719251-1-irogers@google.com>
 <b244a320-5f00-d382-a4ab-0168a80c55fe@huawei.com>
 <ZONjuqVhDNzWPIQ3@kernel.org>
 <CAP-5=fUW9VmBoxfeTHL3upqg-gZRuE6Gd3e0LhY_N5UP6Am5ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUW9VmBoxfeTHL3upqg-gZRuE6Gd3e0LhY_N5UP6Am5ew@mail.gmail.com>
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

Em Thu, Aug 24, 2023 at 03:54:00PM -0700, Ian Rogers escreveu:
> On Mon, Aug 21, 2023 at 6:16 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Sat, Aug 19, 2023 at 12:16:09PM +0800, liwei (GF) escreveu:
> > > Hi Ian:
> > >
> > > On 2023/8/19 1:19, Ian Rogers wrote:
> > > > PMU caps are written as HEADER_PMU_CAPS or for the special case of the
> > > > PMU "cpu" as HEADER_CPU_PMU_CAPS. As the PMU "cpu" is special, and not
> > > > any "core" PMU, the logic had become broken and core PMUs not called
> > > > "cpu" were not having their caps written. This affects ARM and s390
> > > > non-hybrid PMUs.
> > > >
> > > > Simplify the PMU caps writing logic to scan one fewer time and to be
> > > > more explicit in its behavior.
> > > >
> > > > Reported-by: Wei Li <liwei391@huawei.com>
> > > > Fixes: 178ddf3bad98 ("perf header: Avoid hybrid PMU list in write_pmu_caps")
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >  tools/perf/util/header.c | 31 ++++++++++++++++---------------
> > > >  1 file changed, 16 insertions(+), 15 deletions(-)
> > > >
> > > > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > > > index 52fbf526fe74..13c71d28e0eb 100644
> > > > --- a/tools/perf/util/header.c
> > > > +++ b/tools/perf/util/header.c
> > > > @@ -1605,8 +1605,15 @@ static int write_pmu_caps(struct feat_fd *ff,
> > > >     int ret;
> > > >
> > > >     while ((pmu = perf_pmus__scan(pmu))) {
> > > > -           if (!pmu->name || !strcmp(pmu->name, "cpu") ||
> > > > -               perf_pmu__caps_parse(pmu) <= 0)
> > > > +           if (!strcmp(pmu->name, "cpu")) {
> > >
> > > So you removed the check of 'pmu->name', does this check really redundant? since
> > > we can find such checks in many places in the perf code. If not, i think it is
> > > necessary for strcmp().
> >
> > Indeed, when sorting in tools/perf/util/pmus.c in cmp_sevent() we have:
> >
> >         /* Order by PMU name. */
> >         if (as->pmu != bs->pmu) {
> >                 a_pmu_name = a_pmu_name ?: (as->pmu->name ?: "");
> >                 b_pmu_name = b_pmu_name ?: (bs->pmu->name ?: "");
> >                 ret = strcmp(a_pmu_name, b_pmu_name);
> >                 if (ret)
> >                         return ret;
> >         }
> >
> >
> > And even if in this specific case, for some reason, we could guarantee
> > that pmu->name isn't NULL, then removing that check should be best left
> > for a separate patch with an explanation as to why that is safe.
> >
> > Having it as:
> >
> >         while ((pmu = perf_pmus__scan(pmu))) {
> > -               if (!pmu->name || !strcmp(pmu->name, "cpu") ||
> > -                   perf_pmu__caps_parse(pmu) <= 0)
> > +               if (!pmu->name || !strcmp(pmu->name, "cpu")) {
> >
> > even eases a bit reviewing, as we see we're just removing that
> > perf_pmu__caps_parse(pmu) line.
> >
> > Ian?
> 
> The pmu name is initialized with:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/pmu.c?h=perf-tools-next#n1001
> pmu->name = strdup(name);
> if (!pmu->name)
> goto err;
> 
> so name can't be NULL, strdup of NULL is segv, as if it were pmu would
> be NULL. I'll clean this up in an additional patch on top of this one.

Ok, perhaps at some point we can introduce a perf_pmu__name_is(pmu,
"cpu") and then have an assert for it not being NULL, as for some time
those tests were performed.

But thanks for checking, I'll apply the patches.

- Arnaldo

 
> Thanks,
> Ian
> 
> > - Arnaldo
> >
> >
> > > > +                   /*
> > > > +                    * The "cpu" PMU is special and covered by
> > > > +                    * HEADER_CPU_PMU_CAPS. Note, core PMUs are
> > > > +                    * counted/written here for ARM, s390 and Intel hybrid.
> > > > +                    */
> > > > +                   continue;
> > > > +           }
> > > > +           if (perf_pmu__caps_parse(pmu) <= 0)
> > > >                     continue;
> > > >             nr_pmu++;
> > > >     }
> > > > @@ -1619,23 +1626,17 @@ static int write_pmu_caps(struct feat_fd *ff,
> > > >             return 0;
> > > >
> > > >     /*
> > > > -    * Write hybrid pmu caps first to maintain compatibility with
> > > > -    * older perf tool.
> > > > +    * Note older perf tools assume core PMUs come first, this is a property
> > > > +    * of perf_pmus__scan.
> > > >      */
> > > > -   if (perf_pmus__num_core_pmus() > 1) {
> > > > -           pmu = NULL;
> > > > -           while ((pmu = perf_pmus__scan_core(pmu))) {
> > > > -                   ret = __write_pmu_caps(ff, pmu, true);
> > > > -                   if (ret < 0)
> > > > -                           return ret;
> > > > -           }
> > > > -   }
> > > > -
> > > >     pmu = NULL;
> > > >     while ((pmu = perf_pmus__scan(pmu))) {
> > > > -           if (pmu->is_core || !pmu->nr_caps)
> > > > +           if (!strcmp(pmu->name, "cpu")) {
> > >
> > > same here
> > >
> > > Thanks,
> > > Wei
> > >
> > > > +                   /* Skip as above. */
> > > > +                   continue;
> > > > +           }
> > > > +           if (perf_pmu__caps_parse(pmu) <= 0)
> > > >                     continue;
> > > > -
> > > >             ret = __write_pmu_caps(ff, pmu, true);
> > > >             if (ret < 0)
> > > >                     return ret;
> >
> > --
> >
> > - Arnaldo

-- 

- Arnaldo
