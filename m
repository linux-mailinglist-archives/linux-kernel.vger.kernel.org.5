Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312027DED01
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 07:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbjKBG7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 02:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjKBG7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 02:59:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595F812A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 23:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698908339; x=1730444339;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=MndUEcqNycjEVQtJcezPExD3T4iBwIIUXizsMPBaq/A=;
  b=d6Y6XcaYcjp00a2OECWArv89TIG9TqH3/H5rgducp1wZGJhMaU3DAmDo
   kvTbpjvmL69qxIDt8O+3h4qzEsPXbj2TswF9dsS9ipUbTXg3AazBIrKWT
   mFwWjAUOiFKAKtWpsUfFhB1EpQZf7+LjI7BjqWA5aDhyZBY/RwkivdaYV
   0pbeVbGraznuqlB1/wAuogEqyj24gHok4xHQLa8+oTEYXEp8vazo5zimE
   mZPJTZ0wM9QXTVjEMe1B3PHsXyEFrBpK5aq5HvhT7Pf9vLk/nSJejlE2X
   LxhihY9mCAvbY7C4d6W6cyaWmkiKlUBVktB4GwmD0TrB9sz/RMBreb/F5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="455130798"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; 
   d="scan'208";a="455130798"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 23:58:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="737654641"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; 
   d="scan'208";a="737654641"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 23:58:56 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 3/4] mm/vmstat: rename pgdemote_* to pgdemote_dst_*
 and add pgdemote_src_*
In-Reply-To: <fbca99e1-40c4-4ffd-a0a1-89728dd0b900@fujitsu.com> (Zhijian Li's
        message of "Thu, 2 Nov 2023 06:34:42 +0000")
References: <20231102025648.1285477-1-lizhijian@fujitsu.com>
        <20231102025648.1285477-4-lizhijian@fujitsu.com>
        <87r0l81zfd.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <fbca99e1-40c4-4ffd-a0a1-89728dd0b900@fujitsu.com>
Date:   Thu, 02 Nov 2023 14:56:54 +0800
Message-ID: <875y2k1w3t.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com> writes:

> On 02/11/2023 13:45, Huang, Ying wrote:
>> Li Zhijian <lizhijian@fujitsu.com> writes:
>> 
>>> pgdemote_src_*: pages demoted from this node.
>>> pgdemote_dst_*: pages demoted to this node.
>>>
>>> So that we are able to know their demotion per-node stats by checking this.
>>>
>>> In the environment, node0 and node1 are DRAM, node3 is PMEM.
>>>
>>> Global stats:
>>> $ grep -E 'demote' /proc/vmstat
>>> pgdemote_src_kswapd 130155
>>> pgdemote_src_direct 113497
>>> pgdemote_src_khugepaged 0
>>> pgdemote_dst_kswapd 130155
>>> pgdemote_dst_direct 113497
>>> pgdemote_dst_khugepaged 0
>>>
>>> Per-node stats:
>>> $ grep demote /sys/devices/system/node/node0/vmstat
>>> pgdemote_src_kswapd 68454
>>> pgdemote_src_direct 83431
>>> pgdemote_src_khugepaged 0
>>> pgdemote_dst_kswapd 0
>>> pgdemote_dst_direct 0
>>> pgdemote_dst_khugepaged 0
>>>
>>> $ grep demote /sys/devices/system/node/node1/vmstat
>>> pgdemote_src_kswapd 185834
>>> pgdemote_src_direct 30066
>>> pgdemote_src_khugepaged 0
>>> pgdemote_dst_kswapd 0
>>> pgdemote_dst_direct 0
>>> pgdemote_dst_khugepaged 0
>>>
>>> $ grep demote /sys/devices/system/node/node3/vmstat
>>> pgdemote_src_kswapd 0
>>> pgdemote_src_direct 0
>>> pgdemote_src_khugepaged 0
>>> pgdemote_dst_kswapd 254288
>>> pgdemote_dst_direct 113497
>>> pgdemote_dst_khugepaged 0
>>>
>>>  From above stats, we know node3 is the demotion destination which one
>>> the node0 and node1 will demote to.
>> 
>> Why do we need these information?  Do you have some use case?
>
> I recall our customers have mentioned that they want to know how much the memory is demoted
> to the CXL memory device in a specific period.

This doesn't sound like a use case.  Can you elaborate it?  What can
only be tuned with the help of the added stats?

--
Best Regards,
Huang, Ying

