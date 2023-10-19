Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994A67CF62B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345290AbjJSLHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344861AbjJSLHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:07:50 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA90A119
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:07:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VuTuWL4_1697713663;
Received: from 30.97.48.56(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VuTuWL4_1697713663)
          by smtp.aliyun-inc.com;
          Thu, 19 Oct 2023 19:07:44 +0800
Message-ID: <862e46d9-1f83-f45d-b743-b2d90fe98773@linux.alibaba.com>
Date:   Thu, 19 Oct 2023 19:07:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 2/2] mm/migrate: add nr_split to trace_mm_migrate_pages
 stats.
To:     Zi Yan <ziy@nvidia.com>, Huang Ying <ying.huang@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
References: <20231017163129.2025214-1-zi.yan@sent.com>
 <20231017163129.2025214-2-zi.yan@sent.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20231017163129.2025214-2-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/18/2023 12:31 AM, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> Add nr_split to trace_mm_migrate_pages for large folio (including THP)
> split events.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>

LGTM. Feel free to add:
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   include/trace/events/migrate.h | 24 ++++++++++++++----------
>   mm/migrate.c                   |  3 ++-
>   2 files changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/include/trace/events/migrate.h b/include/trace/events/migrate.h
> index 061b5128f335..0190ef725b43 100644
> --- a/include/trace/events/migrate.h
> +++ b/include/trace/events/migrate.h
> @@ -49,10 +49,11 @@ TRACE_EVENT(mm_migrate_pages,
>   
>   	TP_PROTO(unsigned long succeeded, unsigned long failed,
>   		 unsigned long thp_succeeded, unsigned long thp_failed,
> -		 unsigned long thp_split, enum migrate_mode mode, int reason),
> +		 unsigned long thp_split, unsigned long large_folio_split,
> +		 enum migrate_mode mode, int reason),
>   
>   	TP_ARGS(succeeded, failed, thp_succeeded, thp_failed,
> -		thp_split, mode, reason),
> +		thp_split, large_folio_split, mode, reason),
>   
>   	TP_STRUCT__entry(
>   		__field(	unsigned long,		succeeded)
> @@ -60,26 +61,29 @@ TRACE_EVENT(mm_migrate_pages,
>   		__field(	unsigned long,		thp_succeeded)
>   		__field(	unsigned long,		thp_failed)
>   		__field(	unsigned long,		thp_split)
> +		__field(	unsigned long,		large_folio_split)
>   		__field(	enum migrate_mode,	mode)
>   		__field(	int,			reason)
>   	),
>   
>   	TP_fast_assign(
> -		__entry->succeeded	= succeeded;
> -		__entry->failed		= failed;
> -		__entry->thp_succeeded	= thp_succeeded;
> -		__entry->thp_failed	= thp_failed;
> -		__entry->thp_split	= thp_split;
> -		__entry->mode		= mode;
> -		__entry->reason		= reason;
> +		__entry->succeeded			= succeeded;
> +		__entry->failed				= failed;
> +		__entry->thp_succeeded		= thp_succeeded;
> +		__entry->thp_failed			= thp_failed;
> +		__entry->thp_split			= thp_split;
> +		__entry->large_folio_split	= large_folio_split;
> +		__entry->mode				= mode;
> +		__entry->reason				= reason;
>   	),
>   
> -	TP_printk("nr_succeeded=%lu nr_failed=%lu nr_thp_succeeded=%lu nr_thp_failed=%lu nr_thp_split=%lu mode=%s reason=%s",
> +	TP_printk("nr_succeeded=%lu nr_failed=%lu nr_thp_succeeded=%lu nr_thp_failed=%lu nr_thp_split=%lu nr_split=%lu mode=%s reason=%s",
>   		__entry->succeeded,
>   		__entry->failed,
>   		__entry->thp_succeeded,
>   		__entry->thp_failed,
>   		__entry->thp_split,
> +		__entry->large_folio_split,
>   		__print_symbolic(__entry->mode, MIGRATE_MODE),
>   		__print_symbolic(__entry->reason, MIGRATE_REASON))
>   );
> diff --git a/mm/migrate.c b/mm/migrate.c
> index fc2e70b17704..1fecebf4c301 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1979,7 +1979,8 @@ int migrate_pages(struct list_head *from, new_folio_t get_new_folio,
>   	count_vm_events(THP_MIGRATION_SPLIT, stats.nr_thp_split);
>   	trace_mm_migrate_pages(stats.nr_succeeded, stats.nr_failed_pages,
>   			       stats.nr_thp_succeeded, stats.nr_thp_failed,
> -			       stats.nr_thp_split, mode, reason);
> +			       stats.nr_thp_split, stats.nr_split, mode,
> +			       reason);
>   
>   	if (ret_succeeded)
>   		*ret_succeeded = stats.nr_succeeded;
