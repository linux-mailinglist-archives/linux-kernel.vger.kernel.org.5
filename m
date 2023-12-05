Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F417805E0D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345349AbjLESsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:48:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345371AbjLESsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:48:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02911A1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 10:48:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16059C433C8;
        Tue,  5 Dec 2023 18:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701802121;
        bh=5KqBzScuuu0YI5DInZYG3ftxv+0rWvUyxh+PzEZeATI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QZKjDzvkJSQBXK8TntRGXYf2rczkwCY4sVeQFHovoP2DyA2ysnAM4Gy/c055Iz9I0
         FsrwMI1YY4txcLFV93Eiowat8OUq62y0GCxEQjR6EFbysWa518vbGByXwdFioCbLE5
         PpelimSqY+EyUYZkFOccUDaoWdL4IkSqH3UDdxeHoulCpUo9JrMHkejsGm2lxCkdgN
         xwVVh+Q7iZDMt+bv/dBfM0Np37JNAC/vQ2e1mYpqPCvnVzkZejyUfrXHRN1elk5ECw
         ewPxsQtXXWkyBK9dUjeBClATbpE/VLUSM5/IzywmpSrJJDbRrBP5KK/YvsYqWMIWOh
         nhDV9V8ve4/9w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3CE7F40094; Tue,  5 Dec 2023 15:48:38 -0300 (-03)
Date:   Tue, 5 Dec 2023 15:48:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf metrics: Avoid segv if default metricgroup
 isn't set
Message-ID: <ZW9whqUEILWMdcmi@kernel.org>
References: <20231204182330.654255-1-irogers@google.com>
 <bea4ad79-297e-9737-8af1-2286192d26f4@os.amperecomputing.com>
 <CAM9d7ci=Tk845H3x3KMDu-hTdP-u0O6a8D3iAa8EnFLLjOO6OQ@mail.gmail.com>
 <ZW9G8Clxwl6bd0H6@kernel.org>
 <CAM9d7ciOp_O5N1TDX0HyKavykirByAYrqzcmM-_6ZWjMv-47WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7ciOp_O5N1TDX0HyKavykirByAYrqzcmM-_6ZWjMv-47WQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 05, 2023 at 09:24:42AM -0800, Namhyung Kim escreveu:
> Hi Arnaldo,
> 
> On Tue, Dec 5, 2023 at 7:51 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > Em Mon, Dec 04, 2023 at 07:33:18PM -0800, Namhyung Kim escreveu:
> > > On Mon, Dec 4, 2023 at 2:45 PM Ilkka Koskinen <ilkka@os.amperecomputing.com> wrote:
> > > > On Mon, 4 Dec 2023, Ian Rogers wrote:
> > > > > A metric is default by having "Default" within its groups. The default
> > > > > metricgroup name needn't be set and this can result in segv in
> > > > > default_metricgroup_cmp and perf_stat__print_shadow_stats_metricgroup
> > > > > that assume it has a value when there is a Default metric group. To
> > > > > avoid the segv initialize the value to "".
> >
> > > > > Fixes: 1c0e47956a8e ("perf metrics: Sort the Default metricgroup")
> > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > > > Thanks! I was going to look for the bug but got pulled to other
> > > > tasks. The patch looks good to me and I tested it successfully on
> > > > AmpereOne.
> >
> > > >    Reviewed-and-tested-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> >
> > > Looks like it needs to go through perf-tools for v6.7.
> > > Ian, do you think this one is enough?
> >
> > So I had this on my local perf-tools-next, removed now, I also have some
> > other fixes by Ian on the tmp.perf-tools-next, please let me know what
> > you guys decide to have in perf-tools for v6.7 so that I can remove it
> > from there.
> 
> I think we need this one and the Ampere default-metric-group fix.
> 
> https://lore.kernel.org/r/20231201021550.1109196-2-ilkka@os.amperecomputing.com/
> 
> Also perf list JSON fix can go to v6.7.
> 
> https://lore.kernel.org/r/20231129213428.2227448-2-irogers@google.com/

Ok, removed both, please augment the later description to:

"perf list: Fix JSON segfault by setting the used skip_fuplicate_pmus callback"

The original description was vague, improving it a bit like that helps
when just looking at the output of "git log --oneline".

Thanks,

- Arnaldo

