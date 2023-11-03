Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A395B7DFF17
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 07:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjKCGQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 02:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjKCGQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 02:16:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083ADCA
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 23:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698992185; x=1730528185;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=9jHkBKj9vFoE1PXdMlM0Bvfm8ZcZurSAFkjdr/YE9pY=;
  b=K+uOzlpIU55z7DcXhQkwS4saSRrK3JxbXZJMrTkDsDq5FqTP/Vl5/2dw
   0889vpOOCF1UwsWbtqzG3X0VwSj1yaoTO6yZw7t3V6I4YyG+j8Lpd8Oyw
   sE9a+sqPfftwpAN+86pMmaSL36AMV5DC4pldBV1Tu5FjFSqAsIk8gTQh9
   vWrQfMlqprYFIzd0c86q8KZtvdRgBRsIITw0iZ/j95lUPU1EM/qJnXxof
   fdgRkf354t3WwDQUsvjN0K8IrN+qei7Pu6kjLZR2Puaep1nX0eQRjL24d
   Q4j+u0u+XTwmls7jqxIyzSN5j3DsafU/Rgfq+Cs9PjjGiNzI0eGycrUdg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="419995026"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="419995026"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 23:16:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="935012661"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="935012661"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 23:16:23 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Subject: Re: [PATCH RFC 3/4] mm/vmstat: rename pgdemote_* to pgdemote_dst_*
 and add pgdemote_src_*
In-Reply-To: <TYWPR01MB10082911F0687F0674F991F3D90A6A@TYWPR01MB10082.jpnprd01.prod.outlook.com>
        (Yasunori Gotou's message of "Thu, 2 Nov 2023 09:45:38 +0000")
References: <20231102025648.1285477-1-lizhijian@fujitsu.com>
        <20231102025648.1285477-4-lizhijian@fujitsu.com>
        <87r0l81zfd.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <fbca99e1-40c4-4ffd-a0a1-89728dd0b900@fujitsu.com>
        <TYWPR01MB1008262A8FCBBEF0331EB16FD90A6A@TYWPR01MB10082.jpnprd01.prod.outlook.com>
        <871qd81ttm.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <TYWPR01MB10082911F0687F0674F991F3D90A6A@TYWPR01MB10082.jpnprd01.prod.outlook.com>
Date:   Fri, 03 Nov 2023 14:14:21 +0800
Message-ID: <87sf5nz7lu.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com> writes:

>> > Hello,
>> >
>> >> On 02/11/2023 13:45, Huang, Ying wrote:
>> >> > Li Zhijian <lizhijian@fujitsu.com> writes:
>> >> >
>> >> >> pgdemote_src_*: pages demoted from this node.
>> >> >> pgdemote_dst_*: pages demoted to this node.
>> >> >>
>> >> >> So that we are able to know their demotion per-node stats by checking
>> this.
>> >> >>
>> >> >> In the environment, node0 and node1 are DRAM, node3 is PMEM.
>> >> >>
>> >> >> Global stats:
>> >> >> $ grep -E 'demote' /proc/vmstat
>> >> >> pgdemote_src_kswapd 130155
>> >> >> pgdemote_src_direct 113497
>> >> >> pgdemote_src_khugepaged 0
>> >> >> pgdemote_dst_kswapd 130155
>> >> >> pgdemote_dst_direct 113497
>> >> >> pgdemote_dst_khugepaged 0
>> >> >>
>> >> >> Per-node stats:
>> >> >> $ grep demote /sys/devices/system/node/node0/vmstat
>> >> >> pgdemote_src_kswapd 68454
>> >> >> pgdemote_src_direct 83431
>> >> >> pgdemote_src_khugepaged 0
>> >> >> pgdemote_dst_kswapd 0
>> >> >> pgdemote_dst_direct 0
>> >> >> pgdemote_dst_khugepaged 0
>> >> >>
>> >> >> $ grep demote /sys/devices/system/node/node1/vmstat
>> >> >> pgdemote_src_kswapd 185834
>> >> >> pgdemote_src_direct 30066
>> >> >> pgdemote_src_khugepaged 0
>> >> >> pgdemote_dst_kswapd 0
>> >> >> pgdemote_dst_direct 0
>> >> >> pgdemote_dst_khugepaged 0
>> >> >>
>> >> >> $ grep demote /sys/devices/system/node/node3/vmstat
>> >> >> pgdemote_src_kswapd 0
>> >> >> pgdemote_src_direct 0
>> >> >> pgdemote_src_khugepaged 0
>> >> >> pgdemote_dst_kswapd 254288
>> >> >> pgdemote_dst_direct 113497
>> >> >> pgdemote_dst_khugepaged 0
>> >> >>
>> >> >>  From above stats, we know node3 is the demotion destination which
>> >> >> one the node0 and node1 will demote to.
>> >> >
>> >> > Why do we need these information?  Do you have some use case?
>> >>
>> >> I recall our customers have mentioned that they want to know how much
>> >> the memory is demoted to the CXL memory device in a specific period.
>> >
>> > I'll mention about it more.
>> >
>> > I had a conversation with one of our customers. He expressed a desire
>> > for more detailed profile information to analyze the behavior of
>> > demotion (and promotion) when his workloads are executed.
>> > If the results are not satisfactory for his workloads, he wants to
>> > tune his servers for his workloads with these profiles.
>> > Additionally, depending on the results, he may want to change his server
>> configuration.
>> > For example, he may want to buy more expensive DDR memories rather than
>> cheaper CXL memory.
>> >
>> > In my impression, our customers seems to think that CXL memory is NOT as
>> reliable as DDR memory yet.
>> > Therefore, they want to prepare for the new world that CXL will bring,
>> > and want to have a method for the preparation by profiling information as
>> much as possible.
>> >
>> > it this enough for your question?
>> 
>> I want some more detailed information about how these stats are used?
>> Why isn't per-node pgdemote_xxx counter enough?
>
> I rechecked the customer's original request.
>
> - If a memory area is demoted to a CXL memory node, he wanted to analyze how it affects performance
>  of their workload, such as latency. He wanted to use CXL Node memory usage as basic
>  information for the analysis.
>
> - If he notices that demotion occurs well on a server and CXL memories are used 85% constantly, he 
>   may want to add DDR DRAM or select some other ways to avoid demotion.
>   (His image is likely Swap free/used.)
>   IIRC, demotion target is not spread to all of the CXL memory node, right? 
>   Then, he needs to know how CXL memory is occupied by demoted memory.
>
> If I misunderstand something, or you have any better idea,
> please let us know. I'll talk with him again. (It will be next week...)


To check CXL memory usage, /proc/PID/numa_maps,
/sys/fs/cgroup/CGROUP/memory.numa_stat, and
/sys/devices/system/node/nodeN/meminfo can be used for process, cgroup,
and NUMA node respectively.  Is this enough?

--
Best Regards,
Huang, Ying

>> >
>> >>
>> >>
>> >> >>>   	mod_node_page_state(NODE_DATA(target_nid),
>> >> >>> -		    PGDEMOTE_KSWAPD + reclaimer_offset(),
>> >> nr_succeeded);
>> >> >>> +		    PGDEMOTE_DST_KSWAPD + reclaimer_offset(),
>> >> nr_succeeded);
>> >>
>> >> But if the *target_nid* is only indicate the preferred node, this
>> >> accounting maybe not accurate.
>> >>

[snip]
