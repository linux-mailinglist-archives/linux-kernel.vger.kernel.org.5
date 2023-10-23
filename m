Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3977D27E5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 03:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbjJWBUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 21:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbjJWBUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 21:20:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB56BF5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 18:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698024030; x=1729560030;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=8OjgUhcQCF8YY+dIqFZ8+sYmCLWEQX4HA0T+L+09Vk4=;
  b=Qgaf6BhdpEfKHTbAGFK0EtcIfOH3Aws2B9jnFxBP9hwwXWDbFqaC66c+
   9VmHQAAlrIMIx77/Wosn+5mlcEg0ZMf05UK8NbBxwMMcuy9ykOf0yZ2/A
   nC0q/2tytop8KbEH+g9ZCiG9yNQE/XbU55FB7A/aYNF3h4g00mqqetlak
   S8s13el/wKU3OS8bcBvb0kOhIcjUNJOwpZHcBUjZs/sS21hZg3fghFOlx
   GlDlcU6TfbqegtgwvOa9N8Ww+3w/+xuqcIO6ZwqGPIW6DSRX2YX4drwWy
   NfCaJjOD0855oV4xfMf6I3rG+GTZwoorYFkEj+FSU1oDORiwIMeHu1IwE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="8304727"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="8304727"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 18:20:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="792954983"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="792954983"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 18:20:25 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     akpm@linux-foundation.org, rppt@kernel.org, david@redhat.com,
        vbabka@suse.cz, mhocko@suse.com, willy@infradead.org,
        mgorman@techsingularity.net, mingo@kernel.org,
        aneesh.kumar@linux.ibm.com, hannes@cmpxchg.org, osalvador@suse.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 2/2] mm: memory_hotplug: drop memoryless node from
 fallback lists
In-Reply-To: <4bfa007c-a20f-9e68-4a9f-935dacf43222@bytedance.com> (Qi Zheng's
        message of "Fri, 20 Oct 2023 15:35:08 +0800")
References: <cover.1697711415.git.zhengqi.arch@bytedance.com>
        <9f1dbe7ee1301c7163b2770e32954ff5e3ecf2c4.1697711415.git.zhengqi.arch@bytedance.com>
        <87bkctg4f4.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <4bfa007c-a20f-9e68-4a9f-935dacf43222@bytedance.com>
Date:   Mon, 23 Oct 2023 09:18:23 +0800
Message-ID: <8734y2f868.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qi Zheng <zhengqi.arch@bytedance.com> writes:

> Hi Ying,
>
> On 2023/10/20 15:05, Huang, Ying wrote:
>> Qi Zheng <zhengqi.arch@bytedance.com> writes:
>> 
>>> In offline_pages(), if a node becomes memoryless, we
>>> will clear its N_MEMORY state by calling node_states_clear_node().
>>> But we do this after rebuilding the zonelists by calling
>>> build_all_zonelists(), which will cause this memoryless node to
>>> still be in the fallback list of other nodes.
>> For fallback list, do you mean pgdat->node_zonelists[]?  If so, in
>> build_all_zonelists
>>    __build_all_zonelists
>>      build_zonelists
>>        build_zonelists_in_node_order
>>          build_zonerefs_node
>> populated_zone() will be checked before adding zone into zonelist.
>> So, IIUC, we will not try to allocate from the memory less node.
>
> Normally yes, but if it is the weird topology mentioned in [1], it's
> possible to allocate memory from it, it is a memoryless node, but it
> also has memory.
>
> In addition to the above case, I think it's reasonable to remove
> memory less node from node_order[] in advance. In this way it will
> not to be traversed in build_zonelists_in_node_order().
>
> [1]. https://lore.kernel.org/all/20230212110305.93670-1-zhengqi.arch@bytedance.com/

Got it!  Thank you for information.  I think that it may be good to
include this in the patch description to avoid potential confusing in
the future.

--
Best Regards,
Huang, Ying

> Thanks,
> Qi
>
>
>> --
>> Best Regards,
>> Huang, Ying
>> 
>>> This will incur
>>> some runtime overhead.
>>>
>>> To drop memoryless node from fallback lists in this case, just
>>> call node_states_clear_node() before calling build_all_zonelists().
>>>
>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>> Acked-by: David Hildenbrand <david@redhat.com>
>> [snip]
>> --
>> Best Regards,
>> Huang, Ying
