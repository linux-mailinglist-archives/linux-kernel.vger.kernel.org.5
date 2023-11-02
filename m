Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600B47DEC73
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 06:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjKBFrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 01:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235664AbjKBFpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 01:45:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AE7112
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 22:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698903908; x=1730439908;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=99wMrpgWTHZf83CxBo4N4kk+aclJmIhd2EI55OOETrU=;
  b=PQn+EstNG7wwz5CAUEp/oGR7WemrXUTV58kAUt4w0y1j4sjgOw4BroBt
   wPJ6M1rFEumyGtaSEyOmDdmyPYisITAr7Vu4pypFfaWoZ1tqb0PKARAyj
   vn+vEeoJtKW9d2jURgawIRb+G7sAya1KhUqWiDgfyt5XqBt7hXTicC9+h
   D1esov67TLONEZm8aWQpZJMrvlsUr8O26ohNVjiFy2zX9eVBJTcpa779D
   C3BC8H+DJxcMI70VH7WiQGMuBhjhuu2dMOGgyhWFUZXHcX6el4J5rwvNF
   lZ7a7JImnj+GhT0NecdwYZ1+E8mo43wejPuJqh5jXF/wJ/Dbov0y7a3fz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="391503972"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; 
   d="scan'208";a="391503972"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 22:45:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; 
   d="scan'208";a="2320333"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 22:45:06 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <linux-mm@kvack.org>, <y-goto@fujitsu.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 2/4] mm/vmstat: Move pgdemote_* to per-node stats
In-Reply-To: <20231102025648.1285477-3-lizhijian@fujitsu.com> (Li Zhijian's
        message of "Thu, 2 Nov 2023 10:56:46 +0800")
References: <20231102025648.1285477-1-lizhijian@fujitsu.com>
        <20231102025648.1285477-3-lizhijian@fujitsu.com>
Date:   Thu, 02 Nov 2023 13:43:04 +0800
Message-ID: <87v8ak1ziv.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Li Zhijian <lizhijian@fujitsu.com> writes:

> This is a prepare to improve the demotion profiling in the later
> patches.
>
> Per-node demotion stats help users to quickly identify which
> node is in hige stree, and take some special operations if needed.
>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  include/linux/mmzone.h        | 4 ++++
>  include/linux/vm_event_item.h | 3 ---
>  mm/vmscan.c                   | 3 ++-
>  mm/vmstat.c                   | 6 +++---
>  4 files changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 4106fbc5b4b3..ad0309eea850 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -206,6 +206,10 @@ enum node_stat_item {
>  #ifdef CONFIG_NUMA_BALANCING
>  	PGPROMOTE_SUCCESS,	/* promote successfully */
>  	PGPROMOTE_CANDIDATE,	/* candidate pages to promote */
> +	/* PGDEMOTE_*: pages demoted */
> +	PGDEMOTE_KSWAPD,
> +	PGDEMOTE_DIRECT,
> +	PGDEMOTE_KHUGEPAGED,
>  #endif
>  	NR_VM_NODE_STAT_ITEMS
>  };
> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
> index 8abfa1240040..d1b847502f09 100644
> --- a/include/linux/vm_event_item.h
> +++ b/include/linux/vm_event_item.h
> @@ -41,9 +41,6 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>  		PGSTEAL_KSWAPD,
>  		PGSTEAL_DIRECT,
>  		PGSTEAL_KHUGEPAGED,
> -		PGDEMOTE_KSWAPD,
> -		PGDEMOTE_DIRECT,
> -		PGDEMOTE_KHUGEPAGED,
>  		PGSCAN_KSWAPD,
>  		PGSCAN_DIRECT,
>  		PGSCAN_KHUGEPAGED,
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 6f13394b112e..2f1fb4ec3235 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1678,7 +1678,8 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
>  		      (unsigned long)&mtc, MIGRATE_ASYNC, MR_DEMOTION,
>  		      &nr_succeeded);
>  
> -	__count_vm_events(PGDEMOTE_KSWAPD + reclaimer_offset(), nr_succeeded);
> +	mod_node_page_state(NODE_DATA(target_nid),
> +		    PGDEMOTE_KSWAPD + reclaimer_offset(), nr_succeeded);

Think again.  It seems that it's better to count demotion event for the
source node.  Because demotion comes from the memory pressure of the
source node.  The target node isn't so important.  Do you agree?

--
Best Regards,
Huang, Ying

>  
>  	return nr_succeeded;
>  }
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 00e81e99c6ee..f141c48c39e4 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1244,6 +1244,9 @@ const char * const vmstat_text[] = {
>  #ifdef CONFIG_NUMA_BALANCING
>  	"pgpromote_success",
>  	"pgpromote_candidate",
> +	"pgdemote_kswapd",
> +	"pgdemote_direct",
> +	"pgdemote_khugepaged",
>  #endif
>  
>  	/* enum writeback_stat_item counters */
> @@ -1275,9 +1278,6 @@ const char * const vmstat_text[] = {
>  	"pgsteal_kswapd",
>  	"pgsteal_direct",
>  	"pgsteal_khugepaged",
> -	"pgdemote_kswapd",
> -	"pgdemote_direct",
> -	"pgdemote_khugepaged",
>  	"pgscan_kswapd",
>  	"pgscan_direct",
>  	"pgscan_khugepaged",
