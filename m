Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D350076F455
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 22:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjHCUzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 16:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjHCUzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 16:55:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E0E1990;
        Thu,  3 Aug 2023 13:55:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B78A61EA9;
        Thu,  3 Aug 2023 20:55:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFEA6C433C8;
        Thu,  3 Aug 2023 20:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691096102;
        bh=J0pw286lqUZz/i8c9f1pp7D3EBEVQFjY/BPNNe+g5/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tPF1San+pjrHnaPYnj5ratiNxm/hmI1PME1zK2aRIhPZ5LubCUwj2+djZ7SjtRYkf
         GKegSKLpMerR8dAaSlWu3vvG88TwLLhjlYPsBnHybWBPmNwn/NPwCHhoV35LBvDVj1
         asUfNMVGnbxUq3rftrWpX3XP0h8tYu1yNieQQ5fFsSkn1xymk18tYAhvHvKqjt0Ziz
         gNkEYrsm9ZFAaVavmEjCXhLt6lKl6rkD4daWGB4EkKa3O4sAe97c4MjDjfPV6R+bAT
         ps3fsBYVBIcji2J9PQqADNaCNSAESE96Uvy6MCzZKGd5iLqnRDbgJifGsm7zZDaG8d
         6m95HVIYrtQPA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5A518404DF; Thu,  3 Aug 2023 17:54:59 -0300 (-03)
Date:   Thu, 3 Aug 2023 17:54:59 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>, Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Claire Jensen <cjense@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf stat: Don't display zero tool counts
Message-ID: <ZMwUI/YtEHsO3Cc8@kernel.org>
References: <20230801205452.3380578-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801205452.3380578-1-irogers@google.com>
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

Em Tue, Aug 01, 2023 at 01:54:52PM -0700, Ian Rogers escreveu:
> Skip zero counts for tool events.
> 
> Reported-by: Andi Kleen <ak@linux.intel.com>

Andi,

	Have you tested this? Can we please have your Tested-by?

- Arnaldo:1


> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/stat-display.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 7329b3340f88..d45d5dcb0e2b 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -931,6 +931,11 @@ static bool should_skip_zero_counter(struct perf_stat_config *config,
>  	 */
>  	if (config->aggr_mode == AGGR_THREAD && config->system_wide)
>  		return true;
> +
> +	/* Tool events have the software PMU but are only gathered on 1. */
> +	if (evsel__is_tool(counter))
> +		return true;
> +
>  	/*
>  	 * Skip value 0 when it's an uncore event and the given aggr id
>  	 * does not belong to the PMU cpumask.
> -- 
> 2.41.0.585.gd2178a4bd4-goog
> 

-- 

- Arnaldo
