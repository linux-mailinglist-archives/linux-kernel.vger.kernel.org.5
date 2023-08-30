Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAAF378DB9A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239211AbjH3SkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245651AbjH3PsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:48:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231A4122;
        Wed, 30 Aug 2023 08:48:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2AD961FB9;
        Wed, 30 Aug 2023 15:48:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8BCC433C7;
        Wed, 30 Aug 2023 15:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693410489;
        bh=wnPJiJm7rQrsAoc2rWmWxlawY0FbhE1X+OSVa1CfQkg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BSUbGCgKqPv26pt2syJYnQN5yPQVVlwVb0WAg2KDZmNu4ATFh6yjTkfSztfa9oEr8
         XM+icEUhh0cPNhJzbZswf8QrDpIo+F41XZJwSoVwD8N+VdG5F9BimXRC4ulIBmb9XF
         Ntb41DAvA/gCaZW3MgF3SjOxidFDyzizQAOYKHZE815MryZEXv9U5YGQHoLkMRkS8i
         v9arDRbeJaQySdvcHaiGbivJicgNHYIT7N8Kfq+XZ2Rm2/1lSZk7cjn1euP/yUQ8ah
         DjdFwulViZMTjbmi7YSWoUpfWEmjjPahMHu0F0OeRrvnjaJkIbHDPIhOI/NEjfVov7
         afBlwGV/yIPng==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0F6B840722; Wed, 30 Aug 2023 12:48:06 -0300 (-03)
Date:   Wed, 30 Aug 2023 12:48:06 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>
Subject: Re: [PATCH v1] perf pmu: Avoid uninitialized use of alias->str
Message-ID: <ZO9ktixQq0Mq2PHU@kernel.org>
References: <20230830000545.1638964-1-irogers@google.com>
 <CAM9d7ciUho=P8AnSq6inUudw15d8e=epke-XQFkpx5wuDgtikw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7ciUho=P8AnSq6inUudw15d8e=epke-XQFkpx5wuDgtikw@mail.gmail.com>
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

Em Tue, Aug 29, 2023 at 07:23:58PM -0700, Namhyung Kim escreveu:
> Hi Ian,
> 
> On Tue, Aug 29, 2023 at 5:05 PM Ian Rogers <irogers@google.com> wrote:
> >
> > alias is allocated with malloc allowing uninitialized memory to be
> > accessed. The initialization of str was moved late after it could have
> > been updated by a JSON event, however, this create a potential for an
> > uninitialized use. Fix this by assigning str to NULL early. Testing on
> > ARM (Raspberry Pi) showed a memory leak in the same code so add a
> > zfree.
> >
> > Fixes: f63a536f03a2 ("perf pmu: Merge JSON events with sysfs at load time")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied.

- Arnaldo
 
> Thanks,
> Namhyung
> 
> 
> > ---
> >  tools/perf/util/pmu.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > index cde33e01959a..b3f8f3f1e900 100644
> > --- a/tools/perf/util/pmu.c
> > +++ b/tools/perf/util/pmu.c
> > @@ -532,6 +532,7 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
> >         if (!alias)
> >                 return -ENOMEM;
> >
> > +       alias->str = NULL;
> >         INIT_LIST_HEAD(&alias->terms);
> >         alias->scale = 1.0;
> >         alias->unit[0] = '\0';
> > @@ -593,6 +594,7 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
> >                         ret += scnprintf(newval + ret, sizeof(newval) - ret,
> >                                          "%s=%s", term->config, term->val.str);
> >         }
> > +       zfree(&alias->str);
> >         alias->str = strdup(newval);
> >         if (!pe)
> >                 pmu->sysfs_aliases++;
> > --
> > 2.42.0.rc2.253.gd59a3bf2b4-goog
> >

-- 

- Arnaldo
