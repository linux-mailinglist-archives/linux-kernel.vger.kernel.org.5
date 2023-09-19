Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747EC7A683A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 17:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbjISPii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 11:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbjISPih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 11:38:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAEC93
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 08:38:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3948DC433C8;
        Tue, 19 Sep 2023 15:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695137910;
        bh=J8+U3XCWGGk5acPLvSGMBRc9QaTjuUp2xG4OFZxegoQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LVkuPzu1JrukWDxKdgvTxhPeE9Tp9Ac2mjS+sJA/V6txBxst8hHheHxTH67txsXj5
         CmZvAtkHe3hi8lq5p4fJpTu0A66jzbDAsd7imPJE9vBzZYB0gukkCrVWOYzrPMTMho
         W73QxBpGaOwXWEtyGxvLMLC4O0moP/HXP4u8I9Tlrkx7dEBadQEhIcxAbOrjzc/v3G
         0MBQa5O7eWSjYnyeu5hwESClSD031A459oAnakbMGp5m7o81Dj5xYvtzFTKG3WYBLW
         9Xfe9vKbvdkiNWzY4CDDCqGlJWbAMa8JjhIjZSMGELdk3Shkcc6pr4gWB+H/wU5Qcf
         4qrzJc/GNzvcg==
From:   SeongJae Park <sj@kernel.org>
To:     Huan Yang <link@vivo.com>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        damon@lists.linux.dev (open list:DATA ACCESS MONITOR),
        linux-mm@kvack.org (open list:DATA ACCESS MONITOR),
        linux-kernel@vger.kernel.org (open list),
        opensource.kernel@vivo.com
Subject: Re: [PATCH v2] mm/damon/core: remove unnecessary si_meminfo invoke.
Date:   Tue, 19 Sep 2023 15:38:28 +0000
Message-Id: <20230919153828.8190-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230919020057.29388-1-link@vivo.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huan,

On Tue, 19 Sep 2023 10:00:57 +0800 Huan Yang <link@vivo.com> wrote:

> si_meminfo() will read and assign more info not just free/ram pages.
> For just DAMOS_WMARK_FREE_MEM_RATE use, only get free and ram pages
> is ok to save cpu.
> 
> Change from v1:
> v1 fold free mem rate logic into __damos_get_wmark_free_mem_rate and not
> invoke si_meminfo, just get free/ram_pages in global.
> v2 cancel this __damos_get_wmark_free_mem_rate and just calculate rate
> in damos_wmark_metric_value to keep it simple.

Thank you for accepting my suggestion and making this change.  Nevertheless, we
usually not keep patch changelogs on commit message but after the '---'
line[1].

> 
> Signed-off-by: Huan Yang <link@vivo.com>

Other than above and below trivial comments,

Reviewed-by: SeongJae Park <sj@kernel.org>

> ---

This is usual place for patch changelogs.


>  mm/damon/core.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index bcd2bd9d6c10..a3f812d78267 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1280,12 +1280,9 @@ static bool kdamond_need_stop(struct damon_ctx *ctx)
>  
>  static unsigned long damos_wmark_metric_value(enum damos_wmark_metric metric)
>  {
> -	struct sysinfo i;
> -
>  	switch (metric) {
>  	case DAMOS_WMARK_FREE_MEM_RATE:
> -		si_meminfo(&i);
> -		return i.freeram * 1000 / i.totalram;
> +		return global_zone_page_state(NR_FREE_PAGES) * 1000 / totalram_pages();

DAMON code still prefer 80 columns limit[2] (sorry for being stubborn).  Could
you please break this line for that?

>  	default:
>  		break;
>  	}
> -- 
> 2.34.1
> 

[1] https://docs.kernel.org/process/submitting-patches.html#the-canonical-patch-format
[2] https://docs.kernel.org/process/coding-style.html#indentation

Thanks,
SJ
