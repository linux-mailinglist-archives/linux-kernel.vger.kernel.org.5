Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D317D28ED
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 05:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbjJWDNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 23:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjJWDNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 23:13:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B61AD
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 20:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698030785; x=1729566785;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=gyCg2+9VLduhMWu9FS7TlcphhtM5CN94k/MYoshLttE=;
  b=cdJOOAQsu1t96+/2KKDY0RmkU5uPo1aAgDqmO8caMRNl3gIZL1OyQMpR
   MdboaRwjYEYdnsAaZI2/FSM/EdqET4MCaz2UW5rqP7ynORawcTZRjk4g9
   fpv3+grirC917/6yVp62i6HOF/BHJSKpVZyvpMiWSungAtcAMhnJfq9oK
   OPvv/TDoHj/Q7Hq2EQYR1+2wjrY9lE2NUFGpwhpVz09u7lFkrnz66ZF3D
   c71Ly75hpbNRonpb7RNT4LAkXBUeOPG5zo/0zjkp6hpWsQSxXBf3ThSB9
   BP+1sLnGvAGhwlLRYxvVU+Jtf2UAIJ/LmtReBzln5J5Vc93xIZmTG7iDm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="390644195"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="390644195"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 20:13:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="931561560"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="931561560"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 20:13:00 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     akpm@linux-foundation.org, rppt@kernel.org, david@redhat.com,
        vbabka@suse.cz, mhocko@suse.com, willy@infradead.org,
        mgorman@techsingularity.net, mingo@kernel.org,
        aneesh.kumar@linux.ibm.com, hannes@cmpxchg.org, osalvador@suse.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 2/2] mm: memory_hotplug: drop memoryless node from
 fallback lists
In-Reply-To: <b6319738-0d71-4083-a5db-845430b8a5d8@bytedance.com> (Qi Zheng's
        message of "Mon, 23 Oct 2023 10:53:08 +0800")
References: <cover.1697711415.git.zhengqi.arch@bytedance.com>
        <9f1dbe7ee1301c7163b2770e32954ff5e3ecf2c4.1697711415.git.zhengqi.arch@bytedance.com>
        <87bkctg4f4.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <4bfa007c-a20f-9e68-4a9f-935dacf43222@bytedance.com>
        <8734y2f868.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <b6319738-0d71-4083-a5db-845430b8a5d8@bytedance.com>
Date:   Mon, 23 Oct 2023 11:10:58 +0800
Message-ID: <87pm16doe5.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qi Zheng <zhengqi.arch@bytedance.com> writes:

> Hi Ying,
>
> On 2023/10/23 09:18, Huang, Ying wrote:
>> Qi Zheng <zhengqi.arch@bytedance.com> writes:
>> 
>>> Hi Ying,
>>>
>>> On 2023/10/20 15:05, Huang, Ying wrote:
>>>> Qi Zheng <zhengqi.arch@bytedance.com> writes:
>>>>
>>>>> In offline_pages(), if a node becomes memoryless, we
>>>>> will clear its N_MEMORY state by calling node_states_clear_node().
>>>>> But we do this after rebuilding the zonelists by calling
>>>>> build_all_zonelists(), which will cause this memoryless node to
>>>>> still be in the fallback list of other nodes.
>>>> For fallback list, do you mean pgdat->node_zonelists[]?  If so, in
>>>> build_all_zonelists
>>>>     __build_all_zonelists
>>>>       build_zonelists
>>>>         build_zonelists_in_node_order
>>>>           build_zonerefs_node
>>>> populated_zone() will be checked before adding zone into zonelist.
>>>> So, IIUC, we will not try to allocate from the memory less node.
>>>
>>> Normally yes, but if it is the weird topology mentioned in [1], it's
>>> possible to allocate memory from it, it is a memoryless node, but it
>>> also has memory.
>>>
>>> In addition to the above case, I think it's reasonable to remove
>>> memory less node from node_order[] in advance. In this way it will
>>> not to be traversed in build_zonelists_in_node_order().
>>>
>>> [1]. https://lore.kernel.org/all/20230212110305.93670-1-zhengqi.arch@bytedance.com/
>> Got it!  Thank you for information.  I think that it may be good to
>> include this in the patch description to avoid potential confusing in
>> the future.
>
> OK, maybe the commit message can be changed to the following:
>
> ```
> In offline_pages(), if a node becomes memoryless, we
> will clear its N_MEMORY state by calling node_states_clear_node().
> But we do this after rebuilding the zonelists by calling
> build_all_zonelists(), which will cause this memoryless node to
> still be in the fallback nodes (node_order[]) of other nodes.
>
> To drop memoryless nodes from fallback nodes in this case, just
> call node_states_clear_node() before calling build_all_zonelists().
>
> In this way, we will not try to allocate pages from memoryless
> node0, then the panic mentioned in [1] will also be fixed. Even though
> this problem has been solved by dropping the NODE_MIN_SIZE constrain
> in x86 [2], it would be better to fix it in the core MM as well.
>
> [1]. https://lore.kernel.org/all/20230212110305.93670-1-zhengqi.arch@bytedance.com/
> [2]. https://lore.kernel.org/all/20231017062215.171670-1-rppt@kernel.org/
>
> ```

This is helpful.  Thanks!

--
Best Regards,
Huang, Ying

> Thanks,
> Qi
>
>> --
>> Best Regards,
>> Huang, Ying
>> 
>>> Thanks,
>>> Qi
>>>
>>>
>>>> --
>>>> Best Regards,
>>>> Huang, Ying
>>>>
>>>>> This will incur
>>>>> some runtime overhead.
>>>>>
>>>>> To drop memoryless node from fallback lists in this case, just
>>>>> call node_states_clear_node() before calling build_all_zonelists().
>>>>>
>>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>>> Acked-by: David Hildenbrand <david@redhat.com>
>>>> [snip]
>>>> --
>>>> Best Regards,
>>>> Huang, Ying
