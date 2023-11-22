Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31977F3AC6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 01:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbjKVAiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 19:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjKVAix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 19:38:53 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FD8D56
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 16:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700613520; x=1732149520;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=O4nuBJ8lPxlgr4H6Unme6GXB+1ph0KAzNAaPeOJjdRo=;
  b=TvkH584s/iwJPSvsz+e2lkL+po+C6oOq1cBA91i3A6lPsh6oGd3WBmPJ
   eODDQjXeOnKaKZjh6S88ha51k1YNk3Z1GyhSQfl/moogc934AoN94UJyD
   mz4tq9hxfi3rZZ60fxihde+CbiR9jWweLJpV0HdCPCu/UHa7ScwqCARe0
   FulgRD1GExf9CTZYKnyBvk9A5B6IDynhPUXl/iSDwgHN8umgF8f4UUKbP
   DumEhumBJMbVc9zYb4a7mI++4wRJKgPjGMrZuKC81e49fgkzAU6AzNKZ0
   +C44s6luIfGObXjM1RLyOlvFjqDo+CPW+O6qnIku2/fKWUeg1bIsBhTW0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="372125901"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="372125901"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 16:38:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="8264591"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 16:38:37 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Kairui Song <ryncsn@gmail.com>
Cc:     linux-mm@kvack.org, Kairui Song <kasong@tencent.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/24] mm/swap: reduce scope of get_swap_device in
 swapin path
In-Reply-To: <20231119194740.94101-17-ryncsn@gmail.com> (Kairui Song's message
        of "Mon, 20 Nov 2023 03:47:32 +0800")
References: <20231119194740.94101-1-ryncsn@gmail.com>
        <20231119194740.94101-17-ryncsn@gmail.com>
Date:   Wed, 22 Nov 2023 08:36:36 +0800
Message-ID: <87sf4yaajv.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kairui Song <ryncsn@gmail.com> writes:

> From: Kairui Song <kasong@tencent.com>
>
> Move get_swap_device into swapin_readahead, simplify the code
> and prepare for follow up commits.

No.  Please don't do this.  Please check the get/put_swap_device() usage
rule in the comments of get_swap_device().

"
 * When we get a swap entry, if there aren't some other ways to
 * prevent swapoff, such as the folio in swap cache is locked, page
 * table lock is held, etc., the swap entry may become invalid because
 * of swapoff.  Then, we need to enclose all swap related functions
 * with get_swap_device() and put_swap_device(), unless the swap
 * functions call get/put_swap_device() by themselves.
"

This is to simplify the reasoning about swapoff and swap entry.

Why does it bother you?

> For the later part in do_swap_page, using swp_swap_info directly is fine
> since in that context, the swap device is pinned by swapcache reference.

[snip]

--
Best Regards,
Huang, Ying
