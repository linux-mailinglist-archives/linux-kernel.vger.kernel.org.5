Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C1A759F4E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 22:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbjGSUHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 16:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjGSUHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:07:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4771492;
        Wed, 19 Jul 2023 13:07:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D859361812;
        Wed, 19 Jul 2023 20:07:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B303C433C9;
        Wed, 19 Jul 2023 20:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689797242;
        bh=QBRlv2TQMbOLiRvL0z9P4oIMqhGPMMGSEdcz73enZaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dm23rWS9Rw6KGAXcY7fuoaDU28fLmGZtA7SLE6RiGx2FoRtRCGnsQjATCPx9dpqsq
         oUP2RkT4+v8C82HZLBdLQPBraitPW9d+bFP1lWYq7EMkaXEuBF3vCvVJYUlN8bJZ2Q
         zxD6mmXx0fGjeCV0CtEkNtElaPu5shLL2Atd3x33NdA3hp2w+niODhzYnIkAdo3K8O
         eAzhxwKZ1caG5qIL4pMEpBnX0E7/UKf1hf3LMy6PP55+6PKaAZIULaalXQs0UzPMBd
         QQUgOL5QUtkA/mJyaskDagLgav1Izt6Q1NECuWIi36In3LMKZg0qKGF2QceLcPq0MJ
         ou7lWynyzfzhA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 199B940516; Wed, 19 Jul 2023 17:07:19 -0300 (-03)
Date:   Wed, 19 Jul 2023 17:07:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     John Garry <john.g.garry@oracle.com>, namhyung@kernel.org,
        jolsa@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        renyu.zj@linux.alibaba.com, shangxiaojing@huawei.com,
        kjain@linux.ibm.com, kan.liang@linux.intel.com
Subject: Re: [PATCH RFC 4/9] perf jevents: Add sys_events_find_events_table()
Message-ID: <ZLhCd684SosTkJ8q@kernel.org>
References: <897dcf1d-6a04-33d3-9c4f-ea9d1706cdad@oracle.com>
 <CAP-5=fX+rz928LtFs2MWYUH=6Mcvz0XQcLRkO-n9BnVnX4RYWw@mail.gmail.com>
 <297ddf04-9b35-7613-8efd-2857668b6835@oracle.com>
 <CAP-5=fXSQVyqCfrBJFjHkrRdANuQC=TKR-HHi37hLaQ91rPQiA@mail.gmail.com>
 <eb011f48-b953-3647-4699-734ebdf1876a@oracle.com>
 <CAP-5=fXJxVpYQ84hXiMxy4LUi7xs1puXdDhbp6d6N2ArnqKJuQ@mail.gmail.com>
 <0d6e41d1-2f27-9a90-1516-c4e50bad1c21@oracle.com>
 <CAP-5=fXKqZM=RMB-+ooKEKfGw=KdCVU0UbVQ9+XrDOAWpoYAdw@mail.gmail.com>
 <4f0355ec-8bc6-e51a-ab5b-61d555a68b6c@oracle.com>
 <CAP-5=fVGOP6-k=BTRd_bn=N0HVy+1ShpdW5rk5ND0ZGhm_fQkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVGOP6-k=BTRd_bn=N0HVy+1ShpdW5rk5ND0ZGhm_fQkg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 19, 2023 at 08:25:31AM -0700, Ian Rogers escreveu:
> On Tue, Jul 18, 2023 at 2:32 AM John Garry <john.g.garry@oracle.com> wrote:
> >
> > On 17/07/2023 22:39, Ian Rogers wrote:
> > > On Mon, Jul 17, 2023 at 12:41 AM John Garry<john.g.garry@oracle.com>  wrote:
> > >> On 14/07/2023 16:55, Ian Rogers wrote:
> > >>> In this
> > >>> series my main concern was in the changes of the event lookup and
> > >>> having implied PMUs. You mentioned doing these changes so I was
> > >>> waiting for a v2.
> > >> OK, fine, I can look to do this now.
> >
> > I was thinking about this a little further. So you suggest that the
> > metric expression contains PMU name per term, like
> > "cpu_atom@instructions@ / cpu_atom@cycles@" - how would/could this work
> > for PMUs with more complex naming, like the form hisi_siclXXX_cpa_YYY?
> > Would we use the "Unit" expression for the metric name, like
> > "@hisi_sicl,cpa@event_foo"?
> 
> How does this work for events? The "@hisi_sicl,cpa@event_foo" looks
> strange, shouldn't it be "hisi_sicl,cpa@event_foo@" but then hisi_sicl
> looks like an event name.
> 
> >
> > >>
> > >> BTW, which git repo/branch do you guys use for dev? I thought that it
> > >> would be acme git, but Namhyung says "We moved to new repos from acme to
> > >> perf/perf-tools and perf/perf-tools-next" - where is repo "perf"?
> > > Current development is here now:
> > > https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/log/?h=perf-tools-next__;!!ACWV5N9M2RV99hQ!OQDHOClSjd6nVZhmgzrK3RwzXuQpP54QhqyIKpITa_MFD4PLdS7yPYSnvInFja9nrFx9Sd-UnlsJ6XUqAh4$
> >
> > Can that be added to the MAINTAINERS file? I suppose it is ok under
> > "PERFORMANCE EVENTS SUBSYTEM", since the two would-be git repos listed
> > under that same entry would be pretty obvious in purpose.
> 
> Arnaldo could you take a look at doing this?

Sure, just added this:

[acme@quaco perf-tools-next]$ git show
commit 0146244875046fad472a39ffd61ec4f91719b62a (HEAD -> perf-tools-next)
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Wed Jul 19 16:53:01 2023 -0300

    MAINTAINERS: Add git information for perf-tools and perf-tools-next trees/branches

    Now the perf tools development is done on these trees/branches:

      git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git perf-tools
      git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next

    For a while I'll continue mirroring what is these to the same branches
    in my git tree.

    Suggested-by: John Garry <john.g.garry@oracle.com>
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Ian Rogers <irogers@google.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Link: https://lore.kernel.org/lkml/CAP-5=fVGOP6-k=BTRd_bn=N0HVy+1ShpdW5rk5ND0ZGhm_fQkg@mail.gmail.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index aee340630ecaea38..e351cfc7cd41c570 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16629,6 +16629,8 @@ L:      linux-kernel@vger.kernel.org
 S:     Supported
 W:     https://perf.wiki.kernel.org/
 T:     git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
+T:     git git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git perf-tools
+T:     git git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
 F:     arch/*/events/*
 F:     arch/*/events/*/*
 F:     arch/*/include/asm/perf_event.h
[acme@quaco perf-tools-next]$
