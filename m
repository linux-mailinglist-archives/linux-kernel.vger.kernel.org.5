Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51A27A4810
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 13:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241431AbjIRLL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 07:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241417AbjIRLLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:11:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE2010A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 04:11:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8813C433C7;
        Mon, 18 Sep 2023 11:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695035469;
        bh=ex+golzLi755Q7c5GOzK8ML6NZjydWxv20lWvmv3MMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gvNvbnWdRbTuraWZa+yNPIF7xHuuFPk5aPVI1hEQBDTXoB3FPJgE5jOHvHtp+b4Im
         fRwZTZittY0g8uEXwUV6SovcdsD7alarLUAgyDqGasuPBPlf8oRruwcvscwwcInDbx
         c64577bBuOABQ4A/s+2HamKLkPaMaBHn+zWWi7CTLtYDlcmefEv0lrfae/ZmdRRYV8
         k5uIB2umdbYEWdT2YNQUeJhLprEsZAKqR4CHYNDPUaNOGtXrl1OqZXdUgFyV/0lYY8
         TloiNrZAudiKwcEK5RrMfXHCIgMPur5EWHwWFkiHFyLTJ/4YOLhmIDa46PuEwIazOt
         o8U72h6ghLjqA==
From:   SeongJae Park <sj@kernel.org>
To:     Huan Yang <link@vivo.com>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        damon@lists.linux.dev (open list:DATA ACCESS MONITOR),
        linux-mm@kvack.org (open list:DATA ACCESS MONITOR),
        linux-kernel@vger.kernel.org (open list),
        opensource.kernel@vivo.com
Subject: Re: [PATCH] mm/damon/core: remove unnecessary si_meminfo invoke.
Date:   Mon, 18 Sep 2023 11:11:07 +0000
Message-Id: <20230918111107.85008-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230918094934.18123-1-link@vivo.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huan,

On Mon, 18 Sep 2023 17:49:34 +0800 Huan Yang <link@vivo.com> wrote:

> si_meminfo() will read and assign more info not just free/ram pages.

Nice catch :)

> For just DAMOS_WMARK_FREE_MEM_RATE use, only get free and ram pages
> is ok to save cpu.
> 
> Signed-off-by: Huan Yang <link@vivo.com>
> ---
>  mm/damon/core.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index bcd2bd9d6c10..1cddee9ae73b 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1278,14 +1278,16 @@ static bool kdamond_need_stop(struct damon_ctx *ctx)
>  	return true;
>  }
>  
> -static unsigned long damos_wmark_metric_value(enum damos_wmark_metric metric)
> +static unsigned long __damons_get_wmark_free_mem_rate(void)

Nit.  s/damons/damos/ would look more consistently, in my opinion?

>  {
> -	struct sysinfo i;
> +	return global_zone_page_state(NR_FREE_PAGES) * 1000 / totalram_pages();
> +}
>  
> +static unsigned long damos_wmark_metric_value(enum damos_wmark_metric metric)
> +{
>  	switch (metric) {
>  	case DAMOS_WMARK_FREE_MEM_RATE:
> -		si_meminfo(&i);
> -		return i.freeram * 1000 / i.totalram;
> +		return __damons_get_wmark_free_mem_rate();

Since __damons_get_wmark_free_mem_rate() is just one line function and
damos_wmark_metric_value() is the only user of the code, I think we could just
writ the code here?

>  	default:
>  		break;
>  	}
> -- 
> 2.34.1


Thanks,
SJ
