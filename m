Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9037F61C7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345859AbjKWOmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345772AbjKWOmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:42:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A9E1A8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:42:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6870BC433C8;
        Thu, 23 Nov 2023 14:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700750541;
        bh=mfaBvRhfODG3G//JXKw40tGCkxSfBY+Q43wy4Fkk4fI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q6AkV1egQOR4iwp/oOQIOVMdXVAh6VnMf44ZFxdWRxYcQPdOSem5/kDFtj4RqqbrR
         DLGrlfnWEXE26WGZheblSS7JJKLf4n0QhwRzEDx05eY7gPTUcgfR+6Q+BfX6sC0avk
         gSKAI4hu6OxQ/vheUP97V32TMhd0fdhKR38u/S4vEUHX2XmZT37oyM1SWjNddY+BTn
         9cj7eSax0g9aTJRSYcnGHJV8PSFGcZMhmxfH/ejo7t3gB38ZWyrYg/cGJ9pymjx21p
         mq6jPFox0f17VWk1o9s8Ohx/vhJCQ/kVoKATYEw7m+zMzyYzdskPKOau1FpBlIFeUb
         1LKCcDV2IHuaw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 925D740094; Thu, 23 Nov 2023 11:42:18 -0300 (-03)
Date:   Thu, 23 Nov 2023 11:42:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf auxtrace: Add 'T' itrace option for
 timestamp trace
Message-ID: <ZV9kypSaAZNvaP1X@kernel.org>
References: <20231014074513.1668000-1-leo.yan@linaro.org>
 <20231014074513.1668000-2-leo.yan@linaro.org>
 <8a2ea58f-f835-4d1a-8bd6-3a63b3b0db94@intel.com>
 <ZUlgM8pgf19UeyM9@kernel.org>
 <2940af18-8bcd-4456-a8ed-e77cade1b160@intel.com>
 <20231107094852.GA656098@leoy-yangtze.lan>
 <6fc8bc4c-abc3-45d5-a8c8-045f91adfebf@intel.com>
 <20231107141808.GD656098@leoy-yangtze.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107141808.GD656098@leoy-yangtze.lan>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 07, 2023 at 10:18:08PM +0800, Leo Yan escreveu:
> On Tue, Nov 07, 2023 at 12:16:25PM +0200, Adrian Hunter wrote:
> 
> [...]
> 
> > >>>> "If users know" <- how would users know?  Could the kernel
> > >>>> or tools also figure it out?
> > >>>
> > >>> Adrian, I'm trying to go all the outstanding patches, do you still have
> > >>> any issues with this series?
> > >>
> > >> No, although the question wasn't actually answered.  I presume users
> > >> just have to try the 'T' option and see if it helps.
> > > 
> > > Sometimes, users are software developers in SoC companies, they can
> > > know well for the hardware design but are confused why current
> > > implementation cannot use timestamp trace.  This is the main reason
> > > I sent this patch set.
> > > 
> > > An example hardware platform is DB410c [1], we know its CoreSight can
> > > support timestamp trace, but if without this adding option 'T', we
> > > have no chance to use it due to it its CPU arch is prior to Armv8.4.
> > 
> > perf config might be better than an itrace option, but you decide.
> 
> I understand perf config is a better approach due to users don't need
> to bother inputting options after set it once.  I will look at it and
> respin new patch set.
> 
> Thanks for suggestion!

Thanks, applied.

- Arnaldo
