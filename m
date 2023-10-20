Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE7B7D092E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 09:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376363AbjJTHHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 03:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376326AbjJTHHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 03:07:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A55198
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 00:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697785631; x=1729321631;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=CCFoTDB8ylKFfO05W29LpXk6BHd4nA1Vr+D31rPLVVw=;
  b=A6KwxK000OUKTJp5NOLLFzL0ijvyvA8pMq2Ic7VidB+KHb5TcFBq6c3K
   MBSScimfyx2EJrLFd19LpPj3vHzSCcuTqztWOtSfTRnxYkyXiFo6YL6j2
   1jm0zLN4pFGRAKJ+JKiODK44hIAwIhy1JQbf2ac2b/QopxI4EI/7m9hVr
   2L3CBSABTmCqlGlfNCSq5FtX1YnUxwIjmkIzzoATdOIMwocsoYQqi0o69
   ZK/EfLJTdnS53IxOIv0ZQiY08p4j+jTbBm3JpPj/aG8F4SaZP2gVgAINg
   zPyZQlGI6IAFEzrQiTJRn5ZM90oXZnBtJ6Cp+gb72vUpabFOa/hnhQ/rF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="385320326"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="385320326"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 00:07:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="760951128"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="760951128"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 00:07:07 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     akpm@linux-foundation.org, rppt@kernel.org, david@redhat.com,
        vbabka@suse.cz, mhocko@suse.com, willy@infradead.org,
        mgorman@techsingularity.net, mingo@kernel.org,
        aneesh.kumar@linux.ibm.com, hannes@cmpxchg.org, osalvador@suse.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 2/2] mm: memory_hotplug: drop memoryless node from
 fallback lists
In-Reply-To: <9f1dbe7ee1301c7163b2770e32954ff5e3ecf2c4.1697711415.git.zhengqi.arch@bytedance.com>
        (Qi Zheng's message of "Thu, 19 Oct 2023 18:43:55 +0800")
References: <cover.1697711415.git.zhengqi.arch@bytedance.com>
        <9f1dbe7ee1301c7163b2770e32954ff5e3ecf2c4.1697711415.git.zhengqi.arch@bytedance.com>
Date:   Fri, 20 Oct 2023 15:05:03 +0800
Message-ID: <87bkctg4f4.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> In offline_pages(), if a node becomes memoryless, we
> will clear its N_MEMORY state by calling node_states_clear_node().
> But we do this after rebuilding the zonelists by calling
> build_all_zonelists(), which will cause this memoryless node to
> still be in the fallback list of other nodes.

For fallback list, do you mean pgdat->node_zonelists[]?  If so, in

build_all_zonelists
  __build_all_zonelists
    build_zonelists
      build_zonelists_in_node_order
        build_zonerefs_node

populated_zone() will be checked before adding zone into zonelist.

So, IIUC, we will not try to allocate from the memory less node.

--
Best Regards,
Huang, Ying


> This will incur
> some runtime overhead.
>
> To drop memoryless node from fallback lists in this case, just
> call node_states_clear_node() before calling build_all_zonelists().
>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Acked-by: David Hildenbrand <david@redhat.com>

[snip]

--
Best Regards,
Huang, Ying
