Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92257542C3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 20:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236606AbjGNSoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 14:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236332AbjGNSoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 14:44:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DB22D75
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 11:44:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E60161BFD
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 18:44:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A357C433C7;
        Fri, 14 Jul 2023 18:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689360282;
        bh=YOeR8niC1eA7a6LRyFCMWhyjTowxNaY1IgNIJ5/bRCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kN+Cg6nFhuKV9oB9x+SzLrbLnVEuk2nuLHprOj9pbCOMrVYkZ+Wp6ZwLjpkhW4D/z
         VxUKScZzPamrwj5UdSRgpM/67RZDO484YVECd5FsSJlWKaDNjm/38TyHJJbp8WgNx3
         otjiXOoGnTfVJiX0T9dLJoE7EaKNBYMMrHuxvJdSJ75mtECTL2A6tBeNKFGMleMVSp
         zl5IAChCYG9ZtD2uxYSFzqStXt+zreB94gwZ9O05u9VkzRQZdvPd3wIq2W5f8rRA6R
         auvUuW/VvKyP1gsseKB/4uq4XryaAK/jJOQTSl1Y4fs8lLGbwCE5XFKgy9eGW2W1Ax
         MrMN9eMrA/1Mw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2025040516; Fri, 14 Jul 2023 15:44:40 -0300 (-03)
Date:   Fri, 14 Jul 2023 15:44:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] perf test task_exit: No need for a cycles event to
 check if we get an PERF_RECORD_EXIT
Message-ID: <ZLGXmMuNRpx1ubFm@kernel.org>
References: <ZLGWWgROetPjRn2C@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLGWWgROetPjRn2C@kernel.org>
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

Forgot to CC lkml :-\

Em Fri, Jul 14, 2023 at 03:39:22PM -0300, Arnaldo Carvalho de Melo escreveu:
> The intent of this test is to check we get a PERF_RECORD_EXIT as asked
> for by setting perf_event_attr.task=1.
> 
> When the test was written we didn't have the "dummy" event so we went
> with the default event, "cycles".
> 
> There were reports of this test failing sometimes, one of these reports
> was with a PREEMPT_RT_FULL kernel, but I noticed it failing sometimes
> on an aarch64 Firefly board.
> 
> In the kernel the call to perf_event_task_output(), that generates the
> PERF_RECORD_EXIT may fail when there is not enough memory in the ring
> buffer, if the ring buffer is paused, etc.
> 
> So switch to using the "dummy" event to use the ring buffer just for
> what the test was designed for, avoiding uneeded PERF_RECORD_SAMPLEs.
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/tests/task-exit.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
> index 25f075fa9125bd53..968dddde6ddaf0be 100644
> --- a/tools/perf/tests/task-exit.c
> +++ b/tools/perf/tests/task-exit.c
> @@ -58,9 +58,9 @@ static int test__task_exit(struct test_suite *test __maybe_unused, int subtest _
>  
>  	signal(SIGCHLD, sig_handler);
>  
> -	evlist = evlist__new_default();
> +	evlist = evlist__new_dummy();
>  	if (evlist == NULL) {
> -		pr_debug("evlist__new_default\n");
> +		pr_debug("evlist__new_dummy\n");
>  		return -1;
>  	}
>  
> -- 
> 2.37.1
> 

-- 

- Arnaldo
