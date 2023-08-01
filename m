Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB60F76BCF9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 20:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjHASwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 14:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjHASwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 14:52:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386CE1BC5;
        Tue,  1 Aug 2023 11:52:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EE27616A5;
        Tue,  1 Aug 2023 18:52:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997E6C433C8;
        Tue,  1 Aug 2023 18:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690915921;
        bh=pkyYjocoeLmrSGQmrQ8n+dkP7AuTi0HlxfHtfRNzNl8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZmyYDvydqqlT6pfxH0MjZt+4cMcW4PcPrz0Jt7d3E57RYNE4rDNaeQL4Y62BEk8Hu
         ubm387xoMGtT+8R4IF0ZSFceBZoFZu5FlxPbumjK+VJ3yYe0uOb5T1a9nCK6yiKVrz
         np8lE9I4v+5R9HeW/Gcw7wzSuUTcSr9O5WhbflMxwsFd8rkdpXfH9UDkTZTkovHeKh
         9S4hivzFABQqi6urbM9+ulXMFI7shEEJOAEniz/ZhX2nd6+kJRiATMRPnPoJ+oN4Lh
         k9tSzwXyNk69VlyG0ReELHIUzFrjevzfkNDPNSceUJJfUSIlWhUk3qfGZt71xtAqVq
         5lQjfXUuAEKCw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 21BB1405DE; Tue,  1 Aug 2023 15:51:59 -0300 (-03)
Date:   Tue, 1 Aug 2023 15:51:59 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Weilin Wang <weilin.wang@intel.com>
Subject: Re: [PATCH v1 0/4] Intel metric fixes and event updates
Message-ID: <ZMlUT27ABCaq8JnV@kernel.org>
References: <20230801053634.1142634-1-irogers@google.com>
 <a0d5ec0a-e5d9-5938-fa6b-1d60b2aac019@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0d5ec0a-e5d9-5938-fa6b-1d60b2aac019@linux.intel.com>
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

Em Tue, Aug 01, 2023 at 01:48:45PM -0400, Liang, Kan escreveu:
> 
> 
> On 2023-08-01 1:36 a.m., Ian Rogers wrote:
> > The metric tma_info_pipeline_retire contains uops_retired.slots with
> > perf metric events. Patch 1 fixes this event sorting so that
> > uops_retired.slots isn't made a group leader as that needs to be
> > topdown.slots.
> > 
> > Patch 2 and 3 update the meteorlake and sapphirerapids events.
> > 
> > Patch 4 addresses an issue with event grouping discussed in:
> > https://lore.kernel.org/lkml/20230719001836.198363-3-irogers@google.com/
> > by adding and altering metric constraints. The constraints avoid
> > groups for metrics where the kernel PMU fails to not open the group
> > (the trigger for the weak group being removed).
> > 
> > Ian Rogers (4):
> >   perf parse-events x86: Avoid sorting uops_retired.slots
> >   perf vendor events intel: Update meteorlake to 1.04
> >   perf vendor events intel: Update sapphirerapids to 1.15
> >   perf vendor events intel: Update Icelake+ metric constraints
> >
> 
> Thanks Ian.
> 
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks, applied.

- Arnaldo