>
>>>>   	mod_node_page_state(NODE_DATA(target_nid),
>>>> -		    PGDEMOTE_KSWAPD + reclaimer_offset(), nr_succeeded);
>>>> +		    PGDEMOTE_DST_KSWAPD + reclaimer_offset(), nr_succeeded);
>
> But if the *target_nid* is only indicate the preferred node, this accounting maybe not accurate.
>
>
> Thanks
> Zhijian
>
>> 
>> --
>> Best Regards,
>> Huang, Ying
>> 
>>> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
>>> ---
>>> RFC: their names are open to discussion, maybe pgdemote_from/to_*
>>> Another defect of this patch is that, SUM(pgdemote_src_*) is always same
>>> as SUM(pgdemote_dst_*) in the global stats, shall we hide one of them.
>>> ---
>>>   include/linux/mmzone.h |  9 ++++++---
>>>   mm/vmscan.c            | 13 ++++++++++---
>>>   mm/vmstat.c            |  9 ++++++---
>>>   3 files changed, 22 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>>> index ad0309eea850..a6140d894bec 100644
>>> --- a/include/linux/mmzone.h
>>> +++ b/include/linux/mmzone.h
>>> @@ -207,9 +207,12 @@ enum node_stat_item {
>>>   	PGPROMOTE_SUCCESS,	/* promote successfully */
>>>   	PGPROMOTE_CANDIDATE,	/* candidate pages to promote */
>>>   	/* PGDEMOTE_*: pages demoted */
>>> -	PGDEMOTE_KSWAPD,
>>> -	PGDEMOTE_DIRECT,
>>> -	PGDEMOTE_KHUGEPAGED,
>>> +	PGDEMOTE_SRC_KSWAPD,
>>> +	PGDEMOTE_SRC_DIRECT,
>>> +	PGDEMOTE_SRC_KHUGEPAGED,
>>> +	PGDEMOTE_DST_KSWAPD,
>>> +	PGDEMOTE_DST_DIRECT,
>>> +	PGDEMOTE_DST_KHUGEPAGED,
>>>   #endif
>>>   	NR_VM_NODE_STAT_ITEMS
>>>   };
>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>> index 2f1fb4ec3235..55d2287d7150 100644
>>> --- a/mm/vmscan.c
>>> +++ b/mm/vmscan.c
>>> @@ -1111,13 +1111,18 @@ void drop_slab(void)
>>>   static int reclaimer_offset(void)
>>>   {
>>>   	BUILD_BUG_ON(PGSTEAL_DIRECT - PGSTEAL_KSWAPD !=
>>> -			PGDEMOTE_DIRECT - PGDEMOTE_KSWAPD);
>>> +			PGDEMOTE_SRC_DIRECT - PGDEMOTE_SRC_KSWAPD);
>>>   	BUILD_BUG_ON(PGSTEAL_DIRECT - PGSTEAL_KSWAPD !=
>>>   			PGSCAN_DIRECT - PGSCAN_KSWAPD);
>>>   	BUILD_BUG_ON(PGSTEAL_KHUGEPAGED - PGSTEAL_KSWAPD !=
>>> -			PGDEMOTE_KHUGEPAGED - PGDEMOTE_KSWAPD);
>>> +			PGDEMOTE_SRC_KHUGEPAGED - PGDEMOTE_SRC_KSWAPD);
>>>   	BUILD_BUG_ON(PGSTEAL_KHUGEPAGED - PGSTEAL_KSWAPD !=
>>>   			PGSCAN_KHUGEPAGED - PGSCAN_KSWAPD);
>>> +	BUILD_BUG_ON(PGDEMOTE_SRC_DIRECT - PGDEMOTE_SRC_KSWAPD !=
>>> +			PGDEMOTE_DST_DIRECT - PGDEMOTE_DST_KSWAPD);
>>> +	BUILD_BUG_ON(PGDEMOTE_SRC_KHUGEPAGED - PGDEMOTE_SRC_KSWAPD !=
>>> +			PGDEMOTE_DST_KHUGEPAGED - PGDEMOTE_DST_KSWAPD);
>>> +
>>>   
>>>   	if (current_is_kswapd())
>>>   		return 0;
>>> @@ -1678,8 +1683,10 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
>>>   		      (unsigned long)&mtc, MIGRATE_ASYNC, MR_DEMOTION,
>>>   		      &nr_succeeded);
>>>   
>>> +	mod_node_page_state(pgdat,
>>> +		    PGDEMOTE_SRC_KSWAPD + reclaimer_offset(), nr_succeeded);
>>>   	mod_node_page_state(NODE_DATA(target_nid),
>>> -		    PGDEMOTE_KSWAPD + reclaimer_offset(), nr_succeeded);
>>> +		    PGDEMOTE_DST_KSWAPD + reclaimer_offset(), nr_succeeded);
>>>   
>>>   	return nr_succeeded;
>>>   }
>>> diff --git a/mm/vmstat.c b/mm/vmstat.c
>>> index f141c48c39e4..63f106a5e008 100644
>>> --- a/mm/vmstat.c
>>> +++ b/mm/vmstat.c
>>> @@ -1244,9 +1244,12 @@ const char * const vmstat_text[] = {
>>>   #ifdef CONFIG_NUMA_BALANCING
>>>   	"pgpromote_success",
>>>   	"pgpromote_candidate",
>>> -	"pgdemote_kswapd",
>>> -	"pgdemote_direct",
>>> -	"pgdemote_khugepaged",
>>> +	"pgdemote_src_kswapd",
>>> +	"pgdemote_src_direct",
>>> +	"pgdemote_src_khugepaged",
>>> +	"pgdemote_dst_kswapd",
>>> +	"pgdemote_dst_direct",
>>> +	"pgdemote_dst_khugepaged",
>>>   #endif
>>>   
>>>   	/* enum writeback_stat_item counters */
