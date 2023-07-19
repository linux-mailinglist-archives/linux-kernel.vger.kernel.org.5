Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B70D7598CE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 16:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjGSOuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 10:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjGSOuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 10:50:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AD8198D;
        Wed, 19 Jul 2023 07:49:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BCDD61724;
        Wed, 19 Jul 2023 14:49:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB11C433C8;
        Wed, 19 Jul 2023 14:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689778190;
        bh=A3CT326GLyuZ8uG3ETpFiXuusbMwfWFklBzbmRUIMNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ohnmzcB+bjpNkYJYehCOo+xlvbo0F8MQ8fNKAMyeIRJ4SAiNxuJ7gTBq7w417yBmp
         kxpXsSV2BgbblTd9/geUEyrtVKItQS5bWsJQJchy03NnSUAWHaGGP55S7w7riek14G
         zlXYAFXVWshM2W8qUzvievxS3Dq+6+MozfLa20WkfkKweiA84pl3vNNSSh4KEEHz55
         Ftk5F37U2hRH3z0SwNCx92i7XhM89j3s+ZTxudWM1lr8cKs9CfEAgOVfCJcus6y51Z
         WDtPGyGGa0KjpuAD98gBPhZn5azpeA8Ap95izdTEecZnC+TLWZd0lpA+gcPIcsSfR4
         KswggLK+8kpIA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 82B1E40516; Wed, 19 Jul 2023 11:49:47 -0300 (-03)
Date:   Wed, 19 Jul 2023 11:49:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] Parse event sort/regroup fixes
Message-ID: <ZLf4C/+x2ZSpb1Uz@kernel.org>
References: <20230719001836.198363-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719001836.198363-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 18, 2023 at 05:18:33PM -0700, Ian Rogers escreveu:
> Patch 1, fix:
> perf stat -e cycles,slots,topdown-fe-bound
> so that cycles isn't made a group leader (failure caused by PMUs
> matching). Previously this event list would fail so not necessarily a
> regression over previous perf release.
> 
> Patch 2, when regrouping events the leader needs to be updated due to
> sorting. This fix causes larger event groups that then regress at
> least the tigerlake metric test as the kernel PMU driver fails to
> break the weak groups. This is a fix for a bug but the consequence of
> fixing the bug is to make a passing test fail due to the kernel PMU
> driver.
> 
> Patch 3, don't alter the list position of events without a group if
> they don't need forcing into a group. Analysis showed this was the
> cause of the issue reported by Andi Kleen:
> https://lore.kernel.org/linux-perf-users/ZLBgbHkbrfGygM%2Fu@tassilo/

Andi,

	Can you please check these patches and provide a Tested-by?

Thanks,

- Arnaldo
 
> Due to the test regression in patch 2, follow up patches may be
> necessary for Icelake+ Intel vendor metrics to add METRIC_NO_GROUP to
> avoid the kernel PMU driver issue.
> 
> Ian Rogers (3):
>   perf parse-events: Extra care around force grouped events
>   perf parse-events: When fixing group leaders always set the leader
>   perf parse-events: Only move force grouped evsels when sorting
> 
>  tools/perf/util/parse-events.c | 58 +++++++++++++++++++++-------------
>  1 file changed, 36 insertions(+), 22 deletions(-)
> 
> -- 
> 2.41.0.487.g6d72f3e995-goog
