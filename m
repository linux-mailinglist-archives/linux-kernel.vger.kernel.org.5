Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361A47F0CE9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 08:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbjKTHhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 02:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKTHhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 02:37:13 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9C0B4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 23:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700465829; x=1732001829;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=te/kalXMqxIcUbJWXayxqFbR2ZYuIskBP8WKF0nSXPY=;
  b=FrdvlEwHxD82tTetB6SXRvC1YkacDQUKQfMiUpia15fi1mNcE3uSGuVg
   xiQu/NtoAWG1S0ng0idtU9bJ2C7ZjXGS3kgfNqmPTKwncl2AENuLvdAa9
   EDl1jx4OBgVXaKdSHS4dbnZfp/ec1cg5D/K9ZflNUKeSsRVrAeiTVbwQF
   VhoGOrFnDwaDBCRDXkLmSLZlJsl/KdNMHaiole1MJx1KNPtz5WCJzA5uf
   ik3cufA2xzRyHQ0P1G7gz03nbn0Yv0MTK6r6khCx27MRid/g2Tf7ZX7uh
   aLq9Xze+q4JGwF6tLvocplHFiQwC4OI/wGFSnPdlGTOLcppMOpdlFy9ly
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="395499560"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="395499560"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 23:37:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="742647791"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="742647791"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 23:37:06 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Kairui Song <ryncsn@gmail.com>
Cc:     linux-mm@kvack.org, Kairui Song <kasong@tencent.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 23/24] swap: fix multiple swap leak when after cgroup
 migrate
In-Reply-To: <20231119194740.94101-24-ryncsn@gmail.com> (Kairui Song's message
        of "Mon, 20 Nov 2023 03:47:39 +0800")
References: <20231119194740.94101-1-ryncsn@gmail.com>
        <20231119194740.94101-24-ryncsn@gmail.com>
Date:   Mon, 20 Nov 2023 15:35:05 +0800
Message-ID: <87msv8c1xy.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kairui Song <ryncsn@gmail.com> writes:

> From: Kairui Song <kasong@tencent.com>
>
> When a process which previously swapped some memory was moved to
> another cgroup, and the cgroup it previous in is dead, then swapped in
> pages will be leaked into rootcg. Previous commits fixed the bug for
> no readahead path, this commit fix the same issue for readahead path.
>
> This can be easily reproduced by:
> - Setup a SSD or HDD swap.
> - Create memory cgroup A, B and C.
> - Spawn process P1 in cgroup A and make it swap out some pages.
> - Move process P1 to memory cgroup B.
> - Destroy cgroup A.
> - Do a swapoff in cgroup C
> - Swapped in pages is accounted into cgroup C.
>
> This patch will fix it make the swapped in pages accounted in cgroup B.

Accroding to "Memory Ownership" section of
Documentation/admin-guide/cgroup-v2.rst,

"
A memory area is charged to the cgroup which instantiated it and stays
charged to the cgroup until the area is released.  Migrating a process
to a different cgroup doesn't move the memory usages that it
instantiated while in the previous cgroup to the new cgroup.
"

Because we don't move the charge when we move a task from one cgroup to
another.  It's controversial which cgroup should be charged to.
According to the above document, it's acceptable to charge to the cgroup
C (cgroup where swapoff happens).

--
Best Regards,
Huang, Ying
